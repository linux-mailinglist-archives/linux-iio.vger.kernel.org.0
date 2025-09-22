Return-Path: <linux-iio+bounces-24355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C8B93491
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 22:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B462E0338
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237EB1F91E3;
	Mon, 22 Sep 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/INfNXT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619D27D780
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574473; cv=none; b=Rru9+ua09CTrqBuDZ7QC9xV5PNlICp1H4vt3yo6afLmArialVaXfrlkj9hhw9Kf9744lSogULu8m4PXUdU3nCZzPqhvUbg1jzLUGdQGNq00y0Ms7rr5h0seMbNEKMyUDwknto5Ta5DoSmXn91rv2t+vO9NlAEqGfVba2T2pn9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574473; c=relaxed/simple;
	bh=V84pXBsH0LPNovn17OXUos5G5dEi1+0wAHCAzVEiPII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buSe54rSR08e++koWawBl//Nk4dHYiQCUwsSRifcLyXGD68XlekYgxDysV3SpfUquSHDdc3MS5Pt2M8KimnddzYX/krqUe5YjATlidN/ZUWB8DeiqOcdJi8osUYp3wUorv1MyvWlXlxG+b7ds1+Y/3hwW8K0YcxflEwNNED0OPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/INfNXT; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-751415c488cso4692614a34.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758574469; x=1759179269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGBU7GHLXSL2nc83jAU14vFEU4wjaB/gQi1+scPq4HA=;
        b=r/INfNXTsz8httnF7OBTMmSn2Karx1zUjGnRT7afSh1AqGbIFFroG3p+a5jxzB5130
         PCQjep2AkKU9Knfz4AC4hnOcBKTNtERUDYnd23Rk9geMqz74nJ/bJfTIfx9yvMH1mhHQ
         tJ/PeQIonWg3bdk1Up8uQyV3hwwTbulDPXAGX19GQbMW86apU0yPLM+7zxs0lzSdx+eP
         Sf8Ju7zawItjYYxSOjmC7+lB3NLluC6yuvrcVktzt/vSI6HUCUz1woHCOJyvr6P8JmjS
         evC2/RUX9IJbyow65dMtNxbpWgrdksXDFWQOTXE4dOHQ/JI92u/42BxHUq4RUzaJJdYD
         vBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574469; x=1759179269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGBU7GHLXSL2nc83jAU14vFEU4wjaB/gQi1+scPq4HA=;
        b=nHZFc5Ah2YULttgubKMJJUN/eW234yc7+Gk/m963mSbqHTCwpezB2WtJf+kgVQOP0o
         DJTYBlR7NMiLEuq6mL68eu5D9UCnOsVDQshKhUOw5702lFAH7AbSp9JeJm9BcG3rYgEa
         8IxkEIdmEF1L+Uw97vJkBdLxuRjrKdyh5uKcdmN8W7XCrdGQEho/ur+i0U4FAVmu+J18
         suKKRVoRuBtGBSOxwGB9DJugKs9YDK26i1IwL0Ejs9gmPfbJZAU0IYZ4SwV+joR73x0X
         Ogh4k7W6CA5iMBxKXvy/beYCLl2K9A/hYrcstOd7MFrZPf3KmI+Ev1oBwiocJmY0+wI8
         Xt0w==
X-Forwarded-Encrypted: i=1; AJvYcCWrb9qC2ocH2fXh/so0qiN+/giuei4ETgTm+ZKBt+Zf4q5bNGv/uZ9hDDtxmaN10nnsLUbjk9HmVu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzceiM1k6wBLA61GnFkteaJHnu0a3AEww6SIW78rjkp3srit8Qi
	JgEZ4/1pLN0ma0/m+K9Wc/Iu2KpDePXXONY2hrtKlZTcEnqhqzZ/a0QE21xXBaxpkZOexzdvA/v
	KsN5bdKg=
