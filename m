Return-Path: <linux-iio+bounces-21433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9BAFB6E1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492E63A528F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA75628A1CC;
	Mon,  7 Jul 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="eJsmt/FW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B012E2EF5
	for <linux-iio@vger.kernel.org>; Mon,  7 Jul 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900794; cv=none; b=l7l6nkk4UFj9xzkSeN4Nug1CfeIX3WBXIfXXg3Tj3QF50pMxSiiKSLPXftLoPdwu72yPe7RZk1tCG+pcLpbbBxipGj8+uVaruuFV7Bu7PA+oS97ZuDRpHzcWtbMur4wEzeKA2qLOGLKZWrHqhTcxnUmnYMASBS7cAazV5p55VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900794; c=relaxed/simple;
	bh=csBXCJ0zu5y/zUWGlf7zeoALQgR3KLeDisaHq0s4Ids=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T71Fk6+tTFr8UxXpXIdZGnRR23B3o6HxhhrH6Z7780N+Kfi5s9HwfNjGqUohcsy4QBtd6kkQtj3fXkKP6lveWx4LsQS1AAU2y91zHPsWUsta9t4ZBW/CWq2fgopEFyaJb8IBUOz8DD0kMwvmsiHjSb/zpkukzumY8spd91yBT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=eJsmt/FW; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751900783; x=1752159983;
	bh=apL7MQ0F3HfMlf8nmml1QvI03hSnbw0C36z0AZM2iXU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eJsmt/FW7SXwNVqGWO+D5KHb4ObvARaRtj0UhLuDnR4V7CktCg3Ne6Bw9zDAxiCkh
	 jiI5IJpwhlUFyCtj0suFd4kmkP32LIB8sm/Upu5daatkHE8qccQjehYfQFhf9jmkt0
	 FUOwAFAvg66HXxIfFvh7prH63xsgguxxAx5HWocsX+fCkDrCCZf2vbQfCbFOVoXKFI
	 3pLSdYG5s5K1WObLZPqGPCeZKvjLRGplN10skuIS+kvL8s1Cm+5YHNmhlpfrol4xpv
	 golJCOg0aS5OejMolXyNAllEZvi7OAfCszSqvkjnp4JyF1I2elhkhRFaOlwizJhT+6
	 X5jiJE2+6zZ8w==
Date: Mon, 07 Jul 2025 15:06:18 +0000
To: jean-baptiste.maneyrol@tdk.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion
Message-ID: <b7fxmmorpsuxq55p4uojxq4zhsvlntrrl5nidby2yhof4vufgu@3izvnu7lmg4o>
In-Reply-To: <20250630-losd-3-inv-icm42600-add-wom-support-v6-3-5bb0c84800d9@tdk.com>
References: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com> <20250630-losd-3-inv-icm42600-add-wom-support-v6-3-5bb0c84800d9@tdk.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 9609ae15fcb16965bae1728fb05ecd46c6e60624
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 09:47:31PM +0100, Jean-Baptiste Maneyrol via B4 Rel=
ay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> When Wake-on-Motion is on, enable system wakeup and keep the chip on
> for waking up the system with an interrupt.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---

[...]

> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c
> index c52d77cab040dcfb11bc1f9430a3b1dfd52660a9..7a28051330b79098bfa94b8c8=
c78c2bce20b7230 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -1206,6 +1206,11 @@ struct iio_dev *inv_icm42600_accel_init(struct inv=
_icm42600_state *st)
>  =09if (ret)
>  =09=09return ERR_PTR(ret);
>=20
> +=09/* accel events are wakeup capable */
> +=09ret =3D devm_device_init_wakeup(&indio_dev->dev);
> +=09if (ret)
> +=09=09return ERR_PTR(ret);

I don't know if it will work here, but the fxls8962af is controlling this
from the devicetree with:

=09if (device_property_read_bool(dev, "wakeup-source")) {
=09=09ret =3D devm_device_init_wakeup(dev);
=09if (ret)
=09=09return dev_err_probe(dev, ret, "Failed to init wakeup\n");
=09}

Br,
/Sean


