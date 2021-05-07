Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956C33764B2
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhEGLyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 07:54:04 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52252 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhEGLyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2021 07:54:04 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7065D1C0B76; Fri,  7 May 2021 13:53:03 +0200 (CEST)
Date:   Fri, 7 May 2021 13:53:02 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
Message-ID: <20210507115302.GA20751@amd>
References: <20210504174019.2134652-1-linux@roeck-us.net>
 <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
 <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com>
 <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Wed 2021-05-05 16:22:07, Andy Shevchenko wrote:
> On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Wed, 5 May 2021 09:32:35 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > On Tue, 4 May 2021 11:00:52 -0700
> > > Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> +Cc: Paul (I hope you are related to coreboot somehow and can
> communicate this further), Pavel and Jacek (LED subsystem suffered
> with this as well), Hans, Rafael and linux-acpi@

Thanks for Cc. I prefer @ucw.cz address for the LED work.

> > > Dropping the ones we are fairly sure are spurious is even better!
> >
> > If I get bored I'll just do a scrub of all the instances of this that
> > you haven't already cleaned up.  It's worth noting that we do
> > know some highly suspicious looking entries are out there in the wild.
>=20
> I have counted ~60 users of acpi_device_id in IIO. Brief looking at
> the IDs themselves rings an alarm about half of them.

As far as I can tell, this means asking "is this real ID or did you
just invent it" at patch submission. Okay...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCVKh4ACgkQMOfwapXb+vJBQwCfSfvfA+ps5soco8nk8PpfuIwM
NOAAn213eI5AaFWPZd77hSIYq4qpARxm
=WbSs
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
