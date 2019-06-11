Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6A3CA79
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfFKL4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 07:56:11 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:48630 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389499AbfFKL4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2019 07:56:11 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990406AbfFKL4IQ6jTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 13:56:08 +0200
Date:   Tue, 11 Jun 2019 13:56:03 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     linux-iio@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Georg Ottinger <g.ottinger@abatec.at>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [RFC] iio: adc: at91: fix acking DRDY irq (again)
Message-ID: <20190611115603.GA11086@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi there,

(and sorry for unsubscribing from this list as I'm not able to follow
all development and missed previous discussions [*] :( )

It seems that none of these fixes are dealing with problem properly,
however they certainly improve it.

SAM9G20 Datasheet DS60001516A rev Oct-17 states in chapter 39.5.4:
  "Reading one of the ADC_CDR registers clears the corresponding EOC bit.
   Reading ADC_LCDR clears the DRDY bit and the EOC bit corresponding to
   the last converted channel."
That implies reading ADC_LCDR each time irq handler is called with DRDY
bit set and patch bellow does exactly that.

However, that does not fix all issues. Commit 09c6bdee5118 ("iio: adc:
at91: disable adc channel interrupt in timeout case") states in commit log:
  "If 2 different channels are queried we can end up with a situation
   where two interrupts are enabled, but only one interrupt is
   cleared in the interrupt handler"
How this can ever happen? Querying using IIO_CHAN_INFO_RAW is serialized
with st->lock and even if that happens we have only one st->chnb field
to store channel we started conversion for. So EOC handler does know
which channel just finished conversion as we do not test for EOC bit.

Driver also contains some code for TC triggers. How is that supposed to
work? [**] The very same manual states in chapter 39.5.5:
  "If one of the TIOA outputs is selected, the corresponding Timer Counter
   channel must be programmed in Waveform Mode."
There are two drivers touching TC: drivers/clocksource/timer-atmel-tcb.c
and drivers/pwm/pwm-atmel-tcb.c, they seem to conflict each other and
none of them is anyhow related to ADC driver. Here it would seem
appropriate to have TC MFD driver and allocate timers for ADC, PWM and
clocksource from there.

I know it is a long time since ADC driver was developed, but it would
really help if any of its principal authors could answer questions above.

Eventual answer is appreciated in advance,
	ladis

[*]  starting here: https://marc.info/?l=linux-iio&m=154885673507542 and
     here: https://marc.info/?l=linux-iio&m=153777586127721
[**] libiio is obviously unable to deal with at91_adc:
iio_readdev -t trigger0 fffe0000.adc voltage0
WARNING: High-speed mode not enabled
Unable to refill buffer: Connection timed out

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index d23709ed9049..c086fa335b30 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -262,9 +262,6 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 
 	iio_trigger_notify_done(idev->trig);
 
-	/* Needed to ACK the DRDY interruption */
-	at91_adc_readl(st, AT91_ADC_LCDR);
-
 	enable_irq(st->irq);
 
 	return IRQ_HANDLED;
@@ -280,8 +277,6 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
 		iio_trigger_poll(idev->trig);
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
-		/* Needed to ACK the DRDY interruption */
-		at91_adc_readl(st, AT91_ADC_LCDR);
 		st->done = true;
 		wake_up_interruptible(&st->wq_data_avail);
 	}
@@ -357,9 +352,11 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
 	u32 status = at91_adc_readl(st, st->registers->status_register);
 	unsigned int reg;
 
-	status &= at91_adc_readl(st, AT91_ADC_IMR);
-	if (status & GENMASK(st->num_channels - 1, 0))
+	if (status & st->registers->drdy_mask) {
 		handle_adc_eoc_trigger(irq, idev);
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_ADC_LCDR);
+	}
 
 	if (status & AT91RL_ADC_IER_PEN) {
 		/* Disabling pen debounce is required to get a NOPEN irq */
@@ -425,8 +422,11 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
 		AT91_ADC_IER_YRDY |
 		AT91_ADC_IER_PRDY;
 
-	if (status & GENMASK(st->num_channels - 1, 0))
+	if (status & st->registers->drdy_mask) {
 		handle_adc_eoc_trigger(irq, idev);
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_ADC_LCDR);
+	}
 
 	if (status & AT91_ADC_IER_PEN) {
 		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
