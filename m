Return-Path: <linux-iio+bounces-9623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F297A850
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 22:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BDF1C21CFA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B11138490;
	Mon, 16 Sep 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="iiwJBSnw"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3F107A0;
	Mon, 16 Sep 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518783; cv=fail; b=QGz27Lf3/kuPRbm0HKHt93LJF/yym6epVgCLj9+b9aYCtzg0ftHn1xL8NbQHsiaFwXqqTpTIAtRD6yqQf4BFSh3V4UUJudWs89GtUn8Uvgnyzia89KL5KgGWVBJ3XuamBQOwL7iyQqzOFMThCc/+j3F5ysM2g/2YxfwzlWJkkVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518783; c=relaxed/simple;
	bh=BheQeieGNk/eFsMcCYHXTaWoPnrtshdR3voHC2hopWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ggy+hlXFPqZn0ieoVXld6ZcwFHL0bOvdZj93SSeqLJnR9sDmmYwsHiHMDt+xh60/fchWdHLQxynnaS/8FiazTcLxs9PjuE6273nCkYNAGcdDDpJjE1R44wG+RUMXpmU+MaGNMKmEyb2KMFe/nM5jzN/I5jwqioEwgA8YeKRWwMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=iiwJBSnw; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgQn8Zah7qWgy7XXkNGI5sv5RqXhT38AutdBtmwPY9BQzMMvNRYX0rNYc4zalRQ50legRO+nfCuCNL/xWm+U3x1QCggLxkBkyLj7AInoPS8ybzZg1KUpdC80jutYkpOzIviPx9eIj/bVO1uNKM6qtmURxnNsfB6MEojqiO94HCO/Lt/P4I4fyiyEzJfHnwtx2CH4OxRqtAZJv/AL9sYJnXi+OZ0T6NMcqiD4kqixXRwB6qAHqEVtWqbv2wAJIVZ9oy+D7Zv0vv3HnRkS6B1pcRONHOf/xPbkq7ki/huvh8rDE2O7uwDT93dzucN9qb4phgsvjCTVt4Ih6Ejh5wG/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BheQeieGNk/eFsMcCYHXTaWoPnrtshdR3voHC2hopWc=;
 b=hXtkR33uRH9iXWDonsxtAAxklExWLznMgg3vgRx0aKycvit+XbVcDhnw1Hyi95ysNQo9kouiw8X6JP567Sw4hmrhMp03n0n7jnCP0bpJ3D3oxPv5MKzaXR+KVtxJkB9Qrs/PEGDfC/vNR3nJo1jQADxOWXkwqgdipzrzTvEo5q/VaVD18yKe7P1TX7eIAr0p1Avy84Me9hOniaE5qtGT/LYQGlwUWLvN3jYW2lVo470hJUjlHsKCM6jRk4xg3K/oEV6NF5m9cDUkEKxs6hfCQvOEyMoYB43LzBVYlfm33l1ws0KynrapcR8afjTVDyp0gAdp3BN6xBlExL5vjTSaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BheQeieGNk/eFsMcCYHXTaWoPnrtshdR3voHC2hopWc=;
 b=iiwJBSnwNJAcgphtZNj73RnJhRe6YpRQi8BXWn3IvRgG4SoTXaL3QsCMN83+I5etxayv/6TjcHB2GDdvGdMzfNIGZNRcpYHCiq8w8qnsX3EKQwb1SDWJFXaL4m2+xI3S5B273+6MwE8qWxPU9nUxhr3J7xHqv+GNuPIZHiSH23bLkNu3CFV0kz90PjcIJIvwHnGshbR7pmh7EjhOwJ2UA62cQd1ZR6Yb7owAWCW/Zv1aJxVlcENtPjpuHofsWbLkYFDym39qbiTrkjWkbYY8vfMLuYHvL2SXYEmNIPlSHrLw/Y+dp5DCj1I4gAZ+vSrIAJB3KPVSX4xvDKmQZBnl+g==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by PAWPR10MB8137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:385::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 20:32:56 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 20:32:56 +0000
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
Subject: RE: [PATCH v7 2/2] iio: imu: smi240: add driver
Thread-Topic: [PATCH v7 2/2] iio: imu: smi240: add driver
Thread-Index: AQHbBcPr5qpIygQlnEirrZ7fjzK4yLJXe9mAgANiFgA=
Date: Mon, 16 Sep 2024 20:32:56 +0000
Message-ID:
 <AM8PR10MB4721196E13BCDAD7ABAD8E85CD602@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
	<20240913100011.4618-3-Jianping.Shen@de.bosch.com>
 <20240914173229.57548005@jic23-huawei>
