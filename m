Return-Path: <linux-iio+bounces-20560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDBAD7664
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F5C1795EE
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4001D2C0303;
	Thu, 12 Jun 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1H/F52zj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC72BF3FC
	for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742309; cv=none; b=kGjRy1qhWMFXNcidLnCbH6w5bAGplXI2hSeph/gNJYerSKOAGcREO5/DqIeC9/0sCvv+9taw9T/mxUHjnVNVfZpQyw93Pcpqd38eL8FkLqau3TWgfqdwRvRMNcI668q9vkiuUwc16o4EVDaW7KNBgZRUNeR/ZOXuNCBIgo5niN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742309; c=relaxed/simple;
	bh=IQLfy/Zvhm0tkwTZfSoUkuAWBTTh+JjfsYN5OcGahFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ylv82tp+gFsubDVMu0uKYGFA6LiXsTcEylHaqLssAg7JGQvkUaXT46akny9gsGWxCKay6NG8RPvIrz+cbL9mxqCSIhbB9R6fFIm2bxrOC4TdXVKDObz12Qpbce50LcvDTgIioelhkJAI7b6DtBkaIq9XWpvzoTEIW2CMjXxq+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1H/F52zj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ea58f008e9so849548fac.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749742306; x=1750347106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6yA7sWYbwYlMmX+GRi/1Lmimz1lplFtP8nIGu+YKP0=;
        b=1H/F52zjPN4dsyxuvKtQ3yx2ggGc20GWZJ+c81s76XJZTw3sVUjz5Gw9foUvywmpXw
         OOPR63bBgJr1aJWsMCvZfamGpso8P9MmCj31yudL175+R4BKDVT3KsDu3gxWtU/ZQGU/
         36uydGTBffkoGZCZWLCZG4HF2aWEdUYq2vainmyZPpPXYN87mf0Hv+pLdMMg/pA4qsHL
         xTeyQLKqQpHsDBlfac/zs95k1NGPm+ppumQ48BvVYinjCcUQeQiSKozveCoc8MIpJXC6
         RjrO45m8YkpvdO5pdvl4Srf+E9MHGAQ8sfJbHZykCT0qD0BlMdMNkEyqXsAbkZk+D/+V
         oR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749742306; x=1750347106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6yA7sWYbwYlMmX+GRi/1Lmimz1lplFtP8nIGu+YKP0=;
        b=lAf7OuiMkCeBZhdtYc2V0lcrXJJ/XJJSFrtcmb9xLOyqsdKEFDQosl30fDctl2jM5k
         Lw1VSVjLAAuB88/h+I7kO9MXFSF45A+HGwG+6Mjh3zT4JoT0lHsoBk8YWY15QkAcqTxQ
         nb3C/qDs1t461Q94QrHo1uWlM/Amk8svuHVxz+2ErJ/lA6dicPBvzR+/bVCmO4A3J+xO
         N4k2diih0nz+YUuiftOi8RlW+u+SHKslfXiI9mkXFbPxRCJ8YHs0IkTHxfmoKUquuI3z
         3K5quBFWoysEuQ2Iv3OzkC95odcVnN95SU6JC+L785ipJh7AwDbn7d26bATWO3FAwxYs
         1ooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVivZWFWKWbnB6iFNqVTVPqgstreSrxKsrYShH9eQu9Zk5o8QncGS02SUa2py0eiCEZrz+0bCffFgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YWU3RMWiaVe19bidxEXoMqHUbDW4rr7qRbaQv15fnf8ry21J
	xqf2FnCXFel26+WSYALfRo09FFlcL489O7vlYxxLz7GTBMzS4c2s/u6tc+cjwgu9gygQBb3Rewc
	5cNBm
X-Gm-Gg: ASbGncuiZs0PBwMo9PbOy82L2jk1S8y+VPOcR2HjgRofTrED2M0lgrE5KtVq2P9btbc
	0/L0Fhc1NuzJmb2jpJG/dCwlIL+MPnWk7BIP7evH9uDsNNJaP9YX6HsEKlWTEC2kcbNXh2jgyvm
	KkGf+MOU7/QqrSLztwgIir84OtS15TzeyK9ny8NODnQK17+BgUytdYy5tdLD8+hJy2G9N7dyR2r
	MazujuFM+YJo6FbpKfLuncJnUHHsNTdGYn1YD96Oh88ixtvskdKi+4D441eljCK9N3SZYKkzOmb
	3gnL7heBWUvVZSdyYnXO/3CesyOWvDslLWNk+hF6JWFdAdrh3knwSYDt+JoWrMnNiHX2HuXlpIA
	VmghlSoiv093xiqmdbfOVaG8bOsD3/dUdi1blUHg=
X-Google-Smtp-Source: AGHT+IHUcajUQvAiQlcpyarsGKUlow+7UkFOgMUpz2TyLeDgZ26uWwara/bTnXaDMDjrdskS7D6z6Q==
X-Received: by 2002:a05:6870:52a:b0:2cc:3e39:7352 with SMTP id 586e51a60fabf-2ead0561b76mr207656fac.18.1749742306204;
        Thu, 12 Jun 2025 08:31:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eab8edbd59sm319106fac.40.2025.06.12.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:31:44 -0700 (PDT)
Message-ID: <275cf035-f0ca-4aa6-a41f-b0c21d7c9374@baylibre.com>
Date: Thu, 12 Jun 2025 10:31:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: amplifiers: ada4250: move offset_uv in struct
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-4-bf85ddea79f2@baylibre.com>
 <aErQVKul7Gnxvu3F@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aErQVKul7Gnxvu3F@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 8:04 AM, Andy Shevchenko wrote:
> On Wed, Jun 11, 2025 at 04:33:04PM -0500, David Lechner wrote:
>> Move offset_uv in struct ada4250_state. This keeps things logically
>> grouped and reduces holes in the struct.
> 
> Can the (smallest part of) the diff for `pahole` runs be added here?
> 

Well, I didn't use pahole. I could just tell by looking at it. There
was int followed by two u8 followed by int, so we know there was a 2
byte hole before the last int.

