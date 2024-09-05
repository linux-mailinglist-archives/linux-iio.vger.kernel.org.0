Return-Path: <linux-iio+bounces-9217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8396E43D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8A31F21A5D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146791A3BB9;
	Thu,  5 Sep 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t60eJiSW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA817BEB0
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568816; cv=none; b=fSQVOsmF6pqg8HJQ03bfi44uBVOL2QA/xj7pH1Tj+c3lBepr2zH/BYW3CnSrMemqUyvN4TxlPxeW1Cwzzy7xUszwUCadukjQ/gddj6c06Es/7hSrwkbjdDYrxbDhbGhiSIvR98DJAGDriDAlrsHsFlVA1nAZqEmabbszJK1t0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568816; c=relaxed/simple;
	bh=/ARVGuyzHLLg8wXLAKckTVu0x9ZLviw4WFu5PHzeIeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntYQrofOELWWT8a/ibZwRujUMC7AN3k5xgyIjEV2k5V3i3HuTCXghDXsJWHSQOf8+rjSAr7pwyFX9IQGEPClS2wSXR/UCqNCdFihFp5WeEWPEggcmpkbExE8IUiRWZB4St3TXn0kmHXSOlwWd346z1GBAiov0IhBTLr2/GlMoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t60eJiSW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70943713472so719775a34.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725568813; x=1726173613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN9Ba3H9w71uOoA1jFx1TX/eE+kC8y/CszFQ8do6ros=;
        b=t60eJiSWdRxZFWKRDe9BlTvcvBTW71hvq4pcGcdQyiwjB8UvHWu4GjNr9ONeFklQ8D
         nAQrmEsiEJ09t+VuHRtVuyELAhZJJvFv06ahz+Moj/tfDtBMvN3nIA3M1+mey9jKsqtL
         RImTWHT8SXmermQUx3FAvSp7+lmGZNbHzwXsOi5N0xVs1RMoKiXdfEGObwrP0g6e7mFw
         0qwiwbbzfS/reARcuhwucaaM5OucjstRupM9MFhMRCxWkpuBFrNcs6HdBffR3S8LWx3O
         saPslINjscezxgL/cGlFM6bhAY8XK9JMyxrhvP/JI7/bKTbVGNkV2kEny3Ird1w91Qim
         nMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725568813; x=1726173613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN9Ba3H9w71uOoA1jFx1TX/eE+kC8y/CszFQ8do6ros=;
        b=etvc9qn2LGt9D/JW8Myllbiwhaz7uDSERcFIcWjsIzgPGJCaEVr9sYi7HRClwijX+X
         tOa5T4HtcgC+IKJIFzKsUDTRPcwbAInLHDYc+s/37B5Vj723Zks6zOlxLcyXBo6DFVcD
         xsE6qKGkLEhzg8D+VPrUtnZjGhcdvEY7gSar07T8bbrGsLA+OQlb12ir6c2UqWGHdNBF
         wvMgaTjBSkX7hCqEM15KMicmcZc4+U9YEiwqfxauXq3wsTL2j4cTNmCmeLEoUDhMHIYp
         VVDDfO/ZDHEox5hsuEBmn3ztzRv5q65kCcBzLPnQZmOit8i0efwy+evNMbbK5wKEXPXy
         a5VA==
X-Gm-Message-State: AOJu0Yzu7+yoUIa62y1JX3ENHPsVoFWzZLbcx4QYIDsFB4RpfmLmFeVI
	ebUQMubtETafuB9zwCizdeeACseSGI+gGUvAy+hqrbgbQPHX3mMEHx2Cb3r95SM=
X-Google-Smtp-Source: AGHT+IEG2vgqPtEBqB1wj7sdVRKe+FRMlGb5Np8NvmJRy6b3Q7bkHz58pjfA5dY7Opgij63j/VUm2w==
X-Received: by 2002:a05:6830:7195:b0:709:30eb:dfcb with SMTP id 46e09a7af769-710cc22b5a8mr274377a34.18.1725568813126;
        Thu, 05 Sep 2024 13:40:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67155ec7sm3402426a34.28.2024.09.05.13.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 13:40:12 -0700 (PDT)
Message-ID: <b289a789-0440-4c1f-9f75-6d7e8e04189d@baylibre.com>
Date: Thu, 5 Sep 2024 15:40:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 10:17 AM, Angelo Dureghello wrote:

...

> +
> +static int ad3552r_axi_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	int err, ch = chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		int clk_rate;
> +
> +		err = iio_backend_read_raw(st->back, chan, &clk_rate, 0,
> +					   IIO_CHAN_INFO_FREQUENCY);

This seems odd to me. How does the backend know what frequency we want?
It would make more sense to me if this somehow indicated that we were
getting the SPI SCLK rate.

> +		if (err != IIO_VAL_INT)

Would be better to call the variable ret instead of err if it can hold
something besides an error code.

