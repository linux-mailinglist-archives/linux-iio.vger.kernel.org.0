Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7BB440ED2
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhJaOY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:57550 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=kfCSQpWys3eZqXQRjcbRyeN2ESNP4vyS3VNJPYPXss4=; b=TtvTuIWxkiJyAUGsqnRygpjjS4
        qgUXqfWNAVLWC5aYpOBJw+UCte/42y5nGO4oML7xxxuwhlGW8FlNrgqt6Wdx2RCrjW1lPnCp/bJeO
        ar36346ToAtkg4GFDiVK/eo+ZCTMRUrO8M+KdD84Q0JfdzpHC0zsjiV7Ex+HUuDiLSoPrOkPcmEYP
        snz+rPQfIdNHGdDtJ5FYwFFbxDqguSQPbsCBP/FFNn3+iTJdoTr8bD5VkEZjfz06aeRL3I5IYqpG1
        6FYc5a7q/n6jmY+iT5SmnFkv2vD6px5+wEj2dSr7xyI9pp7cFOSQaDWLv9QrYkTZ6orQF4aOudp2x
        cVvg+X8Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-00069I-Cx; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000F2T-72; Sun, 31 Oct 2021 15:21:54 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/9] iio: as3935: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:27 +0100
Message-Id: <20211031142130.20791-6-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211031142130.20791-1-lars@metafoo.de>
References: <20211031142130.20791-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26339/Sun Oct 31 09:18:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO core handles a trigger ops with all NULL callbacks the
same as if the trigger ops itself was NULL.

Remove the empty trigger ops from the interrupt trigger driver to slightly
reduce the boilerplate code. Object size of the driver module is also
slightly reduced.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/proximity/as3935.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 3797a8f54276..d62766b6b39e 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -238,9 +238,6 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
-};
-
 static void as3935_event_work(struct work_struct *work)
 {
 	struct as3935_state *st;
@@ -417,7 +414,6 @@ static int as3935_probe(struct spi_device *spi)
 	st->trig = trig;
 	st->noise_tripped = jiffies - HZ;
 	iio_trigger_set_drvdata(trig, indio_dev);
-	trig->ops = &iio_interrupt_trigger_ops;
 
 	ret = devm_iio_trigger_register(dev, trig);
 	if (ret) {
-- 
2.20.1

