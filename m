Return-Path: <linux-iio+bounces-5264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E218CE490
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810C41F2270D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E285C6C;
	Fri, 24 May 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWXKGNtP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3E85C58;
	Fri, 24 May 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548329; cv=none; b=oiHdG9aZabiSSR4i0o+UqeKfQBnvwpTCwJU/vbcdMK1vK1CdfghFhmdu1+SJ2tmq6oXUKR9YFxqPC05uC9BO699n2LFd9uCU/cHyT5bSgrgRzPx3j1A/xFZJ4d0OITM/8N+4oaj/2flLNxdjijlgRAnnzBapnYc+NrQCqGAmU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548329; c=relaxed/simple;
	bh=Q9VS8gBm5D4iw1wUNOkx35k9uD/bcaJ51xv3pbnGj8s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxF9zejjbss99PxTJfbpF4H3GboHZVDh0xvCf7yN7B+wiw9g4w55mbuftfLTl1gPl6t+fpsRQ5LWS6JqyF8cn08pScN3LISmgeAx5Da4NQ4YYCP2VqXhPhR3SlYPVMJaQLel8MwvhP/3Fj0XF6AWbe/PZgFNBlsGiJIPsowC/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWXKGNtP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b5922so36290785e9.2;
        Fri, 24 May 2024 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548326; x=1717153126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUTmAX2bVuOG30I13E6b3axNjNKRnCtCr2heNab0U0U=;
        b=CWXKGNtPlxCS0L63ABoybR3OEWCKidFrh2lPiW1tZ+6rabwzpuV1+WGX+EUarRYu1M
         DRBRA7jcIc8xY3IDZ5sa+EVOCy2VL5gMZ9iOgwJjBrE7bEVXcsCEFTW/gNUz2gVbWQEc
         NClo0hT0li65TLkP9XkZ1GqgePzpkZv3IcP8Hpn76HBAOlPggPKkw7HBjG7RmNeWvdSI
         YZ1HoPBZUAorZgfvqW0frb6q6qKj84bFd5JsCZmfRIsUG//miBXAj+4j+k7LjtaN6Waa
         ek3nTbiXN7RF7ZqudnSWuCBRSsmk/QbSNYOv2E9UmKVUJrKa2AdKMH7dc02J5xf2Fju8
         tUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548326; x=1717153126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YUTmAX2bVuOG30I13E6b3axNjNKRnCtCr2heNab0U0U=;
        b=CDo7Ovw7p4B6MO6Nt7i+8BTliwihNIBf4WHCTn8x5hZR7DKb1DG0V/Un1BfOj1yBKy
         e1xBnk88D/a2bk1KoXQ67rUZ3JChcurGcPzV0xLoMYoWogaVHSK9ohxm6yJ/3XvhXc15
         KCC8742XEGP/YsxiblTpvUauR78cYpQSw5yiXRacv7YSq9a/lvX0ubH3Y8toQyEMEb4q
         h7YG/pScu1HQJdytmHwW9cEClHJLCoUMQR1wGxl0ajzitVo3nNjlQi18aJHFlTGIoA6E
         KWt/1KhBHWTtjaINcR4bDxbEd55TPMONtHRAqXeqTb3J1ChxzwJk8/c1u/PhRSDkgwrY
         Ij8g==
X-Forwarded-Encrypted: i=1; AJvYcCVH4G1gvHvMTQpl98+5JfWwPOfQXaA87n44Y/JOdUfi7akVfFd9ZVbXmfmSIx1fVjl9zjLfAC095vUT8S0C3S16vWP4WuiM0WOt/bqUDF4KnxxG9AReHGnacYgvcwJgIunpQ5yafzMYQN/myeFZaod2BFpx2IX40BRNDp9mXFZrdBm7gw==
X-Gm-Message-State: AOJu0YyNm3Jw5gNILHWQdtH9ZMeEb3bYiVHcXWii3VyRGkUZUfqT3Vw3
	4NMmT7zdPDdrR7YggYpjHTFOzl0uYSAr1xh+FkdKdmcOxlM04MMg
X-Google-Smtp-Source: AGHT+IFGZD4MTogp8pd3k83mBDPzlU0s7rHmr8cFDji6OnVZSMlQ6/cp4B11ra5TAiz6KmpUmr9YBw==
X-Received: by 2002:adf:f24b:0:b0:34e:93c1:7979 with SMTP id ffacd0b85a97d-3552fdaa2fcmr1590534f8f.38.1716548326177;
        Fri, 24 May 2024 03:58:46 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf044dsm1345298f8f.105.2024.05.24.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:58:45 -0700 (PDT)
Message-ID: <87b282fe0e376c0af07b21feb13be1a98fb4e3eb.camel@gmail.com>
Subject: Re: [PATCH v4 04/10] iio: imu: adis_buffer: Add buffer setup API
 with buffer attributes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:58:45 +0200
