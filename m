Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77E386E96
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 02:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhERA5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 20:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbhERA5O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 20:57:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51640C061756;
        Mon, 17 May 2021 17:55:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so7211171otq.7;
        Mon, 17 May 2021 17:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yucLhkWF+a1ME5Qb9j9m9s8qqNJAVcLcCSl2OC45snE=;
        b=a1KtrMinmN+R1YtVythdwnFkHS+Tdbgcmy9l7vSOkqxC/vVzx3wsPHDcDj0DG+1l2/
         RAbz/FiBBFOjwDrtjtYHY7181fS0TDnX/yv85f7YxllwE/6X1eKZp22timlc9ZYCAZpo
         TF/QlZ3Eyyp6fVaUIbgfXYalF67Do2Yc3RLE40lf+4qfiALN1jJ22SMRVlKlsV0x6Qsl
         VtUIP1xQle5akujtsLkyGB8lA20n81jCSRIT+DuB9XSVPpPhuk8N0j/rXwzJEVn9cOQn
         1pNrxzGbdOfiIlBlBZSopbArR3+M48OmHTD47uPPg+7xoLyLuwhmIbzIAPQW+v6xRY7k
         ipRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yucLhkWF+a1ME5Qb9j9m9s8qqNJAVcLcCSl2OC45snE=;
        b=dkh0Vq5/Y7GzkcmlxVwi7z1Iu0FXzxhLZvSDDt3/8Jn7DSoIM9HaAxjawZPuLgRYT0
         vxwzFv454gVjiHMSnSKH5iDohmUkORtcME+N4mJC/Bk/TpxJ/xlt92wHmzkgFE+ALNly
         GPDI3oHFP6hlWWDot++8N+YddSVBgBmrmXql8OS+wcWzjT6260wT/9lZLIHKYOHjevlz
         CKXDd2rbk97uPIjd6Vt467atwDKFRl8pImrvcyWd+PZyiE5DfH/yGIQHuaoNyyH9HTn+
         YhMVmtw7YyDHfQES2IAceFK4zcPN2AgP28ANolSNdH//LTMjKfHf0gbQ1XYzIjfNHee4
         VRzQ==
X-Gm-Message-State: AOAM532qdhuXf1uHT4ZUxu7t7LYE23+VLW5A23Zxlsg5hzG52D6IhPdG
        DxcOB9IT6Q4SN2K6y5r2Y0RLMeDnhEAPZCklAgY=
X-Google-Smtp-Source: ABdhPJwuJ0+nGKTuihXix656KLbhr2kT8htvpkRAwuHkWBDuRxzKK2bQGjz+fNsbob/VoKSe9F7HsrIUJTbcT2S43K8=
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr1995944otr.89.1621299356430;
 Mon, 17 May 2021 17:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
 <09e65d3a235febfc4c3ee172b573ba8c9cde94b8.1620766020.git.lucas.p.stankus@gmail.com>
 <CA+U=DsptfNDut3984MJkKckgWBhNd_0p17RfpidEXwYhMRfxtg@mail.gmail.com>
In-Reply-To: <CA+U=DsptfNDut3984MJkKckgWBhNd_0p17RfpidEXwYhMRfxtg@mail.gmail.com>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Mon, 17 May 2021 21:55:20 -0300
Message-ID: <CACKVXZA9rPGLLxyq3gWTynoH7dPgYitqe-dO=YNad7VxHfwQhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: iio: cdc: ad7746: avoid overwrite of num_channels
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 12, 2021 at 2:20 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 11:55 PM Lucas Stankus
> <lucas.p.stankus@gmail.com> wrote:
> >
> > AD7745 devices don't have the CIN2 pins and therefore can't handle related
> > channels. Forcing the number of AD7746 channels may lead to enabling more
> > channels than what the hardware actually supports.
> > Avoid num_channels being overwritten after first assignment.
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index e03d010b2f4c..9e0da43b2871 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
> >                 indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> >         else
> >                 indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
> > -       indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
>
> ohh; good catch
>
> this falls into the category of a fix, so a Fixes tag is required;
> this looks so old, that i did not bother tracking it before
> 83e416f458d53  [which is 2011]

As Jonathan said, this bug was already fixed and the patch will be dropped,
but thank you for the review.

This was my first bug fix in the kernel, so sorry for the absence of a
Fixes tag, I'll make sure to add one next time.


>
> so, maybe something like:
>
> Fixes: 83e416f458d53 ("staging: iio: adc: Replace, rewrite ad7745 from
> scratch.")
>
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >         if (pdata) {
> > --
> > 2.31.1
> >
