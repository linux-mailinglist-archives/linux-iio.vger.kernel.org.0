Return-Path: <linux-iio+bounces-24047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84765B560F8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DB63B3FE1
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395F2ECD07;
	Sat, 13 Sep 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxDOg9UN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC12EBB81;
	Sat, 13 Sep 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768416; cv=none; b=C7/J46aLphOp0ZuMo0dDHeqDAm3SV0bh8+br+7Fh2xbwOdHVu1E95Kb/pkZIDltaxFJM7FxjYcrhcuPejYRGq1tASZ3juHw2y5w7dExj/xdEYcdYNAQQWJoNVg17HGjl11Sa2SoeZ3my1E3LiOmv4VlsCABdr3WChyXpT5qpjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768416; c=relaxed/simple;
	bh=X3tVUZP55kWuMIOu1Vz3p03KRrrhWN+I6yX2nUWctE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTi9A6e0ZPFK77g1O4vp/GVsU6KKrq8BDmcSB3aHqO141MvjJTWh5izP4JPdKSCqkqlkQBn1ORljQdDtVaYTovSsO780VVWA35h3HBOinoXEy1exkxoWOI9cAhFwQ7pbvFsaJSnn1w1KbnW4raw1DJ1Hk5Sc0TRyW83b7gR787w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxDOg9UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27A8C4CEEB;
	Sat, 13 Sep 2025 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757768416;
	bh=X3tVUZP55kWuMIOu1Vz3p03KRrrhWN+I6yX2nUWctE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxDOg9UNhG8D7ekDepACM+vk2ViONC49BebZ/Eq8NQKIHG7V3/VdJI2YaTCmZIBFN
	 fV2MuZ8WjEK9QxjTuN39reN6wYLifaea2yJYSXuvzqNB+vVRUL0hoQguYWcHcJ4mdp
	 irmHZMJiBDx8P7BgTMjYHbWzxGC5OLgVofuVAaLdpjfZtlSARTjeqnQ4aajKhdYsUE
	 1ymc4JI5zocMc3pOZQVlAoWk1oQEuwN4T/gjEXpissiS+yPQ8twLzl92xzPyw0SSY/
	 RGMJjp336sIjijFt7Vn1Ol9T+jjk5seSZu48Zu5uvSAKMVaitO2qvw77CCfGkQa4XJ
	 R66pb30nkDPnA==
Date: Sat, 13 Sep 2025 14:00:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 4/6] iio: adc: add ade9000 support
Message-ID: <20250913140008.512a0168@jic23-huawei>
In-Reply-To: <20250908073531.3639-5-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
	<20250908073531.3639-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 07:35:24 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

> +static int ade9000_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{

> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_ENERGY) {
> +			u16 lo_reg = chan->address;
> +
> +			ret = regmap_bulk_read(st->regmap, lo_reg,
> +					       st->bulk_read_buf, 2);
> +			if (ret)
> +				return ret;
> +
> +			*val = st->bulk_read_buf[0];  /* Lower 32 bits */
> +			*val2 = st->bulk_read_buf[1]; /* Upper 32 bits */
> +			return IIO_VAL_INT_64;
> +		}
> +
> +		ret = iio_device_claim_direct(indio_dev);

Sparse wins.  The sense of this is backwards.

One other case of that an access to the private masklength element of iio_dev.
Makes me thing you forwards ported this from an older kernel and didn't
test it.

Anyhow, I have the following diff - some long and short line tweaks in here
along with the real code changes. Please check the result which I'll push
out as testing shortly.

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 9aea09180d62..94e05e11abd9 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -790,8 +790,7 @@ static int ade9000_iio_push_streaming(struct iio_dev *indio_dev)
                        return IRQ_HANDLED;
                }
 
-               ade9000_configure_scan(indio_dev,
-                                      ADE9000_REG_WF_BUFF);
+               ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);
        }
 
        return 0;
@@ -807,7 +806,8 @@ static int ade9000_iio_push_buffer(struct iio_dev *indio_dev)
 
        ret = spi_sync(st->spi, &st->spi_msg);
        if (ret) {
-               dev_err_ratelimited(&st->spi->dev, "SPI fail in trigger handler\n");
+               dev_err_ratelimited(&st->spi->dev,
+                                   "SPI fail in trigger handler\n");
                return ret;
        }
 
@@ -862,7 +862,8 @@ static irqreturn_t ade9000_irq0_thread(int irq, void *data)
                if (iio_buffer_enabled(indio_dev)) {
                        ret = ade9000_iio_push_buffer(indio_dev);
                        if (ret) {
-                               dev_err_ratelimited(dev, "IRQ0 IIO push fail @ WFB TRIG\n");
+                               dev_err_ratelimited(dev,
+                                                   "IRQ0 IIO push fail @ WFB TRIG\n");
                                return IRQ_HANDLED;
                        }
                }
