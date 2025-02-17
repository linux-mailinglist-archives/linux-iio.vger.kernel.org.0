Return-Path: <linux-iio+bounces-15624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D8A380AC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F658188BEAA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A317E019;
	Mon, 17 Feb 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7ybEmHV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361823CE
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789283; cv=none; b=EAW4ou2mDkj7zwoyC9xZuYE+kVOXPa9ocO6CA+5NpiR6SEYFzRJfuNv99V1KLc3e6hgBJV5rUsjzAxTffC+jQBkr/KsfyEc5nBaOFc+sTeRbLeachcZIgxAKCy0+tn978OQB5nFvy42Bqq8lvPIjooFmrmft6vKt8wHHD845+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789283; c=relaxed/simple;
	bh=UrjOCSFd4D4PT8o6+N3durhFgQQRPF4cEhNXFK/ss0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWhHQuxvobSWJUIprtXuwjF+zjFIfpcptKTLQEXgEW9vuNSAdd773qbY0MThBMAENFSrSsynC1v7Aao6ybNZnCywVQREix6fad9PIKiC1yMRsbmlpm8nNLzSeW07mZOpBtL/I0NYfOLjnIYFDHhswPo4IqZhRjq4TxBe+a7eu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7ybEmHV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so2329991f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789280; x=1740394080; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XoNz7hVDVst/IK29vx/tM1pWJGiQgWuDJ8YcPk3Wfvs=;
        b=Y7ybEmHV+w5mmtyqBUpx/eC3TnAKijoTtvO76YW72JHYzG1k3QZhE26QjWVcBZmj7L
         Hq740EFNAPhDJW/JqvnL65/EE0GDF7+c4n4MhIlmb0QnISsEYrFkwcn6bTp96W9aMzlQ
         3hjxuI3I3oOZDXNB8aaQxAljLjy9nvqDcPXHgbTZZSUKIb8LnoDYqW8Z7pdmBNwcLFYY
         ZObaGOpH80LzoePp1mrmDvA0DEi3VV1kihiUsqq6DVuPH73XNzZsoH7idQM1gkM6qZmp
         nkjNiY/rJWDXZUI0CL8gRyr7NfcaFLj61Iupg6XRMpz3GDtxoy6jfSDKQyHbLRD395Y1
         1nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789280; x=1740394080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoNz7hVDVst/IK29vx/tM1pWJGiQgWuDJ8YcPk3Wfvs=;
        b=qbhDIpvlBRmRawWCqhT4AE+ejQj1W/Pks1wJ72n6Dyl0gYk/MvX9vGGiKnpba1iQp5
         b17ZBZbJScN3S4xvc3I/DgDs2GCRNvbdd+AiDWdpf/lONh/Nft5sGVqc4bJVoKtOwzYC
         +7bzLmUxu6sBgd99iGo29r00NigUQQrrPmLC4YM33PYkY0iIHIJn4420cBmBoLYWqco9
         D/x3ba+riVvsFc6p+0kf7W2+AS64UO7Pm63CsNeTOZYzP0OoyOxE2aakvGUQDkDuMf5c
         nJYA+70M/XObsUK0UJdwzCmF3W/yBBzcCvwA1BtJWEQPwp911O901Ve/lLSkQKXyUFoS
         /7kw==
X-Forwarded-Encrypted: i=1; AJvYcCVYudm7NbsQl6s5eMZMPyOZWm2TWnTZt6RKmDInF6Y1ufbSfI74tsu0ySzs0lJSknWHEbPFqmPrBdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCCkDAXBCF9JOvRH+j8ehp+K+e5GAZftMzmzzgYLKlCdKIg0V
	PcH+N1Up6ndPBcO8AMbAj+0DBorW/hMRmg+cCdao0dRViADSWi78
X-Gm-Gg: ASbGncsL6uzqXIOxC/bgF+MfWgWLQ9mt5L1hQ0mw2pnMxlohg2JJSBSW7NBMX2ksx4U
	nLmlmOqUCrdz6mIF5q7FbeSetGncibxT7kMLHcjYtqDoucuLGRtdgHxsGW9UhBtBFmFiVvkEnoB
	agM0e+u7OAUAydgeLYXgXMbVTuKxKRt5LOtJ4LLym13kSzOHWhLRTdH9NXqFGNPd0DnmbwnawjX
	AUG0aOpFnjFg4h/sjmcp0I+wKhhUrWeFI5ncqs1ITP1FH5ipezIeLAEKpJ08odudled4X52FyZf
	FFA/22NCIVZ1XaP6u6/RoqZBuffyEfXbG9YTDqWXDvW0yXqzYoWQGltCT/HU9mY=
X-Google-Smtp-Source: AGHT+IGHdKVgT4DSF4ee5qkZoeokA63dOfdMq0p5PVRT9psM+8fKmGZeZn4/69hXWzos7mU7+DymAA==
X-Received: by 2002:a5d:5850:0:b0:38f:31b6:4f30 with SMTP id ffacd0b85a97d-38f33f4a8c6mr10691367f8f.35.1739789280168;
        Mon, 17 Feb 2025 02:48:00 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdb19sm12194099f8f.95.2025.02.17.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:47:59 -0800 (PST)
