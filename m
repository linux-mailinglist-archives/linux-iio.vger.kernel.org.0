Return-Path: <linux-iio+bounces-22489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49607B1F46A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 13:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB5F722029
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044C27F182;
	Sat,  9 Aug 2025 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfv10rfH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4101CBA18;
	Sat,  9 Aug 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754739896; cv=none; b=P/Z74QMV7c3bk+kizqeWWVK2jRPNkqUNEzUTfYUXxmrWmXjNBs9mShu37YF4QLjXEFsdT07kaJylYwsr5Zk1PKqWwer5VsKL4rigmugoT7Uf+rtMdpx+mfUNWRHf96tuu8I/2zZsQxKTrh/PXhhXmOOfl1QXb1tFTP/+qPIF7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754739896; c=relaxed/simple;
	bh=Azvvfcb9SnOqvqu229kwZtw+F9tzwYrzTk1mDHyS+xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZKnYkZVIFExuH8qZdYohfVqT+g7JktnOkSoMYuPxGeZuuvFu7+yAIkRUTzGlcLsKkQDAVoGydB4Yo9NTsqB705dpt6rMdNrk5m7XSWkVKV9D2prNaw6jFbPx90emSsftMb7vuxr6vBkCj9abVG6Q2QZxw87X1uHGEm3saQ/Vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfv10rfH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so3478612a12.3;
        Sat, 09 Aug 2025 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754739894; x=1755344694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uT4no/pCag6wFWmsFofuh7pYlxDOOGT57ZsLXecReMk=;
        b=Sfv10rfHq3N3POZZJMm3w6GCTXZfpRKqen3NdLuwfKOhup5ue0hvEEW/HRuc/4Lz1a
         E7QtCUyxYOhtBM/wq8NfSUy2PH73Izya8t/r7yVFUfkRp1hE75OeRbGRCGtsR1VuojXU
         iF8vYqlfg3L3gHpb3hefBeXv4owZWz7UjCmsgN+K+/fCkFW6nQKec1UCGFMO1PJjRHtG
         sUBSVhzL5uhEs8vYIStqllzHyFspZoFEEVO0HUk64rtbCRJqOq3vR4uQgIu91tUrS6HE
         IfZEP6OAh6Mklmh11HIWgZY//+Xcoufvag84c+TNrF+v+DF0BQ38JnC9dMubZvdfZKA6
         Bt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754739894; x=1755344694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT4no/pCag6wFWmsFofuh7pYlxDOOGT57ZsLXecReMk=;
        b=EHMEiROuNeHqHtTqsWTHdZxoIrbcUD4eAmcSeI15jlHjlYdK9KNpuy/6woAX2Sanh+
         wIHayzmBIYPXEyo4kGfPWgFAJJ6obK7d4Hq5SZ4YG5KV6dqyd1SLqQ/QfvlsytAjtoNJ
         7mhgLLn7PkeQ1a5YjZtJUY+fVAYXc6Fn3isPPskzgAoDhcsFr2aL9a7nfH4AaEoGapa6
         nYWwC2btuhqIrXNXUP54awmqPPI8XUJDtIUA5JrxmIEkh3/+xudcS1epAAhY0+1jWBJW
         0Xnut/5+RthEVvnMu2FukSA8TR9EkkTPrD5gWz9HXqfBpZSuh0w0JYilHF9GGAF05tUW
         jJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUIJgDJtBVxHW0xN+nOyxJX8PQIBusi8h1iQB5QcPW8wEb0W3VfS8+Y2SrgpVIfSpN1/XvKwQn84HGnn9Hb@vger.kernel.org, AJvYcCUJMi+jljRQyiyWv3PoSmLFz9qKmH6WC+D/aW3UjH+/j3O6g8PEoXWmUU5WX2oRYn4RxOKYdTbtg2Is@vger.kernel.org, AJvYcCXDZOkhDs4mgF7/B9E6+bc/Hfka/cxl6zSL1TZa2VKq2IVWnHFtfDTHAEfPmFGmvden1RUJ34IJWuU+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkni6e7XMf/9v0Jm8ZGFAo5PWtNJ11lJuz1byPyDREbdVXvmkp
	VXVL2AbZpZR1mI0ROuxknt8mPyek4xr9YwcANsVRis/2O/g6t6Pj/87Z
X-Gm-Gg: ASbGncvBdmHD2Jk2gPxjIrUh3JB+AMC36MgXQN4uMrpAIu0cPFQ/lCLVfPMeiVN8U8V
	0x9uxTRt7dBbluexkCJ3MViiN5P8EOT3B8Vik5ncYpuop+NLaQfAUazt9gTZteMQ+swib2Wjwr7
	D9dsl0b13nosuQREIiRZOh9WAqKqYAtEaxf93HYw7HgmLY0U8tFSRvOHnvpp+/7AnCmY/Ep/OWS
	bK9PAz6Gda8nmktJRZ22PqiCo/lJ7ZOfOlar/UdxgOX9zPLoiKL3NdfyN0MStFy2LKDJpzd1GsU
	W/Iul8N6DZKgWExKI39nXCD+Q8UC0s99KH2LKcbBTjMCaYbZl/3Xbv5CHCAmPdvgd7ZFdJrvBMY
	ZJz6ESusQ1IU87yJbl4yiFQ==
