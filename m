Return-Path: <linux-iio+bounces-22245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603DB19A77
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 05:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216833A3944
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689721D59F;
	Mon,  4 Aug 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV4NYwFV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF81FB3;
	Mon,  4 Aug 2025 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754277515; cv=none; b=N4+9J/yRSvvvcP/WEVSYZ30y09IlRFUKqFzdBJ5+nI8a0Oc7iHZ0m2SsovrN0S3dBDpQvDR5ulVpFHrN3mdEa0Z//6jYDgKxTAFLECKrFtp5xxRZFn3ZGFrypr712B6DnluG5w7CuQoBBBvVtGHCWxD4OpQmS580ioYxDvUpPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754277515; c=relaxed/simple;
	bh=WuGIr8RNVHtl+Iq0qQcBja9G4IrlfI6jU5l66RTHPD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcYdCaMuVxHXNu9H5q+iWAHGIEpILWhxvlMlBmH7l2Uu55dt89NWqXMWbTcmlYrX+tLnZPvWPOuLG9RQ//52+Q9/O/TEZGPD5UeGnRot9amQ/Zsm2uaGHRKNPUsLhy+zjUH9seSCFJGp79OmRU/ug1bBfqnVOKv1Q0gBpfzQcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV4NYwFV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4235495646so1664533a12.2;
        Sun, 03 Aug 2025 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754277512; x=1754882312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8dcLSRp5B0Ne68wOvgWrOTAbJlgXFNXzBy8nUWM82+Q=;
        b=LV4NYwFV2ibUB2sur/gq9gWE+5suhFSvTnBY1M2D2ZkI92CAfQaGXyyT9yy8Nisiwn
         0NgD75NuX2DQ/Ryyb1ZDpyGHsAuGEukVywAmzS16mF3VkKcssk/Ii2o+RADZ7OuNggqN
         StEgXQWIiXZY9ZvfwbNFEsJch3oEugD5baZg9HRwpmBVCGGP8ULPZdVU4mQ+mNV6ZVit
         YVkDeq2Jpf9aJ21W+Qr5DamFjvIh7E9dT3v9EU/F2H3zNQDbmQWwI2m2DEy2mLxZkU1o
         z3RFKyiRSbIBbbcQ3PILxVr+RyEiZqEWbwRqHsdEB+lQQ3eP1u1MgoC11YEbxzguhBlx
         BAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754277512; x=1754882312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dcLSRp5B0Ne68wOvgWrOTAbJlgXFNXzBy8nUWM82+Q=;
        b=d5pxsjS888XuIZvizu447xkt5wDb7xPPGM0+882nStIHWPr4lpctIcJv3rjlfdm24P
         84FTxeSZubzKQGEGfRMWCp2rbOAaEQHgrjrQ0fvzueVe1c7MhIBll3iZTSSkZ6/7W56K
         sAYaFZMBqvlxiF6H869R9wFOez1MuZcMlhqWDIPHNkQM45Kpl2ws/TwRfw+2U7gY/HmS
         LOJKNc/Far70kKz/E5dcnzX4ncWX2mjHVI8P98nVNQZsqN4x2/c+RVLypQkxcyeqsFXB
         DSwWdJ2vcmK07ABmK7RCQg+iobIhADZv6djP2dorHCsJCW4yPg15jFGvIDBEIrysp/0K
         XOEw==
X-Forwarded-Encrypted: i=1; AJvYcCVB/TdSRUE4Y4KQTuwpms99WCYDH2Qq9R6dbGYb318bjpKUjIm2dDckmGSpMRfP8GbfE/vnNlzSy9inb1Gs@vger.kernel.org, AJvYcCVCqQ++QKWGqqvfpZmf5O4eirJE1Nmtir5la+IiTyWWhK0ktJvYVE9/SlJ7usT5959XiUE72SLIvzZB@vger.kernel.org, AJvYcCWQr4IzI3mT+FVIjxv3MZ/qoal+awjsGHVTpZCTqueg2zsMetRqSKUdNMbVYZUPNVJTlj/pjbLbOHy3@vger.kernel.org
X-Gm-Message-State: AOJu0YyTX/uP/+xvnigqA3Xt53tfKh5NSbPMS/TUpGUzyCneiJTydUDm
	3SWmSn0rJtZg2J6DcVid5wTid2kvTpx9sdOVvQLdB4k65HtfYSY3hbVG