> +			return err;
> +
> +		/*
> +		 * Data stream SDR/DDR (clk_in/8 or clk_in/4 update rate).
> +		 * Samplerate has sense in DDR only.

We should also mention that this assumes QSPI in addtion to DDR enabled.

> +		 */
> +		if (st->single_channel)
> +			clk_rate = DIV_ROUND_CLOSEST(clk_rate, 4);
> +		else
> +			clk_rate = DIV_ROUND_CLOSEST(clk_rate, 8);
> +

Having the sample rate depend on how many channels are enabled in
the buffer seems a bit odd. Sampling frequency is not strictly
defined in IIO, so I think it would be fine to always return the
same value no matter how many channels are enabled.

We will just need to document that the sampling frequency is the
rate per sample, not per channel. So if two channels are enabled,
the effective sampling rate per channel is 1/2 of the sampling
rate reported by the sysfs attribute. 

> +		*val = clk_rate;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_RAW:

Do we need iio_device_claim_direct_scoped() here to prevent attempting
to do register access while a buffered write is in progress?

> +		err = iio_backend_bus_reg_read(st->back,
> +					       AD3552R_REG_ADDR_CH_DAC_16B(ch),
> +					       val, 2);
> +		if (err)
> +			return err;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3552r_axi_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +			int ch = chan->channel;
> +
> +			return iio_backend_bus_reg_write(st->back,
> +				    AD3552R_REG_ADDR_CH_DAC_16B(ch), val, 2);
> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3552r_axi_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	struct iio_backend_data_fmt fmt = {
> +		.type = IIO_BACKEND_DATA_UNSIGNED
> +	};
> +	int loop_len, val, err;
> +
> +	/* Inform DAC chip to switch into DDR mode */
> +	err = axi3552r_qspi_update_reg_bits(st->back,
> +					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					    AD3552R_MASK_SPI_CONFIG_DDR,
> +					    AD3552R_MASK_SPI_CONFIG_DDR, 1);
> +	if (err)
> +		return err;
> +
> +	/* Inform DAC IP to go for DDR mode from now on */
> +	err = iio_backend_ddr_enable(st->back);
> +	if (err)
> +		goto exit_err;

Might want a comment or dev_warn() here. If we put the DAC in DDR
mode but can't put the backend in DDR mode, then things are probably
going to be a bit broken if we can't get the DAC back out of DDR
mode. Not likely to ever get an error here, but it will be helpful
to let readers of the code know why the unwinding isn't exactly
balanced.

> +> +	switch (*indio_dev->active_scan_mask) {
> +	case AD3552R_CH0_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
> +		break;
> +	case AD3552R_CH1_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	case AD3552R_CH0_CH1_ACTIVE:
> +		st->single_channel = false;
> +		loop_len = AD3552R_STREAM_4BYTE_LOOP;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	default:
> +		return -EINVAL;

Move the switch statement before changing to DDR mode or
goto exit_err here.

> +	}
> +
> +	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> +					loop_len, 1);
> +	if (err)
> +		goto exit_err;
> +
> +	err = iio_backend_data_transfer_addr(st->back, val);
> +	if (err)
> +		goto exit_err;
> +
> +	/*
> +	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
> +	 * of the IP are in the design and they need to generate the signals
> +	 * synchronized.
> +	 *
> +	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
> +	 * but EXT_SYMC (ext synch ability) is enabled anyway.

EXT_SYNC

> +	 */
> +	if (st->synced_transfer == AD3552R_EXT_SYNC_ARM)
> +		err = iio_backend_ext_sync_enable(st->back);
> +	else
> +		err = iio_backend_ext_sync_disable(st->back);
> +	if (err)
> +		goto exit_err_sync;

		goto exit_err;

If enabling failed, no need to disable.

> +
> +	err = iio_backend_data_format_set(st->back, 0, &fmt);
> +	if (err)
> +		goto exit_err_sync;
> +
> +	err = iio_backend_buffer_enable(st->back);
> +	if (err)
> +		goto exit_err_sync;
> +
> +	return 0;
> +
> +exit_err_sync:
> +	iio_backend_ext_sync_disable(st->back);
> +
> +exit_err:
> +	axi3552r_qspi_update_reg_bits(st->back,
> +				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				      AD3552R_MASK_SPI_CONFIG_DDR,
> +				      0, 1);
> +
> +	iio_backend_ddr_disable(st->back);
> +
> +	return err;
> +}
> +
> +static int ad3552r_axi_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
> +	int err;
> +
> +	err = iio_backend_buffer_disable(st->back);
> +	if (err)
> +		return err;

Looks like iio_backend_ext_sync_disable(st->back); should be called here.

> +
> +	/* Inform DAC to set in SDR mode */
> +	err = axi3552r_qspi_update_reg_bits(st->back,
> +					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					    AD3552R_MASK_SPI_CONFIG_DDR,
> +					    0, 1);
> +	if (err)
> +		return err;
> +
> +	return iio_backend_ddr_disable(st->back);
> +}
> +

