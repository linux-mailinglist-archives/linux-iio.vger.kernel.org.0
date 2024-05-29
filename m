Return-Path: <linux-iio+bounces-5437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41968D3650
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786862873FE
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50606180A95;
	Wed, 29 May 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNeGMl3m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FD3B295;
	Wed, 29 May 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985429; cv=none; b=ECeMWLzXxhmVxljkb3+Y+3dLHIsfUmbwWzERRiUK/DP80bc/DTPHxqZj6AhAKVyxgfqEux4VKyfEqT0LuPyScml5g8mdhFSct9uIbWs/p2bEiPCEr/OMly+HemeD0bfziTyWCUWKQuJNuMJce9wIxHn1hBkwo3Q1Qf8jm6Jn4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985429; c=relaxed/simple;
	bh=RkP5D3saaeTMlN+z8GdHuQotsEvMZSjBhTLRBaZ4Za0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUlgsUQRorumqWc3z5yqohPK4O7uGzduEqU3/ifvwrWuFppRog9zwIPXFSS6PvcOVLl+Wc6D1gzxevJzx9b7rS3BeBoC1WMI37jWDl+mRryHsuoLk/ez1EYOUJBADX6nXAOhv6nvz4jYhydvlGxxYwejYO/XoNrvN8zz6WChCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNeGMl3m; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6303e13ffeso226427666b.3;
        Wed, 29 May 2024 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716985426; x=1717590226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=agBA9ROkL6zGoPVLQLVhzR6Klzg/5dR73YkaHBsvPu8=;
        b=PNeGMl3mJ4yMrWxEWuRLkI8vwya7GJ95WDXj9eaKX1IQn6JSH+Dt7lAdTfwdtdTntl
         K7A/eHoF50am+ecoH2O3ZC6NW81uQ5gRCTOUQGA5Qn3KhWKaQaZ1DEd8DsGJHtQwfiUS
         TfZxXQBUgkcYk6QvLKItU631OqDFLBEQHYoM7c5N6agTqXhRz9M3ak3KqvtfB6JuCZOq
         kUSSCuYknLXiVuuZbF4KiQcaWa9nZZd+vArW9bvUQXfnlmv8XSPpxSmSAkMZw/yR17rE
         XxCvENqZXskkblOENUa1vqQwbUrZNanbgRD+zHwHBhG18nEyzScVWMRXZAS5UIG1KvLq
         U+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985426; x=1717590226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agBA9ROkL6zGoPVLQLVhzR6Klzg/5dR73YkaHBsvPu8=;
        b=qEChPhgdIf62uSqHuiBxje1yBmlDBFz9pYi/fAsDBz4f9zQKF8pAo+aHeuiDokenLb
         omamP6/sRiBNEq455xGWEhHl+QrX5B7n+fT+dnwe3iqPFvcmeCmq095eKsQz7p2kUYeO
         yjmW99NKRN5PnJdyPOvZXt7FiUiRuQigkZTv4LcnbNhvDkvKLipq6axq2JUDyh4mMWpM
         TYA1HrXBW5wkB8gAD2SBjsJehmw2b29vamXL39SBXS2oEvdSV8jl+uH6JaTbISeOAOqN
         yYDygJGYP1wL6Z9NIgXdb6/RGG+kPeKq0QWTI2qqC/aznWDq6doRA0Q36xL9WV5iRf/4
         7Y2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYh8uQjUWkP9o79Pka021cXjCukFdYWSi1Z3qCFhYvQXAOcdJ8PM9EepnRnA4Xa2SPSJ8fZiQcFBSLGt9d6xIJXEINE48StXNeseL3w+Sx7qqiQm92Z6+g2RIxbr+zTRk/gzmDZ1S8i67AsLMnxKHx4muzrjueKxWObuBghpNoLVsm3g==
X-Gm-Message-State: AOJu0Yzizrx6sqHtlcVXep9WuQ5DeL8b+RnbBJAmvH8beemvZUEw/qG1
	PAyBCAts8vyXQjGl3hQpf/VusIsME0nhF7S9kMGHrXldTOYj0XCI1npR/CHsfAM=
X-Google-Smtp-Source: AGHT+IH6i/ExeFqOf09tk7YEtXA14MubFGVMVCX2GfSnwPuaHFIipkhddoTWKrl6gWbBIYXdqicv0g==
X-Received: by 2002:a17:906:68d4:b0:a65:9c88:b738 with SMTP id a640c23a62f3a-a659c88b7a6mr53492866b.12.1716985425679;
        Wed, 29 May 2024 05:23:45 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc51ab2sm709129466b.133.2024.05.29.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:23:45 -0700 (PDT)
Message-ID: <2f26b72970be841279ca00c1b5eb91dcfffabdea.camel@gmail.com>
Subject: Re: [PATCH v3 6/6] iio: adc: ad7173: Reduce device info struct size
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Wed, 29 May 2024 14:23:44 +0200
In-Reply-To: <20240527-ad4111-v3-6-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-6-7e9eddbbd3eb@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Reduce the size used by the device info struct by packing the bool
> =C2=A0fields within the same byte. This reduces the struct size from 52 b=
ytes
> =C2=A0to 44 bytes.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 328685ce25e0..e8357a21d513 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -179,15 +179,15 @@ struct ad7173_device_info {
> =C2=A0	unsigned int clock;
> =C2=A0	unsigned int id;
> =C2=A0	char *name;
> -	bool has_current_inputs;
> -	bool has_vcom_input;
> -	bool has_temp;
> +	bool has_current_inputs		:1;
> +	bool has_vcom_input		:1;
> +	bool has_temp			:1;
> =C2=A0	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> -	bool has_common_input;
> -	bool has_input_buf;
> -	bool has_int_ref;
> -	bool has_ref2;
> -	bool higher_gpio_bits;
> +	bool has_common_input		:1;
> +	bool has_input_buf		:1;
> +	bool has_int_ref		:1;
> +	bool has_ref2			:1;
> +	bool higher_gpio_bits		:1;
> =C2=A0	u8 num_gpios;
> =C2=A0};
> =C2=A0
>=20

This is really a very micro optimization... I would drop it tbh but no stro=
ng
feelings about it.

- Nuno S=C3=A1

