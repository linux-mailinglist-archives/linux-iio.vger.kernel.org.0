Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071B9B34A3
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 08:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfIPGQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 02:16:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:48271 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbfIPGQ5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 02:16:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2019 23:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; 
   d="asc'?scan'208";a="193350425"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2019 23:16:54 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH 0/1] Quadrature Encoder Support
In-Reply-To: <20190915142325.GA446150@icarus>
References: <20190909121605.92008-1-felipe.balbi@linux.intel.com> <20190915145347.42bfc393@archlinux> <20190915142325.GA446150@icarus>
Date:   Mon, 16 Sep 2019 09:16:45 +0300
Message-ID: <87pnk0dauq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

William Breathitt Gray <vilhelm.gray@gmail.com> writes:
> On Sun, Sep 15, 2019 at 02:53:47PM +0100, Jonathan Cameron wrote:
>> On Mon,  9 Sep 2019 15:16:04 +0300
>> Felipe Balbi <felipe.balbi@linux.intel.com> wrote:
>>=20
>> > Hi,
>> >=20
>> > Here's a simple RFC for Intel's Quadrature Encoder. Let me make it cle=
ar
>> > that I don't mean we should the following patch as is, rather I'd like
>> > to open the discussion to, perhaps, extending Industrial Automation
>> > Framework with support for Quadrature Encoders.
>> >=20
>> > Let me know if you think IIO would be correct place for such devices,
>> > then I can start reworking the driver to provide an IIO-compliant
>> > interface.
>> >=20
>> > I'm thinking we would need standard sysfs files for configuring the QEP
>> > into single-shot QEP mode or buffered Capture mode, configure threshol=
ds
>> > and other details.
>>=20
>> Hi Felipe,
>>=20
>> Fairly recently, similar concerns that IIO didn't really suite these
>> devices lead William to create a specific 'counters' subsystem.
>> +CC William.
>>=20
>> It may not address all of your requirements yet, but I would imagine it
>> is a better fit than IIO would ever be.  We have moved all the older
>> counter drivers out of IIO and across to this new subsystem.
>>=20
>> Thanks,
>>=20
>> Jonathan
>
> Felipe,
>
> Take a look at the Generic Counter interface, it may be what you need:
> https://www.kernel.org/doc/html/latest/driver-api/generic-counter.html

Thanks guys, I wasn't aware of this new subsystem. I'll have a look at
start porting the driver over.

> There are some existing quadrature encoder counter devices using this
> interface already; look at the files under drivers/counter for
> reference.
>
> This interface is still relatively new, so if you have any problems just
> shoot me an email and I'll be happy to help. :-)

Will do William.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1/KM8ACgkQzL64meEa
mQasXRAAwS/VRwp+OWcK78h5wlZnzB7hCkd7gBbNGDu+d3ZnSsnveLYmgHBBZb+o
URuMH1AQiYX8GCYcf74X0Iyq5QNb1uTOeC2xblrV8vb2OyWc9b+FXE0S3U+sPKB1
oJVzPVTsnRPl/C7/q3L7CKakBU+Ik7qUzQHeBn2UnHdI4DbIpJ11H8loGPXhdKmo
dmmiI2qkOf8bAd5NzFPU+HcKspQ1jOeQH6OpHjfTd1UMbtcDRRCxTSF2MCrJcwLu
BnTIA5e7CEJuKtBmXI1T/U4KpTAUrdPFKkKLP98AN1v+/hws+KHyn5cn6/1uAHQp
KNrv9RA2/a7o7Zyg38hvm57szcwCrCmIqY8jHnjKu3Iile4fdjlaKK1wLBD4Z2bg
YcPHS0mZusOkFLNEAjE/7juhCTyo+e70LzQFefKnb4NLFVEd28D0EE8ga6Vs7i+D
LsblK+fYfJMXW9DaC9QK5saSylMuzpg9Z8kQuUILv18Fn3GbPUg4UqCI5DOu1gGh
98PZiF1BqAhLcj0lcvcIRuVxp5jbUJfwPoWP+eLWPstug06B6TAertTap/gz29tp
7rf80z3XIipVTw/n3UZgN+XZIRgncl4XI/qWFitcKaGdZ1hiyYZlVU9yc5kuZrvE
j5FL8hgniEbEcM6GdxudYeCbdd4qkYFEEqzBz1pUhMeJgAmDjS4=
=oNG/
-----END PGP SIGNATURE-----
--=-=-=--
