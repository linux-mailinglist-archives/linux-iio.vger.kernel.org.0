Return-Path: <linux-iio+bounces-6545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE490E29C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 07:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F80D1C21646
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 05:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36DA548E1;
	Wed, 19 Jun 2024 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWggAkHD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D228EC;
	Wed, 19 Jun 2024 05:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774470; cv=none; b=bZAvl6DUwCkNZCURnT47jOeEeWUUchmrbrEl3e7ToivuC1zaj6i8ayo5sfu2nPOv5yRndsIRTIdA/AhzudLZXoxpzFgzdWP2T0rnLMwWMiu05/4GrZmuVI54/hMdhmBn7582UEkfZJkCt5TAS78VHaPWDlriYGEqpzQIO41YQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774470; c=relaxed/simple;
	bh=3fhxlCy9Vz8ZybVo7OOz3mT1ven3q+ULsCnER4N4Jms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmZl8cxow1A2teoBhQS7JEUzxea+OsbyelptPQaA4eruyKT2OdcNRn1bTickt04e32PeRZdayo6VwvoIJs5+tDHTOJYxjcawWH4kAukISEkifDUSsOgLlPTgitVJEvw6xk6trDM+HecnmHQYtTQJopcnJyx27RBXFUDKAjk1K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWggAkHD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so5553576f8f.1;
        Tue, 18 Jun 2024 22:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718774467; x=1719379267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qwp3G2wkgfWztC1WiEcAvtKbcMmGeeZKMaO+Raf4cOc=;
        b=SWggAkHDcEwiWYhEeY9I8XjHp3/FhgMT3R4TRCVxa8Y9ZosRqpEEKXaPZDXm/8C+f7
         bbILypTMAcHzVN4tDsCxTWuLYqtnfaWagooKvybK2ksJvKCdST3SpyzdzgpnerX9jy2c
         BTFSeUmeDYOqRCiCc78CIUq8aqRqpfUMBv8lLBORfiTmkMl0cC5Jx6uODdcGB8dGIIqu
         SLiDhUWq4s3Wv4la9GdCq6aV9hd80Li34ItSSmGhppqBshL4fLh1t6fzlnrp3Hz2CCZa
         RQVL9nMe8MH0io9qlFyKuo3DokMcYUQkVoOME1zhE3iqIFfoRXAqcl2mUfTU/SFTuFDd
         fP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718774467; x=1719379267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qwp3G2wkgfWztC1WiEcAvtKbcMmGeeZKMaO+Raf4cOc=;
        b=nBoyfT6ZNCOSf6r80FuGUHZTrSnu3PByUaxQGP1TER1F1rRp1rRH39XGvEST6VfHAk
         xU6NPY4TsL14NxO//DnpRoXuer5XkSE6q6fNhI6DgsZd5aXUaXEHj1nDSeWXC98E+IRm
         CKXCCHmNx6pqdylQ5fwXe3B4XEGSMxVHtLJgAVIeG+f/8aSMkezTtIG1F3dwLfsxU1rW
         yq9jIYX4pDbjS4uAue7IL8KN44LO9XNjvyRriKPs6lxc99bMcSbJKcf+UgtyHQ8C30/O
         iGlWXsgmQLI0F10CZL2NU3VwEh3riW/hi5jrJ9LLc1DA0lnR+prRiGjiAWqjYpqckRAr
         dzZw==
X-Forwarded-Encrypted: i=1; AJvYcCU3kZKMA3yf7RbJ9gvu15zR1pAC+H6nvj6xFVbiOROfqEqBefiUb0j3b9OTNuqS3VZ1B28pweDeQVXgDwJYT/sQ+oGo4uMahlFBMzca
X-Gm-Message-State: AOJu0YxbNXVO0SCvQkYFXvJWeUu8m2w0t/YorpXybRAPOV4X9BBfMl15
	JjbKUDbGyjkSoC/9cKb6ZRzdokciyzYcDoaHP4J326Fi0LQhc30+
X-Google-Smtp-Source: AGHT+IFj8N/tYTeh5HIsrNsSRhmMsWBORvW0ufQGbGhkqZvMrK95BBDNOYgO7F76PX0O5jwKLu2TpQ==
X-Received: by 2002:a05:6000:12c1:b0:362:bbd8:229d with SMTP id ffacd0b85a97d-363176ad606mr915492f8f.27.1718774466762;
        Tue, 18 Jun 2024 22:21:06 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36289a4faeasm2607189f8f.95.2024.06.18.22.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:21:06 -0700 (PDT)
Message-ID: <5b7b8a7132934b77b43ffde0650c68c1dd9a5b7e.camel@gmail.com>
Subject: Re: [PATCH 2/8] iio: add enable and disable services to iio backend
 framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 19 Jun 2024 07:21:06 +0200
In-Reply-To: <20240618160836.945242-3-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-3-olivier.moysan@foss.st.com>
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
> Add iio_backend_disable() and iio_backend_enable() APIs to allow
> IIO backend consumer to request backend disabling and enabling.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Hi Olivier,

small notes from me...

> =C2=A0drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index b950e30018ca..d3db048c086b 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -166,6 +166,32 @@ int devm_iio_backend_enable(struct device *dev, stru=
ct
> iio_backend *back)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKEND);
> =C2=A0
> +/**
> + * iio_backend_enable - Backend enable
> + * @dev: Consumer device for the backend
> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_enable(struct device *dev, struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);

We do already have devm_iio_backend_enable(). From a correctness stand poin=
t and even
scalability, that API should now call your new iio_backend_enable() instead=
 of
directly call iio_backend_op_call(). I guess that change could be in this p=
atch.

> +
> +/**
> + * iio_backend_disable - Backend disable
> + * @dev: Consumer device for the backend
> + * @back: Backend device
> + *
> + */
> +void iio_backend_disable(struct device *dev, struct iio_backend *back)
> +{
> +	iio_backend_void_op_call(back, disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
> +

We also have __iio_backend_disable() which is static since all users were u=
sing
devm_iio_backend_enable(). I understand that's not suitable for you but I w=
ould
instead rename the existing function to iio_backend_disable() and export it=
.

With the above changes:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

- Nuno S=C3=A1


