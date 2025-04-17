Return-Path: <linux-iio+bounces-18188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53197A91B15
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E903BC239
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119123F405;
	Thu, 17 Apr 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gTrtrSo7"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4912B93;
	Thu, 17 Apr 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890058; cv=fail; b=D+JxUNHhSDKquN1I1ZQpuaMsBasxQ+emTPePXoN+WAFTnYW1ImHmxpNj/XxnzDmG5/0NHqAIieYGTRlSj1Seb+kePWSWpjm6rSvLEeRKUG1kXZPBX+y84v/gZtFtCM0OGIH4ksJQ0yKm5JSC9xBWWKKY+ZE3x0xUS7ZuN9XAols=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890058; c=relaxed/simple;
	bh=CD9s/dOMZ9ZzqnQf0rQ8v5lp3B33jU7rt3EX1yLluNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PnjSD3k6xqdSB8teih/6Nox2Lnxsw6aY8oqCQg54hv2tRkgJOsxuEt+4hfs1TXnRJzmf8W8Q4NDaBQ6QJy/tG9lQwvech+nJwTL4JQC9U0TetpTB+TAcWuv5Azak6y7hbE5Yhdwy8i4DL2GOamoPMNksPMvUx/lFwCuF5CWCDoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gTrtrSo7; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpFX6uHjZQtFa8iy8MXtTjKiQrAFy0j2ycEZDtTK2FPAXq7I8sPuYTuDxnRva26rbXkzkl7S6A+er+O0HnN8LNPoZkJBXA6BcUs6O9McMoQ/ohWDAIaiS+vB8zu/kUCBm7rzLDXckqfEjUu+8ojR+BgPivYZEMByJYbPituZ3Do/M6GiPX7lcpUkADe2o//qRZKDgE0JJV8avV1Mwp4aXPcufXQ7pf6TLI69uEn2s3ywz0OcIjBlE2xd+q6rhuw3p0X978ZbJu0/dP13j2AUlm7xw1CAAfVu6s3EIQQTj2k3Luoz1JpZ80x/mrIvLXcOv2+TEfSpJk3bEaPebFQYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD9s/dOMZ9ZzqnQf0rQ8v5lp3B33jU7rt3EX1yLluNI=;
 b=wSFLaXbuiYDrG1jzqEQ64z9nKdGRLvVY7Tpzveby5OfSAn5QlTuRj3KuZZbVk5uHaQREJM9GW7XUNIrmIUDxZ6EW/Yq2jl06pU3Ba8p4LnCJaTJO6rh7N/l8X80fPgBHAMDHdoJELU5EsV+Su0OxHYoGe1auofrA909KtTb+IgXfxUrhk13eTE9w7+RTC4+pRxkgM8xAMIrNVYLCM9I9Mq2heQRofE2ORS61hnDKwODhDbrrl219PctqQUuhDONUz/MSfaYyuJ2GAQnFwiFjrlMOgbdUukLdfVZQhDseScTTq2beSRBEiOgICmXvyI5+jspkirnpc81nQ/KXJ6aDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD9s/dOMZ9ZzqnQf0rQ8v5lp3B33jU7rt3EX1yLluNI=;
 b=gTrtrSo7BLYD0zCbyB8YoLd0LvfH60vjqNTClAW1WFN8l7NGknHe/rXWYJn2JSXTdGEc6ft9FR3p7aR1qmSR28aMzxaSbGAT6nyFyP774zc5zS7lWpeX7zjwOtO5IXjYlpIpwmOmurCHpuI7+EUNDY4zk5iD8fp/laWIQw8O5h+rTYwjIQWAskT+usnWzI/FqFnYAF3DFYMfCULg6S92H8a8t2CO6BF2a/dh5UvFGBC2qAnK9BjM4EKgJX0hbrOTXM0ZHtAIysi37zi3WdgQpoISPEuWzQdpcT5Eq+0uzd1q/OVl8BPOu9zivNJueCI3U1kK7pOjHEIkhHLGrgZmvA==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 11:40:53 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%7]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 11:40:53 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>
