Return-Path: <linux-iio+bounces-18270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5BA93A88
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B91A9210BA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD58215789;
	Fri, 18 Apr 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlQqSyCA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2B2153FE;
	Fri, 18 Apr 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992819; cv=none; b=Qyu+d8Ctn1hWurj56H1mRoez471tSXK5j25GOrRgZVU9iBMHOi2cS/6iIcut6yLVUv2vEc1bpDuFTQkh8YByVFZ9Kop3cpnMZPhD+Q4j1ybVmRtElhF5ocyikG0LBbhoBI9BVRiBpqKSFjcN7F79Sjn834fyH2bRzb4OXvpPQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992819; c=relaxed/simple;
	bh=uQ/6b7sB1ONhc9820LzU2mrK9lP7Kt5df9XQ5yEtODU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4ONJB44kmxkxDCovALs3+f6Jz5AApcitt+1P96/EoOMpyITFOlbzz2Sds2/gFToec/p11Yg+Vxhc1OWpnc67Xw4OfwHkYfDCe/0VNUSVihr9ccjfutGeK323kw8TmxY6O37/G0n/KCcGKjF2TWy2NxVzC6kHu0j+sOdumNUBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlQqSyCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43D1C4CEE2;
	Fri, 18 Apr 2025 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744992818;
	bh=uQ/6b7sB1ONhc9820LzU2mrK9lP7Kt5df9XQ5yEtODU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GlQqSyCATnqMw0cNI9TJ0C2iLce8Tfu9P002qys+LGSJ4rdxtFcBPqMWgp5GDRd7z
	 7MEcVadUpLronX7vYhnPM8Whd/l0dtHUkYDDabKvVYe6DeRL4GgMHX6juzeVvuWUFI
	 WAplctHJ9NOtgxdfbt/L7u3xtKhFpdVfJaZabKJiN5MrBx4/n2aK0mCwo+9uzaQsjd
	 +hK/shuaqcsKtOjFux1ndgQCiEy0S1MMvcf639FmuqIpH28pq+vrUe6wXfwVCMzR2n
	 9NLhNLf7/+xbKyXlyAhqz0wamWDMivo7yZBUMIK7OchEHb+FxU42B65mud/wWKWeRF
	 XkKrhtfVpvIXg==
Date: Fri, 18 Apr 2025 17:13:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
 alisadariana@gmail.com, tgamblin@baylibre.com, olivier.moysan@foss.st.com,
 antoniu.miclaus@analog.com, eblanc@baylibre.com,
 andriy.shevchenko@linux.intel.com, joao.goncalves@toradex.com,
 tobias.sperling@softing.com, marcelo.schmitt@analog.com,
 angelogioacchino.delregno@collabora.com, thomas.bonnefille@bootlin.com,
 herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <20250418171326.07634113@jic23-huawei>
In-Reply-To: <20250416081734.563111-3-j2anfernee@gmail.com>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
	<20250416081734.563111-3-j2anfernee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 16:17:34 +0800
Eason Yang <j2anfernee@gmail.com> wrote:

> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.
> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
Hi Eason,

A few trivial things from another glance through.

Thanks,

Jonathan


> +
> +static const struct nct7201_adc_model_data nct7201_model_data = {
> +	.model_name = "nct7201",
> +	.channels = nct7201_channels,
> +	.num_channels = ARRAY_SIZE(nct7201_channels),
> +	.num_vin_channels = 8,
> +};
> +
> +static const struct nct7201_adc_model_data nct7202_model_data = {
> +	.model_name = "nct7202",
> +	.channels = nct7202_channels,
> +	.num_channels = ARRAY_SIZE(nct7202_channels),
> +	.num_vin_channels = 12,
> +};
> +
> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	struct device *dev = chip->dev;
> +	__le16 data = cpu_to_le16(NCT7201_REG_CHANNEL_ENABLE_MASK);

Assign this value down near where it is used. That will generally help
readability.

> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			   NCT7201_BIT_CONFIGURATION_RESET);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to reset chip\n");
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then the Power
> +	 * Up bit will be set to 1. If not, wait for it.
I'd hyphenate power-up perhaps.

> +	 */
> +	fsleep(25000);
> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to read busy status\n");
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(dev, -EIO, "Failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8)
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +				   NCT7201_REG_CHANNEL_ENABLE_MASK);

This is a little odd as I think you are writing an 8 bit register with a 12 bit mask.
Sure it works, but confusing thing to see.  If some future 6 channel device comes
along this <= 8 will seem odd too. Maybe generate the mask from teh number
of channels?

> +	else
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					&data, sizeof(data));
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable channel\n");
> +
> +	err = regmap_bulk_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +			       &chip->vin_mask, sizeof(chip->vin_mask));
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Failed to read channel enable register\n");
> +
> +	/* Start monitoring if needed */
> +	err = regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			      NCT7201_BIT_CONFIGURATION_START);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to start monitoring\n");
> +
> +	return 0;
> +}


