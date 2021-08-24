Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8993F5DFB
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhHXM2u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 08:28:50 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:35328 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXM2u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 08:28:50 -0400
Received: by mail-oo1-f49.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so6433633ooc.2;
        Tue, 24 Aug 2021 05:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uytETCdTYH7zYm638OpCPQhienPtJvPvpm9AsV+41jY=;
        b=c1iPdCljf5IiS4o5TO+YT5qAvofrSxBjrGMe+YKWgIP7IL5Cyd21fMh4dYogllnIuo
         j6VvRjZp6uzlNubed+cQnsV7KSGMDSBt77HsKfaLk8Su5FOayXcaOfU2ttbsuxzTGB6d
         wtPbtDQzUDGe+89+hpAsiybg/LdzmWfvgeOJ5yE0OvWbFqBGvzC/bcJyT2PEope0Xg/O
         pjD8x1MjnQBTbIJUwdfpWXW1t0x7obe105ksNKfvPVs2X8rcGUArNvtrZ+Bk2lndp7bB
         R0741ZO0AIRz0lZ3lbSRoKwX0LTXYgRULGPgZ0OaNFSPUhM0N8+NSTOHckn6Fh4AtZkJ
         XQnQ==
X-Gm-Message-State: AOAM532XVxuCpGwWqjyOtmKOqYWQzZNQPA8BIw8cVYzpE9ECJ/JxXaPC
        AZ4vMXCD3zHTkZgi4AxhJg==
X-Google-Smtp-Source: ABdhPJyUiS/ppMDAOP2s9nFPC4Ys3GDxLfh08N/rOFcCLdJi0T2d/kGnruFHvZ0NuJoO3QUBnJEA7Q==
X-Received: by 2002:a4a:3e58:: with SMTP id t85mr29684525oot.81.1629808086143;
        Tue, 24 Aug 2021 05:28:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f17sm3176408otl.24.2021.08.24.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:28:05 -0700 (PDT)
Received: (nullmailer pid 58470 invoked by uid 1000);
        Tue, 24 Aug 2021 12:28:04 -0000
Date:   Tue, 24 Aug 2021 07:28:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
Message-ID: <YSTl1Ku9jZnDLL21@robh.at.kernel.org>
References: <20210822184927.94673-1-jacopo@jmondi.org>
 <20210822184927.94673-2-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822184927.94673-2-jacopo@jmondi.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Aug 2021 20:49:25 +0200, Jacopo Mondi wrote:
> Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
> v2->v3:
> - Fix syntax error reported by dt_binding_check
>   The device node label in the example cannot contain '-'
> - Add 'Typically' to the gpios polarities description
> 
> v1->v2:
> - Add maxItems to -gpios properties as suggested by Rob
> - Add a label to the device node in the example as suggested by Rob
> ---
>  .../iio/chemical/senseair,sunrise.yaml        | 55 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