Message-ID: <a8b34cb7270ab2045894a978797023a8c7fafd63.camel@gmail.com>
Subject: Re: [PATCH v2 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, 	linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, Cosmin
 Tanislav <demonsingur@gmail.com>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:48:03 +0000
In-Reply-To: <6db4821e-9cfe-4256-a357-51a00a50d083@baylibre.com>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-12-jic23@kernel.org>
	 <20250216181907.40d36bf7@jic23-huawei>
	 <6db4821e-9cfe-4256-a357-51a00a50d083@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-16 at 13:00 -0600, David Lechner wrote:
> On 2/16/25 12:19 PM, Jonathan Cameron wrote:
> > On Sun,=C2=A0 9 Feb 2025 18:06:08 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >=20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > This complex cleanup.h use case of conditional guards has proved
> > > to be more trouble that it is worth in terms of false positive compil=
er
> > > warnings and hard to read code.
> > >=20
> > > Move directly to the new claim/release_direct() that allow sparse
> > > to check for unbalanced context.=C2=A0 In some cases code is factored
> > > out to utility functions that can do a direct return with the
> > > claim and release around the call.
> > >=20
> > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > v2: Typo in commit description (David).
> > > Note there are several sets current in flight that touch this driver.
> > > I'll rebase as necessary depending on what order the dependencies res=
olve.
> > I've done this rebase and applied on the testing branch of iio.git.
> >=20
> > Would appreciate a sanity check if anyone has time though!
> >=20
> > New code is as follows.=C2=A0 The one corner I was not sure on was
> > that for calibbias reading the direct mode claim was held for a long
> > time.=C2=A0 That seems to be unnecessary as we have a copy of osr anywa=
y
> > in that function used for other purposes.
> >=20
>=20
> ...
>=20
> > =C2=A0	case IIO_CHAN_INFO_CALIBBIAS:
> > -		switch (chan->type) {
> > -		case IIO_VOLTAGE:
> > -			iio_device_claim_direct_scoped(return -EBUSY,
> > indio_dev) {
> > -				ret =3D regmap_read(st->regmap16,
> > -					AD4695_REG_OFFSET_IN(chan-
> > >scan_index),
> > -					&reg_val);
> > -				if (ret)
> > -					return ret;
> > -
> > -				tmp =3D sign_extend32(reg_val, 15);
> > -
> > -				switch (cfg->oversampling_ratio) {
> > -				case 1:
> > -					*val =3D tmp / 4;
> > -					*val2 =3D abs(tmp) % 4 * MICRO / 4;
> > -					break;
> > -				case 4:
> > -					*val =3D tmp / 2;
> > -					*val2 =3D abs(tmp) % 2 * MICRO / 2;
> > -					break;
> > -				case 16:
> > -					*val =3D tmp;
> > -					*val2 =3D 0;
> > -					break;
> > -				case 64:
> > -					*val =3D tmp * 2;
> > -					*val2 =3D 0;
> > -					break;
> > -				default:
> > -					return -EINVAL;
> > -				}
> > -
> > -				if (tmp < 0 && *val2) {
> > -					*val *=3D -1;
> > -					*val2 *=3D -1;
> > -				}
> > -
> > -				return IIO_VAL_INT_PLUS_MICRO;
> > +		switch (chan->type)
> > +		case IIO_VOLTAGE: {
> > +			if (!iio_device_claim_direct(indio_dev))
> > +				return -EBUSY;
> > +			ret =3D regmap_read(st->regmap16,
> > +					=C2=A0 AD4695_REG_OFFSET_IN(chan-
> > >scan_index),
> > +					=C2=A0 &reg_val);
> > +			iio_device_release_direct(indio_dev);
> > +			if (ret)
> > +				return ret;
> > ////THIS IS THE BIT I WOuLD LIKE EYES on.
>=20
> Looks fine to me.

+1

- Nuno S=C3=A1
>=20
> > +
> > +			tmp =3D sign_extend32(reg_val, 15);
> > +
> > +			switch (osr) {
> > +			case 1:
> > +				*val =3D tmp / 4;
> > +				*val2 =3D abs(tmp) % 4 * MICRO / 4;
> > +				break;
> > +			case 4:
> > +				*val =3D tmp / 2;
> > +				*val2 =3D abs(tmp) % 2 * MICRO / 2;
> > +				break;
> > +			case 16:
> > +				*val =3D tmp;
> > +				*val2 =3D 0;
> > +				break;
> > +			case 64:
> > +				*val =3D tmp * 2;
> > +				*val2 =3D 0;
> > +				break;
> > +			default:
> > +				return -EINVAL;
> > +			}
> > +
> > +			if (tmp < 0 && *val2) {
> > +				*val *=3D -1;
> > +				*val2 *=3D -1;
> > =C2=A0			}
> > -			unreachable();
> > +
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > =C2=A0		default:
> > =C2=A0			return -EINVAL;
> > =C2=A0		}