X-Gm-Gg: ASbGncsazPHgJoPlMJ2Uosuk3h+74dwE73HfGHtx0FSdGQi9JGGmFMvJ9WPYIV8x0iJ
	+TPNzW/xW051y0DiqAgm94uTnu6EZrv5tIoX5wVwPtQ75kBm0g4c0/HffioyiP0Old64DiGsghN
	n8lffao27Io1bB03eAWTUrtjnf+svHRZP6+Hwi/NhTnjDBDYksrZf53foMKuvm4HDdtbW2NN3Xg
	YMGnn2sp8XCML45bW/Kd+eejkzgk4TtlGJl4o1BVbMVYpraU9d4uIu3vibZANqexHF1NZUIQ1fr
	GLOGaq7Rgf4yr2n7O0lwUeJCMtrI81s8w73ixxRx/y5CqgLlQbuFIxO/9RQO6gfx1LSmGJHO925
	MT3XKcCP4F70ZWCn4bq6qK/tbuUDSCVGajeC6Y8eqUCuTA8X40M27hHyyoNKuSpI/yEyIeKYJ
X-Google-Smtp-Source: AGHT+IFOqiCigFhxLdWtwAb/dCBPvLllb5otp/LQnzn4UWUfbiDTo2em5p1qfbBIvdmKR7RsSXaBPQ==
X-Received: by 2002:a05:6830:6b0b:b0:757:1232:764a with SMTP id 46e09a7af769-791474eaaa0mr66952a34.10.1758574468519;
        Mon, 22 Sep 2025 13:54:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1e96:839:462b:9af7? ([2600:8803:e7e4:1d00:1e96:839:462b:9af7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-77ee58e54c3sm2212982a34.2.2025.09.22.13.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 13:54:27 -0700 (PDT)
Message-ID: <30659b16-290d-4ae5-a644-214c106bbe87@baylibre.com>
Date: Mon, 22 Sep 2025 15:54:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:39 PM, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.

I tried testing this with AD4630-24 but didn't have luck in actually
capturing data. I'm 100% sure the problem is with the FPGA. And the
evaluation board doesn't have any place to attach a logic analyzer for
debugging. That means that I wasn't able to reliabably test this code
yet. But I don't expect my problems to be solved any time soon, so I
don't want to let that hold up progress. I would have really liked to
have been able to see the actual timings over the wire to make sure
we got all of that correct.

> 
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Most of the code for SPI offload support is based on work from Sergiu Cuciurean,
> Nuno Sa, Axel Haslam, and Trevor Gamblin. Thus, this patch comes with many
> co-developed-by tags. I also draw inspiration from other drivers supporting SPI
> offload, many of them written by David Lechner.
> 
> Change log v1 -> v2
> - Dropped all clock-modes and DDR related stuff for now as those will require
>   further changes to the SPI subsystem or to SPI controller drivers.
> - Update the modes register with proper output data mode bits when sample
>   averaging (oversampling_ratio) is set.
> - Lock on device state mutex before updating oversampling and sampling frequency.
> - Made sampling_frequency shared by all channels.
> - Better checking the requested sampling frequency is valid.
> - Adjusted to SPI offload data capture preparation and stop procedures.
> - Error out if try to get/set sampling frequency without offload trigger.
> - Depend on PWM so build always succeed.
> - Drop unmatched/unbalanced call to iio_device_release_direct().
> - No longer shadowing error codes.
> 
> Suggestions to v1 that I did not comply to:
> [SPI]
>> I would be tempted to put the loop check here [in drivers/spi/spi-offload-trigger-pwm.c]:
>>
>> 	offload_offset_ns = periodic->offset_ns;
>>
>> 	do {
>> 		wf.offset_ns = offload_offset_ns;
>> 		ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
>> 		if (ret)
>> 			return ret;
>> 		offload_offset_ns += 10;
>>
>> 	} while (wf.offset_ns < periodic->offset_ns);
>>
>> 	wf.duty_offset_ns = periodic->offset_ns;
>>
>> instead of in the ADC driver so that all future callers don't have to
>> repeat this.
> 
> Not sure implementing the PWM trigger phase approximation/rounding/setup within
> spi-offload-trigger-pwm is actually desirable. The PWM phase
> approximation/rounding/setup done in AD4030 iterates over the configuration of a
> second PWM (the PWM connected to the CNV pin). I haven't seen any other device
> that would use such double PWM setup schema so pushing an additional argument to
> spi_offload_trigger_pwm_validate() doesn't seem worth it.

I think you are right that spi_offload_trigger_pwm_validate() is not the
correct place for this. If we end up repeating this code a lot, we can
make a helper function for it in a place that makes sense at that time.

> 
> [IIO]
>> Why using slower speed for offload?
> Looks like it's the same max speed for both register access and data sample.
> So, just reusing the existing define for the max transfer speed.

I don't follow. The "REG" in AD4030_SPI_MAX_REG_XFER_SPEED stands for
"register". The actual max speed for reading sample data should be coming
from the devicetree since it is faster and depends on the wiring and VIO
voltage. It could be as much as 102 MHz.

Unrelated to this series, I still think 80 MHz is faster that it needs
to be for AD4030_SPI_MAX_REG_XFER_SPEED. It is fine to do them slower,
e.g. at 10 MHz to reduce the risk of errors and also makes it easier to
debug using a logic analyzer.

> 
>  drivers/iio/adc/Kconfig  |   3 +
>  drivers/iio/adc/ad4030.c | 485 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 445 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..2a44fcaccf54 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -60,8 +60,11 @@ config AD4030
>  	tristate "Analog Devices AD4030 ADC Driver"
>  	depends on SPI
>  	depends on GPIOLIB
> +	depends on PWM

PWM is currently only required when using offload, so not a strict depedency.

>  	select REGMAP
>  	select IIO_BUFFER
> +	select IIO_BUFFER_DMA
> +	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index aa0e27321869..52805c779934 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -14,15 +14,25 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/unaligned.h>
>  #include <linux/units.h>
> +#include <linux/types.h>
>  
>  #define AD4030_REG_INTERFACE_CONFIG_A			0x00
>  #define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
> @@ -111,6 +121,8 @@
>  #define AD4632_TCYC_NS			2000
>  #define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
>  #define AD4030_TRESET_COM_DELAY_MS	750
> +/* Datasheet says 9.8ns, so use the closest integer value */
> +#define AD4030_TQUIET_CNV_DELAY_NS	10
>  
>  enum ad4030_out_mode {
>  	AD4030_OUT_DATA_MD_DIFF,
> @@ -136,11 +148,13 @@ struct ad4030_chip_info {
>  	const char *name;
>  	const unsigned long *available_masks;
>  	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
> +	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
>  	u8 grade;
>  	u8 precision_bits;
>  	/* Number of hardware channels */
>  	int num_voltage_inputs;
>  	unsigned int tcyc_ns;
> +	unsigned int max_sample_rate_hz;
>  };
>  
>  struct ad4030_state {
> @@ -153,6 +167,15 @@ struct ad4030_state {
>  	int offset_avail[3];
>  	unsigned int avg_log2;
>  	enum ad4030_out_mode mode;
> +	struct mutex lock; /* Protect read-modify-write and multi write sequences */
> +	/* Offload sampling */
> +	struct spi_transfer offload_xfer;
> +	struct spi_message offload_msg;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
> +	struct spi_offload_trigger_config offload_trigger_config;
> +	struct pwm_device *cnv_trigger;
> +	struct pwm_waveform cnv_wf;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> @@ -209,8 +232,9 @@ struct ad4030_state {
>   * - voltage0-voltage1
>   * - voltage2-voltage3
>   */
> -#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
> +#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
>  	.info_mask_shared_by_all =					\
> +		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
>  	.info_mask_shared_by_all_available =				\
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> @@ -232,6 +256,12 @@ struct ad4030_state {
>  	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
>  }
>  
> +#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
> +
> +#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
> +
>  static const int ad4030_average_modes[] = {
>  	BIT(0),					/* No averaging/oversampling */
>  	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
> @@ -240,6 +270,11 @@ static const int ad4030_average_modes[] = {
>  	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
>  };
>  
> +static const struct spi_offload_config ad4030_offload_config = {
> +	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
> +			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
>  static int ad4030_enter_config_mode(struct ad4030_state *st)
>  {
>  	st->tx_data[0] = AD4030_REG_ACCESS;
> @@ -453,6 +488,106 @@ static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static void ad4030_get_sampling_freq(struct ad4030_state *st, int *freq)
> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +
> +	/*
> +	 * Conversion data is fetched from the device when the offload transfer
> +	 * is triggered. Thus, provide the SPI offload trigger frequency as the
> +	 * sampling frequency.
> +	 */
> +	*freq = config->periodic.frequency_hz;
> +}
> +
> +static int __ad4030_set_sampling_freq(struct ad4030_state *st,
> +				      unsigned int freq, unsigned int avg_log2)

This has more to do with the converstion trigger frequency (when CNV is
toggled) that it does with sample rate (when we read sample data). When
oversampling is in use, the conversion rate is higher than the sample rate.
So I would be tempted to call this function ad4030_update_conversion_rate().

> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = AD4030_TCNVH_NS;
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	/*
> +	 * When averaging/oversampling over N samples, we fire the offload
> +	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
> +	 * signal needs to be N times faster than the offload trigger. Take that
> +	 * into account to correctly re-evaluate both the PWM waveform connected
> +	 * to CNV and the SPI offload trigger.
> +	 */
> +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)

I think we could drop the condition here. If oversampling is disabled (oversampling
ratio == 1) then avg_log2 should be 0. st->mode may be left in a different state
from a single conversion, so can't be relied upon to decide if oversampling is
enabled or not.

> +		freq <<= avg_log2;
> +
> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> +	 * rounded PWM's value is less than 10, increase the target value by 10
> +	 * and attempt to round the waveform again, until the value is at least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target += AD4030_TCNVH_NS;
> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> +
> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;

I hit this error during testing with the default max_sample_rate_hz assigned
in probe. We could have a loop for this too to try to get the closest valid
period rather than erroring if the exact value isn't available.

> +
> +	offload_period_ns = cnv_wf.period_length_ns;
> +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)

Same as above about dropping this condition.

> +		offload_period_ns <<= avg_log2;
> +
> +	config->periodic.frequency_hz =  DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							  offload_period_ns);
> +
> +	/*
> +	 * The hardware does the capture on zone 2 (when SPI trigger PWM
> +	 * is used). This means that the SPI trigger signal should happen at
> +	 * tsync + tquiet_con_delay being tsync the conversion signal period
> +	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
> +	 *
> +	 * The PWM waveform API only supports nanosecond resolution right now,
> +	 * so round this setting to the closest available value.
> +	 */
> +	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
> +	do {
> +		config->periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
> +	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
> +
> +	st->cnv_wf = cnv_wf;
> +
> +	return 0;
> +}
> +
> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * We have no control over the sampling frequency without SPI offload
> +	 * triggering.
> +	 */
> +	if (!st->offload_trigger)
> +		return -ENODEV;
> +
> +	if (!in_range(freq, 1, st->chip->max_sample_rate_hz))
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);

Why not iio_device_claim_direct() instead of a new lock? We wouldn't
want to change the sampling frequency during a buffered read anyway.
This driver already uses iio_device_claim_direct() to protect other
register access.

> +	return __ad4030_set_sampling_freq(st, freq, st->avg_log2);
> +}
> +
>  static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
>  				      struct iio_chan_spec const *chan,
>  				      int gain_int,
> @@ -507,27 +642,6 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
>  				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
>  }
>  
> -static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
> -{
> -	struct ad4030_state *st = iio_priv(dev);
> -	unsigned int avg_log2 = ilog2(avg_val);
> -	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> -	int ret;
> -
> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> -		return -EINVAL;
> -
> -	ret = regmap_write(st->regmap, AD4030_REG_AVG,
> -			   AD4030_REG_AVG_MASK_AVG_SYNC |
> -			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
> -	if (ret)
> -		return ret;
> -
> -	st->avg_log2 = avg_log2;
> -
> -	return 0;
> -}
> -
>  static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
>  					unsigned int mask)
>  {
> @@ -536,11 +650,10 @@ static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
>  		AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK);
>  }
>  
> -static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
> +static int ad4030_set_mode(struct ad4030_state *st, unsigned long mask,
> +			   unsigned int avg_log2)
>  {
> -	struct ad4030_state *st = iio_priv(indio_dev);
> -
> -	if (st->avg_log2 > 0) {
> +	if (avg_log2 > 0) {
>  		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
>  	} else if (ad4030_is_common_byte_asked(st, mask)) {
>  		switch (st->chip->precision_bits) {
> @@ -564,6 +677,50 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
>  				  st->mode);
>  }
>  
> +static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned long mask, int avg_val)
> +{
> +	struct ad4030_state *st = iio_priv(dev);
> +	unsigned int avg_log2 = ilog2(avg_val);
> +	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> +	int freq;
> +	int ret;
> +
> +	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	ret = ad4030_set_mode(st, mask, avg_log2);

Not sure it makes sense to set the mode here. The mode gets set again anyway
(possibly with a different mask) just before doing a single conversion or when
starting a buffered read. So this doesn't really have any useful effect AFAICT.

> +	if (ret)
> +		return ret;
> +
> +	if (st->offload_trigger) {
> +		/*
> +		 * The sample averaging and sampling frequency configurations
> +		 * are mutually dependent one from another. That's because the
> +		 * effective data sample rate is fCNV / 2^N, where N is the
> +		 * number of samples being averaged.
> +		 *
> +		 * When SPI offload is supported and we have control over the
> +		 * sample rate, the conversion start signal (CNV) and the SPI
> +		 * offload trigger frequencies must be re-evaluated so data is
> +		 * fetched only after 'avg_val' conversions.
> +		 */
> +		ad4030_get_sampling_freq(st, &freq);
> +		ret = __ad4030_set_sampling_freq(st, freq, avg_log2);

This looks a bit strange to "get" the sample rate and then "set" it to the
same value we just got. This is what inspired the suggestion to reanme
 __ad4030_set_sampling_freq().

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_AVG,
> +			   AD4030_REG_AVG_MASK_AVG_SYNC |
> +			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
> +	if (ret)
> +		return ret;
> +
> +	st->avg_log2 = avg_log2;
> +	return 0;
> +}
> +
>  /*
>   * Descramble 2 32bits numbers out of a 64bits. The bits are interleaved:
>   * 1 bit for first number, 1 bit for the second, and so on...
> @@ -672,7 +829,7 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
>  	struct ad4030_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = ad4030_set_mode(indio_dev, BIT(chan->scan_index));
> +	ret = ad4030_set_mode(st, BIT(chan->scan_index), st->avg_log2);
>  	if (ret)
>  		return ret;
>  
> @@ -769,6 +926,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
>  		*val = BIT(st->avg_log2);
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!st->offload_trigger)
> +			return -ENODEV;
> +
> +		ad4030_get_sampling_freq(st, val);
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -807,7 +971,10 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
>  		return ad4030_set_chan_calibbias(indio_dev, chan, val);
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		return ad4030_set_avg_frame_len(indio_dev, val);
> +		return ad4030_set_avg_frame_len(indio_dev, BIT(chan->scan_index), val);
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4030_set_sampling_freq(indio_dev, val);
>  
>  	default:
>  		return -EINVAL;
> @@ -869,7 +1036,9 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
>  static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask)
>  {
> -	return ad4030_set_mode(indio_dev, *scan_mask);
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	return ad4030_set_mode(st, *scan_mask, st->avg_log2);
>  }
>  
>  static const struct iio_info ad4030_iio_info = {
> @@ -898,6 +1067,88 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
>  	.validate_scan_mask = ad4030_validate_scan_mask,
>  };
>  
> +static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	u8 offload_bpw;
> +
> +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
> +		offload_bpw = 32;
> +	else
> +		offload_bpw = st->chip->precision_bits;
> +

> +	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;

As mentioned at the beginning, drop this line and let it use the max
speed from the devicetree.

> +	st->offload_xfer.bits_per_word = roundup_pow_of_two(offload_bpw);

Why roundup_pow_of_two()? The SPI controller can do 24 bits per word.
And if we are reading both a 24-bit value and the common mode voltage,
this would cause both to be read in 1 word.

Speaking of which, I think this will need a possible second xfer with
bpw=8 if we want to read the common mode voltage.

Or, if the intention was to not allow it, we need different scan masks.
But I don't see a reason why we could not allow it.

Or, if this is making a assumptions about extra hardware being present
to move bits around between reading them over the SPI bus and pushing the
values to DMA, then there should be some comments about that. More on that
below.

> +	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +}
> +
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
> +	if (ret)
> +		return ret;
> +
> +	ad4030_prepare_offload_msg(indio_dev);
> +	st->offload_msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		goto out_reset_mode;
> +
> +	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
> +
> +	return 0;
> +
> +out_pwm_disable:
> +	pwm_disable(st->cnv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret = ad4030_enter_config_mode(st);

This overwrites the original error in `ret` and could result in the function
returning sucessfully when it should have returned an error. To fix, we can
introduce a ret2 variable for checking the return value while unwinding after
an error (and should print ret2 in the dev_err(), otherwise that info gets
lost).

> +	if (ret)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode\n");
> +	return ret;
> +}
> +
> +static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +	pwm_disable(st->cnv_trigger);
> +
> +	spi_unoptimize_message(&st->offload_msg);
> +
> +	/* reenter register configuration mode */
> +	ret = ad4030_enter_config_mode(st);
> +	if (ret)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode\n");
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
> +	.postenable = &ad4030_offload_buffer_postenable,
> +	.predisable = &ad4030_offload_buffer_predisable,
> +	.validate_scan_mask = ad4030_validate_scan_mask,
> +};
> +
>  static int ad4030_regulators_get(struct ad4030_state *st)
>  {
>  	struct device *dev = &st->spi->dev;
> @@ -967,6 +1218,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
>  	return 0;
>  }
>  
> +static int ad4030_pwm_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +
> +	st->cnv_trigger = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
> +				     "Failed to get CNV PWM\n");
> +
> +	/*
> +	 * Preemptively disable the PWM, since we only want to enable it with
> +	 * the buffer.
> +	 */
> +	pwm_disable(st->cnv_trigger);
> +
> +	return 0;
> +}
> +
>  static int ad4030_config(struct ad4030_state *st)
>  {
>  	int ret;
> @@ -994,6 +1263,31 @@ static int ad4030_config(struct ad4030_state *st)
>  	return 0;
>  }
>  
> +static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
> +				    struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct dma_chan *rx_dma;
> +
> +	indio_dev->setup_ops = &ad4030_offload_buffer_setup_ops;
> +
> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +							   SPI_OFFLOAD_TRIGGER_PERIODIC);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				     "failed to get offload trigger\n");
> +
> +	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;

