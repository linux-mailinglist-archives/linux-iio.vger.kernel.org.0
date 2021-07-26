Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F040D3D68D3
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 23:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhGZVCI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 17:02:08 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:42556 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZVCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 17:02:07 -0400
Received: by mail-il1-f180.google.com with SMTP id q18so10336435ile.9;
        Mon, 26 Jul 2021 14:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=anWr1HrK+zhsWOcsM3iYd/e86jEwOIVQ/Q/u6zwut3c=;
        b=T82hJJFQ9EfceCA/T6spzMMpTBwfUAxKCIha1iUAcEe4sm6KVznoIB4BgSVDV5XPLG
         HbKz74PmfLEV6nzOxTLMZsjA1yXjlvFfrMEv7dXYsVCBjQLSK1meT1AkvogR6SAmMO2t
         Cm6QkPxuz2UEo1UOji2qWTWWFjiYR09PyN/65DJI3UgCTfC7dcW2rJieJmzxPpkvH3pj
         QY8OsmuhxCl+idmH3NyQK3i6aduDClgUikf6gZAIjT3MZ2ozSkHwc6IZRlmmxAzOMlOC
         ptXlZC+t84S54mql83Bz9z+Wxe0xrgLrkwaYLbTidPjWtPfWwhXM+OG6OaUsZgenlsJn
         OI3w==
X-Gm-Message-State: AOAM530mBkVcb7ztVHyfRJutTnH5dRa4DOcSXud39RfXMUkIMcnPAT+N
        hwhO4IsBAVDuUy6BXNAVsg==
X-Google-Smtp-Source: ABdhPJzmq+6HL67gil1Fu99ms6WhbBXahSPl1mItA0AY9EHFJJhhOiZDybOJxiqVoxw2T54qTRmDKQ==
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr14124201ilj.164.1627335755559;
        Mon, 26 Jul 2021 14:42:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b2sm531503iln.5.2021.07.26.14.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:42:34 -0700 (PDT)
Received: (nullmailer pid 914063 invoked by uid 1000);
        Mon, 26 Jul 2021 21:42:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20210726182850.14328-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210726182850.14328-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
Date:   Mon, 26 Jul 2021 15:42:30 -0600
Message-Id: <1627335750.959093.914062.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 19:28:48 +0100, Lad Prabhakar wrote:
> Add binding documentation for Renesas RZ/G2L A/D converter block.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dts:26.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1418: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1510163

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

