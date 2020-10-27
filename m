Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6D29AA68
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895614AbgJ0LRu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 07:17:50 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35044 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509884AbgJ0LRt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 07:17:49 -0400
Received: by mail-pj1-f65.google.com with SMTP id h4so583975pjk.0;
        Tue, 27 Oct 2020 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPsSkKDfaYHYfZBMKhJgybL5r71P6I8MibUMxERzTQ0=;
        b=IjeI9wdSOHdNc1yJ+yQQEI6wi5W7ACIoqnOkxIjXwJdz21jcRAdbTO2C3k5w2dV9AD
         UuDbDNBdswF/czL3PDU0F3BwEW27/g8X48UjNfvOqSoTS7CQR0GRKCPN9EwYKa7Csukb
         fOcx2V/P40DWZFct3dt8b4UOeYXrt+SOJyeCTZ7g1QzGVdj3Dwi7eBD73RoVdmtGUzT6
         Om/pERqY0bVtgZ0IkE2+uJnB6nEHG2oJpp4Z4wDW0gBbUKdfuvCwqYRcJC99FJzoejjt
         H4TzH4y/FMMSUvp1hJxZBj9Da53Lqb2Z6ZgwMQu8RXRVwJjDPKm9xcxTZq1+pnHChwng
         JbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPsSkKDfaYHYfZBMKhJgybL5r71P6I8MibUMxERzTQ0=;
        b=Muj8vHbsmFSGY1PnGe6+4fg/tNNODWriqldszdExZ/whwgmxFP6eW1TcjTB2GCZWRZ
         guN9zsfwiRnoQ3xsPafyUBlRwdgDe8z7/SQmxoCjkrEgdlFuBjKa1gC/GDOb6qZeb4We
         +PF9Ya1xqGELk9Svus8PinfpOsBUyoqVWnG+Qx1ipS9jSagBButk/JswRnPV2u4aL1Mj
         /ciewKl1IL4UR6j3u56sNw/9YNi8Atod9811Vb2ym4K7IcCIGd3XIpA1Yeh/gwSFHxZb
         kELWJAndatrTA8ibvWBheamxkLZ535Xv+fH82j1inN8yiENDjNeeyf6Oxz+/Swh8UajG
         ca5g==
X-Gm-Message-State: AOAM5315rnim4uPggiiN7zqZpAVFG+sKFUQmTwhAx0wX/WqkG7hTUGlb
        VSZL9fp/WcvlE/AUeDXAmvDrenljDy7KrNitnKU=
X-Google-Smtp-Source: ABdhPJyroNUwaMIcTAOLJFPp8bE5Q8OYeTqKBQxXSNbq1Ok9V3p7okmgEQA+o6lvxznO+OvXgnnvEQvgHfk4eVRfhNk=
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id
 m8-20020a1709026bc8b02900d60d9df28cmr1095224plt.17.1603797467528; Tue, 27 Oct
 2020 04:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-3-brgl@bgdev.pl>
 <CAHp75VfeBXszvhrz_YgtX6=HY=TJJXhWdTSTC1=S4UV2cOkJvA@mail.gmail.com>
 <CAMRc=Mf33JMNMT1vcrHx33QK7wj_gPY-CPaPUsqtON8X8S-JtQ@mail.gmail.com>
 <CAHp75Vf-z8yba-QX4G51PRkMV9VKAczd_79sma96zHRf+bMD2w@mail.gmail.com> <CAMpxmJUPsz3o8pDAU9e5x1gD-yGf5Fym2DgYnfpCKEFTj9DSYw@mail.gmail.com>
In-Reply-To: <CAMpxmJUPsz3o8pDAU9e5x1gD-yGf5Fym2DgYnfpCKEFTj9DSYw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Oct 2020 13:18:36 +0200
Message-ID: <CAHp75VdKXJgn3ZNDit6Drz8xyTatLeg8M9+gkmtBFeaLFTn51w@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: xilinx: use devm_krealloc() instead of
 kfree() + kcalloc()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 27, 2020 at 12:40 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> On Tue, Oct 27, 2020 at 11:29 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Oct 27, 2020 at 12:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Tue, Oct 27, 2020 at 10:33 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:

...

> > I meant devm_krealloc(). It should work in this case without your
> > additional "fix" patch.

> I know, this is why I sent the fix separately. The fix is still
> correct on its own.

My point is it's not needed. At all.
It will actually make a regression. But this is for discussion in that thread.

...

> > > Or maybe add devm_krealloc_array() which would perform the checks
> > > behind the scenes?
> >
> > Maybe. But what to do in the cases when you have struct with flexible
> > arrays, like
> > struct foo {
> > ...
> >  type bar[];
> > };
> >
> > ?
>
> Just use regular devm_krealloc() with struct_size()?
>
> >
> > And you do kzalloc(sizeof(foo)) followed by krealloc(). The above name
> > (krealloc_array) may be a bit ambiguous.
>
> But devm_krealloc_array() would only be useful for memory allocated by
> kmalloc_array() or kcalloc(). I don't see what's your point.

Naming ambiguity.
Here I'm not against it. If you think it's a good idea, go for it!

-- 
With Best Regards,
Andy Shevchenko
