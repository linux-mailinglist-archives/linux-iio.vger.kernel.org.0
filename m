Return-Path: <linux-iio+bounces-17954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C1CA8620A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1469E460351
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178620FA90;
	Fri, 11 Apr 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwTXJXH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02438FAD;
	Fri, 11 Apr 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385851; cv=none; b=Sfvx4uxF3LEfWnGC3G7fYceUtO2pCRUVerBokye0KtlPbrSALEiHHayxiPQo6z/x2hptmeLRLNYwLCM2AXmi5b85pVRXfOP4BmdXia/mmw1YvHaavSb/9d/J+QQdvK/6CtTpYWtNgatx5FP34alwx09nrZ/IPC4dsqJr7nMYE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385851; c=relaxed/simple;
	bh=fDRRe0Vo8MsJlmXmjA8331kCKEUcsy/Mwqle2vPH27A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3qGj23XZvor+a8hlxWmCrMV+V29CjFg2OShNt9S7/dUxpa+qE4tLjGFh0eYMwXc2ds1SjaFATw3qEMeWhN56o6FY7M/6aB0eWB+Eo/qDGcrFHCE0PMQJfOoaoQYX6z8nTWJmvO/Q+aILGw9VPk5aSPxxE6It+7FtxYbO7XwJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwTXJXH9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso14971275e9.0;
        Fri, 11 Apr 2025 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744385848; x=1744990648; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtHELzGhuW6IkR/SmUv1y38cOrSHAmRqhP7AdXLw9DY=;
        b=MwTXJXH9BJoZK9VYudkwUjFlmgj2b9eods4y5kyfC4OIdaJRGyqcNAY9z8jCQaOGsg
         OSgm9rgNa9liohkr27Imc7VhkgqJEnEW9UdLpY7SFaFmwDxBaXjx6R/Rc+eOh+583i8i
         sZbESCwmWlIr13eqkjdiAzMrZmbxTBW1ES9sge65i17Z8j9hvHvPmo7csQoRFgFYyNLl
         dSJayIIfh+Fv6JetONNbN2RXTdAUaSom0N/zJymkOR07NUZA70tBa2fuUnc+YRETBm6z
         ANY5vxG/zVJXSJ/RCX1hd3jB24/h5u8bWIMTkZDZ4/8suSEFop5adTnf7ESNW5IhX+V8
         blow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744385848; x=1744990648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtHELzGhuW6IkR/SmUv1y38cOrSHAmRqhP7AdXLw9DY=;
        b=SqchQjueKhoU8Q5vcmCawkx5JV86jehZyWGFOfsmekNKGGwGNKRVxS8Xbz6xwEQOon
         4z+DIHf8q9FyNhwuddMjUWkO5AvW3uTleW+P7zS39nhXGVBCJ76azxaA0tl6IDeA2qRy
         hDdGrImq+jiG1qsVI9zFExL+k7ZMjsrCARLKF60AHw93yNw8b+paJuOUrRHJ0HplcBLG
         PCnrdCBh0IA0A1+kcwVlggq77FNsvhyFY/OECz0P++N0OE8/zhyPLcPy2/ngRwL7KHs/
         u65dldO0HF4z5le4wHuIyElaOULnfVute5E36gRmehtA2JuLPS/lltQpO2cTQ0WMDFT8
         WWoA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmBYIADdd3wYw1weSJNxb7loCK1fEK4K1CfRC8hqberMKZdgz5M6WX8fDiqy6WrZc/wmgHoOGZKZT@vger.kernel.org, AJvYcCW6uiNennPZIBJtMsr59Km16xJl1WBYrNxoNvs2HauCRuhD90QpH4mwiniNGtNz5LYUidaxy1ZtNk0T5oaa@vger.kernel.org, AJvYcCWI8itfHdisOVs8oQBBLDTP+m+o94vJUJRpN0t6FD5GLolQCr+SGZ08jb73nSVFg4H0z58+YvvS16l3@vger.kernel.org
X-Gm-Message-State: AOJu0YxfY927X7BLvB4oPmJgHKx1OGDUtnB6q4hK0fhaATwQ1pm8H4BH
	9rGzp3COKQEJSHTz6bfvqjJ7ooICVGxa6GkTaVtVndM0gsUHePwfB+pqlHThtfUW0w==
X-Gm-Gg: ASbGncuLhu6JIaS6qIn65etA4rmLssmWsoD2IE8m6kkxGxRzP/J+Mr9bNGizKRGgA99
	vUwKEoa8MbJONtqa1H+6lVIaR7p6+EVDmmkQS1Qho52cSlvq54r7rV7YtN4wiMoWhtTvyG9obyE
	w8TQWF47eQQTA0xGJvfUpTgCnxGCpYXDjbyIZCtyFNJXeNxeceMwVVj4i+tEkuF7BR0JvlB9BPE
	K876hZFLFHgWDXnvo/APinW5SLbVStsumkfYXx++Lhp/QfAzfFWYGkEA6Q6kvFfFwLRSO/+66YB
	yYVGZkKcUOAnXSYeoLyHlLntQa3gCTY7Y6TwyzqcTUC+uPbu0Umisqrqh4z+1CJuwbpGaFxz+il
	T3DL6L0+X9K8R
X-Google-Smtp-Source: AGHT+IGWFccAgv+5F837HqeaOX+7V6jFIxHpLZX6I3O2n7dkRELlFksUoypsTSa/82r3riMQSkeIiw==
X-Received: by 2002:a05:600c:54ed:b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-43f2eb960b7mr56574855e9.13.1744385847472;
        Fri, 11 Apr 2025 08:37:27 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5ec3sm88152935e9.39.2025.04.11.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:37:27 -0700 (PDT)
Message-ID: <c352c000a9d2c855dc4e5b01e16682a239e8cae7.camel@gmail.com>
Subject: Re: [PATCH v2 01/13] iio: backend: add support for filter config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2025 16:37:28 +0100
In-Reply-To: <20250411123627.6114-2-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	 <20250411123627.6114-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Antoniu,

I do not have time today for going through all the series but I'll already =
leave
my comment on this on..

On Fri, 2025-04-11 at 15:36 +0300, Antoniu Miclaus wrote:
> Add backend support for digital filter enable/disable.
>=20
> This setting can be adjusted within the IP cores interfacing devices.
>=20
> The IP core can be configured based on the state of the actual
> digital filter configuration of the part.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
> =C2=A0- improve commit description
> =C2=A0drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++++
> =C2=A02 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index d4ad36f54090..ffafe7c73508 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -778,6 +778,32 @@ static int __devm_iio_backend_get(struct device *dev=
,
> struct iio_backend *back)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * iio_backend_filter_enable - Enable filter
> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_filter_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, filter_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_filter_enable, "IIO_BACKEND");
> +
> +/**
> + * iio_backend_filter_disable - Disable filter
> + * @back: Backend device
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_filter_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, filter_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_filter_disable, "IIO_BACKEND");

This seems to resemble the filter_type IIO attr so I would likely be more
explicit in the API naming. Like 'iio_backend_filter_type_set()'. And that =
also
takes me into the more important point. I would consider having this API ta=
king
an unsigned int filter_type (or an enum with the same possibilities as defi=
ned
in the ABI) argument rather than an enable vs disable thing. Like this, we'=
re
just thinking about this particular usecase but it can very well happen tha=
t in
the future some backends might need to know the specific filter being
configured. Sure we could change things later on but doing it now is pretty
straight so why not :)?

- Nuno S=C3=A1


