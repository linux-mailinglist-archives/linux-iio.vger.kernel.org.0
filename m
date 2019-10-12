Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458ECD51B6
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 20:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfJLSre (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 14:47:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37631 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfJLSre (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 14:47:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so10723245oie.4
        for <linux-iio@vger.kernel.org>; Sat, 12 Oct 2019 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M4hviIaYBakjq3wyzuCK4M7g9B6CKEUn9YNNsq0+fnU=;
        b=uP3OraWlzSy2PZJRBaCPb5+3g/+y7Jo1TY8r/m4F5F6EQLG5VarvkiafjsLmocQEsa
         5UUhhyUMjlSu2WxD1WMYDrEbon7JZYqQkrwx2kWKU64FTumhfd1+gpQodzGuIh+paRQL
         OkGOhkeZxurd+5cvWLklWsltYSnl3FB4cx/2BgInI1ok+nucdhc2G2dr0sn66Zbh5A78
         bL2wMUjWZZWQI5rzoRqwCOEv7KP7sk6EO5kxD22o8Wegq8ixK5b36GFJhRkGBe9u+Kfc
         rPNRhNxqsUun60nyg0UeWEj3A3gGOK8ZgTRT0+LcAdWCFh1LTncZtwIqtyVhHN4VAh16
         tK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M4hviIaYBakjq3wyzuCK4M7g9B6CKEUn9YNNsq0+fnU=;
        b=dsGS8JKcSAbCNbVtogN66uYXjn/8mRxZmf0uhxhD0PrQW2fAlUJiTYvM8vgrnpFSrx
         /rlmSXOrMNrOqtdidjUsXKCF0P1lQVaJ637fbuUjCvG9jHL9mzhHaEEdcxcmuJO+3UEU
         HXGL3IQ/XAX6pPcTdFIVKEuS7GtIIq+NGPAPbiuyY4Q0OCYqxNzAbGvVFZwex0hI3Jgd
         Wo25yK0U1ezNEy9cDhEiNy/fOmo96BWiPpBJ++eEwf4XWSeiRaOlX7JK8gzQ/MfXoKHP
         qZoNIWzVaLlQk9+rovxLUpjXa/aHKze5v1shgR4PiA+Lt3o1gbwpfbY6p/BVChu24cj4
         S72w==
X-Gm-Message-State: APjAAAWypPmUoacZKqIAmp4manZIVxQjdzHiudO0WkpECegdvHCKADGc
        uc4QLgdAeDoPP6Qjon/YsOzGhF3TH23aIP7xuJRxZPuU
X-Google-Smtp-Source: APXvYqzYWF3HcEMnPRW56ohU4zZN/W+gIK366v5hGFlEHSmi9eSw8OYO0bZxJ/v9YzO4vGxWAkPH/iQ+AgUnAPuxksA=
X-Received: by 2002:aca:4794:: with SMTP id u142mr18195555oia.159.1570905716989;
 Sat, 12 Oct 2019 11:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191012121946.051b646f@archlinux> <20191012152744.GA2142233@kroah.com>
 <20191012152841.GB2142233@kroah.com> <20191012170615.01546a96@archlinux>
In-Reply-To: <20191012170615.01546a96@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 12 Oct 2019 21:41:45 +0300
Message-ID: <CA+U=DspmQcUZU3q-ntJEVaqtkkK=gk0GCCu06ntYf_kvnpnLZw@mail.gmail.com>
Subject: Re: [PULL v2] First set of iio new device support etc for the 5.5 cycle
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 7:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 12 Oct 2019 17:28:41 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Sat, Oct 12, 2019 at 05:27:44PM +0200, Greg KH wrote:
> > > On Sat, Oct 12, 2019 at 12:19:46PM +0100, Jonathan Cameron wrote:
> > > > The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767=
499f9655:
> > > >
> > > >   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:4=
9 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tag=
s/iio-for-5.5a-take2
> > >
> > > Better, but I see this now:
> > >
> > > drivers/iio/imu/adis.c: In function =E2=80=98__adis_check_status=E2=
=80=99:
> > > drivers/iio/imu/adis.c:295:9: warning: =E2=80=98status=E2=80=99 may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
> > >   295 |  status &=3D adis->data->status_error_mask;
> > >       |         ^~
> > >
> > >
> > > I'll take this, can you just send a follow-on patch for this?
> >
> > Also I see:
> >
> > drivers/iio/imu/adis16480.c: In function =E2=80=98adis16480_enable_irq=
=E2=80=99:
> > drivers/iio/imu/adis16480.c:950:6: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
> >   950 |  val &=3D ~ADIS16480_DRDY_EN_MSK;
> >       |      ^~
> >   CC [M]  drivers/iio/magnetometer/hmc5843_i2c.o
> > drivers/iio/imu/adis16480.c: In function =E2=80=98adis16480_write_raw=
=E2=80=99:
> > drivers/iio/imu/adis16480.c:571:7: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
> >   571 |   val &=3D ~enable_mask;
> >       |       ^~
> > drivers/iio/imu/adis16480.c:557:11: note: =E2=80=98val=E2=80=99 was dec=
lared here
> >   557 |  uint16_t val;
> >       |           ^~~
> >
> >
> > So did you really fix anything here?
> >
> > I'll drop this pull again.
> >
> > What version of gcc are you using?  Might I suggest a newer one (i.e. a
> > modern one?)
>
> Ah. This is my mistake.  I did see all of these, but still thought we wer=
e
> in the category of tidying up some compiler version caused issues.
>
> The adis16400 came up in my local tests, so I previously pinged Alex on
> basis it was something to do in a follow up. The other two showed up, but
> again I still thought these were compiler version issues, particularly
> as 0-day didn't highlight them (there were several other issues it
> did highlight this week). Hence again I requested a follow up to tidy
> it up.
>
> Anyhow, did some digging.  The issue here was a 'fix' I put in to an init=
ial
> 0-day issue in the inline functions that Alex added.  Note that one
> appears to be compiler version dependent as it didn't turn up in my
> local builds. There are now inline functions that check if (ret)
> and don't set the value if ret is non 0.
>
> Out in the drivers, the check is the more specific (unnecessarily)
> if (ret < 0) and hence the compiler is concluded that there might be a pa=
th to
> val not being set.  Previously it was giving up figuring this out.
> So reality is they are a false positive (sort of as in reality ret
> is never positive) but the compiler has made a reasonable point
> that it can't see that.
>
> Never mind, I'll do a new pull request once fixes are in place.
> Given there are two obvious ways of suppressing this and it's Alex's
> driver I'll wait until he has time to take a look.
>
> Sorry for wasting your time.
>

If it helps, let's drop the ADIS patches for this round, and I can
take a closer look as well.
The cleanup does seem to have revealed a few gaps in our CI in
relation to upstreaming things.

We use Travis-CI for our stuff and stuff is public:
https://travis-ci.org/analogdevicesinc/linux

So, if anyone sees anything we should do better, I'm open to
improvements/suggestions.
I am in the process of adding sparse-builds, maybe some build
hardening is next (stronger compile/build flags), adding our patches
on top of a newer kernel (that's partially done).
That should help us catch things a bit earlier.

Sorry for the noise from my side as-well.
Alex


> Jonathan
