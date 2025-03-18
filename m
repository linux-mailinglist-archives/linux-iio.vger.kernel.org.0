Return-Path: <linux-iio+bounces-17013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF6A66D90
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 09:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADED3BA363
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5551F099B;
	Tue, 18 Mar 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TGYYb5Ad"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A51F0987
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285437; cv=fail; b=DFYgISJ+yyYEU+BnGqOsbPzHK/2l4gRuQw8+GXME7LPYRrfBW0dW01gQb+nlAp3c/QV6z4veqZSmqVaj3PuzfZbg9BmYmltYkipei95P2ka/0U8AGeWPHI1T3OlUMCs3wEX+aD4+Bq1waGQOim0ml7oPGODKg51dfdv69WXM9YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285437; c=relaxed/simple;
	bh=obEYNHerISR+I43DHXJH0L5ktUDkGuLM6qhxIzmWmQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sw5lz2MZDTvqyEAHFN9d7jbmJztKxuoclEpiGezTkUHbVzo2NJ3UlMqNhlnrwmCXf6UBdu06vJ5eDCOB7LdYrOaGcsjJriLca7M3piOqhRlxBVauQeA7VghZWVkcERgk31PuiOA0dVVH0Q/rtnQUeLrS9/GU2WxIe6XcbPTkiRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TGYYb5Ad; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qke9yCinksv6MOZXWwSWdVFCwkdA9VeDq9I9ENqlAhOArUEhxVn7hFiFZS/qgxKCaBxS6+4m8h98P/PkhjrdV/epRpjkWjqlFGOvAGDXYgpJHwQ57t7OXp3aYMwYDtvBpbklsv/Y4KZN24uVFTnB1CtmmRk0ePWS258IdUiK6aOEbJmedqd9GhwAt2wwaYE+XbOsJvm0MJS8PNgIcOA8m1lKczgeUMDc5a76vMPYtv/5Hg87PlW+huEPeLcKOEN7pW4L+bttHj4/6oE2bmeegDE2wmAvVALxFbC3WRRQl0peqnLe3Bq96fGXjsGJqbVF7XR1O3YDnjq5GFVzct21oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhSgsw5a/Db2ud8daoOHf0PuKF5QxFT9FWbTus3j4k4=;
 b=EDcY8IBiA8HgBnjIcx6QRA1jFyymH9J8tIXo4A1TXJWZLURwvdxOZw29LyNRru48wtEZGlqqeVBUVIV2JcJChTDSEGv2IwUwUPPnuaFsmp+BJda+H/TFF6XtOdVOuP6w2agq7CW3XhtU2WuQeyPn3WbDW5ij9T5rqgjIc0fQ1vJafFYrdVmsH2b/ux+2i0ajOBaXggzmeNMc728YBpfBPhkkltdbNAZcaUoAoCPwYW2WITw5clqWMhgZo0ERmYcfWnWYB9aM83CiVY9PtskcIZoZ3eQWbRi2Vf512IHBIMthux9VDeI99DzNy4Nj+lSTTxlx1HvF4AAT3RCZ+DLUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhSgsw5a/Db2ud8daoOHf0PuKF5QxFT9FWbTus3j4k4=;
 b=TGYYb5AddfN5ZGbt+7wAFB9ItkB1yxi5qCd5bMuMKgzYMcgtXu9L5xgWSbPAdbsMVRIJUy1PeRhpUWlYrLTYIC2lat/6CS2SeNF7qfvENP3JAa+0r0SiXJVV469Bp9V8auE+5tJMgnuMCBZOTnqid5kOKKOrYKJChN7U2ZWaTRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by DB9PR02MB8371.eurprd02.prod.outlook.com (2603:10a6:10:39a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:10:32 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%2]) with mapi id 15.20.8511.026; Tue, 18 Mar 2025
 08:10:31 +0000
