Return-Path: <linux-iio+bounces-14368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B2EA115AE
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 00:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1ED9169315
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 23:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCCB219E82;
	Tue, 14 Jan 2025 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duLkcxWU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FE20F97C;
	Tue, 14 Jan 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898827; cv=none; b=koLks4uo6Jyho9REudEDwkNIDaDM3RsPoGALanBDIjWh1Hi32V4nghKtv5NC9Lrc8cng9KLTaD1lMCtsbij+xQdj9uu1Iz6ex/tWWLa6ctpRGkF08pmE5WrM/RjEP3MbtCdFlPmP40Qq2jxQquTQEnRI9NHEnrMsnSdeusINDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898827; c=relaxed/simple;
	bh=iCR9tvj2qCQpmxtu9D+eylj+YRdym4FTRtJ+GDf1Kcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeb37maIE4d8hQjwq81lRPg3y1O+5YxINZyH1PiAKkLdmDdptoixxaM9YCEgZ6cvCFoICCbryPGPLZvh3AIZPDOt9UxL8f6HUEcYi60raijGEf6IkRfLHeKwGL8GcCOxoPUmYDmDx1o5zxS7hp9MGQKjr2wOiK1AYTxQppWip5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duLkcxWU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so3813440a12.3;
        Tue, 14 Jan 2025 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736898824; x=1737503624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMzb8yS5h3F6arrsufJifvjJGelvMlFg50S2OirVRuA=;
        b=duLkcxWUzDJGltZdOsjtwmctBHcw9M8IRXgSbWIVIpAaxjSIvMaTB/oNPVaKOMsEHT
         5wd2hWjadVpgtyD2IjgxItyjYbzsyArqjrAJyNmKO+1eARGgIAuxBsdWwPVkgufXShBF
         4ujv3mEqrhSprWS9BZ0S5LnkmH8OQxk6hMftDxux4wW4nGKQPY2UrmzWdIlcV0r2XjRA
         jHdk5bii+NXXAVlAzxQrvyBU1/+JISdwCUj3fj9LVOhz5HhAnzAeHf4pTwp45HHBcaCe
         V1JwpiF8xHlAqROrVkFMeLrP/U+iqOsUkiDow364n93zi82CTZMNo+jNa2ZjLqcBg8R9
         UL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898824; x=1737503624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMzb8yS5h3F6arrsufJifvjJGelvMlFg50S2OirVRuA=;
        b=LL2JoRY1DiPH0J4RKnr5Zx5Hbtv5NFUTBWI+NhpHRorhFwL95nXXT1JUiPpIC0g3Mt
         Fmi9ON3Ol4aWdsn8rNN4Vlgp02nDUJXW31qEJhi1vVQ2qD8R1f0nSH0h/isLaE6DtOEY
         f+n5Fqukts9/Ypx7lmnNbV16pkXfAIYm9i/gqwZs238QwNd4son+OsZVqjYMGmiO2ftl
         VOSU199qkB+WH2JQypIAfF3rAJX3/aTflDQ/ok6S4nM0YXqX+BYKmKLAsEeW5+BHmsnQ
         CxD6xXPoPZP41KdAfBsVx94XVx1PGa32TkuVyCs3eE3aqBqEGEi48eEBzR6QfD3aXsAi
         27IA==
X-Forwarded-Encrypted: i=1; AJvYcCU0uxR9O3XUp4MdoI90YibRsnz3fBaibn6K4ACMTSn+SKPfsN7c42hJn53mJZH+GEDN3E0koimytCdE0p5G@vger.kernel.org, AJvYcCWHps3TtH6UDUzVWzyJeiNDLSdFG3XFcvxhPIpduj0Nb8pHBaVafjByP/ISm/iqVDSK+cNT76rpVIkS@vger.kernel.org, AJvYcCWj4xcWivvxOazT8NGVZBte5JlaihYhYQIhUp6+ELxt4VxVKkFNO0Zz/gifk7d9oJBvQflYZCTphfwG@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeoYl49itrWi7XpDBLDiX6BaC1Xk6m1lcAF/VH0XUzqEUi4HV
	Q3zqHOcSwDqgKORfAvFIB4slEmX1kMbkMKGVKLQTsx+n7JzGfc7PBbvxmEbi
X-Gm-Gg: ASbGncvZfHrFg5Uch+L3zuq6TKCvjes4KsgmEwwBWRUC028RAwQXHH1FFZgcz/cEYh4
	RI3YMnqgw6plKmHmIL3t2r+CVblctBcSAKzIr1B1hydnXVmpn57oFta3As4QmWksnbp6W0c5gda
	weZmlc8nrl9jdWEr8x8jWHt1rJIZcVmg8/5qHrxPTP90UbYnotrjVqfXB5lBnwgFVuvzUdFG3ii
	m+WKK+03WeR8ICIA+fWJxO405LuNT8fuIlvbNh6Y8/MgSOu3B2QgltzFpLXJ3Bgr4P9uZcnDLNl
	NoM5RqKI3BzUOunpNAEyWCea
