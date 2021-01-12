Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1D2F3424
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 16:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbhALP0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jan 2021 10:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbhALP0z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2021 10:26:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B09C061575
        for <linux-iio@vger.kernel.org>; Tue, 12 Jan 2021 07:26:15 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kzLYQ-0005FN-Rg; Tue, 12 Jan 2021 16:25:54 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kzLYM-0005St-Si; Tue, 12 Jan 2021 16:25:50 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Olivier Moysan <olivier.moysan@st.com>
Cc:     kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Holger Assmann <has@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-adc: fix erroneous handling of spurious IRQs
Date:   Tue, 12 Jan 2021 16:24:42 +0100
Message-Id: <20210112152441.20665-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

1c6c69525b40 ("genirq: Reject bogus threaded irq requests") makes sure
that threaded IRQs either
  - have IRQF_ONESHOT set
  - don't have the default just return IRQ_WAKE_THREAD primary handler

This is necessary because level-triggered interrupts need to be masked,
either at device or irqchip, to avoid an interrupt storm.

For spurious interrupts, the STM32 ADC driver still does this bogus
request though:
  - It doesn't set IRQF_ONESHOT
  - Its primary handler just returns IRQ_WAKE_THREAD if the interrupt
    is unexpected, i.e. !(status & enabled_mask)
  - stm32mp151.dtsi describes the ADC interrupt as level-triggered

Fix this by setting IRQF_ONESHOT to have the irqchip mask the IRQ
until the IRQ thread has finished.

IRQF_ONESHOT also has the effect that the primary handler is no longer
forced into a thread. This makes the issue with spurious interrupts
interrupts disappear when reading the ADC on a threadirqs=1 kernel.
This used to result in following kernel error message:

	iio iio:device1: Unexpected IRQ: IER=0x00000000, ISR=0x0000100e
or
	iio iio:device1: Unexpected IRQ: IER=0x00000004, ISR=0x0000100a

But with this patch applied (or threaded IRQs disabled), this no longer
occurs.

Cc: Lucas Stach <l.stach@pengutronix.de>
Reported-by: Holger Assmann <has@pengutronix.de>
Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/iio/adc/stm32-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c067c994dae2..7e0e21c79ac8 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1910,7 +1910,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
 					stm32_adc_threaded_isr,
-					0, pdev->name, indio_dev);
+					IRQF_ONESHOT, pdev->name, indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		return ret;
-- 
2.30.0

