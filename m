Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB74CBAB8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCCJxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Mar 2022 04:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCCJxV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2022 04:53:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13F40E48
        for <linux-iio@vger.kernel.org>; Thu,  3 Mar 2022 01:52:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j17so6970998wrc.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Mar 2022 01:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7sxk0gi7K/gEPgkPAW86oNPcDC6UYWLnAgn9FQdwzh8=;
        b=F5JReUMm+aE6eQqymlEbM8qe/PfH788Ia/OqOdM3zvOQl6r4RpguDVY6lVDA80nPLm
         9ylhE1F/YS+V57bge3B+5sHZtsug09u16n/uMDHMusPZ/Mztwa7r8Gvn5zqumWhA5eyM
         HLeSyjzc8J63VyymRjLNpr286C3U0vFqVCZXz/hA5AdQTU2muMWegRQWyIwLIPzTkgtC
         gkgapOHzZ6KVwMLPX4/hlhc4ePUCxhm/Rw6n+RHBIVp9v3vqQ0xZqoHQ/PJ4lV/zjKml
         q1EU2irWgkLP1+9NvTvSy9gEWBnJq7xp6/k9ftVzU6HchuxSBA9XyKLP+gMq+L+67MEf
         7aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7sxk0gi7K/gEPgkPAW86oNPcDC6UYWLnAgn9FQdwzh8=;
        b=Y9mAagJXuiQydrLHYAILmpCDlEtuFwEKXFQuYcO24FFwuc7chUgZtynsnm+dFaeDBB
         MIB5YfZqHw1O0pqX4R5899YWEtPKx6xcJKU1V6+VmtZl+N+YVpIsVZFrXgwiANeX6C2x
         i0UD7XEeLYIWiY4tbbZuTmKL4LxnSxSDb9PxJETzQs+Kf8GUU2qJdnXBlTXZlDRingK7
         iq64zbjGzDz14xt7ZtKOH12PGP1FlnyUXpCdieXJoJk5H4e93ev5HVbyxCyxwYWshEjk
         06pkltdEpW0EOjOCn/HA0cMeLDShv+YKNeUPg97xUZmO2lK57JZuYAxlhMAkbbA5RRIb
         YcVA==
X-Gm-Message-State: AOAM530iwWcRoprPuO5M8pmPL94ZgkFlFdqzgyIxKPZgSRf6YfbVnAhK
        mNAg8daFR1oxNrY5vPUVI84usg==
X-Google-Smtp-Source: ABdhPJzSz7co5Gr4DzCxUOVBx6L6Q21HdHmiiy260WjUtW/O3KRGZ7JP0MFsCyGruqP65XknqhA0Zw==
X-Received: by 2002:a05:6000:2ca:b0:1f0:46a2:bd63 with SMTP id o10-20020a05600002ca00b001f046a2bd63mr4170886wry.140.1646301153045;
        Thu, 03 Mar 2022 01:52:33 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003816edb5711sm8807931wms.26.2022.03.03.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:52:32 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:52:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Message-ID: <YiCP3gwEffbQiA5W@google.com>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan>
 <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam>
 <YhigDPC6r7dTJUXd@google.com>
 <20220225094024.GQ3943@kadam>
 <da96bd50-e346-a20c-de53-561c996e826c@linaro.org>
 <20220303090549.GM2812@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303090549.GM2812@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 03 Mar 2022, Dan Carpenter wrote:

> On Thu, Mar 03, 2022 at 02:20:58AM +0000, Caleb Connolly wrote:
> > 
> > 
> > On 25/02/2022 09:40, Dan Carpenter wrote:
> > > On Fri, Feb 25, 2022 at 09:23:24AM +0000, Lee Jones wrote:
> > > > On Fri, 25 Feb 2022, Dan Carpenter wrote:
> > > > 
> > > > > On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
> > > > > > On Thu, 24 Feb 2022, Bjorn Andersson wrote:
> > > > > > 
> > > > > > > On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
> > > > > > > 
> > > > > > > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > > > > > > chip revision information to implement errata or otherwise adjust
> > > > > > > > behaviour, export the PMIC information to enable this.
> > > > > > > > 
> > > > > > > > This is specifically required to enable the RRADC to adjust
> > > > > > > > coefficients based on which chip fab the PMIC was produced in,
> > > > > > > > this can vary per unique device and therefore has to be read at
> > > > > > > > runtime.
> > > > > > > > 
> > > > > > > > [bugs in previous revision]
> > > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > > 
> > > > > > > This says is that "kernel test robot" and Dan reported that something
> > > > > > > needed to be fixed and this patch is the fix for this.
> > > > > > > 
> > > > > > > So even though their emails asks for you to give them credit like this
> > > > > > > you can't do it for new patches.
> > > > > > 
> > > > > > Right, or else you'd have to give credit to anyone who provided you
> > > > > > with a review.  This could potentially grow to quite a long list.
> > > > > > 
> > > > > 
> > > > > I always feel like people who find crashing bugs should get credit but
> > > > > no credit for complaining about style.  It's like we reward people for
> > > > > reporting bugs after it gets merged but not before.
> > > > > 
> > > > > We've had this debate before and people don't agree with me or they say
> > > > > that it's fine to just include the Reported-by kbuild tags and let
> > > > > people figure out from the context that probably kbuild didn't tell
> > > > > people to write a new driver.
> > > > 
> > > > Reviews will often consist of both style and logic recommendations.
> > > > If not spotted and remedied, the latter of which would likely result
> > > > in undesired behaviour a.k.a. bugs.  So at what point, or what type of
> > > > bug would warrant a tag?
> > > > 
> > > 
> > > If it's a crash or memory leak.  Style comments and fixing typos are
> > > their own reward.  Basically it's the same rule as Fixes tags.  We
> > > shouldn't use Fixes tags for typos.
> > 
> > Hi Dan,
> > 
> > How (if at all) would you like me to reference the bug reported by LKP
> > in my next revision of this patch? It doesn't seem like a fixed conclusion
> > was reached here.
> > 
> > It seems like Reported-by doesn't really represent things well, perhaps we
> > could try for "Bugchecked-by" or something like that?
> 
> Just leave it out.  Those are automated emails and I just look them
> over and hit forward or delete.
> 
> The thing is that I've been arguing for a new Fixes-from: tag since
> before the kbuild-bot existed and on the last kernel summit email list
> someone said to just use Reported-by so I've been trying to help people
> consider that as an option...

Nothing wrong with using Reported-by if located chronologically and
annotated correctly.  Example was provided in a previous mail.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
