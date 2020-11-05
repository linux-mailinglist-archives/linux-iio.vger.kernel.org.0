Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E270C2A84B9
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKERTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 12:19:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34314 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKERTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2020 12:19:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id z26so2462508oid.1;
        Thu, 05 Nov 2020 09:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05L3sB3OfgwjfPRDm4XzH9qNouMEyPQgKMGeJaoAAxE=;
        b=YEzPiM90Zr32L1wcbVHRX+1sub0DQCVb15fgRjAluaci5vFCYQfEyQDQsY6H2XuHBI
         iRFAuBV+b+p3rYQilL5B5yS+rnxT1K9gjNSfZ1UZ2KPw1aXo6Zj2vumXB5E4zJ1tWjgy
         EE8pw55rJoTKSqcNZhA+kK3baEdB4JuWIy0r0ALdLEZn0w52hNUQWE2mg+pEc1cYdgMz
         HQBNw5kLwMYFDYUEh7pHlIwzj4k1cP7GH+O1HHh5GnhHkbvnN4PkNUDJz4f3QjcNiLb4
         xTMQ1OWwgQkMvrLYdXM0gh/r0OT4xlkbt0/uKxpzpiyEGbade6c5gWhS9dvIUNacr7fC
         lRqg==
X-Gm-Message-State: AOAM531/33f4mPoZQmiclvw9SiPU/M+RKq1esg5ksp2tY3E+x5Zb3Buy
        OcD0DbsJkh2czfH5oCD0Aw==
X-Google-Smtp-Source: ABdhPJz1LxIaYbQB7Z1S1g0MOIWHhGFF4OqmQxG+cWMMxAi7p7yzmfHtMXOns1fo/fb1L8At9GuAxA==
X-Received: by 2002:aca:5515:: with SMTP id j21mr281269oib.150.1604596782389;
        Thu, 05 Nov 2020 09:19:42 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d26sm199446ooh.19.2020.11.05.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:19:41 -0800 (PST)
Received: (nullmailer pid 1503059 invoked by uid 1000);
        Thu, 05 Nov 2020 17:19:40 -0000
Date:   Thu, 5 Nov 2020 11:19:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/5] dt-bindings:iio:adc:adi,ad7768-1: Add
 documentation for channel label
Message-ID: <20201105171940.GA1499984@bogus>
References: <20201102142000.68916-1-cristian.pop@analog.com>
 <20201102142000.68916-4-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102142000.68916-4-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 02, 2020 at 04:19:59PM +0200, Cristian Pop wrote:
> Optional attribute for better identification of the channels.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changes in v7:
>  - Add "additionalProperties: false" for channel child nodes.
>  - Fix "reg" spelling.
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)

Jonathan's common ADC schema should remove the need for some of this, 
but given it's v7:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index d3733ad8785a..6be43bf5c1e0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -29,6 +29,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    vref-supply:
>      description:
>        ADC reference voltage supply
> @@ -61,6 +67,24 @@ required:
>    - spi-cpha
>    - adi,sync-in-gpios
>  
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +
> +      label:
> +        description: |
> +          Unique name to identify which channel this is.
> +    required:
> +      - reg
> +    additionalProperties: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -84,6 +108,14 @@ examples:
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                label = "channel_0";
> +            };
>          };
>      };
>  ...
> -- 
> 2.17.1
> 
