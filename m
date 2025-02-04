Return-Path: <linux-iio+bounces-14981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A06A27676
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFB8162B3D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545B2147ED;
	Tue,  4 Feb 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="gHaPD20w"
X-Original-To: linux-iio@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020142.outbound.protection.outlook.com [52.101.169.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AA2144BF;
	Tue,  4 Feb 2025 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684254; cv=fail; b=tXw7dWJDP6HeHNC/31VjseLWqLi9PnCCnlq6hqwy66kmlED1ygDgY828L2KYUirvanD73pGyO6i6HisIGYRplRM++x7Gy0DaJF69w4/kJJ2bg+f9FADqvAEpVlfxFsK50XgzqE+M0eI0oQKFh8sQGmPDvVg0OR2wFnA7q7Yt7Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684254; c=relaxed/simple;
	bh=C1zYXLgSkpHICslaCDAfFgbeRyNlqBjCsUkTWHA8+LA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTx4lujKx1yF90KwdP9CX1Z953ugSDzV7EYUu1ea1VDhT31JMaVDV+yGpYQJWmEOKSgOQh2dSs34Ou8kqOHjzGovWstx3McB7oUBQxGtAeQ+ID+9PHqMijzQRem1JIO//1ptGDVui9aXAt+8CcHoEoq/KO6pyVv4byVG2Adqd1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=gHaPD20w; arc=fail smtp.client-ip=52.101.169.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIqm1ys10gjTGJCiHSEioj1vV3Bu7vaaW/aIXY9E97R2h2Uy/dqT4IL6siHqXzJCrhHyb6FOjZ7xrazD6BTiPHnva7ArEDbQnlE6XbdADI7KfFwFZbsjbbhOQxddMnBmA/0GKz/97qyt9Yvw8RU2JICIK/SWFmehljmrHBDjMDUktbT9rB+1u3h7kpszKrCp7dR+JQIPvjFt5WjYAC/qPh3FId6CaNMy8vxQHb00NxX5qq6HLvZAuPE5cEQcAn2YVCB0K6rJRHRJvRXchE+/53BV3LUZYuCu6FPiPjdMcsrmo1YAZlGfmBb0VMhVHK2CvCuoWZUT/tjOimgyAK4E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4zqS0lLi4dN3GToQpHKllK9t6CPxGbakw646iVp/Jk=;
 b=qL8Fuerq1GYB8ZSMfA7fzL6k3Xb2dbhmXDN9H5OpvvIHSuC9pvRi/qvJs5tHZpkLg9e25B/Liwsb/ToyYjCi1poTnQbwy2HOaPLkZ09QlTxS9pFMlLnL6aR9d8oSYSPWdG7Mq9iYFhSoUxiYMyS1CII+RvW3hdBZ56X4Xo1pIihomPkLr6wQf1vW26rGmEB+qAyJXP3Ip9GB4PP6sjerec+XFO6r3+bQWu6yp1Q/i3s/buvBsn2YkZpCg+hfhKAwJdp1ydBHpH4SoBs9bJ4PLxbtVPo/L/4Nv5VgoQXgoKmHeb9VelhSJGCTsurOXGyUy29XjbqhddNmcKAazb834Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4zqS0lLi4dN3GToQpHKllK9t6CPxGbakw646iVp/Jk=;
 b=gHaPD20wUjjKh3kjbApxboUS4laEw+fjk4SuuEo93+UFXnVvi1efP2yU0tuXf6GD88CjLkqsvnrHPXcmbLJqDRCnX8fBla7HhdQHDLTExFsJDzjD0U4nuC1FdTIa/DsIG2btKgikX6zKS45O04/wxPAMkYyvYsAcQ7KYTR85q6ntA48Lwa31QzP4LK0KYvkx6R3xP4s/RyL0DWGDAOuwjzJZLUQZtKedknJI9XSVNoI/lhjtQdW2K5Nhlj5DsNyVHnmS95b1Ffp7DQzQUUamQ2Szw6RTtwz3xeAxj35s5soe8GIqUYFQr28AQ9m1CaGSkqXq0GlQ8USplcljlYRVjw==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 BEVP281MB3741.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:95::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Tue, 4 Feb 2025 15:50:18 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 15:50:18 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Topic: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Index: AQHbPPFyoU64h9XPOU+xSgAMQsFXvbLGYqWAgG/U6gCAAXTFgIAAEsIQ
Date: Tue, 4 Feb 2025 15:50:18 +0000
Message-ID:
 <BE1P281MB2420B7C7A95A913B486A2228EFF42@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
	<20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
	<20241124124205.02453a0c@jic23-huawei>
	<BE1P281MB24209585E1552B80272D5448EFF52@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <20250204144309.000043e6@huawei.com>
In-Reply-To: <20250204144309.000043e6@huawei.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|BEVP281MB3741:EE_
x-ms-office365-filtering-correlation-id: f437f0ab-f4bf-4c4e-424c-08dd45339fe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x8xq+AGvVu3g8KyN7/x2PkZ6GtPjG57RLboc3pvViAGqaXaFeI49cwCkpzyq?=
 =?us-ascii?Q?79OklO3BK+I1Il0KtnJw7ZYQOTcXNQVhPcdnHJzLbdtI6XtxpwbHV3JgDVi6?=
 =?us-ascii?Q?PxRTXleFURmoPGC8Amf5Mxh+9sbJ1XcTFSaa5MWdSSak3K9vc0Pk4jc5Y9A+?=
 =?us-ascii?Q?KaClzH1aoEtzcH5/XVYTW90Bk157UGsSb3RXsAMrf/6FGA3h7VqVHojcMI29?=
 =?us-ascii?Q?ZG3JT7UI5YtITEFzZSWCOWOdOnvScFhlCIVxrA2D9qxPYAFtBdEDKxU9uavo?=
 =?us-ascii?Q?AlA5j45mZjWJSzJtcjgipLxrhxVRwYopE8ricB3Ls+dFXweBVDISU8CZ5ppW?=
 =?us-ascii?Q?/v6rMU2uGI6MJ4ZDGQsNolQNlEMEKY+MWN/xXBdfGPoWskk/w5UlLb7SFFDb?=
 =?us-ascii?Q?/WTE0ywspfNIHA+FGRGJxNlv972nsUotMkloCLzIw6e9mZdZ5Wpkk1JMKwoa?=
 =?us-ascii?Q?i5hcwlyIflX+nJNWgxR/ELZE5FX8wrViX4Xa9p94hHstjvlddLiMEa6pfytz?=
 =?us-ascii?Q?X1jjKu8lTxRUNEMV0eOgk+gsA3HerkVeWttUbFxpOmsj1uJqm5fFRu1ZTlAd?=
 =?us-ascii?Q?o0G+8kQseX93J+iMAM3Ik4p+JDmNhux48Nbqq0kR4wQPAQkE7WMHRNThILHu?=
 =?us-ascii?Q?qDZYms0+E+phra0vU6ntobEDKpHX9KbK5+auGc1fESZ6nsanpSGOaqbpp8Jc?=
 =?us-ascii?Q?of1VUaNETx9Z7WI4jNGmXXOrowCrNWtvLRLq8THQ4TQcfh4jfKsqTIX/zvUo?=
 =?us-ascii?Q?N8X80EtNl7BU8JQO5c+hcnlQ3k6t6ksLQvg4OBF58FbH3GdZwnaoL2Rv96gG?=
 =?us-ascii?Q?u0abSJujfPyRyN/4Z1Wk1SkWlN44gjMFmHDZwcB2rjWWYYXAGT0bS5P5KcpU?=
 =?us-ascii?Q?R+GtEqDm1HlTEEqhF6eiVdcHLxX9z4ogsEMoN2gAUoBkIZ5ol41E1/1zbCIC?=
 =?us-ascii?Q?t4gQgW7UuMUSzuodBZoXWRjo14vNHNNonXFP9MVN94bH71r98tHgagIKpOID?=
 =?us-ascii?Q?QZdanBKFPAsyAXBIbGAuXsFQoqo7PfTj2NG0NU92QapOn5oo3cNGwaJK6NHP?=
 =?us-ascii?Q?oSxzTqrM5zvMjuJCpPyVU74sNMEYP0Zo5X/kkfnd03jF8FZ/Va7a49mTRTBl?=
 =?us-ascii?Q?Ao0GKRAFTxeGEZitDbWiduL/nh4WXQ7XwTtuwbYsjBVZtXw3z+dMx2g0RPCg?=
 =?us-ascii?Q?bmOgTpxlywN4ZtnBkhLxZpjB+HjP1cyK4ute3g68PmnQHp9U0gr4qtBSrwx7?=
 =?us-ascii?Q?FUGjcf3tOq5FA4kNGSYnjS3wUaFmyjUMoubdVtwWBHt1xtgqKjxdntjjxXHE?=
 =?us-ascii?Q?iXyZQWaC3Y1Z0s2x5J6fPrhEIuRKJ+ln6r8wvSEfj/yFh60AnjgaYBQB40vI?=
 =?us-ascii?Q?agf9n/SoBU0m0G3XP0mnQ41Obwj9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?En7tAhGF7mWciPHWaxHDurebZCfBe1YNofppfhWFNtZMbibYPqNDe2g/M6bu?=
 =?us-ascii?Q?HdltBQEmREbq7/7LBKszjg8MCksBpJWqmTV0I2e6rQHSCazu9VGB6uayHKRn?=
 =?us-ascii?Q?JOIhTlEyYnyV3o0iwog7J1X4q0rjPyVB3DHNfYVgweHMfX0/mv4eqMkSCVAP?=
 =?us-ascii?Q?m1j3+FGYNYq7fP+ARXMW1PvCeRNUCSq7b0pilwKhsjGkCBuUxCULK3NdilCQ?=
 =?us-ascii?Q?wZeI0DHbgxjQrzFPTh2cVSG366+P+AUCFG5E+MTo4KCN4jEDpkVh0qbK52Gn?=
 =?us-ascii?Q?O6ivl2kIBv3aNgjfhfYOWwYz0XuL2kwYYsCtdx0LpoD1aQ0iIVuPYPGlQo+T?=
 =?us-ascii?Q?uRmfyWVkcRVoS7F9zoIIJEUi9JQqAjfqLpi9K8HV9drsTj/FT8bvZ6yTRgUX?=
 =?us-ascii?Q?veqZuR705QaZfuD9a/0JtAp9a7C5nayOCxYp8scHrjEGbdVpezycFVeCR13b?=
 =?us-ascii?Q?JPgedpuhkcdhV3IjI1okXNOZqam3QFrSCbo9Aik1DKww4RRxOZ3jPyVBEXE4?=
 =?us-ascii?Q?DpNgFwAwof4gym8TuiF8VvOGA0ovMWWzVvoTe87EmSczqAI8rRr5HGYpCurm?=
 =?us-ascii?Q?NepEbBbWinGDRxLPenj3FAQVUn5hZ5+brV33/fP1SQfJ0vJijcuPcMwulGt3?=
 =?us-ascii?Q?nRnjbr0B67InZv8V404bA1Wed4kJ/xoGCT/xb+nbnymH70WdCGKha8IPL8x5?=
 =?us-ascii?Q?GheiVQ0JNyktmLsHdbyMgEvC0Or7Myzo6didzXHI9ob/HPdV9m/Sy9LQvsy4?=
 =?us-ascii?Q?g2NWKgfTbdW2IeYlPvLiAfZoUwdWSIMYimfd34u3Pjpke7P/16hlARZQHJWC?=
 =?us-ascii?Q?xqFYNHOkVzbFZcLjvVKA8YVf9INrz01Vs2ET4v2J/1gcEPQs/lGwAMEEmt13?=
 =?us-ascii?Q?pRmR+IXQbEBW/KrgMVphrFVsf13Ml9XSUKSUv7KIe4VUSGDcPeWGRxUVJ84A?=
 =?us-ascii?Q?CKSYkUQy9AZmuacpoCYHaYF+iKmvyaK+CanmM+vuHVz7JKRrcd5HxpXipjs/?=
 =?us-ascii?Q?Xvyw8Wcd7KSohnBbL+90WHjhBvExYRksoxfnFyeEEGQOSdOLjANHyVTt1Lyn?=
 =?us-ascii?Q?qEr4QVxXon6QkNVlmK9QQknhRI7o8ebrXAsqxFjw2NoPYavINEZiSczJj1wk?=
 =?us-ascii?Q?UVnQXaIj2yVLZdJ18UyjNNyDHLFNcoi/NumQ/DhVFVnNDKzAapzkh/LMcmIl?=
 =?us-ascii?Q?6egAySPnkQT12kvlXr2cOzUspvkqR8ZtTFlxziVif2u/wdcLumdrc3dXvcnt?=
 =?us-ascii?Q?OOljbyWsImCdflgbrbja4akxJH2L9M7OLm57+VHM+43VAqViGGK0o6pZoQ20?=
 =?us-ascii?Q?wJ5CDZZIi38ZoptfKwcImv+YqyifPnG5BtL81PFheDJYbTSuHx+unqLwAOCx?=
 =?us-ascii?Q?GgPfcKYy5Lb947TxbFyoV+ATga+vJQxaSi2/ahFijdAtRXplO7F8KWyrBzVV?=
 =?us-ascii?Q?nKJARwgam4EXNTu38schpCCATKhrZ9Qfrole03SlS4f01Y6pmTWOfd7vhyV0?=
 =?us-ascii?Q?IihPpBs323didxAT77nYz7z2hysRSDgydHF45yA4jWBPeb1wC6VoCHmqP03V?=
 =?us-ascii?Q?B04+Arxgtlpe6r4TGXt/Y9aL6qYP2Ygl2qwrd6R6uv2+innvZHE5qFs60XYV?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f437f0ab-f4bf-4c4e-424c-08dd45339fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 15:50:18.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGbDsEMJxwnX0TvmzkvjnrCm5/efwvFHn0a5mx1XwgggEI/i70cMUoVgmSD5R/W90stSxIMc4mIqqw4GTjLAj11Of+bmb07uX04v9yETBes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3741

Just one more question, as I've received a mail from the kernel test robot.
It reported two warnings regarding following unused functions
ads71x8_runtime_suspend() and ads71x8_runtime_resume().
I guess this is due PM not being used necessarily. So do I still have to us=
e
#ifdef CONFIG_PM or what did I miss there?

static int ads71x8_runtime_suspend(struct device *dev)
{
        struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
        struct ads71x8_data *data =3D iio_priv(indio_dev);

        return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
}

static int ads71x8_runtime_resume(struct device *dev)
{
        struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
        struct ads71x8_data *data =3D iio_priv(indio_dev);

        return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
}

static const struct dev_pm_ops ads71x8_pm_ops =3D {
        SET_RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume,=
 NULL)
};

