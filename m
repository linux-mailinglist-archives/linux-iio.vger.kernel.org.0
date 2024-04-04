Return-Path: <linux-iio+bounces-4040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4228981D1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E881EB2279C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349B548FA;
	Thu,  4 Apr 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sU1UfhQS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26545479F
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214215; cv=none; b=oFTfFCGXUiiJcYM4mhRg/mokuL9k/CbL2MyQzvJPNnabdjpOumlFvJRpRd4174bPUOBOz6LYxWoGkXJonZ2CdBW9zXnr7kjXtoYuYQeL6cjKBKQc3YEATJADnEJ3eSfy3LLqSCdqa/0Oc8Itb6G2GADB7qniBRCnzULfc5JxPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214215; c=relaxed/simple;
	bh=xSZhQALcDek1sVyX0yM9A7bgLyenyyG0Xq43MAWyjT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoRbTWhA1FLsEDlvWj1rorOnoIcAsXaOOFAFStkXwqoTygN1QSdZKRBT7aG8lBt1JlXN0j5FDzSAlAXlo0mIijKdVjQHFWHXJKkClhLIVdwW3fBfgFl4uHco8CjCDQBlniodsmku/EnEBxVYsw3m/bn+rD1JO/mcnsamdvIdXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sU1UfhQS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4f1928bda5so81189666b.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712214212; x=1712819012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa5/D2w4HAOG9StMZL08dYHErea08A7xD8z4vksW0jw=;
        b=sU1UfhQSxAxVA/CKB62/TXteX40Kyc7riKx13J2cZdUlVby+68gSb4doLeU5KaPFHi
         O3I4w6ZxDqM5NIxUKhFRXkOeweAt2wrQJAiE+0phhbH/xHzhvoC7gKwiVjEIfgZNuXRH
         16QMlmL4bpWy3QRZiiHwFZF65Vgt4P/wWb96B6+2eEg9WNWSreTkEcbTEa/6UvOsKi8Z
         jN7JMCOnxadlcaP40t8pFRjgGWpJVttF26BSRcOr1CxnBx6j4Dc+S4zKkAaBUTnypDM7
         VsAwKGi7Ea5CECiyfdFgRPyQaunpzvD5u1bAlGVsjdK3QS0ZlCnChCfu6nzTYL3KXszw
         NB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214212; x=1712819012;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa5/D2w4HAOG9StMZL08dYHErea08A7xD8z4vksW0jw=;
        b=Cu7F/fstRtynKKwMYl6uEOxXvHtQVh9xzpHT7sxQ5myoKC3FpyZV4CU/k+J7pjlt7q
         Kl4cNi23THWB2Ph1E/IBXbZKVH/lNoB3+dHSjYNgCcz+5tyu+3fc2O/Gt7b6NjGOjMKh
         TS2+F4zh9xhWXQcNSRR6kG+Sj9NHsUv+b1BhoLwya+g51jxmOHgFj5Sk3HSeFiHxvNOt
         fx+Zt5FBuE4U8Dhg4rUqzVP3fjuZCwlGBxtMK6HjfhtadqZmFmlwYXsJV9poaKFfCKCo
         epZWpv/1eE8Re/rEsXvzeJmInMNcQPyTGlDtyrL847yXh8BBIGPAWGKwF078G3cv5vKn
         G50Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+SYU2ubEF33WGseRIn5f6aRNiT/fjQEgXE4NpDNhXd52asit2p6Rps6/tPr5sOWKFwtQoc42ExCUuXOQPNhbjkx8DUAYv4ZSP
X-Gm-Message-State: AOJu0Yz4iPq1aeqcDpOuhUh34THtmtFWC0vEMrInSlMjb3maLc26s+IR
	42QpyqPN2BXZujWfM93otSOF+OYFLv/W8hXvzQFc0qYQK8rsK0s2SYPKmeRcMIo=
X-Google-Smtp-Source: AGHT+IEnfXmS/wT7bTyss1un8ZYWBejbj7WTT8VFL4JxX2hDhF/tSpCOOHzqljhIKy7YwWJ7VrmlNw==
X-Received: by 2002:a17:906:240a:b0:a4e:676f:c34b with SMTP id z10-20020a170906240a00b00a4e676fc34bmr1053552eja.61.1712214212433;
        Thu, 04 Apr 2024 00:03:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id wv12-20020a170907080c00b00a4660b63502sm8695747ejb.12.2024.04.04.00.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:03:31 -0700 (PDT)
Message-ID: <beb68fc5-1ad8-4052-80c6-b706b62c267b@linaro.org>
Date: Thu, 4 Apr 2024 09:03:29 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
To: inv.git-commit@tdk.com, jic23@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
 <20240402090046.764572-2-inv.git-commit@tdk.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240402090046.764572-2-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/04/2024 11:00, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add bindings for ICM-42688-P chip.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7cd05bcbee31..5e0bed2c45de 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -32,6 +32,7 @@ properties:
>        - invensense,icm42605
>        - invensense,icm42622
>        - invensense,icm42631
> +      - invensense,icm42688
> 
>    reg:
>      maxItems: 1
> --
> 2.34.1
> 
> TDK-Micronas GmbH
> Company Headquarters / Sitz der Gesellschaft: Freiburg i. Br. - Municipal Court of / Amtsgericht: Freiburg i. Br. HRB 6108. VAT ID / USt-IdNr.: DE 812878184
> Management / Geschäftsführung: Sam Maddalena
> 
> This e-mail and any files transmitted with it are confidential information of TDK-Micronas and intended solely for the use of the individual or entity to whom they are addressed. If you have received this e-mail in error please notify the sender by return e-mail and delete all copies of this e-mail message along with all attachments. If you are not the named addressee you should not disseminate, distribute or copy this e-mail.

Don't send patches which are confidential. Community cannot take them.

Best regards,
Krzysztof


