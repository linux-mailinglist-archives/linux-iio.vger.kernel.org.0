Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C446D2FB2E
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfE3Lxp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 07:53:45 -0400
Received: from out.migadu.com ([91.121.223.63]:36872 "EHLO out.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfE3Lxp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 07:53:45 -0400
Received: (Migadu outbound); Thu, 30 May 2019 11:53:42 +0000
Authentication-Results: out.migadu.com; auth=pass (plain)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by out.migadu.com (Haraka/2.8.16) with ESMTPSA id AB0730A3-24C5-48C6-9F93-87B0BE4C538E.1
        envelope-from <luis@aurorafoss.org> (authenticated bits=0)
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 verify=FAIL);
        Thu, 30 May 2019 11:53:41 +0000
Received: by mail-oi1-f169.google.com with SMTP id t187so4666690oie.10;
        Thu, 30 May 2019 04:53:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUqKWY5YU/ojkJhGDXs8UtI3vyxI0/36gwRXB37sMCmmngn+LkX
        MvJLIsSNFFgsVwxiOwTslEIPzCTGbc3QReY1r6M=
X-Google-Smtp-Source: APXvYqwQSES/ozODI8114f8PtGcfzAr8714XhKQNvMHnNaZ9HVK8SJWCrolP5cWP712FYp7d8TGI/1ek3Xx+bmJflq4=
X-Received: by 2002:aca:b58b:: with SMTP id e133mr2212171oif.49.1559217220705;
 Thu, 30 May 2019 04:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <c2f3c22c-d491-17e7-ede7-54f9df11e064@redhat.com>
 <20190402160433.15810-1-luis@aurorafoss.org> <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
 <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
 <c34e15ec4be9d783c7134491639eb176@_> <9d8458a1-fc47-0727-4dc8-1d1eb185886d@redhat.com>
 <CAPyOxm9Q0Chq+TVjyK1eFWXCSJb0d-pttnEFVRB0Sw4QZnMM+Q@mail.gmail.com> <96658776-bd09-4b2d-2049-f2b213d60f8a@redhat.com>
In-Reply-To: <96658776-bd09-4b2d-2049-f2b213d60f8a@redhat.com>
From:   =?UTF-8?Q?Lu=C3=ADs_Ferreira?= <luis@aurorafoss.org>
Date:   Thu, 30 May 2019 12:53:29 +0100
X-Gmail-Original-Message-ID: <CAPyOxm-dA3BF-6oRJt-rcNMQSucfOHNtGgXj4=aZ7a7khfvhVw@mail.gmail.com>
Message-ID: <CAPyOxm-dA3BF-6oRJt-rcNMQSucfOHNtGgXj4=aZ7a7khfvhVw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based ultrabooks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1;a=rsa-sha256;bh=FekFk5TqaPJwygzCDYDGW/0YXaV6idE5yT7Rfk1uOOs=;c=relaxed/simple;d=aurorafoss.org;h=from:subject:date:to;s=default;b=E2F9/TuiuzUTfq2JoR5f4Ha+hgXQVC9+JGk2WhQ7FIK/R+RW10wRck+hHi19/Il72623h74emZ+pqtNTlz6wH1Es4MIEnoK4LJ0k8dPAt+UTY1Ky6qcRiR81vcWvCYG5yuwxHxSrjKoP6Ew4B+e9FK/CtDIIPV3ZBEaM8IjddA0=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

@poettering just merged the pull request. Is it ready to go now?

Sincerely,
Lu=C3=ADs Ferreira
E2AB 2BF8 F3EC ABE2 E149 F2FD BC43 0831 9CE4 0B64

