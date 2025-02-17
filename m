Return-Path: <linux-iio+bounces-15631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BAA380C1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF1188C2FF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB52165E2;
	Mon, 17 Feb 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiSecH+3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E71DE3B6
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789544; cv=none; b=Wd8AC04ORcpOxETF68eUus4v8MYkPHY7zfDJtkDgsuL222RSSgQIbQCmAE4EF7jdztMgKbsIarHBqQD2Ic8sa46ufdl4oRW2jGaiXyYQjoug1VTi9hSFjCCBj+jRlwqJrjaPklmaxHQpQaY4rPEjcmADhM/eo8TjsLRR/V+JaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789544; c=relaxed/simple;
	bh=Q0NW4xXjhdCfHPluFh1fFqlnfssKHqA8vwHnZ1UhYnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgcUP0tBket1Masa+vBxXzCkNvx1tVjwplQSX8WVGvMuCYYH6rHmH+/ITMGvml7rvwrPxtqF2tNTZbvGGGj/drmsNkjs994oukmKEPDgXcByxV3cvHwHFY2WjpCbKEOYCsBVJGn30THT2OygCZotx3hX8C6cPZxurGttzU7MEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiSecH+3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so5467475e9.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789540; x=1740394340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H2csKt0B6iWG1NaRXK80B9TWJhsiNn+5FkgmnAb2ew0=;
        b=SiSecH+3przgHcQjUOSwKToAunfliCLODeEOcq0zuy2Bipyrm0naqwt1W6DkhMoqqn
         Y680aXT7zLe1bdh8LnPy1grazKJeGG4piwAxlFGnti5kHsP7cKZTlSEgWhnHcYV7r4BT
         IrvNXaRN78voMOungYBc4i9W046L8Z7hkj/OaBZUaAOZ/D7DsE13j++Io+pj510NzYm4
         tw7jv9XQ1A51sz4B95DKX2uoLvQp5AFNc1cW4oNqECw7BErL12/BXJgT5z2dmvlUc0pP
         bO+0cxNXPXZZwHFSwQczPz4aYhj0j8tIx4PbKEnjCvXOX20X6IJM7DufMJX/4U/ICqN4
         b7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789540; x=1740394340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2csKt0B6iWG1NaRXK80B9TWJhsiNn+5FkgmnAb2ew0=;
        b=f5m/Vy8looau+XZVV/MUG4oxWL0gDxTR63Q/gyPyLCOpfwSVlwbA5Nfp348W8LjB5j
         JpndFkdmDSX2Qkzl2EdUjvAdVmkGgsqoq/JCbCYIa9b8RIHrEahGNDTryHos4BELl2jr
         2CIz5V+/508CS6PJ5I5BJxTz5ss0u0zpHVDhH030aUh2YADvxwV9MHD98ewniUFcEpHm
         fUYdvaBv5HHp1UsvAMnhr1xzexKp8KCGZduB8daNYsWIf0pgHlXMy86lebPqRwFrqnwc
         LzKyJXzMXeuCCwMpDAmNmQ0/46CmGeItCMis6BU1ZVhC1Th/lYRnWVNhiRcGEPY+0tiI
         ClAg==
X-Forwarded-Encrypted: i=1; AJvYcCWAhvgzxlR4fRA7VpkWLLGwaurNTF/lEyEnd4jfBqBE1KHRjUyWIBNugKgLPQT6iyRjQU+g1Zif52I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCI/LpCy2+9kgBAAn+Q7d8C3+UgrwWeccM/eL9jVWEHwS5lDq
	CmCiGnZqU4esxowly+cG8ZaKRKCXs43o8ZW9aiy3AAbjuCS4nuxi
X-Gm-Gg: ASbGncuNYYnN+NjYgjaJTPux2wcHw3RPwHYFSpY3aGVGgXaSd/jobV6+NCxR28RdKo4
	a2P8abGVL1JqmTWZSTYWwQknhDh3+WebkfyrOUEIVCqwp48+ebVdVCWebLUd/dCPN52+RiRFOP7
	tJUhcJ4kbN60fwNLeFhTeypVaNEDcK1SGhvn7R56PZ6w6zsXRP/Isrlbpz2zWsqMILtMoNC0ceh
	LJPX0zachqbkyTHxxxlnk1rYbXaxTU+UCQe53my/2PCKSK+5svFOosH1ezKKxoAYm0gd9AYZKYV
	UXdEUOOg2bym/IzBvY0m35sOXJPae063VPJvwBKFvu1CDezOAo4NfX1qJXZZtHw=
X-Google-Smtp-Source: AGHT+IEgrVoXLttbeBHfGxqAWoe0b0YsAtKBfxHDU90Mh2TrNz+tqforW9Kt79/U4qX6Aqg+02A1Ag==
X-Received: by 2002:a05:6000:b12:b0:38d:e420:3984 with SMTP id ffacd0b85a97d-38f3406caa4mr8767780f8f.39.1739789540286;
        Mon, 17 Feb 2025 02:52:20 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccdabsm11893940f8f.28.2025.02.17.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:52:19 -0800 (PST)
Message-ID: <c19a71271fab999409a524f79155b20ad9e5cc63.camel@gmail.com>
Subject: Re: [PATCH v2 20/27] iio: addac: ad74413r: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:52:23 +0000
In-Reply-To: <20250209180624.701140-21-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-21-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context. Includes moving a mutex lock
> into a function rather than around it to simplify the error handling.
>=20
> Cc: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/addac/ad74413r.c | 14 +++++++++-----
> =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index daea2bde7acf..f14d12b03da6 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -826,6 +826,8 @@ static int _ad74413r_get_single_adc_result(struct
> ad74413r_state *st,
> =C2=A0	unsigned int uval;
> =C2=A0	int ret;
> =C2=A0
> +	guard(mutex)(&st->lock);
> +
> =C2=A0	reinit_completion(&st->adc_data_completion);
> =C2=A0
> =C2=A0	ret =3D ad74413r_set_adc_channel_enable(st, channel, true);
> @@ -865,12 +867,14 @@ static int ad74413r_get_single_adc_result(struct ii=
o_dev
> *indio_dev,
> =C2=A0					=C2=A0 unsigned int channel, int *val)
> =C2=A0{
> =C2=A0	struct ad74413r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		guard(mutex)(&st->lock);
> -		return _ad74413r_get_single_adc_result(st, channel, val);
> -	}
> -	unreachable();
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D _ad74413r_get_single_adc_result(st, channel, val);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static void ad74413r_adc_to_resistance_result(int adc_result, int *=
val)


