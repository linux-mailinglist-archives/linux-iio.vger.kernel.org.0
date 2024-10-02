Return-Path: <linux-iio+bounces-10004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E598D38D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 14:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E21F226B0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6D1D015D;
	Wed,  2 Oct 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AW3G7/iX"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F071CFEDC;
	Wed,  2 Oct 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873062; cv=fail; b=dc2xN7kKkE8kMKHiABdQeOcWjWmiEFcXJEifY5Cox1BCIz0IdWbTVfDQlMNxnqMKVSoWih1+BUf7Fsd0/jMIUQAUvbJHnaXOhgrn9eHkj4guEJEmM3589EcThGvLirm3uUm+V0qp2xCNX8DMNwh00S4+DBxrcBVdM3Y5zHtF2/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873062; c=relaxed/simple;
	bh=vCYrqMA+CnfQmJny8QcqnfL2gvvXLPOQABoYK9rRB80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gIVDv/J7ejQuyGks61mqJjBevb9x8Yp0VWcKAf8nbY/dDCX11hlc90Cyp3FO07O0OhG80vwvm8zGc2oopM+qYUiAXKET/FjyCoemfLmT4HQVsW0KHAfpg7mcEhCldIUb4kX/nv+zoQZXD4rljw4wDYiwmsxjFCLkuFD31uQFKcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AW3G7/iX; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPwYaAwnV6jEIO7M0auWzBwUSEqebTohoIimHhpwxxwhBV1QHmU4/mKhPEigAY05fI3XIsCwVdu4mpAnXnsz77EsjOQ9BmoSRPkXmvtZmQK4R8NsFbocPlG2b59hbX6FVYAAADhS1lUSbTeWcVjkH5+fZGHRwR4fVwl4fGy8osRPYar4BRArN0ICvRAU1JQmcq3fXcmEbxcnwXKmUnMF7iC2BkpbhKuySZlU2P1tXFDgaLZKJqsMe23pgieWHgBzVbRxar3p7bdbwA0hq5qLFwyd1RlrD76zkIajCAguTrpreTzlY0wqh/JZNmwbDbpM0T/kwl+eABsWx1+FSq5+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCYrqMA+CnfQmJny8QcqnfL2gvvXLPOQABoYK9rRB80=;
 b=Y+cjSpVl36rrbTxkWQNptqg61KhFeX9Es/exusT8Zd3SjZDup6zxmlRhvc3Kix9utWFJPgvD3bqndoLlasQtB2BW8//msX3DJdokhsC+FUBxzc+SFacZNMWwlfKk8ErVRb/B0j1dR/NfLQ9GYGafm9aW8E4MGHeeSuWx2esLNqiZY/SL9WCGmQrr646vE+hFD/eMr5Pl2cE/FmQZHzvFOzYkFJBzer5MvI6y1RvGQHW9tc126W2qrULm9h4goblh/eFs1Za1ZQUEauSuoKHU4ElQP39I7odBIH0WxTej4cXUU8KLP/9fV4nxNEr++vllmn7HvNzQ2pnPf8ooLCJ3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCYrqMA+CnfQmJny8QcqnfL2gvvXLPOQABoYK9rRB80=;
 b=AW3G7/iX6WWetHNuoPUvYC2ZbNxeQFAVKAegt1Slo39lM7t7Xabqyy6yy7krwA7l8xJKhOePVO6ymNc8zV0pvsxSIU+VZg5P7D//ViH3H9e/qNTLIJmx4Geb9d098XP7+8ZYjQiKomnERI/2YlirFbG87JH/4gl2FvxcpVMaX8c+0EbNKuZhVpopho0AfZOAz5JtP1Cxpaf2MPpGrIJTwEKh+e8Hc1j6sD/xHEzwoD8V1bPEZ8LjvnB326z1qOsvNUfRPhRJdHWBFnnbhhWDHBYsrQCcAtvh/346g/CssiOUklYlYSwd7uZHL7k/1prIDj0LgVf5MozQAiGEnltBbA==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by BY1PR11MB8029.namprd11.prod.outlook.com (2603:10b6:a03:526::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 12:44:16 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 12:44:16 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>
