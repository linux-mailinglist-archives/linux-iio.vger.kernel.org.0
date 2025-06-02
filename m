Return-Path: <linux-iio+bounces-20150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F93ACB511
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2E57B30BD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EE227E9E;
	Mon,  2 Jun 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5GQXtx3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70C227EA4;
	Mon,  2 Jun 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875774; cv=fail; b=C+qb/kX9GZEH2F4yMw9bqrA9DX40zXCPo+6SiKzwxX4CaHBI+Z4EawfZKppeAcKvbc0ABsbUdk5HnawldiUdN83vM37bMzRl6Dh2pnRdFWYQF7vIVOYS0lkk7BWLZzYBDcGjRWWut7stFV8g3/wV8+yMLF/42i7PcG6qHbr7qFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875774; c=relaxed/simple;
	bh=2h5GBKE5HnUZQxhtkMK+0hCYBq+yewh0IoXkg3pm52g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryzKS9FjkApoXwDvw5FxwL10lQTuZqKMzuTkyER0P74ev2cQHAM+itn0q/D13J9BXIm+66z8EwwwPB/eyf4BW2lDvhXOZ8ofyX1i16wzHvzpK5wVx8GfriyLXL8uBAE1HRZ/Jkej0wOMyxt7ntDckopxi+GBp7Gua3d1gqhvVbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5GQXtx3B; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/wTQhn+2iEJ2MwaciUyw0IHiVlQdjd/dLTMeoRJYcuDX6wu8B5bnpGC7qs+aj/wtEQs7rhtu4HMgF7EFnPPGn1k/girkT3y+GJEByws66eSvqPH8soySao67Eo0r2JG+zolr3MYqfBjddxNitQXlNmVkg7NDN4OyRC70GT/8529mBenI2IAC86OHXR4l5s4hJPQbyf4IpJtWf005KuxLSqyO4HpOKztF9MHWDwio0r6wdKGcDPK+f3dR4fDhugA4KP0cKfEtpBkCBonsi50wfwJQsMD3g2GpB9ufk5vt8ojMNghywweZrV3N2NfSqxNuVvD2jaSiSqJLH0a0bYGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h5GBKE5HnUZQxhtkMK+0hCYBq+yewh0IoXkg3pm52g=;
 b=FwnYFtVtIRU13oGh+2wo8WYVGdglgqPVYUK/BKPggQWfF2gL4KDniVBRIn8p77AxmIfdcOQTz/RgoRkLd+vDW2UJcIQkhAnhJQtJzCTvyZXqs3UnsWbBoRiPpz65BjXUUi8JC3A6F8R95IGbnLfF8yZhLhpxm9MxJ1DhuuVb/0L6q8sU7+exC5Oilt/rpzD9maY46Fb3mN8Q/ofDQZQYYON5ESDIspWV+onLV7axV+10slI4V8O3XHB06Wg3HG/jmE8gLbHpFmDGQDpofuTOWK3odY5KvcKGNb4qh/17nvPuc5oN4SKEYEh9K5zDSpHbhSUhrqi/3itmYAGArNYUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h5GBKE5HnUZQxhtkMK+0hCYBq+yewh0IoXkg3pm52g=;
 b=5GQXtx3BazslXRN9NfZEi00QxSlrJZsuQgHbM8YXGMX4n++0wKQF7gJsfDM78eTIpbACpz1M7fMJ22AHPy2nMcFel0B7v1M93M/1oFigpi2++mZ9KRa/9VXWa/Y4Mx3hgKg64WcMGsRT3yjwa1YnIXo3RW1XblaKjGE8Nlc5BLTx81QTN73XAcW1oHcuHkvL+OWtnZAbo/PBRk3VZ1uq5rhsHXaqmW5PDZyakYg99vk+OdM5Hhsonjjn6poPPnGDveAJT+UBxr87lAfOiGCRFEtWoyt7Mp8rq14IAt9+bUE9lM/rORQ0bmXGS5WQ5k1yWQu/6itQb/h0+TTp1wRFuw==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 14:49:29 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%3]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 14:49:29 +0000
