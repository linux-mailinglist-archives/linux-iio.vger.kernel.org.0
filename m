Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8825D8C0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgIDMkZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 08:40:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23358 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgIDMkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 08:40:23 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084BDv0p014835;
        Fri, 4 Sep 2020 07:14:06 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 337kx6k1w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 07:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br08u3q45J3II7CxV79UT2daWHIawizVGMHX4DqmLDmYxORodf3d1W12QYx4WdZcTH1JYuTmcPxZoix5TBXkruCo5jL/pL3s34OmjC4fwztujsIdSGCK1DIHmt5Do7ypVuk1kkmlszOIPu4uBcIsCVnCG+PHbWw7apPR7tSgiVgyqYC/miuVL+7BAOYc8OWwpfn9CvARCCqz+1epD+U8aM11hIcs1zNv5/IfqJuCu88idaOk2Msjpc3pPEZzSeF4x5jcqEvKMvmwF/QYcv0MEsgZ51+uaKbAKHpvKN/n3nYuRTrHhlS0Bfn0vbpyn+ZPD4jpbQ2Xvkl/uHTnhsTkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAj6xTrkt+3ZgiXhXpzuOH6CNbf/XqoGTzCBcYp4iQk=;
 b=e0Ln+ZZ2xxhL43tiCD7NJlHeKe0BfeJ3lBChuUv9WJGNPToQBGU83Pbk8PSbl6A3IqRRyrEka508eh11/Mn0UKdlQCc8e0B34SVsJrDMzxh5c0fcNXTSINWKctPrZE4KcNbbdWzNQqkyo6xgkgc5a4B05U/PDcoSCtXCG1dtoMiF5fbFRwBMJlJdFZ7zPINR59Hd22pUU2BsSXQYnFnFhESDfmphXzJehanjXtMSS3ni3ADmIYqHKLOBMy0jHwFfAxUDdYQmu5ep4e5HdMe+DAVsWAK3vU6Kkbly7fa63awXuIF7cRaemTSD1e8p2wQNW+7s0xU00mn+RdskHnmaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAj6xTrkt+3ZgiXhXpzuOH6CNbf/XqoGTzCBcYp4iQk=;
 b=BB9TY/acbHfq+hRfiu6X9EvA/OqIpg3zliiZrxRXzyC8UftFQnKqjExAHAtar5Cg3Xq2A8xrYHGkeaifJhjYzT7pu+9gjreIjn0Jf6cbqDmElpfScQnuMeFmtkdshufKTHLf+LG3ztS2uW8qgyRxqomMBekf2ZdWqfvWloPcLmI=
