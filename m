Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6813C1C7A0D
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgEFTQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 15:16:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45792 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgEFTQa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 15:16:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id e20so2296647otk.12;
        Wed, 06 May 2020 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RffY1VKIuHSTUWSQQaHo7x6JeP+WjY39egkTgOhujrc=;
        b=c5UykAeQ1gYmZRITApNL+xBRUvKZG4l3oi1dw6GzoUZU1SC8p1CO+ToFirjqueEEU5
         2IUKRUIp4+bZjenTvuWAxrqPtb+MhqlgKMNw8HLLfxuGuj+OTyrngX8DAZLLQ4ilTUNL
         wyCpV83+qY0UOf3QrDEDPSlnlFxNfbmvycwTbw1nXH4GX7EmTtBue+LFFzxhiHwnJWII
         9t1UysyHx5WRdR0YeXiXyKSpwO+Txd79E9xz9R7WtRuB6QwLjQmvaJC8Ww5PBihkMeDV
         BzIrvEa7nHbsAZ5bY5iPD4SUph0bzyK9A1ZhGL88rAbt8Zaj+X5IVz3LMnTAxYXOTGR5
         4GSw==
X-Gm-Message-State: AGi0PubO8RHjiDSXrnK3HyNtsnI0IG3MdOkB8gaXGrKtdeHrDEVT+RP0
        LYmx3YyeHQWlFf7XHHfBrA==
X-Google-Smtp-Source: APiQypKX7Yv5OxxTXIw4EebyAUNARWZ7M2l2W40uhAxBhtZnJdkyt9oNdwaILP/riNyqVgTQ5qC/Hg==
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr7690098oto.371.1588792589363;
        Wed, 06 May 2020 12:16:29 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f14sm726909otl.62.2020.05.06.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:16:28 -0700 (PDT)
Received: (nullmailer pid 21925 invoked by uid 1000);
        Wed, 06 May 2020 19:16:27 -0000
Date:   Wed, 6 May 2020 14:16:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: proximity: provide vcnl3020 device
 tree binding document
Message-ID: <20200506191542.GA20381@bogus>
References: <20200506010809.6348-1-i.mikhaylov@yadro.com>
 <20200506010809.6348-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506010809.6348-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 May 2020 04:08:08 +0300, Ivan Mikhaylov wrote:
> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../iio/proximity/vishay,vcnl3020.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/proximity/vishay,vcnl3020.yaml#

See https://patchwork.ozlabs.org/patch/1284005

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
