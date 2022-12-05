Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700DC6437AB
	for <lists+linux-iio@lfdr.de>; Mon,  5 Dec 2022 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiLEWHP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Dec 2022 17:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiLEWHO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 17:07:14 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DBE88;
        Mon,  5 Dec 2022 14:07:12 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so8153938otl.10;
        Mon, 05 Dec 2022 14:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzxSWx9NN6vl69+NIDxKRNbatlDFCGn78OKTeHWAgYA=;
        b=DBvRlOcJwRGtdRtjs0ihTJqDDmnpEm1x1rDk0dQJUxxr2krZhyq9e/viwLUk22ho0P
         6USjx/GY/i11cBhQJYmW7cjdYfQDufyVslV5UTz2LZl9mmrfuDiZV1cu+2JX3IkMhLNc
         pMo+SI3RKVTP2qf6jIuoIYZibuIDS3VzrT+KI7zhjFpgae18ewwcZtbOOABEc4BznxvO
         xbSt2Xwey+a/Ka/8f5BTw9DM6s2/tF6Io8rJJAdECkzGlCHTs/B8qG16oi7cLljgFd2H
         2YAka9NA9/NvpJNY4Kp+8jovuSYQm4ic1n3nrqNC7DxlhvQKkmjPkT7dO6aLFY5TKRel
         kb5g==
X-Gm-Message-State: ANoB5pkLegzrkB4WM/chATqLjm3k+ryg4Z7jGfopPLFHeb4SHFBwsDwt
        JrLvOirU2ISqbvz1oceNSA==
X-Google-Smtp-Source: AA0mqf7fjIp7rNUXvJ0WHMseWKEOBQTSK9aHB/qZF6np4G0yQsuJTsBZ4CVyCsSs0t3dcv7pZWY+yw==
X-Received: by 2002:a05:6830:1e65:b0:661:b632:4259 with SMTP id m5-20020a0568301e6500b00661b6324259mr33230685otr.304.1670278031257;
        Mon, 05 Dec 2022 14:07:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h13-20020a4ad74d000000b004a0ad937ccdsm3240951oot.1.2022.12.05.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:07:10 -0800 (PST)
Received: (nullmailer pid 2726011 invoked by uid 1000);
        Mon, 05 Dec 2022 22:07:09 -0000
Date:   Mon, 5 Dec 2022 16:07:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: leds: Add 'cm3605' to
 'linux,default-trigger'
Message-ID: <20221205220709.GA2713165-robh@kernel.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
 <20221204061555.1355453-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204061555.1355453-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 04, 2022 at 08:15:55AM +0200, Dmitry Baryshkov wrote:
> Add 'cm3605' to possible values for 'linux,default-trigger'. This allows
> one to specify Capella CM3605 proximity sensor as the LED trigger.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index f5c57a580078..4ffb1cdf6845 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -101,6 +101,7 @@ properties:
>          # LED is triggered by SD/MMC activity
>        - pattern: "^mmc[0-9]+$"
>        - pattern: "^cpu[0-9]*$"
> +      - const: cm3605

No. This would never scale to the 1000s of devices we have.

Maybe 'trigger-sources' does what you need.

Rob
