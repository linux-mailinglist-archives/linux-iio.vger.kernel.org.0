Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C933A5F37
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFNJj3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJj2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 05:39:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC91AC061574
        for <linux-iio@vger.kernel.org>; Mon, 14 Jun 2021 02:37:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lsj23-0007qJ-Aq; Mon, 14 Jun 2021 11:37:23 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lsj22-00063s-K1; Mon, 14 Jun 2021 11:37:22 +0200
Date:   Mon, 14 Jun 2021 11:37:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
Message-ID: <20210614093722.rurmqljcvzvlxpjp@pengutronix.de>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
 <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
 <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
 <839944ff-e4e3-86c1-8d53-abaf96fa9271@linux.intel.com>
 <CAHp75VfqUftwaGrJVR0qAkLG=-=qNLEV=9fLAC5SCNtt2i_bJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e352r23wjxxg6kpy"
Content-Disposition: inline
In-Reply-To: <CAHp75VfqUftwaGrJVR0qAkLG=-=qNLEV=9fLAC5SCNtt2i_bJg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--e352r23wjxxg6kpy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 11:57:46AM +0300, Andy Shevchenko wrote:
> +Uwe Kleine-K=C3=B6nig
>=20
> On Mon, Jun 14, 2021 at 11:24 AM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
> > On 6/13/21 1:36 PM, Andy Shevchenko wrote:
> > > On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
> > > <jarkko.nikula@linux.intel.com> wrote:
> > >>
> > >> Use to_pci_dev() helper instead of container_of(d, struct pci_dev, d=
ev);
> > >
> > > ...
> > >
> > >> -       struct pci_dev *pdev =3D container_of(dev, struct pci_dev, d=
ev);
> > >> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> > >>          struct intel_qep *qep =3D pci_get_drvdata(pdev);
> > >
> > > Why not change both lines to dev_get_drvdata()?
> > >
> > I thought it before and Uwe had a good point why it isn't necessarily a
> > good idea:
> >
> > https://www.spinics.net/lists/linux-pwm/msg15325.html
>=20
> I understand this point, but the problem is that we often use
> different callbacks for different layers. For example, the PM
> callbacks are operating with generic 'struct device' and using the PCI
> device there is non-flexible layering violation, so in my opinion it's
> the opposite to what Uwe says. I.o.w. we need to use corresponding API
> to what we have in the callbacks. If the callback comes from generic
> level =3D=3D> generic APIs more appropriate.

Without having looked at the driver in question: I (think I) understand
both sides here and both variants have their own downside.

 - Using dev_get_drvdata() makes use of the fact that pci_set_drvdata()
   is a wrapper around dev_set_drvdata for the pcidev's struct device.

 - Using pci_get_drvdata() adds overhead (for humans only though, the
   compiler doesn't care and creates the same code) and having the pci
   device in the callback isn't necessary.

My personal opinion is: The first is the graver layer violation because
it relies on an implementation detail in the PCI framework. The latter
is relying on a fact that is local to the driver only: All devices this
driver is bound to are pci devices. The main benefit of explicitly using
pci_get_drvdata =E2=88=98 to_pci_dev I see is that someone having only shal=
low
knowledge of the PCI stuff can easier match a pci_get_drvdata() to the
pci_set_drvdata() called in .probe() than a dev_get_drvdata() and so
while it uses a function call/code line more, it is more explicit and
more obviously correct.

And regarding your argument about the matching API: I think the above
code uses the matching API, that is make a pci_dev from a device using
to_pci_dev().

So this is about weighting up- and downsides. How you judge them is
subjective. (Though my judgement is naturally the better one :-)

Just my 0.02=E2=82=AC
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e352r23wjxxg6kpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDHI08ACgkQwfwUeK3K
7Anf1Qf+JTghhlGu3Var4CkiW0zHGIyf0X1cBcmG+a8nj5flylI5gZ+Poqjb09Yq
jDHmKzvxWCYxH38yuPgu0UYIPOK/hTL//an2zFfVNywHdBWM249tY8mNhbczVLNc
iTbN+7wJgnVLcx3aMwJIpn6AsJrepKTWy1xN/9mVqGVgzf+KFqRUtkHDQ+SN59lX
eNqICdWpEw0EsAhsm2tuOR1V30UlebwQOfrzObBNbluiJabAFqQ5SJFsPkDNUH0s
TJjyx1iBx/ZLlHwkc4iudRxUkCKn/VgtqjL00yG7HKjE9jMqkkSTvqo6Gs/WSFyy
dWp3x2pQJ+kmohAQ+gZJB4+6GbyhaQ==
=VAY3
-----END PGP SIGNATURE-----

--e352r23wjxxg6kpy--
