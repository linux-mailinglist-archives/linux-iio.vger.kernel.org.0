Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE45663A1B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jan 2023 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjAJHo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Jan 2023 02:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAJHo0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2023 02:44:26 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219B18E01
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 23:44:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyGbaY1vafc0D+vsP1FahnJWKMRVqnlRgXZhO+4ktC4R9WG5PpahnBR1g1rZbdrEBHa0w6YdHF1qZEmF5GC5EDsGuxcq07XgEt1MPyPQfwsWq67GOp41S2aZCRVFHJLENbME1QFSTHww1Xya9nyZtxcDshi32Qa3foN10fsroCaWBmsY03BonQ3rdEkbV62nOccBcKs8jo3QWRsTuHTmA6qCz7a6kfZOy3wZYqEoEt9ARFhYz9IYrg7Dy7WXVUV7q6DDvIZskynvRpUb85XN/hPMtLmNRdsgPKM7UYvvBZ68eua6W08rATdkE9G73dCgZQ+LTNOlzqyGNJRQ5CuF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EagIQ1OKb2twny5D1DzZtN9nyo4mTZvbvMMdfNLQntg=;
 b=MaQoh0R+gQYyMe8b2GoZy+kQrQh8JzYKtKmHSAevBy9EYW73yLScKCBLat4BYYdGF12duHyUOcIdlZA59QO0ffzB44XGEUNKBw0OgksRbDtR83lIn1uyI1yq8rBcCGdyReCxwzzUMpdn0C8tstKS/RX6zrs52XJoU/fNb/fNtoDA8QQwHxNNbSY3JnL1rVHN1XwjR/PmFnBY/0otlr6UL/vQ73impbWu0Po+RlxEYomlJg8Pz3KbIdc7tBjXpiYXxYITzj+0LnG9QPVV88BsUeo3/+GGW1Uo3+cPxSaF8NcyXu4kqFYPFiCiS0JyAgM0cWnvSsRB5Z+s4bsqP6KB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EagIQ1OKb2twny5D1DzZtN9nyo4mTZvbvMMdfNLQntg=;
 b=BHSx9FWOj71AFywuECRkuCjkEAime+Os8oB9oy+wgZwX8nWKhfXx6F3sYILesBv+kMv1ilrYGil5C1iD6+4bKaT8JAHgkWmMZ/FqCuswa/oLQeOw4gO1ZPQoxaw3aIwbUrsyCDkx1Cof8RMd6x31rpMrRhdZ9wxO2i3K2XiH1OQ=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 07:44:20 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 07:44:20 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        Bough Chen <haibo.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR
 mode readback
Thread-Topic: [EXT] Re: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR
 mode readback
Thread-Index: AQHZGqA7SVE9ACZjrkeZoZgfy+xfka6IGWmAgA7xvrA=
Date:   Tue, 10 Jan 2023 07:44:20 +0000
Message-ID: <VI1PR04MB500569F6060A544F87899C5BE8FF9@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
        <20221228093941.270046-2-carlos.song@nxp.com>
 <20221231145115.7d9414e5@jic23-huawei>
