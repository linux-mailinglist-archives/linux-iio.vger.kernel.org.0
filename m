Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358CE516ACF
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 08:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiEBGWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 02:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350683AbiEBGWG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 02:22:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4A45784;
        Sun,  1 May 2022 23:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpBcI3VKQQ9Ee6x1BdF9aMRtDPv15l16blyXRQCG6KjrawhrFd50GbTDu4eCpadrE7UVjiNSgehmeG63E5dIgk+a5GtcMSlPvf62kBfYrOXTPc73lFYQ8t/gjVe5sG487HTGmoSG6Q384mMSKY3dMIyegUmncIVpFoH4gZ57JWpJnB++zzD3qeL898Qzq5a8qGYgxkUpBE4SqPadY8L3EvhA0hnd6uBt4q1ic5Up4nRXC08gf1TfwmukAcYKUPHnJS3kLXmHIKs8Zg8Toj0ATBCmmGYntzuHdUQZ1b6eokt72OU3IaI7kbkxUPLklnP6fAy1IPf5ERJL1QOpVGV4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a19Jr3wiFTYvK3owI+NgS7jklHq0TUqPTFt9xZlnDzw=;
 b=Sfr/JlfUGPrAmUQAKFIZLIDI4IxN9uVRomy9jhhu0RlM83FaMS4b5hAyJPyFwXQEalhiHC/qYTz262pYrcgR0+JbloP6ZVo+JnWp3ws/dEJk7Vz/cdOSrbGwCkqCCGEuzb96t48/z8QEcWg9TqqHQ9udPc2BjyAK/3/nmjMfeuMZqFAczDxgNImbNkR+fg4QFaKDiuDBjZq+RMdIqot7obUGFlniwIcl4hWlShxFt1Y7QsEyIp5T8pCzK+dq1tZF2RLUGV5gNybpRhP8j6B43wKGptKM+Rslp1p7imx9p5zV48MujayhuCd71xRw9ycKuCOVO8kFqRskDj8r+P35pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a19Jr3wiFTYvK3owI+NgS7jklHq0TUqPTFt9xZlnDzw=;
 b=Jsmc8c+CSoy0eFWr1fdFlsR+uNt/zdpG5fPc2aArEbWEunSF4ZqeJSp0B+mGnjJJTu0eYN+spBkv84wT+VHNduvCr6HalD08mlY6knE25aew200+anWXotxrPHxAr3jErWVb4gEwpO2hGc8xWlEL2HU1xNRY8Vas0NiwfzM+rTE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9469.jpnprd01.prod.outlook.com (2603:1096:400:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 06:18:33 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Mon, 2 May 2022
 06:18:33 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpA=
Date:   Mon, 2 May 2022 06:18:32 +0000
Message-ID: <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1781d859-1696-4239-1472-08da2c03957e
x-ms-traffictypediagnostic: TYWPR01MB9469:EE_
x-microsoft-antispam-prvs: <TYWPR01MB946913620B2BCDF1CD6A3D1486C19@TYWPR01MB9469.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgpCtXxBsrs09dytk4NLV/ZFNw9irhqOgy1OpkGZTtur50to7Ims/Kx/pVq/CStGqr/WoO8ZOIYf9fBLD2rfXgTWQsfzj8v/ynMCH8U5usAr3vDH0eqPomo+07Dcsv+kqylTUUas81bTNAC9p2Bk8gjR5fDyjkXbRwB1Xe9bGFuyLS52qXR/1dT0bptJNYqZzJpNRfNSq2jp35cW6lVPDLK/tUdZqDgsdIY3CJPaXLCUz9JRD8rLxrvrJs91+vGWv8iqo5KIlU3MDWq8rjJ0/Mbf5g31TyHpZNwvOWjZ53S1cqpb+/eoWEONoK+CuTwHW2gXMiMhUc7SCSrid4FgoZXKofzl9RlOIFRbC2hMiup/rqf8mDh7MrZ5sbKpqCj8ENrwSOKybd8ktfdYTNvskt7Vm8+kT6Tunqgv8SzG1cdGZBPoZhOPf8LQMNgBmOkjDQ0Ab+TsoLFXD/bRDxsanYXGzuccHt729oa7wTujPBFJ0JjjYeHqPdr8P2atwnGS6O+t+9uzMNB24IElrfg6pp+7UMBLrZ+wrH30uGLpvFA9lrfcR0Hurhl2SErccOtu1hAzoPtvci48VnIa2o9F5GISibTRtyz1AEqDO7nUnVDMVTQg8e6zPoreYPCXoE3/QFEnP2053AVC2ZBHlU7HIMFWZVY5zJmpilcmcHsTI+aQSY3OklI2BrRC0TtP9A0jWcyU4dXeO5xhrMic1L36Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(110136005)(54906003)(71200400001)(66446008)(508600001)(38100700002)(38070700005)(107886003)(8936002)(52536014)(2906002)(33656002)(76116006)(66556008)(66946007)(122000001)(66476007)(64756008)(86362001)(5660300002)(8676002)(186003)(4326008)(55016003)(26005)(83380400001)(6506007)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?05+Emg1QleA9mHcr2jsKYZm89zJsEHTAVOQBNx3llz5pXy/h1eEVAsZp3KuW?=
 =?us-ascii?Q?VP5V7ccG4ryFYasZqv64W4KO3mf/0d6v/nRxtOglFKSFohYOH5oYEbp8z4QE?=
 =?us-ascii?Q?tfeCnU0aKtkojwiSOGHi3yNB9OqpH3uamq1qR6iVSUS8cdh6wbXaFDqtBXxW?=
 =?us-ascii?Q?S07/mZevxxB+fkurBti1Z0wWj4ozE3DJO0i0U+6hy4Ggp0rvavpNzGh6yKWK?=
 =?us-ascii?Q?P39g0T7sgyqBGhiXNgD5xbw1l+iokqyqe6m+jNGLaCT8cvzJDAxDrcALMfIn?=
 =?us-ascii?Q?5Byv2lb/IrKr+/vTlwibsBPly0gH2/B6Z2UGGvR6V+MZI/wd2n+En3HTCKGw?=
 =?us-ascii?Q?HqXjrvsVg7ar6MS7v/7MrhfttHE3SfRi7A5uYb3htG8MwgwuMpR6KpVj3dYF?=
 =?us-ascii?Q?YH3mIxiUs7xWAyWPxaK1QeJ0j2PZll0TA0br2gICTV7UQljxAkMYqA2LxxpI?=
 =?us-ascii?Q?oJ463+2V0mhooQYUEI2mhT3YoQ37YZoHcx3KEts1KfB9rkAkHPnIOQ9ohtPR?=
 =?us-ascii?Q?jtFfvaARm2pPtlpqlIC5Q8BSmup7ps+VGhe8/q2PrZ6jSnP/20YLgpVavYoW?=
 =?us-ascii?Q?TmCgdyvIVAVRvcdqoNoJnJJeSVi4VdQAxjYlkR4xZKQQ/DAzQ/vkR+36pLU0?=
 =?us-ascii?Q?EF1RZU8Q/gHitdFFoYP0wcqRMoDbacIOtGyhxtsg6UikdRmkZCVTRIgqI5Oq?=
 =?us-ascii?Q?vJPRsmkzb/i3IZZVSQ9zKWwlEN2RMBwzjSPEqgF0d7uW5irhYtARGK1y/C2N?=
 =?us-ascii?Q?I4Bp8b7I8ycMHWoWZP2LxqnAHqNvryuT1gwt+VAph+hlqIG9M9cB1GxeuCi/?=
 =?us-ascii?Q?0vrotLUwmCEHuES9SCDjM5/ogRzdQ0tC5WK3tFkFth7POcDTIuMH+clAIZRO?=
 =?us-ascii?Q?GrUfSun8XZeX6EPQybBKvNWc+litDhjGgqMqu6cGFlP08UCzF3b5z2dv4tpY?=
 =?us-ascii?Q?pXp1izRvwQtUP9l7zjtuusbn4bUXmJJBOeCvYHIn4dGMUDvCO5s8v+Gr9ju0?=
 =?us-ascii?Q?fprbtXKMDgQ7SbDeVm6HjjDnLV+9ZhtHrmNiWyXxFo3dVUX4FRFqR5eNsz72?=
 =?us-ascii?Q?VrSG1/kX3Rs9ZF70Csn9QIy2Pvag4G6QFYO3khjCGUvxgp5ZSOe2FP3q1k4t?=
 =?us-ascii?Q?rtJKwohTxnT3Gfb5JgN2+IZ4qx21ucUAeydSxew1cTaPjD1Zl/Qik4n3vPXk?=
 =?us-ascii?Q?O7m8sjssikE4WxGmsiebqzTM5XrBrz8Xq4IEg5r5+yRyRZPe9d98sunqfgmZ?=
 =?us-ascii?Q?oen4rHNiiq/DjN2dHXwNCZr6dTznQRpWDIglX5+e4x3KMY6q94VFXQeOOTe7?=
 =?us-ascii?Q?KL/Wsa5zQIEas+4zrmO0tP2CXM9eD8ZKEDhsSPviAvJ9uH5dWcpN2ya+TaHQ?=
 =?us-ascii?Q?ckChgdWugVbIf59U7URl/EPNkJ4nwpUKX6OE8KBRuaGsc+qRIZCINekNAYSq?=
 =?us-ascii?Q?MKIxo8SPoYo2KiCAAUiPDIZvsthAaltqpMypMgt9sbhY1mjKEHKCmWNAdeBn?=
 =?us-ascii?Q?XbvQAx9JWNJ0mkcYNsD993OvapEEwHP47CjHL+l/j1OpGimD3m1Xuh5gXQNW?=
 =?us-ascii?Q?HD+4Msf0FZw030s99/OKbyA4aLwlY0HEVylDM/ln3M0RAUG+XB6M+5zgLu5V?=
 =?us-ascii?Q?1UTEwU3o9D+6aYv6yIhFGPRFkF6mgfFvZKkDx+Eeg4SYm9D0xjQV+p29NpAB?=
 =?us-ascii?Q?Vx7g7Ym4dA2ZH7MBySJ5mkRCxZttea++JjqITpQkJeUuGZSL37Su2diI30yZ?=
 =?us-ascii?Q?heOtV/gRs6DPOIxjCDk5DFm5h5fO9zE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1781d859-1696-4239-1472-08da2c03957e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 06:18:33.0314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOlm/O7R34g+YCUv71SOmWk695z54RxJxwDllun9xAr0RgBple9yg+VzdJLU8+26sIDxHV0LvfJBJblp2jPm5H+UjIJNiv4bESsZMHyB1ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9469
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Prabhakar,

Thanks for the review.

> Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
>=20
> Hi Biju,
>=20
> Thank you for the patch.
>=20
> > Subject: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
> >
> > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but
> > RZ/G2UL has 2 analog input channels compared to 8 channels on RZ/G2L.
> > Therefore, added a new compatible to handle this difference.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> I wonder if this changes is really required. RZ/G2UL can still use the
> "renesas,rzg2l-adc". As the driver populates the channels depending the
> number of elements in the array passed in the DTS and not always 8
> channels. For example on Renesas SMARC EVK only four channels are
> populated.
>=20

For me that restriction is coming from board design, as SoC is capable of h=
andling 8 channels,
But board design allows only 4.

But on RZ/G2UL SoC, it is capable of handling only 2 channels. Other channe=
ls are invalid for RZ/G2UL SoC.

That is the difference.


> With this we don't have to differentiate RZ/G2UL SoC if just add two
> channel entries in the SoC DTSI and the driver will just create two
> channels.


>=20
> @Geert - your thoughts on this.
>=20
> Cheers,
> Prabhakar
>=20
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
> >  	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan-
> > >channel]);
> > @@ -290,7 +296,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void
> > *dev_id)
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
> > platform_device *pdev, struct rzg2l
> >  		return -ENODEV;
> >  	}
> >
> > -	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> > +	if (num_channels > adc->max_channels) {
> >  		dev_err(&pdev->dev, "num of channel children out of range\n");
> >  		return -EINVAL;
> >  	}
> > @@ -337,7 +343,7 @@ static int rzg2l_adc_parse_properties(struct
> > platform_device *pdev, struct rzg2l
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
> >  	ret =3D rzg2l_adc_parse_properties(pdev, adc);
> >  	if (ret)
> >  		return ret;
> > @@ -540,7 +547,8 @@ static int rzg2l_adc_probe(struct platform_device
> > *pdev)  }
> >
> >  static const struct of_device_id rzg2l_adc_match[] =3D {
> > -	{ .compatible =3D "renesas,rzg2l-adc",},
> > +	{ .compatible =3D "renesas,r9a07g043-adc", .data =3D (void
> > *)RZG2UL_ADC_MAX_CHANNELS },
> > +	{ .compatible =3D "renesas,rzg2l-adc", .data =3D (void
> > +*)RZG2L_ADC_MAX_CHANNELS },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
> > --
> > 2.25.1

