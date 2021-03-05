Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6332F4AD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEUmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 15:42:15 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37451 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEUlz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 15:41:55 -0500
Received: by mail-ot1-f43.google.com with SMTP id g8so3089368otk.4;
        Fri, 05 Mar 2021 12:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxiBMaUjkdtGVk/8ZQ2/CYCEccRT7hzqM4cRaA/Ie4I=;
        b=nKqhybF6NyqvuAG/vRV609nDFsCtKllf6b/d12vG4qNM786D/Ta89sf2n3CW66vsTm
         YkVUEke6WFVJnndAtM/Ka/xhG2aj6YCMEGfcftODbxbbD3QtxEHw439vRDEBQjAzy5QB
         OC9Q0saKJtNSNScRueX+nUrGDAn6fArY6H6uJ0l1/G/At7w4/7Gvj9eZpO1dhGM51FLC
         qwEFS0XanV+IsbUFtcgaWO4AxkdoZyWXK0ufO/+u1DYZPT8+nkAYGcefm3zrp+FrqEpb
         BU7DojYTG/Y6O5/0piDzDwReKsqh5Bb0Z4dlCw+qMkpjo9FpYBcSt08aLdBg0TTmFl1d
         4FRA==
X-Gm-Message-State: AOAM530Ymt4BZJct6nWuAG+pDmvDSGBpdJpbSp2cUdPBSzwB0lxBNSke
        PMgsnkEviBSC36/Frxn4+Q==
X-Google-Smtp-Source: ABdhPJwxaJOR7D3U0NW/HQGmeMlbGsOpv8rrmZSuGtCzvVOT1WvYaH5DKSdC3EG+d+HghUDEgniTUg==
X-Received: by 2002:a05:6830:1d41:: with SMTP id p1mr9351418oth.126.1614976914498;
        Fri, 05 Mar 2021 12:41:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z17sm789528oto.58.2021.03.05.12.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:41:53 -0800 (PST)
Received: (nullmailer pid 610653 invoked by uid 1000);
        Fri, 05 Mar 2021 20:41:52 -0000
Date:   Fri, 5 Mar 2021 14:41:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: samsung,exynos-adc: add common clock
 properties
Message-ID: <20210305204152.GA607635@robh.at.kernel.org>
References: <CGME20210212164148eucas1p2ab09436a82d50161ff1a9fc1a169f7d7@eucas1p2.samsung.com>
 <20210212163816.70058-1-krzk@kernel.org>
 <85ed4a70-5cd8-3bce-100f-33a1fba7f3fa@samsung.com>
 <20210215092915.7khog24shtzjzd6g@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215092915.7khog24shtzjzd6g@kozik-lap>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 15, 2021 at 10:29:15AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Feb 15, 2021 at 10:01:48AM +0100, Marek Szyprowski wrote:
> > Hi Krzysztof,
> > 
> > On 12.02.2021 17:38, Krzysztof Kozlowski wrote:
> > > Add common properties appearing in DTSes (assigned-clocks and similar)
> > > to fix dtbs_check warnings like:
> > >
> > >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
> > >      adc@126c0000: assigned-clock-rates: [[6000000]] is not of type 'object'
> > >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
> > >      adc@126c0000: assigned-clocks: [[7, 238]] is not of type 'object'
> > 
> > Does it mean that assigned-clocks related properties have to be added to 
> > almost all bindings?
> 
> To my understanding: yes, and we already added it to multiple schemas.
> 
> > IMHO this is an over-engineering and this has to be 
> > handled somewhere else...
> 
> Would have to be made a part of the core schema (just like pinctrl nodes
> etc).

That's the case now. It's contingent on having a 'clocks' property in 
the node.

Rob
