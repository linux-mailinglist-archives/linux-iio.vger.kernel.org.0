Return-Path: <linux-iio+bounces-20696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE9ADA9BB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A7C7A294C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485620E01F;
	Mon, 16 Jun 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="fTA8Qury"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE31F4631;
	Mon, 16 Jun 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059780; cv=fail; b=Ty3gD4pmm/VBYffxYUG/c8d8PUWODNTEvIYT6vJnb8on6tGcJFJVGWCOhC/The657S/04ZhwZBgYWwvle6xF3wbYHEN3kotfKeSOVfuSXD3FA+ZGICwekLdJuXFcPHb4Ub/inFonlEwCMRDzskHX5qdpE8GkUql/mu2+Tw6q2p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059780; c=relaxed/simple;
	bh=eMCoitgMhBl/1GF6n+k918fzxQR8osHKM2vEqOJ+KpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CjfIzpfTPhWJG44Ag7nCrbuKKjZKsQmhXbzAgEjNP7Bj/TYl8lLq32wfuVP54aiALxl9h6468OTtuFLWJsTHPsi4mBel4HXF9y2eGIRXmIjSogtluAE/pG1rqkSoeSBy8zTmfbNnI1XllhfdXTFxTAkEPF6vAr4iqObh49bWe1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=fTA8Qury; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNUmlr012342;
	Mon, 16 Jun 2025 07:42:28 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012064.outbound.protection.outlook.com [40.107.149.64])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4791nk11cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 07:42:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQzd3zlgIebZPbeqf+VrUEDAWpCEJWDIF/3SQvGT6FYXizju673YcWGiyKC24sEQtiCfSkGOl6eBQIawlO8XY8obnYbSdkipTfAHLGUqlX1X2IETwkU7URpcN2aQX2qwFRIg9Nf4RlGQ59TiTS+fp1ImWcMw8A/AyMG5n9SUF2pigcIsEc2/IGhDCLAXsfNcctcUoyUNVVgpwTi5VCPVDBPNXYCQEhqLxPk/lsAaU1cVtKd8XMVwZbgGO6KD8BD6eHdbGcQ7Ydp0QnY4sWBr+xSKFDOnbSVHwPQur4I063CenTFdKFbxo/Uk83lxuO4ML7MX3yc7VisSdNZrSw7uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgeUrdAOHISjxCr8tuFUqwQXTmaouDip6YF4f5PcCHI=;
 b=lC25HcOJLVEpgYnNsj4XQm2jYFwQBi3rx3Q7cG2IWcQ9AOEzpjbFmXqLgroBSdxZ+jxJbOQaqZsT30P2A7LFqLiQVdy9k3o9cYjeQymRrfK69AMRdfY9n40d31jP6JJT/JwpgclzfBL6reiVh5QxPrtDjLuehmMXioQ3wcgq+jZxTpMXq7JQh6O3VEE9GABbIoLA06WK2vNEGZNdVVMW6E7TeNwtPyFCgLyXfRc4ThBu3v+/BMdGStDHXdLgzaEaoUyRbcLTy5v/6ZAkOdls+DInojJtk2vkQb5qN5vdZY6kL6wmvI6EnEtA05NsHZjwqlyaqjRDhKflMRgNh9aWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgeUrdAOHISjxCr8tuFUqwQXTmaouDip6YF4f5PcCHI=;
 b=fTA8QuryGSz4Ri01FE2DY01irWFIwqXsS11rqAGWW2wNbETEWjiBrVYc2cPQhbj/XvhziYCh/Yn/mOsWAju2P5t/FNrVTRXXQ2ms/+gz/GviuWZAKh/yN5U4cWBtLaqM26fW6G0xSunaT+k6zGM53lT916R0mioLodUsimj701VI770WsBm3XZic5ORTM1DEtLFUj24tieReXe3G/n6u8EtHixx55dmd8HDah+rYVHs1gGk1W74uZ+bD+k+i+yrZW93u7dGlk/kKfvX+ywbP4fvFD+dFUS4kK3Fm7Hgldf6EKM/3gzE3DaLa08ZptUDM5q2v+MiozhdtGWvRoULJCA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE0P281MB0100.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:42:17 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:42:16 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner
	<dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHb3DWiaJg6fqmsLkOWVuHD5p4+yLQCnh0AgALK25k=
Date: Mon, 16 Jun 2025 07:42:16 +0000
Message-ID:
 <FR3P281MB175789F6AADF5D0D15BC89A1CE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
	<20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <20250614135304.10d0fee9@jic23-huawei>
