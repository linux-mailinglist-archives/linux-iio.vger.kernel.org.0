Return-Path: <linux-iio+bounces-20999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04580AEBCA0
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7AE164679
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB272E9751;
	Fri, 27 Jun 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACNE+BzY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF219D89B;
	Fri, 27 Jun 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039808; cv=none; b=E4itW3d1yl339q6mLFNVqam9X4hCiQ/SkFJDQKIZ73U0j5m/cvaai5u1g+12QP6qZhc9s7DiPCbwPyPnX5MFdt/iUvjir16dJWGJfobHeB/zSg8e201LPjbreIuweb2en4cSMf4FgLsX9gORluV/jrGFcBNtIlmUPYpAWATDj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039808; c=relaxed/simple;
	bh=seh8opfNudjWdQklnYEbjMOaE4msR+OSBfaNqXdugOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPC6ksEPhjVRFf72h89pFecrJhR3V/ZAsbPW5ZTVivXQ9ml+OdAvPxg92/cdVmALngv3lyGzjOR1tcWvrF6bKQlBGcRiVIb3lr2zqot9oUwosbfoUiIhEicUtmqYfMyQfqnYlOHJdpmMvL25hz/vKfz6SG0eUXIZI9Miv6ucK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACNE+BzY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a510432236so1825307f8f.0;
        Fri, 27 Jun 2025 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751039805; x=1751644605; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6O6idYvvd7oXDFef9YBBpW9+f8KvCtTxmkJ8rEx+Gcc=;
        b=ACNE+BzYelsIwLswq4cj+8sQ7Srcy+NyCyc9pYU7pAfYGgdg4FdJ1Xsd0hVi+4uKC7
         l3vTEhhouPcSX+CiE2K1RfI7Kyg4Tt9Fd5+LKccLsX4ODldOhvt0mbYKBUi2uSeDpcD0
         CsCOCXCa3r/R3XL9oAL7vS1mhuh4qF3DZkyhIs6q+Qq0u8tvOHQptYFZy7JFAWWvXRHo
         kMnDzB3/TMhh51Nxf+cx2/Z+fOTtfp9dl33kSrHqRIK4jaKq/smrSJz3S1vDwcmdpUeq
         jjJpY1fJeVoK9SOYURZKpvEPr0sUZaSOYqsckSuoqAuFoX4/c+WsOIuP/mRFbeVU+hT5
         kfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039805; x=1751644605;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6O6idYvvd7oXDFef9YBBpW9+f8KvCtTxmkJ8rEx+Gcc=;
        b=Z6b9dlPRI8ZtrroNc0P4NaM4qB3Gp7zY/3k6/wI+JUaY0Z3IGEkaFYFOJfthcLlg59
         Eti8bBDHoPHtAWfO1Mk7CU+ZGRJ5v4SCw4CsrgLJwkUtYlFB1laz/Vod0LwaxP89KkZP
         qnGQw2KY6Oqm6Ecp51Lu7grSAV45NBnfrycmmpH1rLhMXyOBeIB7yVwGdkpTUz2JmUPd
         Ki6cwJnnLpenL/8MGjqR9JbKpcFj4zwuxfo2pZhBguMC7+JmNv6BHNeXWWI+Mu7n95D/
         jzbJIDVsfc01fqel4QAA+mMvajImjjOIvrqx+8ahoZ8Q5BHhziEEJHeXwDpDnDN6XarH
         AkiA==
X-Forwarded-Encrypted: i=1; AJvYcCUEBSvKsZrQMrUwkXXw9xi3Ve8ACkyPOQodVOGFk9Yo4hgR/zAJM6+yD6LynxfTLaAhH1OTPCUFd5+Gjjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfUVTmrqGFPOPJi9nh6ZZZFDrESNQAvKGHCYDUKAQUoPKxi+ui
	4Yn1cKMofRuvyUOwa90E9RiPxRRaA7PP9knn+NMFsVQsith2PsTjiUP5
X-Gm-Gg: ASbGncv3Dxymfum5l7HeXebRp5L9nNGl0ddb2T8s/q1gQZsrBy9k/D9W/ZsBRhrNJIt
	4LY8h4VgWXX0XoEiO/EjT6bmsDgVT/bQ4zfN0BAGUgxqgQ3xhLgzL6F2D24JJDj92l4tLrx64jy
	Xl58ZAfxRFxY2atg58bp/sk/m6Djb2F85cZP/GhI7wxtdbEaz/bobxpNh09kPMfzTKd8aDn1975
	cr/1N+B+DYYxGWdzRvjELIuMl545xlUwWHpvZBL0bgvPhqkURpR6rwc+vxVXmMZwWsmCghV7+6r
	F802nhDGrKjA7vIgtwY8xvKmMBmonyB91icEJsB2HPSpfyF3Zu1xMCsMdMV6BxdYp3FhxQ==
X-Google-Smtp-Source: AGHT+IE4a4I72nLCTRYleWtFC5YZjODy9qWh87mZgIA844i4/nZGIblwiP9IwslChuceELFRidx+sg==
X-Received: by 2002:a05:6000:4186:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3a8f482cf28mr3216991f8f.22.1751039805292;
        Fri, 27 Jun 2025 08:56:45 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c99sm2995844f8f.49.2025.06.27.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:56:45 -0700 (PDT)
Message-ID: <cd0b9044ce6434e9313a4fddf73897800821aec3.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: remove unused oversampling_ratio
 getter
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>, Andy
 Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2025 16:56:55 +0100
In-Reply-To: <20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-getter-v1-1-26cbee356860@baylibre.com>
References: 
	<20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-getter-v1-1-26cbee356860@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 22:44 +0000, David Lechner wrote:
> Remove a call to ad7380_get_osr() in ad7380_init_offload_msg. The
> returned value is never used.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> I wrote this a while back but it looks like it never got sent so here
> it is now.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 5 -----
> =C2=A01 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> d96bd12dfea632b62475d6537c8d6601b042de1f..abcd4cc70074723303b9b67e2b89b0c=
4b43c
> 6884 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1165,7 +1165,6 @@ static int ad7380_init_offload_msg(struct ad7380_st=
ate
> *st,
> =C2=A0	struct spi_transfer *xfer =3D &st->offload_xfer;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0	const struct iio_scan_type *scan_type;
> -	int oversampling_ratio;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	scan_type =3D iio_get_current_scan_type(indio_dev,
> @@ -1195,10 +1194,6 @@ static int ad7380_init_offload_msg(struct ad7380_s=
tate
> *st,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	ret =3D ad7380_get_osr(st, &oversampling_ratio);
> -	if (ret)
> -		return ret;
> -
> =C2=A0	xfer->bits_per_word =3D scan_type->realbits;
> =C2=A0	xfer->offload_flags =3D SPI_OFFLOAD_XFER_RX_STREAM;
> =C2=A0	xfer->len =3D AD7380_SPI_BYTES(scan_type) * st->chip_info-
> >num_simult_channels;
>=20
> ---
> base-commit: b57cb7c47e31244bef6612f271c5dc390f761e17
> change-id: 20250624-iio-adc-ad7380-remove-unused-oversampling_ratio-gette=
r-
> e54413627fe0
>=20
> Best regards,

