Return-Path: <linux-iio+bounces-10180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E5991870
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82AE28328D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78015820C;
	Sat,  5 Oct 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jmbNPija"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5715697A
	for <linux-iio@vger.kernel.org>; Sat,  5 Oct 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146978; cv=none; b=magCgW2GQywy7DprNC5mCTbkyNJ5sHi83q4Ug2oBcjV3bpWzZ90GhYjLijPejMHhsmuVduaQO+WURG5X+p34Z0xzRDPNHG7hiOfB42ZsQ5uhWhjYyQDkdpc8DLrnUkCQCxIr5rxgdyX1TpgmIgGPsjEnT831GpXYOMiHEz+M3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146978; c=relaxed/simple;
	bh=yisxnb0egFsAafRFBnx9JVviGQTOX61NyzBW5Hznt0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J14T9/Npn//UkQ/NXYBG6i2XL+AsR8CP3s/9CyyevkLB/FTb+ntwXG1CmIgkiAsZfJ2zztqkPEBlOG/mdn+/Bg/rU8auBVCbaaMGremJRsYNEXCEhPaP6sSVFetQDVzMU2VCPyfoW8Sj8hhE3dYporRMW1ruIX3CwPvo3KbWreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jmbNPija; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-286f0dcead5so2511724fac.0
        for <linux-iio@vger.kernel.org>; Sat, 05 Oct 2024 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728146975; x=1728751775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fz5iqWZzkRkSIanhxZ9d0XaTHnZxedcupQv2iL5fXio=;
        b=jmbNPijagwkqX9RW4DGdYHnTvy1X924o+v+jTZ3y8F99PNpID0/fvnXKuIUy+ScEF+
         /CMpXbdTxRYZ4eJfQ6IB+EDunV73yid0tnarUxV1OjUaQZcjKLKoGP/HfK2yY6MwuvXy
         yVStoZlQPTl2OWnFxY1tTjfUbp6c3eo1MGbC3BHlZIKN4ZXaQlqoXEd1biU2pNcn1D0G
         5sQv0pLiDsgy/+Kxf49rH28AY3CIOpYBWt5ce/w0xauO1iZ7ADn+4g4bKjEzM9VU+bQb
         QZhZsD2UOlIDRgCjqR3vz67umKrE7KkNzkxjD6dsJ2ZdAnCRccu5uak8PCS6HN8HRM+9
         4bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146975; x=1728751775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz5iqWZzkRkSIanhxZ9d0XaTHnZxedcupQv2iL5fXio=;
        b=upUBjfAjhnCXpPvxqv5YglhuENIabnYuGVebY7TvIPE7LGzgLStUCIAwU9t0RSXi1L
         uR+vofOmIwZJK+uTZstB5MjGB7gUYjBUtRN0V3NzDWkMFjKd0zJ7lbVoWI4hNZ2xjySY
         RyqcmFgrX4eIwZIV8MQvMRUHIwqbSw6BHyJfMkxNjKf2Ha5S1tch2nWiUutBP2ahWKCr
         qpHeKXpeP1RfbsUI2/mbG6YfS7FqM8lGthTN4gImZagw9m8Zkq0k04boJHzJIxowkxg/
         Sr46Stg3qLAc/vig4efxTH8NAJ7zllbcb1v0X+wdhAK3HwR+YpHSB0nYu3xeIqaefocZ
         Dh6w==
X-Forwarded-Encrypted: i=1; AJvYcCUpwRrm649Be5FsWTNn41WF66C/nGcVHqYCMpYELCtByniJRAUqTNIMUHzKUU9Yye3DTbQ4E5ZAWIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEb1nZrpcJEhDEXA6u7qLxjB1z2FOaG9rygSn9xz6+oDkrf737
	hiW2NAjfaD4dmkz0xXY3l3pmXaZJDClah0i13LXx/3FE3KF6R4jyMoviw/o9MeQ=
X-Google-Smtp-Source: AGHT+IF4ui6OX90k7R7d+bTlwjhjgphmk3o8teENkVkRxgIOY8p/7k54A97SKVFD2tkFMtx6LJlYKw==
X-Received: by 2002:a05:6870:548d:b0:278:15b:8ee0 with SMTP id 586e51a60fabf-287c3aaefb8mr3688679fac.7.1728146974760;
        Sat, 05 Oct 2024 09:49:34 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287d7067354sm893141fac.6.2024.10.05.09.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:49:34 -0700 (PDT)
Message-ID: <2053a2ca-5f76-403c-9add-ed55b478a549@baylibre.com>
Date: Sat, 5 Oct 2024 11:49:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241004140922.233939-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 9:07 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - add IIO_BACKEND_INTERFACE_COUNT in enum.
>  - add trailing commas where applies.
>  drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
>  include/linux/iio/backend.h        | 11 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index efe05be284b6..a322b0be7b2c 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
>  
> +/**
> + * iio_backend_interface_type_get - get the interace type used.

spelling: s/interace/interface

> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				   enum iio_backend_interface_type *type)
> +{
> +	int ret;
> +
> +	ret = iio_backend_op_call(back, interface_type_get, type);
> +	if (ret)
> +		return ret;
> +
> +	if (*type >= IIO_BACKEND_INTERFACE_COUNT)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
> +
>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @indio_dev: IIO device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 8099759d7242..34fc76c99d8a 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -63,6 +63,12 @@ enum iio_backend_sample_trigger {
>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
>  };
>  
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_LVDS,
> +	IIO_BACKEND_INTERFACE_CMOS,

There are some chips that can do both serial and parallel, so I
think these qualifiers should be included in the enum as well.

	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
	IIO_BACKEND_INTERFACE_SERIAL_CMOS,

> +	IIO_BACKEND_INTERFACE_COUNT,

No comma here, and add a comment that this should always be last
since it is a count and not an interface type descriptor.

> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -81,6 +87,7 @@ enum iio_backend_sample_trigger {
>   * @extend_chan_spec: Extend an IIO channel.
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
> + * @interface_type_get: Interface type.
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -113,6 +120,8 @@ struct iio_backend_ops {
>  			    const char *buf, size_t len);
>  	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
>  			    const struct iio_chan_spec *chan, char *buf);
> +	int (*interface_type_get)(struct iio_backend *back,
> +				  enum iio_backend_interface_type *type);
>  };
>  
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
> @@ -142,6 +151,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
>  				 const struct iio_chan_spec *chan, char *buf);
>  
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				   enum iio_backend_interface_type *type);
>  int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
>  				 struct iio_backend *back,
>  				 struct iio_chan_spec *chan);


