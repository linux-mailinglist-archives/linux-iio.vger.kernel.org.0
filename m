Return-Path: <linux-iio+bounces-22141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB16B157F2
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 05:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4609F545FED
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084E1D514E;
	Wed, 30 Jul 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkix37Y6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A219CD17;
	Wed, 30 Jul 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753847096; cv=none; b=DpqBjNQ6RTnKuRAyGAjreRraOcO6fRVaDhoteoZudc6gqP4C1mFgqZ9TWSx9sd8TGIurVnF+W4p/xiZiN1DI6O4lhlE4VvMJ9WbYlGuEaUrvrtzU+2wd1r2gMQ53ncdvdhn6LR3yQwhLVByl3U+nOUE6dHFauGtmyiALz8mGk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753847096; c=relaxed/simple;
	bh=OI1yb8YjCJLH5Oh11M/pDegQRoWJPMolFTuhjtpB9jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+KhZMNhuynceqz2klChintyvRXD9dPiFTvZMRhCl9Yg/LyjHl2Vx1yWH5CTnrxzvtwLG76huL1kiV1AJQm7/Pvugysjhk6tC+miAoj1KCmxzvLaD/HmF7Y1T1e8kyv+L/eDuSCEnkGFqfqwJ/Y1Xgzx0xhgmnS8DkjXT512jZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pkix37Y6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so541106a91.1;
        Tue, 29 Jul 2025 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753847093; x=1754451893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XtRm7lojhZk/Guegs7CVGvpxrD6W4yNrLaVpEmyqDLQ=;
        b=Pkix37Y6XpKdmdfBqYl3/h/gPX4CoXa1F1tNfvt2Uk13J7P9QXcSqtLHjIYZwkANnR
         qGJYN2xa3JK2JWxibycYFbmJJ6CROt33SKVLnKEzFF1hcgQfdW1HxRkpbppCyuv5icFM
         S5zKaumUn5mdbl6cbKW4Ubvk/CaBAef+yLAztyV045/yJk68tszkKEpglYX8vLyqgV5x
         VF3LMoCNRFUp/mqCyyJC2gJfZHW6G97ro9KQygjQprf+UKX20QaH7jK7XVMRpcfJNSxe
         HqV7AO8tSWgC0RQhWt3/SdLu+m9STUi9ZE7qyKBEknaXexQc745k+n8IvTG+OKX7ptTb
         5X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753847093; x=1754451893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtRm7lojhZk/Guegs7CVGvpxrD6W4yNrLaVpEmyqDLQ=;
        b=Os5SUBNOkeRhxbqGwU9gDIID4eM3XDMiKz3p6Pa+rfyQM7SX8pgDJ+WcQzismGvVXe
         i5+ZFX7a6Z96MrNXztvxXXawSnAOrbxuQvS4w3yA9mxS3I68fDugde8LIQocX1XIrx+w
         c8nyhbmyYztL5o9KUzt8eUl0WL7jXLyAS8HY18DybIXkZyOBgmoP6SJJrqinD7vFs9rN
         ZzAckbPegql2GnzeIuy6V5yScFqOxbJndwW4s/OXEn/8LSJr8C38HkGx+dybvBVvQR80
         4Adf+83AQW63EV4LMWL/+8hCx7UzosMhZ8Ma00KE0rHWOoPL1pPUnFcuwlAQi47iYHxx
         c38A==
X-Forwarded-Encrypted: i=1; AJvYcCVgGk8C1dYnWdjnv7aEgJqZUG3lY6NQNGCBi4rozi9AJOoTXLxkccliCzemVLdiboAdEIoBv6m7p65B@vger.kernel.org, AJvYcCVyq4QtyTxky956QSTUBaIg6xx8D38g5WhwweIqm3UxDMbvKv8ifi/sonowgoOIIJTg5ARC7xf3yWaXhbso@vger.kernel.org, AJvYcCXG7Ig5zGT172LwS6P1vBRzRBX8aDBd0jfh/YyXYgS5/gAD8//6IGLmx3gwyqJfF30UnEd7IxB5elvn@vger.kernel.org
X-Gm-Message-State: AOJu0YwGseAXrC+AW39I2xRB14WGy8pC1uUoR8B/cYz4uDNfLURJk+xD
	2ybd4Ak2lChNpUmJ8B2NVDrdXKR36x9ZU/xq6P6LEZwHAreVM8gQEmiX
X-Gm-Gg: ASbGncvUshYqtpPQSsiwvUF9jjWnmgCImWCgDn7S2UrkJejB8jOsOlBo1RcduSb1aSN
	ad2AVnth/BeUiDIniAJIWoNGlXiWItPfRZ0G4FsV6rWBxDucRlKVqT8wPBIrxzsiErDqpuApsO1
	VD0b7Rq/Xh3rJCU6uEC1///RpQ7hSoVEskC2BzSr3CDGeDOSj+67ny1C0vWzsUHALcxdEqukHAd
	qy/SE5RjZELZorop93xV2WClSYQFia78f2LZNPxJsudwYmJq9+EtHbjBJ4JD94QLmBkg2X4g88v
	Dim6hoCUAemcHFsuRM22Iuiy3fjMFNra1d76lW13tGDAWvL1IG5oCA0BnwbFBMaw2+k3gpPUJcM
	rJhvBb/8p+O9XZ3q8jd8QaQ==
