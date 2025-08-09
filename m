Return-Path: <linux-iio+bounces-22488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A33FB1F461
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5E46252A8
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659E27F00A;
	Sat,  9 Aug 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd5HJpiU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1027C864;
	Sat,  9 Aug 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754738945; cv=none; b=eCgJZVz6AHdtOr2nyrxSgTOuddAVTdqEP9y8p6FcpRPGGAjHNVA9V1BtCfHZeK2AwICrnni+1DiqsKA/YmSOB6fSkx26hm836oX3Ngwsei+SMjg3CKx/euKjup7bQO7A/5DxsycS3MfxI+3nq6zXLgksL9U6YZPsHJmayvY1vjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754738945; c=relaxed/simple;
	bh=AfFLWgoIvA4IGFwAe0geKaCh77ntPaCbb8ATrEfr9bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Yxd0rxLJZ1O1NQRWVzbApI/gIfx+xMu1pMWTB8VsitXYChyokAVt8NEl+K8pjXapxf5krznATjS2iNWi+2KsBm5+Bmhb0rqGZ81k+rZ1uPpUYr79kUV1Co34gx3JHL5QMKO/jDXw1x4kTOnk6CsfV/ITo4HLzFsWmB27zvhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd5HJpiU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3861576b3a.2;
        Sat, 09 Aug 2025 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754738943; x=1755343743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3jDSSsJNCbaqA/Grzma8s/dztuniQeQowWM9jbonBk=;
        b=bd5HJpiU9RTNesWbhem6dhRKMxAw6SBwWBHyPHkMTyn1Zun8+7yRTtLQYIoZ106UDM
         UTSd10THkCzy7sPkdexzEnNHrqELdx3t4j6NdVCRE6NyX9RgPj+qaPpB6eMq/4aHB+OC
         JnaZfcUvvekjS9GQL9ref4/Azvp5lBe2yU5NGcZLThxwP+Ht3c/5pQ/1rjzpmvGOznJ5
         Q88jPmChHw7lRLRDEdimOXxlAbc4TXM3NNS3sSFzKzMC2T/3+jKqSxaTYm+L/CwFoVSP
         rpi9lnRqhIxe8HQ7lCe1w5wGZbHDuikpYMzYNUhVEUHxjAJKxsQHzw8vZaP0Q/iJfbPZ
         4kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754738943; x=1755343743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3jDSSsJNCbaqA/Grzma8s/dztuniQeQowWM9jbonBk=;
        b=afGkE6Dd0YE0vE1pthGZ62jDORwaSYclRnPTrkoCK3d0RRjMnvFWluWXh+0iEmDHkR
         VJ0dI6k0mUVho5sKCw+oPoxdSlYT6lb6ItjA4GXN3tXb3zLazMkFoMfMsK2+PgBabvup
         OzamoyoNyiToKKudEeroe1ZhA3Zfc2HoHr0QOVazFqh38sr9VsbhXa55WwGVthhDtH//
         qwV1iOaF3vImqhwTOgXS+7S8ohRO7YDNFp0CqZFkgs2hM7Bj+Jlu9QyfTMKzUfsqbf13
         CxqiH5VJ2HUn8nPQSdVSa/sotR0ruFYsbpgzo2EaqCRgGgH5e5q4u11Y+ewVtwcbn+2V
         OoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKn4KpRn1ZKgyIXutMepD54V7oikNsFGptui3SbgaXSrnAwIiwvjK2cYTbkiYZYPoADXLvZe3xkGVM@vger.kernel.org, AJvYcCX7QhbjUT9JfvsmuoPQlT1avoKpYXHbAfrWJDRjpGmZ2ICfpR8vH7+UXHdxBCR4pCgwrr4sMHiLl/6tMUZ8@vger.kernel.org, AJvYcCXZsSi95hpDWGarZZwBWmLZyI0ePo2B16NfWsRmDIgyDcaWj3Ndl8LWjZzcwsXBGxAIZwbWfUegnDoa@vger.kernel.org
