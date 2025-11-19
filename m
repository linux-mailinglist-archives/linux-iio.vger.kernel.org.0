Return-Path: <linux-iio+bounces-26310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0495C6D9CC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 72FFE2DEA5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA4E33506B;
	Wed, 19 Nov 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vXaVpr6O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A827F195;
	Wed, 19 Nov 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543398; cv=fail; b=kHBmWyZCi6cN0TCqnIZYj+p+ctDkkT2tAkxfthdAS77Zsv1o8H2OEWbZLXBqiK2IQvEbujdPyXmKih8539NteASSpcvQNVgAtTP9+9xZcag3NJcnBLCgW9WQno/Yoi/3fJHQ/XsegX0CLhBzPmqTNqCQhFeNDsP6AxVThPyg0YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543398; c=relaxed/simple;
	bh=lqnFgqSy5NrUZm7vHBPPYIRnb1Js6zx8fKFnCE034gA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsEpX5KcpnOOotQY1BVTtoHFPIJZC+2IGr2ApK9AXB7AI43KMtMm5smhkEjD7OEr9iobvOYMJe3KPoL/ZR3XvorR2UqaPqJ++hWEwZvmpejWniGyr0VKLROBN5D24RYYN0zYji6lHvuuFegPg8h+578+gaTUt8Aiu3IpSQ8ZOXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vXaVpr6O; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ8r2vx3430224;
	Wed, 19 Nov 2025 04:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iEKl7
	Fz2xwYKeEMuJEl6Y3wuX4lS7tMyw5hBkJzsMhE=; b=vXaVpr6OO1GXfmi1cJJRz
	4jpq6OC01e7np/4b1glLR/9o4I6Po3ZzeINdEe7xqefJbTgsonDKXlhdrtYhFrtT
	S3/7h3z2W+0U7bfcpfHd6Y1IrTlTn4TQtXLDDRr0nkpTvZR3yQkdfxM2udj5qW1B
	PSFWAm2ky161aedOw8+7aQH3HwBMxGNGLqPtcv+XYFBPngt2E4n/6j9pZUzppDID
	ZyZFCwgbqzmsEDY5HYw0SsUkBng7+IuvQj43V+EhDujTOwGe9nDbx+k1ZqfNJaoO
	jJU3i4ipTe/mmQ+lQ6n6RPQBQC8bCUN6uZ3GP/LM6fXOdd85D5/XBhg7RqDTe7PY
	Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ahas802rv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 04:09:26 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTOX/jfC+CVWumWHH0Yi57yNtKXmDMClzosk/pztAY/bwqY9nJHcuFzuQLfJXUW697s63eNKSKzQctzw61RCzXIGHkC1Vul2C6TsFwADaEhOGlkhYC0aFJKWACErgFDpQ26hQu6a5MmB7lweqB1KHDcz2ysz4o96Q0UlG+MN43LkL1ytDEuMYnhYSMwU0jvPoMeQ73j7gDce3SEbkJliHw8pJ5f6d2F+K7lL/AQXPww1jSdsiLjEklpGyWZ6WztKMnt7BkRnA+y9r+nz/+vcSyheJ6855M5gHsXvaqLQo97VjKczgIOKPuMZfLIscEt9Vtr82RdxFJG+WoyEOrFmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEKl7Fz2xwYKeEMuJEl6Y3wuX4lS7tMyw5hBkJzsMhE=;
 b=Zq+Cq+SEDVlbPfj6R9A4SAtDKdXBmztsc+e3cUvoIGEs0SeMWgkkvvgMLxIegmfJ1SlVTMpQWSinuFM1DIe1jUZ3zKJjEc4W82z/EZIoq1VNtX5W4jXGURpgMNN9V0O+MxaJ0t1MXSzNUfroNd2aB0xOhwx8eO6w9F3i1kVUAn+03Gp6tOUFPFCVTfmXP1GHMlocqOpk82IcsSbUB7/kKxH4IA97LIEgsZcjWwztoaom1eiPO+dwdhHbKaFo+14K0T4yKFTAC75uFraoAL55A719V1TxgIvgqLZKBups+WpMyNZwpcS2Sw31TBpM7xbYYMh78/rE6nB6fjY8I55krQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by MW4PR03MB6620.namprd03.prod.outlook.com (2603:10b6:303:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:09:23 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:09:23 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: RE: [PATCH v3 3/3] Documentation: ABI: adl8113: add documentation
Thread-Topic: [PATCH v3 3/3] Documentation: ABI: adl8113: add documentation
Thread-Index: AQHcVV4WVkBUvZsR0k6Md3ljcuWUzbT1dqeAgAREKTA=
Date: Wed, 19 Nov 2025 09:09:23 +0000
Message-ID:
 <CY4PR03MB3399D2BCCF18EA13DCA768D49BD7A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
	<20251114115725.5660-4-antoniu.miclaus@analog.com>
 <20251116155013.2b55af25@jic23-huawei>
In-Reply-To: <20251116155013.2b55af25@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|MW4PR03MB6620:EE_
x-ms-office365-filtering-correlation-id: 6197e09a-946d-4e6c-96c3-08de274b54bd
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kKVUQPGLnqs9yQV45raxskEmLHKH4P17Z0kUHQ9DrYWkzMMmIKV4SNXVsl91?=
 =?us-ascii?Q?K6kTOxJf3GCa61n5wvorMI9OH7gvQXjdweM7cp4n5ePQjpC9xbgLWA4VWuu2?=
 =?us-ascii?Q?WMxH5FMEzUwvRKOzESoZY/Zj0eahdk5UZhL5HfPN0l9A0HElG87F1z/xBLMs?=
 =?us-ascii?Q?NnX74lkU0qVRxkv2qQGe3qyDZtQGr8At5S7B1YGnYp0ej3NrE/3R1/oy+Esp?=
 =?us-ascii?Q?jvd3sqPt32GppblUGH/w0g5B1WuwQTTpsDENLaBd6fNuKNEaErYCc4GXK+Hl?=
 =?us-ascii?Q?8mGeeIyz6PprX9O6kaDIy8ggit+gpP7E78Pv3CmspoUld0QKdO4k85FAaXgp?=
 =?us-ascii?Q?SRnZVE0IxJklOnuMk0T5lfEs6lqVZRmxjAXnF3eTUWLa4z/og/Uq1Js1pPka?=
 =?us-ascii?Q?orjA2gPW5gCoIikOBiG/C4d52MhWSC7HESYJkasP4pcR1hDbGUuuy0e+vC0D?=
 =?us-ascii?Q?MoVyHYcKuuDdNYDVUfpaY4rAWpcEDfMD/sMs39fZS5URD7MPIdbWaBbxazof?=
 =?us-ascii?Q?ltdNQ3tyeP2ZobrZHaBUSXXGfnIHOzF0azdUkOLIYwj1zx7jPzegLW9goOMw?=
 =?us-ascii?Q?BC5Jn7O3WEjPd98ROlPo9AP5uulruWJ/zL+e/XBrK1IvBNuuKeBcXYWGRq73?=
 =?us-ascii?Q?yEZUlwruY0+AESWAMSPOeMu1s98bsAboV6SCI3PihVwifLWOV9aKUyJh6BT8?=
 =?us-ascii?Q?uFszrlmOtLSrSjzLmxhmfmEXapK6D+Hv0YeOZZLqp5WbBZ8nz0UXoFHefAOo?=
 =?us-ascii?Q?iKjyczE4cPu+njzSDTiWisXX6W+nhMKPu5PHaZZtmMB7UEAky08FDUV2EaYs?=
 =?us-ascii?Q?dGJqUgBygBobbllZXKBc5KvlkypULtERBGkbUDu5mP+lPVjll9rRWUdDVe+o?=
 =?us-ascii?Q?7Q8iFUjyx5eARYDVJXiIjD+VXzYh6pCBN1Wk/1cIH4OqAF1fq73TYSgoR+7k?=
 =?us-ascii?Q?33d0w4RvawhAlfAGagE0ZfwCLFKtVYW0yRu+bxK5D4WGzgEffEYY4Oab1OPO?=
 =?us-ascii?Q?8+KwV2BrZY6vr5BFWNln5EAuUU126Ezduog8Ctze1x40N7r/uzp0Q1gtxEQ2?=
 =?us-ascii?Q?ATFxY9xZOZoXvhxDbIY7NA0+wPOecsyEp7k77yB6oNN4QUA3wKFRKzQlZ6Yd?=
 =?us-ascii?Q?d5bnANQ7YFQr7YDTzDeiwq5xye5u2vHODRbiWw6fEhhPOC3me70ZB7l7VDOJ?=
 =?us-ascii?Q?z5CeeluvyQ3dSTRym3Ucyv3BzU32O/BrIwDP8X+gBu+1rUv+P8DJZdTbA6IO?=
 =?us-ascii?Q?Z9EC8wQedhSedhh1nvbfFHnGhhzWXe5HnPlGqXQaDfD5ALzw4FkeuUAd9A44?=
 =?us-ascii?Q?lY2ZYTrQHyVy8PPwQ7rvQMlVWnKfE2apURl9i1YUmf+oGTuluV/wEuV/TIf5?=
 =?us-ascii?Q?CryX/ON+R1Ty7H+NA6n6/dSenhWim35uR4Jv/zbCkb7V6BwIC6c4XB8p8/d1?=
 =?us-ascii?Q?QNbdHSRgXrZ6moa8vr7GFiFA34BZ5xrDXmUGItwx9N6S8IEQKmZj/P/JbfXI?=
 =?us-ascii?Q?6dqej22CHvtshmuvVsLfohy8UzDrWXo4lB4f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wcoyGni+4pANkIVZ11L1zuDAec6GYs3XnvfOsxvKUzoSkvOPepMFbcIQtZUD?=
 =?us-ascii?Q?yBpVm3bOFEc4+rq8atfY6egjjFhesw7L9pDz5ejG/PL8MNcgSiPvD8Ri/jC9?=
 =?us-ascii?Q?BI1JmLLwsfnJlLeW4Ze4fSsR9Hljc34CQiW97FTMAV1t/81Qn+trZGVbpoaz?=
 =?us-ascii?Q?UdJ+DKw7wUzKtdCJoimAiHDbF8Oqj6qsBF+EEaD8ABJRNj3A3rtlaWnzW7gP?=
 =?us-ascii?Q?gKom3+cZ9C6HdwgWnNaP+FhydDvQ8ygunEURZ1+mPPNeCiFPlwjhrSKYig57?=
 =?us-ascii?Q?A0ibviDMh3FgPbqEZlaRDYyEUYz4eXcr5TZ+hvPQ5PqcU+xQAkAUZRHEcYdu?=
 =?us-ascii?Q?Bb7mXI1fl85M62YQH4kXI1MeVNR+UOiIeDD5VuDBoIwZdanBrApzn1Wuv8Ft?=
 =?us-ascii?Q?RREnfxlZmxT6cewsnu6dlCaYlgW/1Um9FgftkARzaLdXU7UDTzKELVcfFY5i?=
 =?us-ascii?Q?x0qGwant1RzLFOImXDXltYXbWFb4zCpkSJjYi6NiLjzW6/w5vQbzXhK+sHSu?=
 =?us-ascii?Q?U/ekQy7bqtu8ZSGZbIGrGza1HLrQa0+KY7IWN13muraiA26zOMAOBCPYSKen?=
 =?us-ascii?Q?sQwsgQh6v3b5hNoyCtclqO9n7HPF/Hcd/2UiBT5kpyQ9vUDmJbzBSwp4Q6Kg?=
 =?us-ascii?Q?jX5BLD9LkkZOz7XOavVxO4Mhof5Za2GGcwNIXPwBvWl8rN5RKYfXOq1qQLca?=
 =?us-ascii?Q?KSSsYwiZAxnwv5JFRsu/UZbW74WvYPotYNzETxlS+yHWPDyATZPA+vzeaGQj?=
 =?us-ascii?Q?054462ufUp6JERolvRA7MBrQKSHpUR63SFusVr37WIIRRhl8bIueuLSi3FwL?=
 =?us-ascii?Q?nxg1yRzkvD4NrT1b/zVqOVysunwn8otqNjGEkM1jJvePY+362KV3z230t80M?=
 =?us-ascii?Q?YsS4JjVj7ONyo076FJBgXIwj80WChOXxl6VM8/6p05IVEWcXCREyoPdyN0Gr?=
 =?us-ascii?Q?CfUBlCYa63h6no9BELe380Tq+30omKUB3CRSgC033XSConOkia1w5UhVFJ4E?=
 =?us-ascii?Q?FYH9+JAnsZWsH7JRwYSPZSyC36RTAk2Q/GQV0u5RlJf5Joyw4TZQ51VbBChE?=
 =?us-ascii?Q?bA0wrDrgemmYiEXfUx9lIi/Gl9NLacyQIiozRvHySXCPa2IfwLUo5PKnSjWH?=
 =?us-ascii?Q?/7Uug5Ym383IuWvSirRgG9ng8SFnQpzA14MEnICW06jC8CphnBRZawxnqlpC?=
 =?us-ascii?Q?dh9aCsq0MmpODpMRnFREoabqQxqG5FuBJrby3BxRpo2OV+4i4qqEr4K9hZTG?=
 =?us-ascii?Q?WZeOFHTiso5r1YE1ZU5ZlzA8kCwMLlCQdpGUVRMqtc3H/FJt58tZbUMbOVTX?=
 =?us-ascii?Q?XS6J5BP6aIhgnUK51t0J9ZRVC1YZjz7zYAPi1GrICkPM8T5Jnil6jTUc6vPn?=
 =?us-ascii?Q?5jkYBU79mpzcaeGSesi3ocOyLq+zTx+0mlJ4Im+fd08697+7lJt17lWNc7Zh?=
 =?us-ascii?Q?/fA4ImxaMHB6wBfvKYmNt82spslBWkE64Ko4PvXWCzyHnO4k9INPCN16/Ihe?=
 =?us-ascii?Q?MV+shr9K3YQXe1QKgs+821TMS5kn3Bhzg+V9bJSQYyqA+ETdhc7CmzzK6fcH?=
 =?us-ascii?Q?mbcrHruzgKBpiz4EXG7Sfpp7UtWVRKDkV6oCsB/ppMcrl5I2Cl7+hGR2E8y1?=
 =?us-ascii?Q?dA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6197e09a-946d-4e6c-96c3-08de274b54bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 09:09:23.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7J3l9DJ1jy2p28x2rNn0k7fLJ2TusmcfY3BwS6DyTCZWDyxpkpL44afWhb+BrtQ1jiypzJvRnEkyguo4DTgdikuptjjA2Tg1lAl6AHmHOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6620
X-Proofpoint-ORIG-GUID: 6wzsUAOiSWJ-C1DD_q4huJLDfOqvqx5L
X-Authority-Analysis: v=2.4 cv=BvGQAIX5 c=1 sm=1 tr=0 ts=691d8946 cx=c_pps
 a=fOo0+MOGfjr111H4QC4BGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=m5NMCUCmn9cJqTxM75wA:9 a=CjuIK1q_8ugA:10 a=VRc06iDTFAgA:10
 a=8e4LAbc-YucA:10
X-Proofpoint-GUID: 6wzsUAOiSWJ-C1DD_q4huJLDfOqvqx5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MSBTYWx0ZWRfX5mlGn4mPa3Sg
 XGk4ugWE2RE+8MM5cv6x9Q84RhGcP1VTfYUXDOqtcOwpk6bJPzDRKn+Yf3KMWYbKlKaXh2p3GK6
 r0DII1nnv6L1jjGCzyaZxc+HqmZyajcvPqBatYk7AU0U/c9ahvbGSC513Rh9uy0rgPIsF0xD/xT
 n2RRUrwg9s0bP0KL5mQyrNrzGIML79Z0UJLd9WXdZUbYYjWy++5Ie3V8SMCEHTrMF7IOv3dvYT4
 3h/SHZO2TjnjIxJQt4El0cOV74rEFCAt2/4N41Pq0PEBKBQOEEmXhFJM7W4/LP1jdVgHKS54NCT
 uo8eQkwr6mUiNyW1ZWWvxbQS/zPwuJgYnRRa609lAwPhnKWU7qUuwIDcw70he6EK7clTjAOimOg
 20g3M47ZUroNV9ugmCgOgBfLjYIrbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190071

=20
> On Fri, 14 Nov 2025 11:57:25 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add ABI documentation for the ADL8113 Low Noise Amplifier,
> > covering the 4 pin-selectable operating modes.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> +CC all the IIO subsystem reviewers as I'm not sure how to handle
> what this device does, and would like some more opinions.
>=20
> Anyone who has expertise or design experience with this sort
> of amplifier with external bypass path: how are these actually used?
>=20
> The development board seems to just be suited to measurement of
> device characteristics, not representative of a design using it.
>=20
> > ---
> >
> > Changes in v3:
> > - Replace "mode" attribute documentation with "signal_path" attribute
> > - Update descriptions to reflect separation of gain control (hardwarega=
in)
> and path control (signal_path)
> > - Add explanation of automatic bypass mode switching when selecting
> external paths
> > - Update attribute names from mode/mode_available to
> signal_path/signal_path_available
> > - Clarify that external paths enable connection of external components =
for
> filtering or amplification
> > ---
> >  .../testing/sysfs-bus-iio-amplifiers-adl8113  | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-
> adl8113
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> > new file mode 100644
> > index 000000000000..31fb1e6e80fc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> > @@ -0,0 +1,30 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/signal_path
> > +Date:		January 2025
> > +KernelVersion:	6.14
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute controls the signal routing path for the ADL8113
> > +		Low Noise Amplifier. The supported signal paths are:
> > +
> > +		* internal - Signal passes through internal path. Can be used
> with
> > +		  either amplifier mode (14dB gain) or bypass mode (0dB
> gain).
> > +
> > +		* external_a - Signal routes from RFIN to OUT_A and from
> IN_A to RFOUT
> > +		  (VA=3D0, VB=3D1). External components can be connected for
> filtering or
> > +		  additional amplification. Automatically switches to bypass
> mode (0dB).
> > +
> > +		* external_b - Signal routes from RFIN to OUT_B and from
> IN_B to RFOUT
> > +		  (VA=3D1, VB=3D0). External components can be connected for
> filtering or
> > +		  additional amplification. Automatically switches to bypass
> mode (0dB).
>=20
> I'm still not sure how to handle these external paths.  The one thing the=
y won't
> be
> is truly zero gain (because that would be pointless given the internal by=
pass
> path does that).
>=20
> So how are these used in practice?
>=20
> Do we need to figure out how to describe the real characteristics of thos=
e
> paths?
>=20
> All I could find is a brief reference in
> https://www.analog.com/en/resources/app-notes/an-2622.html
> to high dynamic range receiver applications. So with that as only breadcr=
umb
> my
> guess would be that they almost always have additional applifiers on thos=
e
> paths
> and we should figure out how to describe the aggregate device.

I managed to reach the applications engineer responsible of this part and i=
ndeed
the purpose of the external routing is to connect other LNAs or filters wit=
h different
gains.

That being said, I think David's second suggestion might be a way to go:

" Have the devicetree specify the gain of the two external bypass amplifier=
s
   so that we can use the hardwaregain attribute to select between the 4 mu=
x
   positions without needing a custom attribute. This works as long as none
   of the amplifiers have the same gain."

Looking forward to your feedback so I can start implementing it in v4.

Thanks
>=20
> A stop gap might be to merge the driver without this support till we figu=
re out
> how to do it.
>=20
> Jonathan
>=20
>=20
> > +
> > +		Note: Selecting an external path automatically sets the
> hardware gain
> > +		to 0dB (bypass mode) since external paths require bypass
> operation.
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/signal_path_available
> > +Date:		January 2025
> > +KernelVersion:	6.14
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Reading this attribute returns a space-separated list of all
> > +		available signal paths for the ADL8113 device. The available
> paths
> > +		may depend on the current gain mode (hardwaregain setting).


