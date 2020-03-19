Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F312518BDE4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCSRXO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 13:23:14 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:54976 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbgCSRXO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Mar 2020 13:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ovRcEyST6vxl255ZVDdgE7BcGNIyoIHopOrx8AXs9gM=; b=Dbw47AkXiYvUXThvxlbZtE+DA
        Y0GxYKJ++idEBgCvWNVod6japta8/yN72xUPkCPPP9cLPscL1qCYO1+Dyz4vX/6ojKSkPypZA9rDV
        ozk0eFteFa9eJ6y16X1fWRjCKU2YsyOdZoPCk5n4YrU1Mr/ANH5p8ls+P6qOQsVysl1Bw=;
Received: from p200300ccff0fcb00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0f:cb00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jEysi-0003to-BZ; Thu, 19 Mar 2020 18:22:56 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jEysh-0004Yu-8T; Thu, 19 Mar 2020 18:22:55 +0100
Date:   Thu, 19 Mar 2020 18:22:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH RESEND v6 2/7] mfd: rn5t618: add IRQ support
Message-ID: <20200319182246.27d4809b@kemnade.info>
In-Reply-To: <20200319161149.GB5477@dell>
References: <20200313064535.31503-1-andreas@kemnade.info>
        <20200313064535.31503-3-andreas@kemnade.info>
        <20200319161149.GB5477@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/siGgyZ4Qye9Mavy.deiaD6/"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/siGgyZ4Qye9Mavy.deiaD6/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Mar 2020 16:11:49 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Fri, 13 Mar 2020, Andreas Kemnade wrote:
[...]
I agree to the other comments.

> > +	if (priv->irq > 0) { =20
>=20
> There are already have checks in rn5t618_irq_init().
>=20
> Just call it regardless.
>=20
> > +		if (rn5t618_irq_init(priv)) =20
>=20
> If this returns an error, you should return that error from .probe().
>=20
Hmm, that would be a regression. Current users do not specify an interrupt
in the devicetree yet, so the MFD driver would stop working on these devices
completely.
Therefore I think we should keep the existing functionality if there is no
IRQ specified in the devicetree and ignore the error. The new subdevices
are checking the IRQ availability and give error messages and have
reduced functionality.

Regards,
Andreas

--Sig_/siGgyZ4Qye9Mavy.deiaD6/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5zqmcACgkQl4jFM1s/
ye9G7w//WlnawIpi36NIAadLtast9vu33weBJVgKnN3mfwzi5RbM/l5IAVJZH+uN
gpKeObNx1hxpWNresKQfEnEapfmnINbb6l3v4JzoiGtpyWWZeb1jFrWZjzxhqtMv
oqqfUkhETSDajTzt+siADhGd/CcldVY9oZOsGOzzAyO7hTKqP1wLaYi3ZcHTKE2q
HgXYnqYUMANhN1M9uWgAIt4uz41uHrvoFpnL8X1nUj3cEUU3L7ik1lK4uuDFcnQQ
Yu5EA27appMEeLf3scttVFfec9854vq7lxbLHWd1qnS/9R5QFxxguL3EOWLI5FGz
WW5VPTY6ke+s3Srf5fj6ZZuiVzyScXWTMFnaIgo0wHieeAA8yVcd5DG7qJrB03nE
2nRz/IdvHdMLJPAeMOYM9NMqYkbJtB6u19IFVvr9G+5tEAlhTeYqwbRp8W5CSY6N
8oY2Dd6wDJjQWfQ6nadeQ97hKIZhKQzLV0ApFLVI+hbP3v1QwGUNu+lWxO9Hm7yl
LuUFK4vnj/BWiCNzlZAJHq2E3N/wwVcIMtKBp5Xl4QXxNUgVD1VjDFdcYCyHfZUy
Xb6WWsn8t+dvby2nUGJm6WyNKoUzeb+HFh2R2YoeTNFO6sz1lo2aVFFq4oxSDK/F
yF/FaLCKTTCfbHlUN6nR9yCeXKqYzt+dUIiKYepMLuN/1Ddu3tk=
=DMzN
-----END PGP SIGNATURE-----

--Sig_/siGgyZ4Qye9Mavy.deiaD6/--
