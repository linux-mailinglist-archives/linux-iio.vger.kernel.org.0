Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A379A5707A
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZSVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 14:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZSVl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 14:21:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562A02085A;
        Wed, 26 Jun 2019 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561573299;
        bh=0nQhYnLhLEeamrlQUtZb4J3UbsXQMGUaEnaKb6h4KfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2q7D+0HHhmGGjVKNFAt605mcCgei6si0y2xfuvpV1apJvaLIwMs1IWgmeVzTJpzxD
         1aq6WX9joU9mxlXMCydTMDIjmyoosvUA04hdKHugFQeaseHuD6Uw2HLRs+TiDXBjMX
         bEkIx6emye3yzR1zNEwDcVfXMEJRLsNtylPJ8ekU=
Date:   Wed, 26 Jun 2019 19:21:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, zbynek.kocur@fel.cvut.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf04: fix wrong limitation in distance measuring
Message-ID: <20190626192134.4b7aed3c@archlinux>
In-Reply-To: <20190623122909.hhzskp6k5vm4wify@arbad>
References: <20190623122909.hhzskp6k5vm4wify@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 Jun 2019 14:29:10 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> The measured time value in the driver is limited to the maximum distance
> which can be read by the sensor. This limitation was wrong and is fixed
> by this patch.
>=20
> It also takes into account that we are supporting a variety of sensors
> today and that the recently added sensors have a higher maximum
> distance range.
>=20
> Suggested-by: Zbyn=C4=9Bk Kocur <zbynek.kocur@fel.cvut.cz>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Ideally I'm looking for Zbyn=C4=9Bk to confirm that this addresses the
original question.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/srf04.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 8b50d56b0a03..01eb8cc63076 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -110,7 +110,7 @@ static int srf04_read(struct srf04_data *data)
>  	udelay(data->cfg->trigger_pulse_us);
>  	gpiod_set_value(data->gpiod_trig, 0);
> =20
> -	/* it cannot take more than 20 ms */
> +	/* it should not take more than 20 ms until echo is rising */
>  	ret =3D wait_for_completion_killable_timeout(&data->rising, HZ/50);
>  	if (ret < 0) {
>  		mutex_unlock(&data->lock);
> @@ -120,7 +120,8 @@ static int srf04_read(struct srf04_data *data)
>  		return -ETIMEDOUT;
>  	}
> =20
> -	ret =3D wait_for_completion_killable_timeout(&data->falling, HZ/50);
> +	/* it cannot take more than 50 ms until echo is falling */
> +	ret =3D wait_for_completion_killable_timeout(&data->falling, HZ/20);
>  	if (ret < 0) {
>  		mutex_unlock(&data->lock);
>  		return ret;
> @@ -135,19 +136,19 @@ static int srf04_read(struct srf04_data *data)
> =20
>  	dt_ns =3D ktime_to_ns(ktime_dt);
>  	/*
> -	 * measuring more than 3 meters is beyond the capabilities of
> -	 * the sensor
> +	 * measuring more than 6,45 meters is beyond the capabilities of
> +	 * the supported sensors
>  	 * =3D=3D> filter out invalid results for not measuring echos of
>  	 *     another us sensor
>  	 *
>  	 * formula:
> -	 *         distance       3 m
> -	 * time =3D ---------- =3D --------- =3D 9404389 ns
> -	 *          speed       319 m/s
> +	 *         distance     6,45 * 2 m
> +	 * time =3D ---------- =3D ------------ =3D 40438871 ns
> +	 *          speed         319 m/s
>  	 *
>  	 * using a minimum speed at -20 =C2=B0C of 319 m/s
>  	 */
> -	if (dt_ns > 9404389)
> +	if (dt_ns > 40438871)
>  		return -EIO;
> =20
>  	time_ns =3D dt_ns;
> @@ -159,20 +160,20 @@ static int srf04_read(struct srf04_data *data)
>  	 *   with Temp in =C2=B0C
>  	 *   and speed in m/s
>  	 *
> -	 * use 343 m/s as ultrasonic speed at 20 =C2=B0C here in absence of the
> +	 * use 343,5 m/s as ultrasonic speed at 20 =C2=B0C here in absence of t=
he
>  	 * temperature
>  	 *
>  	 * therefore:
> -	 *             time     343
> -	 * distance =3D ------ * -----
> -	 *             10^6       2
> +	 *             time     343,5     time * 106
> +	 * distance =3D ------ * ------- =3D ------------
> +	 *             10^6         2         617176
>  	 *   with time in ns
>  	 *   and distance in mm (one way)
>  	 *
> -	 * because we limit to 3 meters the multiplication with 343 just
> +	 * because we limit to 6,45 meters the multiplication with 106 just
>  	 * fits into 32 bit
>  	 */
> -	distance_mm =3D time_ns * 343 / 2000000;
> +	distance_mm =3D time_ns * 106 / 617176;
> =20
>  	return distance_mm;
>  }

