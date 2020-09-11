Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B82663B5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Sep 2020 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgIKQWz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Sep 2020 12:22:55 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62954 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgIKQWp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Sep 2020 12:22:45 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BDUSoa013745;
        Fri, 11 Sep 2020 09:33:55 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 33c7a7k4dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:33:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnAMWJb263CjU5b5EEgW9miu7pslyvgfDVJU7U6WNRWERZRfh1O1hv7n2kva+Z1Q2jUM+9BNdMPxJvQFBKuqSih60qQBJv9ZaR/Xc16l4tNqzTqzX3Lza2ilVf2RtMOnhci1BSxoHJDsgjhVzkraY9tSP4kqqw6BLlRLBJoCsel9KQO9lgShoYW6TkQZSBvEhicvY+JLktFjfnCiQGT/CPXLkplwC0HzdGoV7lUFwMYAfGXgQW6iDUSt/MI2mSRgz5/ppM9E7pufo1BgNnVEfTjHqH/lBRzAy40dVXqEtCI6kfrMruUFI2Q0eCAAZjUNR7Q/r9Tu3+LEUBCwbJ2N1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcr1nWXIGxXqKClkEntukR1W6vRPR+opNP/PQERZVOU=;
 b=kymBOmK3IOszanvh8NVlnbFi80YcDT67dAlRkV6efsWkita3S7H7oMfboFY9GTAuUOsfmgGuIXprb0+HT2Db4AlsyLzVUwLl1jwJeXRxZiZ3EgxukrjFG3p13a+aVQSb8aqPUT3hdKiDH8MGWicMWyAEdALofO6GiBsnxK0TRc7Io7sDXstaFeqTpGuNgeQm0sui9cZGc5Kwub59Lg2n4NS9K0jxxmx0S7IvWJbffV3GFaHTtzuLdCLOLwZ0D2J/7MFJqVkSovuNnH4BZ32IAm7Vq+gkRDuzcxjnHyepkdl58NZor0YPL+Hx3St15y78MYtTN/KdP47vjxU0542sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcr1nWXIGxXqKClkEntukR1W6vRPR+opNP/PQERZVOU=;
 b=RXavWV+rAEnArkjZLwkyUCIDJpy81bITNuIoqRJ8bikoMPRQtSWau7riMwG1q15O7keraeoXZdxTjms4JIKaMKGknWVA4YgC1Y4awFp5sqdDleR3asrPgrrdZEngfN1BfYEIolp5BJ9ijtYF1u4j3AucaUif+iXgKsxxElpCb6Q=