In-Reply-To: <20240914173229.57548005@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|PAWPR10MB8137:EE_
x-ms-office365-filtering-correlation-id: 635bea95-c241-462d-55dc-08dcd68ebf47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azdkTnNsaklqMFh6R3NISkdzTUZFdk5LOVdEK0s1T1BFc240S3RaWEMxUFM2?=
 =?utf-8?B?OHMvT0xJM3JVK3UrREFHTnQyZ2Nxd1c0S0JwM3ZobnJqUXpQb1FvUDZrSHJB?=
 =?utf-8?B?ZmVyQ3YvZjNXVStnS1pmUFh4M0Ftck9ZRi9uTmI3M2tMNmtYTE4zZnRrYU8r?=
 =?utf-8?B?ZDkvdi8zWk1CS2J6NHp6ZkxKSkh2VEZVUTdrbGJIUmR0YXpKNTcrNGJvOFJn?=
 =?utf-8?B?eFhYOS9HWkcvK3hzSGkyR2xRQmhSSUI5L3pYWWdGb2t5UWxOcVpOSE9zWWMw?=
 =?utf-8?B?d1ZkRGZ5aVlWYmh0WFVsTEJyWGZSNnNPZVRGb3JJdG5CQzVHRzlhTHhUb291?=
 =?utf-8?B?MHROMUo1b1Brcy8rbXBzMGYwTXlIWGdPZU5zSkttRUN0VklVdlM0RElyZjZV?=
 =?utf-8?B?NVhaeTNOT28raDFrMy84L0VSUGhVanV6WnFlVHB6RDdKeldkMGFBRXdZRzRZ?=
 =?utf-8?B?QWlRRjQ2K1BFRXVwTmpmMjFnQ0lRQ1JNR1lyeHdOVWVIdjBwVjg2b25kWE9B?=
 =?utf-8?B?ZHA5N0x0aXhTbWY3V2NjWW9Jb3VGTUxFYWlXVlJ3WDFiWDNYbTRaNExrZytE?=
 =?utf-8?B?ZUxhbVJkYVlRcUhOanY3dWJVN0ZkZXI0MG5YUmc3QTJ1ZnFWY1Q5YitMUHpl?=
 =?utf-8?B?Y3U2aE82U2pveWJsWVN1amxhUkFBUjl4ZU9pRXpTQ0hxNm1scmJQMU00SUNR?=
 =?utf-8?B?Q0hONkVyUnBlMFhKUjRhSHJKbHNRUkRWMG1GNFZVNXpRbWVXTTBJaXhKMXA4?=
 =?utf-8?B?SmJEUGl5aVpPNjIyWWl4SDFhbnI5TjZVTng5ZEZkVENBYmRRNkdSNGdEWEVv?=
 =?utf-8?B?emJuVXg3YysvMnZLWlUxZGhZRjAxa2ZmKzhrQVZYQ0FPYWErOU9Dd3NGTmJq?=
 =?utf-8?B?QXhscTN3dGhMU0c4L0dROEFMQkVrZmljTE1UMHlPYmlnQnNTYVlGMDRKdEhu?=
 =?utf-8?B?anFLZFU1WFVCR3U0VTdCUmxxUFpWRGtqMk9HaTV0SlJJZm1nYURtbHpYdzI5?=
 =?utf-8?B?U0drOXVSZk1qNmo3b1ZBVXZqamxvakNmNUxjZmZiMzRRb2FQc0ZaNEthVlRi?=
 =?utf-8?B?S1lSUis3RU1aOVQ4bGdObytGYTRnZ2I4bHc0SGhwYnR6NHB0cWpYSE9zSmZz?=
 =?utf-8?B?dENpR3lmTVZoeUxaTVF0cFkvbThLSHFlY25mZ0wreGNTdjlQanBwZXloemRQ?=
 =?utf-8?B?cUVPUys3NmhmKzRDYnF5SWRUQjVCTzA0RFNMV203d2tWT3FCVlAwTGlmOVQ0?=
 =?utf-8?B?THBYWkkzanJHWjU0L1RrMkYvVCtUOVZWRDhibWk5V1pwSUF5M2tmMXpSdksw?=
 =?utf-8?B?dG5KaWowZlZZTTVTN3A1OEt1aVRFQ2tSS1ZqWjlrcmg3M2VTQkQ2VzlBOElN?=
 =?utf-8?B?S3BSRlYyWng1aFppVmJLa1dPUHB1V1AyMTlPcXRLK1VYL3dxUGJPTVg2eEpF?=
 =?utf-8?B?eFZCY1NwZmRnaW5CRkdqMFJyNnJ0eCsxT1gvMllxWWtXR0F5OVBpZEllTXhX?=
 =?utf-8?B?WVA0YW5taGErY2s1WWRqV2c3dzRGOUNsVmxJY1dMM2NiazdqZmQyL3NqazdY?=
 =?utf-8?B?anN0NUVPNm90VXV2RFJkZlVuR0RLVWU2R3VFQk9RbllsRk1LWnBrSCtiekFw?=
 =?utf-8?B?SDZ2dWh6dVNFSFFjMGY5UFBDR1h2N1N6TllzTExTVTNuOThGdk54eFpnWWhj?=
 =?utf-8?B?QWxTaXVhQ0VQaGR4N0Vwb2ZPUmd1cDJGM1hKL2sxVWVObStQSHNRanVGWjA4?=
 =?utf-8?B?ckJvOW8vc3pRUmhRV1NyODJCdmVSUjJYZm5yM0h4QkpGbjNEdWV3YUphSmk4?=
 =?utf-8?B?cjdtK0ZKejlwMFJieHBOMVBxUWo3STVPckZTV2R2MjU5YUx0OVJSZWpPcy9j?=
 =?utf-8?B?MGgxUnIyekovajM1OUcxT1hGb0l0MEprQUJUMzdnRUlLdkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bCtJZk1hbHAxOVlkNzRQcGlYdGpyRjBMc1dlT3hQQTVLM3hxb0lMandRWlpF?=
 =?utf-8?B?bmUvQXhCRnRGSm5penJIV0g0ZTJHeWxTbEtTN0FNTDFUUnhzb1NsRVJyK0Er?=
 =?utf-8?B?bHFoeVk5aThmeTNwcW5GbHVOMm5YanlWbzdXM0xwTjFNUjBsbHhBTVlIYVRa?=
 =?utf-8?B?aE5HOHdKQWQ3T2NqRUR3VytCTGc2N2tDcWppZndReXVjWkdYNGdBQ3JnQVFt?=
 =?utf-8?B?VHNjb3pxZElGTmtuWXpEN1U5WkdPNmw2L2EySEtNTjMvMGhiOXcwZmVjL0NI?=
 =?utf-8?B?U25iZTFpOVZmWWtIbnVLMkVteE1GaUVHVWo0ejVJbDZJQ2Rya0pUMTYrSHZP?=
 =?utf-8?B?aE4zRGZoVmhyZGpoSUJjbkxqcUpHeU9qUlhJMjc2bSsvSGpGaUdqWVYyeGZI?=
 =?utf-8?B?MWFUYXNyTWFVd2V3MjlSOVk4R2ZOejZlTTJyMEtuUG5YUzdkaDI5YXNEQzNn?=
 =?utf-8?B?VDJ1emxDUnJ1MzFzeVpNa0pmRW4wKzBWVnpPYXFzV2FRN0JCUlhlSWgvc054?=
 =?utf-8?B?N0FjQXhWdjJJald2eTExVTdySWJvSVdRNjBXTGxPZy9NY3dXeGJra3RoYnZl?=
 =?utf-8?B?MjFXU0JCOW1DWnJQOG11MnZNei95Um04UEpINExjRkZRcU9SWmEwTWxVY2NV?=
 =?utf-8?B?T3Y2UjRQUGxnVWRaM1ZYUFRNT24rVUtwenF0V3BtNCtUdTYrQ0p1WWNpcHFt?=
 =?utf-8?B?VjNMdVYyNlkzU0s3R3RJcm9EY0QyZkJBVlJaSnRIMTJ3VEg2QmFVSUpXZmNk?=
 =?utf-8?B?N1VuNWUzRy9sazVGTEZhTDYrUUw4MWRMdnJKUjRSdGlSejE1NUdQV3plUUxk?=
 =?utf-8?B?Z0dZU2M2amZaUDBkTGRBK0ZZL1pMaklMaFpWb1l3WERRWkdwVjVudzRHUFFo?=
 =?utf-8?B?ZVlRVWpzY2JEcmc2NXVqY3F5Z0ZOenh0SWR3R2owMU1OampkTzlVSWlmQVcw?=
 =?utf-8?B?WnY5bXJpVm43T2NvN0VqRzlTQi91aXVuZ1gwV0x0cnVpWXRzcGZxZkpIbnky?=
 =?utf-8?B?MnRHQUhoSDljc2FCNk1PSXhrOUZvOS9aT2Q3dlRWT0VMZ2lCUjl0QUt1VVox?=
 =?utf-8?B?TnJYYTJiRmh0WUM5YlNyWUtlTkkxRHJrQ2hHWDgxOWZ4cWhGK0hQekVucGxv?=
 =?utf-8?B?ZGxYblo4UXFreVJUeGt1d1ZlUHpHbGVuOEJmSWYzVldjTkNYNVMva0Q4K1Vs?=
 =?utf-8?B?WGpjUytNV2RMK2ZSdmkyRVJONkhqbTNBRHhKYThUUVhXVy9ETi9vTW82L1Nt?=
 =?utf-8?B?eUdpLzFyNUlnT0E1UmloSnJzTFhLbDRTUlJVZStQSWF0b2dqeXRtQ0k2bkl5?=
 =?utf-8?B?OEFHR21IbkxFVGxnL2RheHZkazhBYVVSdlVIV0NlY0hLbXJTQVNBN2dqenhK?=
 =?utf-8?B?MTIrMTVkMGxYK1pqME9CYXRrZkFPcXZKRWxwTEUrY2NhS2xWWW04UXQzVFZQ?=
 =?utf-8?B?dzBZaDRmUmROOGpOQ0d1Wi9ESUlBeElYVyt4Njc5MTh6ZnVGeHJYU01qYWxQ?=
 =?utf-8?B?QTU3dkZKQ2FoaHFrN096bnQrWmJOSUJYQlJqVlpkbFAra2t4UWJUcEhHU3pz?=
 =?utf-8?B?cFNudlNmbWljb3QraUNpWnBINnN3TFZhaDNvK0huSXF5Qm9hVjNNUnp6cTNa?=
 =?utf-8?B?dW11SldzUldKWStIdW04UEZUUUVoSHAyUkdJRUVkSHlpQUFYWDlGVjZYc0My?=
 =?utf-8?B?OGR4Y2I0MWl4S1BOYmxnSjhCdXZXSTNxbTV0ZysvUFhLTkpKcURidkZiWm0y?=
 =?utf-8?B?Vk55R040T3ZHa2lqeGhYUXJLVE0vdXhBSHpzek9UVTdXUEVYUXVGVVJIUFNj?=
 =?utf-8?B?WGJvNmVSVklwWmtOajVGWk4wMS9KZGZiWmV2M1ZOYkpMeUQ3a2V2S2RkOGhh?=
 =?utf-8?B?TmRRRTl3cUU5Vlk2WUpDUFVtNzJiREhtakVZS1BMWlFGMGZvemhtZlFWZndU?=
 =?utf-8?B?eVZUdHo1bG9tbDVnS0tSc1p6a1VrNDl6QUxlYStUNEVKUTRZQXdTYnE3Rm50?=
 =?utf-8?B?OFVXK1BWS0tjdlBnMDJjQmZSWGlCVDBMK3BJQ3JBNFpnVWxPT2s1aDRXa1JT?=
 =?utf-8?B?R0tHTFE1dGY3NFBmWW56eFZTWm5DNmN1YlJmK3lSQUdUNzBQNndQUE01SFFi?=
 =?utf-8?Q?k7A4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 635bea95-c241-462d-55dc-08dcd68ebf47
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 20:32:56.2088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmQ8IPn+6O/qnKfKBUCeDSkBuDCap02L86AcG7NnD3KW6vXuhebgh2k8sq3i1ntmOP7JWjKT2e+nRPy78DfhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8137

