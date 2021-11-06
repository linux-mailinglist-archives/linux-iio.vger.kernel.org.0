Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C70446B91
	for <lists+linux-iio@lfdr.de>; Sat,  6 Nov 2021 01:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKFA1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 20:27:11 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43802 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKFA1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 20:27:11 -0400
Received: by mail-ot1-f46.google.com with SMTP id i16-20020a9d68d0000000b0055c630be045so4792940oto.10;
        Fri, 05 Nov 2021 17:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PHkUHNRSgGKJJ5x9Czw+f8F7S8eqegCyS+KNmMqDioo=;
        b=uVjHedOK5PqfV0i/5qKSVyxyHXSydvmGz1RfIQgpI5Alj5om76mC63mkPE2RI1Q+N4
         ZIPVgjIEzmp8OnupG4UVsDk8khGEotjXZ5Vz+b/bqX3qn+Bi8P6ulCesljxjrBBCNLfb
         y13hPfsXAKB6J5L0Y3nW8EyvgbotV3DO6LOWKtPHRk+VtY8HWkrWi/2dtuql8oUkboVk
         /hQVYmtrAAAq2KuZcVhQkpRCudJxr65LJyHL71JiHvqAOXZdu7NEeuiIqkuBAbWorool
         Z1sam3+UatuMVPYHDzb5zA2vXpy0hA1lqTitSGyNF6lWRNVOyJNeM5HGAU18BgUgLTzB
         xC4Q==
X-Gm-Message-State: AOAM533GgGJ2jnEQcscBs5uJzUMnDe+237X7yDtJEl40gqEkFmnd/13u
        h6j9YcHcmPuEX3IWKckl6Q==
X-Google-Smtp-Source: ABdhPJzEpM2oE758JPy/Vs1YwXoKf/P2GJ3dymT26SjQaUm9cxMcWji+fZiLc4GiOkNPvVWdzbIRag==
X-Received: by 2002:a9d:850:: with SMTP id 74mr17617558oty.349.1636158270293;
        Fri, 05 Nov 2021 17:24:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p12sm1491083otp.79.2021.11.05.17.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 17:24:29 -0700 (PDT)
Received: (nullmailer pid 2112791 invoked by uid 1000);
        Sat, 06 Nov 2021 00:24:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        cosmin.tanislav@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org
In-Reply-To: <20211105143550.1783528-3-demonsingur@gmail.com>
References: <20211105143550.1783528-1-demonsingur@gmail.com> <20211105143550.1783528-3-demonsingur@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: add AD74413R
Date:   Fri, 05 Nov 2021 19:24:28 -0500
Message-Id: <1636158268.701301.2112790.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 05 Nov 2021 16:35:49 +0200, Cosmin Tanislav wrote:
> Add device tree bindings for AD74413R.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/addac/adi,ad74413r.yaml      | 153 ++++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: properties:adi,rsense-resistance-ohms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: ignoring, error in schema: properties: adi,rsense-resistance-ohms
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
Error: Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dts:23.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1551417

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

