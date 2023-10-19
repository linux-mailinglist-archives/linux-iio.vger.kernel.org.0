Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C347CEE89
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 06:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJSEGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 00:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSEGg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 00:06:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B8119
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 21:06:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso5600291b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 21:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697688393; x=1698293193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQIMJ/nxxafee7WyxE0d+o9+7mfW1f+sldaH4ghTpNo=;
        b=YSo4ZV9wRaNJO23IHnuJg4u2Agufp6YcnLHU0i288i0/ihlyPExBf8C8zhXl/0P1nm
         QD6yQ0naylX/wcb2ViIKhnuXzOBYr1TbdEmAihVIdkXp3hFeBsQcNEj6HjueCCdOYMey
         UXLCYN23HyOthNPi4ou5gWv5eDhHtaXbGZyszzGF+Xwt+nk3DbSfkztBzPXu4xtWG9Wp
         3sLKGF5LV9ZlvvkU8EGaCVHFjw4swssEkCSajhASFcik4TTyqiXVNi7D7NpouLQKU/EU
         yZPc8RsL/7LhVhFtyTdU0nT6d4CP1Iy06ljeBq/RPeFcndhrlvEhdIs4CkLkrZ3lOxms
         lU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697688393; x=1698293193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQIMJ/nxxafee7WyxE0d+o9+7mfW1f+sldaH4ghTpNo=;
        b=l74pR8ILjuXXg0lCgJuLeIBgKYdrVMuPWyV+v4vk6ccOMwwMe2BtcWGcwlsyO8qQeI
         1ceFjZcPqk0RAPEQS9GQVPYyep279DKrwUa5b1wv8PHjlha2N4g9HU5Bkfp6jxbcREw+
         043UzfBfxAiGWQijvXjFFDh2neOBCAkvN9MpN4BOkgMA8yhXNSPDfYXDNI/UUgcuvagD
         MscdwJx2XFVt5wY6aXMfO2aWznRgnOdZ7Y0ZnPaVhSc1kIKuTSMdUtWG1TMrMMTDsQNT
         +a6oZn4BmTQgA1s64aunBfPQTPCaiexJH4ljDDiqaJvFvR+l+jbYclB43l904zbNNKGc
         WbCQ==
X-Gm-Message-State: AOJu0YxWmBFip31w468kpOR6VjmP6YZ+NH2oaCFsaSx+BY0lB4XT0/hm
        pILaS6Y9xd/v2RJFt8urh/XG
X-Google-Smtp-Source: AGHT+IGP8RYAqcC88qwdKj5FydUxjIzvKQRY7eQzz8t/NsXRcn/MCN9hzfd2K6b1Dw4tL9sPvOVWrQ==
X-Received: by 2002:a05:6a21:7742:b0:16b:977d:f7cf with SMTP id bc2-20020a056a21774200b0016b977df7cfmr1127597pzc.36.1697688393183;
        Wed, 18 Oct 2023 21:06:33 -0700 (PDT)
Received: from thinkpad ([117.202.186.25])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709027c1300b001c3721897fcsm717665pll.277.2023.10.18.21.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 21:06:32 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:36:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sm8350: Fix remoteproc
 interrupt type
Message-ID: <20231019040623.GA5142@thinkpad>
References: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
 <20231018-nia-sm8350-for-upstream-v2-4-7b243126cb77@igalia.com>
 <6ac842b8-5fcb-4094-8488-4d6e250bf102@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ac842b8-5fcb-4094-8488-4d6e250bf102@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 18, 2023 at 10:17:15PM +0200, Konrad Dybcio wrote:
> 
> 
> On 10/18/23 16:25, Nia Espera wrote:
> > In a similar vein to
> > https://lore.kernel.org/lkml/20220530080842.37024-3-manivannan.sadhasivam@linaro.org/,
> > the remote processors on sm8350 fail to initialize with the 'correct'
> > (i.e., specified in downstream) IRQ type. Change this to EDGE_RISING.
> > 
> > Signed-off-by: Nia Espera <nespera@igalia.com>
> > ---
> Hm, apparently 8250 and 7180 have the same thing.
> 
> Mani, could you elaborate on this?
> 

So the remoteproc driver expects the wdog interrupts to be edge triggered as the
rest of the interrupts, but DT specifies them as level triggered. This won't
cause any issue during the first instance of the probe as the driver requested
trigger will be given precedence. But if the probe defers for some reason and
during the next try, request_irq() will fail with error similar to below:

irq: type mismatch, failed to map hwirq-x for interrupt-controller@xxxxxx!

This error is often confusing and I tried to fix it. But Maz didn't agree with
me, so I just ended up fixing the DTs for some platform I have access to.

So ideally, DTs of all platforms should be fixed to pass correct trigger type.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
