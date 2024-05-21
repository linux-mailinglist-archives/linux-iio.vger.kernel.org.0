Return-Path: <linux-iio+bounces-5156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC18CACB8
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 12:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07390284E3D
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E74C757EB;
	Tue, 21 May 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPatt4kt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30B745ED;
	Tue, 21 May 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288784; cv=none; b=Tzl3pzVg1Dkx3l6NYA+rpOJEzEmfkw0ucVMuWx2FNKBZQyjY5tStbCCTWm7V3dlxhNYPuIYfGkr+Qpxok6T07YCDrMAV4bPfRvUU4ggBmN4oROmNcU2tBWhDo72ogRbgiV7SONNa1y4X5I/CQYgvehomkSmsCjnQ0fgWD5PceW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288784; c=relaxed/simple;
	bh=tC+V9Y70X/Xnv05SewXsKRHGbavT2qz+t6q9U43RK5M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bujyO28y3Y3EZs7Z5St+mg4Gzv1Zr5RN0Zb8yN21ZkKpmkzzoj6zWc+YCQROYl+/KTSnZjKww21E2Z3qFqrOyuA3BFysvPAeX5+sIPV9bB5BT8b30VfEGhlD1JSg4i+MQVJCQ8cg7C+eNlu4S+u/MMOGLpNEhEy51b0jvPPpq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPatt4kt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso11822464a12.1;
        Tue, 21 May 2024 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716288780; x=1716893580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwKhGwCuZU7pPcy50QvgvS6xSY301hGuD+YpB8vSPTs=;
        b=aPatt4kt7WlrUaKU9FbnuqZvXUOPCp+WMyX23eRN2lbccYjyz245/PK97GLkHVGif6
         0SFQ7LbqG6eB+L3Cahli3x/+kJQi0/qME9rXxC4wHNA/Yniz5qM4rWXxZXObUuyF91yL
         b9kMdyciJ30fa/FGY5esBMABEZBgjNbMRVT9uKsqVHmCk/8vpEnFtB9gNNqcSoYbN7wQ
         RuIPMVp43yloWr9Jt/oSf2oOKNwHfFjvLNT8KbUfPaTUmTYSMoR5UzC1l7Ci/L/i6HU7
         B5szHlFdOtW4rpIN4B2+qm4KhmwY8y5GzMu0+Zvniz69el191UzQL+Ukry2J/Orrc+ZV
         90ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716288780; x=1716893580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwKhGwCuZU7pPcy50QvgvS6xSY301hGuD+YpB8vSPTs=;
        b=sbRB5jVworfHBDhnoDtY874wGKINLRwjsQgjMq+3+R7Kx0Jeul9RTiShD7oNuTVi8t
         u9C3VmsJTLuEJQZU4e3S4IQEyf5FYapJ1Ths5N3Wz2zUuYxfza+alLRVy6KqhNZ80QHH
         m/Bsn1P24+AKgGSqOarBd8rzfJbffnaAsd7FAdYGhGC8QGknsUqT97SxsVLGI/J39rDT
         4dTsM+AuTEbyTPAbbvgNgoCbhukFKNpZKlUPYCWeLepHgNpVkdLYZYluYzc4OOC65fgz
         iOASvhwtWOMpr0690vmGL7fOywrw9XQG/pVNILkDwJUZ7//7BXO0+8W6UQda0UAqDkLJ
         QCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlxuG2Cr/430BPEyMYORJQrm3ARz+f13CEud9yVDDs+erhJ6z65OaQ1w60p/pBJrSOQGpftBuKXPZkgNK2UyJV/KxvH6YMF4O+TFkUqtNFDW3IW9hGqp7mES8YtZM8Hj7hftIR6FV26uiRbBkYKh/UHwKbdF8aI4vFey0/aW8khFB3EA==
X-Gm-Message-State: AOJu0YxSoTeQeNOwL7HFnAO7JhjbB0A79qbX4VWKfaUqyDsF7Q3wV7TF
	w+Ce37K3idVTc7Dkb4GB6LC5ZRdzpY/LDTiExRbQIEEdHLgujWkK
X-Google-Smtp-Source: AGHT+IFXKW6WGKcUPz8FMtXQiXjIMyo4n6v5VoDQgWnYwcqGq3eB+PXBwd5+S/yU+NN4hq4P17B1Vg==
X-Received: by 2002:a17:906:79ca:b0:a5a:5bc8:9fcf with SMTP id a640c23a62f3a-a5d5d98cec1mr749951466b.36.1716288780350;
        Tue, 21 May 2024 03:53:00 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01932sm1586399666b.168.2024.05.21.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:53:00 -0700 (PDT)
