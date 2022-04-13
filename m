Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965144FFDF9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Apr 2022 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiDMSlH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Apr 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiDMSlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2022 14:41:07 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1565F241;
        Wed, 13 Apr 2022 11:38:45 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-d6ca46da48so2879588fac.12;
        Wed, 13 Apr 2022 11:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XE0LuRXhbOvzCbZ48CucOmOo4RYloaUhD24S7+cs9c=;
        b=SCL+QHwaGYTQdsgYqES7jtm//yibu7xp4EIHxECDXCiWVMnISX9TxJWttRXkCKxaTI
         CIRb2rX4hduo6+/oiCguSLbHeve033KzntKfQnhrLp6ZjfMmlYYMWLxYi0iTd1+0D9Hq
         OevgnjhBZG744vqlcMqi7/UJHzr0FaL+RCgtWypq55LrnRe7uRnQQIGCpNi3RvYeV0nN
         jS7syfhh4ZJSIAs1Yqke7/swgnDYSPaeV25J1NP11gc2htKsI80kv7/iLTcmMlO85gKU
         xt6IQFd66MmT8fENHQ3TLhbROC4/o4ipuo1RfJMTtG/AFYR3MJWvSBpEA1QS+ASPu8uF
         DaKA==
X-Gm-Message-State: AOAM531GZ/2W3ZFrqdC7QRWoqR0ZMpz5NMN5Ge/V5NHU4eVjvmjsXAU0
        vSrNq97qs09L3UAdaAB/WA==
X-Google-Smtp-Source: ABdhPJxe6R3tfDj53W7g+BEn/HAdgL54WG1tAWd27g09KrpCzZbryWBMuy55bSxgbhp0/gThFGphQQ==
X-Received: by 2002:a05:6870:8a29:b0:e2:ffb9:f52d with SMTP id p41-20020a0568708a2900b000e2ffb9f52dmr26568oaq.205.1649875124603;
        Wed, 13 Apr 2022 11:38:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gu14-20020a056870ab0e00b000e2d96cebe5sm3355192oab.48.2022.04.13.11.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:38:44 -0700 (PDT)
Received: (nullmailer pid 3616565 invoked by uid 1000);
        Wed, 13 Apr 2022 18:38:43 -0000
Date:   Wed, 13 Apr 2022 13:38:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     jic23@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: sx9360: Add precharge resistor
 setting
Message-ID: <YlcYswjsb6dn1a6M@robh.at.kernel.org>
References: <20220406165011.10202-1-gwendal@chromium.org>
 <20220406165011.10202-8-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406165011.10202-8-gwendal@chromium.org>
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

On Wed, Apr 06, 2022 at 09:50:10AM -0700, Gwendal Grignou wrote:
> Allow configure the resistance used during precharge.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v3:
> - Fix maximum field. Check make dt_binding_check passes.
> 
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
> index 63e1a1fd00d4c..20c2759ced436 100644
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

You can have 'multipleOf: 2000' as a constraint.

> +    minimum: 0
> +    maximum: 30000
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
> 2.35.1.1094.g7c7d902a7c-goog
> 
> 
