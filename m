Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2551672A
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiEASnG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiEASnF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 14:43:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9119039;
        Sun,  1 May 2022 11:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tub9qDGCGm3TXqLiTGLOtaBArWbnXMR0rGMx6igjX5ZlHfSqqK9ykg0xSbuGA+4sqfmhuN5zmXmvnebnu8IOy8x2BeEKVR/LPnitxdAZCSDAiyuci2X2JgNMq4PAtkxiLEoejLT//po5G/NRqEt3TltOz/i2/cjpUb1CErznE8daB64+n1hnggOtq8lMizjSTA+qOFgzV7NCO9BKBE2+tESkX9tYgVokr6oRAi4UCshzEPmjOCZ6R6zT14l9HARds8gW+P15jtjV8b5IYGKd/IPxY3X22p04U3OXwop98gJtDYXNwn+1mLuVgPDkY8Q76Wxmi6EbcFV5gbEkk2CGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI02r6y20Y0RwtVE8oeOw0Yq6bfnxW0j6D1ijZiHm6k=;
 b=DRL8zUvOv+RilczZS+QlLP0KU2G/scAqSvGAShP4/PfWxVx0nNUAzaWeuE5RFGT+BY+Z5Q61gexf4YufHfdtcp/l2d7LLjiAfYwv+YxBz/YDkN4Q8etKw99IKTPmhs6HchDtu+wpEOSa/RgWReXU3qQ1msaCiP24GPLaciCOb5syTU9iElZpfe4xRJPeer14q4OZxZwH109XKjWcGy8ho32nuneU/La9NwJzqWanAvE7dmYNKC/mzVLhM4z+ucE59IDdlM2ogZ1A8IOdXQK2ki3l2HXaDykBK5MOKGj3Qez5mli5UsVasPUVJhA0mTu3/TLLWc1JZaeUo13H1bchtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI02r6y20Y0RwtVE8oeOw0Yq6bfnxW0j6D1ijZiHm6k=;
 b=GN7s//MMsf+HpBCtbGdj3a0XBrGbed35Y3yHa1n1v5MFW5ye+mQmD38zEQidlP6wI5S0oX1jWgGVtYktg0gxKHTHuCv9I0yNeOMGv9eGU4XFunMtvEENPCYnRORcUVItWkdCA/Dp/BSzPG16iZ4TqwPfX408ePDUzoDYAqGWJHU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB1981.jpnprd01.prod.outlook.com (2603:1096:404:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Sun, 1 May
 2022 18:39:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Sun, 1 May 2022
 18:39:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460KT56AgAAKtMA=
