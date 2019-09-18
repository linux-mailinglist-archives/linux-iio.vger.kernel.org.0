Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50F2B63CF
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfIRM6F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:58:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42692 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfIRM6E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:58:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so6206000otd.9;
        Wed, 18 Sep 2019 05:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zFk5MHE8p77ZTvBJ2Ef8rpgfEWBCuHhymRwnVR4wL0=;
        b=kJbDhljfVSNKzFOOdSK8e6Vm4f2DhOHIp184GClD0qc8tDrZJxM4qHukb8yf9JxuGK
         0gcvPH0J6XIawYTXT29gNBnrk/b7uHNfFiRHA/7dr4tyPQbhACD4KaiOlK2kmJJdqkGj
         2uppELmFLfiH9t2PEZzAChvJ3XeG+RNxaG3QjuEc07uepxDu/sCNFnGJq9OwGintxcrY
         bbUBKQP1PUn9gU6tV+A1lCP8eYM70aV3ud/HdQfLkgFtUM5RJYKmFJ83ok/S7wbezIh2
         ayUE4e8Aj+h9e4Y5mZsxknE2Up4fEw7oLHBvEJdPf2HCpwX+9+yGlc7qdI5nV3rFEV79
         FBAA==
X-Gm-Message-State: APjAAAW+t5H+6fsx73T6fVQlBtsUTvIz1cv8+nYbtHYit+eAfBPhX3+3
        A/kzS46+mp17abbb6l3ghg==
X-Google-Smtp-Source: APXvYqxToU8rop07pJTky58dYQp14T/5DaTXWnKAr6A/JtuqsIRZmPTo+yZGDzHd9PTvx9bgAsyScQ==
X-Received: by 2002:a9d:744c:: with SMTP id p12mr2787957otk.198.1568811483291;
        Wed, 18 Sep 2019 05:58:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k8sm1704774otl.31.2019.09.18.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:58:02 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:58:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 10/11] dt-bindings: iio: adc: exynos: Convert Exynos
 ADC bindings to json-schema
Message-ID: <20190918125802.GA1051@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-10-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:06 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Analog to Digital Converter bindings to DT schema
> format using json-schema.
> 
> This is a direct conversion of existing bindings so it also copies the
> existing error in the bindings regarding the requirement of two register
> address ranges for certain compatibles.  The inconsistency in binding
> was caused by commit fafb37cfae6d ("iio: exyno-adc: use syscon for PMU
> register access").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Rework reg, clocks and clock-names matching for specific compatibles,
> 2. Make samsung,syscon-phandle required only on certain compatibles,
> 3. Fix indentation.
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.txt   | 107 ------------
>  .../bindings/iio/adc/samsung,exynos-adc.yaml  | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> 

Applied, thanks.

Rob
