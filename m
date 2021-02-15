Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B95631B67A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhBOJaC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 04:30:02 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35842 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhBOJaA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 04:30:00 -0500
Received: by mail-wr1-f48.google.com with SMTP id u14so8055775wri.3;
        Mon, 15 Feb 2021 01:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRqFz3esH44SGfi+ymnjqHi85o47gVCreOzoNzv9tXs=;
        b=sm3kFCh5yOQgegmKw77vwgLEA/9lwgMvi2+Hq//XUYDGST5P0KpkFEHOeJOFQ4BIwA
         YQq1J4IHjDtGfwrMXR7plNTI6uEzLTWXkm41Qu7llqaQ03tkaS/NRLNcwvPzXUqZyZK4
         efJtlG2Z0P/2o/Y4S4HG5hn2EDnKJpDhpfm/xwQSIR6esTz/dklF00A+yFnGYGJ2ASgp
         zKA8DVl3VBXW4oGmCKNgN2/d1velalfzJWsBZ5JeCmZqEzlzS39LS3ksi1nMkE/mTDwS
         bLxXpp+HtVwJkecZB9y9xBkpLn4ZyuTb81T6qblmFU82ZT2AKYqFggfYAQWSigOENWgs
         xmEA==
X-Gm-Message-State: AOAM532dDB8tpz9UCXhLqCDmvaR7O+nk2RBLMo9OF/zvOVJZkbQSZy+8
        pPLdWmSVePhTJDPHRUuY4NJKZSotvyU=
X-Google-Smtp-Source: ABdhPJzVXw9V6t8gFVUjOGIH9f4ikltgVKe3BcG21N4vs+98yPEvVuwpVBwmcjmeKvNAERsM0qMv3Q==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr17772258wru.394.1613381357788;
        Mon, 15 Feb 2021 01:29:17 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h12sm30224267wru.18.2021.02.15.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 01:29:16 -0800 (PST)
Date:   Mon, 15 Feb 2021 10:29:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: samsung,exynos-adc: add common clock
 properties
Message-ID: <20210215092915.7khog24shtzjzd6g@kozik-lap>
References: <CGME20210212164148eucas1p2ab09436a82d50161ff1a9fc1a169f7d7@eucas1p2.samsung.com>
 <20210212163816.70058-1-krzk@kernel.org>
 <85ed4a70-5cd8-3bce-100f-33a1fba7f3fa@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85ed4a70-5cd8-3bce-100f-33a1fba7f3fa@samsung.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 15, 2021 at 10:01:48AM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 12.02.2021 17:38, Krzysztof Kozlowski wrote:
> > Add common properties appearing in DTSes (assigned-clocks and similar)
> > to fix dtbs_check warnings like:
> >
> >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
> >      adc@126c0000: assigned-clock-rates: [[6000000]] is not of type 'object'
> >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
> >      adc@126c0000: assigned-clocks: [[7, 238]] is not of type 'object'
> 
> Does it mean that assigned-clocks related properties have to be added to 
> almost all bindings?

To my understanding: yes, and we already added it to multiple schemas.

> IMHO this is an over-engineering and this has to be 
> handled somewhere else...

Would have to be made a part of the core schema (just like pinctrl nodes
etc).

Best regards,
Krzysztof
