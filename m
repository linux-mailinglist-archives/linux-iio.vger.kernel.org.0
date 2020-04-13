Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286841A6715
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgDMNdy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 09:33:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgDMNdy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 09:33:54 -0400
Received: from envy ([82.207.195.83]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M9WqY-1jIVZH2gIW-005XFe; Mon, 13
 Apr 2020 15:33:39 +0200
Message-ID: <7683f875aa617b3003a1949131ce79bd0e3c4dcb.camel@richard-neumann.de>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
From:   Richard Neumann <mail@richard-neumann.de>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>, Shyam-sundar.S-k@amd.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Mon, 13 Apr 2020 15:33:37 +0200
In-Reply-To: <3ffc343e-c44b-1b4e-993e-179a13dc928c@amd.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
         <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
         <4fe47b0323c1d65d429ee89b000e8bfcd984495f.camel@richard-neumann.de>
         <896f84bc-f0d6-59a5-c894-809695aa348f@amd.com>
         <CAHp75Vfr6q_H6z6tRFfaKedF7oR7nhmZvRWL4mxx3W7uypUFvA@mail.gmail.com>
         <9aea760f9abdd2f90f36642af77de7bfae719485.camel@richard-neumann.de>
         <3ffc343e-c44b-1b4e-993e-179a13dc928c@amd.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Lic1xVuC6am9NOepDW9o"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:R1qlNK3L8DeV4u5KSa3H1cOT/rnu2TOrZG7wEF5f+Em7c69dl6C
 PgvPOCbB5opBzlzrhY7BLi71utTlICGQI7i8KwtmoANaOM1R2DieObIQey+mvamv1M9Rlzu
 ZhGJ2/DF4Xsz1RKfzSSlPucw/dLBAYgDi6MqESKCy3Xb/xs5yP/Ba7X3Ju/zv0kdYqWJsvb
 rpZhiBSdCgs7hIn65QEKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TXtNW1lc3kM=:8AprZdlWe6BlromzeB6BIS
 mAUVf4lHadPgX0QzihzKz4ygMxnFcTqitKKLFO1/Hdscn7qTldwFTtk2pvDJk5IX0FIU3/2Cg
 LYiif/hzeCZiohDo0V/jWMIAYlenXolwvNV8OhCvjUOPEOmgTeh2eY3v5TvbFa/Pi6K8QytJ/
 iv8+oDcCMTTPpO8FhCa/EWlsryvLs4v9GNxfOu+9+yCR+LMPvA0VRwSnlLM7Q0W9UN9YpQY2H
 3/uMPCi99hNJl2xysbHoPKxU9kaTss4NXJp87HjtsTX9uzh9AFvW0OnodODntcLAvuQ+PoFne
 t4feu+8baCkZhvmSvSB8J5dfU4hzPhKf348TUyHp47RpnNHU9i8ldzr0Tj8GDQuKB2txbq/IR
 M7v/A9bg3Lbcipe3rOvHkuvmQwHOe+kvCsbNJ0hzDdtdo9enUdRX4KYPfBtqvSJYZJlsFfk1y
 jXd+kqZup68IUS57fwP0dSH9e64hNSZINeU+rLGWwWNHV02k5h6y21VgS0Pi3oYWV9QY8Pk6S
 xitjA7/zTy0Ae8QASuOcbgF9mgbLqs49nSosnaCdd7USkNwhz7TnoDoRugxCCU4bSlbay+gar
 Ea1vQidsd+Qu38iF3/6m3njfm+tVfxai91qI/2XdMtWp3f5xwxj7oy71GVICx2zwb0RMO0FfP
 +wNGnS/tKD/ZvGIFkepwpAIduGsa/8R4x28vRjTjLKcVZKsA1bOhHJV1Edm2KO58rEM6Ri8/h
 q2/BKXxaXidf4E+TkvEXnNyOyEeUNgzDKKTx+0PbvlvdqrZyNswPatf/H12zrHdnf+zvxHJkD
 /+2aS5IHlcVz5w/bY9/yTOVW7R90Qgypn6jTXYERJ3UPbvWZf3ZM3c3pfOX0Qu751s2ydZl
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--=-Lic1xVuC6am9NOepDW9o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 06.04.2020, 10:56 +0530 schrieb Shah, Nehal-
bakulchandra:
> HI
>=20
> On 4/1/2020 9:58 PM, Richard Neumann wrote:
> > Am Dienstag, den 31.03.2020, 20:24 +0300 schrieb Andy Shevchenko:
> > > On Tue, Mar 31, 2020 at 4:26 PM Shah, Nehal-bakulchandra
> > > <nehal-bakulchandra.shah@amd.com> wrote:
> > > > On 3/31/2020 6:01 PM, Richard Neumann wrote:
> > > > > Not a real review, but your patch series seems to be
> > > > > repeating a
> > > > > lot
> > > > > from drivers/i2c/busses/i2c-amd-mp2*.
> > > > > Is there any chance we could re-use the code?
> > > > > E.g. the AMD_C2P_* definitions from drivers/i2c/busses/i2c-
> > > > > amd-
> > > > > mp2.h?
> > > > Thanks for the mail. Yes there are some common structures,
> > > > however
> > > > as of now we have kept separately considering both
> > > >=20
> > > > are part of different sub systems. But may be will consider
> > > > this
> > > > input for future enhancement.
> > > It can be done in a form of shared definitions at least in
> > > include/linux/platform_data/x86/amd-mp2.h or alike ...
> > >=20
> > I managed to add support for the AMD SFH PCI device to i2c-amd-mp2*=20
> > and
> > outsourced the headers to include/linux/i2c-amd-mp2.h. [1]
> > I also refactored the patch series (excluded the documentation) [2]
> > to
> > use the PCI device now provided by i2c_amd_mp2_pci and removed some
> > duplicate and unncessary code.
> > The driver now consist of just one module (amd_sfhtp_hid).
> > Unfortunately I was not able to solve the problem, that I get AMD-
> > Vi
> > IO_PAGE_FAULT errors when not booted with amd_iommu=3Doff.
> >=20
> > [1]=20
> > https://gist.githubusercontent.com/conqp/4d726f86da8a8397d6e70091a124de=
67/raw/f97e88a0b44d98bfa1258cb73c8afe4dce7afa87/i2c-amd-mp2.patch
> > [2]=20
> > https://gist.githubusercontent.com/conqp/67036e690aca89d08b958971edac28=
3d/raw/2a1ef122f9c8c8e07164b6d597962ce7bbad6d45/amd-sfhtp.patch
>=20
> Thanks for the patch and appreciate your efforts. At this point of
> time, we would like to have our first patch for SFH to be upstreamed
> and dont want to complicate the
>=20
> with two sub systems and maintainers. Surely will consider this input
> for future enhancement. Thanks for your understanding.
>=20
> Thanks
>=20
>=20
> Nehal
>=20
>=20
Hi all,

I spent the last two weeks learning the HID API and refactored [1] the
patch series again. I also took into consideration Nehal's input
regarding the two subsystems. After tinkering with the integration of
the SFH PCI driver into the existing i2c-amd-mp2-pci driver, I realized
that this was a futile effort at this point of time, since the SFH
protocol, as far as I understand it, does not really implement the I2C
protocol. Thusly I turned away from trying to integrate the two
drivers. The core changes I did, is to refactor the PCI driver to use a
similar initialization as the i2c-amd-mp2-pci driver. The registers are
now mapped correctly on initial setup (1 << 2) and not mapped to zero
(1 >> 2) and the ioremapped later. With this change, the AMD-Vi page
faults when not booting with amd_iommu=3Doff also automagically
disappeared.=20
The second change is the HID device handling. I now implemented the
hid_ll_driver API with the respective functions to process raw events
as well device start / stop and open / close routines. I also
refactored the platform driver wich is now solely responsible for
spawning and despawning the HID devices. I also reduced the commonly
used structures and constats to those that were actually being used by
the driver and renamed the PCI registers to express what they are used
for in this driver. I also commented most functions and shared
structures. The only problem I keep having on my machine is, that the
register for the bit-shifted active sensors mask 0x1068C keeps
returning zero on readout and thusly I need to override it.
I tried to get the sensor mask by sending the "dump_sensorinfo" and
"number_of_sensors_discovered" commands to different C2P registers and
dumping the corresponding P2C registers. But so far I could not get any
information that could be interpreted as the sensor info and mask that
I need. Maybe Nehal or Sandeep could provide the information, if and
how it ts possible to get information about the amount, position and
type of the connected sensors in another way. I also found out, by
sweeping the SFH registers (from 0 to 31), that there seem to be other
sensors connected on my machine, namely at positions 0, 1, 2, 3, 4, 7,
8 and 9. The ALS at 19 does not seem to be present on my system. I
suspect that at least one of those is an additional accelerometer,
since the only one working right now ist the accelerometer at position
0, which is located in the sceen / lid. I suspect that the other one is
located in the chassis, allowing the use of both to perform tablet mode
detection by processing their relative orientation. I'd appreciate a
hint on this assumption as well. ;-)

Sincere regards,

Richard

[1] https://gist.github.com/conqp/33baa079d9524914c4c0c196200e4f89

--=-Lic1xVuC6am9NOepDW9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT62wKwhMqSt8WaustMqNUjvThq9wUCXpRqMQAKCRBMqNUjvThq
9/xTAP0fCC9iZ+L52+k77GfQ7si6y49pvUTd0dJVRQdC7qsEhQD+Jok81CLtvoou
Fi5/ODmaKCGFTxeC0IqrNK7CXiRITw8=
=aUOQ
-----END PGP SIGNATURE-----

--=-Lic1xVuC6am9NOepDW9o--

