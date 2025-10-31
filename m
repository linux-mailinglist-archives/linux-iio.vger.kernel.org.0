Return-Path: <linux-iio+bounces-25759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A2AC25C83
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1298D4F99D8
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A9D1D88D7;
	Fri, 31 Oct 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+h2GrRt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F63FF1
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923111; cv=none; b=t6+kY7V4KrL+35UIHIfbNXnD3mcfVef5hDdNDBmcIAExgyW20IWsT/d0MEXgVO7xedZH7N0KVlbZU/N2j2vopFC14AcM6ortb12gYk75kalx1sxF/JG3r4HbGhCy3hyNeWBCpQrBaiYIgIlu7MjyCSg7+I8VQeGF+yHfMmOJ0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923111; c=relaxed/simple;
	bh=PHfx0Q9IdzNJpkg3l9QMPQDVj9FBYA/TtzU/HIDEZ4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z77RRnD/N68hFtwo9tjAH7/gByi+mEk3qRgDH3mUQHFe8ndYxRq2JXl0Wnn8EEJdv9F04ukdilVnndqvLXIJdZs7x4UUtNhP88Fw6B9skNWjAT3qts0nmshkC/AeCc+oVKobypw5ssxU1zPxZk5byCK8pwFhsAfnLS3cVuZcxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+h2GrRt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47117f92e32so20607525e9.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923107; x=1762527907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2nFKb6OjwyUv6GHvaO6ykaX9Ze7PkNCHVdMa1XDQcE=;
        b=f+h2GrRtTMctvAWN/X6ixluoV8pqOC6yunWR5lQ+05pkkfgH+oixSn1T85sQ3AM2vV
         Jw+5uftOSx9brtG+3GJazzNKqr4OQvB/BWjsSa4dTPjAVjcI5eDp5g4sPytr7ujMNbqL
         lfF7KttkllzcAYllG3C/7ZSmTdCWZZfxbmQCXuk5uJW9rh063g9I0WrEt+wYLArbcKMF
         ADAMvzU0byj9baV3IG7PIJRd1kC1Yf3+UawNd0Mx1eBqHMnKbnv2BQD5Za5aO4TJtzy8
         H3co8y4C+Jua/pykhTYvbNNQODQODnkOjdpOg8R+M8NPCnE0jVINr2yfiukOLwKxAmht
         jq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923107; x=1762527907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2nFKb6OjwyUv6GHvaO6ykaX9Ze7PkNCHVdMa1XDQcE=;
        b=dOtZN/JA7rdBJh1JegH6PoIGSdYXuX1gL2setm6X3wrFNORSEMSJHH4Y5Mk0VsKLm1
         8D3QiZMRYKYoQNVa0EEEzKsxCg5of2BfKIup/XcoTfe1XvNBlRn63M5vpPenXDoCr++N
         F0nhFlmFcrBclElhaN1R4KBuqgg6ZEtKSsDtzXupZyvFgwOwcBWwmKwBgIzWxktTjZTO
         4eQCsFpiCBpFhEvOFlvccv7d1JMR8X4qVGbjDElvd0vqJONdzd/mYyUknuT98QlCSrCT
         vDuhrih9zWNrumUqNcKotgibO0yMBjZnQUvSKF8DxEd+6fSnZ9sjQXx5thbwI7PAFalK
         juQg==
X-Gm-Message-State: AOJu0YzoIJrY+GwX/xHi9fFE/06EggyukultLNhZnq5RpnN0G5HIIm9t
	9o2/dr6gJMojLAiyFUTqNozWw1kDac6CAV/V+qsj9vqdsIaCI2uFKmUZr6TcJdr5sMM=
X-Gm-Gg: ASbGnctuEB0R4PSnH+btAfQrbXiWO3/5OusW5V+gQlr50iJ9yG8PvsOgpePwgXF6Er9
	MM3J+xA2OVCDQMUsu/dBDXneTFTuukSPLBMQ3UZ8cNi4el0IgAA0kxghKmnYWB4a15w+EwzBQgl
	v0SNpGC3ADu0sxqw0wMKtgDG05lmE2s16RXPkfg8jVVyy77ghFju8WKIuM4vcSqe736ZhoZWUzz
	WAEz6vo7hEc6YQLoBN3trtLaCXcn4ACRLVpA1Ku5wI/YdVZnVg+6kKbWzmVZEdjwh77voe7Pj0H
	/kHu8+BTzezsEgscR6ebKVOle5Je/WE6IXqhZwRZVkSDd11BKl0qDUz1Dgp5yqwqEhcWnZC7UrT
	IROKJeQW92p5b8oswApZUZkkp8RVCA4yqNx3h1nsrmJ/dVii0fzj7n5Ki7t7qbKch6XOFQe4Irl
	NDPLl8P/+o5rCvNMNsExQ=
X-Google-Smtp-Source: AGHT+IFrap5lABy0mfAhtXeK5h0hFGAWlhLlv1p/txGkgMNsYx8DF2RCmly9/Rm/gBA2t4qcWF7s7w==
X-Received: by 2002:a05:600c:46c4:b0:471:13fc:e356 with SMTP id 5b1f17b1804b1-4773079c96fmr38450655e9.3.1761923106948;
        Fri, 31 Oct 2025 08:05:06 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac18bsm1254595e9.5.2025.10.31.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:05:06 -0700 (PDT)
Message-ID: <c7fa340961e12157d7a2ee67177e02e81e523aa3.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] iio: dac: ad5446: Move to single chip_info
 structures
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko	 <andy@kernel.org>
Date: Fri, 31 Oct 2025 15:05:41 +0000
In-Reply-To: <aQS9-NofUjxBoPyu@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	 <20251031-dev-add-ad5542-v3-4-d3541036c0e6@analog.com>
	 <aQS9-NofUjxBoPyu@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 15:47 +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 12:31:25PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
> >=20
> > Do not use an array with an enum id kind of thing. Use the more
> > maintainable chip_info variable per chip.
> >=20
> > Adapt the probe functions to use the proper helpers (for SPI and I2c).
> > Note that in a following patch we'll also add the chip_info variables t=
o
> > the of_device_id tables. Hence already use the helpers that internally =
use
> > device_get_match_data().
>=20
> ...
>=20
> > +static const struct ad5446_chip_info ad5310_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL_POWERDOWN(10, 16, 2),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5320_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL_POWERDOWN(12, 16, 0),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5444_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(12, 16, 2),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5446_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(14, 16, 0),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5450_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(8, 16, 6),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5451_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(10, 16, 4),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5541a_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(16, 16, 0),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5512a_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(12, 16, 4),
> > +	.write =3D ad5446_write,
> > +};
> > +
> > +static const struct ad5446_chip_info ad5553_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(14, 16, 0),
> > +	.write =3D ad5446_write,
> > +};
>=20
> > +static const struct ad5446_chip_info ad5600_chip_info =3D {
> > +	.channel =3D AD5446_CHANNEL(16, 16, 0),
> > +	.write =3D ad5446_write,
> > +};
>=20
> Seems same as ad5541a_chip_info(). Do we need duplicates _now_?
>=20

Yeah, it seems it was a duplicate before. I guess it could be a precursor
patch. Or if there's no real need for a re-spin (other than this), it
could be a follow up one, maybe?

- Nuno S=C3=A1

>=20

