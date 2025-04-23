Return-Path: <linux-iio+bounces-18556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85DA981B5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0277AA5DC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E226B2AD;
	Wed, 23 Apr 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Wir6eoDD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3409267383;
	Wed, 23 Apr 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394839; cv=fail; b=BeHmYEZ/Xj80yLx7IMIzsicgeINHZcaJIcPEhS+XUme8CZiCI5fyJKzSzaOad0JUc5wV27iTNSdy+XP6fTkRV44XIuP32CRaG4KoZHHCzAcqDmjacCsc4G2ER9P/VTJnmjEorqb7Zg8Xr2hwiME3xy/l2d3Jf+ml5f01fnGNU/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394839; c=relaxed/simple;
	bh=f2NWxyYWedMMh2iSyY/4HoKHx98A9D79+2nDSqTzlso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ei8CiMTdJJihUWXRzL/21mizRqNpHol4AWQHUOUrQUusTMGpSE1Rj9PEVZCnx9cKKnJe98E9KB1SMgl441DKq2lruRM1AIaZLQyfV4raGOJ2ZRYpl+zSBgeAlEpeokLQXJj6J0iYck3Q/BHGwa4OUeDI1soSC796G4dQdrvAN5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Wir6eoDD; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N65CPf029014;
	Wed, 23 Apr 2025 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2o0Z9
	qE1h5P0thCq8n1SIAMrLpAEgYSs+oR4bUG4atM=; b=Wir6eoDD2tn0PF+le0UY8
	q7XjwpgftF+CydNfYX7pEemw912478/iTKcMsY/d+ldEUQUDlxkdhzliCawxzLPX
	R5xKfEhB5RgStv2SZQMTseWO9OHhwADgAYn6lbuvT19XLow5xFRSilQ7Fmi8RLF0
	SAOTHdHH5KHEF3ZBtYVhNooCzGnbPGDC6nwDRZTmiaCXdXL8E03GQtaLg24lK9g6
	Wu5AnMqHxZLwnCXjW6ERGXgTNI50MvgVOrilkx87Bc+0AxSxXJGh0t+uI3tihKN0
	e7rPvXBiweXlju0OccnDdE4ot8q8B0VWh64Lfi53Lo7R7f/W8YgSg1sd8L2Vhu6z
	g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 466jjta24g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 03:53:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdtPBgBwQNpyNkWnv4NQr5faI7jke9uhHhDd0opN6uijiOolYqXgIzxmVh1JVeSb5UOcea9lEmD4QyGtR9dBRUH9qrW0Y7+kflusGpSMwBCSu2m5S638KtfWpZSUEfi2cv+0QQdoqz9P/Bw5m5pGZgNJUryEAX6Lm4Na3/SWEtllP/Tc2rtyTBwoNj7LRSOI3NzrwrgeZ1mEURqfNaWQ3DIn7SaTxt5deOAIOQ790rRrUs2nFCwa1e2v4wFlpaDvwp3wiJI4yyJtVM/InibfgJg17htjA2f9+lobUthQFoKN+cGXKQfaZGWQKESVeVDDm0BndpqJjuKlygXqjj7dVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o0Z9qE1h5P0thCq8n1SIAMrLpAEgYSs+oR4bUG4atM=;
 b=yORXBeKIL4++j3KBm5CoDfnD5qG3s5+DjmjsGQJsY4Am2HCFdor74bY2nooNp2hlbFUjI/0llfBzHdrkJaNcWbMkvwoqZvCKGj8KESUNT3fOWYrY75xst0K0uZirYFIepgLxJ5Yd4iEDxz95Z1IQ9VYf3Dye4e02cXPnNRJNFSgXvT+Uva8LKQIBLzmJzPmUuSyO8iY5W6ktqfTxU7VTYa57hZMo51aAEAtwE1bo9/p4n7Gf/8aVXeHrbu828c0GQxssU1tbMdWikFrIt2fDbptM6Z6eXAibatQF9wOEq9CBZh/V/O5s3bv326RPAZY/ENpWhPR+ccdbMRJc8ywTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SJ0PR03MB7025.namprd03.prod.outlook.com (2603:10b6:a03:4e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 07:53:37 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:53:37 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Topic: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Index: AQHbsnVyrRgqZmjV0EKE05LwnZhDMLOvzK8AgAETIrA=
Date: Wed, 23 Apr 2025 07:53:37 +0000
Message-ID:
 <PH0PR03MB71410D0F7716DAB4A2103AA1F9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
 <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
In-Reply-To: <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SJ0PR03MB7025:EE_
x-ms-office365-filtering-correlation-id: 6027bdac-b35c-49a5-61ee-08dd823bf48a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nbw8Hw7ERQo4rFr6XUDJaaFRcd5lk1OhDw2MeFi5s//4MCub3Zm+dspwF+?=
 =?iso-8859-1?Q?C7ax156kJJcMA9A7QrjUA53Okav6s3YZ9fI7/MANvsGcVTn2JuV6FgI993?=
 =?iso-8859-1?Q?r6GhupaLB/yrk+sWs/j86W+35JZi2UW4Dh6VuCexpDC3/zO6rksh77z+cu?=
 =?iso-8859-1?Q?LsX6/f4DwSDVTSlt0F8o5kp0SDq9n/VITcqAfsblJglytHXyJho7BESSKq?=
 =?iso-8859-1?Q?2tibinNR+6Rxt4lPDieyHuvVmm6IzBXUJwvZjs1lw9SwxP7w5Pd/ytn3oK?=
 =?iso-8859-1?Q?maJSWfRk5mVVOFtnLviUH/4bbfpQw65w3aoZ/9TrH30e2t8QoWza1ASV4P?=
 =?iso-8859-1?Q?eHPRvq3xBzxDizZJ6BcR3hHtS+utQXgriVuSI7l5vMOSDVNmHO8sOUNOMT?=
 =?iso-8859-1?Q?sTvqLpew64MM4I8+p4zcHskZqdNufUEPjmECrW37H9abg4CZnRJudSOsmJ?=
 =?iso-8859-1?Q?3zCq5mVrCur8VDSBYo4Ht2mzVMVXGo2aMnn1GS+zlIpEs7Dhs3T57v4+s3?=
 =?iso-8859-1?Q?2Lrd2KpAuOfgcUlqC7oFXn2DBq6Y72xi9445/M7YnTQkOCY8ep3a6eNm6y?=
 =?iso-8859-1?Q?k746Mi24v7wdX7lT8Sjn80Yzq9AOJ0ZK4ZzUOOTdEmyGaxrvWGuGGnxqKD?=
 =?iso-8859-1?Q?CLtr0bPa56zhz3AR7P1ZReEZyVPwGzfks1P65zZG2Z77wVG0KwLxtaQiv6?=
 =?iso-8859-1?Q?9e2p4z0Dz/g8a2w1Bln4ctxa8PDVnGk5JLgVexVAMTC68QnUDLwC3IjHVo?=
 =?iso-8859-1?Q?3vRyvNa3dzBULdoHw18b4+6dvC2z00bCni0vrheCnoIydgPFvdv7vy3WAF?=
 =?iso-8859-1?Q?W0SRaFOOaSpehlb0QX37VBkd8gREiyz6MBjyA/NApa5XCjvVwpTb/UcDYT?=
 =?iso-8859-1?Q?RiaDoOWa6Mxp+5dnx7fj4F+SQfic5PAvkQE8fe7sey2srwrSGESFwf2Fvt?=
 =?iso-8859-1?Q?G/QosNHREbyE1hqvabiO8fcUSBJV5OaitvtyPeiLL41IVedShtBQsddOAs?=
 =?iso-8859-1?Q?yw6AC+1GnGb/VDQEmN9hkncrAqCxkHLpoF5sgW1oExc0GZxG/8Un6VNmN6?=
 =?iso-8859-1?Q?DjktTIXDTdA4QqUUt6oFSCE+wOatsD8np95TIDeYILYWxc/pK22WGv11pZ?=
 =?iso-8859-1?Q?0EcPRA1X0q+vaj8bVxNVuYsmTfa54t12yjfAITTt/W4nkCnGJl0+f4pIza?=
 =?iso-8859-1?Q?99oI9wa1NMU7MTbFGOV/O8iw3MtOemDVo2ZUBmZ4+TMNExy0dPmPrmpJ3Y?=
 =?iso-8859-1?Q?SuWkdI/R56wXlWYK/ENlgcCUPfssSg3Uu/GSQcR/j6Nu0eRog6zN+NQvjs?=
 =?iso-8859-1?Q?oN4h9PYGIcvmyNp55SKLRsMRgIi7862yf4RKRLGpwQdH9oV8HzKnQW4sin?=
 =?iso-8859-1?Q?pU4hLteto6hh35Pg8WzPBJ3YJRrJZ7NFlJficApXCOxw8ZH5HCVGaY5JYk?=
 =?iso-8859-1?Q?AWqGK7Dw+oTS3t02WzJAAOwVrZfA/lRbtiOUS7K93h60mCfUFh7e8TbmI/?=
 =?iso-8859-1?Q?rGfNoQ7nLiVRuoWSKInEl5bfYV2envx8dmRJGK14eILV/J7zlqkhB8NgTf?=
 =?iso-8859-1?Q?Yn3z/w8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Kwy3ezzXyhmFLryuDJQTiPgnh3R1Z5ic21EXMm6/21eBcnNvm24D6lUTec?=
 =?iso-8859-1?Q?r65wmQOfpihiNd7xDxMKq4r2Km8XC7r2nx5gVGPnK7fMSU4NnQ8c02UxBC?=
 =?iso-8859-1?Q?+PJ9vZka6e6D4EpcGITC9dPQcE2Id/hj897pvNMdp3R5Sbtzi8Q4/Lazxi?=
 =?iso-8859-1?Q?qvMoKMqbX9iv5rSToXWv0VLQbI/2BkdHAeQgJhEoORfa3pymQGlWY2zBd1?=
 =?iso-8859-1?Q?LQ2CMo6wlQsnx2Yum4h3Z9YVy3ek5xf6CXFIoFADpVLKQ4ZkxYztEyGUzc?=
 =?iso-8859-1?Q?ERW4o3JPYSCGBDCEkA6mx4AO4yxCARDW6gHKPdPyMANOL9Uk33DyB7dQND?=
 =?iso-8859-1?Q?S0qoqfowv0DVLcffglCfaJdPOBdXVZfIRs/ncaQu2AWcSK4PvgfzQV8oDD?=
 =?iso-8859-1?Q?SZFta8tSIvjCeZK11zgpnYHkGLlptwdj1tbbBeNcJ+pzwbmcKmg0MfHiEv?=
 =?iso-8859-1?Q?Gb4ju+5BaOBoi7/kVvPLed1g2yNC0StakhsNsIajVzJE56yBopkPxxPdfG?=
 =?iso-8859-1?Q?a+A/FROLHRgEIoWdReYpSSdHy5ZHw0ShAF0Fnqaaez7x6jvBTyC8AE152J?=
 =?iso-8859-1?Q?LMdZjjv0UE5yql209Tg+DOIoUvWpp/pxS+MMadrDibmuX11Oz4oS86q1u5?=
 =?iso-8859-1?Q?QokQRwyCAm5+J8x8ZnSxuizGJxVDcFCpUc3hlk/rdvj/EZVZpwvtudCPl1?=
 =?iso-8859-1?Q?m0i5iLWn84qJgPHxGQJVQ3P8H2i2KiRc4Pek27IdrRIpRMbYRvCFV3rloO?=
 =?iso-8859-1?Q?DkMPhedkFX5F5P8ZmCrOsrr8FCDftZctOfj3Ka1N299zgZhA/my6C1YAdU?=
 =?iso-8859-1?Q?FptVPLAZ0g9zS6Eyr/bmMDUwbe2tgHxeOlbp0FJ0H8NmjYdy+4RVP/JTJB?=
 =?iso-8859-1?Q?23zdInRVxsKgsHgznMne8WoV1Rsl3luJJ5fBu4MoJVEbeHXH6Uv3y8IlJV?=
 =?iso-8859-1?Q?u0UGW9pMe1cosGSwX5KDjULYjBAP1OsTCalFfFeTpmXvi+CN5HaCrvRwTe?=
 =?iso-8859-1?Q?/FbxtQGWTp45oWjZ8el+RME4xOMMWQIzeRsyUxxpNYgdd6AjKXPeQFo6lf?=
 =?iso-8859-1?Q?o7CpHcUQS1uYMG9JsOXu5f85TMF3NkTyKO7Ps/ZK1E0Iq49eaYgqLZeoP+?=
 =?iso-8859-1?Q?JvlEf+x7JUn7w/Efeao74KcUWLzRTLxrkPz51CaOgt4yHFEmamzPSnwt9v?=
 =?iso-8859-1?Q?DPg8/9w5MUzz3upkOeOBRJLJDEVqay1pL3tB/+LkcYpWmWQxJQX1ALAlc4?=
 =?iso-8859-1?Q?aKIamYY8VwQDxDvCLQ3NeEM0jfsJROiGal5pGbHFgJVzGQKBe+r60T8gF1?=
 =?iso-8859-1?Q?7pSwxRu+K1kfjKN8m6q0lp0chl1gSLQRPvfFshe5tFOUuCtoetu4ywr9Qd?=
 =?iso-8859-1?Q?EmacJ5nqz7QJEp2N0B38tFJ4E2wI1l5OgV+qFRdZqlEZFte6r7zTsp/z+e?=
 =?iso-8859-1?Q?7ENuC8adonHxKEG7IB9p1gTgSoU3rK/AKs/qdZkZEWo780WGwHRpwR3+LT?=
 =?iso-8859-1?Q?DPEe1xt3upSNKZYwaVj7N+IZLF5Gw2flcqya9ohQa7LKQPojf5Zufo162M?=
 =?iso-8859-1?Q?q4D8ED4JY1imxm+DOE3TTV7+3exZGt3VlyFU5vTqTu9U7CRN2kc/9qKlRb?=
 =?iso-8859-1?Q?wsC0P6/Fr6Gdc+1v6jNZ02Lipr//t7qZJU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6027bdac-b35c-49a5-61ee-08dd823bf48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 07:53:37.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+XNAgtDHurTTZ+K+RuOnQNXsSr1pYUlbRH6DlbOxkgOyxI1EuIUYGNHKIeCBLjPATirlbVO0q+1c3rfLIgpOaX4eITcHVYoZk1HaVE1UHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7025
X-Proofpoint-ORIG-GUID: Dl1Gv5aLIr2l4Jhds1KGVi0L6V5zjDvI
X-Authority-Analysis: v=2.4 cv=UfxRSLSN c=1 sm=1 tr=0 ts=68089c84 cx=c_pps a=GnUjYDbtZuq/T0BoTQNfSw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=EjWbAKJ-xnEP_5bF_h8A:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: Dl1Gv5aLIr2l4Jhds1KGVi0L6V5zjDvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1MiBTYWx0ZWRfX9X6mhy838lVK q35QbmMPuuPYh7jLR95Rtz+ak/HFLKKhCmodSngpkO+ThsAFbxn+I3b7yJcrtMsIxflSnvxV4QN MLXnlfVdiTBLljzoiB/Z+i6BzMUJGuD109wRVzQdW0sM0CpDeRvw8mhoTnabYkTrvK1e/n73hHY
 9Ek4TMTWWJ0R0V/uf5q9ZVWTbRptSS/jEaRkCkWWT1q05XwtXgpj26Fs9zbfMfH7tELupNgKrLw rouy7Px7IF61RfH6x/iPaFAfL4kVZNupgj7+t9E+ffYDOT9kYvRE3l5RQvi0C5iFAJWL9C4uvuS Zm220U+zZGfeTW0pwUw96dOso3NdNofrB1Gsv7g9++luw0tGdXmUbv+/MR0nGtPHL+QGqIx8jv1
 uDd587uOcKkC1V1b9dDXLzCR2HFwuPquGsne5Di0Lv3m2ObNykEJ0AwKt8LQNZhg7goy6I4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504230052

> -----Original Message-----
> From: Andy Shevchenko <andy@kernel.org>
> Sent: Tuesday, April 22, 2025 11:11 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Nuno S=E1 <noname.nuno@gmail.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
> AD3531R
>=20
> [External]
>=20
> On Mon, Apr 21, 2025 at 12:24:54PM +0800, Kim Seer Paller wrote:
> > The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> > low-power, 16-bit, buffered voltage output DACs with software-
> > programmable gain controls, providing full-scale output spans of 2.5V
> > or 5V for reference voltages of 2.5V. These devices operate from a
> > single 2.7V to 5.5V supply and are guaranteed monotonic by design. The =
"R"
> > variants include a 2.5V, 5ppm/=B0C internal reference, which is disable=
d
> > by default.
> >
> > Support for monitoring internal die temperature, output voltages, and
> > current of a selected channel via the MUXOUT pin using an external ADC
> > is currently not implemented.
>=20
> ...
>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
>=20
> > +#include <linux/device.h>
>=20
> I don't see how you use this. But
>=20
> + dev_printk.h
>=20
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h> #include <linux/spi/spi.h>
>=20
> ...
>=20
> > +#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
>=20
> > +#define AD3530R_MAX_CHANNELS			8
> > +#define AD3531R_MAX_CHANNELS			4
>=20
> Sounds to me that these two shouldn't be grouped with the rest here. Perh=
aps
> move them out to after the LDAC_PULSE?
>=20
> > +#define AD3530R_INTERNAL_VREF_MV		2500
>=20
> _mV (yes, with Volts and Amperes we use proper spelling).
>=20
> > +#define AD3530R_LDAC_PULSE_US			100
>=20
> ...
>=20
> > +	int (*input_ch_reg)(unsigned int c);
>=20
> c? channel?

Thank you for the feedback. I'll change this to 'channel' to make it cleare=
r.

>=20
> ...
>=20
> > +	int vref_mv;
>=20
> _mV
>=20
> ...
>=20
> > +static int ad3530r_input_ch_reg(unsigned int c) {
> > +	return 2 * c + AD3530R_INPUT_CH;
> > +}
> > +
> > +static int ad3531r_input_ch_reg(unsigned int c) {
> > +	return 2 * c + AD3531R_INPUT_CH;
> > +}
>=20
> c --> channel
>=20
> ...
>=20
> > +static const char * const ad3530r_powerdown_modes[] =3D {
> > +	"1kohm_to_gnd",
>=20
> kOhm
>=20
> > +	"7.7kohm_to_gnd",
>=20
> Ditto.
>=20
> > +	"32kohm_to_gnd",
>=20
> Ditto.
>=20
> > +};
>=20
> ...
>=20
> > +static const struct iio_enum ad3530r_powerdown_mode_enum =3D {
> > +	.items =3D ad3530r_powerdown_modes,
> > +	.num_items =3D ARRAY_SIZE(ad3530r_powerdown_modes),
>=20
> + array_size.h
>=20
> > +	.get =3D ad3530r_get_powerdown_mode,
> > +	.set =3D ad3530r_set_powerdown_mode,
> > +};
>=20
> ...
>=20
> > +static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
> > +					 uintptr_t private,
> > +					 const struct iio_chan_spec *chan,
> > +					 char *buf)
> > +{
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +
> > +	guard(mutex)(&st->lock);
> > +	return sysfs_emit(buf, "%d\n", st->chan[chan->channel].powerdown);
>=20
> + sysfs.h
>=20
> > +}
>=20
> ...
>=20
> > +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> > +					 uintptr_t private,
> > +					 const struct iio_chan_spec *chan,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +	unsigned int mask, val, reg;
> > +	bool powerdown;
> > +
> > +	ret =3D kstrtobool(buf, &powerdown);
>=20
> + kstrtox.h
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +	mask =3D GENMASK(chan->address + 1, chan->address);
> > +	reg =3D chan->channel < AD3531R_MAX_CHANNELS ?
> > +	      AD3530R_OUTPUT_OPERATING_MODE_0 :
> > +	      AD3530R_OUTPUT_OPERATING_MODE_1;
> > +	val =3D (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
> > +	       << chan->address;
>=20
> Please, move the operator to the previous line, Or even
>=20
> 	... pdmode;
>=20
> 	pdmode =3D powerdown ? st->chan[chan->channel].powerdown_mode :
> 0;
> 	val =3D pdmode << ...;
>=20
> > +	ret =3D regmap_update_bits(st->regmap, reg, mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->chan[chan->channel].powerdown =3D powerdown;
> > +
> > +	return len;
> > +}
>=20
> ...
>=20
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val < 0 || val > U16_MAX)
>=20
> U16_MAX is an abstract type with this limit, do you have any predefined H=
W
> limit instead? Probably better to use that one as defined via BIT() / GEN=
MASK().