@@ -901,9 +902,11 @@ static irqreturn_t ade9000_irq1_thread(int irq, void *data)
                        /* Clear the reset done status bit */
                        ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, ADE9000_ST1_RSTDONE_BIT);
                        if (ret)
-                               dev_err_ratelimited(&st->spi->dev, "IRQ1 clear reset status fail\n");
+                               dev_err_ratelimited(&st->spi->dev,
+                                                   "IRQ1 clear reset status fail\n");
                } else {
-                       dev_err_ratelimited(&st->spi->dev, "Error testing reset done\n");
+                       dev_err_ratelimited(&st->spi->dev,
+                                           "Error testing reset done\n");
                }
 
                return IRQ_HANDLED;
@@ -1026,9 +1029,8 @@ static int ade9000_read_raw(struct iio_dev *indio_dev,
                        return IIO_VAL_INT_64;
                }
 
-               ret = iio_device_claim_direct(indio_dev);
-               if (ret)
-                       return ret;
+               if (!iio_device_claim_direct(indio_dev))
+                       return -EBUSY;
 
                ret = regmap_read(st->regmap, chan->address, &measured);
                iio_device_release_direct(indio_dev);
@@ -1040,9 +1042,8 @@ static int ade9000_read_raw(struct iio_dev *indio_dev,
                return IIO_VAL_INT;
 
        case IIO_CHAN_INFO_POWERFACTOR:
-               ret = iio_device_claim_direct(indio_dev);
-               if (ret)
-                       return ret;
+               if (!iio_device_claim_direct(indio_dev))
+                       return -EBUSY;
 
                ret = regmap_read(st->regmap, chan->address, &measured);
                iio_device_release_direct(indio_dev);
@@ -1206,7 +1207,8 @@ static int ade9000_read_event_config(struct iio_dev *indio_dev,
                        return !!(interrupts1 & ADE9000_ST1_SWELLA_BIT);
                else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
                        return !!(interrupts1 & ADE9000_ST1_DIPA_BIT);
-               dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase A\n", chan->type, dir);
+               dev_err_ratelimited(&indio_dev->dev,
+                                   "Invalid channel type %d or direction %d for phase A\n", chan->type, dir);
                return -EINVAL;
        case ADE9000_PHASE_B_NR:
                if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
@@ -1217,7 +1219,8 @@ static int ade9000_read_event_config(struct iio_dev *indio_dev,
                        return !!(interrupts1 & ADE9000_ST1_SWELLB_BIT);
                else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
                        return !!(interrupts1 & ADE9000_ST1_DIPB_BIT);
-               dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase B\n", chan->type, dir);
+               dev_err_ratelimited(&indio_dev->dev,
+                                   "Invalid channel type %d or direction %d for phase B\n", chan->type, dir);
                return -EINVAL;
        case ADE9000_PHASE_C_NR:
                if (chan->type == IIO_VOLTAGE && dir == IIO_EV_DIR_EITHER)
@@ -1228,7 +1231,8 @@ static int ade9000_read_event_config(struct iio_dev *indio_dev,
                        return !!(interrupts1 & ADE9000_ST1_SWELLC_BIT);
                else if (chan->type == IIO_ALTVOLTAGE && dir == IIO_EV_DIR_FALLING)
                        return !!(interrupts1 & ADE9000_ST1_DIPC_BIT);
-               dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase C\n", chan->type, dir);
+               dev_err_ratelimited(&indio_dev->dev,
+                                   "Invalid channel type %d or direction %d for phase C\n", chan->type, dir);
                return -EINVAL;
        default:
                return -EINVAL;
@@ -1309,7 +1313,8 @@ static int ade9000_write_event_config(struct iio_dev *indio_dev,
                        else
                                st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
                } else {
-                       dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase B\n",
+                       dev_err_ratelimited(&indio_dev->dev,
+                                           "Invalid channel type %d or direction %d for phase B\n",
                                            chan->type, dir);
                        return -EINVAL;
                }
@@ -1340,7 +1345,8 @@ static int ade9000_write_event_config(struct iio_dev *indio_dev,
                        else
                                st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
                } else {
-                       dev_err_ratelimited(&indio_dev->dev, "Invalid channel type %d or direction %d for phase C\n",
+                       dev_err_ratelimited(&indio_dev->dev,
+                                           "Invalid channel type %d or direction %d for phase C\n",
                                            chan->type, dir);
                        return -EINVAL;
                }
@@ -1418,7 +1424,7 @@ static int ade9000_waveform_buffer_config(struct iio_dev *indio_dev)
        u32 active_scans;
 
        bitmap_to_arr32(&active_scans, indio_dev->active_scan_mask,
-                       indio_dev->masklength);
+                       iio_get_masklength(indio_dev));
 
        switch (active_scans) {
        case ADE9000_SCAN_POS_IA | ADE9000_SCAN_POS_VA:
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(st->regmap, chan->address, &measured);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val = measured;
> +
> +		return IIO_VAL_INT;
> +

Jonathan



