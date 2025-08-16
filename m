Return-Path: <linux-iio+bounces-22813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BCB28DFB
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23DB1C25F32
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0C291C1C;
	Sat, 16 Aug 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8qDeBM1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602A757EA;
	Sat, 16 Aug 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349498; cv=none; b=l/Y+bmE+2zGqHL2+9z8R9dNu2mtcJFzsVUYZ1fnR3thF7BGdFPvbZc2akp9//cTRhy5DRppCkZ3pFETPDszMkoeHFd+CjpL4re7pv7SUSY56xBgND6mc6tbrvIEDwrpidV0jQl3s325FwHzntmOEvxDa6hVPKRszTWo1aLwD4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349498; c=relaxed/simple;
	bh=59qVG3031RGj7Nf3vD9KdAOLIqffhw5uU7dX/oDmNrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meg0bdKzQHK3IPjRhFI78AQtHhF344yTiU2fYIy/8F3bAyUubExeTaUJmHwYQ/5Dk8EHbTBNtJE1ZSjCn5WIrB+EUrDPC6gpCSILb0xa0V+cLViVvrmEhMak/3Lq1z/gvxuYdc+6ckw6+gHMYdfbTKE6MvVHpj8aZ6tCh1OT84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8qDeBM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D10C4CEEF;
	Sat, 16 Aug 2025 13:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755349497;
	bh=59qVG3031RGj7Nf3vD9KdAOLIqffhw5uU7dX/oDmNrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8qDeBM17W2sAhIx8RgMUnNEMWZpyv3pOqluRec1paR+9pb3G+xnBMYA6fRu+bUDt
	 qQLoLZ1vGtjysHSGuc8uCJlx2Gsa098/CyK9qf3FT+kgt7frgMgniw08WsS78DRP17
	 TrKmQ6yQt6X0O7KH/9nfqJA+Xw9KgpNvK6t7FKfgsI7Pi72TnCFJ/8ksTC0o8N9LUM
	 UsvV5qrgx37jejaPctnCI38A72jha3dRURXcL1BN2vDHf9YnWPc/b1jtpZQ9bH3Xgk
	 J//SyFL+6KDIr3x8NCQYugAeQZ22Ynv2WJtW+63DH0cKTedpKfhQpOlb/OZ5M8OZ0w
	 u3OsKX6RRyu4Q==
Date: Sat, 16 Aug 2025 14:04:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250816140448.37f38d0f@jic23-huawei>
In-Reply-To: <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
	<20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:23:43 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
> 
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
> 
> The driver supports raw value read and buffered input via external trigger
> to allow streaming values with the same sensing timestamp.
> 
> While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> But for bus configurations interrupt(INT) is not recommended, unless timing
> constraints between I2C data transfers and interrupt pulses are monitored
> and aligned.
> 
> The Sensor's I2C register map and mode information is described in product
> User Manual [1].
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf [1]
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Hi Dixit,

A couple of really minor things inline. Given Andy has been doing most of the review
work on this one I'll leave it for a few days to give him chance for a final look.

The stuff below is small so if nothing else comes up I can tweak it whilst applying

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> new file mode 100644
> index 000000000000..ee72211576a6
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -0,0 +1,530 @@

> +	TLV493D_AXIS_X,
> +	TLV493D_AXIS_Y,
> +	TLV493D_AXIS_Z,
> +	TLV493D_TEMPERATURE
As below.

> +};
> +
> +enum tlv493d_op_mode {
> +	TLV493D_OP_MODE_POWERDOWN,
> +	TLV493D_OP_MODE_FAST,
> +	TLV493D_OP_MODE_LOWPOWER,
> +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> +	TLV493D_OP_MODE_MASTERCONTROLLED
This is not a terminating entry, so would typically have a trailing comma.
> +};

> +
> +static int tlv493d_init(struct tlv493d_data *data)

I think this is only called from probe, so it would be appropriate
to use return dev_err_probe() in all the error paths.

If nothing else comes up I might tweak that whilst applying.

> +{
> +	int ret;
> +	u8 buff[TLV493D_RD_REG_MAX];
> +	struct device *dev = &data->client->dev;
> +
> +	/*
> +	 * The sensor initialization requires below steps to be followed,
> +	 * 1. Power-up sensor.
> +	 * 2. Read and store read-registers map (0x0-0x9).
> +	 * 3. Copy values from read reserved registers to write reserved fields (0x0-0x3).
> +	 * 4. Set operating mode.
> +	 * 5. Write to all registers.
> +	 */
> +	ret = i2c_master_recv(data->client, buff, ARRAY_SIZE(buff));
> +	if (ret < 0) {
> +		dev_err(dev, "i2c read failed, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Write register 0x0 is reserved. Does not require to be updated.*/
> +	data->wr_regs[0] = 0;
> +	data->wr_regs[1] = buff[TLV493D_RD_REG_RES1] & TLV493D_RD_REG_RES1_WR_MASK;
> +	data->wr_regs[2] = buff[TLV493D_RD_REG_RES2] & TLV493D_RD_REG_RES2_WR_MASK;
> +	data->wr_regs[3] = buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES3_WR_MASK;
> +
> +	ret = tlv493d_set_operating_mode(data, data->mode);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set operating mode\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

