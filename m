Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A8B680F17
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 14:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjA3Nfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 08:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjA3Nfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 08:35:30 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5862BF06;
        Mon, 30 Jan 2023 05:35:28 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15fe106c7c7so14964164fac.8;
        Mon, 30 Jan 2023 05:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yW1F2ZtOSql4vg9q0uHRntIKkM3hR0q/EPWnsBFUEF0=;
        b=h2TKUWIy+R8+2o5dsl4VDx0cQw0Pcxo91f1oswcs+63v/6SCn/dl8t6mOWNDEpwX0l
         SsMyLkWVqNnL9jfhrAh1+VT5mIBLN6k0/SX+RBtqu4TfrDRlqFtiHjvypB8cARjRuOe0
         9uw5xPKIe1a6PCZHRYaH99x8E7UFlw+DU4J2THWnh+o0B/cr3OL3eBYg7rPAK35/9mWg
         SKnpHxfToYs4EXx/lHWjpcIaJXNu9WxFhfIlZzk8qhPoTt/pPitco/8f2F3Y9hrp+7PT
         Xkt10mZk62g75iWOSF/I2Rb0qCiwIL9HWTFLqw+oyJtUI9T2kqJN/rBTNT/Fovsq4emW
         6KiA==
X-Gm-Message-State: AO0yUKXxDUyktzVwFxMeSs9v9VLF/nBqtkgFXTHKvOC7KMB3Cwm44wKM
        qvF9kcZSj56+oy+Ul/Cshw==
X-Google-Smtp-Source: AK7set/1+Yj/1oPdUjZXvgxQIVECoP0Lvo7TQLrQT4HEP3Hg7SMikxwQEwBCNLSjpSjimTeU7uK12w==
X-Received: by 2002:a05:6870:e99a:b0:163:d245:5553 with SMTP id r26-20020a056870e99a00b00163d2455553mr276951oao.28.1675085728110;
        Mon, 30 Jan 2023 05:35:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w17-20020a056870e2d100b00144e6ffe9e5sm5187735oad.47.2023.01.30.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:35:27 -0800 (PST)
Received: (nullmailer pid 2302816 invoked by uid 1000);
        Mon, 30 Jan 2023 13:35:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20230129155602.740743-13-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
 <20230129155602.740743-13-jic23@kernel.org>
Message-Id: <167502679603.787347.16663590794832817182.robh@kernel.org>
Subject: Re: [PATCH v2 12/12] dt-bindings: iio: accel: Add ADIS16203 Inclinometer
Date:   Mon, 30 Jan 2023 07:35:26 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Sun, 29 Jan 2023 15:56:02 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There has been a driver in staging for quite a while.
> Given we are now moving it to the main tree, time to make sure it
> has binding documentation.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> V2:
> - maxItems/minItems added where needed.
> - fix interrupt-names to allow multiple entries.
> ---
>  .../bindings/iio/accel/adi,adis16203.yaml     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16203.example.dtb: accelerometer@0: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230129155602.740743-13-jic23@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

