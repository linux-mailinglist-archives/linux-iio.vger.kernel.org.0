Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09455F33A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jun 2022 04:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiF2CKV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 22:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiF2CKI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 22:10:08 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3EF326C5;
        Tue, 28 Jun 2022 19:10:03 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id h85so14683077iof.4;
        Tue, 28 Jun 2022 19:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LN+78puhwYgKBtGz2TuDo+Xg7t/Ipevze3ieJ206j4Y=;
        b=cQka8Kajrz27cvfwVqVCDOpDQ9f8zqznaxA+QKh0SxSrSkmE+cC4kMUTAtE02Cjawx
         RmsAP5ZVOD2f9UtcwIBImaAL31DnadXG5/lZ9R+jtBgSkrKcohIF5laKd4vYzTb19kGx
         4ZYjhQXbwxpJoVPIcaDbKkNJSpSTcDSBI7sZclWidqvmDLZCXbsdrXVKNXTc351cHyJL
         hSw6h2UGsZVneAu95/9O2V3Bbb1uvZL8QP2Z70D4+XJT1YcJrPWTcxxyqfNwY+AjoOvq
         /qtb/vJ/T7SKlxpQ43U/a1B86UiNukg+24YF7pUXFKZsYy7/vmx249A/d/Qsshc/Q2lj
         M5DQ==
X-Gm-Message-State: AJIora+tams5HpGwq4k7O1VCYmvCLpwalL0ueNR5Exx3SmJEcofi9QjJ
        TgjBxWpn+TbnSK2evTqn5Q==
X-Google-Smtp-Source: AGRyM1tYMYPFp2t74pAadIvPmONlKDfgpVJ9eVS2orkI/qmxrWCHXrzijGo4rGJR+DGI/H8yB6clFw==
X-Received: by 2002:a05:6638:191b:b0:33c:8b14:e7e4 with SMTP id p27-20020a056638191b00b0033c8b14e7e4mr621920jal.212.1656468603517;
        Tue, 28 Jun 2022 19:10:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s10-20020a5ec64a000000b0067520155dedsm5407453ioo.15.2022.06.28.19.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:10:03 -0700 (PDT)
Received: (nullmailer pid 1403680 invoked by uid 1000);
        Wed, 29 Jun 2022 02:09:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     heiko@sntech.de, contact@artur-rojek.eu,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-input@vger.kernel.org, paul@crapouillou.net,
        maccraft123mc@gmail.com, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220628191500.69831-2-macroalpha82@gmail.com>
References: <20220628191500.69831-1-macroalpha82@gmail.com> <20220628191500.69831-2-macroalpha82@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: adc-joystick: add poll-interval-ms
Date:   Tue, 28 Jun 2022 20:09:39 -0600
Message-Id: <1656468579.916584.1403679.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 14:14:58 -0500, Chris Morgan wrote:
> New devicetree attribute of "poll-interval-ms".
> 
> Add poll-interval support for the adc-joystick documentation. This is
> an optional value and if not provided the adc-joystick works as it
> does today (with triggered buffers). If this value is provided, the
> adc-joystick driver is polled at the specified interval. A new
> attribute was added instead of using the existing attribute of
> "poll-interval" to comply with rules detailed in property-units.yaml.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  Documentation/devicetree/bindings/input/adc-joystick.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/adc-joystick.yaml: properties:poll-interval-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermistor@:properties:adi,excitation-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/adc-joystick.yaml: ignoring, error in schema: properties: poll-interval-ms
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-nanoamp
Documentation/devicetree/bindings/input/adc-joystick.example.dtb:0:0: /example-0/adc-joystick: failed to match any schema with compatible: ['adc-joystick']
Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb:0:0: /example-0/spi/ltc2983@0: failed to match any schema with compatible: ['adi,ltc2983']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

