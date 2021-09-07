Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B4402801
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbhIGLuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Sep 2021 07:50:17 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43924 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhIGLuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Sep 2021 07:50:15 -0400
Received: by mail-oi1-f170.google.com with SMTP id w19so12378725oik.10;
        Tue, 07 Sep 2021 04:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YXDFfDqAdMrMh9/PRAPi/Ueq/DRk2vA8+5/R9I9UfFI=;
        b=iBPnoi/NoCbRzgfFp4QbBkW5gtgcUlR6AyINnNVOV8lCOGKwfsGJEwrLdQDNXYIG7F
         ltSGjyNgM4L0IAp3/d5up1/mJfZ1nVY2MQzIxwa096adRVSU8j1jgY+KR4ytaRKW+RoN
         nsoYiMIIJdHxbg/acPJwIJj9FuRs++U04xP1vLfO/FglxPhE7WA0aE+TJQAF70o+mPyV
         KkSe9Y37aFjyygC2Bm5PyTzyQp+ckEv6L1QgOS93jxxxvF4Ths2L3V//eKuxtkIvRuBu
         vTXnOZB+AxBvvDijgzhugD8JPhAyqbQmptd6xu9dVXryULhEHlFVhSTMFIRi5z6/tE7K
         G8EA==
X-Gm-Message-State: AOAM530Ghwb5OYyvRiNRL3LTXid5rUpg3Qvv3wdmSC9IO8Fuql+KnCdm
        dXSiM0CCUqdnRef3dYwjQw==
X-Google-Smtp-Source: ABdhPJxmI/NxJg96KtKH8oQkT0Y05vgErbp7q7fkN8CHIrfJK9I/w/eUsJcWwOLgxpfWiS7SSJhIVw==
X-Received: by 2002:aca:c48d:: with SMTP id u135mr2665147oif.106.1631015349336;
        Tue, 07 Sep 2021 04:49:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z7sm2370656oti.65.2021.09.07.04.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:49:08 -0700 (PDT)
Received: (nullmailer pid 3599963 invoked by uid 1000);
        Tue, 07 Sep 2021 11:49:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210907015724.1377-3-caihuoqing@baidu.com>
References: <20210907015724.1377-1-caihuoqing@baidu.com> <20210907015724.1377-3-caihuoqing@baidu.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add the binding documentation for NXP IMX8QXP ADC
Date:   Tue, 07 Sep 2021 06:49:05 -0500
Message-Id: <1631015345.821868.3599962.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 07 Sep 2021 09:57:22 +0800, Cai Huoqing wrote:
> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the binding
> documentation for NXP IMX8QXP ADC.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: *Fix some indentation issues.
>         *Mark status as okay.
>         *Change clock2 source.
> v1 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-5-caihuoqing@baidu.com/
> 
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dt.yaml: soc: adc@5a880000:reg:0: [0, 1518862336, 0, 65536] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dt.yaml: adc@5a880000: 'interrupts-parent' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dt.yaml: adc@5a880000: 'state' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dt.yaml: adc@5a880000: '#address-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dt.yaml: adc@5a880000: '#size-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.example.dt.yaml: adc@5a880000: 'assigned-clock-rates' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1525098

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

