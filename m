Return-Path: <linux-iio+bounces-6547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B290E2B3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA9B22E53
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 05:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305155893;
	Wed, 19 Jun 2024 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQb++Fqa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF54208B0;
	Wed, 19 Jun 2024 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775075; cv=none; b=omu4hnmr47eqnA5jQs0oWtJWkBfUDz54TkigFeGV6IPxJwpGNyDXsdS/PZxaswUQ5AneHBJBA8FUucbllRG99CJcONVJgcwDhZrWK1sym8Uq1OP07eOZrnl/6LtmNAO8PaxsrO7CQEeLeQNQiWJQlWAc4h2CEeE8gZYZiIreOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775075; c=relaxed/simple;
	bh=S3sIQqQ3//Is06NvUQ4of0J1odDwxVc1O1l6BRUxaQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9CDKygfwoMEEgh3ZFe9AnmnoJLWoHNyURd+UKpXxeZxfP44/FohD9YLqCSCHaZe0j+OhsdvdMzfu6jm6NF/4qdHm9X8HKVJbxXqtcvluSIP74VffLsd1sp/4eWt7Ai/aZkDMHQl3VFJQDHWHi2ZpzpMLFoulWl1cpJPAphHmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQb++Fqa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so49803011fa.3;
        Tue, 18 Jun 2024 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718775072; x=1719379872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9vPtlZ4BEfdVrcH0b0OXPRdbJTCb7JH0uFuSNUJCaI=;
        b=kQb++FqaRWmtG20OtwDVF57JMHWYzzBTix0oiUyRfkhRVp9I775hyIjZCTesWHUwoK
         NBKa1qWgZwlEFitDpci0sdNZZxDW2+54NINlRPpTUREFcHJsSXFsff32bFcyc3MU6Uos
         4ScQ6ke81a6x9d/JZgEd30qxL8w+cQLvn3TFXS+JY5gpetgUV6nEB3bA7BrpAphz8cSb
         yT6TGQU/fYOcC3rWhDoQmfhMFLBta7l6al5Jlv2JoJYe9290/dgVRBZezkDfk01dr3qE
         6l/j1Wb8i/Xdj6HQ1C18cGe0NQEl7IDIHZy9qk6EB96YD7lmTQSp0tLwsqZxkRZWvBeS
         sv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775072; x=1719379872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9vPtlZ4BEfdVrcH0b0OXPRdbJTCb7JH0uFuSNUJCaI=;
        b=Dj+rf8ZVpLdJXabZlIKLUqDjXDh+v2//hgHCcO4r5p/pleAN0KnYhUlJJlTPcp+EHB
         BY6FwqE9bzyuWktF+4tiY5aGZP4wxj5mingItul1GMRhGmDlFq44ak7N0tY3vPGHTAsE
         cM0M76Ye5z6LzeeSvILF/Gq/wGjbux5b45vteg+MX9j/QQHEJ5vFXfnbEvZcUjCz5q57
         azgkoyoQAuB/HtaQDMHm0zZoO5EU7OV5uThwiTfNMZD6Kz6nV6KaYFec2O2IpjSX0zMJ
         JjlWCbQS3P5A/Sg4gsb+ohQrh05apDBa1dIlJcFgqNRRuCGuYyPFYilfcqYwlrlOg8bP
         4IUA==
X-Forwarded-Encrypted: i=1; AJvYcCXT/ZEyph0d8S6H3m3CPwiw661e/njhM6sosFOsPPwaAO6fTXkKxCGdqA/9wI1/3O979MHUD/73gF+K5/prxie9jjl9lRwM6lSX/Baj
X-Gm-Message-State: AOJu0Yz1R0iIEOO0dxWxMfOKRZehoxfP52GG1+LyjRtKLdqbT6uR2Ccz
	jSuekjVvWZeKKro66n1jEZePicQNodOKBcjOT5+5CUHvIYJzy2lc
