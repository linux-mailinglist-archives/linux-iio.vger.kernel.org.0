Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B873CD607
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbhGSNG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 09:06:59 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:46874 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbhGSNG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 09:06:59 -0400
Received: by mail-io1-f52.google.com with SMTP id p186so19973899iod.13;
        Mon, 19 Jul 2021 06:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oFd3MlNUQRlX4N33x8e/4VBraKu1g4Ilixv0NOLhWz0=;
        b=tWUKd6xysrGDBy2dKII1YaVf29RmEOJb53e/cUw/mGfcwHdx+4ueF6Z2t/alz4l/mO
         nSxO66EH+cQa1tLXFUXzcaT83fgnctA9pqZQhQmQbnUEiSGzpTWpqbfp2MmSwlAzB+Xj
         F9d9BiZ607cDGdqE9hL3RLpwM52SZGz6gVDvLvLFs5yFGcymEU5r24h+rkqRLH6EWvhK
         pI+UbQPsHWWeMoZKFc7f7q7fDp9/C65dubuDyWtfGwirp9cyvXc5dhUWPSmAZWosNSB5
         Kde+zlPgP1xZlpb0Ro0yQM96W4HYq6do9vShD+c3sh7rEelRnfM6yX9xDKHAFyDz8Sva
         Gjpw==
X-Gm-Message-State: AOAM530hcJW1fDQOkNRHM5uWgQaknvy6A7iFw3kP6zB2IuHK0YIreAWd
        sWDMFyiKkUTOFFPWo0sJiw==
X-Google-Smtp-Source: ABdhPJzPtqUoDpGjzuH0PNyDyTfPsZwsMzRCiGIw7vDzjRgE9t1FpcLTpQP+rirn7ZBjJymyYAfRgg==
X-Received: by 2002:a5d:87d0:: with SMTP id q16mr19030655ios.109.1626702458777;
        Mon, 19 Jul 2021 06:47:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l9sm1974883ilv.31.2021.07.19.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:47:38 -0700 (PDT)
Received: (nullmailer pid 1811206 invoked by uid 1000);
        Mon, 19 Jul 2021 13:47:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
In-Reply-To: <20210719085840.21842-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210719085840.21842-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210719085840.21842-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
Date:   Mon, 19 Jul 2021 07:47:28 -0600
Message-Id: <1626702448.448880.1811205.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Jul 2021 09:58:37 +0100, Lad Prabhakar wrote:
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

See https://patchwork.ozlabs.org/patch/1506856

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

