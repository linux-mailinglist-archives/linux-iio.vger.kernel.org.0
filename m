Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4D645F9D
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 18:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLGRIB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 12:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGRIA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 12:08:00 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F366241;
        Wed,  7 Dec 2022 09:07:56 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id v82so21419890oib.4;
        Wed, 07 Dec 2022 09:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dhTLX0YWvTThjW6CLFbWou1O6zjrrg1N0tlAu9uVwI=;
        b=w7TlCsbtvANRT+/VRGthb1isjQ0L38Vqn9rmoQ4eXqoleQmXEIOE84jw7Div7GBjFm
         EYS3CdfgRE255GOcvEAUS6P4QWmVzJTSoWYgrE85kcm2MZaiFI0dCijIooF+KSB1etjj
         PEBKAdqcqy/mT+xd189UgrZjlZ5mN35gIckNiei/dpF7DUVDH+11ZzY+FIdZlyT26h9R
         5xAU4cor5mviZc01ZMQgfhOOQwxbp6lNoC8qv/PNw7ZY8uYGIPKQ5IynS6u1r7Gm3oxY
         OULt1NrBbhM9x+eBESMgd3OTA2+e/CqNnTkS4GoB7yehLHpY3v7vo6Fw/270x94Iu21H
         qM2A==
X-Gm-Message-State: ANoB5pnUKVsWMO6kVUl+aHFoyT6KIeozuaejSV5A4KM1NQJ63jXcJkTo
        BMRBnNbsf1MutfFNVIal0Yi6ojjHMg==
X-Google-Smtp-Source: AA0mqf72nM70OyfM4u2USqQW4Ue06dnO2WYGcrsj9lY4SEcHSDXVdL0lGz6S91qY48kM8cYJ+U6NKw==
X-Received: by 2002:aca:3654:0:b0:35b:e564:a51b with SMTP id d81-20020aca3654000000b0035be564a51bmr13366679oia.6.1670432875239;
        Wed, 07 Dec 2022 09:07:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s5-20020a05683004c500b0066d2fc495a4sm10603632otd.48.2022.12.07.09.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:07:54 -0800 (PST)
Received: (nullmailer pid 2415984 invoked by uid 1000);
        Wed, 07 Dec 2022 17:07:53 -0000
Date:   Wed, 7 Dec 2022 11:07:53 -0600
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
Message-ID: <20221207170753.GA2402110-robh@kernel.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
 <20221204061555.1355453-2-dmitry.baryshkov@linaro.org>
 <20221205220433.GA2684995-robh@kernel.org>
 <E5C1A37F-5758-4026-9412-F13760C465D0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E5C1A37F-5758-4026-9412-F13760C465D0@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 06, 2022 at 05:20:16AM +0200, Dmitry Baryshkov wrote:
> 6 декабря 2022 г. 00:04:33 GMT+02:00, Rob Herring <robh@kernel.org> пишет:
> >On Sun, Dec 04, 2022 at 08:15:52AM +0200, Dmitry Baryshkov wrote:
> >> Convert the bindings for the keypad subdevices of Qualcomm PM8921 and
> >> PM8058 PMICs from text to YAML format.
> >> 
> >> While doing the conversion also change linux,keypad-no-autorepeat
> >> property to linux,input-no-autorepeat. The former property was never
> >> used by DT and was never handled by the driver.
> >
> >Changing from the documented one to one some drivers use. I guess 
> >that's a slight improvement. Please see this discussion[1]. 
> 
> Well, the problem is that the documentation is misleading. The driver 
> doesn't handle the documented property, so we should change either 
> the driver, or the docs. Which change is the preferred one?

The preference is autorepeat is not the default and setting 
'autorepeat' enables it. You can't really change that unless you don't 
really need autorepeat by default. I can't see why it would be 
needed for the power button, but I haven't looked what else you have.

Of all the no autorepeat options, I prefer 'linux,no-autorepeat' as I 
find 'input' or 'keypad' redundant. But Dmitry T. didn't think it should 
be a common property at the time.

Rob
