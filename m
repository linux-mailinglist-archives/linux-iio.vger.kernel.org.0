Return-Path: <linux-iio+bounces-17480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767EEA768F8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F061C7A4627
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2021421B;
	Mon, 31 Mar 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="R4PB3Uxt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011921ABDD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432556; cv=fail; b=PdYpoSMkvGM7pDr9a82V6VdNW8nkFdrl7PbO97U7waDezqPIeS9IVE0eSXoASjkf5+1/PjF8+/DxR5/KWuBSGZsK6dXpb5orG8sZkam5wRT4E+13OCeWJ/IAgDf3PvJhnwV+wpYqKKABoPu60BPpPDuuJQjtsteulwiY5LXFi84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432556; c=relaxed/simple;
	bh=BM4NdD4QnqxK5e8QvdJgXEFsG64PWgZcvDhWznpIrCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGlZjIWs5Gv8BEx45y98b48mXUOYdoLabYEJixbDlLjnbQ2uILBA6b/P1SblF3+LglH6KvpZFNzSAWPvCNQNZE0ALT0QjuTxgdgIPTrTJ/4ZOFYhCHKXTaXksfrcP5sgSUAkWBlq+QZQktGFvlJvf+6xocg1rP7L1fJ/SOmj4pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=R4PB3Uxt; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UMnuLJ002954;
	Mon, 31 Mar 2025 14:03:30 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012054.outbound.protection.outlook.com [40.93.78.54])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45p7839n15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 14:03:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xemk9klCnnjXWmIsOfwVvg7p0NRAFf6M3MD1nXKyPqbemKkxEUXvz8DNVXZWzC7ezsbI0dcAqdoHtAiOk+KaG9RTshyqjs52ufexjbADMG6Vmvyu0jToczI2M80wNTP2yF9zvMavn+gSRDkxcpDlr3wQ9KypnXBuDolrHy/4Ysgh7YLOFKY6c+DcguSbw1s1oA/XLq88ndCO2+YbJWdGxV1fwG31tZN12NVcLg+ro5WvBjt/s4oD6/XtwtB/QGrVyzl4DIsmzbZ3rpZCAArVJW4/Can8g2K3GZxZCzAVUhgMo5uQxaGWskbLCUl3vnP4K1FaIxZRKLqbgtN4X5f8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alo/BhDrQkqoV7KE4Syt3pj7FkpAD8z82Cf+g+125+E=;
 b=lwjqPouAitz6JODAExRvd6fJlBNX2Ht5lv9hvoxXo3qFJap+Yjgj09xtl7LI4ym8MNEy/zFlN/9+0aaXoJKu5tJwPWffqVJpXb7Mjv+chdbHPkH7jrGDi2Yye+Bl2/arD//z7A9QfqfvluIp+a3EnjTYLKABMkY7J0tAoImILbO6Y+WP0SndTytOXqiEBlyK/T4/85r4OqrVnQgRNO9uOeIY/iVTZOCky3YknCqIsNZcljMjfKQ8BjbY+oJrhYzbPr0bjVQjVSGWtI8jmVoEmkXUA0WONwUyubYb1B2cFhEsN0O1WuFdKuchkuS0QSggE5l8W53i3uGObjn/elPbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alo/BhDrQkqoV7KE4Syt3pj7FkpAD8z82Cf+g+125+E=;
 b=R4PB3Uxt6aDJfks8M3LO6ZjsyEThgBzpIQPIyUJipOF2FrEunW2piT4GaqaTC+Se8TE+6OdQyIjJeMplGsNTw2H48NTjjiOhlgpWBnCyL483VHvV/Ub0LwRCOf6+0H/RZpxeQXbtmfYTZQAi3np3ggwiTfzpgGhULOTx8TaPZgZQIDdPlZJMwNMPgQ7WGob/0dqiTPjsEGhkrGJd7PZR7LBgaYrqPC8wjcFZEjhmms9KtgOYYmTB7Qjgeta8WQDgjd6OMdWLnh5XvKMCa9NusjM+mleumGwXVCm/SMjQGZJYJGiBnzZSAVRoQhkFA1t70x4P9S4QoMgaIkJiW/ZwlA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1PPF1765703A4.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 14:03:18 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 14:03:18 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Roan van Dijk
	<roan@protonic.nl>, Jyoti Bhayana <jbhayana@google.com>,
        Nishant Malpani
	<nish.malpani25@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>,
        Shen
 Jianping <Jianping.Shen@de.bosch.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Yasin Lee
	<yasin.lee.x@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 25/37] iio: pressure: icp10100: Switch to sparse friendly
 iio_device_claim/release_direct()