X-Google-Smtp-Source: AGHT+IHuSmL/ymrKFv3dE1AjkfE2DbcrkpwnD4enL7EQqezvrPVir4e1owWjmqTMnPn8ZF+LuoTYOA==
X-Received: by 2002:a2e:a286:0:b0:2eb:552a:f6d0 with SMTP id 38308e7fff4ca-2ec3cfffa27mr8508261fa.52.1718775071217;
        Tue, 18 Jun 2024 22:31:11 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e96f9sm253628215e9.26.2024.06.18.22.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:31:11 -0700 (PDT)
Message-ID: <4ee7d979736bb9e1518ce78ccb4a5b1a3766289c.camel@gmail.com>
Subject: Re: [PATCH 3/8] iio: add child nodes support in iio backend
 framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 19 Jun 2024 07:31:10 +0200
In-Reply-To: <20240618160836.945242-4-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-4-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
> Add an API to support IIO generic channels binding:
> http://devicetree.org/schemas/iio/adc/adc.yaml#
> This new API is needed, as generic channel DT node
> isn't populated as a device.
> Add devm_iio_backend_subnode_get() to allow an IIO device
> backend consumer to configure backend phandles in its
> child nodes.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Again small notes nits. With it:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-backend.c | 48 ++++++++++++++++++++++-----=
---
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 38 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index d3db048c086b..e9d29131634d 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -575,17 +575,8 @@ static int __devm_iio_backend_get(struct device *dev=
, struct
> iio_backend *back)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/**
> - * devm_iio_backend_get - Device managed backend device get
> - * @dev: Consumer device for the backend
> - * @name: Backend name
> - *
> - * Get's the backend associated with @dev.
> - *
> - * RETURNS:
> - * A backend pointer, negative error pointer otherwise.
> - */
> -struct iio_backend *devm_iio_backend_get(struct device *dev, const char =
*name)
> +static struct iio_backend *__devm_iio_backend_node_get(struct device *de=
v, const
> char *name,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *node)

I would call it __devm_iio_backend_fwnode_get(). Also the parameter node ->=
 fwnode.

> =C2=A0{
> =C2=A0	struct fwnode_handle *fwnode;
> =C2=A0	struct iio_backend *back;
> @@ -602,7 +593,7 @@ struct iio_backend *devm_iio_backend_get(struct devic=
e *dev,
> const char *name)
> =C2=A0		index =3D 0;
> =C2=A0	}
> =C2=A0
> -	fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends", index)=
;
> +	fwnode =3D fwnode_find_reference(node, "io-backends", index);
> =C2=A0	if (IS_ERR(fwnode)) {
> =C2=A0		dev_err_probe(dev, PTR_ERR(fwnode),
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot get Firmware reference\n"=
);
> @@ -625,8 +616,41 @@ struct iio_backend *devm_iio_backend_get(struct devi=
ce *dev,
> const char *name)
> =C2=A0	fwnode_handle_put(fwnode);
> =C2=A0	return ERR_PTR(-EPROBE_DEFER);
> =C2=A0}
> +
> +/**
> + * devm_iio_backend_get - Device managed backend device get
> + * @dev: Consumer device for the backend
> + * @name: Backend name
> + *
> + * Get's the backend associated with @dev.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_get(struct device *dev, const char =
*name)
> +{
> +	return __devm_iio_backend_node_get(dev, name, dev_fwnode(dev));
> +}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
> =C2=A0
> +/**
> + * devm_iio_backend_subnode_get - Device managed backend device get
> + * @dev: Consumer device for the backend
> + * @name: Backend name
> + * @node: Firmware node of the backend consumer
> + *
> + * Get's the backend associated with @dev.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_subnode_get(struct device *dev, con=
st char
> *name,
> +						 struct fwnode_handle *node)

Again, for consistency devm_iio_backend_fwnode_get(). And node -> fwnode

- Nuno S=C3=A1



