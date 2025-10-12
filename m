Return-Path: <linux-iio+bounces-24983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FDBD0811
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3389E1893397
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AD2EBDD9;
	Sun, 12 Oct 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw8DY+5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BD19258E;
	Sun, 12 Oct 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288490; cv=none; b=kikj0EDJLlKMosKGZ5ovetQUvZUfI/9ilp0verFUK2KvQAy65pHPKybXqs4i1pyKqtd6vqlxmSdzULEkKxmEF+3PZvO5122uMvYnS+yG3TPxR5qvowXOqiujNs28Ku/xBKMVohWqCTtVEUyyF79z6fsmcO6kGgF5MJPStpm2NFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288490; c=relaxed/simple;
	bh=K5u3yiOfDjFXa37+LYFs7qYjcwjZgMOR4ZuK/iED6As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZ08jnSUKaeQJA79+spo4A7AkMTFz+NnRNwj3+EGLbBfpJiMuL4iz9wc9IIAfSWsHWQYKxEku5U8+Di+2GsjzUmSg6OqfPwKJwhzasDN/0j9MASyHCKzDIZdaZFmxHsh7JSqjrCe+pu+qOO4bw7WmWl563elJ/cwjew3P5XaKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw8DY+5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16CAC4CEE7;
	Sun, 12 Oct 2025 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288489;
	bh=K5u3yiOfDjFXa37+LYFs7qYjcwjZgMOR4ZuK/iED6As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bw8DY+5Pfpg1R8UcoCM122hWFKDBhgU/9yRH5uMR2xTdxsTiAHJYzlsRP3MBuKA+A
	 1vC8hsLHvHS8Y9CKurr179lLopG66hDKWRvayvIVlenefGSmSmolBu6NvD0wFa2g2P
	 tHsRtrKTcpYKgf3fhYOBTXjeSH7oyPUpYmBgxd7J4TCyAzOIaUViw03aT+zDxMQQ7R
	 2uIIGrC+43oI46R6FK5ilRpWBwiHowZmi4KWxMWqCaYfqExkzK7BBY6QXjESm/+AxQ
	 T8IiRBgRG52FACaeaTCQm5qqw76XYtgo4lbx1AhpkBuaS/geUgQiSZqeHCRHeNSlAi
	 EH8Z4I6ygOE2Q==
Date: Sun, 12 Oct 2025 18:01:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v5 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251012180119.312191fd@jic23-huawei>
In-Reply-To: <20251007-i3c_ddr-v5-5-444184f7725e@nxp.com>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
	<20251007-i3c_ddr-v5-5-444184f7725e@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 16:06:17 -0400
Frank Li <Frank.Li@nxp.com> wrote:

> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.
> 
> Co-developed-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Until now I missed the ACPI IDs that look to be almost certainly invalid.
See below.


> ---
> Change in V4
> - use { 1, 2000 }
> - Add _US for timeout
> - Use GEN_MASK for MMC5633_CTRL1_BW_MASK
> - Use { } for terminator.
> - remove !!
> - fix mix tab and space
> - add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
> - add tempature measure support
> 
> Change in v3
> - remove mmc5633_hw_set
> - make -> Make
> - change indention for mmc5633_samp_freq
> - use u8 arrary to handle dword data
> - get_unaligned_be16() to get raw data
> - add helper function to check if i3c support hdr
> - use read_avail() callback
> 
> change in v2
> - new patch

> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9b04cba6dbf633b7e0d136629a5aebffd072a68d
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mmc5633.c


> +static int mmc5633_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct mmc5633_data *data = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		i = mmc5633_get_samp_freq_index(data, val, val2);
> +		if (i < 0)
> +			return -EINVAL;
> +
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> +						 MMC5633_CTRL1_BW_MASK,
> +						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
> +			if (ret)
> +				return ret;
> +		};
> +		return ret;

Trivial but to get here it must be 0 so make that apparent via
		return 0;
Then everyone can see the 'good' exit really easily.

> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static const struct i2c_device_id mmc5633_i2c_id[] = {
> +	{ "mmc5603" },
> +	{ "mmc5633" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
> +
> +static const struct acpi_device_id mmc5633_acpi_match[] = {

Guess I missed these in previous versions. Sorry about that!

Where do these come from? 

MMC is not a registered PNP ID according to
https://uefi.org/PNP_ID_List?pnp_search=mmc

So are these in the wild? If they are provide the DSDT snippet
and a reference for where.  Also add a comment after the ID to provide
one device on which it is used.

ACPI IDs can take two valid forms. (1)   A 4 letter prefix that is
a registered ACPI ID.  e.g. HISI is the HiSilicon one I use for
the day job. And 4 digits that must be unique.  Typically each company
has a tracker for this and a process to get one assigned.
(2) A 3 letter PNP ID.  Similar otherwise.  Memsic has neither
unless issued very recently. 

So if these turn up on a device that uses ACPI either the manufacturer
of that should get MEMSIC to follow process to get an ID or use their
own.  It's common to find random sensors with IDs from device manufacturers
for this reason.  Here NXP could use their own ID for example.
They have a registered PNP ID which is the obvious NXP.  To do that
though you need to make sure you get a unique ID.



> +	{ "MMC5603", 0 },
> +	{ "mmc5633", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, mmc5633_acpi_match);
> +
> +static struct i2c_driver mmc5633_i2c_driver = {
> +	.driver = {
> +		.name = "mmc5633_i2c",
> +		.of_match_table = mmc5633_of_match,
> +		.acpi_match_table = mmc5633_acpi_match,
> +		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
> +	},
> +	.probe = mmc5633_i2c_probe,
> +	.id_table =  mmc5633_i2c_id,

Really trivial but there is a extra space after the =


