Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2678A440D74
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 08:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhJaHgP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 03:36:15 -0400
Received: from www381.your-server.de ([78.46.137.84]:57612 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhJaHgP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 03:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=M3rLFebRy7aQo5w4YFAJbZmr2mEk8VmjSxZlzDd6+Jw=; b=CmtcPBhssqzQZT1Zeg+CdFPRN/
        C8wkpu6iSKW1+dhWC0VHcmett/dcYF3b6CxG164iNWNaqH+74AbylU43RL7ylOnhv1lbDK+0cyYVJ
        GLz77AsEqX99mzvga4sNtrhSRCH/vckvsStxVkflh9K1IlW0Swq/qg2MEqmrymRwkLAbLBrH6hV2h
        jjvEnTEdodKNhhRkvPxRyFQofX7GXCse6CLrY/qRtfLkubaQk8jd303BKgZma9e5JbW1BByTyPNDy
        LGxEySUNeq76QmApO8RUzx9GjfWTOutslOALRM9Wcseo5MJZ8ud11LOIVCOsOw75WNTxrwnLmEBVz
        EojqMaUw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mh5Lb-000FTO-1d; Sun, 31 Oct 2021 08:33:43 +0100
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mh5La-00059C-Th; Sun, 31 Oct 2021 08:33:42 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: iio_alloc_device(): Free device correctly on error
Date:   Sun, 31 Oct 2021 08:32:30 +0100
Message-Id: <20211031073231.13780-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Once device_initialize() has been called on a struct device the device must
be freed by decreasing the reference count rather than directly freeing the
underlying memory.

This is so that any additional state and resources associated with the
device get properly freed.

In this particular case there are no additional resources associated with
the device and no additional reference count. So there is no resource leak
or use-after-free by freeing the struct device directly

But in order to follow best practices and avoid accidental future breakage
use put_device() instead of kfree() to free the device when an error
occurs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No fixes tag since, while the code is wrong, it works. No leaks and no
use-after-free.
 drivers/iio/industrialio-core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 463a63d5bf56..669218365277 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1615,7 +1615,8 @@ static void iio_dev_release(struct device *device)
 
 	iio_device_detach_buffers(indio_dev);
 
-	ida_simple_remove(&iio_ida, iio_dev_opaque->id);
+	if (iio_dev_opaque->id >= 0)
+		ida_simple_remove(&iio_ida, iio_dev_opaque->id);
 	kfree(iio_dev_opaque);
 }
 
@@ -1662,20 +1663,20 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	if (iio_dev_opaque->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
-		kfree(iio_dev_opaque);
-		return NULL;
+		goto err_put_device;
 	}
 
-	if (dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id)) {
-		ida_simple_remove(&iio_ida, iio_dev_opaque->id);
-		kfree(iio_dev_opaque);
-		return NULL;
-	}
+	if (dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id))
+		goto err_put_device;
 
 	INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	return indio_dev;
+
+err_put_device:
+	put_device(&indio_dev->dev);
+	return NULL;
 }
 EXPORT_SYMBOL(iio_device_alloc);
 
-- 
2.20.1

