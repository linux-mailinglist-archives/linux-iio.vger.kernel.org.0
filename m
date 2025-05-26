Return-Path: <linux-iio+bounces-19927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FDAC3D62
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BAC3B9002
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0EF1F2BBB;
	Mon, 26 May 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNJ7EwUB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D282BB13;
	Mon, 26 May 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253276; cv=none; b=ZLTV6X1NpugbxGPM0mELL9sdqLkyFiq0iTGJBlWTdjmkcl93H5Jlhddhdjm9jcdj3pdWUuPDm+5eoELw2SS9nt3UEf1284gKM2234mVvAbxYV7ZQX6iTB8WShU/h2Ds1VKYHyt8TqgI1ELzZiVj7uCr9ohsNz3Peeg+nBv18ZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253276; c=relaxed/simple;
	bh=uxCq8pE0zisvNk9Be3djgPnIYt9odmXLbBmY/z//fhE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrRx8dc5D8KTnxpaqemlvOdZ8XOxZVUUbY6K0wfeHJttS/OSCLih39IIPWTAwbb+Pt3pD7UShFEGzs/qcouPBNH9j66NrseDVYW+BzFOahOytv9D9K9LtwWlvAhL+3svS1L30gneEo19AQ2oM8R/z1wQjXqHuJ/TMi2O6qeK/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNJ7EwUB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a361b8a664so2175540f8f.3;
        Mon, 26 May 2025 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253273; x=1748858073; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs58e8O5Dds/mx0mPKhvHcg9OpRi+VQGAVBms+YGRwk=;
        b=BNJ7EwUBDDpfiWzKLOJ7S4PBpuDbXafhXCzIsj1HSXjBK0H25PHrbLZXxQvYImQC96
         DhsnjB0tbm2Lf8rOa4shyMk+vjlV+5YDpvgKLkNn2bSH3fwtStYKV4irG1VcAw8u3GOZ
         N+EQj0qnm7MPBBg9lfyMR7jrl/fJ8cjdDv0TOFr8m7DeKKiQgyQh+5Vhn66KKZRwB8mK
         tmt+JcmtSvMfHuFNhXvOFAm3TqSLULi+L3VMtVyBr+Pbddr9WUwaDauynDDEj/VQePaV
         3mPGT358EKIqcPnpOdasiEFriYI5rKcrDB65LhrdURZ5lupNe2Zk4CrA7Viu9mujmjbK
         GNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253273; x=1748858073;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cs58e8O5Dds/mx0mPKhvHcg9OpRi+VQGAVBms+YGRwk=;
        b=f6lXt7Y7YlpWFpqsF6AOio17NhFTQx0PWN9NjTNE4snPZyXFnSw/CDXPklJqEMr7oL
         DObcv9j6OGuSgmSDv02c9hIXJ0K6DPP+7mkiTuLJPfRXRXQbhjINYk75SHYuVR8ZjPon
         2PR+sZKAYRTqpL//gAE1yir+JFA8VmXNVayilkVdjxyRPgMu5DXZ1hcleL9NHtlhJu0A
         55DoQ3pi87h/mBNEeiDuFcAeyES59hKYFRyrJ3L7iHLCcIISACGcodC1WvQgNr4Iq1bY
         t5lD4wts0oGZNV3CvFu3O3KZydXbDw5kyQSj9+TFj/MCPVFHP+XuQP0FOFuAySrek6vC
         esyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdJEthPZl38OyLP7P8Y57vwJ6Q3KJYNyrB9FRRxF1irZwRrJ0EB6DyF42UPMnj37t0kbnG9k20Y9ko@vger.kernel.org, AJvYcCW/ZRZ8uUA0zHKAh3/mE39CKlXXryyVxklY2Peh+3xc/ux/GfHFlXO5APaTQOR3yvZvgb51WpvvFXLSkih8@vger.kernel.org, AJvYcCWRnJdUIJ1JXoGoBxEM5LeyuwfiskSdjvtgsQwED9nYopcyWmyIpNUJ/gX4RIpb5HYB44xZF5C25pLr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yXm/hM45Cc9XRnb1AkMCJ+Tl0LPWVBby3DZk8xjBZDLxCZ1Q
	wr4339esQN7F6kcRLQGUNOCiKP5MBf7C/QE1prXzC6a++9IJsfNdpmmZ
