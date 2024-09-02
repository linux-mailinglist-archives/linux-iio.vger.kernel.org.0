Return-Path: <linux-iio+bounces-8962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B14EE9683E8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A9AB20ADF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B861D1F6E;
	Mon,  2 Sep 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="lgvAh9pg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95B1C3314;
	Mon,  2 Sep 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271153; cv=fail; b=byO/EfeMalRpxgsQUZVyYW0RY1sSaM8Ief6Ia/9O57RbMqwOfMN8MZkl5qlQZ9/oJhh1gg5kOkajkxTBUNAtw6aGLExiJ1Z9Qtr3Fjv783FoRt50Aq/zqssSEr9LiptRgF8YywlZnL9dXVacj7Z39hHobAcoG7xLChYjVLgLpwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271153; c=relaxed/simple;
	bh=vIJfJ+Cv5XLmsOztS6fndw8UIhlK79X3kO2elCEYFmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rmCj1ywMNhAma3PMl9LptMLdNPgjwurKVVOG6TT5s6zRMIrQy5qcd8XXStgk3elLEDA7cpigmbNgLJV59JJMVQhzzuFbUTiBk3bZeGwFrv5UqV9yixTAjdgIkzd39bpCXUQp9XGgkduVph/xG26TqkvOy7xpjrJBNrCVn7rIiYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=lgvAh9pg; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481NQ0dp015092;
	Mon, 2 Sep 2024 09:58:58 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012048.outbound.protection.outlook.com [40.93.78.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bvhk14kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 09:58:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFB0/KMN+PPYVgyokKGBeVxn4RZWbQPf3Q2r9VUIbx1OuMKHSSgn3COf3PjpIjN1eBSFXfAE65XLXpKRRwnW/48rm8usJxyB4iGKxD/064ZPdFbZ13pzwLdb8xT4CKWJ+kg6d6/cgmYLmetgRea57nBJKJbXqiMJqHLsJimb+hnEr98tGT0o3zCW1JH4CgI/zF3qYKgigFyZztXkLXOyj6Q9AhuQltDqbY+zk68dr6Cd3dzxYUhMNIOk7bM8HP1uDn/5xgdQupt3MtW4hQJs5It4Mo71IgVBnRGh7BMzVjj8HF4HOADbDlxdqyu1wS2qH2Y5Xatn4IaNvzChk022sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgFSLmVfakuQdfVath0ePXBUadbg/jlPhIVOrJhzbOU=;
 b=sWRUz18t6szEXonYU+E8iVLlVg11WCC8K5TbKh9V+dPoIkt6sPRbi/JjkPJH4OjZm8qfUSTj9rzp6Q8D9qTzEwy5w3caow1rLzOjiPvf2GrnzbEK/is8reXYYeSW8NI7pbNdFZ9KmE126A5HvfU32vsu+wSFsmc44nKbdI9lq2YJaQBA44Z1VSAtZwcGEdGBk+xdlckDBStKngZZZ+BWdlcoOfaH7FiKsMnbGKELtpYO07xd1MLpghTWQLQJjiQgiftz+zZFFRh3H7Y/kkucTiL1brMXCJl3PabtQQwk/OlcHrQg6I/gVrQgfuaYQLwRKIKCy5jkete7vnzvuGtKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgFSLmVfakuQdfVath0ePXBUadbg/jlPhIVOrJhzbOU=;
 b=lgvAh9pg9fyRrmafjeA/LlGPPwZbkk8IQlqawMrdMDEYCaOcaWos2N0Dktjijg/S0BCM9t9PI3cuj4hFBy9KF3A4MH8rB9KYJKMT2rgcauSLoDa1VbLGrqjU+SrR84MAGvmFu4V2Gz9a60w4UnS51dKgM30QjfJolmJ+1yWywh9u6oS8sUGIqfoTQi1gQdTGvSabKSJcktWoC5/OgAbywT+wy9HT+6tKsK0j37dk5KopHwTDBSyoQwQcWqfFGNtWm8iYls4dxE+9kcmAjjpJLD+jitbZVXAdbWMFGs2I1S0UqoIFEU4UmHDNWgSqyplL/8PzO0TUhDxmhvkeeKD98w==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB3075.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 09:58:52 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:58:52 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jason Liu <jasonliu10041728@gmail.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Thread-Topic: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Thread-Index:
 AQHa9rmgqTimB9qMZ0ezhD6k7oXBDbI5M8nJgAAiAACACRXAgIAAnB8AgADWk4CAAHDr2w==
Date: Mon, 2 Sep 2024 09:58:52 +0000
Message-ID:
 <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240901152346.45b096c3@jic23-huawei>
 <20240902031145.76829-1-jasonliu10041728@gmail.com>
In-Reply-To: <20240902031145.76829-1-jasonliu10041728@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB3075:EE_
x-ms-office365-filtering-correlation-id: 72fefd0f-3147-4014-dd6a-08dccb35d9d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DcJY89FxEKgz2Yq7vp28q1R74LFUWakhPjYubJ5+cgpKWNsPUcFGXPkp0C?=
 =?iso-8859-1?Q?fO9kDQSyWvJG5sxSmVHO+PNOVzTibC6y1AaWamcfFydLbeLPSbdA4E5snN?=
 =?iso-8859-1?Q?RGrxxSusi8xtl3DAMExptmhHQ08iN/cNDN/51MKaZv2dfKJ0mCGwPEpkb2?=
 =?iso-8859-1?Q?7lHgGSi2gXLppZdZHvztB2b/SFQ8IgI8GsTd0+aP7Kc86RGkhxFdkAWrak?=
 =?iso-8859-1?Q?wjVlqxfoVGjjMQOy9dPHMFopw3wVekxpueLlagadr8zK/W6dEoK1FAxeK9?=
 =?iso-8859-1?Q?okqSH4Ygx5DA2eOlXSrHpi0RoMs7PxCks89NbocGgpyUtmf0KCjYfSI4Ev?=
 =?iso-8859-1?Q?QeVElLOSje5qXKoQAzJFPRwr7z1m/c5Kdv2Tcd+lyv4tepT9k2di+sbKLd?=
 =?iso-8859-1?Q?T948xVYCO/AD/O5nQW7cZsO+7J15hmIN3qazFlHcPrDPOYnBV5rFgqm3u6?=
 =?iso-8859-1?Q?Y1UGyfjgaCKWuJczCZIGGaTbVRkp2rmFOCUjTW5q77YHH4Q/za69lyKZob?=
 =?iso-8859-1?Q?UNUFIGJsHR5uapYo5sD6sCalqGWGdrefzODCVrIoT2z6OV74zW6wtCJZTW?=
 =?iso-8859-1?Q?CN3XkSUeDQ5ELaW5KJOCr9LG/F5FgSVKlsXQhB5WZxmH/2W7IJ0mQfHMu9?=
 =?iso-8859-1?Q?wG/JRPhIctkwk4B2icHf0Rv/tj9hwLCvIbiZtF6d2uS7k2sqPdnXq6bqkd?=
 =?iso-8859-1?Q?HF3Hya0FmuEbALwg1NQ8LVeI+35fXYbEr5Cf7D2qr3Vxm9uV5ZWomQbUnh?=
 =?iso-8859-1?Q?4beUF+zKnCmQqD+xp1Hj7LWCf4lIwo9TY4Wno6t+d4Hj1E/t1uffskLk3O?=
 =?iso-8859-1?Q?Qoivf6OxopesF+DmqIQOJXft64WOvV6HXzRZweJPYpKxIwYiBVmluf5I+b?=
 =?iso-8859-1?Q?yDPZsj5bxqxbHwOFGdNh8C9yIzFWbCb6eqR0SKhEslaHo8WZgZL49Qj+v+?=
 =?iso-8859-1?Q?9ZtBgFhKSjMOb7kQwgdIMajpB5qmfXeR63j29ex5aXjIDRx6hC5W8dSteg?=
 =?iso-8859-1?Q?fNds6hYUWHesw6bYiWKa2PKpQ+blx+es1cyas2Xe8At4R371maVlmFXoYN?=
 =?iso-8859-1?Q?3Z47WylVtMj2flH+NrOxD78D+fsBb9a3xTMQiyS1Q5EEr0vqnpLgbJzD6M?=
 =?iso-8859-1?Q?NlGfPvSxzxGeyVIjLohbQxYhvxUftJSNNk2OMFBam/gbnAGAceFIcsYw/w?=
 =?iso-8859-1?Q?mReOcS7IRB3nEsLHLQmLbG5QAHD+ydSCs8z6tZh8WYOBwSCNWmQttD1N2c?=
 =?iso-8859-1?Q?eohVsOXDGgRumL9d7njMGfAnbjhKIapb+Ye7RwjWe0ai3TwszhoYizgV76?=
 =?iso-8859-1?Q?q6LHgdgA9SvFFeHw6xPwYz//YD4doizDylEPGlbL6NGqeA9+bteO02M5DI?=
 =?iso-8859-1?Q?2e86o4jNcZWOKGi5W+ScFEVd5b9IOiwl2LMp4FpUQ1378P69H0Grx+xXdZ?=
 =?iso-8859-1?Q?hNikxTof1aTUN0DTcrxNJLdfVW/eegeuSvfvOeHKy6CVsgy2epp03GM2wB?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1CF1XJr9nrcsf96lCWrwkBXPzu+A6M5M2fU0MA+LXSFXObDim7+/EePu3/?=
 =?iso-8859-1?Q?2grkm0+MqVhz6wP8Xe+5YVXVb5+kQlJY7i+OoWQj1D/0rpM9l0KlGO/5lD?=
 =?iso-8859-1?Q?03EFcwFGhCiN7ekOGamUZSQfAyHbJDfaWyF9XNjmr5Z5gxHbZh7NpFVqxe?=
 =?iso-8859-1?Q?EBbMRFFC0kUDM7BNIcyYcIyw2Cd74h0x3sgBhacfwFxI1Bp3oS1O2hJMu6?=
 =?iso-8859-1?Q?K/I2fFPug2N4w3vyHB+zvimUwodw9HSBrpFUsFYTQA5xyeKGNeEwnpIExg?=
 =?iso-8859-1?Q?M+ckWlGf01vK+sFUp1GfcyaWultt8UzC9h4Zuto6olLR3PR7LHkD+pr8WL?=
 =?iso-8859-1?Q?OOAOfNeBeVHT3eEolPXuOFxmBohHdLu7Wyi4iflWsCRg7GcLPGKWEU8iMA?=
 =?iso-8859-1?Q?szuwXE88CD3J6tnDjqZsWGsIPe4E3aFHQjIFVnN16mDXAAB9CiEN1GdbGx?=
 =?iso-8859-1?Q?QpYG4JRcJztBi2m5YWvZWVyyW88OhdJTHgXRGr0/KvbnG1ov5oYzzvm7ow?=
 =?iso-8859-1?Q?7WiYVIsyV/pTaSJk6UpsLritLpe6g4P8STkZMkzKdhieHOHp/l9yJT3ggT?=
 =?iso-8859-1?Q?QLCSA4TltkIULR6cHYsgnRtDUax/F0E4ygISTLF3RrdeyDo1VkRx6cK6tY?=
 =?iso-8859-1?Q?oHcfOCLWFOenH1iOiluCV3IpEFHH9hAqtKtBnebZdOsxLUN6PvTynO4Am2?=
 =?iso-8859-1?Q?gRyNWROospoLuEfjAGLd8PzUlnN/ky6ZneHeSiWu+Ae5np9YVdC5oEOVRd?=
 =?iso-8859-1?Q?vba4HX0uHa/1EBKjb+Pehc+/TXBd/FP2D12GWmGTPqKILgv4r9+gEU0RMW?=
 =?iso-8859-1?Q?s55raWmB7HaMgcGxSbz7KuKND2lYySl5Wx9mOgyIBLgglOoYDPuE5Bcyq/?=
 =?iso-8859-1?Q?AOJw2Tg/X7s3Z9DZxj+clB0KhJ4IB0tBGrQDaDoQuLfk39ThzfinMttZMe?=
 =?iso-8859-1?Q?lpqyJlgJ0/Uslt0H8o1Vjbuu31jKDQojGxVb4lAjzMvo3LdKRKXn7KXES5?=
 =?iso-8859-1?Q?os2pTUecG/5wItMBbm/RDMoUS8dHbz4WcEv7gq2pfrt54fZ57CPxK9fbcI?=
 =?iso-8859-1?Q?KdbBGoz1VE4VzBXQY15Uzr41TPQUSnWlsACqALLfBfEGbbAXfSZv7dVK+p?=
 =?iso-8859-1?Q?wL9KxNa+mwOelUjSYOYG/Q+UrSbb7IsyPm3+qVvu6lVp5I7CCSjZJ3xtRo?=
 =?iso-8859-1?Q?vdplLDAcsMXWrznyj+5Qanl+dFzbZY8THJKxA7uyTL86HngOPWy3/SULC9?=
 =?iso-8859-1?Q?Dds3ulcGFiWPy1qa5XdTVw53Rwe7FFC/gIMpAw1NFK4j6W4e3jzSbYO1UG?=
 =?iso-8859-1?Q?xe+sK6yW5MJj7rPM3g+btfuwdNdZIECkKB3d0Ux5t0hw/7oAPq7oqTNB+s?=
 =?iso-8859-1?Q?s0NEIQVitbma+ybYVXKPZ1KF6JTwZST9bzpTGzPRSWxI0F6UwYE4CcvdpE?=
 =?iso-8859-1?Q?9YhVqHjd3qmR+wGldURvYPpPS86K8MgWZE82J7rS/q3hJZ8C7xa5i9+viv?=
 =?iso-8859-1?Q?4OzZevI2w0DCrieZ7TQWf0Ij8R1KbDoTJ3+xzFyUugUuQ3x/qmB0AJ71Ag?=
 =?iso-8859-1?Q?3SrOvcjXEvtxqUMled4pJcK+/AHhQKdHJ/72CMyKDD03PXARDfK1mDNs6K?=
 =?iso-8859-1?Q?zBvhMeonshgiJqhBC5Bh+rWHd/yNSI1cJyTSiyjTyuVE/qDp7KqItMWg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fefd0f-3147-4014-dd6a-08dccb35d9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:58:52.8033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPkdR9EC9Z7m3SuUMealsY3uQwvL5UvCdMMLx5VEhrSjKHvf2n0vm5tbXsu1zZPceGQUMHnmZJKDO7pwBb389Jla7uq3lUhrh+6Itt69edA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3075
X-Proofpoint-GUID: xhEsnxBiF55Y5wPwx7C3c23sIEB41ONH
X-Proofpoint-ORIG-GUID: xhEsnxBiF55Y5wPwx7C3c23sIEB41ONH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020081

Hello,=0A=
=0A=
this patch is missing chips supported by this driver: icm42686 (INV_ICM_426=
86) and icm42688 (INV_ICM_42688).=0A=
=0A=
Please add them and in the same order than of_device_id:=0A=
        {=0A=
                .compatible =3D "invensense,icm42600",=0A=
                .data =3D (void *)INV_CHIP_ICM42600,=0A=
        }, {=0A=
                .compatible =3D "invensense,icm42602",=0A=
                .data =3D (void *)INV_CHIP_ICM42602,=0A=
        }, {=0A=
                .compatible =3D "invensense,icm42605",=0A=
                .data =3D (void *)INV_CHIP_ICM42605,=0A=
        }, {=0A=
                .compatible =3D "invensense,icm42686",=0A=
                .data =3D (void *)INV_CHIP_ICM42686,=0A=
        }, {=0A=
                .compatible =3D "invensense,icm42622",=0A=
                .data =3D (void *)INV_CHIP_ICM42622,=0A=
        }, {=0A=
                .compatible =3D "invensense,icm42688",=0A=
                .data =3D (void *)INV_CHIP_ICM42688,=0A=
        }, {=0A=
                .compatible =3D "invensense,icm42631",=0A=
                .data =3D (void *)INV_CHIP_ICM42631,=0A=
        },=0A=
=0A=
Thanks.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Jason Liu <jasonliu10041728@gmail.com>=0A=
Sent:=A0Monday, September 2, 2024 05:11=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel=
.org>; Jason Liu <jasonliu10041728@gmail.com>=0A=
Subject:=A0[PATCH] iio/inv_icm42600: add inv_icm42600 id_table=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
Add the id_table of inv_icm42600, so the device can probe correctly.=0A=
=0A=
Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>=0A=
---=0A=
V1->V2: fix up the formatting as requested=0A=
---=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++++++++++=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 15 +++++++++++++++=0A=
 2 files changed, 30 insertions(+)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_i2c.c=0A=
index ebb31b385881..4e00eb130e9f 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
@@ -71,6 +71,20 @@ static int inv_icm42600_probe(struct i2c_client *client)=
=0A=
 				       inv_icm42600_i2c_bus_setup);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * device id table is used to identify what device can be=0A=
