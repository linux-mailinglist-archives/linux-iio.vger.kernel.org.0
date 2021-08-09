Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBA3E3DF9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 04:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhHIChR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 22:37:17 -0400
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:53490 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhHIChQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Aug 2021 22:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628476617; x=1660012617;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=S5CPTabNoTndrACQMK6Rmlxzof5oq7hgo1skvEPN0Y8=;
  b=pkX+g00D+xyKcHECM113YL92k9A4mfSQF/vDN6ADq7j7vMp7g17NeIfl
   3/2Fi4JgmeiIcrTJiT8QpmDZkeE4ohTnu++3Q46SXAUq6YlbfRkqbQk2g
   uyWeaVAu/KHZEihcoOI6butUxv53bJHODSNBqg21JVeiAXYulwBy6P543
   luHwC22Fj46cFcloN0KqoVoRgmF03j7K2fEElVTWzrOAWynIbIMYdY4rd
   v+BCNE9F/qy4NhAQlbii21cFWZMDKlon9uq73mtloRU+5tMtHLp0xYdBj
   5bWQDLgfnCl6LmPc/Jfv9weuEZReJOsRrL+PLCzt/ExzvfvT9aIKSec7p
   g==;
IronPort-SDR: oafu1XLNM7KRfmWXA+b9DOgPyHi4acxaSJ1orVpQ+z+DntTirGGJAFf5XcLMvkvlZIhXb43txn
 UJ00PKp8NSSPTZeS+OOKVig1FP9yfTc7w27sGfHAmTRHERrrTHcNo1uI5TgvK8YmGcdIIhxAPo
 qRZUi1Tz2DSbS3i88K6Pg0cU712zN8o7Tq1hdRevk4Sb8zI7FmrMJVVlf+9u3IMkD2gjsT1gyl
 WXRzF19W8vIOAMHJReQ2u1Qhnj66KaRql3/NmgnnVE9YPhH30bmicjmCHxeOqu5ybDL2ZiNdSt
 +28Wzc/hQOeJSwKzED+XSVWJ
X-IPAS-Result: =?us-ascii?q?A2EeAgBjlBBhhsXWVdFaHgEBCxIMQIFOC4N4bIRIkW0Di?=
 =?us-ascii?q?lmRCYF8AgkBAQEPQQQBAYRYAoMFAiU0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBAQUEAQECEAEBAQGBIAtZC2OBT4F5BgQ9gjUpAYNtAQEBAxIRBFIQC?=
 =?us-ascii?q?wsDCgICJgICIQESAQUBHAYTIoJPglYDL5xfgQQ9izJ/MoEBh1YNTgEJDYFjE?=
 =?us-ascii?q?n4qhwuGZCeCKYFLgQWBMzc+giCFO4JkBIIsYwcBFScWKBMcMgcGaS09ESoRf?=
 =?us-ascii?q?wEBAZNbAYtQnDxbAQYCgw4ckkqFGQl8hWMrg2WLYIYAQ5BnLZAslSiVQhAjg?=
 =?us-ascii?q?T2CFTMaJX8GZ4FLTQECAQIBDAIBAgECAQIBAggBAQKOKA0JFY44JC84AgYLA?=
 =?us-ascii?q?QEDCYpQAQE?=
IronPort-PHdr: A9a23:TWZLyx3lbJP97+8MsmDOoQQyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaHo6ozxwKQFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9qr2+yo+ZDeYgpEiTqgbbhvM
 Bi4sALdu9UMj4B/MKgx0BzJonVJe+RS22xlIE+Ykgj/6Mmt4pNt6jxctP09+cFOV6X6ZLk4Q
 qdDDDs6KWA15dbkugfFQACS+3YTSGQWkh5PAwjY8BH3W4r6vyXmuuZh3iSRINb7Rq4oVzu88
 6hrSQfoiCYZOD4/7GHXkdF7gKZCrB68uxBz34vYbYeIP/R8Y6zdZ8sXSmVPXslTVyJPDICyY
 ZYRAeUdJutYs5XxqkESoReiGQWhBuXiwSJIiH/s2q061vwsHgPH3A0hH9IOrXPUp8j2O6cSS
 ++1zbTDwDLDbvJX2Tfy8onIfgw9rfyCRr9wbNbeyVM1Gwzbk1qQtJXoMjWI3esCr2aV9fBvV
 f6zi2E5sQFxpCCiy8goh4TNho8bxE7I+Cp9zYg6JtC1R0B2bN6qHZZMtiyXK4p7T80hTm11p
 Ss2174LtIC1cSUFy5kq2hDRZuGbfoWO/xntV/6RLC9miH55fL+znRW//Ei6xuHiS8W530xGo
 jdBn9TOsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5oTrVzPHi/ol0Xyi
 6+bbkAk9fKp6+Tje7nmvpucO5JthgHwL6gjns6yDf43MggJWGib9uC826P58ULlR7VKi+U6k
 qjfsJ/EOcQWvrC1DxNR34o56BuyDy2q3MoFkXQINl5JZRaKgorxN1HLOv/4DPO/g1q2kDdsw
 vDLJr3gA5TNLnfZkbftYapx5kBHxQou0d9f/YhYBa8cL/LuQkPxrsDXDgclMwyoxObqENF91
 oIYWWKSDa6VKaLSsV6P5u80PemMa5EauCznJ/gm+fHul3k5lkEZfaWz2psXcn+4TbxaJBC7Z
 nzlntcIFy8htw8zVuvswAmAUDUJPF6xUrg66zV9D5ipW9TtXIeo1Y2AziemGdVkZmlHQgSdA
 3fhdt3cAN8RYzjUL8N8xG9XHYO9QpMsgEn9/DTxzKBqe6+NonVwiA==
