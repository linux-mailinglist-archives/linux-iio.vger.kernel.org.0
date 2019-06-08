Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E039C84
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFHKx5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 06:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfFHKx5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 06:53:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0291C212F5;
        Sat,  8 Jun 2019 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559991235;
        bh=vyiv1d9hAKJpvDiAuZjJxBWNxr8TA1Ow16OKEU831z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kZsI/e3UycHhVTiZDyqsTMaLSbUP5fvsA2CgBWWZBj94pUsswuo1igmSREMM5BpEF
         LOhxtNhxil4at4rsTx+bAVNUtejccTZ3vq/l7IVLk1k+GwvfECVNDR+rB3E8cjJqAW
         E+weMQGeQBU1fpvVVKlpkpyz5rabOoARTMjWqHs0=
Date:   Sat, 8 Jun 2019 11:53:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?B?THXDrXM=?= Ferreira <luis@aurorafoss.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based
 ultrabooks
Message-ID: <20190608115350.07cf97d7@archlinux>
In-Reply-To: <e9a53afc-30de-134b-0454-869262aaa134@redhat.com>
References: <c2f3c22c-d491-17e7-ede7-54f9df11e064@redhat.com>
        <20190402160433.15810-1-luis@aurorafoss.org>
        <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
        <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
        <c34e15ec4be9d783c7134491639eb176@_>
        <9d8458a1-fc47-0727-4dc8-1d1eb185886d@redhat.com>
        <CAPyOxm9Q0Chq+TVjyK1eFWXCSJb0d-pttnEFVRB0Sw4QZnMM+Q@mail.gmail.com>
        <96658776-bd09-4b2d-2049-f2b213d60f8a@redhat.com>
        <CAPyOxm-dA3BF-6oRJt-rcNMQSucfOHNtGgXj4=aZ7a7khfvhVw@mail.gmail.com>
        <e9a53afc-30de-134b-0454-869262aaa134@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 14:35:10 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>=20
> On 30-05-19 13:53, Lu=C3=ADs Ferreira wrote:
> > Hi,
> >=20
> > @poettering just merged the pull request. Is it ready to go now? =20
>=20
> You mean the kernel patch, yes merging that now is fine with me.
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> >=20
> > Sincerely,
> > Lu=C3=ADs Ferreira
> > E2AB 2BF8 F3EC ABE2 E149 F2FD BC43 0831 9CE4 0B64
> >=20
> > On Wed, 29 May 2019 at 10:57, Hans de Goede <hdegoede@redhat.com> wrote=
: =20
> >>
> >> Hi,
> >>
> >> On 5/23/19 2:03 PM, Lu=C3=ADs Ferreira wrote: =20
> >>> Hi Hams,
> >>>
> >>> https://github.com/systemd/systemd/pull/12322
> >>> https://github.com/hadess/iio-sensor-proxy/pull/262
> >>>
> >>> As all the pull requests to systemd and iio-sensor-proxy has already
> >>> been merged, I just need your review on this:
> >>> https://github.com/systemd/systemd/pull/12449
> >>>
> >>> Then, I guess this patch is ready to go. Please let me know if theres=
 any issue. =20
