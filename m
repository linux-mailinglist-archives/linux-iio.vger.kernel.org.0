Return-Path: <linux-iio+bounces-2177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE91849598
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 09:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9293B217D2
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828691170E;
	Mon,  5 Feb 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaBP6wHK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCC111A2;
	Mon,  5 Feb 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122679; cv=none; b=c/+1YjSRAQDOWFlPjZuXl0Bpow15NuEofvPX5mFBOa6B0XLfdGV+Ps8Ukrz8iVKsDDA7XZAu2szHhoXi24CXtHTd/DkR0EkemtF9JQjM5zsqLB6fwe0ViAvxIU7AFNovqLj338jWS+p9WfVMF2tnJ9o9UkN5QedRE52OATOdNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122679; c=relaxed/simple;
	bh=0acNVRvEL+4cX9aUrDUK2bMmT2Fun2Rqh5ryQH9BdGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vo7awN0tzfh0irqYD2S5lUNyBbjOOzk6V104hKDY6SCDslnO8c/tW/MXF63H4vj4MNxJDflcQJ/RZLkcDyR5Sy3V9AqPrcYXVP/Mge2sSy2urDLLAx45xd7VA9Mv3/SRYkFM1NsaCQYchHXD5GYJnrhOBg6D1g1712dffYK91/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaBP6wHK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso34102495e9.0;
        Mon, 05 Feb 2024 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707122675; x=1707727475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5GWVRIre/A4VgFXhKfqdegG0tissbji1iue8FfAYEzA=;
        b=GaBP6wHKJEDU4F6IIi87bJG0MOdcOf+CWTtBvaflyAUE5KX/8gRwgST26wJGlpHgQX
         QV666bPztvXuKNeoThJ3OABrKa1xa8rWqWcB00G0xAM0jScflSPGvehd6RdRYsm6ebh7
         vNcov345c/I4BYJHWrPJm4+LxNnf8KKnM3e1DmLH/KG0WgUd5yf2b2ja7q0r7xDJ3jm1
         M/z2ztOuJrt6wLToruxhNFMeS2j6NIHUfjiZf9f7smtMKuNGkaTFXT53g7NTOGJPAJ5E
         zk/GPJ0NbtWXm7qu8Ku34ZxKxxcHWP2oZTUpR1OYMtQYi+KeV5d+9ZWYnDXmnWU+sM7H
         FRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707122675; x=1707727475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GWVRIre/A4VgFXhKfqdegG0tissbji1iue8FfAYEzA=;
        b=l0VlrTe3V/iY2o0WHV0dxMwqa2wmUH0pHZYhgG/34W6xyn8fkQ9cY8vj0VznVTUJAk
         LIIIC88EByGlTkqGm23Pby5Hgs5k71/ESob1S2Pbb6V5Sid2lK1cxGC3kuP9VANv5eIe
         LzRtixzWt9UUsbMz8b1hi8FhFnx8fYRCA0rHqtC3jCCm73PNtOMuU68GGpmVHAExgc4M
         BfBn4jI/1loRZrXOuN9IuaBFTlbMxgkbZt7KxRonEede7TJ2sNPeHfMzqhX/8yAsSV4e
         L24QFGY8ESTSDz9Gp7S2uiMx+Z2tq/fKe7RZCRta4ucikuftN89Z9I44yRN7KAHqLtwP
         d5oA==
X-Gm-Message-State: AOJu0YyApW10hDhOplFHFuDEigH+pONodbjRBtiBP0AvKfe1pBdeUHu9
	prH5tWJVbFusQ3APp6A9wJk5zB+XHrQXkFcDHsFvn2HArIeWf3aZBMmo/cRrURHEUg==