From: <Victor.Duicu@microchip.com>
To: <Jonathan.Cameron@huawei.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Marius.Cristea@microchip.com>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for MCP998X
Thread-Topic: [PATCH v2 2/2] iio: temperature: add support for MCP998X
Thread-Index: AQHb0H09KZUxVIY490G9XQS9PBcSM7PrZdyAgASUPgA=
Date: Mon, 2 Jun 2025 14:49:29 +0000
Message-ID: <e5756eaf53fb5a702274cc707fcdf6196773fc65.camel@microchip.com>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
		<20250529093628.15042-3-victor.duicu@microchip.com>
	 <20250530175351.000039cb@huawei.com>
In-Reply-To: <20250530175351.000039cb@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|PH8PR11MB6999:EE_
x-ms-office365-filtering-correlation-id: 95e5b5b4-7fdf-4b60-54cb-08dda1e4ad77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlFmZWt6MkhtRUx2ODNiOERQWW4yeDBsWkxNSm1DMnBJM2dnUHZIYUJzSisv?=
 =?utf-8?B?cmlZeHpSNktHUHBiTnJNNTdTdkNCVlUzdmpHaXord2xOR1hwd3VhU3JsZmtn?=
 =?utf-8?B?NDQvbWJjVVZWVFN2bGU2RU02WHhnVWZsM1IzZnlHak1YazMwS1N0dTVYRlVq?=
 =?utf-8?B?dUpCd1g4OGxrWTJ0WmE2M1Q3UktXVHBhOXhUczVXK084ZTV4R2tLelRwWHh4?=
 =?utf-8?B?Vm50ei9GZW5McFRlSG1uSnZaOUhvNXBuTVI0aEtBUjY4QTlEWDdpV3NKU2U2?=
 =?utf-8?B?WURIcmZ6TFd0WEx5c3hmVW1RNDhUS0daT29ZS0pJTk1HUStXMmcvSGR4UGZr?=
 =?utf-8?B?aWFucmovMmo0dXd3T09OQkVWaTdqTFlOcFloUUdtVFRoU3paMkF0UVFaSjh5?=
 =?utf-8?B?bEdmTnlabkorQndoS1p3eWFoTzhKeTVJUVFOWTlwaHFVYjgvL3o0U2NCTjZh?=
 =?utf-8?B?YU5saDZ5bXZJNHpzQ1NuOGRjZHJpZlNMQTNpVzArOWlkdHJBMDUvZzJpOXBj?=
 =?utf-8?B?czVPQ0dYUGowQWV0d21SSVlFeTZJdmFXUWNoNDltZHlmV2dYek5aeVN2Z01U?=
 =?utf-8?B?ZER1Q3kvQzlCWHhZVFRmbUI2bER6SDhmZ2lFKzV0SmpkNnI1UkxJcDhYYkNM?=
 =?utf-8?B?TEpYMXFsUVZKTlNDU0N0N1B0YVlBdFQ4bWl4ZXRRVWtYZEJDQ25yWGVmbTFO?=
 =?utf-8?B?S1E1SzFDUTY3YTNSNS9yTndHdHFVWlJZUTJVbmhBYjVMZDVpdDNrSXBGa2FW?=
 =?utf-8?B?cmk2cllLa3hwSDRucmtvNGJoNWdEcml3NVZjeDNaT0FQSkdURzhHZTlWWW9Q?=
 =?utf-8?B?L1FkOTloaUJ0Z3R6VmQyZ3JlbmhTZDVvS2p3TVpGc2xiYVpCQ3JRM215U2Mr?=
 =?utf-8?B?YnFoRm1ZeDR1cFZzLzRvSnRWNjFNeG5UUzgzRll5U0k3bXNQbUdZaUxJS2J3?=
 =?utf-8?B?RG1WeDZKbnBlRVhkUm5nS1VVU0YvSjZnUjNDajAyZFkzTXAvQTU0Y0x0TXU2?=
 =?utf-8?B?ZUZwZ09hT3FZUW1LZ2hERkIrOUhnTHVsMURsNHE5NFN2WC9xZ1Y3UGFzVnRR?=
 =?utf-8?B?Y05CNXQ0NUlUQ0ordWxqaXg4b21EY2RFdXVYR3JrNStVSUdCeUc2US9aY3dX?=
 =?utf-8?B?R216MUlyUXN5WnhIa1U1UEJnRnBpbkk4RUxQMk9Dbi9IdjljTXFVVHBlNk5j?=
 =?utf-8?B?cy9idHpGMGVUTWRZQW9hRDc1OEVib1JxcTZQUXdTZjdjcGdiK29hR201NlQ5?=
 =?utf-8?B?Y0VhNStVejFvMVdxMzFyZXMxZ1liajR5ZGFuMFpkNDRCbjVoZHM5eW9xZ2Zh?=
 =?utf-8?B?RnVZQWJySFlEODVhZFpDbTFSSlBxOSsweHdEa0o4cm5ibjdpOUgreHBpK0F1?=
 =?utf-8?B?ZDF5SS9UQU51SEpIVWNHcjc0bzZ3TW5WN0NiZHpLVmlXelY1czBsT3dhblVM?=
 =?utf-8?B?cVdaSjRuZFdMaVVxOUtGZG1PSEdSUS9ST295WFpQNXFDUlJ5ZFI3ajJnMENX?=
 =?utf-8?B?a29QU1JCakRZUG03d3lwQzd1ckprMkFwMWhjY0xSdlBNZTNXREdvTFRZbkhq?=
 =?utf-8?B?V3lSRWNwQmtHZ0tvMnFWVk5Pc2NMTUtGNkM1d0p1QWkzUUZPekFxS2dxZVU0?=
 =?utf-8?B?elBWakNseWd0Z0UrQ2JzaGF3L1lwTlkrNHBGM1E3alZ2TVJxVm00WXFoRG1P?=
 =?utf-8?B?cktSVTdmV0hvWFlFRkhFSHF2TitsUjBZTkNRQlpocmpxaDVrQ1MyK0VlaTFk?=
 =?utf-8?B?dm1lbmM3eUtWOWhCdDg2SFlSZWpLY3JvdmJRV1ZPTzV4SDB4bnhpNkdOMGdt?=
 =?utf-8?B?WkFWZzJCQm1WRURpL0NVelNrRlF1aHNuL254Tmp5VkJYN3VlYnp4VUlHb1lY?=
 =?utf-8?B?WTJYTW9lOFRtVjlnOFRLcXhaUzUvWUN1NDFNbmNTNVJRc09QMEZkZ0JKaUx3?=
 =?utf-8?B?MlY2cklnVVpFQnJubEUyQ2x4QmtwWTNoNWh1NGR6eC91cFNaTG9jK3NHZXho?=
 =?utf-8?Q?cHV9Xk98hZ2yMsIw/5g3kGdqCYPR5g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVlGeWgrbEFLSlNjZTJhTVEvVXZiUURxa0duNmN2MGpybGh1R1U5UHdib1BR?=
 =?utf-8?B?dGowZGU5cmJPMFdJMWV1ckxMT1R1SFp6dnVwaHBDQ1ZzMmozSUZtL1k1SGVB?=
 =?utf-8?B?K2NRUVh2RXk5Rk9aY2N4RWo2MnlxU2J2RkhVUnlkSEVNNG9TTlNEdk9nemJX?=
 =?utf-8?B?aXYwd3FqTUdtS1cwVWJOOFJYODAzNUpzNmwxYzMyd3Z2QzkzSEhjYk0vYk1U?=
 =?utf-8?B?Q20vcVlwKzg4aThwK1VPQnZnU29yTmIvbWdPdkNtTlcyckp5dDAyaGovSitP?=
 =?utf-8?B?Y1lUd2RUMmVrUlRjMHFKMS9HaFRWdStxdHcyNTJJanFQdG1Cc3pvNXpLZlhv?=
 =?utf-8?B?dVBmNi9ISTduWDdoVDloUnl0L0c4TTBvZHh0cWROaHpzMDZUTmtKdDY2OTNP?=
 =?utf-8?B?a0xKZHpZdzNqME1nNENKLzA3aEpiQVFMd3BMaEJIUHAzSHpNUExSNytuelI1?=
 =?utf-8?B?eDdtaGlQZW9NL2xSRHdTSURNNm1TU0pRNXRLdWljNFEwelZjcWFORENJRHFu?=
 =?utf-8?B?MGNibEpBYzEwR0l6eE1yaFBxZU5JVmVFeVVjaXJ6aTFDbmF2aDlxV2xHaWhQ?=
 =?utf-8?B?bVBiZ0h2Y05uUWR0amk4bmdaRFplbDJxZXExT2hnaWk5aHZ4K1hzOEw4enly?=
 =?utf-8?B?NzlXNHd3WnFUTVpRanpkNFFKZ0dUZXVkc1ZpTUVucmI0cTJRVEg2SEdua2xm?=
 =?utf-8?B?S2tLdFVkZmdJT1ZYbVNPVmlNdlBQZjNreW9ESitJemMxUVNOMVFjZURhbmxN?=
 =?utf-8?B?ZHgvbmtwMkR2OWozR2pCWUIzbHRKVHZkb0xYcnZxTGdVTGVLdWtzR0w5eFlR?=
 =?utf-8?B?VGp4SHM2dnFQV0hLMmozMWhBTEVSdlZjNFNOeG1wNHEwRzFLRGtwUFRWVmVH?=
 =?utf-8?B?NEZRUHI0eHB5MnlBVUMwQWNPVVd3RUJIaStXSC9kWlpVNklmdVFFdjFkTUFV?=
 =?utf-8?B?R0ZnL29LMjFOTkVGTmsyWU9vZjE4a0NMdHEyeU9KTkdrS0plZmM1cVo2UUpw?=
 =?utf-8?B?MG9PZXJQbGFIa0NxSGJrSW55YWVPcGZOZjRYMVZscXpRRm1sazdwaGROT0J1?=
 =?utf-8?B?UkM4c1MrV3E0U2E4VGltdFY5SHhzR3EwaFdSWVhFUzE2MC9lcCs3R0hoc3Rk?=
 =?utf-8?B?bmJVSFAyK2VMRS9NLzZiUGN2Sy8xS3NmRTE2dHlPV3dzMi9VOHdGdDZzNG9l?=
 =?utf-8?B?REtnbERPc05pUEcwaXBEK1h0MXhDWlc3dkRiREJ3ODlEL2pETjkwR3BraDV6?=
 =?utf-8?B?a0kvejVMb29rT3BmU1VRYzZOOHNPeUNlQXQwaXoxU2h6Z0NhR3MvUTJ5NE9G?=
 =?utf-8?B?cnRFVjh1UUdjT2J0b0VVdWRBcWhGdzFYb2swNEsyMVFtL2g5SEdobDRydlJI?=
 =?utf-8?B?dm1KbmNTNk5abFNNUXVJQVhWOTI0dzFtL3RteENPTVA5QnRiZEg5SnNVK2dw?=
 =?utf-8?B?dFJZSTdhaGh4UUYyK2tSSXFwbGhydXpYdnVieHQvVkFrU1FSYitidktnRTJH?=
 =?utf-8?B?Sk9SL2E0VjdHMHZEaHd3cnUzSVZ0ZmFIZkFHdWN0d3hZanZVNTg3SnlZYy9q?=
 =?utf-8?B?UUFKVUdBSUpkYUhrMkRDaThZSUZyUjJSeDRhb2J4OVF2dU1HaVpncks0SHpL?=
 =?utf-8?B?NDU1Sk1WQ1FSd1ZkWDVhNGQydEsrUjRjQ0Fzd0lLQ2d4YlBBL01hanJWRXhI?=
 =?utf-8?B?T2dMbW9VdDRlVXBZUVRIV2tEdHdPWmJtWkdyMlBiTDAwNmk1U3FCTGVMNVFs?=
 =?utf-8?B?Q3BONE4xeTg4ZHB6bWJycjdlNUY3UmpKaC82amFIUU1IMmZpL2lTRE1GSHpM?=
 =?utf-8?B?djJkdnBGalZnWWhISHQvaTRLWXVyVVZseDJRWW40UUxvam1WN1ZWMmtNWXR1?=
 =?utf-8?B?Ty9OSFF2NS85czdvOXJMZncyejFMTHpEMUloZkJMTzg1a0JhbTBrdkJYRk9R?=
 =?utf-8?B?YXFpaUIvdU5HQ1V5K3JLaHpqWUtaMU1VV0tTUkI1OVpFRUVOdXBVTVNIT2wx?=
 =?utf-8?B?UkY0NmlNVmZZaGJBVnZLVXhEYUNZUFF5S09nb3JER1BIaEhZMVVQaVFiU0or?=
 =?utf-8?B?RlFEVGlsWU5JSWY5NEhDZFo0VU02STk3Y014QkczeEt3N21ETXpQY05KVkxB?=
 =?utf-8?B?RndwUVM5UGpVZDNWQVJVSnE0akVrcmUvamZpVXFneDNzWmxrU3lqdHhGbWdK?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12EF785E6E401341BF7DD2BBC36F5C07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e5b5b4-7fdf-4b60-54cb-08dda1e4ad77
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 14:49:29.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEtg/5YYiK/DigbVOmXW0t7qf4lJKPzBMkVV5orDSD79VroFlHSQIpFr2amOF/+HJbfjgsUg6YBVEDWZ9WfKR3/C3fKzzWDzoJUHvhazYWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999

