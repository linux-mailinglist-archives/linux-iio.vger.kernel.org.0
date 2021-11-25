Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1760F45D682
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353097AbhKYI4K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 03:56:10 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49326
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347563AbhKYIyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 03:54:09 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9898B40011
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637830257;
        bh=rMq/yk98ezdS8bnYknRMoSetJT9i558m+wVBJkqBkGw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QqLoko2EWvZ4HLwfFAAEyYxj03xP5NrTAA2lTr4fvkko7NpOLbfc30iNpsEy1j27O
         nqRSyua5h/JOhDok3CmMN5alhJUCBPgT7/h9sGJ9tKHliVERHx8ESrx6m2X7fmLgOg
         hBr+3TxKxFfclInJ/Glf4PgF/UKNMvyMVylkc18DChp0pypW/YF78sSNcDHB6bT9UZ
         mOdGFEuA8SIyOp/HzMJJgVaLsANQA5ftoTIdPpsew/i+tveiGCslCDFE/yfaq/KChd
         8mhTEINfwUR3dveH9Yi9A0PGVtPt2G69FPg1zdhxdnaO5EC/bnEZEWLG1S+sBU25fG
         xzCMEJmoD4F6g==
Received: by mail-wr1-f69.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so978369wro.4
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 00:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rMq/yk98ezdS8bnYknRMoSetJT9i558m+wVBJkqBkGw=;
        b=WGJ+5aoXSfLV+hxN7M/z+3Tv5w1B7pjfOj/mytpYJHbnGcytzCNa+T9Czo2azVyjb6
         Fx1ZJf5tofVBL9m/0fRYhgnlC3eLrtSPIzwNBZ84VDq17WCaxyz6+B/BPVhpgyHdaeXU
         42SM8y9i80mtPFoE0+laHPlQgekoRNtOPtXBe/0ByFt6rbKdCq7Fedf+/z0vBEZu5Dz4
         3cLFrfgfeZf5jOLsXXgI1rAH41sfCKDdh67jRkLRg3PnpQ5X+iVhP82inMOGoBM+jViA
         iRkdRamMFgZFBK7U0lTwzZzUcrebvrb4C8N1/JRzbBJBIUACf9HMlu/b9jRBcZRkUuyS
         HAmg==
X-Gm-Message-State: AOAM531AuFTzve++L7WbLeEZPx4z6Cc8UaAwd8OBuSMOGxLHdGx5ugOW
        CEN2jmkzgHY/rlO3cAAvfnCO6dP96CSYGNBDxaDFpXygkjPKIauQKTDMdZuyRv8tivOvQQp+3zZ
        nFO8yEE0n0A8hoR2YZhp9Z9fIVhzMsKK8ac9KEA==
X-Received: by 2002:a1c:2397:: with SMTP id j145mr5037144wmj.113.1637830257043;
        Thu, 25 Nov 2021 00:50:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIg5gk00RlUgUwNq9XX2NxvmIriFKGKUTPQ8OwTcuIN5EUmX2xh5Nvk/wEJSYT6PU3NKQbGA==
X-Received: by 2002:a1c:2397:: with SMTP id j145mr5037120wmj.113.1637830256873;
        Thu, 25 Nov 2021 00:50:56 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g13sm2220199wmk.37.2021.11.25.00.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 00:50:56 -0800 (PST)
Message-ID: <7f712176-e49e-696e-b47e-5c1ef9cf2391@canonical.com>
Date:   Thu, 25 Nov 2021 09:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 14/49] iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
 <20211123211019.2271440-15-jic23@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211123211019.2271440-15-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/11/2021 22:09, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> The pm_ptr() macro only removes the reference if CONFIG_PM is not
> set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> will not always remove the pm_ops structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/adc/exynos_adc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Looks good:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
