Return-Path: <linux-iio+bounces-18130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C5A897A6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2835E179673
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F92D27FD61;
	Tue, 15 Apr 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8TVH0S7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF9275860;
	Tue, 15 Apr 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708437; cv=none; b=BUWbIik9wBAMSzkZX9VsqLpbIi4PksqFGEr714wyyGgGMCytZ7b0/SVNjdzS6/3srHWQRfLpEuQbDOKz9BP9Aer/ZpsA/I+qZUqZRkZfa1+6BVZ3DtUexW1DcABKB0ISAxeEu+nWsa+dQzXBg3nhe9dsCEwX64BXy+p6cQBM1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708437; c=relaxed/simple;
	bh=WNM/4OfpkmjCV4Wo87i68L4Ct0zOB1z3vFnyrdWUfFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAnNZZZAxS6aa09MXX9UqKoTp4tIonOlmn9g3ikFjkwloJJRI3sengCsPKPcVfoL4IRk73KknKfylsrAfBMYaQOu0uhXAL3KrQFPW6lYaidrfv40qu2kEZSlaFkntzqnJojPYsX33WmippH4GqBJuq9hIitGJVsuYNUssm2RtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8TVH0S7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so3143205f8f.1;
        Tue, 15 Apr 2025 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744708434; x=1745313234; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2jVRA/+pZYsZV/NIcT4L7XLSuBTKMKtalPI1ILjZdM=;
        b=L8TVH0S78oldqwoNlARg6YrW0nTS1STdd3oNDxGRRiRfld3AkluE+mPBfmyqklQ+mu
         p9X+KCsPxnLUXTpyNAVUYVH1Opth8P3Shmo+KbpbOnpufFz4CUVy8DZh7gWZBz7B+lQ2
         v6gz1uAWeiNdXMalMxLCrr2mYn9XTAnj8pbmHmb73oCLK4kuneJu4SZ7lpW+QzSQV8UG
         /MGVLPVPOoy/78SYcDbjE2O0JVf1rkAySS9XXa+OGfbJPA/Mw2i5edZUPz7knlqt8Jfo
         zQKQX4hIgxTemiuGuf2cXTTVJ7KM7eOh47qRGOqMrs7JI9JuiZN7wSFaAgTcLUSOh4B6
         xLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708434; x=1745313234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2jVRA/+pZYsZV/NIcT4L7XLSuBTKMKtalPI1ILjZdM=;
        b=Mt7xmZ8yvNvP14ri7QN8b2NcLBD6hs88bFxNZviO/4JDNzXVuGwYpCNyUPtyUsxYrC
         1orzCYvejl74RRfEFey/OLpnPb65z2OBSwMoRONLXKEfHsxg8ENXuHoifEOt/jJSHd7h
         q+wYNARJFCaHYQqQx/qW8hzglEdZW+LlBZjAE60iwogcHcu7ZrqAe5X1M/bCw1BEoRcC
         NIfnBNLzDuo6mdfIiVCwkBBCi2tcHxLPtftumRH3lsmZzbXNnna4Py1Fpk2zP9eZDThG
         0HuRQQ1EMAmg3nu6QSsPBike8xDNOZC4gqgNQbtL+yUDaqJiAxvM6H54DBa7I/7fzusn
         5/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWVdqCVBzgmMrta7sVUhF5mIo4l5KM3+/geHSg0ult63fz3oWiT/qZCr5tzKcOXh6VkSfIr241U4QY=@vger.kernel.org, AJvYcCWwU0XhhSBxp80NxXQ2DTXBRYbwG4LZrAiJ6FIZ+OcsnkemsIzf/kLbhuNnc3Ufy7M/9pJo7Z7h@vger.kernel.org, AJvYcCXlzG/SqUF7jyBTlj6TLz//wkhG4MlsybVOzfDXLHr0eWthhxQXtowWs1VFXbns5UWU8q4lK7o7gA3SbAI+@vger.kernel.org