CC: <Marius.Cristea@microchip.com>, <matteomartelli3@gmail.com>,
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: pac1921: add ACPI support for pac1921
Thread-Topic: [PATCH v1] iio: adc: pac1921: add ACPI support for pac1921
Thread-Index: AQHbD1zdhxNKL1+VSUaQSL3Lid19/bJtbDOAgAYGpoA=
Date: Wed, 2 Oct 2024 12:44:16 +0000
Message-ID: <b459b62eed7418d4eadb60b4f1e4816448176e20.camel@microchip.com>
References: <20240925150856.19441-1-victor.duicu@microchip.com>
	 <20240928174253.15e1fe7a@jic23-huawei>
In-Reply-To: <20240928174253.15e1fe7a@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|BY1PR11MB8029:EE_
x-ms-office365-filtering-correlation-id: d75b3165-79c1-40c9-bcfd-08dce2dfed25
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0JHdFpobGEvSzRhVjB4QUlwYzh6aDFQQWpxeFhDbDljOTczbkoyTFhEY0ly?=
 =?utf-8?B?emxVZ3Fvd1l2M0d3OUdVS25FbE5RTDZFdDI4cHowMGtDd3B4VGpuWmRxYnV3?=
 =?utf-8?B?eUhZdzVYSytZcmM4aGorbklzNCtPeVJFalJZbHhwOXBwYjRFRHhBWndKUEZi?=
 =?utf-8?B?VXNad3hheG15QU8vcTZ0dENvVG1TYlJUZDVFQjYvaFFxZ2ZKdVFhbjQ1QlZU?=
 =?utf-8?B?UklzYTdKYWN0MmlGVEF6angrOXBLcmwwNGpSK1NNZnRvdEpzaGlWSllXVjFE?=
 =?utf-8?B?NHdEcGlPRDZodEoyMEJhMUVGZTV1ajludjc1R1RKVUZFcVB2Q0dFNVV1V0lz?=
 =?utf-8?B?OXZ6Zi9abXBlWXZqcVhEL2tCWU1peDB0Y3NTRTdIcEFGODlmcFlwandmUDB0?=
 =?utf-8?B?YUI0UldCSitxejFrNFhWMFYzQm1RWVYzZ3l1SGZjckhrZTNZaHhYUllKNEdu?=
 =?utf-8?B?dEd4ZUxFbWlwOGVXamYxdzBIQ05oMVhCck1TOEw5bEdUcVdGOG5XUUF6cThz?=
 =?utf-8?B?TGoySnlKazExY3dha2o2dHVpYlpqNDJLc0M2SU9rcDdnR2xWb1BiMjdTUVhC?=
 =?utf-8?B?ZDMwVGNvSWhadGF0ZkZGR3IxZ3ZQc3Rad2YveENHaGRDVzlVZ2dnTkRGbjVn?=
 =?utf-8?B?ZjRpOVc1eStBV0lHSGFDMjB6SElhR0JIUm13SGZMZHNpZFVYR1ZiYWE0Snl1?=
 =?utf-8?B?TUZHZFBzUm5RZzhJRGlXUXhvT1NKUmlVSkZVYVFHdmQwM0x0Z2toNmtqSnNo?=
 =?utf-8?B?WEhza0RSTHV1RXdUOVVJZ0pncGZJcG52TnR3UnVJT1BVTHpZNExqd1BjQzJn?=
 =?utf-8?B?dWFnbk5TQXpJbFEvYjFZdDcwYVVrRnBHclZVTndCTjQ0YVBla3ZpSndMRjBM?=
 =?utf-8?B?b2pyUU5lWituOWk0NURmWDB1dWs4SUFoekttV2RoNURQdEhLYkJPN3dJck9y?=
 =?utf-8?B?Y3RoNlpUZklHeU1tMjY3OXRmWWFuSS9nOG5TODdkSDQ0WEJBRm1jQ2M1OTQ0?=
 =?utf-8?B?czFYbUJ5OU9mWk1GTnEydVhOMnYvTTJzYXZjVGZyWnlDejU5WUM3cGxxRjhq?=
 =?utf-8?B?RU9NYVgrMTJBYmYzTWcwYmpIS3dwT0pUWmR6dUs2ZDAzeEJGY3hMeHoyUllT?=
 =?utf-8?B?NjMvV2t5QkdnOUd1bFVZMlhvMzVtVXVkQVh1NytxN2wrclZ3OGRSdTlqaXJJ?=
 =?utf-8?B?QXpmWWNEUVFuMTJNdHR0cmpTOHdtT0hJMk1tTUVUQU9RTFVjeEsyS2xZREp1?=
 =?utf-8?B?K0ZET040MEhBNWQ3RkxJRmsxNEYvZllndjBUSnNzRG1zZTIwR29VQ1V1d091?=
 =?utf-8?B?SFB5M1FDSGFhQUtkUGVrTXI5a0hRdi9zRHlnUDJsMDZBY0p2bDRVdzRpV0kr?=
 =?utf-8?B?MEtyYWM5eUVja1UxQXVLeG1Va0R3UExMM1lpcEZUMWxBNmpUYm54aERiM1lY?=
 =?utf-8?B?VXk0S1JqZHl6VmNudkV2VDFrMVV3c0R3Z0xlWVI1Yy8rVy9hSUJHejMrSTFx?=
 =?utf-8?B?N0FiM1pRTTcrc0psQ2dnd0RybjN1VXkyWXZUeFpKeU5oOWhETjYzVnFZN0xP?=
 =?utf-8?B?a2FDS0hkc3FqYVgrdURYbWVmaGYyeHNLQ3c1bHVxNi9Ic1hWRW5OOE1wak0r?=
 =?utf-8?B?M1ZGY3pFZUNSSVhvVVJTYjA0Y0YyU1piTmZLaDlqanpVdmhTaUNWWWpnWEpT?=
 =?utf-8?B?SDFNYXVaNEhHcGN1TG1OUSttM2FVTHo4ZVI2L0g1UEJUcXRadHYrcS9HSUk0?=
 =?utf-8?B?VkxOY0V3QVhEcjF5TFlOaS9UcUxqOGNzMmRNYjNPb1ZIRTdXclJtcHpTWmJJ?=
 =?utf-8?B?UFB6c0NoN2ovY3VsR2FLZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG0vbDhIRUxFYXYxSC9IZEJDNlhkeTBQS0ZQY1ZLYTJuYzN2MUV4anlnUVYv?=
 =?utf-8?B?dWlLNEtycTJwTEhUQnVtaExUNmVNeHV1TGlySEpuOEoxYk5RdDlIRGlLL0Fx?=
 =?utf-8?B?MmFWYi9mM21yRUNsbUNDYWtBZHBlZFpabWlVYW9pMms1TzhiYlExL2JZVlJF?=
 =?utf-8?B?cXdpT0lvMHpIMXdEU0RzQ2NDOFlXVUVPczd0Q0ZRRFR2MDVGRjBCSXpVMldJ?=
 =?utf-8?B?Mjc2cjNtb2tlMkd5UjEvRG9ONkhJQllPd0tJYmhlRytjYUpoVEczUVFLVEln?=
 =?utf-8?B?eDBGek5VQkZwWWlVS3NpYk9nb0hxZUMrVENJTi9MbUFESHhOWFB6cWtZSG1y?=
 =?utf-8?B?eTN6WG1PNEVyYXBTUkxodE8rQ0t5cjhIams3UHhkVWJhSmRDRm9ENzlWNVM1?=
 =?utf-8?B?c3pjbS84dHorMitxZFY4Z1l3RENtV3hONFJiZnZCaEFSM21JZjNrY1NTbFdS?=
 =?utf-8?B?RmdpUnh0V1IwTDcvYllnZnc0YU9KV2VIY1VpOXV0Z3pKOGdyNlIxQnBQZzgw?=
 =?utf-8?B?bFhxM1N5Z21jSDhuUzFOYkxHN0ZQOXVMOFlpdHZPMXdVeGdhUWJiVnl1REsx?=
 =?utf-8?B?eGdtVWExc3VXV2NEV3hjWldzcGVja0liWGxCbmVKRzlDUFVualhBVXpEdGFz?=
 =?utf-8?B?dnpVcnpVeG9waGpISWJSZVVHTEdsbERQcWhtV1BMNGFSVDlIcXB3ZjNSZEpE?=
 =?utf-8?B?RlFQQjBONFMwdllwTkhnMWhFZ0hTamRjVEZCWHljLy80SllDeUs0eDlrUHNO?=
 =?utf-8?B?Nm5lOHJwU3l5enNrbHN5VXQ3R1NCNGsrRUpGcUR1MWJaNG9NRzZCanVmb2Vt?=
 =?utf-8?B?aWhoZUk2UnNnYk5FODdCQ3BTVks5ZEprTFYwMElTVjVVUGQ1MGVpWE5SWGUz?=
 =?utf-8?B?K1RsQ3ZyTzB1bFRiSURUV0ZjUUZrUlFXTXdQZ3RqTHExM0k4WWtic3lmbE53?=
 =?utf-8?B?bW5mY2V1Wm15dDhWa2Q5LysrQzJsR09UdTJvK3ZmbmkrK0lWN0NIWXNPQWdK?=
 =?utf-8?B?cGpST2R1MzhWQVpBL2NvL0FoU095NnkrQzJ3U2FkcUtkZXR5Q1I1OUFJVVhl?=
 =?utf-8?B?d0NuQzZvS3czT084Q0xBWWVRRm5CZ3lQL0R5bXl6eDFSMDRzalUvZk1PSVBR?=
 =?utf-8?B?dldvVWV0b1N0THppME5oUHBYbGMzNEVLSnI5ejBDZlp0Zk50dEY1OHcwRnFW?=
 =?utf-8?B?SS9LV1RTb0Q4TzBDbU1Md0o5TFUxU1NEQUZocHJWWkd5MEJ4WEJTazF2cDhP?=
 =?utf-8?B?dXJNYkQ4NXI4bS9EZkpCaC9LMGJNMHJZdERaeHdDd0lqQ3lsYlc5UjRpRDF0?=
 =?utf-8?B?QTYrMW1pRnRzbVRKcXd3RHc2eEN0djN4Z3NsaXF0U2tadExUNXplYkxXSnAv?=
 =?utf-8?B?Z0J3WHB4KysxcFB5enJkRDlDZ1hMMnJBeTBxbFVwS3BqbzFNZUxGaHN1V3Y3?=
 =?utf-8?B?TTV1SkVtZEdDWXQ4c3ZicDQ2MTBVS0JTTjVSK09lMTJ6Znl0NkxlU0RBamJj?=
 =?utf-8?B?NE5rZFFjOGNGaE9hQ05Wak9EZVNZUFU2M3NtOEJQcHN3dzcvc1d5NFE0Y25w?=
 =?utf-8?B?MVVLVituNC9yOGRhZFF6UTVUS3l1eEVnWHhkYkcxSkZWdC9ieDFrV1JwdndB?=
 =?utf-8?B?N242RmJ6U3V1RjJ5M1BxODF5M2lYbGMxRVpkZWpOWHZBUzFubEFiTWFkQ0E4?=
 =?utf-8?B?S0s4VEoyS1FjYTIydHlpNGJHYklwdnlCRTBEZDZvblZaK3ljWm5kZHd2VjY3?=
 =?utf-8?B?ampoT2RNMlBlQ1ZoU2xWYTh0K0dnb2pNN1ZCN0FSMmhvcE9FeERPSjVlTFF3?=
 =?utf-8?B?VjRpRVV2ZU00RTN3VVF2OTZFTndKMUJQQlEra3luSitKbFM2YTJEczRQNDhE?=
 =?utf-8?B?YlhQcjdLVmh2andtUXpscU5pY1JtYzQ1cnRoLzRGNGxDOGlHMStpSTZJdXk1?=
 =?utf-8?B?anNRSmF4VUlWTGFqVmM4OEFhRkNPazBjTGtvR2MzN3k5Nm5PWXFLVnhjcFU4?=
 =?utf-8?B?bndseVVZWGovU3F6SnVoTG9WRFhzampZa3hha2VMRm5iMURESkIxbFdnVWtu?=
 =?utf-8?B?WnRHdFZ6Rm13OUxwcHpBQ3VLQVZqUFd3cTNSR1NKWVJ4bmt1Y0s3d1RIb2F4?=
 =?utf-8?B?YXZDMnJ4SHFyMUVhVmJFR2lsNGtkY1Uvak1LcU5ncGJzdFU1OWI0SDNrcVdk?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <124E91B2354F8A4A8E2AF7640515E2DE@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d75b3165-79c1-40c9-bcfd-08dce2dfed25
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 12:44:16.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJkdwMIWezxyrAyjBwz2YfOlgmdSRFIO/e+xjvQtLVtSpCuam41ErQGn7F54nEOtAvM4jlX94t0KX7WvD1Kh9bdMzLFXMAgC923QLLMWxf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029

