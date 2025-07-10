Return-Path: <linux-iio+bounces-21535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA22B00796
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8321B1BC63E0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B8244688;
	Thu, 10 Jul 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BxatNQ8z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AF1EF39F
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162411; cv=none; b=mVUyP3Rk2ruHMeWGgvLxxMk2MF+qTCVUzjYclGuHV7LZ39AdDSE4+xkvD1U7x1qsPSd/0K0mRuyt/cy79CZYEQ8p2nQ6dADdoALm/uEXGiELuoeaNGWbxtxw2JIjvIfeFEDdNgEO5pI7pxbpxUkqqmkmyC0QBQ1L6JdNnX4TP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162411; c=relaxed/simple;
	bh=sk5MkTgT33G126yLu0cU6kvmDkC6SSCYrqJIAgQRCfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwTMoaVe5zoNIeRIjTrvtoRMhhNxAnnFgDxB0Ae2EX6fFzT66Z2E16k4130/NJtBcatEV4DuPLjtcEra55d1z3XdWTR3nGrjpqUH9kL2DTpBjoejTCMoGQpiTlz0r5GsHo1GfriPsgt6OP5iUcVrXJ+SYqIBtVym3PN4LaM+/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BxatNQ8z; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2eb6c422828so1224885fac.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752162407; x=1752767207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxqC0ATm8XXXx24MpZdy05ScJSWmhlnLQqeCjqghw20=;
        b=BxatNQ8zTL/D8PDEvT/iYc8wJMHJpQIbwc9w1fofki7ZP55YcdFgbGjrPZbn4G5MWA
         VNkz5F3GesZ1e7K7IQcr5xy+35mEA4RCZ7lCVk35L+yy4KM9ay3XG54B0a/Wt3o/gAoV
         7qVVkrCXR+6IfHbGkgA/hl37QIIa0U6TQ0hhKv5Y6eTMyodRNe+I5xnRCtmDmgOG3YHp
         EIZ/iWxE+7IoPNLxet6Aj5AdX+pmJOrfPukiWBltJLssbBEvx752ywRuzLj+KSl7Y6Gw
         Ey+3oizZ0wdsuaVnz2CPhEyMUbFXjLgI+4hSsWbxxC++U1QAa3UTJx3JbsK6kUxFig5G
         vjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162407; x=1752767207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxqC0ATm8XXXx24MpZdy05ScJSWmhlnLQqeCjqghw20=;
        b=A0YMk3qHsRdAYdVVqvFLfzZNc2WQoAw7gi5hJ87NMLV0Q4uerDVreuaOsGY4Qt4arn
         SNZ4JUeokhs02G3rMMe6eWOAtoio3RjgqAXAhKJUFCm6YsJZV9S1harLy+bV2RR47xC8
         /w5I/sO0N3gDH/7vni08tga2s2NExxRZuVJHuGjtNbPeHTvqCtAap3hA0QQY6IQtleMm
         /AucjIWwvSWhj3fhIkdDG4i52MEb7Zw8R6lT5yB9w2XK4wKJWkqPoN3TvbsDfko7c37W
         gdV+o45VCjmx8m6MPRpcjjierMfRNixWsFJOb31cLairt7jycNQbz9AyUxCm5R1HMu0w
         D1og==
X-Gm-Message-State: AOJu0YyXP2N9WgjVzY9Lemt8x3QRvusQCMEHioc6J7cJunFSJ+o5ZF+7
	I7roY61TiQe62J+gAVusC8fVAI+kMnYtjxqpHIXuwo8Fif/wnQGNxZ23Y9Ysawq76DA=
X-Gm-Gg: ASbGncuTM3a3wp5Yf1p6ufvfFhckMmnU+b8odfcqsptuURnxlTEUvjMTDNes7FckEUa
	EW9PLf9dAy0kLw+lk2yN6GaVi9DzGuNLCiADkDH09t6QgNUgnZwYEZGHmYeFsVc4ba/l04vAXkK
	b7GpEeukkoJxG9Ed9x1KOo/zJfBuKdKY795eHmmkUDBnEkPrs/BDTxsupSNWPJUuc+MPl+slcox
	u6cKoVo/GURlMsAORSjC+C0GJGPH95NTtIvC0dXk37BOPgenpLhEELGY3/wk10ELO4oUtD0NrEJ
	FQmED2scFkZTXE7NlSQidpb0qpEOv2yMAeMlfPwxVJbLec4ZlkVJRUtEuSpG+x1Z9H1MTU8/nrB
	+EEnyYh4J4TTg5s8VK3JnZY+/h53LVYIyASI5NSU=
X-Google-Smtp-Source: AGHT+IGGnNYbfg3tRijwYJsTHxFrHe4ec9V4WbLcn63Mw2V3gA0rhenSRI8xr6ktDmmz0UyeTDfVCg==
X-Received: by 2002:a05:6870:7053:10b0:2eb:9fe5:d06c with SMTP id 586e51a60fabf-2ff0c5af786mr2100280fac.3.1752162407230;
        Thu, 10 Jul 2025 08:46:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7? ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116dd664sm343870fac.42.2025.07.10.08.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:46:46 -0700 (PDT)
Message-ID: <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
Date: Thu, 10 Jul 2025 10:46:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
To: Primoz Fiser <primoz.fiser@norik.com>, Haibo Chen <haibo.chen@nxp.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de,
 andrej.picej@norik.com
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250710073905.1105417-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 2:39 AM, Primoz Fiser wrote:
> From: Andrej Picej <andrej.picej@norik.com>
> 
> Document i.MX93 ADC calibration properties and how to set them.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> index c2e5ff418920..d1c04cf85fe6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -52,6 +52,27 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  nxp,calib-avg-en:
> +    default: 1
> +    description:
> +      Enable or disable calibration averaging function (AVGEN).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +
> +  nxp,calib-nr-samples:
> +    default: 512
> +    description:
> +      Selects number of samples (NRSMPL) to be used during calibration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 16, 32, 128, 512 ]
> +
> +  nxp,calib-t-sample:
> +    default: 22
> +    description:
> +      Selects sample time (TSAMP) of calibration conversions in ADC clock cycles
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 8, 16, 22, 32 ]
> +
>  required:
>    - compatible
>    - reg

This seem like things that should be set at runtime rather than
in the devicetree. Unless there is some justification on why
these values depend on how the chip is wired up?


