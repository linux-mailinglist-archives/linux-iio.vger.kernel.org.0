Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2433F1EF6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 19:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhHSRWO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhHSRWO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 13:22:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC551C061575;
        Thu, 19 Aug 2021 10:21:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so6126667pff.3;
        Thu, 19 Aug 2021 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egaoZwC4rZ4/dIah6if50WUKCEkDpfq88EIvJ7O/wVQ=;
        b=TI2jtzCrSXvEeb21lI4jkNgetmIdroz8sDWZm8yrT2dk0MWKikhsPwuwx6r5dnKird
         p+fuTjZiq6caheadW6ugPBt1rKWBiI2dTzQYM61tVqEtTLwVLnIxgnptnS7OBlDi3XS7
         SE0Oz5IkAan4WQahRNDVLvJr2p/6Mz3Q/C2+R4UkeHie7K9nBmdvaRH9uaXyhtG1UR4U
         a0cOUtyRoYHahHnESguDOUA24XBdxxIaPbFfDoN2uur1htIgXnCbXZ1gsrQPABaa8PCr
         TSOll4M3fxc+zHq+DNKtJSDVZw/0NlDSunHe+0/vs5CaEvJHhjWZxPU35EBXaPolcOH0
         Cc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egaoZwC4rZ4/dIah6if50WUKCEkDpfq88EIvJ7O/wVQ=;
        b=rnyOaznuFFVZPshT7GmlbIXa3hjkqC8RqkhEwWSp4MvNnD9SDhfMXUxLC0NEnhBIxV
         A3NWs/6FFHi/BNXqkEPVQdYEvWXtQ1Hx95DF5v27EvmtwM47zl1yEX7n6aD2Tdmzxj8S
         lgkGb7piEN1VXzZcZEvl2AfAZMvDe/y7rFE9unAT7IFNLRLPJmodxmXQLDUJyFoFiokZ
         BPN0FFUItm9q5AOjijCrZ6mbqgeIcdHYsfrcsdroAG5Z1A1YBSHZL8MyKBAVvCmAoGYq
         RSY5CWJt49Y6x3Dx6+PZyzyo0cIBcz3KQsgARA3cdaoPO6i4tP82UpnEEPFLxh32fNSW
         eY3Q==
X-Gm-Message-State: AOAM5326ucA4r4NvVGl5ZV+LFd/G3DLB8oMZIRKyDKvbGM//Ryw9EaZg
        R+WFdWEz2Y/X+ro6MhRwQmJPQCgHhXoW8rOxYWA=
X-Google-Smtp-Source: ABdhPJzwN8rJH6SfevdmMC4vWF3AK9ZlnfxilFbELXr1BPdg0mV6edcRGUbzLP7i1IqOoxx1lb4fB/dCaWcPy0hMX8s=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr15038622pgg.4.1629393697365;
 Thu, 19 Aug 2021 10:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210819132416.175644-1-yangyingliang@huawei.com>
In-Reply-To: <20210819132416.175644-1-yangyingliang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 20:20:58 +0300
Message-ID: <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com>
Subject: Re: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 19, 2021 at 4:19 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume().

...

>         ret = clk_prepare_enable(adc->adclk);
> -       if (ret)
> +       if (ret) {
> +               clk_disable_unprepare(adc->pclk);
>                 return ret;
> +       }

Huh?!

-- 
With Best Regards,
Andy Shevchenko
