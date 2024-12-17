Return-Path: <linux-iio+bounces-13569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AB9F4896
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D0816E6FA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C621DFD8D;
	Tue, 17 Dec 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjnNzHJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2161DF961;
	Tue, 17 Dec 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430172; cv=none; b=YASL4g53l21eNT/duiojr7hyfVWBRC5c5cbBmdvGG5+9f4H+qyObYZXS4tk2p8zjuEIARrRsHtUJjkUlm9cfrCYbEStz3DDxAy+7N2yK3VVOI1gBXfRAd+zx3J9B6QfAz0dwqpJUXx2o9clLGrxKj7oyA75BclbJmUiQ6PvDK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430172; c=relaxed/simple;
	bh=bARy3KBMlATEtdBhaaWeu0sXjLdLh6PmGujP+bQWNQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKtXj2E/ZefIu1VrtJ1rjUKKYOfNCBo4GoWuwkFeWvYy1edXN1kN62En3x3Hvr4BUocMGmM6zPSq7ot4BYr8baLgtSwKVHIQqlg+bnRjTd0Ic2Mrc2/33AgACZKRtROim2g6XhQqdq03F3wXETHWkXF66zc85EthvMKedZ9eE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjnNzHJk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aab9e281bc0so491301866b.3;
        Tue, 17 Dec 2024 02:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734430169; x=1735034969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKR0sxBe61CR4Sm04Ka49lA4kFtCAPFa2I5U7ImLLBw=;
        b=QjnNzHJkyFnq4vcz4AxARBxTy9Po226M9bSnyKk4Xd1i5QTNGkfXUNnPJgySR5NOQt
         ivL3QjcOVXEzoJEBAIaxkeT/A+T15rHYUMhwrMERD3yyubEgjL/LVZa8RSeqki925fnb
         c2E56+g6okm4bV+dMT0CD1R4ZYOhZ83J6Z3yCpZg3+2nncs4f0QdDesgw5swoR+YphGb
         lXbvUxhCxjTRybr78x6hitCB247x4hJlraaTWaIRWKj+x0tAflWqiyQDXT3qeaczNWrI
         XC2u4BvuOYJeMbMqtQm3sS/IODZWyEVnQI8C/va5L2LpQDyk69U4ic4NDLZYNIuEfFi/
         N2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430169; x=1735034969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKR0sxBe61CR4Sm04Ka49lA4kFtCAPFa2I5U7ImLLBw=;
        b=Ah2RKiLkTUUi1AtwNua1Nz3bel0OaRjs13ZbBm22op/wDqEEhx9dDnl4KYzyXdBf0i
         ZdDCQ/Oj6DVI+zPbkcUt2XYnA90FrBxjVOSCLO1dI5UqM4yDc8vFljLi0AKAIlDZYwO7
         3Ks201OwTnBGt48bTGsHurgLSPGbSawdcOiBDY4JeK0odzBnSRLxQmJfE99Wu+Z7UKYy
         8fKhCfZLjSZMKxNM4Za2LloWVAK4sGWKbFS8bt0u49c+c9fo+oYswlXqp/SU33FyJ14p
         iSfMEZsf43PPaIPAqqvXVtmoPu/aW1vcGla48splhbNoHzgKhuRLfzv5xsGRcBpvs5C4
         oMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaG0OhKu31OH24OMQ5TTvNWZDiCZJuok519POTo95jFuag+zCFJ3ATai1i/i4+Q6J5CwBJjE+kaoQ=@vger.kernel.org, AJvYcCXm1kNwDP83Qk1DxOeuy9asYRMiF/vY40z9amCcHCGSUaUY2phXDxoh2DUrtjgTp2SgOg3pskF2p19GC1q2@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAePW8TN9PdvBzmuA+ienqh95JN3wWL9FQYZ63wvoClzDMr0k
	hj93samD0dGCm69+pG5K/wAxSrdnCB7tqnETtzoJ5kNnsje6xtHL
