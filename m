Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1774EB6D8
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiC2XiT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Mar 2022 19:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2XiT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2022 19:38:19 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD26F255AA;
        Tue, 29 Mar 2022 16:36:34 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-de48295467so20465746fac.2;
        Tue, 29 Mar 2022 16:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHUZAMSZIWqvsr2Epvahq61OIGQQvk3dBinGkbW7F0g=;
        b=vYfKBCDhPwGL55KHG8b/hyGzlK8MezNPierT9x/ZTiN1tjW/9szoUZ90oCxv4B8mKf
         7yQetPeB1nKCKdEuaJkMj0KlwvFbaO78YxLJPDRY82zW7Le4QgrrqqNUcjY6qx/fZTLi
         ez+FrSnasyP4piGtnolBkKQ7s3hRLr0okjhyTysHZJv+mO2M8z9CkuAIywZZyuIU4l2l
         iOwW6rQaYkZ+EJbRJ7VVU5Qh9so/OueTzz8W63ghcG7vJDMZPnIPlFXytxhz8OcOczse
         MxfMwfPN9BWcf3H+8ly187wfvHICkIgG+4TC2JGNkUZL0lMrZP7bEIv/N48MyOPNvY9W
         figg==
X-Gm-Message-State: AOAM533dV/IXsAVIuk0N9HKdlYiibvsjA7NN5X/zbaMEPHdoYPWdRMfA
        nWNcuTOmSfr90IseNFxeOw==
X-Google-Smtp-Source: ABdhPJwjI/tjEIXvYOjvxFUykjnLqtmnNJLL2LeSbHqFBLi4uUfwQpNzCZn+pVYaCeYTDFc4qeUMyw==
X-Received: by 2002:a05:6870:7393:b0:dd:9a31:96d1 with SMTP id z19-20020a056870739300b000dd9a3196d1mr895445oam.98.1648596994006;
        Tue, 29 Mar 2022 16:36:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 96-20020a9d0469000000b005c959dd643csm9251036otc.3.2022.03.29.16.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:36:33 -0700 (PDT)
Received: (nullmailer pid 1570101 invoked by uid 1000);
        Tue, 29 Mar 2022 23:36:32 -0000
Date:   Tue, 29 Mar 2022 18:36:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     jic23@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: sx9360: Add precharge resistor
 setting
Message-ID: <YkOYAIyI6gs9VbN4@robh.at.kernel.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
 <20220325220827.3719273-8-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325220827.3719273-8-gwendal@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 25, 2022 at 03:08:26PM -0700, Gwendal Grignou wrote:
> Allow configure the resistance used during precharge.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v2:
> - Change kOhms into ohms.
> 
> Changes since v1:
> - Suffix property with kOhms.
> 
>  .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> index 63e1a1fd00d4c..453d2f02abbb1 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> @@ -61,6 +61,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>  
> +  semtech,input-precharge-resistor-ohms:
> +    default: 0
> +    description:
> +      Pre-charge input resistance in Ohm.
> +      Rounded down to a 2000 Ohm multiple.
> +    minimum: 0
> +    maximum: 30

This should give you a failure.

> +
>  required:
>    - compatible
>    - reg
> @@ -85,5 +93,6 @@ examples:
>          semtech,resolution = <256>;
>          semtech,proxraw-strength = <2>;
>          semtech,avg-pos-strength = <64>;
> +        semtech,input-precharge-resistor-ohms = <4000>;
>        };
>      };
> -- 
> 2.35.1.1021.g381101b075-goog
> 
> 
