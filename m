Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF73B37FA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 22:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFXUkz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 16:40:55 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:33506 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUkz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 16:40:55 -0400
Received: by mail-io1-f52.google.com with SMTP id a6so9972491ioe.0;
        Thu, 24 Jun 2021 13:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mVeWhhzPXG8CW+IRm1upd8/5K1R+1iM9HKwXKQFw2FE=;
        b=s0IYq7EXodu1SrAtU945SFDMGtFTgMCODBr71Ptmk+UirueleDVBfYH6yjsuYMP4oK
         399BpIvOYfd+iEF6V/82rfr7CU2ApA/T5miu+weTUXbqdg8RCb8/vc94x1cMM9emCSg9
         CLZa5BByMO1wwAoiv4F/x/YS0oN1bZskN5Mt+yEWvu/1RGUMwEJuu8k1Om2J3F3QPV/v
         J+QvHKlDtW15xz/LKOb1Aj6x6Rw8WU7NR1WJxl6R/XqSI0XH1i3iKD51CylHph3qa9SV
         y6vgIWBw+WnJzyfrcCYdIEkfeFSWhyU6bLXifs2O8Cx85FR/f7QMd+s7D4wZWdoAX4Nr
         UAUg==
X-Gm-Message-State: AOAM531+w7V9NTFvwcZkek9dvalr2ouHLebWGkZJW04NH3rvANrukkMs
        lhH+6EDyGm7vAbcWlMevZA==
X-Google-Smtp-Source: ABdhPJxZQYyomrt+6om8kqUEUP2uEIeWKd0AWMWRZLocYQJEOKW9kwE+359402DRg9lXVDKUsC5tjA==
X-Received: by 2002:a05:6602:334e:: with SMTP id c14mr5710903ioz.78.1624567114519;
        Thu, 24 Jun 2021 13:38:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e7sm2379768ili.10.2021.06.24.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:38:33 -0700 (PDT)
Received: (nullmailer pid 1949058 invoked by uid 1000);
        Thu, 24 Jun 2021 20:38:30 -0000
Date:   Thu, 24 Jun 2021 14:38:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: accel: bma255: Sort compatibles
Message-ID: <20210624203830.GA1949009@robh.at.kernel.org>
References: <20210614163150.7774-1-stephan@gerhold.net>
 <20210614163150.7774-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614163150.7774-3-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 18:31:49 +0200, Stephan Gerhold wrote:
> Similar to recent rework in the bmc150-accel driver, sort the compatible
> list in the DT schema so there is a consistent order.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/iio/accel/bosch,bma255.yaml    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