In-Reply-To: <20221231145115.7d9414e5@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|DU2PR04MB8581:EE_
x-ms-office365-filtering-correlation-id: 84010bc0-1c97-471f-c22b-08daf2de7c29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jVdtfnBWfLexWJqTehRz/7IloEAnHwvwxhEOCWMy8Zo8cGC496QnsReStw4ZF6FeJRnANOIGdHdYaitLDLUo4WasZCjHEyyP6GgGWiAPB5t4H/nL/iDE1efSsVSMrSF/RANnc3KSLVS72XY5U5h6OOeiPnZZOEYtYVI1RjPPK8DQQgLGq4hFfx+D9ge6y5L+zYFiocFrHuTuLYoj29p9AfdSgk0J7TVeu2OVq9tgoJmyigkK/rav5m+ALk5ashBcbWciN2mPbr+TldKASHsYcSDi/ZCvXKk5yUfvzvXtdLU2rq52i99hGmDP0M737P+ObgOIO4fpc43MeukNRWyBCD0pKBxnZURvrAAaUti99QVMdUIVbw9U2DU0yBYyqr+dRPDHMP7D63KSoRVTFNMS3IEIqh1znoJdrAhCgqu+LweKWpptKK+l/RjtdvONrQjKb2q51w+mTLltFdDyGneOqQNduLUYcqGOJDIjA9ff8ohQJYGSunz8ZpblTc4dlQsjoapCP0zdtg0oRA+UbTkKRxK1/46X/W8wY9ARYKXlMyyMIKFBa2HeXj9o9sW5AjtEsD4oqzlfOYltz27ciJ/ma0dWHE8oFVK129nrIkqJgZNpQHJK45goHWgI8IGecXp2b3IH+vD7t0oLSN60WZKwtm1+wOC+ydw/Z3WilovuW+pYvQKrHd6s4ITLJchKsJToN60a7wZHsFiCayfHKIM/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(6506007)(33656002)(478600001)(53546011)(4326008)(26005)(186003)(55016003)(9686003)(64756008)(66446008)(76116006)(66556008)(8676002)(66476007)(6916009)(71200400001)(54906003)(316002)(7696005)(86362001)(122000001)(38070700005)(38100700002)(83380400001)(41300700001)(52536014)(66946007)(5660300002)(2906002)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?up7Cog5cULCtMwxnNAf0I/MmO3yzoY6P/sBMixmHfY4ouylVDqfGzA3iZTwr?=
 =?us-ascii?Q?sYcu5hS/l93ykFc2ycrWSK5RS57UHLpijDNEoOMtE4bRP8PJ+aqupW9zqYua?=
 =?us-ascii?Q?Vmy80DECDOPYvyKBwZ6tXgN7Qh4a+8i824MHA5jP/6wQq/fj0oAT4tK01nVo?=
 =?us-ascii?Q?TH0+VAcVkUtAVCC1J6DRk+AhHWZqO8NbpaurRP8C8BgHm6QzCkv5qVYT5XpC?=
 =?us-ascii?Q?Sxhix2UemOdlhy8AvgUN591Z2Fy99bKIo5FzpNXqM55ANULqmEbyXzzBqnUD?=
 =?us-ascii?Q?Bu0j36kqsLVB/2aEPDBYtI/y1XG3+fo6/VNBzD0Fo7MPSo0/dh/ZrZs4vKqQ?=
 =?us-ascii?Q?JbpV/LHlY9go3hW24brd6oJVR3v7KUxF5SPStQDzcLxvEJYM2S8vDG0Cmqxy?=
 =?us-ascii?Q?PvNqoTsCRajM/Q2t4UX/5KEkJ/JgmSdmxw68EwcPuAktau5TCkZtbQU1jNux?=
 =?us-ascii?Q?CHjj/RY/YVgomTC8OfjR6qTABV4XtQoIMlob9QZY5CPcpvklotwdkK3cMLC+?=
 =?us-ascii?Q?mWkGEODIMpzNpJ7AWnLhAcjZmPpdKbP2hOj7N0TozDU0QpNF5UlVP16Nx9hO?=
 =?us-ascii?Q?aDKztGWfn0iTjeThuWmP9V1m2w3wNie7b8khN6NkPA3slfyBNJOxSR425yA1?=
 =?us-ascii?Q?FaFkscftPkqnGSgYWrjktoNwlt1dhdP1tB9GlaQejziEltzAoxuOek8ciR/6?=
 =?us-ascii?Q?LCpeaeircC7JHSEdrtV9P0c/e3LlKAN4lKB+NtiOHTMAGFprF+Nnp0ZbFJoB?=
 =?us-ascii?Q?gO4y5HXWFCn4Zllxl/s+tWP7l3uVcfObKWQWJWJCiO/FCLqckKIKrM2sTHuP?=
 =?us-ascii?Q?ST75GMJ1U7Hii8cGF518JsbTLoVxII52ZiynIWzXMQm9mNUMBvXY9pIF2YJJ?=
 =?us-ascii?Q?IK6hsq2+qWMHkJaw8beIjTGuHPof4TYpHe6Rsn9FIMxh2nYhynSZmyL4LyLe?=
 =?us-ascii?Q?DEsRVGwpqJ5wN41IkBkMi5CPoYsl1s/fI6GThrUkJqOADBCN20OJVJTlQPCy?=
 =?us-ascii?Q?OUEp3wEfg8BzV3KpB3wXhjIp57UR9TqCzBn55P1mpAphYKcDsBSecv8shaJ4?=
 =?us-ascii?Q?1G97BNct1hEbVXIKuid5WpuQPj8HIk6HxRfdc47oDx4Z04TGwUfYBqcM8ECL?=
 =?us-ascii?Q?oW9zhDhE4b7wT9Qe0JrltZ4n/1AInGQ7z+D48H09zDK/7DixwBwQSUD8dJAs?=
 =?us-ascii?Q?BO18mown9TdnGxPCxb3yQ8ZLk/Sl099nHGBTqbh0r4jXa9bWosBkZkdzUIXl?=
 =?us-ascii?Q?wMyqu9Qindcv/Utk6tTeFjTtrAMhMcWLq7GxWWVud5+u+w9+CGHQEWosiZFb?=
 =?us-ascii?Q?Q+vE2lhAAraPvd+62gHFO4qlE/QmHWYeUfrjckm6xUXu4neCM5GqZOmIlsH2?=
 =?us-ascii?Q?20RDbHQYt4YDnOhJLdQ5JAczIDV4a2azc2iagHmwWasnxr8Z2qkoH0F8u+wq?=
 =?us-ascii?Q?k10JO8Fk4u5vAX498JjJ4eI0oZV19qMWmfiCtj5YT/gqJzaCwcAQqKur3n3l?=
 =?us-ascii?Q?RrE/d3/joPT9CMvzhQzuMWeKLkf89nVLRbN/msnl1L41U3fJuLZ0T6OZTuMO?=
 =?us-ascii?Q?vYKY4spx6N4ypD8m/wRPYEC0dtO/2XN51OlekFqu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84010bc0-1c97-471f-c22b-08daf2de7c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 07:44:20.5494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAeie2ntxCkhOHdF9C8LS2KKGkTnUTmRNzOKdYFp3FMka6aCehgwLIvHRoYwwa7D3d0d8h8xs/Z6cJXIrcindg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, Jonathan. I have some doubts about how to use regmap_write() and regmap=