In-Reply-To: <20250614135304.10d0fee9@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE0P281MB0100:EE_
x-ms-office365-filtering-correlation-id: fa66d6cc-f6aa-4fcd-f31d-08ddaca950f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WuYjRTksdtRlUhXIqwPkC+r8r5Ec9sbD4Jgv2obVtz6PuCEs67F+8B7ezr?=
 =?iso-8859-1?Q?n3TizVdCdDpaxHiHMNs/gI/9igWVhL+Wp8WJXTQn/rVsqKW1NC9/9l0RSF?=
 =?iso-8859-1?Q?v3nf3IAXS7AgBj6Zlm0sYBFz4xncTscOv3Ry8U7cX01MDk+w7vpyR6Vicr?=
 =?iso-8859-1?Q?7nI8qSReRz5MPGKqYEPY5xW7VT8KXV18IzHMBvP/NQlSVxxEBbLLkkf9SN?=
 =?iso-8859-1?Q?eFBjqlxWgKTsU6sRJX/mwFu2T+kVq8UGqItU6HNnPVTnICGVgYF8nqBKVx?=
 =?iso-8859-1?Q?3TuMWUEuAgz3v3l4CY74PGFXysQqYSezB+r4ixuvpjWI59PKyOBJmtJ8jQ?=
 =?iso-8859-1?Q?s4hjPFBuBEQDym+v5I2XQwxxTVM9yHq2M9oqeonGX8LNczzgqY05JNgtSo?=
 =?iso-8859-1?Q?psdzpxHo1ZiMJdQvh6ae9Fa7m1rOkOFTlrkMUEwNfA1SX3tb9QpSWHO1Vg?=
 =?iso-8859-1?Q?5EDLWB7+2wrDX4txc5Y16zZXlYGnu83HGreRXwpkIpm08yx2uZoVgfUTTS?=
 =?iso-8859-1?Q?qIJp/jhOVk678kAGXo7ZbxPLPUGxOEicPUadqXijGRchRv0ZNtQLFmdIIR?=
 =?iso-8859-1?Q?//aZKdsjsK3QPsTOoAs/goqbxrS4H2+pblwBdGvL9Bmd6rpdv0/VO9RyJN?=
 =?iso-8859-1?Q?9OcztqQ5STrix6hwKoliihAsMCirAGe4llC/Y2wuPGiScPkX58YkxrEEy2?=
 =?iso-8859-1?Q?FdqnLknqK4X/O9Yo38CIUdJRHiq3rx+eSNJwGHmP9TYbD2UEc6B3FSjLlm?=
 =?iso-8859-1?Q?7fmVlOj5Rid4tYuZct/IAvBIFQoWCrVGBPGHp0lLPpLEyHGRzFJsoon67j?=
 =?iso-8859-1?Q?I+u09NkjJuBwo0sRr+0YhfVhoXweTsV+Yo4bLnekn8JO56NgXeJ1qlnkhP?=
 =?iso-8859-1?Q?e7uN95dcdBmRm3ztQscN2NXughZqKAfeWJIObKP8lGOmlUn9aDyOB1VsIc?=
 =?iso-8859-1?Q?oqLBvgIZYp/EVfUaKy6sEcp4fZPYhl5xRiw8cnI1GdoxTGxYgOmZth6bkK?=
 =?iso-8859-1?Q?X0Ctk7xf628ERM55z7cULBkcsKjZEbgGkKRVf2J1rUPXFGc2sGnbkyWxxq?=
 =?iso-8859-1?Q?DKVwHtHtcg7vBZcHHEn0wyx/hVwGY4Ez9domjnfAct9PkhJwNoPd6xcn4S?=
 =?iso-8859-1?Q?FkhTRuHLywyWaKt08Tu6Td8uYOkb780I7wVVqebqz3Lt6N56kdZo7O43O/?=
 =?iso-8859-1?Q?sy0jFIe2MzcxxkmhwDJhuAvx3d80C5VHJTgwDATRvgsNEPBTSGU7MDlIYR?=
 =?iso-8859-1?Q?ctsKGfCltNz5QsltGe+lNednLtpF1FP2Xv/G11FDwZ5ZZsi+0buwyVu2wf?=
 =?iso-8859-1?Q?v0xHkbngDWI9qJ1N52Iw1gE7HcACV/Ltll2EZ+wh2Z32rq+/hHbL0wUEU9?=
 =?iso-8859-1?Q?lx8zCOeOJYl0o5NCUOPIfAJUz+mt973IZKImYFB9f3DQORlQSkaix6gEaM?=
 =?iso-8859-1?Q?nOJLojWdukMTr84FTYo9yTIWA4CxwsMxIRExPm7ny0kzhBRTUpSmRjatqK?=
 =?iso-8859-1?Q?GfaDVFWtqip33tvKFh9boHlppRpDDNuJUXz+MTGe4umQ9x5pmoOEaQJV/A?=
 =?iso-8859-1?Q?1nNyDCIz3k9uZLOW/UMXIsARuEXp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0mIqdOAIIYefTu1RyrIvqijnABmNbl8XwMAwhmqTUh08bqm1UntyWt1RUD?=
 =?iso-8859-1?Q?rvVklVsqn00P1xWYKh3sGgOzC7GW58ZRzGDqZymW30KCvQonCFoBsPqMP2?=
 =?iso-8859-1?Q?Dlp/pABmauhe9VqkGeGj+AaQ535Gb9bDQbV4GuibS3EpVOP2OPa4yL7Eyq?=
 =?iso-8859-1?Q?rW0o6axqo6/4ipL1g+TOFWS1U1+9S+EqU4MsI3hzVdJeR8rA8x9bo79KJg?=
 =?iso-8859-1?Q?6rbqoXHppe+pM+gDCZ7VuIL2/38P1vjOcHNL5cIWG5ZBdSnyQiwrDde9+v?=
 =?iso-8859-1?Q?WplsezXOdUDMOg/lxp9Xi5sAcb29B3hO6sPwrlIfh9EpjpsR8oLoxDdqxr?=
 =?iso-8859-1?Q?FiNGTi8w9eX71nUnrWAcK126I4h9GpidGk3up5aSFl3r6alnEsMvCs9vAt?=
 =?iso-8859-1?Q?rWHY55P53qau21w0pnDSL/6+5FycoXOQXm3BqxrgCUehOZ33uxOs66sGJJ?=
 =?iso-8859-1?Q?h2bwe9JFizxBI7gmvJKIHurqLSy2CQ0bKNxa9C4seq/wWFgAS+XsVILSlv?=
 =?iso-8859-1?Q?4Ytz3fOnOGAQEBrqpiZfm/4s72TdapWGikEnsy90/ayLa3FYQTz5p4mwzV?=
 =?iso-8859-1?Q?Migcr8L/0BaFd3OuPb2n05IZN8MAEKcbjg5YSiBIZD9In7Z4rDBnjm2UQO?=
 =?iso-8859-1?Q?MWNGXJjb8feH7oX/sk+eGym9D28IMYT9If67p+NUXkw3hOYt4h510wxWjv?=
 =?iso-8859-1?Q?/JfgEPhjekZgb/NsuS69+mlSxEW64tOnBLqdeh0H0xoFtXiTytyckPJYFP?=
 =?iso-8859-1?Q?rFxqHuxyfjw8xfCjBrhosyd8kMQAeWLgA/HtKTb7ntSKjwmolv5ePugU6U?=
 =?iso-8859-1?Q?pC+BMwTIf84PNg/BZqgutMv024GqxNPsqZ/oU4rmRMYiPGb+yzXv5hwafg?=
 =?iso-8859-1?Q?Q1nwqSX9BXjhEsAx213GSx0r9H6wSxYXpPOMZ9pVg+iQR8DxYtUT+ENT/h?=
 =?iso-8859-1?Q?YzCVEpDGH00V14snn9HlHV3EV20nwpHyhlsRJk/80seZgcJPgL+PYWPXi2?=
 =?iso-8859-1?Q?LMD71IKy66ZWkpJuFtgQM0F9t/q86juJRutsZdSkwPRtdb/unIuohFidX5?=
 =?iso-8859-1?Q?lQP07FnbTmc4B455vDFfPWQupwzz91lAaWG4F9BMBxv4R6t8RlwKEOcKc/?=
 =?iso-8859-1?Q?nzw9JlENKUECtOIPhI/V/6wetTDguB6SmPrAlJBPuqlfesFd78fok1N+Kw?=
 =?iso-8859-1?Q?Laa9zXo1JGKyvgyX1SqyglatXWEhEsI0yGd8z3KBf18iSArIUXLfl54wLZ?=
 =?iso-8859-1?Q?wvNa5jOQVoWn9I9AbZjicR+WMgwlBzEuTSg5HwzzWhX+8Yzl0BYBqC4upX?=
 =?iso-8859-1?Q?UvghzNhOX2f/zB1O1OiZEl1qGrGlYOaPq7udStRZbevH633LuXECyCusa6?=
 =?iso-8859-1?Q?5sR8bOq9XG/g68L3wl3SC2h3xd8YJkIzV7xJB1ti7DjAc65v+X1/coHQT/?=
 =?iso-8859-1?Q?Q7HGphnnBOGbwA7gsCuuiqWPV3IBLmDyQq2K5XW0lHQWaZ9nlUv3W+rOik?=
 =?iso-8859-1?Q?Y4oN4EiEpjcL0vhg8LekDAcO2KumvpjnQYKYMqNXvySj3XDpPpXoFZvzUk?=
 =?iso-8859-1?Q?IT1tPFTcExwcFjLSFNvMHlKDjxEKbh4MPD+FUvkhd/9iR9sfw+sbf7+sQa?=
 =?iso-8859-1?Q?y0mZooRBBAtAWf7dUM4jafTqS+f9IxQuXpYQctRdJ0o/NP3LD7/aikqQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa66d6cc-f6aa-4fcd-f31d-08ddaca950f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:42:16.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exAhvWhyBlSiNKh4QZuptZIvcEhKcRG8tcDBMne7c96bFbicneddaVgelqCgmrkQnzwt9DsA4i1pVadgyOwfuoohHRVQRmPUQ0HaHx8zeSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0100
