Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A044C5189
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 23:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiBYWbi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 17:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiBYWbh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 17:31:37 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002D210452
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 14:31:04 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so8443042ooi.7
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6stLPZaGS6nvvDwpshyXkfYQ31q2L27yLoTEa6odkug=;
        b=BVADKUGIFH+Bz3Dro3Gs/TYsaEH+nA+XwmrpLfL+vrZos9iYY47ifY/dqQ/HNuqq5M
         1V2JXPmwcOBXBafqjVqLfIfeVznzTYtRZMx1OJ5gHDNqyX4N5uCLun6jUbGkE9nvVpZ/
         YVUc7bOvJdesdT/U/GIxu1EIJdxZgZpfBpbSk8QQ3Z3/SB3d6J1Fr6bqvqwlOfHvMj7b
         23rycgAIRL2evFaiSMc65U9f6MZLzHAr25lKIswG2bMpnbOSqVDd1mfLu2W43p71OFFQ
         Z9Dqp9y7hfC8andTVv6qj1r1QRPpUEPt60+Q6DAzDVYha740SVdY4+f0+hdJRjCEo2t2
         Z4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6stLPZaGS6nvvDwpshyXkfYQ31q2L27yLoTEa6odkug=;
        b=sVUcSKrTWH8oWcrZtDjKj5E+qnn3PgCFhuJqAfNH4NfE9TEi4kvqCY6RjFquHd8Xke
         A9TopLlAEc7vEVEECj+JrKAlpXH4OuTvkdMMMup6i8Lyn3ied3WeVSmqoBcVFCYWsrBR
         En9dk6KpqwyHUGPFW1NLAWKQ2VLrVezC9Hy8sYiMra3uXUHXyXDrL2cA1rlqhkPUFqdF
         V6a6n3KC6RjlKg9j3hliC9rk/wAibn2YHBFOGYkddR9LjPhTsFjBHRtq1ys0HDWXVtUi
         4tdYj8JFkmLkSg1Mfj1U9WlRRR1OBpbWACPivcRkpd16Bsnzafu7BxdTwHYG1ikgNOPE
         V9kA==
X-Gm-Message-State: AOAM531HOWuUK3Yt46c9eWXhGgiWW4Qb92xKNk9/dbJLKnXs/O6pL6l5
        oQMT9JyPKG9NKLY73dEIMTzXxA==
X-Google-Smtp-Source: ABdhPJyJ618LE128s4aGt50PcKa9gGTGS6OS3+AvbniRvT1Q1aLS/G5jaqcOrZ8I2fWH+kBdeS94+Q==
X-Received: by 2002:a05:6870:b9b:b0:d0:effc:7620 with SMTP id lg27-20020a0568700b9b00b000d0effc7620mr2371117oab.56.1645828263696;
        Fri, 25 Feb 2022 14:31:03 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w11-20020a056808140b00b002c0966d9521sm2165316oiv.10.2022.02.25.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:31:02 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:32:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
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
Message-ID: <YhlZG6xJ75ieskyT@ripper>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Fri 25 Feb 01:04 PST 2022, Dan Carpenter wrote:

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
> 

I certainly would like to be able to recognize any form of review effort
going into the evolution of a patch, but if we use Reported-by for that
purpose we're loosing the ability to credit the effort to find the
regressions in the kernel.


And while it's clear that Reported-by could mean that you spotted a bug
in a previous revision of the patch, should this then be used to denote
anyone that came with any sort of feedback?

Do we want to "repurpose" Reported-by to be a list of anyone providing
any input to any previous revision of the patches? (Reported-by doesn't
sound like the right tag for that to me)

> Also I think that counting Reviewed-by/Acked-by tags should be
> discouraged.  It's useful as a communication between maintainers but it
> shouldn't be rewarded.
> 

For acked-by I definitely agree. At least in my subsystems I see a quite
good flow of Reviewed-bys from community members and am very happy about
that. It communicates that people approves of the patch, in contrast to
the more common case of no one dissaproving the patch and it's merged
just with my S-o-b...

Regards,
Bjorn
