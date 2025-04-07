Return-Path: <linux-iio+bounces-17777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223AA7E707
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BA53BA12C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60523212F8A;
	Mon,  7 Apr 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bism88s7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782920E6E6
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043692; cv=none; b=MbZjEXogQps15MG3UxEOK6ogJ/Pb8iTyLkhg0xTWohNkq357OYQ88RAsqLexq7afOjwstxf5aoTh5g9fGqRNrcFGIKE+pdBR93he31Yvr+surcXksK1+UlkbYgnTEBt3cLJh3Wze1pLixyVUhz5YZfDqOpO/Hv51nag7My5wajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043692; c=relaxed/simple;
	bh=QjnkRdpL+NlOwC5N9Ascvlgc23O6I+RcxoW8S07+034=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBhiasEovX/im0Tu57Y3pEk0FVz0gqBcISTcRIMpNXyCMMgZL6M1Gj+xmyBIWAbYJUqCWLEt0viwRoMDKyabaXEc1DjYi7SHreb6S45l5dSQE7omYCEuqgGmoQF2vdR2xlgZuOvJ1H/DL2KsoWebJPB9c0M+vAM9K64gnHcdI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bism88s7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso29330055e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043688; x=1744648488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=awU54n1XmmRnUXyp0iAIFHiHZXaVqOAq28tUHBc3eMY=;
        b=bism88s7S/WZVeNMrDeVCoCyjTRCacgAmWAhmBcR3PQNG3UjIsF37eQnQ83VC2x1SE
         XWWM1W0zpsS5au8t/nkYGD3Xq7m+kVZkj9VEXi/BMS6oePdfGjPDhieoMlScAD2ABF2D
         LeCm7+hblMK23JbIXQscRxPLhG5pTJrpU3ly0d4gi349mup7BVGSIE23mS15YYAwzRav
         33yYeUd5jhZzmz2LFeIcsZAPzjaHFlUWb1BCo71/guTEufvhf3w5m0ioEtf6yNXXe9HR
         9rBTqobAfRu/2JCckmvRZIk34Y6BXVlv3LXEhH/A0Ze6UcxeJ7N5uz6jN5RmS0RQ0gIW
         HhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043688; x=1744648488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awU54n1XmmRnUXyp0iAIFHiHZXaVqOAq28tUHBc3eMY=;
        b=pOqCGit8Ot9t5cBlTDVnY4Y0JHWC5Qx1EmKkDRa++KhhhWli98slisiAE2V8GbWRvp
         nnqvvyDLpVuFvKO8OYhLLN3+p28W3mAwqvozAJEjevq8yVnFLvcEtQpXMOgColK2tMSL
         mAB6NfvTq1GklOQagmA+wlM8CekdGxhAtcZ/dJ4lomJrbGrIoPyzzw8ovNpFKz/FHML2
         dsRMx9JgrKjq4pMWg539lTvyHfLeNrk2XRbYTK2aRiQxNrlQKR9C4Yfhy1m1TaTzWVzv
         1uIjH7ZiFZpPH0fhOhVGtPriWwRMhIKjQD5zSIULPRDxI1PXE3FmfcfCCVV2HCG5g3ba
         hNmw==
X-Forwarded-Encrypted: i=1; AJvYcCXNCy/Ag5ud6vlk+Xwq+qaUILX3oMR4zeOJ/KlVA8OUNCtTK02T00hzT9fm5bGuHY5OdPXRergDZqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytsYvOznblPYyH1BJ+BHWbQw7QDn8kGI9JvwCBvdT8FMVAOMGu
	eHv/LSDgwqYMQ7c2MoRfdwp8yfPmCdnM1/9RfEAjQS/Gl49PuOovjlp7BcQPZFcuOQ==
X-Gm-Gg: ASbGncumUDPmRcQ9nSkmLwRtwm2sDh21+tq3iuZea0sh1NC0+gf5RMH8X2wOWql/akS
	SNuA5LAUGCyf92Yr9oMH5Qw+4Zc24l+w7mOVPuJK4LE/rzwY2rhk4Gb2LLzOIIpAOaYVg0Ua9DO
	Tqwp4ZZc52TMtBaHdmPVJyUywsdqjRz7jIfd6iklmihlz6AGgxCC87v1L2gF8Rf46+fceA6JEFK
	q2aFWamwqxiOXM0FB28/4M/TEElaKdf1NvDECP5UD4ceBZQUuqYgqHBj+PnbrPLmgplaoWoJLMN
	cEmYmODLjgSNOepBO7CQLytP2ecnVU3EJjoDEn1z9r/84tT+R9TANoa28X+qTUddRsrSVAGvwOz
	8frobHCBbrTO6HWWg
X-Google-Smtp-Source: AGHT+IGtyQgMbuldFBprIOb2w18eYqZbtBXTY3DVUL9ExoGNXmoclf5d6Zq0Er1TIO9Hn/qboiEsng==
X-Received: by 2002:a05:600c:1d02:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43f0e5e02fbmr874695e9.12.1744043688493;
        Mon, 07 Apr 2025 09:34:48 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8952sm134718195e9.10.2025.04.07.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:34:48 -0700 (PDT)
Message-ID: <b3bf13448a0eda9e83fd501fb4fc7e29070bf0cc.camel@gmail.com>
Subject: Re: [PATCH v2 06/20] iio: dummy: Use a fixed structure to build up
 scan to push to buffers.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:34:48 +0100
In-Reply-To: <20250406172001.2167607-7-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-7-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-06 at 18:19 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> It has long been discouraged for drivers to make use of iio_dev->scan_byt=
es
> directly as that is an implementation detail of the core. As such our
> example driver should definitely not be doing so.
>=20
> A simple anonymous structure definition suffices here as even though
> we have a mixture of signed and unsigned channels only the signed ones
> use the full storage so the unsigned channels can used signed types as
> well.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Add a comment about stack buffers not being DMA safe.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dummy/iio_simple_dummy_buffer.c | 20 ++++++++++--------=
--
> =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index 288880346707..eca5f0652d23 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -46,11 +46,14 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq=
,
> void *p)
> =C2=A0	struct iio_poll_func *pf =3D p;
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> =C2=A0	int i =3D 0, j;
> -	u16 *data;
> -
> -	data =3D kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (!data)
> -		goto done;
> +	/*
> +	 * Note that some buses such as SPI require DMA safe buffers which
> +	 * cannot be on the stack.
> +	 */
> +	struct {
> +		s16 data[ARRAY_SIZE(fakedata)];
> +		aligned_s64 timestamp;
> +	} scan;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Three common options here:
> @@ -69,14 +72,11 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq=
,
> void *p)
> =C2=A0	 * constant table fakedata.
> =C2=A0	 */
> =C2=A0	iio_for_each_active_channel(indio_dev, j)
> -		data[i++] =3D fakedata[j];
> +		scan.data[i++] =3D fakedata[j];
> =C2=A0
> -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> =C2=A0					=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> =C2=A0
> -	kfree(data);
> -
> -done:
> =C2=A0	/*
> =C2=A0	 * Tell the core we are done with this trigger and ready for the
> =C2=A0	 * next one.

