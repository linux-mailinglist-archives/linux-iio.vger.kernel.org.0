Return-Path: <linux-iio+bounces-21313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8EAF798D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 17:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A654A78C8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E92EF2B0;
	Thu,  3 Jul 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO/kITT2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20362EE97A;
	Thu,  3 Jul 2025 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554829; cv=none; b=DCHc70PU5oTwMNfG3ni3GdkY0Jp+0GaWcEkbdxMw543iAv6ue5CgFm8N++vm4JQdvYWxfXD73N8brwb+E/ihvr35iBzFQXyIN9CrDtGZTjCIOXyzvuk6DqYnG56N9WkqG6FYBVPDH/Wpq/uaHkPcoU5jPiX0IM5VE2qUJ+sL5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554829; c=relaxed/simple;
	bh=y5Bn/qxeEIbhfA4Ie5xDKGLKZvHhGtzkHdNAYE3pOqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcFAs4904QJ8OBh/YnF5jt66nsxyExvHdi1rxhNAF+Yg3xZjK2XI7tqEGfSJAbEERZYoA6YfKxARK6g8eYSr0sufqtoXZfVH1c8yy1cPZtyrLng2a4yvpiV76tm2WFg9YAnwV3/iqV7Th0wlVIsz4ZCVdlH/XAomVQ8RYt0OHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO/kITT2; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7111f616c6bso10179927b3.1;
        Thu, 03 Jul 2025 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751554826; x=1752159626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ptb8KthmKGSlL8wUvt0FDDgjb5LSkon5edWESqJxivU=;
        b=iO/kITT2x1FzXo6ri9UwFIgQpK3DvRSpC/K+04KQff3HPdywCj8yd635tiPn2bGjaH
         79LGwGVdBlkO3+Facp5PT1tc8hDkb9YiwYwoB8Aw2NrAmi8DnPqjL5KkdPVAlSo3ZZsK
         ySMhQ8tNKOQLPzZ+1VbLv5ayWMMUboasf6KLcr98AB8c+BEeksvYw2Aui0NdlLwtat0y
         gMZCpsw9KBJ1KGZ8idQIZp73WOcx+5zPb+UYzl2b2gsn3dW+vGc5ORKiguklK7B9YEZ4
         JK8Lphis54i9NZut5jjpuIZ0lOUdinFhxVPfywiBEKJpvIf2lZVIPQhlKY19qOMEfTpQ
         TQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554826; x=1752159626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ptb8KthmKGSlL8wUvt0FDDgjb5LSkon5edWESqJxivU=;
        b=ScK2TkpZPT28lfijQr9fJ+i/gACIjagmy6z+jfuNMfU7nFcMpmd9OrLl8VWw4P6Uzh
         Y5VGytcls+FKO7on6dn+msbU15DvX5MtMgjNVvRaOvpHqWS9qpaL0xTQGRkc+nHHDpgl
         s3btJzITiHEb7+r/IS3XxBwN9eetH4NkV12/KVFOQc9iVbqv32w69XJKMTD54T0tuEbe
         7pa54t2ctNbn5/4s99k6eTJ+i66XCE4sAVygtl28UuTv119XCjJGkubOVwnJCxL+c3OC
         U5pypGmwAa6eleFqYkuScKcwsvLTJXlgN3xumHGe3k7M1n5hCWeikqW7NDdwtfJSJ5bV
         76Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV0rT1qFWBse0POefgNxy9juF07paTP0MTSc+UI278RIlUT8xQ1RKXU2CShqA7FaMrKTsMvIOu3zrk=@vger.kernel.org, AJvYcCVIbK6XFbyWkChW0t+HpgY8pnzHMwe33b0JJPZK7V2x1MsoqLqR+kVtjVJnW5sI5+LQ6lZDEfyhJTJ7@vger.kernel.org, AJvYcCW6//0IxVNc98agnkBKM+L0M42Rzw2eCfyx8by/KVJRgRjq1ZTDopIcVdaGBvduhZqwLVFiylSNL8F+TNNs@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCFTSCWlw1kobD4TNETyiOncaL62AiZa8W4L6khO7lTa0O1eC
	ggDE3V1Hbc8fTGHEHJdY1vrweCaJHlkzJgyJUQJDOpu64Nhgp5OWnNOsCEZ80hR/Xhq3QlFoHjo
	noyFXChxSti+c2T7oYhhvCZDf+fXRX0U=
X-Gm-Gg: ASbGncuEW9eKXKyWpVg32dcmKNmEtZoTi9EIP2MWSamPol5YBHMrs2BaKEMXCpV6aDk
	8ksFHpXM09aRrzL4BnUOGFZQZIS973r1/+6T68o8uwpY/zv5YMumR0QkpOU4kDXK/F0YLBQZ1CF
	AbGPZ6nkAjDONYZZp6m8y1SrEZv1ZiZDz57MYBTo5IcRE=
