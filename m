Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770C702481
	for <lists+linux-iio@lfdr.de>; Mon, 15 May 2023 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjEOGX7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 May 2023 02:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbjEOGX7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2023 02:23:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4051F2133
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2023 23:23:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9659f452148so2246618966b.1
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2023 23:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684131830; x=1686723830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aG3cuPsJbywJ2jZPWFDdB3wERfrKUjf/xc3vSM+XjiA=;
        b=oAyA2+7weBfyce49Vcc0dHoW4JNj4/j1vZp9dYpY/Cz0nYTVubXvYyMUyZ63/T7E7c
         UnuZTkeGxmBzU7tQkDtZFUzBJZWPWnvJXlQSPOjHDDHbroZOJ01TC8v06pbBMZR/9OtX
         j9kN3aRB6zkq55ppjGAF/2YjdUuqLv3FKfzcAtvlFFuEnwES9vgWl753bQTHfqw5t463
         FraBuoPqYo5ulrcxEtslTmYJEV4h89Ywgbc2FSovR8q6Q+83QkKe+7nNJKonCxvQOavg
         ZRUA7hsnc8dQVn7WJQhZZX6S6q1TE0JYLEETmZSX1BnMCjLJ6DH62k8B0vpQPl42P8rp
         ylxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131830; x=1686723830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG3cuPsJbywJ2jZPWFDdB3wERfrKUjf/xc3vSM+XjiA=;
        b=er2AAGumgEyeUPOLPFVo8iZe1snzcTX0eBZpyPjp3PZ9prL7x4HLX68ONE6hd733oJ
         hN0LzbaF9IyZli51HLb1b4K0Zy/5m15kEdQkOmrRoXvpHzDw2+Ay54UFReoyczdMMmc9
         FJr4gfi1PaQX5ahj+org8vWgsWYI8668b7YneOm5TkrF9jEphs7JkUncThOckHfPqaf8
         hoEeSI7E4aYKAVvXye0WmcEaVH3o6/PkMTgnNm8lp3at6o9q09COQ3KJVUCUwE3sGkBM
         dirHqQmRlkcwO9TKONA1WBg7YNToMYcuGcdYZl0iqcLTo4NRkz/5LZfAjAsScS/HZwUn
         lcSg==
X-Gm-Message-State: AC+VfDyVvKZcJh08W8pPw/02Rb+0Y90dGpn3lsw68igDkHBIqVDBHtNq
        7kwDAdKWTP2IsBPtCSS8YaeFwQ==
X-Google-Smtp-Source: ACHHUZ5gCGS8/MNRHuJSz5Pca9SEJ6gjisklu2kr+9uwRmmyoigsefr6FNuCM7gRhYo9W4I3nGrfmA==
X-Received: by 2002:a17:907:72cc:b0:969:9118:a98f with SMTP id du12-20020a17090772cc00b009699118a98fmr23725549ejc.10.1684131829753;
        Sun, 14 May 2023 23:23:49 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id hx16-20020a170906847000b0094e4eabb402sm8997368ejc.128.2023.05.14.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:23:49 -0700 (PDT)
Date:   Mon, 15 May 2023 08:23:47 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Meerwald <pmeerw@pmeerw.net>, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        andriy.shevchenko@linux.intel.com,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add support for tmp006
Message-ID: <20230515062347.gwiarus7rlfywew4@krzk-bin>
References: <cover.1684089997.git.anupnewsmail@gmail.com>
 <e6e56cd513625c76435f444f13c640f9556fb2bc.1684089997.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6e56cd513625c76435f444f13c640f9556fb2bc.1684089997.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 May 2023 00:31:59 +0530, Anup Sharma wrote:
> Add devicetree binding document for TMP006, IR thermopile sensor.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Changes:
> V1 -> V2: Removed redundant dt-binding from subject.
>           Added supply information.
>           Adhere to the generic node name.
> ---
>  .../bindings/iio/temperature/ti,tmp006.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/temperature/ti,tmp006.example.dts:25.13-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/iio/temperature/ti,tmp006.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1781058

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
