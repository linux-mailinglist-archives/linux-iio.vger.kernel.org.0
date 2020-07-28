Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA472302BC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 08:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG1GYJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 02:24:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13514 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726916AbgG1GYJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 02:24:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S69mbO006221;
        Tue, 28 Jul 2020 02:24:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 32gek68y9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 02:24:07 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06S6O6uv004276;
        Tue, 28 Jul 2020 02:24:06 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 32gek68y9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 02:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcXFwvMpLZSJlc6YXYzryJzPL/zXETFVG4pLhW07DnG6pvZttbJPUzUSs9ICyqyMbrajwEUKfkuz3CDNUBM8GR77tyBvE3Hf/7Rf0yySQ3SUPzowjrT/D/CPqbqq/kCWLerxZ/BRzSzeuV6h4q0EWYbV5yAHnV/0KOHKYr+F7s4S4UUqTR0LBA/ODvr/5+LySWh+SBm8PmaeHtQWFFVGruaEsEXYzWjbKOxplc3TssluHp8QIsyNSNd19MMDeTepuEJ3v3m6bOrivdnhrcPp8uRiVE7TuuYW7Jry0eiXsZ785v7UsvEgQ6AlS1kbjAwn8vjU9TOelhl2wpTSw70WUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2f1PHgQWAmsFceyjARChojjV5XK4YySy6uk7FowzS4=;
 b=KCs2CN3ADlHffAJ1W14lvPqKInm+d+Ia+9CTHqoDkP9/V3grLlU2a2a7cVX0Ls9Z+Qq37cWzxRsp/InemFUC+i4XSUbdyTY9g3qZl4XR+5sXslSMAVcXuKTZedYgoG+pBadGXsvSXmHKioxMAHgMQdYNSAvEjvsTShaEyc9zfMLf3eZwwxXkkzgC6SWKy06jzPLybcwZ/iQBVNUP1XI5MXVv0GYAXtEd37XmIqW7x2kR93mpEzdn1tgcfTpANIcKXzr2T3ApszGpNP74KeBYSOmTW58B9eBkSEhkCGFM0VcUjHupdXpffdE956zm+FW3bBNKoaTUxTQUyUZ3pgLGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2f1PHgQWAmsFceyjARChojjV5XK4YySy6uk7FowzS4=;
 b=315mc2zXwH+SwoLTE43HaVMTzuhQ2PhcNR3ZoC8/pSvGtLZjw/G/FGX1e1c1/RrKM8JxCL3EOHeDznbhDaKNBulXeTA8WHJTgbvNEHWYIyDNdBthTTHKJInDX+288M2H7hMIOrXQcIhlGtgHIRBstTyeH9SEhbM0mvRhtjZgRns=
Received: from MWHPR03MB3199.namprd03.prod.outlook.com (2603:10b6:301:3f::29)
 by CO2PR03MB2408.namprd03.prod.outlook.com (2603:10b6:102:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 06:24:04 +0000
Received: from MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::41d5:c2a2:5c61:404b]) by MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::41d5:c2a2:5c61:404b%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:24:04 +0000
From:   "Berghe, Darius" <Darius.Berghe@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
Thread-Topic: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
Thread-Index: AQHWZDshD2fRVBN5G0WOOeGeLwbtg6kchCgQ
Date:   Tue, 28 Jul 2020 06:24:03 +0000
Message-ID: <MWHPR03MB319956D095B2715835D0BF1A96730@MWHPR03MB3199.namprd03.prod.outlook.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
        <20200727135834.84093-3-darius.berghe@analog.com>
 <20200727182647.00002e3c@huawei.com>
