Return-Path: <linux-iio+bounces-21699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD1B0661D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277A9189A851
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D747A2BE62B;
	Tue, 15 Jul 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="T3Sde3Jt"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38051F0E24;
	Tue, 15 Jul 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604556; cv=fail; b=G8vRDWV6nVNtoNmPETtb/A9ZPBqhn3LDTti3wLKu1N3oi2OPojQMnIoz0sYsg28M1RESEqJrCJVxXQixBfyNWoHNvwdXlBwDETwfY4M8R4UHVJmcYKnGKTwWAuRgN3Dij0dJBb5QGfeibBe0zAB3AKDSuuggxh0NXeKfY8H1t8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604556; c=relaxed/simple;
	bh=50yxcJKuGOcwad8thYGdNaJO9HlghbksIImbX86NblI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PnhLMyEpcIhqyuB8SOh82F0XlqgEOUbYvN/v0xpLkaxeI3S+Km5ka5jp6RIn12yQ/8/lFPjSQWQjSOfju9IXeoJ01o++f/mEG/H9P7VSOg/2LsyV234NaTiSdKqX7/lCxXUSElsicEAU7dChJArgOnkXpUFvEdA0OHp0Q6gm8Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=T3Sde3Jt; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVSHMVrZLbR46zEMkcAkSJSWQvjQvxPcmP0N+GDmNOV82AM61PxxSqKprkCAzaqnDu1mar1llL/cHXVb7My9h5C7ETa3y+p/Ik/64kkcJzwcN10+G+JgVsluHzcJkeDfHIAwV1mOgfH7gY+gb3S8bUMOZ8PPfW+ytcjmsAOcbYRmkkrHSGexpruoWJA7ksJOJa5KYiHM8C4JrBsbV9a2trgqaQPPrhvwSdkR9LxyC45GrOz42qnm3GuHyuBIsdwUN8yd5mtA2NIiW4YgB5J8xK8pS5aPMt/i2fvoAZt5FNxuKb52qwVIFb2qb9crrJdSmzEA0m2h+Zk5pGYWcVH2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw7SGhiIf2bCKlwpSjStzKeyabV9WU2OGuxmdh5MmOg=;
 b=njUf3VGWy9afQvroiqX3TlYJncYZTPkPUCLRvAuzgX70d8hpmIKH4VsXDiLCe9Bp9K0rrcBC5FVsAIxY0N4iezez5aOtSokGmOrd7TdgkaKy0v1i9f7atYKG1fDL2Vd8Y9NkmTR9sznuj7nXSVSNMk3BATrseZaWYGKol3liheMLDFTA2XiV4aAlo7vVGGPN6Mscposee6to7AUCx6GytVvQDF+d0+nPNT9P7yAwSICWrzajjw2ywCQvbSF7VBKcQguROkwC/oHJdLqiN8EIur5DFuJqPysNVbMbHvE9x++qYTO0Sh55DXRqfm/TzdCGICv00SJZz0UkHBqhuEeaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw7SGhiIf2bCKlwpSjStzKeyabV9WU2OGuxmdh5MmOg=;
 b=T3Sde3JtHJxsThs9prhmq8x92K2CkwlkdyCWGBVZ9sE4k3TOIko//7i/i4y8deKBLe4ebO2l671olA9MV/gK/bQ76rCoseqeN6TEEbvT/0UEmhOdpH06O8VGBlQcuJp7+AUM+v1HMmJCur1i1Eb+sS1K4cDVVKQyLbYzBaIKVdbQqYrSZyM4Gk21Iw4B+6gKflvNZdgZ8l61DtV4Xef1t8c5bBlHmS7OTjgFUd1j0XI521gMaWoRDrHEV/uigd3btOXSQrUi+tQM055lFcwXVo+duCGZioHBZDhsY26p6SvxWEKZp6Ydh44YKaao1EEnrHhqrJtc7nmSXcp0Mns3Lg==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DBAPR10MB4012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 18:35:48 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 18:35:48 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenz
 Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike
 (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: AW: [PATCH v3 2/2] iio: imu: smi330: Add driver
Thread-Topic: [PATCH v3 2/2] iio: imu: smi330: Add driver
Thread-Index: AQHb7DCnxFfdguezA0CMBsJ2vkpDJrQlVJwAgATVpeCABfU/AIADa+ZQ
Date: Tue, 15 Jul 2025 18:35:48 +0000
Message-ID:
 <AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20250713144214.6ee02f59@jic23-huawei>
In-Reply-To: <20250713144214.6ee02f59@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DBAPR10MB4012:EE_
x-ms-office365-filtering-correlation-id: 2655f13f-705d-45ed-42db-08ddc3ce6b1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hnfB5x1iQgVn+TBIm0oreQ7TPTr3bn0Hml6bXKvFAFzLW+Z3fF88XmFLdZxM?=
 =?us-ascii?Q?UXz9Sm13N1YVIjMDk+42CiBt0eDGJKCUXVmZqvJ7mkC8KnK4XNbeQH6mQIdq?=
 =?us-ascii?Q?FdD/OuI9IA8g8L0Jj02uUomvtYRytKmsVh/TY/9IF4xsB71hOUIGXxhdLF4V?=
 =?us-ascii?Q?i1N+TvBia1w+RIFbfpkL1yaWvK8A2/bFNI5/K2r1vetRSkcFakKlitBGD4U5?=
 =?us-ascii?Q?+aIXgPZRUgRCk/XoglMw439KdTbB3pyyDlKW2ehIttjPowD/QEqfB0zOPCQO?=
 =?us-ascii?Q?G7XvATL1rgfGuXFeVyDbo5GJiX71z0lmdWqIZinsO79U7lmkizLxiMotvuS+?=
 =?us-ascii?Q?P4JGqgES/iSbJCLGEFymlQ+uQtH4Aj5rxoZaKwqTbXGu4gdYxwzKpc+bV2m4?=
 =?us-ascii?Q?em2fmia6QgsdTYoK2jo6qcsRvoMR3sJ5NNxIagKWHojwRugknIOkw2l/WXOm?=
 =?us-ascii?Q?BGcORe6+LV+1WWf5VQ9C6TYJLCcqarYSirF46TdNaPE+OfjPuUYOKzQttanu?=
 =?us-ascii?Q?tmmZZ/WC1Zg6MObHi0XKW+xPAtNml9Sx25ITFxS2ULB9O2Kzurv9Wylc52tW?=
 =?us-ascii?Q?JONGc4nvidh/8xS4XDgALBQP5UO0oDmzsCkaIj1btnBdbQhLleUaYDA1BNBF?=
 =?us-ascii?Q?4G1poKZuoT2Y/p1SVAqZPptJ3f7s15bU1ooWhCxkT+SwAWXPoHfejpV3p9RW?=
 =?us-ascii?Q?jXZ+lYn7Dr1zBsEYbU9PPAkaqVUf2CQhaccgVphTsprU3jKuvi/b/M6/IxIA?=
 =?us-ascii?Q?mi6vbVJRiBzvJJKyiopLwG0LmbT539Wwl+1RzS9BTlJiRtg5lxBZLMiRUV0v?=
 =?us-ascii?Q?Lsw0eeuDkqQMSDKpjKkBl12oU9dmKtoDth1YqU7twoUgOeUR0YnzzYtKyO+e?=
 =?us-ascii?Q?BI8mE/lQFiAK55TmNuH9m5NLB9J8rZ6LdnSZBKYgbS87zddbXBAfuFUH7Zrn?=
 =?us-ascii?Q?D6IqHEjxZEJuJaYj9rCDYD5kduqrruw2hCXwopZ44hFjfEnUg9Yika95iapy?=
 =?us-ascii?Q?rNfEFmQCB9jKccmDHdVCWzunT3N6JjXB2r+xA69gmfLJhYIUawsFOmuLGQIA?=
 =?us-ascii?Q?Ikghhze3ap/FnR6B/zSY9cNMp6KDa1LxCsZNUUrjqrDn6e64uQHT23dJ0njd?=
 =?us-ascii?Q?b7EyTlT7FhR0Od1lAaEV4RCV2bvsqesMztJM6hpS3zoyGxuB6F0lvI5KVaJt?=
 =?us-ascii?Q?/yucHPkqb5PQVwVCg1NoqgCLKqEU35ShMV8DpCI21KXyWRU2meUa2tp4ec1t?=
 =?us-ascii?Q?tEG6yuRhYkw5l4cA0KTRlbseAVLOOFp50AZGlZM0hPUsx24Vv6PLnE/uZXoS?=
 =?us-ascii?Q?EaPZXMFZJ9b1Wj5VUAcjp5RJedxLtggS4CP+D4pi8erADdBVGAAlqqgyGFxj?=
 =?us-ascii?Q?Nu5P1EtFregXdjKfAe5+ZaAzr5CGJkyB8l5vR75JASEjob/5AoQfAiLTNoMh?=
 =?us-ascii?Q?Mym7nW8P3UNPEIpZ/eut2cCQGKYKMQwkx8xjJ/0qVlptzHTDfyA8dg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C4wtx01vhVxpbVToRXd0yWx5zwcl+WAtfUKWzsVcpsD+UJAHsasCYHXPUm7p?=
 =?us-ascii?Q?N2EMssnwmplszg4NgMq3VUQO2cehBEr+o57xslt32uOwWjuaoY6/Zd9BD1DM?=
 =?us-ascii?Q?InGuux6GzSCVo/qVe3Zmt+ljbVjyRc0QZbsDNEgQfeCmfSfAVchfj/r6HM26?=
 =?us-ascii?Q?HZd84UEoXI2jApsG9xf6IXaoSreT3diTqMXTyai9saQB80pyD5FpUlD6MiM3?=
 =?us-ascii?Q?iNbhNlhkFIzII+40RWQ/u+Qv4H5/oPZyOHJswRf5JTsBzRvXcYWUlFGDRTAq?=
 =?us-ascii?Q?eCEsYDu2jjZJ8QkyVwUpBpCbKMdmgPtjvDsonRV6fyxCEL2Ofv4/7m1x5dm+?=
 =?us-ascii?Q?nDRbtyVTkh84UggDz+6TFDEkBQ+a11kw8uPJAB8LkDBwUp0P2v87s7ejwxjO?=
 =?us-ascii?Q?t9c/LH0r9PWUHP14ui7x5a5mw3TfBiTImt/LGvitWl/zEC78NmPslpV2abIb?=
 =?us-ascii?Q?cax7v+39tCA/sriPjdnmd4RS0WBpm+GTpCh2m/egMfGIxLovGBVEpfcwlniG?=
 =?us-ascii?Q?ApNhcFz0+l5DWVXDlHyLTpiVIzQKwgW9ZHA6D3tZY5LMNnnnrK+1q1FBFX+3?=
 =?us-ascii?Q?FBKrEVsT/pjs8fsPPTZqPyKFU+2jcy7KAlexg+d2RRbHsC4R7R3LxjtYKr2l?=
 =?us-ascii?Q?pxhpPqJh/MdSfzIeM6CE6LYZp7Uyu0cJ2Go+nUR+6sA4dfawTnvD/fFQEwQ7?=
 =?us-ascii?Q?GBSNQ9u7ZYQCo8yLtuMDEZ4as/59nctu2zHWTSqWK7D0tn/XFgFH4I9L8tp1?=
 =?us-ascii?Q?Yjei34dCqZSaWzwcB4jaMXpLG3Y+QQ7g3JHzqYGaTqqC+KBPe99a5UJSHFmK?=
 =?us-ascii?Q?LeTl4E4sw9UjrA0eoVJD5LateRly2Eil0eGGhWZjfjwQ4Fm7A5RiHyRwoX5N?=
 =?us-ascii?Q?Y6xmbtVqEMcZ31zjC0cpgK/3zqCTXFDDTM6d/HwQKe54BiiQ4yWZrWj2wkNM?=
 =?us-ascii?Q?/U4cIddIrC4Qkvgd0FYZvyHHyfkbc7A6d82CaLQpU8wvYh7SXYWZbrV5NCVR?=
 =?us-ascii?Q?yjNrJh/6aeMx++3gcgVWYxtZIAWOVHLYQmEYOqKbw25t+FWuLgdk2Yxo61SF?=
 =?us-ascii?Q?pZ1hx4VzENRe6xy5CYGvAdm/8onRSIi3NsrAUX+Ls2sPOtX9wNegGOK1KwGC?=
 =?us-ascii?Q?pEhbu6GLuSWe2maUQOt6XyGQ4iXIidpA7nxNBUFS/wI8VdOoUXlxyTMJcKfm?=
 =?us-ascii?Q?9oyC+4hUcL4BTy1hWhrz6taDZNNepTlPzxzFo+RdFhUysj2fyuMXQ25glCwi?=
 =?us-ascii?Q?5FUGpmFTCex2InBSOZJqhbDjeky3uMBNFWDwTzfCewSFzQPiS9iplrPjBI3k?=
 =?us-ascii?Q?uy8HtEIW1+Asfi10OUNVlRdMpqUsgz3Tsm4b5jGeoDmdj8UQYN4hIdasT5Wq?=
 =?us-ascii?Q?ZbOz/+x0ZMjB635gG3K1XHvaJU9ZiuO9Er9iJCDb12xEV3HOvMYFsBq02Tfx?=
 =?us-ascii?Q?LhUpHP71G8Fl9c0XkdMItWqOAgfKtRsc7gx8GlZ8TEZ7Ff4u5a9vXfVW/0ap?=
 =?us-ascii?Q?SakcNnxxwfKvdWr1VZioWwbBgFNd4/Wl3b1U2bY3CKouXp4C6eOKF1YAk8W9?=
 =?us-ascii?Q?NeHM2j/ECk4x++AMiRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2655f13f-705d-45ed-42db-08ddc3ce6b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 18:35:48.3556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaAIlPQKuXzul8Ykof7lCSgIg85q0+pdbjrM6vXxp4TZ9sAfbMQZFtVS+17GC+UtnyCkiehP3VR71/VWkp4hQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4012

Hi Jonathan,

as you suggested we just set available_scan_masks =3D {  SMI330_ALL_CHAN_MS=
K, 0 }; and push the whole buffer every time.
We enable a subset (3 channels) from user space. This time the channel data=
 is correct in iio buffer, nevertheless invalid timestamp.
See test result inline

Best Regards
Jianping

>>
>> >> +
>> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
>> >> +	struct iio_poll_func *pf =3D p;
>> >> +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> >> +	struct smi330_data *data =3D iio_priv(indio_dev);
>> >> +	int ret, chan;
>> >> +	int i =3D 0;
>> >> +
>> >> +	ret =3D regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data-
>> >>buf,
>> >> +			       ARRAY_SIZE(smi330_channels));
>> >> +	if (ret)
>> >> +		goto out;
>> >> +
>> >> +	if (*indio_dev->active_scan_mask !=3D SMI330_ALL_CHAN_MSK) {
>> >> +		iio_for_each_active_channel(indio_dev, chan)
>> >> +			data->buf[i++] =3D data->buf[chan];
>> >
>> >If I follow this correctly you are reading all the channels and just
>> >copying out the ones you want.  Just let the IIO core do that for you
>> >by setting iio_dev-
>> >>available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }; and push the
>> >>whole
>> >buffer every time.
>>
>> For the most frequent use cases, we define available_scan_masks =3D {
>SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK, SMI330_GYRO_XYZ_MSK,
>0 }; and push the whole buffer every time.
>> From the user space we just enable 3 channels gyro_x, gyro_y, and gyro_z=
.
>Then we enable buffer and expect that only the gyro values and timestamp i=
n
>iio_buffer. Nevertheless, we have 3 accelerometer values and the timestamp=
 in
