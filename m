Return-Path: <linux-iio+bounces-26660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D4C9E0B0
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 504864E0725
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881929B778;
	Wed,  3 Dec 2025 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hjHwwSzO"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022131.outbound.protection.outlook.com [52.101.66.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A98405C;
	Wed,  3 Dec 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764746921; cv=fail; b=dgI+HeOrd5Nn7c6MUkzzaQ3XSZ9svg1QspfqbuClu9nrbYZBI99D0K3DcTEQpgSPaDevXdvRjxs1rIJxtkQy3faRf16vV1IzxYypMcp3QJ0ORoQuxzExtsuPieT2Y2BYz7TKnqKxFUl2XykCAzd8V4S/atssdfV92mi74mxrw9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764746921; c=relaxed/simple;
	bh=9NL5n7quP5MV1+FPqH0DTeqtQPwHJ4U6xAjNaPw1+I4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oo6TLZ3r+JlI+bI5KCn/n9FSA3aAB3zJ7+9ijAf9l2VZkK34J0v6rrwIX7GQbGR5FesezgnWuKP4wp54atOqEeNBnDg9GV5zqszuHMDbW2p+n39V3bChDWMVsD9KGCzU7esV2hlOj2AJJmnuqw+A5+b0/M/z96+RqLyF/p62054=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hjHwwSzO; arc=fail smtp.client-ip=52.101.66.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E27rppcOD7udEWJTPkH4bCZx8vrrvicHj+WM0bZOoH24GZfyYyarPFsWBrWxutedqR+whrS6F/CErL3wjJ6+Eo3Wtqc4HZPshVwTo5gqjBjSwH/uh2ZCGSwKZ6TV+slgJx6DdzI75iAKzUe8hz/GIbNISmczX6T+9Eaa6CRgyNj91gevh4koBNDiKfA0/cmyKKlwS3xce80Vo9vXK7XGtOEm31YJeEDMlDzpPKUKuQNqLa/rWL5KteYzg9EF2Xy/kDgHf/gLxN7gV2k6wfgdP4Q6vF9ujiSbEc9WP+x3ZOa4WSbNl73CzaeB1t7Ok7M4tbufPViKxxo/u5/j9ePzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+rsCktXD6/zKd7yXS7EoJJKJ6ROZPB1d1L+LUC8aGc=;
 b=Mb0r9jg2GntJ4qJvWbjmK87QAISydTc5ECwQ3MwwkpEbzDQOzicXS16MOiwWDpdZaU1I1uKy+5JgTJnt8Cf68cp6ziNNXIQPDLhEP0cjecRaIPcuEiSevlY6mubBmqlfxANlIGYcKp2E0Jg05zxVAYP/GUokHCznRji7J0JzJvYPoZgIRf1FUsyRVR19Y4if+u+c0lcJOlXkjIo6E2oHGO9KWUx8RkoAoMevjG8W5iy//jgiBAGoXVmlvA708eRIedKyG4PVsRvV3aYnPbjzU771KNmcRV2hTelhUMM19lnyoGholtc1zH7kwhYN1+keo5cOYM92BbNNzP9QQt4C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+rsCktXD6/zKd7yXS7EoJJKJ6ROZPB1d1L+LUC8aGc=;
 b=hjHwwSzO8ATD3dKE5E5h1hlP81eKCmVFaMfVbfZevCxEmwro1ucdOAbLqvP0q32TX1VZ0OHfFukh5xye2qVAIDabTt4s81vLUDhv1CVc+P2EehzuGdo5wZxRdU36whzoy0kSXfnjS9j4yQ+ydRhtN1EPw4Co7CcYseThcfY+vQ5i35pqZaK37iMMcCygXaO2JnnA820uf/ifhYLKbmHmVAlxPRAkqAVUM506h4KdZdUoI2ot6FebUdMlP1Iptqig+e1drp5E2tR7a3XqCpyy5agwFblsnC8BQ6F3CDb1gT2XfHS8kNR/qfZTBoNzT1PBONW2Nfj6IItAJzmwNX1vig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA1PR06MB10092.eurprd06.prod.outlook.com (2603:10a6:102:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 07:28:32 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 07:28:32 +0000
Message-ID: <4a64c388-f141-4998-96e0-f6840d70f139@vaisala.com>
Date: Wed, 3 Dec 2025 09:28:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
From: Tomas Melin <tomas.melin@vaisala.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
 <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
 <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
Content-Language: en-US
In-Reply-To: <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00007A84.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::616) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA1PR06MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f790346-e172-4353-d953-08de323d9026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVB6ZjAvdWQwT0ExOHdYOElRMGNLelZlOXJaV0N3L1B2RC84eWdsNHBYNkNU?=
 =?utf-8?B?M0syZ1ZzTi8wb29JUllIeFVKOVg5czdCSVppRDJSV2lPb0hUSE9BNFNOakhq?=
 =?utf-8?B?SkhZWXpSdS83clphaWhRaFRrMUNlYVVHOSs1b1hMYSt4Wm9DVS8ybGlYMmtV?=
 =?utf-8?B?djNjNXRPUkdPQ2xUd3BLZ2dYVldxa3FEZzdNTzI0c2phWmp2V2NBNS9MWUNi?=
 =?utf-8?B?T3d0T1Yvdm5oOVhFcEl3b2FRMzVMcE4vcDZub1BpMmFjdU9wN1QyUnBiVTJo?=
 =?utf-8?B?djluV1RoaEc0SjBBVkZQTk5nWmQvL0U4MTRIWU5Lb0FELzdRSVFBaTI0TFJL?=
 =?utf-8?B?RkZYU1M5Q1kvYmM1S2NDUVdra2hOYjBHOGNHcVMrMmZsd0RsK1FodEEyWUZB?=
 =?utf-8?B?NEs0SEcvVk50dkFLVjBJRWNhb3FrdHdZSzVxV1Y4NTVWTzJvUENWdCtRY3hL?=
 =?utf-8?B?d1ZyVlZDaDkydWI3Z0E4c3BudFZldVcxMEJpR3NlVzQveG9nTE96cTdFbGlq?=
 =?utf-8?B?aU9kQlJ2WWVsSnBFMTVHWDhHT1pGdWk2ZUh1bXBCcWhHMkJNamtVQkhIbkdn?=
 =?utf-8?B?OHcrR0tjbzFGeXhER09mN29MbEs2OWYvUTd2TFlyT29DYUk3VHFwUXlPYnVT?=
 =?utf-8?B?VHR4bUxyaDlxV2lBNnZ1ZEdQSFFUdE9aS043RUthWTdZaWRqRGNYVjNCT0xT?=
 =?utf-8?B?R2FKWHJpaHN4SncxZDI5b2hOSjZ5dlR1a2hvTVJHSFZhTGZvNWU1czd6RVli?=
 =?utf-8?B?MWc0bHpTYVJkT0FTY0wwc0QrUmdGdXhERFpjUkJweXB1b2VsQ1NTYk50amdB?=
 =?utf-8?B?NTFZUkdRTVl1RVlCUUNUSTFDTGhMV05ZTVIvYUQ3UnpFMW51Q3hJOWJtQnVV?=
 =?utf-8?B?MmNEdVhFcmtaNTZSZzNmc1lLaFBiVEN4ODEzY1ZPOWlDU0pDSE5NclpNRDRD?=
 =?utf-8?B?TlZxdU9XaGRWekIrUHZWcDdNSVJRTjdndHk2SjlIOFNBdW5mWFphWjBIbDEy?=
 =?utf-8?B?OXUvZktscHFFZitWNVNGL2MzbzUvWU1Yd3ZWVXZvL3Y5MkUxUXlEazJIK3VE?=
 =?utf-8?B?US9ZVWhNYnZvb3NCVUwxd1FVUzZxUnd1WDA4eWJnVmJvTmcvSEF1Uks4STM2?=
 =?utf-8?B?QVlQOWJxblBGR2YwMlNpMndwb3ZDZkh3d0lDUmR0ZWJacmQzOC9pQmhZazRm?=
 =?utf-8?B?eVZheXkwaVpESGVZcVd2cjhhK2szNm1uSklPNmxKWXdKSFpaTXlzZ3ZJak5E?=
 =?utf-8?B?Um95aWxEQ0FmM3ZVZ21xcW9YblNpM09iSVBXejVqTEt2TzQ5SHRhMVNuTzlu?=
 =?utf-8?B?bFd3MHMrNDNUbURwTlNQUVo5eUlyVTgrQ3hlZkRmdlNWNWE5bi9MMk5MVTJZ?=
 =?utf-8?B?T3RLMExEZ2gyMHV5Y3VHdnVyVkhpRjhiTGZycjYzZVZJVzMwdmZyNFp1eWh6?=
 =?utf-8?B?aXgrNVhUOHd1Q2xyaGo4Vnl1NFlZUElkd2hnbG1qS0MvU0xGRWZteG1zVEpI?=
 =?utf-8?B?dlltT2dwazZLRTNtWmZqNWVYTXE4K3pSVkpUN0NDeC96VUhoNTJGc1lRU244?=
 =?utf-8?B?RHVKcnpiRjNNUythOTNVQTRtd0JwMWlVbXRtYzNFakxTckV2ZEh4K2lsd3FG?=
 =?utf-8?B?MTNIUXBkbVQzLzdJeXcyUVdObURNRitFYk1vNDJWeDJ5VXlqMWgrckhKOXhB?=
 =?utf-8?B?Y3ByOTM5aHVzbW16UThPdkQzTmwvUEVEQ281U1F6OUt5dklFQjNzSzk4ajFs?=
 =?utf-8?B?QzV2bk5DWTFYQUR4blNWSXV6ZDc1R0QvclExTmhacEdtT2VmL082cGVGTFBa?=
 =?utf-8?B?R1BaSEJEd2xVK1dGYVMzakkrbHB3Q2lSeW9nL042VE91ajhuMmdOK2RzUWJS?=
 =?utf-8?B?VjFqVXd5MHpEVnk1V0VMRG9tZmtURjBkeFZCVldKaDRQTlVCdkFsY1BTWm55?=
 =?utf-8?Q?Ki+JccNsCTgvJH2zy/kCp1RhFCSlpQUU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWp3Q1dXRHVsMzBRYXB5aVVObzRsVXc0NVNzekdyR01VZmpkWDR1Y05wL3ds?=
 =?utf-8?B?RkxyMUtpQmp2S2lrUW93YWxQampkbFg5UHBzTi95TW9VZjFGRFFpdllQOUky?=
 =?utf-8?B?bWs3TFRvRlB2cWYxOGUxN1ZSY3ZhR0YvNXNMckNKMTNCNlRpTmRyS3pjWkNW?=
 =?utf-8?B?NHdTWHhWRUUyOG50SUE0QjR3VE90UlJaUGZjSDlIcWZrU1BsQmFKbkxyZzBR?=
 =?utf-8?B?RGVGeVZRSVkvdURtNW1XNVZCRjhuOG9BYmxVVmV6anlTVWxRcnJvN2JoVEVG?=
 =?utf-8?B?c0xXVHhBVm05aUJwU3VhMVlocVdYL3hZN21GaXh6WkNQMk1sT0xQbFh3U0lC?=
 =?utf-8?B?aGJsOVBDSUNBdjg3LzVrTHlldFRPRjZyNjVKMlo5bTh2Yy9Ub2tuZUpLNW0w?=
 =?utf-8?B?VmtFRTkyYSs3b1RzOFl5NHVaR0Vld0lJOUExMCs1MzJQbU5UcFdIcVhjNFhX?=
 =?utf-8?B?VXBVNTdvazZVRHE3TDNTa3N1TGNIQTh0bGNSK05Kb0V4S1VwSThRc2VEQ29E?=
 =?utf-8?B?dWx6YXIxWG1QM3lNM1g2ZTByMzZRZlVMOEh3clZCSVlUdldMNHF0L2RjYVR2?=
 =?utf-8?B?eW1nN2d5VmdQcDdxNTNLQlZkUk9qcEdES092QTdrdTdDODgycVFyTjJzRlpt?=
 =?utf-8?B?SWUzd3Naek02UDJPZzJPNUNaWlJYZnhTcTRpSTJhUkVWY2xnZkMyY014ajRO?=
 =?utf-8?B?QmROUTRwOXpSd0xjenZQZFpQRXk4TmNodzdWOExqWUFsa0J0MkN0WTVpWjUy?=
 =?utf-8?B?TEdSYXo3c0ZhVGppQ1RGanFCWlFBQ1RiNXhFczYrNnZzNlhpN1ZrcndWTXpT?=
 =?utf-8?B?Y2FQVjAxc0Y4OHFQeVNPUElyMHNpWjJiWndTeFhOYnJMRUxDSXhEZmN0aVpX?=
 =?utf-8?B?U0ZXVUFzbnpqTTh2Um5nWHc0T1lFZWVHU3dpNGx1ZnJqZHExbWZnaGNha3dk?=
 =?utf-8?B?b1Zla0hFU1lYaE5hYnJ0MzRucC8xNU1Kbld2dzI5cnBVWFZBNnZ4bThQRVNk?=
 =?utf-8?B?VWxvSndPbEtZYUdZU295MWVCU1BueTN4QXoyd2Z6bHNEeXV1S3A4b3RJVVlp?=
 =?utf-8?B?ejRIbEY4UWxYZFZZeEdmeEU2WGNnWEU3eEtuZzBOaXM3R0FiVzgxbVZFUkRq?=
 =?utf-8?B?L0lYK2RTd1M3MkRTN0FhVGVpSXFuOWRGT1oyNVRDTXdCdmJNc0ludmtMOHpu?=
 =?utf-8?B?U0pKQ1c4MTNPVmlLNWlMdk5RRFBMTWlJcUNwdDVUdXNjSEtRQ0tiR0NjM1lh?=
 =?utf-8?B?U3R1VW5KNGR6eElYWnJRT0svUlU5bHlpRWNoNGk5UVV6VTZrTGExNkxwNDZx?=
 =?utf-8?B?ZEpoSmtBSFB6RXhFNUxMZXVDZTZSY1MxaDlKM0FxM0c1ZXQ3MmhKOWhFbUpI?=
 =?utf-8?B?Ti9MYVpFWVdJclNKTHVteSt4aC9pbEI0YzI3OTE5c3F2bkZGM3BpaDBHOTVu?=
 =?utf-8?B?UEF4bFE0M0RzQm5Wb3lKNEk5SU5yNGtabU9mWitoVHp6K0NwVmJWZ0lreFFQ?=
 =?utf-8?B?TXhVZiszbUYyTzB0WVdERzZDdkV6N1FGR21WQjRMRkNyZ21BQ0pvTFJJcURo?=
 =?utf-8?B?dnYzQUhmZElLbXVZV2swNytxVEN0bG1PdlpVVEwvTmNqMjc5NElpTFB0VU8x?=
 =?utf-8?B?NGI1RmtCTnFKbUlhV3hPOHFNSXVaV29EK2R0MGJXSVJhdzlmTkRweWtBbEZD?=
 =?utf-8?B?M24yZmFCNTFKMnE0eFg4Nk9sSW1GN3R6UEpsNXBPYkpZRzdSdkN5VFpoVzBw?=
 =?utf-8?B?REpEMXFHRExZYlkyWFcxWStKd0xhdlNOZ1RSbGlqN3JOZ1hLM2tzNDl6RUMx?=
 =?utf-8?B?aXMwRGtaZk1qK0o0T0JvYmtRL3RUVW44UWhoM2ZqVzVibUpFUHJEVmo4L1Bk?=
 =?utf-8?B?K3VkSE5kZkRtSkIyQWRQOXBaQS9UZkJaL01TVDI1STM0b2FsVVhseXRWVmo1?=
 =?utf-8?B?RVFJUEh6ek9vdkhkMFNjN1dDdGZzbEw5TmdJV25udXE3NndPajU0dE0xVTdT?=
 =?utf-8?B?L2Z6NjY4MXU5ZVJFbWlkVURKWm1SMU4yOGxtRVBJa0RucmVESUZlNUcwbm9a?=
 =?utf-8?B?Q0UwdFY2TXdXbXlxQmZ6U2ZMZlFMbE5HazFmclVFRkxUWldXSjhlUEJyZE5H?=
 =?utf-8?B?OGlqOUYyWWFVcDFhMXpQZ2ROL0czbCtyMnNaRWhSQlVOSGcxU3VXcXpKRDVX?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f790346-e172-4353-d953-08de323d9026
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 07:28:32.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eYo/RUwj6dgZmDqLzyGedM5K3ELzYkLe4meMcXVlbj8x+glCYq0c/35i6U9/GmJvotA7ual6O3ZWSrpXfFPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB10092