+ * supported by this driver=0A=
+ */=0A=
+static const struct i2c_device_id inv_icm42600_id[] =3D {=0A=
+	{ "icm42600", INV_CHIP_ICM42600 },=0A=
+	{ "icm42602", INV_CHIP_ICM42602 },=0A=
+	{ "icm42605", INV_CHIP_ICM42605 },=0A=
+	{ "icm42622", INV_CHIP_ICM42622 },=0A=
+	{ "icm42631", INV_CHIP_ICM42631 },=0A=
+	{}=0A=
+};=0A=
+MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);=0A=
+=0A=
 static const struct of_device_id inv_icm42600_of_matches[] =3D {=0A=
 	{=0A=
 		.compatible =3D "invensense,icm42600",=0A=
@@ -104,6 +118,7 @@ static struct i2c_driver inv_icm42600_driver =3D {=0A=
 		.of_match_table =3D inv_icm42600_of_matches,=0A=
 		.pm =3D pm_ptr(&inv_icm42600_pm_ops),=0A=
 	},=0A=
+	.id_table =3D inv_icm42600_id,=0A=
 	.probe =3D inv_icm42600_probe,=0A=
 };=0A=
 module_i2c_driver(inv_icm42600_driver);=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_spi.c=0A=
index eae5ff7a3cc1..9efbe9b7674d 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
@@ -67,6 +67,20 @@ static int inv_icm42600_probe(struct spi_device *spi)=0A=
 				       inv_icm42600_spi_bus_setup);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * device id table is used to identify what device can be=0A=