X-Gm-Message-State: AOJu0YyIq4oqOxU4ke/jQKNiYQ6MZDuvHf+gexbM/vJytju0LdaLFcPA
	y5onL+0EV7+etDxq7PfNAdcrlmxbHYZXgf2+lIjxprhOfqo6IwSClahZ
X-Gm-Gg: ASbGncsrTsf1W4yQCFE/fgGv/2T8meX9L5//vp4Ba0XAcsG7gesgTPGywZlJJKTKwtM
	ldyKvL9ylM5hWDnKzgTw6yXScqHs8npvkWLtxIbDJdiUlrw3bapxklvx67gvZXPuh2UL7ctB75n
	YsVllkVCKPaTq4pbivATBIgAcigu8/NK0fTkANGloiqk97ztMmY7Q98kf6Y+OESn07j10jwoPGa
	7PYl1Ps9eyfd1q1RLQTbMmYibonSCN4tWyY34/N+PP00DJsD4bNyMPtxvU6FdISPCkYZDKJzOHN
	oXAV+QSc8sCemxVYO610PeEELGJhdlYskG64n4ZrdNbPPif80ovKD7BjT+/cIBFuQoDN8OtAfUc
	nFqp4x3ypfOayJmeRTxmJLQ==
X-Google-Smtp-Source: AGHT+IGLhk53gdI3ahnykqnR/EMkkHKH72AEKv7zh101b/xTnzkApCLMrO71maSxXuIeMiaaStb6yw==
X-Received: by 2002:a05:6a20:914d:b0:240:21e1:cb9b with SMTP id adf61e73a8af0-24055067f3amr10996884637.14.1754738943298;
        Sat, 09 Aug 2025 04:29:03 -0700 (PDT)
Received: from dixit ([2401:4900:1c45:5acf:241:d77b:f6c0:54f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce89132sm22520715b3a.29.2025.08.09.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 04:29:02 -0700 (PDT)
Date: Sat, 9 Aug 2025 16:58:50 +0530
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
Message-ID: <aJcw8icGvsDzFGpJ@dixit>
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
> 
> > +enum tlv493d_channels {
> > +       TLV493D_AXIS_X = 0,
> 
> Why assignment? Is this HW defined value? Then you must assign all of
> them explicitly to make code robust to changes.
>
No, this is not HW defined value, these are used for iio channel and
some internall indexing. Most of the driver I referred had this enum
having assigned to 0 which i think gives clear intention and better
understanding. either I can keep as it is assuming its good for
readabilty or keep it unassigned. What do you suggest?
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
Same as above. Just different usecase as this is driver specific enums.
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
Indeed, I should drop struct device *dev member.
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
I believe, we are doing OR op with the value created using FIELD_PREP,
so it should not interefere with the existing non-masked values.
However, as FIELD_MODIFY is there, I should utilize it.
> ...
> 
> > +static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
> > +{
> > +       u16 val = 0;
> 
> I would move the default assignment to the 'default' case. This makes
> the intention clearer.
> 
As per the suggestion on privious version of the patch, we are having
ch datatype as enum and as suggested, with enum as swicth-case, it
should not have default case. so I think this initialisation to 0 at the
beginning should be fine.
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
General question for all the include related suggestions, all the
required headers are being included by one of the included header(i2c.h,
iio.h etc), in such case, is it necessary to have specific include for
given API mentioned in source file? Will it not make it more clumsy
in terms of repeatative header includes? I understand having all the
includes mentioned in given source file makes it clear to understand the
dependency the driver is having. Just want to undertand it bit more as
learning.
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
For (3 * sleep_us)?
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
Does it mean it should have whatever is being skipped in the flow?
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
Yes, return 0 and the check for ret has been kept as per the previous
review suggestion. The return value from the tlv493d_set_operating_mode
is returned from i2c_master_send() via few function inbetween and its result
has to be conveyed to the caller API as we are in initialization phase.
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
ACK.
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
The ID tables are defined mod_devicetable.h in which intern gets
included in i2c.h and i2c.h is already included in this driver file,
should I explicitely include mod_devicetable.h here?
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
No I guess. DEFINE_RUNTIME_DEV_PM_OPS is part of pm_runtime.h and its
already included.
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

Thank you for careful review,
Dixit