>iio_buffer.
>
>> It seems that the iio core does not take care which channel is enabled, =
 just
>copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver code stil=
l needs to
>take care and just copy the enabled channel value to buffer.
>
>Look again at how it works.  If you provide ACC_XYZ_MSK, then your driver =
has
>to handle it.
>available_scan_masks is saying what your driver supports. The driver can c=
heck
>active_scan_mask to find out what is enabled.  So right option here is onl=
y {
>SMI330_ALL_CHAN_MSK, 0, }  In that case the driver never needs to check as
>there is only one option.
>
>Then if any subset of channels is enabled the IIO core copy out just the d=
ata
>that is relevant.
>
>
>>
>> Another side effect after using available_scan_masks is that the
>active_scan_masks sometimes does not reflect current channel activation
>status.
>>
>> Is some step missing to properly use available_scan_masks ?  How can a u=
ser
>find out from user space which channel combination is defined in
>available_scan_masks ?
>
>Why would userspace want to?  Userspace requested a subset of channels and
>it gets that subset.  So it if asks for the channels that make up
>SMI330_ACC_XYZ_MSK, if available_scan_mask =3D=3D { SMI330_ALL_CHAN_MSK,
>0 } then the IIO core handling selects SMI330_ALL_CHAN_MSK (smallest
>available mask that is superset of what we asked for) and sets
>active_scan_mask to that.  The driver follows what active_scan_mask specif=
ies
>and passes all channel data via the iio_push_to_buffers*() call. The demux=
 in
