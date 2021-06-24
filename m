Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54D23B3802
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 22:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhFXUmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 16:42:35 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39696 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhFXUme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 16:42:34 -0400
Received: by mail-io1-f46.google.com with SMTP id f10so9924276iok.6;
        Thu, 24 Jun 2021 13:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAjUk7bPyWoWd/SVsIoyGcVFspYCDvY6WLnYCkpjN9w=;
        b=au7gtrt++kDmb/68/RsR4N0yzcKS36HfF0HZX/loQUkIl0ZuCDEJjdjHzpaCynygbm
         4t84UaH5hMhpgoaKkGyIgrhnDz2iJPlHu4OYVafEPLv6X7XqzhAOo4s2Ud2Drq7ppy4C
         OPNeBysjy0eoQyVzKt2XrKs6+JQ6pKciETZDfQp7xemPoqlLIaIdSjHoGJQrnG9apnYD
         OmOHgz+wqR8UNUjm9wyg0ggDo1fUtJ6kc45L98fpZ8xi78uKlHVOX92F6MWaG643yDht
         q2Joaiqz9Iq+IgEaeA30r7gqfo1lAb9snHtY9r6nMIw65vtyXhP3zOwhgzkFdUUMypT8
         EQvA==
X-Gm-Message-State: AOAM531loCb33RjXY1ut4MS/z4YUffawIu/Rw4hdUD3bnJWZb2BxkjLt
        EMiFSBLraVp37fdbSbSYdQ==
X-Google-Smtp-Source: ABdhPJxpQzSvHu6RKbcbNrr9s+E73jopU+p+iVJpRt/y4od0TwBZV9i3wwIVwJ9GhmRVog8T0/oVgA==
X-Received: by 2002:a05:6638:11c7:: with SMTP id g7mr4053113jas.11.1624567213575;
        Thu, 24 Jun 2021 13:40:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e14sm2333419ilc.47.2021.06.24.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:40:13 -0700 (PDT)
Received: (nullmailer pid 1951357 invoked by uid 1000);
        Thu, 24 Jun 2021 20:40:09 -0000
Date:   Thu, 24 Jun 2021 14:40:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] dt-bindings: iio: accel: bma255: Merge bosch,bma180
 schema
Message-ID: <20210624204009.GA1951324@robh.at.kernel.org>
References: <20210614163150.7774-1-stephan@gerhold.net>
 <20210614163150.7774-4-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614163150.7774-4-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 18:31:50 +0200, Stephan Gerhold wrote:
> In Linux the bma180 and bmc150-accel driver cover fairly similar chips
> from Bosch (just with minor register differences). For the DT schema,
> this does not make any difference: They both represent I2C/SPI devices,
> have one or two interrupts plus a vdd/vddio-supply.
> 
> This means there is no need to duplicate the schema, we can just
> document the compatibles for both drivers in a single DT schema.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Some additional notes:
>   - The datasheet links in bma180 sadly seem all broken for me so
>     I just dropped them.
>   - I separated the bma180/bmc150-accel compatibles using a comment.
>     This is just for clarity, it has no influence on the schema.
>   - I added myself as second maintainer for the bma255 binding since
>     Jonathan seemed to be happy to get unlisted for bma180. :)
> 
> In the future we could consider combining even more schemas.
> In particular bosch,bma400.yaml and bosch,bmi088.yaml are also
> almost identical, although they currently specify different interrupt
> types. I think in general the situation for those Bosch sensors is
> exactly the same: The sensors can be configured to either active-high
> or active-low level. However, at the moment neither bma400 or bmi088
> actually implement interrupt support. For now I kept those schemas
> as-is, I think this is better left up for follow-up patches.
> ---
>  .../bindings/iio/accel/bosch,bma180.yaml      | 61 -------------------
>  .../bindings/iio/accel/bosch,bma255.yaml      |  9 +++
>  2 files changed, 9 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
