Return-Path: <linux-iio+bounces-27684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50545D1CE7D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A733F300B280
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EE379991;
	Wed, 14 Jan 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="qZ3DOvcQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023119.outbound.protection.outlook.com [52.101.72.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282034E760;
	Wed, 14 Jan 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376384; cv=fail; b=L8ae/pEmpTzYDYXvm4lyvEHOzCOUW659nrkwpoxtSwgC9zOJqX0hRbsOfsh7CnJJq1IKifOkaE2OF5j5zFsLkXu3mnDAy4XfLWTMOrjwymrgYs9tikhb6A55k4d6gGAZ1pon5mvEX7CuurwdsaJ5Lhuw/bqYIjLSPC/I5TghgBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376384; c=relaxed/simple;
	bh=7ZLThZtPaaxLu2TnTG25UEKkdk5PiITGFDwSqL65+gE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdHVkiEMptEhNVU8BPrPrFYpBOJdz7Qqv0tYGR+XhsFeVR3NnxaCgD9316aOxTruobL7DpTLmhaWHEalqliYfvO8dn/GjDpkEtNDqqSWxpH1UlDtWkNLHF/DufUrSS4AGg/3yTb0eMkJdP8AcH3AEKVdOJ+HzN88MQHm02+w3QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=qZ3DOvcQ; arc=fail smtp.client-ip=52.101.72.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojdvIHnsbqU5OnpYYuLVdPzrmVzjspWH8wBOeJ3C8kY3C+erri6D8h9eZvhssKwTHun+xZaPgGjeKchvYDb46pf06M5HNXHegzjLaealpZcKjKJmzTsMV6jOeWow6cDEFWHCUmN/+dQS7BTUbGgf8i6XZpkRNfpPE7WlfEZLlN2aTsPslVGoypovJv/zdhpA8tCLWs1togG/JQoaGaKJbir3Y5S6NCoelCDFeb3V1ESx3sqt9yZH2QLq/12XH4InwQs7MassNvuVn7884zXFFWVxGme16Hg2G1Vr/2dl/HggMA/n/RBi9xI1MOa84xjO6tq4ECNy49QmHjdUj65b+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UohphqXSQ6+CELaD9rzMZmiLz7O+z8eJOYBrEWXJpNA=;
 b=Bl0gqhJEDT8CJ03Fkd4tgVxpVYOWJOvIVmGDbELfzzGB7VFe3ouv8jlRear6626YOJL7KMM/pqvJRSEpxoiu3OQ2jnbajM4ZjG8nCHEn3oxGhGe7dZJAbOrtr7/OmGBPDl0h1qknCnbcN/90pgRJ9eKNmwYaquKHgORw0efvsjJqaCYemDoorSQIQik97VxcyZRry22Mlmk8ReeR+c+BgaZg0OgiMPa3b0rM2Qx3/T20UzC3v45OL75TOIUqYNdplgPRjEDjI2f8UD7SNtOnRF3Dat9sJ94e8E3ArEDBuo72FsHzx6cbp0l5GogXtZ6anJkDElO8UbC1D9GLdb/cFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UohphqXSQ6+CELaD9rzMZmiLz7O+z8eJOYBrEWXJpNA=;
 b=qZ3DOvcQcP+iByO2vUDovfO0N2QC00IILvwE/gwe+Lvk+A08y5WPOuElX99eDuLRzw8OMn7b/TS4+Qgre2vi6wouaZlVOrDIzk9UOfigQ4Dh2QRHwExx1QIbHU5jS2/KAclbimK6/kJlIIzl5FQer6q76gXVKQfPZEJ6TarcRVk6LaSsdgVXA86WEmYpxZyrNNCYIiTO6++3LfE+BjjL9gXvnazwg+05Go/6a7jpqXl3u/41OsbEIKBCktGSzxqG2ws/VIODBufnOfO8sJM4Zb/24Su2RfHO8IfuOuAEJJRIkQVi6eAAkaRJG0Ir0H7JV8bSWzn9z9PVJoZDuTWElg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS8PR06MB7734.eurprd06.prod.outlook.com (2603:10a6:20b:33f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 07:39:36 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 07:39:36 +0000
Message-ID: <1a0adfe1-3847-40c6-ae95-73cd3f41786c@vaisala.com>
Date: Wed, 14 Jan 2026 09:39:32 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v2 2/3] iio: industrialio-backend: support backend
 capabilities
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
 <aWaz2JrwtwwE3dEc@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <aWaz2JrwtwwE3dEc@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::7) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS8PR06MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3b9a16-3721-476e-a576-08de5340110d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REcwQWRzRmdaNSs5bVpLdUMreVdmM25aRmFoemNtaVNVcUV1eDd4ZXF6UnBw?=
 =?utf-8?B?bzFUNm5uOHpIWXZLSmpxbWljeVVveXZFZUJQc0RHTHI2OGZqWkRDUGh3MFdm?=
 =?utf-8?B?OW13T2E0VVJqR2hKeFl4azJJYmhJNjJUMUx2ZHYzdlBROGxmVGowSWo1bVgr?=
 =?utf-8?B?UnJIMy9lRUFrNGtmYmVDTjJmK05JTno0cUZrUU0rSDJDVUVYRFR0TWpmaEgy?=
 =?utf-8?B?QktiNVhsOHkrcmFnZFVVaDFaUzlCb1lUZEVMMFNnSFNNbzQ1SUo3WSsyZkRB?=
 =?utf-8?B?TXlZQ1ErbWc2RjgyMHd5eTBLZlZGSXNDWW1HVTRocTJJaHI3NDRXU1AwOW5Y?=
 =?utf-8?B?MmpxbFZxNmlQb1lnaGovdHpVbGcrbHNMZHpCdnBseVZibjA1UnF6WGR5Uzgx?=
 =?utf-8?B?RHBZWU5mc1BKektOcnBPTXlBSUVmTlZXdm1nanVRYkFuR0w2VlZWSDY4cGU3?=
 =?utf-8?B?VDNySkdLUlRraWNHV2tPdmhOT2ZTdnJHZjhDQUoxeXRITHVyRzJiSWVLYzhU?=
 =?utf-8?B?MHZGNHZFc01JRFRQc3E0bm90dTk0cEVKaUJKb3l6cUNoQzUxYVdCQUtCVHFQ?=
 =?utf-8?B?bCtDSjFscXVQdjBTSDFBOGF1R2ZpbHRTYnc3YWIzVTk4OEZzQnpPODFzVC96?=
 =?utf-8?B?aDVtWUk5RTZITnRzWWV1ZFRNQkc2RWMzV2VaRHk0VmNtSGVJZ2FCc2dMMUlO?=
 =?utf-8?B?VkYrQWZTT2I2UHpXUWFLc3M4aCt0MW91TUZsZ1ZsT0FwbjRQYnIvY2JwdDVv?=
 =?utf-8?B?NWZQNXJzeU9YSEladHZydzhuTk9PbFkzU1V5T09pZHR5TXhjZHo2MkdSWk1T?=
 =?utf-8?B?aUVoUWlWZG5hRXVuaTR0UWtjcDVIQVRaTCs2U1RxOHArQUE0bDRVRlV0Tit6?=
 =?utf-8?B?MnRmSU5NSzVFVHk2NmVlOUo2emE3TWF5MEk4RmJBUWUrSnBBWnVGV1RtbmlR?=
 =?utf-8?B?bmdxZitkeG1SNzBmSjBaNDBxbi90c1JORHBvWkNHVnNSTVNPczJtd0xDS0pV?=
 =?utf-8?B?RDc4MHIxZm03bnUweXZCczZDNnNiTFZQenhnR3ZobjZyMFUzR1NINU13REdS?=
 =?utf-8?B?c2ZLVkpSbGNxMitQYUE3aWJ1dHVWQll2QUpCdWhGVlRJYWVFUGV0NmV6bnFo?=
 =?utf-8?B?N2dORUJCVkQxcGpJeVR3Zm95NmprRWdLQURPVmNpMm15eDJ5dEhrNmRaOTdu?=
 =?utf-8?B?WmNHOC9NS251azVIdjBveW5nRGpqa25wbjJac2dSRmNCQWZYNlBuT1ROem1y?=
 =?utf-8?B?c1BHbm5RbWVieXMxT1UyTm8zYlJZaFZOK1pFdVhOWm5KU1RDU2x1bFR0VThX?=
 =?utf-8?B?amdpajJGRDk5RDZxcVVzQlNOSml6NzJVV3NRK2o3ZldqT3pBbTRjNGJzS2xr?=
 =?utf-8?B?eDhVSGw5TUZGVk1jY3lzM2hnc091UmxnMXR3RXJPVENvdktrc0xHb2ZCc2dM?=
 =?utf-8?B?TGtNd2xTVkdLTWpFWW9nOVgvR1FmYSthTXN0SjRyajJPaHFGVGlUWWhJUm8r?=
 =?utf-8?B?by81dG5tSnprYjZ6cWhGVFhTQy9nSzR1ZUJtbWdnZW0wNlE2Y1BXSGNUWS9a?=
 =?utf-8?B?T09kYkhpNWw5SnVaTjdmQ0FidmY1Uk4yUExtdjhjUktXdG9aYUFtSm1Ud1Zv?=
 =?utf-8?B?ajBPeTNvMUxGYkplZTNQSEdqdjR4anZjdWpIVzVORTVOS0RyVURBQm5xdmd3?=
 =?utf-8?B?S3RRK2VQRjg5VXNxWUpweG5kbjIvbmllN3lrc3lraFZQZFIycHoveC9GQ3NN?=
 =?utf-8?B?SWUxZ1U3OVZscmpOMkIwMXZhaG5QdWJBVS9IeVpaVTI2Zk5lQU5LNnpjSnls?=
 =?utf-8?B?YUF2dXltcHpXSE9WeVZMbmZNZDlWZHo1cTRtU0hGWjJkc0w3OVk4dmhhSmp4?=
 =?utf-8?B?YWRVT0gyTjhlQTMzVmpaU0R4VzZmR0FORklXeHNSNDZoZkJuZWx1TjBSUjM1?=
 =?utf-8?Q?qBtDIE3txuS1TitedFk202uCP+XLycIr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTExdWZ5SmpZV09pMEdsNUhzby9QZ1dMMUJiUG9uNEFhVG5ZZHRtTFdMQUpF?=
 =?utf-8?B?dFo2bmw1OTQ4QTBtZmpQdERBV0t4K3g4NlhJOXllTGZ3UTAxa1JtZlo4QVZv?=
 =?utf-8?B?dlJXNFN5TlBnWHdwNFpHaEIrcnBESWQybzJ0YkFZOFNJSENPVmd4WlZKSGNO?=
 =?utf-8?B?TFpGa2xjL1JrREdsRUVsT0h3VXNLRVppc0ZCYlNiZGM5enZZVFdQVEhoKzIr?=
 =?utf-8?B?Qmc0TVNtbk1qc0loeTZrMFN2bkp4Y0pGTkhsTVhQemhPb25sN0tSNjFoSlNP?=
 =?utf-8?B?R2pCK3ZScUJRQ3F5M1VMaWtuSTNVN0xzbk1Pci9aTDNLcHAvclpZeDNpSDUz?=
 =?utf-8?B?VDBsSWJBZi9mb2owdzd6dDcxaGVVR0RGNWFlUlpXdFdSQVFnNUtvenBQZElI?=
 =?utf-8?B?YkVJdFFsWVYwTFdYeUErWDkra0gwNWowSVpPTXIrUU91TTJHUjRuNkRGV0RL?=
 =?utf-8?B?cEJZNGxQVlNmeVB5bml6eU9DYUJJU00wTlZ3ZklMYzNKODZQQkN1eXROZ3BG?=
 =?utf-8?B?ME1JaGpuT24xZzJOVGU1STlraFluMGNjRS9jbXRnRDBqYXNTb0xjeWEyZjd0?=
 =?utf-8?B?eXB2bFIrbnFyZU5EWE9ZMEtibDd4UWl6TFQ0SXNYKzRuNkhqOTBweVp1d3Jx?=
 =?utf-8?B?Wm93dk9mYWhlellUdnluakFNU3JFeDVYR3JBZm1hMmR1SG1VdThicVdHeDBj?=
 =?utf-8?B?aml4QTVsNWxydGwwdnowMlhWWTdLelh6LzlQYWZCUlRsT1VjV050TDRwclFK?=
 =?utf-8?B?VkkyYVpsaFIxTXNwT0ZnazRTb3BOSGM0RGY1elJaaWJ0MDBqNThyZVdxOTR0?=
 =?utf-8?B?bkxxLzZ5RVNmOG11N3UvcytXMGFIeFV0REppbDIycjRoL3NIaXlnclpldE95?=
 =?utf-8?B?YzV3MVoxK2VaZlNYSDlXSGswaEVncWE4Q3k4N3I2OXZ5TTZWTXpkZER4RXFP?=
 =?utf-8?B?cVhkK2Voc293bGc5S2tnMVZveW1YVWhUR3puTktab1B1Qng0VWdoSXh5T0I5?=
 =?utf-8?B?ME5UcFJpVkNNbVdiQnRneGlTeHJ0UUtuQloxOXhJRGxEbFZlNC9Xdy9NZ0VP?=
 =?utf-8?B?YVRGeFU3VWZFbFcraDJYREZZSGZ1WDYzL3p5SDFTT01tZXBMRzBMUXZJbGtp?=
 =?utf-8?B?bUYwbkY1d1ZYZzYxK1hDcjRYTWNoc3FFTVlpbHRpWFRYSHFsNXlpZk1mZ01J?=
 =?utf-8?B?UGV0WW5uUjRZRUFLSWNPMVQwRHZ2WklKYkdrMjZtOGQ2dEkwV0FldGdvRkgy?=
 =?utf-8?B?NzJKeUdxVGFLSXBxZzlwWTRNTHIrZ2VBQ3FjeVpOMys4TDErVVd3MGcxYmM4?=
 =?utf-8?B?djhUTk0zby9Zd2VlM3dDTUoyblBublpHeXRXVVB6a3lDRVJCZ21ScXE3UU00?=
 =?utf-8?B?OTNDcG5XSjh0TjVoc2VGNXErZzFYWWdOLzNva3F6SGF0SzRwY201cmh4YkYr?=
 =?utf-8?B?WkFENlNpaUszVzNTZHp6ekVkcmN1Z0NnYWFoemRKNEZwcWZiZFFlVXlXVUwr?=
 =?utf-8?B?Zm9Ddy9NTDQ2ZDljcWw0cGpvK2JUQmRhcm00YWdVbUNlYnhPQ3p3TDhtYysw?=
 =?utf-8?B?akRLbkw1VytRckV3S3pCYzNYbVRmRS95MFhpbzEwcHlIdFlCdFVjZWI0V0xP?=
 =?utf-8?B?Q2N6WG5PcHpiWTU2NnN2ME1HaFdoUWpZN2tOYVlUNlFaMzlGeDRqcEVzV3Vw?=
 =?utf-8?B?Tk85ZDZqUEN6bkYwRW9tQk9EeGZINVY0QVpEOFpzeFM2K2NiVHBmbXhiNnJR?=
 =?utf-8?B?NEt3WEZUSDdmVmlKQ3NKdVBwNTl2UkNnYU9sNXdpYldzY0s2OU5hZFk2Z3Rk?=
 =?utf-8?B?YURYanZPNEFGNUJob1E1dnIxeENUSjRMcFFmNTFvSmtuYjc0Z3RpSnd1Mytw?=
 =?utf-8?B?TVVvMFZtMVpWVGV6R3JreEtmMlUvaFZNVUg5TE5LM3NCQUdSb0xvak42STE4?=
 =?utf-8?B?QjVkRy9SQ20vSTYwQm96dE5pc0ppdnA1ZUZ0ZWVmT053Zjl0UmkvVERESDVQ?=
 =?utf-8?B?dlhVWGpSS3pCeWttaitTbmZ4WXFGVTFUU3BHTXZpd3pESllocVkvZnJQbVBU?=
 =?utf-8?B?NU5JRmRieHRIQWFqR2xWYXVjZGFrcFdxUlpEM0w4Vy9udFBJVk1rTUpHOW5s?=
 =?utf-8?B?NTkvakJnU0pyYjZrUHlSaW9YRlhHMCtTakJZa09jMncxMzI5ZENxazJWVzdO?=
 =?utf-8?B?b0FOeW9CVHo2UnY0Y2s4TUdLT3E1ZmpwQTVON2lCMG5IcVJmUktESnNmbTBx?=
 =?utf-8?B?MVdac253ZS9LaTJ4NERrclNKS25EeFY3OHpBbC8rUmExUUtjdHF1WnNpTlFM?=
 =?utf-8?B?QWRIRnlXOHFvSjg5Y0kwSzQxdEJaUWNiMmdFVEV6bklVOVFMZFVlTVhrMzVN?=
 =?utf-8?Q?7+TXyOq7s+Ky/Fk0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3b9a16-3721-476e-a576-08de5340110d
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:39:36.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+8bEZxeSwxKR4CuiLap3oQvMzenGBMOTpBQbS+3TSdlMYAL2x7IdM+G7NW6xydmXDMAYDaEsBf4pwC75Lle/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7734

Hi,

On 13/01/2026 23:06, Andy Shevchenko wrote:
> On Tue, Jan 13, 2026 at 12:12:48PM +0000, Tomas Melin wrote:
>> Not all backends support the full set of capabilities provided by the
>> industrialio-backend framework. Capability bits can be used in frontends
>> and backends for checking for a certain feature set, or if using
>> related functions can be expected to fail.
>>
>> Capability bits should be set by a compatible backend and provided when
>> registering the backend.
> 
> ...
> 
>> struct iio_backend {
> 
>>  	u8 idx;
>> +	u32 caps;
> 
> Please, run `pahole` to see if there is a better place for a new member.
> (I bet there is.)
Indeed, there seems to be. Thanks for the suggestion, will update.

> 
>>  };
> 
> ...
> 
>> +enum iio_backend_capabilities {
>> +	IIO_BACKEND_CAP_TEST_PATTERNS = BIT(0),
>> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
>> +	IIO_BACKEND_CAP_CALIBRATION = BIT(2)
> 
> Add trailing comma, it will allow to avoid unneeded churn in the future.
Sounds good, was just following existing style.

Thanks,
Tomas


> 
>> +};
> 
> 


