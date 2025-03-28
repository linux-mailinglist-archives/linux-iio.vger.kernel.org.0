Return-Path: <linux-iio+bounces-17306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C2A74571
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053853B3781
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8D212FA3;
	Fri, 28 Mar 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvWcrJ8k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311C153BE8;
	Fri, 28 Mar 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150673; cv=none; b=WcEXjTyYOWwZ9DsKL6+eGWbEEutyngaMMclqLX+Vm1Vhpl34nDXBWiyeCx3NUqEdY5Jj+kuH1zTkWihTwImf6emyBm3hZg1ca7taj8O8HPHQOtbFRrW06MWMJPiiUqXeJca7py7Rj3Y9tZQg+/iQrh/5xjekSz+nSJmt9i9iMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150673; c=relaxed/simple;
	bh=RV0CjmH8QYRgCiBSGK3Cnp6V0pSiVXDyVBYkfINLB6I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0XYWLU0+SFK5ICaqmphRHglXTpC7gfAsSUIv25HrgFb9OyKyJ9lqMigafDIZ4pfDAY1WybmeKYsZZ3h4lE3m4Xw1lyGc4MoWb10mrYqKhoW/YYbNcmk8eEpsFxQ574w/apHHPcoyjkfgIzfzQO7AwiQSlyS1JI6Ru33U4UqHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvWcrJ8k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso13378875e9.1;
        Fri, 28 Mar 2025 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743150670; x=1743755470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQE8MJbln6l8bWbgcy+D13myK6deDTKtx1pmrOTSZWg=;
        b=jvWcrJ8k7CwQdTR0MwbJngmnr7r5foRkg5RFBoDqBSnFBMILhDrO74tXJHlRjiTMMK
         mfxLZnEK31Brq/miy1OCVNfauVOcxXa1FvU/29f/tTCHPaYPEercWZJ1ftjGrjdAATQU
         Y+DS1vItEgX6B5W5RSYfaGv+Ov4EIZ8kgVYikuRdfitWtlS/cjw/RqGS/zdg95d+lEgR
         6oUs1AN5qTrr09Zs/I9dj9CC4A0JPAghOPo0LEgitu45ZiOAFM8UvG/+u9WzGZdC9TYW
         qOHrdjQj/ri+KWnpZR8jAbLPpbd5cgwEPXs6Js8AaVA1FmXAhiso+GUhc0/d01Pkq+rd
         BSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743150670; x=1743755470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQE8MJbln6l8bWbgcy+D13myK6deDTKtx1pmrOTSZWg=;
        b=EM0AuIxZcpWbsO5oAeZZEe644+HJ6jvFoOZ+G7kqj+zvcasdnKG3WRFN7A9Q3yS/UO
         FGiiG8pQQmiVhnHjQFqDqaad5/uxKdAFLlS8K3ALiRzlaWa64wJZCRcfP9KIov8KTKn1
         cYnbvRJN6Bd/zbEkomof6q/QRoeZ9RWmQxuBS0kp0rVaZvSpXHF/HA10jHL2mvofL7vW
         EqCvMMDjRzKpuk+jPxoGYnsoxC5Jz0qJAx49TVXIgn5hIASsdgrQZjsiErf6tKuX2eqi
         zQvO8Zd8sL9oHuj7xAlcj6jIabg83UN3uT/FYQaznApp/gvpBb3BPs9Mt3cbKgMbwqvq
         MVRw==
X-Forwarded-Encrypted: i=1; AJvYcCU5nZvDmnQUv/mPMVSruFvJ1+Ki2ZDvxrhRvPaTn5y8OK2gaieFTDMlPHeFEHLrKQ7+cWM+EM8od4LMZD/z@vger.kernel.org, AJvYcCUIRoz/ZmPFPY8Gmj+7J+4l2H/jghrEKOV9TH9kItWsnWSMejygLGEVyqfvPDgatQmyGR2tcZLu7tNh@vger.kernel.org, AJvYcCV9w/yT4Z5c3uf6PLMIzuwYHkwGzpbOiRNlptQGQu+oLM6NLBZKpL7gi/SbMEd3Yf8+gOd8furpQbOO@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4dNKTBSKfWBlg/3Qcqc+0ujz+k6ERf+nQdEiknMM4rDNJ15F
	VMdOcxyL0sU+8C06Zk5RlCn6fnYTPW9PePQsTva9BAuEqtaSTWvC
