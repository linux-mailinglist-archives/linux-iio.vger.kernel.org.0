Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21193B92A2
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhGAOF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 10:05:26 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:36616 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhGAOFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 10:05:25 -0400
Received: by mail-io1-f51.google.com with SMTP id u7so5467118ion.3;
        Thu, 01 Jul 2021 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=mYpWVNkGyyi4+D5Ik3YO8omc3O/tZSWPuO0UlaNpdPE=;
        b=fAyOVUOcDZSHW58wbxWqW4TAvfLBRU1bsMUNfnY0MSfezl5MchfUJDGivQZnKuVZ1F
         KitXSDgjX9siYDAEbS7dVfLq5FBKO0t3/nVlKqTg4dypm5+qc2HZ4773O+Q2fR3T1KyA
         2vq6Nvh2rcpOZqN72dcQyT7xdC/Au2KJ8U4XBBwQ/eefMYD4IajNyGwb7lQutfC0A4Ml
         n0v8OqeBR+RrEn9xlqaP7/mAqE9Jf8YQ1NmJ0DHDra4LJsmUFi9N2elsboSHfnEFKlku
         QZJRacqtwKLxPffOeCUFI1lAvfEGeNlq98vzn+R9TW4q6iE3yTdMlpeDiRlQpjqQnrpD
         l/XA==
X-Gm-Message-State: AOAM532DMQohQZVFricciUpOwNLlBqjJc8DnoscA1zPUr5TPevWuUkXU
        v5Vj/HHuULfeRfg7bEzsCw==
X-Google-Smtp-Source: ABdhPJxvLXDtYCaeHE5BU26+kYkT3YksThGWXzGZkcTWU32ai4Ma0FLwraS4S2gZj5vctoN26xJltA==
X-Received: by 2002:a05:6602:1846:: with SMTP id d6mr12160079ioi.111.1625148175051;
        Thu, 01 Jul 2021 07:02:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m12sm32206iln.43.2021.07.01.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:02:54 -0700 (PDT)
Received: (nullmailer pid 2278702 invoked by uid 1000);
        Thu, 01 Jul 2021 14:02:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
Date:   Thu, 01 Jul 2021 08:02:43 -0600
Message-Id: <1625148163.546497.2278701.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Jun 2021 23:03:27 +0100, Lad Prabhakar wrote:
> Add binding documentation for Renesas RZ/G2L A/D converter block.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dts:19:18: fatal error: dt-bindings/clock/r9a07g044-cpg.h: No such file or directory
   19 |         #include <dt-bindings/clock/r9a07g044-cpg.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1498675

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