In-Reply-To: <20200727182647.00002e3c@huawei.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGJlcmdoZVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWVjNzc1OWFjLWQwOWEtMTFlYS04OGFkLTg0ZmRk?=
 =?us-ascii?Q?MWVmNmRmMVxhbWUtdGVzdFxlYzc3NTlhZS1kMDlhLTExZWEtODhhZC04NGZk?=
 =?us-ascii?Q?ZDFlZjZkZjFib2R5LnR4dCIgc3o9IjM5MTciIHQ9IjEzMjQwMzkxMDQwOTE2?=
 =?us-ascii?Q?MzQ3NSIgaD0iOUxuMzNCWmZ0RjgyNkNUbDg5Yy93MDhibDRjPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFE?=
 =?us-ascii?Q?VGtzK3VwMlRXQWM4Mi93MVNZbGRIenpiL0RWSmlWMGNEQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFYWFBvblFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFR?=
 =?us-ascii?Q?QmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4?=
 =?us-ascii?Q?QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFC?=
 =?us-ascii?Q?eUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0?=
 =?us-ascii?Q?YT4=3D?=
x-dg-rorf: true
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [79.117.36.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71867caf-b787-41e5-454c-08d832bed328
x-ms-traffictypediagnostic: CO2PR03MB2408:
x-microsoft-antispam-prvs: <CO2PR03MB240819264CBB5B35BD5E3A8696730@CO2PR03MB2408.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdnrSTmbtsjBoKby970N0y1jEzTUi5J1suZY9+/NXqa331LkEXYOWWYfkeWgRcuevjAzXWSr+9uiCLJZ68QDeVlSLrUHIYdnbLZ/5MKKdc35pxpAFtdafrEz6f0a+E0+mCUmsyt62NSRIRPhWe+NXUh5IcaxXr6XK6NYOUwRQoldwUJZ/GKGYPjIKc6Xh6PnH4ncADSLgkk2y/R7s1nC8IykyE/Mm7UpB3s1jsao3v5xC77bwzrmgiuAG+BE2rufuKScVowAjQYqvhB4WIxzUw1urrcmczsQJBMvQIInbJuFuDSLNRcK9b65htXFBxgRryno9PI7Dm+v+gIHQA/H6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR03MB3199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(39860400002)(376002)(396003)(136003)(52536014)(6506007)(53546011)(33656002)(86362001)(7696005)(316002)(6916009)(26005)(54906003)(5660300002)(478600001)(186003)(66946007)(76116006)(66476007)(66556008)(71200400001)(2906002)(8936002)(9686003)(4326008)(8676002)(55016002)(83380400001)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nfauC94DQ6yF6+Z7XxazLwY+FvP4w9hBsw+DAhbeuPJ9hNxlYBfu7724LXp7i+/WLmlQT3ck45Nr0o9glc8Ue3NjSzL4vfdtNyInm2HyV9Uje4lpR0FsYq2TKCZQ0Cf9/nOniy/Fdu3w3d8Km+y8H5Jz7/yr7Roj66dJtrTVb9jiv0eyt/Zdnxemx2xEy91NyO3YgShZpAHa7COAvn44eNtgddtIb+/yLFysnaNjEtoNFEDtxGlLvpcE1St+DQDtSTc/mzlqKWfCTD6KB8lEb+7kaK+nl0tQdnw3qEGzJSv7t6hOfWqLBouWN/ngWA4w/Y4bazErLuxJ4ekjnVfacUYALnj71IJDHfYfjEoTIxFbrWnudaEcr2aVPjDzuC6ycFSe9ZVLbuQziefczRiFpxFWZAwoa4GSfmdeyzUyrtmSlUlhdJwTmy4zOlXsjwNn/unN9PaeQTBzlq3SGFd+e8XGhIEUaSCEcZgxk113mWY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR03MB3199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71867caf-b787-41e5-454c-08d832bed328
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 06:24:03.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISDopW09cNj80PsFyMTo6dmsAdoys94p5Ii69PvCxvnuLqcvI2IOCLGn36wz6CwYlu8zy+CrjqB9/zYiaNjLttxx5ko5sHqIUDFkOPVVM28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_01:2020-07-27,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280048
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for review, comments inline.

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Sent: Monday, July 27, 2020 8:27 PM
> To: Berghe, Darius <Darius.Berghe@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; jic23@kernel.org; robh@kernel.org
> Subject: Re: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
>=20
> [External]
>=20
> On Mon, 27 Jul 2020 16:58:33 +0300
> Darius Berghe <darius.berghe@analog.com> wrote:
>=20
> > Add compatible strings for these devices in the existing ltc2471
> > driver.
> >
> > Signed-off-by: Darius Berghe <darius.berghe@analog.com>
>=20
> Hi Darius,
>=20
> A few additional minor comments from me.
>=20
> > ---
> >  drivers/iio/adc/ltc2471.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> > index e1c4e966524d..8c57203b1fe4 100644
> > --- a/drivers/iio/adc/ltc2471.c
> > +++ b/drivers/iio/adc/ltc2471.c
> > @@ -1,5 +1,7 @@
> >  /*
> > - * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
> > + * Driver for Linear Technology LTC2461, LTC2463, LTC2471 and LTC2473
> > + voltage
> > + * monitors.
> > + * The LTC2463 is identical to the 2461, but reports a differential si=
gnal.
> >   * The LTC2473 is identical to the 2471, but reports a differential si=
gnal.
> >   *
> >   * Copyright (C) 2017 Topic Embedded Products @@ -17,8 +19,10 @@
> > #include <linux/mod_devicetable.h>
> >
> >  enum ltc2471_chips {
> > +	ltc2461,
> > +	ltc2463,
> >  	ltc2471,
> > -	ltc2473,
> > +	ltc2473
>=20
> Why drop the comma?  We've just added two new devices. Seems possible
> there may be more in the future!
>=20

Ok, will leave it there in v4.

> >  };
> >
> >  struct ltc2471_data {
> > @@ -122,7 +126,7 @@ static int ltc2471_i2c_probe(struct i2c_client
> *client,
> >  	indio_dev->name =3D id->name;
> >  	indio_dev->info =3D &ltc2471_info;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -	if (id->driver_data =3D=3D ltc2473)
> > +	if (id->driver_data =3D=3D ltc2473 || id->driver_data =3D=3D ltc2463)
> If the only use of driver_data is going to be this check, then just set i=
t to 2473
> for the 2463 and 2473.  It's not uncommon to do this when we have a bunch
> of devices that look the same to software.

Yes the chips are similar but there is at least one feature which requires =
this level=20
of distinguishing them: the sampling rate (60sps for ltc2461/3 and selectab=
le 208/833sps=20
for ltc2471/3). It's not used anywhere for now but I can see it being imple=
mented
as standard IIO dev attribute sampling frequency.

>=20
> >  		indio_dev->channels =3D ltc2473_channel;
> >  	else
> >  		indio_dev->channels =3D ltc2471_channel; @@ -139,6 +143,8
> @@ static
> > int ltc2471_i2c_probe(struct i2c_client *client,  }
> >
> >  static const struct i2c_device_id ltc2471_i2c_id[] =3D {
> > +	{ "ltc2461", ltc2461 },
> > +	{ "ltc2463", ltc2463 },
> >  	{ "ltc2471", ltc2471 },
> >  	{ "ltc2473", ltc2473 },
> >  	{}
> > @@ -146,6 +152,8 @@ static const struct i2c_device_id ltc2471_i2c_id[]
> > =3D {  MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
> >
> >  static const struct of_device_id ltc2471_of_match[] =3D {
> > +	{ .compatible =3D "adi,ltc2461" },
> > +	{ .compatible =3D "adi,ltc2463" },
> >  	{ .compatible =3D "adi,ltc2471" },
> >  	{ .compatible =3D "adi,ltc2473" },
> >  	{}
> > @@ -163,6 +171,6 @@ static struct i2c_driver ltc2471_i2c_driver =3D {
> >
> >  module_i2c_driver(ltc2471_i2c_driver);
> >
> > -MODULE_DESCRIPTION("LTC2471/LTC2473 ADC driver");
> > +MODULE_DESCRIPTION("LTC2461/LTC2463/LTC2471/LTC2473 ADC
> driver");
> >  MODULE_AUTHOR("Topic Embedded Products");  MODULE_LICENSE("GPL
> v2");