X-Gm-Gg: ASbGnctDGNuEtg5ZMSCGxnayHEs8/v/X0m4P6fOiYQB3SfrrM+qDqN1NiRtTVLpOD6S
	W4DbxZqiRdRN5U+R8+niUAWgWa8LUvU5NSlZsoyM9NHS+Fq6E9HV8qm29SzrbA68XsF/ZeKAYi5
	2Y/ePDzlLJA9+PhrfbLPq35ybU0YeqSJsbiLrl0uwPEQr2O734Qzb9tyzV1Lqn2yYCaG7evKmkR
	EVsabCpWlkDunIXpUiS/w5nDQ8Zhi0bYDfgE/tHrx2xW1ZRCmU4IpBjqkywAht6ERA6pCfe1MWV
	rzNHyQJAg8uhM2zry56rYpl6/H7/ElPW7MweATpnMd/ue1DMEnJO1JfkzH7UN0SEf1DyUrhiZ2v
	smKkJk4ISFXpbhftaFvBmho4=
X-Google-Smtp-Source: AGHT+IEh8toJ84DeWRPo9IkrEWkW3bzs8SAjQgPiNxZubUDeoegUrEBBataAR8Sg9s78TipoauLbPA==
X-Received: by 2002:a17:902:cec7:b0:235:f143:9b07 with SMTP id d9443c01a7336-24246f595d3mr123674325ad.5.1754277512261;
        Sun, 03 Aug 2025 20:18:32 -0700 (PDT)