X-Gm-Gg: ASbGncveLvw1oiJHps50FPkbGQi7BP8MKjhI6I6mR75CRD5o1+yh/oPe96qcPdEA2AY
	H4MsoP2bUVUKzZdMv4pVTMkomZtuI5bBhCv0VIEyIcmRTLU60U5qg6O65JgK9NmPl+TVqTQr9aG
	A77oWEJzZYbCZH5gghHv8auihd7Vd6EK1BxbmICFBUFuLSwb4bLmkGAPmuk2EmHQhA/Wm6a1nds
	hu8l1QMz+/4+EfZu1g8u3Ylq+28yYwexvIukdLDis31I6BKmFWR8kQGlii9FDSltg9pj7O0iMyr
	wNi+l8qgW3tDopHXF6SkJNbNZworz/AHaVN+8eB0v4jR88mkPJjAyC4k
X-Google-Smtp-Source: AGHT+IFgg5hiQMqm4gJHvbfHx5Gxn+8SH5qAtUYpKUyFlq0gzvv/suuIfnzPYtEwkJ8qcx4+JqgwMw==
X-Received: by 2002:a05:6000:40db:b0:3a4:dc0a:5c29 with SMTP id ffacd0b85a97d-3a4dc0a61camr1592038f8f.36.1748253272463;
        Mon, 26 May 2025 02:54:32 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cf4c6b1fsm6372202f8f.19.2025.05.26.02.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:54:32 -0700 (PDT)
Message-ID: <90194d4e3c48de7b3b4948aeb536708a4bed2354.camel@gmail.com>
Subject: Re: [PATCH v4 2/6] iio: backend: update
 iio_backend_oversampling_ratio_set
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Olivier Moysan	 <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,  Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman	 <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>,  Herve Codina <herve.codina@bootlin.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Thomas Bonnefille	
 <thomas.bonnefille@bootlin.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 May 2025 10:54:35 +0100
In-Reply-To: <20250519140220.81489-3-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
	 <20250519140220.81489-3-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 17:02 +0300, Pop Ioan Daniel wrote:
> Add chan parameter to iio_backed_oversampling_ration_set() to allow
> for contexts where the channel must be specified. Modify all
> existing users.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

With the change requested by David in the following patch:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v4:
> =C2=A0- pass 0 in the list of parameters instead of chan
> =C2=A0drivers/iio/adc/ad4851.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/industrialio-backend.c | 3 ++-
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 3 ++-
> =C2=A03 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> index 12f90aa3a156..1f975858c496 100644
> --- a/drivers/iio/adc/ad4851.c
> +++ b/drivers/iio/adc/ad4851.c
> @@ -319,8 +319,8 @@ static int ad4851_set_oversampling_ratio(struct iio_d=
ev
> *indio_dev,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
> -
> -	ret =3D iio_backend_oversampling_ratio_set(st->back, osr);
> +	/* Channel is ignored by the backend being used here */
> +	ret =3D iio_backend_oversampling_ratio_set(st->back, 0, osr);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index c1eb9ef9db08..a4e3e54fecb1 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -720,9 +720,10 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set,
> "IIO_BACKEND");
> =C2=A0 * 0 on success, negative error number on failure.
> =C2=A0 */
> =C2=A0int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ratio)
> =C2=A0{
> -	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> +	return iio_backend_op_call(back, oversampling_ratio_set, chan,
> ratio);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, "IIO_BACKE=
ND");
> =C2=A0
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e59d909cb659..dbf4e4a5f4b1 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -144,7 +144,7 @@ struct iio_backend_ops {
> =C2=A0				=C2=A0 enum iio_backend_interface_type *type);
> =C2=A0	int (*data_size_set)(struct iio_backend *back, unsigned int size);
> =C2=A0	int (*oversampling_ratio_set)(struct iio_backend *back,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ratio);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan, unsigned int ratio=
);
> =C2=A0	int (*read_raw)(struct iio_backend *back,
> =C2=A0			struct iio_chan_spec const *chan, int *val, int
> *val2,
> =C2=A0			long mask);
> @@ -209,6 +209,7 @@ int iio_backend_interface_type_get(struct iio_backend
> *back,
> =C2=A0				=C2=A0=C2=A0 enum iio_backend_interface_type *type);
> =C2=A0int iio_backend_data_size_set(struct iio_backend *back, unsigned in=
t size);
> =C2=A0int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ratio);
> =C2=A0int iio_backend_read_raw(struct iio_backend *back,
> =C2=A0			 struct iio_chan_spec const *chan, int *val, int
> *val2,

