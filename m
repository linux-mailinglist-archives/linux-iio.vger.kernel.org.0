Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4C65270F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 20:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiLTTcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 14:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiLTTbn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 14:31:43 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9778BE29;
        Tue, 20 Dec 2022 11:30:49 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r130so11466206oih.2;
        Tue, 20 Dec 2022 11:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjPWJdrfuOFUB0CxhY2KgzX/9aMI9KNfJtBkyKPTgBY=;
        b=qcw2rTWZZpOrRu22A9A4I14nTcqZUUQyBFUq8MWTysogNgdAHfGnSe0PJW43WVpCnQ
         YHyWTd9HYD9gjf71csL/omMhd1z577lsBLylJISTVDjojkwp/aFXARE/FIPvrKoUCFno
         Jl2fYrDXRWcPOm+CfGYAI/Wr+0M/qw2HZ1Zk3Te0zAic3E0OW+z+PjNQsPf6XasvITai
         to5x0bMzbH3SjjvcbZY8fjqOUSeHsGs2TklFjUBukSCgvjGqnfIbJ86ZBnAmwGX42lie
         sftUjhz+gO2LbjRGv39/dM6kvtE6kCutfChdq+2FVVRtFZSq2QgmteYqHrL+W/1U4jGZ
         7O1w==
X-Gm-Message-State: ANoB5pn2qEwSVClZ2lA1cmkKo3BY38/UXDTh0y/F+bdeGLQP6huHKFQ2
        dJs4/4BARfAqCVHv9vnVky6XNjkfcw==
X-Google-Smtp-Source: AA0mqf6huOkGLq+cZrYjEX9nrpp2rVd1Ik6MMGx1iXDY4GY8xpjiRL2Mon+jx0pcCkOHhJlSPEf6oQ==
X-Received: by 2002:aca:1a1a:0:b0:35e:bc27:de53 with SMTP id a26-20020aca1a1a000000b0035ebc27de53mr12061752oia.17.1671564648964;
        Tue, 20 Dec 2022 11:30:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l22-20020a056808021600b0035c4ec78d0esm5826162oie.47.2022.12.20.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:30:48 -0800 (PST)
Received: (nullmailer pid 951382 invoked by uid 1000);
        Tue, 20 Dec 2022 19:30:47 -0000
Date:   Tue, 20 Dec 2022 13:30:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     jic23@kernel.org, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX93 ADC
Message-ID: <20221220193047.GA946657-robh@kernel.org>
References: <20221219101336.3929570-1-haibo.chen@nxp.com>
 <20221219101336.3929570-3-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219101336.3929570-3-haibo.chen@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 19, 2022 at 06:13:35PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>

For the subject, no need to say 'binding documentation' twice:

dt-bindings: iio: adc: Add NXP IMX93 ADC

> 
> The IMX93 SoC has a new ADC IP, so add binding documentation
> for NXP IMX93 ADC.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