If we want to be really strict/generic here, we should not be allowing
chips with num_voltage_inputs == 2 and a single SPI bus/deserializer (i.e.
channel data is interleaved). In this case, extra hardware is required
to do the de-interleaving (i.e. the spi_axis_reorder IP block).

We could take the easy way out and just always assume that is there.
In that case, we should makes some comments here about such assumptions.

Or we could actually describe it properly in the devicetree and check
for that here. This came up during the discussions when I was upstreaming
SPI offload support. It would look something like this...

In the devicetree, instead of having the DMA connected to the SPI controller,
we now have a separate IP block with it's own node between them.

/* spi_axis_reorder IP block */
reorder: offload-stream-sink@4000000 {
	compatible = "adi,axi-spi-reorder";
	reg = <0x4000000 0x1000>;
	clocks = <&spi_clk>;
	dmas = <&adc_dma>;
};

spi@5000000 {
	compatible = "adi,axi-spi-engine-1.00.a
	reg = <0x4000000 0x1000>;
	clocks = <&clkc 15>, <&spi_clk>;
	clock-name "s_axi_aclk", "spi_clk";

	trigger-sources = <&pwm_trigger>;
	offload-streams = <&reorder>;
	offload-stream-names = "offload0-rx";

	...
};

Then here in the driver, we would need a different (non-existing)
API to get the DMA from this offload-stream rather than calling
devm_spi_offload_rx_stream_request_dma_chan(). Or extend the SPI
controller to handle that.