X-Google-Smtp-Source: AGHT+IH3uXv6DR4Vo1dx4tzR5HMDWyQ61KAPStNXz+Y7nwfawmDxhHNQoTDGOpjwVmm2s6gzWjFJVg==
X-Received: by 2002:a05:600c:a3a5:b0:40e:fbb3:f67c with SMTP id hn37-20020a05600ca3a500b0040efbb3f67cmr4221704wmb.38.1707122675149;
        Mon, 05 Feb 2024 00:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBSdDn6CXccNcOjl0Q5LDGeUAG8WUNMM5IxfU0+GKZzpMGNxpBSlECbQJP0ZQLgv4ZnH1+2hlRycCawLrjGVygnfxrN8Dc36N0mGbv0KsLKFGC/X9wOM6AxyE290VFg1W+noLk4k+jq6b/uXqLFLAS+q1rt9CS23DKG8Q9gzVmU+XEZNNWmMg1MFAA4EY1giUqmli8g4MpMJzq2IErvqv/L6eG0PM+ctSxa690w/uBrcNADYU91AkBC9/nE6xr7p/ifWoATrZOvTpNbEPM1zuh+jc9f5Y8M1p+LEoX8sZiH2/58L36RKN7oRaqBw4ePztEZYcbiW48i4zoaZCq6LcZ66iW3k+UAW2mNErYUXja/w6ge6JWI2bHbuMvpGBxvA==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id bg19-20020a05600c3c9300b0040fdc86c763sm1347835wmb.18.2024.02.05.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 00:44:34 -0800 (PST)
Message-ID: <3c2be790cabb066dd7c8b5bf5e7d3f277e3d77cb.camel@gmail.com>
Subject: Re: [PATCH v8 5/7] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: andy.shevchenko@gmail.com, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 05 Feb 2024 09:44:34 +0100
In-Reply-To: <Zb-yr0u_a9-vE86t@surfacebook.localdomain>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
	 <20240202-iio-backend-v8-5-f65ee8c8203d@analog.com>
	 <Zb-yr0u_a9-vE86t@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 17:52 +0200, andy.shevchenko@gmail.com wrote:
> Fri, Feb 02, 2024 at 04:08:36PM +0100, Nuno Sa kirjoitti:
> > This is a Framework to handle complex IIO aggregate devices.
> >=20
> > The typical architecture is to have one device as the frontend device w=
hich
> > can be "linked" against one or multiple backend devices. All the IIO an=
d
> > userspace interface is expected to be registers/managed by the frontend
> > device which will callback into the backends when needed (to get/set
> > some configuration that it does not directly control).
> >=20
> > The basic framework interface is pretty simple:
> > =C2=A0- Backends should register themselves with @devm_iio_backend_regi=
ster()
> > =C2=A0- Frontend devices should get backends with @devm_iio_backend_get=
()
>=20
> ...
>=20
> > + * Copyright (C) 2023 Analog Devices Inc.
>=20
> 2024 as well?

Yep.

>=20
> ...
>=20
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
>=20
> Missing types.h and maybe more. (E.g., IIRC linux/err.h doesn't cover
> linux/errno.h for Linux internal error codes, >=3D 512.)

ack..