X-Gm-Gg: ASbGncun50f024270uwatbZMgoM14XjgP0dH1iEifosvlrFp5r1QxlyM2ZpLBSF+/Yp
	4ZpjyeillZYrEmfIZQir61feypUzephJob8d8bjFaFrhzilgaAwfJX+nMWEgyreJDZacyFFXbmN
	6rnE7d0ZGkFyxXtSGFRaqLZ44O3wGjgvQnJLuwMmrn32eb/WZOiQI8HJZOScTmdl7qE/0w+NiKe
	zjgI1YUGb7J5wWjh6uENL89kKExvjI5o+8gMJdC/AucirghT9I6c5NUCUuks20lK7SxTM71Ubu1
	rc4iXBJn4V2pnzXdmytv7hQ8/ogzSiIFOT0zWxUzthInT0ikWwrW7jV7Xd5w3kzjJzPZ4ZN6xa4
	EcZrEvFDJ4O9XGcnweME=
X-Google-Smtp-Source: AGHT+IGI2eJg7BHRpn3r51sDH5p+MRaRhGiL0S/Kaf3UkvfdxC0LWaMxZljHzx49GypwiWGPKM3cFQ==
X-Received: by 2002:adf:b64f:0:b0:39c:dcc:5b2a with SMTP id ffacd0b85a97d-39c0dcc5b72mr742495f8f.39.1743150669634;
        Fri, 28 Mar 2025 01:31:09 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a41b4sm1869337f8f.85.2025.03.28.01.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:31:09 -0700 (PDT)
Message-ID: <c8ab344480e57ffe7eb0ec73d509de25ea5cea3a.camel@gmail.com>
Subject: Re: [PATCH 1/5] iio: backend: add support for decimation ratio set
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Pop Ioan Daniel
 <pop.ioan-daniel@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Guillaume Stols <gstols@baylibre.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
  Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Herve Codina
 <herve.codina@bootlin.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2025 08:31:25 +0000
In-Reply-To: <9b565cb2-815b-4ca9-a7dc-8ca2e8eb5f72@baylibre.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
	 <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
	 <9b565cb2-815b-4ca9-a7dc-8ca2e8eb5f72@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-24 at 13:53 -0500, David Lechner wrote:
> On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> > Add backend support for setting the decimation ratio used.
> >=20
> > Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 18 ++++++++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +++
> > =C2=A02 files changed, 21 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index 363281272035..f4db6514944a 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -417,6 +417,24 @@ int iio_backend_test_pattern_set(struct iio_backen=
d *back,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, "IIO_BACKEND")=
;
> > =C2=A0
> > +/**
> > + * iio_backend_set_dec_rate - set decimation ratio
>=20
> In [1], we decided that for a similar chip we could use "decimation rate"=
 and
> "oversampling ratio" interchangeably. And in [2], we recently added a bac=
kend
> op for setting the oversampling ratio. Would it make sense to use that he=
re
> as well instead of introducing a new function? If not, we'll want more of=
 an
> explanation here on what the difference is. But from what I can tell, thi=
s
> sounds very similar to the other case where they are essentially the same=
 thing.
> On the other hand, this is internal API and not userspace ABI, so having =
a
> separate name might not be so bad, especially if there is a chance we wou=
ld ever
> have both at the same time.

If it fits, I have preference for using existent interfaces...

- Nuno S=C3=A1
>=20
> [1]: https://lore.kernel.org/linux-iio/20250112122047.1e1978e0@jic23-huaw=
ei/
> [2]:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/=
drivers/iio/industrialio-backend.c?h=3Dtesting&id=3D22894e0be908791e3df011c=
dfac02589c2f340bd
>=20
> > + * @back: Backend device
> > + * @rate: Rate in decimal
> > +
> > + * Return:
> > + * 0 on success, negative error number on failure.
> > + */
> > +
> > +int iio_backend_set_dec_rate(struct iio_backend *back, unsigned int ra=
te)
> > +{
> > +	if (!rate)
> > +		return -EINVAL;
> > +
> > +	return iio_backend_op_call(back, set_dec_rate, rate);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_set_dec_rate, "IIO_BACKEND");
> > +


