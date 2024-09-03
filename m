Return-Path: <linux-iio+bounces-9070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313D969A53
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 12:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0079C283419
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873C1B984C;
	Tue,  3 Sep 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrSj1uWD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E4186E32;
	Tue,  3 Sep 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359929; cv=none; b=nRBx08dgKjUr6DzSw3cgZ9Pf05HsRZ0A3aV1kKEodjzZT59jSJ3TmvaqI3BMYXvrLags9HqzUL/felZ4IBpV+cHf/yMkp/6zUkHftGszg/4nruPggHYCw5vxjaI7HOKRyJGH3sJnojq5L7qtFptOuxyLUJFszKo2zu1eOizlclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359929; c=relaxed/simple;
	bh=wvA9i9r0eygvN94AksUDSYcqlnspxNFsQbrkoBT91ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8sd1GQ5S34EMIRVrjPaL01w0PtfRh4ZJmlF2izMnenWWJYD03LSGJJzZ1KiyxQllRwzWu3xBDfMsDwSPVG+So1xD+N+I2Ee7xKQAKBgxzVvK9Qz5mmRECjAoWYUjwSCaKJ9cKwmXZWV3g564NuSOlPk6jsYbGqbop7DGBKmm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrSj1uWD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533461323cdso6485767e87.2;
        Tue, 03 Sep 2024 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725359926; x=1725964726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1de35yFdiBfb8tHz3t4HwBE+WaobasAkciBBcp/z9F0=;
        b=XrSj1uWDGojjAsGobOLNy2KM0yeCOwZBmirXtQKRl1xiqpnGshOhEQKMA8zB/kXBMm
         KUHgYLNu8Ecjb24EcIkfsNdQZLs30CFk3RQA6mVu9hwXfXPUIMgPYGPeMMHXwlSOiQA7
         z7gQBaWnHaWfMhQpV/dCSf0E45XpIGS7kONBDm6MA1d2hAstgmZ5QYfcj+gMpVFQkM4k
         lBw5sW+LINkx+T98SVyaFY5BpmEV/mM4gGxqqUEl2P6tzfN51xXQM1Z2g7FoIHsrY2YJ
         LHC1F9KxPRHEvOFr9v6IM+18NZq31iq2W5punNUsI8nLcEkAw/bers4m+7S19FHezR+u
         lcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359926; x=1725964726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1de35yFdiBfb8tHz3t4HwBE+WaobasAkciBBcp/z9F0=;
        b=nsI7RLWMtZutcdiuZV4AjGjTmWLHAgOwkmcVVjwQLAvhX9ZfGsfE8Kbb3/yc+gqO2W
         578WK8aDwKJasIDxDXY9GHcXQ8z+4suGUqeGKrNeev/jETvXB1uEFkA/mEtxiuEMunLi
         kSTXPkwo4C3dLg9dtjEYxt2oDZFABwXKmH33Aht59mq8BqYijdyEROTYTNcezCFsR0nR
         DG7dhGxG/b0mb89F0HGqKkmPmbKq++T1DGMFbX/afDJWvbZOJ1Kxd2N0QoLypGHORCrU
         I1WIniOSO92ElmZDrgDW4tYy+SR4Axn5rhQArqJmKNEA3qDlWPFRoMevXSo6UgpyJb8y
         DWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8KIrMjG7OLywrcHXg6WdO5/awBXQb8wZ/uJyEGymsXy8b97VQtjDTlqKot4Gjxw2sQzTPOM6dnw7JpvU=@vger.kernel.org, AJvYcCUylM5NJc4tZgtod8LWxHaKmKr1mO9sVxJMHBuABDn4HLN/kLpXtho4y+97llssU6h2YHAKKHsOzu4BILms@vger.kernel.org, AJvYcCXJNyAGPYr4z+zvalnF/tBWXCyEiD1uZ9e15HYYmcGF/lPRIRxfziR8ohuOCiJMF6Rnxvrm1A2r5LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1BvQYgp3XYMIagdjanjMZX0xA1KUieDdnFPZtaLkroeF/zKK
	o6s7jpkS3i+F5izA79oP4+siDTae07nfHU9L4Cn2LOyiLOYfj4sjyqH8f0SVwF9+c4SWj2LdkU4
	lqyFhhlvSS89dPHjd6wO/dO46cTQ=
X-Google-Smtp-Source: AGHT+IEgMpXH7/qvhGdANhQYiJIhOuy2BnVDH4KXyoaAxxA6SOzIHAm6nQaU3KhJ636OnSzc2QoNfhMRLMsQumtpsJs=
X-Received: by 2002:a05:6512:1294:b0:533:4477:28a2 with SMTP id
 2adb3069b0e04-53546b04544mr8699822e87.16.1725359925654; Tue, 03 Sep 2024
 03:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
 <20240902222824.1145571-15-andy.shevchenko@gmail.com> <Zta2gaV_8qintFts@lore-rh-laptop>
In-Reply-To: <Zta2gaV_8qintFts@lore-rh-laptop>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Sep 2024 13:38:09 +0300
Message-ID: <CAHp75VdmXa3njJFkbsgLX3G2Auh_6ive1dHQyEvTf26ft_riTA@mail.gmail.com>
Subject: Re: [PATCH v1 14/22] iio: imu: st_lsm6dsx: Get platform data via dev_get_platdata()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:11=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:

...

> >       struct device *dev =3D hw->dev;
> > +     const struct st_sensors_platform_data *pdata =3D dev_get_platdata=
(dev);
>
> nit: I guess you can move pdata pointer in the 'if' block, since it is ju=
st
> used there.

Yes, but it will increase the LoCs number by 3 for no benefit for each
of such cases.

> >       int err =3D 0, drdy_pin;
> >
> > -     if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) <=
 0) {
> > -             struct st_sensors_platform_data *pdata;
> > -
> > -             pdata =3D (struct st_sensors_platform_data *)dev->platfor=
m_data;
> > +     if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) <=
 0)
> >               drdy_pin =3D pdata ? pdata->drdy_int_pin : 1;
> > -     }


--=20
With Best Regards,
Andy Shevchenko