+ * supported by this driver=0A=
+ */=0A=
+static const struct spi_device_id inv_icm42600_id[] =3D {=0A=
+	{ "icm42600", INV_CHIP_ICM42600 },=0A=
+	{ "icm42602", INV_CHIP_ICM42602 },=0A=
+	{ "icm42605", INV_CHIP_ICM42605 },=0A=
+	{ "icm42622", INV_CHIP_ICM42622 },=0A=
+	{ "icm42631", INV_CHIP_ICM42631 },=0A=
+	{}=0A=
+};=0A=
+MODULE_DEVICE_TABLE(spi, inv_icm42600_id);=0A=
+=0A=
 static const struct of_device_id inv_icm42600_of_matches[] =3D {=0A=
 	{=0A=
 		.compatible =3D "invensense,icm42600",=0A=
@@ -100,6 +114,7 @@ static struct spi_driver inv_icm42600_driver =3D {=0A=
 		.of_match_table =3D inv_icm42600_of_matches,=0A=
 		.pm =3D pm_ptr(&inv_icm42600_pm_ops),=0A=
 	},=0A=
+	.id_table =3D inv_icm42600_id,=0A=
 	.probe =3D inv_icm42600_probe,=0A=
 };=0A=
 module_spi_driver(inv_icm42600_driver);=0A=
-- =0A=
2.25.1=0A=
=0A=