IronPort-HdrOrdr: A9a23:KZ9/x6OnRu1WWcBcTvqjsMiBIKoaSvp037Dk7TEJdfU1SL3hqy
 nApoV/6faZskdyZJhko6HiBEDiexLhHPxOkO0s1N6ZNWGMhILrFuFfBODZslrd8kPFh4hgPG
 RbHpSWyuebMbG3t6nHCcCDf7gd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="62362304"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2021 19:36:56 -0700
Received: by mail-pl1-f197.google.com with SMTP id u2-20020a170902e5c2b029012cb0f6543aso7719534plf.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Aug 2021 19:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXT+reKNAAdaXSEr1r6kToV8qtLfQIdGnpz4v9GHBhI=;
        b=MKCZMdPROld9t8Dn3T6IM3qGPh2OjIls/9odqfx1xJ/LEc9t+TTKzZqG+SSDFTPMnx
         sMg/mEix93r4AgXbBAdfQkDv3IkGCYGodqWUnS9mvN2JdetRTaSwEtM/DYWcWF0CUq3w
         oik//RTo5CIjfq5nV3v8dbQkqzMbBtFs6N281wDB90t8Fhsc9M05yGCrNVYhNZAtP+Hs
         cUvaHDGv2O20b0/7teUDMqTx1gn4yNjhLfN5bD6+65jqXKsv2rJLEXATUTppPTfZ5qx6
         WALd2svb5fI72zVcvXAhHOmbxbkS/9ANDwRiwnHtJUg+XqpmJrkJMtUqNIatwSzM/Y6q
         YiEw==
X-Gm-Message-State: AOAM531j15svo0rI3ra/SBUuUqN/gdhnbpcukBJD8klKbpXWrQlNi6+I
        mIQocn0rLPT3j8KvEYOMSjleAqaXUxGxmml/a5ySvJW1YASZprYlc1ihqduEPQMXNDjn4LfgwKU
        Y2FVfq4t1e7GljzeHE7eDyINpbECLyWMDII7HCg==
X-Received: by 2002:a17:90a:448f:: with SMTP id t15mr22860881pjg.21.1628476615284;
        Sun, 08 Aug 2021 19:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmi7KyD7gC/LNsTSN7LbNllZcAdD362fcg3154hLUGjINb7m4IUt/iss0EBAvzX9fyKwU+IE1XNo2+BlsUz3s=
X-Received: by 2002:a17:90a:448f:: with SMTP id t15mr22860872pjg.21.1628476615053;
 Sun, 08 Aug 2021 19:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210719195313.40341-1-yzhai003@ucr.edu> <20210724164840.7381053b@jic23-huawei>
 <20210808183243.70619aa8@jic23-huawei>
In-Reply-To: <20210808183243.70619aa8@jic23-huawei>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 8 Aug 2021 19:36:44 -0700
Message-ID: <CABvMjLRHs61AAYqTeRWV0DHciLBoqHwJ5Djg7ZseYkjE=JhbQg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Fix the uninitialized use if
 regmap_read() fails
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan:
Thanks for your effort, and yes please take a look just in case.
FYI, I made the modifications align with Alexandru's help, this is the
original reply:

