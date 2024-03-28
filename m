Return-Path: <linux-iio+bounces-3884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD2D8903A2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2B92926B4
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86351131BDC;
	Thu, 28 Mar 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI0waItF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58501131BD7;
	Thu, 28 Mar 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640563; cv=none; b=pLOF9spKcVUzDHm6j6k6w3fF4KRmNAAbkAxWMCj4TKnnWZ9iuSeTUzcms6XwZXXl3EKK6udX9nA86WkjJqvbLnZLiuB2RN+/PF2FF0CDf20wtzWAvgbP0cpTclghhd8oOr+ETg3ktxEw2Lveh49s1amf2e4dQ4FUlKSIF3jh+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640563; c=relaxed/simple;
	bh=nD6PSMTL46kRSAEccOJw9v7uZeKzF0ZI3OWYtGPDa+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tXFyESlrTQ+NfWvuGwdUv4zFrLOVZwcmYzdaSZYsoX6dSoDxvdfjpws+4/7RpnI5xC/FDC91f8W2Fr4Yw8cfUvIR4o6aLkLeUfL7BT0pbQtzupwVmKGvxfZe4hhiJKU6obGxaEDSRm3YDh9TkydKkRZGXv3F5IVbzEf2h8kazbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI0waItF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e28b10a53so61834366b.3;
        Thu, 28 Mar 2024 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711640560; x=1712245360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=280ZhrYUUjgoFmU/2HkUb1iRYJt1In7G0rCFmXh5F8o=;
        b=ZI0waItFzhVG4RezCH3C7S5QFIZ3Q3zENs74fb9mNTkvFkgKTWn8PKDBWhzMCx+eJa
         lDGcQhgihzqdKF8KvRYOFLZkpHiU4ZbIAMWqltjmHLNQ3MbEsytoSCchbmJMzJWPP7gB
         EJivzw4X55mi/doqFuEi0wz/1VkK8t4sSKj1QzHQtFHttIz694s8YuzGvN/+I7UrxDI0
         Zd/txre4am9DxA20iQt4UhTJ3VwqbVymUeOZIMJozW+0+kM7uc3FctZfRighFbvZgstd
         O+YVFGke1DxoccDbnwzgY8qxDm/fxxF5gJLE7zs/DkFWIJvyGA3LQWSebucJ/ZaekREP
         CwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640560; x=1712245360;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=280ZhrYUUjgoFmU/2HkUb1iRYJt1In7G0rCFmXh5F8o=;
        b=L4ojr6lIWS687CP1oEYe4x0NmuyyrbklKKzuqIiMH4Js0+ahMr5Ws6SWnqfYa4YjnI
         AouHUl/ossI4irvatpkFYxXNkGm5ssPQ10yNjvGQ3zDAmj/m/u4Nt6FjZ9MsWjVrxXx9
         obLBRuVVW3i7dj2o1O9x5DWItNcEaJyZjOd/GnqOo8Dfj5mkxSq4HTbBZhAE8IWHD6wn
         zL5HW9Hw8N8TelbQNyuxDHGT915yTKdZPTDRz2VlfbJ1hGHX8qrlIMVYg7KQwuWJKkxI
         uSPUL5U0Hl/kKXDTb4RfERkA3K6BiaeRa3G3QpJr0LUO2wLL1x809F6H5NpwTFlocB6i
         ACZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1HEUH7NwnJ3IbMRO+octPEp5XvD3uZiVtC2tITF3Ddg01+UkUpeP9S5uQIH0QPygkzutU9qGXqeo9OQU3LZyXjVdP0Wf80jLSKX5QpTiHcvjRo/PAa4pKPwGze3hV8dOKvb0rOw==
X-Gm-Message-State: AOJu0Yw1vlK6X4RLf+SVKDKiu3lc6aBQ+3lR8EuoEGkEZkNtIKuibeBd
	G9K1P/Pg1+oSo5k5rNugdCGFVbLut3JvFtzVFAo6QEtJM8UTHXr0kneMB8oq/DQ=
X-Google-Smtp-Source: AGHT+IHigr/OB/Bp2VoYKOFtHkExCBs52kxaenSyjyDpJ7XI15+ltTVH1a2uEZJ2qodx/BJhDphGOw==
X-Received: by 2002:a17:906:fc8:b0:a4e:4da:5ef with SMTP id c8-20020a1709060fc800b00a4e04da05efmr1833800ejk.44.1711640559496;
        Thu, 28 Mar 2024 08:42:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id f6-20020a170906ef0600b00a46af0fbf5dsm874116ejs.103.2024.03.28.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:42:39 -0700 (PDT)