PkhpIFNoZW4sDQo+DQo+SSBzdXNwZWN0IEkgbGVkIHlvdSBhc3RyYXkuICByZWdtYXAgY29yZSBz
ZWVtcyB1bmxpa2VseSB0byBmZWVkIHVzIGxpdHRsZSBlbmRpYW4NCj5idWZmZXJzIG9uIHdyaXRl
cyAodGhleSBzaG91bGQgYmUgQ1BVIGVuZGlhbiBJIHRoaW5rKSBzbyB0aGVyZSBzaG91bGQgYmUg
bWVtY3B5KCkNCj5mb3IgdGhhdCBub3QgYSBnZXRfdW5hbGlnbmVkX2xlMTYoKQ0KPg0KPj4gKw0K
Pj4gK3N0YXRpYyBpbnQgc21pMjQwX3JlZ21hcF9zcGlfd3JpdGUodm9pZCAqY29udGV4dCwgY29u
c3Qgdm9pZCAqZGF0YSwNCj4+ICsJCQkJICAgc2l6ZV90IGNvdW50KQ0KPj4gK3sNCj4+ICsJdTgg
cmVnX2FkZHI7DQo+PiArCXUxNiByZWdfZGF0YTsNCj4+ICsJdTMyIHJlcXVlc3Q7DQo+PiArCXN0
cnVjdCBzcGlfZGV2aWNlICpzcGkgPSBjb250ZXh0Ow0KPj4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5k
aW9fZGV2ID0gZGV2X2dldF9kcnZkYXRhKCZzcGktPmRldik7DQo+PiArCXN0cnVjdCBzbWkyNDBf
ZGF0YSAqaWlvX3ByaXZfZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+PiArDQo+PiArCWlm
IChjb3VudCA8IDIpDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJcmVnX2FkZHIg
PSAoKHU4ICopZGF0YSlbMF07DQo+PiArCXJlZ19kYXRhID0gZ2V0X3VuYWxpZ25lZF9sZTE2KCYo
KHU4ICopZGF0YSlbMV0pOw0KPg0KPldoeSBpcyB0aGUgcmVnbWFwIGNvcmUgZ2l2aW5nIHVzIGFu
IGxlMTY/DQo+SSBwcm9iYWJseSBzZW50IHlvdSB3cm9uZyB3YXkgd2l0aCB0aGlzIGVhcmxpZXIg
OiggbWVtY3B5IHByb2JhYmx5IHRoZSBjb3JyZWN0DQo+Y2hvaWNlIGhlcmUuDQoNClllcywgeW91
IGFyZSByaWdodC4gV2Ugc2hhbGwgdXNlIG1lbWNweSB0byBrZWVwIHRoZSBiZSBDUFUgZW5kaWFu
LiAgSnVzdCB1c2luZyBtZW1jcHkgbWF5IGJlIG5vdCBlbm91Z2guDQoNClNoYWxsIHdlIGFsc28g
Y2hhbmdlIHJlZ21hcF9jb25maWcudmFsX2Zvcm1hdF9lbmRpYW4gIGZyb20gUkVHTUFQX0VORElB
Tl9MSVRUTEUgdG8gIFJFR01BUF9FTkRJQU5fTkFUSVZFID8NCg0KVGhpcyBpcyB0byBtYWtlIHN1
cmUgdGhhdCByZWdtYXBfd3JpdGUgcGFzc2VzIHRoZSByZWctdmFsdWUgdG8gc21pMjQwX3JlZ21h
cF9zcGlfd3JpdGUgd2l0aG91dCBjaGFuZ2luZyB0aGUgQ1BVIGVuZGlhbi4NCg0K