On Mon, Jul 19, 2021 at 12:47 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Jul 19, 2021 at 2:39 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> >
> > Hi All:
> > Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
> > could be uninitialized if the regmap_read() fails and returns an error
> > code.  However, they are directly used in the later context to decide
> > the control flow, which is potentially unsafe. However,
> > stm32_dfsdm_irq() returns the type irqreturn_t and I could not return
>
> Just curious: are you seeing any issues with these variables being
> uninitialized?
>
> > the error code directly. Could you please advise me here?
>
> The correct way to do it, would be:
>
> ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> if (ret)
>     return IRQ_HANDLED;
>
> IRQ handlers should return one of
> enum irqreturn {
>     IRQ_NONE        = (0 << 0),
>     IRQ_HANDLED     = (1 << 0),
>     IRQ_WAKE_THREAD     = (1 << 1),
> };
>
> If you want to fully optimize/correct this, then it may be something like:
>
>         ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
>         if (ret)
>                 return IRQ_HANDLED;
>
>         if (status & DFSDM_ISR_REOCF_MASK) {
>                 /* Read the data register clean the IRQ status */
>                 regmap_read(regmap, DFSDM_RDATAR(adc->fl_id), adc->buffer);
>
> // in this point, we could check for regmap_read(), but it won't make
> sense; we should call the complete() handler, either way
>
>                 complete(&adc->completion);
>         }
>
>         if (status & DFSDM_ISR_ROVRF_MASK) {
>                 ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
>                 if (ret)
>                         return IRQ_HANDLED;
>                 if (int_en & DFSDM_CR2_ROVRIE_MASK)
>                         dev_warn(&indio_dev->dev, "Overrun detected\n");
>                 regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
>                                    DFSDM_ICR_CLRROVRF_MASK,
>                                    DFSDM_ICR_CLRROVRF_MASK);
>
> // in this point, we could also check the ret code; but we still need
> to call IRQ_HANDLED anyway;
>         }
>
>
> Quite often, when regmap_read() returns errors, then something is
> seriously wrong in the system.
> Something else would usually fail or crash worse than this interrupt handler.
> That being said, properly handling regmap_read() here is a good idea.
>
> >
> > The related code:
> >
> > static irqreturn_t stm32_dfsdm_irq(int irq, void *arg) {
> >     unsigned int status, int_en;
> >
> >     regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> >     regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> >
> >     if (status & DFSDM_ISR_REOCF_MASK) {}
> >     if (status & DFSDM_ISR_ROVRF_MASK) {}
> > }
> >
> >
> > --
> > Kind Regards,
> >
> > Yizhuo Zhai
> >
> > Computer Science, Graduate Student
> > University of California, Riverside


On Sun, Aug 8, 2021 at 10:29 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 24 Jul 2021 16:48:40 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Mon, 19 Jul 2021 19:53:11 +0000
> > Yizhuo <yzhai003@ucr.edu> wrote:
> >
> > > Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
> > > could be uninitialized if the regmap_read() fails and returns an error
> > > code.  However, they are directly used in the later context to decide
> > > the control flow, which is potentially unsafe.
> > >
> > > Fixes: e2e6771c64625 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> > >
> > > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> >
> > Hi Yizhou
> >
> > I want to get some review of this from people familiar with the
> > hardware as there is a small possibility your reordering might have
> > introduced a problem.
>
> To stm32 people, can someone take a look at this?
>
> Thanks,
>
> Jonathan
>
> >
> > > ---
> > >  drivers/iio/adc/stm32-dfsdm-adc.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > > index 1cfefb3b5e56..d8b78aead942 100644
> > > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > > @@ -1292,9 +1292,11 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> > >     struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> > >     struct regmap *regmap = adc->dfsdm->regmap;
> > >     unsigned int status, int_en;
> > > +   int ret;
> > >
> > > -   regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> > > -   regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> >
> > Moving this later is only valid if there aren't any side effects.
> > The current ordering is strange enough it makes me wonder if there might be!
> >
> > Jonathan
> >
> > > +   ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> > > +   if (ret)
> > > +           return IRQ_HANDLED;
> > >
> > >     if (status & DFSDM_ISR_REOCF_MASK) {
> > >             /* Read the data register clean the IRQ status */
> > > @@ -1303,6 +1305,9 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> > >     }
> > >
> > >     if (status & DFSDM_ISR_ROVRF_MASK) {
> > > +           ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> > > +           if (ret)
> > > +                   return IRQ_HANDLED;
> > >             if (int_en & DFSDM_CR2_ROVRIE_MASK)
> > >                     dev_warn(&indio_dev->dev, "Overrun detected\n");
> > >             regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
> >
>


--
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
