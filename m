Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAF513975
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349810AbiD1QRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345615AbiD1QRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 12:17:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5381CFFD
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 09:14:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3303554wmn.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QfECKJ9jXKQdvjYOESszu+qVUD2KhaWOaYSTUAompe4=;
        b=xMorN3sTWcD2nS6xKLVHbEOd8t0eOKsHByopFCTW4WhxlhE3GjuXklradLCpxaARbY
         a9kUBZ2tzrHsX/cGw8hvtuwrYYav9abkp7XytTMgaaA7gQlZJCXHJxVdhcwPIAFmrVFO
         SjrvDcou0KbOjl8sWiL+cAcAwXr6/q908ODz7seDE0rY4zoU77RWF1LNCCxBdqh6rird
         /VTm/bOgzrD0TU4LvlvR1Kuct19Wv48dJNrEj8/L9SfC7wJ3VeogS1Qv2Y6MmFL66vRr
         6UeNVr9eOlsFF8n/tRs1M3b3yhV+jJE5B1kbUmK5KArTrog03mWozcpIoRdY52NDqlyj
         Jkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QfECKJ9jXKQdvjYOESszu+qVUD2KhaWOaYSTUAompe4=;
        b=kEyHoput1epQnSPXvAWQJR2fy79NE72NVEg+9XdN95GQ//ycKQ9pGqOImtkEjSH2m4
         FwC3fJ6GbUqLTfsuR5s6hoeToYHJtRPSg3Md1TNg+2UicsmnpkiL3jpb7mQBLlks6w/b
         Pzr23pf6Q4Ew4GUB3MSdRgDn2wV5dXJPZQrEeLrsazVkwI//o+bs7dOJsqJaMw3ZZpce
         KZWaaZ4lNCVqrs48kyOMFPiHPWFelIUlURHKVigzPNOv1iQWyj56TsMaiJOuOKDKsQE2
         TzqRWPZ/U6BGzd8rBX+OgQJgeAUG05xaSYkA/PumNJJqy8MkmVqb/HvlulTMarJVl6Sg
         ZZbA==
X-Gm-Message-State: AOAM530yVBJwGia4MX8DdfKAJUiiOlVOc/iDcQ0A1HVg0AuMqhVQJuPS
        fVWmHn9JXuWEbDJnZWTMIxQR5A==
X-Google-Smtp-Source: ABdhPJzlbC2j7+vYKVRNIsNxsAsJs+Q2hamjZ0PlHMilu9iBBMqmDiwhSbTNYXL5bTgnoQgygiz4PA==
X-Received: by 2002:a05:600c:1548:b0:392:8e1a:18c3 with SMTP id f8-20020a05600c154800b003928e1a18c3mr31915224wmg.102.1651162444697;
        Thu, 28 Apr 2022 09:14:04 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id s30-20020adf979e000000b0020adfb1292fsm227454wrb.16.2022.04.28.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:14:04 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:14:02 +0100
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
Message-ID: <Ymq9Su3UE5IYiHnI@google.com>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-3-caleb@connolly.tech>
 <Yma4T1+AglaISe2l@google.com>
 <2763f103-6947-e431-cef5-e202c324d678@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2763f103-6947-e431-cef5-e202c324d678@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 Apr 2022, Caleb Connolly wrote:
> On 25/04/2022 16:03, Lee Jones wrote:
> > 
> > On Wed, 23 Mar 2022, Caleb Connolly wrote:
> > > From: Caleb Connolly <caleb.connolly@linaro.org>
> > > 
> > > Some PMIC functions such as the RRADC need to be aware of the PMIC
> > > chip revision information to implement errata or otherwise adjust
> > > behaviour, export the PMIC information to enable this.
> > > 
> > > This is specifically required to enable the RRADC to adjust
> > > coefficients based on which chip fab the PMIC was produced in,
> > > this can vary per unique device and therefore has to be read at
> > > runtime.
> > > 
> > > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/mfd/qcom-spmi-pmic.c      | 261 +++++++++++++++++++-----------
> > >   include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++
> > >   2 files changed, 231 insertions(+), 90 deletions(-)
> > >   create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

[...]

> > > +			/*
> > > +			 * If the base USID for this PMIC hasn't probed yet
> > > +			 * but the secondary USID has, then we need to defer
> > > +			 * the function driver so that it will attempt to
> > > +			 * probe again when the base USID is ready.
> > > +			 */
> > > +			if (pmic_addr == function_parent_usid  - (ctx->num_usids - 1))
> > 
> > Double "  ".
> Ack
> > 
> > Over-bracketing of statements with matching operands.
> I don't think x - (y - 1) is equal to x - y - 1? Or am I misunderstanding you here?

Can you give me an example when this would be the case?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
