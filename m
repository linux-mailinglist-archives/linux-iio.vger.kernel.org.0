Return-Path: <linux-iio+bounces-9486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748ED977CA1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92F01F2608A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C691D7999;
	Fri, 13 Sep 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="arhh5NWE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AA1D6DC7
	for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221334; cv=none; b=LKsLMO0MRrBpd0zJTIKRTVSQ8Ewu5C7im+trSYX59f8zGYpC20zqOk2+lXdDVyCWqlbnfllkmxuImRiH2JQ9/FgSHw+3GcYTC720fwSp1pWfNsk8Q8+e/4JdkfV4lYtKvIMianKJVA6EwoIWhWbAlp7beOcq0S3Gcb8oTmcjbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221334; c=relaxed/simple;
	bh=QdwlMldGdphejuyA0j4+krFypkdA83svh79wzoxEj0w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VdEJ4YB82qpEA8urmuTtJZa4NQK31a0/LqgNE2Lb1FTxtP6XVasuJcAIGnIRkSeVv3LhMFxTmWN/AyJhBTLk5sexyqyvCNUkaI+dnGB+Sku19HpOr+Q5eUkiAA2OYK1CgtHbpk6AjuW0pWCZpALS3/02z5ax3YyQW+BfiNLfU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=arhh5NWE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cafda818aso18596735e9.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2024 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726221330; x=1726826130; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IimCEQjw+RxgJwL7dEaHdlom89dp2Edr+TPjCTDc1c=;
        b=arhh5NWEy49xdC8Rpv58dGQlK0ydVbRg9QdBUG47wMgAaNFpL8Y1CsoOhYcwb8nJXw
         bEnoKrbJKQnaCVrwIUSpTRp1QaipudZUmJcbNqiSzfI+sDjdZRqE8/z13JRYhMUyBMho
         Ny52fdZVdwMyoQlCtSEOxw5eevGlx0KCiCZ3VYWA5IdU0q7/AIJCxzSHK3wnOJL5lDsg
         0PvNCSDJpuj2KdLDnqbVRTyVEcm3JYvBa5pqSmMxswQ/C6HXYYp7wHRKLkLjjyJDRm5P
         FfVeN6R+/NChkWAdv395GfQQ6PwCW7QCs+2x0rpWOzyXO9zziUy7Z7IEFDZdEtXbXUuH
         T2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221330; x=1726826130;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8IimCEQjw+RxgJwL7dEaHdlom89dp2Edr+TPjCTDc1c=;
        b=mEDzQ2dr464KbyEpM+Bf4n5s5GEoSUTlOLWHPO4CtDdobY799iAtrctNN6EQ5UZEA5
         t48JbY69Eias4D/tah9DXIDz6He3ol+bAVDG2JZhwHGkHwerCM/DYyjqNS7xRQ69k5LY
         ZH1VwY0YIhj6iG8qaC2CUCQudyGyzAkIqKB2THN3s48psuXsk6TKpN778woCO8CF3Sqn
         /QoyiNAqld6u5Eq9vK6ZUo+5XwzdagAyhXdmats8qBDeKhbRnDMZZ1U/jBHlwZbWHk0s
         EQB810664CNwqHTPiYMOGrGE3OWXWfW9EaDrTKof36uAlNURlDWH6q16XWggt0YTTL24
         ZVAg==
X-Forwarded-Encrypted: i=1; AJvYcCX0WgyzDpRC+c31tSt81VSck0dJQeVbVVijaB17mytKBHavGLNS4pe2hWJe1pRoOAaKgWfLZRZbEoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIshB1gufN5JjIzTnzA/jGXbiTIsh0QJDb8qIvuGoCG2QKNZz
	f4Sv0b6DQzejJFGVoxuQFFvs2TzCFUEqqphH3g1qlly58J67ojClmJ7SPBXk8ws=
X-Google-Smtp-Source: AGHT+IF4CvTAu/JtSSJx1DTcjPw9Y2oWznPE0a2seSirQo3gZlG7JOgoRrPbVmWsUTwVrl3EsyiV5A==
X-Received: by 2002:a05:600c:35cf:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-42cdb575036mr52128725e9.29.1726221329829;
        Fri, 13 Sep 2024 02:55:29 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1948fasm18463575e9.43.2024.09.13.02.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 02:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Sep 2024 09:55:28 +0000
Message-Id: <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
 <20240826102748.4be0b642@jic23-huawei>
In-Reply-To: <20240826102748.4be0b642@jic23-huawei>

On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:
> On Thu, 22 Aug 2024 14:45:20 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
> > @@ -460,12 +517,21 @@ static int ad4030_conversion(struct ad4030_state =
*st,
> >  	if (ret)
> >  		return ret;
> > =20
> > -	if (st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> > +	if (st->chip->num_channels =3D=3D 2)
> > +		ad4030_extract_interleaved(st->rx_data.raw,
> > +					   &st->rx_data.diff[0],
> > +					   &st->rx_data.diff[1]);
> > +
> > +	if (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> > +	    st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> >  		return 0;
> > =20
> >  	byte_index =3D BITS_TO_BYTES(chan->scan_type.realbits);
> > -	for (i =3D 0; i < st->chip->num_channels; i++)
> > -		st->rx_data.buffered[i].common =3D ((u8 *)&st->rx_data.buffered[i].v=
al)[byte_index];
> > +	/* Doing it backward to avoid overlap when reordering */
> > +	for (i =3D st->chip->num_channels - 1; i > 0; i--) {
> > +		st->rx_data.buffered_common[i].diff =3D st->rx_data.diff[i];
> > +		st->rx_data.buffered_common[i].common =3D ((u8 *)&st->rx_data.diff[i=
])[byte_index];
> > +	}
>
> I wonder if doing it in place is actually worthwhile.  Maybe unpack into =
a second
> array? That is still fairly small and may make code easier to read.

Okay sure

> > +static const unsigned long ad4630_channel_masks[] =3D {
> > +	/* Differential only */
> > +	BIT(0) | BIT(2),
> > +	/* Differential with common byte */
> > +	GENMASK(3, 0),
> The packing of data isn't going to be good. How bad to shuffle
> to put the two small channels next to each other?
> Seems like it means you will want to combine your deinterleave
> and channel specific handling above, which is a bit fiddly but
> not much worse than current code.

I can do it since that was what I had done in the RFC in the first place.
Nuno asked for in this email https://lore.kernel.org/r/0036d44542f8cf45c91c=
867f0ddd7b45d1904d6b.camel@gmail.com/:

>>> * You're pushing the CM channels into the end. So when we a 2 channel d=
evice
>>> we'll have:

>>> in_voltage0 - diff
>>> in_voltage1 - diff
>>> in_voltage2 - CM associated with chan0
>>> in_voltage0 - CM associated with chan1
>>>
>>> I think we could make it so the CM channel comes right after the channe=
l where
>>> it's data belongs too. So for example, odd channels would be CM channel=
s (and
>>> labels could also make sense).

So that's what I did here :D

For the software side off things here it doesn't change a lot of things
since we have to manipulate the data anyway, putting the extra byte at the
end or in between is no extra work.
For the offload engine however, it should be easier to ask for 24 bits
then 8 bits for each channel as it would return two u32 per "hardware
channel".

In order to avoid having two different layouts, I was kind of sold by
Nuno's idea of having the CM in between each diff channel.

Thanks for your time,

--=20
Esteban Blanc
BayLibre

