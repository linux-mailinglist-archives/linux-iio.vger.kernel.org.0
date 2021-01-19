Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C442FC1B4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 21:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhASU6r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 15:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbhASU6o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 15:58:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA3EC061573
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 12:58:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i63so1006005wma.4
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 12:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=of/pRXfYf8KADmbm/k7eAlaIB9piSSwAWZ8glb4h2lk=;
        b=ccFf+1ObrkxxiKN/zv8a7jjbmKQyeEBznWyroAQD9yAVMaTnl+JtmHf5fIQ6Rp+Rob
         yF6h+EoyFK6Nz8ldK6DIOj3AlTamfWWRGssGaVrp0pH3oJyLLVbDPqFujsScurwkRcWl
         W5s3zsXqXedGuTW5KIVCMkdQMRm8U5j6auWhsAC7XoBgP/6bNtGTGQq2dheNWz4C+hQm
         03s+pcyRBjTWifFxRg0eOAj3uT1X5kZtY43JsBlyIx0DaudguLPTC/wtCvNhziENpMaK
         s24C/rJOhJfvsmE6w/eGa2e3KP5nCwFcaWp3A/+ugQQn4g/rmnPvx4dpPeaHRHZBHFCO
         jhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=of/pRXfYf8KADmbm/k7eAlaIB9piSSwAWZ8glb4h2lk=;
        b=j5xxVS3qW87fCbR/DYV+uOFF3S7OrEmtB+Q9MPVLpFjNc3MmOa3YWulVZZm2OTN28E
         rapdOsRc3vydNKSW1P5/fpe0j6FmfTJPd0Jc9yj3U+P2j2iHmhLfwsCJADcWwBhERL60
         IlOAD4O0v7nabl6K30gI+4Ai+RNeuWbjctGjriaDjoHqUZmj5KVYPWQi6Qj+0dN6dEWP
         ZvTPDW80wIjpA9nF7cyfucHwEAKnYxV0rV7JDjoZt9o1HaSu4jVuSWnhVrqUBp37nWuF
         MRVJj1FgpTykRxLbvzfe+sNrc+Q+EdxoPrWD0Qs6NDIIVSNhM/g6S1FhCxlrQc9P11bz
         Wbzg==
X-Gm-Message-State: AOAM532snLe9e4Ot+YFdq0lCZDTb2ETAD+CiMuqailZtqtioDY0unMNh
        dfpUwvnoU136xECZ8rp6muyyvA==
X-Google-Smtp-Source: ABdhPJwwlkl7tUgr70Wbh1Oql8bMdbNpHNrfJ1G+pno8wXk6Ry+lDe8WS36QVLc2VM7Vg8xp0m5a8w==
X-Received: by 2002:a1c:6089:: with SMTP id u131mr1230059wmb.187.1611089882759;
        Tue, 19 Jan 2021 12:58:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c8a3:239a:c6eb:c10b? ([2a01:e34:ed2f:f020:c8a3:239a:c6eb:c10b])
        by smtp.googlemail.com with ESMTPSA id a62sm6592680wmf.7.2021.01.19.12.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 12:58:02 -0800 (PST)
Subject: Re: [PATCH v12 0/5] qcom: pm8150: add support for thermal monitoring
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <078a7025-ce5c-a252-f8f4-694c56153b3a@linaro.org>
Date:   Tue, 19 Jan 2021 21:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19/01/2021 06:48, Dmitry Baryshkov wrote:
> This patch serie adds support for thermal monitoring block on Qualcomm's
> PMIC5 chips. PM8150{,b,l}, qrb5165-rb5 board and sm8250-mtp board device
> trees are extended to support thermal zones provided by this thermal
> monitoring block.  Unlike the rest of PMIC thermal senses, these thermal
> zones describe particular thermistors, which differ between from board
> to board.
> 
> Dependencies: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-5.11-rc1

Shall I pick 3,4,5 also ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
