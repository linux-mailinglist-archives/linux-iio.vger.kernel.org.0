Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6319B17CDC8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 12:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgCGL1X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 06:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgCGL1X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 06:27:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E332073D;
        Sat,  7 Mar 2020 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583580442;
        bh=+mDF1Es4cKqD9+h/YcabwuwoWW6L0mM43bPu6zLRqe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C5bAD/r/ZcbBunBDXf7e/V0yMGUX98gELFhETsgQJ8j8+9bYtdNLf0ZUCyoAr02+V
         2I3K7YvYFfXxrUvd7xtix/b97J4USba1CEXEtBHD8Z1h2qEMVcCigVYWNjcGjdUPbR
         D3HGg8nZn/X9sy54q4ktHFzmg026nvPU8lXKW0O4=
Date:   Sat, 7 Mar 2020 11:27:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 4/5] iio: imu: Add support for adis16475
Message-ID: <20200307112717.64245cf7@archlinux>
In-Reply-To: <f1f14ed4f13c41be728cee976b969192af95e61c.camel@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-5-nuno.sa@analog.com>
        <20200303210814.1057fbbb@archlinux>
        <0021fdd0f92a30209bd798c761add8e67a8df5db.camel@analog.com>
        <f1f14ed4f13c41be728cee976b969192af95e61c.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> > > > +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> > > > +{
> > > > +	struct iio_poll_func *pf =3D p;
> > > > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > > > +	struct adis16475 *st =3D iio_priv(indio_dev);
> > > > +	struct adis *adis =3D &st->adis;
> > > > +	int ret, bit, i =3D 0;
> > > > +	u16 crc, data[ADIS16475_MAX_SCAN_DATA], *buffer, crc_res;
> > > > +	/* offset until the first element after gyro and accel */
> > > > +	const u8 offset =3D st->burst32 ? 13 : 7;
> > > > +
> > > > +	ret =3D spi_sync(adis->spi, &adis->msg);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	buffer =3D (u16 *)adis->buffer;
> > > > +
> > > > +	if (!(adis->burst && adis->burst->en))
> > > > +		goto push_to_buffers;
> > > > +
> > > > +	/* We always validate the crc to at least print a message */
> > > > +	crc =3D get_unaligned_be16(&buffer[offset + 2]);
> > > > +	crc_res =3D adis16475_validate_crc((u8 *)adis->buffer, crc,
> > > > +					 st->burst32);
> > > > +	if (crc_res)
> > > > +		dev_err(&adis->spi->dev, "Invalid crc\n");
> > > > +
> > > > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > > +			 indio_dev->masklength) {
> > > > +		/*
> > > > +		 * When burst mode is used, system flags is the first
> > > > data
> > > > +		 * channel in the sequence, but the scan index is 7.
> > > > +		 */
> > > > +		switch (bit) {
> > > > +		case ADIS16475_SCAN_TEMP:
> > > > +			data[i++] =3D get_unaligned(&buffer[offset]);
> > > > +			break;
> > > > +		case ADIS16475_SCAN_GYRO_X ... ADIS16475_SCAN_ACCEL_Z:
> > > > +			/*
> > > > +			 * The first 2 bytes on the received data are
> > > > the
> > > > +			 * DIAG_STAT reg, hence the +1 offset here...
> > > > +			 */
> > > > +			if (st->burst32) {
> > > > +				/* upper 16 */
> > > > +				data[i++] =3D get_unaligned(&buffer[bit *
> > > > 2 + 2]);
> > > > +				/* lower 16 */
> > > > +				data[i++] =3D get_unaligned(&buffer[bit *
> > > > 2 + 1]);
> > > > +			} else {
> > > > +				data[i++] =3D get_unaligned(&buffer[bit +
> > > > 1]);
> > > > +				/* lower not used */
> > > > +				data[i++] =3D 0;
> > > > +			}
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	buffer =3D data;
> > > > +
> > > > +push_to_buffers:
> > > > +	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf- =20
> > > > > timestamp); =20
> > >=20
> > > I'm not sure data is the right size.  It needs to have space to
> > > have
> > > an aligned
> > > timestamp at the end. =20
> >=20
> > Will double check this... Honestly I did not had the timestamp into
> > account so the size is probably wrong. =20
>=20
> I guess you are right. With all the channels enabled I think we need a
> 40 bytes buffer in order to have the aligned timestamp...
>=20

Sounds right.

> > > > +static const struct spi_device_id adis16475_ids[] =3D { =20
> > >=20
> > > Is it actually possible to instantiate this except by
> > > using the dt table below?  If not, then move the 'data'
> > > part into that table and don't provide an spi_device_id
> > > table at all.  It's not relevant to the possible ways
> > > of causing the driver to probe. =20
> >=20
> > I guess we could use the id table with devicetree even without the dt
> > table (even though it makes no sense).
> >=20
> > So, I can remove it but I was using the id->name to set the the
> > iio_dev
> > name which I guess is not the right way?
> >=20
> > What Im thinking is having a name/part number string in chip info
> > that
> > I can use to set the iio dev name. For parts that have the *-[1|2|3]
> > variations I could use the devicetree iio label property. Is this the
> > correct way of handling this? =20
>=20
> I was misunderstanding some stuff here. So, the *-[1|2|3] are valid
> part numbers so they can be in the `name`, right? So, labels come into
> play, for example, when we have multiple instances of the same part,
> right?

Absolutely fine to have the -1 etc.  They are odd part numbers, but they
are the ones on the datasheet etc.

> =20
> > - Nuno S=C3=A1 =20
> > > > +	{ "adis16470", ADIS16470 },
> > > > +	{ "adis16475-1", ADIS16475_1 },
> > > > +	{ "adis16475-2", ADIS16475_2 },
> > > > +	{ "adis16475-3", ADIS16475_3 },
> > > > +	{ "adis16477-1", ADIS16477_1 },
> > > > +	{ "adis16477-2", ADIS16477_2 },
> > > > +	{ "adis16477-3", ADIS16477_3 },
> > > > +	{ "adis16465-1", ADIS16465_1 },
> > > > +	{ "adis16465-2", ADIS16465_2 },
> > > > +	{ "adis16465-3", ADIS16465_3 },
> > > > +	{ "adis16467-1", ADIS16467_1 },
> > > > +	{ "adis16467-2", ADIS16467_2 },
> > > > +	{ "adis16467-3", ADIS16467_3 },
> > > > +	{ "adis16500", ADIS16500 },
> > > > +	{ "adis16505-1", ADIS16505_1 },
> > > > +	{ "adis16505-2", ADIS16505_2 },
> > > > +	{ "adis16505-3", ADIS16505_3 },
> > > > +	{ "adis16507-1", ADIS16507_1 },
> > > > +	{ "adis16507-2", ADIS16507_2 },
> > > > +	{ "adis16507-3", ADIS16507_3 },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(spi, adis16475_ids);
> > > > +
> > > > +static const struct of_device_id adis16475_of_match[] =3D {
> > > > +	{ .compatible =3D "adi,adis16470" },
> > > > +	{ .compatible =3D "adi,adis16475-1" },
> > > > +	{ .compatible =3D "adi,adis16475-2" },
> > > > +	{ .compatible =3D "adi,adis16475-3" },
> > > > +	{ .compatible =3D "adi,adis16477-1" },
> > > > +	{ .compatible =3D "adi,adis16477-2" },
> > > > +	{ .compatible =3D "adi,adis16477-3" },
> > > > +	{ .compatible =3D "adi,adis16465-1" },
> > > > +	{ .compatible =3D "adi,adis16465-2" },
> > > > +	{ .compatible =3D "adi,adis16465-3" },
> > > > +	{ .compatible =3D "adi,adis16467-1" },
> > > > +	{ .compatible =3D "adi,adis16467-2" },
> > > > +	{ .compatible =3D "adi,adis16467-3" },
> > > > +	{ .compatible =3D "adi,adis16500" },
> > > > +	{ .compatible =3D "adi,adis16505-1" },
> > > > +	{ .compatible =3D "adi,adis16505-2" },
> > > > +	{ .compatible =3D "adi,adis16505-3" },
> > > > +	{ .compatible =3D "adi,adis16507-1" },
> > > > +	{ .compatible =3D "adi,adis16507-2" },
> > > > +	{ .compatible =3D "adi,adis16507-3" },
> > > > +	{ },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, adis16475_of_match);
> > > > +
> > > > +static struct spi_driver adis16475_driver =3D {
> > > > +	.driver =3D {
> > > > +		.name =3D "adis16475",
> > > > +		.of_match_table =3D adis16475_of_match,
> > > > +	},
> > > > +	.id_table =3D adis16475_ids,
> > > > +	.probe =3D adis16475_probe,
> > > > +};
> > > > +module_spi_driver(adis16475_driver);
> > > > +
> > > > +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> > > > +MODULE_DESCRIPTION("Analog Devices ADIS16475 IMU driver");
> > > > +MODULE_LICENSE("GPL"); =20
>=20