Message-ID: <cc53c6c282c070894d8c65fd78f47616d36ec75f.camel@gmail.com>
Subject: Re: [PATCH v3 7/9] iio: imu: adis_trigger: Allow level interrupts
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Tue, 21 May 2024 12:56:43 +0200
In-Reply-To: <20240517074750.87376-8-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
	 <20240517074750.87376-8-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-17 at 10:47 +0300, Ramona Gradinariu wrote:
> Currently, adis library allows configuration only for edge interrupts,
> needed for data ready sampling.
> This patch removes the restriction for level interrupts, which are
> needed to handle FIFO watermark interrupts.
> Furthermore, in case of level interrupts, devm_request_threaded_irq is
> used for interrupt allocation, to avoid blocking the processor while
> retrieving the FIFO samples.

Technically this not totally accurate (though ends up being true) as we do =
read
the FIFO samples in a thread already. The part that runs on the top halve s=
hould
be:

iio_trigger_generic_data_rdy_poll() ->=C2=A0iio_trigger_poll() -> iio_pollf=
unc_store_time()

and given the FIFO nature (as the interrupt keeps firing until FIFO_CNT dro=
ps
below the watermark), it seems this is enough for you to see some freezes.

Anyhow, I'd say the commit message should be a bit refactored. This also le=
ads to
another minor detail/question (see below)

>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---
> changes in v3:
> =C2=A0- new patch
> =C2=A0drivers/iio/imu/adis_trigger.c | 39 ++++++++++++++++++-------------=
---
> =C2=A01 file changed, 21 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigge=
r.c
> index f890bf842db8..becf1f558b4e 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -34,21 +34,16 @@ static int adis_validate_irq_flag(struct adis *adis)
> =C2=A0	if (adis->data->unmasked_drdy)
> =C2=A0		adis->irq_flag |=3D IRQF_NO_AUTOEN;
> =C2=A0	/*
> -	 * Typically this devices have data ready either on the rising edge
> or
> -	 * on the falling edge of the data ready pin. This checks enforces
> that
> -	 * one of those is set in the drivers... It defaults to
> -	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
> -	 * don't support changing the pin polarity.
> +	 * Typically adis devices without fifo have data ready either on the
> +	 * rising edge or on the falling edge of the data ready pin.
> +	 * IMU devices with fifo support have the watermark pin level driven
> +	 * either high or low when the fifo is filled with the desired number
> +	 * of samples.
> +	 * It defaults to IRQF_TRIGGER_RISING for backward compatibility with
> +	 * devices that don't support changing the pin polarity.
> =C2=A0	 */
> -	if (direction =3D=3D IRQF_TRIGGER_NONE) {
> +	if (direction =3D=3D IRQF_TRIGGER_NONE)
> =C2=A0		adis->irq_flag |=3D IRQF_TRIGGER_RISING;
> -		return 0;
> -	} else if (direction !=3D IRQF_TRIGGER_RISING &&
> -		=C2=A0=C2=A0 direction !=3D IRQF_TRIGGER_FALLING) {
> -		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> -			adis->irq_flag);
> -		return -EINVAL;
> -	}

I guess then we should rename the function as no actual validation is being
done, right?

>=20
> =C2=A0	return 0;
> =C2=A0}
> @@ -77,11 +72,19 @@ int devm_adis_probe_trigger(struct adis *adis, struct
> iio_dev *indio_dev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
>=20
> -	ret =3D devm_request_irq(&adis->spi->dev, adis->spi->irq,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_trigger_generic_data_rdy_po=
ll,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adis->irq_flag,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adis->trig);
> +	if (adis->irq_flag & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> +		ret =3D devm_request_threaded_irq(&adis->spi->dev, adis->spi-
> >irq,
> +						NULL,
> +						&iio_trigger_generic_data_rdy
> _poll,
> +						adis->irq_flag |
> IRQF_ONESHOT,
> +						indio_dev->name,
> +						adis->trig);

So, this is not really a big deal for me but I wonder if we should actually=
 tie
this change to the device having FIFO support (so a boolean in the adis_dat=
a
struct)? It seems to me that's the real reason for the split... With the
boolean, we could also constrain the IRQ level support for devices supporti=
ng
FIFOs. Anyhow, since this is the first supported device with a FIFO having =
the
boolean (while it makes sense to me) may add more overhead than needed to t=
he
series so I'm fine with this as-is.

- Nuno S=C3=A1
>=20




