Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD1440E80
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 14:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhJaNDr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJaNDr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 09:03:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D15C061570
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 06:01:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y26so30978498lfa.11
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnlEzAPo8A2mDZ8q79yEegiVz4q7dur35G+RKfHSiqE=;
        b=GehK+Aje6egAtEgxwH5R1apX9WsqTLzB71mHCqEvP5/ump4OEW0Nr+fw1d6xzFTe+V
         kqw+lO/r/KwG7gGewv2qXML5VFspFe4DK68R1eaD+jjNjifJ6fx5NJqYUMmg7uIf2DEI
         WR/s1QVu0ZhOja7V3rQROt8vYUin3k2s06YJ3zBLwLllAYPBrQROC1PWhFVFKlnFLc6b
         AhQ+Kylf/70T/mD/TVuoKzLz6pU/S8o6Og2Z05m2ikreCU9f6UktxDlvjBj4Iyi5aDsv
         zBRRl7/VY9BcNTvftTfMjHoFdpWSDfA1mei75dB+94ZVVBs/Tr9tPiw1v/qRrdXnwfUq
         VoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnlEzAPo8A2mDZ8q79yEegiVz4q7dur35G+RKfHSiqE=;
        b=YauJYPlI35S7uF7Np3WyBUiHoeImBerr1UqWINSIYhihtdRSFN864qAe/EgjrT8hon
         OAWivj7xe+vpH3ZtWcdoqEJmob+EoW/2VVz8DUGGuZDrY0tZpVKjeO78ufPomcHgQdHi
         /qyayLvLJ0s85hYcLWyNOMLzyJB7oTSYLaRncTOqyD3AopLVl0aMal5qZ1HKUs7xRtO6
         +mejY4orql50Rw+rMlCi+Lwc3mHIMl+Fws2MwAyHuDH5t572N7rVb3BZONYXFYKUHhmd
         Mha0OFYuDn+rByI9Flhu5njsfdliWB8Sox+UVSQpG1ceqoJH6n/oz/Bd215U23u/PIFi
         W0eA==
X-Gm-Message-State: AOAM5336wsl9dRiXp/5Cwk5UCn/L3mMCisLLgIQnQ4ZYMqnHVDGpdUS5
        578ZnKZ50Hk9IeV5lez4ERr9n8LoStS4LdzkZlo=
X-Google-Smtp-Source: ABdhPJyV8BRy+Czvpx/HIuGdyxSx4AxaJCdExUkhvHbNrw+4APNPE4EX2NcJGcJO5fPx1RVOLI+yu2SGaWnalsqNKkg=
X-Received: by 2002:a05:6512:acd:: with SMTP id n13mr21717918lfu.60.1635685274010;
 Sun, 31 Oct 2021 06:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211031073231.13780-1-lars@metafoo.de> <20211031073231.13780-2-lars@metafoo.de>
 <CAHp75VfT-VgMODDdZCy8ERh1Uw8HVR6YuzmTukeP+nHbrx++sg@mail.gmail.com> <cfa7d882-7825-74d6-ff50-d8bd85dbf0f1@metafoo.de>
In-Reply-To: <cfa7d882-7825-74d6-ff50-d8bd85dbf0f1@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 15:00:38 +0200
Message-ID: <CAHp75VdeNcNTedxeOBAt2aFz8yWTzv37YWD1km8bs5fuAg0QfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: viio_trigger_alloc(): Correctly free trigger on error
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 31, 2021 at 11:15 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/31/21 9:54 AM, Andy Shevchenko wrote:
> > On Sunday, October 31, 2021, Lars-Peter Clausen <lars@metafoo.de
> > <mailto:lars@metafoo.de>> wrote:

...

> >     -       if (trig->subirq_base) {
> >     +       if (trig->subirq_base > 0) {
> >
> > >= ?
>
> I don't know. 0 is not supposed to be a valid irq number. And we
> kzalloc() the struct, so if it hasn't been explicitly initialized we'd
> get 0.

But it will change the behaviour of the code.
>=0 is the opposite of replacing < 0.


> The way the code is at the moment we'd never end up here without calling
> irq_alloc_descs(), so it is either a valid irq or a negative error code
> and I can see why you might want to use >= for consistency and symmetry.

Right!

(But on some architectures and cases 0 might be a valid vIRQ)

-- 
With Best Regards,
Andy Shevchenko