In-Reply-To: <20240524090030.336427-5-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	 <20240524090030.336427-5-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> Add new API called devm_adis_setup_buffer_and_trigger_with_attrs() which
> also takes buffer attributes as a parameter.
> Rewrite devm_adis_setup_buffer_and_trigger() implementation such that it
> calls devm_adis_setup_buffer_and_trigger_with_attrs() with buffer
> attributes parameter NULL
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v4
> =C2=A0drivers/iio/imu/adis_buffer.c | 32 ++++++++++++++++++--------------
> =C2=A0include/linux/iio/imu/adis.h=C2=A0 | 19 +++++++++++++++----
> =C2=A02 files changed, 33 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.=
c
> index 928933027ae3..871b78b225e2 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -175,31 +175,36 @@ static void adis_buffer_cleanup(void *arg)
> =C2=A0}
>=20
> =C2=A0/**
> - * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
> - *					=C2=A0 the managed adis device
> + * devm_adis_setup_buffer_and_trigger_with_attrs() - Sets up buffer and =
trigger
> + * for the managed adis device with buffer attributes.
> =C2=A0 * @adis: The adis device
> =C2=A0 * @indio_dev: The IIO device
> - * @trigger_handler: Optional trigger handler, may be NULL.
> + * @trigger_handler: Trigger handler: should handle the buffer readings.
> + * @ops: Optional buffer setup functions, may be NULL.
> + * @buffer_attrs: Extra buffer attributes.
> =C2=A0 *
> =C2=A0 * Returns 0 on success, a negative error code otherwise.
> =C2=A0 *
> - * This function sets up the buffer and trigger for a adis devices.=C2=
=A0 If
> - * 'trigger_handler' is NULL the default trigger handler will be used. T=
he
> - * default trigger handler will simply read the registers assigned to th=
e
> - * currently active channels.
> + * This function sets up the buffer (with buffer setup functions and ext=
ra
> + * buffer attributes) and trigger for a adis devices with buffer attribu=
tes.
> =C2=A0 */
> =C2=A0int
> -devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *in=
dio_dev,
> -				=C2=A0=C2=A0 irq_handler_t trigger_handler)
> +devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct =
iio_dev
> *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_handler_t trigger_handler,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_buffer_setup_ops
> *ops,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_dev_attr
> **buffer_attrs)
> =C2=A0{
> =C2=A0	int ret;
>=20
> =C2=A0	if (!trigger_handler)
> =C2=A0		trigger_handler =3D adis_trigger_handler;
>=20
> -	ret =3D devm_iio_triggered_buffer_setup(&adis->spi->dev, indio_dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_pollfunc_store_time,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trigger_handler, NULL);
> +	ret =3D devm_iio_triggered_buffer_setup_ext(&adis->spi->dev, indio_dev,
> +						=C2=A0 &iio_pollfunc_store_time,
> +						=C2=A0 trigger_handler,
> +						=C2=A0 IIO_BUFFER_DIRECTION_IN,
> +						=C2=A0 ops,
> +						=C2=A0 buffer_attrs);
> =C2=A0	if (ret)
> =C2=A0		return ret;
>=20
> @@ -212,5 +217,4 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis,=
 struct
> iio_dev *indio_dev,
> =C2=A0	return devm_add_action_or_reset(&adis->spi->dev, adis_buffer_clean=
up,
> =C2=A0					adis);
> =C2=A0}
> -EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger, IIO_ADISLIB);
> -
> +EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger_with_attrs, IIO_=
ADISLIB);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 8898966bc0f0..8dda3cfa5773 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -21,6 +21,7 @@
> =C2=A0#define ADIS_REG_PAGE_ID 0x00
>=20
> =C2=A0struct adis;
> +struct iio_dev_attr;
>=20
> =C2=A0/**
> =C2=A0 * struct adis_timeouts - ADIS chip variant timeouts
> @@ -515,11 +516,19 @@ int adis_single_conversion(struct iio_dev *indio_de=
v,
> =C2=A0#define ADIS_ROT_CHAN(mod, addr, si, info_sep, info_all, bits) \
> =C2=A0	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info_sep, info_all, bits)
>=20
> +#define devm_adis_setup_buffer_and_trigger(adis, indio_dev, trigger_hand=
ler)	\
> +	devm_adis_setup_buffer_and_trigger_with_attrs((adis), (indio_dev),	\
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (trigger_handler), NULL,	\
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL)
> +
> =C2=A0#ifdef CONFIG_IIO_ADIS_LIB_BUFFER
>=20
> =C2=A0int
> -devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *in=
dio_dev,
> -				=C2=A0=C2=A0 irq_handler_t trigger_handler);
> +devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_handler_t trigger_handler,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_buffer_setup_ops
> *ops,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_dev_attr
> **buffer_attrs);
>=20
> =C2=A0int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indi=
o_dev);
>=20
> @@ -529,8 +538,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
> =C2=A0#else /* CONFIG_IIO_BUFFER */
>=20
> =C2=A0static inline int
> -devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *in=
dio_dev,
> -				=C2=A0=C2=A0 irq_handler_t trigger_handler)
> +devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct =
iio_dev
> *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_handler_t trigger_handler,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_buffer_setup_ops
> *ops,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_dev_attr
> **buffer_attrs)
> =C2=A0{
> =C2=A0	return 0;
> =C2=A0}
> --
> 2.34.1
>=20


