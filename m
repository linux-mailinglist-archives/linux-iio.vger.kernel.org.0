Return-Path: <linux-iio+bounces-24612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21597BB00CA
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 12:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B4917BAFF
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800662C029E;
	Wed,  1 Oct 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NUqiz9th"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBB2AD3E
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315442; cv=none; b=g9Soc42nUg8+3OTDe/M+Qtcy6dYfePpZDkN7OJ74poJBUpWyv3l+pTDPRjV/Ng2FupRjGrQPzzRuhQSbRJCrwi3bmwS7Ccw02dN9jRVkiyCxQ4/VB/jB7wEsqwq7M2L9zarIe9Y1TAiyuJG98N4JDK9D61pt9BPSE0fSnioLdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315442; c=relaxed/simple;
	bh=AgSkwJRd80VStmQzpr0QeOrgu20AtVP1C0KmVgylgnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEsCYi38ZmwtiA67PkJuM921qu35OfnpmywPu3KhdIfB29UH/Wg4YXGQWVnw23gw94mWuu5c4gxdOq+KEcFKAu/eFveSDeVTHwjIUKk4vQZNKP1dAB3mD/2M6pHO6XeUez5cM1d+JUafYpCa8bHP3GKxPvAfynD2k+Qjh/xMAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NUqiz9th; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36a6a39752bso66245981fa.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759315438; x=1759920238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lZRH7mvLyxN+MzFG95XhIKVBdnkVtDrMCoccREIXhU=;
        b=NUqiz9thhTn9L+LZFuSJm5i0/sR/WoX8qQz92Yq/r+y1FaCIYRoF7pz5LFVD1XwTZ4
         NLzEW78S7zm9A6FFeOi6Qk/pwB4TvAYdL3fhf5yrzKMTJL7WLTZHsdPjkhISF6gb7Ttx
         t37NEVY/BKOie4XiDNkTnBBcjuKMBPcffdwFd4Nipmtqm8aurh7HOjg1iYrSAs64mp37
         rCSLBWUnp7X3QY6xKGo1946D1lcfsK3EqUdsbesB1dxPyZwQKAb0wZs15owZU1xKbj4/
         PregIOyLdFgDCSdKGdkShD9W1QC/vHFGQ5N/xGf8ozeNwI58cspGu8fb8U+B7wLBeKWJ
         JAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315438; x=1759920238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lZRH7mvLyxN+MzFG95XhIKVBdnkVtDrMCoccREIXhU=;
        b=Qra3UWX9FLntq+KN/KPU4BspdBRn9dm/QnUIMgqfPYkW4nMIfAt1TLTFgShr1PAnpu
         tpF/A8AXYVH5vBt/rzFoALVoA1FH+RLodbtZ2ZdKVQIYVbuqWhjrxRYmJhJdpCzqXPhy
         Dq6Md2lmCJu14UDEdY/XlDj1PGhhRcsPfVR9+zkYf0cuW/1SYYMtWKzq/ct6HIgDTAlu
         EnM/uQW9sMpdyDPVFlUfvLsQplHPjBNw59BOrxXHxBgKYuz2N+42h0Ae67T3aTFCUPr7
         setQlv7wT6jjmDNowF3e9OLzgMaJdDlCo6EU9AmbKNsZPpEoAxJK7LFIWHCmm3pd8Nmn
         H/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXG9ZADv+vVzWM20ECcRULbLNXg/j+KmpgxcBZzR0zlL0dJZFXFuEukQdkW4rnCR8ktihAhgsd7NJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXn5iKewHwSdBBpFIiUkg3cMjwQ9p/+HBYLbXsp55dNWramgmO
	n6JV1v4J1C0+qMImEoQJJ8EL6qoV7tEXkCI6jQlIdc1RiaC/1sjCyvBsnViiXOPR4mKelkRAnDc
	C0b9TcQHRmDkwl2Y/mgdK34xkEDEbSQKnMCkkPb3BOQ==
X-Gm-Gg: ASbGncune+1+SAv82Pld4gyWBdxdhhFtdEs23mSFLTG0IpaHs1CxbcIcgj8YLjG3f2a
	OzJ3D4jaMDhWK3SdCqkOkEEDj5Ztw+RljL1SFo1PCZ4xFcodj+ZdIn9a0E24S4piJRPufyzqwt0
	oibnEGeSSTz2FQ3lClLfwcNGKPlNWfreMcZkJvlyGM6CQQPKA972qu3VWtMS6hxbEGMUUGFmTF1
	yuSW+2htueMAWfw7XS1Xz8w8oOg5Qo=
