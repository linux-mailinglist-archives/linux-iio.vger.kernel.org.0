Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475F1DEC4F
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgEVPmM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVPmL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:42:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197ADC061A0E;
        Fri, 22 May 2020 08:42:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w20so140963pga.6;
        Fri, 22 May 2020 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sv9pvfwqBcoNP+skkNSWNXJEe0eEqSbnxl5w+lZkjdQ=;
        b=CJJ/rQAmyH5meit7+76N2Fxm9Keswf6rHFRTDvyuMbB/TXK86HDjZqaA/a3t657MxK
         fK82vSBrD/bS+kKEeE8kLng+spPeEqmL7ZYgP0Kw8sPOD9txTjhSXs+WxAgxDg0b/XB4
         ghfRrCFCfXI/+a05B4LVXB/LruDVNfhrcBgzC1cAEfSKceA/cG2PT/L7g338We+R2lUp
         9/ekq9tSCRdQMHWpUY+Vd0/rI6/+mJjIJuQvKDfWw8SFqPiqx+DI0zysTc0MJtNyP+nG
         QWKbY0+S+mG5liXwUo/lPIk76easwGgn1bssO+OXAzs4Td/FP4i1IiW1Lp8RERlO/TlG
         4LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sv9pvfwqBcoNP+skkNSWNXJEe0eEqSbnxl5w+lZkjdQ=;
        b=Oye84nLFuSCgzG3vvOS74VW2Oi/62JysmNiOrJpS8K7S2iC0E3aMfzbVwPvPKu4yEh
         pOw6sdFWYlMqxvRKJ7dig4e3EqSumbFgTtBO74BJUq9dQUZTKKmS8Ua5AvJu9rPjJUKm
         sJdUXJCJsvsN66r6X6p+jCmSyL55zod3xO2lF5IM0GH0b6ILnU55uaAw9IP6eF7zf7+3
         G+UslFw+yB8dM8w/fNzcekkVH3W9vVJsaLYxYBomyOBd9QTleMjtXCTcWz6zP+5UOS+w
         a6amlg3kcCudn6ogufzLQvKkfuXYGkFi+yZcA6jKLjo64ehgyFWDNalA/UZ1IF7g/q7y
         gNxg==
X-Gm-Message-State: AOAM533XDpe0Q90bIQ1je6oykaLm+0jsYzpvKG9bDC1rI3rHkhHXcf2j
        VCBbprvCqsaImecGiSuf47S3eIrLuAZ+povWzWw=
X-Google-Smtp-Source: ABdhPJyP3SHIJcjXhymTa/izkoVLtzQWvpcKPRnmcp/2hlYw/Kzosnk76+L+Mq2CZkqLOs+/GYZNzzrG4kobRmJ31/o=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr13730040pgb.74.1590162130668;
 Fri, 22 May 2020 08:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
 <1590157452-27179-4-git-send-email-jprakash@codeaurora.org> <CAHp75Vfgk0-Rye2We1A6_WTWMCK3D-WW4_T3CGPHc=-tB=6M9g@mail.gmail.com>
In-Reply-To: <CAHp75Vfgk0-Rye2We1A6_WTWMCK3D-WW4_T3CGPHc=-tB=6M9g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:41:59 +0300
Message-ID: <CAHp75VcyUtPz5GVPw16i8Jn5tGYwVnwVt-uBTMD0NuJ=TZvXjg@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iio: adc: Add support for PMIC7 ADC
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 6:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 5:25 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
> >
> > The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> > major change from PMIC5 is that all SW communication to ADC goes through
> > PMK8350, which communicates with other PMICs through PBS when the ADC
> > on PMK8350 works in master mode. The SID register is used to identify the
> > PMICs with which the PBS needs to communicate. Add support for the same.
>
> Below should be in a separate patch, but it's a bikeshedding. So, I
> left it to maintainers to decide.

> Fine with me

Fine with me *after* addressing some issues below (besides ' < 0' part).

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
