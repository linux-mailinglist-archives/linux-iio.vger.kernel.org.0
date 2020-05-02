Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDC1C2785
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgEBSVc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 14:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgEBSVb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 14:21:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D090206F0;
        Sat,  2 May 2020 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588443691;
        bh=DPc9Re7qa8CBzUBp9XwR6ALtym5ZC8rwfj/DMwRnlbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uC5yN99jManhws+iD6txsIbLRmkVjGreNgP+s4rVkXN6on8WoAvEyEthgvV8SL0pr
         akVAqiTV86f+EvdX9AZ0zFAupzyw8M6ZHF2F33ZAIbEcxRQZCcHHK2vXiBiRSnzbzX
         aWOYKELmtg3bO41/h3tjbr6eDwviIsz8f0e5vuOk=
Date:   Sat, 2 May 2020 19:21:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eugene Zalkonnikov <ez@norphonic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200502192127.25c77aa5@archlinux>
In-Reply-To: <7482ee6f-eedb-8482-d30e-7fa8e9b0fd47@norphonic.com>
References: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
        <alpine.DEB.2.21.2004270024590.16743@vps.pmeerw.net>
        <7482ee6f-eedb-8482-d30e-7fa8e9b0fd47@norphonic.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 09:57:49 +0200
Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com> wrote:

> Hi Peter,
>=20
>=20
> On 27.04.2020 00:35, Peter Meerwald-Stadler wrote:
> >> +{
> >> +	struct i2c_client *client =3D data->client;
> >> +	s32 ret;
> >> +
> >> +	ret =3D i2c_smbus_read_byte_data(client,
> >> +			hdc2010_reg_translation[chan->address].peak);
> >> +
> >> +	if (ret < 0)
> >> +		dev_err(&client->dev, "Could not read sensor data\n");
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int hdc2010_get_heater_status(struct hdc2010_data *data) =20
> > return value should be bool? =20
>=20
> No idea. It is an int in hdc100x hdc heater sysfs and I try to stick to e=
xisting practices.
>=20
> Should those be bools?

Locally it would make sense, but then we write them into an int where
they are used, so little point. Probably best to leave them as they are.

>=20
> > =20
> >> +	case IIO_CHAN_INFO_PEAK: {
> >> +		int ret;
> >> +
> >> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> >> +		if (ret)
> >> +			return ret;
> >> +		mutex_lock(&data->lock);
> >> +		ret =3D hdc2010_get_peak_measurement_byte(data, chan);
> >> +		mutex_unlock(&data->lock);
> >> +		iio_device_release_direct_mode(indio_dev);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +		/* Scaling up the value so we can use same offset as RAW */
> >> +		*val =3D ret * 256; =20
> > I'd rather have different _SCALEs for peak and raw =20
>=20
> They are made shared per Jonathan's suggestion early on, as the offsets f=
or the channels don't match.

Yup. There is no standard ABI to deal with different scales for peak and
raw and I wasn't keen that we introduce it for this relatively rare
corner case.

Jonathan

>=20
>=20
> Regards,
>=20
> =C2=A0=C2=A0 Eugene.
>=20