Will add a macro for this hardware limit.

>=20
> > +			return -EINVAL;
> > +
> > +		return ad3530r_dac_write(st, chan->channel, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
>=20
> ...
>=20
> > +static const struct iio_chan_spec_ext_info ad3530r_ext_info[] =3D {
> > +	{
> > +		.name =3D "powerdown",
> > +		.shared =3D IIO_SEPARATE,
> > +		.read =3D ad3530r_get_dac_powerdown,
> > +		.write =3D ad3530r_set_dac_powerdown,
> > +	},
> > +	IIO_ENUM("powerdown_mode", IIO_SEPARATE,
> &ad3530r_powerdown_mode_enum),
> > +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> > +			   &ad3530r_powerdown_mode_enum),
> > +	{ }
> > +};
> > +
> > +#define AD3530R_CHAN(_chan, _pos) {
> 	\
>=20
> Slightly better to have the curly braces on the same column as it's easie=
r to
> read.
>=20
> #define AD3530R_CHAN(_chan, _pos)				\
> {								\
>=20
> (and make it one TAB less for the backslash).
>=20
> > +	.type =3D IIO_VOLTAGE,						\
> > +	.indexed =3D 1,							\
> > +	.channel =3D _chan,						\
> > +	.address =3D _pos,						\
> > +	.output =3D 1,							\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> 	\
> > +			      BIT(IIO_CHAN_INFO_SCALE),			\
> > +	.ext_info =3D ad3530r_ext_info,					\
> > +}
>=20
> ...
>=20
> > +static int ad3530r_setup(struct ad3530r_state *st, int vref,
> > +			 bool has_external_vref)
> > +{
> > +	struct device *dev =3D regmap_get_device(st->regmap);
> > +	struct gpio_desc *reset_gpio;
> > +	int i, ret;
> > +	u8 range_multiplier;
>=20
> + types.h (and especially for boolean type along with true/false definiti=
ons.
>=20
> > +
> > +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> > +				     "Failed to get reset GPIO\n");
>=20
> + err.h
>=20
> > +	if (reset_gpio) {
> > +		/* Perform hardware reset */
> > +		fsleep(1000);
>=20
> (1 * USEC_PER_MSEC) ?
>=20
> > +		gpiod_set_value_cansleep(reset_gpio, 0);
> > +	} else {
> > +		/* Perform software reset */
> > +		ret =3D regmap_update_bits(st->regmap,
> AD3530R_INTERFACE_CONFIG_A,
> > +					 AD3530R_SW_RESET,
> AD3530R_SW_RESET);
> > +		if (ret)
> > +			return ret;
> > +	}
>=20
> > +	fsleep(10000);
>=20
> 10 * USEC_PER_MSEC
>=20
> With these constants it's less error prone (when 3 or more zeroes) and ea=
sier to
> get the units without looking into fsleep() implementation / documentatio=
n.

I'll take note of this.

>=20
> > +	range_multiplier =3D 1;
> > +	if (device_property_read_bool(dev, "adi,range-double")) {
> > +		ret =3D regmap_set_bits(st->regmap,
> AD3530R_OUTPUT_CONTROL_0,
> > +				      AD3530R_OUTPUT_CONTROL_RANGE);
> > +		if (ret)
> > +			return ret;
> > +
> > +		range_multiplier =3D 2;
> > +	}
> > +
> > +	if (!has_external_vref && st->chip_info->internal_ref_support) {
> > +		ret =3D regmap_set_bits(st->regmap,
> AD3530R_REFERENCE_CONTROL_0,
> > +				      AD3530R_REFERENCE_CONTROL_SEL);
> > +		if (ret)
> > +			return ret;
> > +
> > +		st->vref_mv =3D range_multiplier *
> AD3530R_INTERNAL_VREF_MV;
> > +	}
> > +
> > +	if (has_external_vref)
> > +		st->vref_mv =3D range_multiplier * vref / 1000;
>=20
> MILLI?

Yes this is milli, will change this also to vref_mV

	st->vref_mV =3D range_multiplier * vref_mV / 1000;

>=20
>=20
> > +	/* Set operating mode to normal operation. */
> > +	ret =3D regmap_write(st->regmap,
> AD3530R_OUTPUT_OPERATING_MODE_0,
> > +			   AD3530R_NORMAL_OPERATION);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {
> > +		ret =3D regmap_write(st->regmap,
> AD3530R_OUTPUT_OPERATING_MODE_1,
> > +				   AD3530R_NORMAL_OPERATION);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < st->chip_info->num_channels; i++)
> > +		st->chan[i].powerdown_mode =3D AD3530R_POWERDOWN_32K;
> > +
> > +	st->ldac_gpio =3D devm_gpiod_get_optional(dev, "ldac",
> GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->ldac_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> > +				     "Failed to get ldac GPIO\n");
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +	vref =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> > +	if (vref < 0 && vref !=3D -ENODEV)
> > +		return vref;
> > +
> > +	has_external_vref =3D vref !=3D -ENODEV;
>=20
> Wouldn't be better just make this 0 when it's =3D=3D -ENODEV and check ju=
st the
> value without having this additional boolean variable (note, I haven't ch=
ecked
> the meaning of Vref =3D=3D 0 in case it's possible in real life and hardw=
are behaves
> adequately)?

I think it could be simpler to set vref to 0 when it's -ENODEV and check it=
s value directly
without having additional boolean variable. I'll try this approach.

>=20
> > +	if (!st->chip_info->internal_ref_support && !has_external_vref)
> > +		return -ENODEV;
>=20
> > +	ret =3D ad3530r_setup(st, vref, has_external_vref);
> > +	if (ret)
> > +		return ret;
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


