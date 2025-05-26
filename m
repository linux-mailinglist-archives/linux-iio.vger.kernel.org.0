Return-Path: <linux-iio+bounces-19926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C022FAC3D5C
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 11:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B4217019A
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883F1F2BAD;
	Mon, 26 May 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBhVMuij"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776911EFFB2;
	Mon, 26 May 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253225; cv=none; b=u6vo6XOq4/x62Y0nmkCIyBUJa8Pu7rA/RpSYdW9IgEOijgD3s4M5sEYkPgvTmjbvU3+M/U1gnayC6urXoiQQKZDhbaFBsUETTIkyaq0RW/ibMaK03c16l7n/WYRB9AJPvBK3WbyJ9x6bI+ihvIAZY/zA4hstuXOqBkMVHsdFXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253225; c=relaxed/simple;
	bh=ayi+iilYVEjRyZDjXtPujnVNmpmRyndyw79Hoc3feqE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sF4yUWIMZxPf/KNoO+K9Wv86OgCh96vDIVvTkMYG2DfJ5vXepGQePNCI1QSLCTeZt9MALErMLPFMpPt7DSNAgj1sIQRenR6yE94KNMKPRKl23kFQ2wTfZJ0v/H11EqALJYlB7WKIJNC9N+QCOam5/Xhg0DS1UgKNwz/MgJ+42bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBhVMuij; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-602e5dd500fso2738413a12.0;
        Mon, 26 May 2025 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253222; x=1748858022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXy+eKw+ntKe1vWZnveBx84g5rWssnbg4O55yPCdDII=;
        b=WBhVMuijrGM6WwmLl3VJokgaIYclijTg5LestWTC61s/KXqeETbZ2w4Q8qOsNX1SS7
         QR+vl++Tbq9y5d+yL2ch0XeoSfIcGZqgbA/2xXrPVp5+SjJdOMbHb+U3fPv2hYFdKpmO
         lRHMoGs2ML29354GoBQhFryKMUv+ngLUES5oRUi+PXqXjWgEefxVijBmCTZ6BrD+LIy8
         VWJLDEiYVY5+J5E3wGBHOt+ie4Y6NZ0MpjWNIM7wmP8v+tKT5rXiEHS3TYFUVgMDqq2J
         M9Vlsw1AKiwUCujqYMfDibknk3LwBNPsk8REcsUZimdDOhdRMewgdTXXfoVXVbztuNfa
         Hyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253222; x=1748858022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AXy+eKw+ntKe1vWZnveBx84g5rWssnbg4O55yPCdDII=;
        b=wgaxzJWAqZTCNCxBjb7e5imIUB3WI0lqzHr6UoYDFcoTErONLkOJ8ZBImhVfA9zh0K
         xsNQfLSgM7QsrFPfykuQwgm2GJpDiAFgxFH7SQHjs2DwXAQP+zO+zCWdg3DaJDEM1TQY
         Kv49SL3Cy382qEFjCnhHSvgyTeymcEMiO2Q+DrTBs9dVwlcZsRDUZrZfSDqbdqbf7ZI5
         3NHHGpm8rqAnn+6pSlFE9hN6CafgmOHhHikxNZsnOpgTDpudBlQUa43o2VzemY7z2KKb
         DYhYphmq9H/d0qDzl5Op5qkj0OBg/TtAa/f4KK7HJSUoppDc1njVjbonJkKBDO1ml/Z+
         lGgA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWj+54/fb3H4jEtm3hkhyxhiaOtF0obLiIGYOJjRduMMDbhRK9809J3nhmlh3RTmjXJ3d48c7l327IuBZ@vger.kernel.org, AJvYcCWoMuamHWjIwvagcakfhr58k+3bsS5nIkhREDdYeJckbvi0o4EkAcBU4oHMH53eYHUd9seMTTAfXX9k@vger.kernel.org, AJvYcCWpMFhAg9IFM4O4j6ZDbRxxa5rmvwTGgBemA1H2I2f3bDf8HGTjOMcxt+XuTTizvOZ/3omeSU1PrYSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCqo5RMGGfuIaNu8iqTc7ScJ8UOTA2rC+DWcLC2tYs+QRsAvo
	heoGsu7EF4sUP4RUr2a1+5O4a3U2WT/29MNi0a9kRTGGLWCLZfLvVSUq
X-Gm-Gg: ASbGnctUEQPnpXbJNHliGuJzUaQ1qSpMJXhRj6J2enbJItiW3E8yDHvILYWHmztEE13
	AZfd9LWl3bYqzYxkWFESsEqnyIe4amU9eGo78u0hwd9cKkop6vh5LA/HUeCn9NIuUnO6CPK1RR7
	DD0J0Ub/SAzyWjNiZ4Tgu531mBfhAwmSPWF9qi5OPizuiqJxHW6uRAXHArO6a2KSuWDoYyD/3Me
	Qbpd5WMweNIurzWf0jHLB0V6Rke23ZOEYFnULKxGT39rRxnPEhVs4/FFtJpgySyMnV8JxtiCJjW
	Kat8AkRLrM+TdyviYukA8n4qKRvC7vVYqA153DRYazrhe3RQeLqDOE08Pjp6wHawIKc=
X-Google-Smtp-Source: AGHT+IGRa4S8yVCYNRKNxt+ZYbckrrkS8/+MXVDubpUZ5JCrPN2kkprLkP7za5MpRF6S+CpbcWORlQ==
X-Received: by 2002:a17:906:6a01:b0:ad5:465d:8855 with SMTP id a640c23a62f3a-ad85b1f93ddmr875000866b.36.1748253221191;
        Mon, 26 May 2025 02:53:41 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498909sm1633929266b.126.2025.05.26.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:53:40 -0700 (PDT)
Message-ID: <0fb2756ce0e34be56df40187370a28d7a2a3f321.camel@gmail.com>
Subject: Re: [PATCH v4 3/6] iio: adc: adi-axi-adc: add
 axi_adc_oversampling_ratio_set
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Pop Ioan Daniel	
 <pop.ioan-daniel@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,  Dragos Bogdan
 <dragos.bogdan@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>,  Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman	 <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>,  =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?=	 <joao.goncalves@toradex.com>, Thomas
 Bonnefille <thomas.bonnefille@bootlin.com>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 26 May 2025 10:53:43 +0100
In-Reply-To: <556bb250-d7c6-48aa-8773-26799265f782@baylibre.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
	 <20250519140220.81489-4-pop.ioan-daniel@analog.com>
	 <556bb250-d7c6-48aa-8773-26799265f782@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 10:15 -0500, David Lechner wrote:
> On 5/19/25 9:02 AM, Pop Ioan Daniel wrote:
> > Add support for setting decimation rate.
> >=20
> > Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> > ---
>=20
> With the bit below fixed:
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20
> ...
> > @@ -381,7 +397,8 @@ static int axi_adc_ad485x_data_size_set(struct
> > iio_backend *back,
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backe=
nd *back,
> > -					=C2=A0 unsigned int ratio)
> > +						 unsigned int chan,
> > +						 unsigned int ratio)
>=20
> I think this change belongs in the previous patch. Most importantly becau=
se
> it could cause a compile error during a git bisect, but also because that
> is where it logically belongs.

I was wondering about this. Definitely needs to be in the previous one...

>=20
> > =C2=A0{
> > =C2=A0	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> > =C2=A0

