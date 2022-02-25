Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D744C4143
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 10:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbiBYJYL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbiBYJYK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 04:24:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474F91B8FF6
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 01:23:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso1302556wmr.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 01:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CN3ckV7V7XY2Z/PXd5eMoT2Xt0bXtTULBgiFUcwvDV0=;
        b=yyqeERueu3u0ZjNKrABkQFIPOEykZ2OzixnO1rjGXau8PrMSZR5lW8ygRfvU8TnJny
         8aNSGSoLZpIwXEIGxGb5Np4UI4xrLwAqSenS9p51hVApZAC7mQ4w4cIEDUjP1pSOrEa9
         IKFi/hknh+h36u6E9khuzeiT3M5T/Nn9db1jir2HltEroWypBB9TwAYyLtbZ1K7PV3/V
         qusC7kyGVwa66ScnE9EKgMUxL0SkEIQyO/VFQTZ+Y1pAV6H8WXm9h5UARlBXIIh1q6bq
         95SIfOiBigkTZx1apW3F61LD004ww3e6l+ktm45ubrC3ELcz9br9iszrBKS/RfIHwSQI
         3Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CN3ckV7V7XY2Z/PXd5eMoT2Xt0bXtTULBgiFUcwvDV0=;
        b=hW460Ijocy+55/t4gVUsJusSmIZifXEbwEG/9tOXwfuuFxT2cbSxS/oB6+5oN5kUG0
         IK1UtoV2VXPbjbR68zqRldD7fh3aAgIVHS3u5XDqmXyjPrKzIJs24JuXsGtV6Y/chaNT
         htUIZjkIy3JJtNKH7ZbLcsrjzyB0T5JJSCg0h+AvfRQoLCcH5J6keRn/zcQCms1yBN9n
         Th6A8PofQ4GFr3VHnIwfptHu6ihyrT6ZUFaEyRCVK4AmcEo1ZrAxiehlO92bgoUvhAjc
         10mk7qQcSpA0TC8afuO/tAeOlgMD/AIdaQ7/krFaWRU1xaIMfCGdV7dc7/GQXT//oUs/
         sPcQ==
X-Gm-Message-State: AOAM533TxO39M2ZifgHtcfXEuy/fnz8d1wKfHolcoApGA/QSwA/Cxy0n
        iiUqEcF4bDbeqkL8RM4RKHuJHA==
X-Google-Smtp-Source: ABdhPJzk67cSQJnn5+JKcm3bvir6uAjLX4KqIrLecspN4qJsRTg7viCmegRw8hkil1HaYQPmAghpsw==
X-Received: by 2002:a7b:c347:0:b0:37e:68e6:d85c with SMTP id l7-20020a7bc347000000b0037e68e6d85cmr1844984wmj.176.1645781006811;
        Fri, 25 Feb 2022 01:23:26 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g16-20020a7bc4d0000000b0037bbe255339sm5209340wmk.15.2022.02.25.01.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:23:26 -0800 (PST)
Date:   Fri, 25 Feb 2022 09:23:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <YhigDPC6r7dTJUXd@google.com>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225090452.GP3943@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Feb 2022, Dan Carpenter wrote:

> On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
> > On Thu, 24 Feb 2022, Bjorn Andersson wrote:
> > 
> > > On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
> > > 
> > > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > > chip revision information to implement errata or otherwise adjust
> > > > behaviour, export the PMIC information to enable this.
> > > > 
> > > > This is specifically required to enable the RRADC to adjust
> > > > coefficients based on which chip fab the PMIC was produced in,
> > > > this can vary per unique device and therefore has to be read at
> > > > runtime.
> > > > 
> > > > [bugs in previous revision]
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > This says is that "kernel test robot" and Dan reported that something
> > > needed to be fixed and this patch is the fix for this.
> > > 
> > > So even though their emails asks for you to give them credit like this
> > > you can't do it for new patches.
> > 
> > Right, or else you'd have to give credit to anyone who provided you
> > with a review.  This could potentially grow to quite a long list.
> > 
> 
> I always feel like people who find crashing bugs should get credit but
> no credit for complaining about style.  It's like we reward people for
> reporting bugs after it gets merged but not before.
> 
> We've had this debate before and people don't agree with me or they say
> that it's fine to just include the Reported-by kbuild tags and let
> people figure out from the context that probably kbuild didn't tell
> people to write a new driver.

Reviews will often consist of both style and logic recommendations.
If not spotted and remedied, the latter of which would likely result
in undesired behaviour a.k.a. bugs.  So at what point, or what type of
bug would warrant a tag?

If people insist on providing tags for spotting bugs, at least place
them chronologically with a little info.

Signed-off-by: Author <author@example.com>
Reported-by: Bug Blaster <b.b@kernel.org> # off-by-one in .probe()
Signed-off-by: Maintainer <maintainer@kernel.org>

> Also I think that counting Reviewed-by/Acked-by tags should be
> discouraged.  It's useful as a communication between maintainers but it
> shouldn't be rewarded.

100%

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
