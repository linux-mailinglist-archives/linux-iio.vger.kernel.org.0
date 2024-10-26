Return-Path: <linux-iio+bounces-11339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84279B180D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D891F22490
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43461D5CF2;
	Sat, 26 Oct 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKWLNq6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0131D5CD6;
	Sat, 26 Oct 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945652; cv=none; b=RQyNL5cFGAlk84q6BZcVyOY0byDtuFQ2p6fqb66vy3+qOp62FFzziH8KgCabrxmfile8LmGx8AK/RF0+H1JSo9gzIHJAXip50XDNFNtaOEfU+oSXcTFuzLcAVL6iR759FlBBLPdXK/tUytBU1MOuviZHyKM0rQ3iizdNDN1bUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945652; c=relaxed/simple;
	bh=aX6mtqMDDuRMLKNNH7o4YnE5my+zUXmBU6eo3tXrXwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap9VXWPfqYgH81WiT2Atfq1ghP21R/nsf6Ydem/IJsC9aL0RdTJXluaaIXHoc1i5x1IMS+MCajPvqIc9xtStRRTN4lagHxxv9FYFtckcwa73Gx2qT+3VskCwkq4AbzWxLFvH4Xrr+jGERaFfst8S+2Z+DdE+WT91Ips6um7p9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKWLNq6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C28CC4CEC6;
	Sat, 26 Oct 2024 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945651;
	bh=aX6mtqMDDuRMLKNNH7o4YnE5my+zUXmBU6eo3tXrXwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aKWLNq6VAKMcnkpPXKonLpZM86l8AXsgOyZjporptckA2vVeWeXHDmDkAYJy3WPqH
	 5Reo4m0CkJ4qcMV+e+cisDVhG1hqDsmS5SnBG7q92nAIH2ljcsHbEBMjLMiAUK1gFW
	 5c2akkQrwi8hXc5tH0PvsDnSCLhqb5tYu8bzpRDjK0xhk+1I7v3Fz9Yzu9TN+yGRFP
	 xiDQzuaQD/lqUR7VrCm0Oj2v6PzMMCJn80VOFeZtNSoD0k8eptS3KIyoi8l982TzR8
	 3V/5vSnKNs+CqBsiQMLU9O0g35+Qv6o093gEvjzGVk0fLZeie1wdxQmlGfW1/GEWKu
	 NDIfUA6Q940LQ==
Date: Sat, 26 Oct 2024 13:27:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Anshul
 Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit
 Ghosh <subhajit.ghosh@tweaklogic.com>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "chrome-platform@lists.linux.dev"
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 5/7] iio: imu: inv_mpu6050: simplify code in
 write_event_config callback
Message-ID: <20241026132638.4ff2c8a2@jic23-huawei>
In-Reply-To: <FR3P281MB175799CC4895C8BC5B645236CE4E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-5-7d29e5a31b00@baylibre.com>
	<FR3P281MB175799CC4895C8BC5B645236CE4E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 12:16:42 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Julien,
>=20
> good thing to know, thanks for the patch.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied.
>=20
> Best regards,
> JB
>=20
> ________________________________________
> From:=C2=A0Julien Stephan <jstephan@baylibre.com>
> Sent:=C2=A0Thursday, October 24, 2024 11:11
> To:=C2=A0Mudit Sharma <muditsharma.info@gmail.com>; Jonathan Cameron <jic=
23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Anshul Dalal <anshulu=
sr@gmail.com>; Javier Carrasco <javier.carrasco.cruz@gmail.com>; Jean-Bapti=
ste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Michael Hennerich <Michael.H=
ennerich@analog.com>; Cosmin Tanislav <cosmin.tanislav@analog.com>; Ramona =
Gradinariu <ramona.gradinariu@analog.com>; Antoniu Miclaus <antoniu.miclaus=
@analog.com>; Dan Robertson <dan@dlrobertson.com>; Marcelo Schmitt <marcelo=
.schmitt@analog.com>; Matteo Martelli <matteomartelli3@gmail.com>; Anand As=
hok Dumbre <anand.ashok.dumbre@xilinx.com>; Michal Simek <michal.simek@amd.=
com>; Mariel Tinaco <Mariel.Tinaco@analog.com>; Jagath Jog J <jagathjog1996=
@gmail.com>; Lorenzo Bianconi <lorenzo@kernel.org>; Subhajit Ghosh <subhaji=
t.ghosh@tweaklogic.com>; Kevin Tsai <ktsai@capellamicro.com>; Linus Walleij=
 <linus.walleij@linaro.org>; Benson Leung <bleung@chromium.org>; Guenter Ro=
eck <groeck@chromium.org>
> Cc:=C2=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-ker=
nel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-kernel@lists.=
infradead.org <linux-arm-kernel@lists.infradead.org>; chrome-platform@lists=
.linux.dev <chrome-platform@lists.linux.dev>; Julien Stephan <jstephan@bayl=
ibre.com>
> Subject:=C2=A0[PATCH 5/7] iio: imu: inv_mpu6050: simplify code in write_e=
vent_config callback
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
>=20
> Remove useless code in write_event_config callback.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 7 ++-----
>  drivers/iio/light/apds9960.c               | 2 --
>  2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 5680be153127711777b6074da18a7a0f86211d6c..21ebf0f7e28fec302cbf8ab89=
0fc53a3de6f36cd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1176,21 +1176,18 @@ static int inv_mpu6050_write_event_config(struct =
iio_dev *indio_dev,
>  					  int state)
>  {
>  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> -	int enable;
> =20
>  	/* support only WoM (accel roc rising) event */
>  	if (chan->type !=3D IIO_ACCEL || type !=3D IIO_EV_TYPE_ROC ||
>  	    dir !=3D IIO_EV_DIR_RISING)
>  		return -EINVAL;
> =20
> -	enable =3D !!state;
> -
>  	guard(mutex)(&st->lock);
> =20
> -	if (st->chip_config.wom_en =3D=3D enable)
> +	if (st->chip_config.wom_en =3D=3D state)
>  		return 0;
> =20
> -	return inv_mpu6050_enable_wom(st, enable);
> +	return inv_mpu6050_enable_wom(st, state);
>  }
> =20
>  static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 3c14e4c30805e1b596ef2380f94e6aa3e92082b1..3a56eaae5a68f2891d061871c=
7013f0b5447bb47 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -762,8 +762,6 @@ static int apds9960_write_event_config(struct iio_dev=
 *indio_dev,
>  	struct apds9960_data *data =3D iio_priv(indio_dev);
>  	int ret;
> =20
> -	state =3D !!state;
> -
>  	switch (chan->type) {
>  	case IIO_PROXIMITY:
>  		if (data->pxs_int =3D=3D state)
>=20