Message-ID: <cec2ac9c67aeae7c59434a86713f35461d171c04.camel@gmail.com>
Subject: Re: [PATCH 08/10] iio: backend: add new functionality
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 28 Mar 2024 16:42:38 +0100
In-Reply-To: <20240328151632.298bd95f@jic23-huawei>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-8-afc808b3fde3@analog.com>
	 <20240328151632.298bd95f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 15:16 +0000, Jonathan Cameron wrote:
> On Thu, 28 Mar 2024 14:22:32 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > This adds the needed backend ops for supporting a backend inerfacing
> > with an high speed dac. The new ops are:
> >=20
> > * data_source_set();
> > * set_sampling_freq();
> > * extend_chan_spec();
> > * ext_info_set();
> > * ext_info_get().
> >=20
> > Also to note the new helpers that are meant to be used by the backends
> > when extending an IIO channel (adding extended info):
> >=20
> > * iio_backend_ext_info_set();
> > * iio_backend_ext_info_get().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> I'm pretty flexible on this so far as I think we are still learning how f=
ront
> ends and backends should interact. Maybe we'll figure that out in the med=
ium
> term and rework this stuff. For now it looks fine. A few minor things inl=
ine.
> > =C2=A0
> > +/**
> > + * iio_backend_ext_info_get - IIO ext_info read callback
> > + * @indio_dev:	IIO device
> > + * @private:	Data private to the driver
> > + * @chan:	IIO channel
> > + * @buf:	Buffer where to place the attribute data
> > + *
> > + * This helper is intended to be used by backends that extend an IIO c=
hannel
> > + * (trough iio_backend_extend_chan_spec()) with extended info. In that=
 case,
> > + * backends are not supposed to give their own callbacks (as they woul=
d not
> > + * a way to get te backend from indio_dev). This is the getter.
>=20
> te->the?

Yes and some more typos :).

>=20
>=20
> > +/**
> > + * iio_backend_extend_chan_spec - Extend an IIO channel
> > + * @indio_dev:	IIO device
> > + * @back:	Backend device
> > + * @chan:	IIO channel
> > + *
> > + * Some backends may have their own functionalities and hence capable =
of
> > + * extending a frontend's channel.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
> > +				 struct iio_backend *back,
> > +				 struct iio_chan_spec *chan)
> > +{
> > +	const struct iio_chan_spec_ext_info *ext_info =3D chan->ext_info;
> This is getting confusing.=C2=A0 So this one is the front end value of ex=
t_info?
> Name it as such frontend_ext_info

Yes, it's the frontend pointer. Just to enforce the below constrain. Will r=
ename as
suggested.

>=20
> > +	int ret;
> > +
> > +	ret =3D iio_backend_op_call(back, extend_chan_spec, chan);
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * Let's keep things simple for now. Don't allow to overwrite the
> > +	 * frontend's extended info. If ever needed, we can support appending
> > +	 * it.
> > +	 */
> > +	if (ext_info && chan->ext_info !=3D ext_info)
> > +		return -EOPNOTSUPP;
> > +	if (!chan->ext_info)
>=20
> This is checking if the backend added anything? Perhaps a comment on that
> as we don't need a backend_ext_info local variable...

Yes, but just regarding ext_info as that is the only thing we're handling b=
elow
(doing some sanity checks). Note that (as you said above) I'm keeping thing=
s a bit
"open" in that the backend is open to extend whatever it wants. With time w=
e may
learn better what do we want constrain or not.

>=20
> > +		return 0;
> > +	/*
> > +	 * !\NOTE: this will break as soon as we have multiple backends on on=
e
> > +	 * frontend and all of them extend channels. In that case, the core
> > +	 * backend code has no way to get the correct backend given the
> > +	 * iio device.
> > +	 *
> > +	 * One solution for this could be introducing a new backend
> > +	 * dedicated callback in struct iio_info so we can callback into the
> > +	 * frontend so it can give us the right backend given a chan_spec.
> > +	 */
>=20
> Hmm. This is indeed messy.=C2=A0 Could we associate it with the buffer as=
 presuably
> a front end with multiple backends is using multiple IIO buffers?
>=20

Hmm, the assumption of having multiple buffers seems plausible to me but co=
nsidering
the example we have in hands it would be cumbersome to get the backend. Con=
sidering
iio_backend_ext_info_get(), how could we get the backend if it was associat=
ed to one
of the IIO buffers? I think we would need more "intrusive" changes to make =
that work
or do you have something in mind=3D
=20
> As you say a dance via the front end would work fine.