>the IIO core than takes that 'scan' and repacks it so that userspace recei=
ves just
>the data it asked for formatting exactly as the driver would have done it =
if you
>had handled each channels separately in the driver.
>

Set available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 } and push the whole=
 buffer. iio_push_to_buffers_with_timestamp (indio_dev, data->buf, pf->time=
stamp);
We enable the accX, accY, and accZ from userspace. And expect 3 acc values =
and the timestamp in iio buffer.

Raw iio buffer data:
00000000: 3c00 d6ff 7510 0000 6100 f3ff 0000 0000  <...u...a.......
00000010: 3f00 d2ff 8910 0000 0300 f6ff 0000 0000  ?...............
00000020: 4900 dcff 7a10 0000 caff 0100 0000 0000  I...z...........
00000030: 4c00 d9ff 7910 0000 2f00 f8ff 0000 0000  L...y.../.......
00000040: 4b00 d9ff 8410 0000 1f00 0800 0000 0000  K...............
00000050: 4700 daff 7f10 0000 3b00 eeff 0000 0000  G.......;.......
00000060: 3f00 d8ff 8410 0000 0c00 0900 0000 0000  ?...............
00000070: 4600 d9ff 8010 0000 0e00 0800 0000 0000  F...............
00000080: 4700 d7ff 7d10 0000 3400 feff 0000 0000  G...}...4.......
00000090: 4b00 d4ff 8010 0000 3e00 1200 0000 0000  K.......>.......
000000a0: 4600 d6ff 8d10 0000 4300 0000 0000 0000  F.......C.......
000000b0: 4900 d6ff 7710 0000 2500 f0ff 0000 0000  I...w...%.......

