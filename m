Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA033007A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 12:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCGLoY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 06:44:24 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:33277 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCGLoM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 06:44:12 -0500
Received: by mail-ej1-f51.google.com with SMTP id jt13so14307820ejb.0;
        Sun, 07 Mar 2021 03:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I+lZXT2bUYW31YOq4X2EmqVSXL5RIdvlx0J7BfQaCn4=;
        b=g3hLA63jw/fUwaI/SXji7mkxoyl2IjgybvZU7dsmpOD82YhvUxwRkRLhBIASR1+i6q
         V3rrY4UYmoj7aB3VbDn5hmKqoVAqqtzELRlrWz1wPBdwWLKqHQuHUcyPb1McCf4ak0o/
         lbE8bO/2/Im09VWMfg4fd4R8Hg+0TLOx1Zc1VLBjRstZkiJpuSrrokC2ZcwEKxDC3oS9
         Foz5NzbofllyOqZWA9ALAAHCQ1JMfNMb8Rg1AAw7HIj0gkCyGlSKCRKxIPftnsgOZjUO
         KplZQGGB6mL/EInise4oEK+pldP2n23l+v2k/y2M0D1kLmBFAZ8yrDZ8QOozHESzluIi
         N6kw==
X-Gm-Message-State: AOAM530bIxAb9VLDFPuPmvuUZ7iuvAUsahVrzRD6lODhzVmYjYNa3g88
        hFDlG6hSH3J8wyPlhg56m6+d95Zd9BU=
X-Google-Smtp-Source: ABdhPJzeVFy2MmR61HOeXXY3sFEGXJ29c7e8ywEDUN4JGbSvrgznOdVKwYJZkBupf9tAY21sRSn/0A==
X-Received: by 2002:a17:906:3846:: with SMTP id w6mr10561370ejc.190.1615117449726;
        Sun, 07 Mar 2021 03:44:09 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s13sm5310854edr.86.2021.03.07.03.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 03:44:09 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: iio: samsung,exynos-adc: add common clock
 properties
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210212164148eucas1p2ab09436a82d50161ff1a9fc1a169f7d7@eucas1p2.samsung.com>
 <20210212163816.70058-1-krzk@kernel.org>
 <85ed4a70-5cd8-3bce-100f-33a1fba7f3fa@samsung.com>
 <20210215092915.7khog24shtzjzd6g@kozik-lap>
 <20210305204152.GA607635@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <b43a8735-42fd-be44-01d1-843562b1efd8@kernel.org>
Date:   Sun, 7 Mar 2021 12:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305204152.GA607635@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/03/2021 21:41, Rob Herring wrote:
> On Mon, Feb 15, 2021 at 10:29:15AM +0100, Krzysztof Kozlowski wrote:
>> On Mon, Feb 15, 2021 at 10:01:48AM +0100, Marek Szyprowski wrote:
>>> Hi Krzysztof,
>>>
>>> On 12.02.2021 17:38, Krzysztof Kozlowski wrote:
>>>> Add common properties appearing in DTSes (assigned-clocks and similar)
>>>> to fix dtbs_check warnings like:
>>>>
>>>>    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
>>>>      adc@126c0000: assigned-clock-rates: [[6000000]] is not of type 'object'
>>>>    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
>>>>      adc@126c0000: assigned-clocks: [[7, 238]] is not of type 'object'
>>>
>>> Does it mean that assigned-clocks related properties have to be added to 
>>> almost all bindings?
>>
>> To my understanding: yes, and we already added it to multiple schemas.
>>
>>> IMHO this is an over-engineering and this has to be 
>>> handled somewhere else...
>>
>> Would have to be made a part of the core schema (just like pinctrl nodes
>> etc).
> 
> That's the case now. It's contingent on having a 'clocks' property in 
> the node.

Do I understand correctly: with new dtschema my patch is not needed anymore?

Best regards,
Krzysztof
