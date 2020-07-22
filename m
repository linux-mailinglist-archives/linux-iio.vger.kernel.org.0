Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8522A040
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgGVTqQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 15:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTqQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 15:46:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CBC0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:46:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so1493961plm.10
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGrsK58KkMH+7dMcxn0YUQjqsyujxUEhUkWuBPtHlM8=;
        b=LHiT7UpCbaRiknzbQLJrGUyFq7DEGpN3sKCV48SuVtaGzlAzV4KdA9KmSOSrK+g405
         XShTf8Qz9SJhX8MnkAXgWYT5+IsA0aCeKL4c6piFG8Or25Pi55nU6/rpeqowxe991PY4
         13pJ1rmG9JVjr7l50BmRf/+TmfhnhPMNtM0GiGR0eR3y569B0tEmdwGeLztHc13peIce
         l5EKQGthlcXdBx2OPuvWYmGAw6drGdn5oupbCStpFzokhhcZc2KIcA+24kPyhqPKle8d
         5v6GQ2voGqVTAo5rTgbFsCJvwe6J5/sru9VoyHAxZAzCVzrzEgwe61xsm7b5NbbTZxc0
         XaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGrsK58KkMH+7dMcxn0YUQjqsyujxUEhUkWuBPtHlM8=;
        b=jpEsPkJ+4ZOo5DRsPjrmVR9t1TQ5yeAna8pWa8P9cynKla7AC+IxtrTVLtaUH/xJRI
         +vwlT5jhuWUbfBjiayEn2i0OUa82zuydJ7yT/py/FKU2+gACYM8/DEI39OAFViFANkSd
         xAgTRyCTA7xyK/ISxMeUlon6j2/49RJI5+dYXV1SDEian98S6+bydmtzWpoFEmcIlFKj
         /zpAIK3GYHu60kbhr4ASMN7KPkUhKg0gnIa5OeN8r4A8wmYEZiEJy+ojaeVeJ2WsMjZz
         XufpaH9KgmNeWNKCg8FJAgu7NMrVu6mqsKB0+nInIyn1Aoqce3i63nY/BVCACqAF1d96
         sEPw==
X-Gm-Message-State: AOAM532xk4oJ+HwkA3MELdd/AaAhkZ0vCzr4Xa8eBj7yEfgKvq2iwplB
        /O6u374+gg/6qR/9vNbB+xGGvMce2JPhdkX+HMo=
X-Google-Smtp-Source: ABdhPJzgijMCBvWYDMLZCBq2eyBPsxpOGc48IHIvRlHl3PTJi484PmBi8mmBfVQ+KASd09h1DXPJpO5cOZlKA3d7wtU=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr881870pjb.181.1595447175696;
 Wed, 22 Jul 2020 12:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-9-jic23@kernel.org>
 <CAHp75VdFQYtkA-g2S=Vcvk3Sxp7duTihr3XGfzbUEB5xM4UbTg@mail.gmail.com>
In-Reply-To: <CAHp75VdFQYtkA-g2S=Vcvk3Sxp7duTihr3XGfzbUEB5xM4UbTg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 22:45:59 +0300
Message-ID: <CAHp75VcL+-jxYiNVkXi=s8WDRvDuSVJ9w9AtKsKVp2eN_TEtXA@mail.gmail.com>
Subject: Re: [PATCH v3 08/27] iio:light:si1145: Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 10:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses a 24 byte array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable array in the iio_priv() data with alignment
> > explicitly requested.  This data is allocated with kzalloc so no
> > data can leak appart from previous readings.
> >
> > Depending on the enabled channels, the  location of the timestamp
> > can be at various aligned offsets through the buffer.  As such we
> > any use of a structure to enforce this alignment would incorrectly
> > suggest a single location for the timestamp.
>
> ...
>
> > +       /* Ensure timestamp will be naturally aligned if present */
> > +       u8 buffer[24] __aligned(8);
>
> Why can't we use proper structure here?
>
> > @@ -445,7 +447,6 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
> >          *   6*2 bytes channels data + 4 bytes alignment +
> >          *   8 bytes timestamp
> >          */
> > -       u8 buffer[24];
>
> Seems even the old comment shows how it should look like...

I think I understand now. Basically it's a dynamic amount of channels
(up to 6) before you get a timestamp.

-- 
With Best Regards,
Andy Shevchenko
