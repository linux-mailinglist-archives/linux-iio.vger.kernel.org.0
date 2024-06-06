Return-Path: <linux-iio+bounces-5890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE558FE292
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048D91C24EF6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2DC13FD93;
	Thu,  6 Jun 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfpZeOT2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B513E8B8
	for <linux-iio@vger.kernel.org>; Thu,  6 Jun 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665869; cv=none; b=bCVGjp2JZyEQFD3KewEkKz6eIyhCaUXhDjG5gxyP6BVLAoh2bcN+9ue6aBah5bHgknSUVuTSG9lYI8G8wjbn9ki6mxf8Aaz6n91dEbuq/5EQwIR2u4vfLluZoltDO5KBqi/fzhl/6xkrCSPK25UpTh1TU9/uv11uGp92PS6AWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665869; c=relaxed/simple;
	bh=udXsNUhcnZ8ynFTNJ+VRVp6bj42T4g0XRqCcuRb5JXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2XRT2PfoO8KJsh2VWVzPQIjtUTxynFwtkA0cJ0OcpyKitP0xz4hHwZ/o4lOiM/unCOKof+girYoqdgHmztkCHQDRoB0EFMKQ8douGJF0JGzsA5WaJWowSRWMIv+kr7fB0N4vyErv55LX3LS7pEVRQ21VjSiT0xFYCjHat9sYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfpZeOT2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c29c487a94so397252a91.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Jun 2024 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717665866; x=1718270666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCgaL8o9gTqW3R6MkCs66+V6tGdqOhyMZityYxhrOKQ=;
        b=bfpZeOT2jsOO3ulGbxN5iU0WItcvHCC1Wn7N83jkTs0cI1lpe4yhWJzD2ssYEWJzi/
         0YT3EFkkfrqqgxKblh7U5CZMVkJZ+5Cc0DZm6fknSk8jtMGrOHNev83QLjft35fAeS7Z
         +WoslQTEVfQjvkQfwTc/PAawt3wWIWWNpdvOJt39kWGIp8LIqZVhnbc7e+IvYr3WvkHr
         lJ04buV0AbIEChXCvX/ISxcxdJftTVwtW0U2oFExRP3I7hgur46QN6MFnlWknLp0yr3V
         bWSgELUA3qy6CgcJ/UNDTB9R4rnyz8rrLDXZ7FLpfburz71zBFqV20TZEWSqvJ1Mq/EL
         9THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665866; x=1718270666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCgaL8o9gTqW3R6MkCs66+V6tGdqOhyMZityYxhrOKQ=;
        b=IeZLCdrDaEZQKW8u0R4h7v7ZZVscBqpcS6Qpdsqq5Sc/Ht1RcKU6RbM0n5pe9NQR+9
         eQcbs9w9YCDgc4nsi8lJuROheOzwRoQ/oC7TnBuYFAgX8SStt7RUYz4YePxLouJE/y7D
         BD6mHZHc9LHypRD8RSVHDIsWj79RzCGYQBIy0L4S3YdrvajJdGLah+d+LRxCTzMG4unY
         hssSOVxk4wFuSA8ogiOpYWbEdwK8vFKFfEB8KPBmIRBiWT6LUUIx8Vzku4e4A3KnyOh3
         R46HjrXZJCOypAAcZiCOCkarOnFObs2HhEXcIzPH+wWRaIHobo/vSvU1L+hxCSP6Kw5D
         EUQg==
X-Forwarded-Encrypted: i=1; AJvYcCWese6gzBmHG5qeIL7KSKsIXbphL5ywsfmHj5BuFMPZbIVuAGg8Co0UkeBZugU883wnURn0BWq3HXib4n5tvQ4CivAQEPBDJbb+
X-Gm-Message-State: AOJu0YzAdb72+XSrdNykHDlMUG6y30BPIihP+dbjRjj9hXvwiBT06SSh
	VurHAyLhhgLxxDdubjqQYTsZ/8lXCOzyZPr5gavxcqeS3ElV6/tUQZfCuDx2FZf5iMaFrMVrfGw
	1XBkNntUpR8z/ArwvOdkU3py73N/k0zlnKqFO
X-Google-Smtp-Source: AGHT+IFO27fLQ60otnz+VPqegLb1l+ah/BSl+EBtF4Q1892OcY0hAdcmXoAoiATlOwzJL3jUrPraipj4bPnP8gdWMEU=
X-Received: by 2002:a17:90b:4ad0:b0:2c1:ad46:7133 with SMTP id
 98e67ed59e1d1-2c27dafd1d8mr5026032a91.8.1717665865426; Thu, 06 Jun 2024
 02:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605175953.2613260-1-joychakr@google.com> <20240605175953.2613260-6-joychakr@google.com>
 <20a9ea0b-74d0-47b2-8dc0-2b5e7d070d38@roeck-us.net>
In-Reply-To: <20a9ea0b-74d0-47b2-8dc0-2b5e7d070d38@roeck-us.net>
From: Joy Chakraborty <joychakr@google.com>
Date: Thu, 6 Jun 2024 14:54:09 +0530
Message-ID: <CAOSNQF3Kes3MHWf3FMCCfNOCvymSZV8RS+UMM_oKjhBQzQz8Bg@mail.gmail.com>
Subject: Re: [PATCH v1 05/17] misc: ds1682: Change nvmem reg_read/write return type
To: Guenter Roeck <linux@roeck-us.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:48=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 6/5/24 10:59, Joy Chakraborty wrote:
> > Change nvmem read/write function definition return type to ssize_t.
> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >   drivers/misc/ds1682.c | 16 ++++++----------
> >   1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
> > index 5f8dcd0e3848..953341666ddb 100644
> > --- a/drivers/misc/ds1682.c
> > +++ b/drivers/misc/ds1682.c
> > @@ -198,26 +198,22 @@ static const struct bin_attribute ds1682_eeprom_a=
ttr =3D {
> >       .write =3D ds1682_eeprom_write,
> >   };
> >
> > -static int ds1682_nvmem_read(void *priv, unsigned int offset, void *va=
l,
> > -                          size_t bytes)
> > +static ssize_t ds1682_nvmem_read(void *priv, unsigned int offset, void=
 *val,
> > +                              size_t bytes)
> >   {
> >       struct i2c_client *client =3D priv;
> > -     int ret;
> >
> > -     ret =3D i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM +=
 offset,
> > +     return i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + =
offset,
> >                                           bytes, val);
> > -     return ret < 0 ? ret : 0;
> >   }
> >
> > -static int ds1682_nvmem_write(void *priv, unsigned int offset, void *v=
al,
> > -                           size_t bytes)
> > +static ssize_t ds1682_nvmem_write(void *priv, unsigned int offset, voi=
d *val,
> > +                               size_t bytes)
> >   {
> >       struct i2c_client *client =3D priv;
> > -     int ret;
> >
> > -     ret =3D i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM =
+ offset,
> > +     return i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM +=
 offset,
> >                                            bytes, val);
>
> i2c_smbus_write_i2c_block_data() does not return the number of bytes writ=
ten.
> It returns either 0 or an error code.
>
Ack, I see only i2c_smbus_read_i2c_block_data()  returns the number of
bytes read . Will fix it next revision.

> Guenter
>

