Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2464CCC0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiLNO47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 09:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbiLNO45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 09:56:57 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71042497F;
        Wed, 14 Dec 2022 06:56:55 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id v82so2794547oib.4;
        Wed, 14 Dec 2022 06:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQp+Pv+VnNqt0GnEv4In+p3V3Ugon2ooJmx0qU33ZRk=;
        b=fJwMrR5HJt2RmB1YJH/t7JCAME6UqjF/uiHimK1dbCx4bM6bW1Sh9Fzv56S2K5/bF3
         Hs/cb0BO+/wMxCoxGDAgfwZV7PjImfLX0SwkCeMkTrRe4KgmGJB31I3zZ+N2UKYy3IIw
         WznqqRY/EswdbnvtDxlaIzQQVuDGtSjy/MOUtbZCsGa6SYLuHj5HjObDnsmnPjTdL3BI
         h7XKzSojTZUMgThemJBml2KOa91YHDZMudWAqbMqCKhF/8ExCRD+KMSbXTjC+NthOAwx
         TxTY2WfewpJKNRtcWE3kcPgEo2tnC4Thv/fs587vgH2b+8a+QgvRcwUDGoVLN/XMRU0V
         6/vg==
X-Gm-Message-State: ANoB5pmMh9IaLiFyl6Na0eNbwvCGDhGfj7yfuzjxxeILqOEJffB4z7jG
        4cR/W/9ISU2Yzmlv+IFKYaUX0nEm4Q==
X-Google-Smtp-Source: AA0mqf7z8hKcvrlqNaLrxkNuSJUWSssJhZEijZM/veXnP0ZqiDrSolZQlVcEdXmEGO9b1Bj/+HjaBA==
X-Received: by 2002:a05:6808:b02:b0:35a:4c73:7ad1 with SMTP id s2-20020a0568080b0200b0035a4c737ad1mr10835722oij.5.1671029814930;
        Wed, 14 Dec 2022 06:56:54 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id e19-20020a4a91d3000000b004a09c4aceb6sm657913ooh.46.2022.12.14.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 06:56:54 -0800 (PST)
Received: (nullmailer pid 1045155 invoked by uid 1000);
        Wed, 14 Dec 2022 14:56:53 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-iio@vger.kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        jic23@kernel.org, robh+dt@kernel.org
In-Reply-To: <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
References: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
 <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
Message-Id: <167102966432.1040986.12796829521940941811.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX93 ADC
Date:   Wed, 14 Dec 2022 08:56:53 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Wed, 14 Dec 2022 21:35:38 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The IMX93 SoC has a new ADC IP, so add binding documentation
> for NXP IMX93 ADC.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.example.dtb: adc@44530000: '#io-channel-cells' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.example.dtb: adc@44530000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1671024939-29322-2-git-send-email-haibo.chen@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

