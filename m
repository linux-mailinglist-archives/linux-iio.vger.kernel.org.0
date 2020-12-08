Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A5B2D2C07
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgLHNav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 08:30:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23336 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728758AbgLHNav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 08:30:51 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8DPDk6015776;
        Tue, 8 Dec 2020 08:30:08 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 3588090yy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:30:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6vgEbnXComA6yqxghNf/JkAaMCqtlOneCB+5iv3c5DLS1FcPDAzncQVIsUIV5y+byGGPkDXXcZw1QRj9DnJetUtVpNHVsv/fRh/ddjbc8GxHnKtSqSwY9lFvYT9N+IsjrHj29n1+4OiBwrtWC45W7RoH7oVJOh8cS1DmcQG2mkb4+C2kC1fPI99EsHyQTmpEZU2l8tsvuvXUiiGWLK7yM4S+hgcwNRemVvf4oyumJk1lom2QBfDChPEGV4E/N/SBYm5kVoabYAhvESHwjyN6Xy3b25RdXyduw+pWgcfXxGpqhjcS94ZUYBlnieqfslhSMiiekciH9JPcPogHR3sOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfcKdJHIzeqxWAVp+FH1DboI8uIh4p0ySI8ZOBs1rSg=;
 b=U6J4kYfvSSBvotZOWJvK3x8IvX6CBTMrG3JbjVLkNNJ+e/31UFKRFTCn42XsE/L7Rlka5b0SNKLDJIVHuF0cSzzLmXSX00TqbqvqOGoh9un8U7G5S6KzS/0zae/1m2alvOW4jReKG+En7O+2ACD9ozojOwBbNgIehPupZe1g3BVtsziChJHwqGrSkCaDDMCBV0U2uh43GBjwHcyKrJ7tAt3HNW19853SR5hcu78zyrcAuiU+UwO7YbDpai/t8T1BgJ89SF2jZ5pM3N5YfB9wh+ty1XBNZX7VFKJ2aiRK6YuAarQXN70TaNG/MsrFFIE7JMEIrJL6osoQPqI2pZNdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfcKdJHIzeqxWAVp+FH1DboI8uIh4p0ySI8ZOBs1rSg=;
 b=acjvKFLp/i6eD01C4YmBgLCefHyUFIm0ZakhkpvrfWtI0aBamTFJGx5lN2TocyzHeYjwwPIJ0ONKRHrSlqvBoHQ/Wj/SDGhAz+nbIoD22UFuYfZ0+1nDVziLGS9ebdGXZeKor1KuXB8+CQVTsRxMBPSItQLlni/BIoNJ8FYi22A=
Received: from SJ0PR03MB5423.namprd03.prod.outlook.com (2603:10b6:a03:28c::5)
 by BY5PR03MB5046.namprd03.prod.outlook.com (2603:10b6:a03:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 13:30:06 +0000
Received: from SJ0PR03MB5423.namprd03.prod.outlook.com
 ([fe80::d1fe:4dd6:52fd:e18e]) by SJ0PR03MB5423.namprd03.prod.outlook.com
 ([fe80::d1fe:4dd6:52fd:e18e%5]) with mapi id 15.20.3632.018; Tue, 8 Dec 2020
 13:30:06 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v2 2/2] iio: dac: ad5766: add driver support for AD5766
Thread-Topic: [PATCH v2 2/2] iio: dac: ad5766: add driver support for AD5766
Thread-Index: AQHWymmIJWQOnTgb20SmFXYwOD1DHanozHIAgARHP/A=
Date:   Tue, 8 Dec 2020 13:30:06 +0000
Message-ID: <SJ0PR03MB542332C028820DB869A54BAAE7CD0@SJ0PR03MB5423.namprd03.prod.outlook.com>
References: <20201204182043.86899-1-cristian.pop@analog.com>
        <20201204182043.86899-2-cristian.pop@analog.com>
 <20201205180120.70125969@archlinux>
