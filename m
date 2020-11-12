Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E62B0612
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLNN4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 08:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgKLNN4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 08:13:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F33C0613D1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 05:13:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so5921278wrf.12
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bo6b3plJGeSCfqA2TlRi1WC3RGLlmTiYJkUzuyFzqgg=;
        b=xqEnu3qOxGCBmIvnubq6qgbQFbZ1GALhsKcWy3ouPmFAnGxWqncXENS0E3AOCV/4+J
         ZDMV3iem5aUNFgb9zxQzPdO96qfck5iIHcs1je+WjE2DSXc334BC9pqMG3SFMcvEtTg/
         yuVD5XBeRhIdSwyjRHrf4yQW3rk/eqUvkIl4h6Ne11juJcsx+O1i7hZ9e3+CO0l5itft
         K3DCOwWVVAkP29iBXMUkxPs94dS/gxyICz5wV7bfoVg6Q92Onq0nSzbvgP/0B0UUKIMg
         koAMbzCfFK8Z2RVYcLIVKvncInJ/mhAeKnJCSd3dcpfz9JNQkAzEBrKHvCRZjCJ12xzX
         TMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bo6b3plJGeSCfqA2TlRi1WC3RGLlmTiYJkUzuyFzqgg=;
        b=aVKqzE9+o/65wDPzFFiXsrrw0//Y/LQVl99zjgf9KzSAMgX0kxSOP7csD7OH7y+UC3
         8MzNsaSY0dDyCmogzqEANd6kY0S018vrSC6wkBjhpEgnlll6PweiQnayoKm02mrZQ2UL
         1spOWfbJaFteLF0bqFfciaBSre+rLw5XYk7SmPyeUP9alrngUs2VQOccQrpEIST36/TS
         bWl/f+8gX+RMCvt9AsNiXy41j1nIWg8/o8E7UlABS1XlPfDMqpLbxFOJP4+9AlSi7xnz
         9bIPg6xo8fZsS/JH+tKNa4rPqO1Abq3YzV6WmMaSzU+0QEBT+2mEllppWv8c8jYV4bad
         3rCw==
X-Gm-Message-State: AOAM532V1sJSsIvwge8awkuoGh2c9nikpiLNlMLL/UJ8R/YIAipIur5L
        5ADwnUvVD6BcP/kDygofEsvyOg==
X-Google-Smtp-Source: ABdhPJzSZTM0aetNvyM1aDGThFnDswNgJp25u/ogvbOp/15JLROiREI2JWpn1R9Gf3vaCpfyMX0yHg==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr9205512wrt.348.1605186833116;
        Thu, 12 Nov 2020 05:13:53 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id f7sm7379008wrx.64.2020.11.12.05.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 05:13:52 -0800 (PST)
Subject: Re: [PATCH v9 00/15] qcom: pm8150: add support for thermal monitoring
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
 <c943f56c-f72c-0f14-b6ed-b67e91573b1e@linaro.org>
 <CAA8EJpp+=sQAre+kCiDLEFT+gDB0wO7KypGTXeCDncO8wWzQ-Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a66e75c1-ce30-df75-c77e-e58e660f0105@linaro.org>
Date:   Thu, 12 Nov 2020 14:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAA8EJpp+=sQAre+kCiDLEFT+gDB0wO7KypGTXeCDncO8wWzQ-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/11/2020 13:41, Dmitry Baryshkov wrote:
> On Thu, 12 Nov 2020 at 14:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Shall I take patch 1/15 and 12/15 ?
> 
> 12/15 will not compile without several previous patches, so it might
> be better to take all of them through the single tree.

Ok, I will take some time to review the driver and ack it, so it can be
merged through the iio tree.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
