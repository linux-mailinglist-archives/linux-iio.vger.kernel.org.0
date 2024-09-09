Return-Path: <linux-iio+bounces-9369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4D19712B2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A01E1C21AA9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4861B2519;
	Mon,  9 Sep 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7VT9iYw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726B176237;
	Mon,  9 Sep 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872211; cv=none; b=PI+w3kYK1bGnZKW231BPBnFS4ZFYzRigEfwELRpxwIJ+Awvdn8DG4cbQyKDL5xILxDiGUCbccLd9wV+aHZedRvnOhCODPcxWEH6+2yg3IBYmhD7MdibFY66+/sqJdMEjMmEWTT4C7xeFZUGAY0L5+uKyjE58m3sBGt2wlMg5Qm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872211; c=relaxed/simple;
	bh=IHVEyXjXEadqqP4bsMBt8xo2VWroQd70mE6fg0tm3MA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNc8XNeR/lDsFeTbrry8FjMlVTcHfjEp5WmjxbDf6lZOUs9WkAgrycJ7xvlV13AB3LF2aI9MXlxQeoE/2n6RKv8c3IFCibUxAn0d9aSwWwDtZjPU0AZGNi+dMevRAanHIQBz97XUVUq5B6kv1EqD4UbNs0aBPWhaSx8KNlVNZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7VT9iYw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae102702so17717375e9.0;
        Mon, 09 Sep 2024 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725872208; x=1726477008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/BmGU95A8hfLAsZCZFz/EirdQEHMm/2AkTfuMxVV4Mo=;
        b=U7VT9iYwPf1jwOlAjZyhd7UrzU5+46T0QQQFFHeLs1cxLywvlsGZDLAOX5GzEf8/wD
         rSwtwjPVKCAY5T2rvzQ215RTb0je2Y60AfVV6Z+Txii/DPrd7TEL69Vv2/vvi1s1tcwa
         lLjZ7dB+MqFxCcLOjYx3/A5121feiAG4qsn9tcLvDpeYbf/tdl37oW2WwIwJaXKLN2UX
         QofQm/DwONMQJs1uBcY02uU15qmxx91yItHxeGnoQeBbD72LCws38injR6P7EqUhVx6V
         erPnUd5+4kINrIjHC+7HEfUAY3qm3mJct2o4eeKEXVVnOWVNtyT8wVSuFBy9gOGBdG18
         OVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872208; x=1726477008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BmGU95A8hfLAsZCZFz/EirdQEHMm/2AkTfuMxVV4Mo=;
        b=Ez0sLgQSbvApG0npKLnhyeM+9JdW4NoLg+hwslOnHl8Uc9gftWhntd8obx0uQB4KW1
         b8BKEQQs8cd4q5bym4CJAtN607tb3STOy0Je14fz7oe0irZ08w9jM4LNTIVDV4Wv3n15
         g3PJhw87xSczvMX1U5TGDpdfeyQjuLqZ9Q+fmj+sqCeJp6HydC1sZY200qVxR29eRn5q
         1Hrb8HKyaVKin3T4NqZVUxoiwk1IbqGn93n9I+9/Vbqn6++7vIEKR1UBBFmJsDJUshou
         Zqf6/8MwOQHeCrrDVVIJQH4zzfce7ewnZofghDv/VjQ4rItmSY9KH4DFd1Vf1lKfcm3K
         CtXw==
X-Forwarded-Encrypted: i=1; AJvYcCURjH6ko4zRKi7vvmbQr/AMO1kyD4tDqAyfgLaDDQMSywa/ssKCrjDHQ9rPhqnVdttkfBTOnE1KaSWa@vger.kernel.org, AJvYcCVOvSQBMJYquus+t2u/W28tA0Qkmv1gdVfcP+p/7k3tlJcx4J67JlDauI+eQcuo1vyiJF5Lqt1Ik8taNjSV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ScNpQFn78/MP8Oj1i5VFizpbW63vrvcuic9EF6B7NcPZN453
	h3ZfpPwubdzjqyeYDs7w2gPTuEyOhy8Mp+KnPhFfyQvMS+PhAQ4gKJcUYuKjKKc=
X-Google-Smtp-Source: AGHT+IEHm1v1khJv8a55IRYehk34lw+ZogsDBIzuQMF7zF1B6HV7gIXGvMxLW8eAqQw5NmagzJCnXg==
X-Received: by 2002:a05:6000:4597:b0:375:48e6:f30f with SMTP id ffacd0b85a97d-37894a04036mr3606204f8f.30.1725872207167;
        Mon, 09 Sep 2024 01:56:47 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956654f4sm5443169f8f.43.2024.09.09.01.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:56:46 -0700 (PDT)
Message-ID: <d48fa85725b27be77a5542e798c0dcbd4e08765b.camel@gmail.com>
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Sep 2024 11:00:55 +0200
In-Reply-To: <b289a789-0440-4c1f-9f75-6d7e8e04189d@baylibre.com>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
	 <b289a789-0440-4c1f-9f75-6d7e8e04189d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

Some comments on top of what David already said...

On Thu, 2024-09-05 at 15:40 -0500, David Lechner wrote:
> On 9/5/24 10:17 AM, Angelo Dureghello wrote:
>=20
> ...
>=20
> > +
> > +static int ad3552r_axi_read_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val, int *val2, long mask)
> > +{
> > +	struct ad3552r_axi_state *st =3D iio_priv(indio_dev);
> > +	int err, ch =3D chan->channel;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		int clk_rate;
> > +
> > +		err =3D iio_backend_read_raw(st->back, chan, &clk_rate, 0,
> > +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
>=20
> This seems odd to me. How does the backend know what frequency we want?
> It would make more sense to me if this somehow indicated that we were
> getting the SPI SCLK rate.
>=20

Yes, this sampling frequency bit seems very wrong atm. And the thing is, we=
're
not even getting SCLK. According to [1], the /4 and /8 is for clk_in which =
is
not the same as SCLK (unless I'm missing something).=C2=A0

OTOH, if in the backend patch, that clk_get() is somehow getting sclk, that=
's
wrong because sclk is an output clk of the IP. So we need to get clk_in whi=
ch
should be (typically) 133MHz.

> > +		if (err !=3D IIO_VAL_INT)
>=20
> Would be better to call the variable ret instead of err if it can hold
> something besides an error code.
>=20
> > +			return err;
> > +
> > +		/*
> > +		 * Data stream SDR/DDR (clk_in/8 or clk_in/4 update rate).
> > +		 * Samplerate has sense in DDR only.
>=20
> We should also mention that this assumes QSPI in addtion to DDR enabled.
>=20

I understand the QSPI bit but why the DDR part? I just don't understand the
comment "Samplerate has sense in DDR only.". It needs way more explanation =
if
that is true...

> > +		 */
> > +		if (st->single_channel)
> > +			clk_rate =3D DIV_ROUND_CLOSEST(clk_rate, 4);
> > +		else
> > +			clk_rate =3D DIV_ROUND_CLOSEST(clk_rate, 8);
> > +
>=20

This division also looks to be very backend dependent. So it's far from ide=
al
being in here...

To me, the way we need to get this done is for the backend to effectively r=
eport
back SCLK (in a correct way). Then, depending on the number of bits per clk=
 (4
for QSPI), the word size and DDR vs SDR we get the device sample rate. With=
 it,
we then choose one of Jonathan's suggestion (a per channel attr might be le=
ss
confusing).

All the above said, I probably need to catch up on the above. It might happ=
en
that David and Angelo already got some more info from the hdl guys while I =
was
on vacation.

[1]: https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
- Nuno S=C3=A1


