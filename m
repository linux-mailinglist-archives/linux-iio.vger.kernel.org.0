Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0026ADE7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIOTpU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:45:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43490 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgIOTpL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:45:11 -0400
Received: by mail-il1-f196.google.com with SMTP id a19so4140292ilq.10;
        Tue, 15 Sep 2020 12:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICVFxs8iVtQIEcYwtSKGznTnFV9/wjFUcjDC0+WbyYQ=;
        b=ilYH2dE3vFPtigYY+73JOJ8zkUcVwNVWf4YbbgVtw+8AeqUrlKW/AgaW6OXvDdyF++
         ORZM0WsxVTu6imKoVfYakIwY9j1HYhZn3+8f4v+sXXwSYV9xnuadChYIMF1xX/ZmtSkh
         0anaxGqvx+CvSJCSVpMb2Ie9ihttWU9eHrz1IcnLmCrPRi1m+SSz0KUe6xHwy/TjSfb1
         LE0JiZ8F+o08g/qK3pZa4JBHvEODq9iNsSh7AfjNsuf8FcMeB4i9v4rk4vW8gIM3o7hc
         l88OujYJvr4fIIzq5NYiAWhlXCul2zSBH6lilVd7uhGFfQbk4XIW+U0qZZFvFIOGhY+k
         kzQw==
X-Gm-Message-State: AOAM531/Pmo/+WVwqdXUboWBdSUIjMJhkGow/J8l6H2OC+QR2yAww70f
        AdBNdBq0WO7qY+gCF5GIQg==
X-Google-Smtp-Source: ABdhPJySBq95Rewtru7F3DIjujHCjXgu2VSsphfFgxZctOxUMjPHTyQRLbf4c7FEJGY39N1NjzUKdQ==
X-Received: by 2002:a92:c6c8:: with SMTP id v8mr17624118ilm.145.1600199109950;
        Tue, 15 Sep 2020 12:45:09 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k1sm9313963ilq.59.2020.09.15.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:45:09 -0700 (PDT)
Received: (nullmailer pid 2384942 invoked by uid 1000);
        Tue, 15 Sep 2020 19:45:06 -0000
Date:   Tue, 15 Sep 2020 13:45:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: exynos-adc: do not require
 syscon on S5Pv210
Message-ID: <20200915194506.GA2384890@bogus>
References: <20200910161933.9156-1-krzk@kernel.org>
 <20200910161933.9156-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910161933.9156-2-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 18:19:33 +0200, Krzysztof Kozlowski wrote:
> The ADC in S5Pv210 does not have ADC phy registers in separate block for
> which syscon would be needed.  Remove this requirement to fix dtbs_check
> warnings like:
> 
>   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: adc@e1700000: 'samsung,syscon-phandle' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> 
> ---
> 
> Changes since v1:
> 1. Add Ack.
> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
