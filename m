Return-Path: <linux-iio+bounces-1672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89882D6D1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D1281230
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76FBF508;
	Mon, 15 Jan 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM/QvhlQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1FF4F6;
	Mon, 15 Jan 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3377d45c178so3719197f8f.2;
        Mon, 15 Jan 2024 02:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313379; x=1705918179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RCzvxAoishCNkmgPbCCeRptNJ4cx9eMqJ2QtWA3SAC8=;
        b=RM/QvhlQQ4Rd/T+PIl+lwf8MrwOYNVXoS1XxM3XBT8yYg/blVhOdp20fWN2TYhnYWt
         WbXmcXfjk/Q0fck0ieWWXOUCHPR5u3iC3YDodrfUe93CV+p8xOrCRgRix01FDWneA2Sv
         sI27Wk7s2oDwnhgpj0aSxBJ8IJGGx7TtwG4JCECpavne1h7GKOfYgY8YOW61zhizZdyj
         d+PXem2x0j65fS1EwFEkw5CLxhjrN9yhyFXytQaePNNh1Bu3JUApDtQO+CLmbLnq6IVq
         PGf+WqB54fJcLjrhGNdEJZGCTwcKpHYBecPXqMQr2YAZf42oIkrcJrBXCd1dvnVN913T
         Kw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313379; x=1705918179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCzvxAoishCNkmgPbCCeRptNJ4cx9eMqJ2QtWA3SAC8=;
        b=DncFEGy27mZtiWdWIPcXB6mRp0JPFBpUyEXZjC0x0/lurWZkS9iimcaHx+NzEMXycf
         WGGjfu3YYptx36ZHlXw2FpsKWuwJwlgJKWw1zPLdpz9+HDaoAIAA0MSa8tdbp8n4xytn
         zQyyUqH3Jxmi+t8zTlw/3P4E+4WQI4jfqpDAoa+Swx/pyzoYJpJBYC2Djcf1FYmFkF6K
         DSUSVKOrL+hHM4lWOq/ds+mg9KzzmDWA+sW9ZwYBsQIZq8lQE9bUZsMfkt36uN38ysHI
         0zgFDD8WC1euQvBgmKd/xqyyZc+f8rQeFMW26Mq6auF5xSWJswdTgTCY3I+XeF0GaYtm
         p7Lg==
X-Gm-Message-State: AOJu0YzheSdWTPArxVabQB/1NRWcrfHagE4Sem3Y5IEth9SScZovtJ+B
	dUrosg5A1bQiIFCG4gu3bsg=
X-Google-Smtp-Source: AGHT+IH+Gnjyx434Oa4E+G43ycwwg+XkVbJfM6++cDMLAP+HuEcgV6vqaTAIfZ2daY8VaX7rO4id+w==
X-Received: by 2002:a05:600c:6987:b0:40e:74e5:ac4e with SMTP id fp7-20020a05600c698700b0040e74e5ac4emr1034746wmb.5.1705313379120;
        Mon, 15 Jan 2024 02:09:39 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm15226264wmq.12.2024.01.15.02.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:09:38 -0800 (PST)
Message-ID: <4e80cc77e2f4cd51ebe1dc551c7a03a2f32d48bd.camel@gmail.com>
Subject: Re: [PATCH v5 6/8] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 15 Jan 2024 11:12:51 +0100
In-Reply-To: <20240113172208.6c4cfdbb@jic23-huawei>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	 <20240112-iio-backend-v5-6-bdecad041ab4@analog.com>
	 <20240113172208.6c4cfdbb@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-13 at 17:22 +0000, Jonathan Cameron wrote:
> On Fri, 12 Jan 2024 17:40:20 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
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
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> A few minor comments inline.
>=20
> ...
>=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > new file mode 100644
> > index 000000000000..994bc68c2679
> > --- /dev/null
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -0,0 +1,411 @@
>=20
> ...
>=20
> > +
> > +/*
> > + * Helper struct for requesting buffers. Allows for multiple buffers p=
er
> > + * backend.
> Only seems to be used to ensure we have all the data needed to free it...
> So comment seems less than obviously connected to that.

I'll update the comment...

> > + */
> > +struct iio_backend_buffer_pair {
> > +	struct iio_backend *back;
> > +	struct iio_buffer *buffer;
> > +};
> > +
>=20
> > +/**
> > + * iio_backend_chan_enable - Enable a backend channel.
> > + * @back:	Backend device.
> > + * @chan:	Channel number.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_chan_enable(struct iio_backend *back, unsigned int cha=
n)
> > +{
> > +	return iio_backend_op_call(back, chan_enable, chan);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_enable, IIO_BACKEND);
> > +
> > +/**
> > + * iio_backend_chan_disable - Disable a backend channel.
> > + * @back:	Backend device.
> > + * @chan:	Channel number.
> Would be good to be consistent on . or not.

Agreed.

> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_chan_disable(struct iio_backend *back, unsigned int ch=
an)
> > +{
> > +	return iio_backend_op_call(back, chan_disable, chan);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_disable, IIO_BACKEND);
> > +
> > +/**
> > + * iio_backend_chan_enable - Enable the backend.
> > + * @back:	Backend device
>=20
>=20
>=20
> ...
>=20
>=20
> > +/**
> > + * devm_iio_backend_get_from_fwnode_lookup
>=20
> Not valid kernel doc + name is wrong.=C2=A0 Make sure you run
> the kernel-doc script over this and fix any errors or warnings
> reported.

Noted.

>=20
> > + * @dev:	Device where to bind the backend lifetime.
> > + * @fwnode:	Firmware node of the backend device.
> > + *
> > + * Search the backend list for a device matching @fwnode.
> > + * This API should not be used and it's only present for preventing th=
e
> > first
> > + * user of this framework to break it's DT ABI.
> > + *
> > + * RETURNS:
> > + * A backend pointer, negative error pointer otherwise.
> > + */
> > +struct iio_backend *
> > +__devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
> > +					=C2=A0 struct fwnode_handle *fwnode)
> > +{
> > +	struct iio_backend *back;
> > +	int ret;
> > +
> > +	guard(mutex)(&iio_back_lock);
> > +	list_for_each_entry(back, &iio_back_list, entry) {
> > +		if (!device_match_fwnode(back->dev, fwnode))
> > +			continue;
> > +
> > +		ret =3D __devm_iio_backend_get(dev, back);
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +
> > +		return back;
> > +	}
> > +
> > +	return ERR_PTR(-EPROBE_DEFER);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup,
> > IIO_BACKEND);
> >=20
>=20
>=20
> > +/**
> > + * devm_iio_backend_register - Register a new backend device
> > + * @dev:	Backend device being registered.
> > + * @ops:	Backend ops
> > + * @priv:	Device private data.
> > + *
> > + * @ops and @priv are both mandatory. Not providing them results in -
> > EINVAL.
>=20
> It's unusual to 'insist' on the private data.
> Whilst it's highly likely it will always be there from a core point of vi=
ew
> we don't mind it being NULL.=C2=A0 This is different from the ops as we w=
ant
> to be able to call those without checking they are there.
>=20

Hmm, you're right. The private is for the callers to care as we don't reall=
y
touch it.

- Nuno S=C3=A1
>=20