>=20
> ...
>=20
> > +int devm_iio_backend_request_buffer(struct device *dev,
> > +				=C2=A0=C2=A0=C2=A0 struct iio_backend *back,
> > +				=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev)
> > +{
> > +	struct iio_backend_buffer_pair *pair;
> > +	struct iio_buffer *buffer;
> > +
> > +	buffer =3D iio_backend_ptr_op_call(back, request_buffer, indio_dev);
> > +	if (IS_ERR(buffer))
> > +		return PTR_ERR(buffer);
> > +
> > +	pair =3D devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
> > +	if (!pair)
> > +		return -ENOMEM;
>=20
> Shouldn't we try memory allocation first? Otherwise seems to me like free=
ing
> buffer is missed here.

Oh that's right. Good catch!

>=20
> > +	/* weak reference should be all what we need */
> > +	pair->back =3D back;
> > +	pair->buffer =3D buffer;
> > +
> > +	return devm_add_action_or_reset(dev, iio_backend_free_buffer, pair);
> > +}
>=20
> ...
>=20
> > +static int __devm_iio_backend_get(struct device *dev, struct iio_backe=
nd *back)
> > +{
> > +	struct device_link *link;
> > +	int ret;
> > +
> > +	/*
> > +	 * Make sure the provider cannot be unloaded before the consumer modu=
le.
> > +	 * Note that device_links would still guarantee that nothing is
> > +	 * accessible (and breaks) but this makes it explicit that the consum=
er
> > +	 * module must be also unloaded.
> > +	 */
> > +	if (!try_module_get(back->owner)) {
> > +		pr_err("%s: Cannot get module reference\n", dev_name(dev));
>=20
> NIH dev_err(). If you want the prefix, define dev_fmt() (or how is it cal=
led?)
> as well.

Hmm, initially I was using dev() stuff but then it felt we could easily get
unconsistent. We have two devices (supplier and consumer) and I guess we ca=
n easily
start to be unconsistent in which device we use as argument so I just went =
with pr_.=C2=A0

I would say if the call is done by the supplier we use that one, if it's th=
e
consumer, then the consumer. I can do that but again, not sure if it's the =
best thing
long run.

>=20
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(dev, iio_backend_release, back);
> > +	if (ret)
> > +		return ret;
> > +
> > +	link =3D device_link_add(dev, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER)=
;
> > +	if (!link) {
> > +		pr_err("%s: Could not link to supplier(%s)\n", dev_name(dev),
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(back->dev));
>=20
> Ditto.
>=20
> > +		return -EINVAL;
> > +	}
> > +
> > +	pr_debug("%s: Found backend(%s) device\n", dev_name(dev),
> > +		 dev_name(back->dev));
>=20
> Ditto (dev_dbg() here).
>=20
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +struct iio_backend *devm_iio_backend_get(struct device *dev, const cha=
r *name)
>=20
> Same comments regarding pr_*() vs. dev_*().
>=20
> > +	struct fwnode_handle *fwnode;
> > +	struct iio_backend *back;
>=20
> > +	int index =3D 0, ret;
>=20
> Wouldn't be better to have it done differently and actually using int is =
not
> okay strictly speaking? It's unsigned in your case.

Well, I think you're being a bit pedantic... I do cover the index < 0. But =
no strong
opinion, so I'll do as you suggest and don't wast your (and my) time with t=
his :)

>=20
> 	unsigned int index;
> 	int ret;
>=20
>=20
> > +	if (name) {
> > +		index =3D device_property_match_string(dev, "io-backends-names",
> > +						=C2=A0=C2=A0=C2=A0=C2=A0 name);
> > +		if (index < 0)
> > +			return ERR_PTR(index);
> > +	}
>=20
> 	if (name) {
> 		ret =3D device_property_match_string(dev, "io-backends-names",
> name);

But in the end, nice you mentioned this because it caught my attention for =
a bug!
io-backends-names > io-backend-names.

> 		if (ret < 0)
> 			return ERR_PTR(ret);
> 		index =3D ret;
> 	} else {
> 		index =3D 0;
> 	}
>=20
> > +	fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends", inde=
x);
> > +	if (IS_ERR(fwnode)) {
> > +		/* not an error if optional */
> > +		pr_debug("%s: Cannot get Firmware reference\n", dev_name(dev));
> > +		return ERR_CAST(fwnode);
> > +	}
> > +
> > +	guard(mutex)(&iio_back_lock);
> > +	list_for_each_entry(back, &iio_back_list, entry) {
> > +		if (!device_match_fwnode(back->dev, fwnode))
> > +			continue;
> > +
> > +		fwnode_handle_put(fwnode);
> > +		ret =3D __devm_iio_backend_get(dev, back);
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +
> > +		return back;
> > +	}
> > +
> > +	fwnode_handle_put(fwnode);
> > +	return ERR_PTR(-EPROBE_DEFER);
> > +}
>=20
> ...
>=20
> > +static void iio_backend_unregister(void *arg)
> > +{
> > +	struct iio_backend *back =3D arg;
>=20
> No guard() here, why?

Because you're not really gaining much in using it in here. There's no earl=
y return
path or goto in here. As I say below, you can argue about consistency but m=
eh...

>=20
> > +	mutex_lock(&iio_back_lock);
> > +	list_del(&back->entry);
> > +	mutex_unlock(&iio_back_lock);
> > +}
>=20
> > +int devm_iio_backend_register(struct device *dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_backend_ops *ops, v=
oid *priv)
>=20
> Use dev_err() et al.
>=20
> ...
>=20
> > +	mutex_lock(&iio_back_lock);
> > +	list_add(&back->entry, &iio_back_list);
> > +	mutex_unlock(&iio_back_lock);
>=20
> scoped_guard()?
>=20

Don't really see the point. In the end we'll even have the same LOC.

But yeah, the only reason I could think off is consistency but OTOH I think=
 it makes
sense to use these were it makes sense.

- Nuno S=C3=A1


