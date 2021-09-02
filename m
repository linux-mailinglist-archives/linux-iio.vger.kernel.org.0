Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857BC3FF682
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347841AbhIBVyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:54:11 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58387 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347746AbhIBVyB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:54:01 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 26126240007;
        Thu,  2 Sep 2021 21:53:00 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 38/46] iio: adc: ti_am335x_adc: Fix style
Date:   Thu,  2 Sep 2021 23:51:36 +0200
Message-Id: <20210902215144.507243-39-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These warnings are reported by checkpatch.pl essentially.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 104 ++++++++++++++++----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 7479b3c629e8..cb2ff4eaa35e 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -58,7 +58,7 @@ static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
 }
 
 static void tiadc_writel(struct tiadc_device *adc, unsigned int reg,
-					unsigned int val)
+			 unsigned int val)
 {
 	writel(val, adc->mfd_tscadc->tscadc_base + reg);
 }
@@ -73,7 +73,7 @@ static u32 get_adc_step_mask(struct tiadc_device *adc_dev)
 }
 
 static u32 get_adc_chan_step_mask(struct tiadc_device *adc_dev,
-		struct iio_chan_spec const *chan)
+				  struct iio_chan_spec const *chan)
 {
 	int i;
 
@@ -120,8 +120,6 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 	 * Channel would represent which analog input
 	 * needs to be given to ADC to digitalize data.
 	 */
-
-
 	for (i = 0; i < adc_dev->channels; i++) {
 		int chan;
 
@@ -134,9 +132,8 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 		}
 
 		if (adc_dev->step_avg[i])
-			stepconfig =
-			STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
-			STEPCONFIG_FIFO1;
+			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
+				     STEPCONFIG_FIFO1;
 		else
 			stepconfig = STEPCONFIG_FIFO1;
 
@@ -144,10 +141,9 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 			stepconfig |= STEPCONFIG_MODE_SWCNT;
 
 		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
-				stepconfig | STEPCONFIG_INP(chan) |
-				STEPCONFIG_INM_ADCREFM |
-				STEPCONFIG_RFP_VREFP |
-				STEPCONFIG_RFM_VREFN);
+			     stepconfig | STEPCONFIG_INP(chan) |
+			     STEPCONFIG_INM_ADCREFM | STEPCONFIG_RFP_VREFP |
+			     STEPCONFIG_RFM_VREFN);
 
 		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
 			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
@@ -162,8 +158,8 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 		}
 
 		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
-				STEPDELAY_OPEN(adc_dev->open_delay[i]) |
-				STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
+			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
+			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
 
 		adc_dev->channel_step[i] = steps;
 		steps++;
@@ -188,10 +184,12 @@ static irqreturn_t tiadc_irq_h(int irq, void *private)
 		config = tiadc_readl(adc_dev, REG_CTRL);
 		config &= ~(CNTRLREG_SSENB);
 		tiadc_writel(adc_dev, REG_CTRL, config);
-		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN
-				| IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
+		tiadc_writel(adc_dev, REG_IRQSTATUS,
+			     IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW |
+			     IRQENB_FIFO1THRES);
 
-		/* wait for idle state.
+		/*
+		 * Wait for the idle state.
 		 * ADC needs to finish the current conversion
 		 * before disabling the module
 		 */
@@ -219,11 +217,11 @@ static irqreturn_t tiadc_worker_h(int irq, void *private)
 
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (k = 0; k < fifo1count; k = k + i) {
-		for (i = 0; i < (indio_dev->scan_bytes)/2; i++) {
+		for (i = 0; i < indio_dev->scan_bytes / 2; i++) {
 			read = tiadc_readl(adc_dev, REG_FIFO1);
 			data[i] = read & FIFOREAD_DATA_MASK;
 		}
-		iio_push_to_buffers(indio_dev, (u8 *) data);
+		iio_push_to_buffers(indio_dev, (u8 *)data);
 	}
 
 	tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1THRES);
@@ -256,6 +254,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
 	struct dma_async_tx_descriptor *desc;
 
 	dma->current_period = 0; /* We start to fill period 0 */
+
 	/*
 	 * Make the fifo thresh as the multiple of total number of
 	 * channels enabled, so make sure that cyclic DMA period
@@ -265,9 +264,10 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
 	 */
 	dma->fifo_thresh = rounddown(FIFO1_THRESHOLD + 1,
 				     adc_dev->total_ch_enabled) - 1;
+
 	/* Make sure that period length is multiple of fifo thresh level */
 	dma->period_size = rounddown(DMA_BUFFER_SIZE / 2,
-				    (dma->fifo_thresh + 1) * sizeof(u16));
+				     (dma->fifo_thresh + 1) * sizeof(u16));
 
 	dma->conf.src_maxburst = dma->fifo_thresh + 1;
 	dmaengine_slave_config(dma->chan, &dma->conf);
@@ -303,9 +303,9 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
-				IRQENB_FIFO1OVRRUN |
-				IRQENB_FIFO1UNDRFLW));
+	tiadc_writel(adc_dev, REG_IRQCLR,
+		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
+		     IRQENB_FIFO1UNDRFLW);
 
 	/* Flush FIFO. Needed in corner cases in simultaneous tsc/adc use */
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
@@ -335,8 +335,9 @@ static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
 
 	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc, enb);
 
