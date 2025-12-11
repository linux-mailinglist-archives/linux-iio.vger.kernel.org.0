Return-Path: <linux-iio+bounces-27018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89713CB5A39
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 12:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F25293016BA7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011A2DF121;
	Thu, 11 Dec 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQX57O8O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C1207A0B
	for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452739; cv=none; b=LlF8MFuZnnNcc8efptZh4oJ86fQR6/PANlnlTsdSsSk50DdxcN1oYBnIAxCxHgpq4vUcOcpz8gy9OsKbxcFRvE7j3QdqmzZerF4Y3Wpdm6d1J6LTFWzOU8liXufCzYguNU83Bz8orfDTIEWCstzvjBnPqb2h60apKgaMlny4IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452739; c=relaxed/simple;
	bh=NchHZPDCVbR2zKgQZ6II0ne2TAbumnNcDZoeVADXcKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2tyfq7SgBvNaJwHo8DDoGQkYPMKxOLT/sTgVNmcLL2ZWx2fd8HjVwR5ma/KVPO83IbC7w81wxW6ZSLqg8gJPwzJIKF8fwh8W9lyUqanDkfMawx8EJhq0S4vm1fNRNBeyExagmR1gzF5WwNeDWRBI+6z/sNo84ltS8uxRs2ZBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQX57O8O; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64472ea7d18so760731d50.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 03:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452735; x=1766057535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
        b=QQX57O8OsKuVkASZOy3qxp6if78bDgDbkjwSeD7uaKrKurvNp1ku/3MDnCE9Bf6Mym
         C+NxsqKpUWN8GaO+RapzoLI/tFEh9UW9QqyYNX0PmN9kAFmFVCqFATZR4TX2+JART4Ij
         Ww1J4foYdr6vNtt8a7tOuoiWCzh7oZhR6S70cb/Kv0KsQTQyCYa60HSECZoFp77O9N8H
         VRb0rfvZ7BoxG92nyYSOGgqg5xoWMAP23FDSPo9rP75amoW8qhfaCLkVnVG8eHhNcGb9
         vncS2Ps5PoPRn4RlbNAcuewgWJFWm6evYv1K+ckfssLI9BeMqOCvPe8FxXjDgx8FcCr/
         O/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452735; x=1766057535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
        b=Vsn6r0OWqaNi9g1poNOG96DFGCatQcRJYs2rMiF9p3S2wIcCKq5+OmfyOCpfOZrenJ
         o9r9Hd741ajsLnNj3UM2Hdn7P1jseLywXTX5SHkF5TsbeO1TCeizpM//F5Bew0MEkJ9P
         Cp2wT3UE9EkmS3kZjhYrpgyE6x9PgaNAvnSSld1xkUmuwW87sobrhuR43B3UBdp39Zp5
         GYTZe742EJOSafPLdT2rEq+GmgkBOma/EkL6VB/4GlaW3GcAooCBdPeX0yroEHUyOYcW
         LL6cModjChOkwV+ikt0tDi8tC2ZGm2wQi3EXsfSD8TOlpasO+S9BuaOE+qbM0TJRZAyB
         G6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUFHIDLZD+d1wOGCL4qb0fgxCKZs8PcB0n1La9M5NfX7ostJW5OCT8qLZWjcTfU5kG/mq3hIN83l44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnblA05y6ySYEW2xlBVeYB5Xnor+9x/8lmAMljDxClVL5ou0y
	wPfJ6vRAzJEK9+BXcrp9Baxfdmik4WJGPzFWphedgk5XXHqsfag0VKO1u6Fn1oI3AzxRiWDhK4Q
	pREIeIX1wkVX0uiNw1NWBngwdtI/o1kmUJ4WLSbDFRw==
X-Gm-Gg: AY/fxX71NFfvCekWmSQyxgBtUj1WjF6KVg8DI9diOqvW1b8Ao2qYIrN4cUfSxub8oFG
	rendQIgLgyufLPB9YAedMcuvP9jZa2g/WvTb1P0JSIoG01cROHqmIUSlmrbffWYRPUOJ4/LGhS6
	5ls+0cGwTbhQJg6bKMWhXhKkWVyqBwKRMQwRW4jIQ+Mm0gFX+/s+E18L/bG+YobuyHal300TOaS
	Pcw/kJig2Ca2qzMxD6j2pSBUswBFKDFsaeBSC/Xb8RqhpKubrCxfxGsdJmnzZKKTSaWUhmXWyXM
	TN2/fIk=
X-Google-Smtp-Source: AGHT+IG8bNJ7GVmxCtKmkFoNf2sieoYkv2mgOPVq2xJndKf37hgXCewb4eZsd1D0ffqnRQUAE3M4kyCHgtlEMcMmN4I=
X-Received: by 2002:a05:690e:191b:b0:640:db57:8d95 with SMTP id
 956f58d0204a3-6446eb3aa4emr5006636d50.63.1765452735377; Thu, 11 Dec 2025
 03:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:38 +0100
X-Gm-Features: AQt7F2pSIRmWc3gz3aUnvZCl6QhFMFW_pPE_bkwFhLy-FhbClf3aqE2_J1pJY4M
Message-ID: <CAPDyKFrbS_3XRTSuexFxTpP1ydgvfFvXNv_tninnTqum7+92ZA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to sdhci-common.yaml
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 09:47, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Enable use of common SDHCI-related properties such as sdhci-caps-mask as
> found in the AST2600 EVB DTS.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 9fce8cd7b0b6..d24950ccea95 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -41,7 +41,7 @@ properties:
>  patternProperties:
>    "^sdhci@[0-9a-f]+$":
>      type: object
> -    $ref: mmc-controller.yaml
> +    $ref: sdhci-common.yaml
>      unevaluatedProperties: false
>
>      properties:
>
> --
> 2.47.3
>
>

