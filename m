Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAE269041
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgINPmB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgINPl2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 11:41:28 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EFDC06178B
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:41:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w25so315992otk.8
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZELQhGU+/XtL/55nDBDugsi7ueM9gHLCZBficN7FL9w=;
        b=kldHqlgVGZ/L1PYKcsqUtEnMD/Q9aXDKd/gxzvCZ7KQiWwV87i0LUwBn0BrZo8xr4K
         FAAP45tRfhJ9KXuDoUxhjfwwcNO6alrS4tySG00FInO7DLbCqX+7pX/tDsyV5k2SI8xJ
         S7IBlUXutBVAu+M2zfeIH2IOfe1WdG2iNSOpBlqo2YR+ovIP4Lk427LLi70ohF/Ht7hn
         Jl02Kik0j6p5/XYhF/AK59H3zr4ZeAzThOSl8QjXW0ipDwsndDXaoow/H5mpu1yr3wYm
         H8OaA7NZjHv6Mq+h9JurK+57q9o3kbzIPUqme/9WuZut/XtoaemL9D87iVKfOmqNKEIp
         PB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZELQhGU+/XtL/55nDBDugsi7ueM9gHLCZBficN7FL9w=;
        b=fXio4lvRGGEzLK+nqTAZhBFm6FsyFghMbxY5Y0X3Mw3fDEt9SdXHJZHiwZ5+tgeudu
         IGYdodO9bSgDiEYK31alnc9ux6mHuvE9o6Lg9i332QKx8K7liOWUBZfhdMnFf5trf59K
         M9g7zNc+xZBLsLSw79DaeoeP1rWMBz1lzQFHjaO9f2aqYaUom/dMHKTJp+CdkSh9nk38
         AmFUw7p/Mpf/JtfXJR0HwXlv3w2tmuNODdV3ajlcdaJ5VBOydiMsaq6v+0NsqOlpgPHH
         SBRNDYX9z5zDMi7qQsZdOXAoDgQ/Bqln/1mdSzdOQ4VUmDVODI0/4pEr2gT0kgn9jOBx
         uLfw==
X-Gm-Message-State: AOAM533M62ZsUt9VDRhNPx2/PsN0RiCZfykuiNwLWOWFnKRLCXKpcGJ0
        kaoU4CaPBtABB7w8s929c2KlAUX9o7aNvQEZpiZeYA==
X-Google-Smtp-Source: ABdhPJxOXHJTmnoyvncutLUljQZPNcmmjD8ZnonC/r6sp0kl55kb8ZXthIsQjiYohus1Nn/JEPZJ+ZDFIEELZu6L0OY=
X-Received: by 2002:a9d:7350:: with SMTP id l16mr9254540otk.368.1600098086769;
 Mon, 14 Sep 2020 08:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
 <20200910140000.324091-9-dmitry.baryshkov@linaro.org> <20200913111544.20a03410@archlinux>
In-Reply-To: <20200913111544.20a03410@archlinux>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 14 Sep 2020 18:41:15 +0300
Message-ID: <CAA8EJpr4JSa9+3K1txbhyw64PgKdri_WNbW3yvQSkYMkD-zKYA@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] thermal: qcom: add support for adc-tm5 PMIC
 thermal monitor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Sep 2020 at 13:15, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 10 Sep 2020 16:59:58 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > Add support for Thermal Monitoring part of PMIC5. This part is closely
> > coupled with ADC, using it's channels directly. ADC-TM support
> > generating interrupts on ADC value crossing low or high voltage bounds,
> > which is used to support thermal trip points.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> A few trivial things inline.  Only one I'm really fussed about is
> filling in the rest of the kernel-doc. I raised that in v2.

Ugh, please excuse me. Probably I missed that comment.

>
> With that fixed,
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
With best wishes
Dmitry