....

static struct i2c_driver ads71x8_driver =3D {
        .driver =3D {
                .name =3D "ads7138",
                .of_match_table =3D ads71x8_of_match,
                .pm =3D pm_ptr(&ads71x8_pm_ops),
        },
        .id_table =3D ads71x8_device_ids,
        .probe =3D ads71x8_probe,
};
module_i2c_driver(ads71x8_driver);


> On Mon, 3 Feb 2025 16:57:19 +0000
> "Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:
>
> > Hi Jonathan,
> > thanks for the great feedback, I tried to improve all the mentioned thi=
ngs, just
> > some comments/questions inline.
> >
> > Regards,
> > Tobi
> >
> > > > +static const struct ads71x8_freq_bits ads71x8_samp_freq[] =3D {
> > > > + {163, 0x1F}, {244, 0x1E}, {326, 0x1D}, {488, 0x1C}, {651, 0x1B},
> > > > + {977, 0x1A}, {1302, 0x19}, {1953, 0x18}, {2604, 0x17}, {3906, 0x1=
6},
> > > > + {5208, 0x15}, {7813, 0x14}, {10417, 0x13}, {15625, 0x12}, {20833,=
 0x11},
> > > > + {31250, 0x10}, {41667, 0x09}, {62500, 0x08}, {83333, 0x07},
> > > > + {125000, 0x06}, {166667, 0x05}, {250000, 0x04}, {333333, 0x03},
> > > > + {500000, 0x02}, {666667, 0x01}, {1000000, 0x0}
> > > Format this as something like.
> > >     { 163, 0x1F }, { 244, 0x1E }, { 326, 0x1D }, { 488, 0x1C },
> > >     { 651, 0x1B }, { 977, 0x1A }, { 1302, 0x19 }, { 1953, 0x18 },
> > >
> > > So with more spaces and with a power of 2 entries on each line to mak=
e it
> easy
> > > for people to work out the matching.
> > >
> > > Once you use read_avail as requested below, you may well just want to=
 use
> > > the index of the array for the second field and have a simple array o=
f value
> > > assuming no holes that I'm missing.
> >
> > There would have been some holes, as some register values lead to the s=
ame
> frequency.
> > I just changed this to repeat these values then in the list. Should be =
fine now
> and the
> > array's index can be used now.
>
> Ok.  Generally when that happens we don't export repeats in read_avail.
>
> So may be back to this approach :(

Ok I will adapt.

> >
> > > > +static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintp=
tr_t priv,
> > > > + const struct iio_chan_spec *chan, char *buf)
> > > > +{
> > > > + struct ads71x8_data *data =3D iio_priv(indio_dev);
> > > > + int ret;
> > > > + u8 values[2];
> > > > +
> > > > + switch (priv) {
> > > > + case ADS71x8_STATS_MIN:
> > > > +         ret =3D ads71x8_i2c_read_block(data->client,
> > > > +                 ADS71x8_REG_MIN_LSB_CH(chan->channel), values,
> > > > +                 ARRAY_SIZE(values));
> > > > +         if (ret < 0)
> > > > +                 return ret;
> > > > +         break;
> > > > + case ADS71x8_STATS_MAX:
> > > > +         ret =3D ads71x8_i2c_read_block(data->client,
> > > > +                 ADS71x8_REG_MAX_LSB_CH(chan->channel), values,
> > > > +                 ARRAY_SIZE(values));
> > > > +         if (ret < 0)
> > > > +                 return ret;
> > > > +         break;
> > > > + default:
> > > > +         return -EINVAL;
> > > > + }
> > > > +
> > > > + return sprintf(buf, "%d\n", ((values[1] << 8) | values[0]));
> > >
> > > I've no ideas what this is, so needs docs.
> >
> > See comment below regarding custom ABI.
> >
> > > That last bit is a get_unaligned_le16() though so use that to make it
> > > explicit what is going on.
> >
> > > > +};
> > > > +
> > > > +static const struct attribute_group ads71x8_attribute_group =3D {
> > > > + .attrs =3D ads71x8_attributes,
> > > > +};
> > > > +
> > > > +static const struct iio_info ti_ads71x8_info =3D {
> > > > + .attrs =3D &ads71x8_attribute_group,
> > > > + .read_raw =3D &ads71x8_read_raw,
> > > > + .write_raw =3D &ads71x8_write_raw,
> > > > + .read_event_value =3D &ads71x8_read_event,
> > > > + .write_event_value =3D &ads71x8_write_event,
> > > > + .read_event_config =3D &ads71x8_read_event_config,
> > > > + .write_event_config =3D &ads71x8_write_event_config,
> > > Definitely worth thinking about whether the device can be used to
> > > some degree at least without interrupts.  It is annoyingly common
> > > for board designers to not wire them.
> > >
> > > If it is easy to support (without events) from the start that
> > > is a nice to have. If more complex we can leave it until we know
> > > of actual hardware.
> >
> > In general, this driver could be used without interrupts. What remains
> > is the reading of the ADC values, which probably is sufficient most of
> > the time.
> > Is this what you had in mind?
>
> Yes.

I'll also change this, to make the interrupt optional.

> >
> > > > +static const struct iio_chan_spec_ext_info ads71x8_ext_info[] =3D =
{
> > > > + {"stats_min", IIO_SEPARATE, ads71x8_read_stats, NULL,
> > > ADS71x8_STATS_MIN},
> > > > + {"stats_max", IIO_SEPARATE, ads71x8_read_stats, NULL,
> > > ADS71x8_STATS_MAX},
> > > > + {},
> > >     { "stats_min", ...
> > >     { }
> > >
> > > No comma for terminating entries as we don't want it to be easy to ad=
d more
> > > after them.
> > >
> > > However, the fields in this structure are non obvious, so
> > >     {
> > >             .name =3D "stats_min",
> > > etc
> > > preferred.
> > >
> > > This is custom ABI, so I'd expect to see a file under
> > > Documentation/ABI/testing/sysfs-bus-iio-*
> > > that explains what these are.
> > >
> > > Adding custom ABI however is a hard thing, so provide plenty of infor=
mation
> > > to see if these are justified or not.
> > > Superficially they sound like debugfs things rather than suitable for=
 sysfs.
> >
> > In the current configuration the IC is automatically making some statis=
tics about
> > the minimal and maximum value that were seen on each channel, which can=
 be
> > read back by this ABI.
> > This as quick info, do you think it makes sense to add this as custom A=
BI?
>
> For max we do have existing ABI peak and trough (only one user of that)
> https://elixir.bootl/
> in.com%2Flinux%2Fv6.13.1%2Fsource%2FDocumentation%2FABI%2Ftesting%2Fs
> ysfs-bus-
> iio%23L363&data=3D05%7C02%7C%7Cc0561925fc764bf0d29008dd452a3fcd%7Cfe
> 3606fad3974238999768dcd7851f64%7C1%7C0%7C638742769956935518%7CU
> nknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCI
> sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata
> =3DsL3aAnBltvf9J7Cn0dgBXUujyc%2B%2BnGxU%2F5%2F%2FMlnmfWQ%3D&reser
> ved=3D0
> Would those work for you?

Yes, looks like this will work for me. Thanks.

> >
> > Otherwise, making this part of the debugfs, I guess you are talking abo=
ut
> > granting access via debugfs_reg_access of the iio_info, don't you?
> > And this then also needs docu in "Documentation/ABI/testing/debugfs-bus=
-iio-
> *",
> > doesn't it?
>
> This doesn't really feel like a feature intended for debug, so better to
> use main ABI. If we need to add something we can.
>
>
> Jonathan
>

Regards and thanks in advance.
Tobi

