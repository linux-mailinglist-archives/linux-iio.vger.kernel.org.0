Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1E3DABA7
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 21:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhG2TKv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 15:10:51 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:40634 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhG2TKv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 15:10:51 -0400
Received: by mail-il1-f171.google.com with SMTP id d10so6979228ils.7;
        Thu, 29 Jul 2021 12:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2KJztUk7hjyBpEHsawdWHW4V+MK0jA2X1CxRP9F8zYs=;
        b=NpvLxmh40qbYEN/fFyyYgYM5ZW03pQffWXMDIG7frkPP1GfNYNqfJlkDaPnbwMSVkO
         G8FEiqq2xuKWAWt2RfWP+0T0GYDqO8zfocSnMmXuMO/1EJwMSGGJdq/TiLYVT4xRjIbi
         8HBFoAkKmqAz9aN9ltOLkdFOFjIyJzZ1nw/VkcAIbb0XGYyvW1j7CNZovgWavMC1dQxN
         Q/TiTv+/NKZtov7E7Zgnr2hZk+Hs7RKpKs/nJh8u7U75frXISj4/IPiwDwHWhZZj4Nf3
         tJFHBViokUcg2skdcvxK4IJkjsmopHrBt+AdCGzRPbUGeEFEHC8+A1/5fhIab7Vtvg4E
         28mw==
X-Gm-Message-State: AOAM530DprmmxPoIXG2tIxsz6L/Gkl2248mEn3svlMta3yG2zJBUyM1y
        OVXPWQbkhIBv1dBVrdkdHQ==
X-Google-Smtp-Source: ABdhPJxhEJ+6qO0fXEwmwwb14IzQvJFZ6YNmv5sOhq5AaWAt4bqSgGRvwjOJSvcu24n6Mqr9WtYrjQ==
X-Received: by 2002:a92:d8cf:: with SMTP id l15mr4668534ilo.227.1627585846919;
        Thu, 29 Jul 2021 12:10:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t2sm2423911ilq.27.2021.07.29.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:10:46 -0700 (PDT)
Received: (nullmailer pid 707779 invoked by uid 1000);
        Thu, 29 Jul 2021 19:10:44 -0000
Date:   Thu, 29 Jul 2021 13:10:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: accel: bma255: Add
 bosch,bmc156_accel
Message-ID: <YQL9NEtGgKekqxWd@robh.at.kernel.org>
References: <20210719112156.27087-1-stephan@gerhold.net>
 <20210719112156.27087-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719112156.27087-3-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Jul 2021 13:21:54 +0200, Stephan Gerhold wrote:
> BMC156 is very smilar to BMC150, but it has only one accelerometer
> interrupt pin. It would make sense if only INT1 was exposed but someone
> at Bosch was crazy and decided to only have an INT2 pin.
> 
> In this case, it does not make sense if the first interrupt pin is
> treated as INT1 (since that pin does not exist). Add a note to the
> bindings that the first interrupt pin is treated as INT2 for BMC156.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/iio/accel/bosch,bma255.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
