Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD14299B4
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhJKXPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 19:15:49 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42877 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhJKXPs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 19:15:48 -0400
Received: by mail-ot1-f46.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso23560443otu.9;
        Mon, 11 Oct 2021 16:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7zuoS5ImJfku8d8xCEMyvxbsSp1wfRVxODVvjTNPpWI=;
        b=amsw0I40qmeKasNEjfYH2Jd4dK2wBuvNBUVvnolS+jQRmzD6fAMsKFaDwVx1G6Dh35
         3knGgQUQoJq+RPbioGihQzCSqF5oiFAf7FB62v122N9WLIQRppUHioW8pDAvvDBT//yq
         NF0sESjjmW7e4anLcOCyazbM3wd3rHY8AjaIq8SqjZgJchBPct7+xptY80wakF7xC2d5
         nr7jYET6ZdFzA4D1BUG69J4HQm5WClfpdSp5ifFT6gGbuRxz2uHdVVSxH7lZUCxnr/0q
         O8gp4T1lRtNG4EwdVr3O3NCxL7czJieyWYjtbYqgr19EdolOPR89jKzg6Ao6EzSuqelA
         XHRg==
X-Gm-Message-State: AOAM533zqOlNXUU1b1h9M9bf66Z+woWXfbuLhjkMP6DjnUANESDgvD/K
        3VxDMZPLTeJznPtyReohAgaB4Kat9w==
X-Google-Smtp-Source: ABdhPJwgjqa80alYqxnGTfd3HMgT9XwEeOu7Wz9fbyC7hQnvyMYxKzqnL/RZNXXaNYHYTgIuXCirxw==
X-Received: by 2002:a9d:7114:: with SMTP id n20mr14348496otj.25.1633994026820;
        Mon, 11 Oct 2021 16:13:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r4sm2049640oiw.36.2021.10.11.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 16:13:45 -0700 (PDT)
Received: (nullmailer pid 1347640 invoked by uid 1000);
        Mon, 11 Oct 2021 23:13:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211011155717.1594-2-olivier.moysan@foss.st.com>
References: <20211011155717.1594-1-olivier.moysan@foss.st.com> <20211011155717.1594-2-olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: stm32-adc: add generic channel binding
Date:   Mon, 11 Oct 2021 18:13:43 -0500
Message-Id: <1633994023.340533.1347639.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Oct 2021 17:57:11 +0200, Olivier Moysan wrote:
> Add ADC generic channel binding. This binding should
> be used as an alternate to legacy channel properties
> whenever possible.
> ADC generic channel binding allows to identify supported
> internal channels through the following reserved label names:
> "vddcore", "vrefint" and "vbat".
> This binding also allows to set a different sampling time
> for each channel.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
>  1 file changed, 93 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.example.dt.yaml: adc@48003000: adc@100:channel@13: 'st,min-sample-time-nsecs' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.example.dt.yaml: adc@48003000: adc@100:channel@14: 'st,min-sample-time-nsecs' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.example.dt.yaml: adc@48003000: adc@100:channel@15: 'st,min-sample-time-nsecs' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1539385

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

