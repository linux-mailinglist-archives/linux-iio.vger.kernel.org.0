Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B83F34C4
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhHTTqx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:46:53 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33532 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhHTTqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:46:53 -0400
Received: by mail-ot1-f51.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so16463286oti.0;
        Fri, 20 Aug 2021 12:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dPjBhc5PoJzOzyxmfR83kp4COKv5CtNRdj8GGDoPG0w=;
        b=B9wUjPc8pDagJ6vD+BYM/wx8vb71Orc7WAp+id0dvi2FSmdZYaClQ6KReMAGv0b573
         trxpR4knT/Hzg+g8OIsvKz5r1ylgD1S+4Y5iCOnqs7Z58QSL6L53NPBSR115zMyhx/Yo
         gYyA4jBALzeFy1ePh7I2zegKzYVxPIrfuqM9eT6f4pVnmPP8qSgGudKVEtMikLDKMTse
         h4hW81nJSUV386POU0AxsJsAQAsPXhwcTldaFUJLux+g8sNNRn/sGzI4BlWBtQfVfHL4
         +hGDbt6SVv4NPZmNB/lbdFANfJKE76S1tdDjLQqGk3xfAeKNB3uC+6ys1gJVsltMn6vf
         K35Q==
X-Gm-Message-State: AOAM531XP9ieryGLi17t9Zeo8z97leDDjMrJa6WeQ4NUG/LQg9pGTAWF
        DGRshzFZEkviRMUzo4cxuQ==
X-Google-Smtp-Source: ABdhPJy1ep63eo2x2TXkk8cP+Qx29c5ITXWsNLBeI01BjukKpkifq0B0JARsDRR/S50XsJ+zpemxkA==
X-Received: by 2002:a9d:6310:: with SMTP id q16mr18716544otk.203.1629488774479;
        Fri, 20 Aug 2021 12:46:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p2sm1616085oip.35.2021.08.20.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:46:13 -0700 (PDT)
Received: (nullmailer pid 3663911 invoked by uid 1000);
        Fri, 20 Aug 2021 19:46:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20210820133821.159239-2-jacopo@jmondi.org>
References: <20210820133821.159239-1-jacopo@jmondi.org> <20210820133821.159239-2-jacopo@jmondi.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
Date:   Fri, 20 Aug 2021 14:46:12 -0500
Message-Id: <1629488772.355778.3663899.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Aug 2021 15:38:19 +0200, Jacopo Mondi wrote:
> Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
> v1->v2:
> - Add maxItems to -gpios properties as suggested by Rob
> - Add a label to the device node in the example as suggested by Rob
> 
> ---
>  .../iio/chemical/senseair,sunrise.yaml        | 53 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.example.dts:23.21-22 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1519042

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