X-Proofpoint-ORIG-GUID: GJb5bxnnnQ21WYdTKL3R0-FGmyyUM14Q
X-Proofpoint-GUID: GJb5bxnnnQ21WYdTKL3R0-FGmyyUM14Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0OSBTYWx0ZWRfX+O/VNqf2UURu
 UDztxzNDaVWenW2X9It3RdeaGDP7hz2jdc8K96b7aDzHmEaFZBYOSKo0aou2+9PCvXsJpdZf/pU
 2pKgnqD6mbSbPZ92JE6cuxtS5nZxv+ARC+nHRZcZCEcCWzRYhBpzEw83G/+tLF/p3TFvCRCBeuE
 r8wOmVMBCbrI4wIggBbR2zV9f0bLQtKYy/S7MHKghpcLviJGc2LVDma/oC4pEI5UFYPDkXsJfup
 wolCZhtyuIUUCWIz5IVWecRuir3ViabIhqvzeMTbSVOxD+8WFaSsMuYv11H7uqNkNN1Wtu+iEKP
 wz6wnuodz99qtKQxdTrGM+aVK3a7VM0l8gu1cBpBGqa+9QHgNHpu21zCif5CoTbgaaNF+V7wwU9
 7vOOxsvWQyciZaFN4aMtKcpyDnyKRAH6LXOYqM2EZUVYY+vLQe44VNIkgEYj6WgdPD412eot
