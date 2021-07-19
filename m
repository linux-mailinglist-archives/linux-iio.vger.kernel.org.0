Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97A33CEECE
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhGSVQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 17:16:02 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:11210 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385443AbhGSTAo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 15:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626723684; x=1658259684;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=kkiRt5Jj5CBJRC7q0YHNC8c+M4BiUBKBgl5wROFqk0o=;
  b=lViVeTNANoGeebxhkooqSBF9ns5ui+tzuJZPwlgiHRNvWirY/kaFlg9n
   cVXE2KPrpWdWFcwEp+seWULZOWfwIlxGZTQY9H2dfn+rFwRW/iMptp145
   qSVtC91OdZqsIM57PgUM+dEt8gBEs/kVBDLEp94cNbwVpgK4Qlayx9xb7
   76oMj2+bm0Uq1VANWc3BfjU/YhT/X7yF60ta1DRBGEAdQbg4yQ/I/Qcxo
   aCFlF1fJhj7Enz3BSRf8JQjpnluD0gzvT8rMTIPyrwDuStW75eFiquHk5
   xi9pLTLUfWdltzFg6BKxskO7gJ3jxPz704NFZQYp+oCH0nCI9uCedjTQe
   g==;
IronPort-SDR: Kih/fHDU2RJP0Qn0BOV8LyBkHKnnHNPnLcU4VSs04rURX0HqarFQm7PBqbuK/wKr3fbtE0/5Xm
 UGzLM8EcTTGxwQG/32brJMks3DGViJqhYFHkSUZXw/N7LmPS0N0jkaPJpafiVGINnzGtMiWyYl
 D3+554MYttF2r1N6qTQOJm7qy5ZuUOpp4h+ZcrtFV2x77Xu86eKfsIY8l85MZbxGbqxdQS2VIA
 bgd4RDv3a32BeNIJ9PcyZRR3qMf/RNx83hf3oAfTTymD0qPrLQh1VOTXMZy9E4yiiWNS6yp+/9
 exBQ/rKke+SIKOq4f27i3EBu
X-IPAS-Result: =?us-ascii?q?A2GUAgAl0fVgf8fXVdFagQmBWYN4bIRIkWADileRB4F8A?=
 =?us-ascii?q?gkBAQEPQQQBAYRXAoJ+AiU0CQ4CBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBB?=
 =?us-ascii?q?QQBAQIQAQGBDAtZC2OBT4F5BgQ9gjgpAYNtAQEBAxIRBFIQCwsNAgImAgIhA?=
 =?us-ascii?q?RIBBQEcBhMihSUDL5olgQQ9izJ/M4EBhy4NTAEJDYFjEn4qhwqGYieCKYFLg?=
 =?us-ascii?q?jg3PoIghTuCZASCK2sVPSgvMg2DHgEBAZNQAYs8nC9aAQYCgwockj+GGYVhK?=
 =?us-ascii?q?4Nji16FfEKQX5BTlRqVPhAjgTiCFTMaJX8GZ4FLTQECAQIBDAIBAgECAQIBA?=
 =?us-ascii?q?ggBAQKOKBaOTSQvOAIGCwEBAwmMEwEB?=
IronPort-PHdr: A9a23:kT3fNxDw1nDle5lKznQ+UyQUmUMY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua81ygSRFtyBu7oE07OQ7/mxHzRYoN6oizMrSNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9sM
 Bm6twvcutUZjYd/NKo8yQbCrn9Ud+hL329lKk+fkhLm6sus4JJv9jlbtu48+cJHTaj0ZbkzQ
 6ZCDDQhPWA15cnrugfGQACS+HYSUXgYnwRRDQTd4x70Qpn+si3htupgwyaaJtH5Tao1WTu58
 ahmTgLjhTodOD449GHXjdFwjL5erRm8qRFz35LYbYeIP/dlYKjTYc0VSnZAXsZJVixOHIW8b
 5cUD+EcOepUtpTxq0cSoRe7AwSnGeHhxSJShnLu0qI63eYuHwHI0gIjAtwArmjboc7pNKsOS
 +250LXEwSnBYv5QxDzz6JLIchckofyUX71wcMvQyUkyFwPCk16fqozlMCmU1u8QtGWa7+thV
 eK1hG4mtw19vjaiy9wxiobVnIIZ0E7L+jhkwIssI9CzVUF0b8K+HpRKqyGaK5V5QtkkQ2xwt
 ys3zrkLtJ61ciQUx5kqwxHRZv+IfoWG4h/uWvqcLDZkiX9kdr+yhAu+/FW9xuD/SMS53llHo
 ylYn9fCq30Ayxre4dWERPtl5kqtxyqD2gTJ5uxHIU04j7TXJ4Mhz7Iqi5YetUDOEynrk0vsl
 qCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMgQWX2iU5+C81Lr78E38WrpKj/k2n
 rDBsJDVOMgXv6C5DxJR34sn8Rq/ADCm0NMXnXkDMl1JYg6Ij4/sO13WIfD4C+mwg0i0nTt12
 /zLOqftD5bNI3TZjrvtYLZw51RBxAc3yd1T/5dUBasAIPL3VE/xrtvYDhohPg20wufnCM9y1
 oICVW6TDKKUK77SvkOS5u41PeaDeZIVtC7nK/c5//7ukWM5mVgFcKmt3JsXbm24H/t/L0WYY
 HrshcwMEXkFvgUgVuzmkl6CXiBJZ3a0Qa084is3CIW8DYfMFciRh+mo2CqrF5tafH0OI0qAH
 HPlfoPMD/4WZC+WL8ZnmzgJRZCuToYg0VelswqsmJR9Ke+ByywKtY/knOp17uybwQAg9TV1V
 5zG+3yGVSd5kn5eFGx+57x2vUEokgTL6qN/mfENUIULv5t0
