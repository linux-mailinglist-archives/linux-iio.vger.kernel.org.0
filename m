Return-Path: <linux-iio+bounces-22283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3BB1A2ED
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC423A5304
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7525E479;
	Mon,  4 Aug 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmo4UUeT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B838D;
	Mon,  4 Aug 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313131; cv=none; b=qnIURcDddfIB2o10iXdU4hmfz6MPkK/3QsrzsiKpi5uEH3n21xro8Wbzgy1+OhxqJRlB23ng8r/OXdz0lFM5Ibu17cWFfq7cprmSziisMRgD71lNVdopQMST02dPqrFi/CDWd4GjkULEgYvig1ODH6+XWwmIexlKySjuJFRWFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313131; c=relaxed/simple;
	bh=OI2R0Q4lTLB1kDiC1IDjs0ZkI5WiZKYKxu18MzvvXzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh4E9rdoQVNH1JE1lO1PkT2y9ns9GzeS3cnV9Zyit2dK4EcZc9GyUm7AvlBk+Am4gtCl59UBuMOxpATSn6AbMLv/fOQV4eYpdLFPn5OMNL+lLOeZzYqfuWEvxrYk9j6v8T6/URmFoCg4cfOefCeEdeBfGqCJBbFr+kQMiMiyEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmo4UUeT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso225368266b.1;
        Mon, 04 Aug 2025 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754313128; x=1754917928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swft9UILAtkQmCs4YgSGLeRiuZYqDElcjNWNFS7cu68=;
        b=Zmo4UUeToxbYOrb1pL2UxtsOSeqE0TPyZEDyxVAygJXSZ4fhzzRsX4VMFK4oMUUhOh
         JcLNwNpYtXjKEnnnBRWQNdgIhtmK0tUjW87C2N7w4I+AeN1v3US2o3ZdQwj5xi3vNnfl
         uFhZSCvyI/vx/9IEluu8RAWC7i1yscu1KseXkHmXbhG1V6TpqCmbhHi9xfW6wWyLqcbh
         M5HgwuBUQDs6o9u6s2MzDbui07OPPGHmhIVe2I8IVzmp1ilmQE7i21yxb75wuBOQPSWj
         JCIgZU6vGflKXMbyPkgtV0amunBE4DNEfmlX7glBhnETF+zln9rwfaNZnaGVzaAwZn1K
         DtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313128; x=1754917928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swft9UILAtkQmCs4YgSGLeRiuZYqDElcjNWNFS7cu68=;
        b=a5f8mrio1g0B/ugfUQQ3YpLslgl3NCZkBRxvT5eZJBA9kNx+Bh4/ir7j41Os1E0dXG
         86Uwnbn8Mro4EJAWh/ZbMIPGpMWgn/hjnKjTFsBVeNhg/fsSyRNmgPbN2QLmk1U3/eZW
         SE3BHHB2Mks1s/dJ2e3OLHRMZL2hUbe7T34G+ZtSRvZHN904wsLl0MCGUkX8lIn2Rw98
         PucNB8Z4dw5CEERX7nntCFeK+y49XsfOzBxo2WsNWkRb7KImqk39+8oS0EEUHHONaJFO
         03Gy3h+PipAHF/qdHHv512YAOZfNZ7Rb6Gue71PfyHV5mGd5CQV9AHvL9YHHUj1s+MID
         bB8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKroTLnig0u0mgQaSO6jIPHbVPmOqnX9JEYLqQKbOe2zeqmE9xS4Gfluf3PEtiICmRDzHzVYLDQv4XbqCe@vger.kernel.org, AJvYcCVsdqstf09UIFLNnbzoc7pxbXKDG9vm/kfg1i87r3sxv410ych+sUC5C3qHDRX2KS9fYI6A0i0Gr0Rc@vger.kernel.org, AJvYcCWk6ForNCpIELVCqNpDdY1v++ZzL2nwGUXOk9P9PMCG7gNCnVO/r+eQHNfBw52MdbAEvEfuidQTqT3p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qRPtfuFr99mRbTRNwgEy3lgA9uB4Iw6qmsXUKLLijHw4DT6a
	+DPYdn+qV8pZp40Bt2wJI1rvPMGIL5UwJPaBGAUt+E/nHJ9RDQHhe618oII1XYXj9n8g8GA/YG4
	KzwBd6QUGKjPOzp0+QogCDIQDc6GHRNbOlpA1jnk=
