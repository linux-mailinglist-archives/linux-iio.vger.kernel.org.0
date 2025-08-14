Return-Path: <linux-iio+bounces-22730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40830B261BA
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 12:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9855D1895AD5
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CF2F659A;
	Thu, 14 Aug 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQm6hYx1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10472F6599;
	Thu, 14 Aug 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165433; cv=none; b=s3nW7UGeg4I0b8jNbwRleca4ddTALs96BzekPxEjzX89lCewsKwYoJOmzGGwIlD2NGpioY9oQxGjs5AuMpybShkR7ufx1/bO9qz0iqFYaQHEvpe5mRqqTV3zA534pjjlBpjbLlI9HBculkSeYUrIT0E/yvqwdREOQDBOt6UYGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165433; c=relaxed/simple;
	bh=hxq+BAlC4BTcZrulCz2ztttBWVAi3fJkeyvA1e4ENoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueox/CTpQkN3GFCWuLh4WwPPDUlufchxSKPx9MT47LIKYPEKLmTwtEpJiEKrde9iCin1ld4/+ecnA5XDths2RyPkbCfDf5UaEuo2MXKLu+ecXhIQ5AO7bcbDe7WtbE/ftsholiowIm8swNCjc/oljU/94/n31l/u2kqjdZYvYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQm6hYx1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so559909e87.0;
        Thu, 14 Aug 2025 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755165430; x=1755770230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3s7YhXsV6p0c1Yl9oTw0XLLqhsC5QWkVPLgNC0X3hf4=;
        b=dQm6hYx1WBB1tEM0R17+NuxxwSNEXrvb3G19PqQ3zYlKj0kWM5B/wlwj0BXm0y9r5I
         NBJaPQxgEJEpYy9Vol9G+byEBzktUoX1iDXyLvyBZhEH95GF73riV8ID8QyFf9g8Bhx+
         zLbIiCFwo9R/P95/NmqmSKwZURAotKOJ319Fs0+t1I4a6Ubk3U9p+xLcvBIDVZQn+9RH
         1o9SvuTFb9z5VYoEtPqwZ55WiP/EbyKXzrDnHHB9afKY2SyzHE+LYVeXwfGDwYFiLvBN
         FdGm7og0Sj/UXccM2OjICpo6TKUYaxsdaDLNBQKj+N63NHO/7QyUFNCbsvImf9cFiER7
         uEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165430; x=1755770230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s7YhXsV6p0c1Yl9oTw0XLLqhsC5QWkVPLgNC0X3hf4=;
        b=WR9nLsZt7ouJN8/RENoZsdVYOTGLjxLwuY0q6wnjv0JvQ84Dr/UC3jo6ZIoaUdJSh8
         k2i+TMq5j3AxqUPr7742KJbhXQ4HzQjkFdkksbDuKi2zcb6OidpkqZtSxEYG8YppPWop
         DVu5vYAgSoplsOCqUj5H/xO7I0HkFUL5aM/WP74HWJ0FUnnKJBQI8ehXI3Eg0+mjYUl8
         yKp8JW+6kYcxkI38t+19tkCj/wErDESDwun143sHyIJEciRQpcX74qjgdRztGCK5LtLC
         40LDa0lN1I8QKrCAAjIBnO/gP7R2vzp7+IfH2jbyARAEToLSkd6da4Ve8HkvMQRuWv6G
         LiCA==
X-Forwarded-Encrypted: i=1; AJvYcCVaME7L51tP5EdCz7a83OJ1AzAZk/cQ6sUwqxMfbJMFq00tVMpO9+hfGkbz68sm5c6WYFo+0OnZHaGf@vger.kernel.org, AJvYcCWfO2eJNZ+cbMX7f5ksWq5KOP0UarNQ9TQHY4PbkS3z5PjjHu8qYao8fN3ifMYJPEIRH7RWFkPm9Ive@vger.kernel.org, AJvYcCXcAHgIMf6vq2bTex2lpCc1nj93Vi10DFxmwIGgpK6+KCc8OvmWCTcr23EHD9W+NnDzsBK2Lrn+zxrRQ7ru@vger.kernel.org
X-Gm-Message-State: AOJu0YysJvhzWn8hE21Gw/GHMZtqmQ6QdTwvP4PqpXL4zLPBLVQjSUWi
	GWzH8C2emDWZMAqsijrMcKdkDOno4MMW+EuMqoFGqMd31soFPjbQb0wa
X-Gm-Gg: ASbGncuOV/bJxLgdx2MxRFyIKOhkzFxiG89Kqy/+9CmWrtNhvvLsIwJm7iklXC/dfse
	IrRlWqbssln6z1NLBc3vB83OiaUpHYriTvIJ+cONnOS522zbXHp5KJ6H58m5hXe/00rkcecv2ka
	nduUkbp9OoyJYSVHImEuycBLtsEJFjV0uWl9AkMQGyIR+RD5+npGxCZ3bCiAkEwFidpf0IQiIUu
	AX0svZ0gZXU3OioOdM8uz1sG005Rd+hN/kUfF3EaJt4EBrZwEZu+WuPO+OLZXXmbK1KQXa67Vzs
	LkxBErlQ1vF3tc9+XhZZzClgo21z5EwmRMEXIw/OGDqK4n1gMlo2Q5tJKkJwZ6Lev+ip3unl9ec
	8L7WLiDlX8IKldtvRYB2LtKDIwXgyuraj6tg=
X-Google-Smtp-Source: AGHT+IGQuXcr+7hBrPHuoqBZIph7f+GgG15OetCBb/AawoLaoonWiiogi5JxMf81RcBC2bNbHe2U1w==
X-Received: by 2002:a05:6512:12c8:b0:55c:c98b:39ea with SMTP id 2adb3069b0e04-55ce5032d3dmr729324e87.27.1755165429555;
        Thu, 14 Aug 2025 02:57:09 -0700 (PDT)
Received: from [172.16.183.161] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c987acsm5529433e87.100.2025.08.14.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:57:08 -0700 (PDT)
Message-ID: <175ce750-7f5d-477c-8d18-dd418ba749be@gmail.com>
Date: Thu, 14 Aug 2025 12:57:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <8ef78e3cffcfdf99153a3fcf57860771890f1632.1755159847.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <8ef78e3cffcfdf99153a3fcf57860771890f1632.1755159847.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2025 11:35, Matti Vaittinen wrote:
> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
> and, based on the data sheets, they seem identical from the software
> point-of-view.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   .../devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> index f0a1347ba4db..6a6e6ab4aca3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
> @@ -14,7 +14,16 @@ description: |
>   
>   properties:
>     compatible:
> -    const: rohm,bd79104
> +    oneOf:
> +      - items:
> +          - enum:
> +              - rohm,bd79100
> +              - rohm,bd79101
> +              - rohm,bd79102
> +              - rohm,bd79104
> +      - items:
> +          - const: rohm,bd79104
> +          - const: rohm,bd79103

Oops. I believe the order of the compatibles is wrong for the fallback.

>   
>     reg:
>       maxItems: 1

Yours,
	-- Matti

