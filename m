Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CFD19B0C1
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbgDAQ3O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 12:29:14 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388148AbgDAQ3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 12:29:11 -0400
Received: from envy ([82.207.223.251]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5W0q-1jHt2y0YtW-016w4x; Wed, 01
 Apr 2020 18:28:54 +0200
Message-ID: <9aea760f9abdd2f90f36642af77de7bfae719485.camel@richard-neumann.de>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
From:   Richard Neumann <mail@richard-neumann.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>, Shyam-sundar.S-k@amd.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 01 Apr 2020 18:28:51 +0200
In-Reply-To: <CAHp75Vfr6q_H6z6tRFfaKedF7oR7nhmZvRWL4mxx3W7uypUFvA@mail.gmail.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
         <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
         <4fe47b0323c1d65d429ee89b000e8bfcd984495f.camel@richard-neumann.de>
         <896f84bc-f0d6-59a5-c894-809695aa348f@amd.com>
         <CAHp75Vfr6q_H6z6tRFfaKedF7oR7nhmZvRWL4mxx3W7uypUFvA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JMpIYctbEoNFnW+rx2oI"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:/Iuh6Wc2OWUWANhg+i5sa8DX8+N5Q471sfzV1dJZGtvhNgn30bW
 WFNUEw83jU+/rRD8GACG8t2TGf2kw4Z5QQLxVaB3MvjdmW+0A8XTSl1hI2iTfdflWXmcfYH
 1IwhXyqvBX/2rCAP5zojzlREeoMLx4pLRZg6+TbOXwHSofssNiK+0ubQ27EHfVP+wpjgfDE
 9haVSMVl1addbBrysAL7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BEgHpqVQWuA=:eab8Bjm6U04XClhfM96ei2
 6eVrEtmoO/i+1Z0ybln3l54Ic5d8P0vyqSGtUqDdZB+rHtFjXTtH07Hz5ZKah2Up5iX5Lo9zx
 dWBBBxAq3tM2LhPhpwLvl25KM/fiw79mo64WUjY4SLGdy+D2FX7b5mTtRPuBCY+u06nIbBtkd
 ZdUuVhPde03VpLsKqprLsyBP96JXvcWslukQVjTzJP9/AIaw6Mqqm5rZa/YSxck8aAYoqh5PG
 4f+cMMdZU89i2DRM3SAKN5MwZw2WPrRXBKHgiAZByC5834bmS2/WwbmaNjnAUKmfBvYW4VTn8
 FixF/Of2X2CK3RXKiOx/SitiO5F76BadLahtiLOR7bM++gUyHdkbsm7sKqS2DFh4fUSdBQMNd
 mZLHzHT9hdqNhIp224x/VeQzByHZwaPegkzUv7xWeU2QNIFAscRqcV1AooEKAAHTEBcBOyNay
 OniuUrU51qLrVzVRZif/oO4dBoYVaHezOcZo6j8boCuTeCrpoRxqkM01iSNREWvyAc5mX06Sl
 /kfXvsksupRk669Q08Oi/lMJwXgNaFFWryEs2nNtE/X2/FKmoPXaWhNHy8JGbntNkRovKqt6h
 kb1ccpgMV5Il06Drok+Vcz0rNjsEMvzl6zMF+8QymF30Voc1Fo1JM7CYP4tPykr5JFhRv4Kr8
 k9jTU2x8QxkEGuvAs+uSHJeH/Sc4d8uoLnrVw6ZKwzCMZ1qk4tK60ly4fkYe58OLQdBQvO3LX
 eJyBw2xDeHlfCsiD1ZFPe+SSXskptFLDQ0lgJbwoE52Xkmy+ntyZWo39lQnBJlPLrPqzARLd2
 sMeTVIZRzPwwOnT4o4/r/iRAAGDDqLL5Tw5Ts01zYC7APWmfooBVR0QejZXowu75yG0HU/d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--=-JMpIYctbEoNFnW+rx2oI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 31.03.2020, 20:24 +0300 schrieb Andy Shevchenko:
> On Tue, Mar 31, 2020 at 4:26 PM Shah, Nehal-bakulchandra
> <nehal-bakulchandra.shah@amd.com> wrote:
> > On 3/31/2020 6:01 PM, Richard Neumann wrote:
> > > Not a real review, but your patch series seems to be repeating a
> > > lot
> > > from drivers/i2c/busses/i2c-amd-mp2*.
> > > Is there any chance we could re-use the code?
> > > E.g. the AMD_C2P_* definitions from drivers/i2c/busses/i2c-amd-
> > > mp2.h?
> >=20
> > Thanks for the mail. Yes there are some common structures, however
> > as of now we have kept separately considering both
> >=20
> > are part of different sub systems. But may be will consider this
> > input for future enhancement.
>=20
> It can be done in a form of shared definitions at least in
> include/linux/platform_data/x86/amd-mp2.h or alike ...
>=20

I managed to add support for the AMD SFH PCI device to i2c-amd-mp2* and
outsourced the headers to include/linux/i2c-amd-mp2.h. [1]
I also refactored the patch series (excluded the documentation) [2] to
use the PCI device now provided by i2c_amd_mp2_pci and removed some
duplicate and unncessary code.
The driver now consist of just one module (amd_sfhtp_hid).
Unfortunately I was not able to solve the problem, that I get AMD-Vi
IO_PAGE_FAULT errors when not booted with amd_iommu=3Doff.

[1] https://gist.githubusercontent.com/conqp/4d726f86da8a8397d6e70091a124de=
67/raw/f97e88a0b44d98bfa1258cb73c8afe4dce7afa87/i2c-amd-mp2.patch
[2] https://gist.githubusercontent.com/conqp/67036e690aca89d08b958971edac28=
3d/raw/2a1ef122f9c8c8e07164b6d597962ce7bbad6d45/amd-sfhtp.patch

--=-JMpIYctbEoNFnW+rx2oI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT62wKwhMqSt8WaustMqNUjvThq9wUCXoTBQwAKCRBMqNUjvThq
95P6AQD2f9/1gcoiIcDpJ/lT+fG8FH3cCnQqUJ7jGkVhNmZuiQD/aPm0aB1ZPd0L
NzfP2Euf/mdDdd0WMbbsFkX4VhKSxw8=
=0blY
-----END PGP SIGNATURE-----

--=-JMpIYctbEoNFnW+rx2oI--

