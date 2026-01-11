Return-Path: <linux-iio+bounces-27620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06E2D0F67B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 17:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4E43050586
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93134C820;
	Sun, 11 Jan 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJPPS1EJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83C34BA24;
	Sun, 11 Jan 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768147764; cv=none; b=bGI9bfMyAbfCBouU3/96XnAvTC6YgWzmUQqEX4Y4qnkE7P7JMsEQcPToxwj8gJBrAKk6usrDPYMmyTExla7kYHWUr+S3qMgk0E8Ry2i2ydIb+zSbZhr89cY5O8cajIztYfM91GTA4Nr+U2ycK2AmmKGLXl8IsMU5WpxRLPIDmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768147764; c=relaxed/simple;
	bh=dbcZL645pHFqgTcsH096QV8zHH1uB+yrUffujrOPkiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxK7J7g+A6xoiT31voP68qvlhfO9b9diao3nlpVAKX2xxAW1vhbSsuEeAheyTm8g7qgzXNLA0OsS0vxok/gq+UfZqhRbUEdJsXoKRmD5BWtg5XsUrt9HAuJe/WTVWQ8GoVSNJBIraWT/GT1esM/sBA3kNHKcTJHY7hU/OxYa2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJPPS1EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBC5C4CEF7;
	Sun, 11 Jan 2026 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768147764;
	bh=dbcZL645pHFqgTcsH096QV8zHH1uB+yrUffujrOPkiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lJPPS1EJmitu8+bpVhq91HQHA6tYdlDOY/WgU2CFfsuFrr0nBLsDo59JRhxX2dAGs
	 yZMyq/Pv8mKfrC/R1McrFKIgzu8beNDt7YO57E5RlrE7Vni/y8G1jo0iE41dvm1XrN
	 lTNqIyxli7QdDv/J/i9abf2mJ9ZZsi01qqbVldkh/fK77A/w0et1ujnPK8vozmH+lN
	 We9R85tFqRIfUpFvKNSdXhjmRN+66hgQqZYNUxge9QUIA0RMEGBSRYeRMsRcbTXfM7
	 4G3nE+2pQ0AfF15eNjvMA1S8FNgZOET9EFdUuR7b6fWcbmhdDj55yjNje1sMO7kj2D
	 K+ybgH0G299eA==
Date: Sun, 11 Jan 2026 16:09:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jan.sun97@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: dac: Add MAX22007 DAC driver support
Message-ID: <20260111160914.72f177e6@jic23-huawei>
In-Reply-To: <20260108-max22007-dev-v2-2-2506c738784f@analog.com>
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
	<20260108-max22007-dev-v2-2-2506c738784f@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 13:58:24 +0100
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for the MAX22007, a 4-channel 12-bit DAC that drives
> voltage or current output on each channel.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

A few minor things to add to Marcelo's detailed review.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
> new file mode 100644
> index 000000000000..19557c008554
> --- /dev/null
> +++ b/drivers/iio/dac/max22007.c


> +static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
> +			     void *val, size_t val_size)
> +{
> +	struct max22007_state *st = context;
> +	u8 reg_byte = *(u8 *)reg;
> +	u8 calculated_crc, received_crc;
> +	u8 crc_data[3];
> +	u8 rx_buf[4];
> +	int ret;
> +
> +	if (reg_size != 1)
> +		return -EINVAL;
> +
> +	ret = spi_write_then_read(st->spi, &reg_byte, 1, rx_buf,
> +				  val_size + MAX22007_CRC_OVERHEAD);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	crc_data[0] = reg_byte;
> +	crc_data[1] = rx_buf[0];
> +	crc_data[2] = rx_buf[1];
> +
> +	calculated_crc = crc8(max22007_crc8_table, crc_data, 3, 0x00);

I think you can chain CRCs as follows and avoid the need for a local array
just to marshal the data.

	calculated_crc = crc8(max22007_crc8_table, &reg_byte, 1, 0x00);
	calculated_crc = crc8(max22007_crc8_table, rx_buf, 2, caculated_crc);

> +	received_crc = rx_buf[val_size];
> +
> +	if (calculated_crc != received_crc) {
> +		dev_err(&st->spi->dev, "CRC mismatch on read register %02x\n", reg_byte);
> +		return -EIO;
> +	}
> +
> +	memcpy(val, rx_buf, val_size);
> +
> +	return 0;
> +}

> +static ssize_t max22007_write_dac_powerdown(struct iio_dev *indio_dev,
> +					    uintptr_t private,
> +					    const struct iio_chan_spec *chan,
> +					    const char *buf, size_t len)
> +{
> +	struct max22007_state *st = iio_priv(indio_dev);
> +	bool powerdown;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	if (powerdown)
> +		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
> +					 MAX22007_CH_PWRON_CH_MASK(chan->channel),
> +					 MAX22007_CH_PWR_VAL(chan->channel, 0));
> +	else
> +		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
> +					 MAX22007_CH_PWRON_CH_MASK(chan->channel),
> +					 MAX22007_CH_PWR_VAL(chan->channel, 1));
> +	if (ret)
> +		return ret;
> +
Something like the following reduces duplication:

	ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
				 MAX2207_CH_PWRON_CH_MASK(chan->channel),
				 MAX2207_CH_PWR_VAL(chan->channel, powerdown ? 1 : 0);


> +	return len;
> +}


