Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523928521E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgJFTLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 15:11:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38750 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTLZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 15:11:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12so7521949ota.5;
        Tue, 06 Oct 2020 12:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OvNlaT40rJ1ZkJccfnwhJyelYaQf4zWxeFB+I7NWAsg=;
        b=Tfri8HNVeGfgor0Ka2wqN2NUXInhC+VemFgxnZRxz3u8ssE2MSaqAiZxTSdX92FMNp
         PeOk+LLyX1GtJDwUmqS69u/S5WOcEz+1lLhUs1qISG7AuAw3b1qcQHfq3FgRfE0rOfE0
         3DD+4/fNudzuRjuJQUl6g1/38Nzn9F8ImNA0hTq1e519McNo3YkfFPfykkmeIUjaAMND
         rR+IzqdSuzNLGOkXEeJ8iLRSq/H2tqD4pwn1daJDtItxKN4FEN1Tt1wYwNidwShwq5RW
         ogQRPp5rBbbxWtp8g9VR0IqzUDJYJoG05oc1KDKrgBDsz703N1eswET/rwg4g9X91bo8
         UuXg==
X-Gm-Message-State: AOAM5327A/oQjUsK1hqW5jgJ88QRQ78j9jCasToiCfFLVl5ZC2axx2sF
        dEgaJ4oFcLIgzDFKpmMbqw==
X-Google-Smtp-Source: ABdhPJz+fypRuGzjWW6ctLyXwfesy8InnT6iydTy++bYMZcUpUkQfYe527n9h3a4xce9Xd+xlbQXAg==
X-Received: by 2002:a05:6830:168f:: with SMTP id k15mr3740467otr.64.1602011483381;
        Tue, 06 Oct 2020 12:11:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm676541otj.61.2020.10.06.12.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:11:22 -0700 (PDT)
Received: (nullmailer pid 2658613 invoked by uid 1000);
        Tue, 06 Oct 2020 19:11:21 -0000
Date:   Tue, 6 Oct 2020 14:11:21 -0500
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
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: sx9310: Add various settings as
 DT properties
Message-ID: <20201006191121.GA2653627@bogus>
References: <20200930075728.2410327-1-swboyd@chromium.org>
 <20200930075728.2410327-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930075728.2410327-6-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 30, 2020 at 12:57:27AM -0700, Stephen Boyd wrote:
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
>  .../iio/proximity/semtech,sx9310.yaml         | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> index 5739074d3592..a85b8fa25861 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -40,6 +40,61 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  semtech,cs0-ground:
> +    description: Indicates the CS0 sensor is connected to ground.
> +    type: boolean
> +
> +  semtech,combined-sensors:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      List of which sensors are combined and represented by CS3.
> +      Possible values are -
> +      3        - CS3 (internal)
> +      0 1      - CS0 + CS1
> +      1 2      - CS1 + CS2 (default)
> +      0 1 2 3  - CS0 + CS1 + CS2 + CS3

       items:
         enum: [ 0, 1, 2, 3 ]

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    minItems: 1
> +    maxItems: 4
> +
> +  semtech,resolution:
> +    description:
> +      Capacitance measure resolution. Refer to datasheet for more details.
> +    enum:
> +      - coarsest
> +      - very-coarse
> +      - coarse
> +      - medium-coarse
> +      - medium
> +      - fine
> +      - very-fine
> +      - finest
> +
> +  semtech,startup-sensor:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +    description:
> +      Sensor used for start-up proximity detection. The combined
> +      sensor is represented by the value 3. This is used for initial
> +      compensation.
> +
> +  semtech,proxraw-strength:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [0, 2, 4, 8]
> +    default: 2
> +    description:
> +      PROXRAW filter strength. A value of 0 represents off, and other values
> +      represent 1-1/N.
> +
> +  semtech,avg-pos-strength:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> +    default: 16
> +    description:
> +      Average positive filter strength. A value of 0 represents off and
> +      UINT_MAX (4294967295) represents infinite. Other values
> +      represent 1-1/N.
> +
>  required:
>    - compatible
>    - reg
> @@ -61,5 +116,11 @@ examples:
>          vdd-supply = <&pp3300_a>;
>          svdd-supply = <&pp1800_prox>;
>          #io-channel-cells = <1>;
> +        semtech,cs0-ground;
> +        semtech,combined-sensors = <1 2 3>;
> +        semtech,resolution = "fine";
> +        semtech,startup-sensor = <1>;
> +        semtech,proxraw-strength = <2>;
> +        semtech,avg-pos-strength = <64>;
>        };
>      };
> -- 
> Sent by a computer, using git, on the internet
> 
