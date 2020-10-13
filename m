Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2128D13F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbgJMP3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389307AbgJMP3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 11:29:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD709C0613D0;
        Tue, 13 Oct 2020 08:29:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q5so98452wmq.0;
        Tue, 13 Oct 2020 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mjiyjVsGGXyDjzrsZuC1J4LlhI+CHkfPoB5QM0hQOC4=;
        b=sjRGH2PXzw0V9eOoQIG6NTECrQgppWtQCeoH6EqFPQpDJlEkYOZvgwNM3pJaYvIykb
         a21zOdrGlVqrMNRSfCf3awaV70i0Bf5cC5SRjASUBZu899J7I4UwL0WztUwkqoHw3/Li
         y2TdGz7FsiW7uRf0pysSwsNjMXIWswFk5pZSYrJ4P2qmDNWX8ohK05dPHjh5MMG7e7HU
         PeF+dONFIs9p7kUyTh5h2km7WrnqnzYBDQxvLm3gSbCUfP9X2nDkACJmt613k0E5QSzU
         oUyTmlNkd3KBKPfBrvtOfnCcOln+alEeZTW92HMunW4NHgfO+gE2a8QmH55NO3wK6OzS
         5GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjiyjVsGGXyDjzrsZuC1J4LlhI+CHkfPoB5QM0hQOC4=;
        b=lGINjHEy0MoBxtfqp0OLrReH23i1l7GgwPzOqDBa5t+Drxt8VXXYwsglxoGD7QY02S
         l6tJVWK5mjoRZEihnZAkSNysT4u6w4YWZ8fgqFgZIlUTIvbnVQgJO5KBtisxMfKJWKs/
         geMsHgWYjRiAnEEowe5KB+Uizb0yb7I4jA5E6CdyNm/fVWMv3ZxWvO3Eu/qV0yS0qdy+
         HEv1DKxnsi/c4wYEYqIBedvuxvCZD3sOHdBdZYpHdNn7iJHc2y2nHVAjYW9y3yAAnSCv
         LDeAA/i9Me4PEZSJfB0w0nsYzUTQ3JMvEo4jetcF4NIsa0gSItYk16OdJvd25LC68SzF
         2IWw==
X-Gm-Message-State: AOAM533xgQcl+j9B2h3wJGol0ssV+Dy598KIMx9k524t3I5euJCVLYeB
        F1gl8a7dTshNWQOI9E0huADmMYQigzfdMw==
X-Google-Smtp-Source: ABdhPJw4prU04oixGXNv11ba1nnr8682cUZNiDAAoVcJ0ibWqNyHNPuAZ5moFweZHKugXeG3NgEikg==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr411620wmy.51.1602602950342;
        Tue, 13 Oct 2020 08:29:10 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id x65sm129753wmg.1.2020.10.13.08.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 08:29:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8516: add auxadc node
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org
References: <20201012205218.3010868-1-fparent@baylibre.com>
 <20201012205218.3010868-2-fparent@baylibre.com>
 <81a12664-639e-20cc-8b49-6bcb53822a3f@gmail.com>
 <CAOwMV_yqK+yLZH1tOSeUHP7qz35k-bYmWf7jg6qQpvhO9LeJ6g@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <ab900e0f-fd5f-a1cc-8300-b681c97f7231@gmail.com>
Date:   Tue, 13 Oct 2020 17:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAOwMV_yqK+yLZH1tOSeUHP7qz35k-bYmWf7jg6qQpvhO9LeJ6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 13/10/2020 11:06, Fabien Parent wrote:
> Hi Matthias,
> 
>> Any reason you don't enable the status in the pumpkin dts?
> 
> No particular reasons. I looked at what other MTK SoC did for this IP,
> and half went with the status to be disabled and the other half went
> with an enabled status.  So I went the mt8183 way since it is the last
> MTK SoC to have been merged and disabled by default. If you think it
> is better to be enabled by default, I can change it, I don't have any
> strong opinion about this.
> 

Well on mt8183 it is missing the thermal driver although as you can read the 
values via sysfs I'd say to enable it. No need to resend just because of that. 
I'll take the patch as-is as soon as Jonathan takes 1/2.

Regards,
Matthias