Thread-Topic: [PATCH 25/37] iio: pressure: icp10100: Switch to sparse friendly
 iio_device_claim/release_direct()
Thread-Index: AQHboja64orWkks+OUugtB27GaN6MrONRjFV
Date: Mon, 31 Mar 2025 14:03:17 +0000
Message-ID:
 <FR3P281MB17578BE32115204381D45D56CEAD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-26-jic23@kernel.org>
In-Reply-To: <20250331121317.1694135-26-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1PPF1765703A4:EE_
x-ms-office365-filtering-correlation-id: b95c4872-f8a6-4ed2-a90e-08dd705cc959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8p9XxbOqFqqLqOISvLXFR9dB8MntQ+ppmaAW1F0PoCxPuJYBDUvFa5biGh?=
 =?iso-8859-1?Q?pfX1HYvpTtcJCQVQmHmxP1iNU++idT3VQi83KhRnJ7IE4zASyzve1ZnWHF?=
 =?iso-8859-1?Q?mAuyonkfXq8y14fHsVbEgSvqC7mPd4NIaZgvBXp8Zx2qUFSm/3bDjsHJmb?=
 =?iso-8859-1?Q?wcDiqgrSIsJTNtRye++xHAXmPqGVw0MX0jmaoO6H5RM4xPGI0xbQ0eGxoP?=
 =?iso-8859-1?Q?sJsyxPZmKBBAWcq9K/rZxf6chCuJGA5zOaeSlb3nPMzFI76NGNFtvozJ9P?=
 =?iso-8859-1?Q?x8DFHpByr8nCo9l9ILQtyZ9CHzJok36SPyIIQw/55VZndouyThSfLCPGk0?=
 =?iso-8859-1?Q?ngvDdk/flNX37a2PB3qA7MLrLmInSzIrtjRLt8P1EbdQJHl7FmgUALChUI?=
 =?iso-8859-1?Q?j1Ry1h5sHjYW+th9Jo3wOmMpO1zpiWjs98JuTujqgjTPMIRro0azDNKK/8?=
 =?iso-8859-1?Q?gPOyFKLjGqpvKzTTRkYSDrK7QmVOOKebWHBYulKN0J90wa6K2fplJYGvoR?=
 =?iso-8859-1?Q?Zhqky3x2SO0viWih6/BSVins9bT0Zj17aHRXnd5krIDu0/UCWa39ctYmvR?=
 =?iso-8859-1?Q?v8XVoSqeHP0myEkvVgez46H0irbJJKGXSTdIfglliGSJDOZJse9mYgskiG?=
 =?iso-8859-1?Q?36CKqaMl2DTzq9cVTQsjY5C9BAbE+ymql0hdL49N2XITOdxZGailEkfkAY?=
 =?iso-8859-1?Q?KbdS2xLFPEsGLVpHsNw6YcYt3S/xK7eMIFOopuQ7dDbfgXFXDMW4PCknDQ?=
 =?iso-8859-1?Q?M3aiaOk/m5haWr8KOObBtOtMdG3ne0GTzoZq7G/tVH1WqHCfSTkFEvOyQA?=
 =?iso-8859-1?Q?J/oCd0yJByWXHAvyn1dd0UuFjYevSWKl/VVkPlrHLGIRRgdey8LxA6MODn?=
 =?iso-8859-1?Q?wyMG3/wTMWRdmDQvqQsp+u32XOC8QSQQC40lkFlcSvMmsxz4kkghQjEXWv?=
 =?iso-8859-1?Q?uA8sLTnSJX9dxt76MBeZTcsO6LiHiad0zjR9JRJfUcAzyWHsCuBO+dd9XI?=
 =?iso-8859-1?Q?65xiyjLopeASjeAY44U+aDwFEX4LFdkN+HFqjQ1Ky3dwCeHLUHE4Hp0+Lg?=
 =?iso-8859-1?Q?PY9R0bVWK36rtBSlfADrwWn93aTEysWOHf3cGE/8hxXPmw7cpsMgUKqEAP?=
 =?iso-8859-1?Q?ZzCq/U0xWzLBD/S/BzVT6hnkFdu1J0vgQThaE2hc9OcdXYFzDqM/RnToKP?=
 =?iso-8859-1?Q?ZTTPpNZlo967k80DhZBz7fBsg2wB9d085WFabNKwjWp02cQzB4Td8tQQV7?=
 =?iso-8859-1?Q?4RNMfXJtXbIIlHy39hgW/yMYEOZRIdwURFhYi3rxuqrm2Qvca0duv/sflT?=
 =?iso-8859-1?Q?W7ewSpewmRqIXupAg+NgfiA4GZB6hMpP9dZ4q4ozZeuKtOI3HHAhKUrDOt?=
 =?iso-8859-1?Q?AF/wPPUe/QLH0PZVEtodFDCAS7Y3y16r75avAv3f45heqzCibcThplF3eR?=
 =?iso-8859-1?Q?C+SctBaIPgB3ppA+GxEmwAVo8Rw8YPAj8i1Hwrb2OzvD4+gz6ojYy5qPc2?=
 =?iso-8859-1?Q?BOEiv1MZSK7otLGVezmK8lOGHEMlRdnF+LOxH50MXpNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mTQOdErXhKm/zWwuIRHwZn91ODvtPNMqQkAZVqrFwaVDyZPodFlMD6EYt+?=
 =?iso-8859-1?Q?41wA0/TeSnYm34EwU3F25drv2sTGBbl+SZxvRIccTz12yMuQP2lnXZ7X+f?=
 =?iso-8859-1?Q?C45LLsqevsh4/pwQRhLg5vqHI/l0Y8r+6/56yHnaLgH4TFkg5toIkJCz/P?=
 =?iso-8859-1?Q?1/H80XzEuHfNKMIaCuJhjxhviacX5k9LPhRc9ZA+wrbhfg4UimCMNkNnr4?=
 =?iso-8859-1?Q?ZDriwhxhFzGdriwuY5tZSSjwATn96vov89XLBquV+dgkeeHb2kvBI1DMbE?=
 =?iso-8859-1?Q?MaQW0mAPo3CeePZckJ9o2PkIOJTkM9uLOcKpmJuJOhvS17Q7HVKG0oLORd?=
 =?iso-8859-1?Q?tp7AIPO7H4bRVxrLxWsL6xtu9gCjuGk3GM0/RrZbBb1liVON/OINYH/VLn?=
 =?iso-8859-1?Q?Jq4NWfQifI91VJQB7hD1Fl1pS6Tz8AyaNlY6jbd+xH5IiSMN6iB9AtNv9Z?=
 =?iso-8859-1?Q?SuAkKFVzmNgEMI6Kd3keNKHKxL2+jL1C8RGbVmem10gJxZrA0mL7cs2wyV?=
 =?iso-8859-1?Q?hn/v33Lh1KXLAkkND3uVJERgJ/gJvaYfZDzdpRui326bQyFc3l65Q7aoDq?=
 =?iso-8859-1?Q?ZCRaJarUXOSFv12qy4EPHNUkXW2mORch63VrQuj2ONrffnb9EZFpZ2szjG?=
 =?iso-8859-1?Q?5DalNGHBL9xsGT6yyBpeinRz+2J6B1XG7+1mndmdUXD9xHVJ2Qpy5Xycno?=
 =?iso-8859-1?Q?Y58SlROIi907gHAGJM0YBm7pia1aLystw3rsblXpK4og8WOtGFHoOOxdw/?=
 =?iso-8859-1?Q?vCwBXQIyLo3949kJw7QahTyhJvxNITnSxjto+iHoReuuyq+QZFvKzpCZv3?=
 =?iso-8859-1?Q?m+cEcKb5gAY83FLNe5ELVfX2MeCVlwPomap2wu33eeWGtNtIh7FBSuB2xf?=
 =?iso-8859-1?Q?41ufRryv85eTUI2j7LrZ2hD/2W7UcxEdEfnn5h21OiAR/6OX3nFKP3GM9t?=
 =?iso-8859-1?Q?xSEELHnQ5zAa8uJLZhfOE4qMeKn8Z/YgSAfhE7p3S1AT2BJOHa8kc1jkbL?=
 =?iso-8859-1?Q?CBwU8q4k+kSEYQokg7j5TpUlSQnUWXMHj6rcuN86YXs9GSbFlzsbOWknbU?=
 =?iso-8859-1?Q?L7e7BDELAfgi4W9906N12XGaKh84V4la45sA7G61pW5oaZerjO+5Pplxgr?=
 =?iso-8859-1?Q?4mrvD9dSe5oVZ+FQmgxFIwT8DL73H0en5Wy2ktjmvKhjtQbdrp4OYasVn0?=
 =?iso-8859-1?Q?IGcto20PSMwiobu9Z7Wedh+SF5Y6ME9F9tufl0597h4iiHXe1Nzw9dKNrq?=
 =?iso-8859-1?Q?XFnEBfjmw2S87VKJO7YMmxQSV2vxsOhIbIaTte1iYkn0Mcz8BzJrnGdNbi?=
 =?iso-8859-1?Q?w7dcF2v+274aUinRVMiHmEBwVQalH43UladVppuXKwAiUJplcVYDfHXW+a?=
 =?iso-8859-1?Q?Wm6dEj9GsYAkAwbhBtIFSZltYo2ng/fbY3zN+oB3Ai02f+FmbWb9geVUGK?=
 =?iso-8859-1?Q?b067ElgMXzaLq+We1RVadH1jqR9tK3E4pybQiBtBNsGJ5Cm/yMh+YFTEd9?=
 =?iso-8859-1?Q?4eLyrRRmz4ddiZ7I9yuGxfBk0KsInzKokwsmrEkC6KsVqSeTn88/FwqGki?=
 =?iso-8859-1?Q?CgdTW0BaW6WEZmcF82TvM3kSWVW22PM9/cwKY4FmqI215R5hM67HnyTE/x?=
 =?iso-8859-1?Q?BBLRZlOyAH2UcoRgCUKx8ngZBdBcXhCwAH0ZlW3RoXVPl6LaHVcdt6jg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c4872-f8a6-4ed2-a90e-08dd705cc959
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 14:03:17.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3Pz9Yo5OLUY52KPyXepm1FK7QJRWcrQCrIbENGABFZufA62z+CvTMuZ/SRPSrym0OmJyYOE4dq470ch7QalOpMlVgxOr3tv9zzF6xjYtn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF1765703A4
X-Proofpoint-GUID: eIzTf317i93EepHs6M3t7dnTBEyTYg1U
X-Proofpoint-ORIG-GUID: eIzTf317i93EepHs6M3t7dnTBEyTYg1U
X-Authority-Analysis: v=2.4 cv=IOICChvG c=1 sm=1 tr=0 ts=67eaa0b1 cx=c_pps a=w5n1bf+9uxWZZxVc/eFLww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Uwzcpa5oeQwA:10 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=yutHOF6BAAAA:8 a=1XWaLZrsAAAA:8 a=IiweX4PvAAAA:8 a=hVcwujEvAAAA:8 a=i0EeH86SAAAA:8 a=CF3zxFjyZVKtA2M-1nwA:9
 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22 a=p9TLLz150Om7V_NzouHt:22 a=4UppLPHNXRjA7phoqhyY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310100

