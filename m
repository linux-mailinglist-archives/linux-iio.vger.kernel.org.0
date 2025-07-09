Return-Path: <linux-iio+bounces-21494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA6AFF1F0
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660A11C26238
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 19:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A71F0E50;
	Wed,  9 Jul 2025 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="J1kQIvje"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834F1EDA2F;
	Wed,  9 Jul 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089906; cv=fail; b=J1eJutu6mnzH7vguNYnL1IEgOL1ziy6OoH/JNZ8YVjhySylFm9z6qFlXPW5NbRp2Ez9jh4TRD1RIHz1+1OJr65bXOvpGiNK90FGv3iY9RrS03NI+vTtUbFwGKIwwB8tBHhYgJ9yuPIoL6FPKbZc1MrBc6l5bQ7DUiAqDGtzgbB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089906; c=relaxed/simple;
	bh=du9VsSWsdNJjtNNUeWxBqg4LXW4B7Dy5zao8l6/Jb68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XercP5S5B8jLtlhu8IvYQEug9iLgSjORzPptwELNDi2sELt8soVCnmZoZM01CTizit2/Zsi5hwOk7pgPmjr09VTez1wv2m6LeEb+9wCeIZRLv4WqPNPsAU9bI6A1ZkwXplcotOcxYJma6/mt/TSMmeylNxr0iJfvmBreIO+68m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=J1kQIvje; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAEPGBAMhebQDr3Qwiaccyl9kH8gdf+BDDp8f8NBN2p9nlZ91gf9jOjafqm8unrWLI8HsoqwdCa/GgGWuVaMtuY4rqGgnm0Rcu7bEcrdGeMejhvfnMYh3tOHI/F7X+8PlQuYxaUPbvatJb2kJu4pbAzk46H9BjR/CvyTzHXGtElFvN8vbqXzyR8tfPdC+GbU8gC5Hrw0p6EHxfhA9+ltcVeFIb6aLSFpxK/hE7adOrVBYoAqsguJULDnW57ovLtptFgL4wLaVamSZ6HgHRRXe8rj0RQ62riEK1s9mONP56ShDNgS5asN2wjsyhdNYHlw67DpTP9A1fJtJbDV5XU5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8tKjzTDVWNq99JRwdpYGeYuaYeeCcqiVu4WHheYceo=;
 b=lPCObtUCRAlzKmmnUyWF0f7Q4iZ+y3z95dyaPG3gL1wu+DpVbi3JQ7y1u0fjcvN3Pj9tNtDADDz2w4Tm7tKlHDLNfyb7QqZ0DHfcFFuwX2oKhVAmpNMVwQUqf+U05637PNBJlD3EtVDi/bm3O4+45WoGlQPqiaQKHTq89FeqrulmmelV68TmBHWONZ0NgLUPq8LZq5Gr5FJc3jlOOFWpfm1ouyxERTDeKJTha8JOLu29nMyHu8BMoVrzyAml7Is0yn+oZUYAB7J6ZrJPLzGLCLrgUiiKphtorp6rtnEilFaNELz4ScSTVvl6qDSZ9jj/jqXnLX1nqrQn5k2PqHRERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8tKjzTDVWNq99JRwdpYGeYuaYeeCcqiVu4WHheYceo=;
 b=J1kQIvjeSTlSXF1Nq5Z/H4rGnDvQdtp1XaNn7fEpv7ledfQfG+ADtdA9GRQONoftIZs7G0wyQT5tId4vqExRC/VUF+966z+ob5Tt4n7+i9o48wR/+WR4XvqJ/IyGg53azbWub9iLJpUzryZaI/X8kFaXLvpRx+3yvh8OpRZKNtzgw0+YOVyCJbz5gGSKuYqJ4+j4SxFfUzSn8sU1Q36pfevVdyXha8kpj2lqU4JaNgJnINDGzbNDDddkfTnR+XwfvkcIjGStkJOJqvu/KBaOgGONcdMxHRQjvctiaHXHm2JffOGL+8DKWKB3OrYDU8K1fKzXJDX99IbQZ99QiDFYew==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by PA1PR10MB8390.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 19:38:18 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 19:38:18 +0000
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
Thread-Index: AQHb7DCnxFfdguezA0CMBsJ2vkpDJrQlVJwAgATVpeA=
Date: Wed, 9 Jul 2025 19:38:18 +0000
Message-ID:
 <AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
 <20250706175328.7207d847@jic23-huawei>
