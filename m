Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7A2FEEFB
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbhAUPeO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 10:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbhAUPcx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 10:32:53 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D0C0613ED
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 07:32:09 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id y72so73594ooa.5
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrC/BtIGOSMmK8LojhA7HYYtVauAes9ugHyEOOmaStM=;
        b=zsmsXfxPeN1c5q6BDDydKmojMbFwdYUFugqo1wUWW1HoXkSCQFm9y6uswYIqP3tTED
         kYDlANpbvajQyu9x3lqlOHpBtwx0NzL4XL/RR781HzWDFzEyW6gj0yzhftTRYOPV/Wnu
         pTDD1RUi183xe0Op5lF1MzDEZK+w9VEYTI1yeRLEk0R9BD/5ZAUzqgbPsv1wtXH5JcyB
         dfTw+b//4KUx5OVqB5jhF1A3TokWKQaBoQK/ipVZQoxKvRmCd4WNs5Mbg1eaR4hF+q4e
         6nr7IqWCQOT96DahxU6HiLUdZ5VyKXgIUMnVVgBJMCueASom2HIK7QG3oeGdkjhu61W/
         G4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrC/BtIGOSMmK8LojhA7HYYtVauAes9ugHyEOOmaStM=;
        b=k6RSY/wD7EUJbX8rtL2XxvhAhpSn2rgZUrZ6qiLrOrwsQBVTOFfM8j3r/4Qlwh1/m6
         ltUZhNFxrinYE1ZcyM2BCoZSiSG1RawAgammnoX+/OVNfWYFNFXVtt0bnrkojytMlisQ
         6di1P9G1kIjLpAyE9gRnwGXDw1EzL7X1c1j6fgEm8z9TfGxGuCirfJocF7KbCDEqMmpn
         j3WGLb1fwLK9cmE89jpUJu7l/Sx8/w1tLjPhm6aeHvU5E2DYR1wqVhaykPoG27Yhrs/X
         7fWPbPnCXkj179gkxe2tWHMJywXgOqcwiYfhWEfF1tg3q4M8v43pAhEPQJYdbvP+W5BL
         nctw==
X-Gm-Message-State: AOAM533kyLgojAmlsKQ2SbreAw/NNJlwed9z7n2TYAkx8UE3MFXYgomu
        r/NKckwt5rAs34Oeq4YleN7kcw==
X-Google-Smtp-Source: ABdhPJzRDqEsIBxCVlEnwYonZwjyr88XzHSrBOjAp45xooIVZZMHYE2AVKTNIKCNX1WxITcrXDFSSA==
X-Received: by 2002:a4a:c692:: with SMTP id m18mr85815ooq.59.1611243128557;
        Thu, 21 Jan 2021 07:32:08 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y24sm1031116oos.44.2021.01.21.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:32:07 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:32:06 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: Re: [PATCH v12 0/5] qcom: pm8150: add support for thermal monitoring
Message-ID: <YAmedqs9/1oDSWvK@builder.lan>
References: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
 <078a7025-ce5c-a252-f8f4-694c56153b3a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078a7025-ce5c-a252-f8f4-694c56153b3a@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue 19 Jan 14:57 CST 2021, Daniel Lezcano wrote:

> On 19/01/2021 06:48, Dmitry Baryshkov wrote:
> > This patch serie adds support for thermal monitoring block on Qualcomm's
> > PMIC5 chips. PM8150{,b,l}, qrb5165-rb5 board and sm8250-mtp board device
> > trees are extended to support thermal zones provided by this thermal
> > monitoring block.  Unlike the rest of PMIC thermal senses, these thermal
> > zones describe particular thermistors, which differ between from board
> > to board.
> > 
> > Dependencies: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-5.11-rc1
> 
> Shall I pick 3,4,5 also ?
> 

I believe I have some adjacent changes staged in these files, so I'll
prefer to pick them through the Qualcomm tree.

Thank you,
Bjorn

> 
> -- 
> <http://www.linaro.org/> Linaro.org ??? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