On Wed, 29 May 2019 at 10:57, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 5/23/19 2:03 PM, Lu=C3=ADs Ferreira wrote:
> > Hi Hams,
> >
> > https://github.com/systemd/systemd/pull/12322
> > https://github.com/hadess/iio-sensor-proxy/pull/262
> >
> > As all the pull requests to systemd and iio-sensor-proxy has already
> > been merged, I just need your review on this:
> > https://github.com/systemd/systemd/pull/12449
> >
> > Then, I guess this patch is ready to go. Please let me know if theres a=
ny issue.
>
> Thank you for your work on this. I've given a favorable review to the
>
> last systemd  pull-req.
>
> Regards,
>
> Hans
>
>
> > On Wed, 17 Apr 2019 at 16:08, Hans de Goede <hdegoede@redhat.com> wrote=
:
> >>
> >> Hi,
> >>
> >> On 15-04-19 17:40, luis@aurorafoss.org wrote:
> >>> April 6, 2019 10:36 AM, "Hans de Goede" <hdegoede@redhat.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>>> Yes that seems the best way forward with this.
> >>>>
> >>>> Note I think "base" is better then "keyboard" for the sensor which
> >>>> is in the base/keyboard. But neither is perfect, so go which whateve=
r
> >>>> you prefer.
> >>>
> >>> Reference to:
> >>> - https://github.com/hadess/iio-sensor-proxy/pull/262 > - https://git=
hub.com/systemd/systemd/pull/12322
> >>
> >> Thank you for your work on this, I see that Bastien has
> >> already reviewed the iio-sensor-proxy changes.
> >>
> >> I've just added one small remark to the systemd changes,
> >> except for that small remark the systemd changes look good to me.
> >>
> >> Regards,
> >>
> >> Hams
> >>
> >>
> >>
> >>
> >>>> On 06-04-19 01:01, Lu=C3=ADs Ferreira wrote:
> >>>>
> >>>>> Hi,
> >>>>> Basically we need to come up with a convention to (optionally) indi=
cate
> >>>>
> >>>> the sensors location with a udev attribute set by:
> >>>> /lib/udev/hwdb.d/60-sensor.hwdb
> >>>>> So should we start adding `ACCEL_LOCATION=3Ddisplay` and
> >>>>> `ACCEL_LOCATION=3Dkeyboard` attributes to that file and patch
> >>>>> iio-sensor-proxy to ignore the keyboard ones as a first step ?
> >>>>
> >>>> Yes that seems the best way forward with this.
> >>>>
> >>>> Note I think "base" is better then "keyboard" for the sensor which
> >>>> is in the base/keyboard. But neither is perfect, so go which whateve=
r
> >>>> you prefer.
> >>>>
> >>>> Thanks & Regards,
> >>>>
> >>>> Hans
> >>>>
> >>>>> On Wed, 3 Apr 2019 at 10:10, Hans de Goede <hdegoede@redhat.com> wr=
ote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 02-04-19 18:04, Lu=C3=ADs Ferreira wrote:
> >>>>> Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on displa=
y
> >>>>> and KIOX020A sensor on keyboard base, to detect tablet mode or scre=
en
> >>>>> orientation.
> >>>>
> >>>> I deliberately left out the KIOX020A id for now, because currently
> >>>> userspace cannot really deal with having 2 sensors.
> >>>>
> >>>> See:
> >>>> https://github.com/systemd/systemd/issues/6557
> >>>> https://github.com/hadess/iio-sensor-proxy/issues/166
> >>>>
> >>>> Basically we need to come up with a convention to (optionally) indic=
ate
> >>>> the sensors location with a udev attribute set by:
> >>>> /lib/udev/hwdb.d/60-sensor.hwdb
> >>>>
> >>>> And then patch iio-sensor-proxy to consume that attribute and ignore
> >>>> the one which has e.g. ACCEL_LOCATION=3Dkeyboard in its udev propert=
ies
> >>>>
> >>>> Ignoring would be a first step, maybe later it can do something usef=
ul
> >>>> with it, see e.g. : https://github.com/alesguzik/linux_detect_tablet=
_mode
> >>>>
> >>>> IMHO we really should minimally get code in place for iio-sensor-pro=
xy
> >>>> to ignore the keyboard accelerometer before merging this patch.
> >>>>
> >>>> I realize that having the code in place will not magically get it on
> >>>> all users machines, but I believe this is the minimum which needs to
> >>>> happen before we push this out and potentially breaks people screen
> >>>> rotation.
> >>>>
> >>>> I've had working on this on my TODO list for a long long time now,
> >>>> but -ENOTIME. If you have some time to work on this then that would
> >>>> be great.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hans
> >>>>> Signed-off-by: Lu=C3=ADs Ferreira <luis@aurorafoss.org>
> >>>>> ---
> >>>>> drivers/iio/accel/kxcjk-1013.c | 1 +
> >>>>> 1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxc=
jk-1013.c
> >>>>> index 7096e577b23f..9a5e445facc1 100644
> >>>>> --- a/drivers/iio/accel/kxcjk-1013.c
> >>>>> +++ b/drivers/iio/accel/kxcjk-1013.c
> >>>>> @@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_ma=
tch[] =3D {
> >>>>> {"KIOX0009", KXTJ21009},
> >>>>> {"KIOX000A", KXCJ91008},
> >>>>> {"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-=
1 */
> >>>>> + {"KIOX020A", KXCJ91008},
> >>>>> {"KXTJ1009", KXTJ21009},
> >>>>> {"KXJ2109", KXTJ21009},
> >>>>> {"SMO8500", KXCJ91008},
