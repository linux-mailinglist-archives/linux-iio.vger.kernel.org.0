Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D525C2C94FB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 03:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgLACIf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 21:08:35 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35474 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgLACIf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 21:08:35 -0500
Received: by mail-il1-f196.google.com with SMTP id t13so174879ilp.2;
        Mon, 30 Nov 2020 18:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wmb1E9vwJ20mbsZfVtg7o1J8TNNKrE+DCJCeq7P0tQw=;
        b=pysRKWhT42B98wNkRIZYcCmslx5G30b3qu8k0aqO9hm4ucGcrr6Yq78Mll5AwNYtzg
         Q5BsqZLcSDSpPoMX61BX5koUJkVhpjg7cgm8CQ0HdEYrAJ3ffnKsaJNBm/yHofRO7oOh
         5vt7ZcheIz0ktvik9QL/9NqMZzVHSwfd++nauMAXCMBGVnSAgUPQNtOxP5fOP5bRfUZm
         L1TyTwXPwsHNjffylnK76lcbjTWMUsd5jx8TYe8c7eIv7Te8d4njeCWT2b0GFbQ82RLA
         61B9ZJDLMrcN+FPcN0VX9DXKW6ZVAHUZy0RcF37CGJBPTke9kngvz76yTChM976RwWGX
         wuXw==
X-Gm-Message-State: AOAM531t4QCXJr1KVnu7eqjAQCmBFSYE0Okun8HtEw5LfWbWjOPBShTb
        MA1hCgEsyJ2syMN1Nu9IUA==
X-Google-Smtp-Source: ABdhPJw+YP5JQ39895685yf6gbmiiehuqB9qVkocRfkDD2sFBTw28pMjbGcSkhIKB8CwvBwoRMckqA==
X-Received: by 2002:a92:da87:: with SMTP id u7mr670427iln.230.1606788468742;
        Mon, 30 Nov 2020 18:07:48 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w14sm222589ilu.54.2020.11.30.18.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:07:47 -0800 (PST)
Received: (nullmailer pid 3492586 invoked by uid 1000);
        Tue, 01 Dec 2020 02:07:46 -0000
Date:   Mon, 30 Nov 2020 19:07:46 -0700
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2 v4] iio: accel: yamaha-yas530: Add DT bindings
Message-ID: <20201201020746.GA3492504@robh.at.kernel.org>
References: <20201129215421.1177990-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129215421.1177990-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Nov 2020 22:54:20 +0100, Linus Walleij wrote:
> This adds device tree bindings for the Yamaha YAS530
> family of magnetometers/compass sensors.
> 
> Cc: devicetree@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Rename the bindings and file yas530 after the first
>   introduced component in the family.
> - Simplify conditional logic using the if: not: YAML
>   constructions.
> - Use the possibility to set a property to false to just
>   remvove reset GPIOs and interrupts from variants that
>   do not have them.
> ChangeLog v2->v3:
> - Restrict to cover the YAS53x variants, it turns out that
>   YAS529 is a very different component from the others so
>   keep that for a separate document when/if needed.
> - Rename the file and binding yamaha,53x.yaml
> - Use - if: clauses to restrict some properties.
> - Fix some spelling mistakes.
> - Restrict the nodename to be "magnetometer@[0-9a-f]"
> ChangeLog v1->v2:
> - Add Yamaha to the vendor list, I was surprised to find
>   they were not yet listed.
> ---
>  .../iio/magnetometer/yamaha,yas530.yaml       | 112 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
