Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8E12D245
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2019 17:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL3Qta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Dec 2019 11:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfL3Qt3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Dec 2019 11:49:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764EE206DB;
        Mon, 30 Dec 2019 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577724569;
        bh=H+Xixm/5Bouk1S1r30r0nDOhxrKrI3dSi6dVwniIfPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X2vKkENQGmNJ7gM4pmz1GLNmrsusKX4AjWYghZtheyg5mVfDKF42eR1lC+d3i82vZ
         GeBZHw85LSJxrUTdVwSYWZaxg8FofUsTBJz/JiEuCAQ+Br7aH1yNCtf5EkIt0mb9Ea
         bm/j858Q6l+eWAuF7MD8XoTHMU+KFzBFI87arGCI=
Date:   Mon, 30 Dec 2019 16:49:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix scale for vcnl4040
Message-ID: <20191230164924.42614610@archlinux>
In-Reply-To: <6adc62445cac7d16e4688aea905dc1c9cc128488.1577442112.git.agx@sigxcpu.org>
References: <6adc62445cac7d16e4688aea905dc1c9cc128488.1577442112.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Dec 2019 11:22:54 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> According to the data sheet the ambient sensor's scale is 0.12 lux/step
> (not 0.024 lux/step as used by vcnl4200) when the integration time is
> 80ms. The integration time is currently hardcoded in the driver to that
> value.
>=20
> See p. 8 in https://www.vishay.com/docs/84307/designingvcnl4040.pdf
>=20
> Fixes: 5a441aade5b3 ("light: vcnl4000 add support for the VCNL4040 proxim=
ity and light sensor")
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 16dacea9eadf..b0e241aaefb4 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -163,7 +163,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	if (ret < 0)
>  		return ret;
> =20
> -	data->al_scale =3D 24000;
>  	data->vcnl4200_al.reg =3D VCNL4200_AL_DATA;
>  	data->vcnl4200_ps.reg =3D VCNL4200_PS_DATA;
>  	switch (id) {
> @@ -172,11 +171,13 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		/* show 54ms in total. */
>  		data->vcnl4200_al.sampling_rate =3D ktime_set(0, 54000 * 1000);
>  		data->vcnl4200_ps.sampling_rate =3D ktime_set(0, 4200 * 1000);
> +		data->al_scale =3D 24000;
>  		break;
>  	case VCNL4040_PROD_ID:
>  		/* Integration time is 80ms, add 10ms. */
>  		data->vcnl4200_al.sampling_rate =3D ktime_set(0, 100000 * 1000);
>  		data->vcnl4200_ps.sampling_rate =3D ktime_set(0, 100000 * 1000);
> +		data->al_scale =3D 120000;
>  		break;
>  	}
>  	data->vcnl4200_al.last_measurement =3D ktime_set(0, 0);