_updata_bits() appropriately
and faced difficult decisions. I propose different modifications as follows=
 and I would like to get some suggestions
from you. Thanks!

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, December 31, 2022 10:51 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: lars@metafoo.de; rjones@gateworks.com;
> Jonathan.Cameron@huawei.com; Bough Chen <haibo.chen@nxp.com>;
> dl-linux-imx <linux-imx@nxp.com>; linux-iio@vger.kernel.org
> Subject: [EXT] Re: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR m=
ode
> readback
>=20
> Caution: EXT Email
>=20
> On Wed, 28 Dec 2022 17:39:38 +0800
> carlos.song@nxp.com wrote:
>=20
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > The absence of a correct offset leads an incorrect ODR mode readback
> > after use a hexadecimal number to mark the value from
> > FXOS8700_CTRL_REG1.
> >
> > Get ODR mode by field mask and FIELD_GET clearly and conveniently.
> > And attach other additional fix for keeping the original code logic
> > and a good readability.
> >
> > Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Hi Carlos,
>=20
> I'm fairly sure the new code doesn't quite work correctly. See inline.
>=20
> Jonathan
>=20
> > ---
> > Changes for V4:
> > - Use ODR_MSK in the first place that merged the first two patches
> >   in V3 into this patch.
> > - Rework commit log
> > Changes for V3:
> > - Remove FXOS8700_CTRL_ODR_GENMSK and set
> FXOS8700_CTRL_ODR_MSK a
> >   field mask
> > - Legal use of filed mask and FIELD_PREP() to select ODR mode
> > - Rework commit log
> > ---
> >  drivers/iio/imu/fxos8700_core.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/imu/fxos8700_core.c
> > b/drivers/iio/imu/fxos8700_core.c index 773f62203bf0..a1af5d0fde5d
> > 100644
> > --- a/drivers/iio/imu/fxos8700_core.c
> > +++ b/drivers/iio/imu/fxos8700_core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/acpi.h>
> >  #include <linux/bitops.h>
> > +#include <linux/bitfield.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -144,9 +145,9 @@
> >  #define FXOS8700_NVM_DATA_BNK0      0xa7
> >
> >  /* Bit definitions for FXOS8700_CTRL_REG1 */
> > -#define FXOS8700_CTRL_ODR_MSK       0x38
> >  #define FXOS8700_CTRL_ODR_MAX       0x00
> >  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
> > +#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
> >
> >  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
> >  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> > @@ -508,10 +509,8 @@ static int fxos8700_set_odr(struct fxos8700_data
> *data, enum fxos8700_sensor t,
> >       if (i >=3D odr_num)
> >               return -EINVAL;
> >
> > -     return regmap_update_bits(data->regmap,
> > -                               FXOS8700_CTRL_REG1,
> > -                               FXOS8700_CTRL_ODR_MSK +
> FXOS8700_ACTIVE,
> > -                               fxos8700_odr[i].bits << 3 |
> active_mode);
> > +     val =3D val | FIELD_PREP(FXOS8700_CTRL_ODR_MSK,
> > + fxos8700_odr[i].bits) | active_mode;
>=20
> val |=3D would be neater.
>=20
> Also, if I read the existing code correctly, val hasn't been masked, so i=
f
> active_mode was set in val, it still will be, hence no need to or it in a=
gain.
> You also haven't masked out _CTRL_ODR_MSK so as a result of this call you=
 will
> get the bitwise or of whatever ODR value you are trying to set and whatev=
er it
> was set to before.
>=20
>=20
> > +     return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
> >  }
> >