X-Google-Smtp-Source: AGHT+IFBNLoa1BBHg6PHmhCfIOsJf0knmpDONYUnnaDdcU3PfkWZsq79vjdgh5DKgImq2pj+maiSeA==
X-Received: by 2002:a17:903:3bad:b0:234:b743:c7a4 with SMTP id d9443c01a7336-242c22c3c1emr92676985ad.38.1754739893419;
        Sat, 09 Aug 2025 04:44:53 -0700 (PDT)
Received: from dixit ([2401:4900:1c45:5acf:241:d77b:f6c0:54f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm227668315ad.96.2025.08.09.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 04:44:53 -0700 (PDT)
Date: Sat, 9 Aug 2025 17:14:45 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aJc0rZmfc_zSzaG_@dixit>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
 <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
 <CAHp75VeKPr=3H_wOvcesqj4OsrqN7zwRFFk3ys3O012JpQtxrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeKPr=3H_wOvcesqj4OsrqN7zwRFFk3ys3O012JpQtxrQ@mail.gmail.com>

On Thu, Aug 07, 2025 at 10:57:16PM +0200, Andy Shevchenko wrote:
> On Thu, Aug 7, 2025 at 4:57 AM Dixit Parmar <dixitparmar19@gmail.com> wrote:
> >
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
> > While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> > But for bus configurations interrupt(INT) is not recommended, unless timing
> > constraints between I2C data transfers and interrupt pulses are monitored
> > and aligned.
> >
> > The Sensor's I2C register map and mode information is described in product
> > User Manual [1].
> 
> ...
> 
> > +       help
> > +         Say Y here to add support for the Infineon TLV493D-A1B6 Low-
> > +         Power 3D Megnetic Sensor.
> 
> Megnetic?
> 
> > +         This driver can also be compiled as a module.
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called tlv493d.
> 
> ...
> 
> > +#define TLV493D_RD_REG_BX      0x00
> > +#define TLV493D_RD_REG_BY      0x01
> > +#define TLV493D_RD_REG_BZ      0x02
> > +#define TLV493D_RD_REG_TEMP    0x03
> > +#define TLV493D_RD_REG_BX2     0x04
> > +#define TLV493D_RD_REG_BZ2     0x05
> > +#define TLV493D_RD_REG_TEMP2   0x06
> > +#define TLV493D_RD_REG_RES1    0x07
> > +#define TLV493D_RD_REG_RES2    0x08
> > +#define TLV493D_RD_REG_RES3    0x09
> > +#define TLV493D_RD_REG_MAX     0x0a
> 
> + blank line
> 
> > +#define TLV493D_WR_REG_RES     0x00
> 
> I would name it _RES0 in analogue with the _RES2 below.
>
We are not using these TLV493D_WR_REG_RES* registers anywhere,
so I shall drop TLV493D_WR_REG_RES2 too.
> > +#define TLV493D_WR_REG_MODE1   0x01
> > +#define TLV493D_WR_REG_RES2    0x02
> > +#define TLV493D_WR_REG_MODE2   0x03
> > +#define TLV493D_WR_REG_MAX     0x04
> 
> ...
> 
> > +enum tlv493d_channels {
> > +       TLV493D_AXIS_X = 0,
> 
> Why assignment? Is this HW defined value? Then you must assign all of
> them explicitly to make code robust to changes.
> 
> > +       TLV493D_AXIS_Y,
> > +       TLV493D_AXIS_Z,
> > +       TLV493D_TEMPERATURE
> > +};
> > +
> > +enum tlv493d_op_mode {
> > +       TLV493D_OP_MODE_POWERDOWN = 0,
> 
> Ditto.
> 
> > +       TLV493D_OP_MODE_FAST,
> > +       TLV493D_OP_MODE_LOWPOWER,
> > +       TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > +       TLV493D_OP_MODE_MASTERCONTROLLED
> > +};
> 
> ...
> 
> > +struct tlv493d_data {
> > +       struct device *dev;
> > +       struct i2c_client *client;
> 
> Why do you need both?
> 
> > +       /* protects from simultaneous sensor access and register readings */
> > +       struct mutex lock;
> > +       enum tlv493d_op_mode mode;
> 
> > +       u8 wr_regs[TLV493D_WR_REG_MAX];
> > +};
> 
> ...
> 
> > +       data->wr_regs[TLV493D_WR_REG_MODE1] |= mode1_cfg;
> > +       data->wr_regs[TLV493D_WR_REG_MODE2] |= mode2_cfg;
> 
> No mask for the existing values in the respective wr_regs? Wouldn't
> you need to use FIELD_MODIFY() instead?
> 
> ...
> 
> > +static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
> > +{
> > +       u16 val = 0;
> 
> I would move the default assignment to the 'default' case. This makes
> the intention clearer.
> 
> > +       switch (ch) {
> > +       case TLV493D_AXIS_X:
> > +               val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
> > +                       FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
> > +               break;
> > +       case TLV493D_AXIS_Y:
> > +               val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
> > +                       FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
> > +               break;
> > +       case TLV493D_AXIS_Z:
> > +               val = FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << 4 |
> > +                       FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]);
> > +               break;
> > +       case TLV493D_TEMPERATURE:
> > +               val = FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 |
> > +                       FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]);
> > +               break;
> > +       }
> > +
> > +       return sign_extend32(val, 11);
> > +}
> 
> ...
> 
> > +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
> > +                               s16 *z, s16 *t)
> > +{
> > +       u8 buff[7] = {};
> > +       int err, ret;
> > +       u32 sleep_us = tlv493d_sample_rate_us[data->mode];
> > +
> > +       guard(mutex)(&data->lock);
> 
> No include for this API.
> 
> > +       ret = pm_runtime_resume_and_get(data->dev);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /*
> > +        * Poll until data is valid,
> > +        * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
> > +        * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
> > +        */
> > +       ret = read_poll_timeout(i2c_master_recv, err, err ||
> > +                       FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
> > +                       sleep_us, (3 * sleep_us), false, data->client, buff,
> 
> Redundant parentheses.
> 
> > +                       ARRAY_SIZE(buff));
> 
> Missing include for this macro.
> 
> > +       if (ret) {
> > +               dev_err(data->dev, "i2c read poll timeout, error:%d\n", ret);
> > +               goto out;
> > +       }
> > +       if (err < 0) {
> > +               dev_err(data->dev, "i2c read data failed, error:%d\n", err);
> > +               ret = err;
> > +               goto out;
> > +       }
> > +
> > +       *x = tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
> > +       *y = tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
> > +       *z = tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
> > +       *t = tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
> > +
> > +out:
> 
> Labels are better made when they define what they are going to perform.
> 
> out_put_autosuspend:
> 
> > +       pm_runtime_put_autosuspend(data->dev);
> > +       return ret;
> > +}
> 
> ...
> 
> > +       ret = tlv493d_set_operating_mode(data, data->mode);
> > +       if (ret < 0) {
> 
> Is ' < 0' part required here?
> 
> > +               dev_err(data->dev, "failed to set operating mode\n");
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> 
> If not, these all lines can be transformed to just
> 
>   return ret;
> 
> > +}
> 
> ...
> 
> > +static irqreturn_t tlv493d_trigger_handler(int irq, void *ptr)
> > +{
> > +       struct iio_poll_func *pf = ptr;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct tlv493d_data *data = iio_priv(indio_dev);
> > +
> > +       struct {
> > +               s16 channels[3];
> > +               s16 temperature;
> > +               aligned_s64 timestamp;
> > +       } scan;
> 
> > +
> 
> No blank lines in the definition block.
> 
> > +       s16 x, y, z, t;
> > +       int ret;
> > +
> > +       ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> > +       if (ret) {
> > +               dev_err(data->dev, "failed to read sensor data\n");
> > +               goto trig_out;
> > +       }
> > +
> > +       scan.channels[0] = x;
> > +       scan.channels[1] = y;
> > +       scan.channels[2] = z;
> > +       scan.temperature = t;
> > +       iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > +                               pf->timestamp);
> > +trig_out:
> 
> Make sure you use a consistent pattern for labels.
> 
> out_trigger_notify:
> 
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +       data->dev = dev;
> > +       data->client = client;
> 
> Choose one of them, the other can be derived.
> 
> ...
> 
> > +               return dev_err_probe(dev, ret, "failed to initialize\n");
> 
> Missing include for this API.
> 
> ...
> 
> > +static const struct i2c_device_id tlv493d_id[] = {
> > +       { "tlv493d" },
> > +       { }
> > +};
> 
> > +static const struct of_device_id tlv493d_of_match[] = {
> > +       { .compatible = "infineon,tlv493d-a1b6", },
> 
> Inner comma is redundant.
> 
> > +       { }
> > +};
> 
> Missing include for both of the ID tables.
> 
> ...
> 
> > +static struct i2c_driver tlv493d_driver = {
> > +       .driver = {
> > +               .name = "tlv493d",
> > +               .of_match_table = tlv493d_of_match,
> 
> > +               .pm = pm_ptr(&tlv493d_pm_ops),
> 
> Missing include for this macro I believe.
> 
> > +       },
> > +       .probe = tlv493d_probe,
> > +       .id_table = tlv493d_id,
> > +};
> 
> > +
> 
> Remove this blank line.
> 
> > +module_i2c_driver(tlv493d_driver);
> 
> -- 
> With Best Regards,
> Andy Shevchenko