X-Authority-Analysis: v=2.4 cv=C/PpyRP+ c=1 sm=1 tr=0 ts=684fcae4 cx=c_pps
 a=vDd4nxUi3q3OcmX6cYwc2A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=5oJRwxC-VJ8zwEdryuYA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160049

>=0A=
>________________________________________=0A=
>From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
>Sent:=A0Saturday, June 14, 2025 14:53=0A=
>To:=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.=
tdk.com@kernel.org>=0A=
>Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter =
Clausen <lars@metafoo.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1=
 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; linux-iio@vger.ke=
rnel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
>Subject:=A0Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, 13 Jun 2025 09:34:26 +0200=0A=
>Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.co=
m@kernel.org> wrote:=0A=
>=0A=
>> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
>> =0A=
>> Add WoM as accel roc rising x|y|z event.=0A=
>> =0A=
>> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
=0A=
>Hi Jean-Baptiste.=0A=
>=0A=
>A couple of comments inline.=0A=
>Ideally pull the movement of the timestamp struct to before the DMA safe=
=0A=
>buffers to a precursor patch.   That is a bit subtle to have hiding in her=
e.=0A=
>=0A=
>The guards thing can be for next time you are doing a cleanup series on th=
is=0A=
>driver if you prefer.=0A=
>=0A=
>Jonathan=0A=
=0A=
Hello Jonathan,=0A=
=0A=
concerning the full driver rewrite asked by Andy to switch to uXX/sXX kerne=
l types,=0A=
can I put it inside this series?=0A=
=0A=
Otherwise, should it be in a separate patch and perhaps with a fixed tag so=
 it=0A=
