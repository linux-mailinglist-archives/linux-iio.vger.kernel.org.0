Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DC6461C4
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLGTcZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 14:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGTcY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 14:32:24 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE3C663DC;
        Wed,  7 Dec 2022 11:32:23 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q1so17241586pgl.11;
        Wed, 07 Dec 2022 11:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJ93t0qOhK77peLQli38loBDZSZoHQBfLCudn8XKKkU=;
        b=SXJMcwQ/DX/x1scl/JInhAOMSXhTgG6NMqn0+f7F4uJvfw1ENl1Owc16iAdMtuKYZV
         +eUJ6MG53Lh01wqJMd6+BBLGW+ASLyrTILLY/k8fcy3T1q3c0G2guTpUxDEZ+Cw7xiwq
         5nv71OjcKpcKe1o8yphT4VWCfosowXpVq8F5taWYUqk/X0jcJiSsHJEcfPvqzh70Md7I
         pVJu4/p2YnToPdRxt7oQFXliv+t6JQHRnhBtkIWmA1PpDjP5ebiwdFx3ie9dbI1oq7T/
         fVANQn9sC5L4Sogum8Mi1HJ4qls2Do89SgYD/trpNdfJjBuDX56pZV6W0HB7hvxFRpoE
         /x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ93t0qOhK77peLQli38loBDZSZoHQBfLCudn8XKKkU=;
        b=P/NlZFRX/34uBIbzxctF94PRLIi1Lhstjs0drm2pHdGq6XsJCSmHYjqb7Tk0zWQRQT
         zx9K4QMQigwFTLGy0Dp37knnEKH5ugtZTFh7vX432b6fdZPGFGGnWaI0VrlHNHJDXp9k
         iECYCjLd87GWaNZ027FFQpGQ2TSvP4VVQsB83LSsDiNUWNwUom5vpspaDezPPPRlMvrz
         5uXiWnTeeL6uItSLepU6q90MMc+f8xUHgIpDkB0sOp7IrlJiyjaKAB0ivDNMl9ChQE4r
         Z93PQHaZ4PmY+/x1eE4oGzpCMIbfPKNp7nHI/OrARjLM95am1DFfeOo2bl8Z+WQtadAp
         bJJw==
X-Gm-Message-State: ANoB5pnPX0XBgM92mEpTOzNX2Z9jyWraiLuVjeiDmt5CWDkJpquJWHO2
        5ajb+r3D+VY+fzzORthd/d4=
X-Google-Smtp-Source: AA0mqf5S9Wbej7daA71TN/mdshSxOTWOgPe3L9BDEC6euYukOmVdhOpbd6Jrdw3mr8NfWxb0vDjJEQ==
X-Received: by 2002:a62:1b05:0:b0:576:91fa:8ed0 with SMTP id b5-20020a621b05000000b0057691fa8ed0mr22190841pfb.15.1670441543186;
        Wed, 07 Dec 2022 11:32:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a61:38c7:d37a:7f43])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b0018157b415dbsm15089573plh.63.2022.12.07.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:32:22 -0800 (PST)
Date:   Wed, 7 Dec 2022 11:32:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: input: qcom,pm8921-keypad: convert
 to YAML format
Message-ID: <Y5DqQywrM6WjqwWA@google.com>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
 <20221204061555.1355453-2-dmitry.baryshkov@linaro.org>
 <20221205220433.GA2684995-robh@kernel.org>
 <E5C1A37F-5758-4026-9412-F13760C465D0@linaro.org>
 <20221207170753.GA2402110-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207170753.GA2402110-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 07, 2022 at 11:07:53AM -0600, Rob Herring wrote:
> On Tue, Dec 06, 2022 at 05:20:16AM +0200, Dmitry Baryshkov wrote:
> > 6 декабря 2022 г. 00:04:33 GMT+02:00, Rob Herring <robh@kernel.org> пишет:
> > >On Sun, Dec 04, 2022 at 08:15:52AM +0200, Dmitry Baryshkov wrote:
> > >> Convert the bindings for the keypad subdevices of Qualcomm PM8921 and
> > >> PM8058 PMICs from text to YAML format.
> > >> 
> > >> While doing the conversion also change linux,keypad-no-autorepeat
> > >> property to linux,input-no-autorepeat. The former property was never
> > >> used by DT and was never handled by the driver.
> > >
> > >Changing from the documented one to one some drivers use. I guess 
> > >that's a slight improvement. Please see this discussion[1]. 
> > 
> > Well, the problem is that the documentation is misleading. The driver 
> > doesn't handle the documented property, so we should change either 
> > the driver, or the docs. Which change is the preferred one?
> 
> The preference is autorepeat is not the default and setting 
> 'autorepeat' enables it. You can't really change that unless you don't 
> really need autorepeat by default. I can't see why it would be 
> needed for the power button, but I haven't looked what else you have.
> 
> Of all the no autorepeat options, I prefer 'linux,no-autorepeat' as I 
> find 'input' or 'keypad' redundant. But Dmitry T. didn't think it should 
> be a common property at the time.

Right, I would prefer for new bindings we used assertive "autorepeat",
instead of negating "no-autorepeat". However here we are dealing with
existing binding.

The issue is complicated with the driver using one option, binding
specifying another, and existing in-kernel DTSes not using any and thus
activating autorepeat as the default driver behavior.

Do we have an idea if there are out-of-tree users of this? If we are
reasonable sure there are not we could converge on the standard
"autorepeat" property.

-- 
Dmitry
