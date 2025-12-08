Return-Path: <linux-iio+bounces-26936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA43CAD280
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE345306A509
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF130F954;
	Mon,  8 Dec 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hnKxo/e3"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9342F6930;
	Mon,  8 Dec 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197081; cv=fail; b=uebq9xMPA1/UErBhUl0s/XWzCkiU09Evp8N5oqDZtycrPwJIlHHcD2EdNAyt9+qqUipwZj6SLzEICqQtEvd9rUkuxG+gQ9sQqAlqbCeH/9g9FsakYKuEzfoq4RV013rXJ2GPw0oZ00YQ3MY4PErItMpqfvF0+VixcBaNkV7GJ6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197081; c=relaxed/simple;
	bh=djKBbWlRZ1QD1Pdb2TCv6mtCOnMTmKSJ9zj8dZMAZvY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mYLSgmt2EQPNcNYk6qoWsHG4SGDfTCDE4Dx9vyTFV25wRR5+WRV9N+YGI1sYE+3X8Dy4V+48qDHE65JH3ETFv1j0YFyoVulLZ6xh5f5N8Q5BHBOKIUmhxxk7czM4pPLw4WrpXElH2eVfa77cA5/KrXlMgxCqrj7O+RWsw+/KLCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hnKxo/e3; arc=fail smtp.client-ip=52.101.72.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPnoo+0CjEIMjNOQxJU4O+beriUyIO4LDOmWB77ow52165XTIZwxm/mjBlvZU/+Q2cn6DTfWgHldDYIBoBirVur3O4oImhiXI7BkFMAVkXT7/Qvqz6+bZWV0OteIAnr7hzIRMlrupQZEkWayl2nxOh17qsJBkaHRM4ALCwY3P9NLiOoL1YNTXprcujtJaJCUHU1xzNrRQJnGagT4D7lj+dV/jWfe4+XgCe3RkIsfVOuMA7PdyxYKl1SKv3tNVAboUrfEncFgJ5gani/3/mvwnRErMHioABUCRkEG1iQVvipuYq2qQXkrisP43yizTLKzLRDfep33oRWkRBHAY2AnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+TcksRneaZB+Ac11ZX64IYXGG/Kd1b9dxa5uYRdvkE=;
 b=pFCpMD2+akPsof3ZA3kEzZh7fnPFL9cfe3KpWw0wJeRJCtGKS3C2xm33j5tfBVTekOw/rDZALV9kPjwc4fxoUbsZ4z28f33EXPaxVXnVpRUl7vzYt0mRAFRAqm88PpmyRFNSgKNsitaC0njgVjd0bAwQg5f0BpRtpbIMO0nj02NVfQlO7lWG+drHvSoUeTaItb/BcrSmITBzh76mgl8ck6qjlLyoRTst3uEHWjkZNFHKIDPmK1fGve4y35LkdmRQbX0Ft38dvevOWOXy46WOE/XmoyQe2kO/1VCEq8MHie4p5ubhf9megpYLLV2oxZIByzQQWxuZ71SDV7uCQPOC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+TcksRneaZB+Ac11ZX64IYXGG/Kd1b9dxa5uYRdvkE=;
 b=hnKxo/e3spW4zyHAl0zVVDwK4tkbZXUDp0UDgTcynF68cEUZktc7vM4N26x8uFt5jAjEZ9clltgjuhfulojzUVFabkDJWnrc1QmT664UAa5m3d31htBSRQW4D9x2V1Eo11B/FDkRDplnJiRv2r8pXtMz6LcuTM/G1q6rA13gb9LBONxwC21It8TQZEDQmPmBzxs6rjTggRSRjUrneELyBDsGX0o5grfUHrEPG+vVu5GJ1rsfzefaXQ/IuZDx9s/rzvQFJKNmH+aAQt59xzXQlQRXq1odhjN+y3l4Q2JB3j0hdzv8JGUOHS+VrqPjAh0+5IW537MLjtDhGfW3iAPEXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV4PR06MB10452.eurprd06.prod.outlook.com (2603:10a6:150:2e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:31:10 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:31:09 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Mon, 08 Dec 2025 12:30:58 +0000
Subject: [PATCH v3 2/3] iio: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-add-ad9211-v3-2-c49897fa91c4@vaisala.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
In-Reply-To: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765197067; l=4677;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=djKBbWlRZ1QD1Pdb2TCv6mtCOnMTmKSJ9zj8dZMAZvY=;
 b=L4boGQoXzsWZYdapxg5ORiAwNLV/nOMvipKJq7E9TPKVMjrLGSOP/61FZafCMrU99ANDzSHZy
 coXGt0CCFByDDsPsImCbTDHETV4g8h91Ew9E5fYQSAknuOGFsyi0uRB
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0004F092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::62d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV4PR06MB10452:EE_
X-MS-Office365-Filtering-Correlation-Id: 244e9604-53cb-44f1-c703-08de3655aab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUNNcVcra0ZGcWNVS1JMbWl2akJGL050STI0SUpuWUhWNlVYVk40WXhJdk5l?=
 =?utf-8?B?Mld2dXF6dWN4YTBPb2pmdUdrcCtocWlMbHE2ZzZUZ3BHUkRUbXNPRThTaUtm?=
 =?utf-8?B?RkEvYnQ1Z3Biam1YaXpZVkVWMjJrK3F1ZWRka0NRK1NYb0hNYUJjYUdPSkQ2?=
 =?utf-8?B?OTFwd2MyMzFCRGlZc0FVejg5OEZ4L2JKZWgxQ3liOTFkbjMrc3F5Z1RXN2hi?=
 =?utf-8?B?amJSSHRvYzFzT0pwNlNGZER0MklXYW9jWVpoRW54Ynl0NDNEOXBiR0M1QU1v?=
 =?utf-8?B?eEJjVEFjM1JrelhNV3NTT2l0MjlqSzNrOGFlREhZQWlxek5pSmNTSHc1Y3lO?=
 =?utf-8?B?YXA2VEwxb1ZLVWlXREEydk9PVzdVaVcrTGpoMkFxUXRseTJubS9PNU5OQlJO?=
 =?utf-8?B?WkNpRld2Vy9UTXF6b1lQSUY0ZkJiSGwvNGpMUVFCYU9yMkExUTR3QURwbkJo?=
 =?utf-8?B?VkwzNmJTcnFWd0hvRHVHTmh6U2dHNjVhQ3k3clpWb3IyejR0SWlMVmxoVWRv?=
 =?utf-8?B?SWx1eTRHU2pNalQvVGYvVjdSRFdUaXdzNGl3MVhmT3NKMytsTEMrWmVIdUhD?=
 =?utf-8?B?QWM2WjBHNExDd0VVTVR3czB4WE5tcDJiVW53aUhmRVVMY1pPWFBOVyszckdV?=
 =?utf-8?B?Y1hpWk1tanlHR01ENlY1UnZQM3E1QnNpTUpvN1hRZWZWaG1ya2k0eEVsZGt3?=
 =?utf-8?B?UUwvZ2hGaWtvN3VJZnhRSVY3cTBacERaU2NidDNId3NJdk9EYXFUVTRyUWZN?=
 =?utf-8?B?WTdib1pmN1NKa1c3cVZPcTV2OEN0dVBMWmFIWGNJaUhOcVF0WVJqOE9hTW9S?=
 =?utf-8?B?SHE1SndXTDZDbzJ2dlViaEQ1N2NXeVF5dnlhYU1kQThodUIzd1pTLzdVUFIw?=
 =?utf-8?B?TE45Z0FNRzNjZG14VlVzN201V2g1dXRBMzdiRzEzOThOUTkvMDZhbWRDZTYx?=
 =?utf-8?B?WDVzTytiRm1LbDZSYkhRYTBPMTJBYU5UVW0vNnloeXBseDFsZWhoUkE0ckFX?=
 =?utf-8?B?ZkhXcHVUZldmTnJIRWZ1bUcvbFVjZGQ2WUtEUHRkaVJkbDQzRWJTdW5VbDB2?=
 =?utf-8?B?RzZ5b1dwNGhqNkJrNU5vbnZsSmIrRnRiUFhnSWdFSjVZN2YrL3JMTjI1NW5t?=
 =?utf-8?B?Qks4YWs3Y1MxZXhEZDhuelluYlRFNVpxRHRIUVlaZFI0NFppVjVwY0duREtD?=
 =?utf-8?B?dHlQZEtXSkxEblJNM1AyckdKem1TVE1Id3pIa0xwbFFBMmFJZmN5SEtkMzhP?=
 =?utf-8?B?Y09odEY3SWZkZW5SaVhpbkk2bGVSMnRhVmEzd0tadUtDKzBrcTM4TUFaY0wz?=
 =?utf-8?B?YWtaWmlvWmhSSUl2MnRKS2ZOZExpVW0ydllBR3pXYW9pRWNHaUxmZVlUVlZC?=
 =?utf-8?B?cjJkaHZyQ3V6aUxDN1BZejdWa1VIV1I2V293L3NjMmU2ZndYOGJVWDcxN2pD?=
 =?utf-8?B?eVJnQkZVOUNpb040VkZzTkpueDdFc0tpOGdXYW5oZ2kveTBqL1FMWTBWV0t5?=
 =?utf-8?B?dXVEOCtTckZZMEdpUzRpUmNkZjhHM3VHL2UxL3doOHBUWVlqdFZUdkwxRlQz?=
 =?utf-8?B?QTlHVnF4M1VQSFh4RHNpT0VtR0kxemhuUVFYY2p0VlJqMjl0V1Fjd2UvV0N6?=
 =?utf-8?B?VXR5eE9rcXBDTWpjZjkxVlhTa203R3U0R0FjR2lFOC9Gdkp0UjVZbks4WEd5?=
 =?utf-8?B?elpBa0RXZzJHRUlLTGlNeFpNZ2FUM3dPbVJKTGRHRU5KSGp2VGFlYUZKTkFw?=
 =?utf-8?B?d2t6Tld4YmNxc0pwWWJ2SVYxRG1pOGRnMzhWN2pZZGoxbnZQZitEWTVkcXdV?=
 =?utf-8?B?Z1NRNm5LL0l1eFJnazNtNEg3K0hsR29SOVhncFgrM0FuR2FzTmJaVmpoT0Qv?=
 =?utf-8?B?dnBJcUFLb3d0WktlTnBxblMyTkszNlR5TVU1dGJrRTN1UVZjMzFXM25VS0xX?=
 =?utf-8?B?OUUyR1pOdkxYNEJ4NDQ3R1NmVXR1NzU2M1ZuRmIrWEUxbEs1aHZzM1M1L3FX?=
 =?utf-8?B?SWF3TnA2QTZYUXljRDQ1WEFPYjhTWjB3ZHN2czhWbzZid2cyTGIzNWZtWWpx?=
 =?utf-8?Q?NROkJE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXMxRTk3Wmt1WlduSXdqbWw1cU9HZ21XM0w3cFVqSXMxN0V3b3F1dnArZTg2?=
 =?utf-8?B?YlpNa2ZVYnRtSEMwNldJbE0veExKa3NHbWV4VVMydnFqbWd5UlQrUlhCTzRU?=
 =?utf-8?B?Mzg0MjA4VEV4dkhTTkYrSTNUOWtqWEJjaTVTZ2szQ3czWkpDeFp0RndKTkZV?=
 =?utf-8?B?Ri9TWHFCRGhMQkpvVk4zaHVVV3dmOUJFRnRtWXpCeWpBTlNleURpaTBEbThz?=
 =?utf-8?B?RmdSdkljL0h5N2xaUXFnemZRdDlRWDNaSHZiakxtZks5WXZqQ1E3Y1ZtN2Fo?=
 =?utf-8?B?Tk5xWFQvU1BvTnE0V3BENkRqTEkySHdnSzFOWXNQYXBHbk5hc2RIRi80cjBv?=
 =?utf-8?B?dXdRcHhTenBGMHR3YktRTXR1VitaWnRSSzNOeGZ4dXd0QzFxZERUNHBpcDJa?=
 =?utf-8?B?T3B5Zk9iNERPeWJNRTBmT1RtL3kzY2xqcUVqRk9laW4zc3RLUksyUUZNanBi?=
 =?utf-8?B?L0trVy80clNvaGJkUFo0SkNTMytRTGZjNWRsaVFrb3FCZk1ZNXQ1SExPbHNU?=
 =?utf-8?B?eVJzdVhTRE9HeXdYRTUySEhyeDI1aElHRmx0alBYZkZKa3FCMjQvWmhMTndp?=
 =?utf-8?B?TzNjRmFyZWIyb012M0p2a2tTbldibEpJOVNvS043T3R0K3duSGJwN3JseDds?=
 =?utf-8?B?ckpNWkZmMlFVRXNURFduMkhndmNCZDFoSnVrbWlwNHBDcVh6S2JidDBCRU9a?=
 =?utf-8?B?RnBBeDJEdVEvNE1kZFhPd3NobDNQYVh3bkFrUkFMcTEvcWdBQk1XRmxWN3Qv?=
 =?utf-8?B?MlRtS0NZMlpzWHVTV29UZmJOM2F4bGhCdmhpWmRKUG9PbmlQNFl6Rm9raWhK?=
 =?utf-8?B?NW9kVFVzRDZCa3laOFIyVDd4NDkxRmgrSGI1dk5hT2RmU1lGK0FwMXFYU1dG?=
 =?utf-8?B?d2syK1ZIN1Zaa2tDT3U2dS94cS83OGI3Z3l0QjQ5VEZ4ek9jVVQrVkdka1gw?=
 =?utf-8?B?bEVndjhKMjZ1VUhIWitPU3IveE9TeVE3dXpTdFpPNmpHVjVYVEZJakcxVk9Z?=
 =?utf-8?B?SDB2bGtaOU50TnR4eTl2emZuVzhtWnRkaU5RaG5sSlpmMjkwRWRtYTAyQVBL?=
 =?utf-8?B?bU9OZmF4dFYvYU5QZzRMVFZ4REdCQ3FBWHlxUmJTMVQ4V1owZ3FjTUsxRFgr?=
 =?utf-8?B?YjNzMDZSYU5zNktQMXBhdzdxYjR6alAvd1N6ZVk2L0Q2aytLb042TlBQRmw0?=
 =?utf-8?B?bU9iUk1MeCtPMWVHbG9VZ0ZTaEJ0dzh2V3lhcEtwUWpqNzVnUjhKYlRWY05F?=
 =?utf-8?B?Wis0SnBXRjNYWWM0ZWlSYWN2ejgrRE0zSUFSYVZBcStQRityWE9CYU9pWkQ4?=
 =?utf-8?B?R0NQM1NQQjRuS0p1RFFRaGZnVC9OY2FDc0t4R0ZOR1dXWk9HZUw3U0ZUY2NQ?=
 =?utf-8?B?UkpCYXY5LzR2K2Vja09qNVR5ZFhobTZobFZHZS9LdG9SQnZhQk1sTzBBbHpo?=
 =?utf-8?B?QXJDa0dDQnFCWDY3dVQvQXorTG90MHZSOUE1aEdQVXFzYzBNeGRaSTBGUy9o?=
 =?utf-8?B?WnBoWmhwWHE0NmlVZ3FPRDBhSmlwcndOajRUS2x4YWtYR3k3L0NVZVpBYlk3?=
 =?utf-8?B?eTZTdVF0c0cxVzNISkhocHQxUmowSFZEa0MwUjJzQ1BrSnB6YXVEb0x0R01G?=
 =?utf-8?B?L1k0YjZ2WlQrYXNWMUhFbkxON0M0WWY1NkNlZ0VqZVRxYTc1L2ZUVldZVEpn?=
 =?utf-8?B?RW9uNC9mdWxTMlI1ZDhvVUJ1Tk5kQTZ5b3pCbkRaMXlHTzVEUjZVNWRDK1hU?=
 =?utf-8?B?LzI1dUhRUUJSRW1seEx6NVh6SlZRL1EvOG5MeFB6d2Y2YXpmTm9ZbzJHUmJC?=
 =?utf-8?B?YVJsVzlRMGQ1RTBwdVZlMzBITEdXU3BZVDBib0x2d0hTY1hGZnRRcVZvWkpy?=
 =?utf-8?B?ZVFyUzZwWk0xOWs2WnFYSXNsVFN6bTdsSWFueU5wcFpUcGtKTFdGKy9MQ2VU?=
 =?utf-8?B?QUEzemZJSU1vdjNKcmZiWmxvaHpkQzhVMStOd25GdDVvNmZsc3RwVHNlOTd3?=
 =?utf-8?B?OGxCWEFDTGdadmVIWnBiLzVLWlVTT1MxYVlwb0RoYjhwNmZZcFhOSlFCMDhI?=
 =?utf-8?B?dThObC9xVlVDOVpvL2Foc3RYZFJKd1ViL2tPRjJ6U0lGU1c4b21GSVRRZzlZ?=
 =?utf-8?B?OWRnRHBzakgrUk5qWnhieGo0QXFFQWRiaHh1M01ZTUJseDBNdWpuY2dGVWlZ?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244e9604-53cb-44f1-c703-08de3655aab7
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:31:09.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Do8zNRN/URxQokCJunyEoGraAXHfFymHmDuEUzQD/WesHcjXJGAG6BSkvxT0wwb4HUtX4SiNGUWK0PGVIl0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10452

The AD9211 is a 10-bit monolithic sampling analog-to-digital converter
optimized for high performance, low power, and ease of use. The product
operates at up to a 300 MSPS conversion rate and is optimized for
outstanding dynamic performance in wideband carrier and broadband systems.

The scale table implemented here is not an exact match with the
datasheet as the table presented there is missing some information.
The reference presents these values as being linear,
but that does not add up. There is information missing in the table.
Implemented scale table matches values at the middle and at the ends,
smoothing the curve towards middle and end.
Impact on end result from deviation in scale factor affects only software
using it for scaling. All the possible hw-settings are also available with
this implementation.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..5840bef795daae88518b23ca0dec4da0c5fef07f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -20,7 +20,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
-
+#include <linux/units.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
@@ -81,6 +81,14 @@
 /* AN877_ADC_REG_OUTPUT_DELAY */
 #define AN877_ADC_DCO_DELAY_ENABLE		0x80
 
+/*
+ * Analog Devices AD9211 10-Bit, 200/250/300 MSPS ADC
+ */
+
+#define CHIPID_AD9211			0x06
+#define AD9211_DEF_OUTPUT_MODE		0x00
+#define AD9211_REG_VREF_MASK		GENMASK(4, 0)
+
 /*
  * Analog Devices AD9265 16-Bit, 125/105/80 MSPS ADC
  */
@@ -234,6 +242,17 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return 0;
 }
 