X-Google-Smtp-Source: AGHT+IELEYCA31j9P6Or7GVmAd7n7W5Rl2GMFLcjIwwLG8njncnATmQDigcfNH55gqHFIYkkLUHIuA==
X-Received: by 2002:a17:90b:3c44:b0:311:482a:f956 with SMTP id 98e67ed59e1d1-31f28c91e87mr7580790a91.5.1753847092676;
        Tue, 29 Jul 2025 20:44:52 -0700 (PDT)
Received: from dixit ([2401:4900:1c42:3ce:3482:dfb3:c610:58ac])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b41fda7b737sm5869776a12.66.2025.07.29.20.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 20:44:52 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:14:45 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <aImVLWJP08_g23xu@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <20250727140559.1f6c1668@jic23-huawei>
 <aIhE5zwrPljqHqGX@dixit>
 <20250729200513.275e0d98@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729200513.275e0d98@jic23-huawei>

On Tue, Jul 29, 2025 at 08:05:13PM +0100, Jonathan Cameron wrote:
> On Tue, 29 Jul 2025 09:19:59 +0530
> Dixit Parmar <dixitparmar19@gmail.com> wrote:
> 
> > On Sun, Jul 27, 2025 at 02:05:59PM +0100, Jonathan Cameron wrote:
> > > On Sat, 26 Jul 2025 15:07:01 +0530
> > > Dixit Parmar <dixitparmar19@gmail.com> wrote:
> > > 
> > > Hi Dixit,
> > > 
> > > Very clean driver for a v1. Nice.
> > >   
> > > > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor  
> > > 
> > > Slightly odd wrap.  Aim for 75 chars for patch descriptions.
> > >  
> > Okay, 75.
> > > > applications includes joysticks, control elements (white goods,
> > > > multifunction knops), or electric meters (anti tampering) and any
> > > > other application that requires accurate angular measurements at
> > > > low power consumptions.
> > > > 
> > > > The Sensor is configured over I2C, and as part of Sensor measurement
> > > > data it provides 3-Axis magnetic fields and temperature core measurement.
> > > > 
> > > > The driver supports raw value read and buffered input via external trigger
> > > > to allow streaming values with the same sensing timestamp.
> > > > 
> > > > The device can be configured in to different operating modes by optional
> > > > device-tree "mode" property. Also, the temperature sensing part requires
> > > > raw offset captured at 25°C and that can be specified by "temp-offset"
> > > > optional device-tree property.
> > > > 
> > > > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> > > > configurations interrupt(INT) is not recommended, unless timing constraints
> > > > between I2C data transfers and interrupt pulses are monitored and aligned.
> > > > 
> > > > The Sensor's I2C register map and mode information is described in product
> > > > User Manual[1].
> > > > 
> > > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf  
> > > Tag, so in the tags block (no blank line to the SoB)  
> > Sorry, didn't quite get it.
> 
> You should have it as Datasheet: <link>
> That will then be a formal 'tag' so belongs alongside the Signed-off-by: etc with no blank
> lines in that block.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf 
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf #1
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> 
> > > > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf  
> > > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf #1
> > > 
> > > So make it a tag with a trailing comment to give the reference number.
> > >   
> > > > 
> > > > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>  
> 
> > > > +
> > > > +#define TLV493D_DATA_X_GET(b)	\
> > > > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 | \
> > > > +			(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4), 11)  
> > > 
> > > These are odd enough I'd make them c functions rather than macros. Burn a few lines
> > > for better readability. 
> > >   
> > I saw this kind of data retrival and formation from registers as macros so I sticked to
> > it. Having all these as function will also require a seperate function
> > for each channel coz the masks and the layout of the bits changes over
> > the register. Do you still recommend it as c functions?
> 
> Is it more than 4 short functions?  I'd burn the few lines that costs.
> 
> s32 tlv493d_data_y_get(u8 *buff)
> {
> 	u16 val = FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
> 		  FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
> 
> 	return sign_extend32(val, 11);
> }
Okay.
Will a single function with channel as arguments will be better?
> > > > +/*
> > > > + * The datasheet mentions the sensor supports only direct byte-stream write starting from
> > > > + * register address 0x0. So for any modification to be made to any write registers, it must
> > > > + * be written starting from the register address 0x0.
> > > > + * I2C write operation should not contain register address in the I2C frame, it should
> > > > + * contains only raw byte stream for the write registers. As below,
> > > > + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> > > > + */
> > > > +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	if (!data || !data->client)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/*
> > > > +	 * As regmap does not provide raw write API which perform I2C write without
> > > > +	 * specifying register address, direct i2c_master_send() API is used.
> > > > +	 */
> > > > +	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));  
> > > 
> > > Given we have to do this, I'm a bit doubtful about regmap usage in general in here.
> > > Maybe it's just not a good fit and we should stick to direct use of the i2c stuff
> > > like here?
> > >   
> > Sorry, didn't get entirely? From what I understood, you meant we could
> > drop regmap from this driver entirely and use direct I2C APIs. I believe
> > that would be too much, coz of the frequency we perform operations and
> > regmap is easier and clean imo.
> 
> The mixture is nasty though :( 
Indeed.
> > Also, we could have used regmap_raw_write() API by specifying register
> > 0x0 as address and rest of the 3 bytes as data. regmap will perform raw
> > write of these byte stream over the I2C the same way sensor expects. But
> > the problem with that approach is we are not using it as per the API
> > convention. let me know your thoughts? Is it a good option, it'll look
> > like this:
> > regmap_raw_write(data->map, data->wr_regs[0], &data->wr_regs[1],
> > ARRAY_SIZE(data->wr_regs) - 1);
> 
> I'm not keen on that either.
> 
> If you really want to mix i2c and regmap then that's fine, I was just dubious
> whether we were getting value for money from regmap here.
> 
Agree. Let's switch to i2c APIs and drop regmap.
> > > > +	if (ret < 0) {
> > > > +		dev_err(data->dev, "failed to write registers. error %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +	*x = TLV493D_DATA_X_GET(buff);
> > > > +	*y = TLV493D_DATA_Y_GET(buff);
> > > > +	*z = TLV493D_DATA_Z_GET(buff);
> > > > +	*t = TLV493D_DATA_TEMP_GET(buff);
> > > > +
> > > > +out:
> > > > +	pm_runtime_mark_last_busy(data->dev);  
> > > 
> > > As below  This should get simpler.
> > > 
> > > Not directly relevant to this patch:
> > > 
> > > If this cycle is quiet I plan to propose some cleanup.h based handling for runtime
> > > pm as it's annoying how often we need a goto for it.  The new ACQUIRE()  / ACQUIRE_ERR()
> > > should work for this. 
> > >   
> > Does this need any modifications with current codebase?
> 
> Needs a bunch of work to show generality across many drivers and
> convincing Rafael (PM maintainer) it's a good idea.
> Don't try to do it in this series!
> 
> > >   
> > > > +	pm_runtime_put_autosuspend(data->dev);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int tlv493d_init(struct tlv493d_data *data)
> > > > +{
> > > > +	int ret;
> > > > +	u8 buff[TLV493D_RD_REG_MAX];
> > > > +
> > > > +	if (!data)
> > > > +		return -EINVAL;
> > > > +
> > > > +	/*
> > > > +	 * The sensor initialization requires below steps to be followed,
> > > > +	 * 1. Power-up sensor.
> > > > +	 * 2. Read and store read-registers map (0x0-0x9).
> > > > +	 * 3. Copy values from read reserved registers to write reserved fields (0x0-0x3).
> > > > +	 * 4. Set operating mode.
> > > > +	 * 5. Write to all registers.
> > > > +	 */
> > > > +	ret = regmap_bulk_read(data->map, TLV493D_RD_REG_BX, buff, ARRAY_SIZE(buff));
> > > > +	if (ret) {
> > > > +		dev_err(data->dev, "bulk read failed, error %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	data->wr_regs[0] = 0; /* Write register 0x0 is reserved. Does not require to be updated.*/
> > > > +	data->wr_regs[1] = buff[TLV493D_RD_REG_RES1] & TLV493D_RD_REG_RES1_WR_MASK;
> > > > +	data->wr_regs[2] = buff[TLV493D_RD_REG_RES2] & TLV493D_RD_REG_RES2_WR_MASK;
> > > > +	data->wr_regs[3] = buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES3_WR_MASK;
> > > > +
> > > > +	ret = tlv493d_set_operating_mode(data, data->mode);
> > > > +	if (ret < 0) {
> > > > +		dev_err(data->dev, "failed to set operating mode\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return ret;  
> > > return 0?  
> > Its the same though. ret from tlv493d_set_operating_mode is 0 on
> > success and -ve on failure.
> 
> Then return 0 to make it explicit that if we get here we only return 0.
> That can be useful to compilers.
> 
> Also check above as if (ret) is cleaner still.
> 
> 
> > > > +	if (ret)
> > > > +		val = 340;
> > > > +	/*
> > > > +	 * The above is a raw offset; however, IIO expects a single effective offset.
> > > > +	 * Since final temperature includes an additional fixed 25°C (i.e. 25000 m°C),
> > > > +	 * we compute a combined offset using scale = 1100 (1.1 * 1000).
> > > > +	 */
> > > > +	data->temp_offset = -val + (s32)div_u64(25000, 1100);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int tlv493d_read_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,  
> > > 
> > > wrap to keep this under 80.  Doesn't look like it will hurt readability.
> > >   
> > Ack. Is 80 standard for whole kernel or iio only?
> 
> It's kind of the the 'old' standard.  Used to be a fairly hard limit, but
> over time there has been some relaxation.  So, if your code is nice and readable
> you will rarely get anyone complaining if you stick to 80 chars.
> 
> > 
> > Thank you for such detailed review. Appriciate it,
> You are welcome.
> 
> J
> > Dixit
> 

