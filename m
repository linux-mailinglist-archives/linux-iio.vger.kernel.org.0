Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219AF497385
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jan 2022 18:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiAWRXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jan 2022 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiAWRW7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jan 2022 12:22:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D54C06173B
        for <linux-iio@vger.kernel.org>; Sun, 23 Jan 2022 09:22:59 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id m6so43834034ybc.9
        for <linux-iio@vger.kernel.org>; Sun, 23 Jan 2022 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o6NsuyNZFv1cpKIdPpjXz9s6orM4+m83PURsQJN4vvI=;
        b=m4gPpQR+iSH6iA11USVtgFUMb7YqtHZ5rTIS9aPY41GYfSFP31+AVuK5FV6j5Tik1h
         UnO0meyCFmpivGqNFACJGQTED8FAVdqDCsnM/n9ZIDqu6bo/jD1kXVFbRK7kW74LWJeJ
         5fheIbgt91lQPiFk4ZsYLYn5GW3lbmYYvOKbmkppYyjdaq+e1vef4eraXC5zLvMDNRS/
         yduBfjnvJpGvkCdw1VEjbsMGN8QkF7NSaMNYQubOMUGQopJk6TJOVBp1cU1MrkQTC3ZG
         YmaDm4ebuQ7nhNPMciOJbwdfCsQtlt6pGGw1SSNQzXg6mjtU4uO/xUhRSQUpMAJajdH3
         Z5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6NsuyNZFv1cpKIdPpjXz9s6orM4+m83PURsQJN4vvI=;
        b=lbCSUPvplNV51HIHIvgL/9BmtlrFkW7dcO2gGQ/ba+4iEPKrnOL+D5dUP5jgrnxBRb
         eu05DqeISn6EFkJPw2CLYyZLdv9cxSxFDG4PR4w+bkNAo0eM9s73V94G9x8IzX52bPZY
         8jV2yIrKpO/CiAVvREBAzCOqivoCDBAvmIerjw139u7Y+3xeCqbdtLbztYBQvuhoHNKh
         MkW3CKLL9YgsPvnZ756MBh8R40onfo8vT9B3HprMgX8UKSIVQw5OTMsAWdnRtH2cocy/
         Xfyyz29mPbaC08miyvi1ks0Tcue0/RBfI/UrvejT4nwU7+xVBJEqOUh6wbCxOIO2ZBl1
         NP4Q==
X-Gm-Message-State: AOAM530OsvzYy1cf+VRLrSnJAnSN81taTMScKO4obMImtAH08u8Pgo+b
        XnQHObq/QHkQyjCg83sFlRjcYqpv4aMQnHi5S3E=
X-Google-Smtp-Source: ABdhPJwjawdvKws8goS/pCaN8a+sKXubBuVYXt7F695mMs58I+NYCwfqVZbDiefT4ipHPSfOoZwhOF0rnDm3x84xK2M=
X-Received: by 2002:a05:6902:705:: with SMTP id k5mr14426685ybt.564.1642958577481;
 Sun, 23 Jan 2022 09:22:57 -0800 (PST)
MIME-Version: 1.0
References: <CACAwPwauWAcin3Vj4cOM1uejrCz-eRX_3Hp_iZFap--yuXK0jg@mail.gmail.com>
 <Yeh564iHDXEzHXUQ@smile.fi.intel.com>
In-Reply-To: <Yeh564iHDXEzHXUQ@smile.fi.intel.com>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Sun, 23 Jan 2022 19:22:46 +0200
Message-ID: <CACAwPwatbMjd9CLdFCWnND3FqT5ZtPJqEVC-Ohze+GoJ6ODqqw@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hayes Wang <hayeswang@realtek.com>, nicfae@realtek.com,
        wlanfae@realtek.com, pctech@realtek.com, security@realtek.com,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pkshih <pkshih@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
        =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        Kailang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "info@ayaneo.com" <info@ayaneo.com>, meakyi@ayaneo.com,
        software@ayaneo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added software@ayaneo.com to CC ( I found this email on google).

