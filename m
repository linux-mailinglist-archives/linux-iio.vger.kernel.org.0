Return-Path: <linux-iio+bounces-21034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF02AEC818
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908647A2A4D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7821B192;
	Sat, 28 Jun 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2UVeyjW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671214883F;
	Sat, 28 Jun 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123018; cv=none; b=E+i0Gr5Dz1uM8/tIkgX+SB20qWFiS1Dpqvfac5pK/JDYw7uN5Oxelp2N+Itw8KvOfcymlbimY5PQF9nfsnF96XDz/F8+EQMFLNA+P2bKSXXYIwq0/BSD3pr67N7cSDj3IXPp1Azq6K9cL4L0N2ZN3bROio9set8UrFjnHLiAB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123018; c=relaxed/simple;
	bh=tB/OqKZySucOavnV7IK+ZhNnC6CvdJvC7go9wFwAzyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDN2vaiZppBmrKfYLXm1Wv6ZeDN4JX/crTHn2/o3Ih3j6fXqwD4v4uyH9Fszf13zL63XyNGrnFH72+JraH02GAIdidpzq+Ci2XFK/wo7LFSAoO4tbHViMMTNEiQB20V17BkcLDz0vW8ZRS9Dw9NKKBqkZZ89lYaTWCo10j1QygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2UVeyjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D230C4CEF3;
	Sat, 28 Jun 2025 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751123017;
	bh=tB/OqKZySucOavnV7IK+ZhNnC6CvdJvC7go9wFwAzyM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=K2UVeyjWpToVc/bXWsEiny0pDK+L1LK2VmgM2/2HG5BQfK4ENFK/Qgl/IDB++ye8Y
	 DS2Z1UzeIL/IQcVBlPPct8bNf1+j1iiyqjG6v1OL5g0ncqGoNerCDr3qly0RK3/Lwu
	 rJUnOE1ghNqsSiJKPopYH707YWY3lCytTjb0mUQ5Jk5HLphR2B5xegcCeYPsL8CmQm
	 2ihbA9Uc25VFNzwyZ+s7aLUOqyU4AAbQ93+3zom8eyuFaessdsp94z9jbQvczH+8OI
	 ISqZD5yN1N7dAkLty6+Cz2GoKgoAiWit2IxPy9kTvd+l+uIdKnHHXKYA5ZoMB6PzN/
	 4gXBgI2bAhrVQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d771435fso2565755e87.3;
        Sat, 28 Jun 2025 08:03:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiSUGiHphwwl5AQSz0tp1/FAxIAmI6J+gOwCVM9WQdx+8WNEXcfcJowDDzlPiJkeRE900dU/8mn7I=@vger.kernel.org, AJvYcCXyo6AiCNJ9EQBLEVXtL3u/fxOaWbaAxQfSGK9P0s4hdOsRvdnz5AOZO6KqKrheWhM4Mky3449tjsbg1xm2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Mx+0sXi5xh5TpHDd8IHfMXN4rO8NeN+mG6mIyQXi75IT1LBL
	xI2ICK4vbSdUe8av2KncJdyNLCHFP4v1d+CXicGXa2N3u8HYaH62oYch5lq98tharlwSizAkAuF
	e6FHFFtGpz4J5EdOPtONDv6AWtMfX2do=
X-Google-Smtp-Source: AGHT+IG6Rncce3KW8sf3+FKtZPvqEv33L2BKd1LTtks9HbvkhaFI7zipeaHmUVPk5QL5LmiXI2cv2XEmruNNmc875rg=
X-Received: by 2002:a05:6512:31cd:b0:554:f76a:bab0 with SMTP id
 2adb3069b0e04-5550ba43369mr2248669e87.47.1751123015769; Sat, 28 Jun 2025
 08:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628044326.2844027-1-wens@kernel.org> <20250628155112.2d45ffe1@jic23-huawei>
In-Reply-To: <20250628155112.2d45ffe1@jic23-huawei>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 28 Jun 2025 23:03:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v66efw2xABohSdiMn=EfwoCvAj2-WGnGNXT5PLtCTBZo1g@mail.gmail.com>
X-Gm-Features: Ac12FXwg6CYYFXVNkQO2sHQqUdA6gXXXxz1znZJBwnjjNXK5flWtbDfMP-80fPY
Message-ID: <CAGb2v66efw2xABohSdiMn=EfwoCvAj2-WGnGNXT5PLtCTBZo1g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC
 channel maps
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 10:51=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sat, 28 Jun 2025 12:43:26 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The AXP717 ADC channel maps is missing a sentinel entry at the end. Thi=
s
> > causes a KASAN warning.
> >
> > Add the missing sentinel entry.
> >
> > Fixes: 5ba0cb92584b ("iio: adc: axp20x_adc: add support for AXP717 ADC"=
)
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> I picked up the version you posted on 7th June.
> I've been a bit slow to send a fixed pull request - sorry about that; bus=
y
> few weeks.

Ah, sorry about that. I was looking through my work directory and trees,
didn't find a patch file and thought I hadn't sent it yet.

Good to know it's already queued up.

Thanks
ChenYu


> Jonathan
>
>
> > ---
> >  drivers/iio/adc/axp20x_adc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.=
c
> > index 71584ffd3632..1b49325ec1ce 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -187,6 +187,7 @@ static struct iio_map axp717_maps[] =3D {
> >               .consumer_channel =3D "batt_chrg_i",
> >               .adc_channel_label =3D "batt_chrg_i",
> >       },
> > +     { }
> >  };
> >
> >  /*
>

