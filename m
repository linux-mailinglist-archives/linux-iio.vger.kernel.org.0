Return-Path: <linux-iio+bounces-27294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D6CD449B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98FCB3000B6E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8C302CBA;
	Sun, 21 Dec 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+0w4dWy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7B3A1E60;
	Sun, 21 Dec 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766344408; cv=none; b=ogWDCCgG6vCQr5aUtBcYZ4AikhEb5PvDBjjNtqozGkUbFkwtcGiSV3Pa2ZotTahUJRQESGCxqaXDmLGaMuGczKXMtmwj3FEBFrZNUQziKMXtz94Q4+39gGBd8eG3AVmYgogoRpjtmH/bCQLG7VPgxl5X2fRfLmSmzSQF/wbFfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766344408; c=relaxed/simple;
	bh=oIyM+6Y/011fii1rlhhpcPat9VA188HJLa4bJW7bpaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7sed/9EYevKmaQ/TRLxhgYjhBWo3s/8zxPcyJcT9ugABUmAV1gk5ZA5lSTAlNI+QbC4MnI0XpiQ3b9/68C51MVjO7gpSiGnocdyqwO3vR134mX3nZ1+UiVkxocNQhNZcnJSKtW1zheJKcpCNcIM8keqnHmkIjuJi0zjATaiq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+0w4dWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26950C4CEFB;
	Sun, 21 Dec 2025 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766344408;
	bh=oIyM+6Y/011fii1rlhhpcPat9VA188HJLa4bJW7bpaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+0w4dWyUPFr18KdNyX7huN2SDMOTn5wqJmZQN6yZX0H5DPHDNpyy5m/Srh9yv5Ip
	 pEtiO8wUc5LMR38Vr1ery0zlFRCfLjqAS9qJaY1p3euMfcBEARi0ZMKVudIZWkosTN
	 v8YJZvd6U4lWyBIpM9CAC73TnpzOQEirudR3jddJLgd5r4/ocE9sDopg5pKtkSKv6p
	 5+1P885HSu2oOzhzSldDXAK2GvzOl3dnJZondxxVk29X5H9f40VdNhk+02yYqkcpef
	 b1nfArXEtvQEz82LsegykuYfKb2BxPw5/rR96fKaLt4+uKH3X2/MBE/Pls34fnor4l
	 gDAghbmIfzGag==
Date: Sun, 21 Dec 2025 19:13:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, linux@roeck-us.net, Carlos Song
 <carlos.song@nxp.com>, Adrian Fluturel <fluturel.adrian@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251221191316.7c3aa128@jic23-huawei>
In-Reply-To: <20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>
References: <20251215-i3c_ddr-v12-0-1ae31225b4d9@nxp.com>
	<20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 11:51:11 -0500
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
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

drivers/iio/magnetometer/mmc5633.c:87:5: warning: symbol 'mmc5633_samp_freq' was not declared. Should it be static?
(I fixed up)

With that and the trivial stuff below tidied up whilst applying, applied to the togreg
branch of iio.git. I'll initially push out as testing however to let the
bots take a first look before I annoy linux-next 

Jonathan


> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7b20ff3b063b026ab2ae0170fd8c021973428dea
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mmc5633.c

> +static int mmc5633_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct mmc5633_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

This is the missing scope thing from the bot report.  {}
needed in a switch to define scope for local variables like the one guard()
is using under the hood.

> +		ret = mmc5633_get_samp_freq_index(data, val, val2);
> +		if (ret < 0)
> +			return ret;
> +
> +		guard(mutex)(&data->mutex);
> +
> +		return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> +					  MMC5633_CTRL1_BW_MASK,
> +					  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static struct i2c_driver mmc5633_i2c_driver = {
> +	.driver = {
> +		.name = "mmc5633_i2c",
> +		.of_match_table = mmc5633_of_match,
> +		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
> +	},
> +	.probe = mmc5633_i2c_probe,
> +	.id_table =  mmc5633_i2c_id,
Bonus space after =

> +};