X-Google-Smtp-Source: AGHT+IEJUB5T2dZch8L6OTflAWv0/CbLrHQDwfw+YuL8DyN+2SKWnCAuI/UdJ4TilIAaYk4IuUSilswkIWEQlX7CIMI=
X-Received: by 2002:a05:690c:48c5:b0:712:cc11:af5 with SMTP id
 00721157ae682-7165d46e317mr14680987b3.0.1751554826083; Thu, 03 Jul 2025
 08:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230315.19297-1-l.rubusch@gmail.com> <20250702230315.19297-5-l.rubusch@gmail.com>
 <aGaTH6gVqHxn9Xct@smile.fi.intel.com>
In-Reply-To: <aGaTH6gVqHxn9Xct@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 3 Jul 2025 16:59:50 +0200
X-Gm-Features: Ac12FXz9rM0PAzHkg-Tc_r3etk-DC0GwYxQkKb6ETriONVfGT8gZjdobROS2SOQ
Message-ID: <CAFXKEHb4MQk=6hyh-02Fq_XmkQmMiwc-WT4ZSviP6x4XA463mQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] iio: accel: adxl345: add inactivity feature
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, thank you so much for the (almost) immediate feedback!

On Thu, Jul 3, 2025 at 4:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jul 02, 2025 at 11:03:11PM +0000, Lothar Rubusch wrote:
> > Add support for the sensor=E2=80=99s inactivity feature in the driver. =
When both
> > activity and inactivity detection are enabled, the sensor sets a link b=
it
> > that ties the two functions together. This also enables auto-sleep mode=
,
> > allowing the sensor to automatically enter sleep state upon detecting
> > inactivity.
> >
> > Inactivity detection relies on a configurable threshold and a specified
> > time period. If sensor measurements remain below the threshold for the
> > defined duration, the sensor transitions to the inactivity state.
> >
> > When an Output Data Rate (ODR) is set, the inactivity time period is
> > automatically adjusted to a sensible default. Higher ODRs result in sho=
rter
> > inactivity timeouts, while lower ODRs allow longer durations-within
> > reasonable upper and lower bounds. This is important because features l=
ike
> > auto-sleep operate effectively only between 12.5 Hz and 400 Hz. These
> > defaults are applied when the sample rate is modified, but users can
> > override them by explicitly setting a custom inactivity timeout.
> >
> > Similarly, configuring the g-range provides default threshold values fo=
r
> > both activity and inactivity detection. These are implicit defaults mea=
nt
> > to simplify configuration, but they can also be manually overridden as
> > needed.
>
> ...
>
> >  #define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> >  #define ADXL345_REG_TAP_SUPPRESS     BIT(3)
> >  #define ADXL345_REG_ACT_AXIS_MSK     GENMASK(6, 4)
> > +#define ADXL345_REG_INACT_AXIS_MSK   GENMASK(2, 0)
> > +#define ADXL345_POWER_CTL_INACT_MSK  (ADXL345_POWER_CTL_AUTO_SLEEP | A=
DXL345_POWER_CTL_LINK)
> >
> >  #define ADXL345_TAP_Z_EN             BIT(0)
> >  #define ADXL345_TAP_Y_EN             BIT(1)
> >  #define ADXL345_TAP_X_EN             BIT(2)
> >
> > +#define ADXL345_INACT_Z_EN           BIT(0)
> > +#define ADXL345_INACT_Y_EN           BIT(1)
> > +#define ADXL345_INACT_X_EN           BIT(2)
> > +#define ADXL345_INACT_XYZ_EN         (ADXL345_INACT_Z_EN | ADXL345_INA=
CT_Y_EN | ADXL345_INACT_X_EN)
> > +
> >  #define ADXL345_ACT_Z_EN             BIT(4)
> >  #define ADXL345_ACT_Y_EN             BIT(5)
> >  #define ADXL345_ACT_X_EN             BIT(6)
>
> Now it's even more mess. I am lost in understanding which bits/masks are =
from
> the same offset and which are not.
>

I'm sorry for that. I mean, while the above is supposed to make it
clear where the "values" are coming from, I also could setup something
like the following which is shorter.
+#define ADXL345_INACT_XYZ_EN        GENMASK(2,0)
+#define ADXL345_ACT_XYZ_EN        GENMASK(6,4)

As I understand you, you'd rather prefer to see the latter one in the kerne=
l?

> ...
>
> > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE) |
> > +                     BIT(IIO_EV_INFO_PERIOD),
>
> Same comment about indentation style.
>

I'll take it on the list. As I mentioned, "checkpatch --strict" seems
to complain about function arguments not being aligned, but
assignments this way are passing nicely, like the one above. Depending
on what else comes up, I'll put this CR on the list. Thank you.

> --
> With Best Regards,
> Andy Shevchenko
>
>

