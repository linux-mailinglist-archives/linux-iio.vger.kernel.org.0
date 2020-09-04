Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D925DB30
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgIDORl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 10:17:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10374 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730641AbgIDOR1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 10:17:27 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084DTcUn021816;
        Fri, 4 Sep 2020 09:35:14 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 337gv6uykg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 09:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpVu2l8PaAbpH2fcQgDYk2HfS/KTBPQJjIOSWXZ0oZ1RxBhkseOcwTKVXarr6dcdiBq7SCLl/Mo1aNvTRGJYC9IY2RIJ5SMFneV1EQttJS8mRBuRbEFr40l8XS9fJVkUrmEMbp2czpd3wI59pqqsMA4rrs32fMh6G4U4xoZHzai/WAlyScIT5jro7vV8MoI8phgO1SqiftZoY2RffqZztTyDxL6kIbqyv+Kr2XGPSxrsg9OOzkps39enZ9gc2RhLx1KhCbAmA31RlGHZ2osvUs1kS10pmafQ6JRSk/DbEJP3lB7zGHgNd+WMKoiaxHmYorw7nMgwKc6ecn7GBxOcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PYFShbb7td8RcLzcp/5QY51ZofAe6KvoYApXg1JFXk=;
 b=DsRMqKiQn4UlRpTgejHQOKBY7/yCubUjTZos05XGFuzKk9BOGAWpP5Zg7qSYpC7b0tEbM5Hxi2Y3kuyWelXYV4JiLfJQT7bqbNOJs9VoblO/6DiTgKFtOMVZ/wZ1AB07iwF5hfmdX4PBPi7ZWsrVLciRTuTkRqYJRR2HCujwurKlE1r35TihIw7r4T0ReTBVOTfvwOA9e3JaTSG/0sPJjDqe+0k/FjJMtlykyIHsqVLNiU6P/nUDgcFnJx1TcuJNkGFB9H8x2DkEejtOGbXTz6YjDUu736k9OVy3VdsHtQpmoqgmUp9p7GBpxmOM4XNjrxnAUJcynMtfXwKfZ2/bOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PYFShbb7td8RcLzcp/5QY51ZofAe6KvoYApXg1JFXk=;
 b=Wm0zuFfb0EaM35arUDJJ5nCOjMajHDH/NdRbjGTN9XcNNvpAZKCVOz2Y3eMq8THO4hWETGQe2mlT2tyxCyM237lh5UL7xcJaHHqVLNzRTwmvv8QWBnuxN2CWN6ZPM4ZxAlq1f2RaLfa87s0f2p49vRv/oeTg3dy7+SMHTqsvMTI=