CC: <Marius.Cristea@microchip.com>, <andy@kernel.org>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Topic: [PATCH v1 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Index: AQHbrgoUEa9l812ZO0OzitxIihcWHbOlAhgAgAK894A=
Date: Thu, 17 Apr 2025 11:40:53 +0000
Message-ID: <b3ffdcd05578742b3b992102e7930ac123ee7d51.camel@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
		<20250415132623.14913-2-victor.duicu@microchip.com>
	 <20250415185200.396d6356@jic23-huawei>
In-Reply-To: <20250415185200.396d6356@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|DM4PR11MB6550:EE_
x-ms-office365-filtering-correlation-id: a0274a9d-b165-4074-f4c6-08dd7da4b5ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L25hRUhNeG9KUFFsdFdPOTVwem84aWkwcks3VTNGc2JIWmYyVG9mbTI5SGVY?=
 =?utf-8?B?UnpZSlY5WWViR29wQlJ0UTNBRzQ4UmpWL1NyRG8zMGN0a2cvM1B5RVpFRkZ5?=
 =?utf-8?B?T3RjdUZxK0Z5VlkvYy84WlljM2FMRzRZSnRic1Y2RG1GVDNlNTd1c0xHZmNw?=
 =?utf-8?B?MGMwZCs0dkdZNjZweFNPSkZyQ3NJSCtIbmlCVm9PSzZBanFXdlhRNk9NWE15?=
 =?utf-8?B?UzhpL1UwR1BKQ3VOeFdZU2M2djVYQWxOVmFrSTd6U2JyZGpqL0llUUZyeUNN?=
 =?utf-8?B?MkpJOENGSTkwMzdSNTc3NmxTZmZZaHdFcEZkVnZYRzhtSnFBbWhlZXJUNE9I?=
 =?utf-8?B?Mk0rOVBBWG5tRURLNVlrK3NYN2VRQmNMUUdTYllSRTZleTJrTnlWdWFoaWFZ?=
 =?utf-8?B?bzlLdmtMZkFWSnduVE9qN2J5MGMwek1ZdTRSUEZFdURDRmQ3KzB6QmJpQTE0?=
 =?utf-8?B?WlZDbWZOWjZTMDhhU2xUZCtBOHkwb1B1T09RYVF5a3k1aTZPZHFNR3V6a3NM?=
 =?utf-8?B?WkI0ZDgxclBxZTZyb090aS9WVFlRdFczbmUyY2g1NFhZejNUdHNzMUM0bEJ6?=
 =?utf-8?B?cWVCckdSY25mdnBaZ2xLaVRKcGc2bHVwUWRxdkJZa3N4Z2pGOFNqa2JncFpx?=
 =?utf-8?B?blhzcGFqNGtqQmhQNTZBSFNJb3JCalB5aUJKMkZYWTZieTNSaXFCTXdCRllD?=
 =?utf-8?B?RFI4QmJ1aCtHWGVPbUVSL2orWldjRU5xWTlIUDJHV2M5Z3VoNkVscXowK1gv?=
 =?utf-8?B?emRadnljNXJMMUx6UjlwNWlIWmNSQU5SMHJQZy8vOEVkNi9wUy80U2prbGxt?=
 =?utf-8?B?ai9oV0lGVWt2ejNETkVpc0srUDk2dGlzY0lYY0NSeVc2TDFMTEZGbW9tTExu?=
 =?utf-8?B?QVJCdGtkRzVYNGV3bnFqc0Vva1VnTTlqQkx3ZW43ZGdsdFg4VEZWOTFZMm1E?=
 =?utf-8?B?S3hXbDZkOTd2V2kwMFVSUThRdHRWK256RTZNOGw5THdVQTk5VHhtaHZDeFd3?=
 =?utf-8?B?UDBPbDJaK2pFZlhRcTZNTC9TQy8rWTRUZ09NbWplUlVSc29uQldrMmx1V0VV?=
 =?utf-8?B?cHFPZUJpd0xwamh3dE5IU3FNdmFTc0JOZUhFOTIxSzhlSXZkVlBoWDM2cXFJ?=
 =?utf-8?B?em5aMXlMdlVWTHlBYytiS0RWS2FOaGdLL2h0UFhMS0U4RkJFalpUajF0L1RQ?=
 =?utf-8?B?Vk51V0ZkS0RjaXlFUTI3SFllZnplK0JOZ3p2VHM3WXhkYVdveHhnNTY2bjZq?=
 =?utf-8?B?YkV4WlI2VnhBVVYxOE9lMWhnSGhEMzJmRVphbzJBQ09vdHFlNk9Nbll0bTZ0?=
 =?utf-8?B?T0JwNm8rYkRXdGlwQ3RES1pUay9vM3RmM2h4bjRSNDNuUWJLOThMRzZLeDJw?=
 =?utf-8?B?ckl4aVFUcjZUYnVHSktpQk1UN2lreFhVVWxrWFZFRndJejlXb2VBSlhLK29k?=
 =?utf-8?B?NEdmTkpUZUdsR0NVRFQ4V3QyMENpQ25ZZE5tMy81czJUSlVWbkxNOVpOcUJE?=
 =?utf-8?B?OGEvdnBPQjBhdUdEbC9SRWNjbzJJWk9kMG5lYURuWGNIa2lIdFdnWU0wTlFG?=
 =?utf-8?B?OWU5azc1TEI4bk9WL1RxZXRQNGxtOGJnSmNQTnFqUmtsUWdXeFpIaVdQUjRo?=
 =?utf-8?B?NjZsSDkwbjRiM1FDOGJGRkhGVnBNNS9vRk5MTHZLUjhZWVM1MzE4bHYwQjBK?=
 =?utf-8?B?Nnh0TE5kUnhnRU0yVTUva3NUZUtsb3hPc1hSTXAxRVV5ZklSaDB2T05EK2lL?=
 =?utf-8?B?bDJoZFE5bHZkV3prR2xZR2NVUzBUSjBpcWUxdk0vZjRKMTI5UmllR0tFeGlZ?=
 =?utf-8?B?cWlsL0Q2VXFYRTg0OFVKN3dKK01HYXpqMElyYnZYUVNieHBtQStxV2Z0cGlp?=
 =?utf-8?B?NnV6czR2dXVaUUlpeFkxajFybHBJenZyd1dSUWVEc1NGbFM0M051LzJJay85?=
 =?utf-8?B?cWEyNUtFM1d4WkcvLzcrQURnN295eHZ4ZFZRcFM4MThYbVdGSWMvb0tPZzdK?=
 =?utf-8?Q?h8IXB7tBw6n6tSehEWxuyrRuHpifz4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akRPZXBqNnJBS2R5ZzV0Z3gwdkxTQ2ZQclJnaVFrRDhHRkw4Z2xhQzc0S3cz?=
 =?utf-8?B?bi9IaC9NOXlrb1dod21waTJwREFDSGRXZVp3UnBDbXhXa3l5N1NYb0poMmtW?=
 =?utf-8?B?TFdIMHBjdkVqcllwci9wK1ZHaVBoYlRrZVVrNWZQZWJNc3g5SVEzVHc2Y3Zn?=
 =?utf-8?B?YVc0bGxyNDhsSWgySlpsSkNyaVdEQjc5Zy9vRlhuUGRwMEVia0pZVGlxaUVL?=
 =?utf-8?B?R0tnNUNhSVBlbHlZa2RubXFmTlFvb0psWHErK2dHaGFnRlFiSDNkbDJOYW85?=
 =?utf-8?B?MjZKY2Y1OStrMzA2RWl4OXBEV1lheEY3NjYxRktXNURIMkR1cVlFakFSaXJX?=
 =?utf-8?B?ODhobkhEWU0zaXBKcFNRSXBzdVB3YWcwemJSQzBTaFk4ZzRjOGoyMFI4WjR1?=
 =?utf-8?B?bjg3RTVXbkZGNXp6WjFpMTg2QnZYVEZJejVKYklKUkU4WDZ1VTZHbkpRTTZJ?=
 =?utf-8?B?V3F5NEh5bjRsdVJXeE1KL0ZjNVNZMkJYVlRyTVd4TWpTTm96UTJGRFRsNFZw?=
 =?utf-8?B?b1VaZ0Jzd3ZCdmpzMDhER3hsWEhmTmhZN1Y0b3RVWGRBS3ZhalBvRENJZkp1?=
 =?utf-8?B?Y3JzaThvdWU5eWNnY3RFZUtmUU5xaTVENnBacG5ZWjY3NjA5RFREUlVYRi80?=
 =?utf-8?B?ZGlGWjhVSzg3Y1BINTVTUi8wUFdUVGZNVCtMRU1EM1AwQUJTMzJkRUlTcUNY?=
 =?utf-8?B?U2FiSTdnZVc1M00wYzVOYVFUUXhmZU9IeTJsa2plRmlDaUFkNUxiWDRZY1Rx?=
 =?utf-8?B?UTZyK3hkT3U2Nk9BRjcyRmJXQjZ5UmVDWThuZGJ6cnQrODdSMi9pcGJCdTRR?=
 =?utf-8?B?MDhhb09lb045Qm1jMCs2ZjhqaEc0TVFZcXNWMG1KOXc4eGsvcDBabHBOMnBE?=
 =?utf-8?B?NnovYTZrVEZjVENucXNkSlQwVGhqQXdmZjJ4dExsOVZzRWtzVE1RdURoeHl0?=
 =?utf-8?B?RGNZQWwxSVo3c2ZqTUduc01ZcC84SXFBcHlsc04ybllUUFpYdWJVV2x1UmVD?=
 =?utf-8?B?VkJoQjRJY2ZjTTRObkhwdXphejQ5ekJscW5pZHdLY1JHRTMxRCt3MmJJTkxt?=
 =?utf-8?B?ZGQ2YWlGc1ZMOWZ5REdvUytmd05iazQ5OXBidHhCMHYxQ2YvdWkrVWUzWFIr?=
 =?utf-8?B?YXFpYVdVZkxuUDNQY0dHY0NTRkNNbFQzQmxKajl4RmdOM1cxRlhzWDdwRWZp?=
 =?utf-8?B?NzEwWG1hYVVOdnFHWjlxNGxUU25IWEdqc0RxaU0yV0U3RXRudVkwdTN5bnB5?=
 =?utf-8?B?TUFJWFdaUGsxb210TjNVQWlqY094NzBFaXNSVy9LMytwVDRqZkdhelJBZ0E5?=
 =?utf-8?B?TVN2Ujh2V2E0Zk42d3lQTzdnRGtRUXZURWx3UUpJVGF2ZWZmbDR4RXF2MEEx?=
 =?utf-8?B?OGNxbWFsTnlZcHJWR3QrVkdobTBoMXpLUmdDSFpmMkM4M2IvL0cxOTd3R09t?=
 =?utf-8?B?QVphRUNFQ0w5WG1IaFZuM0lZN2pLZlZmNjc4dzBIVXVRWU8zOXI4b1NzN05o?=
 =?utf-8?B?WFh6VWREYjBjVExIVFl0T2R6dzFhb0p1cXdLQUF6d1FWSWhZTUxOb1pQcUor?=
 =?utf-8?B?NHQ3dHdNQkNTY1IxamNWb0xDejV0VWdqSDY0VFlXdHpPMmZLZzBKWnJFeDEz?=
 =?utf-8?B?bXZsK0lIMkpoSWE0Q0xlRlFLTWRaNHhuRHhlWlBhTXdONFVxWWpYYmpUdUhR?=
 =?utf-8?B?ME8vdnBZYVVCalVJOGdkRjBEL21Yc1FBeS9NaHdWK3BEYkt4ZmVwdmRvSTVk?=
 =?utf-8?B?aTlPUW9iMXlNNVdKdU5KVzdOTHVFcC9sSXNnSkpWN2k2dllRSklWQWNrajlD?=
 =?utf-8?B?TkViMytxY0tZWkJCYlhURFBsaXlpMmE2em5QK0F4bytzcU9Fbnc4T1p1Vkhw?=
 =?utf-8?B?VHRpRlVUZTk3a0NiVHBGZzdVZkRkclJBN1VuYml5dGlkbkpyQ1kwYVUvQUEr?=
 =?utf-8?B?Q2o3cmNGNjI1b2R3WmkwcGhjMHpQSFEyNDBJRUt5UjIzMS9zK0hIY3B4Qlp3?=
 =?utf-8?B?eWlOUHcxY1ArZ1l3Ymc2aTQrKzZTdDZ6UzJ2QmZ3WklQM1p0WWhMYjE2TWVj?=
 =?utf-8?B?c1hTaXN0Ri9kSWtDd1lKcFZwVGc3R1ZDa01vbjA1YlpncG1JVko1L2NRUmhS?=
 =?utf-8?B?b2F6VGZURDFqY1VUNVJKeUdEK1FCa1JqVUgyV2dURE1wOGhjSDdhMEsxUHk5?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <970A4C528EB7A741A8B079D6403237F8@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0274a9d-b165-4074-f4c6-08dd7da4b5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 11:40:53.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWxNAexi50LtEw+Xd5DlFh8V8bpzF7l5FYQcCe56iV5ut/8ZrRyvKm33J5QwIJcYso3Yadfc9jU6INEvET0X6bQYlT8hQSOjAaPufMX8QTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550

T24gVHVlLCAyMDI1LTA0LTE1IGF0IDE4OjUyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwg
MTUgQXByIDIwMjUgMTY6MjY6MjIgKzAzMDANCj4gPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9j
aGlwLmNvbT4NCj4gPiANCj4gPiBUaGlzIGlzIHRoZSBkZXZpY2V0cmVlIHNjaGVtYSBmb3IgTWlj
cm9jaGlwIE1DUDk5OFgvMzMgYW5kDQo+ID4gTUNQOTk4WEQvMzNEIE11bHRpY2hhbm5lbCBBdXRv
bW90aXZlIFRlbXBlcmF0dXJlIE1vbml0b3IgRmFtaWx5Lg0KPiBIaSBWaWN0b3IsDQo+IA0KSGkg
Sm9uYXRoYW4sDQoNCj4gUGxlYXNlIHN0YXRlIGJyaWVmbHkgaGVyZSBpbiB3aGF0IHdheSB0aGUg
cGFydHMgYXJlIGluY29tcGF0aWJsZQ0KPiBhcyBhIGp1c3RpZmljYXRpb24gZm9yIG5vIGZhbGxi
YWNrIGNvbXBhdGlibGVzLsKgIFF1aXRlIGEgYml0DQo+IG9mIHRoYXQgd2lsbCBiZWNvbWUgYXBw
YXJlbnQgd2hlbiB5b3UgZW5mb3JjZSB2YWxpZGl0eSBvZiBwYXJhbWV0ZXJzDQo+IGFzIHN1Z2dl
c3RlZCBiZWxvdy4NCj4gDQpJIGFtIGEgYml0IGNvbmZ1c2VkLCBjb3VsZCB5b3UgZWxhYm9yYXRl
IGEgYml0IG9uIHRoaXMgcG9pbnQ/IEFyZSB5b3UNCmFza2luZyBpZiB0aGUgY2hpcHMgbWNwOTk4
MiwgODMsIDg0IGV0Yy4gYXJlIGNvbXBhdGlibGUgYW1vbmcgZWFjaA0Kb3RoZXI/DQoNCg0KPiBW
YXJpb3VzIGNvbW1lbnRzIGlubGluZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWN0b3Ig
RHVpY3UgPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiANCi4uLg0KPiAN
Cj4gPiArDQo+ID4gK8KgIG1pY3JvY2hpcCxleHRlbmRlZC10ZW1wLXJhbmdlOg0KPiA+ICvCoMKg
wqAgZGVzY3JpcHRpb246IHwNCj4gPiArwqDCoMKgwqDCoCBTZXQgdGhlIGNoaXAgdG8gd29yayBp
biB0aGUgZXh0ZW5kZWQgdGVtcGVyYXR1cmUgcmFuZ2UgLTY0DQo+ID4gZGVncmVlcyBDIHRvIDE5
MS44NzUgZGVncmVlcyBDLg0KPiA+ICvCoMKgwqDCoMKgIE9taXQgdGhpcyB0YWcgdG8gc2V0IHRo
ZSBkZWZhdWx0IHJhbmdlIDAgZGVncmVlcyBDIHRvDQo+ID4gMTI3Ljg3NSBkZWdyZWVzIEMNCj4g
PiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gDQo+IEknbSBjdXJpb3VzLsKgIFdoeSBkb2VzIHRo
aXMgYmVsb25nIGluIHRoZSBEVCBiaW5kaW5nPw0KPiANCg0KUmVnYXJkaW5nIG1pY3JvY2hpcCxl
eHRlbmRlZC10ZW1wLXJhbmdlLCBteSBwZXJzcGVjdGl2ZSBpcyB0aGF0IHRoZQ0KdXNlciBrbm93
cyBiZWZvcmVoYW5kIHdoaWNoIHNwZWNpZmljIHJhbmdlIG9mIHRlbXBlcmF0dXJlcyBoZSBuZWVk
cy4NCkZvciBleGFtcGxlLCBpZiB0aGUgZGV2aWNlIHRvIGJlIG1lYXN1cmVkIGlzIGEgZnJlZXpl
ciwgdGhlIHVzZXIgd291bGQNCmJlIGludGVyZXN0ZWQgaW4gdGVtcGVyYXR1cmVzIGJlbG93IDAg
ZGVncmVlcyBDLiBJZiB3ZSBtb25pdG9yIGEgQ1BVLA0KdGhlIHVzZXIgd291bGQgYmUgaW50ZXJl
c3RlZCBpbiB0ZW1wZXJhdHVyZXMgYWJvdmUgMCBkZWdyZWVzIEMuDQoNCj4gPiArDQo+ID4gK8Kg
IG1pY3JvY2hpcCxiZXRhLWNoYW5uZWwxOg0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246IHwNCj4g
PiArwqDCoMKgwqDCoCBUaGUgYmV0YSBjb21wZW5zYXRpb24gZmFjdG9yIGZvciBleHRlcm5hbCBj
aGFubmVsIDEgY2FuIGJlDQo+ID4gc2V0DQo+ID4gK8KgwqDCoMKgwqAgYnkgdGhlIHVzZXIsIG9y
IGNhbiBiZSBzZXQgYXV0b21hdGljYWxseSBieSB0aGUgY2hpcC4NCj4gPiArwqDCoMKgwqDCoCBJ
ZiBvbmUgd2FudHMgdG8gZW5hYmxlIGJldGEgYXV0b2RldGVjdGlvbiwgb21pdCB0aGlzIHRhZy4N
Cj4gPiArwqDCoMKgwqDCoCBQbGVhc2UgY29uc3VsdCB0aGUgZG9jdW1lbnRhdGlvbiBpZiBvbmUg
d2FudHMgdG8gc2V0IGENCj4gPiBzcGVjaWZpYyBiZXRhLg0KPiA+ICvCoMKgwqDCoMKgIElmIGFu
dGktcGFyYWxsZWwgZGlvZGUgb3BlcmF0aW9uIGlzIGVuYWJsZWQsIHRoZSBkZWZhdWx0DQo+ID4g
dmFsdWUgaXMgc2V0DQo+ID4gK8KgwqDCoMKgwqAgYW5kIGNhbid0IGJlIGNoYW5nZWQuDQo+ID4g
K8KgwqDCoCB0eXBlOiBib29sZWFuDQo+IA0KPiBXaHkgaXMgdGhpcyBhIGhhcmR3YXJlIHRoaW5n
IHRoYXQgYmVsb25ncyBpbiBkdD/CoCBFbmZvcmNlIHRoZQ0KPiBjb25zdHJhaW50DQo+IGluIHRo
ZSBzY2hlbWEgcmF0aGVyIHRoYW4gdGV4dC4NCj4gDQoNCldpdGggcmVzcGVjdCB0byB0aGUgYmV0
YSBwYXJhbWV0ZXIsIGl0IGlzIGRpcmVjdGx5IGFmZmVjdGVkIGJ5IHRoZQ0KaGFyZHdhcmUgcGFy
dCB1c2VkLiBGb3IgZXhhbXBsZSBhIENQVSBkaW9kZSB3b3VsZCByZXF1aXJlIGEgZGlmZmVyZW50
DQpiZXRhICh0aGF0IGNvdWxkIGJlIGtub3duIGJ5IHRoZSBtYW51ZmFjdHVyZXIgb2YgdGhlIGRl
dmljZSBhbmQgbm90DQprbm93IGJ5IHRoZSBmaW5hbCB1c2VyKSBhcyBvcHBvc2VkIHRvIGEgZGlv
ZGUgY29ubmVjdGVkIHRyYW5zaXN0b3INCih0aGF0IGNvdWxkIGJlIGVhc2lseSBtZWFzdXJlZCBi
eSB0aGUgZW5kIHVzZXIpLg0KDQpIb3dldmVyLCBJIHJlbWFpbiBvcGVuIHRvIHRoZSBpZGVhIG9m
IG1vdmluZyB0ZW1wZXJhdHVyZSByYW5nZSBhbmQNCmNoYW5uZWwgYmV0YXMgdG8gdXNlciBzcGFj
ZSBpZiB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIHRoYXQgd2F5Lg0KDQpLaW5kIHJlZ2FyZHMsDQpW
aWN0b3IgRHVpY3UNCi4uLg0KPiA+IA0KPiANCg0K

