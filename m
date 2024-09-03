Return-Path: <linux-iio+bounces-9075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B896A090
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280B11C23B99
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCD6F30D;
	Tue,  3 Sep 2024 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zOuimzRB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66351C3E;
	Tue,  3 Sep 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373643; cv=fail; b=E9lZSHT4iCC1sC2jjfBocusF2b65+JjYlE8pHvAWaWMbhykx8rMSfNkoeOLCgHTPQP3veS7Z3Q3Ah176ZkfNBhkhYpT5E6hc/nLDG08GbEzq/mYFPhI+nsBXmPhmcCFiSboHYYTolbwlY60kh5d/bvPcDFhE9PrJVTMRBgGZVkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373643; c=relaxed/simple;
	bh=Ua0tzpc6tVgN68lpb+z+F1kvbUYffqpg4Apuj6U2r44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N/yQCvzoPO+vMisHBDteGmzPFUN0GYoHVZSMUe9wl0UXieVNwzE5aTxwpWskXITmpNRxrhQWtnyP/gWjXZ/5fjBxvZ0a1lDFf+pr6UuD3juEzRChqn1uxteOTBNHyn/VfONCwi+6N7a2W++517iNHlQr+ds+EKYWl3ZuLXBISI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zOuimzRB; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BwCBU005567;
	Tue, 3 Sep 2024 10:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=16w9U
	oTFUbnd6SVs5W7EPEWnbyRF1Ivc6PPxT4Kl1c8=; b=zOuimzRBE7+wLVd+uVKcb
	QbOYbR5ErMAeBB9XtSn+lEc04sKsM+XLjGo6JRw39u2E842djLwITbFS42x07cnE
	QHNNQiuTpk8LUR4/Iv/32VEeH68rPYL8l+h94wdbqIZpGhm0YY+mPItIV1mnBhsf
	7x5MBGtdpo1Z01MwBpY1QPGioemh6xa7/MN34cWydh7bGLL8hA6pGrvQlvwyrFkv
	Rw4cpl7YXN6kvUQNefY1yAStWKCW46IniE54XGekdn5fCvuWdSXYL9hVMenpYfzS
	W1GCyxby8042SO2ASrF/zSHId3SiSwnmho1brX426Lj9KMP6dItPMvxP9b852jtQ
	Q==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41e21wrjvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 10:26:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaTvmVUtXQ6hzJznqPeSsMHi8Fy/MpVkn5KqbpK2HokM7Vfaxln41KzJDFGO4o4zF6PMRip+QLtVttTO+TSXiN0F/m2lMFa7gMzXghRw5LQYCgvXdWTmjSrC/FmrHhTxKJSWvN9P/YETnFjFpm3p6xS0JS6ZhW4quYn8izrSZIcIW1L5GMYhLylGcSIMrnsENG9/i8Zj+4gBnEgh6jc15l3XspiqUUroSmB2yoVwI28YM7grOIi0QP/CptdYAs6Vgqjf3jOGdT/SOnsx99RmgAcTHx0Pk3ce+4P0dxET1/c183Wx8uzBHF70fxv3st53/X74B+OSSSc67DUN5jhJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16w9UoTFUbnd6SVs5W7EPEWnbyRF1Ivc6PPxT4Kl1c8=;
 b=DL/PDNqTpN3MwVrXabSytMasH0uYvfBBgplrSHYh44qpcTFlKC6R5tMf/tjLL2E8+6XcvVVqprmn7qNgWj/M1b8jFY9NZVWLHCMZpYnSgl8lCyajufKLCRpOOo0BLTquFvEFoBw3gLOgbB01cDh8f+5b1EOxLM6PUVItBkQC/ji0VwVjuHT/Qf4QIlzL1e3a5jj+6TGCogi5adOnEqEuC5HT1Tvr2IZENEV1BsV6bA1IyTUr444sDn89yumGRBtwgbKIRcTAkM99/C4+kkIjc0CAMiBPjPaxI15SiIMyPxoq7VWlKsHJ7C1rPhz6+wRU6uVGfauN2JdybxpQjZIYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by MN2PR03MB5360.namprd03.prod.outlook.com (2603:10b6:208:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 14:26:41 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 14:26:41 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Mike Looijmans
	<mike.looijmans@topic.nl>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHa3eIXd5qIVEQ6FE+jClJ0oKqrQbIKuw2AgDuZ7sA=
Date: Tue, 3 Sep 2024 14:26:41 +0000
Message-ID:
 <SN6PR03MB432025ED9C0CB4CDD1CE243FF3932@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
	<20240724155517.12470-5-ramona.nechita@analog.com>
 <20240727164113.02a95b79@jic23-huawei>
In-Reply-To: <20240727164113.02a95b79@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHJu?=
 =?us-ascii?Q?ZWNoaXRhXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODc1ODMxZDgtNmEwMC0xMWVmLWJi?=
 =?us-ascii?Q?M2QtM2NlOWY3NDc1YjhlXGFtZS10ZXN0XDg3NTgzMWRhLTZhMDAtMTFlZi1i?=
 =?us-ascii?Q?YjNkLTNjZTlmNzQ3NWI4ZWJvZHkudHh0IiBzej0iODg4OCIgdD0iMTMzNjk4?=
 =?us-ascii?Q?NDcxOTg1NjAxNTA0IiBoPSJBS3lZOWx2TFh5Z0tuOEMyc3F5MkNKdmtFczQ9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQURnMjdaSkRmN2FBZGRxeDNPY1U2SHgxMnJIYzV4VG9mRURBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|MN2PR03MB5360:EE_
x-ms-office365-filtering-correlation-id: 593c63a9-a89c-4c95-32f8-08dccc246e02
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+s6wNAK9ps9PScTW6y1dMovepzO9atrAr5Sdog+PxS8WxX0+AmiV/57ie45C?=
 =?us-ascii?Q?WYEd/+zv8huxY02lVsSmGDoJI32hGuN9vGrhzQuXUE4VIyqBEhO1OhlZluD1?=
 =?us-ascii?Q?6m8+ZosYN9n4j9NJNAl0iNdm2HE0K+lK5DP4IgO9v3q1eNo0Qf11kQoJXEyn?=
 =?us-ascii?Q?RrC+Ps6UcBlow38Zf+fpd8lKEuBG5u3aKYaxSCoeR0+0kXXjtpIi78QpnHaf?=
 =?us-ascii?Q?i/2lweAQy42fq72Lqr6I2tJgZAEFLVvIfQbQsf0GNUB/3iNR4mcXIRAUymvR?=
 =?us-ascii?Q?tEQ9Dd21H8wO9Ucvj2aBj19ltpDMyY+G0kxpiHGzOmO/EDit64eKfsRzrOAm?=
 =?us-ascii?Q?Qll2dxRGVdECMv0Am6rAjXl+m4a9RrAEUAaxKQz+Z7Wda0Zx5N9/Z4QGoL+b?=
 =?us-ascii?Q?3WviSk1IQ5vuzdJZg42Onp1niEe0ztVPRTCoY0cfR7eerUC8ISGc0jqIVRb3?=
 =?us-ascii?Q?Dp0kl7VmiGeAtG3COPQa1a7sjHCB/uVEWSKorRWx4E61moKv5rT+gL2J2pyM?=
 =?us-ascii?Q?Mtj8rL8Jn2fBEGdPcHrDciFZtWqRJbHOXRiUVDu7Do6oSNdKvejwPgfJhx7K?=
 =?us-ascii?Q?w5V472Yk33J7UN5zT4jcp35yozAzyFzMO23LJYtv4tJ70Ph7af+Q9pgG0GSz?=
 =?us-ascii?Q?QZdLoaBM2xdqeEY/2k2mN8MFBaOUdWmQXZcfqMuBRt6FrDRGbbAWZfbDM9H/?=
 =?us-ascii?Q?JVqbI87KX+evFdV/uX3bo1dp9YTrgwWXesXREOLyBh6+mwHaI1KX67MXODGS?=
 =?us-ascii?Q?wi7Exj4GRoz2BDrLPI4sx9Lw+v0HSlw0jXciw25w3e+g+38igI+9foebPZab?=
 =?us-ascii?Q?TudBuyg4MX4b0nI59KfNMxRj6L+/9+qtVibp9jHWCKrio+XWZ6wWndKKt9UK?=
 =?us-ascii?Q?y+nurDU8RYx8vXHIjH4gb/47dB4Lv2d503EbMXeHjoOpYAGuR0YWtSn3jxNE?=
 =?us-ascii?Q?j0+nOc0n0MfI2VAAnMg3lTzUPgSv+uOSs7ovdR8/bxMxgK9mgdoekw6Mygis?=
 =?us-ascii?Q?Mv/tDhmWCI9lS4R8nFuPpgyxl8pbhAhLOxDv0ZNs5sotmLDz/lE5ISt+JnO5?=
 =?us-ascii?Q?n132WSAQEi/pTbioBzv8v8gfHZdKNiioBrlvUgFUw56QWLrvNAiyD6QQ6Qj/?=
 =?us-ascii?Q?INOQ+GcCdw5venHRMG5rjp9fsrhPxGC/wiPEn080AN/7uvu4xZszSIy3ON/O?=
 =?us-ascii?Q?GhcQzsAwLsmTAmcAQd3yf4HA6qo7tLRZjYP8QGHTHIC4TfW5MtWIoaIFPxAn?=
 =?us-ascii?Q?qTacCJgmcGVFWOgB9rPK7SAXd6VEn+z7eseN5yqR2qrOBAdtbcpOB3cM8QJW?=
 =?us-ascii?Q?6i1wCPkr1W/at6qgWJXGHDiK2hF4X5cGZbW00SLsZ+dktNUWmmFQb6ovwXXj?=
 =?us-ascii?Q?G8t1JP+aQG6UhSHlFEP8xNYel1rONwSDj+bGw8yyDD6d1xAvPA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mdkDWKnWgGjYCgoIVLAiJbJGuED6yNIZUQ30Kv67fStTuwd4fW22i+iiXD8r?=
 =?us-ascii?Q?XcX1TWWvPqxszQTni300kezg6YnIOIwfgkuSsOet0H1u/keTawlSOatzWTAI?=
 =?us-ascii?Q?6sBMgOnS1W7MAEZoIl8GdKE8Zia3IcbpX/diPy2emvERalIU6MLkFCjw8u0N?=
 =?us-ascii?Q?fnh/EYTsNKdaNQMG4dWCqkIcKUGTzX4I44odo+nkLg2vINR896EckBosfv3i?=
 =?us-ascii?Q?oSf6rkPXbcIgCC4vmqv87MLgng2o/UOWA/GnJVnA6JBsWGnsAbRP3HKPkTT2?=
 =?us-ascii?Q?/aZ8HVWSEjJi9hgGRW0Z17N5eBQxeqO+BuB8EHuM1Fsqk1BIRew2VNFoJZCB?=
 =?us-ascii?Q?kKxSAUxxoZjoP4nSqmefAAzvVH4dlaN5E2kNhM6BIxDWInOrysDVk0RBijDU?=
 =?us-ascii?Q?Xteljc2ZBgqUl0MqcjZ6fgDRdIaGY5H8hoUx1TNcSjLA/3MNVgpui9VGrkyJ?=
 =?us-ascii?Q?+Acs8iuLY64y4MXE7p5iwHYw+h7eheB+BBQZGfzVSD5bnP1lHD7uFoGVjFQT?=
 =?us-ascii?Q?morgj7B60yryrTkm9TwNazLtGE6tTf1Di9hYAxpAGMwYi+/Ht8NgyL1ZFIoJ?=
 =?us-ascii?Q?kydMajtblb5b40EVeeCFXJEMzmAz9TIuf4aZiuJeiBVMVU7SF1p18mrkxjK0?=
 =?us-ascii?Q?mpJRG8qma0MbUHTeE62M1VG/gGlX3ipoXJDCgTBTvR28Em9DlBoTsAu2YJdR?=
 =?us-ascii?Q?hoVpjzf3XvmFqZi24k21OtV06ssULPfEFty4JWbR5eoeso5w9nmfVr5ZDHhJ?=
 =?us-ascii?Q?oQ1KIehzmk3XBrnuV7hO2Dp/L+ZEqqFgH1d2jR7Elkns/lRlG9iZAhnVQeFd?=
 =?us-ascii?Q?s2ffaEVbSUmFhOw7aGaartf6tVqwOU/MZwei6u3HS8ce+W+J6GvCAvLlb/+a?=
 =?us-ascii?Q?iW43E3GR4pR7GA0A+SIjCWq26GOLiStMRiN0A4SzxQtwKhzUJW0PgN7T+dRt?=
 =?us-ascii?Q?UT+kbV+Y+dq3j909g2NY7mlcGNybNL/gcYxpGu0cUz0jmoslHfTZ9GN+Xo6u?=
 =?us-ascii?Q?vjl1431tk8A9n+GcWYCuLd0IjKUNret2C6ZlEvuSFp81diDDNJbZljwqU6s1?=
 =?us-ascii?Q?LF61xSg3vye+MXRlmhKMPnHk0g3f0OhJzetf+oB+uIC/UmKQf1wryCWCsRI0?=
 =?us-ascii?Q?CQqL+Zm8A9jyEK++1YhA2/0yvsAy2fsEkFoyEnYX1i2XGuQ5Q4l6YZDZstMT?=
 =?us-ascii?Q?0v1Za24Iwchrso4AqRW71JpJWhGHYPOtKCfwDthYYtQALB0wMy/0jz191lY4?=
 =?us-ascii?Q?iWVdsx2ZpsGXU/u/Wi43lsRjsnB5kzfATzkban/8j6ejAAr0CbvDzuznvGq6?=
 =?us-ascii?Q?UULyMXr1L+V0eKXQ07iJyWNPe7hceY8oGESY6o/RGyZKx4s7zNOIfC2tmjAV?=
 =?us-ascii?Q?N2mvbQ9c8PhbgsPSGR49m6kFjWeGLMnppvYxDXvtgg4DYMi5krqhQB906EyO?=
 =?us-ascii?Q?4QsWzrupDB/8ichgWPirDbgOhCbIIHc4NoOuFt6m3dMBzKYy87WYpy1jUclS?=
 =?us-ascii?Q?aUofKZjoSps9ZRfwV/XTLSj5u84bKVEjIyGmPPraH7nQ3yRgatRPMkcjXVwR?=
 =?us-ascii?Q?99iDi29e2pk8zlaUanlql/VZFRQb0GGNJD4lYP/V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593c63a9-a89c-4c95-32f8-08dccc246e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 14:26:41.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aME8SYU+gu71JTKXgng8isQxC0QSX7m2edR4kgXZgQiBxDiRP23Qer52fZemhewJY6LY5bdj8uA4F4NPbwHvzdf0db1wBLd+j0as2+Q1AGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5360
X-Proofpoint-GUID: 4AjA95gMlA1mpHPg7Hb7CVnyQJKVOj59
X-Proofpoint-ORIG-GUID: 4AjA95gMlA1mpHPg7Hb7CVnyQJKVOj59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030117


Hi all,

I implemented most of the feedback from previous emails and I will be ready=
 to send a new patch soon. One minor question inline.

Thank you,
Ramona
-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Saturday, July 27, 2024 6:41 PM
To: Nechita, Ramona <Ramona.Nechita@analog.com>
Cc: linux-iio@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Tanisl=
av, Cosmin <Cosmin.Tanislav@analog.com>; Hennerich, Michael <Michael.Henner=
ich@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+d=
t@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Andy Shevchenko <andriy.=
shevchenko@linux.intel.com>; Sa, Nuno <Nuno.Sa@analog.com>; Schmitt, Marcel=
o <Marcelo.Schmitt@analog.com>; Marius Cristea <marius.cristea@microchip.co=
m>; Ivan Mikhaylov <fr0st61te@gmail.com>; Mike Looijmans <mike.looijmans@to=
pic.nl>; Marcus Folkesson <marcus.folkesson@gmail.com>; Liam Beguin <liambe=
guin@gmail.com>; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x famil=
y

[>> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of=20
>> sending out data both on DOUT lines interface,as on the SDO line.
>> The driver currently implements only theSDO data streaming mode. SPI=20
>> communication is used alternatively foraccessingregisters and=20
>> streaming data. Register access are protected by crc8.
>>=20
>> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
>Hi Ramona,
>
>Various comments inline.  Key one though is make sure you read your own co=
de before posting as there is a bunch of left over stuff from updates still=
 in the code.
>
>Jonathan
>
>> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c new=20
>> file mode 100644 index 000000000000..7a83977fd00c
>> --- /dev/null
>> +++ b/drivers/iio/adc/ad7779.c
>
>> +
>.....
>> +static irqreturn_t ad7779_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf =3D p;
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> +	struct ad7779_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +	int bit;
>> +	int k =3D 0;
>> +	/* Each channel shifts out HEADER + 24 bits of data
>
>Wrong comment syntax, and also early than necessary line wrap.
>
>> +	 * therefore 8 * u32 for the data and 64 bits for
>> +	 * the timestamp
>> +	 */
>> +	u32 tmp[10];=20
>> +
>> +	struct spi_transfer sd_readback_tr[] =3D {
>> +		{
>> +			.rx_buf =3D st->spidata_rx,
>> +			.tx_buf =3D st->spidata_tx,
>> +			.len =3D 32,
>
>Why 32?  Good to add some maths or a comment on the sizing.
>
>> +		}
>> +	};
>> +
>> +	if (!iio_buffer_enabled(indio_dev)){
>> +		iio_trigger_notify_done(indio_dev->trig);
>> +		return IRQ_HANDLED;
>
>use a goto.
>
>> +	}
>> +
>> +	st->spidata_tx[0] =3D AD7779_SPI_READ_CMD;
>> +	ret =3D spi_sync_transfer(st->spi, sd_readback_tr,
>> +				ARRAY_SIZE(sd_readback_tr));
>> +	if (ret) {
>> +		dev_err(&st->spi->dev,
>> +			"spi transfer error in irq handler");
>goto.
>
>> +		iio_trigger_notify_done(indio_dev->trig);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	for_each_set_bit(bit, indio_dev->active_scan_mask, AD7779_NUM_CHANNELS=
 - 1)
>> +		tmp[k++] =3D st->spidata_rx[bit];
>
>Update this to use Nuno's new macros for iterating over the scan mask.

Does this refer to iio_for_each_active_channel ? I checked and noticed that=
 the patch containing this macro is not upstream yet, should I wait for it =
to be merged before sending out a new patch?

>
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, &tmp[0], pf->timestamp);
>> +
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>......
>
>Don't need __maybe_unused as DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr() e=
nsure
>these functions are visible to the compiler, but that it them removes them
>if they aren't in use.
>
>> +{
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct ad7779_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret =3D ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
>> +				    AD7779_MOD_POWERMODE_MSK,
>> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
>> +					       AD7779_HIGH_POWER));
>> +	if (ret)
>> +		return ret;
>> +
>> +	st->power_mode =3D AD7779_HIGH_POWER;
>> +
>> +	return 0;
>> +}

