Return-Path: <linux-iio+bounces-14343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB7BA10335
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1817169A2D
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1722DC48;
	Tue, 14 Jan 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f20ITt3c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C1230D0F;
	Tue, 14 Jan 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847831; cv=none; b=mbAGxYbs646A8IZeDcmhkXQju6xyBQEsPU59TLlzqmOSu8Vuarkqi/SqGo4r35OavHkP+4I677BIJF7GXPBWBlfABzCd4x0CNzGk1ZpUisPExRvrHFCZkIf2fFj/V97hQlS9252zloxN2soBjsh0ywSQcJz4h8yaTI4I6ZdLjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847831; c=relaxed/simple;
	bh=gz3j4LSQUGTBc6G+JzcwXpBUEdENWWL1Z9KVZpZq88Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbnnctmwWkAz+aNmYk+zxb1ddJ1CzBUROvYrqCDNdCKJj+SgQ49l2Pj3ISyuzIrK+N77gPkB2SYZ3HYPKCIhTwmaKfEr81O3PY1zBCEs5UFQXIBG8snYF96wkEBdoMwe3IU3nYUwfqBEeIOz1/lvY+kVzfBx6G5/hvGafd5oE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f20ITt3c; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6a92f863cso992086266b.1;
        Tue, 14 Jan 2025 01:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736847828; x=1737452628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4ddnLC7R3AnxKxF1WharRszc6HLAQzXaIR1Cc3GioU=;
        b=f20ITt3czn03J3c3NNzCNl9o/dq38MjDvOhWwW09HSEVRAbpqR7Tb776YEPB3EH5+L
         EUianDcseHnBnJK8xRC0iqmAmei/rLoVH4x/aRavy2AtAzazdWs1CKNHCuLwuqkm039y
         irwWLvBhI09/TgP68VMN4uZ6gNf3ldBIW7zn2L5zmVpFBuu7ibmNnjCeG7KAePRwx0Vm
         Y4E+bl4/6iZ3L+g8w8SCP6IUwMBeNXJ7B9iWLUB/Kpy3tI5HIJM5dPc3PsaOYrMX2fPx
         UuF79bQbBQx+JDMa9e5HAkJEEAx75jLZJsHDX6tASfIdxanIQ/HHFfs6IlNgqlOnjj/y
         K6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847828; x=1737452628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4ddnLC7R3AnxKxF1WharRszc6HLAQzXaIR1Cc3GioU=;
        b=PK3RGQZJ8SBe1eR9j+98b/TjsnKaf8BIIgOWLF+XEpADP+56JmF/kCn2qJlVgXFSyi
         ydQX+Cpssxyf7dsKIeTqBesHSsfQ0H58uKI925nuXqQWQBrBhe5iKLhBlzFZmSyJ1qkW
         FYyLrizTcNs7HSbgiJF9vJtpBe58XufgXJY7DubNB9yaWhu9O9+4CpnX7Por+f63umQH
         t4zZu2kvJnfKxFo8pC3YQmS12LO5eUF+/Y2j9HmtFrbdF5aPx5A18ttOby2k1EvVFOLB
         Fceff1jpn+Gkqo8/wCiWDOvYi3wb6wJPEjQNBcRKXUMGVjT1VN79ToHjw+Y4nb2Zw2XV
         BTKg==
X-Forwarded-Encrypted: i=1; AJvYcCVW61e3uCV40wnF3DUg8s8d4lhTVPjLm29P26qhQtFQUSVYLKU9YRB+D8zbqVzfpq540PZAcXtO/gU8@vger.kernel.org, AJvYcCW4LhD89xVH96iCH7L7Jm3kJspNkX6SLXHan0kj4ISPSsR2OEAiN3N57YySn0ZI81O50qwIkUMLC6BAEyhH@vger.kernel.org, AJvYcCXaR+5qnshMTT0NTYDCUSXTVB2pI3RT2CrFoKBz3Hfo2C9dju0V8OVDfGs8uiQAAwdibqeWptVcbGNk@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbzNoLyR9vahgfO88fVRdd1evWjPLTQSsohxfhXDsk9geseOR
	tcl/LedxLMmTTY1EQdTp83gqTYyayRRdr+GMkgbAzkSt8wkAtjICHp9rgmXmTyyGpn3uQfXuQZE
	ulZtfr2tzArqwp/TqkUt8Wx/p/rc=