Converted value
0.015625 -0.009277 1.024411 589929
0.015869 -0.009521 1.040769 4294901719
0.020508 -0.008301 1.025632 458712
0.018799 -0.006836 1.032956 851960
0.019287 -0.009521 1.033201 4294836275
0.015625 -0.010498 1.031003 4293328982
0.015137 -0.010498 1.031980 4293853176
0.015869 -0.009521 1.031492 4293722141
0.018555 -0.011475 1.033445 4294311886

The 3 acc values is correct in buffer.  Nevertheless, invalid timestamp. Th=
e timestamp is actually the value of the gyroscope, which directly followed=
 by acc values.
If we enable the gyroX, gyroY, and gyroZ from userspace, then all the data =
is correct. Since the gyro values are the last 3 values and flowed by times=
tamp.

Conclusion: Setting available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }, t=
he iio core is able to correct handle the enabled channel data, but not the=
 timestamp.
The working solution for now is that our driver takes care and just copys t=
he enabled channel value to buffer without using available_scan_masks.

>So the aim is that userspace never knows anything about this.  Just set wh=
at
>channels you want and get that data.
>
>Jonathan
>
>
>>
>> >
>> >The handling the core code is reasonably sophisticated and will use
>> >bulk copying where appropriate.
>> >
>> >If there is a strong reason to not use that, add a comment here so we
>> >don't have anyone 'fix' this code in future.
>> >
>> >> +	}
>> >> +
>> >> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
>> >> +pf->timestamp);
>> >> +
>> >> +out:
>> >> +	iio_trigger_notify_done(indio_dev->trig);
>> >> +
>> >> +	return IRQ_HANDLED;
>> >> +}
>>


