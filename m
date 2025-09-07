Return-Path: <linux-iio+bounces-23834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A11B47A43
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CC83A6FAC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AA22256F;
	Sun,  7 Sep 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chVqrbqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64C1C8606;
	Sun,  7 Sep 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238567; cv=none; b=tmYuya9xcrymVq3CcL4VBrtRj4fyG5IhxRigqkFlXa2eNX7uvpujFYqcjbwh4YOqc/iEgCRMrko2N+ZCodpsx3jke3RaMQmg/YCjLe2uIsm2dYcDJV5td/HBQRBQhjIGnCq2Lxs/cLZDTS6g8dch/AGC2XDOlebjF8JnXRdKjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238567; c=relaxed/simple;
	bh=09SsC9CPsdCrkg9Q1JH9HwH0XdU+TT5Sdeby0QyXHBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs7QW0vIf0BlgR62dwbsXlBaQGtjG3DspO8DL+9APkzyr8WoDHKV2Z5bQcRL24dQOjP2ylMa2N2FX+hMkyuPmZQsm/MYMygYXd9YMHbvGMGJMZ1ITORWtTyEe1Uwg4kTWAJ5OGyunlEx2L8Lo40j91plgUugCSXspwJuHpumWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chVqrbqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CCFC4CEF0;
	Sun,  7 Sep 2025 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757238566;
	bh=09SsC9CPsdCrkg9Q1JH9HwH0XdU+TT5Sdeby0QyXHBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chVqrbqHlJp+wC3quYndhSuH97koNUw7ImMTvEwK+nidmKEJ89KwK1dkdZlaGk4BW
	 sxBb/W/BuA6+ZgQvIawn66cECgmfaqLQ+VSVcKuNnxRZ1AYlrwvOFAPXog2QRB6tLn
	 NSMCdVytDCIL+uX9edsKK94RWrl8SPYcRFmvtyiZo37YJ0RWmg+AeCsDg0mwsuN3y9
	 5jiPKVfuDcZt75hDujaAIhQZ/c7BLcW2TDmpUxa6KwuH4faDbeLSHNOOlX1rOLoUfI
	 ZYdLpBDSnivC/BUHfqYe4MDbkEa4qgkmUVSNRrgP06pNSf1BCZuozM4J15jgPrzmTu
	 wDn/Rcire5xng==
Date: Sun, 7 Sep 2025 10:49:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250907104917.5d743db3@jic23-huawei>
In-Reply-To: <20250906-tlv493d-sensor-v6_16-rc5-v6-2-b1a62d968353@gmail.com>
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
	<20250906-tlv493d-sensor-v6_16-rc5-v6-2-b1a62d968353@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Sep 2025 14:07:57 +0530
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

Only thing I spotted was trivial enough that I'll tidy that up (and Andy's comment)
whilst applying.  Changes made follow.  Applied to the togreg branch of iio.git and
pushed out as testing for 0-day to take a first look at it.

diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
index 6b9012889148..ec53fd40277b 100644
--- a/drivers/iio/magnetometer/tlv493d.c
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -250,10 +250,8 @@ static int tlv493d_init(struct tlv493d_data *data)
         * 5. Write to all registers.
         */
        ret = i2c_master_recv(data->client, buff, ARRAY_SIZE(buff));
-       if (ret < 0) {
-               dev_err(dev, "i2c read failed, error %d\n", ret);
-               return ret;
-       }
+       if (ret < 0)
+               return dev_err_probe(dev, ret, "i2c read failed\n");
 
        /* Write register 0x0 is reserved. Does not require to be updated.*/
        data->wr_regs[0] = 0;
@@ -262,10 +260,8 @@ static int tlv493d_init(struct tlv493d_data *data)
        data->wr_regs[3] = buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES3_WR_MASK;
 
        ret = tlv493d_set_operating_mode(data, data->mode);
-       if (ret < 0) {
-               dev_err(dev, "failed to set operating mode\n");
-               return ret;
-       }
+       if (ret < 0)
+               return dev_err_probe(dev, ret, "failed to set operating mode\n");
 
        return 0;
 }
@@ -336,7 +332,6 @@ static int tlv493d_read_raw(struct iio_dev *indio_dev,
                default:
                        return -EINVAL;
                }
-
        default:
                return -EINVAL;
        }


> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> new file mode 100644
> index 000000000000..6b9012889148
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tlv493d.c

> +static int tlv493d_init(struct tlv493d_data *data)

As this is only called from probe, ideally would just dev_err_probe() for
all error message print.

> +{
> +	int ret;
> +	u8 buff[TLV493D_RD_REG_MAX];
> +	struct device *dev = &data->client->dev;
> +
> +	/*
> +	 * The sensor initialization requires below steps to be followed,
> +	 * 1. Power-up sensor.
> +	 * 2. Read and store read-registers map (0x0-0x9).
> +	 * 3. Copy values from read reserved registers to write reserved fields
> +	 *    (0x0-0x3).
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
>

