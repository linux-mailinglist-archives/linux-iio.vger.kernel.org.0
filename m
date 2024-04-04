Return-Path: <linux-iio+bounces-4041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6208981D6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA96FB22EAD
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8B56B72;
	Thu,  4 Apr 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/WozZ17"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EAB54BCF
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214289; cv=none; b=F7b3fHMoUxrBKmmnU2sJz0lYU8FMHnmSHgoUBq6T6KTOjy6yFqRgEbDzqRulIeveRZnsFmtca5QozcSY6yN2kt4PzjtZH3eoFCdzFfCkOx0EMY/t0ejYR7ojDXL+ebdWsDwxR329L4buHA0jFPOC5uU14/l2r0bk1/KCzFOX7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214289; c=relaxed/simple;
	bh=SAjv6RGnBR8J3f4UDEx40SZcv2JBjI2SotfhBl2mya4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSrCLXZWKfdEpzzAg0jA0/lkVlRLV1uO7+Vo2gD5NwoXk3JNxGUwkDTZiSbgVE9Wd3zN7BiHdfp+ZILdCWjfDmnH9IDBQdTSW43NWvNxUyKWG+wwNOebDx7hHaLA69wGKuO3NcM7MMMprA6js6xukSXPYPA283vkSB51T0isE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/WozZ17; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513e134f73aso941843e87.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712214285; x=1712819085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXZLFSY2Y6jaTrC8c++mRC62bTKE3uJxdBu7mLsCWUk=;
        b=j/WozZ17GRz2oN1Tg/aUviAORlnb9+xiX/c8k/ZR2VFZ8mlwymUIm0/F3gr8SMCRTa
         0Yt9UHJBEVnTEa4IjhyFN7wMmMvHtPK/PDy0lym7c/Qvh3xVCWRsICB/JgClPmmBn0EU
         R7nzcG4EoIcBV1RMKW5y8CyfaRACqvjq7mSfnmgKGiDHvOqu1cQZx/E/7Mm5P+GL7HE9
         ReOCRUPqPP5QQjoU44EBDzMwsvhXcfNQnakYHIDREeWkHefaf9ZOeoDCvC2A54sEy712
         C552ysUtHZzHd/vxWM44w1ry+dR1MnjDEKbn4UtxOp4OkDhgoE6UAETblTMM00x4Ougx
         kCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214285; x=1712819085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXZLFSY2Y6jaTrC8c++mRC62bTKE3uJxdBu7mLsCWUk=;
        b=w1f3EZL95kejMj7nC1iHU/5AAhiMDMX/ivcS+O3D0s1znxAr2m8jyTngrqr9GYhpSO
         Y593B0sCnqI4veWiVUHnd00AjfN7t0emtQdspDWKAOf794TKS+v0N+JewFbiF4GdU3sn
         RUQF1CTTOHMG/k5NA0+833M0hK5zv0M2fuY6sArEfbf7oGJnF4c1QH0oSH5nKP5oaYXW
         9FA2EilZX4Q0X4Dm8Wu95TVYJQ2cVLqb2MvgXyhgl92QaKb+sMeWz2WyHcE9S3FifRF0
         MlmTHfv6pfYp5gpAV7VfFHrXh3S9yMMh+9HAOHV6pMoXnazXDd6Hvpf0A81wpTACn6n2
         gKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9pTO4fgut81Oy8hI3ob4Ni+xbZQfgQLF9wQ8OM1vUKKszITl6D9YIojLLPhuekZO1RAM0L3vmptYo5uYO+ENkzNVkM+a0zaeh
X-Gm-Message-State: AOJu0Yxu/ASB6V2nKKgwPA7i3F5SBZoOTzlzxHUSRjvjsMUxgLJRAfAd
	zziGIz9YqWIgM4hJ+ntHYt9iHkVTt0339HLdcxbBxz5pFlN2GYegjOOwk3M43HU=
X-Google-Smtp-Source: AGHT+IGK2MMJfDHA/RmBTX/w8HS2DQi6pEVwKkJGBNOvDtoDa6tUoMgxk+m3PCMKOcDOvxC0XrgEqg==
X-Received: by 2002:ac2:4851:0:b0:516:9ee5:e02c with SMTP id 17-20020ac24851000000b005169ee5e02cmr1340681lfy.2.1712214285438;
        Thu, 04 Apr 2024 00:04:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b00a47342b53a4sm8578870ejz.191.2024.04.04.00.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:04:44 -0700 (PDT)
Message-ID: <882e018d-73e2-4505-b613-50e759a25420@linaro.org>
Date: Thu, 4 Apr 2024 09:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: imu: inv_icm42600: add support of ICM-42688-P
To: inv.git-commit@tdk.com, jic23@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
 <20240402090046.764572-3-inv.git-commit@tdk.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240402090046.764572-3-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/04/2024 11:00, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 

Missing commit msg explaining why/what is happening.

> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 3 +++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 3 +++
>  4 files changed, 13 insertions(+)


> 2.34.1
> 
> TDK-Micronas GmbH
> Company Headquarters / Sitz der Gesellschaft: Freiburg i. Br. - Municipal Court of / Amtsgericht: Freiburg i. Br. HRB 6108. VAT ID / USt-IdNr.: DE 812878184
> Management / Geschäftsführung: Sam Maddalena
> 
> This e-mail and any files transmitted with it are confidential information of TDK-Micronas and intended solely for the use of the individual or entity to whom they are addressed. If you have received this e-mail in error please notify the sender by return e-mail and delete all copies of this e-mail message along with all attachments. If you are not the named addressee you should not disseminate, distribute or copy this e-mail.

Sorry, we cannot work with confidential IP. You also made public your
company confidential data, so it looks bad. Please double check it with
your company legal department.

Best regards,
Krzysztof


