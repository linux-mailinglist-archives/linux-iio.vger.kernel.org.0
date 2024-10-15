Return-Path: <linux-iio+bounces-10598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2395199DE8D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 08:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E16AB236D4
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE318A925;
	Tue, 15 Oct 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvxukV/K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBF189F43;
	Tue, 15 Oct 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974284; cv=none; b=tnQ0H9pQ++0KeYP3bHTyw65u+USGQ4fcrtkS7itEfFHKy/BlXRB7oUQNFogb+51Uke1YrcY7S/VWFtceyoQZ2h/1HtsXjNeRcjhMg+3a3rArJ/QY346goGB20x0Afqq34KNrbpdhkGo1I6YUng66kfFo1ZwrtHWPZNoOvFLmwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974284; c=relaxed/simple;
	bh=YgD3cjpe3mkQGu5Jv6mav8icsnWQaCYCpTfcU2SgrY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9sSwJRweqZFl64caq/ZmvVCXdHiN/WG+gjaRiV2sSQQcVNOLzfyfikv+DuHlJ6jjV7cX0/5yWgCNX4sMrLk64vwQsdqV6lCX5wPFNZbsg30Kb+7GxfJ1NgM7dlrCFhXje5DyiT88S9KbNKTZZQvZfda4YbQgpSMCRNhZ92flas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvxukV/K; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe76e802so553278e87.1;
        Mon, 14 Oct 2024 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728974281; x=1729579081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F0BPR0yvcNPqJoEqgpzXCJfseSq4ZxLcZ1DyMgnB5po=;
        b=DvxukV/KP28Dohn1BliRZ3clmvXtGbN7+ynGINQL1X03Ya7xDfbcaCDD/ljDRKhinu
         DXjgjdWmOm2rJE3XnCLwa3LIgtm48/ViSmKG9EhDb709XiNZE/GFxg3nktFg1a0keipc
         /F7Y74jIKRHVzeQZ/YCihY9eNagp2UyudA7NM0BT3K1eMI3HIZqHV1ti1As79R3Utmyk
         y3bgZh7JyogV7qu04Zv2zbwyL2r7fWC8ja9/KTfwoJItuhE9eqEi4DeieLxluEOVX59J
         X0qND2HNUWiIPuyM/tw/YobizH2wFgg6qG6r9Y9Eq0EiThJIF5A45kwebduq8z3/B/zV
         YyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728974281; x=1729579081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0BPR0yvcNPqJoEqgpzXCJfseSq4ZxLcZ1DyMgnB5po=;
        b=qXun/PfXgwUcvkNJH4ogN33lojdWDtg70zbVD4qKGV5cAWrxWA2YcNO88zuUhBJApH
         4q3u/4FEqI+nWrqShdo6+ZTxsf9FB7ZC8yov0S4KzuKIA4CbLszlVON5rGO02KnG9px+
         0ZNTT5DdLKbQOr5RvNT8weCLjVUiWRkw1Ilay12EEUcJSLXNFVINuA24eWA8lZ+oVglU
         xmGIKLOsXQVCdWnYWdumCGvA58/Jyuq1/mVg8dvRcl9nVp2/3JPRxpiVOw62vaQ9WF6v
         10PIeRtn8nhZ0fqLm6qCQUztGhMXd/PMSPG8rVKKr9qXEh/qZKciHdsXmiPqDhuy+6Vc
         UMoA==
X-Forwarded-Encrypted: i=1; AJvYcCVmCj2LYbi+u3iQyRQbuYgOuOWOdUTZ1Uf6ECjL8CV5uy6A4ekwvWles5MRiT3YyGcxV3CkLGRiN1UC@vger.kernel.org, AJvYcCXRHSoVzvUhSaOT1c4lLsvAQ9VRvAAA3xJaqd7bDqzwV5v9x8DU7mZ0qKK/c570HMz3CCzssvCBUahKtvaU@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSI4FP/e3JBI7i0doGhqj1SqjrSfaWMhc+MB7hIrVx4y/B7T1
	XGhRyjADHJHrMygSEkMuf/BLcjB0hVTrSJwl9u7F//O/vBez5U+9
X-Google-Smtp-Source: AGHT+IEuwWR3ieEarmImxoKYArcYr7YwE+SQATw+oprrZt65xT0iNkFPGoZU+wWvVCJcZg+XpaToZA==
X-Received: by 2002:a05:6512:1104:b0:539:8bc6:694a with SMTP id 2adb3069b0e04-539e571daf1mr4863962e87.43.1728974280792;
        Mon, 14 Oct 2024 23:38:00 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm713359f8f.113.2024.10.14.23.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:38:00 -0700 (PDT)
Message-ID: <8642bdb546c6046e8fe1d20ef4c93e70c95c6f71.camel@gmail.com>
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
Date: Tue, 15 Oct 2024 08:37:59 +0200
In-Reply-To: <c3d55f78-5a54-49f8-b6a1-4ed0f24f8666@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
	 <c3d55f78-5a54-49f8-b6a1-4ed0f24f8666@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 16:15 -0500, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Add High Speed ad3552r platform driver.
> >=20
>=20
> ...
>=20
> > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *ch=
an,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask=
)
> > +{
> > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		int sclk;
> > +
> > +		ret =3D iio_backend_read_raw(st->back, chan, &sclk, 0,
> > +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
>=20
> FWIW, this still seems like an odd way to get the stream mode SCLK
> rate from the backend to me. How does the backend know that we want
> the stream mode clock rate and not some other frequency value?=20

In this case the backend has a dedicated compatible so sky is the limit :).=
 But yeah,
I'm also not extremely happy with IIO_CHAN_INFO_FREQUENCY. But what do you =
have in
mind? Using the sampling frequency INFO or a dedicated OP?

>=20
> > +		if (ret !=3D IIO_VAL_INT)
> > +			return -EINVAL;
> > +
> > +		/* Using 4 lanes (QSPI) */
> > +		*val =3D DIV_ROUND_CLOSEST(sclk * 4 * (1 + st->ddr_mode),
>=20
> Since DDR is always enabled for buffered reads, I think we should
> always be multiplying by 2 here instead of (1 + st->ddr_mode).
>=20
> Otherwise the sampling frequency attribute will return the wrong
> value if it is read when a buffered read is not currently in
> progress.
>=20
> > +					 chan->scan_type.storagebits);
>=20
> It would probably be more correct to use realbits here instead of
> storagebits. Usually realbits is the bits per word being sent over
> the SPI bus while storagebits can be larger.

It can go both ways I guess. For channels with eg: status bits in the sampl=
e,
realbits won't be the exact word on the bus. OTOH, yes, we do have cases fo=
r DMA
buffering where storage bits is bigger that the actual word. So, yeah, no s=
trong
feeling about it.

- Nuno S=C3=A1


