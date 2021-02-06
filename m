Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42ED311E69
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 16:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBFP1a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 10:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhBFP12 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 10:27:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B675D64E7D;
        Sat,  6 Feb 2021 15:26:46 +0000 (UTC)
Date:   Sat, 6 Feb 2021 15:26:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ad7124: add config nodes
Message-ID: <20210206152643.53b0e01b@archlinux>
In-Reply-To: <20210204113551.68744-3-alexandru.tachici@analog.com>
References: <20210204113551.68744-1-alexandru.tachici@analog.com>
        <20210204113551.68744-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Feb 2021 13:35:51 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Document use of configurations in device-tree bindings.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Ignoring discussing in my reply to the cover letter...

This is a breaking change as described.  We can't move properties
around without some sort of fullback for them being in the old
location.

> ---
>  .../bindings/iio/adc/adi,ad7124.yaml          | 72 +++++++++++++++----
>  1 file changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index fb3d0dae9bae..330064461d0a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -62,20 +62,19 @@ required:
>    - interrupts
>  
>  patternProperties:
> -  "^channel@([0-9]|1[0-5])$":
> -    $ref: "adc.yaml"
> +  "^config@(2[0-7])$":
>      type: object
>      description: |
> -      Represents the external channels which are connected to the ADC.
> +      Represents a channel configuration.
> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.

adc.yaml now.


>  
>      properties:
>        reg:
>          description: |
> -          The channel number. It can have up to 8 channels on ad7124-4
> -          and 16 channels on ad7124-8, numbered from 0 to 15.
> +          The config number. It can have up to 8 configuration.
>          items:
> -          minimum: 0
> -          maximum: 15
> +         minimum: 20
> +         maximum: 27

Number then 0-7 please rather than 20-27.

>  
>        adi,reference-select:
>          description: |
> @@ -88,8 +87,6 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          enum: [0, 1, 3]
>  
> -      diff-channels: true
> -
>        bipolar: true
>  
>        adi,buffered-positive:
> @@ -100,6 +97,35 @@ patternProperties:
>          description: Enable buffered mode for negative input.
>          type: boolean
>  
> +    additionalProperties: false
> +
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 8 channels on ad7124-4
> +          and 16 channels on ad7124-8, numbered from 0 to 15.
> +        items:
> +         minimum: 0
> +         maximum: 15
> +
> +      diff-channels: true
> +
> +      adi,configuration:
> +        description: |
> +          The devices has 8 configuration and ad7124-8 support up to 16 unipolar channels.
> +          Each channel can be assigned one configuration. Some channels will be sharing the
> +          same configuration.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 20
> +        maximum: 27
> +
>      required:
>        - reg
>        - diff-channels
> @@ -127,30 +153,46 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        channel@0 {
> -          reg = <0>;
> -          diff-channels = <0 1>;
> +        config@20 {
> +          reg = <20>;
>            adi,reference-select = <0>;
>            adi,buffered-positive;
>          };
>  
> -        channel@1 {
> -          reg = <1>;
> +        config@21 {
> +          reg = <21>;
>            bipolar;
> -          diff-channels = <2 3>;
>            adi,reference-select = <0>;
>            adi,buffered-positive;
>            adi,buffered-negative;
>          };
>  
> +        config@22 {
> +          reg = <22>;
> +        };
> +
> +        channel@0 {
> +          reg = <0>;
> +          diff-channels = <0 1>;
> +          adi,configuration = <20>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +          diff-channels = <2 3>;
> +          adi,configuration = <21>;
> +        };
> +
>          channel@2 {
>            reg = <2>;
>            diff-channels = <4 5>;
> +          adi,configuration = <22>;
>          };
>  
>          channel@3 {
>            reg = <3>;
>            diff-channels = <6 7>;
> +          adi,configuration = <22>;
>          };
>        };
>      };

