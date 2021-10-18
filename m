Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0581432890
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJRUpI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhJRUpH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 16:45:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1005C06161C;
        Mon, 18 Oct 2021 13:42:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n65so115816ybb.7;
        Mon, 18 Oct 2021 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMMxXst2ZoD81CU4ID788FdVQy/9/0/vD87y7ue82uc=;
        b=pX1EXzYgtbC8geq9Fy5n3+CgDLkjbU9yzZRIfFcS8xL+IoAcnq7kUGIf8y4wYm0WoT
         BJbo8iI7ObWEBUZBXum9A8+jeQIXp+3S6J23qdvh6xEP8cVnIpHTD1kYYRK4RpeOaxhx
         FhortOHm89V5T+LGB1Iu06Jt5ZIg1hf39CjMy4fs36ehzDdik3AwDRQ0KOkv0zKtiOJf
         yNhCyokz1o3QiJauJYZslEEgczpdVMNsFPObBvzOUcgop29OAOvH0PpCfHZAZmMsJnFz
         kPJKRDA3P5WenbuocOEVLKPAuelwsPTOgyv3q0cjNnLMfMl+H+TiZvRKgx1kdxyWTsbS
         Xv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMMxXst2ZoD81CU4ID788FdVQy/9/0/vD87y7ue82uc=;
        b=OojWSF5LrupY9SguOy/A767TGYIj60LsKejs1sg5dvNiGHGiigpghdsS6oivU6jiPm
         OqFe5pRuJNZIO4LdcaMtM8DgyYNfweA/l4YDvnZnlF5X+GTTGCFYkrheGoVOKDlYhJUy
         XazZBFxDXlC1Or+GlfYZZOk9nXi/qb6kDAM86x7y50fIujRdBLqnOqsu+Zdfr4BxmYHy
         IRcl7BfCpY3mEHe7xUVuxlybtACx177LqrY/n2uihv4usFt+yFpu7WRDyWS+Yt0lMve7
         TLCDNg+lmzLL7Wd+wLrus5rXjEy2stiQa9LJgNIy/53mCOb0eXOvf9i9Oz1QAdxuxgWK
         i48w==
X-Gm-Message-State: AOAM530stkZX5svPxUumnMo1lAC7cC6WRykPBmKke17vRflNsIF31YwA
        EsMeLZe2fXikEtCeg1TFQKeV239ukW+OXnpVUPk=
X-Google-Smtp-Source: ABdhPJyvX+Nf0TFY0fY+mohyVJ0yLPlViIul+h2jDlLo0+nJcdieuCw3lot8vKGyATPDFdtVLDS//H6YFzGiFJxHTd0=
X-Received: by 2002:a25:b790:: with SMTP id n16mr30530564ybh.395.1634589774922;
 Mon, 18 Oct 2021 13:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com> <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
In-Reply-To: <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Mon, 18 Oct 2021 23:42:44 +0300
Message-ID: <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Mon, Oct 18, 2021 at 10:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:
> > I also suspect a mistake from the hardware vendors.
> >
> > I attached all DSDT decompiled, which shows that they indeed use that
> > ID, and I also attached the windows driver .INF which was published on
> > their website  with the driver (https://www.ayaneo.com/downloads)
> >
> > They are a small startup so they might have used the realtek ID by mistake.
> > I added them to the CC.
>
> Thank you for sharing. Seems they indeed used (deliberately or not) the wrong
> ID. So there are questions I have:
> - Is the firmware available in the wild?

Likely so. It looks Aya team only released a single windows driver which
works on all revisions of their device including the Founder Edition,
which was released more that a year ago.

It is likely that all 3 revisions that they sold carry this ACPI ID.
(The founder edition, first batch of IndieGoGo orders which had a
redesigned shell,
and 2nd batch (which I have) which has a new wifi card, a bit better
controller,
among other changes).


> - Do they plan to update firmware to fix this?
> - Can we make sure that guys got their mistake and will be more careful
>   in the future?

I CCed them, hoping that they would hear us. I can also raise this on their
discord when I find time to look there.

>
> Realtek probably should make this ID marked somehow broken and not use
> in their products in case the answer to the first of the above question
> is "yes". (Of course in case the ID will be used for solely PCI enumerated
> product there will be no conflict, I just propose to be on the safest side,
> but remark should be made somewhere).

>
> > BTW, I also notice a rotation matrix embedded in DSTD, but the linux's
> > BMI160 driver doesn't recognize it.
>
> This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
> mount-matrix from ACPI") which needs to be amended to take care about
> more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
> Hans, what do you think?

If you like to, I can probably volunteer to prepare a patch for this myself next
weekend, using this pointer as a reference.

>
> P.S. As I said, the commit message and the code (in the comments) should
> be very well elaborated and only accepted in case the firmware is already
> in the wild on the market.

I will prepare a patch with a better commit description this weekend.


Thank you very much,
Best regards,
      Maxim Levitsky


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