X-Gm-Message-State: AOJu0YyfzXvEr3SkPqx6Wfhbe6DxpTfisICmJoUJZ9KWVY5uqdkOXQNU
	ZPit7NvUdN145xYbb+5Uz4M9KOgGFxI+Lx6LFZqy4qfrQTVydM1X
X-Gm-Gg: ASbGnct9yCs32NMAfnP3sY3LrNnvaSgJN4h9hPKz+4gmoeZeoW4dFQTL1q7GiaOxub5
	C2SMmhmSFdyNM4XpdCv85GS11s4sQRyoyGPSE3TmvTB1NXoY5ioz4RpuvaJ8TrCp7XnKmpkSgZP
	h7mJY1zfmFgJn/ZUNQV2avgu7RFJjD+wJkOUzG+vVFoHtW6C8zapP3j1qnTzyzZmHAxlvg7NyBf
	lpROC/dbL3syibLGQ1QBzCTtNMEs1fdDSw3/BXgEnKRO0MS9eYMXi9EHoN2Oza4DP/HWVcg0bkV
	tTrhyF/jhK3GrG+OFh6rvTGNazUj6uDAkxABKRZoCl1uNY1Bt5BfI/037/ASkv9YF/dbPl4THic
	0Med7QbSX+lYA40be8yZQAV0=
X-Google-Smtp-Source: AGHT+IETzmpzV8MS7XyeqUk1lViNUBhbS8KmDB5sfjr8p/5OPY1gqFLmopkaJDenJ5glgZx/7VcLdg==
X-Received: by 2002:a5d:648a:0:b0:39a:c9ac:cd58 with SMTP id ffacd0b85a97d-39ea52124fcmr11718050f8f.29.1744708433744;
        Tue, 15 Apr 2025 02:13:53 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979615sm13923443f8f.54.2025.04.15.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:13:53 -0700 (PDT)
Message-ID: <1fb5f1c5e61ce386cb431d48296e952bdd560a6c.camel@gmail.com>
Subject: Re: [PATCH v3] iio: adc: Correct conditional logic for store mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org, 
	stable@vger.kernel.org
Date: Tue, 15 Apr 2025 10:13:55 +0100
In-Reply-To: <20250414154050.469482-1-gshahrouzi@gmail.com>
References: <20250414154050.469482-1-gshahrouzi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-14 at 11:40 -0400, Gabriel Shahrouzi wrote:
> The mode setting logic in ad7816_store_mode was reversed due to
> incorrect handling of the strcmp return value. strcmp returns 0 on
> match, so the `if (strcmp(buf, "full"))` block executed when the
> input was not "full".
>=20
> This resulted in "full" setting the mode to AD7816_PD (power-down) and
> other inputs setting it to AD7816_FULL.
>=20
> Fix this by checking it against 0 to correctly check for "full" and
> "power-down", mapping them to AD7816_FULL and AD7816_PD respectively.
>=20
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---

LGTM, do you happen to have this device? It would more interesting to move =
this
driver out of staging :)

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes since v3:
> 	- Tag stable@vger.kernel.org=C2=A0instead of an email CC
> 	- Use the correct version for patch
> Changes since v2:
> 	- Add fixes tag that references commit that introduced the bug.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Replace sysfs_streq with str=
cmp.
> ---
> =C2=A0drivers/staging/iio/adc/ad7816.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/adc/ad7816.c
> b/drivers/staging/iio/adc/ad7816.c
> index 6c14d7bcdd675..081b17f498638 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
> =C2=A0	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> =C2=A0	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> =C2=A0
> -	if (strcmp(buf, "full")) {
> +	if (strcmp(buf, "full") =3D=3D 0) {
> =C2=A0		gpiod_set_value(chip->rdwr_pin, 1);
> =C2=A0		chip->mode =3D AD7816_FULL;
> =C2=A0	} else {