I am so sorry that I don't use the FIELD_PREP correctly due to my rustiness=
.
Firstly I fix the issue I haven't masked out _CTRL_ODR_MSK. But activating =
the device
is required after that so I or FXOS8700_ACTIVE instead or active_mode. Then=
 I want to
discuss about the appropriate usage scenarios about regmap_write and regmap=
_update_bits.

In source code, regmap_write use _regmap_write only while regmap_update_bit=
s encapsulates=20
_regmap_read, modify mask bits and _regmap write. So when need to see what =
the previous values
or the value has been already got before and is used at other place, it is =
better to use regmap_write.
We just renew the value and use regmap_write to write it to the register. I=
f we just need modify
the register bits but there is no need to see what the previous values were=
, it is better to use
regmap_update_bits. It is a simple and direct means and can avoid using reg=
map_read to get a value
and perform bit operations.
To sum up, if the value of the register has been read by regmap_read or oth=
er methods, then use
regmap_write correspondingly to renew the value. If no value has been obtai=
ned from the register,
modifying the register using regmap_update_bits is the preferred method. I'=
m not sure if that's the
right understanding.

So based on it, there are two reasons that I choose regmap_write to replace=
 regmap_update_bits:
1. There is a val which has been get by regmap_read and is used, so just us=
e regmap_write and FIELD_PREP
to renew the val.=20
2. The code block used regmap_read and regmap_write to renew the value, uni=
form use of regmap_write
can have a good readability.

So I think the using regmap_write than regmap_update_bits is more reasonabl=
e.
@@ -508,10 +509,9 @@ static int fxos8700_set_odr(struct fxos8700_data *data=
, enum fxos8700_sensor t,
        if (i >=3D odr_num)
                return -EINVAL;

-       return regmap_update_bits(data->regmap,
-                                 FXOS8700_CTRL_REG1,
-                                 FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
-                                 fxos8700_odr[i].bits << 3 | active_mode);
+       val &=3D ~FXOS8700_CTRL_ODR_MSK;
+       val |=3D FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | =
FXOS8700_ACTIVE;
+       return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
 }

However there is a minimal fix, the patch looks more graceful:
@@ -511,7 +512,8 @@ static int fxos8700_set_odr(struct fxos8700_data *data,=
 enum fxos8700_sensor t,
        return regmap_update_bits(data->regmap,
                                  FXOS8700_CTRL_REG1,
                                  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
-                                 fxos8700_odr[i].bits << 3 | active_mode);
+                                 FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos870=
0_odr[i].bits) |
+                                 FXOS8700_ACTIVE);
 }

Which is better? In next patch I also faced a difficult decision about it.
> >  static int fxos8700_get_odr(struct fxos8700_data *data, enum
> > fxos8700_sensor t, @@ -524,7 +523,7 @@ static int
> fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
> >       if (ret)
> >               return ret;
> >
> > -     val &=3D FXOS8700_CTRL_ODR_MSK;
> > +     val =3D FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
> >
> >       for (i =3D 0; i < odr_num; i++)
> >               if (val =3D=3D fxos8700_odr[i].bits)

