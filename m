Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9D433C25
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 18:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhJSQbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJSQbl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 12:31:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0552C06161C;
        Tue, 19 Oct 2021 09:29:28 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g6so8131391ybb.3;
        Tue, 19 Oct 2021 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J78XHtk0yTiXURgVL3TaxzbN4iqYDfNXS5o8OtDU9bs=;
        b=V6BkfA59n1q/wUPW5mIxLE6Mlin2TdZOOctv/yUZp+GvrRa1N9oDplN3RnpQyB1ErR
         lL8UyJmxV/b/lXVwf8chRAN0+nQlqLaA8ThyK/nFPfEkzB2JFg4AdMmgJMLAyG/52d7/
         hy8ICxIqBD4F11hDClAUF9FDlwy1iW7D0uS+zOkx/ijI+B+2srdJ7ir8qXqGMUW9jvw3
         XNY5HH/tgWv4tIpOZXPJXYIk5Kp21Mhw/cBK6EYsfrnbZcJAK4d5dSf6zXl2L/lyKThL
         wBfNycRfBSkZsF18jd/YizBdl5ncv1STnJdO+x5SJEOLqzv/80gWBb/BqfswALw1YUXb
         7Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J78XHtk0yTiXURgVL3TaxzbN4iqYDfNXS5o8OtDU9bs=;
        b=QEKFjGJbfJlgz0BNEIkGu0IVyGjE+Qb9FctXXBSOBEb/0QQlWpfZnpLyyuf5tPeLIG
         OfQUgrZqAKta4pma9o5ZKl0z8im0ONY6RmmDn7jNbEohRSKXju97cN/js4hZUDEbwGBm
         mvtvKhyGUmvPTc5mOCTd7f/WZrWxq1vfHHUnUDtHVKghn8hoTM/CJQsJBjf0cTiyGaQG
         UEOBaNYsbhzH8ELuVXcGo3JTzKT0NjObPioQGsFd6gtKMCPZ7mHkUzzFdzO4eBKRhsgm
         +FnXXlJG3C06+FHGCBuYOU2aTwLIAGwabEEzVCHW8cKcDvfJa+kasKY2UpzsTOazQQ9u
         8frw==
X-Gm-Message-State: AOAM530WzCW4UzFAgI3GM1nGVBRxCgq49a15cN3TWiGbCJ3MUIXNS2Py
        M/WNojveJC7JcRsyiDonz9sHSU3AD39XozQeB7E=
X-Google-Smtp-Source: ABdhPJy4PLn5pDo/W7hEIGapAm+cHHFPBsqpwcP95QTzvHzjwia8X1+iDF4y8YtJl0JYML7X2HOsnoIj3DVyPSsDq+4=
X-Received: by 2002:a25:5846:: with SMTP id m67mr35963205ybb.231.1634660968212;
 Tue, 19 Oct 2021 09:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com> <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
 <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
In-Reply-To: <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Tue, 19 Oct 2021 19:29:17 +0300
Message-ID: <CACAwPwaN-4onX=o+czsLh-0emDCJRCg_-qgqPWYqj1b3-4N+Bg@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-realtek-soc@lists.infradead.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, nic_swsd@realtek.com,
        Derek Fang <derek.fang@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Kailang Yang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LKML <linux-kernel@vger.kernel.org>, info@ayaneo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 19, 2021 at 12:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Oct 18, 2021 at 11:42 PM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > On Mon, Oct 18, 2021 at 10:02 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:
>
> ...
>
> > > Thank you for sharing. Seems they indeed used (deliberately or not) the wrong
> > > ID. So there are questions I have:
> > > - Is the firmware available in the wild?
> >
> > Likely so. It looks Aya team only released a single windows driver which
> > works on all revisions of their device including the Founder Edition,
> > which was released more that a year ago.
> >
> > It is likely that all 3 revisions that they sold carry this ACPI ID.
> > (The founder edition, first batch of IndieGoGo orders which had a
> > redesigned shell,
> > and 2nd batch (which I have) which has a new wifi card, a bit better
> > controller,
> > among other changes).
> >
> >
> > > - Do they plan to update firmware to fix this?
> > > - Can we make sure that guys got their mistake and will be more careful
> > >   in the future?
> >
> > I CCed them, hoping that they would hear us. I can also raise this on their
> > discord when I find time to look there.
>
> I expect to have confirmation from them that they have got it and
> promise to fix the firmware (ACPI tables) for supported and future
> products.Can it be achieved? (Note, Hans already told what the HID
> should be used there)

Small Note: we are talking about BMI160 and not BMC150 and its ACPI HID is
I think is BMI0160. This doesn't change much, other that maybe a bit
more code to be added to read the rotation matrix.

>
> > > Realtek probably should make this ID marked somehow broken and not use
> > > in their products in case the answer to the first of the above question
> > > is "yes". (Of course in case the ID will be used for solely PCI enumerated
> > > product there will be no conflict, I just propose to be on the safest side,
> > > but remark should be made somewhere).
>
> Any comments from Realtek, please?
>
> > > > BTW, I also notice a rotation matrix embedded in DSTD, but the linux's
> > > > BMI160 driver doesn't recognize it.
> > >
> > > This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
> > > mount-matrix from ACPI") which needs to be amended to take care about
> > > more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
> > > Hans, what do you think?
> >
> > If you like to, I can probably volunteer to prepare a patch for this myself next
> > weekend, using this pointer as a reference.
>
> The best is to cooperate with Hans as he is much more involved in the
> topic of how these sensors are programmed and used in the Linux
> kernel. My job here is to fix ACPI HID and
> make every stakeholder be aware now and in the future.

Yep, not a problem at all, I am open to test any patch to fix these issues,
as well as try to write my own.


>
> ...
>
> > I will prepare a patch with a better commit description this weekend.
>
> Thanks, but let's not be in such a hurry, I really want to hear from
> both vendors. I guess a couple of weeks would be a reasonable time to
> settle this down.

I guess you are right. Waiting a few weeks seems very reasonable.

Thanks,
Best regards,
        Maxim Levitsky


>
> --
> With Best Regards,
> Andy Shevchenko