IronPort-HdrOrdr: A9a23:Jntjd6g3VAGlt62luc893TkvJnBQXuEji2hC6mlwRA09TyVXrb
 HWoB17726NtN9/YgBEpTntAtjjfZqYz+8X3WBzB9aftWvdyQ+VxehZhOOI/9SjIU3DH4VmpM
 BdmsZFebvN5JtB4PoSIjPTLz/t+ra6GWmT6Ynj80s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="55028083"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2021 12:24:41 -0700
Received: by mail-pg1-f199.google.com with SMTP id z30-20020a630a5e0000b029022c78a7fc98so15796284pgk.11
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 12:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KRwBQYkzx1TnPP604PZP7mAiiyDknEAGOzKz5P9lLk=;
        b=q0iu00S7Pfb4i6LpBQ+U4cgZl3+e8f4dYaB0pRYArgtd3Y1HKAWgpLVyAcJm9LrNcg
         fZz+bkk0o6HjIdGkHf8/CyYKIm0DRg11EsJo1wvhv5yfSC8zmAkxR+zJUC4bll6G7P8m
         xpRljWtzu1WWxVmE9KTZgL39CHG8z+DCOg8oqqNr5fKl7K39khnhEL+Y8LyQBtujf99j
         bqmLga5D1lGW/i6f6KuJ6hzANrvWe6vCqOk47EOcfYPNmKxECaUSG06dQkmFV7f3913b
         WbwJm12kairPO4362c/Yv1z5C/I+eSgdPbHxufJh5rj5KexdRk99nNkTiMZDZCQdYphh
         ziGQ==
X-Gm-Message-State: AOAM53173bD2dp5DFQp9ui8N5YNYh/FoZQwIOf3p/B81ODhHoJiNaW2C
        wFyOhrLb62dtOVPnDpYW7/02ESMz1abe80ThaJ45V2EdG9A29CLd+nrgB/P1NMdWn+Mzztb6kyz
        qiozd8fk+fqtkZaDk1mfvoo609ihha4sFa62Izg==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr27277331pff.49.1626722680595;
        Mon, 19 Jul 2021 12:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg1RfsGvJK2QTY7aIp7/ssMd+mZmtyz3pP+qeB4sZSXtRJsKg7sA+dBra8jH9enCR2M+si7DTkxfIgrV3iMtc=
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id
 w125-20020a62dd830000b02902e8e511c32fmr27277313pff.49.1626722680291; Mon, 19
 Jul 2021 12:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLS8jU2y3owRvsS-PyS5NUyRpQs6Xa_A+U5mfWUTKu3p4A@mail.gmail.com>
 <CA+U=Dspdc84enbfmkmY24O8fnN_6d0_enSAj0PR9w7M9CjE7xw@mail.gmail.com>
In-Reply-To: <CA+U=Dspdc84enbfmkmY24O8fnN_6d0_enSAj0PR9w7M9CjE7xw@mail.gmail.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 19 Jul 2021 12:24:29 -0700
Message-ID: <CABvMjLQYjVtdOw30TxSDZVntccHa-20ad4Eki3rBVam4R=DBQw@mail.gmail.com>
Subject: Re: Uninitialized Variable Use in drivers/iio/adc/stm32-dfsdm-adc.c
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Alexandru:
Thanks for your detailed explanation, I would submit the patch accordingly.

>>Just curious: are you seeing any issues with these variables being uninitialized?
This bug is reported by the static analysis tool, we haven't
dynamically triggered it.


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



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
