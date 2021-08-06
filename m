Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D33E315F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 23:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbhHFVt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 17:49:59 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38402 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhHFVt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 17:49:59 -0400
Received: by mail-io1-f54.google.com with SMTP id a13so14216276iol.5;
        Fri, 06 Aug 2021 14:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGmkEMZUDU+QvM2aaIUEPqMWpY1r3o8Dv4JEir1z/cM=;
        b=Nu9EFDvXd0FK4OZoykpE2a7aEqSkpJNqmeMaQNP92NEAmGa48+KVFptiTzib30UkAK
         GBoRBcUy4U2w7aIgcIy8YtB0G76kxvl6wQZdgH/vJ0ctEW8ikQfKEtUjW019D2gy8AoK
         6TwgQbZsXVxgu9kRSUW9eFPsS9QppaEfAXb/CqcXWTuHNJ021R6NgEZuTMXZcunF78v1
         Ml+m0b6MWPBaVzPgNLaLwl0rN3Og8Bof1KTLdDu71Aqq/3MjWP6sANgsF7HUbzkL71nm
         7p0Ze59S4Bq0RqIBACpm+YieDOrNE2QkGeaOfiR7yAYiIUZgxyfA8DOBE20tMDPaY+CO
         CURA==
X-Gm-Message-State: AOAM530jPcCpdGZpywvre6gqFwdv5k8+d5lYHGRGcGavMcJy9v1z+mCd
        Uabz231NZsPWdkjxz4g4WQ==
X-Google-Smtp-Source: ABdhPJwD19WYnKvOPAOLgWeQJO51CkKwAGkZNAJQNi8/aOFr8CVGerRNyPG56bH7x4qxikMH7mbE8w==
X-Received: by 2002:a6b:2bd6:: with SMTP id r205mr202266ior.122.1628286582047;
        Fri, 06 Aug 2021 14:49:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m184sm6059218ioa.17.2021.08.06.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:49:41 -0700 (PDT)
Received: (nullmailer pid 1865734 invoked by uid 1000);
        Fri, 06 Aug 2021 21:49:39 -0000
Date:   Fri, 6 Aug 2021 15:49:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: accel: bma255: Add
 interrupt-names
Message-ID: <YQ2uc/c8t3Ed2G+a@robh.at.kernel.org>
References: <20210802155657.102766-1-stephan@gerhold.net>
 <20210802155657.102766-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802155657.102766-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 02 Aug 2021 17:56:54 +0200, Stephan Gerhold wrote:
> The binding already allows specifying both interrupt pins, but there
> is currently no way to describe a board where (for whatever reason)
> only INT2 is connected. Make it possible to use "interrupt-names"
> to make it explicit which interrupt pin is meant in the interrupts.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v2:
>   - Add "Without interrupt-names, ..." to "interrupts" description
>     to clarify that ordering of interrupts can be relaxed if
>     interrupt-names is used.
> ---
>  .../bindings/iio/accel/bosch,bma255.yaml         | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
