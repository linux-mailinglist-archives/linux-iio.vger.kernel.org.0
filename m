Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EA477BF8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhLPSw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:26 -0500
Received: from www381.your-server.de ([78.46.137.84]:47628 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=GFyGAv7LQyFMd2HAlFFETsDhdGkHMScKSBM1Bu+lxnc=; b=K68mkzRyZyz4PTZQEmSrDwTJgN
        WCoXQjUpJGJWyziO2+DKPeddGM069FNuCpHvqm5JCR2Sh1K90aT6bI378l3s1n5fuOaj8M9O6GoeZ
        ngvugPj+0qo2jjU4T2pmd1wHIt/Kw5U3FXk5yMdZtQMksIvw3xjwLZXAmOpuM50XeDMZCpiaxyzkw
        j17gp9DVIcE9R/kfev1lR17F4ZzOB/mqd1U8ImLEm7LZUaQqBVZZyskDgmn2C3CQM0pUqFtamhDNp
        BLrTTvLtPWPHqyOIwv9ownx8fK79vUMkzXFevgslowmoCyWoFCVzMIgkqZ6zFcrf1eTJ8JBoa1VXU
        5NgZzxLg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000ARz-F1; Thu, 16 Dec 2021 19:52:22 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000HSt-3u; Thu, 16 Dec 2021 19:52:22 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/13] iio: dmaengine-buffer: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:06 +0100
Message-Id: <20211216185217.1054495-3-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216185217.1054495-1-lars@metafoo.de>
References: <20211216185217.1054495-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26389/Thu Dec 16 07:02:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
knows about the sysfs buffer specifics and has some built-in checks for
size and alignment.

Use sysfs_emit() for the `length_align_bytes` buffer attribute.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index f8ce26a24c57..f744b62a636a 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -136,7 +136,7 @@ static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(buffer);
 
-	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
+	return sysfs_emit(buf, "%zu\n", dmaengine_buffer->align);
 }
 
 static IIO_DEVICE_ATTR(length_align_bytes, 0444,
-- 
2.30.2

