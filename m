Return-Path: <linux-iio+bounces-18850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F669AA106B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BED1B65C85
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895D22157B;
	Tue, 29 Apr 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YFWgNGCu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A8221555
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940371; cv=none; b=XvpwwCQm4eKI2+JC6nMLox4JMGj2nAEY8S92hP1a1LTX3kx860d3WdyQ/lNmSwWbDANJ+zaMfK8SX9qzNoO/wOwQEvZfsNhQOzeBidkoe0P/zw4f5bznyMsc3sUEbJrzxoOiVT458nGrFAfHjpdn8QgpoMqIKpNhELYC0G3wTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940371; c=relaxed/simple;
	bh=PbCJ3eqOQPycfLIlHcU26eDZxIfwoDf/fUXtAYBciCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVnM1GlZainkr2A88a0hgF65zGwARHxK19UQwsU09pmx2f9H/NeDQTHZFdFA0Q58dVQumZkpkJ3qdfgyxV6cGeTmIUIuP4uMmV8iu0VprOzZ2qeuzTkdX7EtY7BKxCmNtCtiRAARNEKgk8G1M11eXlsJOadTZnd3241PEoUocN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YFWgNGCu; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c40235c34so1843345a34.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745940368; x=1746545168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqXd7CqxL691uVQllOCxYUhKwjtU/lcEe666k5nlk2E=;
        b=YFWgNGCuDJzAuYjkwp3iGbe5FAJSlS0Zx2buMafQnGo32fr+U91JKtzVgwxpRxlBCR
         HAgGPu4Qm3i8tyDZpjlfcxgVvsI1MHy+WaoSh63Oin+5o049xZV4CgeKHmbFIWueh0YR
         TX6/f+bDGE9pHzaBESadZBisTeSMj9/D3HhxHXvMFGmPWUDjyD+i4xcQBglz3e111Ucp
         QNA8Vs+27Yaw14uPqpJ5vI41xumCLL7vM4uUSAujIxc+yqVDTfun7RBUEjbqJV6pRa0X
         BMVw5HSL0D9aTMu8v20d5nNtTi0I9UlEd82CQSabmK6yA+KTGbhmg3TPrQat34lShRvG
         4Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745940368; x=1746545168;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqXd7CqxL691uVQllOCxYUhKwjtU/lcEe666k5nlk2E=;
        b=pxV2VaTzQjhjVPAKozXcKvJsyZGHASmf1oGveMNQPOc6c94bLpGPbJ8M8fLrwqxFFs
         Za5Keyrs1ds49orMHiLdG5Ob0cpwksBE+P2yf/FmPx9tSiv37VdibOfTRD+BAkDYy8Nk
         CaX9wcv1ZY/ljXaT1YtNc0kU3Ua6FeqxOImklwnK52vCnVpCNl2XU7wptGmdFjpESYkz
         5CX4EPV2O/L2ofc5Uy0fqfA5XsjPpcZOZk69QFuz0EUnXqcOHmM1VVOeYyFGKUamGFwE
         mW9WuDkRnGHpqoqgiioimDhZ8GR5aoytZZB2zBj0o/czNU15MbNwuJPTtzjmdsO6BTrz
         dw0g==
X-Gm-Message-State: AOJu0YzuS6IqaWGBoXK8oAdsDJEL3B09ocIEGRWiI5nVVaXih8RBYJCH
	FSj83B0olJ7Sk/vCqSnzyIcNFvHRg6P4oa+qUp+1pU6zVeN3UXStrl/w3Q5Mjyg=
X-Gm-Gg: ASbGncu2em9errI6J/o2d62+5ZLAJf/mssZeOK9OUYXYlDDH/Rlw4+vNiHiaUY8r+WF
	ZqER+8amEs6NhWqUEudf0tz+1Tto78V3olsE35kd9filHJm0D+2rTPLhM67QZtfGPt3mEw6wXTc
	DJcxdB9XAdoEkMVyH0fZv9uR5oSt6WMVtVeyfybKwTW6iUkIrnl4iEU4lm0PyxBFMwBrB29AZLW
	CshgBUCrM2OHT6HdQQGED/nJhESXUWSDfWWfT29cYNHpaWPJRE2Gcbimx3tlT8m+uZ72HKfvn2D
	Rggr5qqqfs29anAITX43oMWVs4xUq2O0ACgYS24JU4b8qFoA0aMveVokpcOLNP5/kF24CQCB258
	aqFMiqbsVrvXCGcOWQw==
X-Google-Smtp-Source: AGHT+IFUp1czM56vFhnwCjOqwrL/S1Mh48QYvkOILNdjL8GS+rOj8cEaXcPSuTFNAk6VzZ0KfdpCgg==
X-Received: by 2002:a05:6870:d68a:b0:29e:2ce2:94d with SMTP id 586e51a60fabf-2d9be53d02cmr7495407fac.14.1745940368204;
        Tue, 29 Apr 2025 08:26:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d973b794e2sm2841412fac.40.2025.04.29.08.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 08:26:06 -0700 (PDT)
Message-ID: <d13e3671-9330-419c-acf6-97f33060116c@baylibre.com>
Date: Tue, 29 Apr 2025 10:26:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-4-eb4d4821b172@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-4-eb4d4821b172@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 8:06 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support by a per-channel resistor value.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 29f12d650442b8ff2eb455306ce59a0e87867ddd..df30545fb52c89a814257443183303775a06a7f2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -204,6 +204,15 @@ patternProperties:
>            considered a bipolar differential channel. Otherwise it is bipolar
>            single-ended.
>  
> +      adi,rfilter-ohms:
> +        description:
> +          For ADCs that supports gain calibration, this property must be set to
> +          the value of the external RFilter resistor. Proper gain error
> +          correction is applied based on this value.
> +        default: 0
> +        minimum: 0
> +        maximum: 65536
> +
>      required:
>        - reg
>        - bipolar
> @@ -271,6 +280,10 @@ allOf:
>      then:
>        properties:
>          adi,sw-mode: false
> +      patternProperties:
> +        "^channel@[0-9a-f]+$":
> +          properties:
> +            adi,rfilter-ohms: false

I think this is in the wrong place. It would allow this property on ad7616, but
ad7616 does not have this feature.


>      else:
>        properties:
>          pwms:
> @@ -398,6 +411,7 @@ examples:
>                  reg = <8>;
>                  diff-channels = <8 8>;
>                  bipolar;
> +                adi,rfilter-ohms = <2048>;
>              };
>  
>          };
> 


