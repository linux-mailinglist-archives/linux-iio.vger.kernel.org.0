Return-Path: <linux-iio+bounces-4618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA378B5231
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 09:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1EC1F21A96
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 07:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0013AC5;
	Mon, 29 Apr 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVMZflnj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246510971;
	Mon, 29 Apr 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375247; cv=none; b=uq2C9eW2M8a2BkPZ+TPzO3Fl8rKQXnqOPVpD0WIpv2YuhujBT9H0Ud6DXKpvMul7nm9kfqM1OW9dJAwfPw1gr/xEYIcMORQ0zCvvrCE3SgZBVl6kvlocilhSt7/yCTp2DC5rure2WFslF9R6WhZExX2uO0augjq1EEM6r0WGpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375247; c=relaxed/simple;
	bh=FaZ+FTwuhJV/kjew2rB30wE6OM5b3S3I9tzJXoha6+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6G/NEU5mp1cAo+kVFqMXvyInM3FBa06zTFz30cpcQJxg16es7TF6F81XdZV22M2arjd+wFiv45cKMDc7k6wUFoSy/nwY5s6B1dRN6xHq/Bb7DRcX9fXGtdulk3f0N6KEzZr4ZlZcwVetmZhSB5/Lyh47H7ODLkRyC/owH2pbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVMZflnj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b782405d5so29987185e9.2;
        Mon, 29 Apr 2024 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714375244; x=1714980044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VuRhE21XzHwDXdcbtWbCYdj1BqrENkdd7owmcqg9iKs=;
        b=iVMZflnjkZH76se+Txbr9MtqbTuHdyPtfBlOFfeklqdA9aotMiiXoOEHuWrUnOuAOe
         WkUXuAB1ukAfRUQh/Fzqr3vl0/uXEkUZ1ld04REwTS5CJjTJi5ZC9IjxsC1xmQrFD8cL
         uatbsjalEgHeEBOQ9CHvq+5ER4hxzv/8oKYCsoQEna2s28Wz1tBd+Q4oezg0Tambn+Ay
         ek/MBv+T9t8A72jQjUFi9swFiGKq0gUbN8Wpunjl/QMRqltx4pUpKO2LukfAx6S08iTr
         K5SI/gi9VI3egfRZMkHcPh4+6RtuhbDeEJsE+6l9mMiqH0DdQqKVNKyBzJFQ1XJMpHa/
         Kr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714375244; x=1714980044;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuRhE21XzHwDXdcbtWbCYdj1BqrENkdd7owmcqg9iKs=;
        b=JYnX8VCNjqcCX11mp+A2DkKgR/TbwZ9XHQtzctYAyb56gMV2obdxMv//wyohYTLphG
         5a//WpTeDpFHS6hLlpp54Jpva8RKUfoFC7XlslEfk8rUYWd9ufWZ9GjyNIO/vTNlmbEx
         QdyRCuuKEO2/dd9mpDK/KOrzCWqF27CMIjnS7JN3ansbJFsWeKt0P+E4EUys71PHCZEJ
         Cel5j94cAQkmBWyF4+EdCzZvz9zAR0rmjjpX48Tgduk7/5EO/ZMvBd53BkT1ZOfZCmJY
         Yhz8UJbGkdzYbvN3hsLsSrSI5NXNfKrbLIVQJDk0T2pVSw2yeYwydO5qW0h58z3RBETn
         RqZw==
X-Forwarded-Encrypted: i=1; AJvYcCV2eD8D958AjGD9QBzeoYs73QoVWwYyI5gC+tymfUy4pBE3H2DeLMZoGJsf8/mIROKVMPM3cE331l0Czr/am+AXIOTD8SLt6P1E38LTY3azFGJlfA6G8RnZX8HkmOyU2mlM0Dr1kA==
X-Gm-Message-State: AOJu0YxhRLOrcgAmJ2fhkXTh32EclXIcaMJkPxuZp/HkK+w7FxMsYHu2
	LVS2lvEcio9e1I+oSXGa98N8sHQ0JqsVj0q+zwhAJ8ITpfcMITc0