X-Google-Smtp-Source: AGHT+IGJ9OoCSt69qSz0S+IZPQ24WcgNAq7AL1kC005K8SJV8OJKe3mHbmPlw9uuhNpvC5T8Eyr0LjgcKU1Qm7+Wghs=
X-Received: by 2002:a05:651c:1553:b0:36f:4c94:b55e with SMTP id
 38308e7fff4ca-373a7487662mr6999571fa.39.1759315438106; Wed, 01 Oct 2025
 03:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-2-bb61a401a0dc@bootlin.com> <2a503edb-fe9f-4d61-92c0-c1083a028e19@baylibre.com>
 <5015441.GXAFRqVoOG@fw-rgant>
In-Reply-To: <5015441.GXAFRqVoOG@fw-rgant>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 1 Oct 2025 12:43:47 +0200
X-Gm-Features: AS18NWByDMtr1hcTFcPp3qerygswAkBQ0L9YHlvelZDEmKOElWDCvIdZewkZNO0
Message-ID: <CAMknhBHJ8Je2Tcz6yBi1g5tBswoVFXr78tKeZRrfi_9TjLdMuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: add processed write API
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies if you are receiving the same message twice. Re-sending as
text email so that the mailing lists will pick up the reply.

On Wed, Oct 1, 2025 at 9:19=E2=80=AFAM Romain Gantois
<romain.gantois@bootlin.com> wrote:
>
> Hello David,
>
> On Thursday, 25 September 2025 23:10:14 CEST David Lechner wrote:
> > On 9/25/25 7:37 AM, Romain Gantois wrote:
> > > Add a function to allow IIO consumers to write a processed value to a
> ...
> > > +static int iio_convert_processed_to_raw_unlocked(struct iio_channel
> > > *chan,
> > > +                                            int processed, int *raw,
> > > +                                            unsigned int scale)
> > > +{
> > > +   int scale_type, scale_val, scale_val2;
> > > +   int offset_type, offset_val, offset_val2;
> > > +   int ret;
> > > +
> > > +   scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> > > +                                 IIO_CHAN_INFO_SCALE);
> > > +   if (scale_type >=3D 0) {
> > > +           ret =3D iio_divide_by_value(raw, processed, scale_type,
> scale_val,
> > > scale_val2); +              if (ret < 0)
> > > +                   return ret;
> > > +   } else {
> > > +           *raw =3D processed;
> > > +   }
> > > +
> > > +   if (!scale)
> > > +           return -ERANGE;
> > > +
> > > +   *raw =3D div_s64(*raw, scale);
> > > +
> > > +   offset_type =3D iio_channel_read(chan, &offset_val, &offset_val2,
> > > +                                  IIO_CHAN_INFO_OFFSET);
> > > +   if (offset_type >=3D 0) {
> > > +           switch (offset_type) {
> > > +           case IIO_VAL_INT:
> > > +           case IIO_VAL_INT_PLUS_MICRO:
> > > +           case IIO_VAL_INT_PLUS_NANO:
> > > +                   break;
> > > +           case IIO_VAL_FRACTIONAL:
> > > +                   offset_val /=3D offset_val2;
> > > +                   break;
> > > +           case IIO_VAL_FRACTIONAL_LOG2:
> > > +                   offset_val >>=3D offset_val2;
> > > +                   break;
> > > +           default:
> > > +                   return -EINVAL;
> > > +           }
> > > +
> > > +           *raw -=3D offset_val;
> > > +   }
> >
> > There are some rounding biases in this function, but I'm not sure if
> > it is worth trying to make a perfectly fair function.
>
> I'm unfamiliar with the notion of rounding bias, does it mean that nested
> calls of this function would tend to amplify rounding errors? In this cas=
e,
> would rounding to the nearest integer instead of whatever is being done b=
y the
> integer division here be a good solution?

In this case, the issue is when you are taking multiple samples. When you
look at the average of all of the samples, you will be able to see the
bias. For example, in one of the drivers I was looking at there is an
offset of xxxx.6. Since the IIO_VAL_INT_PLUS_MICRO case is just dropping
any fractional part, the raw value will be on average 0.6 lsb lower that
the requested value. This could be a problem in an application where high
precision is required. But probably not noticeable in cases where 1 lsb is
less than the noise level.

The floor division for IIO_VAL_FRACTIONAL creates a similar bias.
DIV_ROUND_CLOSEST can help there, but even that has a small bias because
values of exactly 0.5 always get rounded in the same direction. That kind
of bias is much smaller though, so easier to ignore.


>
> Maybe I'm misunderstanding what you mean, in that case please let me know=
.
>
> Thanks,
>
> --
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

