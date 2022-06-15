Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC154BF3A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 03:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiFOB21 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 21:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFOB21 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 21:28:27 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12482CE07;
        Tue, 14 Jun 2022 18:28:25 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id q11so11202584iod.8;
        Tue, 14 Jun 2022 18:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=suAYcRsiFSTodJkKkMZwNSVlbn0Z7Celw9TQj2rqfTk=;
        b=Ykg8MzBnSwtI7prchez0bfErHDzfWIqArxqJaX0qyFEHLcQTVQOmRzEtL3s4dktBGg
         PEs0yBbGvIcC6V2h4r2MK1gP9ryGrAgkr7qVb384qcJT8vGYQdp3c/mrdzBO2kmA+noN
         AfyfvZQ0iUdMgjzH8nEYkLMljMtPIzq0d1JOOy0mUjBQZ0KXP0yn//eVxDTbbPNsEqsw
         1YRny99CMDsMvpARuXpiJfIz827KefOwhx1EvKiiZ/SskfWxf7SM23NJNUiHPO0X2lvK
         1eim6uR2cgrCDp9g7/T0Mw54zkda7+mtMGXZavWl9xSYMzBlbzFYMAeOwPFC6HTNBtlE
         c/ug==
X-Gm-Message-State: AOAM531s9bkiCJvom6+13y6z59GoV4b4CG6XQD6WuzML8nHHi9q6JWph
        +JE3Xz4R7aBogFez0FAlAA==
X-Google-Smtp-Source: ABdhPJxqIl9Zm9z8IKtqnt37oI4/tjqMhg+8+yDWQMkG9w2ChU6LsAVhGgh7YMYx5rXIIyt05hrUfg==
X-Received: by 2002:a05:6638:15cc:b0:331:f70f:635e with SMTP id i12-20020a05663815cc00b00331f70f635emr4223164jat.29.1655256504947;
        Tue, 14 Jun 2022 18:28:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c1-20020a056638028100b0032e802256a9sm5531696jaq.163.2022.06.14.18.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:28:24 -0700 (PDT)
Received: (nullmailer pid 3407444 invoked by uid 1000);
        Wed, 15 Jun 2022 01:28:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
In-Reply-To: <20220614194225.2226447-2-sravanhome@gmail.com>
References: <20220614194225.2226447-1-sravanhome@gmail.com> <20220614194225.2226447-2-sravanhome@gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: mfd: Add mp2733 compatible
Date:   Tue, 14 Jun 2022 19:28:22 -0600
Message-Id: <1655256502.732671.3407443.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jun 2022 21:42:21 +0200, Saravanan Sekar wrote:
> Add new compatible for mp2733 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/mps,mp2629.yaml:22:5: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/mfd/mps,mp2629.example.dts'
Documentation/devicetree/bindings/mfd/mps,mp2629.yaml:22:5: found duplicate key "const" with value "mps,mp2733" (original value: "mps,mp2629")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mfd/mps,mp2629.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/mfd/mps,mp2629.yaml:22:5: found duplicate key "const" with value "mps,mp2733" (original value: "mps,mp2629")
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml: ignoring, error parsing file
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

