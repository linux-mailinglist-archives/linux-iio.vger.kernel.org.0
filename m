Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E561155AD
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFQpP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 11:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfLFQpP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 11:45:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B15D21835;
        Fri,  6 Dec 2019 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575650714;
        bh=9D2ID6uDj07434xBhqPgK5P/YqmUCeKjTdahYEwCfCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pcXLqRMbzEnkf+5Y/lEj9zIc6/Ul98Jeu8hlRmOTevGiTlmYfUvV8OgnlwCyTiAee
         1T/4l9tRmUkviPsr/4/tlELUGWIVTN2Luq1dxwIiZmoWkwWZtDhrDRSUuhp2ow9DEt
         uzfRXuHYYh0XDEG41LA2YNLNZtlNv8Vao5oscEa0=
Date:   Fri, 6 Dec 2019 16:45:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [v2] iio: ad7949: fix channels mixups
Message-ID: <20191206164509.35f52b80@archlinux>
In-Reply-To: <13a71c7e-678c-cffa-ae43-104918f88265@essensium.com>
References: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
        <20191202141336.4507-1-andrea.merello@gmail.com>
        <c3f3367f-cc78-23f3-ec89-439b9bc8f433@essensium.com>
        <20191204110659.00004987@Huawei.com>
        <13a71c7e-678c-cffa-ae43-104918f88265@essensium.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Dec 2019 12:13:03 +0100
Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:

> Le 04/12/2019 =C3=A0 12:06, Jonathan Cameron a =C3=A9crit=C2=A0:
> > On Mon, 2 Dec 2019 16:36:19 +0100
> > Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:
> > =20
> >> Le 02/12/2019 =C3=A0 15:13, Andrea Merello a =C3=A9crit=C2=A0: =20
> >>>    drivers/iio/adc/ad7949.c | 22 +++++++++++++++++-----
> >>>    1 file changed, 17 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> >>> index 5c2b3446fa4a..2c6f60edb7ce 100644
> >>> --- a/drivers/iio/adc/ad7949.c
> >>> +++ b/drivers/iio/adc/ad7949.c
> >>> @@ -89,6 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
> >>>    				   unsigned int channel)
> >>>    {
> >>>    	int ret;
> >>> +	int i;
> >>>    	int bits_per_word =3D ad7949_adc->resolution;
> >>>    	int mask =3D GENMASK(ad7949_adc->resolution, 0);
> >>>    	struct spi_message msg;
> >>> @@ -100,12 +101,23 @@ static int ad7949_spi_read_channel(struct ad794=
9_adc_chip *ad7949_adc, int *val,
> >>>    		},
> >>>    	};
> >>>   =20
> >>> -	ret =3D ad7949_spi_write_cfg(ad7949_adc,
> >>> -				   channel << AD7949_OFFSET_CHANNEL_SEL,
> >>> -				   AD7949_MASK_CHANNEL_SEL);
> >>> -	if (ret)
> >>> -		return ret;
> >>> +	/*
> >>> +	 * 1: write CFG for sample N and read old data (sample N-2)
> >>> +	 * 2: if CFG was not changed since sample N-1 then we'll get good d=
ata
> >>> +	 *    at the next xfer, so we bail out now, otherwise we write some=
thing
> >>> +	 *    and we read garbage (sample N-1 configuration).
> >>> +	 */
> >>> +	for (i =3D 0; i < 2; i++) {
> >>> +		ret =3D ad7949_spi_write_cfg(ad7949_adc,
> >>> +					   channel << AD7949_OFFSET_CHANNEL_SEL,
> >>> +					   AD7949_MASK_CHANNEL_SEL);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +		if (channel =3D=3D ad7949_adc->current_channel)
> >>> +			break;
> >>> +	}
> >>>   =20
> >>> +	/* 3: write something and read actual data */
> >>>    	ad7949_adc->buffer =3D 0;
> >>>    	spi_message_init_with_transfers(&msg, tx, 1);
> >>>    	ret =3D spi_sync(ad7949_adc->spi, &msg); =20
> >> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensiu=
m.com> =20
> > Hi Charles-Antoine,
> >
> > Why a signed-off-by as opposed to a reviewed-by or similar?
> >
> > signed-off-by brings some very specific legal implications around Devel=
oper
> > Certificate of Origin, so is normally just the author plus people invol=
ved in
> > the path to upstream (maintainers). =20
>=20
> Ah sorry, I made the mistake, I wanted to add:
>=20
> Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Great thanks.

Applied to the fixes-togreg branch of iio.git.  I've also marked it for sta=
ble.

Thanks,

Jonathan

>=20
> Regards,
>=20
> Charles-Antoine COuret
>=20

