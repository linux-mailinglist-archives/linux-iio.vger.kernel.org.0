Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D862F3BE48
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbfFJVUa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 17:20:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58041 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389988AbfFJVUa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 17:20:30 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AL6PFg021993;
        Mon, 10 Jun 2019 23:20:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Drac3oMcb/4AwiInN5LMEiXVzYaILeXj4UtZUJSNcgQ=;
 b=k0Ifb/qFuWlAZBemLMrStM/Odx7DD/vTv5OB3deeVimPHUiTEcCb3Di7g+QQz9NnNkO8
 vnwUPIECmP0flLk5jRzj4Z4yzS8+aDBM5cdC+JyoA0T0WeyiI1PIthELDCFMDjY23zJf
 LHthNoPTJUrrN1RTLcuX+oLovDOdVbRtZPcxBhcKtoC7BgG4CuiVGRZLKR5G/SADt8NS
 uUZzriLs4tw1/l2yjgNbSVcTOg6ptGGFlyip8Iit5sUTucUGA+dhfckMsjGiI+6mex2U
 zoQ300C6IR8cEfy8VFy4KrrGjtGDi7BotQaBhJET9ysEY5eu969t1tlbiZqxx3DgTQRs wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t02stay6x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Jun 2019 23:20:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74CB031;
        Mon, 10 Jun 2019 21:20:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57B5D5579;
        Mon, 10 Jun 2019 21:20:21 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Jun
 2019 23:20:20 +0200
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Mon, 10 Jun 2019 23:20:21 +0200
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: RE: [PATCH][V2] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Thread-Topic: [PATCH][V2] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Thread-Index: AQHVFiaq91qGeiMWKUqDMnB3v0xp96aRudAAgAO8FBA=
Date:   Mon, 10 Jun 2019 21:20:20 +0000
Message-ID: <8501c7c92ca04a46a327681ad1384cc0@SFHDAG2NODE1.st.com>
References: <20190529130121.30532-1-alexandru.ardelean@analog.com>
        <20190529135848.11964-1-alexandru.ardelean@analog.com>
 <20190608150944.5764158f@archlinux>
In-Reply-To: <20190608150944.5764158f@archlinux>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Alexandru,

I agree with you about the predisable but I am not convinced regarding the =
postenable.
Few modifications have been made on magn driver and never replicated on acc=
el. I think should be done in the same way magn is implemented.
During postenable kmalloc should be called first because iio_triggered_buff=
er_postenable function it enables irq and if an interrupt arrives before th=
e memory is allocated (wrong interrupt or failure of switching sensor off f=
rom previous disable) it could generate a null pointer exception. Make sens=
e to you?

Thanks & Br,
Denis



-----Original Message-----
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>=20
Sent: Saturday, June 8, 2019 7:10 AM
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org; Denis CIOCCA <denis.ciocca@st.com>; Lorenzo =
Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH][V2] iio: st_accel: fix iio_triggered_buffer_{pre,post}=
enable positions

On Wed, 29 May 2019 16:58:48 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions=20
> attach/detach the poll functions.
>=20
> For the predisable hook, the disable code should occur before=20
> detaching the poll func, and for the postenable hook, the poll func=20
> should be attached before the enable code.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I think this is fine, but I'd like an ack from Lorenzo / Denis.

Note to those who have missed the background on this, the aim is to both ti=
dy up drivers, but long term to allow for simpler reworking of the core by =
ensuring consistency of ordering and what is done in each of these hooks.

Thanks,

Jonathan

> ---
> Changelog v1 -> v2:
> * record the first error in st_accel_buffer_predisable() and return=20
> that
>=20
>  drivers/iio/accel/st_accel_buffer.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/accel/st_accel_buffer.c=20
> b/drivers/iio/accel/st_accel_buffer.c
> index 7fddc137e91e..711ecd9bc898 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -40,6 +40,10 @@ static int st_accel_buffer_postenable(struct iio_dev *=
indio_dev)
>  	int err;
>  	struct st_sensor_data *adata =3D iio_priv(indio_dev);
> =20
> +	err =3D iio_triggered_buffer_postenable(indio_dev);
> +	if (err < 0)
> +		return err;
> +
>  	adata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (adata->buffer_data =3D=3D NULL) {
>  		err =3D -ENOMEM;
> @@ -51,34 +55,33 @@ static int st_accel_buffer_postenable(struct iio_dev =
*indio_dev)
>  	if (err < 0)
>  		goto st_accel_buffer_postenable_error;
> =20
> -	err =3D iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		goto st_accel_buffer_postenable_error;
> -
>  	return err;
> =20
>  st_accel_buffer_postenable_error:
>  	kfree(adata->buffer_data);
>  allocate_memory_error:
> +	iio_triggered_buffer_predisable(indio_dev);
>  	return err;
>  }
> =20
>  static int st_accel_buffer_predisable(struct iio_dev *indio_dev)  {
> -	int err;
> +	int err, err2;
>  	struct st_sensor_data *adata =3D iio_priv(indio_dev);
> =20
> -	err =3D iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto st_accel_buffer_predisable_error;
> -
>  	err =3D st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXI=
S);
>  	if (err < 0)
>  		goto st_accel_buffer_predisable_error;
> =20
>  	err =3D st_sensors_set_enable(indio_dev, false);
> +	if (err < 0)
> +		goto st_accel_buffer_predisable_error;
> =20
>  st_accel_buffer_predisable_error:
> +	err2 =3D iio_triggered_buffer_predisable(indio_dev);
> +	if (!err)
> +		err =3D err2;
> +
>  	kfree(adata->buffer_data);
>  	return err;
>  }

