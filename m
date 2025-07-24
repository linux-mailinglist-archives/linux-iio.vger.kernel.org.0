Return-Path: <linux-iio+bounces-21956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127AAB10919
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FD8171FB0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464C27057C;
	Thu, 24 Jul 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="V+zTJRhD"
X-Original-To: linux-iio@vger.kernel.org
Received: from ixit.cz (ip-94-112-25-9.bb.vodafone.cz [94.112.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CC27055A;
	Thu, 24 Jul 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.112.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356162; cv=none; b=ujaKW7d70gbLYpkyDkBqqH/AhWbQOXt7BKlDZ5jxrRQg4SHne0+iKysUmZQk6YKOT+u3A52cW1ep3zTYLOJsV+jyczkcL5y63i5xezVB5Mtn7VKPl/jQj/Dm/n3hoE4JVRMfcHbbhcvGlmo+7T5VxraUA5hJ6pxBH2soE+V2okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356162; c=relaxed/simple;
	bh=ncQWBKwI6E8yMwJouaUCSKjj7KYKskxzt07O77RrEYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=fwU+G7NT+Jqj4Wp0YoGsnEQv6jbtDRQziszD9UQc+Tmq6f985vFRS0u3U2fkaHcHR+MGnWHkixwJZsrcdrojgOV58/mdRNfmMl0fW2JC/pz9qrybTlLZHQYeaJ6+nO4OAy8R3Sq0UdcNO0xHxDWc22jhrm0+o8OQYX5eYDiohLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=V+zTJRhD; arc=none smtp.client-ip=94.112.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [192.168.6.83] (office.icewarp.com [82.113.48.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 25826161193;
	Thu, 24 Jul 2025 13:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1753356157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zk+cD+vGoFFprH1JsPNoZZcojBrn4oW2cTrpdNOuWYI=;
	b=V+zTJRhD9IxgO6eAU2f73Q6zmgZuL/s30d7j1lY0zcy3d+WBbOZ5HrkgP76c3rBCMTIK+S
	eEKeiRU20oNV/FfFdSfJcgtS3cxzHp8H6rk6ESmLKYWA1A5e5y58Dha/qdqdzGiQHxbABK
	dJPUbBfYk42jDWkqvQgkaFi7Sb1Ov/g=
Message-ID: <623783cf-d1ca-424c-9e71-e14acb9c3204@ixit.cz>
Date: Thu, 24 Jul 2025 13:22:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dt-bindings: iio: light: Simplify interrupts property
 in the example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
 <20250724111345.47889-8-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko <andy@kernel.org>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Alexandru Lazar <alazar@startmail.com>,
 linux-arm-kernel@lists.infradead.org, Bjorn Andersson
 <andersson@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?=
 <megi@xff.cz>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Puranjay Mohan <puranjay@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 linux-samsung-soc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Dan Robertson <dan@dlrobertson.com>, Linus Walleij
 <linus.walleij@linaro.org>, Stefan Popa <stefan.popa@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Lucas Stankus <lucas.p.stankus@gmail.com>, linux-kernel@vger.kernel.org,
 Andreas Klinger <ak@it-klinger.de>, Andy Gross <agross@kernel.org>
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20250724111345.47889-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you,

Reviewed-by: David Heidelberg <david@ixit.cz>

On 24/07/2025 13:13, Krzysztof Kozlowski wrote:
> dynaimage,al3010 and dynaimage,al3320a are I2C devices, so their
> interrupts are not routed to GIC and rarely first interrupt cell is <0>.
> This looks like copy-paste from some SoC block, so drop it and also for
> readability use known defines instead of hard-coding interrupt flag.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/iio/light/dynaimage,al3010.yaml         | 2 +-
>   .../devicetree/bindings/iio/light/dynaimage,al3320a.yaml        | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> index f1048c30e73e..1472c997c16f 100644
> --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> @@ -42,6 +42,6 @@ examples:
>               compatible = "dynaimage,al3010";
>               reg = <0x1c>;
>               vdd-supply = <&vdd_reg>;
> -            interrupts = <0 99 4>;
> +            interrupts = <99 IRQ_TYPE_LEVEL_HIGH>;
>           };
>       };
> diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
> index 8249be99cff9..d06db737cd9e 100644
> --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
> @@ -40,6 +40,6 @@ examples:
>               compatible = "dynaimage,al3320a";
>               reg = <0x1c>;
>               vdd-supply = <&vdd_reg>;
> -            interrupts = <0 99 4>;
> +            interrupts = <99 IRQ_TYPE_LEVEL_HIGH>;
>           };
>       };

-- 
David Heidelberg


