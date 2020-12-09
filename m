Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E612D2D48CA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 19:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgLISSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 13:18:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39825 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLISSW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 13:18:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id v85so2706919oia.6;
        Wed, 09 Dec 2020 10:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t0IEJ9Kjkjr6WBfSG3+TpVJkzpjFITDdJoH/Uozbldk=;
        b=kwj4GfkiI4F74d7l9N0sFkZbHuVOLKcVlOwQgRAsuXsuPWW6sGolj5CLiP1uCDjWbY
         aNJ+ggq6TxWD01qyfwPyVXpZvOhH1LXT5lLfVJp6/v+88EboXMBKCqGIHEiJ1e/tmbpI
         zO0UkrdBakm9GH/Qpy2JtT7C+0wGf53q0JEsGSpOVieCiCbyDoZHHT1NOK//OMcXya/M
         1yz1rkuFH4Wjz9kDHMgD55mr6bNCYaE577LO5O76mR5nODEn2q0r8slR7BpxV6HHixem
         LXyv+53d74BvaxUsakM6N6umpenb9OmbVVCe0W8jtnQJfygFOBD7opfzMMJ+4sBbnQ5+
         0k0g==
X-Gm-Message-State: AOAM530IP6mdLmXFul+KzJgkkGwnV6Sfuue0Erp/kA4oRsejZZGmDLk6
        SLlW9njjmS0jwXRsui/z9w==
X-Google-Smtp-Source: ABdhPJxugqkrL7F4hfvf+E6P2ob2gJ/QKFOkVn9KHpzkM7jSWsKeI0C3NueoVWpO1P/KGk1kN+r9iA==
X-Received: by 2002:aca:f3d6:: with SMTP id r205mr2727621oih.152.1607537861591;
        Wed, 09 Dec 2020 10:17:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k5sm455334oot.30.2020.12.09.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:17:40 -0800 (PST)
Received: (nullmailer pid 708174 invoked by uid 1000);
        Wed, 09 Dec 2020 18:17:39 -0000
Date:   Wed, 9 Dec 2020 12:17:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055
 compatible
Message-ID: <20201209181739.GA708144@robh.at.kernel.org>
References: <20201202083551.7753-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202083551.7753-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 02 Dec 2020 09:35:51 +0100, Stephan Gerhold wrote:
> The bmc150-accel-i2c.c driver has an "_accel" suffix for the
> compatibles of BMC150 and BMI055. This is necessary because BMC150
> contains both accelerometer (bosch,bmc150_accel) and magnetometer
> (bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.
> 
> However, the binding documentation suggests using "bosch,bmc150".
> Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
> match what is expected by the driver.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