X-Google-Smtp-Source: AGHT+IGcKV5p6fryFNa8FeK6yPu3HVSA3yKa3W56gy2KDYxlfl8pHaG/IX4a9qmPs1JxAKr41pjHdA==
X-Received: by 2002:a05:600c:3d9b:b0:41b:e94f:1e88 with SMTP id bi27-20020a05600c3d9b00b0041be94f1e88mr4975835wmb.24.1714375243993;
        Mon, 29 Apr 2024 00:20:43 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id bh18-20020a05600c3d1200b0041bd920d41csm7920607wmb.1.2024.04.29.00.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:20:43 -0700 (PDT)
Message-ID: <b988e9b88eb7589ed38a5f50a2b1ad10007fa1ce.camel@gmail.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ad9467: support digital interface
 calibration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 29 Apr 2024 09:24:21 +0200
In-Reply-To: <20240428183231.644857bd@jic23-huawei>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
	 <20240426-ad9467-new-features-v2-7-6361fc3ba1cc@analog.com>
	 <20240428183231.644857bd@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-28 at 18:32 +0100, Jonathan Cameron wrote:
> On Fri, 26 Apr 2024 17:42:16 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > To make sure that we have the best timings on the serial data interface
> > we should calibrate it. This means going through the device supported
> > values and see for which ones we get a successful result. To do that, w=
e
> > use a prbs test pattern both in the IIO backend and in the frontend
> > devices. Then for each of the test points we see if there are any
> > errors. Note that the backend is responsible to look for those errors.
> >=20
> > As calibrating the interface also requires that the data format is disa=
bled
> > (the one thing being done in ad9467_setup()), ad9467_setup() was remove=
d
> > and configuring the data fomat is now part of the calibration process.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> One trivial comment.
>=20
> I'd have picked up the whole series, but it feels too big to do on a Sund=
ay
> when you only posted on Friday.=C2=A0 Hence, lets let it sit for at least
> a few more days to see if others have comments.

Yeah, I kind of waited till the last moment to see if you had any important
comment (on the first version open discussions) that could affect v2 :).
>=20
> It might not make this cycle as a result.=C2=A0=C2=A0 I've picked up the =
2 fixes
> today to increase the chances those make it.
>=20
> Jonathan
>=20
>=20
> > =C2=A0static int ad9467_read_raw(struct iio_dev *indio_dev,
> > =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > =C2=A0			=C2=A0=C2=A0 int *val, int *val2, long m)
> > @@ -345,7 +606,9 @@ static int ad9467_write_raw(struct iio_dev *indio_d=
ev,
> > =C2=A0{
> > =C2=A0	struct ad9467_state *st =3D iio_priv(indio_dev);
> > =C2=A0	const struct ad9467_chip_info *info =3D st->info;
> > +	unsigned long sample_rate;
> > =C2=A0	long r_clk;
> > +	int ret;
> > =C2=A0
> > =C2=A0	switch (mask) {
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > @@ -358,7 +621,23 @@ static int ad9467_write_raw(struct iio_dev *indio_=
dev,
> > =C2=A0			return -EINVAL;
> > =C2=A0		}
> > =C2=A0
> > -		return clk_set_rate(st->clk, r_clk);
> > +		sample_rate =3D clk_get_rate(st->clk);
> > +		/*
> > +		 * clk_set_rate() would also do this but since we would
> > still
> > +		 * need it for avoiding an unnecessary calibration, do it
> > now.
> > +		 */
> > +		if (sample_rate =3D=3D r_clk)
> > +			return 0;
> > +
> > +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +			ret =3D clk_set_rate(st->clk, r_clk);
> > +			if (ret)
> > +				return ret;
> > +
> > +			guard(mutex)(&st->lock);
> > +			ret =3D ad9467_calibrate(st);
> 			return ad9467_calibrate(st);
> > +		}
> 		unreachable();
>=20
> not totally elegant but I think the early return makes more sense and we
> should
> just use an unreachable() to squash the resulting compiler warning.
>=20

As you might remember I'm not a big fan of the unreachable() but also no st=
rong
feelings about it :). Do you expect a v3 for this or is this something you =
can
fix up while applying (assuming no other things pop by)?=20

- Nuno S=C3=A1
>=20