T24gU2F0LCAyMDI0LTA5LTI4IGF0IDE3OjQyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwg
MjUgU2VwIDIwMjQgMTg6MDg6NTYgKzAzMDANCj4gPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9j
aGlwLmNvbT4NCj4gPiANCj4gPiANCj4gPiDCoE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHBhYzE5
MjFfb2ZfbWF0Y2gpOw0KPiA+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNl
X2lkIHBhYzE5MjFfYWNwaV9tYXRjaFtdID0gew0KPiA+ICvCoMKgwqDCoCB7ICJNQ0hQMTkyMSIg
fSwNCj4gDQo+IFRoYXQncyBhIHZhbGlkIElEIGZvciBvbmNlIHdoaWNoIGlzIGdvb2QuIEknbGwg
YXNzdW1lIE1pY3JvY2hpcA0KPiBoYXMgYSBwcm9jZXNzIGZvciB0cmFja2luZyB0aGVzZSBhbmQg
YXZvaWRpbmcgY2xhc2hlcy4NCj4gDQoNCk1DSFAgaWQgaXMgcmVnaXN0ZXJlZCB3aXRoIFVFRkkg
YW5kIE1DSFAxOTIxIGlzIHRyYWNrZWQgaW50ZXJuYWxseS4NCg0KPiA+ICvCoMKgwqDCoCB7IH0N
Cj4gPiArfTsNCj4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShhY3BpLCBwYWMxOTIxX2FjcGlfbWF0
Y2gpOw0KPiA+IMKgc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIHBhYzE5MjFfZHJpdmVyID0gew0K
PiA+IMKgwqDCoMKgwqAgLmRyaXZlcsKgID0gew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC5uYW1lID0gInBhYzE5MjEiLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5w
bSA9IHBtX3NsZWVwX3B0cigmcGFjMTkyMV9wbV9vcHMpLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC5vZl9tYXRjaF90YWJsZSA9IHBhYzE5MjFfb2ZfbWF0Y2gsDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAuYWNwaV9tYXRjaF90YWJsZSA9IHBhYzE5MjFfYWNwaV9tYXRj
aA0KPiA+IMKgwqDCoMKgwqAgfSwNCj4gPiDCoMKgwqDCoMKgIC5wcm9iZSA9IHBhYzE5MjFfcHJv
YmUsDQo+ID4gwqDCoMKgwqDCoCAuaWRfdGFibGUgPSBwYWMxOTIxX2lkLA0KPiA+IA0KPiA+IGJh
c2UtY29tbWl0OiBmZWM0OTY2ODQzODg2ODU2NDc2NTJhYjQyMTM0NTRmYmFiZGFiMDk5DQo+IA0K
DQo=