-	tiadc_writel(adc_dev,  REG_IRQSTATUS, IRQENB_FIFO1THRES
-				| IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
+	tiadc_writel(adc_dev, REG_IRQSTATUS,
+		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
+		     IRQENB_FIFO1UNDRFLW);
 
 	irq_enable = IRQENB_FIFO1OVRRUN;
 	if (!dma->chan)
@@ -352,8 +353,9 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
 	struct tiadc_dma *dma = &adc_dev->dma;
 	int fifo1count, i;
 
-	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
-				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
+	tiadc_writel(adc_dev, REG_IRQCLR,
+		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
+		     IRQENB_FIFO1UNDRFLW);
 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, adc_dev->buffer_en_ch_steps);
 	adc_dev->buffer_en_ch_steps = 0;
 	adc_dev->total_ch_enabled = 0;
@@ -385,12 +387,11 @@ static const struct iio_buffer_setup_ops tiadc_buffer_setup_ops = {
 };
 
 static int tiadc_iio_buffered_hardware_setup(struct device *dev,
-	struct iio_dev *indio_dev,
-	irqreturn_t (*pollfunc_bh)(int irq, void *p),
-	irqreturn_t (*pollfunc_th)(int irq, void *p),
-	int irq,
-	unsigned long flags,
-	const struct iio_buffer_setup_ops *setup_ops)
+					     struct iio_dev *indio_dev,
+					     irqreturn_t (*pollfunc_bh)(int irq, void *p),
+					     irqreturn_t (*pollfunc_th)(int irq, void *p),
+					     int irq, unsigned long flags,
+					     const struct iio_buffer_setup_ops *setup_ops)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -402,7 +403,7 @@ static int tiadc_iio_buffered_hardware_setup(struct device *dev,
 	iio_device_attach_buffer(indio_dev, buffer);
 
 	ret = devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
-				flags, indio_dev->name, indio_dev);
+					flags, indio_dev->name, indio_dev);
 	if (ret)
 		return ret;
 
@@ -434,12 +435,11 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
 	indio_dev->num_channels = channels;
 	chan_array = devm_kcalloc(dev, channels, sizeof(*chan_array),
 				  GFP_KERNEL);
-	if (chan_array == NULL)
+	if (!chan_array)
 		return -ENOMEM;
 
 	chan = chan_array;
 	for (i = 0; i < channels; i++, chan++) {
-
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
 		chan->channel = adc_dev->channel_line[i];
@@ -457,8 +457,8 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
 }
 
 static int tiadc_read_raw(struct iio_dev *indio_dev,
-		struct iio_chan_spec const *chan,
-		int *val, int *val2, long mask)
+			  struct iio_chan_spec const *chan, int *val, int *val2,
+			  long mask)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	int i, map_val;
@@ -487,9 +487,8 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 
 	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
 
-	timeout = jiffies + msecs_to_jiffies
-				(IDLE_TIMEOUT * adc_dev->channels);
 	/* Wait for Fifo threshold interrupt */
+	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT * adc_dev->channels);
 	while (1) {
 		fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 		if (fifo1count)
@@ -501,6 +500,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 			goto err_unlock;
 		}
 	}
+
 	map_val = adc_dev->channel_step[chan->scan_index];
 
 	/*
@@ -518,13 +518,14 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 		if (stepid == map_val) {
 			read = read & FIFOREAD_DATA_MASK;
 			found = true;
-			*val = (u16) read;
+			*val = (u16)read;
 		}
 	}
+
 	am335x_tsc_se_adc_done(adc_dev->mfd_tscadc);
 
 	if (!found)
-		ret =  -EBUSY;
+		ret = -EBUSY;
 
 err_unlock:
 	mutex_unlock(&adc_dev->fifo1_lock);
@@ -565,6 +566,7 @@ static int tiadc_request_dma(struct platform_device *pdev,
 		goto err;
 
 	return 0;
+
 err:
 	dma_release_channel(dma->chan);
 	return -ENOMEM;
@@ -614,7 +616,7 @@ static int tiadc_probe(struct platform_device *pdev)
 	}
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
-	if (indio_dev == NULL) {
+	if (!indio_dev) {
 		dev_err(&pdev->dev, "failed to allocate iio device\n");
 		return -ENOMEM;
 	}
@@ -636,12 +638,11 @@ static int tiadc_probe(struct platform_device *pdev)
 		return err;
 
 	err = tiadc_iio_buffered_hardware_setup(&pdev->dev, indio_dev,
-		&tiadc_worker_h,
-		&tiadc_irq_h,
-		adc_dev->mfd_tscadc->irq,
-		IRQF_SHARED,
-		&tiadc_buffer_setup_ops);
-
+						&tiadc_worker_h,
+						&tiadc_irq_h,
+						adc_dev->mfd_tscadc->irq,
+						IRQF_SHARED,
+						&tiadc_buffer_setup_ops);
 	if (err)
 		goto err_free_channels;
 
@@ -692,8 +693,7 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
 
 	idle = tiadc_readl(adc_dev, REG_CTRL);
 	idle &= ~(CNTRLREG_SSENB);
-	tiadc_writel(adc_dev, REG_CTRL, (idle |
-			CNTRLREG_POWERDOWN));
+	tiadc_writel(adc_dev, REG_CTRL, idle | CNTRLREG_POWERDOWN);
 
 	return 0;
 }
@@ -706,12 +706,12 @@ static int __maybe_unused tiadc_resume(struct device *dev)
 
 	/* Make sure ADC is powered up */
 	restore = tiadc_readl(adc_dev, REG_CTRL);
-	restore &= ~(CNTRLREG_POWERDOWN);
+	restore &= ~CNTRLREG_POWERDOWN;
 	tiadc_writel(adc_dev, REG_CTRL, restore);
 
 	tiadc_step_config(indio_dev);
 	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc,
-			adc_dev->buffer_en_ch_steps);
+				adc_dev->buffer_en_ch_steps);
 	return 0;
 }
 
-- 
2.27.0

