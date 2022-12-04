Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48388641D9B
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLDPY4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 10:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLDPYz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 10:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD513F7C;
        Sun,  4 Dec 2022 07:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9CD60E9A;
        Sun,  4 Dec 2022 15:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643AFC433D7;
        Sun,  4 Dec 2022 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670167492;
        bh=ul2+VHkiJxaUIPa/a1hTitbj20YPceGO0/dSKYns2Dc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TA+weilQscJKqqepdmnmkFIcznj5f4OTP/E+mSob4mIQYxCyNLYyMGhSMzOOBZqdO
         kj/a1ZVPvwMU7kDZIy9QK9vY3pfCuc4x8MKG/CokKJZ4hXpYRHFNMy15Lx1ec4/7ZY
         1Qttp08uTmlhnmxPNx8QN801GTtYh+xCOp60mr+DjtVitglCFGEbsvoFQlt6JOxgg7
         BVSsF/maYZ1darIb0ia4Vz27dbHI80ei4rvWBajdIZnBenUAqaesyFrItMvPDkzJaS
         0MNW3GZEIL5vqgffaPrsMDyJIz0DNZIjQZyjPCIHys0RFHD9jWmIkc5eHU09w4wcqs
         f7C9NjWEu1MMA==
Date:   Sun, 4 Dec 2022 15:37:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: qcom,pm8018-adc: allow
 specifying MPP channels
Message-ID: <20221204153736.610c49ed@jic23-huawei>
In-Reply-To: <20221204061555.1355453-4-dmitry.baryshkov@linaro.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
        <20221204061555.1355453-4-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  4 Dec 2022 08:15:54 +0200
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> Several ADC channels are bound to the Multi Purpose Pins (MPPs). Allow
> specifying such channels using the mppN device node (as used on apq8060
> dragonboard).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

So I understand this more, why do the node names have to have anything to
do with the particular pin? I'm assuming the reg value provides that
relationship.

> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
> index d186b713d6a7..fee30e6ddd62 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
> @@ -64,7 +64,7 @@ required:
>    - adc-channel@f
>  
>  patternProperties:
> -  "^(adc-channel@)[0-9a-f]$":
> +  "^(adc-channel|mpp[0-9]+)@[0-9a-f]$":
>      type: object
>      description: |
>        ADC channel specific configuration.