In-Reply-To: <20201205180120.70125969@archlinux>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy1hZmJjZjMzNy0zOTQ4LTExZWItOTQ4MS0xODFkZWE1?=
 =?us-ascii?Q?NDZmZTBcYW1lLXRlc3RcYWZiY2YzMzktMzk0OC0xMWViLTk0ODEtMTgxZGVh?=
 =?us-ascii?Q?NTQ2ZmUwYm9keS50eHQiIHN6PSIxMDk0NiIgdD0iMTMyNTE5MDA1OTI0NTc3?=
 =?us-ascii?Q?NTYxIiBoPSJPdkxwQXJleHVsZ0oybS91K3QreFF1RTZWdGs9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUFa?=
 =?us-ascii?Q?VVI5eVZjM1dBY1FJOVBIUVc2Q1d4QWowOGRCYm9KWURBQUFBQUFBQUFBQUFB?=
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
x-originating-ip: [86.125.73.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4324f48-beb5-4405-e28e-08d89b7d6080
x-ms-traffictypediagnostic: BY5PR03MB5046:
x-microsoft-antispam-prvs: <BY5PR03MB5046474BA7EE09B80982F151E7CD0@BY5PR03MB5046.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Trpqg9RCOFJgE12TrkFeao1wjBM+mALJv9QyUdBEmAJYoivPfJUskw85uo5mvONO/M9MRobGNoympmY9VGEhwbHlGMtWeEsNpRducm2HclUFPI7zPqJTTwxTfVm7teQqTlYiiFrI+m/oPuN0kMN8NWBFdqYnBty6oiiaTgejttbr/KZoA/R1IonsdpGonbEykubKdTlmzuqJKIBPUTn/3/wxKI0K9UZ5/s4kMq/AB2tAlGVwlU40JUazPJpF/qtWBUZQYbTPVZZo0VP1J4Z5rXWPWn5zaQXFKY4TnwgSb5TVgbC3HgdqhekSHazrfwLVyXQXFNmdRXVjuj1ZrsONeS0L6+PxaU8ZHkmYu6SSBDSEAndzMIDognvV+OKWlSku2cyqdgXcVlvXzLy4Ufnr2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(66446008)(71200400001)(76116006)(7696005)(186003)(2906002)(5660300002)(53546011)(4326008)(83380400001)(55016002)(54906003)(316002)(478600001)(8936002)(33656002)(6506007)(26005)(64756008)(66476007)(966005)(9686003)(66946007)(66556008)(86362001)(6916009)(52536014)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dxyS1dH1YUETlB0Bil+MHv2o9hi1G4Ph6bwUCGayqLknHcU7a+TPnCt8+mDI?=
 =?us-ascii?Q?ysMII2XpSRrmI75ZHw/NjC4fRmnGW0bk6aJw4E/jy2kv10CmuhBZver6rE81?=
 =?us-ascii?Q?nFw7E+WxAXbTnKkfyniJvtPdNfSW47tDcNNSktGBscTZ1i7iWodsURAs+PiG?=
 =?us-ascii?Q?1IJml/YLbHrJgdxF1UMWcS8lydabxO83LTh5GF3buA63V6s/h90epCSog2FU?=
 =?us-ascii?Q?zvb6me3nO5HsGZcYzFQTLoMXseVQ7supPvlwsCKVciIZW1vu+iDhAUZB2yQw?=
 =?us-ascii?Q?Ad0tZjtRqQrPzGe6tUw/+WflDNtGhwJotqrkuTkrci0RYoPos14GjQXvSU24?=
 =?us-ascii?Q?Tf9P2dWkaDIBTXNMITxrLuopGfR2X+fjtlNzjzq8vH2Hqp3NJNijZPDfxQeW?=
 =?us-ascii?Q?k5hteMC0QaaneL9iVcvedFvs2uylt4I4snOTShVnDspt5OfPCMksbkvqMlh7?=
 =?us-ascii?Q?x6ijB1D1kgj2TAevdDfTbXhsFeK3PDTLZeddU8LbBC+7M6vUMYafBnBmFWrI?=
 =?us-ascii?Q?4GZ+q+D6JaKYXiWfF8v6NdWDMf2rQV/Io8BDPS7vmO7gAwYJ2jqjjU2jy48D?=
 =?us-ascii?Q?m/q0kHiMEQ7xWPF4rHur8tOB6/7eIUXjnkZsbXJApzMRuB7Zcl4QqyOsilLi?=
 =?us-ascii?Q?tYOEdm28ryJAhyCGVmOgJKliXezMYcuuXvdefFwF2TL7QZzKilvH5qC2bEhH?=
 =?us-ascii?Q?SlHR5HDbp9Rhli2030Q3fWFgq9C1ONGTTuaOutL4NzcCAJcz1sne5APmH3hZ?=
 =?us-ascii?Q?kSoU7gyy3Pjb8uic/4Aaomnv+VHEKM9BQZzpd0+yesfZHnvvCK0mDGuRsrg2?=
 =?us-ascii?Q?PyIUdeF1ppj5s5zb7lOHhb7h8VKgW6ka+WrIL3jE80SkCgyYdD7JwibEXztL?=
 =?us-ascii?Q?wg83AeCwSYIz9qx7YAqWJ9Sm1hH4NGQuta/DEmxfR2qIzX0egxw9vCGLIJYa?=
 =?us-ascii?Q?ypBtAsJTHd28wll5YYvkiXeOP19RSZVhALLwBhyxiDM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4324f48-beb5-4405-e28e-08d89b7d6080
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 13:30:06.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7aWpXixDhKfMD6OqVljBuVjeTuOQmMs0bjGizRc0iDVWP8hTVy0dIHzi+xm8pcKYfvz0vcLAvlSm9zEgqZrfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5046
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080083
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, December 5, 2020 8:01 PM
> To: Pop, Cristian <Cristian.Pop@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: Re: [PATCH v2 2/2] iio: dac: ad5766: add driver support for AD57=
66
>=20
> [External]
>=20
> On Fri, 4 Dec 2020 20:20:43 +0200
> Cristian Pop <cristian.pop@analog.com> wrote:
>=20
> > The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense
> > DACs Digital-to-Analog converters.
> >
> > This change adds support for these DACs.
> >
> > Link:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ad
> > 5766-5767.pdf
> >
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
>=20
> Missing build files + docs for the new ABI.
> Note it doesn't build so a few things to fix on that front!
>=20
> Docs in appropriate file under Documentation/ABI/testing/sysfs-bus-iio-*
>=20
> I'm a bit curious about the range being entirely controllable from usersp=
ace
> as well. Seems like something that might be dangerous in some systems.
> Perhaps we need some sort of dt binding restriction mechanism?
If you think it is better to restrict the user to a range that is set in de=
vice tree,
please let me know. In some cases it is possible to have an extended range =
maybe,
or a combination of multiple ranges.
>=20
>=20
> > ---
> >  Changes in v2:
> > 	-Remove forward declarations, arrange code
> > 	-New ABI docs
> > 	-Move "max_val" scope in case
> > 	-Remove blank line
> > 	-Use bitfield operations, where posible
> > 	-Change declaration type to int of:
> > 		int
> 	scale_avail[AD5766_VOLTAGE_RANGE_MAX][2];
> > 		int
> 	offset_avail[AD5766_VOLTAGE_RANGE_MAX][2];
> > 	-Move initialization down to just above where it is used:
> > 		"type =3D spi_get_device_id(spi)->driver_data;"
> >
> >  drivers/iio/dac/ad5766.c | 758
> > +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 758 insertions(+)
> >  create mode 100644 drivers/iio/dac/ad5766.c
> >
> > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c new
> > file mode 100644 index 000000000000..e6d24a41bd4e
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad5766.c
> > @@ -0,0 +1,758 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD5766, AD5767
> > + * Digital to Analog Converters driver
> > + *
> > + * Copyright 2019-2020 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/bitfield.h>
> > +
> > +#define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
> > +#define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
> > +#define AD5766_DITHER_SOURCE_MASK(x)		GENMASK(((2 * x) +
> 1), (2 * x))
> > +#define AD5766_DITHER_SCALE_MASK(x)
> 	AD5766_DITHER_SOURCE_MASK(x)
> > +
> > +#define AD5766_CMD_NOP_MUX_OUT			0x00
> > +#define AD5766_CMD_SDO_CNTRL			0x01
> > +#define AD5766_CMD_WR_IN_REG(x)			(0x10 | ((x)
> & 0xF))
> > +#define AD5766_CMD_WR_DAC_REG(x)		(0x20 | ((x) & 0xF))
> > +#define AD5766_CMD_SW_LDAC			0x30
> > +#define AD5766_CMD_SPAN_REG			0x40
> > +#define AD5766_CMD_WR_PWR_DITHER		0x51
> > +#define AD5766_CMD_WR_DAC_REG_ALL		0x60
> > +#define AD5766_CMD_SW_FULL_RESET		0x70
> > +#define AD5766_CMD_READBACK_REG(x)		(0x80 | ((x) & 0xF))
> > +#define AD5766_CMD_DITHER_SIG_1			0x90
> > +#define AD5766_CMD_DITHER_SIG_2			0xA0
> > +#define AD5766_CMD_INV_DITHER			0xB0
> > +#define AD5766_CMD_DITHER_SCALE_1		0xC0
> > +#define AD5766_CMD_DITHER_SCALE_2		0xD0
> > +
> > +#define AD5766_FULL_RESET_CODE			0x1234
> > +
> > +enum ad5766_type {
> > +	ID_AD5766,
> > +	ID_AD5767,
> > +};
> > +
> > +enum ad5766_voltage_range {
> > +	AD5766_VOLTAGE_RANGE_M20V_0V,
> > +	AD5766_VOLTAGE_RANGE_M16V_to_0V,
> > +	AD5766_VOLTAGE_RANGE_M10V_to_0V,
> > +	AD5766_VOLTAGE_RANGE_M12V_to_14V,
> > +	AD5766_VOLTAGE_RANGE_M16V_to_10V,
> > +	AD5766_VOLTAGE_RANGE_M10V_to_6V,
> > +	AD5766_VOLTAGE_RANGE_M5V_to_5V,
> > +	AD5766_VOLTAGE_RANGE_M10V_to_10V,
> > +	AD5766_VOLTAGE_RANGE_MAX,
> > +};
> > +
> > +/**
> > + * struct ad5766_chip_info - chip specific information
> > + * @num_channels:	number of channels
> > + * @channel:	        channel specification
> > + */
> > +struct ad5766_chip_info {
> > +	unsigned int			num_channels;
> > +	const struct iio_chan_spec	*channels;
> > +};
> > +
> > +enum {
> > +	AD5766_DITHER_PWR,
> > +	AD5766_DITHER_INVERT
> > +};
> > +
> > +/*
> > + * External dither signal can be composed with the DAC output, if
> activated.
> > + * The dither signals are applied to the N0 and N1 input pins.
> > + * Dither source for each of the channel can be selected by writing
> > +to
> > + * "dither_source",a 32 bit variable and two bits are used for each
> > +of the 16
> > + * channels: 0: NO_DITHER, 1: N0, 2: N1.
> > + * This variable holds available dither source strings.
> > + */
> > +static const char * const ad5766_dither_sources[] =3D {
> > +	"NO_DITHER",
> > +	"N0",
> > +	"N1",
> > +};
> > +
> > +/*
> > + * Dither signal can also be scaled.
> > + * Available dither scale strings coresponding to "dither_scale"
> > +field in
> > + * "struct ad5766_state".
> > + * "dither_scale" is a 32 bit variable and two bits are used for each
> > +of the 16
> > + * channels: 0: NO_SCALING, 1: 75%_SCALING, 2: 50%_SCALING, 3:
> 25%_SCALING.
>=20
> Needs explicit ABI docs for a proper discussion.  My gut feeling is it sh=
ould
> be two controls. On/off + a scaling control that takes integer values.
There is a dither on/off, we can also add an on/off control for scale and s=
ource
If requested.
>=20
> > + */
> > +static const char * const ad5766_dither_scales[] =3D {
> > +	"NO_SCALING",
> > +	"75%_SCALING",
> > +	"50%_SCALING",
> > +	"25%_SCALING",
> > +};
> > +
> > +/**
> > + * struct ad5766_state - driver instance specific data
> > + * @spi:		SPI device
> > + * @lock:		Mutex lock
>=20
> Say what exactly the scope of the lock is.  No interest at all to tell us=
 what is
> clear from the type of the structure element.
>=20
> > + * @chip_info:		Chip model specific constants
> > + * @gpio_reset:		Reset GPIO, used to reset the device
> > + * @crt_range:		Current selected output range
> > + * @cached_offset:	Cached range coresponding to the selected offset
> > + * @dither_power_ctrl:	Power-down bit for each channel dither
> block (for
> > + *			example, D15 =3D DAC 15,D8 =3D DAC 8, and D0 =3D DAC 0)
> > + *			0 - Normal operation, 1 - Power down
> > + * @dither_invert:	Inverts the dither signal applied to the selected D=
AC
> > + *			outputs
> > + * @dither_source:	Selects between 3 possible sources:
> > + *			0: No dither, 1: N0, 2: N1
> > + *			Two bits are used for each channel
> > + * @dither_scale:	Selects between 4 possible scales:
> > + *			0: No scale, 1: 75%, 2: 50%, 3: 25%
> > + *			Two bits are used for each channel
> > + * @scale_avail:	Scale available table
> > + * @offset_avail:	Offest available table
> > + * @data:		SPI transfer buffers
> > + */
> > +struct ad5766_state {
> > +	struct spi_device		*spi;
> > +	struct mutex			lock;
> > +	const struct ad5766_chip_info	*chip_info;
> > +	struct gpio_desc		*gpio_reset;
> > +	enum ad5766_voltage_range	crt_range;
> > +	enum ad5766_voltage_range	cached_offset;
> > +	u16		dither_power_ctrl;
> > +	u16		dither_invert;
> > +	u32		dither_source;
> > +	u32		dither_scale;
> > +	int		scale_avail[AD5766_VOLTAGE_RANGE_MAX][2];
> > +	int		offset_avail[AD5766_VOLTAGE_RANGE_MAX][2];
> > +	union {
> > +		u32	d32;
> > +		u16	w16[2];
> > +		u8	b8[4];
> > +	} data[3] ____cacheline_aligned;
> > +};
> > +
> ...
> > +
> > +static int _ad5766_spi_read(struct ad5766_state *st, u8 dac, int
> > +*val) {
> > +	int ret;
> > +	struct spi_transfer xfers[] =3D {
> > +		{
> > +			.tx_buf =3D &st->data[0].d32,
> > +			.bits_per_word =3D 8,
> > +			.len =3D 3,
> > +			.cs_change =3D 1,
> > +		}, {
> > +			.tx_buf =3D &st->data[1].d32,
> > +			.rx_buf =3D &st->data[2].d32,
> > +			.bits_per_word =3D 8,
> > +			.len =3D 3,
> > +		},
> > +	};
> > +
> > +	st->data[0].d32 =3D AD5766_CMD_READBACK_REG(dac);
> > +	st->data[1].d32 =3D AD5766_CMD_NOP_MUX_OUT;
> > +
> > +	ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val =3D st->data[2].w16[1];
> > +
> > +	return ret;
> > +}
> > +
> > +static int _ad5766_spi_write(struct ad5766_state *st, u8 command, u16
> > +data) {
> > +	st->data[0].b8[0] =3D command;
> > +	st->data[0].b8[1] =3D (data & 0xFF00) >> 8;
> > +	st->data[0].b8[2] =3D (data & 0x00FF) >> 0;
>=20
> That's an unaligned put so ideally use put_unaligned_xx16 and friends to
> make that clear.
>=20
> > +
> > +	return spi_write(st->spi, &st->data[0].b8[0], 3); }
> > +
> > +static int ad5766_read(struct iio_dev *indio_dev, u8 dac, int *val) {
> > +	struct ad5766_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +	ret =3D _ad5766_spi_read(st, dac, val);
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ad5766_write(struct iio_dev *indio_dev, u8 dac, u16 data)
> > +{
> > +	struct ad5766_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +	ret =3D _ad5766_spi_write(st, AD5766_CMD_WR_DAC_REG(dac),
> data);
>=20
> Normal convention for this sort of function would be __ rather than _ Loo=
ks
> more deliberate.
>=20
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
>=20
> ...
>=20
> > +
> > +#define _AD5766_CHAN_EXT_INFO(_name, _what, _shared) { \
> > +	.name =3D _name, \
> > +	.read =3D ad5766_read_ext, \
> > +	.write =3D ad5766_write_ext, \
> > +	.private =3D _what, \
> > +	.shared =3D _shared, \
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info ad5766_ext_info[] =3D {
> > +
> > +	_AD5766_CHAN_EXT_INFO("dither_pwr", AD5766_DITHER_PWR,
> IIO_SEPARATE),
> > +	_AD5766_CHAN_EXT_INFO("dither_invert",
> AD5766_DITHER_INVERT,
> > +			      IIO_SEPARATE),
> > +	IIO_ENUM("dither_source", IIO_SEPARATE,
> &ad5766_dither_source_enum),
> > +	IIO_ENUM_AVAILABLE_SHARED("dither_source",
> > +				  IIO_SEPARATE,
> > +				  &ad5766_dither_source_enum),
> > +	IIO_ENUM("dither_scale", IIO_SEPARATE,
> &ad5766_dither_scale_enum),
> > +	IIO_ENUM_AVAILABLE_SHARED("dither_scale",
>=20
> That macro doesn't exist in mainline.
>=20
> > +				  IIO_SEPARATE,
> > +				  &ad5766_dither_scale_enum),
> > +	{}
> > +};
>=20
> All the above need ABI docs so we can talk about them without having to
> read data sheets.
>=20
> ...
