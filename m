Return-Path: <linux-iio+bounces-3209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694886C5A8
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A182DB21B9A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A71C60BAF;
	Thu, 29 Feb 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAmU8Kyg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32B5D730
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199661; cv=none; b=rxUB4Xbfvyt/dAaTj5kNvnVkdI2lDB4H6W1xPg96l9jO9xLT0nCZPIzpRS2uSLFSfhsyWD20+TkpxqMafLSurGsgOpQkkq8E8PUf9uReqyY6rTVWzBqg/jIlkCPTqzk9BI3xTNAO2lltsO9L/4SRpcfCPgexRlSWmajsEUs3Ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199661; c=relaxed/simple;
	bh=2oaBePVnp8xyk3FHRDU2Ycv1pUab3j3C2X3zAN+YBuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfipIAiklk5ncwCM089cYZdBv+U5mPxLwlbkj3wePbOtC3JlcdyJc27pHRjmV29nFZYYwM/9NN5ygbf7KpISjvLjiWBysdLoLE+QcEQugs1I/flImoqLXST7UcwFkcrlxJFBeembc/pPTYwq6nSB1sIcAOQCkVl47BjnIIsuT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uAmU8Kyg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so127395566b.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 01:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199658; x=1709804458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CKdo/N380Uyco7cqejTSkmSIJM6MM6yhvV+7bHun7Y0=;
        b=uAmU8KygzJoj7WPF3WG6ww0it8lHuVpi6pZ3AZ0+cRoClL1r2oq/l+1MYCeAVQ72f1
         EIDtghsHKaSAjWvvB+tjSmnjGfdqS54P9+tQ/LMLEB+7/jzfFtQIRmllbUP+nrDRu2p2
         NLsnhuoA13fi0WC68KgEHUeTak48HgpUZ7PA0u4ZYGPLviuLMQvTtN0VW/6mB0pxqubx
         M/vP9yiD+T1Aa3zB+30XtFumnF37Dvfedt8o/K+VBO/Pwj/iXnADDDR1OWGh85iydMDj
         ywxgZTx64AbOKGfAG53qHNOFycXwKUpIBPuy2plf+ZQqhKEo8dTuHrVDfF+V7ZaOf84S
         /58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199658; x=1709804458;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKdo/N380Uyco7cqejTSkmSIJM6MM6yhvV+7bHun7Y0=;
        b=wGnam3m8u+unRU0BJu6VKnHDy2mgiXBJDt+IPnQqBvyuZkRT0P8oVDMlGQ+YxXA0l8
         h+xzB4WcFV1DcOYIcCg4M3XuzFfezM5TEW57tdE8vLu5+vxo0PhoBlcO1UrJKIhdG8bG
         VYNWxUAH6cZJEzH+JRRNRE5P15FmAwcv5TX3AY7KRE7YqWSBx0qjaANjjpg8l4zwVsE+
         W2unZncDWw+1aRuvBbpDpU5mu/Hey5mYVlabf7zSPdfGgU34xVx3We6VRCEzC3Gtm3pG
         x6uxgxEzoQbZDU1EUaalGZAHV9PDyH6r5egKGq3V8+Cc1+N4sQKgnIQw8coOmrU8rCh2
         mP3g==
X-Forwarded-Encrypted: i=1; AJvYcCW0mWo6I58ZYNpQsp6j4zzWzgZTvsxtvye6lS7vnPH/fTEe39DwA4aIKiNTYzZL956gy2I+Y3pV2vWYu11l2Or2dDCrPS+jw2ev
X-Gm-Message-State: AOJu0Yy4LX6d0Wmr0UHb/fEhgmB51nDJBmR/R+wGkTdyfnn/zZSYfbjP
	WfIgeq7AndA2TinNZOZYULfwNb7uUhQFbrA906Ucl793DuWiuE3Ox12lgvqcE+8=
X-Google-Smtp-Source: AGHT+IE1VZKS59bT84Im+7bEa7GH1AxMzxuNUuG4mJNaOxwXYvy1oWscf48DgdTk/PSX/n9eWqetxg==
X-Received: by 2002:a17:906:815:b0:a43:fb76:433a with SMTP id e21-20020a170906081500b00a43fb76433amr1085865ejd.47.1709199658113;
        Thu, 29 Feb 2024 01:40:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wn5-20020a170907068500b00a4316384159sm492091ejb.224.2024.02.29.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:40:57 -0800 (PST)
Message-ID: <06235b66-6948-49b3-b881-198443a421df@linaro.org>
Date: Thu, 29 Feb 2024 10:40:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
 <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 19:10, David Lechner wrote:
> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +
>  2 files changed, 221 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> new file mode 100644
> index 000000000000..2564ef4f58cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> 
> v2 changes:
> - Removed default 'multi' value from adi,spi-mode property. This simplifies
>   things a bit by not having to check for two possible conditions (absence of
>   property or explicit default value). Now, only absence of property is valid to
>   indicate the default mode. Constraints that depend on this property are
>   updated accordingly.
> - Fixed spelling of 'conventional'.
> - Expanded description to call out potential confusion of '3-wire' mode being
>   unrelated to the standard spi-3wire property.
> - Added standard '#daisy-chained-devices' property for chain mode.
> - Relaxed requirement of cnv-gpios since it was determined that an active high
>   CS could actually be used in chain mode.

? Please don't edit patches manually... Use git or git+b4. Or quilt?

Best regards,
Krzysztof


