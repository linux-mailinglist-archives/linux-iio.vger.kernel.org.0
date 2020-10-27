Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6925629A9A8
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 11:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898257AbgJ0Kad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 06:30:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38143 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898246AbgJ0K3w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 06:29:52 -0400
Received: by mail-pj1-f65.google.com with SMTP id gi3so522255pjb.3;
        Tue, 27 Oct 2020 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TL4B+5yGPsuzk8YLy1Eb/baT+Nq11wWNa0Lsz50auDk=;
        b=EykaKmttOBuXKBD9Zv5StJFK7gLO7kju3F1ajh/rQFgazI8+C72rrVEcJQSDgd471i
         rGMjUvCNSI0fPzHuySmn3xF+HIwFPHVqRhmXvElpsxLhGUjA/riQFutmXqfXSJWtRkOa
         uWt5UMK4vAbgs0k1v0SfJejNjrgh+eWSMf7DFLBYVmwcuYgcWFnqVO2pyADNyTPYYq5N
         WFKuBC24JywqIjfHJrLcD5C+KUEXH2lvIj2VUKW3ahFUayCu2yLVOlmvw63C996ghhY/
         pyeiB+xCM3JPkfs2oYUMtPRAxUYAcsN2KFxkSUMI36jTdo+u7sxJvYyqsrybc9CrYQSU
         k4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL4B+5yGPsuzk8YLy1Eb/baT+Nq11wWNa0Lsz50auDk=;
        b=AMJ68oLWu3IFo0lrH1/1SyBN9+WyQH+oxzwYQ2W9xvVX1W61L38ClqI9xiA3BYXd6b
         Lo76+4o6k6GyMQEJikTfG4nBU5ZyRos50i0wu/ZKSUHHB/1MbaoE1wQIAIjwZQRjV86S
         o728hOaN4UVjLeOw0tFxm0/9Z067K3RxVehz4uRI4m48Kiy2EsCLD02qKXngF8i19DRz
         ySh9EgL0mbR9512sOg20ado5EvyZmWCee07m0VXYCO2mloaRj1w7w8xX1eUQihjpGhgF
         06rZfv4TPQwLV2pqDEUVyXIStGmrDgRqnIOTVvhyMk4L0VNSMX5ROChaqxlGqumB6Eo/
         JQqA==
X-Gm-Message-State: AOAM530JJPEqNeYTBq05KL6wi9IrG+af+suPilNOLwXz826/tVKIRHZy
        rRP1hK7Qnhc05wJpI1ZYovcdjUXCiEC2+O4ZaZo=
X-Google-Smtp-Source: ABdhPJzUoXCVKJFrmUfM7e4Fpi5fgz1J3WZ4IdEcHTIE8NfBDGKstOyUcEh08iVe42sVUErGgpuqFfXiXS9nC9LDJWo=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr1437134pjb.228.1603794592208;
 Tue, 27 Oct 2020 03:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-3-brgl@bgdev.pl>
 <CAHp75VfeBXszvhrz_YgtX6=HY=TJJXhWdTSTC1=S4UV2cOkJvA@mail.gmail.com> <CAMRc=Mf33JMNMT1vcrHx33QK7wj_gPY-CPaPUsqtON8X8S-JtQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mf33JMNMT1vcrHx33QK7wj_gPY-CPaPUsqtON8X8S-JtQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Oct 2020 12:30:41 +0200
Message-ID: <CAHp75Vf-z8yba-QX4G51PRkMV9VKAczd_79sma96zHRf+bMD2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: xilinx: use devm_krealloc() instead of
 kfree() + kcalloc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 27, 2020 at 12:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Tue, Oct 27, 2020 at 10:33 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Oct 26, 2020 at 4:03 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > We now have devm_krealloc() in the kernel Use it indstead of calling
> > > kfree() and kcalloc() separately.
> >
> > Which is completely lawful when size > previous_size (I mean, the
> > additional patch you sent previously seems not related to this).
> >
>
> Sure but devm_krealloc() is cleaner and adds the benefit of resource management.

I meant devm_krealloc(). It should work in this case without your
additional "fix" patch.

> > > -       kfree(xadc->data);
> > > -       xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
> > > +       xadc->data = devm_krealloc(indio_dev->dev.parent, xadc->data,
> > > +                                  n * sizeof(*xadc->data),
> >
> > I think you need to use something from overflow.h instead of explicit
> > multiplication here.
> >
>
> Or maybe add devm_krealloc_array() which would perform the checks
> behind the scenes?

Maybe. But what to do in the cases when you have struct with flexible
arrays, like
struct foo {
...
 type bar[];
};

?

And you do kzalloc(sizeof(foo)) followed by krealloc(). The above name
(krealloc_array) may be a bit ambiguous.

> > > +                                  GFP_KERNEL | __GFP_ZERO);

-- 
With Best Regards,
Andy Shevchenko