Message-ID: <6366e065-d49d-46d1-9f69-edf7d0966da4@axis.com>
Date: Tue, 18 Mar 2025 09:10:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] iio: light: opt4060: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-10-jic23@kernel.org>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20250309170633.1347476-10-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|DB9PR02MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bc0dff-b026-4092-f268-08dd65f459da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VitpQ3pXYkFWT1lYaFFvYjRJZElzY0NkM1BzbDJiREZ0bHNPTVpmUmc2NXAx?=
 =?utf-8?B?QkJCNTlaM3ZQQm5jclVDZzdYQ2JyZjdtTG5vQlZWZXhOR2UvRnEzMXRFQUlR?=
 =?utf-8?B?ZEh0REhuZ3hsekZXdHNCcDlwWW5ZZWZqVzRpTWloYUxFaS9iQ3JTRVVYMTZE?=
 =?utf-8?B?bmxyWlZ0QjlIaFMrNitTT2VZQWRoMHZuWVJBUHdwb1VXSEZFTTg3dnJSTmdV?=
 =?utf-8?B?c1dieS8vdzN4MjNibGZkYWRiZU5HcW9ndHhTZmVOU01rRUllcmhnZG94eW9L?=
 =?utf-8?B?amJ0V1dKVnkzRk1MalkyQXlJd0ViQ3VFaGtPV3BpR295MTd1R1JudWFxb0FM?=
 =?utf-8?B?TDdoem1oM0hlUVRIUmlaWTdEbW5YWFg5TGcrUSt6YVd5OUJHRDYrVVIvRzQz?=
 =?utf-8?B?ZzFnTkhIZjFlL2xpVWlDR3RrNE5KZTBhVkhRV3FEcSs3MGVnbXlLbCtlaVFo?=
 =?utf-8?B?LythWGJTSXNwckZkVXV5a0RzMkFFRCsyZ2tNcUlzdGNyNnY4eW5kZFRxUDY5?=
 =?utf-8?B?cC96SXEvME5OQ3hGY3MzazBOdEhlc1hFemd3WVRGbUkxbVZtVnRkZGRFSU5p?=
 =?utf-8?B?aUNEeHBxY0tBVHdQREtBcUtjWStYWWc4NWpLSXFId3NvWTE2dzV0Zzljdkpz?=
 =?utf-8?B?M3MxSW5mUVJXaEM5Si9ncnZ0VTJ2eXo4Y0hBK3I1SzFuREVYUXBMbFMyVjBt?=
 =?utf-8?B?WUdtdDgrSElNcGF4Rzk4WE9qSjdVRm1WcTNkcHRFQ1dBVVFCM2VtRG1GSkNR?=
 =?utf-8?B?alRYd3FHalFGSGQrc0Jod3F3WkI0UE80N013Y2tCd09ZclpwRjdscXBsdjg1?=
 =?utf-8?B?RUdNM0lacjZGaTBUQlpBQUhSMi9MTFBUWG5qV1ZQYldOQnN2eitpOXZQNEsv?=
 =?utf-8?B?cTJWbWZQSnBSVVFsaWt4YlVqYUtNSStETFhwQUZBbGJYQzhlSWdIMm8wZjdk?=
 =?utf-8?B?cnZqbGQ5N1JuY1U1eStudTQ4d1l0MXFvTm1hZjl3ajlGRVRVelFaR1gzdWNi?=
 =?utf-8?B?WFVHOGlxUEF4Z1JCdkVoVnBhNWNrSFRYbHRDUUxEN1E3eWpWOXduMjVQdFJF?=
 =?utf-8?B?VFZ5Y1ozYzl3V0ZZSHhsanBDbFJtSFpTZDdvOTlGY1gxSTNvL000R3VGTG5R?=
 =?utf-8?B?cy9WUDR3OTlRL3dob1NaVWMzWnBBQzR1cER3YlJ4cCtmdi9lMUVRZjk0UGtN?=
 =?utf-8?B?UEtEYzhZaElrTnlOWHFkT2RRUm1tNHFHblFGcWpqRnFDb0NPY3psbWRNbWpx?=
 =?utf-8?B?QXcwSEtLRXRyYTRSMDU4N1lqeUx0ai9Ca1ZBclNzM2RaSHlVODVrZ0s1dGZW?=
 =?utf-8?B?bndxbk14Yzl1KzhtS3h2TzRvaE5ta28yWXBhc2tMYk9CUzVZaEtNdWpYUHUw?=
 =?utf-8?B?ME5BYWNCVm9vcmdJNHExMjNXblVYeHdCeC9ZTzRsM2tiK1B3dStDZ3hTRjEx?=
 =?utf-8?B?TlMwV3B3N21mM24reG52U202M0lIQTFCa082N3pPeTJQUmdOM2RsNDRBRjh2?=
 =?utf-8?B?ait0NkNkRUcxOC9HUUkwOUpkUTZXVGdiTTR1anVBendOQW9LdWJjZ0wrOEk4?=
 =?utf-8?B?Q2hENThrdjBhL2phUEMrWlBuZDNjRkt4Z3ZnM2lBWVR0bDlXYUtKZFNDaDBa?=
 =?utf-8?B?U2J1Zk5VdURvUVRxUTcxUFJudUFsWGZrbU5RajFkL3dkT1VGMzB6R0FMTGxu?=
 =?utf-8?B?U1dmV1pxOGIrYTZSNlc5L3BvZG1YSnhZQXVpQkZFc2d4c1RrR2RYYjV5N1cy?=
 =?utf-8?B?RUVmMkVDanVEaTRsUFFjNXdZczlQTUZjcGdvaXZrMHIweDVZSFc2NmlrUXAz?=
 =?utf-8?B?UjdmKzVKUEFQK1RXVm1SZGtidHc5RS9SMytuUERpUmk0enUwcnFHQm1kc1Zy?=
 =?utf-8?Q?33R8SRcIEORZf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjZLRy9BcGY3QlRlZGw0dFhnL1FQZ2VsV1BGd01nKzh1dExPT1k4bXJaeStk?=
 =?utf-8?B?ZVZ2MVBlYXNBQ2hlZ3hpUHBIUjgrMDNiQnNmVXdodDNzK1RtcWQyMlM5QmYv?=
 =?utf-8?B?NjV0Y0xweXZCNTJYNE5LOUVUOTVLcm01QjNMNHNEUU9CNmxoeXE2NDJaNGxi?=
 =?utf-8?B?djZYd2FGSlo3bjY3a2xzK1NiV1V0blpudjNTRG1XSGp1dmdsN295OEVSQTk4?=
 =?utf-8?B?WVNsVlhsN0p1KzdCZlJ6R2ZVcFNTK0ZNWlF5eDlHRDE2bEdmYkdXdzMwanYy?=
 =?utf-8?B?UGtaRDZJMlVoZERHcHhvQ3kwNHE2ZHR3RXNha2NJRDM0Z0NqcnNnR1RkZGNt?=
 =?utf-8?B?OWs2ZzUxMzhJM2p5YnZoM2ZQZHVnZEttWjdmT3pxWi9qYksyU1czQURBeXVV?=
 =?utf-8?B?cEl2ZnRlL0dzOTVuMktuVndQYkJUVU9nS1ZtbU0yUWtNdDNVNThtekY2d2w5?=
 =?utf-8?B?aEZkUHgxckV1Wk5WVkpPMXlrK0U1TWdqcmpJS1padkJmZG5TMFVuTHVtZEoy?=
 =?utf-8?B?WERQSFdGT2FoSExwYU5PanFwWFVwTHM4alloY0tvRlZIb2E1L0RJdFUwUFZL?=
 =?utf-8?B?a1QxRjBCQVpneWJ1dFlxUGR0VTVvV2hZT2xoUGU5SGI1aFhjWnMzOEc4TE1o?=
 =?utf-8?B?MDlBb1FGUWtsdG9pMnQ3RG9penJOUDJJL1BJcUJSeFpwYnRCalZzRS9mMHV0?=
 =?utf-8?B?YmJ1OU5vT3FzQ1R1MHlLM2Fpb25qN0l1QThpejJPSHF1YUM3MWlTTWppb1FP?=
 =?utf-8?B?NVJkbGxlQUp6WkF3UVJzSGNzeHR0Y1l2Nks5aGhES2wvUHgwejhFSTJkN1ZF?=
 =?utf-8?B?djVKV21OaTN6S2pqbGluTSt2RmFLYUlsVDNyaEdwMlFCcnh3YVJTbytrSEc3?=
 =?utf-8?B?RzRITEpVRXN4RjgrUEhvUllSck9SN0R5a0t3aUtOMk54S0dycWY3ZWtlL3pa?=
 =?utf-8?B?Q1pQWHJTQ3JEVGdNM3JKODZYYTNwQzdwRGtPQzVyV2RCbExGbGs1ZkVzOGVw?=
 =?utf-8?B?RjVwZDFFcHd4cXhlY3VCOEJnUmhGaEFkV2hUTUlBMHhvYmNxY3I3NHdjY0FR?=
 =?utf-8?B?bFI2ajdOMTU4dWJzbmluVUxTWlJQam1rMVoyZXF4Y3RjZ1hHQTErc1Z5SCs0?=
 =?utf-8?B?c2FEd0puVXBYSlpOYzB4eS8vbFZRKzNIUC9xN3N6Tm9nZjlkMVVHam5BL21U?=
 =?utf-8?B?d2FvQUlPZmdsVURUck1yMTk0aXJXN1lTZFRUU1EwWDhjZkdOODBLUHhWK2Ni?=
 =?utf-8?B?R3RGZG5VMTI3dTREdHU4SS9rdnQvS2orbDhjWGtYcjNtSHI3Sk5VUmFJeVd6?=
 =?utf-8?B?WnZpYTlJcjVEd1BJZkVMNUxkcTNRdzZob0tiYjJNOTF0M1lRUWpvRW50QjJt?=
 =?utf-8?B?QUV5N3M5eTFkTHF3Vm9SWktXQzl3SDJDVXFrRHlLVHYvZlVIK2JPMWhaaTNV?=
 =?utf-8?B?NDg4TXJMQ2VOck4vcXY0R3VOTHFYUDRCNE11Wm5UdjJCa2ErcE1xeGd0RnZ1?=
 =?utf-8?B?SGtjSDN1bGZabFR2M3dUNWYrbDNON2h0THFwYzZhK3QyL0VtcFl4WVVmcHdB?=
 =?utf-8?B?TVFQbk1PbkdHUjVxeTdCNS80VndzQVpkOTM4c3FGS0dWU2pNT1BwK1hlWkgz?=
 =?utf-8?B?d2M1N0tIQmVzeHJkdWVibVMwb2VjTXg3bUtLWjVLajhxc2Z3bnRoSXlYMWox?=
 =?utf-8?B?K0pkQWJsZXFIdmpoSENncFpSQjhjZTYyN1hBYXVhcnVlblhxWDI4LzJpbEJy?=
 =?utf-8?B?VHN6QlArM2VvWUtmR2xScjVvK1cvSXg2Rm9xOEY1aEJPekk1cW53cGs4Wlk1?=
 =?utf-8?B?WVZac3BUZCtZQUpuTDhRZW1HaWkxQXpGL1VRTXl5N3kvNWpMQ3hadHNhNWV1?=
 =?utf-8?B?U3pYS21NNHFWSERJMTlhMDlLL1FUWjgyOFNFaVh0WE1VelJKYzZzSVpkTHlH?=
 =?utf-8?B?QUpwcElRZkVEb1ZKUCtLTU81anJzZmlVTlBXaVJsZ28vdmh6TERHeU1KOXZx?=
 =?utf-8?B?c1ZZaDdlQ3hTWmNDUWRJU2tiWktvd21zYldjcUhpK1llVFhsNEduODVqNG5W?=
 =?utf-8?B?UDBNaVkvaTFVL2F2M3dCWXdEQWY3Zi9KN1RuK2hWTENrbmtpcTNBMFpEaUpV?=
 =?utf-8?Q?rfI4=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bc0dff-b026-4092-f268-08dd65f459da
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:10:31.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtYpLsX2EFspkr3ab/D89WKk7HyIkgrpMDKhVaxt+rIAAab7oUPKJysdHLDZhdPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8371

On 3/9/25 18:06, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.  This is a case where the code
> is pinning down the mode so also has a claim on buffered mode.
> A follow up set may move those calls over to a sparse friendly
> form as well.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Acked-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Best regards / P-D

