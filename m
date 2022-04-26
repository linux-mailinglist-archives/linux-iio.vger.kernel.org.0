Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0675106CB
	for <lists+linux-iio@lfdr.de>; Tue, 26 Apr 2022 20:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351223AbiDZS15 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Apr 2022 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351258AbiDZS1w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 14:27:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0A198C43
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 11:24:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q20so11772853wmq.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+SCJtuLLPCBIugzhmGROyOenrWlaIWVL1GHx1RKXQ04=;
        b=nntI83QQTS/o0PgqWKe78Wr/Fs7Rm4Eskmyw6Fc9ZUnLXEOEzdwyZ4D9skbnKDbf1I
         PaGaX7HxqO4WvGXMqz28D5yOrFtObmRpnP/7aL+ypyEKGi70g+DZBVCB5tuweBllAyOD
         /vT3/SyWlkJeaeo5SCcoedvh9KBVPgls0+VEecJNwud2dU0fmwnnYG+D4u4o6r+ocx7k
         Vsn7mz7BQcsEek2QZJqcz2GwyR9Wt16Zkq10n9tiRtM9OKx1ZFI57S0OhQ1ZuNRqiAJy
         UPQixnwjYm0CiEt5CWRFhEKn0nnI0oPn837Ny7wrD7WzyqK5KzwRqRop4m0ydqI1MnyH
         LL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+SCJtuLLPCBIugzhmGROyOenrWlaIWVL1GHx1RKXQ04=;
        b=z3taEtHffcTIoKXj+Y7QaAgDbumOGBM9HfmcOjc5wZI4cs3RMXr+G27G2fJGYsiBWh
         HqSwd9NsKGwqOZSsvmIBxHqOCG/Nmp6KUwjMXY5WFiC0ZwtAGNVxr7BO4gSMrZMqVTrJ
         +zZlEgxmQeq0RqG1MRBJT5rdD72lpihCiOm3J1UkBrAX3dGxcP80ecKwpA0+hZtmOaY7
         QdkIIngF5PyTcK3FmeKonGHjRdi2dbs0NPYe8yXNuGIH+legq3ZK3eDy7qdtufGoeOpU
         78tLSsZqPSWuxk11U+HyAlet0duCjV5eFxrjmR1N4KipETjTcX98te74CaWsfLAggXyX
         hffw==
X-Gm-Message-State: AOAM533jPjNaG/8PQWS5PDveHbboBNV1pLvPTS+RT22fsPWOPIX5WiKy
        H5Mzl0rX9Qhc+d5YrlqEMb+SaNwMUr9H2g==
X-Google-Smtp-Source: ABdhPJwz//6x4ICwKAzGCmmXVVYSEtHxdDp9dLUNvkRfLP6WxyjweH5Q18HN37vwRJIIiCxDpbUDqQ==
X-Received: by 2002:a7b:c0d0:0:b0:392:a02c:28ab with SMTP id s16-20020a7bc0d0000000b00392a02c28abmr31509324wmh.2.1650997482193;
        Tue, 26 Apr 2022 11:24:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b0038ecb2d2feasm11567536wms.4.2022.04.26.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:24:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 19:24:39 +0100
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v13 3/9] mfd: qcom-spmi-pmic: read fab id on supported
 PMICs
Message-ID: <Ymg455MYRIJTXgvW@google.com>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-4-caleb@connolly.tech>
 <Yma4tXvPQ+U89Whr@google.com>
 <10f7cb8e-4c2a-0bba-df55-16b56d429147@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10f7cb8e-4c2a-0bba-df55-16b56d429147@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Apr 2022, Caleb Connolly wrote:
> On 25/04/2022 16:05, Lee Jones wrote:
> > On Wed, 23 Mar 2022, Caleb Connolly wrote:
> > 
> > > From: Caleb Connolly <caleb.connolly@linaro.org>
> > > 
> > > The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
> > > the RRADC to calibrate ADC values.
> > > 
> > > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
> > >   include/soc/qcom/qcom-spmi-pmic.h | 1 +
> > >   2 files changed, 8 insertions(+)
> > 
> > Please change the Subject line to match the style of the sub-system?
> Hi, sorry if this is a silly question, I don't quite understand what you
> want me to change here, the subject line is in the same "mfd: driver:"
> format as other patches in the subsystem?

mfd: qcom-spmi-pmic: Read fab ID on supported PMICs

What's 'fab' should that be capitalised too?

> > Once changed:
> > 
> >    Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> 

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
