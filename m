Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF251463A
	for <lists+linux-iio@lfdr.de>; Fri, 29 Apr 2022 12:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiD2KJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiD2KJ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 06:09:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6886AF2
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 03:06:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so277641wrn.8
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5CntfCmjV+jt6ob6/zxp3NJtpyFCYLSjmSO47xgDfgc=;
        b=oXA9dlu2adoUv261G7eAKYGi1UusCO0BveMUWtGi/h0x1gYMNR/5kar9EilfjqWqeH
         RbQQah1OR9W1Epej6xFXyO2DPjGjQFkkaMoGvEr4GF+mznfy281mAKd4maVjO7gYS2gh
         FD8fp7mOMZK+CvC9/hJbl7kU3k5kbgm9z9yYicwcQnnq1hQL8LyKyhlxeNqGwDfKKXvb
         6ix2grTS4VjS3pXgcX+OIwhC6ah39pI7b5teZJFxBjc3PWFjTe1W5w0fMrKiOH1Nuqoz
         i23aqjE5MO7AaSiLMfI3UnMTr5UtsaJCO4LnSs0sGiFOPXLF+1ATN9KndhWsBw0r5WNS
         xWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5CntfCmjV+jt6ob6/zxp3NJtpyFCYLSjmSO47xgDfgc=;
        b=ffLjeQkK46ybefMYfyEMwTQEte/ulU3xamFCIvoXiF6dpOnDs+31rDZkXZAw4zNp2I
         Fr4BEhPg3EK7WS0Q60uMK4IMu/4hG7OkTMSpjcm9goHzEqPkg2YuQpeGUmv1KdOHZI3F
         KuHsUF93n0ckH6GMSOd9oVsYyqjyy0PNsmWbzBC0kZKW4On/ScegMq2JMmCY7g7vc5T9
         n83KV/7FfcqxaFw632giDYMZClngRDbLJctAY61dfPg2XJaqCwGnmyB3E36MjRZFtQ2j
         KIVussDFj/sOlgG/O96xIJ1sHNJhHL2lZLgTWryv/fcHnSmWAtXujO88VCUbAainsNTq
         PGfQ==
X-Gm-Message-State: AOAM531UCR+GSxiNjMvHcxGO3VmAYJBbcNKFthatJ8e6FYC4rTGYezp/
        XdEWtVOKjGOJT5Ti7J4lzMk6qA==
X-Google-Smtp-Source: ABdhPJyyUkGGUul0ToFA0PjtK9Hd8cYiW92xkX4JQwO7eX/nHbXxL2pHim5RFuxPS/MurU+O7q0yrg==
X-Received: by 2002:adf:ec05:0:b0:20a:e496:dab5 with SMTP id x5-20020adfec05000000b0020ae496dab5mr14839951wrn.221.1651226768263;
        Fri, 29 Apr 2022 03:06:08 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id x2-20020adfbb42000000b0020ae057045csm2094888wrg.28.2022.04.29.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 03:06:07 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:06:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v13 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <Ymu4jUup3YiX6p3X@google.com>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-3-caleb@connolly.tech>
 <Yma4T1+AglaISe2l@google.com>
 <2763f103-6947-e431-cef5-e202c324d678@linaro.org>
 <Ymq9Su3UE5IYiHnI@google.com>
 <cce2f4b7-3620-7a33-ef21-579eff9a7dac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cce2f4b7-3620-7a33-ef21-579eff9a7dac@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Apr 2022, Caleb Connolly wrote:
> On 28/04/2022 17:14, Lee Jones wrote:
> > On Wed, 27 Apr 2022, Caleb Connolly wrote:
> > > On 25/04/2022 16:03, Lee Jones wrote:
> > > > 
> > > > On Wed, 23 Mar 2022, Caleb Connolly wrote:
> > > > > From: Caleb Connolly <caleb.connolly@linaro.org>
> > > > > 
> > > > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > > > chip revision information to implement errata or otherwise adjust
> > > > > behaviour, export the PMIC information to enable this.
> > > > > 
> > > > > This is specifically required to enable the RRADC to adjust
> > > > > coefficients based on which chip fab the PMIC was produced in,
> > > > > this can vary per unique device and therefore has to be read at
> > > > > runtime.
> > > > > 
> > > > > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >    drivers/mfd/qcom-spmi-pmic.c      | 261 +++++++++++++++++++-----------
> > > > >    include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++
> > > > >    2 files changed, 231 insertions(+), 90 deletions(-)
> > > > >    create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
> > 
> > [...]
> > 
> > > > > +			/*
> > > > > +			 * If the base USID for this PMIC hasn't probed yet
> > > > > +			 * but the secondary USID has, then we need to defer
> > > > > +			 * the function driver so that it will attempt to
> > > > > +			 * probe again when the base USID is ready.
> > > > > +			 */
> > > > > +			if (pmic_addr == function_parent_usid  - (ctx->num_usids - 1))
> > > > 
> > > > Double "  ".
> > > Ack
> > > > 
> > > > Over-bracketing of statements with matching operands.
> > > I don't think x - (y - 1) is equal to x - y - 1? Or am I misunderstanding you here?
> > 
> > Can you give me an example when this would be the case?
> According to the Python interpreter:
> >>> x=7
> >>> y=4
> >>> x - y - 1
> 2
> >>> x - (y - 1)
> 4
> 
> C does also respect the first rule of BODMAS - parenthesis are always
> evaluated first.

Fair point, well presented.

Thanks for this - I understand the problem now.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