In-Reply-To: <20250706175328.7207d847@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|PA1PR10MB8390:EE_
x-ms-office365-filtering-correlation-id: a028adea-02b3-4c19-439b-08ddbf2027ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tgmTwnfimjUE62zhR/KCP1ICgc0RsM6kysDH0n1g/VkYOSsLQrrTjnC83qkO?=
 =?us-ascii?Q?G3P+Um+61jtkb6zSM2WSUrDcbaZuxb7G+YkIb8sVLddzPcV12yw3SBq/OjCr?=
 =?us-ascii?Q?VGrwyGzNx5AXSeAirQdNq42ECMl5KSlWRsRbU5r8yCvD7QBvrtRl3wLuJfll?=
 =?us-ascii?Q?IS/6yluotowz2b2WC7dK2ItYVAaZEhY+k5lIFKY9Ggu32yKq8buPHUbv73rW?=
 =?us-ascii?Q?1HGQon8no+NFB/0AylauHHjX6gsAZd31wU5lvH82Ae92lwkPXyoXKfUyQugW?=
 =?us-ascii?Q?PUQXut/NdGnblA0oDXZRmMnHgbyWQC8+E2u1E4Hve/e3OHdZuAsin0inlC5C?=
 =?us-ascii?Q?frzckwdawmqtBaJAkk1bw/30VPfYf9t5+JOgGuajVW115eA+9dw/z3JQv1vx?=
 =?us-ascii?Q?l9+oZT/oov6Mbmhqp0+Vaf09WWXkjYzrUk3WcYzb5KmsucYUDnEyG1aohRlr?=
 =?us-ascii?Q?s3jLJZzPFbCl9SkC2ZYv/tsipxN34fN32TaXK9QZ8AS8QarMtBuTCjJppB7K?=
 =?us-ascii?Q?vUkA8AM5lt0xr1zimQTYAPG9lcIqwZJhWgRDAjwQ0YNB9COY9oEmyYcXZ6mu?=
 =?us-ascii?Q?oW0SM0664z8uaIFwsze+y6C4ZPrEIMFRATYZBhAH02Sfaj848wcS+xsMVtwz?=
 =?us-ascii?Q?gI8QuczMy5bD2FJwDhpqzo2x72FntkYGJ03ID84vDOPGy4biLCp8Ieah7vWx?=
 =?us-ascii?Q?ZuyvACqIrqJsGUmmQwrB9p4eRmT/pvlt1fccMhWZkRyrffPlVaGOYrdyjrpz?=
 =?us-ascii?Q?Np9MlqxNPXP/sjkcV1AVul4BcVmBmcu+MNygrC5jX8Hm7uJJKgd4aowOQw0U?=
 =?us-ascii?Q?CkVvSj2XFtC2mHk6B325h9PwKWFtXjMAywFGD1s3lTGDjBvDFvUFhp6jgMgT?=
 =?us-ascii?Q?JH3GqqbUnRn279hWMNtxPmKmsFqQ3b7txDKrlLBU2UDiERQHPHpUeSl0ozK7?=
 =?us-ascii?Q?1LXeZ9V8jYj9k8Di/JMRvFYa4seWWXP0pKHIV8mAnvh6KfvxWeiaFtG67t94?=
 =?us-ascii?Q?4ppE/2sELV+Gubgaw935PO8JM7TZyjcz7XHHyP60OIkEpbJYwZwKdOJs6WPH?=
 =?us-ascii?Q?UeAqHpDb/t1E7/CrSI5YQBbDHI7ph+iqmxyQREfu90MPji+1N4TeG55VDqDf?=
 =?us-ascii?Q?lj9Hl4CA0N6Luh99882/9EU4wMHJbhw1HSsCR0ZS+w8fCVJ60gGCcxwe79bz?=
 =?us-ascii?Q?6396UqsOjsLXhUlKqMgXZlxC2Kd6LHwQvfuJksFy8rYxFMToi6IlX/qJb/sN?=
 =?us-ascii?Q?/eTSLj9Nwf8w2V/ek9Jo04ztg9ZLqy/GY6aioMQl7plrvQZsTOZ9xuvhKYTg?=
 =?us-ascii?Q?v/2e0B6A+Ce04BEl14dr1VyuAKTQpRBGqrZ3pXEmikaKrFEW50cEzsACUIet?=
 =?us-ascii?Q?Cl/JmOtFfoXvTF2d8ps4uw5L7/yf2XWrMx6vjM5JqinMmvDVF1Kxy+3eLhrV?=
 =?us-ascii?Q?OOZCoMrdapACqy2mfPgh0GRL/HWacXGxf9bbZ9LDQeYPTwn2325/Jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/t8R/MN+d3Cg+Ng4yQur1j5E8FfkK9Ifl2HWE4ckO3Pr30LydnzekI0mL5eq?=
 =?us-ascii?Q?Fgd6u2Y6YEmVmwqdbLFadUk4S/cshmTWAxRcM22qYNHb6fkMKP82Zju2bc9P?=
 =?us-ascii?Q?MPnXo3e8ZG0TkkDVGdX3Gwey5ZCDBczUimTZHJS34FHVYPdYE8nN+mHYBiw6?=
 =?us-ascii?Q?hXius1RSfw0k+UaDolA5fzbUz1tsNwVqlJtMjPIw/tm6CvlGNw6JjQRgWg+Q?=
 =?us-ascii?Q?2yBtKAOJwGKZ1w9hdwywLOQicaySAtmpxLZkyNeG+K/TM6Q/asMl/lNyqTc+?=
 =?us-ascii?Q?O95bOQV40zkaWohtgMBKwaOv/haDHno4HD1x68WSZwUufITV6hu0WQ7sKapp?=
 =?us-ascii?Q?JiXoiiKy3NSMXmInpaI4ZZrtQr5oOnT2bZDozRzJuR9n517yPPzvGt/CoFJS?=
 =?us-ascii?Q?VMkjWo2rZNOpXA/RoXtmYJr+9k+DLfJ/MsM0Mt1VJVre+I59ESgKRrBpoxAz?=
 =?us-ascii?Q?fJpayk6Wvn5rrXHqmZJGkj9Wk91XQHAcJyfN3QiLdv7mdTGMHVotN4VwESgH?=
 =?us-ascii?Q?02ko8IdbabBZDACVCYDcPngtToNO3UN7sgaS6EbqQhyR8rvWsaQi3IMw0Tc+?=
 =?us-ascii?Q?gS9jZ/7T7SmlbO0sANg41KR9rNQgyUHI1T/Be9MKHrj7eH5zdzq3j5TqTYdZ?=
 =?us-ascii?Q?6JZTo+oRAaeAsiqeXfCLnk08qGs83j0gKZ7rqnO7DMB5asVc9IwE1BYAasLb?=
 =?us-ascii?Q?Xxa0ohEXRqAPsO9p8gcmyVwensCx/d3nB/FvJqRLlC1WkFSpOYg3VuvKNg/E?=
 =?us-ascii?Q?8RgDGZ59Gcb+ezIoW8apU3FXa3/d+Pb1sdBaz0FnuRkdSDMPZB2AUCAZdn+b?=
 =?us-ascii?Q?urS0zCM/LpB2SlGYwH8V/vfbrf+YbNmg+T33X3lRklPf7QX0r33AYGOKl8YD?=
 =?us-ascii?Q?NcDznAgPmrWkC6vSJykraMrjd3959kb31T7uA8oQGi+dRj9cznPST2LcuZ+M?=
 =?us-ascii?Q?/SuutuEIvpZi8uByuuVgTXJpYx8cSp9CWe6Al82ErmYlIZ47Qu1bQxB7tXgj?=
 =?us-ascii?Q?xht9MJlG/yNkf5bq91+gQi4aH26sYQ4NOBBuwsAsGtaPYvvedY//7WNlxnND?=
 =?us-ascii?Q?CKUCW9yxdUQSUXXS7K+vHpUh4NYLBNl499F0o+hYh6oxvuWytGgdpir/D6jG?=
 =?us-ascii?Q?9SKIPBkDVtRSplLR/uozdx8PTMDWFz2LAaE859tHWmqNVgoU8zbQgKfxB55J?=
 =?us-ascii?Q?VteS3hWtnbGAgHlJqpfViUP1AMyDWZkPXOClLn4GmBD4aDkdcuKmg6ru2pRD?=
 =?us-ascii?Q?vLdRc4s0vQpCKxXStvDGwUD9UNP227xfVa5H/nAuxkDsRsbaDHv3ooZthtVT?=
 =?us-ascii?Q?+dUwZKoAV4lFfddBYgOywcLKztEX8JeyoCqyiOZ7NkFZxOxEOk5YEQcZ5a2k?=
 =?us-ascii?Q?kXF47h2vr71T/Fh2u6A2W+UauLSQEzQ7gDkk55k8sgn+W0vw1avrJQlFff1n?=
 =?us-ascii?Q?GdCGEcq+F37nFWVNA0HjLdbkXKTZ9/DMlLR+2VRVa7k7PNrN9wppB61CnWNi?=
 =?us-ascii?Q?0/Ya4G4LXV9mjwPV6UHKPsKDRLe4iCtUPqSmIDMG/lRHoQ6GZUyHCN98ocjb?=
 =?us-ascii?Q?dO7xfhr15lFAHKOoafQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a028adea-02b3-4c19-439b-08ddbf2027ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 19:38:18.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7P25aGS0n6zjUPM0keDWX/l8of3S+ecE07bZZaJI1a/swoImE5spIhHdu9i8SOdtkvVEe4Db2TO57EE7KDJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8390

