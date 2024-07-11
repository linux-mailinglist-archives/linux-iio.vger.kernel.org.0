Return-Path: <linux-iio+bounces-7523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1FA92F133
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5568628303D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556D19F497;
	Thu, 11 Jul 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kMFCsb9F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032019EED0
	for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733804; cv=none; b=dBp31QE73IFUpTIrskOZreB6kM6uKbqmRMoETaWEoN8gwou6g0ERjvhUQ1ATAPxldq1JgWraFkWVw4uOR5BzfHQxHqLFm2OWRqVAots1OD9AJr7nPn394ShUghevizwBvUAXWGC98ucXnGl1ot5rlEjPD5sIU29EW3PzUXX3Q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733804; c=relaxed/simple;
	bh=qcfw4ZEipXJaZB8aZn/6RzXP8PBdSCt/J+jyIfgv61o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDvSAJQMTDjLLdo+zywbOzKF+E9HYmpWooRw8aCIrbSDjuQOenKlxaESDZcBuAyxKnTVpOAZJ7pe/P6KtyLYr40JqiwQAfyopZKVqnCKeHDBROzfFm6tCFieUPOx/C5XC4zGx3vkrt4dxS7zI/HcnoOfV7hPkaOOpjRW/Zknhdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kMFCsb9F; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c697fc4aa2so849421eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2024 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720733802; x=1721338602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmNMXoUWUZ9pmumtzDsBb+Z7WfRYtOtrecZqaqh7Ddo=;
        b=kMFCsb9F3w1tGM+mMp+eZ7IJPVgYzq/w2An6KwhsYqTOaeZAqPRhYcBtum8AvDbNXb
         xZzpd3n4U+dKi6U+fDPms5phbkN9I1lCipmJghwfGKufEHx1vH52Q4/Jh0HOh29uGeBe
         d2HUgVZ2X7L4Ao2pO3NqJsXu0lY4Cr52moNFL/K1EBtr5KUQK+IcFK51/mErpfU0DqIB
         HruHqBVLMdaE5Ermb1/E62aTOWSR73cOqT+eTc3s612vpzpFHw5WXcHt5F3l7uEoXlyp
         T1l6G47xGIaR8k77T5qdQ5R/Co163MmllOCCcYNtQFavVV/iLw8YQY1mZXG0VWHSxise
         K+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733802; x=1721338602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmNMXoUWUZ9pmumtzDsBb+Z7WfRYtOtrecZqaqh7Ddo=;
        b=S9HKWFT7nlnTXvsimSaZTRSxk3naSnJMC88YxvD475BDHr6Lmsl0te5TBtg/MlBCC5
         x6Iy4bFDtzV39A2mcWDa8pGIcvhR49WiWmt61Q2Ra0j/H3iBdWVqV7JcjPTRnVqOs1/K
         3hJimzFPd2HUwOCtFObJgD4hxOY25AmXtASatCJGAn5foqipIlAZOYIybnZhwQZYQTQC
         3xaCuBpnrbOfMCHmlNHkLtCuY0mPIH4SU6PqT74phpD5ewgKzUavx1fuxjBKKxi4wGow
         9RWga5kQvdHQQKD5Jmgbn2TktmlLCBXSIs+RibJyzxPwvzPm5QZFpd28ovYbMaOABHG/
         Td8g==
X-Forwarded-Encrypted: i=1; AJvYcCVvDGcnSq+RXrk1u7LD9IwcwhbyeA5luCvvZOAwQDW2vjfDBmeFd3B9yOXTEfHiOHrDUzD7OeDke+zmJoy3W2OIxqV1SaQ69I4F
X-Gm-Message-State: AOJu0YysQWXp9QUuehKXxlQRp3oaY81HIYMSRiJZpzE1BQ/YN/Zcqsrr
	i/rUvklr7Rlexzi1QAnQ6lGniRzZpkT1pG0LNRo6pw6L1eW9//KCF4G5fIKKXF8=
X-Google-Smtp-Source: AGHT+IH9l2G5i0p5je9vPCuRcuZCqx1TN0LUQn6U/enW/tK3QxG5RWV+qhirMBXEGyIr9DY5SSlrrg==
X-Received: by 2002:a05:6820:210b:b0:5c6:6f69:7e7b with SMTP id 006d021491bc7-5ccdb7ced73mr264769eaf.3.1720733801865;
        Thu, 11 Jul 2024 14:36:41 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c7b12612e0sm598518eaf.36.2024.07.11.14.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:36:41 -0700 (PDT)
Message-ID: <1a686673-9ffa-4574-a095-923d0e168893@baylibre.com>
Date: Thu, 11 Jul 2024 16:36:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240711114221.62386-1-kimseer.paller@analog.com>
 <20240711114221.62386-4-kimseer.paller@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240711114221.62386-4-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 6:42 AM, Kim Seer Paller wrote:
> Introduce a generalized DAC binding that can be used by DACs that have
> similar properties adding output-range-microamp and output-range-microvolt.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> new file mode 100644
> index 000000000000..a9787bbcd22b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IIO Common Properties for DAC Channels
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description:
> +  A few properties are defined in a common way for DAC channels.
> +
> +properties:
> +  $nodename:
> +    pattern: "^channel(@[0-9a-f]+)?$"
> +    description:
> +      A channel index should match reg.
> +
> +  reg:
> +    maxItems: 1
> +
> +  label:
> +    description: Unique name to identify which channel this is.
> +
> +  output-range-microamp:
> +    maxItems: 2
> +    minItems: 2
> +    description:
> +      Specify the channel output full scale range in microamperes.
> +
> +  output-range-microvolt:
> +    maxItems: 2
> +    minItems: 2
> +    description:
> +      Specify the channel output full scale range in microvolts.
> +
> +oneOf:
> +  - required:
> +      - reg
> +      - output-range-microamp
> +  - required:
> +      - reg
> +      - output-range-microvolt
> +
> +required:
> +  - reg
> +

It looks like oneOf: and required: are missing an indent, which is
likely the cause of the Rob-bot complaints.

Also, shouldn't the last required: be an item in the oneOf: list?

> +additionalProperties: true


