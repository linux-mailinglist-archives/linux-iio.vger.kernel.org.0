Return-Path: <linux-iio+bounces-10640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C299F089
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D6A1F26BDD
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51551B394B;
	Tue, 15 Oct 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SubSaxvF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B713A250;
	Tue, 15 Oct 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004414; cv=none; b=kKJ+kZvgGPNX49Lm1YUtdgGQRfCQjnnNlIvgQXjsCUjFMIy4DfGF46iVhL1HxGT2gGt6QvNe9OaIFUMQKlPCQecdkIe1IlUGsIJ8W7kUhJiCHReREI4C6OpwBDtMjoW9+msExzxymxJsSxkiMiu5yg5rOf8fdravZK2lXzlN3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004414; c=relaxed/simple;
	bh=NHQcykyO07KGUppnbImRwz/+8yOPHS1ejAAO14tBPlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivG/PcgKoBWtTtj+H+vHqOVV1yxd/owIh4u7g+/ogB+KCpb9wk9S+FvDF5dn/x2vBcWjBdta5dQ3zdIzM9l5c6KeALUd/feH1BI5yjeyP7thDUT8YoaHyG8oQsJz51j1Zhs9Z1oQcrxquZofLT3keJszRDl27Co8Msqbc8t+Krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SubSaxvF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43115887867so37733485e9.0;
        Tue, 15 Oct 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729004411; x=1729609211; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=70KjP7TZnnA2FF4/RcJoqC2NB3rfaqKggG+mRZoAMVE=;
        b=SubSaxvFiTayetB7sJuA7fSyKnFoKqq61fqy/cYRTd1ey8PYjrL5VG8hH3rCevVC8A
         Qm0cONWdC2YyHfbM9e24+OsiNSlAiDY1Ftxz1l1113j1/8DOniOsRMsq9gd4wqsxYfAk
         ASQf7lhacGzbAmPOYSXA439s5sUqh6+ZejvL8TSvLAITLlRNPmZrCFQlsGPQLAS9D2Dq
         VAjc2xzVDPexWb5GfWbyKw3gmyELPWYjuD5EFACBQ28P3A85qXvwsOpStRbnfegvhYa7
         vauofrmjf1gjt38qAqHONwyY5ix0tu4lym4epzkp30U6dxyXxaQPxvIPaW38AzKsIS4u
         QTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004411; x=1729609211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70KjP7TZnnA2FF4/RcJoqC2NB3rfaqKggG+mRZoAMVE=;
        b=JG7TnqZd/GytbtpqZnTeJNMBZlUEG4hTR+uN8HPGT+G+mBrdRCkrYbGnhaak/JpW1F
         vKLZFbLTybomAQ68CvqZGVjM7/EVaBXu7MpivdSTOt5wd1yaIsTk5nEE4bgkpVqctl0F
         POa1MihMePYnJhO9TWuOVXiUC1LgyPwYnKtj7iY7+zAtU8/WzPm4BlH6jb5p7W/ajuhU
         TeoM05SUZQG9OJFXdjtm6IhwgYYVqBFR3i15N/egxGpVx5Lulfhj2FMES75GXWQNDgIt
         fXtB2RXjGQGbmhpiJHsjHyEiJn9Bu8iOXcApmpLpOYGlIjSWWhiJpRyq9+9no/42Anrw
         0OoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg+8P+Vi4SMxZUJk6Ph6lKdEiQPJJHo7AoH6kYnJrYnB8tDZlBdEBvu45hppVP2L5knB/BXvdsgRD4@vger.kernel.org, AJvYcCWGsVESuOqb4EMuYFJw8wHA3kEDeHvZV3E6gK6XtKW27DqZwak2o+M6Zl9k+STbnDHaVZxdCy+cKe+JitN5@vger.kernel.org
X-Gm-Message-State: AOJu0YzNa5BHlMrJFyZ2VoHoGOkfLzbPXHpKHWDpalU6/XyG7Oohba6/
	Z7rb+mBxsnJk0xkpPsQvNS3qt5jbs69j/rYVYenxB/qpJ18Tu5GQ
X-Google-Smtp-Source: AGHT+IGwbLbRVH41oyhqnMLLEqQufgi06XUslzdfzLsyHkUZzXpEiTdRCKk/qwVwaKQVFIjMUXWMWg==
X-Received: by 2002:a05:600c:3b0f:b0:426:5b17:8458 with SMTP id 5b1f17b1804b1-4311d92c56fmr124538815e9.12.1729004410834;
        Tue, 15 Oct 2024 08:00:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56a6a3sm20274445e9.20.2024.10.15.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:00:10 -0700 (PDT)
Message-ID: <781cf5fa075e13260e1b20f5acadb70bd8107cd0.camel@gmail.com>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Tue, 15 Oct 2024 17:00:10 +0200
In-Reply-To: <2815c8b0-e2ad-47cb-b5aa-00297cf57899@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
	 <c3d55f78-5a54-49f8-b6a1-4ed0f24f8666@baylibre.com>
	 <8642bdb546c6046e8fe1d20ef4c93e70c95c6f71.camel@gmail.com>
	 <2815c8b0-e2ad-47cb-b5aa-00297cf57899@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 09:38 -0500, David Lechner wrote:
> On 10/15/24 1:37 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-10-14 at 16:15 -0500, David Lechner wrote:
> > > On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Add High Speed ad3552r platform driver.
> > > >=20
> > >=20
> > > ...
> > >=20
> > > > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const=
 *chan,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long =
mask)
> > > > +{
> > > > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > +		int sclk;
> > > > +
> > > > +		ret =3D iio_backend_read_raw(st->back, chan, &sclk, 0,
> > > > +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
> > >=20
> > > FWIW, this still seems like an odd way to get the stream mode SCLK
> > > rate from the backend to me. How does the backend know that we want
> > > the stream mode clock rate and not some other frequency value?=20
> >=20
> > In this case the backend has a dedicated compatible so sky is the limit=
 :). But
> > yeah,
> > I'm also not extremely happy with IIO_CHAN_INFO_FREQUENCY. But what do =
you have
> > in
> > mind? Using the sampling frequency INFO or a dedicated OP?
> >=20
>=20
> It think it would be most straightforward to have something
> like a iio_backend_get_data_stream_clock_rate() callback since
> that is what we are getting.

Hmmm, what about exporting an actual clock? Maybe it's overkill but from a
correctness point of view, seems what we should actually do :)

>=20
> Re: the other recent discussions about getting too many
> callbacks. Instead of a dedicated function like this, we
> could make a set of generic functions:
>=20
> iio_backend_{g,s}et_property_{s,u}(8, 16, 32, 64}()
>=20

Hmm interesting approach. I don't dislike it. Kind of a generic getter/sett=
er thingy.
We could then still have optional inline helpers that would call the generi=
c
functions with the proper enum value.

> that take an enum parameter for the property. This way,
> for each new property, we just have to add an enum member
> instead of creating a get/set callback pair.
>=20
> Unrelated to this particular case, but taking the idea even
> farther, we could also do the same with enable/disable
> functions. We talked before about cutting the number of
> callbacks in half by using a bool parameter instead of
> separate enable/disable callbacks. But we could cut it down
> even more by having an enum parameter for the thing we are
> enabling/disabling.

If we don't get too strict about types it could even fall into the above u8=
 category.

Instead of lot of new simple ops we just grow an enum.

- Nuno S=C3=A1


