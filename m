Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDDE663A1C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jan 2023 08:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjAJHo2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Jan 2023 02:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAJHo1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2023 02:44:27 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CB17595
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 23:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgOsLVC8RJvld26kQYTZ3fPNBAos2HIMk2v9yCIFWdyeNFngnX4Q1mJlbWjos57uHngTKUVjWLCdYTgNKEtxcbUVcFTxklOU5CK1+eOokzc8k87IjtWk6wp+ANYvrP/aXF2ktbSmh5gru7+6XHOCbYK74PANirS0gZ4ucyXpoTeGjyRuHI3H0IUHjKNSCT2VzfSTtiC0r7fYDR5/AYDinzw2+UhgWY3R+kK9kx8K0TT8O/7eDRZH03SwHaCUEmw6NkY0blKnd2wPm0gaQwF1g4HEJl5lG8Hccm5W9jPdWHd1w+mikl4sKhE1oxAnb/schQ4ZGR0NWvUxQwk/LOmk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PXn08fSPf2cSt0prmvGHItTkjE7r8hRBWx8V5OqrSY=;
 b=d9+iQcjL5DbL/UESZzUdVB2GLNuNMI/nUT+dovigrDgs4AhAK8Z3zBhlZu9//YpQcEpwElSwKEJ8EuKXi9rBEfyT+9yqauTj7yh2vXSq+A98YBUO/f7+4f0b7imDaEaVd7aNiFOsQA/Q3j/apca3NvdlnGzx+ugZQzv3tHmBF9gPXSoiJUbo1DEzSziwHYl9tq3VAbAjVBu27d8rhgozfFw7cFvse5NYGVlIuhrhQq5+LAr5N2eM4vhBvPfLiXkLV0rrGwMR4IfJAPQNM76H3CrPQLL+rFRNYsp6Gqxj4fmrOplD8xvPglgcotE+sB7fVTYt5eNpJJ3x8FaZerqNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PXn08fSPf2cSt0prmvGHItTkjE7r8hRBWx8V5OqrSY=;
 b=SB9UQlmjgDNRupTiY5zBlYXQfScXFuv8K9odrrR3ocBXPok69jHErNmlF6xO0W5WfbVJvVdd3uZvj7honY7RJemp/yC+3/XXPWihIAWoyulZHUoL1uLk9M3jzAn+g9CCCBCwFol39ZeCIZrXLTn96/nhGpeZ0Gki6CoYoATaRSo=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 07:44:23 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 07:44:23 +0000
From:   Carlos Song <carlos.song@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        Bough Chen <haibo.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 2/4] iio: imu: fxos8700: fix failed
 initialization ODR mode assignment
Thread-Topic: [EXT] Re: [PATCH v4 2/4] iio: imu: fxos8700: fix failed
 initialization ODR mode assignment
Thread-Index: AQHZGqA9Gfp/W4wEuE2/t8T/fss+5q6IGlyAgA8l7xA=
Date:   Tue, 10 Jan 2023 07:44:23 +0000
Message-ID: <VI1PR04MB50057136A46A6FA64DBDDC5CE8FF9@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
        <20221228093941.270046-3-carlos.song@nxp.com>
 <20221231145439.08564db1@jic23-huawei>
