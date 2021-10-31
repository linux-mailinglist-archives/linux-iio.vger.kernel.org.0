Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D61440ECD
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJaOY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 10:24:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:57556 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJaOY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=gKE3nw/HFC8lzeI47EHip0Hwb4LlbJ7XRw0bhspFohQ=; b=BnXTVG39UvFr3Qq//1KgEptCKa
        ePhQPgFN1hwLJuLiRvhMjNaUBytsD7gCcP2UsBajzi7DpxLqcESDaWhrsYY4uLQhb0xVch+10omGw
        F4d2hNcyRr+a6SVPTXUr1obqQNb6MRz8tRAcSPEBr0/B6eFCsCdgXJG8CaxzqguQXJuYNvK+lQTBI
        nE5Vtru0sxzD6lEDxWurC4Cwk/Umo0NzFfwJvMlypUFpTWNmAFvSxZVxTbSIs7k0lsdlWnoiKTjjF
        16ISbjw05kHm9TKO3t5IWyAI9EG17h7QuLpyBxZ073AYCYtBxpKNzMitWckrN8YeXr8euAkYxgfRd
        /9zMI+mg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhBic-000693-07; Sun, 31 Oct 2021 15:21:54 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhBib-000F2T-Po; Sun, 31 Oct 2021 15:21:53 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/9] iio: interrupt-trigger: Remove no-op trigger ops
Date:   Sun, 31 Oct 2021 15:21:22 +0100
Message-Id: <20211031142130.20791-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
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
 drivers/iio/trigger/iio-trig-interrupt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index f746c460bf2a..5f49cd105fae 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -25,9 +25,6 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
-};
-
 static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_interrupt_trigger_info *trig_info;
@@ -58,7 +55,6 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 	}
 	iio_trigger_set_drvdata(trig, trig_info);
 	trig_info->irq = irq;
-	trig->ops = &iio_interrupt_trigger_ops;
 	ret = request_irq(irq, iio_interrupt_trigger_poll,
 			  irqflags, trig->name, trig);
 	if (ret) {
-- 
2.20.1