Received: from dixit ([2401:4900:1c43:eb01:acfe:5fdc:edb4:dbec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef671fsm97741145ad.9.2025.08.03.20.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 20:18:31 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:48:25 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aJAmgX0876tu5Ss0@dixit>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
 <20250802124333.67f64863@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802124333.67f64863@jic23-huawei>

On Sat, Aug 02, 2025 at 12:43:33PM +0100, Jonathan Cameron wrote:
> On Sat, 02 Aug 2025 12:14:27 +0530
> Dixit Parmar <dixitparmar19@gmail.com> wrote:
> 
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> > 
> > The Sensor is configured over I2C, and as part of Sensor measurement
> > data it provides 3-Axis magnetic fields and temperature core measurement.
> > 
> > The driver supports raw value read and buffered input via external trigger
> > to allow streaming values with the same sensing timestamp.
> > 
> > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> > configurations interrupt(INT) is not recommended, unless timing constraints
> > between I2C data transfers and interrupt pulses are monitored and aligned.
> > 
> > The Sensor's I2C register map and mode information is described in product
> > User Manual[Link].
> > 
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> 
> Hi Dixit,
> 
> Some additional comments inline.
> 
> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> > new file mode 100644
> > index 000000000000..da1569ae97bf
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/tlv493d.c
> 
> > +enum tlv493d_op_mode {
> > +	TLV493D_OP_MODE_POWERDOWN = 0,
> > +	TLV493D_OP_MODE_FAST,
> > +	TLV493D_OP_MODE_LOWPOWER,
> > +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > +	TLV493D_OP_MODE_MASTERCONTROLLED,
> > +	TLV493D_OP_MODE_MAX
> In order to be able to use this as the type for a parameter as suggested
> below, you'll need to drop MODE_MAX.  Comments on why you shouldn't
> need that anyway below.
> 
> > +};
> > +
> > +struct tlv493d_mode {
> > +	u8 m;
> You have an enum type.  Much better to use it.
> 
> > +	u32 sleep_us;
> > +};
> > +
> > +struct tlv493d_data {
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	/* protects from simultaneous sensor access and register readings */
> > +	struct mutex lock;
> > +	u8 mode;
> > +	u8 wr_regs[TLV493D_WR_REG_MAX];
> > +};
> > +
> > +/*
> > + * Different mode has different measurement cycle time, this time is
> > + * used in deriving the sleep and timemout while reading the data from
> > + * sensor in polling.
> > + * Power-down mode: No measurement.
> > + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> > + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> > + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> > + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> > + */
> > +static struct tlv493d_mode tlv493d_mode_info[TLV493D_OP_MODE_MAX] = {
> If you want to size it, do it using the enum values. [] is fine here
> 	[TLV493D_OP_MODE_POWERDOWN] = { }
> 
> I'm not sure why this should embed the index.  Can you just drop .m?
>
Indeed, In V2 I wanted to change this to a u32 array containing the
timing values for all mode and drop struct, but was skeptical.
IMO that would also be a clean way rather than having it in struct. Makes sense?
> > +	{ .m = TLV493D_OP_MODE_POWERDOWN, .sleep_us = 0 },
> > +	{ .m = TLV493D_OP_MODE_FAST, .sleep_us = 305 },
> > +	{ .m = TLV493D_OP_MODE_LOWPOWER, .sleep_us = 10 * USEC_PER_MSEC	},
> > +	{ .m = TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us = 100 * USEC_PER_MSEC },
> > +	{ .m = TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us = 305 }
> > +};
> > +
> > +/*
> > + * The datasheet mentions the sensor supports only direct byte-stream write
> > + * starting from register address 0x0. So for any modification to be made to
> > + * any write registers, it must be written starting from the register address
> > + * 0x0. I2C write operation should not contain register address in the I2C
> > + * frame, it should contains only raw byte stream for the write registers.
> > + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> > + */
> > +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> > +{
> > +	int ret;
> > +
> > +	if (!data || !data->client)
> If either of these happen, something went very very wrong.
> No need for the checks.  Remove all similar ones.
> 
Interesting, Is the idea behind is that this API is used within the
driver and the inputs are known? Ofcourse it saves some CPU cycles.
> > +		return -EINVAL;
> > +
> > +	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "i2c write registers failed, error: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_set_operating_mode(struct tlv493d_data *data, u8 mode)
> As below. Use the enum type.
> > +{
> > +	if (!data)
> > +		return -EINVAL;
> 
> As above. Data is never going to be NULL, so don't check it.
> 
> > +
> > +	u8 mode1_cfg, mode2_cfg;
> > +
> > +	switch (mode) {
> > +	case TLV493D_OP_MODE_POWERDOWN:
> > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 0);
> > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_FAST:
> > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 1);
> > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_LOWPOWER:
> > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
> > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 1);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
> > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
> > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > +		break;
> > +
> > +	case TLV493D_OP_MODE_MASTERCONTROLLED:
> > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 3);
> > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > +		break;
> > +
> > +	default:
> > +		dev_err(data->dev, "invalid mode configuration\n");
> > +		return -EINVAL;
> And with the enum type you shouldn't need a default.
> 
Can you please help me understand this better? So far my learning was,
wherever there is switch case, it must have default case handled
appropriatly.
> > +	}
> > +
> > +	data->wr_regs[TLV493D_WR_REG_MODE1] |= mode1_cfg;
> > +	data->wr_regs[TLV493D_WR_REG_MODE2] |= mode2_cfg;
> > +
> > +	return tlv493d_write_all_regs(data);
> > +}
> > +
> > +static s16 tlv493d_get_channel_data(u8 *b, u8 ch)
> Use the enum. 
> > +{
> > +	if (!b)
> > +		return -EINVAL;
> Unnecessary check
> > +
> > +	u16 val = 0;
> Variable declarations at the top of scope unless strong reason to do otherwise
> (only normally done for auto cleanup)
> > +
> > +	switch (ch) {
> > +	case TLV493D_AXIS_X:
> > +		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
> > +			FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
> > +		break;
> > +	case TLV493D_AXIS_Y:
> > +		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
> > +			FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
> > +		break;
> > +	case TLV493D_AXIS_Z:
> > +		val = FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << 4 |
> > +			FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]);
> > +		break;
> > +	case TLV493D_TEMPERATURE:
> > +		val = FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 |
> > +			FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> And with the enum, there will be no need to have a default.
> Not to mention passing -EINVAL through an s16 is unusual and I doubt wise.
> 
> > +	}
> > +
> > +	return sign_extend32(val, 11);
> > +}
> > +
> > +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
> > +				s16 *z, s16 *t)
> > +{
> > +	u8 buff[7] = {};
> > +	int err, ret;
> > +	struct tlv493d_mode *mode;
> > +
> > +	if (!data)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = pm_runtime_resume_and_get(data->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mode = &tlv493d_mode_info[data->mode];
> > +
> > +	/*
> > +	 * Poll until data is valid,
> > +	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
> > +	 * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
> > +	 */
> > +	ret = read_poll_timeout(i2c_master_recv, err, err ||
> > +			FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
> > +			mode->sleep_us, (3 * mode->sleep_us), false, data->client, buff,
> > +			ARRAY_SIZE(buff));
> > +	if (ret) {
> > +		dev_err(data->dev, "i2c read poll timeout, error:%d\n", ret);
> > +		goto out;
> > +	}
> > +	if (err < 0) {
> > +		dev_err(data->dev, "i2c read data failed, error:%d\n", err);
> > +		ret = err;
> > +		goto out;
> > +	}
> > +
> > +	*x = tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
> > +	*y = tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
> > +	*z = tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
> > +	*t = tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
> > +
> > +out:
> > +	pm_runtime_mark_last_busy(data->dev);
> I've just rebased (mid merge window so i'll do it again on rc1) and now
> have the version of pm_runtime_put_autosuspend() that internally calls
> pm_runtime_mark_last_busy().
> 
> So please drop the line above if you need to do a v3.
>  
Okay.
> > +	pm_runtime_put_autosuspend(data->dev);
> > +	return ret;
> > +}
> 
> > +static int tlv493d_read_raw(struct iio_dev *indio_dev,
> > +			const struct iio_chan_spec *chan, int *val,
> > +			int *val2, long mask)
> > +{
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +	s16 x, y, z, t;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Return raw values for requested channel */
> > +		switch (chan->address) {
> > +		case TLV493D_AXIS_X:
> > +			*val = x;
> > +			return IIO_VAL_INT;
> > +		case TLV493D_AXIS_Y:
> > +			*val = y;
> > +			return IIO_VAL_INT;
> > +		case TLV493D_AXIS_Z:
> > +			*val = z;
> > +			return IIO_VAL_INT;
> > +		case TLV493D_TEMPERATURE:
> > +			*val = t;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_MAGN:
> > +			/*
> > +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
> > +			 * Magnetic filed in Guass: mT * 10 = 0.098.
> > +			 */
> > +			*val = 98;
> > +			*val2 = 1000;
> > +			return IIO_VAL_FRACTIONAL;
> > +		case IIO_TEMP:
> > +			/*
> > +			 * Temperature scale: 1.1 °C per LSB, expressed as 1100 m°C
> > +			 * Returned as integer for IIO core to apply:
> > +			 * temp = (raw + offset) * scale
> > +			 */
> > +			*val = 1100;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (chan->type) {
> > +		case IIO_TEMP:
> > +			/*
> > +			 * Temperature offset includes sensor-specific raw offset
> > +			 * plus compensation for +25°C bias in formula.
> > +			 * offset = -raw_offset + (25000 / 1100)
> > +			 * -340 + 22.72 = -317.28
> > +			 */
> > +			*val = -31728;
> > +			*val2 = 100;
> > +			return IIO_VAL_FRACTIONAL;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> 
> Can you get here? If not drop this.  Compilers are very good at complaining if
> code changes later such that we should add this back.
> 
> > +}
> 
> > +static const struct iio_info tlv493d_info = {
> > +	.read_raw = tlv493d_read_raw,
> > +};
> > +
> > +static const struct iio_buffer_setup_ops tlv493d_setup_ops = { NULL };
> 
> No need specify that NULL. Due to some odd quirks of compiler specific
> handling and C spec evolution (none of which apply to the kernel because
> we carefully choose build options) that is actually less likely to do what
> you want than = { };
> 
Originally it was { } in V1. Got review comment that it must have NULL
if no ops is being passed, so I added (May be I would have asked and
understand their point). Nevertheless will remove NULL.
> 
> 
> > +
> > +static const unsigned long tlv493d_scan_masks[] = { GENMASK(3, 0), 0 };
> > +
> > +static int tlv493d_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct tlv493d_data *data;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->dev = dev;
> > +	data->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	ret = devm_mutex_init(dev, &data->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> > +
> > +	/*
> > +	 * Setting Sensor default operating mode as Master Controlled mode as
> > +	 * it performs measurement cycle on-request only and stays in Power-Down
> > +	 * mode until next cycle is initiated.
> > +	 */
> > +	data->mode = TLV493D_OP_MODE_MASTERCONTROLLED;
> > +	ret = tlv493d_init(data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to initialize\n");
> > +
> > +	indio_dev->info = &tlv493d_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->name = client->name;
> > +	indio_dev->channels = tlv493d_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(tlv493d_channels);
> > +	indio_dev->available_scan_masks = tlv493d_scan_masks;
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +			iio_pollfunc_store_time, tlv493d_trigger_handler,
> > +			&tlv493d_setup_ops);
> Similar to below no alignment. Something like;
> 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> 					      iio_pollfunc_store_time,
> 					      tlv493d_trigger_handler,
> 					      &tlv493d_setup_ops);
> 
> If you do have a case where the line ends up very long with this style, then
> indent only one tab more than line above. If that applied here it would be.
> 
> 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> 		iio_pollfunc_store_time, tlv493d_trigger_handler,
> 		&tlv493d_setup_ops);
> 
> 
> 
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
> > +
> > +	ret = pm_runtime_set_active(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = devm_pm_runtime_enable(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "iio device register failed\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int tlv493d_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> > +
> > +	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
> > +}
> > +
> > +static int tlv493d_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct tlv493d_data *data = iio_priv(indio_dev);
> 
> Trivial but you could do
> 	struct tlv493d_data *data = iio_priv(dev_get_drvdata(dev));
> with no real loss of readability.
> 
> > +
> > +	return tlv493d_set_operating_mode(data, data->mode);
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> > +			tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
> Preferred wrapping here is
> static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv493d_runtime_suspend,
> 				 tlv493d_runtime_resume, NULL);
> 
> So go nearer 80 chars on first line and align second line below the parameters
> on the first line.
> 
> Jonathan
> 

