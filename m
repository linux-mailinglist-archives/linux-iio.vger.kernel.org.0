Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE7344908
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVPQ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCVPQz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 11:16:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF891C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 08:16:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n21so14296098ioa.7
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijhOIls8YU0yT7JZWlLYCgyOnDmqWsieNC9WpV+evWA=;
        b=dji58ONwQpAtfcuhMdnEYZu0dM4aYGDcvLJjn4m6Sgq0mVJLa7uRHrHbFOWcqoUVmL
         3j4262qWnEGifjL54CWe81CEov3Eb6EvPRxmif2m4TzqpLECJqXjSXZac29+ITct5eE7
         Q/zWRaqrNVK0HbQOgKfaerP46gnUQt0VMqIv2LfrQfb94oVgZkW9KZjmVxqSA5ZsQS+x
         VULhgiUCluFrLQM/laPwao1fOrnKPkBMpZ1toCP9Mi5oDEhRb7/cJzxqVDMyN9Hv9YdG
         b5N3Kuk5CL090a4/Pydg+oZUn3WDMY0R1jfvjWgcCUfn7zDnTshonht6GzxjCtSmZQOF
         YE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijhOIls8YU0yT7JZWlLYCgyOnDmqWsieNC9WpV+evWA=;
        b=cLvBOHEBgqeRnIBmWAzAAC/0VyaNYZFNP7E1hIrvShUfbW+HMM2ybmSSJcjL447gBf
         SUvt+zmRDioE07pkbQFmDj4jXjsnYrmGSq4tK43yR/qmGy1gjKlLi4yPULGFbhUKSAy0
         7wE5mbERcYznweHAJZHi2YuObdpTV6ZNd71945eCYjyUMnDNoszg8JfmEPdRAss6Mfml
         hNx21xOcUGqLDvJWz2vuk7Y/Ks0Tjr5zpo8TEEjw4bOL8/XbbII2HKAq9XSuvhyeua3a
         yIholNsGCKrcrK/pS2xWt8gwg2A0pogaMhBw+0LY/uZesM3S8ROVl5EHdd6HUb/dX7YN
         ViKA==
X-Gm-Message-State: AOAM531BvpEHRT9JWfab4qd9Ty3mWw+jM8zbh+gTsiB25jRlgnJLU+6R
        VyTSyO/Cqj2tDKfrZSzZcypQpzzglHahDXvpr5clpzcsECU=
X-Google-Smtp-Source: ABdhPJxzS+7Anx/1jFuhqFxvZFqXg+J+UWbtnGHvThGEL261sTgAhZ+We6qjjJpvY+tcgh4NGGmjYqoHvFChovemIk4=
X-Received: by 2002:a05:6638:3791:: with SMTP id w17mr11425664jal.91.1616426215167;
 Mon, 22 Mar 2021 08:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210322073220.1637117-1-gwendal@chromium.org>
 <20210322073220.1637117-2-gwendal@chromium.org> <CA+U=Dspk-BdZoDNnNdXMMZ+hA=bCzea8v2zxsuCkf5-ecHr7Bg@mail.gmail.com>
 <CAHp75VcULMoQaDh5YEcJjJV2n_zSH236A=465Nki8QxPZ4n0jQ@mail.gmail.com>
In-Reply-To: <CAHp75VcULMoQaDh5YEcJjJV2n_zSH236A=465Nki8QxPZ4n0jQ@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 22 Mar 2021 17:16:44 +0200
Message-ID: <CA+U=DsrMaQif+jC_PJixX=KKJ=t4Cqgn6cGUg6Dpdy8VtAviyw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: sx9310: Fix access to variable DT array
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 3:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 1:16 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> > On Mon, Mar 22, 2021 at 9:33 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> ...
>
> > but i think there may be a bug, in the fact that number of elements in
> > the array must be 4 (no more, no less)
> > that is, when reading the DT, it implies a variable array size of 1 to
> > 4, which doesn't seem true in the code;
> >
> > maybe a better idea would be to use of_property_read_***variable***_u32_array()
> > this would allow for a flexible array size;
>
> Wouldn't work in conjunction with the second patch.
> The above API is OF specific.

oh
good point

>
> >                count = of_property_read_variable_u32_array(np,
> > "semtech,combined-sensors",
> >                                            combined, 1,
> > ARRAY_SIZE(combined));   // min 1 , max 4 elements
> >                // count must be int, so that if it is negative, the
> > array doesn't loop;
> >                 for (i = 0; i < count; i++) {
> >                         if (combined[i] <= SX9310_NUM_CHANNELS)
> >                                 comb_mask |= BIT(combined[i]);
> >                 }
> >
>
> --
> With Best Regards,
> Andy Shevchenko