Hello Jonathan,=0A=
=0A=
looks good, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Monday, March 31, 2025 14:13=0A=
To:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc:=A0David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>=
; Cosmin Tanislav <demonsingur@gmail.com>; Roan van Dijk <roan@protonic.nl>=
; Jyoti Bhayana <jbhayana@google.com>; Nishant Malpani <nish.malpani25@gmai=
l.com>; Eugene Zaikonnikov <ez@norphonic.com>; Jean-Baptiste Maneyrol <Jean=
-Baptiste.Maneyrol@tdk.com>; Shen Jianping <Jianping.Shen@de.bosch.com>; Lo=
renzo Bianconi <lorenzo@kernel.org>; Matti Vaittinen <mazziesaccount@gmail.=
com>; Yasin Lee <yasin.lee.x@gmail.com>; Andy Shevchenko <andy.shevchenko@g=
mail.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Subject:=A0[PATCH 25/37] iio: pressure: icp10100: Switch to sparse friendly=
 iio_device_claim/release_direct()=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
These new functions allow sparse to find failures to release=0A=
direct mode reducing chances of bugs over the claim_direct_mode()=0A=
functions that are deprecated.=0A=
=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
---=0A=
 drivers/iio/pressure/icp10100.c | 15 ++++++---------=0A=
 1 file changed, 6 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp1010=