Received: from BN6PR03MB2514.namprd03.prod.outlook.com (2603:10b6:404:15::16)
 by BN7PR03MB3617.namprd03.prod.outlook.com (2603:10b6:406:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 13:33:53 +0000
Received: from BN6PR03MB2514.namprd03.prod.outlook.com
 ([fe80::f97b:3d4:9aa2:fec6]) by BN6PR03MB2514.namprd03.prod.outlook.com
 ([fe80::f97b:3d4:9aa2:fec6%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 13:33:53 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2] iio: core: Add optional symbolic label to a device
 channel
Thread-Topic: [RFC PATCH v2] iio: core: Add optional symbolic label to a
 device channel
Thread-Index: AQHWefGasimkgzJai0eJZKBxcJKrA6lQjFiAgAfTFFCAACrC4IADTaiAgAezdEA=
Date:   Fri, 11 Sep 2020 13:33:53 +0000
Message-ID: <BN6PR03MB25142BDF4D295086CE214F84E7240@BN6PR03MB2514.namprd03.prod.outlook.com>
References: <20200824083646.84886-1-cristian.pop@analog.com>
        <20200830122425.3e00332b@archlinux>
        <BN6PR03MB2514AE2330F47235028B4455E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
        <BN6PR03MB251405FC8654C3539D7BD9C1E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
 <20200906165329.150cc055@archlinux>
In-Reply-To: <20200906165329.150cc055@archlinux>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy02NjhkYTIxNi1mNDMzLTExZWEtOTQ1OS0xODFkZWE1?=
 =?us-ascii?Q?NDZmZTBcYW1lLXRlc3RcNjY4ZGEyMTgtZjQzMy0xMWVhLTk0NTktMTgxZGVh?=
 =?us-ascii?Q?NTQ2ZmUwYm9keS50eHQiIHN6PSIxMDg0NyIgdD0iMTMyNDQzMDQ4MjAwMTMx?=
 =?us-ascii?Q?NzA1IiBoPSJzbGprMUtIOUg2bENmdHkxcHo0TVpISXZwU0k9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUI1?=
 =?us-ascii?Q?VlBBb1FJaldBWUJHbEhJUHRWamlnRWFVY2crMVdPSURBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQUY0aG9ad0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.129.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6fb7dbf-3704-40db-9f56-08d856575371
x-ms-traffictypediagnostic: BN7PR03MB3617:
x-microsoft-antispam-prvs: <BN7PR03MB3617652498B4A6392D0C879BE7240@BN7PR03MB3617.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZA7kVr1oFHp5ueb7hnf7NB85UtVTU7eLMl8vIDVK5L12HjK9pmgTYIgEHlRAXEkp72Ka4MEp2wZqcPQ8TuGaBc3AkBDHyCyT4MGJGENyyPmnkjnQrhnYbOuPMFvAxl7EAzQkW9ktqomye0FnuPpd5kjMo29nAqnJ1hx4Q3HdGJCZX2zns5YOc34OVTvFzPRojeb/UjliXKXyoZzULjoSPVsmzc7TWi3CzwI3986KNFmmxuw1ULjfzgQ27IRQE3w/hs9ldltHQqJXo10fsuQp7p8XPVE0lIy5JAyPEE0YBd6msVonMHVwZavb7+pqHKHU7QDms0WVh0wQZUb7aU6d3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB2514.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(71200400001)(76116006)(26005)(53546011)(6506007)(8936002)(52536014)(6916009)(7696005)(55016002)(9686003)(2906002)(86362001)(5660300002)(8676002)(30864003)(316002)(4326008)(478600001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +WnUD80rqIlUfVZBu9TBtpPCuaIgm9/Ougg1wjn8L4oLFzEBUcEqJn2mOEByE9L40IU/VV/j2bwOPSlAYDkPaSkE6hSUAuXbIAhxlzGbKiS9GNf8HkFQLRgJ+WM4pX858kV22wYtH2ROMZa7uBU9YdhxH0+PM3VsjJR6q43SYY7/Zlwo6fxwu3YVFUUWAyxtxhcTEA73h5v6ixvxqe2i9h7vIHjThDvEzdUebpGMhVUOp7/xiwsvxU+xRVw25Wmz08vt8X3njjzsF2xG4Tm10cLDNExD/gwZu3f74zRa2WFdEq+slGdgQvEB8jzCfG62HBnXN3lOl+26LGv/tQMt20P8m6czF7h3G2in+FijbPZwy3WQuM2McEcJJ9jSMs3klQMQkD/JZ4z+ApJ50jax5m5yk/eBQ3e/7gogQ2S8HBXlJgtYQRLMgxBROYIClEJXnNdd8JUIuuS1KCbcwx+/8O4tlu4Ry9HeFd/MtsUcTt5JHdWqBrm+tDL8N4WmG+Zf2eBTmtgyvfSvnM1pBjClDOTEBtYDq/o6dx9Ii5uck2+LqweeWNC84TZIi7AACsAR4R05hqVavxaO24vox6Xmiih+QyDiiVieUOvv4YOGFah9YweLp2pnUJ1TMfHIeGgllBVXJ+CtNuTLpXmhB6hMUQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB2514.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fb7dbf-3704-40db-9f56-08d856575371
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 13:33:53.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+sjbpxGK6VpXbScJAoo/6HN/0YcV1Xy57Yx9kCmfQUaQ7TWuiClqVGAoDo9I2QHUa4A81TC7s32St2etwVtNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3617
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_04:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 6, 2020 6:53 PM
> To: Pop, Cristian <Cristian.Pop@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label to a d=
evice
> channel
>=20
> [External]
>=20
> On Fri, 4 Sep 2020 13:35:12 +0000
> "Pop, Cristian" <Cristian.Pop@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Pop, Cristian
> > > Sent: Friday, September 4, 2020 2:14 PM
> > > To: Jonathan Cameron <jic23@kernel.org>
> > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [RFC PATCH v2] iio: core: Add optional symbolic label
> > > to a device channel
>=20
> Hi Cristian,
>=20
> If possible fix your word wrapping for future replies.
> I've tried to unwind it below but it makes it very hard to read and reply=
 to.
>=20
> > >
> > > Best ragards,
> > > Cristian Pop
> > >
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Sunday, August 30, 2020 2:24 PM
> > > > To: Pop, Cristian <Cristian.Pop@analog.com>
> > > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label
> > > > to a device channel
> > > >
> > > > [External]
> > > >
> > > > On Mon, 24 Aug 2020 11:36:46 +0300 Cristian Pop
> > > > <cristian.pop@analog.com> wrote:
> > > >
> > > > > If a label is defined in the device tree for this channel add
> > > > > that to the channel specific attributes. This is useful for
> > > > > userspace to be able to identify an individual channel.
> > > > >
> > > > > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > > > > ---
> > > > >  Changes in v2:
> > > > > 	- Move label check before "read_raw" callback.
> > > > > 	- Move the responsability to of parsing channel labels, to the
> > > > > 	  driver.
> > > > >
> > > > >  drivers/iio/industrialio-core.c | 10 ++++++++--
> > > > >  include/linux/iio/iio.h         |  2 ++
> > > > >  include/linux/iio/types.h       |  1 +
> > > > >  3 files changed, 11 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/industrialio-core.c
> > > > > b/drivers/iio/industrialio-core.c index
> > > > > 1527f01a44f1..32277e94f02d
> > > > > 100644
> > > > > --- a/drivers/iio/industrialio-core.c
> > > > > +++ b/drivers/iio/industrialio-core.c
> > > > > @@ -135,6 +135,7 @@ static const char * const
> > > > > iio_modifier_names[] =3D {
> > > > >  /* relies on pairs of these shared then separate */  static
> > > > > const char * const iio_chan_info_postfix[] =3D {
> > > > >  	[IIO_CHAN_INFO_RAW] =3D "raw",
> > > > > +	[IIO_CHAN_INFO_LABEL] =3D "label",
> > > > >  	[IIO_CHAN_INFO_PROCESSED] =3D "input",
> > > > >  	[IIO_CHAN_INFO_SCALE] =3D "scale",
> > > > >  	[IIO_CHAN_INFO_OFFSET] =3D "offset", @@ -653,14 +654,18 @@
> > > > > static ssize_t iio_read_channel_info(struct device
> > > > *dev,
> > > > >  	int ret;
> > > > >  	int val_len =3D 2;
> > > > >
> > > > > -	if (indio_dev->info->read_raw_multi)
> > > > > +	if (indio_dev->info->read_raw_multi) {
> > > > >  		ret =3D indio_dev->info->read_raw_multi(indio_dev, this_attr-
> > > > > c,
> > > > >
> > > > 	INDIO_MAX_RAW_ELEMENTS,
> > > > >  							vals, &val_len,
> > > > >  							this_attr->address);
> > > > > -	else
> > > > > +	} else {
> > > > >  		ret =3D indio_dev->info->read_raw(indio_dev, this_attr->c,
> > > > >  				    &vals[0], &vals[1], this_attr->address);
> > > > > +		if (ret < 0 && this_attr->address =3D=3D
> IIO_CHAN_INFO_LABEL
> > > > &&
> > > > > +			this_attr->c->label_name)
> > > >
> > > > I'm not keen on this. We shouldn't be calling read_raw at all in th=
is path.
> > > > There is no way it can return a valid label.
> > > >
> > > > > +			return sprintf(buf, "%s\n", this_attr->c-
> >label_name);
> > > > > +	}
> > > > >
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > > > @@ -1399,6 +1404,7 @@ static int
> > > > > iio_device_register_sysfs(struct iio_dev
> > > > *indio_dev)
> > > > >  			attrcount_orig++;
> > > > >  	}
> > > > >  	attrcount =3D attrcount_orig;
> > > > > +
> > > >
> > > > Please avoid unrelated white space changes.
> > > >
> > > > >  	/*
> > > > >  	 * New channel registration method - relies on the fact a group=
 does
> > > > >  	 * not need to be initialized if its name is NULL.
> > > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > > > index a1be82e74c93..39209f3b62be 100644
> > > > > --- a/include/linux/iio/iio.h
> > > > > +++ b/include/linux/iio/iio.h
> > > > > @@ -223,6 +223,7 @@ struct iio_event_spec {
> > > > >   *			correspond to the first name that the channel
> is
> > > > referred
> > > > >   *			to by in the datasheet (e.g. IND), or the
> nearest
> > > > >   *			possible compound name (e.g. IND-INC).
> > > > > + * @label_name:		Unique name to identify which
> channel this is.
> > > > >   * @modified:		Does a modifier apply to this channel. What
> > > > these are
> > > > >   *			depends on the channel type.  Modifier is set
> in
> > > > >   *			channel2. Examples are IIO_MOD_X for axial
> sensors
> > > > about
> > > > > @@ -260,6 +261,7 @@ struct iio_chan_spec {
> > > > >  	const struct iio_chan_spec_ext_info *ext_info;
> > > > >  	const char		*extend_name;
> > > > >  	const char		*datasheet_name;
> > > > > +	const char		*label_name;
> > > >
> > > > This can't be part of chan_spec as that is constant in many drivers=
.
> > > > We need a separate way of doing this.
> > What do you mean by "chan_spec is constant in many drivers"?
> > Instances of the "struct iio_chan_spec" are created in the driver.
>=20
> No they aren't.  Grep for struct iio_chan_spec Something like...
> git grep iio_chan_spec -- drivers/iio/ | grep const | grep channels
>=20
> A very very large number of drivers keep this data constant.
> If the driver doesn't provide flexibility on enabled channels (for exampl=
e such
> flexibility makes no sense on an accelerometer) then the instances of thi=
s
> structure are constant.
>=20
> There are lots of good reasons to do this if at all possible and I'm not =
happy
> changing it just to put in an optional string.
>=20
> > Also it makes sense for me to add "const char              *label_name;=
"
> > in this structure since it is an attribute of the channel, and it
> > doesn't change at runtime, only when parsing the device tree and
> > assigning the value to it
>=20
> That is at runtime.  The structure is constant at build time in many/most
> drivers.
> There are 459 instances using the above grep for starters that would all =
need
> to change.
>=20
> >, when an instance of "iio_chan_spec" is created.
> > >> Don't use info_mask, but
Hi Jonathan!

How would you inform iio -core that label is present for a specific channel=
 and
a file system for it should be created?

Best regards,
Cristian

> > > > register it separately for each channel in a similar way to we do
> > > > the name and label attributes for the whole device.
> > Don't understand this part. "name" and "label" of the device are
> > elements of "struct iio_dev", as "const char  *label_name;" is part of =
"struct
> iio_chan_spec", the equivalent structure for holding channel attributes.
> It is not the equivalent structure.  There is no equivalent per channel s=
tructure.
> iio_chan_spec is a specification for a channel, not a dynamic structure h=
olding
> information about it, whereas iio_dev is such a dynamic structure holding
> dynamic information about the device (plus a few small bits of constant i=
nfo).
>=20
> If we need a dynamic structure per channel then we need to create a new o=
ne,
> not take a massive amount of constant data and make it dynamic in order t=
o
> add a single dynamic field.
>=20
> > Who will hold the label values otherwise, if not the " iio_chan_spec "
> structure?
>=20
> A new element.  For now we should keep this in the drivers because it is =
a
> driver decision to provide this information.  For a lot of drivers it mak=
es no
> sense to have a label so we don't want to put the burden on the IIO core.
>=20
> For now, a driver should just copy the labels into driver local storage a=
nd
> return them from the new callback.
>=20
> Later, we can look at adding utility functions etc if it turns out to mak=
e sense.
> However, I'm not interested in doing that until we have a reasonable numb=
er
> of drivers using the facility and hence a good understanding of the commo=
n
> elements of such functions.
>=20
> > > > I would add a new callback to iio_info that is passed the
> > > > iio_chan_spec and returns a const char * for the label name.
> > I do agree with the callback, it can be a more generic callback, to
> > return strings, for other purposes also.
> > Something like this:
> >     int (*read_string)(struct iio_dev *indio_dev,  struct
> > iio_chan_spec const *chan,  char *string,  long mask); or
> >     int (*read_string)(struct iio_dev *indio_dev,  struct
> > iio_chan_spec const *chan, const char **string, long mask); The callbac=
k will
> be called in "iio_read_channel_info", so I think that a system file will =
be
> created for it.
>=20
> What else is it used for?  If you are refactoring some other code to use =
this
> new callback then it is worth considering.  Until then it's an unused
> generalization so a bad idea.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > > >
> > > > The driver would be responsible for doing a lookup based on what
> > > > it has cached from the dt parse, probably indexed off address or
> > > > scan_index (that can be driver specific)
> > > >
> > > > To create the attribute you need to add this to
> > > > iio_device_register_sysfs and use the various core functions to
> > > > build the attribute name in a similar fashion to that done for info=
 mask
> elements.
> > > >
> > > > It will be more complex than your approach, but make it more
> > > > 'separable' as a feature in drivers.
> > > >
> > > > Jonathan
> > > >
> > > >
> > > > >  	unsigned		modified:1;
> > > > >  	unsigned		indexed:1;
> > > > >  	unsigned		output:1;
> > > > > diff --git a/include/linux/iio/types.h
> > > > > b/include/linux/iio/types.h index e6fd3645963c..c8f65f476eb2
> > > > > 100644
> > > > > --- a/include/linux/iio/types.h
> > > > > +++ b/include/linux/iio/types.h
> > > > > @@ -34,6 +34,7 @@ enum iio_available_type {
> > > > >
> > > > >  enum iio_chan_info_enum {
> > > > >  	IIO_CHAN_INFO_RAW =3D 0,
> > > > > +	IIO_CHAN_INFO_LABEL,
> > > > >  	IIO_CHAN_INFO_PROCESSED,
> > > > >  	IIO_CHAN_INFO_SCALE,
> > > > >  	IIO_CHAN_INFO_OFFSET,
> >

