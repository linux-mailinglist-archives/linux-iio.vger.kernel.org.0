Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4453D419F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfJKNow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 09:44:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJKNow (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 09:44:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so7993247oib.12;
        Fri, 11 Oct 2019 06:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZeJBsZghT7e6LCjUz+sVvchYWE7PmUmwwhmIaUBEwE=;
        b=bitqoVMUDif8GKdgwxbKgrIZXMRJHGg7lszjkCQnrMjigJFusto1gU2uhIjWMXa0hG
         /qSkONqWXdf6cPgc84w6EGH9zTkDZU8uQhzZQ57p21r0U80N2UK+sruxnwVadR8FRLzH
         GQjfAHugKRkqSoVMySdwu7mckSy3H6prIShljo3lzXCuVO1ou6pjGTd5PxQOSR/vkPDs
         ekNBFw22iH391kvC7bwWPEy36/KYWXX7afp+S6C7FBl2z8ncbLo/7T0kd/EspxQGp4pz
         jgxwYmUZf8tOIS1k89FKl9HKpWu9gh7SGPJxqf+f9sivDVlobrKpPfhvIVCupEFL1DDb
         K6Aw==
X-Gm-Message-State: APjAAAUavHx2QWXQMI0hZEgDV35joWnSRoauQ2fnVmMg3hMmJ85DXkQG
        q4TW5eqXBvhYa8+j1lauJg==
X-Google-Smtp-Source: APXvYqygQnNsKFE3tAs7X9nvUFdWunpcSkwQgK464MYYpP62MRP1sSRUZgDZUeiBY+VI7zwUodJkww==
X-Received: by 2002:a54:4d02:: with SMTP id v2mr4744823oix.8.1570801490268;
        Fri, 11 Oct 2019 06:44:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 100sm2661759otl.48.2019.10.11.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:44:49 -0700 (PDT)
Date:   Fri, 11 Oct 2019 08:44:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7 v4] mfd: ab8500: augment DT bindings
Message-ID: <20191011134449.GA12969@bogus>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
 <20191011071805.5554-6-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011071805.5554-6-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 11, 2019 at 09:18:03AM +0200, Linus Walleij wrote:
> As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> the bindings to account for defining the ADC channels in the device
> tree.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Fix the nodenames from "foo_node" to "foo-node"

You forgot to update the example. With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> - Remove 0 prefix from @0n to @n
> ChangeLog v2->v3:
> - Change "adc-channel@" to "channel@" as per preferred notation.
> - Add some full stops to the end of sentences.
> - Reference the new ADC-specific documentation for channel specifier
>   etc.
> - Collect Lee's ACK.
> - Rebased on v5.4-rc1
> ChangeLog v1->v2:
> - Rebased on v5.3-rc5
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
