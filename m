Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6E5F1F9C
	for <lists+linux-iio@lfdr.de>; Sat,  1 Oct 2022 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJAVFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Oct 2022 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJAVFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2022 17:05:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429940BE5;
        Sat,  1 Oct 2022 14:05:51 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E9876601E6A;
        Sat,  1 Oct 2022 22:05:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664658350;
        bh=Arj8XY3vybvBQ3J7ITnL7U5IbeHE9NPvxP3IGJNaYWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MT/PzlDp2/y2Z9+SW4qnJ0hQ9ndoIEmMk1AESOv6RJteGdNiG9ocUzIjbAy/NmFSv
         A/4A6E0zWgfSk/NSoVTu8MlaXPfTlLYE0uBcux5IONjjgfgTOJxeR/vx6zR/X+1xct
         PRZ2TlVDYHOHAAhjdJh0cwJz33JC34fXn5sEotq+bZBH9MBc6x/xN6C7TzKPk7X7BC
         u3WnDVoIw+8v5C1scDPuIDuVVh6Hh0RcCA4URJCS2UvvPerLIm/Nvk+ABP1GYXLk7v
         La1zQ6ffAvugabvo4LajYku0Yx3dCSqF41Chj+JYTXOR4J3h8UBiY/m7qhKRBA0ssC
         wzd3PcpNu46hQ==
Received: by mercury (Postfix, from userid 1000)
        id F2B601061C22; Sat,  1 Oct 2022 23:05:47 +0200 (CEST)
Date:   Sat, 1 Oct 2022 23:05:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/6] power: supply: Add support for mp2733 battery
 charger
Message-ID: <20221001210547.ngtkjm3ue6joxqdg@mercury.elektranox.org>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-6-sravanhome@gmail.com>
 <20220911133101.7g6hnwp3dnnqrmgb@mercury.elektranox.org>
 <77f13cfe-58dc-d150-18a9-cb14c82f222a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fp56e5gruha3a2n2"
Content-Disposition: inline
In-Reply-To: <77f13cfe-58dc-d150-18a9-cb14c82f222a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--fp56e5gruha3a2n2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 25, 2022 at 11:26:24AM +0200, saravanan sekar wrote:
> On 11/09/22 15:31, Sebastian Reichel wrote:
> > On Wed, Jun 15, 2022 at 04:53:56PM +0200, Saravanan Sekar wrote:
> > > mp2733 is updated version of mp2629 battery charge management
> > > which supports USB fast-charge and higher range of input voltage.
> > >=20
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > ---
> > > [...]
> > >   	psy_cfg.drv_data =3D charger;
> > > -	psy_cfg.attr_grp =3D mp2629_charger_sysfs_groups;
> > > +	if (charger->chip_info->has_impedance)
> > > +		psy_cfg.attr_grp =3D mp2629_charger_sysfs_groups;
> > > +
> > > +	if (charger->chip_info->has_fast_charge)
> > > +		psy_cfg.attr_grp =3D mp2733_charger_sysfs_groups;
> > > +
> > >   	charger->battery =3D devm_power_supply_register(dev,
> > >   					 &mp2629_battery_desc, &psy_cfg);
> > >   	if (IS_ERR(charger->battery)) {
> >=20
> > Instead of having has_impedance and has_fast_charge feature
> > flag that are mutual exclusive, store the device type and
> > use if/else or switch statement to chose the correct attr_grp.
>=20
> these flags are not really mutual exclusive, limitation only for
> application between mp2629 and mp2629. In future another chipset on
> same series shall have both or none, so I would consider to control
> flags with functionality rather than chipset!
>=20
> Please feedback if still I have to consider your proposal.

I'm fine with this being flag based, but your code assumes that the
flags are mutual exclusive, since psy_cfg.attr_grp is overwritten.
This is bad style and needs to be fixed:

+       if (charger->chip_info->has_impedance)
+               psy_cfg.attr_grp =3D mp2629_charger_sysfs_groups;
+
+       if (charger->chip_info->has_fast_charge)
+               psy_cfg.attr_grp =3D mp2733_charger_sysfs_groups;

-- Sebastian

--fp56e5gruha3a2n2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4q6sACgkQ2O7X88g7
+pqDzw/8DYNihI/5niBVAy8sxQtMYp1fODvWdL9PyBNxYrYJgicUuiYjMKw7nKuW
c3JGR1D4bkDtBghktWBfs+BvpexpVt1YrK5dTqHnnnBNEHBv+r/f/+6Zh5y3CJKp
0ffksLxM2mDaElxchdRXB+ObL2Kb+9HKvTQnuXVldX7LvbgHWhwnbYIDsDdin5mO
awWkoEEdf/wr31F6seFIHkig+mBd/cuo9opbKCOp/YHDzNrHr79C5LCLmd6CeGKh
TW78eqWlSM8ArBBpA6MXckTo9x7lW1+tsf67NDA1XPUSlwyuIsAAe2deb87gy3qZ
O/NtL9ABfHjgQgNWeDeXoM//i/et7IJoncxqokxZOVHMapt3QTFAMbbDI7fBOH1E
Eu7Paps0/OFp88k0aQCTYAa6mPUPKN15/s9WDHW6W074JgcN4m0wPFlzZAsa6oiM
kXIMvZWUMOEga4UW5GS29okYuIXQQyC656B/+kVTjfhtNDaarblm5KNVMGbRxdcm
4AwKX0GJSK1Vf0bPfSD1UtpE3R81Z0nL20QZbQm5fVWZppq3kXUZaXx8W6hVk6/P
UwLXVClFeax1X0e/UODeNvkwA6xR92QPxDqZ8lsdFA3lJtz0K9avQMLuhpvqoZ94
NnsOX7zTFVXBmJz6gNp2Q6f7BHSzNTVnNDkGpWyhFA1ZB2lDBhU=
=I5wa
-----END PGP SIGNATURE-----

--fp56e5gruha3a2n2--
