Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3601D7B0B
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEROWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 10:22:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43845 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROWw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 10:22:52 -0400
Received: by mail-il1-f195.google.com with SMTP id l20so9962537ilj.10;
        Mon, 18 May 2020 07:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OBcPiRkFf2HqCBrlS/cgfO6TiTzCErqXJ+wgd+Jl1A0=;
        b=YmsVn3AXDFZdD0iwwbOy6E8Qqbo3eYhnyy8p1ZNNEBMuxsz8UA9TDSxJluvba8+do3
         BrFDD0zom1gWjW2YC2M5M24VeGDgKdtXBzBrTAWh8m7M3seEGuZntlpT+5zGBhbCYXui
         OU+yvZCntS9hxtuTj/AtA8HE8BMhqWnyrEL+uAWaJ5ivE93vQcf00P1wPl9uJzzWmYI0
         RDwFSwjW9jLZazGXusUrX4Pz79k7nsvPp8z8nqvLAkMtkiKt+d25NRIsVbYCPMyTs9HS
         Q38/FlmHyKemf1CBooJkMHkzmKrvVUQXR1OhTtDgiINSCstnkMBSkoanGCRF0IwxLQ4C
         Nmrg==
X-Gm-Message-State: AOAM533eLpkFQzagXU28P4OaG0QnERqUudFeIjNo/u7WDYjxtP464wMl
        jp4vI6dPKBQVXr5BZkwW1A==
X-Google-Smtp-Source: ABdhPJzV6KNOjj8p+ww1n7tkHaJxwgQNVgNaGd9L1aIW1QqJKwwO89/xnJnvqKKO6gIiVKDYrGe3tA==
X-Received: by 2002:a92:6b10:: with SMTP id g16mr16567750ilc.29.1589811771270;
        Mon, 18 May 2020 07:22:51 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l16sm3364985ils.64.2020.05.18.07.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:22:50 -0700 (PDT)
Received: (nullmailer pid 10442 invoked by uid 1000);
        Mon, 18 May 2020 14:22:49 -0000
Date:   Mon, 18 May 2020 08:22:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 6/7] dt-bindings: input: Add docs for ADC driven
 joystick.
Message-ID: <20200518142249.GA10125@bogus>
References: <20200517194904.34758-1-contact@artur-rojek.eu>
 <20200517194904.34758-6-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517194904.34758-6-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 21:49:03 +0200, Artur Rojek wrote:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
>  Changes:
> 
>  v2: - Add `reg` property to axis subnode in order to enumerate the axes,
>      - rename `linux,abs-code` property to `linux,code`,
>      - drop `linux,` prefix from the remaining properties of axis subnode
> 
>  v3: no change
> 
>  v4: - remove "bindings" from the unique identifier string,
>      - replace `|` with `>` for all description properties,
>      - specify the number of items for `io-channels`,
>      - correct the regex pattern of `axis` property,
>      - specify the value range of `reg` property for each axis,
>      - put `abs-range` properties under `allOf`
> 
>  v5: add `a-f` to the regex pattern of `axis` property
> 
>  v6-v7: no change
> 
>  .../bindings/input/adc-joystick.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/input/adc-joystick.example.dts:24.31-32 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml] Error 1
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1292230

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