+static const unsigned int ad9211_scale_table[][2] = {
+	{980, 0x10}, {1000, 0x11}, {1020, 0x12}, {1040, 0x13},
+	{1060, 0x14}, {1080, 0x15}, {1100, 0x16}, {1120, 0x17},
+	{1140, 0x18}, {1160, 0x19}, {1180, 0x1A}, {1190, 0x1B},
+	{1200, 0x1C}, {1210, 0x1D}, {1220, 0x1E}, {1230, 0x1F},
+	{1250, 0x0}, {1270, 0x1}, {1290, 0x2}, {1310, 0x3},
+	{1330, 0x4}, {1350, 0x5}, {1370, 0x6}, {1390, 0x7},
+	{1410, 0x8}, {1430, 0x9}, {1450, 0xA}, {1460, 0xB},
+	{1470, 0xC}, {1480, 0xD}, {1490, 0xE}, {1500, 0xF},
+};
+
 static const unsigned int ad9265_scale_table[][2] = {
 	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
 };
@@ -297,6 +316,10 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9211_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 10, 's'),
+};
+
 static const struct iio_chan_spec ad9434_channels[] = {
 	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
 };
@@ -369,6 +392,23 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.num_lanes = 6,
 };
 
+static const struct ad9467_chip_info ad9211_chip_tbl = {
+	.name = "ad9211",
+	.id = CHIPID_AD9211,
+	.max_rate = 300 * HZ_PER_MHZ,
+	.scale_table = ad9211_scale_table,
+	.num_scales = ARRAY_SIZE(ad9211_scale_table),
+	.channels = ad9211_channels,
+	.num_channels = ARRAY_SIZE(ad9211_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
+	.default_output_mode = AD9211_DEF_OUTPUT_MODE,
+	.vref_mask = AD9211_REG_VREF_MASK,
+	.has_dco = true,
+};
+
 static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.name = "ad9265",
 	.id = CHIPID_AD9265,
@@ -1264,6 +1304,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9211", .data = &ad9211_chip_tbl, },
 	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
 	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
@@ -1275,6 +1316,7 @@ static const struct of_device_id ad9467_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9211", (kernel_ulong_t)&ad9211_chip_tbl },
 	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
 	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
 	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },

-- 
2.47.3