Received: from BN6PR03MB2514.namprd03.prod.outlook.com (2603:10b6:404:15::16)
 by BN6PR03MB2513.namprd03.prod.outlook.com (2603:10b6:404:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 13:35:12 +0000
Received: from BN6PR03MB2514.namprd03.prod.outlook.com
 ([fe80::f97b:3d4:9aa2:fec6]) by BN6PR03MB2514.namprd03.prod.outlook.com
 ([fe80::f97b:3d4:9aa2:fec6%7]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 13:35:12 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2] iio: core: Add optional symbolic label to a device
 channel
Thread-Topic: [RFC PATCH v2] iio: core: Add optional symbolic label to a
 device channel
Thread-Index: AQHWefGasimkgzJai0eJZKBxcJKrA6lQjFiAgAfTFFCAACrC4A==
Date:   Fri, 4 Sep 2020 13:35:12 +0000
Message-ID: <BN6PR03MB251405FC8654C3539D7BD9C1E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
References: <20200824083646.84886-1-cristian.pop@analog.com>
 <20200830122425.3e00332b@archlinux>
 <BN6PR03MB2514AE2330F47235028B4455E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB2514AE2330F47235028B4455E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy03MmEwZDQ3ZC1lZWIzLTExZWEtOTQ1Ny0xODFkZWE1?=
 =?us-ascii?Q?NDZmZTBcYW1lLXRlc3RcNzJhMGQ0N2UtZWViMy0xMWVhLTk0NTctMTgxZGVh?=
 =?us-ascii?Q?NTQ2ZmUwYm9keS50eHQiIHN6PSI3MTkzIiB0PSIxMzI0MzcwMDEwOTE3MDc3?=
 =?us-ascii?Q?MjYiIGg9Ik5UdXdQQmFqZms4VWR1dmlnZzNTQ3ZVSlBEbz0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FBQk9j?=
 =?us-ascii?Q?ekExd0lMV0FZZS9DSFRmOVpMZGg3OElkTi8xa3QwREFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBRjRob1p3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFhUUJm?=
 =?us-ascii?Q?QUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFGOEFa?=
 =?us-ascii?Q?Z0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlB?=
 =?us-ascii?Q?R1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFH?=
 =?us-ascii?Q?b0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.129.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57ff7d45-ce0a-4e93-7678-08d850d75991
x-ms-traffictypediagnostic: BN6PR03MB2513:
x-microsoft-antispam-prvs: <BN6PR03MB25134BF2D1E0C0569CDCB3EEE72D0@BN6PR03MB2513.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MKTN4QAsLzJR9Ea5yLzsDH7exsRbXezdfsZwPLjrLYKN+YE39yIbxrirLPkCndqIQxaCRehrv7dCJnDWamnG8aKmQ+8CJU9xSTyzdZV0atWqopSUuVg9GbyEBstGD1tQL5tSAT/OpXUPdaKMgi1wisXVY2X/fB+AGUH5B3fQRDq6aHMOrEln+OSNQZlUQQ4/O7AsHO2svXpv5qwcM5YiNEN0DTPYVPpBmneYN3r72aovPBr6zvtxDRwG+cFqE3H0+D9Qa3V3JL2uQPe3P2jImLbERXSezyYeW4uTKpRyTU8ZpLaVRrXAjCJlHCcAYSCTJWm0EYv/gQi21IUbYwRGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB2514.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(26005)(4326008)(316002)(7696005)(33656002)(54906003)(52536014)(71200400001)(83380400001)(6506007)(53546011)(5660300002)(8936002)(2940100002)(8676002)(6916009)(64756008)(66446008)(55016002)(478600001)(9686003)(76116006)(86362001)(2906002)(66476007)(66946007)(66556008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pDpviubZ2CEvsUy/AcnFAlmJBK6hTnBEHrpWryujbPQTWgZjR0ssbqK//dab3fEtZvQUe3WRzye46Znzrvf0Quu+KsD8Kz6iiSm8W0KbkuNenSuGwXvXUQmskJSXWLqQVqLJvSpYQzoJoDgvI1ToHc21IFefMITvWYXcNVSBKj9yOJ6tahS0kUAGEJa1VESLbaT/wqRJDjhbXkgxSLG6yntRA7mZY53/LWcWPjCq1xFgLy9JtNSTZtM5GPdc3+/v1n/NqD7Nn/JfCGgLRmaG+D8sw5CnTNMNBV70vfRBfTyHY1fkdU/0gH/IUoeZm9lLz2JQp7WqZ9snaawi/Z/RNyMFUhML4TghwUjuA9KO/IKYsTrVyokKmGEo5d8lWYBwnUWSxLSENbOvhONVqoMLxwSdMVBj5JgNy4+sUb9J9qcX3MDBAErCmzalu8lQLwe88YJSbEWRxP78nRQ74JRLpDum9UWkSit8oQoVh5hKD/U9gjkiueNgTKTCz+Z+Enwgv0I4dFgfA5GoNlGAZgb/OVK2SC7hqP3i2Fnj+rixEP19/rG0k9mHWTUheSZQYrY597j6ekeCXHUxWd6dNN1rQopDkA2IUtrTcUzjOuTlZD2ssPermU+63hODbwpCDPRuGTSBr6nS3wiB6K9ButHzsw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB2514.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ff7d45-ce0a-4e93-7678-08d850d75991
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 13:35:12.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hDvonBjte0AmBdrUiUwmpv1CqBrZR1skcrfSV/Eo954RKaWWcCFpia4zVX7Hj5BeT6wxqIhcanpChBmNqcIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2513
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_07:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Pop, Cristian
> Sent: Friday, September 4, 2020 2:14 PM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [RFC PATCH v2] iio: core: Add optional symbolic label to a d=
evice
> channel
>=20
> Best ragards,
> Cristian Pop
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, August 30, 2020 2:24 PM
> > To: Pop, Cristian <Cristian.Pop@analog.com>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label to
> > a device channel
> >
> > [External]
> >
> > On Mon, 24 Aug 2020 11:36:46 +0300
> > Cristian Pop <cristian.pop@analog.com> wrote:
> >
> > > If a label is defined in the device tree for this channel add that
> > > to the channel specific attributes. This is useful for userspace to
> > > be able to identify an individual channel.
> > >
> > > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > > ---
> > >  Changes in v2:
> > > 	- Move label check before "read_raw" callback.
> > > 	- Move the responsability to of parsing channel labels, to the
> > > 	  driver.
> > >
> > >  drivers/iio/industrialio-core.c | 10 ++++++++--
> > >  include/linux/iio/iio.h         |  2 ++
> > >  include/linux/iio/types.h       |  1 +
> > >  3 files changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-core.c
> > > b/drivers/iio/industrialio-core.c index 1527f01a44f1..32277e94f02d
> > > 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -135,6 +135,7 @@ static const char * const iio_modifier_names[] =
=3D
> > > {
> > >  /* relies on pairs of these shared then separate */  static const
> > > char * const iio_chan_info_postfix[] =3D {
> > >  	[IIO_CHAN_INFO_RAW] =3D "raw",
> > > +	[IIO_CHAN_INFO_LABEL] =3D "label",
> > >  	[IIO_CHAN_INFO_PROCESSED] =3D "input",
> > >  	[IIO_CHAN_INFO_SCALE] =3D "scale",
> > >  	[IIO_CHAN_INFO_OFFSET] =3D "offset", @@ -653,14 +654,18 @@ static
> > > ssize_t iio_read_channel_info(struct device
> > *dev,
> > >  	int ret;
> > >  	int val_len =3D 2;
> > >
> > > -	if (indio_dev->info->read_raw_multi)
> > > +	if (indio_dev->info->read_raw_multi) {
> > >  		ret =3D indio_dev->info->read_raw_multi(indio_dev, this_attr- c,
> > >
> > 	INDIO_MAX_RAW_ELEMENTS,
> > >  							vals, &val_len,
> > >  							this_attr->address);
> > > -	else
> > > +	} else {
> > >  		ret =3D indio_dev->info->read_raw(indio_dev, this_attr->c,
> > >  				    &vals[0], &vals[1], this_attr->address);
> > > +		if (ret < 0 && this_attr->address =3D=3D IIO_CHAN_INFO_LABEL
> > &&
> > > +			this_attr->c->label_name)
> >
> > I'm not keen on this. We shouldn't be calling read_raw at all in this p=
ath.
> > There is no way it can return a valid label.
> >
> > > +			return sprintf(buf, "%s\n", this_attr->c->label_name);
> > > +	}
> > >
> > >  	if (ret < 0)
> > >  		return ret;
> > > @@ -1399,6 +1404,7 @@ static int iio_device_register_sysfs(struct
> > > iio_dev
> > *indio_dev)
> > >  			attrcount_orig++;
> > >  	}
> > >  	attrcount =3D attrcount_orig;
> > > +
> >
> > Please avoid unrelated white space changes.
> >
> > >  	/*
> > >  	 * New channel registration method - relies on the fact a group doe=
s
> > >  	 * not need to be initialized if its name is NULL.
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h index
> > > a1be82e74c93..39209f3b62be 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -223,6 +223,7 @@ struct iio_event_spec {
> > >   *			correspond to the first name that the channel is
> > referred
> > >   *			to by in the datasheet (e.g. IND), or the nearest
> > >   *			possible compound name (e.g. IND-INC).
> > > + * @label_name:		Unique name to identify which channel this is.
> > >   * @modified:		Does a modifier apply to this channel. What
> > these are
> > >   *			depends on the channel type.  Modifier is set in
> > >   *			channel2. Examples are IIO_MOD_X for axial sensors
> > about
> > > @@ -260,6 +261,7 @@ struct iio_chan_spec {
> > >  	const struct iio_chan_spec_ext_info *ext_info;
> > >  	const char		*extend_name;
> > >  	const char		*datasheet_name;
> > > +	const char		*label_name;
> >
> > This can't be part of chan_spec as that is constant in many drivers.
> > We need a separate way of doing this. =20
What do you mean by "chan_spec is constant in many drivers"? Instances of t=
he "struct iio_chan_spec" are created in the driver. Also it makes sense fo=
r me to add "const char              *label_name;" in this structure since =
it is an attribute of the channel, and it doesn't change at runtime, only w=
hen parsing the device tree and assigning the value to it, when an instance=
 of "iio_chan_spec" is created.
>> Don't use info_mask, but
> > register it separately for each channel in a similar way to we do the
> > name and label attributes for the whole device.
Don't understand this part. "name" and "label" of the device are elements o=
f "struct iio_dev", as "const char  *label_name;" is part of "struct iio_ch=
an_spec", the equivalent structure for holding channel attributes.
Who will hold the label values otherwise, if not the " iio_chan_spec " stru=
cture?
> > I would add a new callback to iio_info that is passed the
> > iio_chan_spec and returns a const char * for the label name.
I do agree with the callback, it can be a more generic callback, to return =
strings, for other purposes also.
Something like this:
    int (*read_string)(struct iio_dev *indio_dev,  struct iio_chan_spec con=
st *chan,  char *string,  long mask);
or
    int (*read_string)(struct iio_dev *indio_dev,  struct iio_chan_spec con=
st *chan, const char **string, long mask);
The callback will be called in "iio_read_channel_info", so I think that a s=
ystem file will be created for it.
> >
> > The driver would be responsible for doing a lookup based on what it
> > has cached from the dt parse, probably indexed off address or
> > scan_index (that can be driver specific)
> >
> > To create the attribute you need to add this to
> > iio_device_register_sysfs and use the various core functions to build
> > the attribute name in a similar fashion to that done for info mask elem=
ents.
> >
> > It will be more complex than your approach, but make it more
> > 'separable' as a feature in drivers.
> >
> > Jonathan
> >
> >
> > >  	unsigned		modified:1;
> > >  	unsigned		indexed:1;
> > >  	unsigned		output:1;
> > > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > > index e6fd3645963c..c8f65f476eb2 100644
> > > --- a/include/linux/iio/types.h
> > > +++ b/include/linux/iio/types.h
> > > @@ -34,6 +34,7 @@ enum iio_available_type {
> > >
> > >  enum iio_chan_info_enum {
> > >  	IIO_CHAN_INFO_RAW =3D 0,
> > > +	IIO_CHAN_INFO_LABEL,
> > >  	IIO_CHAN_INFO_PROCESSED,
> > >  	IIO_CHAN_INFO_SCALE,
> > >  	IIO_CHAN_INFO_OFFSET,

