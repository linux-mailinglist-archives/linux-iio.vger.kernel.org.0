Return-Path: <linux-iio+bounces-15890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A51A3E574
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2024B70129D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792D9213E99;
	Thu, 20 Feb 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhDGiOdv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9752E630;
	Thu, 20 Feb 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081646; cv=none; b=B1zVVJHtt7M/eWP2lYno3usC9kR3F3d9O6HMEWpYSH9/1N32UVB4807ouoslNvMmf47SHkW9nJgL+hVe7tvL+XxhcIapL/MRc5r8HG6H/4cFAHZTBYmiDdxDOw6HbXwbbcvxd0TXVkAp0dSJY12oNJBAA7q25oZZ1FLH//g6uVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081646; c=relaxed/simple;
	bh=ZwxyBNn60giTmBgx51iZZIM895gyFxQdW4Jn/GsJ/c0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K2FQrFUJKk1uZXVSaC61ZjQmjKI90OaUG8fXirRfoxS/huMgmMABwYWH3SlOWhpdnGhq1FRzbC1n35C5z1NkcX+3dbfq6j+8ABE4rn3/SSh8kokKiYG2+NyFBWZL653+9wqhw65CXBU+oST9OUoXM8RcG6B0PudAidBTOdL2wNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhDGiOdv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f504f087eso1200811f8f.1;
        Thu, 20 Feb 2025 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740081643; x=1740686443; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnVEiaezuQBE5qRpXebYksuKze6Hv6Z+t4012aOy/rI=;
        b=MhDGiOdva95Pv+Zk12iETeD+dPmEoiQFSxoDqzfWF/cO6JqYvOw8ulyQbJblgvJpFV
         JHrnL1uVBNiv6DZ+exKoIcv1HBhDvGajcZHySV75lddD0qt81jn87RBbrd2UrujGfjuj
         2VuYUnh9TpzQvp9kO8USSeCPxVbFgQkM+k1NMr0KOaaDJKO0UhfGsbCgqmvDdyuBJbMg
         DDu5QcsoDkxphDQM8K62rIqesCdG+KhTDv/TW5CXvkTFBXgEpDwug/gfHkKoGBUOBmXR
         pqbgpyf3AMfZW+Qx6W3lDiNHNlZgFr634OODRUcl3HvnYA9d/22r9awliSRibHwbDJGC
         FvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081643; x=1740686443;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnVEiaezuQBE5qRpXebYksuKze6Hv6Z+t4012aOy/rI=;
        b=oJNIohVJ/607NBFTGElcYeEUDjgMFveqrkMxcDv6VSTZAvqRT88fo76m6QBi96KhaG
         dCIZ+zJHYFRJ/tTv0Fll3ylCBJ+mQhSIjt/OfiCvohZlGsupa90UluB2coTi53TrCpuf
         iSmmrJAhXqOqAE2WK3fzM/XhZXkAdpEgsi3Cxu8dS4ZohME7Goi0OUquOoBVJdRNlRxj
         ilaatMg2DpzoGkHSOwWf1+lxDXfcrX/1DPpIX7qUuGuAJhhh7OKm3ScKZ+Q9Rl/YOKo9
         +0nFAQ3CUMqBmwE3FpNA8EQrnwEwrAuxSxzSh/hWIsB1V9ajYBu5NCaLDS5nPM3H38nI
         qPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLYQl0av+o0zBMqD7UgO2VpOEBDI/Ih5RbPhGr06P2Rryxu1q+P34Cwuyqjt9I3BcAHbWcRwXMa5IigQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOC56SjtUQpHxFriSV+3R7wo/5qUKUWGpzfvZWSZzcxtJhAnDh
	ViwKQGvHrAexwxa93DXUiLFtdyjcKbWQBfocAww7cS9kupLRKXbS
X-Gm-Gg: ASbGncu7c7h1sDNgjA+yWkttXm3iSt1Ed3Ql3ooUmY8q/obcrzWaC9siByC1RIcIs6b
	7QEW+so7Xx5gWi3estLPrDwsvT9k1yPVhHzqTyfEhJpLvrjsHzhC3VlJuG32tU/BMjeXEeuawVG
	o8oTdcN3u+nKRRWNxU2NKcAK7r2gkv91172gBB6eK60BWn15fQek3ygtVtO/cmHI0SlIBAuChF8
	tm1GysY8P/2MX44lX6mvcUJIfn9yrwTgYL0UoErp9gkL2/6hK9YuxZmCZjm5+h4MxcgpfhutU6I
	XH7mpOYahfIuqnEVPGb8GxOjfsCjz01hONTnRKAMqNpwYAnFwkfYwnUPuBCkmZsxyiYdpor1rBy
	pZUOcSmcR+nlrp7PqwdJZ2WdC1M2aqHfZkQI=
X-Google-Smtp-Source: AGHT+IEwKt6uBewYKOv88LnWb1WG6cg43+QhXhKl95Ke5zzPnvOh1oHGTYThn29dtQxdFoyhuFSY6A==
X-Received: by 2002:a5d:5f87:0:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-38f6e9595demr433391f8f.15.1740081642620;
        Thu, 20 Feb 2025 12:00:42 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-9936-96b7-6cd8-be6b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9936:96b7:6cd8:be6b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm21697410f8f.39.2025.02.20.12.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 21:00:40 +0100
Message-Id: <D7XJGM6MAB6N.2FYSUN4OJELUA@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
To: "Karan Sanghavi" <karansanghvi98@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <Z7dnrEpKQdRZ2qFU@Emma>
In-Reply-To: <Z7dnrEpKQdRZ2qFU@Emma>

On Thu Feb 20, 2025 at 6:34 PM CET, Karan Sanghavi wrote:
> The array contains only 5 elements, but the index calculated by
> veml6075_read_int_time_index can range from 0 to 7,
> which could lead to out-of-bounds access. The check prevents this issue.
>
> Coverity Issue
> CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> elements at element index 7 (byte offset 31) using
> index int_index (which evaluates to 7)
>
> Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor d=
river")
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>  drivers/iio/light/veml6075.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index 05d4c0e9015d..5dd951f6e989 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -201,7 +201,12 @@ static int veml6075_read_int_time_index(struct veml6=
075_data *data)
>  	if (ret < 0)
>  		return ret;
> =20
> -	return FIELD_GET(VEML6075_CONF_IT, conf);

Please declare the variable at the beginning of the function (there are
some integers there already) and rename it to follow the driver
convention, it for integration time: it_index

> +	int int_index =3D FIELD_GET(VEML6075_CONF_IT, conf);
> +
> +	if (int_index >=3D ARRAY_SIZE(veml6075_it_ms))
> +		return -EINVAL;
> +
> +	return int_index;
>  }
> =20
>  static int veml6075_read_int_time_ms(struct veml6075_data *data, int *va=
l)

With that applied:

Reviewed-by: Javier Carrasco <javier.carrasco@gmail.com>

