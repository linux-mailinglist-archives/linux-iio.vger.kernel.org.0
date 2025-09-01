Return-Path: <linux-iio+bounces-23574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4AB3E215
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9397189E23F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D063218D4;
	Mon,  1 Sep 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E6MGjysR"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013044.outbound.protection.outlook.com [52.101.127.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6E313E1D;
	Mon,  1 Sep 2025 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727712; cv=fail; b=Jlcjq/uTapbByUF0EmxCZo07dDVW4hvX1uB5xJ1Wr9tayN0K6ARv6smHKRBbMIyU6QYMrfoebPhSoAt+fLTLmP6DJYvl8JqhrYC2Ll8phMc/B5mjMxpkQlnatRF47VjUfgst+NtCf1UAfpTXbEZllV68N9NxIH5PlCP3JFwgHeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727712; c=relaxed/simple;
	bh=h5ZI1NNav4v41Tsl4Wubb18AVO7kA6E2PwDcfyAB8o4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ts/m8OSnVy8VwMsQ0BXIx86ftCBY76sRR5iLjnh1/7rLRku9YE8dij9bu1v5vYahYysupFeC/ylOBedbPG3sVi+Kcvqgfu2e20xI+yo9GM3V6JGIQGTRbFuy3aKnwzR3jmxNKKKZMVojHB9icv230BLkCGV3m9imeqmvaJEJpXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E6MGjysR; arc=fail smtp.client-ip=52.101.127.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdSSdo9jXrjQS7LYX1+ZxKP0W4KPLP7umTUH3iuDROVCA15hqMpLViJauub2sGVSZZANjfGNByw+9YVW8Bj6IiEP37C3hdz9/gmSpyjCH8stFWdy0Ds//2MKZmY+K/IV5xRFJgTe0pFMhMSfwTvB1FJj80EsxycGoENTEsdGZ5K/y0bLdZ17C48b5p3Rt/AcKJ9WDsZMxbwWHGrXhtAZeF6z23ysoS/t5kxlshg2ei5qHK4MLCLu+PoL0upzIzE+x9DG9tx8+1T109+GCSrZpq0ZrBkmAiTBGUqhi26pJWEPbYZLi+wZ4ShM3KQuo5cm7bs0ie94QWw2hiSGxv7kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5ZI1NNav4v41Tsl4Wubb18AVO7kA6E2PwDcfyAB8o4=;
 b=qYWcIcUoWDFUq1mIZh/Pq4JCz206njcxoNW/DTAAj8sqjtyF6UGQw//6vzBELcPyD752tkAqunXcL76iE7nNnQ9DIe9Y9dytLeGz/621eDtL6ajUauWS9B9Y5MwqOiXwBrr//7tIZtBYx67jMo23XGkUEAC6QA4dFPTzDYU4o9Xh+ZBM5SZEmkbvUYKsE6AeZ21kR/RW8Nz5z7jPzdBHZJZvSp+sf7lu63N+Hc80SxbCzpcUhL0fccBZXFGQZ0JB2nZDKj4rmRqqUeiB9iiOPpOE8OticXX22y7ULY1q+BCF+TkVvSVEOneGlYvqx36HsDFjfIl52jQ+F5yY23eU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5ZI1NNav4v41Tsl4Wubb18AVO7kA6E2PwDcfyAB8o4=;
 b=E6MGjysRPkVRaobVujSY+FBTyl+3JdbF0ZtL6JkhrGAMKz/DbsELDrV5jXW9sOXFOIJzs2PXWToqExeNTIo6DjvPA+6y9QFCqudxGTc3Hq519eUnNLi3JoGMx4aqM0fDgeK3PmvFj9tcJuK8XN4ZH/7zqKYufKvjs2dLCsDX6+pdkYCUFEF9YaTp91+BoIgBH1Zm8HE47sfIQ8IudNcbxQqufAq2Rdu0YzZjtNRpD6PvyD2wbGbqYpQ0d/JiPpH4J+dGNHlxMqlSo/yLunG5Xi/fB2Y72GmIVfQGzvh+zg0s3hV4ysEWVlHL7zTdIVSUrJdfmOEcApYZLS8n2A822A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SE3PR06MB8105.apcprd06.prod.outlook.com (2603:1096:101:2e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:55:08 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:55:08 +0000
Message-ID: <7a775ae7-5925-4d64-a030-eeaa9d5809c9@vivo.com>
Date: Mon, 1 Sep 2025 19:55:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: use int instead of u32 to store error codes
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826101825.248167-1-rongqianfeng@vivo.com>
 <20250831162746.7dab74c2@jic23-huawei>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250831162746.7dab74c2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SE3PR06MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: b21782a5-3bad-4683-94d5-08dde94e65b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWRTU2ZNT3ppMjI2MVNUMGthWk43UEhFaTJNUk1uY2I0c014VkhIMDlndjB1?=
 =?utf-8?B?RDlLQ2tMUVQyWkllb1A4dWIwS2NJRW4wZldLZ3pKODRzMlhVMXJScGhBKzZl?=
 =?utf-8?B?cGNsREViaktXd0NUWHRRcHlicjZRL1pIVlFVaW9XSUFaaWdPVSttTjRMaXhj?=
 =?utf-8?B?Y3FxTDdzaFF4Z2Z5Y3lPcTBQRk1KR2REaCs1UmQ1cDRjcUVTejJjc0R4bmdt?=
 =?utf-8?B?SFJMVjFKQ0ZSbXplbkxsT2lNb2VnM1h4Ujlrekw3M3pWYndwdEN1c25rQlNm?=
 =?utf-8?B?NzUzenhrZ0pjVnlhdmd3QTFEUHhiRmNjeGNoMkJiby9yZ2h4aVVHWEtKcVRy?=
 =?utf-8?B?ZU1HS3BWWUc1aGRvWGFmWWlHb0FqZzZkTVFKWUcwRHNxNFpZeHoyajhXNDFn?=
 =?utf-8?B?OWg5RGFnTnhYVnhhMVcvM29YK3dFWG9YbVY3QkJFOEJyU3N1YUlOTDVJWmhj?=
 =?utf-8?B?Wk1PKzdwOGRZRzdwNnZCY1hMWXc5aWp5Q0FUbFJWWWtlaWdEcWNyQ0FDbFg2?=
 =?utf-8?B?ZGJzZzk5MUd0R2t2N0tsMXA3SE14TVMxeXZkdFRScGJuWjUvdTRaK1lrOGdO?=
 =?utf-8?B?NHdrVjEzMVI5cUNld3huNmQ1emZ2RUhGbWFjWFNkVDh1dTZ1MVZXWVpGYXMz?=
 =?utf-8?B?Z0pkQTRHVSswSVFudWlYYlZnNnJSTmFCY1IzcHZNUGpUdExTVVpKMExucGtT?=
 =?utf-8?B?Zi84OVczZDdFMXNnNDFxaGdEMllmaE40eTcwZWp5Qk9BQnpzYzVXYllwNG9Y?=
 =?utf-8?B?RkFOR3ZmNVFvemovdk1kNUxtWmtMSTI0SUhqQkNpaS9CTk5ZWUFmRHhodU0y?=
 =?utf-8?B?YWNpSjNLdDVhMVZqSEZmZlZEczdjMUhuajRFalRMcU5ZV1Z6a3J2bVB6TGVY?=
 =?utf-8?B?TEVWSDJHUEhxM2hDQ3prVWRRam1WTGdqTXVlRk1uVDM1MlpzUkk5clRHNUxr?=
 =?utf-8?B?dkFTcmxaU01LT3lYNis1T1IxbkRJdi9YbGIrOVZxdE44dGd1V0pmL2JiWlkw?=
 =?utf-8?B?RCtNbVpEREpmdTNxREhqWEtKdDhsNU1kekFueS9JWU1kTE9obW1GS2dJbmFT?=
 =?utf-8?B?SDFEREdVczF4b2xSc0lzekllNjlYeGk2dEkrR0tPNEYrYVh2OWZ3clJUbE1M?=
 =?utf-8?B?bFdzOUpOTG5GQ2Z2ejBFbHJncytzL2d2b3FrWHVYOVVGSjh3cHVzL3F3S0Ja?=
 =?utf-8?B?NFp0NUlYVldxVkVLbDBnam80WjZZQmdtVU1ZSlQvbmlTcVkzL05EUGkvTXZx?=
 =?utf-8?B?WmF2Z1RFYnFNNW1JWlZCOVpLQWpUZWlvV21NWm9vRzlGS1owTURIMU1mQ2Fz?=
 =?utf-8?B?ZjZDdmFWNUk5QXh0dVpHcWxRRCt6andnakxZSEV3d3Nnd05Eb1YvellWVUlo?=
 =?utf-8?B?a3RZMzVRdldubnpyMVloZkVEbXptYTczbjhJS0pwWmVwVDg0bk5FLzB1NmhU?=
 =?utf-8?B?VWdyZW5OME85RUZTM1BHbnNvbDI5Mk9CUnlVTWp4VmRlSyt0S3JDTDhYT3d5?=
 =?utf-8?B?QmxhaFBYTFljZUN2eTNsQXdLY2lEMzRid3NuUHp3a1d6L1lwUmtGRkFtdDhH?=
 =?utf-8?B?ZHhZbS9ESjVHS3hwRm9wZmtaZjhLZUJuSEpab29YTng4dURyQmFMRFF4clNX?=
 =?utf-8?B?UHdlOFU0Si9xTThvcGU5VFZ5TFdCRzI0aWxVUUVqRzJzY21NS210amVNVW56?=
 =?utf-8?B?UkxWb0gxK1FVNHF3bzM4OFEyL05YSFU3UWZmeGpCc1F3QVNlRi9tM3kwd3l4?=
 =?utf-8?B?ZlJ1WDVxMEQxc0pteit4NGJnY1FiQW1zNUcwTzg0MmhmbVI4YUw2YnpsMGVj?=
 =?utf-8?B?TGZVYjdrWlVNdGJBQ3NGeTIzZzNrdko4dlpIcDdJODR4T3RpdExKQzc5Wi9H?=
 =?utf-8?B?NnBqcGRYdWswVm5pVW1IRUlEQXp1T3EyZllhN1k4THR5SmdQS0Y4K3dpNlNh?=
 =?utf-8?Q?SAF0vuHL7+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0sxMXRVUEFuZjU5ZWFMaXRyQzZKRCt2RGR0Y2svUzNNQ0J2ZzFXZlZyVHBx?=
 =?utf-8?B?eFF2a1dnU1RkZEQ2UG9OemVTYk1ESENVN3poM2dLb0drVjY1YmZ0WWhLYjY2?=
 =?utf-8?B?QXpad1Y4enhEcklTYTg1R20zeGZvZUk4TE1zOUpsak5hMm9IcWpEY0NuVTBI?=
 =?utf-8?B?UGgwc2dFbytBSFk5QWczNDB2RnNqbEludHEycWRFWWo1ZlhaMHlZdEllY25t?=
 =?utf-8?B?cGV5M2hSbkVRSHhhUCswT3ZlM0VpMUtPVzNkRDZiQ2FXNXYvZ2JhR0Vhbk1B?=
 =?utf-8?B?ME11alloMmRucUFpN05UbzZseDVwOXNBU0RuNlgxaTA3SHQ0dTlZWFVmYlh0?=
 =?utf-8?B?NFJCUEEvYVhCVkUrSytJaFhJZG11Kys4VnkxejhlcjNWZXhZbkFBQldMY09V?=
 =?utf-8?B?bXIzU3BIdk5wQ0hOMzRnK28wVUJJV0toTERRaFlCTjhYVDMwbFRlR0pBRTkz?=
 =?utf-8?B?enIwaE1ML1dCN0o4cTZuVGhtTmdJZ28vczloM2kraE5pc1Rqd2dSTXJQbjdU?=
 =?utf-8?B?ZGdyS3JncFVXdTgxQXpyVUhzcjVxcHN5VEZiMDZNNUZ6SmJpclUreTlkdTlZ?=
 =?utf-8?B?RkFXOWFqeno1VjVWeDRUdHh4RVAwWkdXWmZXcGRxbHFRN294UmdXZVNRWWJV?=
 =?utf-8?B?RHVSVzNpMWZRZ3N4ckVxTlpBUG5ObXZ6bzVmWDVWWmlxSFozS3FQRkNFaUk2?=
 =?utf-8?B?cWowZEZWRUJRNEVTTmVXTDB5OHFPOXUrdFVYNDJ5TW5BT0pHZTcvdTRtQmQx?=
 =?utf-8?B?S2lCOWNJMFhMVTBtRllTNWYwQTFmSTVRNHI1ZUJIa3JPdEpYeWpqeDl1MWV6?=
 =?utf-8?B?R2QxTTVOVkhYeDNYTXFEZXFSL0dQREJ6QmdNc1dDdHMwSHoxUmNUR2p6dWZh?=
 =?utf-8?B?WW5YRWNaMUZoVGdYVVFrL0VGeTNPdVhQeUpxUUYwUUhYaHRyOFZKSGRibm5F?=
 =?utf-8?B?TmFOakorRFBHYmE4Ty9Td1V2eEZTNUQ4SmF3Q3pQWUNWWjEzaWNWT3NhZElH?=
 =?utf-8?B?eWpFZVI4NXM1SFk5UENrZHRYWnNwNmQ4ZUZET0grUks1dSsyWCs4U1B5SUtW?=
 =?utf-8?B?MHFOa25YUjg1bGpvYzFwckdQN0FEUVRNWE1kc2VOOEpLbTRXbGV1RU9GVTRu?=
 =?utf-8?B?djEralM3VjkxK1pHcEZlVk9MaVBGWjc0L2crNWZaWXhJNGhJTWtyNmhNa2dV?=
 =?utf-8?B?QmFLL09vaWlsSHhtWXFHR0pBQjRLRjhSeGNkbjdYV2FHVEJMNVIwTmVVem5E?=
 =?utf-8?B?bitTOTVrcG1MbG5ocldZTXZxY3h6bmtPcmhkRHFUTjJ0RWhucVRxYllISitt?=
 =?utf-8?B?RFBnTUw1UXhlMU0zcDcxRW5BTFJwVTJtMCt4NjRIR0w1RHpiMmVJcHRLazlj?=
 =?utf-8?B?Y1FWT3FlV1o1dXhvWVpuR05ZVlVxblZ3aUQ4alVVdzZoYmRsUFNWaDJXbmpH?=
 =?utf-8?B?WVM4bTNUbEs3ZThqa2l0ZU1vRjZwRjBTVXZGQ3pVUlVqa1YvVFNLRzRIeDl0?=
 =?utf-8?B?Sk1zMkV0T1piWmN0OTNuWjhMbkUrVUlwcjZBSEJiWlE0emVpZDVXa3pyY25D?=
 =?utf-8?B?d3g4VllLS3NjZTgxcEozVWg4TjNWYXhwUVJhNlZFeEhGQ2NFclVURm12ZHF4?=
 =?utf-8?B?MnZCc2JNNDFaUUFMK2VQcDBvVVFFL0tlS201L0V2M3gzdGU1amxZRms3N2c4?=
 =?utf-8?B?enBEd1liTmZBc3FTWElrRlgwRjh5OVhVZU5RNUJGMmM5MVQ2T3JtbllkdjBL?=
 =?utf-8?B?V1RKSWNMVlkreHJwSnpxdytTSUR4QWM2S0p2eWFUYmcwMjRMNHBvTjNEcjRs?=
 =?utf-8?B?TUl6Yk5tSm9kS3NjWUNGU0UvcnJhWHVVTmdWZmFqWG4zMGJHY3pFU3kzYnUy?=
 =?utf-8?B?S29NOFN4a2FqMzFaVlFaSmVuU1kzWXhHMXhFOWN1cHVjN21tbHhsSDNGaEVY?=
 =?utf-8?B?RWxKb2g5RXRKSWJrRDBzalFRRndieHNwekduNGhRRm8ydWhneGc1NEVwY2NV?=
 =?utf-8?B?d3plT3FJNGMzS3Y1VEQ0a1Q2bnRUcjMycC9ZdU5vaFgxOXEzSmVLUi9SRFpN?=
 =?utf-8?B?a29DeFVMczZXZE5mNkt5QUhGN1E0c0c3eHg5dFRQUjFoSmY2UGRxTTZaYWM0?=
 =?utf-8?Q?bYjVyy5sXQgSbzw7LG11KR3nt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21782a5-3bad-4683-94d5-08dde94e65b4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:55:08.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoerX59G+mLmoX39u31vn0/CXKO+JeKHg1sitzpZhUi2XvcHsFhxxjRi/UBykEB3PF6b8ScWjptrMlyE9EcAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8105


在 2025/8/31 23:27, Jonathan Cameron 写道:
> On Tue, 26 Aug 2025 18:18:25 +0800
> Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>
>> Use int instead of unsigned int for 'ret' variable to store negative error
>> codes returned by ad5421_write_unlocked() and ad5360_write_unlocked().
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> This is a fix, so needs a fixes tag.
>
> Given the two drivers were introduced in separate patches
> I would suggest splitting this into two different patches so
> we can call out how far to backport each one (via the appropriate
> fixes tags!)

Okay, I’ll send the V2 version later.

Best regards,
Qianfeng


