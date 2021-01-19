Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACC2FB900
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbhASOMv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732160AbhASJRy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 04:17:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195FC061573;
        Tue, 19 Jan 2021 01:17:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p15so11310119pjv.3;
        Tue, 19 Jan 2021 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jJh+2k9wCDrNKQ27JuyEj9qy86OS5Hwk4wsaFrJtzic=;
        b=Cmboxatui+9cUmf1/xiEy/4AwcVEUktmXTUMp1fKBPvsx2Gjk972Y/w+1j0yI1mhAj
         7Fhgc9//+9Wq+k5kDdyQkkoGWynNwgpyNqVNU0z2zarwkv+V2oy7HXxyTDjDMoWZNFrS
         h7NQoDJ0jHcgZmmZatFVaVlkaoaqyR5i/wD+IKCe6Gm+0TeY+SgizLta5g/CGM48fozh
         dlM3ZRWB5TL7qHpMmJTEhWdVUyAsfhWkhsnCyhaERxR+wVDgXr57dMQhCJak/NQOtD7S
         uIF9wmue0I3Xvlex7ivViXMGevjWPWnOeD7QzJHJlXZowl7XPI0uXUtTt0slU1tvF05I
         IeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJh+2k9wCDrNKQ27JuyEj9qy86OS5Hwk4wsaFrJtzic=;
        b=uNvh/SdkcDEX2Bp7aakzdSunFchvi7K1F8af0XNa8x4OPU3Rgd63qdqJPno7sZ/OtL
         wxtZYVSBi+fRuUYIe9VoGEtsu92LDDcFogS0qYRpOxitmAR/PdxWEBDePeTjdaZaPhiO
         PHW+CWuED831+nqHVGB4xYp4uILc2SzBhL7MNmVh5d1LrF3nRLS0jWz1oh6qt0qwjIcA
         nj7WDCYT5/0L2IIiNzzSPtir11xkRVHAub9wdJS9kqC9wOQ5lL8ltYVidn2NSj3Ha5LL
         RhpH7LbUa5f547vtgzCfdFlsVNkTp2Rt3jxNTQpju5QoNh9t6dBZAcijG+JyLCkwwHeb
         MD3g==
X-Gm-Message-State: AOAM533QGXaPo/3kikvHVSwsJp+v2PHbMFT0IXgBxNvwDDmOk1U3cuWV
        g+nujlZTg99JSlKZynEc6TFTl0ChXM0EbQ==
X-Google-Smtp-Source: ABdhPJzq0TwhjZZlKdHr2uue5umJmtD1SkoAajfyzxPQRjB2VcIeqaKSdtzr7RRh/Lrz8Hlq2Uvt9w==
X-Received: by 2002:a17:902:d4d1:b029:de:30a4:360f with SMTP id o17-20020a170902d4d1b02900de30a4360fmr3681601plg.83.1611047833953;
        Tue, 19 Jan 2021 01:17:13 -0800 (PST)