X-Google-Smtp-Source: AGHT+IHMWQihEHrG1M2HrKWrQcstVSYgtm39lT5eq1twiFCL6hBZtE5GJLnwGhMwbTzEaGEv8lXyfw==
X-Received: by 2002:a17:907:9687:b0:aa6:912f:7ec1 with SMTP id a640c23a62f3a-ab2abc779dcmr2778139666b.39.1736898823271;
        Tue, 14 Jan 2025 15:53:43 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([37.162.56.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95624e8sm681193766b.127.2025.01.14.15.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:53:42 -0800 (PST)
Date: Wed, 15 Jan 2025 00:53:23 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <20250114235323.3xkktco7fsb6pmzk@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250112104453.45673-1-apokusinski01@gmail.com>
 <20250112104453.45673-3-apokusinski01@gmail.com>
 <CAHp75VedQvf2xwY3fDWX=FQaHyhaUSVJW3Y6Yt2ecpwru756vw@mail.gmail.com>
 <20250113221905.ruv3w3k4w53hvf2b@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
 <CAHp75Vf-zdsh6CP3XX6jyjVutch9Z_iH78zrpaFkt9WkP=qz4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf-zdsh6CP3XX6jyjVutch9Z_iH78zrpaFkt9WkP=qz4w@mail.gmail.com>

On Tue, Jan 14, 2025 at 11:43:11AM +0200, Andy Shevchenko wrote:
> On Tue, Jan 14, 2025 at 12:19 AM Antoni Pokusinski
> <apokusinski01@gmail.com> wrote:
> 
> > Thanks for the review. I'm currently implementing some changes in the
> > driver according to the review, however I have some doubts regarding
> > removal of the `i2c_client` from `si7210_data`.
> 
> ...
> 
> > > > +struct si7210_data {
> > > > +       struct i2c_client *client;
> > >
> > > Do we really need a room for that? Isn't it derivable from the below
> > > regmap? Also note the frequency of use of client vs. regmap. The
> > > result in the object file can be much better if regmap becomes the
> > > first member here. Check it (with bloat-o-meter, for example).
> > >
> >
> > I used arm-linux-nm and the bloat-o-meter to compare the sizes and it
> > turned out that the version which contains the `i2c_client` has
> > slightly smaller size actually. Here are the results:
> >
> > $ ./scripts/bloat-o-meter -p arm-linux-  ./old_si7210.ko  ./new_si7210.ko
> > add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
> > Function                                     old     new   delta
> > si7210_probe                                 556     560      +4
> > Total: Before=4021, After=4025, chg +0.10%
> >
> > Here is the diff (shortened for better readability) between
> > the old_si7210.ko (uses `si7210_data->i2c_client`) and
> > new_si7210.ko (does not use `si7210_data->i2c_client`):
> >
> >  struct si7210_data {
> > -       struct i2c_client *client;
> >         struct regmap *regmap;
> > ...
> >  static int si7210_device_wake(struct si7210_data *data)
> >  {
> > +       struct device *dev = regmap_get_device(data->regmap);
> >         int ret;
> >
> > -       ret = i2c_smbus_read_byte(data->client);
> > +       ret = i2c_smbus_read_byte(to_i2c_client(dev));
> > ...
> > static int si7210_probe(struct i2c_client *client)
> >         data = iio_priv(indio_dev);
> > -       data->client = client;
> >
> > Hence, I guess that it's actually better to leave the `i2c_client` as it is.
> 
> I don't think you have tested all that I was talking about, i.e. have
> you tried to swap the positions of client and regmap? What I expect is
> that when you swap them you will see a good size reduction due to
> pointer arithmetics becoming no-op for the regmap pointer. And then
> the dropping of the client might waste all that beneficial size.
> 

Ok, so I've tried to swap the `i2c_client` and `regmap` pointers and...
there was no change shown by the bloat-o-meter. The only improvement was
that the new object file (that is after moving the `regmap` to the
beginning of the struct) was 8 bytes smaller in file size.

Out of curiosity I've also tried moving
the `regmap` further away in the structure (e.g. I placed it after the
regulator and mutex) but there was still no change. I am a bit confused,
since this behavior is different from what you described that it should
be.

> > > > +       struct regmap *regmap;
> > > > +       struct regulator *vdd;
> > > > +       struct mutex fetch_lock; /* lock for a single measurement fetch */
> > > > +       s8 temp_offset;
> > > > +       s8 temp_gain;
> > > > +       s8 scale_20_a[A_REGS_COUNT];
> > > > +       s8 scale_200_a[A_REGS_COUNT];
> > > > +       u8 curr_scale;
> > > > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Kinds regards,
Antoni

