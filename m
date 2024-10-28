Return-Path: <linux-iio+bounces-11482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5749B3482
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F3D1F229A2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A71DE3AA;
	Mon, 28 Oct 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Jo61nPDb"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAC54769;
	Mon, 28 Oct 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128375; cv=none; b=ko0BfpIZvCi5Ryj+Zp1oDhblwh2B6rm/0IoSMF5uKteumz75Zr61vr6cHbYpmFQ1OwI/K1NVr69+sZJlEHF8cb7PuRsot2nL6pwCggyj31ORVHwRmmy24wtaYaRKnsnqrC6JwSlCu8M9mUWHzSWikjlTekBns6jazS2XoSu6xdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128375; c=relaxed/simple;
	bh=7MqD3icugQngzAQ2Q7MgjC4Ss1IizgUGID5EmAQwFbI=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=fGa18Gr66rdev7s98azyw1pd0Bg9M0GD3BqkOT2t8dhuZFGcqb+Ky0p75JGjGH9FLE7ddxjL3efzkGy3rpey+hXB42B9hludQw95RMtB2K5ZSYRuJkmHgfYCD0ykWzAYwh/CqJrhK1rvW1BNc1EjDaTybk2cgxRmMlqyJrP1gWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Jo61nPDb; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5RP2tiD1igeRP5RP2t8WlI; Mon, 28 Oct 2024 16:11:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730128294;
	bh=fjqDdQt+XNPED4eC5c7Ufv/q0r2FByiZMWuGovsyH5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Jo61nPDboyWDeo5o+6HGmwAAbry/cUoEn6xA9BF5TW3FJkos/TC6Zn9sjO4+qDAv9
	 P5bK6oUhDotl5Jy5NCOivlcjRBTcyItDIqxUVbpny0lVz2os+KbUTUT5WRPDZp7cC1
	 TaTExCIo64NtDn68wNltIDU5Papf1a8vdC5KHgJWLRAUlVRRvuIs+o1t2FM9yZ3SjX
	 qkuGQdD1FczP1LJTOABY1Yv0Wn4MBxRBHhyvf1hU8tBw1pThK61ZxGp2hJGJ0uyIag
	 lXRCe/PvlX59mCakfGOR6pmoHQQsO4XRrR5dylgnWynv3pYYorM2J+0A2iR/S7DeMV
	 g62guAX8L6Jhw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 28 Oct 2024 16:11:34 +0100
X-ME-IP: 90.11.132.44
Message-ID: <f5454f83-4af2-419b-b0ca-7309fa96f264@wanadoo.fr>
Date: Mon, 28 Oct 2024 16:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iio: imu: adis16550: add adis16550 support
Cc: Nuno Sa <nuno.sa@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robert Budai <robert.budai@analog.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, robi_budai@yahoo.com
References: <20241028123550.9128-1-robert.budai@analog.com>
 <20241028123550.9128-3-robert.budai@analog.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Robert Budai <robert.budai@analog.com>
In-Reply-To: <20241028123550.9128-3-robert.budai@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/10/2024 à 13:35, Robert Budai a écrit :
> From: Nuno Sá <nuno.sa-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in
> the ADIS16550 combines industry leading MEMS only technology
> with signal conditioning that optimizes dynamic performance. The
> factory calibration characterizes each sensor for sensitivity, bias,
> and alignment. As a result, each sensor has its own dynamic com-
> pensation formulas that provide accurate sensor measurements

Hi,

...

> +static ssize_t adis16550_show_firmware_date(struct file *file,
> +					    char __user *userbuf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct adis16550 *st = file->private_data;
> +	u32 date;
> +	char buf[12];
> +	size_t len;
> +	int ret;
> +
> +	ret = adis_read_reg_32(&st->adis, ADIS16550_REG_FW_DATE, &date);
> +	if (ret)
> +		return ret;
> +
> +	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", date & 0xff,
> +		       (date >> 8) & 0xff, date >> 16);

scnprintf() ?

> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +}

...

> +static void adis16550_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct adis16550 *st = iio_priv(indio_dev);
> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;

I don't think that this is needed.
Functions below should ahndle it already.

> +
> +	debugfs_create_file_unsafe("serial_number", 0400,
> +				   d, st, &adis16550_serial_number_fops);
> +	debugfs_create_file_unsafe("product_id", 0400,
> +				   d, st, &adis16550_product_id_fops);
> +	debugfs_create_file("firmware_revision", 0400,
> +			    d, st, &adis16550_firmware_revision_fops);
> +	debugfs_create_file("firmware_date", 0400, d,
> +			    st, &adis16550_firmware_date_fops);
> +	debugfs_create_file_unsafe("flash_count", 0400,
> +				   d, st, &adis16550_flash_count_fops);
> +}