In-Reply-To: <20221231145439.08564db1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|DU2PR04MB8581:EE_
x-ms-office365-filtering-correlation-id: 14d96d0a-8029-4a07-bc97-08daf2de7db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +n7rnFlAmRxniPZDc9DInbz7efcjtGw1cAL8ng4HvsVv5g1vlEJeYQMrdOcQU2+vd/GAg/v95uOFOnGMh69Dle/3zts1pXZ50Wl0U1XxLR4ykWihJS90hrNVmSlPx06DN5LJnumS7XOHGloAWS7o81IyAaU14BubFu4VOa+gqtc0u0f7GXiCEhfefmly7dHkxRDxPNN/bTB0ACelplnHQo6TGhV/d3hMPu+WzQCxfDn5m6dzUajrb2L/qEvLsTA7iYuqBg9kP0nBse1FsAhCJL+FZgcW/c+bycpoJoKMywD8EBdRsMbep5Y8eeuLkW2rLrSRPBh7StDCLSCTFPkQOZ6KutgBxr+hL50Be/Q1rMwAgHxPNjsY0K4z4vbK5skve6gwsAo45YWeRAADUOWuFlne2a/W6hmtaAm0YeJrdEhxtlKb1/dXLuoftzSPLaTB4Cd0xzq8jfvliKIyemkUxwzvwleh6834YUCx2QCOBuqBv7r7mViBa+9yUqEPYIyuPA+t4gtVuskiTTEJ/kURrgo4btCmQnpYIC9kZpdRuWzVLrmd2Z4OdR8oaGgQ18zK1fWJW6FSi3ZA9ucOazCCWa67yWUF6rVJmPnOz7q8yClT6FXLfjA9lVG1EkpeDqkcBEGC5dwMnjMnMU/fTvLVGSppzCV7S7q1pqHZsJnVSOrqKzCcDqwt3kOM8Qf8r/h42ioSXx6HpYgx3k4ZBCBkXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(6506007)(33656002)(478600001)(53546011)(4326008)(26005)(186003)(55016003)(9686003)(64756008)(66446008)(76116006)(66556008)(8676002)(66476007)(6916009)(71200400001)(54906003)(316002)(7696005)(86362001)(122000001)(38070700005)(38100700002)(83380400001)(41300700001)(52536014)(66946007)(5660300002)(2906002)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oe8HzSCEazZ3l04S0hQ2xvdkXbdTXQ/DaYjoDwZRjIS7inD3Bp06oYz2nNqz?=
 =?us-ascii?Q?zJL9aRbZgqzVofFDjxhfg5A70Sa0OK9ULIUBCGyjQo7zFbGfDI9/4F1BRI3Q?=
 =?us-ascii?Q?kAc17FJTMPUe0Gkbw/qUswCAP7rh7NVaRl4SLEJJgkvaXzQYRoMo1vZle4AJ?=
 =?us-ascii?Q?09uk5u4hzw7Pkc7WgjTjJlDXYbh0yA9bdCXkIYfuOAOzH+G9XLa71AJrTQzw?=
 =?us-ascii?Q?T8QzDEfJIQTRA7V/wEiK/dZUd07maxqa4fqZgghxqENTChxLCoS2oNRfkyU3?=
 =?us-ascii?Q?o+bXE4iobDM22mjeOgSFaa4o3CHchzAnzV9TnpJtOEOKF+m5nrkKb3P93r0O?=
 =?us-ascii?Q?YdmQb8GL8ZbooRAgLuotMPli8mUQd39u5rnukc1AV/v6puw/moC0ezXzcdo4?=
 =?us-ascii?Q?jtXpNnegw+ZKD/ntmokQt8QiGbQMLbB6DNEHPmSxTUyUZAuF0YnY6mRTJa1d?=
 =?us-ascii?Q?CJvgXK3FtCCl3xvcJjXiB7zrrkfpWpniFFwJGcXQ2141xvajOe+zzAldEmqL?=
 =?us-ascii?Q?mgDYeqCNGPj0hKc9X0LS9U2KXpvmnVSE2JPHH1i3wBvL5s2QVqR+NvoUcPST?=
 =?us-ascii?Q?DTHt4dIi5/dknHgA2LhKzElJHzAN+eM9yUq6x0R5gHwcqBbDuaRe9KP0HYLc?=
 =?us-ascii?Q?d/4d8n58OKshOaifXwzg29xIHaaV0Agi68mIptuW6Wp15TDKfmGRBL3ZQ2MM?=
 =?us-ascii?Q?bIvgiCV5zVopygZkR5Qpt9ObYn1A1TnlxvFOZX50QlTpYSBmLI8E2MJ4h7+L?=
 =?us-ascii?Q?bv/v2cYLeXrAmYgEtQryWknbIowMM5VHtlNwUODov1G+H2nQC6QLNWj55cVO?=
 =?us-ascii?Q?LK75ExTwX4IJQ95aK7vWJrOR251hsmdmMOGoT0rLExudaC3JU3JK9aGjBQ8v?=
 =?us-ascii?Q?OWjuV/7Riln7S2N4Cx6WMoh/hxMiweqFYtoSSavm66Ns1XGdzv/dO1UT3FlA?=
 =?us-ascii?Q?rsDbIKRBVddoZ1iAP5YntfJ2h95btHxGXR0TwGnD5XzhYmRnfFrF2R7EPMyf?=
 =?us-ascii?Q?LLPgvv349ml/OLCUslJrbsCML06XKAmh6FBgSbxS8oQD/BK46eq3dnP6rGcd?=
 =?us-ascii?Q?ZJr8Sm3Q24tVusVje1Zq3gQ5hsfFMH1lvCpgqwXCkk0Gt+KJP8urpNxoGBN4?=
 =?us-ascii?Q?BpMaynuSSrjLQfooSHbRybxb1kG9yi3tzaWB4FAAUwrfC0L3/Xfp0ugbobY2?=
 =?us-ascii?Q?ZVV52CpfzAJVN6DNtz9A6TPiuzXQOBd5fQkpob+cGCmEwNyZsjrWYrPkl3uI?=
 =?us-ascii?Q?LDWhUBRFr3R99EU9Goy7UsyH0Bd37LMwGxorVrfFNCoKTGKt//sUshu9S54K?=
 =?us-ascii?Q?nzFLQC//rijIeTtoZE4xwGpAUP33/67vtKQJnzUifpIgU067ODzC0H8zkQ8J?=
 =?us-ascii?Q?W1O/xbOuPsasR4ypwypI7xhZEOn+FPgQl4vy2ZmQE4d4qQiHrPKkJQK4aOOH?=
 =?us-ascii?Q?xqtTsihJzQaL1SLZ0XACWla9zJXx66R/OzFZw1JFyYEIKBmbp2IOBjcQNTfm?=
 =?us-ascii?Q?JhYvQwV48JzGdqQBMYP9COFx69jsj7HsJIOCFHoqSDfH37nNI7McOmZY/mF2?=
 =?us-ascii?Q?8jgm05TZ6a76/Ezas8sUNuRwfaBqpiUmvN5ti9Ep?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d96d0a-8029-4a07-bc97-08daf2de7db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 07:44:23.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZMR4T+rccnqCngj0R3mLfmFSSTlqWcTgj6ijfNGpbrUu3VoY/8rE4GSy/kW/4H2GolNkO2b1JTWNIuuQ7z2jA==
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


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, December 31, 2022 10:55 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: lars@metafoo.de; rjones@gateworks.com;
> Jonathan.Cameron@huawei.com; Bough Chen <haibo.chen@nxp.com>;
> dl-linux-imx <linux-imx@nxp.com>; linux-iio@vger.kernel.org
> Subject: [EXT] Re: [PATCH v4 2/4] iio: imu: fxos8700: fix failed initiali=
zation
> ODR mode assignment
>=20
> Caution: EXT Email
>=20
> On Wed, 28 Dec 2022 17:39:39 +0800
> carlos.song@nxp.com wrote:
>=20
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > The absence of correct offset leads a failed initialization ODR mode
> > assignment.
> >
> > Select MAX ODR mode as the initialization ODR mode by field mask and
> > FIELD_PREP.
> >
> > Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > ---
> > Changes for V4:
> > - None
> > Changes for V3:
> > - Legal use of FIELD_PREP() and field mask to select initialization
> >   ODR mode
> > - Rework commit log
> > ---
> >  drivers/iio/imu/fxos8700_core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/fxos8700_core.c
> > b/drivers/iio/imu/fxos8700_core.c index a1af5d0fde5d..de4ced979226
> > 100644
> > --- a/drivers/iio/imu/fxos8700_core.c
> > +++ b/drivers/iio/imu/fxos8700_core.c
> > @@ -611,6 +611,7 @@ static const struct iio_info fxos8700_info =3D {
> > static int fxos8700_chip_init(struct fxos8700_data *data, bool
> > use_spi)  {
> >       int ret;
> > +     int reg;
> >       unsigned int val;
> >       struct device *dev =3D regmap_get_device(data->regmap);
> >
> > @@ -663,8 +664,11 @@ static int fxos8700_chip_init(struct fxos8700_data
> *data, bool use_spi)
> >               return ret;
> >
> >       /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> > -     return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > -                        FXOS8700_CTRL_ODR_MAX |
> FXOS8700_ACTIVE);
> > +     ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &reg);
> > +     if (ret)
> > +             return ret;
> > +     reg =3D reg | FIELD_PREP(FXOS8700_CTRL_ODR_MSK,
> > + FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;
> reg |=3D will work here. However, like in previous patch I'd expect to se=
e the
> _CTRL_ODR_MSK used in
>         reg &=3D ~FXOS8700_CTRL_ODR_MASK;
>         reg |=3D FIELD_PREP(FXOS8700_CTRL_ODR_MSK,
> FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;
>=20
> This is a good place to use regmap_update_bits() as there is no need to s=
ee
> what the previous values were (unlike in previous patch).
>=20
> > +     return regmap_write(data->regmap, FXOS8700_CTRL_REG1, reg);
> >  }
> >
> >  static void fxos8700_chip_uninit(void *data)

This is a good place to use regmap_update_bits(), because I don't need usin=
g the regmap_read to
get the value and perform bit operations:
@@ -666,8 +666,10 @@ static int fxos8700_chip_init(struct fxos8700_data *da=
ta, bool use_spi)
                return ret;

        /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-       return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-                          FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+       return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
+                               FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
+                               FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_=
CTRL_ODR_MAX) |
+                               FXOS8700_ACTIVE);
 }


 static void fxos8700_chip_uninit(void *data)

Here I also faced a difficult decision:
most code block of the entire driver code uses regmap_read and regmap_write=
 to modify registers,
only my two patches use regmap_update_bits. I admit that this is indeed a g=
ood place to
use regmap_update_bits, but do I need to consider the uniformity of the ent=
ire driver code
style when proposing a patch? When using regmap_read and regmap_write, alth=
ough the
patch is a bit lengthy and jumbled, it is very uniform in terms of the over=
all code style.
Like this:

@@ -663,8 +664,11 @@ static int fxos8700_chip_init(struct fxos8700_data *da=
ta, bool use_spi)
                return ret;

        /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-       return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-                          FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+       ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &reg);
+       if (ret)
+               return ret;
+       reg &=3D ~FXOS8700_CTRL_ODR_MASK;
+       reg |=3D FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) |
+ FXOS8700_ACTIVE;
+       return regmap_write(data->regmap, FXOS8700_CTRL_REG1, reg);
 }

 static void fxos8700_chip_uninit(void *data)

How should I weigh them?
