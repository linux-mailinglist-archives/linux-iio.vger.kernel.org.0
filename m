Return-Path: <linux-iio+bounces-7182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D19248E6
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A77282669
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C11CE0B0;
	Tue,  2 Jul 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmw6HnjP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F1282E1;
	Tue,  2 Jul 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951383; cv=none; b=tMkQd2Feq3U/eNJCBkuL3NIrNZPR82EQSy/zAdrrcvuZHT3c6D/8Y4jMBy6rwYP1hexk61agKWYPW5Blhwk2pZ5USJcfltUaj5dL4zJOAXqLPVAf/SOd1WEi3dPc83XVdXuqUi+dbh0EYb1ej084JLVet5s24j2teN1R+DW9cYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951383; c=relaxed/simple;
	bh=PPeV90arzQu+7Uv9VI11vXizNAfNFrLCWhgvo+R3uuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMLJJwVddRUfMFkAqVNh0C45ex8mXhbgnarPnyHhY/q1Jy0u/ysL7i8ssdQgPsReu75qqP5l2CtzCdigPj4QSTw0fyLpO2B0L50gfEUGw41uLnmnjsuep07a8b6mjlLLJIs4nFDCm7rj9e91DT2frw8WiBtMRAnPyqCUfuwaeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmw6HnjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C189CC116B1;
	Tue,  2 Jul 2024 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719951383;
	bh=PPeV90arzQu+7Uv9VI11vXizNAfNFrLCWhgvo+R3uuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hmw6HnjPnTlVr8wghJ+PY75Z4lo3Y/1gxeotH/pxM/tZkGw08IpWWNCMHffUkyc46
	 OQ73Zi5sgzEwqVh4cyL28P9zFGfAr3gPk+Ndue5Ijgd4IyjtpKOF4WkBs3iwhw3RVJ
	 ryw3NH7m0KUnUnUKCWSyG1Uxd11uaNdco2XNDMEVXjESPmt9Sfuqe7n0huDkuMkrBW
	 ntokMvCiTvLWkxtuSIe1rEkjWi8OjXPq1TQmXf1B8Rn28E0wHWvbg1ZHvIDVDKhcUZ
	 qLlrl2/7H3ttjzrtONxOJ/4hvvrqobUTvVBStQPAxiF9H0w82wSKzcOvgBfI9laizl
	 OWOo6wMci/Ycg==
Date: Tue, 2 Jul 2024 21:16:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Cc: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240702211615.0334c2e6@jic23-huawei>
In-Reply-To: <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
	<20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jul 2024 16:59:09 +0200
Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> wrote:

> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
Hi Petar

Given you are going to be doing a v4, a few comments inline on things
to tidy up in here.

Note that I've already tagged what may be the last pull request from me
for the 6.11 merge window, so this is probably 6.12 material now anyway.
Hence plenty of time to tidy up.

Jonathan

> diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
> new file mode 100644
> index 000000000000..661c70bc1b5b
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp500.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Sensirion sdp500 and sdp510 pressure sensors
> + *
> + * Datasheet: https://sensirion.com/resource/datasheet/sdp600
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/crc8.h>
> +#include <linux/iio/iio.h>

#include <linux/mod_devicetable.h> appropriate for the id tables.

> +#include <linux/regulator/consumer.h>
> +#include <asm/unaligned.h>
> +
> +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized to 0x31)

For IIO we tend to just use c style comments /* xxx */
and not c++ ones.

> +#define SDP500_READ_SIZE        3

> +static int sdp500_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	int ret;
> +	u8 rxbuf[SDP500_READ_SIZE];
> +	u8 received_crc, calculated_crc;
> +	struct sdp500_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to receive data");
> +			return ret;
> +		}
> +		if (ret != SDP500_READ_SIZE) {
> +			dev_err(data->dev, "Data is received wrongly");
> +			return -EIO;
> +		}
> +
> +		received_crc = rxbuf[2];
> +		calculated_crc = crc8(sdp500_crc8_table, rxbuf, sizeof(rxbuf) - 1, 0x00);
A line break in here to keep it under 80 chars would be good (see below).

> +		if (received_crc != calculated_crc) {
> +			dev_err(data->dev, "calculated crc = 0x%.2X, received 0x%.2X",
> +				calculated_crc, received_crc);
> +			return -EIO;
> +		}
> +
> +		*val = get_unaligned_be16(rxbuf);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		*val2 = 60;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info sdp500_info = {
> +	.read_raw = &sdp500_read_raw,
> +};
> +
> +static int sdp500_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct sdp500_data *data;
> +	struct device *dev = &client->dev;
> +	int ret;
> +	u8 rxbuf[SDP500_READ_SIZE];
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable regulator\n");
Given you are going around again.  Add a line break before "
General rule is stay under 80 chars unless it hurts readability.
 
> +

