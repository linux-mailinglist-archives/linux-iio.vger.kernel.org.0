Return-Path: <linux-iio+bounces-14967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF48A27289
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A7B7A1285
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936321504B;
	Tue,  4 Feb 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LxDLjHsZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D912F46
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673673; cv=none; b=kzH7lzKZKp1v3cEGufl1alF8lem4KOhANOsf60brUiJeGclLYOcKEquTkIH1GbxO/9KF61ZnSro6qLMoAAbrZy/sPHv5I6QgzLOPzXtnAZR4eQbKPAcHw6Q9yhVc0JGghmMtbeagHtLMWlBdWZ2NK0YBz3aGqxqBoeXZd8lvhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673673; c=relaxed/simple;
	bh=ynSUJ63SuLhCXyf2usS1JVLKxrhDuZv8kV79M/Jon+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=JS6Dl4R1T/JI53Np9iqTozOITpHA+fPhdd5ba7x3f7EMU8jov/M7bdShKNq+QiSkQCum3hDZbFW94IEp2MUuX79COVo+GOsQAkyhdoZYFzECl4PUMFkuqtKLEs1gyr6MdCbOXZZa8vqtmZszCvKsTtDlALQnuBYDmHp5eyp7DrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LxDLjHsZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436341f575fso64684535e9.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2025 04:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738673669; x=1739278469; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSDieL9GBtvsQS7Ye0zV4eVocVG/YaV0pHO+Q0/Wne4=;
        b=LxDLjHsZPwDJHzkD+Eim7w5Zmh4tZJddvIc26w2ntrXWaPAcPVrs9D+/dkx4bgJvIH
         Tqlv/kNkn840rWVSTbjF+yDxbg882vYfVskYls3e+MMo+K82eFSG46lIhSs9fKocNzae
         m78PVoCyZs7WZUUHPSTCUoV8FVX38o9hN5m0yrNB6c3mLIDdGCNK95oU/LXr43LxrUqe
         aWmBdXsAgSACZJLm/A1vzQcziT7VzJVKvQVONOZgbg0o7eP3v9kaSPaRrh2wK3ZUYnMK
         YoI8Y3phTWWXT2L+qWhFE1LqB88TPEgttiAA+V1PIQZ7T8VLbE+o8j7CG2mpZRDuKxvZ
         oRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673669; x=1739278469;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fSDieL9GBtvsQS7Ye0zV4eVocVG/YaV0pHO+Q0/Wne4=;
        b=BlEeKyf4fFafyJqN1HEgVSnZFAX6pI+2w5dI6ZytSkraP1kJvDHRbzhJQHeD4fpP7A
         UMQTI2dcwXTEVntPm8GXnPDuhOCpqILF+pdqIJ0haJG809i8Q2fTPJ45zjYR/9Nsr9yg
         eMjqjLgvbr4gtt6K8HTt8aXJVh4okHYGdKdsGwzcnlG1QKBCQWhh4QnqsbMlhsJQvISe
         zmIsPjCrVdbHZXJqpUf65eiHVv8Pljj7CzWqP57QLtPfHUsFHM8iokABcK/jvnmqTEqj
         AmgoJSK5jcdl7iYYMpmjZCawJWcuBdaAMrPkncS8P6Imaqqa0N9xKQl2VbsL06ilHd5Q
         oyAw==
X-Forwarded-Encrypted: i=1; AJvYcCVMn/r6FRo/CHfmXxpzQYqVfM+F0zOGRy7ckJXCRy3x8yzkxEfQmts7x7ByUN4Q5zaJUUBfuvSQfDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb78ZNUNspZ8bC7YD/U+mPnbdYy95yG6fZnN/Ka2zTSWig4tZo
	XKA1P14osJCG1Nb7nr4ZCqGepwBzZsCFXoFM1rhTw9kn4HpWHxmAB/ICt7/QPYc=
X-Gm-Gg: ASbGncv7WsEQI2PNbBtr8TDy4+p6rTRWLkDFw79JTyHejCaSD0UndQLWltecILXeILH
	5T0xdor8F/1/fh5fxZB11j0In886r5kIt4xiJ9BxbgAf9xYcp9EwlvWz5PeWaaTUsL3sTUBCJ2S
	n5JFOXWolQWtHIPB65OJXMY0pCJimpy90N0f/uztn5vTz/YxXcG7U2IXNjvKUU90pD8kg6l7jgH
	ijBEfMCJ31Kg8/Tet3fuCQCFJFfkNHBOiwv88LMplT592lZ+v9XEehkv98q1zX/Bek9cz2Myz2z
	v3R+WLe+TpGS6XuisM825NdGzvXgBN6SLXQ09bCf1rucd6jphr/40so/MiaXXdBKb/Y3ow==
X-Google-Smtp-Source: AGHT+IFouneBDH4lcmisK2CqC0lJVk1uEkk/8hKiuwfY//uH+O/ijh/ARezQ4p0atRjAsVemu/oJlw==
X-Received: by 2002:a05:600c:3d05:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-438dc3ab518mr293284155e9.5.1738673668943;
        Tue, 04 Feb 2025 04:54:28 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390692a66esm14765885e9.0.2025.02.04.04.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Feb 2025 13:54:27 +0100
Message-Id: <D7JODK8W4W9W.3OO4GRGNDU5ZX@baylibre.com>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] iio: adc: ad4030: add driver for ad4030-24
From: "Esteban Blanc" <eblanc@baylibre.com>
X-Mailer: aerc 0.18.2
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
 <20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d@baylibre.com>
 <20250131181437.00000097@huawei.com>
In-Reply-To: <20250131181437.00000097@huawei.com>

On Fri Jan 31, 2025 at 7:14 PM CET, Jonathan Cameron wrote:
> On Thu, 30 Jan 2025 12:08:26 +0100
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> >=20
> > The driver implements basic support for the AD4030-24 1 channel
> > differential ADC with hardware gain and offset control.
> >=20
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> Hi Esteban,
>
> Just one thing in here that actually matters. Question about scaling of
> the common channel.  The others I could tidy up whilst applying if
> nothing much else comes up.
>
> Jonathan
>
>
> > +static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
> > +				 struct iio_chan_spec const *chan,
> > +				 int *val,
> > +				 int *val2)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +
> > +	if (chan->differential) {
> > +		*val =3D (st->vref_uv * 2) / MILLI;
> > +		*val2 =3D st->chip->precision_bits;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	}
> > +
> > +	*val =3D st->vref_uv / 256;
>
> This is a bit non obvious.
> A comment on this scaling might be good to have.
> Particularly the lack of / MILLI
> (I think that's a bug?)

Yes I think that should be:
``
*val =3D st->vref_uv / MILLI;
*val2 =3D 8;
return IIO_VAL_FRACTIONAL_LOG2;
``

So I guess that requires a V4. I will address the other comments there.

Thanks for your time,

--=20
Esteban "Skallwar" Blanc
BayLibre