X-Gm-Gg: ASbGncvFNn0Z4R3rJ8DKGghxLp6ylMYp2FpZuYQIF+m6egnqYfeM7Yx9FBPvSwmWtX9
	aGyGLQs8R6oocergqM7GW7u8JyE8M+37sYPGHqkP43KWrEwI/hkhxcLBO4Q0Wn++S9h+HYCp68c
	FmSBBAMKvzT4JCtmij632SaVJIBzdJdD+N8CpaX1ie8tQamm2a5AuUuxWigdlsaKnr3+IWcKhE+
	stlP+eGYn4KEwPGZQq7OmzaR6Igk9nMxvBc6j4vm3SthAv0mftswgDJ1CTD/ixfPezzkDWYg498
	KUF/1sWKDjFEY7bAE34XBj3onPdOcZrReBp1pMqccCb1NdglRjOnGVTMIVnT1TdLBEu0VkO0JIp
	aFlA//J4IX2F+oQ==
X-Google-Smtp-Source: AGHT+IEicmeBluRTyuZSSIp7WQRAW1oTrBlmYFjVHPTozYKu/hqSpkIrk8k2GhoEW2VbQkUDRSW72A==
X-Received: by 2002:a17:906:31c1:b0:aa6:5eae:7ed8 with SMTP id a640c23a62f3a-aab778da4admr1336894266b.6.1734430168288;
        Tue, 17 Dec 2024 02:09:28 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm424333966b.139.2024.12.17.02.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:09:27 -0800 (PST)
Message-ID: <b5a773858a71e6929667fc73b9384908ca3ff313.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: backend: add API for interface configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa	 <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org, Antoniu Miclaus
 <antoniu.miclaus@analog.com>
Date: Tue, 17 Dec 2024 11:13:59 +0100
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
References: 
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	 <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-16 at 21:36 +0100, Angelo Dureghello wrote:
> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Add backend support for setting and getting the interface type
> in use.
>=20
> Link:
> https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.miclaus@=
analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> This patch has been picked up from the Antoniu patchset
> still not accepted, and extended with the interface setter,
> fixing also namespace names to be between quotation marks.
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 42
> ++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 19 +++++++++++++++++
> =C2=A02 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 363281272035..6edc3e685f6a 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> *indio_dev, uintptr_t private,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_interface_type_get - get the interface type used.
> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				=C2=A0=C2=A0 enum iio_backend_interface_type *type)
> +{
> +	int ret;
> +
> +	ret =3D iio_backend_op_call(back, interface_type_get, type);
> +	if (ret)
> +		return ret;
> +
> +	if (*type >=3D IIO_BACKEND_INTERFACE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
> +
> +/**
> + * iio_backend_interface_type_set - set the interface type used.
> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_set(struct iio_backend *back,
> +				=C2=A0=C2=A0 enum iio_backend_interface_type type)
> +{
> +	if (type >=3D IIO_BACKEND_INTERFACE_MAX)
> +		return -EINVAL;
> +
> +	return=C2=A0 iio_backend_op_call(back, interface_type_set, type);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 10be00f3b120..2b7221099d8c 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
> =C2=A0	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> =C2=A0};
> =C2=A0
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,

The above are apparently not used in the next patch so I would not add them=
 now.
> +	IIO_BACKEND_INTERFACE_SERIAL_SPI,
> +	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
> +	IIO_BACKEND_INTERFACE_SERIAL_QSPI,

I'll throw my 2 cents but it would be nice to have more feedback on this. I=
'm
not completely sure about the xSPI stuff in here. We treated the QSPI as a =
bus
both for control and data in which we also add child devices. And we've bee=
n
adding specific bus operations/configurations through the 'struct
ad3552r_hs_platform_data' interface. So, I'm wondering if this should also =
not
be set through that interface?

LVDS/CMOS still looks slightly different to me...

- Nuno S=C3=A1



