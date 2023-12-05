Return-Path: <linux-iio+bounces-627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358BA804CA4
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 09:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673B81C20DF2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4472E839;
	Tue,  5 Dec 2023 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FET7OtMQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0DDC0
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 00:37:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1ca24776c3so32253966b.0
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2023 00:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765476; x=1702370276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKsTemEihZv2vC9OxWB7MGNqxP1Szsn4vPdHbIKlSxA=;
        b=FET7OtMQt25JLMyYqP7NDn75VXgBfsr/G9KW3BLIX2bAFRerPSmjKlikPyVPQNOtGC
         v6aXS3Jx4/g3vlLV80ijFtxsYUbS7jbvOY1uVDeJQTnDvky3O1ezLW7Ah9GcWWI6vIQ8
         kQfIg2XI1/c7KD/tNN5nZqPUiafES5u/XsH7kgD+zVwqXSsFdLBgLqRM6JrDpfW6Me8P
         Cw36LgkwxkvNpO6itGa9IwkEPaSjwLoQVKAc81HY96DqDTAeebaUayInk6Yx4rhm0xte
         uLqbgfU1/iRoPRyt2RA4wxZES57Yc9zzx15xTmjRNvO4FbhULVtivqltSfGr+VOzx5bV
         NTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765476; x=1702370276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKsTemEihZv2vC9OxWB7MGNqxP1Szsn4vPdHbIKlSxA=;
        b=u4BGlVQ417iIzYKIeVAnhJiPpF3S63L6T8gmk7EDNJscdz0ye1mZ5nwbw1tNN8IE2c
         1jSAFFnqoW3CKez4vVoztpG0xNK7giw4tq0UePFSFR1A54JS7UvK/tNvasifpu+qvTib
         dCX6MtR/Xd0nWRrQe76JhHCbhj+1pgeNzuOo2mszvj5ChWzBgOn4ymlGxS9EPSbhh+b/
         i24hgwCbUvNoMb6RxeR3IC3OcsRusIShMabLIj0W6E9qh4F05YMo9sqYtu8/VqpHZ0YH
         iMGUa8TmYCGV12lUUu3ad+tjTn5g/ZonZhvwpn+Pd+iqFoUiywD9KpWtLEyl0IFukyAL
         voDg==
X-Gm-Message-State: AOJu0Yz5fKwfLDIm47ni9YCgtWxKGPrBBQ4+mdGkCIP04xACrVFSk2x0
	x5SRaSk+XboaAtTkIx8SNWfqEDkvGJ8=
X-Google-Smtp-Source: AGHT+IH0cJFNGBN0qAziTxNG27Gcf/8YQis2Q+Z0gIKD1mv7gYk/lr1u1IGpfd2Qs3gxzqjwcv2Ytw==
X-Received: by 2002:a17:906:73c7:b0:a1b:619e:53f7 with SMTP id n7-20020a17090673c700b00a1b619e53f7mr703357ejl.27.1701765476412;
        Tue, 05 Dec 2023 00:37:56 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:7143:f865:4a98:8091? (2a02-8389-41cf-e200-7143-f865-4a98-8091.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7143:f865:4a98:8091])
        by smtp.gmail.com with ESMTPSA id pj20-20020a170906d79400b009fd2028e62csm6297010ejb.71.2023.12.05.00.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:37:56 -0800 (PST)
Message-ID: <345e4d18-d95b-41e3-bdf7-9daea33a874e@gmail.com>
Date: Tue, 5 Dec 2023 09:37:54 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iio: humidity: Add driver for TI HDC302x humidity
 sensors
Content-Language: en-US
To: Li peiyu <579lpy@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <20231130-hdc302x-v2-0-72f765c0f1e0@gmail.com>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231130-hdc302x-v2-0-72f765c0f1e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry, this was not meant to be sent to the mailing list yet, please ignore.

On 05.12.23 09:33, Javier Carrasco wrote:
> Updated version of my modifications. From my side the series is ready
> for a new version to send upstream.
> 
> Feel free to add any improvements or discuss any of my modifications.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - Drop IIO_CHAN_INFO_PEAK_SCALE. It was discussed with Jonathan Cameron
>   and this modifier will only be required if its value overrides the
>   _SCALE value.
> - Document the new _TROUGH modifier.
> - Fix heater configuration order: config value and then enable.
> 
> ---
> Javier Carrasco (2):
>       iio: core: introduce trough modifier for minimum values
>       iio: ABI: document temperature and humidity peak/trough raw attributes
> 
> Li peiyu (2):
>       dt-bindings: iio: humidity: Add TI HDC302x support
>       iio: humidity: Add driver for TI HDC302x humidity sensors
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
>  .../bindings/iio/humidity/ti,hdc3020.yaml          |  55 +++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/humidity/Kconfig                       |  12 +
>  drivers/iio/humidity/Makefile                      |   1 +
>  drivers/iio/humidity/hdc3020.c                     | 468 +++++++++++++++++++++
>  drivers/iio/industrialio-core.c                    |   1 +
>  include/linux/iio/types.h                          |   1 +
>  8 files changed, 558 insertions(+), 1 deletion(-)
> ---
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
> change-id: 20231130-hdc302x-59b8a9c312b0
> 
> Best regards,