On 02/12/2025 17:01, Tomas Melin wrote:
> 
> 
> On 02/12/2025 16:11, Andy Shevchenko wrote:
>> On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:
>>> Support configuring output calibration value. Among the devices
>>> currently supported by this driver, this setting is specific to
>>> ad9434. The offset can be used to calibrate the output against
>>> a known input. The register is called offset, but the procedure
>>> is best mapped internally with calibbias operation.
>>
>> ...
>>
>>>  static const struct iio_chan_spec ad9434_channels[] = {
>>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
>>> +	{
>>> +		.type = IIO_VOLTAGE,
>>> +		.indexed = 1,
>>> +		.channel = 0,
>>> +		.info_mask_shared_by_type =
>>> +		BIT(IIO_CHAN_INFO_SCALE) |
>>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
>>
>> Wrong indentation.
> 
> Can you please provide example of your preferred indentation for this
> particular case? This is used in several places around the code and
> seemed like one of the more readable.

Would this be the preferred indentation?

{
	.type = IIO_VOLTAGE,
	.indexed = 1,
	.channel = 0,
	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |
				    BIT(IIO_CHAN_INFO_CALIBBIAS),
	.info_mask_shared_by_type_available =
		BIT(IIO_CHAN_INFO_SCALE) |
		BIT(IIO_CHAN_INFO_CALIBBIAS),
	.scan_index = 0,
	.scan_type = {
		.sign = 's',
		.realbits = 12,
		.storagebits = 16,
	},
},


BR,
Tomas

> 
>>
>>> +		.info_mask_shared_by_type_available =
>>> +		BIT(IIO_CHAN_INFO_SCALE) |
>>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
>>
>> Ditto.
>>
>>> +		.scan_index = 0,
>>> +		.scan_type = {
>>> +			.sign = 's',
>>> +			.realbits = 12,
>>> +			.storagebits = 16,
>>> +		},
>>> +	},
>>>  };
>>
>> I'm not sure about macro-less approach here, I think that we want more
>> consistency and hence before doing this change probably we want to clean up
>> the existing macro, then split it to two, and add another one here based on
>> the low-level, which was split in the previous clean up.
> 
> As mentioned, this is only needed for a single channel, and since it is
> different than the other, it needs to be separated. Do You think we
> actually need another macro for this?
> 
>>
>> ...
>>
>>> +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
>>> +				AN877_ADC_TRANSFER_SYNC);
>>
>> I would make it one line, despite on being 85 characters long.
>> But it's up to you and maintainers.
> I would like to not fight against checkpatch here.
> 
>>
> 
> 