Received: from shinobu (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id m62sm3857601pfm.135.2021.01.19.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 01:17:12 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:17:05 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
Message-ID: <YAajkfaXPqkZUB/2@shinobu>
References: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
 <20210115104947.71d99e87@coco.lan>
 <20210115134720.000011f9@Huawei.com>
 <20210117154218.634dd5fa@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MjKgfLFDy3EUHZT3"
Content-Disposition: inline
In-Reply-To: <20210117154218.634dd5fa@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--MjKgfLFDy3EUHZT3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 17, 2021 at 03:42:18PM +0000, Jonathan Cameron wrote:
> On Fri, 15 Jan 2021 13:47:20 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>=20
> > On Fri, 15 Jan 2021 10:49:47 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >=20
> > > Hi Lukas,
> > >=20
> > > Em Fri, 15 Jan 2021 07:12:38 +0100
> > > Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> > >  =20
> > > > [reduced the recipient list to the main responsible ones and list]
> > > >=20
> > > > Hi Mauro, hi Jonathan,
> > > >=20
> > > > We both, Mauro and I, have been submitting patches to address the
> > > > documentation warnings on linux-next. If it is okay with you, Mauro=
, I
> > > > would like to take responsibility for the task to send out the patc=
hes
> > > > to address all warnings on linux-next in make htmldocs and follow up
> > > > with all the discussions. I can also provide a short weekly summary
> > > > (probably always on Friday) on what is pending where and what I cou=
ld
> > > > not resolve by myself.
> > > >=20
> > > > Is that okay for you?
> > > >=20
> > > > If at some point I do not have the time to take care anymore, I will
> > > > let you know.   =20
> > >=20
> > > Yeah, sure!
> > >=20
> > > Anyway, after applying the patches I sent this week, the warnings
> > > I'm getting are all due to the validation scripts I wrote. So, if=20
> > > everything gets merged (either yours or my version), we'll have zero
> > > Sphinx/kernel-doc warnings again.
> > >=20
> > > The script-validation warnings are:
> > >=20
> > > 1. Broken cross references
> > > --------------------------
> > >=20
> > > $ scripts/documentation-file-ref-check
> > > Warning: Documentation/arm/booting.rst references a file that doesn't=
 exist: Documentation/devicetree/booting-without-of.rst
> > > Warning: Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt r=
eferences a file that doesn't exist: Documentation/devicetree/bindings/iio/=
iio-bindings.txt
> > > Warning: Documentation/devicetree/bindings/input/adc-joystick.yaml re=
ferences a file that doesn't exist: Documentation/devicetree/bindings/iio/i=
io-bindings.txt
> > > Warning: Documentation/devicetree/bindings/power/supply/da9150-charge=
r.txt references a file that doesn't exist: Documentation/devicetree/bindin=
gs/iio/iio-bindings.txt
> > > Warning: Documentation/devicetree/bindings/regulator/rohm,bd9576-regu=
lator.yaml references a file that doesn't exist: Documentation/devicetree/b=
indings/mfd/rohm,bd9576-pmic.yaml
> > > Warning: Documentation/translations/zh_CN/arm/Booting references a fi=
le that doesn't exist: Documentation/devicetree/booting-without-of.rst
> > > Warning: Documentation/virt/kvm/vcpu-requests.rst references a file t=
hat doesn't exist: Documentation/core-api/atomic_ops.rst
> > > Warning: MAINTAINERS references a file that doesn't exist: Documentat=
ion/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
> > > Warning: MAINTAINERS references a file that doesn't exist: Documentat=
ion/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> > > Warning: MAINTAINERS references a file that doesn't exist: Documentat=
ion/devicetree/bindings/display/intel,kmb_display.yaml
> > > Warning: MAINTAINERS references a file that doesn't exist: Documentat=
ion/devicetree/bindings/media/i2c/ov2680.yaml
> > > Warning: include/linux/rculist_nulls.h references a file that doesn't=
 exist: Documentation/core-api/atomic_ops.rst
> > > Warning: tools/memory-model/Documentation/simple.txt references a fil=
e that doesn't exist: Documentation/core-api/atomic_ops.rst
> > >=20
> > > It sounds that part of the above is due to DT patches that weren't
> > > merged yet, but there are a few others that can be solved, but may
> > > require discussions with some Kernel developers/maintainers.
> > >=20
> > > 2. Duplicated ABI definitions
> > > -----------------------------
> > >=20
> > > $ scripts/get_abi.pl validate
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is def=
ined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  ./Docu=
mentation/ABI/testing/sysfs-bus-iio:394
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is def=
ined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  ./Docu=
mentation/ABI/testing/sysfs-bus-iio:395
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is def=
ined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  ./Docu=
mentation/ABI/testing/sysfs-bus-iio:396
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is d=
efined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  ./Do=
cumentation/ABI/testing/sysfs-bus-iio:397
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is d=
efined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  ./Do=
cumentation/ABI/testing/sysfs-bus-iio:398
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is d=
efined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  ./Do=
cumentation/ABI/testing/sysfs-bus-iio:399
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined=
 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100  ./Doc=
umentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
> > > Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_av=
ailable is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-coun=
ter-104-quad-8:2  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8
> > > Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency i=
s defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf=
4371:0  ./Documentation/ABI/testing/sysfs-bus-iio:599
> > > Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown i=
s defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf=
4371:36  ./Documentation/ABI/testing/sysfs-bus-iio:588
> > > Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined=
 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:43  .=
/Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:38
> > > Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is d=
efined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010=
:0  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
> > > Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_avai=
lable is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidi=
ty-hdc2010:1  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
> > > Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defin=
ed 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:0  ./=
Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:8
> > > Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined =
2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Docum=
entation/ABI/testing/sysfs-bus-iio:45
> > > Warning: /sys/class/backlight/<backlight>/l1_daylight_max is defined =
2 times:  ./Documentation/ABI/testing/sysfs-class-backlight-adp8860:12  ./D=
ocumentation/ABI/testing/sysfs-class-backlight-driver-adp8870:4
> > > Warning: /sys/class/leds/<led>/repeat is defined 2 times:  ./Document=
ation/ABI/testing/sysfs-class-led-trigger-pattern:28  ./Documentation/ABI/t=
esting/sysfs-class-led-driver-el15203000:0
> > > Warning: /sys/kernel/iommu_groups/reserved_regions is defined 2 times=
:  ./Documentation/ABI/testing/sysfs-kernel-iommu_groups:15  ./Documentatio=
n/ABI/testing/sysfs-kernel-iommu_groups:27
> > >=20
> > > Perhaps you could check with Jonathan Cameron some strategy to address
> > > the IIO warnings. =20
> >=20
> > I'm being a bit rubbish on those ones. All need a bit of thought...
> >=20
> > I'll try to kill off a few of them this weekend as *touch wood* my
> > review queue is looking fairly short.
>=20
> As I mentioned in the cover letter for the series I've just sent out, I r=
an into
> a bit of an understanding gap around the two counter cases.  This isn't h=
elped
> by the fact it is at least partly deprecated ABI given the counter subsys=
tem
> has much richer ABI for these types of devices.
>=20
> @Fabrice, Benjamin and William.
> What do we do about that one?
>=20
> Thanks,
>=20
> Jonathan

I'd consider the IIO counter ABI as entirely deprecated -- the Counter
subsystem supports all the functionality that's provided by the IIO
counter ABI, as well as additional functionality that is missing.=20

Regarding the iio:deviceX/in_count_quadrature_mode_available attribute:
superseded by the Counter subsystem counterX/countY/function attribute.
The IIO counter ABI allows users to select between a quadrature counting
mode or a non-quadrature counting mode; unfortunately, it does not
specify what kind of quadrature or what kind of non-quadrature counting
is actually being performed by the device.

Because the 104-quad-8 and stm32-lptimer-cnt drivers were the only ones
to use this attribute, they are luckily in sync -- both define the same
possible modes available: "quadrature" and "non-quadrature". You could
simply consolidate this attribute to the main sys-bus-iio file in order
to resolve this warning.

Given that it has already been superceded by the Counter subsystem, I'd
also be all right with just removing the IIO Counter ABI entirely from
the codebase, or alternatively setting a future date for removal.

William Breathitt Gray

> >=20
> > Jonathan
> >=20
> > >=20
> > > Thanks,
> > > Mauro =20
> >=20
>=20

--MjKgfLFDy3EUHZT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAGo4YACgkQhvpINdm7
VJIZxA/9H7SZZN2VLQOm+wRMOdsAFk+N+mS5eYaod2XmO5DkJxJjV6JSyOoglH9U
KYDZBG2otHyEe4YdBGFkgzUE58NEzSDKqmruuE1VlcCvBB1AfzU+0l+7wtmbxywJ
Ye+fbpX8WJYiTiI3kDPibIqgNMMo3xKTIitNsCMHlgRS+Fm8ph2Xlt6wZU2830tf
WGut29VTI/D1hYf6a1woaoHg6G6sWUkhdviszi9pnDZD2bngVsXqxUdrRb3v/Ssn
gVwvXBC9TYwTQQue5/Ah29lW4KBFrVEI2Lw+8HJ8srpaBwZlKbRdGw6k/nAkrWgx
9KVGFTs12hNhHXFThcAjSDq1nwY7Ss8L9Jk6WNTVekiie9b0LY0fmH/sCU/2UlQ2
LHwtmkG41UiRvJ+NE6d5K860oEShCPsVW5n+esKDGN2welc+0d/7kCITgtzH0Kvt
EbDqmXKx/bls02Tg2b3NxtSQz+W6hsqWCFrLNioZEMoowW1LaES1nSsfAxnyRL62
ELw2h9bsPamXUm4AvK244WDTU40Lt1Utzu1vQ+scX4L9goiZim4+Tyx01qkRq6+2
RML3c+05F/oQ3xe9rKKG0mbb8Dun1QdoObYEbLKLI3vkrZDzwXdL/hDH2xwmbuYn
eWhku4AEcq0GZfofSocGzJh0l2jQKa8TGNd3ZZIqd9z2E5dRKPg=
=npAt
-----END PGP SIGNATURE-----

--MjKgfLFDy3EUHZT3--
