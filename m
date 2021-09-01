Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC993FD0D3
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 03:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbhIABji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 21:39:38 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46045 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbhIABje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 21:39:34 -0400
Received: by mail-oi1-f177.google.com with SMTP id q39so1696732oiw.12;
        Tue, 31 Aug 2021 18:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkTvXd/OXCPZFirPQZmYlHm/KbbHKoDGKpXR0196NUM=;
        b=s8XSOCPX0X2EQXy9vYrzX+1lPvuBbX5sgHI7+9BPiJxvRDaCroDQPxc8WqXRPsaed/
         53/z3N8mzzwMCZbImvxyASOiUhYLm+Cgfs9/lzrdqIVR/0e/7iOeKLOsciOR/ikUGV/x
         5orzJJklKnhoYNO+GUGYkJZqAR/G06kR+oKDU8ynLYhE1EtvNVZ1gXlHgwKk/alDuRIs
         TNASERxrVVvftYRpJwOBBYZUt54cm0QQ+AHmozAVh17eVmDscHBRKcSW2NqPEqmW+7sy
         2dFZL30ZJ/KS6nK4d6HED7+L0eZj6ZCgPy9TMyQs1c3c9dkuvORMdff7yH++x7dOTdIY
         QZ4Q==
X-Gm-Message-State: AOAM5327ViM2XVaU2rgVZmG0TXGCSVJ7C0JnZv1I7Ojx0sPgu3Ezb08s
        tGHOCCypIUy5BB9DpB72Rg==
X-Google-Smtp-Source: ABdhPJw8XN6RFsEE8lVBAG5RX6KeqUwC9q/4Uz5cvep/tRytpYwCGBe1ZDT+bYShKYR2qxjwSiSDEA==
X-Received: by 2002:a05:6808:aa8:: with SMTP id r8mr5536583oij.171.1630460317663;
        Tue, 31 Aug 2021 18:38:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s206sm3953218oif.44.2021.08.31.18.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:38:37 -0700 (PDT)
Received: (nullmailer pid 1009336 invoked by uid 1000);
        Wed, 01 Sep 2021 01:38:36 -0000
Date:   Tue, 31 Aug 2021 20:38:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     robh+dt@kernel.org, linux-aspeed@lists.ozlabs.org,
        p.zabel@pengutronix.de, pmeerw@pmeerw.net, lars@metafoo.de,
        linux-iio@vger.kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jic23@kernel.org, andrew@aj.id.au, joel@jms.id.au,
        devicetree@vger.kernel.org, BMC-SW@aspeedtech.com,
        lgirdwood@gmail.com
Subject: Re: [v5 02/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Message-ID: <YS7ZnG05pZvfA/7m@robh.at.kernel.org>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
 <20210831071458.2334-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831071458.2334-3-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 15:14:45 +0800, Billy Tsai wrote:
> Add device tree bindings document for the aspeed ast2600 adc device
> driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
