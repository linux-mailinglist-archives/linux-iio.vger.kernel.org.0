Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA304C2E63
	for <lists+linux-iio@lfdr.de>; Thu, 24 Feb 2022 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiBXO0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Feb 2022 09:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiBXO03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2022 09:26:29 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8A1637FA
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 06:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8Nxkjo3vaZciV2qljmbSBg7g6CEk50qmPQBPQnOeEP4MoMhBsnUbadsevgbmfb9OcCz/KhNLAqFx9ZZ9cdv9u6MphTDrqkt4MkwahD3m0SGH1EV185ceiBiN4GniMYpbtj0kW88I8sAVsUlZRhofhYjC19dVwTv68rv2d/dShn/JdVGIJtdgdNZCPm+Ov0BPASJpU7RFzxBzLRkjU6XIzrzpqGtTtIH7XjZksXIdfDtdnuuB3rV6eCKmlXx66hS1OcYpawFb8kMJgjh01vnKAXMnBuCHLnd7B6mSG038vWcrNSzGiyi7vXB7x+BjwORDhLtBzwna4GFM0h+lV/9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my80LbCIqzqIkPMJMU6Z56OMGhGLvBqpwL0w7lS9yBk=;
 b=e1QCMfvYl/eRzNfwrKbCCm7U8ty5A7jgQkGf3ylA9j1gxYPdDiV9pbeSHh4f9Hm6fPlg1eMeNTqKMKAU++jP2Rg00kqmg7+yU/dkvOqDwEjXwMDzpZfzdkd0ZZktYARjDE0xWjMWiCC/g3KOOoA+AmnAMjyS4biiD4GzOhm3eoFgO9oXBWCpTE0vQZZtLkm3A0Br9aTwpX9FBTKM1LG87npkhqwx3LbUgUtMdIYwVwSZFXX1BdyCTTMYrjeI3AQer4Hli+K1gKC9UIiq+hhR3sHYHicMmTjJGQl06A8i6LFMi0gqCqDyCRjuwamCFyhfeZCdOwDQ1IY40Qeme2YnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my80LbCIqzqIkPMJMU6Z56OMGhGLvBqpwL0w7lS9yBk=;
 b=PUbnsX1NvKbVkkqnSvdz//to6TthlVDW6YlMTI6BZ/fHiC/DTGsBvddHpleYUCIr7PC+f06ElIRu8rsi432X7ae5zd16LZZtfzap3k9Te6PXHDk+x4ICqWt2FMfucG5yOW9BJQ1mecavn+Z1K6BMt/NXhDjfGDZpbeq7FoHJXF0=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM0PR0402MB3683.eurprd04.prod.outlook.com (2603:10a6:208:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 14:25:56 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::f468:5bbf:f34c:668]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::f468:5bbf:f34c:668%6]) with mapi id 15.20.5017.023; Thu, 24 Feb 2022
 14:25:55 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] iio: imu: fxos8700: few bug fix for fxos8700
Thread-Topic: [PATCH] iio: imu: fxos8700: few bug fix for fxos8700
Thread-Index: AQHYJ6LdpwjUUgqtj0WoPzU8wK55BqyfywoAgALxAKA=
Date:   Thu, 24 Feb 2022 14:25:55 +0000
Message-ID: <VI1PR04MB40164F502C239F681BFAC015903D9@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <1645502822-5585-1-git-send-email-haibo.chen@nxp.com>
 <20220222165638.0000243a@Huawei.com>
In-Reply-To: <20220222165638.0000243a@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29f170c2-cd41-4916-7bf3-08d9f7a191e5
x-ms-traffictypediagnostic: AM0PR0402MB3683:EE_
x-microsoft-antispam-prvs: <AM0PR0402MB3683203E809661A86522D284903D9@AM0PR0402MB3683.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4QW18RPgA6P6EfRPOoVxAarchKW0ep4FgwWkSwMKiQXxi85uXFpDwe1MEgumvZ9LJH8m77pkw3zgFBb6KnQy75Zr24UnRBJav3OjPwxpxldO5CkGqOLF3XqxtQjwFu6QeBs/SLyHsq32RnEUfQxS3GpZBJKr/1f5wd0oyGdtSxiLguvt/Dk9U+buJtIONRNo/il0nDpHpJp/8qGQeKiBKP/LGQvd7I8ajeUlLbXINKQfKC7Eqc8jUbFaf6H6AOlDKbDL5M9j8XpxtCn/zYCn9v4N2RhBtQ1Poe68s7CxqXj4sVHkTVfDzuxOt2U+309A35zOEfaCP3xnbC1aspuIR3qabqhhgaKcOyTJp3fZqQORMREQac/ht+rLIOqCw4bUs2hdXmMQOOLpVuTnsXaRw4Aa6erRjTzTBfBsyLWh9AnSwkAJHE9fhsOnfQl3yOC09Ink+G979uKE1sBbW7P0/GCI+AfuLwYHoPrHMLBdVu9QBG2LG/FRW3L5yqBwodgQ8yaMtcnU4+MLMDsKN99is6Sze2A6hnJzdgRxeeo8BvRqQ+SgkeKHcQNLgPpcup/pB03hTUYM2PIU689FEjyHiNvjYPOt/9Nws8OnClHPt5THucBMyWkmvGEVfQPTSRoEwInEPDmEk9rV4C9TJwSxQqqKNnVWPSCYfkzCOW6BJiEH1Fg4l2bhQNQtc5WlqxzHs8nZn+yqpUCA6RTYRbVPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(9686003)(86362001)(52536014)(2906002)(7696005)(122000001)(54906003)(8936002)(38070700005)(76116006)(6506007)(5660300002)(55016003)(186003)(6916009)(316002)(99936003)(26005)(83380400001)(38100700002)(66446008)(66476007)(66946007)(66556008)(64756008)(4326008)(8676002)(508600001)(53546011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZlkxclNCcXQvSTBjOUZpR3BwSG5BNTNqY2pVY3Nha3p3TzQzdE1ya3I1bmYy?=
 =?gb2312?B?QXlpT2U1elZlWmNwYytydEFoSlEzVjRMU0dRRDV1NklmL1JjQzFuWk1ZNDIv?=
 =?gb2312?B?cENHSmlPOXI5WVRjOGNhZHQ0OEhEOFlabk9qOVJhazcxb29mQnErSGFOVkNG?=
 =?gb2312?B?SS9McmVSRS9SMTBKbVdGWVdhL3ZtV3ZRblduNjVxczl5QmdFd0R0anF1YTUw?=
 =?gb2312?B?WHRkcy9JQlhJNm80eGdWV2Qyb09ldG1wbGdIVzNCVW5JZEdxWUNudU4zYzdU?=
 =?gb2312?B?S0RRajlTbWZGWGI5TFprNWZuYUNlSEhpTUFyeUFnYkxUMWhoYzZhOEkrckRB?=
 =?gb2312?B?eDhUbFpLMDNnaCtxTndKZVpwaGllV2FYWWxHdlRUK1psREQ2eGlPVkVLREIx?=
 =?gb2312?B?RE96bWN4R042Z2pvOXRrSklPMTRKMVRFT0ZrckNMT3FDS1RqWkdNUGhUSXBI?=
 =?gb2312?B?b2NHcTcvMDl3WHZTcW5HN0hMdXFPZEg4VUpmR1FGK0NndmZaaWh5QUUzaHpj?=
 =?gb2312?B?bmdIbS9YSGhvbmtoUHczdXlySEpNYjRhWmNCQnB3SXZmVFFaUUZiVE43MVJj?=
 =?gb2312?B?S2Z2Z1g5dG1YSmgyMElxN21nQ3M4TW4wMFlZR0tlbENYNGJqQjhDMlVRanJz?=
 =?gb2312?B?MGhBZUNzOU10bksyWHAyQmhjVks5a2dDVWF0ejJTWGhmVmRGN1lrQ3B1U25y?=
 =?gb2312?B?bE9QZGRWaFB3MXlnTFZpZmIyc1F1Tmhmd0Mrb0hlQ1Vpam5XOSsrWlRsTC82?=
 =?gb2312?B?T09CRG1oejVjSkcrLzVlRjZ1bGl5dHAvOWkxSStJMGx5dXFuOU93aTlhVkR2?=
 =?gb2312?B?VXh4bVA5bDNyRHNVVG8vNHBhL3VHRG8vSHNqbktIWEx4T2w2cnBMT1A3MFdQ?=
 =?gb2312?B?a3FkTUdPbFRRYVhzRlBsQ3NPVEgvZnpkZWx5WXBvbUtIeENNN0JRUEE3b1FU?=
 =?gb2312?B?anREbHJCRWJZN0x2cExLWGZoR2QzYlRyekNKRUNlQ0NZS0R6TThXT3ZralJs?=
 =?gb2312?B?RXlSTTdpQ3Q4VEoxdlk5V1VBKzFEQmRhaXVvRUJJZ2UzamRVazN1UVBXNWNS?=
 =?gb2312?B?VDZ3VU5iVWp2RW9hb2xubldJcFcxNm0vS3A4TCtsQktBdXMzNFk2WldINGVV?=
 =?gb2312?B?TlM5cW5xVS9sNjV3VWFpdGF1WmJEQ2EyWUZrUjZtWXlVbDl2dDVDajJ6U2o4?=
 =?gb2312?B?V0tjanFFdENkUGxaOXNqRWN5aGJBL0lHM0VhNlBkM1Y4RXp3RlE5RjNMMFlS?=
 =?gb2312?B?SXlJT29iTG4wazNHaGFNdWNwelkwZkhmb0dTYWl5azA4VU0rVFExVnRhMlhk?=
 =?gb2312?B?ZFk3czkzQjV2SlJOdnNtcTdiUnhCQlVwWjZJTSt0eFltTmd3NTB4TmtVWFhx?=
 =?gb2312?B?QmVTSlZ0SFNHbmU2Z2g0bTgwOHZpRURlQ3VjZkRRRVM5azFDSE9qMFc2ZzUw?=
 =?gb2312?B?Uk1oY3JXYUZDYkFlcXFsNys4dStaQXNkZlE3ZWMycVdhM1lYOWhJM3loMXpJ?=
 =?gb2312?B?cXZiZWxiV043NEJSREtGTitjQWw1TFpxWDE3cmt2VWFicnFWRm9mOGUvQjJY?=
 =?gb2312?B?S0ZoS3JWN09sK1dwVDJHZmtBVktoRGw5R2tRM0dOWldVNkVzbU1VZWhNbSs2?=
 =?gb2312?B?cWNzNWtQOTNqM004dDJKYjVaaEZCNm9DanAyS1FsQ3J4RWZCN0l2Zmp5czJh?=
 =?gb2312?B?L2ZXd2pNalpscXpuUXlKYmJyYzJSYkhvSzhsS2FzME1uTEI1Y01pZDJoM2tE?=
 =?gb2312?B?c2lqbDBuRUs5aGt4ZklBanRJRDI0TGErRTBHcitYa2ZZVVFqVkxWQXdNYWJt?=
 =?gb2312?B?SmxtbEdod2Vxd2p3cnVnZ290Nm5nWnQzWEZWdjl5dm5QcEx1c2NIUmJib0tF?=
 =?gb2312?B?WUF4TEJkVVJVbUVycWtHai9Delpoa3dZejFkQlVHdHFDVlpMRzZhSUExTWwy?=
 =?gb2312?B?T2dIV0ZLRG1zczVNcG1HcFJmNlhzSzUvazVHWHNHV2tIektIZXJ3akorUHVv?=
 =?gb2312?B?eFZDenExMVpjS3d6Qk5oRVJhZG1Va0pHb1VqYm85b2YzbmdzR3dYYnY0TGFh?=
 =?gb2312?B?dGU4aHgzcVoycERqWU41ZE9SQlZuZEVLQlJ4MWQ1TzgzWlhyOXk2QXl4UFZF?=
 =?gb2312?B?UVhTbEJSc0s1MGVZbjBtTmFmUzVxOWt0SGFhT0FlMTUyZkVrMENpNkhqZDM0?=
 =?gb2312?Q?pRgbcwzgVgqeriSemjHtPiM=3D?=
Content-Type: multipart/signed;
        micalg=SHA1;
        protocol="application/x-pkcs7-signature";
        boundary="----=_NextPart_000_0397_01D829CD.7ABA64E0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f170c2-cd41-4916-7bf3-08d9f7a191e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 14:25:55.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxEJCws4iOYN8oDooY2H3wdV/zMvuG6h6dRg7a67x+ozeV4X7muG89Ti2Ys1hR9HKuL13Ho7cCnWhApG/JEuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

------=_NextPart_000_0397_01D829CD.7ABA64E0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Jonathan Cameron [mailto:Jonathan.Cameron@Huawei.com]
> Sent: 2022=C4=EA2=D4=C223=C8=D5 0:57
> To: Bough Chen <haibo.chen@nxp.com>
> Cc: jic23@kernel.org; lars@metafoo.de; linux-iio@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] iio: imu: fxos8700: few bug fix for fxos8700
>=20
> On Tue, 22 Feb 2022 12:07:02 +0800
> <haibo.chen@nxp.com> wrote:
>=20
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > 1, z raw data always 0, regmap_buk_read use the wrong length. fix it
> > and optmize read the only need data.
> > 2, use the correct register address when try to read raw data.
> > 3, before set scale, need to set the sensor to standby mode. =
otherwise
> > the scale set is not work.
> > 4, give the correct offset when config odr bit.
>=20
> Sounds like 4 patches to me. Whenever you have a list of what a patch =
does
> you should probably split it up.  Would be a lot easier to review as =
one
> patch per issue.  For now I've just take a quick general look.
>=20
>=20
Hi Jonathan

Thanks for your suggestion, I will split few patches in the next =
version.

> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> > ---
> >  drivers/iio/imu/fxos8700_core.c | 66
> > +++++++++++++++++++++++----------
> >  1 file changed, 47 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/iio/imu/fxos8700_core.c
> > b/drivers/iio/imu/fxos8700_core.c index ab288186f36e..1896d6db6d77
> > 100644
> > --- a/drivers/iio/imu/fxos8700_core.c
> > +++ b/drivers/iio/imu/fxos8700_core.c
> > @@ -162,12 +162,11 @@
> >
> >  #define FXOS8700_DEVICE_ID          0xC7
> >  #define FXOS8700_PRE_DEVICE_ID      0xC4
> > -#define FXOS8700_DATA_BUF_SIZE      3
> >
> >  struct fxos8700_data {
> >  	struct regmap *regmap;
> >  	struct iio_trigger *trig;
> > -	__be16 buf[FXOS8700_DATA_BUF_SIZE] ____cacheline_aligned;
> > +	__be16 buf ____cacheline_aligned;
> >  };
> >
> >  /* Regmap info */
> > @@ -345,7 +344,8 @@ static int fxos8700_set_active_mode(struct
> > fxos8700_data *data,  static int fxos8700_set_scale(struct
> fxos8700_data *data,
> >  			      enum fxos8700_sensor t, int uscale)  {
> > -	int i;
> > +	int i, ret, val;
> > +	bool active_mode;
> >  	static const int scale_num =3D ARRAY_SIZE(fxos8700_accel_scale);
> >  	struct device *dev =3D regmap_get_device(data->regmap);
> >
> > @@ -354,6 +354,23 @@ static int fxos8700_set_scale(struct
> fxos8700_data *data,
> >  		return -EINVAL;
> >  	}
> >
> > +	ret =3D regmap_read(data->regmap, FXOS8700_CTRL_REG1, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	active_mode =3D val & FXOS8700_ACTIVE;
> > +
> > +	if (active_mode) {
> > +		/*
> > +		 * The device must be in standby mode to change any of the
> > +		 * other fields within CTRL_REG1
> > +		 */
> > +		ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > +				   val & ~FXOS8700_ACTIVE);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	for (i =3D 0; i < scale_num; i++)
> >  		if (fxos8700_accel_scale[i].uscale =3D=3D uscale)
> >  			break;
> > @@ -361,8 +378,12 @@ static int fxos8700_set_scale(struct
> fxos8700_data *data,
> >  	if (i =3D=3D scale_num)
> >  		return -EINVAL;
> >
> > -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> > +	ret =3D regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> >  			    fxos8700_accel_scale[i].bits);
>=20
> Realign these parameters with the opening bracket.
>=20
> > +	if (ret)
> > +		return ret;
>=20
> blank line here.
>=20
> > +	return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
> > +				  FXOS8700_ACTIVE, active_mode);
> >  }
> >
> >  static int fxos8700_get_scale(struct fxos8700_data *data, @@ =
-393,23
> > +414,29 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
> > static int fxos8700_get_data(struct fxos8700_data *data, int =
chan_type,
> >  			     int axis, int *val)
> >  {
> > -	u8 base, reg;
> > -	int ret;
> > +	u8 base, offset;
> >  	enum fxos8700_sensor type =3D fxos8700_to_sensor(chan_type);
> > +	u8 tmp_data[2];
> We loop around this every now and then. It 'happens' to be the case =
that
> currently (or last time I checked) regmap_bulk_read always copied the =
data
> and hence uses a dma safe buffer internally. That is not guaranteed by =
the
> interface however so when we last asked Mark Brown he suggested we
> should assume that it requires the same level of dma buffer safety as =
the
bus
> subsystems being used.
>=20
> Thus for any driver doing bulk accesses to SPI device, you need a DMA =
safe
> buffer.  Which is what the __cacheline_aligned buffer in iio_priv() is =
for
in
> this driver.

Thanks for your sharing, I will take care of this.

>=20
> > +	u16 native_data;
> > +	int ret;
> >
> > -	base =3D type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
> > +	base =3D type ? FXOS8700_M_OUT_X_MSB : FXOS8700_OUT_X_MSB;
> > +	offset =3D axis - IIO_MOD_X;
> >
> > -	/* Block read 6 bytes of device output registers to avoid data =
loss
*/
> > -	ret =3D regmap_bulk_read(data->regmap, base, data->buf,
> > -			       FXOS8700_DATA_BUF_SIZE);
> > +	ret =3D regmap_bulk_read(data->regmap, base + offset, =
&tmp_data[0],
> > +2);
> >  	if (ret)
> > -		return ret;
> > +		return -EIO;
>=20
> Why eat the error return of the bulk_read and replace it with a
potentially
> less informative one?

My bad, will fix.

>=20
> >
> > -	/* Convert axis to buffer index */
> > -	reg =3D axis - IIO_MOD_X;
> >
> > +	data->buf =3D ((tmp_data[1] << 8) & 0xff00) | tmp_data[0];
>=20
> tmp_data[1] is a u8 so that masking isn't doing anything other than
possibly
> fixing some type conversion issues.

Oh, you are correct, I will fix that.
>=20
> However, this is an endian operation, so express it as such
> get_unaligned_be16(tmp_data); or similar.  Maybe even just use a =
__be16
> and be16_to_cpu() directly on that.

I will re-do this code.

>=20
>=20
> >  	/* Convert to native endianness */
> > -	*val =3D sign_extend32(be16_to_cpu(data->buf[reg]), 15);
> > +	native_data =3D be16_to_cpu(data->buf);
>=20
> This looks wrong.  You've already done a be to cpu conversion (via the
> shifts above) now y ou are doing it again. Why?

For this sensor, according to the RM
For the first register(address 01), we get data[13~6], and for the =
second
register(address 02), we get 8 bit data, the upper 6 bit is data[5~0],
Seems I made the logic complicated.

>=20
> > +
> > +	/*accel raw data only has 14 bit */
>=20
> /* Accel ...
>=20
> > +	if (!type)
> > +		native_data =3D native_data >> 2;
> > +
> > +	*val =3D sign_extend32(native_data, 15);
> >
> >  	return 0;
> >  }
> > @@ -462,6 +489,7 @@ static int fxos8700_get_odr(struct fxos8700_data
> *data, enum fxos8700_sensor t,
> >  		return ret;
> >
> >  	val &=3D FXOS8700_CTRL_ODR_MSK;
> > +	val =3D val >> 3;
>=20
> FIELD_GET() would be easier to read for this.
>=20
> >
> >  	for (i =3D 0; i < odr_num; i++)
> >  		if (val =3D=3D fxos8700_odr[i].bits)
> > @@ -592,14 +620,14 @@ static int fxos8700_chip_init(struct
> fxos8700_data *data, bool use_spi)
> >  	if (ret)
> >  		return ret;
> >
> > -	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> > -	ret =3D regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> > +	/* Set for max full-scale range (+/-8G) */
> > +	ret =3D regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> MODE_8G);
> >  	if (ret)
> >  		return ret;
> >
> > -	/* Set for max full-scale range (+/-8G) */
> > -	return regmap_write(data->regmap, FXOS8700_XYZ_DATA_CFG,
> MODE_8G);
> > +	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> > +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > +			   FXOS8700_CTRL_ODR_MAX << 3 | FXOS8700_ACTIVE);
>=20
> Preference for FIELD_PREP() to make ti clear what you are shifting =
left
and
> why.
> Given you have FXOS8700_CTRL_ODR_MSK that is easy to add here.
> Mind you it's a noop as ODR_MAX =3D=3D 0 anyway :)

Thanks for your suggestion, I just want to optimize that I config =
ODR_MAX,
but seems
It better only mentioned this in the comment, do not need add in the =
code.

Best Regards
Haibo Chen
>=20
>=20
> >  }
> >
> >  static void fxos8700_chip_uninit(void *data)


------=_NextPart_000_0397_01D829CD.7ABA64E0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwMjI0MTQyNTUxWjAjBgkqhkiG9w0BCQQxFgQUupcyjjNOV5mTA3dqSZSlkHGY
z3kwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAEm5
Rsox19uOVDSOrntoaS+k3rjnGyzWHbPzdebdiFj8xNRQ5fEebJntx3DcB4AJqPW8BSk4mI++E2Xt
JYaaapYSRkzQGLaAq8UBqbK26XsHiS0m+Me4rz4C8D1bPUAnjXGzXMoxvb2NQp2sX95borErkjQc
AGQ/keT7hd0NjEgE35WyrpYy1UNXtLRg1grn5AXkjf1PWwDSTZNggR6skyHRUbr9ZOOE+RsKvFN3
rQzx0M92GSI38EGctjW2EBuwYa6nVagr/ffOkesznx034VKVFbpQX9oiaUg5eH1AWwuRuJ3YgKJn
rEtpuhF9z7T5Fz1+j+MMxhiyA7k34WCsU9sAAAAAAAA=

------=_NextPart_000_0397_01D829CD.7ABA64E0--
