Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E56269741
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 23:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINVAx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 17:00:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33548 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINVAv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 17:00:51 -0400
Received: by mail-io1-f66.google.com with SMTP id r25so1728230ioj.0;
        Mon, 14 Sep 2020 14:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vtjUkAlc6mhyHfdc10mPS+CwPbTLyIyM4ON46GRum8=;
        b=FBxy3Y7WJZtFpdWi0MV0lX9A2IgepaTbZPVS6noGeyzZZhHCT/Ioud/PWqO5/8AS9j
         aVZZSbRPsoJA35277Pu9FAsi1nXHrMW2RJSPuF7Ik25wX8QIFC04SK4oAk99Xnd2QFpR
         dApJ0jjzD9PpydPSHezPPzk0nutCTbiiNDJim+RNBFgpC5j/6iShdVLK96vqKG+5u34E
         fVZSDibAjVS6VMhywTlkJdwm7ULXaSRFs50W0sU5t84R+EFwtXj4ExUuKU5CqHOolHFv
         QBbLLRXe/wwxv91aTiWNd+IeNoXyd0mThyvIE2K/mC89Bx5BoCkn10cLN/T2NNE6dOmI
         6mcw==
X-Gm-Message-State: AOAM533IGzb3kR3rNCNBHaabH3HNkeFbDhFaw82DA2iA86YqqeMyd6gR
        pvbWamW5F2MD/utFFqsbZg==
X-Google-Smtp-Source: ABdhPJy2m12YZdezzBzT5cv+XqRojOX9fZtGmNqp9vR+dLVfSYmXhGC3JOTufd8GnIvv7owiKKtK6A==
X-Received: by 2002:a6b:590c:: with SMTP id n12mr13081561iob.25.1600117250111;
        Mon, 14 Sep 2020 14:00:50 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a20sm7638304ilq.57.2020.09.14.14.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:00:49 -0700 (PDT)
Received: (nullmailer pid 239411 invoked by uid 1000);
        Mon, 14 Sep 2020 21:00:47 -0000
Date:   Mon, 14 Sep 2020 15:00:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT
 properties
Message-ID: <20200914210047.GA232617@bogus>
References: <20200903221828.3657250-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903221828.3657250-1-swboyd@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 03, 2020 at 03:18:28PM -0700, Stephen Boyd wrote:
> We need to set various bits in the hardware registers for this device to
> operate properly depending on how it is installed. Add a handful of DT
> properties to configure these things.
> 
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> I haven't written any code to handle these properties yet. I'd rather do
> that once the binding patch is reviewed. Patch based on iio.git testing
> branch.
> 
>  .../iio/proximity/semtech,sx9310.yaml         | 182 ++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> index 5739074d3592..e74b81483c14 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -40,6 +40,169 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  semtech,cs0-ground:
> +    description: Indicates the CS0 sensor is connected to ground.
> +    type: boolean
> +
> +  semtech,combined-sensors:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +    default: 0
> +    description:
> +      Which sensors are combined. 0 for CS3, 1 for CS0+CS1, 2 for CS1+CS2,
> +      and 3 for all sensors.
> +
> +  semtech,cs0-gain-factor:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [1, 2, 4, 8]
> +    default: 1
> +    description:
> +      Gain factor for CS0 (and combined if any) sensor.
> +
> +  semtech,cs1-gain-factor:
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/uint32
> +      - enum: [1, 2, 4, 8]

Now that everyone is trained on 'allOf', you can drop it. json-schema 
draft8 changed this behavior.

Rob