0.c=0A=
index 3e0bf5d31ad7..1951c1cc84cf 100644=0A=
--- a/drivers/iio/pressure/icp10100.c=0A=
+++ b/drivers/iio/pressure/icp10100.c=0A=
@@ -343,9 +343,8 @@ static int icp10100_read_raw_measures(struct iio_dev *i=
ndio_dev,=0A=
 	uint32_t pressure_mPa;=0A=
 	int ret;=0A=
 =0A=
-	ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-	if (ret)=0A=
-		return ret;=0A=
+	if (!iio_device_claim_direct(indio_dev))=0A=
+		return -EBUSY;=0A=
 =0A=
 	ret =3D icp10100_get_measures(st, &raw_pressure, &raw_temp);=0A=
 	if (ret)=0A=
@@ -370,7 +369,7 @@ static int icp10100_read_raw_measures(struct iio_dev *i=
ndio_dev,=0A=
 	}=0A=
 =0A=
 error_release:=0A=
-	iio_device_release_direct_mode(indio_dev);=0A=
+	iio_device_release_direct(indio_dev);=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -439,7 +438,6 @@ static int icp10100_write_raw(struct iio_dev *indio_dev=
,=0A=
 {=0A=
 	struct icp10100_state *st =3D iio_priv(indio_dev);=0A=
 	unsigned int mode;=0A=
-	int ret;=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:=0A=
@@ -449,13 +447,12 @@ static int icp10100_write_raw(struct iio_dev *indio_d=
ev,=0A=
 		mode =3D ilog2(val);=0A=
 		if (mode >=3D ICP10100_MODE_NB)=0A=
 			return -EINVAL;=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		mutex_lock(&st->lock);=0A=
 		st->mode =3D mode;=0A=
 		mutex_unlock(&st->lock);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		return 0;=0A=
 	default:=0A=
 		return -EINVAL;=0A=
-- =0A=
2.48.1=0A=
=0A=
=0A=