can be backported to enable automatic backport of further fix patches?=0A=
=0A=
Or can it be after this series is accepted? I would prefer that.=0A=
=0A=
Thanks for your help here.=0A=
=0A=
>=0A=
>> ---=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  54 +++-=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 289 ++++++++++++++=
++++++-=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  58 +++++=0A=
>>  4 files changed, 395 insertions(+), 8 deletions(-)=0A=
>> =0A=
>> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/i=
mu/inv_icm42600/inv_icm42600.h=0A=
>> index f893dbe6996506a33eb5d3be47e6765a923665c9..413a15493bcb880dc00b20da=
3b3168d5addd32a9 100644=0A=
>> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
>> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
>> @@ -135,6 +135,14 @@ struct inv_icm42600_suspended {=0A=
>>  	bool temp;=0A=
>>  };=0A=
>>  =0A=
>> +struct inv_icm42600_apex {=0A=
>> +	unsigned int on;=0A=
>> +	struct {=0A=
>> +		uint64_t value;=0A=
>> +		bool enable;=0A=
>> +	} wom;=0A=
>> +};=0A=
>> +=0A=
>>  /**=0A=
>>   *  struct inv_icm42600_state - driver state variables=0A=
>>   *  @lock:		lock for serializing multiple registers access.=0A=
>> @@ -148,9 +156,10 @@ struct inv_icm42600_suspended {=0A=
>>   *  @suspended:		suspended sensors configuration.=0A=
>>   *  @indio_gyro:	gyroscope IIO device.=0A=
>>   *  @indio_accel:	accelerometer IIO device.=0A=
>> - *  @buffer:		data transfer buffer aligned for DMA.=0A=
>> - *  @fifo:		FIFO management structure.=0A=
>>   *  @timestamp:		interrupt timestamps.=0A=
>> + *  @apex:		APEX (Advanced Pedometer and Event detection) management=0A=
>> + *  @fifo:		FIFO management structure.=0A=
>> + *  @buffer:		data transfer buffer aligned for DMA.=0A=
>>   */=0A=
>>  struct inv_icm42600_state {=0A=
>>  	struct mutex lock;=0A=
>> @@ -164,12 +173,13 @@ struct inv_icm42600_state {=0A=
>>  	struct inv_icm42600_suspended suspended;=0A=
>>  	struct iio_dev *indio_gyro;=0A=
>>  	struct iio_dev *indio_accel;=0A=
>> -	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);=0A=
>> -	struct inv_icm42600_fifo fifo;=0A=
>>  	struct {=0A=
>>  		int64_t gyro;=0A=
>>  		int64_t accel;=0A=
>>  	} timestamp;=0A=
>This was a bit subtle and had me going for a minute.=0A=
>The timestamp should never have been at this location in the structure bec=
ause=0A=
>it's mid way through various regions with forced alignment.  It isn't actu=
ally a bug=0A=
>I think though (beyond unnecessary padding) because the fifo struct obeyed=
 c spec rule=0A=
>that anything after it must be aligned to it's largest aligned element whi=
ch was=0A=
>IIO_DMA_MINALIGN.=0A=
>=0A=
>Maybe move this in a precursor patch where you can talk about whether it w=
as a problem=0A=
>or not?=0A=
=0A=
I can move it in a separate patch at the beginning of the series. This fix =
was asked=0A=
by you to avoid potential hard bugs, but it dates sorry.=0A=
=0A=
>=0A=
>> +	struct inv_icm42600_apex apex;=0A=
>> +	struct inv_icm42600_fifo fifo;=0A=
>> +	uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);=0A=
>>  };=0A=
>>=0A=
>> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
>> index e6cd9dcb0687d19554e63a69dc60f065c58d70ee..9a2089527a9426b70eb796d4=
e9c234d8804c508b 100644=0A=
>> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
>> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
>=0A=
>=0A=
>=0A=
>> @@ -860,6 +911,13 @@ static int inv_icm42600_resume(struct device *dev)=
=0A=
>>  	if (ret)=0A=
>>  		goto out_unlock;=0A=
>>  =0A=
>> +	/* restore APEX features */=0A=
>> +	if (st->apex.wom.enable) {=0A=
>> +		ret =3D inv_icm42600_enable_wom(st);=0A=
>> +		if (ret)=0A=
>> +			goto out_unlock;=0A=
>=0A=
>One for another day, but this would definitely benefit from some guard() m=
agic=0A=
>and there are a few other bits of existing code that would as well.=0A=
=0A=
Same here, it was decided long ago in the first series to not switch to gua=
rd()=0A=
yet but later.=0A=
=0A=
>=0A=
>=0A=
>> +	}=0A=
>> +=0A=
>>  	/* restore FIFO data streaming */=0A=
>>  	if (st->fifo.on) {=0A=
>>  		inv_sensors_timestamp_reset(&gyro_st->ts);=0A=
>> =0A=
>=0A=
>=0A=
=0A=
Thanks,=0A=
JB=

