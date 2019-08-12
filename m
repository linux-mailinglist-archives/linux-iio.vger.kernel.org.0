Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7F89563
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 04:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHLCh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 22:37:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42584 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHLCh5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2019 22:37:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so9003434ota.9
        for <linux-iio@vger.kernel.org>; Sun, 11 Aug 2019 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVPUyU0J20dZaP14ZLtarTnmhaUFJnFvaSIBf/iSdHg=;
        b=HqKR6v7rUVKSqH/801mtUb1b78SxT444rRCVYLlXNrRvp07ibQehYufIH7zwzwDso/
         IS581UNC9Z8ELxE5VeWHqzl8I0+7/AQXjYXv8hZ5jV2ZTVsYRXf20Gb0EYxfA8/z28sr
         MRqdBnWVDqq/ZnLG/D42iTpl6ZxPuVa3lXzrwNHq9DwTray9m9bCOh2gpZ+EmIDRQE3X
         POb1arab6XlIRV+ysy2faIH4gXg345Z0QVuhpy+zodgkrp1iLRmWiEXFWjK5cfPbIixu
         g8XwfRwS0rwmmuWSs5qBONARdmSm+i2T/G17QvWwhQ6D0z1fPGRlBZJ5mIPEQzYiiosh
         Qc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVPUyU0J20dZaP14ZLtarTnmhaUFJnFvaSIBf/iSdHg=;
        b=XwzncLI6TVkgpim4chsH3ikjvsWLwWJ+cRysK2vvGdsbhKydU9ycMrAnRujM/fd5ZF
         GXXtnqJ8XpdBrvWQM8VGeJ8gF/8EKjBu+cB6a/WyLISNdOmWNTCrfD8O6nT6aAOflQpW
         SUFHxUSjxiT673vS8ZFYV05LzCb3k61d55f9MQHRFGhYGxzF/nZ25vvf0dkUUQhhAgEe
         hjCU7PDUvga+zryYAwWd8b0V0HTmo/oGwpuMsYwTpO28KLkut0DmPpVp+7b7Ow3ZvjzT
         RZsnOWeTH59V+gvl6vFV7uwl2rV1g/NyDwYRIC4iWaOpVerMqObV+pEzXgxuPYTnLAdW
         5x1g==
X-Gm-Message-State: APjAAAUDYLwLC6V+2tz86zapX2ZvsttcSY0qG8o18+WZ6uR+29fs3QfS
        T++ZtXGsmIBvjgttQR47mFeXn5zVquELXZpfmYdZvg==
X-Google-Smtp-Source: APXvYqy4/uubGIOKb1mot88/KCwAhXdUYNlH4ftJciezuK0kUKzJ1Q2YpBEmCO17/xgWuQUtu7VXOSNPqtPZCFhbso4=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr18027546oth.281.1565577475725;
 Sun, 11 Aug 2019 19:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <1870ea18729f93fb36694affaf7e9443733dd988.1564035575.git.baolin.wang@linaro.org>
 <20190727182709.037fc595@archlinux> <CAMz4kuLLSYw0JRLRVN-JegxZcK1bdv4K2m4mVu7oep6xfb+xxg@mail.gmail.com>
 <20190805145037.0a03f21e@archlinux> <CAMz4kuK4GFfOi3vGvFOLdRfmqrwVLDs5CN+Xp_it3jG4=iKi=w@mail.gmail.com>
 <20190811090251.5fbd7d75@archlinux>
In-Reply-To: <20190811090251.5fbd7d75@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 10:37:44 +0800
Message-ID: <CAMz4ku+ansL1RJScmJRsvKR-dJVLNjAZqgTFqRSEJWQSYUy_Sg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: sc27xx: Change to polling mode to read data
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Aug 2019 at 16:03, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 6 Aug 2019 15:39:45 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
> > Hi Jonathan,
> >
> > On Mon, 5 Aug 2019 at 21:50, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Mon, 29 Jul 2019 10:19:48 +0800
> > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > On Sun, 28 Jul 2019 at 01:27, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > >
> > > > > On Thu, 25 Jul 2019 14:33:50 +0800
> > > > > Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > >
> > > > > > From: Freeman Liu <freeman.liu@unisoc.com>
> > > > > >
> > > > > > On Spreadtrum platform, the headphone will read one ADC channel multiple
> > > > > > times to identify the headphone type, and the headphone identification is
> > > > > > sensitive of the ADC reading time. And we found it will take longer time
> > > > > > to reading ADC data by using interrupt mode comparing with the polling
> > > > > > mode, thus we should change to polling mode to improve the efficiency
> > > > > > of reading data, which can identify the headphone type successfully.
> > > > > >
> > > > > > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > >
> > > > > Hi,
> > > > >
> > > > > My concerns with this sort of approach is that we may be sacrificing power
> > > > > efficiency for some usecases to support one demanding one.
> > > > >
> > > > > The maximum sleep time is 1 second (I think) which is probably too long
> > > > > to poll a register for in general.
> > > >
> > > > 1 second is the timeout time, that means something wrong when reading
> > > > the data taking 1 second, and we will poll the register status every
> > > > 500 us.
> > > > From the testing, polling mode takes less time than interrupt mode
> > > > when reading ADC data multiple times, so polling mode did not
> > > > sacrifice power
> > > > efficiency.
> > >
> > > Hmm.  I'll go with a probably on that, depends on interrupt response
> > > latency etc so isn't entirely obvious.  Faster response doesn't necessarily
> > > mean lower power.
> > >
> > > >
> > > > > Is there some way we can bound that time and perhaps switch between
> > > > > interrupt and polling modes depending on how long we expect to wait?
> > > >
> > > > I do not think the interrupt mode is needed any more, since the ADC
> > > > reading is so fast enough usually. Thanks.
> > > The reason for interrupts in such devices is usually precisely the opposite.
> > >
> > > You do it because things are slow enough that you can go to sleep
> > > for a long time before the interrupt occurs.
> > >
> > > So question becomes whether there are circumstances in which we are
> > > running with long timescales and would benefit from using interrupts.
> >
> > From our testing, the ADC version time is usually about 100us, it will
> > be faster to get data if we poll every 50us in this case. But if we
> > change to use interrupt mode, it will take millisecond level time to
> > get data. That will cause problems for those time sensitive scenarios,
> > like headphone detection, that's the main reason we can not use
> > interrupt mode.
> >
> > For those non-time-sensitive scenarios, yes, I agree with you, the
> > interrupt mode will get a better power efficiency. But ADC driver can
> > not know what scenarios asked by consumers, so changing to polling
> > mode seems the easiest way to solve the problem, and we've applied
> > this patch in our downstream kernel for a while, we did not see any
> > other problem.
> >
> > Thanks for your comments.
>
> OK. It's not ideal but sometimes such is life ;)

Thanks for your understanding :)

>
> So last question - fix or not?  If a fix, can I have a fixes tag
> please.

This is a bigger patch, I am afraid it can not be merged into stable
kernel, and original code can work at most scenarios. So I think no
need add stable tag for this patch. Thanks.

-- 
Baolin Wang
Best Regards
