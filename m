Return-Path: <linux-iio+bounces-6999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7C91BC80
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 12:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A357D1F21CAB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE014F9F2;
	Fri, 28 Jun 2024 10:16:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7691103
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569797; cv=none; b=sjj3hHAZaQdILXhgYINV5TLUQaa0ozcxyTJYUQKmfadSmblXRzPzBdizYHxdIToNHhLWhX3PGrzCr4533VeQSXOEgZfg/WhezeXFotjBihfG9Sf3nn2o1y2cyI/ZNfzAafydhBCpPtJM0nQA3VR3N+i1Ljk9BftrnRkpnob3wGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569797; c=relaxed/simple;
	bh=vy2xf2tOixhTJbhpkca+o0WXYhKl9tglB6SdJSICdmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttO5sG+Z/sRtCIxEnRq7QOeoYxrpQ+Ip3Y/9Qsm9yCbNqHnmF55IUtue5WrNXFBeeI9JGMOyiDBrVTuI7hLF/kd1nZlc459/epDx5qB5gTDM9VsrOtfZdq2snp7K0Ovl2QiHJ2LgV72rjFwDpyB3JaRmf2/RC4Olf+8YeY00YTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sN8eH-0000jO-2V; Fri, 28 Jun 2024 12:16:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sN8eF-005a41-1j; Fri, 28 Jun 2024 12:16:07 +0200
Received: from pengutronix.de (p200300cb5f450e00b3b76ff7b19af51f.dip0.t-ipconnect.de [IPv6:2003:cb:5f45:e00:b3b7:6ff7:b19a:f51f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 37BED2F5B46;
	Fri, 28 Jun 2024 10:16:06 +0000 (UTC)
Date: Fri, 28 Jun 2024 12:16:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
	Martin Sperl <kernel@martin.sperl.org>, David Jander <david@protonic.nl>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	Julien Stephan <jstephan@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	kernel@pengutronix.de, T.Scherer@eckelmann.de
Subject: Re: [PATCH v2 0/5] spi: add support for pre-cooking messages
Message-ID: <20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <Zn6HMrYG2b7epUxT@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w5ugtvmixttbihsx"
Content-Disposition: inline
In-Reply-To: <Zn6HMrYG2b7epUxT@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--w5ugtvmixttbihsx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.06.2024 11:49:38, Oleksij Rempel wrote:
> It seems to be spi_mux specific. We have seen similar trace on other syst=
em
> with spi_mux.

Here is the other backtrace from another imx8mp system with a completely
different workload. Both have in common that they use a spi_mux on the
spi-imx driver.

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
000000dd0
Mem abort info:
  ESR =3D 0x0000000096000004
  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
  FSC =3D 0x04: level 0 translation fault
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000046760000
[0000000000000dd0] pgd=3D0000000000000000, p4d=3D0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: can_raw can ti_ads7950 industrialio_triggered_buffer kfi=
fo_buf spi_mux fsl_imx8_ddr_perf at24 flexcan caam can_dev error rtc_snvs i=
mx8mm_thermal spi_imx capture_events_irq cfg80211 iio_trig_hrtimer industri=
alio_sw_trigger ind>
CPU: 3 PID: 177 Comm: spi5 Not tainted 6.9.0 #1
Hardware name: xxxxxxxxxxxxxxxx (xxxxxxxxx) (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : spi_res_release+0x24/0xb8
lr : spi_async+0xac/0x118
sp : ffff8000823fbcc0
x29: ffff8000823fbcc0 x28: 0000000000000000 x27: 0000000000000000
x26: ffff8000807bef88 x25: ffff80008115c008 x24: 0000000000000000
x23: ffff8000826c3938 x22: 0000000000000000 x21: ffff0000076a9800
x20: 0000000000000000 x19: 0000000000000dc8 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff88c0e760
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff8000815a1f98 x10: ffff8000823fbb40 x9 : ffff8000807b8420
x8 : ffff800081508000 x7 : 0000000000000004 x6 : 0000000003ce4c66
x5 : 0000000001000000 x4 : 0000000000000000 x3 : 0000000001000000
x2 : 0000000000000000 x1 : ffff8000826c38e0 x0 : ffff0000076a9800
Call trace:
 spi_res_release+0x24/0xb8
 spi_async+0xac/0x118
 spi_mux_transfer_one_message+0xb8/0xf0 [spi_mux]
 __spi_pump_transfer_message+0x260/0x5d8
 __spi_pump_messages+0xdc/0x320
 spi_pump_messages+0x20/0x38
 kthread_worker_fn+0xdc/0x220
 kthread+0x118/0x128
 ret_from_fork+0x10/0x20
Code: a90153f3 a90363f7 91016037 f9403033 (f9400674)=20
---[ end trace 0000000000000000 ]---

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w5ugtvmixttbihsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ+jWMACgkQKDiiPnot
vG9eTAf9Ex8vUqqElTcG0woxjhCZvA7UgAAlCJye+UQRedbmMLm9YgmvSXG8PwnT
aBJZdof3Wg8wcU4w7fpYKdyYHly22kN0MixT5zEkQSSfLH2FDB7r0kwA3pLjPo0k
j9L7II3idEFC3PURB99Lm+F5IqAyR1EKXxlBw7ETsg6IZ4wREMPmqSphtqa0Jcth
X+yub9Gkzc7Tr9tSwNorky4C9wBjEwev/Ux6Cp4wB2eartdebOrcI0yOsPZ9rnqh
7WZLpJgCOya15LDdX0Ql69179iItbmNYp8feHrmYbAHnXrwHTJ2XFgzUlQnhTA0T
O5QKJX5UYStEzNavkGkXH34aE7BLAQ==
=EDL7
-----END PGP SIGNATURE-----

--w5ugtvmixttbihsx--

