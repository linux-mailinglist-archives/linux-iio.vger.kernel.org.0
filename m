Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384893FCDF6
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhHaTjH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 15:39:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33664 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhHaTjH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 15:39:07 -0400
Received: by mail-ot1-f41.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso626397otu.0;
        Tue, 31 Aug 2021 12:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fg7Et8pyyujQ3fRDHXVdaKSzYC69RQWknbOQ5VvvNrc=;
        b=CxXTcURfln+r9O0JdrzVR5psarjsl0zvwaT8HtPD6mqc2PIB4QDS/OV8laUYS7rQ7B
         f6lVBsp/IG8gxF6A1pVWF5eyt0EQsPtMbWCQJ3ka+QP7Yy2sLiUL86jIkYCxPgfy4IjZ
         kM7FcsRbWJRuPteeTzBcMYCjTOf20+TNQfLRT58NBbr/Z854Ia89jQAdDfGwQU36b/Nx
         CLj6x30mJ+Uo2mhIYh2gYRUo16onj1viCEsMtLnZq58miHuPoO4aXp0GxZwNlR2/iced
         OEzsCxZNGI+a+ZtkJnSHbMOUTPN9DtL73ceOMGmIHWrQhxqSgjr+KLVdmUO5wSVyLygV
         idwg==
X-Gm-Message-State: AOAM533gnpfAoOlUcvvWexcM6WAKdlXN6ljmZuxJOf2TCHY470o/vaPK
        sNuQqCZt0VVmWo3OEvGjKg==
X-Google-Smtp-Source: ABdhPJwDs0q03AAls8x8Tc8IAMZbjj8Xg4VzhKlz+uEakELcPEHccJnuEVEY5pQrQKiH3BnZ+qVDzA==
X-Received: by 2002:a9d:6391:: with SMTP id w17mr24232635otk.19.1630438691037;
        Tue, 31 Aug 2021 12:38:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w23sm4094939otk.56.2021.08.31.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:38:10 -0700 (PDT)
Received: (nullmailer pid 531289 invoked by uid 1000);
        Tue, 31 Aug 2021 19:38:09 -0000
Date:   Tue, 31 Aug 2021 14:38:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>,
        bcousson@baylibre.com, Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>
Subject: Re: [PATCH 05/40] dt-bindings: touchscreen: ti,am3359-tsc: Remove
 deprecated text file
Message-ID: <YS6FIcCIef7B5cmR@robh.at.kernel.org>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
 <20210825152518.379386-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825152518.379386-6-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:43 +0200, Miquel Raynal wrote:
> Now that the three hardware peaces described in this file have been
> translated in yaml in 3 dedicated files (MFD, touchscreen controller and
> ADC) it is time to remove this text file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/input/touchscreen/ti-tsc-adc.txt | 91 -------------------
>  1 file changed, 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
