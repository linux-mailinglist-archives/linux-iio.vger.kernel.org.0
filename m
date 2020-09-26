Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09207279A28
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIZOo2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 10:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgIZOo1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 10:44:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F22F20BED;
        Sat, 26 Sep 2020 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601131467;
        bh=znUgDKdMyJBWtd+ZYMfFlvxrc8IyUkWXxVEJH7JpALo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wIJu8hzHgrEpcTGS833nBsDz0fP1gxkwSAa2kxoh5Y6q1Nkn/sm5GcM2W7T6wpA7Q
         F1ucoqlLkdfroiaxyAdNLPKO9APCpVswhxrPpWC/7qQMJ1bwCtupVZ5BVFcBhLFzYC
         bjMlVRIpaqmwFz38pTTZy/TczjD3fro0+t8ZWcx0=
Date:   Sat, 26 Sep 2020 15:44:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tobias Jordan <kernel@cdqe.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: temperature: ltc2983: fix leak of device node
 iterator
Message-ID: <20200926154423.2dfe8c34@archlinux>
In-Reply-To: <20200926104554.GA14752@agrajag.zerfleddert.de>
References: <20200926104554.GA14752@agrajag.zerfleddert.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Sep 2020 12:45:54 +0200
Tobias Jordan <kernel@cdqe.de> wrote:

> Add missing of_node_put calls for the error paths of the
> for_each_available_child_of_node loop in ltc2983_parse_dt.
>=20
> Thought about adding an "goto err_of_node_put" instead, but as the error
> paths are quite divergent, I'm not sure if that wouldn't complicate
> things.
>=20
> Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
> Signed-off-by: Tobias Jordan <kernel@cdqe.de>
Nuno S=C3=A1 sent a fix for this yesterday which I've just applied.

Unlucky timing on this one!

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/ltc2983.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> index 55ff28a0f1c7..438e0ee29025 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1285,6 +1285,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  		ret =3D of_property_read_u32(child, "reg", &sensor.chan);
>  		if (ret) {
>  			dev_err(dev, "reg property must given for child nodes\n");
> +			of_node_put(child);
>  			return ret;
>  		}
> =20
> @@ -1293,9 +1294,11 @@ static int ltc2983_parse_dt(struct ltc2983_data *s=
t)
>  		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
>  			dev_err(dev,
>  				"chan:%d must be from 1 to 20\n", sensor.chan);
> +			of_node_put(child);
>  			return -EINVAL;
>  		} else if (channel_avail_mask & BIT(sensor.chan)) {
>  			dev_err(dev, "chan:%d already in use\n", sensor.chan);
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
> =20
> @@ -1304,6 +1307,7 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  		if (ret) {
>  			dev_err(dev,
>  				"adi,sensor-type property must given for child nodes\n");
> +			of_node_put(child);
>  			return ret;
>  		}
> =20
> @@ -1334,12 +1338,14 @@ static int ltc2983_parse_dt(struct ltc2983_data *=
st)
>  			st->sensors[chan] =3D ltc2983_adc_new(child, st, &sensor);
>  		} else {
>  			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
> =20
>  		if (IS_ERR(st->sensors[chan])) {
>  			dev_err(dev, "Failed to create sensor %ld",
>  				PTR_ERR(st->sensors[chan]));
> +			of_node_put(child);
>  			return PTR_ERR(st->sensors[chan]);
>  		}
>  		/* set generic sensor parameters */