Date:   Sun, 1 May 2022 18:39:34 +0000
Message-ID: <OS0PR01MB5922F15B8C38526675D03B4786FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <20220501185807.0273f96f@jic23-huawei>
In-Reply-To: <20220501185807.0273f96f@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b43ab42-ccc8-443a-d3c9-08da2ba1f017
x-ms-traffictypediagnostic: TYAPR01MB1981:EE_
x-microsoft-antispam-prvs: <TYAPR01MB198118316125CA4272903F2D86FE9@TYAPR01MB1981.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpLks+hjppVwsRtY+CSsvJ3JcmBvvyfEuhC586X4mm6IGsf6VP1B8A+TcfgV8AeL/roKWs/YsnycenYOgvzPKXK5otHLH7tbioGUbmmJFwsab8SQsQ0uCevA0lbuUvrX+vAzNGeKwHgFQA16gCZzQxQmjs60f0dOon1e0MdkWWVHJTUUDIL3z8OV0/6d6JDtBZMeGPuEGjfThrYOW4ql+1bAobQuNrkuijfFYoXQvztZP5iKpnwmPKFM+PlW2xhtnG5rmMMq9W1N6WBFpgEilO8htBxU8TUBuwtKLwxXMC8e/o8oj23PuwQAuNWGFObytB1i6OXP4B6nt//BcMZctMDR7GxQl8xAlcNPiw+KEDmVWFrMRB/5zVGvcHlZ6CIpYCdp51YfC+dfQYqDYALGcsQPPMzcVN7P9OAuhlcg3j7W1tfjecx096HfahwbNgChVRhgHWOFeD3DoQciQgpO4BFCFDhKxcHsiQ0APITfIJgMJoOFBSzvNRtpWXT2ROLRtV4cK2c5en88C0t0joSRzVBGSX96OXadi6t9iwQ9WQtOhhHb2Cjf46YSnx3amJ7fCiPDcPDDNn2Jbga5I8kCb6PqFnp22Dc0EfrxzCl7N3Rimj0H97RCd/yNyn0OGmJvz9KY+XakiBsbZzv+mq+tCdKiRkeoa/0TW/s6OaedWACnnUA69I275n/AT5a7+wTgDRWNV7rCGszL9cmOTOGCMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(4326008)(54906003)(107886003)(52536014)(76116006)(8936002)(186003)(26005)(6916009)(9686003)(83380400001)(2906002)(316002)(508600001)(55016003)(6506007)(86362001)(38100700002)(38070700005)(5660300002)(71200400001)(33656002)(64756008)(66446008)(66476007)(122000001)(8676002)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mgZOXz6DZ1NA2RRoB5sezlRd5e116fY7ZDYmmQbWjaLp+JnOCdXOF8KuVY3h?=
 =?us-ascii?Q?GuspeLOMEumW+lt8YaMM6lqbQ7g4CmbbhGGho/0nJC2UVYXjdIZGqxJAP9SD?=
 =?us-ascii?Q?QU7r/5LTNmPZNGYZMjbhzMvqtMPh20DpAdEiADC+PAxg4Eqwem9U4DEGmfCt?=
 =?us-ascii?Q?xJhei2xXhbarBCY3vUti/RF7jlT7CTMLzSZrEgoXwchEbBvGJHJIPIbJt+W3?=
 =?us-ascii?Q?LiBLvDtZTC2jgqLMEbIghYVtAOU0UBhMMHlxJa288tXJ+vhctkt2yRMjO5RD?=
 =?us-ascii?Q?PU0gumAi9XVETg6yEo69DPXXTBrxwiRLu8OPMZsxzUxUmkGOPktBU9MCy9iG?=
 =?us-ascii?Q?UFsnLF0TZyl6htL60HJidjXZrKcODFvFRw+jXy0IQJsN2Rbm3ixGKIgZsbkR?=
 =?us-ascii?Q?I4COYb20fx4fVRBIeMbKogNmm0oKNb/RlUEZjgckuJl7OKy4ySbibJIv8uVS?=
 =?us-ascii?Q?j/4i4TCjbF7cNVy6FyzJMYbzzKi3RBtnacaSu/QJKufWJ7CQlPpGI2XrdB1i?=
 =?us-ascii?Q?78sPNQz58grbs4mUmoEjnCEIZjjiJOOF93rln6NVdmXnAq5b0LmGNHt1eLd0?=
 =?us-ascii?Q?EQI1MOIhtIfG8tqylRfaqDksCMmBttZwI5E6PMRc+7OlKHOQMo1qSOEzeHz3?=
 =?us-ascii?Q?fknkwpJ9/cz/D7gPwgpcyQeWxPxGz88D0bu0yrWikuU10zbmdyscr3XJTTkY?=
 =?us-ascii?Q?rXvfRD4BHcPCG7K9er6dzoQ+J/ZGfy/0loBeC+sbCJmPQMKQ0EmjlrdobA1F?=
 =?us-ascii?Q?rtrurbefk8jdXyGy9Msc5IukdWTQ6W/qktxyt9oj0PLZioKKHPYM8C3dvjmU?=
 =?us-ascii?Q?O7Wax7TJluHDb2x/TamGqgKupIO0TIlgPq5cMiGD5n3TZAoL51fsePV3h0V/?=
 =?us-ascii?Q?mkQEZP4jEzYcD53hb8rX0e3p/G0zxtv9RhHWckoJUMmYF7aNfy7mWdElVO0L?=
 =?us-ascii?Q?AP6ijrZM+JHCtySw7/iN0CKhhEIf4V/OjPeL13cOECNGyJeAuuXLe81FWmhO?=
 =?us-ascii?Q?k2TWlNH7+PQ2ksCk0Njj/bgN3B7lQbACj0UzL5uTNjLUU+8W7EBZA2JcBt2C?=
 =?us-ascii?Q?8WfBNak9AARmGd10QQACudZFd0+e0VQOikgOaU8IRO5ADIVn1ueR15pu8zlI?=
 =?us-ascii?Q?oHMMlAPMbkcy5anTW8jSTBpL5/9pOuAhcxavvrB37fcdm3CYFyV921uGhPC/?=
 =?us-ascii?Q?ggPIRvS8QZVu6fhSxooUZ2a1aH50s4+qa01g+Gl5K5ETBqLe9tyWyj5hftrB?=
 =?us-ascii?Q?UQGmb3OjBmY5Pw1/KzeY8M5k9+vJFUGpZCqH/JY176h4LZHulLEzyOmgGbgv?=
 =?us-ascii?Q?pA//hrwsMoBZRAatGRm0VK78LXy46JTYBNq9IE5C13PetrBmLOMeZCnCdzWc?=
 =?us-ascii?Q?19FPaUyo1x41TEnfp/kgOAyda6YmdkPaSNzqYRvVvuhyBa7eY6fRS21YNEep?=
 =?us-ascii?Q?yz3pQVE+Jdop96foOvZj/r2lSUjBsP+DfJXjcSEqEtw3Kg4GFJcXwmVN+Foe?=
 =?us-ascii?Q?abR40adnCmi0lWpBFtSlwJ/FPfHwZr7dMn+iDYWNiBoz8HFq6mNY4acbTj+6?=
 =?us-ascii?Q?UeRMWLjWunHAfjAZxtYvp/AN5WYDYF1e7iHM3SP32gDdcTs2ZGpVkGYIxYs7?=
 =?us-ascii?Q?CDkrtIz1IN4XzVDsaTTnSNs6K2YpQgBYm4LBFYJrTSIWIAP25CkVpNSC4irH?=
 =?us-ascii?Q?/dSFdXVy8UV/NwxEwEpDLQMPww1SFndLOO7qF71PH0+6psD7rec1Bbnrrrbc?=
 =?us-ascii?Q?0Yc8rQzxMvY118Vpr8xUa0vcMRw7QZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b43ab42-ccc8-443a-d3c9-08da2ba1f017
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 18:39:34.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JMY8njZ29b3fahtdjo8f0IXAVJnakN9Nlct722e9UqLBd10ami27LsZmtLNjELah8+5DSFLUgG2pftQIvJ7u6HTdwHjHPx+4YAVBaZOkrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1981
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the feedback,

> Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
>=20
> On Sun,  1 May 2022 09:15:23 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but
> > RZ/G2UL has 2 analog input channels compared to 8 channels on RZ/G2L.
> > Therefore, added a new compatible to handle this difference.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi.
>=20
> Please keep the driver changes and DT update in a series with a short
> cover letter.  It makes much more sense to apply them when both ready tha=
n
> to end up with them being handled separately.

OK,  will send as a series on next version.
>=20
> A request inline to do this in a slightly different way that will prove
> more flexible if we end up supporting more variants in the future.
>=20
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index 7585144b9715..703b08254c9f 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/io.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/reset.h>
> > @@ -61,6 +62,8 @@
> >  #define RZG2L_ADC_CHN_MASK		0x7
> >  #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
> >
> > +#define RZG2UL_ADC_MAX_CHANNELS		2
> > +
> >  struct rzg2l_adc_data {
> >  	const struct iio_chan_spec *channels;
> >  	u8 num_channels;
> > @@ -76,6 +79,7 @@ struct rzg2l_adc {
> >  	const struct rzg2l_adc_data *data;
> >  	struct mutex lock;
> >  	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> > +	u8 max_channels;
> >  };
> >
> >  static const char * const rzg2l_adc_channel_name[] =3D { @@ -260,7
> > +264,9 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
> >  				const struct iio_chan_spec *chan,
> >  				char *label)
> >  {
> > -	if (chan->channel >=3D RZG2L_ADC_MAX_CHANNELS)
> > +	struct rzg2l_adc *adc =3D iio_priv(iio_dev);
> > +
> > +	if (chan->channel >=3D adc->max_channels)
> >  		return -EINVAL;
> >
> >  	return sysfs_emit(label, "%s\n",
> > rzg2l_adc_channel_name[chan->channel]);
> > @@ -290,7 +296,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void
> *dev_id)
> >  	if (!intst)
> >  		return IRQ_NONE;
> >
> > -	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
> > +	for_each_set_bit(ch, &intst, adc->max_channels)
> >  		adc->last_val[ch] =3D rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) &
> > RZG2L_ADCR_AD_MASK;
> >
> >  	/* clear the channel interrupt */
> > @@ -321,7 +327,7 @@ static int rzg2l_adc_parse_properties(struct
> platform_device *pdev, struct rzg2l
> >  		return -ENODEV;
> >  	}
> >
> > -	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> > +	if (num_channels > adc->max_channels) {
> >  		dev_err(&pdev->dev, "num of channel children out of range\n");
> >  		return -EINVAL;
> >  	}
> > @@ -337,7 +343,7 @@ static int rzg2l_adc_parse_properties(struct
> platform_device *pdev, struct rzg2l
> >  		if (ret)
> >  			return ret;
> >
> > -		if (channel >=3D RZG2L_ADC_MAX_CHANNELS)
> > +		if (channel >=3D adc->max_channels)
> >  			return -EINVAL;
> >
> >  		chan_array[i].type =3D IIO_VOLTAGE;
> > @@ -437,6 +443,7 @@ static int rzg2l_adc_probe(struct platform_device
> > *pdev)
> >
> >  	adc =3D iio_priv(indio_dev);
> >
> > +	adc->max_channels =3D (uintptr_t)of_device_get_match_data(dev);
>=20
> For IIO drivers, where possible please use the generic firmware
> properties.
> The driver already uses them for everything else. Hence
>=20
> device_get_match_data(dev);

OK, will use device_get_match_data(dev);

>=20
> >  	ret =3D rzg2l_adc_parse_properties(pdev, adc);
> >  	if (ret)
> >  		return ret;
> > @@ -540,7 +547,8 @@ static int rzg2l_adc_probe(struct platform_device
> > *pdev)  }
> >
> >  static const struct of_device_id rzg2l_adc_match[] =3D {
> > -	{ .compatible =3D "renesas,rzg2l-adc",},
> > +	{ .compatible =3D "renesas,r9a07g043-adc", .data =3D (void
> *)RZG2UL_ADC_MAX_CHANNELS },
> > +	{ .compatible =3D "renesas,rzg2l-adc", .data =3D (void
> > +*)RZG2L_ADC_MAX_CHANNELS },
> Whilst it is more work, I'd prefer that you introduce a small structure t=
o
> represent chip type specific information then have an array of those.
> Finally store a pointer to an element of that array in here.

OK. will use SoC info structure pointing to the compatible.

>=20
> We almost always end up needing to add more chip type specific data over
> time and so it is better to provide the means to do so flexibly in the
> first patch where such support is added.

Agreed.

Thanks,
Biju
>=20
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);

