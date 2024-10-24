Return-Path: <linux-iio+bounces-11130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E79AE88F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68C91F21088
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549920012B;
	Thu, 24 Oct 2024 14:20:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBB200139
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779652; cv=none; b=Rd36MEFktB/3PpHfWdwPngLfAe625gAygF2lOu6V5LAQ7G0D9/zG/e95f0LTPtg/TalLoi4HypQdttazhoViUCra5wdkOQRaQqbMTdeKbXX0Wspl1xbGCpNZUh4twpcoa339UB4i1Y3q/keWooJHMsEll2HBxIlZjkNp4uEpSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779652; c=relaxed/simple;
	bh=CeH6d9jYHaUoXOEafD41IQtDoDuY9WGiGrn3lPFqJ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNH1qMM2FWP5PMcaxJM+Zj0x2AIXKnFCUdN2m96YjauxWJUB8JkJ12QMtZ4UjdbR2v1Z9yvtevlUkD5K+lwMkcggAWLQFTIJkPx5D2C3nhLQWuO2iN8piG7j6t12jXMBirLfEpfLPz236D71vPl4bYKn0z2ls+pZIFV+9FY2Vqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3yhJ-000452-8g; Thu, 24 Oct 2024 16:20:21 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3yhI-000DEt-35;
	Thu, 24 Oct 2024 16:20:20 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8119C35DCED;
	Thu, 24 Oct 2024 14:20:20 +0000 (UTC)
Date: Thu, 24 Oct 2024 16:20:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, andi.shyti@kernel.org, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net, jdelvare@suse.com, 
	jic23@kernel.org, lars@metafoo.de, ukleinek@kernel.org, 
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
Message-ID: <20241024-cryptic-giga-mole-54e2b5-mkl@pengutronix.de>
References: <20241024085922.133071-1-tmyu0@nuvoton.com>
 <20241024085922.133071-5-tmyu0@nuvoton.com>
 <20241024-poetic-offbeat-alligator-d6b9fe-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umhghwnwqoavy3lt"
Content-Disposition: inline
In-Reply-To: <20241024-poetic-offbeat-alligator-d6b9fe-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--umhghwnwqoavy3lt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
MIME-Version: 1.0

On 24.10.2024 16:17:52, Marc Kleine-Budde wrote:
> On 24.10.2024 16:59:17, Ming Yu wrote:
> > This driver supports Socket CANfd functionality for NCT6694 MFD
> > device based on USB interface.
> >=20
> > Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
> > ---
> >  MAINTAINERS                     |   1 +
> >  drivers/net/can/Kconfig         |  10 +
> >  drivers/net/can/Makefile        |   1 +
> >  drivers/net/can/nct6694_canfd.c | 843 ++++++++++++++++++++++++++++++++

|   CC [M]  drivers/net/can/nct6694_canfd.o
| drivers/net/can/nct6694_canfd.c: In function =E2=80=98nct6694_canfd_start=
_xmit=E2=80=99:
| drivers/net/can/nct6694_canfd.c:282:22: error: variable =E2=80=98echo_byt=
e=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
|   282 |         unsigned int echo_byte;
|       |                      ^~~~~~~~~
| drivers/net/can/nct6694_canfd.c: In function =E2=80=98nct6694_canfd_rx_wo=
rk=E2=80=99:
| drivers/net/can/nct6694_canfd.c:677:34: error: variable =E2=80=98stats=E2=
=80=99 set but not used [-Werror=3Dunused-but-set-variable]
|   677 |         struct net_device_stats *stats;
|       |                                  ^~~~~
| cc1: all warnings being treated as errors

If compiling with C=3D1, sparse throws the following errors:

| drivers/net/can/nct6694_canfd.c:417:14: warning: cast to restricted __le32
| drivers/net/can/nct6694_canfd.c:750:9: warning: cast to restricted __le32
| drivers/net/can/nct6694_canfd.c:777:32: warning: cast to restricted __le32

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--umhghwnwqoavy3lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcaV6EACgkQKDiiPnot
vG+E+Qf8CIIlMRqAUgax6FgoXWP0LDl3JVfJSfoClGvwvTGIR6r0hAAYhY6YXdy9
gUPusFE69CRe780ZIu4/gR45YWIRpof1exG4JAIoKbU/4Bdq/42x1BKSXifWPayo
Rm/mm+HyVCjb7WTpopxM7ZCnZMks9xOUwl6A+/ShIRZA3pWBz8ll4yRCtTq1V6xy
GMKhYsYP4mDY3YyD1+hUfLBmiBu2XvhnGksdoLRZHNMNKlNhZnpRSLeQew5EHSy1
03BltphJ6YsdAgTfyR7AT4nTisdNyYl+IhnJq1+FSKsWxdHcelNMaM3JwlLrXMBO
FbotT17CV8J3M14xFrwqL7cRROi57A==
=lV4A
-----END PGP SIGNATURE-----

--umhghwnwqoavy3lt--

