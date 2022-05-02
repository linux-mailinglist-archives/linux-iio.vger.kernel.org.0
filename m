Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88475169BA
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357385AbiEBEOD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 00:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353405AbiEBEOB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 00:14:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63533BA9;
        Sun,  1 May 2022 21:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qbyxe3fStU2/uDUamtdViSAdC7p/NGBMUNBKqfegHY5n7NxDXK3Z81S6IFNC/A75v3c5h0/7NutjbDjoiKFvGKfjMJwPt1ZZF3GCa86eugOsc8KGMAhXWq18Itkq0E8ea5SwFaXeW2sz2fX94Me2+PqJC9ftd7KxMW3dEmUYyilwsOmq+QlRfIfEtIcV2RMSKrvImPfJ3Y7sGxChCMyRCSKevoOkXjFbEzn7Hre8SUElPe/WqWW2O/uj5JMgyCpSIWc0Kjf1CCixOVfrxjp5crutGtBwVtTAb8cS828hPMWZpx81nLiKkGddfInPmmeSFcBaX4t1OiLWQ4BlJAM+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmrwsltpVv41Ifcpz6nVy6dXvkjzrCBtcK4IXYKWo4A=;
 b=lXjVl+XROCEKBsgi5HoKSIejMhKOtuzk6mTRXI2cuUMRwMv3ZRQ4m1jGN4hgfEuTw2Sm87sj8EJmKXXd8AuEg5XcDjGdDGHaiNLAphgzy1P9+BeFeKhx/owLl4TVaq+6lusJ/PH2176M0ogWi+450rvqjYh+CM3I3I3LOJh4A2+3lKA9ThjtWgRbQa90KY/8neHK09svIVxNUSWt9j8dvj4O3v9akUJrlD+zkU0KKiOhKmcjKNryqc+DEp7i63r60cdQR2GrLW2L3d9nlRNW7kIPwTkjeKu/0etOxhLoeEZVduS3hy6B5qQllf57mpl8KQZIDWSH6up1cJYkntSfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmrwsltpVv41Ifcpz6nVy6dXvkjzrCBtcK4IXYKWo4A=;
 b=voEaFtlTlvsRcF+420x311e3x/jEftnObe+cPAKsuT16XXpMB2L7P2yDt0slhIj4iBCA0o5c8+Qm0bZh/2XeQ+AYHB1+MRtm/0TMggXyyKjN1Q1uGKkyG9ShCiVYDDNA5PSq3ORPh8EjbRFto3kB+xY6PrCo9zPTCvPhFUhcZfc=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB4851.jpnprd01.prod.outlook.com (2603:1096:604:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 04:10:30 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5206.012; Mon, 2 May 2022
 04:10:30 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfd6MOv31HREqgoJEzHLjIx60K+Tpw
Date:   Mon, 2 May 2022 04:10:30 +0000
Message-ID: <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fd2604e-eccb-47fe-067d-08da2bf1b232
x-ms-traffictypediagnostic: OSAPR01MB4851:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4851676DFAAA1BFA62FA78EEAAC19@OSAPR01MB4851.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlbt8FIr6KvoryOowwuHCOhzEApgR4dTrawk5B1lwUGhp28+rtLm8vNEoSyqy+G1tXCPv99sfLYVyENQKUkIjDVUWYrFCElfcDDCRAqmJRZhcwZk/7vcQQz40mcj6sMz3zgpVtL9yiwwjZuIF6LCjgU6OxA4zOvtS6/qNPZuqufdh7FLzFJgpnJ/gLm6JB7jkujnZUdHmnYtfDQtSI8ilMSxhzyAecF+27pOK8g5mKOLCYgHleRPJSGUrw2G4MsPspsUl0cS+L7mGnTqSTC/qoEh3Bk6/tEkEgJUIM89J3k6tQ6cm2xlGm5WiqSpteECxLwgY0VIEXgtnGeWlIOK29Mv9KfpbKZAfGCUyHsbDEpX7OvAougIS+3zeCefAxC9hV10D3/77JR5s4VWgCOgZH7P7JRtSfob2XVYSfOEOAg741lX/J3wuCAYIm9/D5pU4G7HJbGBXmkWgCdfHrBAwCfoNdpnKTzMlaIBsi3p8K6ucGWOoCFPrHe9Sl/psyVLYuSiBmJawfkDL86mAlVOqQbzaSrqkDOMkMuMqyxVl0W0S7L3TkHu9NFtHQ2Zlfc+aVeIZucnbbTQl49dXSiW3/cDYq3IWzuEbOaZQVbLW+/Qn68jT4tfb3KgXLXkqE6JMY3Afw4iKwVCWeMsApO/w38VzBU/TqTc4XiLj7wPjHqMFuFdZzwrr3jXnrasxavVPrZZmx+TxK5ZjdMjtKhB8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(122000001)(38100700002)(55016003)(26005)(53546011)(6506007)(7696005)(9686003)(316002)(186003)(110136005)(71200400001)(52536014)(8676002)(5660300002)(33656002)(54906003)(508600001)(4326008)(64756008)(86362001)(83380400001)(8936002)(107886003)(66946007)(66556008)(66476007)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?twMZ0DcaJVOwZEPp5qO5Gcc91fHz2djqxrI9nh2Vo7U5EWdv74mZckxKwoK+?=
 =?us-ascii?Q?iCblZynsd4+NNbhLDSg6JXet9phg7f5RIqJ0bJgcYJgz7Y3g26TJsztJeyxF?=
 =?us-ascii?Q?ziPODpmsAbtube9ydM0IDANSYuRMcJpxoCB0okRkMn/1y9Qtuc0Ho2iCqoOO?=
 =?us-ascii?Q?1umuZx037FhDXLSp3BSuFfgRDxL7lHTWVhvE7UKmxMWQIsCMKyn2pZEt/nMv?=
 =?us-ascii?Q?UxVq83yK+w9GNlE5HsBCk8eHBVH5KJb8OuohqugNPk3ujkmZTvHT6zcvmHlh?=
 =?us-ascii?Q?Y87N7J8H1tlY8MpZHnEU9dnuVX1B0PG+jFvFE+RSVv8dwoDx8LkL796t9wt4?=
 =?us-ascii?Q?57tGDUj9KhzV2QsDUOQKndhRqey2Hgz6LWUezCq/ao90x5f25C5sDvTUuJi7?=
 =?us-ascii?Q?V/ZXQ6wGtJzHyUIKiEl9xn0IM/WhRUUpSrvr9XXekxErTcicKJU1CKLFRFyk?=
 =?us-ascii?Q?VaLek5h+1QwcrQy05/iIxnNK9RKIBFiaLeEDKyJmCUBkYyBgjfR5+pZfyXAe?=
 =?us-ascii?Q?kWRA+qnFMrEd5Pqja7vTQhUqh1VBTpA9zyve2rXVMgK6+5Ie5yZJTTANrGhY?=
 =?us-ascii?Q?QelSi0ve9mJ8PRcBXpzUeOel+Zs6U2s2HNbaLbHOisBXSHoXD4sLFJEDzlRG?=
 =?us-ascii?Q?rZOOY5+C5LqOCJ4gxghB31Jd6N8fQwSW11IraQJJgYNJziAwY5kU+BiB+jiF?=
 =?us-ascii?Q?rDR/8V+CvRcD5fbWw5jS71ulp/7xelEaxQHHLsQZWB3cX/m+e7jpRMHdtnyF?=
 =?us-ascii?Q?xsBYDrZlQikt/tqjB+yY5bVlNbZm/e+3UGp1qT+ALFqR0gxhX7VRxohleBab?=
 =?us-ascii?Q?tefS7gfWp/8nbIdSqEFM40lC0eBxyySEJcZxsn6juiy76zQCLzgx3jO7sBjx?=
 =?us-ascii?Q?g9apz+EAO1lDtG01IGO0zm31FHt93G2d8ZWd0rpUBB30ACwmv0JL162jkOjp?=
 =?us-ascii?Q?ZcQZwteQVWN3CuidjEGoquw6x5yFHOQZd81qVJsUOw9yLwwQ5Bs2a1af71Zh?=
 =?us-ascii?Q?TqMFhQLhuZLR7AOVKP29hIgHiPAdaWBDrLnz0XN+LFdQIWeInx4bYDUWuVzA?=
 =?us-ascii?Q?3cf8OZbC5wiR+YINy4GnLsKibzbpfBDvXI7Rs1USTcOi76YoB1QxT4DSDykL?=
 =?us-ascii?Q?cptySwbgOCCi2BjEOGnX4VdUBDO68wSMuVHvoW52KX2Jc/7zUa9XkRJ52CVc?=
 =?us-ascii?Q?ewcu8EOoZ02FLtPu+aR8tmpmqgQXW/UOjxwjUiBbdkZnfIkyq3ot5ukbYJXV?=
 =?us-ascii?Q?uLbBs8Tga3lVmPBxvPI+e4X6wZrMT3b79p7S1xB/2YRR6CI5mPZkJY7WYj1f?=
 =?us-ascii?Q?11o+fPv3hajiaqSozNZNPM2EX/kgejAJQf0E/hVQr7Pah+jLYTWZ1tMFTCqq?=
 =?us-ascii?Q?yERe89rYMD4pC35dH9XSgR42zpcZbnsCH0N18gF2XGvYIDzn6Ro6UY7VPcj6?=
 =?us-ascii?Q?wET5W/qIBfBEfdWd64Fl47XnTtsiDzCGOg9xnqsdryo/biI4HnUcV0WxL9E8?=
 =?us-ascii?Q?3uGYfRuw33T7K16X97+qilQ/cllRJgPyHei4LVXJMlPptk7po1ad/UY9nkzo?=
 =?us-ascii?Q?mAnu7zFhYDLIDLOvIBb4/DK2kpMjfetdIeR0aSwofvFguDKyNhCTz3pet5sq?=
 =?us-ascii?Q?Kg3l22MlSW8LPKrMgTVjEAjGyOtV2rVZJXZiEOYaHleUmFffQ+Q6M2DQ+Gl3?=
 =?us-ascii?Q?DrhHyO7xfrf+l+c7QF6n2ugeDJPJlrn39rA74qCVZE3k9WWC5mRFRzXbR+IG?=
 =?us-ascii?Q?gC+8Ca4/tAzm3MGcN7MF0iRZ06S1Wth+d3U/2nO+yB99hVdunvTI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2604e-eccb-47fe-067d-08da2bf1b232
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 04:10:30.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLMVwKSsUB2UXJxgbQsBXkgc42sVt5dGMX3GROvze31/Xwut9aNOXXgCeauAVIw4LQAG4MdO3v4/rDfwyEdwsgrJKz3DmfAxCV77WRuU6mEczQLXx553LqoTWpEZjvIJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4851
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thank you for the patch.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 01 May 2022 09:15
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Lars-Peter Clausen
> <lars@metafoo.de>; linux-iio@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com=
>
> Subject: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
>=20
> ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
> has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
> added a new compatible to handle this difference.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
I wonder if this changes is really required. RZ/G2UL can still use the "ren=
esas,rzg2l-adc". As the driver populates the channels depending the number =
of elements in the array passed in the DTS and not always 8 channels. For e=
xample on Renesas SMARC EVK only four channels are populated.

With this we don't have to differentiate RZ/G2UL SoC if just add two channe=
l entries in the SoC DTSI and the driver will just create two channels.

@Geert - your thoughts on this.

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 7585144b9715..703b08254c9f 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -61,6 +62,8 @@
>  #define RZG2L_ADC_CHN_MASK		0x7
>  #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
>=20
> +#define RZG2UL_ADC_MAX_CHANNELS		2
> +
>  struct rzg2l_adc_data {
>  	const struct iio_chan_spec *channels;
>  	u8 num_channels;
> @@ -76,6 +79,7 @@ struct rzg2l_adc {
>  	const struct rzg2l_adc_data *data;
>  	struct mutex lock;
>  	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> +	u8 max_channels;
>  };
>=20
>  static const char * const rzg2l_adc_channel_name[] =3D { @@ -260,7 +264,=
9
> @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
>  				const struct iio_chan_spec *chan,
>  				char *label)
>  {
> -	if (chan->channel >=3D RZG2L_ADC_MAX_CHANNELS)
> +	struct rzg2l_adc *adc =3D iio_priv(iio_dev);
> +
> +	if (chan->channel >=3D adc->max_channels)
>  		return -EINVAL;
>=20
>  	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan-
> >channel]);
> @@ -290,7 +296,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void
> *dev_id)
>  	if (!intst)
>  		return IRQ_NONE;
>=20
> -	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
> +	for_each_set_bit(ch, &intst, adc->max_channels)
>  		adc->last_val[ch] =3D rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) &
> RZG2L_ADCR_AD_MASK;
>=20
>  	/* clear the channel interrupt */
> @@ -321,7 +327,7 @@ static int rzg2l_adc_parse_properties(struct
> platform_device *pdev, struct rzg2l
>  		return -ENODEV;
>  	}
>=20
> -	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> +	if (num_channels > adc->max_channels) {
>  		dev_err(&pdev->dev, "num of channel children out of range\n");
>  		return -EINVAL;
>  	}
> @@ -337,7 +343,7 @@ static int rzg2l_adc_parse_properties(struct
> platform_device *pdev, struct rzg2l
>  		if (ret)
>  			return ret;
>=20
> -		if (channel >=3D RZG2L_ADC_MAX_CHANNELS)
> +		if (channel >=3D adc->max_channels)
>  			return -EINVAL;
>=20
>  		chan_array[i].type =3D IIO_VOLTAGE;
> @@ -437,6 +443,7 @@ static int rzg2l_adc_probe(struct platform_device
> *pdev)
>=20
>  	adc =3D iio_priv(indio_dev);
>=20
> +	adc->max_channels =3D (uintptr_t)of_device_get_match_data(dev);
>  	ret =3D rzg2l_adc_parse_properties(pdev, adc);
>  	if (ret)
>  		return ret;
> @@ -540,7 +547,8 @@ static int rzg2l_adc_probe(struct platform_device
> *pdev)  }
>=20
>  static const struct of_device_id rzg2l_adc_match[] =3D {
> -	{ .compatible =3D "renesas,rzg2l-adc",},
> +	{ .compatible =3D "renesas,r9a07g043-adc", .data =3D (void
> *)RZG2UL_ADC_MAX_CHANNELS },
> +	{ .compatible =3D "renesas,rzg2l-adc", .data =3D (void
> +*)RZG2L_ADC_MAX_CHANNELS },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
> --
> 2.25.1