Or 3rd option: If easy way is not acceptable and "right way" is too much
work, we could just return error here for num_voltage_inputs == 2 until
we add support for SPI controllers with two buses/deserializers.

> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to get offload RX DMA\n");
> +
> +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> +							   IIO_BUFFER_DIRECTION_IN);
> +}
> +
>  static int ad4030_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -1018,6 +1312,10 @@ static int ad4030_probe(struct spi_device *spi)
>  	if (!st->chip)
>  		return -EINVAL;
>  
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
>  	ret = ad4030_regulators_get(st);
>  	if (ret)
>  		return ret;
> @@ -1045,24 +1343,57 @@ static int ad4030_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
>  				     "Failed to get cnv gpio\n");
>  
> -	/*
> -	 * One hardware channel is split in two software channels when using
> -	 * common byte mode. Add one more channel for the timestamp.
> -	 */
> -	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
>  	indio_dev->name = st->chip->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad4030_iio_info;
> -	indio_dev->channels = st->chip->channels;
> -	indio_dev->available_scan_masks = st->chip->available_masks;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> -					      ad4030_trigger_handler,
> -					      &ad4030_buffer_setup_ops);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to setup triggered buffer\n");
> +	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +
> +	/* Fall back to low speed usage when no SPI offload is available. */
> +	if (ret == -ENODEV) {
> +		/*
> +		 * One hardware channel is split in two software channels when
> +		 * using common byte mode. Add one more channel for the timestamp.
> +		 */
> +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
> +		indio_dev->channels = st->chip->channels;
> +		indio_dev->available_scan_masks = st->chip->available_masks;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      iio_pollfunc_store_time,
> +						      ad4030_trigger_handler,
> +						      &ad4030_buffer_setup_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup triggered buffer\n");
> +	} else {
> +		/*
> +		 * One hardware channel is split in two software channels when
> +		 * using common byte mode. Offloaded SPI transfers can't support
> +		 * software timestamp so no additional timestamp channel is added.
> +		 */
> +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
> +		indio_dev->channels = st->chip->offload_channels;
> +		indio_dev->available_scan_masks = st->chip->available_masks;

It looks like scan_masks are the same in both cases, so we could leave that
outside of the if statement.

> +		ret = ad4030_spi_offload_setup(indio_dev, st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup SPI offload\n");
> +
> +		ret = ad4030_pwm_get(st);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to get PWM: %d\n", ret);
> +
> +		ret = __ad4030_set_sampling_freq(st, st->chip->max_sample_rate_hz,

Max sample rate probably isn't the best choice for a default since it only works
under very specific conditions. In another driver, we picked a rate that would
still work even if we maxed out the oversampling ratio and had only one serial
line. As mentioned above, the driver failed to probe for me because of this and
I had to change the inital rate.

> +						 st->avg_log2);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to set offload samp freq\n");
> +	}
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }

