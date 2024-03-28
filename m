Return-Path: <linux-iio+bounces-3901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81E89065A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EBCB218ED
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCC2C6AD;
	Thu, 28 Mar 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf0dJI9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFB210EC;
	Thu, 28 Mar 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644903; cv=none; b=LxzGi9aD7l//HsUG0TreBw6/wqLN97tWxyKlETWMxGrAkkTfrIS1VBT/oKz7jDp5Lvu+zzLsx07KyVsDAxjJ0M+7jaHstwQRxikVd6WFCSvzcKGQJUCylilnKTcqUwnjQIRjgnkpyAPyuXWxwcE4wvtmQpoaaFJLDA9Z/rz7H7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644903; c=relaxed/simple;
	bh=4jxS4mQA+useKLjoAa/Alxgr3zkwF3d4TaQN+cdIWzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fjkRZJxlf6DMb3sIGt/1+EcsgZVXGfU2rlY1/foFMYSnsh2/B0SPIY3LvKTtRGxSe1olodzjsav16UciNS8oE3dpE2sPosa6Sr43sXAh9kwj5rKN9bD+S2JP7UjvLcLHJiRAg3bzGGZwgTL6A4g3EMxLgm/GRwyHLBk7bwfD70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf0dJI9T; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso154646766b.1;
        Thu, 28 Mar 2024 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711644900; x=1712249700; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=70ZGFL91YHlHNGTIlb0xaZCbRIitQgk926egsBYhjoQ=;
        b=Wf0dJI9TObqgfBoxhHgP3ZoJXFCV2FGzSeI4H92GlDxjoI5cbL/L6ci443AZn+MQrO
         jQsfEYZRc9Vp2mo/d+8YR1d9PQjCww5fNxVcTpBYlkAwBfA2STIl57xpEk57PCvxmex9
         YyztGPRdfVpq7viDbbRzCUAk4APDn62Q6nAEs7FHsNWsIRq4zZ3iTidgMbWqDSYGQ4Cu
         +TsQF7/9GISfmNc6JZad4rqftgARxm+nmOIlcSlpklkcu8a5z7P9bBL02WKsGAjWOQ0p
         xPFYikpVx8cLLMQaWgcZvG6aniyrHz3cQxRjSyhvMbzjx4vqfcmH+i78o10TRNg1B9fH
         4BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644900; x=1712249700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70ZGFL91YHlHNGTIlb0xaZCbRIitQgk926egsBYhjoQ=;
        b=gBgOV6KN17z8ZDFgPq3PfIKrdNzZCZqaYmPPaGc8jlLAFp+yoneaBZY9o3RwPj6RpR
         YMsnYhgLobKUzVcPp5Z9Mi+fLnwUyDEeSxv+b1xzy+svGwbPyvL0N2UrXq0sZmTTYaZT
         4nQbegRqTpDBQEKi1PtWYZ3vGMf+bmh/84uajfRds5KF8h4vWf/7j1qky0mQ8Eyq1wlh
         OiTXbcJTa0iMVRJ/+oRi2H6pOrBzvGhU8lVk9ZTMh7pMha6NIrpIiTExTmw6kGnv2a5R
         RgYzyPg3FWwhc5kVtWebuyLbTfPdngJShUg372X8JF0rctiPia+RIsPoNCJNv4t407NE
         YuVg==
X-Forwarded-Encrypted: i=1; AJvYcCUDGq71DeLDf8ZyFEzYs+HNmidUNYOIMoMYYfZdZ2XZtiI1mOGI9TO+oNORsOqFBVF1OaDUnQiiegF/bJbNViHgopFtpLryEHoyII92AASMpmzLpcc0FGIq/KUFb1frZq0Ldfd1RQ==
X-Gm-Message-State: AOJu0YywvYcjlypiLpjhw7bOwTPhsE7KTnrkfjjtvdvdKQjrVcXtUkhk
	iNOnMLiaIhevhYgsR/0IrKMMiCqhotwnJkIwSiiTGcIeqSySwnC7PlZhojrfr2A=
X-Google-Smtp-Source: AGHT+IFVH9hJpL4J73VBtz8U9m8GQe03oPIbxB2EC1enlCDO6k3m8JMeHE+A3+FCFoVu+1DeZjdz4A==
X-Received: by 2002:a17:906:aac8:b0:a47:df55:cf6c with SMTP id kt8-20020a170906aac800b00a47df55cf6cmr2600938ejb.63.1711644900173;
        Thu, 28 Mar 2024 09:55:00 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id gy16-20020a170906f25000b00a45f2dc6795sm941540ejb.137.2024.03.28.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:54:59 -0700 (PDT)
Message-ID: <1e5e8b0764b3a42059be4c20724d475c83e5d241.camel@gmail.com>
Subject: Re: [PATCH 08/10] iio: backend: add new functionality
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Dragos Bogdan <dragos.bogdan@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 28 Mar 2024 17:54:59 +0100
In-Reply-To: <20240328155929.20848a6a@jic23-huawei>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-8-afc808b3fde3@analog.com>
	 <20240328151632.298bd95f@jic23-huawei>
	 <cec2ac9c67aeae7c59434a86713f35461d171c04.camel@gmail.com>
	 <20240328155929.20848a6a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 15:59 +0000, Jonathan Cameron wrote:
> On Thu, 28 Mar 2024 16:42:38 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2024-03-28 at 15:16 +0000, Jonathan Cameron wrote:
> > > On Thu, 28 Mar 2024 14:22:32 +0100
> > > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > =C2=A0=20
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >=20
> > > > This adds the needed backend ops for supporting a backend inerfacin=
g
> > > > with an high speed dac. The new ops are:
> > > >=20
> > > > * data_source_set();
> > > > * set_sampling_freq();
> > > > * extend_chan_spec();
> > > > * ext_info_set();
> > > > * ext_info_get().
> > > >=20
> > > > Also to note the new helpers that are meant to be used by the backe=
nds
> > > > +		return 0;
> > > > +	/*
> > > > +	 * !\NOTE: this will break as soon as we have multiple backends o=
n
> > > > one
> > > > +	 * frontend and all of them extend channels. In that case, the co=
re
> > > > +	 * backend code has no way to get the correct backend given the
> > > > +	 * iio device.
> > > > +	 *
> > > > +	 * One solution for this could be introducing a new backend
> > > > +	 * dedicated callback in struct iio_info so we can callback into =
the
> > > > +	 * frontend so it can give us the right backend given a chan_spec=
.
> > > > +	 */=C2=A0=20
> > >=20
> > > Hmm. This is indeed messy.=C2=A0 Could we associate it with the buffe=
r as presuably
> > > a front end with multiple backends is using multiple IIO buffers?
> > > =C2=A0=20
> >=20
> > Hmm, the assumption of having multiple buffers seems plausible to me bu=
t
> > considering
> > the example we have in hands it would be cumbersome to get the backend.
> > Considering
> > iio_backend_ext_info_get(), how could we get the backend if it was asso=
ciated to
> > one
> > of the IIO buffers? I think we would need more "intrusive" changes to m=
ake that
> > work
> > or do you have something in mind=3D
>=20
> Nope. Just trying to get my head around the associations. I hadn't though=
t about
> how to make that visible in the code.=C2=A0 Probably a callabck anyway.
>=20
> > =C2=A0
> > > As you say a dance via the front end would work fine.=C2=A0=20
> >=20
> > I'm happy you're also open for a proper solution already. I mention thi=
s in the
> > cover. My idea was something like (consider the iio_backend_ext_info_ge=
t()):
> >=20
> > if (!indio_dev->info->get_iio_backend())
> > 	return -EOPNOTSUPP;
> >=20
> > back =3D indio_dev->info->get_iio_backend(indio_dev, chan_spec);
> >=20
> > It would be nice to have some "default/generic" implementation for case=
s where we
> > only have one backend per frontend so that the frontend would not need =
to define
> > the
> > callback.
> Agreed - either a default that means if the callback isn't provided we ge=
t the
> single backend or if that proves fiddly at least a standard callback we c=
an
> use in all such cases.
>=20

I'll have to think a bit about it. We may need some association/link betwee=
n iio_dev
and iio_backend in order to "if the callback isn't provided we get the sing=
le
backend". The easiest that comes to my mind without much thinking would be =
to use
iio_device_set_drvdata()/iio_device_get_drvdata() in case the frontend does=
 not
provide a callback. This would already force callers to assign the indio_de=
v->info
pointer before this call. Not that nice but acceptable if properly document=
ed I
guess.

Anyways, I'll see if I can think of something better...

> > =C2=A0=20
> > >=20
> > > =C2=A0=20
> > > > +	iio_device_set_drvdata(indio_dev, back);
> > > > +
> > > > +	/* Don't allow backends to get creative and force their own handl=
ers
> > > > */
> > > > +	for (ext_info =3D chan->ext_info; ext_info->name; ext_info++) {
> > > > +		if (ext_info->read !=3D iio_backend_ext_info_get)
> > > > +			return -EINVAL;
> > > > +		if (ext_info->write !=3D iio_backend_ext_info_set)
> > > > +			return -EINVAL;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, IIO_BACKEND);=
=C2=A0=20
> > > =C2=A0=20
> > > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backen=
d.h
> > > > index a6d79381866e..09ff2f8f9fd8 100644
> > > > --- a/include/linux/iio/backend.h
> > > > +++ b/include/linux/iio/backend.h
> > > > @@ -4,6 +4,7 @@
> > > > =C2=A0
> > > > =C2=A0#include <linux/types.h>
> > > > =C2=A0
> > > > +struct iio_chan_spec;
> > > > =C2=A0struct fwnode_handle;
> > > > =C2=A0struct iio_backend;
> > > > =C2=A0struct device;
> > > > @@ -15,6 +16,26 @@ enum iio_backend_data_type {
> > > > =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> > > > =C2=A0};
> > > > =C2=A0
> > > > +enum iio_backend_data_source {
> > > > +	IIO_BACKEND_INTERNAL_CW,=C2=A0=20
> > >=20
> > > CW?=C2=A0 Either expand out what ever that is in definition of add a =
comment
> > > at least.=C2=A0=20
> >=20
> > Continuous wave :)
>=20
> Spell that out.
>=20
> >=20
> > > =C2=A0=20
> > > > +	IIO_BACKEND_EXTERNAL,=C2=A0=20
> > > What does external mean in this case?=C2=A0=20
> >=20
> > In this particular case comes from a DMA source (IP). I thought externa=
l to be
> > more
> > generic but if you prefer, I can do something like IIO_BACKEND_DMA?
>=20
> So from another IP block?=C2=A0=C2=A0 For that to be reasonably 'generic'=
 we'd need a way
> to known where it was coming from.
>=20

Yeps, in this case comes from the IIO DMA buffer which in HW means a DMA IP=
 core...

> Now I remember advantage of reviewing on weekends - fewer replies during =
the
> reviews :)
>=20

:)

- Nuno S=C3=A1

