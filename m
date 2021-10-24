Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECF438ADC
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJXRPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 13:15:37 -0400
Received: from www381.your-server.de ([78.46.137.84]:54152 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhJXRPg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 13:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=IaMYS+cLpglLi8ceKKvHbWr24RAnA38Ao+XpmQ0jPww=; b=LSW0B6pxjLlvE/HwoCFYp0rIw8
        DzFPduYznCYdGKOc38TNn1Ytn62r/XQamHn3hnwIBGF+aKnNLu/aHOwlOnz/HBxFcjqLOD5JAMunS
        bAkf+AVkiC1G3KYrsn0FvTvzYszrZ54VJOVw0BnXgBc1qqOLlMxyMD74s2jVzLoE32m4says034kD
        qDv5tupktOnvC50P6JXz2uYhH/eYIVCdqKyi92xq4ouEuT2p72IsqVOAVjrCYGTudHoJtBsVvb79l
        hKH6PR4oZC3GF79VXyozbX2hkt1vDT/gM0eAUH+T+HGTXpBZB4eWYUW+9JDGsxyfhpnF4efYe5GdP
        UG7fVlSQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meh3Z-000BgS-1f; Sun, 24 Oct 2021 19:13:13 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meh3Y-000VNB-Sl; Sun, 24 Oct 2021 19:13:12 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: kxsd9: Don't return error code in trigger handler
Date:   Sun, 24 Oct 2021 19:12:50 +0200
Message-Id: <20211024171251.22896-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211024171251.22896-1-lars@metafoo.de>
References: <20211024171251.22896-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO trigger handlers need to return one of the irqreturn_t values.
Returning an error code is not supported.

The kxsd9 interrupt handler returns an error code if reading the data
registers fails. In addition when exiting due to an error the trigger
handler does not call `iio_trigger_notify_done()`. Which when not done
keeps the triggered disabled forever.

Modify the code so that the function returns a valid irqreturn_t value as
well as calling `iio_trigger_notify_done()` on all exit paths.

Since we can't return the error code make sure to at least log it as part
of the error message.

Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/accel/kxsd9.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 2faf85ca996e..552eba5e8b4f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -224,14 +224,14 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 			       hw_values.chan,
 			       sizeof(hw_values.chan));
 	if (ret) {
-		dev_err(st->dev,
-			"error reading data\n");
-		return ret;
+		dev_err(st->dev, "error reading data: %d\n", ret);
+		goto out;
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev,
 					   &hw_values,
 					   iio_get_time_ns(indio_dev));
+out:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.20.1

