Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE88440ED1
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhJaOY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:57570 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=GYlqh/QoQrgTUf+L2zuxmnGlvPGztBGICImeGA0/608=; b=eTnps61xa13rfwG5nHTxFTfEop
        KH8xt+9e+4/f0pi6EX+XAfiTbIWfNBJgkYhz8qV2yFgMtKnLVqeopE3ux6KBLMtMFAtdDVWdlnY28
        UMQwEio4Gp7bvp2Hvcpxh2bv/A+zuzob5pjO1AnhUQPZr/7NbdOJEtbkPrqem5sbhcLZnSpnPVbQL
        +aIh9DTIWffFuPFVmpW+H/QDkt9ISaSML1o7Dp4fGmRsTckSwzPxAczk831UdvaICJww/4HDwojdZ
        NbGu/MfwmIUmqlvMAmsTA2QMx9+SmyGRGeHFyNxnLgfERN1sye3IZWyA1cBuyw7Bf/ZQkjsH2Nf7d
        UwW1SyMA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-00069B-7v; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000F2T-1o; Sun, 31 Oct 2021 15:21:54 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/9] iio: afe4403: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:25 +0100
Message-Id: <20211031142130.20791-4-lars@metafoo.de>
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
 drivers/iio/health/afe4403.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 97b82f9a8e45..273f16dcaff8 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -345,9 +345,6 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const struct iio_trigger_ops afe4403_trigger_ops = {
-};
-
 #define AFE4403_TIMING_PAIRS			\
 	{ AFE440X_LED2STC,	0x000050 },	\
 	{ AFE440X_LED2ENDC,	0x0003e7 },	\
@@ -530,8 +527,6 @@ static int afe4403_probe(struct spi_device *spi)
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
-		afe->trig->ops = &afe4403_trigger_ops;
-
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to register IIO trigger\n");
-- 
2.20.1

