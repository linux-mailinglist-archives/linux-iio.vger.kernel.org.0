Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91D376C59
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 00:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhEGWRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 18:17:06 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41621 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhEGWRF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2021 18:17:05 -0400
Received: by mail-oi1-f171.google.com with SMTP id c3so10007095oic.8;
        Fri, 07 May 2021 15:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tiub5wckWCZgWB+zl+PgHhpRQTIZAIX3PBjR724A/DI=;
        b=OeWpuxkS8WV/yVdqaYLJNo2CWdHsQMYdh+AbCgZyu3ZcAwYY3VS9YIUOeuXTBg1Lb1
         zfIDUWEknjolAootdRNv3uTf/8EX4T8EtI2ht94sPtfrw7aIDtpfEg/g6+EPhlnawU/0
         y9LICLzSb7hLegxTQWMptoP/1MP8cQvLJjOZCFDN6S/qDUrZ8NnHd46u0DCSHsBm+kUb
         BPbuklt6+HQx3DTo7s2/LNBn/bWMmdqwYQC1bsFzD8B2rGxoA1Dtpv4km3P36ECMfoHr
         c9CPkc85Fliu0l2C4mlfsaED2QDMyl+MS3Q+noygmKVJxzabzcTE5NBi8mEN8luOau4c
         4WLg==
X-Gm-Message-State: AOAM532tJZqm0CObJ5S8ZZyN90PIbRWFOqb+QZjp+vYYlwam0Xmae8R2
        t+Ffy23jUlXu5sKB34QGnEBTiZ6JuQ==
X-Google-Smtp-Source: ABdhPJwDyL3D3bpZWEsWu/gymymyW3eLZ3eftxGCMxskLzMhSyGtQHvSPd6RGYwWdwdSHEhYJXcAew==
X-Received: by 2002:aca:4f51:: with SMTP id d78mr8758439oib.168.1620425763899;
        Fri, 07 May 2021 15:16:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m67sm1423721otm.69.2021.05.07.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:16:03 -0700 (PDT)
Received: (nullmailer pid 2994502 invoked by uid 1000);
        Fri, 07 May 2021 22:16:02 -0000
Date:   Fri, 7 May 2021 17:16:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: afe: current-sense-shunt: add
 io-channel-cells
Message-ID: <20210507221602.GA2994472@robh.at.kernel.org>
References: <20210506150637.35288-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506150637.35288-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 06 May 2021 11:06:37 -0400, Krzysztof Kozlowski wrote:
> The current-sense-shunt is an IIO provider thus can be referenced by IIO
> consumers (via "io-channels" property in consumer device node).
> Such provider is required to describe number of cells used in phandle
> lookup with "io-channel-cells" property.  This also fixes dtbs_check
> warnings like:
> 
>   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: current-sense-shunt:
>     '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/iio/afe/current-sense-shunt.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
