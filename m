Return-Path: <linux-iio+bounces-27823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B8D24552
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 12:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495AA3087988
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC5B3933F9;
	Thu, 15 Jan 2026 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6qgRXKg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A7389DF2
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478029; cv=none; b=oSl7xgPoieiDESamj205MIzku9Q8f7R6OQJm4H6v+42Lf4yvsgqyX7wXex2rrgBpWM+eexJ44rCWT6ZfpUc80hweIJQ5trgbwSXWEDRr1fOoZKCFmy8B/cXYDta4JUac2jaUe6EjqT0DHdo8dsLyzga/rcPYjox0uNFbnUguVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478029; c=relaxed/simple;
	bh=/XYcX4ZF6hkWrb5Pi3v0AQi1e8aX65EI/WLYoPfoLGo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+OT2kCax5gmpkBwg4/Bf2tmqqf05XztnkwDXvgZK/hp7fHUB49QgMul+7dF0yGFlWOQALlX8RzsTshLcOeDc0mW/CD/sPU98hKrOaRBhqpmgmNZCVeWppzOwFVxbyBP80YYjaxX1oMbCMvZ493+f2byJ6RfFkaqOb3BQ6DUEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6qgRXKg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47edffe5540so8647015e9.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768478027; x=1769082827; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeN1NqskDMCkofNqgbz9AjaJHZXyD+S3GI7j/r2RdhE=;
        b=M6qgRXKgxVAHUESQwY3+VZ44dwUydaqXms7yDCZxAGBxFJ5dHVDlWZGaKZQbZxlHhm
         YLDc/9eDPFhOBImmZMyoxt6yt5BAsCWKwI5CqbXGZfklyXtACbR95G47lgtF4NHxcRtI
         WHi4t9XmY7gZ/IQs59bkx9cbTS6DZdABu5T+GF+KC+BUJj4MMWzPvtBT6P7Vc2h+gLN5
         3uyNRYiJ/X5qrE3Pfbc/zwR5faHBGvZBwBAwiJHDoLg1WhopO6WlUVw27UQ4HaXo00E+
         AeYSaBH5k5FUxN2XgM99qTiPAU9IrBO7XjhwKn/8chEHc+YwWCgHEUJj0lsgFL4+XlhR
         B/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768478027; x=1769082827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeN1NqskDMCkofNqgbz9AjaJHZXyD+S3GI7j/r2RdhE=;
        b=OINHFRoZFczlnT66ToxfbK6/lFbj/+t4pOMfUvGVRlkZLXuJn0yiGm5b41ZuBDODdR
         ZS39A6ekW0nCftmdD8dEzSCWZDtavHNx7zlMDORRcDswvApFixcKVeTxJKkckHlpWBkI
         7PLv2dQnF9lGeRK16DrtVHDPjeKt1d2aI8VjAT397Npexk23d6FzlrxMfAnv864djmUP
         bNrvbx/f8VkqJOabeko5FLAldtNkS7r9ixQM8ze7kdk+Xpv8VZvZYFeZvPUwqRYaHI04
         Si87JI+DHpKuuoQs5Oc2hRR7bYt0506H0mU4jP56RRsthx3JyEcW0QeyUqJOtFS86lsq
         1fyg==
X-Gm-Message-State: AOJu0Yysaw+Q2NDeQyJawAw7oWdEt7q0vwk9YpuiNZ4JGeSFaWRcAfSU
	c7TMqmu3IigDT86FP8em7WhaZmp4Xqk5zzoWF3Pf27qXPQZ7MZtHMblW
X-Gm-Gg: AY/fxX5WVXbrosM7lwcKQgvFub3vClaC0zw6Ph4kmw5SSXt69ebLRUXnkBE/ROmOkZL
	m9XVr9sUWKiml3xPBv1ndi+oqThfupBOhK4UdB7FWKaGOF2ruJyu3b/Y1ocWPsfaO1QaNdOy23d
	NLALQqSgNRJE4F6LHpk58fcQXdJR/rp/2nkgrl/KASiFwWdmdySXiiHAztwAbh2fNcvpm21iLFN
	zNue+5Tbe3bLlNBnHEIAZAGIasruUucD8qE8QVNkP0TU4oEu0gGLFv2UOA9/+OUQSmOVi2P7UWi
	Z2K8//Y1mlD2Vl7QiH4BhFZKJeLKzA0lcZdpA63QCBkeSAOROtVhIPv7vX/G02NlVj/hh5ryIjL
	gzExTjWAcjDEdd5whLMX40967J3v+KNaTMvY7iSxaM6uw9NM+BXqTLg6ZWmRkTMRlY92pJ2YOPK
	x9vWjr0vkq5G0xgFxvZ2U=
X-Received: by 2002:a05:600c:3f16:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47ee32fd19emr69502975e9.10.1768478026429;
        Thu, 15 Jan 2026 03:53:46 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27d9aaesm44884595e9.3.2026.01.15.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:53:46 -0800 (PST)
Message-ID: <9214d1ba49ee31e4f35d8d3fe5d894142e1d6fef.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Jan 2026 11:54:28 +0000
In-Reply-To: <68cee45e-4822-41af-a0da-d1b88166425d@vaisala.com>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	 <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
	 <34e97dbb610e82953657d8354c0a343a9e1fa57a.camel@gmail.com>
	 <68cee45e-4822-41af-a0da-d1b88166425d@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 17:23 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 14/01/2026 14:29, Nuno S=C3=A1 wrote:
> > On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
> > > Add capability checks for operation with backends that do not support
> > > full set of features, but are otherwise compatible with the device.
> > >=20
>=20
> > > +		return 0;
> > > +
> >=20
> > As David suggested, it might make more sense to do the check from the c=
allers. Not as
> > important as within the backend functions though.
> >=20
> > > =C2=A0	/* all points invalid */
> > > =C2=A0	bitmap_fill(st->calib_map, st->calib_map_size);
> > > =C2=A0
> > > @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
> > > =C2=A0		return ret;
> > > =C2=A0
> > > =C2=A0	ret =3D devm_iio_backend_request_buffer(&spi->dev, st->back, i=
ndio_dev);
> > > -	if (ret)
> > > +	if (ret && ret !=3D -EOPNOTSUPP)
> > > =C2=A0		return ret;
> >=20
> > Don't agree with the above. I would prefer to see a dedicated CAP for b=
uffering
> > otherwise I would argue why not doing the same for everything? While it=
 might
> > be acceptable merging IIO_BACKEND_CAP_TEST_PATTERNS and IIO_BACKEND_CAP=
_CALIBRATION
> > (given they are related to some extent), that does not apply to bufferi=
ng.
>=20
> Okay perhaps we first need to agree on how we define a capability;)
>=20
> So my thinking here was that calibration capability expands across
> several or even many op calls, so it's a feature level thing and
> requires several coordinated functions. So does the test pattern, but
> it's a sub entity of the calibration so I merged the two together. So
> checking for a capability in these cases makes sense, since checking
> against a single operation call for determining if the capability is
> present is not easy and which function would it be, etc.

Makes sense.

>=20
> The backend buffer on the other hand maps to a single op call (in theory
> two). So checking for that buffering capability can be done by checking
> if the op call is supported (eopnotsupp). I was kindof thinking that why
> need a capability if the mapping is 1:1 and the information is available
> through that error value directly?

Yeah, TBH the only reason I can think of is readability. To me, it is more
explicit:

if (has_buffering())
	request_buffer(); //not allowed to fail

And can be a bit confusing having a mix of has_capability() and checking fo=
r
error codes.

But yes, checking for specific error codes for determining behavior is a co=
mmon
pattern so I won't be nitpicky about it.

>=20
> On frontend level, like here it is known that the driver can function
> without that buffering, so if the backend does not supported it can be
> okay to proceed.
> If we add a capability for a single operation that has 1:1 mapping then
> basically we should map all and that is not really the point?

> I see the capability like a contract between the backend and frontend on
> feature level, that the feature is there but the implementation of a
> specific capability might actually differ depending on the use case
> (like we see with ad9467 and ad485x calibration and their backends)
>=20
> What are your thoughts about this?
>=20

Ok, I think it makes sense to me but maybe we should be more explicit/clear=
 in
the docs:

"... meaning that a capability requires certain=C2=A0
operations to be implemented by the backend"

Maybe s/certain/multiple and we could even mention that if a frontend is in=
terested
in knowing that a operation is not supported, the error code can be checked
(though this could be obvious already).

Let's see what Jonathan and others thinks about it.

- Nuno S=C3=A1






