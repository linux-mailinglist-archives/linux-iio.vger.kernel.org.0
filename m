Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0234A608
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCZK6Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 06:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCZK5v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 06:57:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440BAC0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 03:57:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so2282033pjg.5
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICek8SZmILqEKuHvomM9GoBMan2JZF33tLa10tKNVCw=;
        b=byozqVPE8tPmOrDNACj8rJS2fvFy8I58rxFa0w1Mk3bLutzKBVM6UORko+YNHc0JEn
         MysE3IPjcEk6/HNCUNRkzV31mGJtkm+eZg51aAEc/bBzoyfqF+Klx+MMV4x9y6F+ly+Y
         C61FNWlhOv7YzpjhRD6rEhI98vvOzdQOQvlKSiih3QvhUzkDwHeb+4jmGBBoN5DOxM3e
         /vnCqxyEsyI5fC4QBde5t8gLalGMmRvK3VcJMW0r7wU1Hy8b9oQvMnSjvzVysGOli/+9
         vfbA1Ql6/hG2GgBkGKTMU2bDAx0Dm5uMOUk3527uU04YMtxe7eV1NhjG0yF8IjnJPvRr
         Cdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICek8SZmILqEKuHvomM9GoBMan2JZF33tLa10tKNVCw=;
        b=X4hljmFsUnMhwlFj3l2kLup8shAb9Avh/6kKh3JvH6qTKyxmYJhAtMukaeT6rn5H5s
         aD/9VqYrQ2ttgJYtihkD7Qc67b11mKEtSi0B+UYrUeCX/B//PUuZdVd6IvH6yUvdfG3e
         eMsgXSpUZCQtV1xnpaqGwBvAioPesQEJ39pXShpB+WQMc6sPZyCNsDQtuOPmw3mqH47y
         z5zfRFfCbS+ijcVsD3EoiN8qouh+zt1VLdlRFqnTL4JOg1alpeSF9fBDA7O7ATMXEFmS
         1Li7IJfgFhyqf/qhXVVjmURcPn5LBbNMdYHfG1/n38QhrIlH4IcvJj9wi4UeqE8ft+BQ
         4tTQ==
X-Gm-Message-State: AOAM531oi6oNhjX8nVvjISYWNb9J1t3kM8B6Usre87bAqI9EKEpHGBMh
        ybN9uVmaADvBj8EkCxRvRJQV6Uj1w+L/B48bk1s=
X-Google-Smtp-Source: ABdhPJzRiRJggrfbP+w5hKYI3RrAkliGA8DTV8ki8tmtrodJLpIjUYTq0cn6UCtwDYYmgwSrTHWNyVnyrf9tU4LMv0w=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr14301594plq.17.1616756270863; Fri, 26
 Mar 2021 03:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210325131046.13383-1-lars@metafoo.de> <20210325131046.13383-2-lars@metafoo.de>
 <CAHp75VcHJrJyvdW9qCdCprrROozUuTb6EPP7DDMg3FSoY=Ch=A@mail.gmail.com>
In-Reply-To: <CAHp75VcHJrJyvdW9qCdCprrROozUuTb6EPP7DDMg3FSoY=Ch=A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 12:57:34 +0200
Message-ID: <CAHp75VdK0rbM3ahDjjaQiZzjZ7Pm7wPV2Kkqv1SMo6c44nh46w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 26, 2021 at 12:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Mar 25, 2021 at 3:12 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> > The inv_mpu6050 driver requires an interrupt for buffered capture. But non
> > buffered reading for measurements works just fine without an interrupt
> > connected.
> >
> > Make the interrupt optional to support this case.
>
>
> > -       irq_type = irqd_get_trigger_type(desc);
> > -       if (!irq_type)
> > +               irq_type = irqd_get_trigger_type(desc);
> > +               if (!irq_type)
>
> A side note: perhaps change this to comparison with IRQ_TYPE_NONE (as
> a separate change)?

And use actually IRQ_TYPE and not IRQF (the values are the same but
semantics is different). I have seen that in many drivers :-(

-- 
With Best Regards,
Andy Shevchenko