T24gRnJpLCAyMDI1LTA1LTMwIGF0IDE3OjUzICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwg
MjkgTWF5IDIwMjUgMTI6MzY6MjggKzAzMDANCj4gdmljdG9yLmR1aWN1QG1pY3JvY2hpcC5jb23C
oHdyb3RlOg0KPiANCj4gPiBGcm9tOiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5kdWljdUBtaWNyb2No
aXAuY29tPg0KPiA+IA0KPiA+IFRoaXMgaXMgdGhlIGRyaXZlciBmb3IgTWljcm9jaGlwIE1DUDk5
OFgvMzMgYW5kIE1DUDk5OFhELzMzRA0KPiA+IE11bHRpY2hhbm5lbCBBdXRvbW90aXZlIFRlbXBl
cmF0dXJlIE1vbml0b3IgRmFtaWx5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpY3RvciBE
dWljdSA8dmljdG9yLmR1aWN1QG1pY3JvY2hpcC5jb20+DQo+IEhpIFZpY3RvciwNCj4gDQpIaSBK
b25hdGhhbiwNCg0KLi4uDQoNCj4gDQo+ID4gKw0KPiA+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlWC9pbl9iZXRhMQ0K
PiA+ICtLZXJuZWxWZXJzaW9uOsKgwqDCoMKgwqDCoCA2LjE3DQo+ID4gK0NvbnRhY3Q6wqDCoMKg
wqAgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+ICtEZXNjcmlwdGlvbjoNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRoaXMgYXR0cmlidXRlIGNvbnRyb2xzIHRoZSB2YWx1ZSBv
ZiBiZXRhIGNvcnJlY3Rpb24NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBjaGFu
bmVsIDEuDQo+IA0KPiBJcyB0aGlzIHNvbWV0aGluZyB0aGF0IHdlJ2Qgbm9ybWFsbHkgZXhwZWN0
IHRvIG1hbnVhbGx5IHVwZGF0ZT8gV2hhdA0KPiBpcw0KPiBpdCBhIGNoYXJhY3RlcmlzdGljIG9m
P8KgIElmIGl0IGlzIGV4cGVjdGVkIHRvIHRoZSBiZSByZWxhdGVkIHRvIHRoZQ0KPiBkaW9kZXMg
YXR0YWNoZWQsIHRoYXQncyBhIHByb2JsZW0gZm9yIGZpcm13YXJlL2R0LCBub3Qgc3lzZnMNCj4g
aW50ZXJmYWNlcy4NCj4gDQoNCkJldGEgaXMgYSBjaGFyYWN0ZXJpc3RpYyBvZiB0aGUgZGlvZGUv
dHJhbnNpc3RvciBwbGFjZWQgb24gdGhlIHNldHVwLg0KRGlmZmVyZW50IGRpb2RlcyByZXF1aXJl
IGRpZmZlcmVudCBiZXRhcy4NClNvIHllcywgYmV0YSB2YWx1ZSBzaG91bGQgYmUgaW4gZGV2aWNl
dHJlZS4NCg0KLi4uDQo+ID4gDQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cHJpdi0+aWlvX2NoYW5baWlvX2lkeCsrXSA9IChzdHJ1Y3QNCj4gPiBpaW9fY2hhbl9zcGVjKU1D
UDk5ODJfQ0hBTihyZWdfbnIsIHJlZ19uciwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+IE1DUDk5ODJfSU5UX1ZBTFVFX0FERFIocmVn
X25yKSk7DQo+IA0KPiBTZWVtcyB2ZXJ5IGxpa2VseSB0aGF0IHRoZSAoc3RydWN0IGlpb19jaGFu
X3NwZWMpIHNob3VsZCBiZSBpbiB0aGUNCj4gbWFjcm8gZGVmaW5pdGlvbi4NCj4gDQoNCkluIHZl
cnNpb24gMSB0aGUgbWFjcm8gdXNlZCB0byBkZWZpbmUgdGhlIGNoYW5uZWxzIHdhczoNCg0KPiAN
CiNkZWZpbmUgTUNQOTk4Ml9DSEFOKGluZGV4LCBzaSwgX19hZGRyZXNzKSAoeyBcDQoJc3RydWN0
IGlpb19jaGFuX3NwZWMgX19jaGFuID0geyBcDQoJCS50eXBlID0gSUlPX1RFTVAsIFwNCgkJLmlu
Zm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVyksIFwNCgkJLmluZm9fbWFz
a19zaGFyZWRfYnlfYWxsX2F2YWlsYWJsZSA9DQpCSVQoSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEp
LCBcDQoJCS5pbmZvX21hc2tfc2hhcmVkX2J5X2FsbCA9DQpCSVQoSUlPX0NIQU5fSU5GT19TQU1Q
X0ZSRVEpLCBcDQoJCS5jaGFubmVsID0gaW5kZXgsIFwNCgkJLmFkZHJlc3MgPSBfX2FkZHJlc3Ms
IFwNCgkJLnNjYW5faW5kZXggPSBzaSwgXA0KCQkuc2Nhbl90eXBlID0geyBcDQoJCQkuc2lnbiA9
ICd1JywgXA0KCQkJLnJlYWxiaXRzID0gOCwgXA0KCQkJLnN0b3JhZ2ViaXRzID0gOCwgXA0KCQkJ
LmVuZGlhbm5lc3MgPSBJSU9fQ1BVIFwNCgkJfSwgXA0KCQkuaW5kZXhlZCA9IDEsIFwNCgl9OyBc
DQoJX19jaGFuOyBcDQp9KQ0KDQp3aGljaCBjb250YWlucyBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBp
bnNpZGUuDQpBbmR5IHN1Z2dlc3RlZCB0byB1c2UgY29tcG91bmQgbGl0ZXJhbCwgc28gSSBzd2l0
Y2hlZCB0byB2ZXJzaW9uIDIuDQpJIHN0aWxsIHVzZSBhIG1hY3JvIGJlY2F1c2UgbW9zdCBvZiB0
aGUgcGFyYW1ldGVycyBhcmUgY29tbW9uIGFtb25nIHRoZQ0KY2hhbm5lbHMuDQoNCldpdGggS2lu
ZCBSZWdhcmRzLA0KVmljdG9yIER1aWN1DQo=

