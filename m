Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D06437A1
	for <lists+linux-iio@lfdr.de>; Mon,  5 Dec 2022 23:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLEWEh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Dec 2022 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiLEWEg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 17:04:36 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D211470;
        Mon,  5 Dec 2022 14:04:35 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-14449b7814bso10197411fac.3;
        Mon, 05 Dec 2022 14:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0o74DAKGRH7Cm9VJkIU43IM86KKjNPrQtB4w12QWbA=;
        b=sGqzU9+ZxURRohoE2SNQ/14EyCb2k0Cy+7lOJyErZfYbkAFcsDoPIpvnNQVexFgN2s
         ediQ3fzehZrnF3pD8emD2MfLQfCmgmYomjQu/dNlmS1G+ZawUO1vVx1u2GmfRfwCfzDe
         h4yUJH70sSA9oUesf48iCdYunkIOWjo+6TyXr2drgU5DQEyoE6htbINVA3EmZXJWgS9J
         LIKMTf3EQXXZlYhlTZPoSWHIgcXWeZHN9fralygXCnzEmEp3+3Y4OHAO/G8I4m1R63En
         Ph6kRJdcbOh2/kSz4vzDu73nRrbU2go8CjEQPFk5KQqwiVCvtweC4i+hmkxHXAgeQp3K
         KC3w==
X-Gm-Message-State: ANoB5pl9yAenJ6Igg5VkfNU+EZkZPRZyb9E0+PQiVnICx0SN6P8kk//Y
        wFdfhsVCrmRVcuO3Gqj+yg==
X-Google-Smtp-Source: AA0mqf5+j5X2a2K39tY4PrzDbQKhAY0J9u3F+3pE3tsRI6votXOld4GH5/oZPKPKFAfPEktnYb/4qg==
X-Received: by 2002:a05:6870:ea81:b0:144:6881:d7e6 with SMTP id s1-20020a056870ea8100b001446881d7e6mr6088539oap.94.1670277875064;
        Mon, 05 Dec 2022 14:04:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r127-20020aca4485000000b0034d9042758fsm7461646oia.24.2022.12.05.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:04:34 -0800 (PST)
Received: (nullmailer pid 2709108 invoked by uid 1000);
        Mon, 05 Dec 2022 22:04:33 -0000
Date:   Mon, 5 Dec 2022 16:04:33 -0600
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
Subject: Re: [PATCH v2 1/4] dt-bindings: input: qcom,pm8921-keypad: convert
 to YAML format
Message-ID: <20221205220433.GA2684995-robh@kernel.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
 <20221204061555.1355453-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204061555.1355453-2-dmitry.baryshkov@linaro.org>
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

On Sun, Dec 04, 2022 at 08:15:52AM +0200, Dmitry Baryshkov wrote:
> Convert the bindings for the keypad subdevices of Qualcomm PM8921 and
> PM8058 PMICs from text to YAML format.
> 
> While doing the conversion also change linux,keypad-no-autorepeat
> property to linux,input-no-autorepeat. The former property was never
> used by DT and was never handled by the driver.

Changing from the documented one to one some drivers use. I guess 
that's a slight improvement. Please see this discussion[1]. 

Rob

[1] https://lore.kernel.org/all/YowEgvwBOSEK+kd2@google.com/
