Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17D23CCECD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 09:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhGSHuU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhGSHuO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 03:50:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D6C0613DB
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 00:47:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj21so22786679edb.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX5G7GXYgSuIZSzn7JC06isCYBNW34wfxtw6yOB40VA=;
        b=Qn78KfjsRGsyatSjUSmRLiRY7bi8CO3pFOL84aLFlheelrMNXdkrp1n2LXPxl9Sv+G
         +t5EHzj7gWxgJli/I7l/9m/RRs0qIycX/biSGZ1zwK67LUEagFGJ8VQqa8Om3jOQVv4s
         x8d39pOlboCys0s3Kyb1FdPS9bj3MQOYgFQ5Gbk+cfEpviGqfhGEXNxcCNw9oiEFtvKF
         uBgj8FzKzwv+cQq3+HtadK8RLsQSiO4r6fOYgZVuuzhTd4F/Suar1lK88dPzCmt36teF
         z+fggpXzY3jFDkIhOKgF/pttkxHTb3n2QCI1Xf1+qa0yTiQ7dsOd4vsFpB8b3TOnVbaV
         1mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX5G7GXYgSuIZSzn7JC06isCYBNW34wfxtw6yOB40VA=;
        b=jA0R4xLXz/g9GxmTB0xe2GUWNfVyXyDIAWnVaY9PrEfm0CqjFoA5cuDFvnZXpuQkln
         ch+pXCir5a+VSBmSs3yy6h/7add7hbw2HjSACkXke7BAkxbV7XRxbkifc1ke2ad25G3U
         JSbDY3XGrVuhqfjzcVggM/ZJg8vTCa08Urvy7/uKNjfJC88hAGIJs2Q1JEpDKrzAbA9z
         SEjTwpZItsDIIUOqVPudRJwG/RoPLoZ+fkMHg7w1K2+5rcep5A0ttLLaRLrPUitd//oo
         Pbq25RyTGOpF9RbseWGElk932PLLv7mQKofIv/zu+EPVsNclc7hmyX+j6ygJ+9502Cg1
         nFOw==
X-Gm-Message-State: AOAM531/SZISknLLSuHQMWQAC/maMiYX9wXxCGMfy2cZOZkGHnzC/x0T
        39w/sDneL0o4GY5bHSvoLm2+wF/KhCC5z/S0jNo=
X-Google-Smtp-Source: ABdhPJzNymUba5hVO5WFIBh68XxpLdNoGtX1CR+aPVlrpXI9skQQAAOWQlHfl35VCSsC23SF0CstAidSjoVjCDteT64=
X-Received: by 2002:a05:6402:3089:: with SMTP id de9mr33153528edb.69.1626680833174;
 Mon, 19 Jul 2021 00:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLS8jU2y3owRvsS-PyS5NUyRpQs6Xa_A+U5mfWUTKu3p4A@mail.gmail.com>
In-Reply-To: <CABvMjLS8jU2y3owRvsS-PyS5NUyRpQs6Xa_A+U5mfWUTKu3p4A@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 19 Jul 2021 10:47:02 +0300
Message-ID: <CA+U=Dspdc84enbfmkmY24O8fnN_6d0_enSAj0PR9w7M9CjE7xw@mail.gmail.com>
Subject: Re: Uninitialized Variable Use in drivers/iio/adc/stm32-dfsdm-adc.c
To:     Yizhuo Zhai <yzhai003@ucr.edu>
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

On Mon, Jul 19, 2021 at 2:39 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
>
> Hi All:
> Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
> could be uninitialized if the regmap_read() fails and returns an error
> code.  However, they are directly used in the later context to decide
> the control flow, which is potentially unsafe. However,
> stm32_dfsdm_irq() returns the type irqreturn_t and I could not return

Just curious: are you seeing any issues with these variables being
uninitialized?

> the error code directly. Could you please advise me here?

The correct way to do it, would be:

ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
if (ret)
    return IRQ_HANDLED;

IRQ handlers should return one of
enum irqreturn {
    IRQ_NONE        = (0 << 0),
    IRQ_HANDLED     = (1 << 0),
    IRQ_WAKE_THREAD     = (1 << 1),
};

If you want to fully optimize/correct this, then it may be something like:

        ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
        if (ret)
                return IRQ_HANDLED;

        if (status & DFSDM_ISR_REOCF_MASK) {
                /* Read the data register clean the IRQ status */
                regmap_read(regmap, DFSDM_RDATAR(adc->fl_id), adc->buffer);

// in this point, we could check for regmap_read(), but it won't make
sense; we should call the complete() handler, either way

                complete(&adc->completion);
        }

        if (status & DFSDM_ISR_ROVRF_MASK) {
                ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
                if (ret)
                        return IRQ_HANDLED;
                if (int_en & DFSDM_CR2_ROVRIE_MASK)
                        dev_warn(&indio_dev->dev, "Overrun detected\n");
                regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
                                   DFSDM_ICR_CLRROVRF_MASK,
                                   DFSDM_ICR_CLRROVRF_MASK);

// in this point, we could also check the ret code; but we still need
to call IRQ_HANDLED anyway;
        }


Quite often, when regmap_read() returns errors, then something is
seriously wrong in the system.
Something else would usually fail or crash worse than this interrupt handler.
That being said, properly handling regmap_read() here is a good idea.

>
> The related code:
>
> static irqreturn_t stm32_dfsdm_irq(int irq, void *arg) {
>     unsigned int status, int_en;
>
>     regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
>     regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
>
>     if (status & DFSDM_ISR_REOCF_MASK) {}
>     if (status & DFSDM_ISR_ROVRF_MASK) {}
> }
>
>
> --
> Kind Regards,
>
> Yizhuo Zhai
>
> Computer Science, Graduate Student
> University of California, Riverside
