Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09CA4332F6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhJSKCA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJSKB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 06:01:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18752C06161C;
        Tue, 19 Oct 2021 02:59:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i20so10585178edj.10;
        Tue, 19 Oct 2021 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ok4RcBO4chuBAELkxTaC1jvGHBt7wsZQsA6QEOc+VkM=;
        b=XbEbxmdWhPEeBAze0cQSK9xvnF55Jvay+LBtHAkXh28r+NHXfHFV2fMfRgZ+NdLqbF
         QQZXQBTlGzaN/fQI0DvznFWTCG+10you/2durUdkHCXjavoGwfPpFrHUb75PBYWrQahm
         z7eVzaSHWpodVhXx+LFhX9e7jwguuS5IF87yicmXb2uysEUUjVJzvEfasgkwKdDVZGJV
         8pSVGCa4WketpUUa3DqMk2YfqdCA87C6opdG59lhiXXx5PC9Y1zJD5aTrVNu/l+y49SQ
         pbemU5L+FOFjbHIv301bPSyzMfscfro02bJ25O+3Al9PY60S7VSovANt5Wl67qvTsxaY
         TGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ok4RcBO4chuBAELkxTaC1jvGHBt7wsZQsA6QEOc+VkM=;
        b=45ooftOLbBWIK7JwyLbRWLSlR5gZxHObMldeo/wXnCTPRaamqNVoqiQydGkz4mO2xI
         /J95TxwCphnyCO0lXauEKh3mswuRnCU3tMLr+jDUM25mJNq9LUlPxcN61F/0urMsrn/W
         2BKADAsvyFJvJXAvBEFqNMrDXJFzEU95tRgapOxGfL7UkpnQ4Av/NhYeLHWWIZpMrh2q
         Vw1py3GS/9phvDh+9lWufszbZY+QAVY1qpRo2Tdh20v8G4IN3H2NVVqqkjivBPZv6lUx
         9Igfcv5IScBlu+HfvPb1gktcFJuqehHJAKo8R2/mIMJlggXWZ3kGTP86NdFjVvTVaiKp
         w4Vw==
X-Gm-Message-State: AOAM531w/ysg+QaPfpe4/3X4/I63SXK/xysNoY8PwNoOch5PqSZ0Uusy
        Lh8txLcqZA72dSTK/U6aNrn2LYnQu64WfACnbr4=
X-Google-Smtp-Source: ABdhPJxj3yeJm5VLIbDXamoA7KIt533/LFp8lcXbWY5u7MipACFBS9zsJcYnFFTsig0d3MPmt9lxwYS0jifcmFI2mVo=
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr35779021eje.377.1634637585609;
 Tue, 19 Oct 2021 02:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com> <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
In-Reply-To: <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Oct 2021 12:58:53 +0300
Message-ID: <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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

On Mon, Oct 18, 2021 at 11:42 PM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Mon, Oct 18, 2021 at 10:02 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:

...

> > Thank you for sharing. Seems they indeed used (deliberately or not) the wrong
> > ID. So there are questions I have:
> > - Is the firmware available in the wild?
>
> Likely so. It looks Aya team only released a single windows driver which
> works on all revisions of their device including the Founder Edition,
> which was released more that a year ago.
>
> It is likely that all 3 revisions that they sold carry this ACPI ID.
> (The founder edition, first batch of IndieGoGo orders which had a
> redesigned shell,
> and 2nd batch (which I have) which has a new wifi card, a bit better
> controller,
> among other changes).
>
>
> > - Do they plan to update firmware to fix this?
> > - Can we make sure that guys got their mistake and will be more careful
> >   in the future?
>
> I CCed them, hoping that they would hear us. I can also raise this on their
> discord when I find time to look there.

I expect to have confirmation from them that they have got it and
promise to fix the firmware (ACPI tables) for supported and future
products.Can it be achieved? (Note, Hans already told what the HID
should be used there)

> > Realtek probably should make this ID marked somehow broken and not use
> > in their products in case the answer to the first of the above question
> > is "yes". (Of course in case the ID will be used for solely PCI enumerated
> > product there will be no conflict, I just propose to be on the safest side,
> > but remark should be made somewhere).

Any comments from Realtek, please?

> > > BTW, I also notice a rotation matrix embedded in DSTD, but the linux's
> > > BMI160 driver doesn't recognize it.
> >
> > This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
> > mount-matrix from ACPI") which needs to be amended to take care about
> > more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
> > Hans, what do you think?
>
> If you like to, I can probably volunteer to prepare a patch for this myself next
> weekend, using this pointer as a reference.

The best is to cooperate with Hans as he is much more involved in the
topic of how these sensors are programmed and used in the Linux
kernel. My job here is to fix ACPI HID and
make every stakeholder be aware now and in the future.

...

> I will prepare a patch with a better commit description this weekend.

Thanks, but let's not be in such a hurry, I really want to hear from
both vendors. I guess a couple of weeks would be a reasonable time to
settle this down.

-- 
With Best Regards,
Andy Shevchenko
