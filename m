Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7948E3658B9
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhDTMNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhDTMNa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Apr 2021 08:13:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2CC06174A;
        Tue, 20 Apr 2021 05:12:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so16136938pjb.4;
        Tue, 20 Apr 2021 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbVlMk3yHqj6zVL1HunaMZ8N49XlU6pQ+8rdJjvQcnk=;
        b=om6ueCBSbqWfHkQN0Afv4S2+yzHZRM0YW7U5E5Lpw4YgWc8Zh83HQKjgxgtBbnqoff
         hVi7XPg7TFneV0qgx8sj6lx1v+sea6ZFbg8rkf406juk1P+a3OjeTHv/pc9tQKhyWmZq
         fZ+9Q5f3WN8hHLrfu5uCRy/CLZlwnTDbxumzN1W3QknA0HsU5IlqO5kWaxFu9poj8Dpv
         wugpU++QsqPqMg2n9Pehk17684jP9dS7ujZaWBMzcU2ndDrxEEHVTetBmgS/vw55AkW+
         aOLWrNo6DELFml3EbYhJjdVNYCoUpfodd1nsEN11UdE1Nm9joySLj73tUMhXDr7Wd/zt
         ZD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbVlMk3yHqj6zVL1HunaMZ8N49XlU6pQ+8rdJjvQcnk=;
        b=NfLMDkgEd2y9F0o1PX4HQo4Fz89IHuRZ1MuFtPtyecsPMRcfGishAWpRYnoVcez/Sl
         cvY4XwB5QOO1jWQ4nV0z78DA+IwU9JcMmB0pwmWBPGikEo6ZNNQc2bhj8UNajctsQgE6
         UeYQDGxvItzNqUbClDJL6R6p9DdYJgGNj0cw4oW9ljchQa1GI6vYTV6wTRaWuoq0sTae
         DyQ65FzWQ32EeHekBLghgJSyhi7YzB7b58tYmnpOM5OC9rHYmYiM1Yi5DDtESxaI4fqW
         bNEmPu/0vC+vvvPRMnzzySX6pT1NSPIStRA2erGqD98S8hJKz9uE/N+5gG4mmCRdcSdn
         WQRw==
X-Gm-Message-State: AOAM5318n0rAP/nCmWz42lBXb0StrlDJtRpbEsh/jfAa5bs9CvOaHR4F
        RwxvpMmnRUgK+S6RiQwpf7OEKw1mKfmj5J76ucQ=
X-Google-Smtp-Source: ABdhPJzjS4PT2fSLemDIvTKeIOvJkxI4TPmyTy7niHzqJQPhxNe0KQuvIyA4TZHcemCotw8RzbFpyjppQ6RnjIKc1Ds=
X-Received: by 2002:a17:90a:bd13:: with SMTP id y19mr4894850pjr.181.1618920778529;
 Tue, 20 Apr 2021 05:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210419132159.4450-1-tomas.melin@vaisala.com>
 <20210419132159.4450-3-tomas.melin@vaisala.com> <CAHp75VdApCk_Ydt2W_WWJ_wme4d1ocrrnvo+TjZcQ62RG6uOUA@mail.gmail.com>
 <bea4dc56-b860-431c-a820-a482ce87743c@vaisala.com> <CAHp75VfM3xToHJ+J095pkoLz1YD5qq-MaZoN3Log+bj6ktWFkQ@mail.gmail.com>
 <b9381886-35a8-8e5d-02b9-5d229439d11e@vaisala.com>
In-Reply-To: <b9381886-35a8-8e5d-02b9-5d229439d11e@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Apr 2021 15:12:42 +0300
Message-ID: <CAHp75Vc3GyGixOMFwiS9Y1UAQgch+NTcXkQ0YRXK8Yy+mOboYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 20, 2021 at 2:36 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> On 4/20/21 1:47 PM, Andy Shevchenko wrote:
> > On Tue, Apr 20, 2021 at 11:50 AM Tomas Melin <tomas.melin@vaisala.com> wrote:

...

> >>>> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> >>>> +                        indio_dev->masklength) {
> >>>> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> >>>> +                                      &val);
> >>>> +               if (ret) {
> >>>> +                       dev_err(&data->spi->dev,
> >>>> +                               "failed to read register, error: %d\n", ret);
> >>>> +                       goto out;
> >>> Does it mean interrupt is handled in this case?
> >>> Perhaps a comment why it's okay to consider so?
> >> IRQ_HANDLED seemed more correct than IRQ_NONE.
> > Why? Care to explain?
>
> Thinking that IRQ was for the device and it was indeed handled. There
> were errors when handling
>
> it, but it was handled as much as possible.
>
> >
> >>   Or did You have some
> >> other option in mind?
> >>
> >> How about something like:
> >>
> >>       /* handled with errors */
> > But what if this is the very first interrupt (bit in the loop) that
> > failed? What about the rest?
>
> Aah, right. Other option could be to simply continue loop and set 'val'
> to e.g. 0 for
>
> readings with errors. But perhaps it is after all better to bail out,
> and only for cases
>
> when _all_ data is reliable, it is pushed to buffers(?)
>
> Comes to mind that perhaps better to have error message in this irq
> handler as
>
> dev_err_ratelimited(), to avoid possible flooding.
>
>
> So to conclude, proposing:
>
> *change to dev_err_ratelimited()
>
> * comment goto:
>
>      /* handled, but bailing out this round due to errors */
>
> Would this be OK?

Sounds like a plan!

> >>       goto out;
> >>
> >>>> +               }
> >>>> +               data->scan.channels[i++] = val;
> >>>> +       }

-- 
With Best Regards,
Andy Shevchenko
