Return-Path: <linux-iio+bounces-24931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E2BCE708
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 22:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3E9406C80
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A522579E;
	Fri, 10 Oct 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy+cXTKl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82A1D86D6
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126512; cv=none; b=s2sX6aA7xlFIAQ6NPx+AdLvYaIGWtejsZHOxNmvJH+PtExbqfFYUB+xj2s/XykWqyj5Mleq7wBGH6lcwpUt314awHTrJRJm/WKZKyKgNx0jgxZSaZdOeU0RQr5u+eOSgYT79eLemaPe40WHrYmHMRS3gEGW+6ilamRh46tNao+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126512; c=relaxed/simple;
	bh=v83TZneUwIbHURqBLBUftZnuT49NHmKFDtDnU+8K10c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iv9OpPXlxfrfiuEhzF2t4gb/6ahrSFLHhCDRG369mWD0aAPiNfr5Cblw0L+Z9nnQ9mXHdcPC8yxMkg7MrbBr+HjLpMHYrZQtTxlf3T5PL/dwCrzwsa4b0H1Uoa1Tq1fw+48IvXbdsqnYnJY9dChZWI/RViM6/WZfyLuPJdqlxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy+cXTKl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so15263685e9.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760126509; x=1760731309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZfPC9OqRt3Pko14zqSSfdQDkti8kHbrjDGGNF/Jl+4=;
        b=Cy+cXTKlZPvYxmTrSFcFNp4DEwW1sX4jZMpr7yDVdo75G7w/nqcqxn9tYIfxLyXyWd
         qKo2kG+knca/THYjP0fqHUHNjOXpxWfaOtaGW+7A8e9cxUmgxDVbeRjYbw+sKkdvX+Jl
         AHoBd2t5tm5+HrhyT62O9P9NKD5kK6ZRptlWlbWSFqcx+L4NpFwD4Ft/g3rLUIJ3zRf2
         dIZN9H61QT5QJc4JATUaBXmDNoxQcieX/YOC1+Og6d/gttzGLo30xm4feYYjQykJ2hYZ
         9m7n/tysyUGT1Y+vu1DLBlxizW3G3OCSPa/Ru6m4JyGtF8AZa42rIUejHwrogY/5Rud2
         lN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126509; x=1760731309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZfPC9OqRt3Pko14zqSSfdQDkti8kHbrjDGGNF/Jl+4=;
        b=iHoFhYl4yZYmg2UMiSjcDHSj6WFqhn72+uejpHx5eg31MfpDN+MxuULKe7umZH9AZF
         S8CC5Jr5pE3wijKa2bTLGvmo95NNdlkU+jxsuQ+XdOhHKzx9ISPX6Z2LUjxnpC2vVHry
         d7lMP4ukdoI7okt07ySZEFHoESTaabh3EGpm5dYNkpas+QW9i+hYrGYO/ehFxQBOykNt
         3E6s8DuRvvaxH1Igo9L2zw8fafx8OXwBDiDx4rxfsQJlVLQuz+DLigHH8UUpFZ8ylpki
         iEZzjqmOkgLACvE0z3xepE3xRhkqPjioK9eU5MujMqNXXvkToh039KParD21/bkRHini
         7sBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jjgWB3IlXiOjwRHoQdTCfsVkuHeE7BA8w9cRpuqWBbh251m93eYcY5/cor1+8QzSlbwdtgacDcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqCBTa+Ae7506kUMpN8yQAM6bnCp/W7kTwNcWcCQG/YU5Gifq
	kWyw7+VlTO8iouqLSVUaVVV4EQJoDcJ8LAdh8Y9lLNb2JvU1R22qT+UO
X-Gm-Gg: ASbGnctI+r39Kg31xhOLsdJ76XOMYUJPVgCQQvItuFkol0lj/IttuFjDP367Wk3rpjm
	uZG7+nJB7hQnf8SDO1AGE5tG9KNXJEivjxg9isdRN57MHoNiRf6xKmxGtTiXVJYKeySzz8P8sKx
	2u2Hqh2dEKnG1C6efuMT5Q0eiJcSxqm96rfGs4UhkNqXKSXAgpAhAK/hyGhK6O9IiC2/Cubwtvc
	FnJt+/WI0mhOJYyZxd+ib2hdDHqIK1kOet76sDXfJ1iOzzMDcBABxgI5QSFU57UdVJJHjUigbUc
	IVW9hnH64ESfQqGeoB23SmlCW0nEyrCE+Y3KZjYgKRd6ECZgHTSXqkSkc32BB7fDbP+MMgaYs5P
	ShL4eHOUur9fMX53sssYI+zU/P0+HXuJNK0GxHIwsIieUwLmkhxU2XfaIolGbsp3kcNAeoxXpHj
	7jIQscXmALURJ3f3idoHW1bRJoEJCGUVNRx5c=
X-Google-Smtp-Source: AGHT+IF08fno/6+c+hT7zPA/nd21lbMJVoyQ+kHnEhcG+gDzSp6aFl2IoErRcP/YuiRklbfCtO/rkg==
X-Received: by 2002:a05:600c:1e86:b0:46e:4581:6634 with SMTP id 5b1f17b1804b1-46fa9b018e1mr92934245e9.29.1760126508907;
        Fri, 10 Oct 2025 13:01:48 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf71dsm5393260f8f.29.2025.10.10.13.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 13:01:48 -0700 (PDT)
Message-ID: <efeeda046354cabd7da93d5afa64417260fa7c82.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7280a: fix ad7280_store_balance_timer()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 20:02:44 +0100
In-Reply-To: <20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
References: 
	<20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 10:44 -0500, David Lechner wrote:
> Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.
>=20
> iio_str_to_fixpoint() has a bit of an unintuitive API where the
> fract_mult parameter is the multiplier of the first decimal place as if
> it was already an integer.=C2=A0 So to get 3 decimal places, fract_mult m=
ust
> be 100 rather than 1000.
>=20
> Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI n=
aming")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7280a.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> index
> dda2986ccda075fbfa04851a1ceac7a186b47537..50a6ff7c8b1c73905fabdef119d4120=
4c32b590c
> 100644
> --- a/drivers/iio/adc/ad7280a.c
> +++ b/drivers/iio/adc/ad7280a.c
> @@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_=
dev
> *indio_dev,
> =C2=A0	int val, val2;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_str_to_fixpoint(buf, 1000, &val, &val2);
> +	ret =3D iio_str_to_fixpoint(buf, 100, &val, &val2);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
>=20
> ---
> base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
> change-id: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126bc5=
b4ee90
>=20
> Best regards,