Received: from BN6PR03MB2514.namprd03.prod.outlook.com (2603:10b6:404:15::16)
 by BN8PR03MB4611.namprd03.prod.outlook.com (2603:10b6:408:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 11:14:04 +0000
Received: from BN6PR03MB2514.namprd03.prod.outlook.com
 ([fe80::f97b:3d4:9aa2:fec6]) by BN6PR03MB2514.namprd03.prod.outlook.com
 ([fe80::f97b:3d4:9aa2:fec6%7]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 11:14:04 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2] iio: core: Add optional symbolic label to a device
 channel
Thread-Topic: [RFC PATCH v2] iio: core: Add optional symbolic label to a
 device channel
Thread-Index: AQHWefGasimkgzJai0eJZKBxcJKrA6lQjFiAgAfTFFA=
Date:   Fri, 4 Sep 2020 11:14:04 +0000
Message-ID: <BN6PR03MB2514AE2330F47235028B4455E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
References: <20200824083646.84886-1-cristian.pop@analog.com>
 <20200830122425.3e00332b@archlinux>
In-Reply-To: <20200830122425.3e00332b@archlinux>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy1iYmNjMjc5ZC1lZTlmLTExZWEtOTQ1Ni0xODFkZWE1?=
 =?us-ascii?Q?NDZmZTBcYW1lLXRlc3RcYmJjYzI3OWUtZWU5Zi0xMWVhLTk0NTYtMTgxZGVh?=
 =?us-ascii?Q?NTQ2ZmUwYm9keS50eHQiIHN6PSI1Nzg1IiB0PSIxMzI0MzY5MTY0MTkzMDc0?=
 =?us-ascii?Q?OTEiIGg9IldmYkZPYmF4YzhxSElKaFBMc3liNktkOVpSST0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FBRGpK?=
 =?us-ascii?Q?MUorcklMV0FmZkN6ZjlBalNORzk4TE4vMENOSTBZREFBQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 805e8d9e-0ae1-4e80-3ed3-08d850c3a246
x-ms-traffictypediagnostic: BN8PR03MB4611:
x-microsoft-antispam-prvs: <BN8PR03MB46111633534C7350DB65C568E72D0@BN8PR03MB4611.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElrQ7S8HBAGr6DGaUrDMZo4y3xLsvP1MD6cy88KUTTsG1KQOYCWiec8+ueMYjygCGSFQ2zeKPOVgslVnr2XXRmfmeEj1Fj2dao6JOsLzdYsq8FbQSWSEZvjr5zfqIT3JBauqoFeXwPSF6Tqw4hFQTHMkPOnlQ16ng3j5LzCylcoH9B1/4U34vxicvqlX0RJR8Ze1L/FlfvMQuJXcR8A0Kt5f/lo1jRAFoFDq61oPQY3sQOfwGQwhN/O2vWLB4u+FOGh7XC7ftZWVaFtwpZMU2LwiRg2Hg4SlznAKEU5gxav0vq+yvfTM1SrNDX5bOQIbHQohn5Zgdlfc+EOLgXeIXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB2514.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(6506007)(53546011)(478600001)(66946007)(26005)(71200400001)(66556008)(7696005)(64756008)(66446008)(86362001)(5660300002)(52536014)(66476007)(76116006)(186003)(83380400001)(33656002)(316002)(6916009)(8676002)(9686003)(55016002)(4326008)(2906002)(54906003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bH7se7/lUrC0GZ0ALVffYU42q9GNR1zHDpbUHTHEekXqZ8Jzl+7VMbRo2Tc8972t1ePBXGXiyMsq67CLF209A0qnIMUxkUlnLX5mIYg8OCdPppweK2leIBuv/IXu6LlbvaS07nVRJsLYEEuu3e0aLohtybpmjdTXKIa/vqQNC0Nw2D+UC5pSn9xuWjVin3/oHQj7eGCmjg615fnU3k5hugTsYCTAyo/fTufbxhaALQGw4XNwuWfkUSMOQ+EYcFe80X6wdN46/oohqb4fppOCm5qmi1CjmnYhXF6k2h54/6vLBB6u9RwL3OWIcsHrBNmVNS6BHUOw0zR30jmrrgtiSXDP8uAT1DCa97SnXHMenzJmdi3YwAai/xNYG1I1dDSfr7tTs1/pHLc2swd6DYqMp/96DKLASL1k8/zMA1VKa2LU2evmqgEh61eM8gG+K7OR30l+qnvAkj3ZhJceGv0qCZ/LqOaCKbyN4aZ1A1FSW+GrOPa/dxYWbSRu0jAR/IDwSdYCiGsdooY7pQ3jqNrK4nWqKP5LI6eFXsslKAupFn0AAcrLMXmTmvGwkVvTsbWkVdCOxXvfDk1ihzsheacgXXIM6aB94VhHI/HQFVEdh0Qq77/JiPXI9k/PRUAUQxkRQXQsqEyRsHsVfw/FSR3qCg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB2514.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805e8d9e-0ae1-4e80-3ed3-08d850c3a246
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 11:14:04.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CZ3utqU0jFPO2p4phEBJedLLFSH7HSC/CqetEEm8NvvkijUS5K49mL2tZGjQy5lnDlRaopjPR/iRQE+EEzVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4611
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_06:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Best ragards,
Cristian Pop

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, August 30, 2020 2:24 PM
> To: Pop, Cristian <Cristian.Pop@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label to a d=
evice
> channel
>=20
> [External]
>=20
> On Mon, 24 Aug 2020 11:36:46 +0300
> Cristian Pop <cristian.pop@analog.com> wrote:
>=20
> > If a label is defined in the device tree for this channel add that to
> > the channel specific attributes. This is useful for userspace to be
> > able to identify an individual channel.
> >
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> >  Changes in v2:
> > 	- Move label check before "read_raw" callback.
> > 	- Move the responsability to of parsing channel labels, to the
> > 	  driver.
> >
> >  drivers/iio/industrialio-core.c | 10 ++++++++--
> >  include/linux/iio/iio.h         |  2 ++
> >  include/linux/iio/types.h       |  1 +
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c
> > b/drivers/iio/industrialio-core.c index 1527f01a44f1..32277e94f02d
> > 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -135,6 +135,7 @@ static const char * const iio_modifier_names[] =3D =
{
> >  /* relies on pairs of these shared then separate */  static const
> > char * const iio_chan_info_postfix[] =3D {
> >  	[IIO_CHAN_INFO_RAW] =3D "raw",
> > +	[IIO_CHAN_INFO_LABEL] =3D "label",
> >  	[IIO_CHAN_INFO_PROCESSED] =3D "input",
> >  	[IIO_CHAN_INFO_SCALE] =3D "scale",
> >  	[IIO_CHAN_INFO_OFFSET] =3D "offset",
> > @@ -653,14 +654,18 @@ static ssize_t iio_read_channel_info(struct devic=
e
> *dev,
> >  	int ret;
> >  	int val_len =3D 2;
> >
> > -	if (indio_dev->info->read_raw_multi)
> > +	if (indio_dev->info->read_raw_multi) {
> >  		ret =3D indio_dev->info->read_raw_multi(indio_dev, this_attr-
> >c,
> >
> 	INDIO_MAX_RAW_ELEMENTS,
> >  							vals, &val_len,
> >  							this_attr->address);
> > -	else
> > +	} else {
> >  		ret =3D indio_dev->info->read_raw(indio_dev, this_attr->c,
> >  				    &vals[0], &vals[1], this_attr->address);
> > +		if (ret < 0 && this_attr->address =3D=3D IIO_CHAN_INFO_LABEL
> &&
> > +			this_attr->c->label_name)
>=20
> I'm not keen on this. We shouldn't be calling read_raw at all in this pat=
h.
> There is no way it can return a valid label.
>=20
> > +			return sprintf(buf, "%s\n", this_attr->c->label_name);
> > +	}
> >
> >  	if (ret < 0)
> >  		return ret;
> > @@ -1399,6 +1404,7 @@ static int iio_device_register_sysfs(struct iio_d=
ev
> *indio_dev)
> >  			attrcount_orig++;
> >  	}
> >  	attrcount =3D attrcount_orig;
> > +
>=20
> Please avoid unrelated white space changes.
>=20
> >  	/*
> >  	 * New channel registration method - relies on the fact a group does
> >  	 * not need to be initialized if its name is NULL.
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h index
> > a1be82e74c93..39209f3b62be 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -223,6 +223,7 @@ struct iio_event_spec {
> >   *			correspond to the first name that the channel is
> referred
> >   *			to by in the datasheet (e.g. IND), or the nearest
> >   *			possible compound name (e.g. IND-INC).
> > + * @label_name:		Unique name to identify which channel this is.
> >   * @modified:		Does a modifier apply to this channel. What
> these are
> >   *			depends on the channel type.  Modifier is set in
> >   *			channel2. Examples are IIO_MOD_X for axial sensors
> about
> > @@ -260,6 +261,7 @@ struct iio_chan_spec {
> >  	const struct iio_chan_spec_ext_info *ext_info;
> >  	const char		*extend_name;
> >  	const char		*datasheet_name;
> > +	const char		*label_name;
>=20
> This can't be part of chan_spec as that is constant in many drivers.
> We need a separate way of doing this.  Don't use info_mask, but register =
it
> separately for each channel in a similar way to we do the name and label
> attributes for the whole device.
>=20
If "label_name" can't be part of the "struct iio_chan_spec " why would I pa=
ss
it to the callback function? Just identify the channel?
I would implement a callback :
int (*read_string)(struct iio_dev *indio_dev,
	const struct iio_chan_spec *chan, const char *buf, long info);
and use this callback for other purposes as well, not only for "label" attr=
ibute.

> I would add a new callback to iio_info that is passed the iio_chan_spec a=
nd
> returns a const char * for the label name.
>=20
> The driver would be responsible for doing a lookup based on what it has
> cached from the dt parse, probably indexed off address or scan_index (tha=
t
> can be driver specific)
>=20
> To create the attribute you need to add this to iio_device_register_sysfs=
 and
> use the various core functions to build the attribute name in a similar f=
ashion
> to that done for info mask elements.
>=20
> It will be more complex than your approach, but make it more 'separable' =
as a
> feature in drivers.
>=20
> Jonathan
>=20
>=20
> >  	unsigned		modified:1;
> >  	unsigned		indexed:1;
> >  	unsigned		output:1;
> > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > index e6fd3645963c..c8f65f476eb2 100644
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -34,6 +34,7 @@ enum iio_available_type {
> >
> >  enum iio_chan_info_enum {
> >  	IIO_CHAN_INFO_RAW =3D 0,
> > +	IIO_CHAN_INFO_LABEL,
> >  	IIO_CHAN_INFO_PROCESSED,
> >  	IIO_CHAN_INFO_SCALE,
> >  	IIO_CHAN_INFO_OFFSET,

