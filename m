Return-Path: <linux-iio+bounces-2311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C6A84DEDD
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FA11C26A77
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409674E1E;
	Thu,  8 Feb 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="f+vgiWhn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0040B79948
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389599; cv=none; b=POijoLH3S7kGBS4pzCS7rB/jwwuCdqigNU1zA9ry8gNfd8MsL42rdrjHL2gddYEkGiYLG67jgh8CJa8joEvOkEnN8PbtytWMz2BdhbEyDFroSlC6ur+PHKQVyNiQb8A+lK0/l9efSxNz8GpAydfNTarX2izuBRvmzLWENN6OeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389599; c=relaxed/simple;
	bh=F1A8AmEp4wNSQLhzrcHpWnzOgc/WUOThU17NrPtCqd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/k7fpK14XrUpeB/PziZUp0Vj+6d+D9Z01DOy+uBPcFRDGtYzsQ/EWyAPf5z5z7vZ8hm7GDvJQMkWNMLwZ/v+TPxJ8+PFvT54lIjHpacKJrZ5PZAzTf5OHNVi0r8APbPfZfL/0zetz1SrpuCvUUV3xcU0VtpuSwdkHz5vP5qI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=f+vgiWhn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e07532ff1aso408082b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Feb 2024 02:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707389597; x=1707994397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMyPz6/s8uJFvODcdRo+J5x2mgdfYCrfXlxQeU6U93U=;
        b=f+vgiWhnPv1ttWKvV4nODdHo9e0Xtor9hZ1BfZeoNOhgZ6nFXalqM7jg0vAH1hiQDf
         Egjv8rPBlaqND9Ompj+7vNfZWfW1peizGSM1EtBz9wVBug6YfZ9I2wmeERhD8UlZgcHt
         HBogTGeniV5qRx0m97ykSENSUg16ho9M7Y2CBxfP5wu5V5oq2HcnNO0DbftRWp4DbBh9
         ay/UzXtuqczF6ALXiwANY+x5TmiI9hEXEvdQzSz7HyA8AKCPx4+pJj27hm7lPTJKHbJ0
         MQKeAAC6JNDr/ZytrB1g73e61mQO+gWAnqeQL1ib7wFcOTbQuw1J1qmkouvPquMI1Ziw
         C/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389597; x=1707994397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMyPz6/s8uJFvODcdRo+J5x2mgdfYCrfXlxQeU6U93U=;
        b=nlpoZWXBJ6HLHCq876bLGlb2WWhYhnomkYeY7KMEarCd38SId6Gel+pUEs7VrBO7dE
         qriuHOF38OJqkSUXYZv97UXCPEBCi9YaRLspch8IeMBxAECFYI8qY/+fGPaew1YrPOH0
         h4DfFljzkasH8POllFcqssteU4tbTujlSoA6WwdIrdM9Q2S95vteRBGIKYhMEMuFjnYd
         3clD/cW6QiC+n3Y+UCt959XWIPL4phC2ApyFPFZMzIurUUokj7KWhU7K4Fjec3pmsiDv
         RBPnnOlJwxYGdQyffF94VMvOxnc5Sldjw9rHMzfti9nOAGnh+V57cmgL4WZZDhRtWdm2
         TW/w==
X-Forwarded-Encrypted: i=1; AJvYcCUUclJoSyfuu3ImYrnWrdaLXn6WjFtrjAVAwj2f7pepjoY/9VjFaVaaA6+788M6V5GSUYUxpNHjZxH+eDoUqMCPhD/8jouT030K
X-Gm-Message-State: AOJu0YztSE5MnYdsuv8joFL0itfiLB7Zuj+q+r+H0ZWhwy8ggc4RUE8r
	gRoi0oTmwXctmnQP8sZwSbEpWsmiTeGJnpxNayLxm7rGE/sTZfmvFGKClaXuqo8=
X-Google-Smtp-Source: AGHT+IGxYixzAkTcdCyuejkAQm7aD2sDv2xG6jtVAS76uxSMd995+5FBS3chvRA9gBKLOaZ3j8Pw2g==
X-Received: by 2002:a05:6a00:2f1b:b0:6e0:334e:42b9 with SMTP id fe27-20020a056a002f1b00b006e0334e42b9mr5023711pfb.5.1707389597324;
        Thu, 08 Feb 2024 02:53:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEWPdCHZgO3mIABnSKapx9pfY1A7Qtx5cOd+LDz6M3UonhnOLxXMpmEkpF31QSalhINuP7Ptgk0bpr+IU0CR2dX30b0cmMORQI3rLjW70BaoeEp7gS615ZPWF/fc9Pa/gzSka5N98YiCcbAwrR/8+JgVxPcwwXOZr0qy6uneAXhY0Q/HMD5FzWwqCvTbldLB2BEfC+X3UoWRuy0vy9dFamVWMXExv6IXgNHQMO4uXclF8b7lM3F8WfTkkOwPx+5/hTYO6Pd/MGQ7yp5mqwPxJCTOFjq+SE6TBa8cADUKOXSKYjTW9dw+fxSYf2ZufeIulFoPiW28og+/2imEV86UYIDPTTsczdDsPIFzoApeQrw6j7GC9ygJ9XF+qS2uemEcaAKaPYidgQkSMc9mMvu2/ro+uacJkLHAoMJfCbwQoX4CmzB5PZBUQcL6fyLlNg57n9kqL/OeO04NH14+eq8MNX7ynezpaGc0m2gM8C7Jat1ZY=
Received: from [192.168.20.11] ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b006e02eb7fb05sm3361414pfo.160.2024.02.08.02.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 02:53:16 -0800 (PST)
Message-ID: <9f806e4e-b4a4-4e85-9a68-332b7920bfce@tweaklogic.com>
Date: Thu, 8 Feb 2024 21:23:09 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: light: adps9300: Update
 interrupt definitions
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-4-subhajit.ghosh@tweaklogic.com>
 <4647ae5a-b700-4eb0-91a2-d9885bd60431@linaro.org>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <4647ae5a-b700-4eb0-91a2-d9885bd60431@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 18:48, Krzysztof Kozlowski wrote:
> On 06/02/2024 14:00, Subhajit Ghosh wrote:
>> Include irq.h and irq level macro in the example for readability
>>
>> this patch depends on patch:
>> "dt-bindings: iio: light: Add property vdd-supply"
> 
> Please, don't write such useless dependencies. This is neither true nor
> useful.
Understood.
> 
> 
> Best regards,
> Krzysztof
> 
Thank you for reviewing.
Regards,
Subhajit Ghosh