I'm happy you're also open for a proper solution already. I mention this in=
 the
cover. My idea was something like (consider the iio_backend_ext_info_get())=
:

if (!indio_dev->info->get_iio_backend())
	return -EOPNOTSUPP;

back =3D indio_dev->info->get_iio_backend(indio_dev, chan_spec);

It would be nice to have some "default/generic" implementation for cases wh=
ere we
only have one backend per frontend so that the frontend would not need to d=
efine the
callback.
 =20
>=20
>=20
> > +	iio_device_set_drvdata(indio_dev, back);
> > +
> > +	/* Don't allow backends to get creative and force their own handlers =
*/
> > +	for (ext_info =3D chan->ext_info; ext_info->name; ext_info++) {
> > +		if (ext_info->read !=3D iio_backend_ext_info_get)
> > +			return -EINVAL;
> > +		if (ext_info->write !=3D iio_backend_ext_info_set)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, IIO_BACKEND);
>=20
> > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > index a6d79381866e..09ff2f8f9fd8 100644
> > --- a/include/linux/iio/backend.h
> > +++ b/include/linux/iio/backend.h
> > @@ -4,6 +4,7 @@
> > =C2=A0
> > =C2=A0#include <linux/types.h>
> > =C2=A0
> > +struct iio_chan_spec;
> > =C2=A0struct fwnode_handle;
> > =C2=A0struct iio_backend;
> > =C2=A0struct device;
> > @@ -15,6 +16,26 @@ enum iio_backend_data_type {
> > =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> > =C2=A0};
> > =C2=A0
> > +enum iio_backend_data_source {
> > +	IIO_BACKEND_INTERNAL_CW,
>=20
> CW?=C2=A0 Either expand out what ever that is in definition of add a comm=
ent
> at least.

Continuous wave :)

>=20
> > +	IIO_BACKEND_EXTERNAL,
> What does external mean in this case?

In this particular case comes from a DMA source (IP). I thought external to=
 be more
generic but if you prefer, I can do something like IIO_BACKEND_DMA?


> > +	IIO_BACKEND_DATA_SOURCE_MAX
> > +};
> > +
> > +/**
> > + * IIO_BACKEND_EX_INFO - Helper for an IIO extended channel attribute
> > + * @_name:	Attribute name
> > + * @_shared:	Whether the attribute is shared between all channels
> > + * @_what:	Data private to the driver
> > + */
> > +#define IIO_BACKEND_EX_INFO(_name, _shared, _what) {	\
> > +	.name =3D (_name),				\
> > +	.shared =3D (_shared),				\
> > +	.read =3D=C2=A0 iio_backend_ext_info_get,		\
> > +	.write =3D iio_backend_ext_info_set,		\
> > +	.private =3D (_what),				\
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * struct iio_backend_data_fmt - Backend data format
> > =C2=A0 * @type:		Data type.
> > @@ -35,8 +56,13 @@ struct iio_backend_data_fmt {
> > =C2=A0 * @chan_enable:	Enable one channel.
> > =C2=A0 * @chan_disable:	Disable one channel.
> > =C2=A0 * @data_format_set:	Configure the data format for a specific cha=
nnel.
> > + * @data_source_set:	Configure the data source for a specific channel.
> > + * @set_sample_rate:	Configure the sampling rate for a specific channe=
l.
> > =C2=A0 * @request_buffer:	Request an IIO buffer.
> > =C2=A0 * @free_buffer:	Free an IIO buffer.
> > + * @extend_chan_spec:	Extend an IIO channel.
> > + * @ext_info_set:	Extended info setter.
> > + * @ext_info_get:	Extended info getter.
> > =C2=A0 **/
> > =C2=A0struct iio_backend_ops {
> > =C2=A0	int (*enable)(struct iio_backend *back);
> > @@ -45,10 +71,21 @@ struct iio_backend_ops {
> > =C2=A0	int (*chan_disable)(struct iio_backend *back, unsigned int chan)=
;
> > =C2=A0	int (*data_format_set)(struct iio_backend *back, unsigned int ch=
an,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_backend_=
data_fmt *data);
> > +	int (*data_source_set)(struct iio_backend *back, unsigned int chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_data_source d=
ata);
> > +	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 sample_rate);
>=20
> Name the parameter that so we know the units.=C2=A0 _hz?=C2=A0

yes. And u64 to not fall in the CCF problem for 32bits :)

- Nuno S=C3=A1


