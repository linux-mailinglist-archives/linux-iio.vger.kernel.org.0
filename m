Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58F31A540
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhBLTVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 14:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhBLTUv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 14:20:51 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCBC061756
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 11:20:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v24so1006995lfr.7
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI5YCogRovoSakj+Kf5SqncA9JkXMXzioIW8zLW5Z9A=;
        b=fPl6BpQ+bT9XOmxBhkSgPMqavD/BiV4RzZHT6Lkt99dQ7MW9bzbBuuW2XTHq9Wbup/
         3lqx51fuk1dNB42GGNgmQGC0ndwJtcg7vpOqHmYxik3BPLiVxjH49ZFbh5WcwSnn8cfU
         +um7kV5bx+Eu8KNNNbV2QhLu1xHeny2OLnQVni7OTUExnPmkF1d7uheETSu8QEkywFfN
         cnDMcPoXyOzdarpEbl1bbOD/ss+Ub9LGdoop8g0hPtwUIrJiKEKN184VJ4gGAfqbaH2Z
         FOjg1tGHkPy1HCdPLOajyYMrM6/C4oPo96YaeEvOrrdiXIxDqt8AEq5Nzh2TmGlR4Y4g
         X5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI5YCogRovoSakj+Kf5SqncA9JkXMXzioIW8zLW5Z9A=;
        b=e654/BBlt6jrXmdHwIHgXt9UWFWwgRNNLXVg8yHehHACUnrH5v/W1bv4kZoyzfeRvk
         +thaEl9KTXkJt+Jo3eumb8WiL76EdU6DsqnyQrBSXhzNPp25aB7wGQkXt8FlU8CEVga1
         wYJBwNbSNrVQJgXRtFqtzq9y8R6x/r9SqZw/UMChn0/TJtYAfGHKIyJz53JFO6J/nkeW
         91j9NxrY0BxMvC2ggzkbQA6akcgjvFg8zdr9ftG3QEJk4M12jL70EbQW9R2b0OaWQ7Of
         GpSLb5Gz+dXrx0y+Vl57TPCSr1xkfaxnEpkOWRF/AxN7AzvNU23+m2TPZUVpyXlYZZbj
         cPZw==
X-Gm-Message-State: AOAM531HU1ouHw9KgC+rLfIFgyr3OJJQHP8fCFrTYw4zHUtmxhiJmS3Y
        mkQJtEk2VQsLphuskywqzLd7GYvm4ryynYGx940LnsCNL3wNSnof
X-Google-Smtp-Source: ABdhPJxHh/ip6sp23+DXCxlzguKyVcN7zdQsER/5L5YJ5kwLi/3Me5uW9NbVqNNz2LyQ1Ph0smPir4imopTurTdJz9M=
X-Received: by 2002:a19:6d07:: with SMTP id i7mr2492323lfc.75.1613157609053;
 Fri, 12 Feb 2021 11:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20210208142705.GA51260@ubuntu> <CAHp75Vc1VWYLO1rF-NNnW3qkgiGycgpTHvr5Q2Yn91aZcFuyJg@mail.gmail.com>
 <CAMwq6HiAufEjLPn2hSnQ7iBvrrCZUzwE_hdFE8s51ewbuJOMYA@mail.gmail.com>
 <CAHp75VcT_7=MKErF0oVn5PFT1_7OeD4cZaw5WAANvhHouB7V6g@mail.gmail.com> <20210212190455.76b38d94@archlinux>
In-Reply-To: <20210212190455.76b38d94@archlinux>
From:   Wilfried Wessner <wilfried.wessner@gmail.com>
Date:   Fri, 12 Feb 2021 20:19:59 +0100
Message-ID: <CAMwq6HjcJqQV7qGGBPphhq4aA4h5BAtHHt88i5h1wqF2ii=zhg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect bit mask
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 12, 2021 at 8:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 11 Feb 2021 21:24:04 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Thu, Feb 11, 2021 at 8:42 PM Wilfried Wessner
> > <wilfried.wessner@gmail.com> wrote:
> > > On Mon, Feb 8, 2021 at 5:06 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Feb 8, 2021 at 4:27 PM Wilfried Wessner
> > > > <wilfried.wessner@gmail.com> wrote:
> >
> > ...
> >
> > > > Shouldn't be blank like here, but I think Jonathan can fix when applying.
> > > > Jonathan, can you also amend the subject (I totally forgot about
> > > > subsubsystem prefix)?
> > > > Should be like:
> > > > "iio: adc: ad7949: fix wrong results due to incorrect bit mask"
> > >
> > > Should I send a v4 with the changes proposed by Andy?
> > > It would change the subject.
> >
> > Depends on you. Jonothan usually processes the queue during weekends,
> > so no hurry.
> >
> > > And if so, should I add the tags:
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> >
> > If resend, yes, you need to add them.
> >
> Applied with the minor spacing and title tweak Andy suggested
>
> Applied to the fixes-togreg branch of iio.git. Given this has been
> there a while, I'm going to wait until after the merge window to
> send this upstream.  So it will be a few weeks.
>
> Thanks,
>
> Jonathan
>
>
Great, thank you!

Best regards,
Willi