X-Gm-Gg: ASbGncuPDtMY09M/XfKXpNV7oeeYpRDOK9DigxYv6TaORAn6HohNjgNTcB5rLADgjf2
	6oIGJ0mWs1s2BNeHNYabkF6k4qTHpkgxolXOXKh+L8a32uSvI5kqYych6B3QPoBh2ia5MChrMnc
	UatdSS1N4NlFTQLkWHkWmYLe9y68yxTeTviaLcea6ZO+QOY9IT3QFh5DS2ISHcqRkzBqKBolhQu
	EFWZwXFow==
X-Google-Smtp-Source: AGHT+IEHpdX2IDILP+rJpjx07e9XErIuO8k7iC1fwdeX+yStcAEloVb0r8iAfKXkonrvAZ/UiYSW7MHTXgCOPTKvHw8=
X-Received: by 2002:a17:907:2da5:b0:af9:341b:7fd7 with SMTP id
 a640c23a62f3a-af940230215mr810789666b.49.1754313127995; Mon, 04 Aug 2025
 06:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804100219.63325-1-varshini.rajendran@microchip.com> <20250804100219.63325-5-varshini.rajendran@microchip.com>
In-Reply-To: <20250804100219.63325-5-varshini.rajendran@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 15:11:31 +0200
X-Gm-Features: Ac12FXw0lMHcmKSaxDiokDDn22qbztJNg7JO29s19Gyej8dLjMMZT64fvF00ezs
Message-ID: <CAHp75VesaDaMNpfdtxg_LSqjRL28YNKNFOBkCcdkF8B6Mp2J7Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: adc: at91-sama5d2_adc: update calibration
 index, validation condition
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:03=E2=80=AFPM Varshini Rajendran
<varshini.rajendran@microchip.com> wrote:
>
> Add additional condition for validating the calibration data read from
> the OTP through nvmem device interface. Adjust the calibration indexes
> of sama7g5 according to the buffer received from the OTP memory.


> +/*
> + * The calibration data has a TAG to recognize the packet
> + * The tag has a constant value "ACST" with the ASCII
> + * equivalent 0x41435354. This is used to validate the
> + * calibration data obtained from the OTP.
> + */
> +#define AT91_TEMP_CALIB_TAG    0x41435354

Just add the ASCII representation into the definition name.

For example,

AT91_TAG_ACST

or

AT91_CALIB_TAG_ACST

or choose the better one, but with an ACST token in it.

...

>  enum at91_adc_ts_clb_idx {
> -       AT91_ADC_TS_CLB_IDX_P1 =3D 2,
> -       AT91_ADC_TS_CLB_IDX_P4 =3D 5,
> -       AT91_ADC_TS_CLB_IDX_P6 =3D 7,
> -       AT91_ADC_TS_CLB_IDX_MAX =3D 19,
> +       AT91_ADC_TS_CLB_IDX_P1 =3D 1,
> +       AT91_ADC_TS_CLB_IDX_P4 =3D 4,
> +       AT91_ADC_TS_CLB_IDX_P6 =3D 6,
> +       AT91_ADC_TS_CLB_IDX_MAX =3D 18,

This MAX naming with the trailing comma is odd. Either remove MAX, or
remove trailing comma, or explain why moving from 19 to 18 has no side
effects here.

>  };


--=20
With Best Regards,
Andy Shevchenko

