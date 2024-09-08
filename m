Return-Path: <linux-iio+bounces-9337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA52E9708C0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 18:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FF81C20C79
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD5173331;
	Sun,  8 Sep 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KBnW/to0"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7241C01;
	Sun,  8 Sep 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725812926; cv=none; b=EUskBPrXaO5n/INg3/KCdhNmh5ZMytFsmXt9GUKIRrPgLWcjHHOrLUQAaWar7YtmTEgQqQU/EJAaoWUO5k88txqFAM7/3Het04GffJ9+Tu6DqNoqI3b4c/JHbeHvXrwKdmqlEvkVTQ0qa9hKJvzw+e7T36PNwqZFZXhmHnk7EpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725812926; c=relaxed/simple;
	bh=6Y6mvowD6Vd0W1f+ZwiRSAOPTuzFt7oLBAvovDmWF58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ck6JHISEM4ia26af4Kqup/2v26OtaD0rZWXgbiqfmvEsMsXMMUX+/OKA/4m4Js+uk45f1+zIZyM8VMJIwuHV/Yt2BYNOHUoG5CfdWZdMuk2mDssvCora4Eu2JqEJ4sDYn2DDnmld7afVhSIO5UOi2PTCC6OQDOiyNFzDDP7hZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KBnW/to0; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nKm9sJeJ841DAnKm9s64K1; Sun, 08 Sep 2024 18:28:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725812915;
	bh=JJwcLtiI4stIT0Ic279e4kM9IdcT2WJSDxx8qm63mKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KBnW/to0xvMW/KBv9QojsZ1A+kyUoI6H4vCEHmJ5YL2DhbMfoe1sb4ZeQLNWQddJ1
	 VEaaST7AuUrlKMDUquuR7ZNd+3Y0Tk0HhfxI0lJ14vDe5BcWcPZvvwN+W3iY4y4VOy
	 IjTs76JAc5UwLNglgcv7+eU1KWD5D96ZudOVcgMfq1jR9tryyW12ESGgq7m1lHWhOM
	 JqNVdV4f/mgiJzqbUN+FqN6UbqbKTlwlnzjAxAA27azlf038Ukyi1krlvrNvTjXuS7
	 pLVa06XL/6UX7TMgMaeaBq3ViLCjWxWFslnTzI8UntYGurQHuQEFqGoO5j2hXbZr8V
	 MVBFUSbYyWXFg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Sep 2024 18:28:35 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a6be8c40-5aa7-455c-8a15-55bda451ea51@wanadoo.fr>
Date: Sun, 8 Sep 2024 18:28:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
To: adureghello@baylibre.com
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 olivier.moysan@foss.st.com, robh@kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/09/2024 à 17:17, Angelo Dureghello a écrit :
> From: Angelo Dureghello <adureghello-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> Add support for ad3552r-axi, where ad3552r has to be controlled
> by the custom (fpga-based) ad3552r AXI DAC IP.

...

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

I don't know if it can be an issue, but iio_backend_ddr_disable() is 
called if iio_backend_ddr_enable() fails.

> +
> +	switch (*indio_dev->active_scan_mask) {
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
> +	 */
> +	if (st->synced_transfer == AD3552R_EXT_SYNC_ARM)
> +		err = iio_backend_ext_sync_enable(st->back);
> +	else
> +		err = iio_backend_ext_sync_disable(st->back);
> +	if (err)
> +		goto exit_err_sync;
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

...


> +#define AD3552R_CHANNEL(ch) { \
> +	.type = IIO_VOLTAGE, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.output = 1, \
> +	.indexed = 1, \
> +	.channel = (ch), \
> +	.scan_index = (ch), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_BE, \
> +	}, \
> +	.ext_info = ad3552r_axi_ext_info, \
> +}
> +
> +static struct iio_chan_spec ad3552r_axi_channels[] = {

I think (but I've not checked :)) that it could be const.

CJ

> +	AD3552R_CHANNEL(0),
> +	AD3552R_CHANNEL(1),
> +};

...