Best regards,
   Maxim Levitsky


On Wed, Jan 19, 2022 at 10:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> +Cc: more Aya-Neo emails (please, share it with your legal, involved mana=
gers
>      and engineers).
>
> On Wed, Jan 19, 2022 at 09:05:25PM +0200, Maxim Levitsky wrote:
> > > Any news from Aya-Neo? Have you fixed and issued a new firmware, plea=
se?
> >
> > Nothing I heard of. Anything I can do to further help with this?
>
> Unfortunately we need to hear from the Aya-Neo, if they ever care about t=
heir
> products. Without that it would make an unfortunate precedent which will =
open
> a Pandora's box (means a green light on abusing ACPI specification and ot=
her's
> IPs, yes, Intellectual Property in this case, as ID is an IP of the corre=
sponding
> vendor).
>
> I'm fine if Realtek doesn't care about their IDs to be (ab)used by somebo=
dy else,
> the main problem here is on Aya-Neo side.
>
> Is there any engineer-to-engineer connection with Aya-Neo? Because using =
that
> info@ address may be simply ignored / went to spam / etc.
>
> > On Tue, Nov 16, 2021 at 7:50 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > I filed the form, Cc'ed this to more people from Realtek, still no re=
sponse on
> > > the topic. Does Realtek really cares about their IDs?
> > >
> > > Any news from Aya-Neo? Have you fixed and issued a new firmware, plea=
se?
> > >
> > > On Wed, Oct 20, 2021 at 02:21:04PM +0300, Andy Shevchenko wrote:
> > > > +Cc: another set of emails from Realtek as per Hayes' email.
> > > >
> > > > Please waterfall to the people inside Realtek who can answer the qu=
estion.
> > > > (Note, you may access this discussion in full via:
> > > > https://lore.kernel.org/linux-iio/CACAwPwYQHRcrabw9=3D0tvenPzAcwwW1=
pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/T/#u)
> > > >
> > > > The problem here is to have an official confirmation of what 10ec:5=
280
> > > > ID is from Realtek's point of view.
> > > >
> > > > Context: the current discussion and a patch state that it's related
> > > > to gyro sensor. Is it so?
> > > >
> > > > On Wed, Oct 20, 2021 at 10:36:12AM +0300, Andy Shevchenko wrote:
> > > > > On Wednesday, October 20, 2021, Hayes Wang <hayeswang@realtek.com=
> wrote:
> > > > > > Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > Sent: Tuesday, October 19, 2021 5:59 PM
> > > >
> > > > ...
> > > >
> > > > > > > > > Realtek probably should make this ID marked somehow broke=
n and not
> > > > > > use
> > > > > > > > > in their products in case the answer to the first of the =
above
> > > > > > question
> > > > > > > > > is "yes". (Of course in case the ID will be used for sole=
ly PCI
> > > > > > enumerated
> > > > > > > > > product there will be no conflict, I just propose to be o=
n the
> > > > > > safest side,
> > > > > > > > > but remark should be made somewhere).
> > > > > > >
> > > > > > > Any comments from Realtek, please?
> > > > > >
> > > > > > Excuse me. I don't know this device, so I don't know who I coul=
d forward.
> > > > > > Maybe you could try our contract window from our web site.
> > > > > > https://www.realtek.com/en/cu-1-en/cu-1-taiwan-en
> > > > >
> > > > > Thanks for reply. I will try my best, but I am afraid that what y=
ou suggest
> > > > > will be a long loop (and I believe the people behind that form ar=
e not
> > > > > technical, they probably won=E2=80=99t understand the topic). I t=
hink you may pull
> > > > > strings inside much faster. Just ask somebody who is technical su=
perior in
> > > > > your team / organization. Ideally inside company you may have a d=
edicated
> > > > > people who responsible for allocating PCI and ACPI IDs.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