> >>
> >> Thank you for your work on this. I've given a favorable review to the
> >>
> >> last systemd  pull-req.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >> =20
> >>> On Wed, 17 Apr 2019 at 16:08, Hans de Goede <hdegoede@redhat.com> wro=
te: =20
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 15-04-19 17:40, luis@aurorafoss.org wrote: =20
> >>>>> April 6, 2019 10:36 AM, "Hans de Goede" <hdegoede@redhat.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>> =20
> >>>>>> Yes that seems the best way forward with this.
> >>>>>>
> >>>>>> Note I think "base" is better then "keyboard" for the sensor which
> >>>>>> is in the base/keyboard. But neither is perfect, so go which whate=
ver
> >>>>>> you prefer. =20
> >>>>>
> >>>>> Reference to:
> >>>>> - https://github.com/hadess/iio-sensor-proxy/pull/262 > - https://g=
ithub.com/systemd/systemd/pull/12322 =20
> >>>>
> >>>> Thank you for your work on this, I see that Bastien has
> >>>> already reviewed the iio-sensor-proxy changes.
> >>>>
> >>>> I've just added one small remark to the systemd changes,
> >>>> except for that small remark the systemd changes look good to me.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hams
> >>>>
> >>>>
> >>>>
> >>>> =20
> >>>>>> On 06-04-19 01:01, Lu=C3=ADs Ferreira wrote:
> >>>>>> =20
> >>>>>>> Hi,
> >>>>>>> Basically we need to come up with a convention to (optionally) in=
dicate =20
> >>>>>>
> >>>>>> the sensors location with a udev attribute set by:
> >>>>>> /lib/udev/hwdb.d/60-sensor.hwdb =20
> >>>>>>> So should we start adding `ACCEL_LOCATION=3Ddisplay` and
> >>>>>>> `ACCEL_LOCATION=3Dkeyboard` attributes to that file and patch
> >>>>>>> iio-sensor-proxy to ignore the keyboard ones as a first step ? =20
> >>>>>>
> >>>>>> Yes that seems the best way forward with this.
> >>>>>>
> >>>>>> Note I think "base" is better then "keyboard" for the sensor which
> >>>>>> is in the base/keyboard. But neither is perfect, so go which whate=
ver
> >>>>>> you prefer.
> >>>>>>
> >>>>>> Thanks & Regards,
> >>>>>>
> >>>>>> Hans
> >>>>>> =20
> >>>>>>> On Wed, 3 Apr 2019 at 10:10, Hans de Goede <hdegoede@redhat.com> =
wrote: =20
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 02-04-19 18:04, Lu=C3=ADs Ferreira wrote: =20
> >>>>>>> Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on disp=
lay
> >>>>>>> and KIOX020A sensor on keyboard base, to detect tablet mode or sc=
reen
> >>>>>>> orientation. =20
> >>>>>>
> >>>>>> I deliberately left out the KIOX020A id for now, because currently
> >>>>>> userspace cannot really deal with having 2 sensors.
> >>>>>>
> >>>>>> See:
> >>>>>> https://github.com/systemd/systemd/issues/6557
> >>>>>> https://github.com/hadess/iio-sensor-proxy/issues/166
> >>>>>>
> >>>>>> Basically we need to come up with a convention to (optionally) ind=
icate
> >>>>>> the sensors location with a udev attribute set by:
> >>>>>> /lib/udev/hwdb.d/60-sensor.hwdb
> >>>>>>
> >>>>>> And then patch iio-sensor-proxy to consume that attribute and igno=
re
> >>>>>> the one which has e.g. ACCEL_LOCATION=3Dkeyboard in its udev prope=
rties
> >>>>>>
> >>>>>> Ignoring would be a first step, maybe later it can do something us=
eful
> >>>>>> with it, see e.g. : https://github.com/alesguzik/linux_detect_tabl=
et_mode
> >>>>>>
> >>>>>> IMHO we really should minimally get code in place for iio-sensor-p=
roxy
> >>>>>> to ignore the keyboard accelerometer before merging this patch.
> >>>>>>
> >>>>>> I realize that having the code in place will not magically get it =
on
> >>>>>> all users machines, but I believe this is the minimum which needs =
to
> >>>>>> happen before we push this out and potentially breaks people screen
> >>>>>> rotation.
> >>>>>>
> >>>>>> I've had working on this on my TODO list for a long long time now,
> >>>>>> but -ENOTIME. If you have some time to work on this then that would
> >>>>>> be great.
> >>>>>>
> >>>>>> Regards,
> >>>>>>
> >>>>>> Hans =20
> >>>>>>> Signed-off-by: Lu=C3=ADs Ferreira <luis@aurorafoss.org>
> >>>>>>> ---
> >>>>>>> drivers/iio/accel/kxcjk-1013.c | 1 +
> >>>>>>> 1 file changed, 1 insertion(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/k=
xcjk-1013.c
> >>>>>>> index 7096e577b23f..9a5e445facc1 100644
> >>>>>>> --- a/drivers/iio/accel/kxcjk-1013.c
> >>>>>>> +++ b/drivers/iio/accel/kxcjk-1013.c
> >>>>>>> @@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_=
match[] =3D {
> >>>>>>> {"KIOX0009", KXTJ21009},
> >>>>>>> {"KIOX000A", KXCJ91008},
> >>>>>>> {"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-i=
n-1 */
> >>>>>>> + {"KIOX020A", KXCJ91008},
> >>>>>>> {"KXTJ1009", KXTJ21009},
> >>>>>>> {"KXJ2109", KXTJ21009},
> >>>>>>> {"SMO8500", KXCJ91008}, =20