Hi Jonathan,

"available_scan_masks" works not as expected.  We test it using kernel vers=
ion v6.16. see the test result inline.

Best Regards=20
Jianping=20

>> +
>> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
>> +	struct iio_poll_func *pf =3D p;
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> +	struct smi330_data *data =3D iio_priv(indio_dev);
>> +	int ret, chan;
>> +	int i =3D 0;
>> +
>> +	ret =3D regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data-
>>buf,
>> +			       ARRAY_SIZE(smi330_channels));
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (*indio_dev->active_scan_mask !=3D SMI330_ALL_CHAN_MSK) {
>> +		iio_for_each_active_channel(indio_dev, chan)
>> +			data->buf[i++] =3D data->buf[chan];
>
>If I follow this correctly you are reading all the channels and just copyi=
ng out the
>ones you want.  Just let the IIO core do that for you by setting iio_dev-
>>available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }; and push the whole
>buffer every time.

For the most frequent use cases, we define available_scan_masks =3D { SMI33=
0_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK, SMI330_GYRO_XYZ_MSK, 0 }; and push the =
whole buffer every time.
From the user space we just enable 3 channels gyro_x, gyro_y, and gyro_z. T=
hen we enable buffer and expect that only the gyro values and timestamp in =
iio_buffer. Nevertheless, we have 3 accelerometer values and the timestamp =
in iio_buffer.
It seems that the iio core does not take care which channel is enabled,  ju=
st copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver code st=
ill needs to take care and just copy the enabled channel value to buffer.

Another side effect after using available_scan_masks is that the active_sca=
n_masks sometimes does not reflect current channel activation status.

Is some step missing to properly use available_scan_masks ?  How can a user=
 find out from user space which channel combination is defined in available=
_scan_masks ?

>
>The handling the core code is reasonably sophisticated and will use bulk
>copying where appropriate.
>
>If there is a strong reason to not use that, add a comment here so we don'=
t
>have anyone 'fix' this code in future.
>
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
>> +pf->timestamp);
>> +
>> +out:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}