...

> +static int adis16550_set_freq(struct adis16550 *st, u32 freq)
> +{
> +	u16 dec;
> +	int ret;
> +	u32 sample_rate = st->clk_freq;
> +	/*
> +	 * The optimal sample rate for the supported IMUs is between
> +	 * int_clk - 1000 and int_clk + 500.
> +	 */
> +	u32 max_sample_rate =  st->info->int_clk * 1000 + 500000;
> +	u32 min_sample_rate =  st->info->int_clk * 1000 - 1000000;

Nitpick: 2 spaces after =

> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	adis_dev_lock(&st->adis);
> +
> +	if (st->sync_mode == ADIS16550_SYNC_MODE_SCALED) {
> +		unsigned long scaled_rate = lcm(st->clk_freq, freq);
> +		int sync_scale;
> +
> +		if (scaled_rate > max_sample_rate)
> +			scaled_rate = max_sample_rate / st->clk_freq * st->clk_freq;
> +		else
> +			scaled_rate = max_sample_rate / scaled_rate * scaled_rate;
> +
> +		if (scaled_rate < min_sample_rate)
> +			scaled_rate = roundup(min_sample_rate, st->clk_freq);
> +
> +		sync_scale = scaled_rate / st->clk_freq;
> +		ret = __adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
> +					  sync_scale);
> +		if (ret)
> +			goto error;
> +
> +		sample_rate = scaled_rate;
> +	}
> +
> +	dec = DIV_ROUND_CLOSEST(sample_rate, freq);
> +
> +	if (dec)
> +		dec--;
> +
> +	if (dec > st->info->max_dec)
> +		dec = st->info->max_dec;
> +
> +	ret = __adis_write_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, dec);
> +	if (ret)
> +		goto error;
> +
> +	adis_dev_unlock(&st->adis);
> +
> +	return 0;
> +
> +error:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
> +}

...

> +static const struct adis16550_chip_info adis16550_chip_info[] = {
> +	[ADIS16550] =
> +		ADIS16550_CHIP_INFO(adis16550),

This fits on the previous line.

> +	[ADIS16550W] =
> +		ADIS16550_CHIP_INFO(adis16550w),
> +};
> +
> +static u32 adis16550_validate_crc(const u32 *buf, const u8 n_elem,
> +				  const u32 crc)
> +{
> +	u32 crc_calc;
> +	u32 crc_buf[ADIS16550_BURST_N_ELEM - 2];
> +	int j;

Nitpick: i is more usual than j.
There also should be a newline here.

> +	/*
> +	 * The crc calculation of the data is done in little endian. Hence, we
> +	 * always swap the 32bit elements making sure that the data LSB is
> +	 * always on address 0...
> +	 */
> +	for (j = 0; j < n_elem; j++)
> +		crc_buf[j] = swab32(buf[j]);
> +
> +	crc_calc = crc32(~0, crc_buf, n_elem * 4);
> +	crc_calc ^= ~0;
> +
> +	return (crc_calc == crc);
> +}

...

> +static int adis16550_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->info =  device_get_match_data(&spi->dev);

Nitpick: 2 spaces after =

> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = st->info->channels;
> +	indio_dev->num_channels = st->info->num_channels;
> +	indio_dev->available_scan_masks = adis16550_channel_masks;
> +	indio_dev->info = &adis16550_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->adis.ops = &adis16550_ops;
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get vdd regulator\n");
> +
> +	ret = adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis16550_config_sync(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id adis16550_id[] = {
> +	{ "adis16550", (kernel_ulong_t)&adis16550_chip_info[ADIS16550]  },

Nitpick: extra space before ending }

> +	{ "adis16550w",  (kernel_ulong_t)&adis16550_chip_info[ADIS16550W] },

Nitpick: 2 spaces after first ,

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16550_id);
> +
> +static const struct of_device_id adis16550_of_match[] = {
> +	{ .compatible = "adi,adis16550", .data = &adis16550_chip_info[ADIS16550]},

Nitpick: missing space before ending }

> +	{ .compatible = "adi,adis16550w", .data = &adis16550_chip_info[ADIS16550W] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adis16550_of_match);

...

CJ

