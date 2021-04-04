Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C6353976
	for <lists+linux-iio@lfdr.de>; Sun,  4 Apr 2021 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhDDTUb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Apr 2021 15:20:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35833 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhDDTUa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Apr 2021 15:20:30 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lT8IK-0006a5-Gj
        for linux-iio@vger.kernel.org; Sun, 04 Apr 2021 19:20:24 +0000
Received: by mail-ej1-f69.google.com with SMTP id jx20so225939ejc.4
        for <linux-iio@vger.kernel.org>; Sun, 04 Apr 2021 12:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZ3gczaQYTruLQCdY/ZOGdHbHE8nS5TPT/OLAGynftE=;
        b=VUoTKeEtVCVhDHNso4m6BiAwrQTyEBqHfK35ButFWH3kfNnu+Cy5kABptskuEgz4B8
         SqostKFhyI0PcavOl2rDvDBkCgwm7eRWSG3FZJ22CxAh2HzTNWPgN/WksJJCS7iAYNOh
         8+ErijjZkf7j8dQiEASnA/2WQ9VAf6z8VV11Yudrm4ZBwMa4w/oPcgNJ+8HWyIxwanXK
         LqWiP+ejKp7COE60xTTtafUjPTnAiiaYvoYfPF/dQR2O6AlfVG/y5k9IavptL5XJV69q
         tJR/aJHi3XFhpCm8Hj8RbSuJzGqX0pNlIfREMrU4BiM8uoimPmE/hpHssg+ccxA6SSN8
         YV1w==
X-Gm-Message-State: AOAM5324OkMObWSVoIJPjD7FExtMxNkb9F7L7s7RCePofEwNoONFyEtc
        g3b4nmDk7UecDxhEkGagkgyS8ocWF472UU2zLO/4Rv/rtKicU1Z9i9UCb2ucziYVYF8OyIxSJUh
        Jlf68Ku2XLUS6LnTdSY2TRxyRVvTGEYU5cf5Zkg==
X-Received: by 2002:aa7:da04:: with SMTP id r4mr27575242eds.343.1617564023839;
        Sun, 04 Apr 2021 12:20:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIWbG8A0ZsCGTMKjNoF3vsmBCw+5JGU7ZJWrDH4G6NPCAX3YJ8/V5zEnQn5xsQ4ICdc90N1A==
X-Received: by 2002:aa7:da04:: with SMTP id r4mr27575233eds.343.1617564023721;
        Sun, 04 Apr 2021 12:20:23 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id g12sm7150373eje.120.2021.04.04.12.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 12:20:23 -0700 (PDT)
Subject: Re: [PATCH 2/7] iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag
 rather than separate irq_disable()
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-3-jic23@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <c8812c32-e748-bb0e-09b1-d3be3bb29872@canonical.com>
Date:   Sun, 4 Apr 2021 21:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210402184544.488862-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/04/2021 20:45, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Disabling an irq before the driver has actually atempted to request it
> may work, but is definitely not as clean as just requesting it as
> normal but with the auto enable disabled.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
