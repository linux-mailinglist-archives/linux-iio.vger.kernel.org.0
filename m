Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD0B2024F6
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jun 2020 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFTP5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jun 2020 11:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgFTP5p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 11:57:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB85823D6A;
        Sat, 20 Jun 2020 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592668664;
        bh=D8fKktaZdo0jD0i4fAQUF+z6/90romTLM3ZgSwzvpY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pP6GKyBHjzZRcJx+iJFjVnoR2m7N67RQfT0Bm48HzxTwn/NPvrKJennJn5qtMW7A6
         XWs9wB6b/eUtJcm1UKKlpAcNqOMDywl+aCTbaTc9WvlyB3E/UomafaAif3mEpR1rGF
         BplKzw7hKoY66Q6EEC9wx43AN2/CjzSQOs+w4xz4=
Date:   Sat, 20 Jun 2020 16:57:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor
 support
Message-ID: <20200620165739.29694b9b@archlinux>
In-Reply-To: <MN2PR12MB4422148948CF6FC7953A6D2AC49F0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
        <20200608204250.3291-7-jmaneyrol@invensense.com>
        <fd4918b6-a55f-4047-7f18-b796a8ccd020@metafoo.de>
        <MN2PR12MB4422148948CF6FC7953A6D2AC49F0@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Jun 2020 20:35:13 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello Lars,
>=20
> for the temperature data, the problem is that temperature in the FIFO (us=
ed in buffer) is not in the same format than when reading the register.
>=20
> Reading the temperature register return a full precision value on 16 bits=
. I am using a PROCESSED attribute for it.
> Temperature data in buffer (coming from the FIFO) is on 8 bits in lower p=
recision. It is reported as raw data, thus the need of the offset and scale=
 values.
>=20
> So offset and scale values are only for transforming the temperature data=
 from the buffer, and direct read is a full precision already processed in =
m=C2=B0C.

That is a problem.  We have no means of describing it in IIO.

If the channel is processed via sysfs the assumption would normally
be that it is processed in the buffer as well. We don't really
have any means of describing the two separately.

In cases where we've seen this before the way around it was to
change the data in the fifo so that the scaling was the same as the
sysfs channel (usually it's just a bit of padding).

Can we do that here?  Looks like the ratio is 1:64 so should
be possible.=20



>=20
> Thanks for the review,
> JB
>=20
> From: Lars-Peter Clausen <lars@metafoo.de>
> Sent: Sunday, June 14, 2020 17:10
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; jic23@kernel.org <=
jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org=
 <robh@kernel.org>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; =
davem@davemloft.net <davem@davemloft.net>; gregkh@linuxfoundation.org <greg=
kh@linuxfoundation.org>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sen=
sor support=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> On 6/8/20 10:42 PM, Jean-Baptiste Maneyrol wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_PROCESSED:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D iio_device_claim_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_temp_read(st, &temp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_device_release_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *val =3D temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *val =3D 483;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *val2 =3D 91787;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT_PLUS_MICRO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_OFFSET:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *val =3D 25000;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT; =20
>=20
> If the data is returned processed there is no need to specify scale and=20
> offset.
>=20
> But since the transformation to turn the data into standard units is a=20
> simple linear transform the preferred way to handle this is to return=20
> RAW data and specify scale and offset.

