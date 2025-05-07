Return-Path: <linux-iio+bounces-19229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C2AAD80E
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641477BABB2
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66221D5AA;
	Wed,  7 May 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjZPvZpg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533E21481D;
	Wed,  7 May 2025 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602961; cv=none; b=IsWSJGzv8nlNA+kHiF1GhhXrIm+q4blaUBoeLQkJUsOOkyJJu69Lmo4I3MbuBZJ/XaNKBGPzCFr8vso59s935Kq66lNGdpPU8dnQ1NScbJUYVU1yHUpZZrp72RajBtepoxxeGFDboujQM6X9L7xohfNdxcxLExOXZ5R1icbUnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602961; c=relaxed/simple;
	bh=yHf9/ftT8R0NcVDJ1hfNI2qi/CtPmDvZv+p8tcq8me0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOc36Hsteyj9fM8eCUEsZxaFPquWi1I5YpVmj0wb3Js5tcTLvehyW+79kFJYbLCnCJEHJXZIvVykfE/U/KIgFYUWbXFOsvJ0Io5MX2hpRcH1RKvObt5E+raTTWNJUQxONiRPA9nmONv7onM17x10kGTSB1YkLR+PFjP1tQd6RaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjZPvZpg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso10350625e9.0;
        Wed, 07 May 2025 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746602958; x=1747207758; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iR2zA0EdcdHsgk0AyQDnICvVvY4Gi25oEb1LErzmdKk=;
        b=XjZPvZpg7JD4Zf/3eRDQfL/MUu1skKioHGszV4yuHYq9oCsAxdinM7IDlcAJj0Rc9B
         EuBXQcQCFpKqNAfOJ0bYBKs9ChJOvmGwURjZ6vA7D77HBtIEBPFiVutXwXT94iYw6lIL
         lHe1ZBawghwTxjZK/1bYmkzRYDWseV3NX9asCLwkiQvV1oM1AjY227QI7X76/LvgFpvk
         8rwpgIYTMsd4FoZ5XAYpN1unEs/nBNA8sD4Jn+/x/aRUSMJCxHsV5zgL0T33eViJGQh7
         diDMAZ2jt8uumBd+00rhXwQd8xiP8m3nlYiSupIHdWdZJljnsR7wwCHpm457m3aEv35j
         DVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602958; x=1747207758;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iR2zA0EdcdHsgk0AyQDnICvVvY4Gi25oEb1LErzmdKk=;
        b=e2XuukMX4W7BGunHQ8tS2cnDWP03qCrWbeYEbMAOXwnkH5O9t8eT7wW0J4fnXs19U2
         HJPfldWsEbwVfajjN9j+5Y9wk4ss6NT8aijLtk+akejO64PWhvK978OaplZJzEENmSBf
         77unrS6u/NY8Z9mvdEEcBursRq1a4fCEVHZ/DFPFYzPxYH0U4BG8ofe331z78IQE4s1t
         /T6wB/yR1A5c3sfEDGF6JO2lPdQSSvzy4qyG0zqL+fl5vwrDaM/7Ud8B1NepFJSJxExW
         bPut1Te22LK98qq4uJqbS85a/wPrJcBbIKQz4XYf3yi6Dou6i7oAdq3JKFoN/QhGczCq
         DanQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJUHFDLCMu3shMfiOkHIwAhLAVH//GG9URKrTjey3OJxjBbtuDBhR8T1irwcq/3ozsObbMSx7wM2Y=@vger.kernel.org, AJvYcCXSZI3Y+YyO8t4uWdE55MI1zQyC8q/IuAJkGTr9b5eal5KHLiMqP2Vq5s7HO3l2625btdmGR6Dblfnty/eR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RFrq5RfhHqfIsKPCZHiSi4K+XkQCF7DOJWqMwZd+rGupXKSw
	xVMtZpS3YCXnxbWtAeOAou0DBSuR4DRM35FVPmvrfqgoZ0cdiGao
X-Gm-Gg: ASbGncu2ebgaC48THC/FHLnuTDbg1EFV/vkdnSVvXoHrcFfK3e/lhzlbLTclxWNI5Ni
	WR1iTmZjgoRdRUzuOnVxUfVjqbxNYQWdF336d6ba9IQU2hnViyOl1PYN4hN89I9FT6LRtyUTu8P
	XDPnQ+KH+AjtC2yjFIei3eTToKA7trw7doa3TFHre6CUvEY41ozYd62+VJdp2IkLQOZuVBlFvuA
	R8flgGXQpUxNZjTB4uQRG1ryA9L712xUjr5GBeZ4CINl1vsYIsjKeVX77yg5ovXVtkbn+27imVf
	JtOG+mNa3yQA8V/ygxOSrpJosaTdnk6lyYxmdfZh2ewjX2sQm6QYw9c12Nx8hQiWS6RjkhABjYi
	m7H37EWQoQUCGtHE=
X-Google-Smtp-Source: AGHT+IGGaL+rl/74nMAHw73kbNQ4stZN3O4aJfmM7No/pxs2x5k2i6dSgRLIWAu6ib9gbXsfdqUuwA==
X-Received: by 2002:a05:600c:1d8f:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-441d44dd262mr13902825e9.20.1746602957701;
        Wed, 07 May 2025 00:29:17 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43d0b41sm20443695e9.11.2025.05.07.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:29:17 -0700 (PDT)
Message-ID: <dd7dda31525f2947060386a2b605300cf02677f2.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7944: max high bits on direct read
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 07 May 2025 07:29:41 +0100
In-Reply-To: <20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com>
References: 
	<20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 13:28 -0500, David Lechner wrote:
> Apply a mask to the raw value received over the SPI bus for unsigned
> direct reads. As we found recently, SPI controllers may not set unused
> bits to 0 when reading with bits_per_word !=3D {8,16,32}. The ad7944 uses
> bits_per_word of 14 and 18, so we need to mask the value to be sure we
> returning the correct value to userspace during a direct read.
>=20
> Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD79=
86")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> The sign_extend32() already takes care of signed reads in case that
> isn't obvious - it overwrites the unknown bits with the sign bit.
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7944.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index
> 2f949fe5587318957f2e423029294ced0a6f803d..37a137bd83571b055e970a8cd483d87=
26972d637
> 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -377,6 +377,8 @@ static int ad7944_single_conversion(struct ad7944_adc=
 *adc,
> =C2=A0
> =C2=A0	if (chan->scan_type.sign =3D=3D 's')
> =C2=A0		*val =3D sign_extend32(*val, chan->scan_type.realbits - 1);
> +	else
> +		*val &=3D GENMASK(chan->scan_type.realbits - 1, 0);
> =C2=A0
> =C2=A0	return IIO_VAL_INT;
> =C2=A0}
>=20
> ---
> base-commit: b72f1157bfb9b92b0439e11469f7f94e47363460
> change-id: 20250505-iio-adc-ad7944-max-high-bits-on-direct-read-b358289d0=
337
>=20
> Best regards,