X-Gm-Gg: ASbGncvXGBNu4KFhdcjS4IqkEyXcvhP+s//rP2ZpXrFwic7krjtqvwSKotNYqZPKB02
	Z3+BP0fOa/rqZ6iZv4ZTaTivTB9pPh/CMR5p5gA==
X-Google-Smtp-Source: AGHT+IEjLsKdifmYxBceuBRUhzQSXsIHy21C5OvzReHgRJldHJBOhkxV4ELNS+tp01DLClQuYww4PkHy2frF4iL/tJE=
X-Received: by 2002:a17:907:7e91:b0:ab3:f88:b54e with SMTP id
 a640c23a62f3a-ab30f88b5d5mr716496966b.31.1736847828120; Tue, 14 Jan 2025
 01:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112104453.45673-1-apokusinski01@gmail.com>
 <20250112104453.45673-3-apokusinski01@gmail.com> <CAHp75VedQvf2xwY3fDWX=FQaHyhaUSVJW3Y6Yt2ecpwru756vw@mail.gmail.com>
 <20250113221905.ruv3w3k4w53hvf2b@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
In-Reply-To: <20250113221905.ruv3w3k4w53hvf2b@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 14 Jan 2025 11:43:11 +0200
X-Gm-Features: AbW1kvbQwRaXNMYtgKB2WXq76hJsvg9oad8fE5WUUR3ShP5wYYrP-gLDDL8Wva4
Message-ID: <CAHp75Vf-zdsh6CP3XX6jyjVutch9Z_iH78zrpaFkt9WkP=qz4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: magnetometer: si7210: add driver for Si7210
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org, 
	icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:19=E2=80=AFAM Antoni Pokusinski
<apokusinski01@gmail.com> wrote:

> Thanks for the review. I'm currently implementing some changes in the
> driver according to the review, however I have some doubts regarding
> removal of the `i2c_client` from `si7210_data`.

...

> > > +struct si7210_data {
> > > +       struct i2c_client *client;
> >
> > Do we really need a room for that? Isn't it derivable from the below
> > regmap? Also note the frequency of use of client vs. regmap. The
> > result in the object file can be much better if regmap becomes the
> > first member here. Check it (with bloat-o-meter, for example).
> >
>
> I used arm-linux-nm and the bloat-o-meter to compare the sizes and it
> turned out that the version which contains the `i2c_client` has
> slightly smaller size actually. Here are the results:
>
> $ ./scripts/bloat-o-meter -p arm-linux-  ./old_si7210.ko  ./new_si7210.ko
> add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
> Function                                     old     new   delta
> si7210_probe                                 556     560      +4
> Total: Before=3D4021, After=3D4025, chg +0.10%
>
> Here is the diff (shortened for better readability) between
> the old_si7210.ko (uses `si7210_data->i2c_client`) and
> new_si7210.ko (does not use `si7210_data->i2c_client`):
>
>  struct si7210_data {
> -       struct i2c_client *client;
>         struct regmap *regmap;
> ...
>  static int si7210_device_wake(struct si7210_data *data)
>  {
> +       struct device *dev =3D regmap_get_device(data->regmap);
>         int ret;
>
> -       ret =3D i2c_smbus_read_byte(data->client);
> +       ret =3D i2c_smbus_read_byte(to_i2c_client(dev));
> ...
> static int si7210_probe(struct i2c_client *client)
>         data =3D iio_priv(indio_dev);
> -       data->client =3D client;
>
> Hence, I guess that it's actually better to leave the `i2c_client` as it =
is.

I don't think you have tested all that I was talking about, i.e. have
you tried to swap the positions of client and regmap? What I expect is
that when you swap them you will see a good size reduction due to
pointer arithmetics becoming no-op for the regmap pointer. And then
the dropping of the client might waste all that beneficial size.

> > > +       struct regmap *regmap;
> > > +       struct regulator *vdd;
> > > +       struct mutex fetch_lock; /* lock for a single measurement fet=
ch */
> > > +       s8 temp_offset;
> > > +       s8 temp_gain;
> > > +       s8 scale_20_a[A_REGS_COUNT];
> > > +       s8 scale_200_a[A_REGS_COUNT];
> > > +       u8 curr_scale;
> > > +};

--=20
With Best Regards,
Andy Shevchenko

