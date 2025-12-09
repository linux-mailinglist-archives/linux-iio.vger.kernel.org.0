Return-Path: <linux-iio+bounces-26963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30252CAEF2D
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 06:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77363309593C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 05:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D62D879F;
	Tue,  9 Dec 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="eGlf3BR3"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B32BE657;
	Tue,  9 Dec 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258448; cv=fail; b=F8/eYtIHm1GYDUsgdXzAMVgJdATddJ4BDK8fE9to2mk9sEsBcwi/3Z8+EY3FvKrTQgIt1OWjxsSYBqWXxtm1Mza2J1E1NBkSA+X4jLdr63ZtRKk8A28B4++lMeOCK/fzJDrLC+cV0Nna4ij2sDc7bhxaHOV6ZmVN+RNZcauyBaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258448; c=relaxed/simple;
	bh=YrRTQypvQNdKH8/HTjaUEIxVBKo0+WDoN0haO8fRgyU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QCO5r/iMx0/svOjd/A7a/6yjK3PdKTzCYiSnzzKR9HpgOD/328rHGZ/Fdpn0fMg2QXphRXySthkRjNNeAdAhfCBk4VEXpy/G/IENZfyieI4U/41TFirhgSWCzav5A2DDq5ttvzoWm1N/yMXBHyTtMWfCGpERZsgMud0hc/OXRdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=eGlf3BR3; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG7u6u934QozjE3dR5dnNv+BFSM9iKWy2dWihvwfnQiydM8K5NVMczR/IdnxQF7YIb7IVPfFEBQBnM1SGDaLWraMoXluPYc551oVBlRVi5529/LZInBc6bgo7drhZCrbiuWgS83/Uj3P7mLFF2tKpym0HddhLh6svBHzICZbmcbUP9icd43Hi9Z8W6ToDB33ic2tz/nN8Gx4eeI8xndQCofZrlkMoouxgnS4nOIqnrwAfG6UTYptQu9j9LsS9k4PQgGjyaoomO0kOsCbTn+GWJCbsezGpi0+mx6pXbtGZgactxON6lXBDhvzwaIqj3EddPgMDHNLtZOaMKZH+HsEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49ZaP7m38FyGm/XT+Pvxep5c6pgRcsMdNnZ8o+p7N2I=;
 b=Re3ZO+okPb/6w1FHJm04rkkp5y4kUXxIvAKOoIJKL/G4WIrjqn94B9qG6ao3cJPW5KZJGc2kZR+ZdxOxEDVJIgt7302oHGFJObbJBZQxJBxBqkrxcMULIWZF8I/5gUOoQXPANFbKDxURVPtQGQb1vOl414me5ZNhc5AROH3oe+0USqBk2YDGY2ejY/2Q4vHFW9vC4rNJdwZX+L3QzFoHPerTiEVMQuclEP4W5m3BygK3jS/TWxqYbBDekua2uKwXSeMaUJDLTjVdTRAOQjCQmYQE2xAvFMm/Uz8PgWWCpkye5+W4jK6nFM+AKjDSI/M8KylAbS3g3VSVCxb/wBMMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49ZaP7m38FyGm/XT+Pvxep5c6pgRcsMdNnZ8o+p7N2I=;
 b=eGlf3BR3PtVJCtax1KBQQw9if0kvl7PnIxx/DMgZ0z15R5AAaRaup0twD5x8WzXinT/QJJL9HTPFgrn0zypUJrQG1YwmvwOwOAbk0BXKkFGWEf/TTpiaMsmX82nxFqtAzECA1cF21A3dmRK1LhCBDU1OxKRWBmEOkFf+78/dxEmDL6dHu79gwYeDhWyrKx0WbFnpNTFwC6UmjGlxwYtDwL3zkxOpbW18UX2Al0jTeU2P5tTgL4L8NeHswiBmYvq0h0lhCu3ROSXKZbN1YkS1fKL3y30L7lXXadoYZ3TnfaPnoLor8n/Dw58bGis+NgMTsFcD0aKPiMLy3vzIFayXbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7053.eurprd06.prod.outlook.com (2603:10a6:800:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:33:53 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 05:33:53 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 09 Dec 2025 05:32:28 +0000
Subject: [PATCH v4 3/3] iio: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-ad9211-v4-3-02217f401292@vaisala.com>
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
In-Reply-To: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765258430; l=4655;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=YrRTQypvQNdKH8/HTjaUEIxVBKo0+WDoN0haO8fRgyU=;
 b=n/CAvFntS3aL/r5ey5ESKOt/CYCvlbPsTXFgjbcdKjsUl7KsCwkh1JGgrk4Ycc0FRs834mEg7
 RNbgprwxqTJCkvPBMN7yvrW6OHfsvUvZ4xJgi2HfeoGWh09dYUI5O9s
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E6A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b58d3e7-7a1b-49ba-75d3-08de36e48a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjhyeGhQektPZnowc0JlZThNalIrdnlPVE8xbHdBRUoxN092SjVnUHRIOW5T?=
 =?utf-8?B?eEEwOVNNdWpxMFRwdTRKSDA5Vy9XZ0czY1pVTXEza1R4NGpFRExGQW5DYXdh?=
 =?utf-8?B?dlpuV1NSeGtuVHpKYlYzMXo1Vmx5MHc1VzhlRUtqZGJyRXF5K1V0RnZwWi9P?=
 =?utf-8?B?UUNFL3BlUlh5QzBnTUV2dnMyMWF0b3VUZTNhYSt2dnYybXNVcXRCdkg1Tnhq?=
 =?utf-8?B?OU1lVUdSYVdxTVZLMmtjUVI2YVJKVFpOY3pObFlHSmJzT0E3b2wwcFBHenI2?=
 =?utf-8?B?Mm5qQUI3eXhTaUQvQ2pFMzJ3d1VMMWQxdXdEelVqOVplZGVUUEF6NEhwYlgz?=
 =?utf-8?B?WjduOVlJbk5aTXlVNUE5YVJ4dkNWQVpsemhVVUVYdDNJMDhHMXllbmV0RjZ0?=
 =?utf-8?B?Sk9nTkZ5TXNTTFVsY2czR2RYYVlkT25FSFphQkV2Q0xUT2h1R1RPN0QzUjZ1?=
 =?utf-8?B?QVY1SmVCbUdlcjRZSFBteXV2S01wSWZSbTluRnF6c2NTczRvZm5KcWw5RC9z?=
 =?utf-8?B?RXVtVUhTZXVhUEZ4UjlkT2YwNEs2cmFKeVZEdzhna3ZoeXRvNjdVMVdmU081?=
 =?utf-8?B?UDU3MUVZQmpocWMrNlVRSnI4NnhaSnd0c1AwUjA2Z082N1M5Z0hXdnNuTjBa?=
 =?utf-8?B?OUp1L3l2Qk1adHY5YTcwU0xhbVBCM1NybHJzQkU4akNIRW81YUtmYjVzakZR?=
 =?utf-8?B?cEtjZWhBcUQ2NWFUZVEyMzdQZnYxa21xUUNMbEJNRElPVHhCN0ZrbFMwbFAv?=
 =?utf-8?B?eTJNMGRHUGtidnZNUDh0ZkV5UHBRcTcwdVdNaTlMb1JBUDRxdisvaU5Ld1NQ?=
 =?utf-8?B?aEx0cXNrY2RXalRMMnBodTBkMkxuZTI0dndjMHJXQmE1S092cmxzVWdkc3RR?=
 =?utf-8?B?K21YVVlHbUtZbThlZWIrMTdwaVlpWE1zamVBTDFCLzhsZHk1Vi91cFpJVWlH?=
 =?utf-8?B?K1BpK0lsZmoralNndVdNWlIvWXA3WDJXcWlZYTJ5Sm1ZVGNwazRqbEpQbmFM?=
 =?utf-8?B?OUUwUGZ6a3BRTkZrWTQ3NnVhWnRtZFZpMnNadnRPUnBCbFM0bGJZMTlraVI1?=
 =?utf-8?B?UEhvc0dnYzAwYXY1YjdUckIxazQvaVQ2VmtIVDBYbXFZZzNLb3k5UXkyYVV3?=
 =?utf-8?B?MEkwMDBIVDBYUWRhbStUZzFzbDh2MGVxeG1YWmVOcTd2WmRmUnpVcUtOMzI0?=
 =?utf-8?B?QVA1dk5YeS9HajlwR1NoN2puUkJwNEVDZmtlTWd1TGlJVmVCRTBwby9HNTNi?=
 =?utf-8?B?VVVzcnFzQk1ZS0lUdzkveno1WFVDa1pUVjFtV2RtcnVoTWdjaHZ1Q1V4YjIv?=
 =?utf-8?B?ZGNXbzIzWmg1bkxUa0prYmREaWhDVGNGRTdVampRS3dCMHVycnpLZGhvU1p4?=
 =?utf-8?B?UmZDa3FlY0h0VU1qdzE1c1VrVVArYkJ6eW5HQzBadUhEbUd2dWlOSTNSNlVv?=
 =?utf-8?B?aXo2UVgvQkRMMnpqSis5cmtFQVRCdWd6QmduYW43VUpsVVVjeE9oOHlnUFlR?=
 =?utf-8?B?NkJiZXVudjU3UHRZalV2VUt1MVZxZG1yL25ueUVaaUNyeVdBZVkzc0NOb2Ux?=
 =?utf-8?B?dDZVWVU2ZzRQYVZmT3I4UHJTUk54bWxtOXdYV0F3WUJWTmNmUzRzK2FSTjN2?=
 =?utf-8?B?aWVYUGV3bnFvYWZaZVJEQzRWQXpCWGxrSk5IajJpL0FRRDVsQlRpTU9CdG1q?=
 =?utf-8?B?dEhZa0hBSGJzZjRpZytJVWZZdDZGQVFWVEFSS3NwUDU3RkxMTmZQVE8xUllU?=
 =?utf-8?B?Qk5pUTdaTk9MYW03cXhWbDJMRWpKTldIUUpOMXhZVjQyTU5MczA4ejhGUEN1?=
 =?utf-8?B?ZWVSVlhDSG90NWVveTZHWDhHeFpSdHNCT004Rm53R3Rsa3VWZEJHVUN3bUcy?=
 =?utf-8?B?Zk1MdE9sUDcxWGNqeVUyRnN2cUtxbHdTb0R0R1ZFVE5NdEw2TU1JaWFPZTgr?=
 =?utf-8?B?UnhDWG44U1ZHZk1nUHZvaHE2WmlRdGdXUFRFMWdTU0hpbjArN1FYeGc2ckhs?=
 =?utf-8?B?YnczRFVBSEdqMFZrREJ5a1gvY2FMQUlsQklDTEV4STVVOHdQOHRhYVRuK21G?=
 =?utf-8?Q?0sFFwm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wmo3WXRWMTIwUVVLdnM1K204SDg5N3o5MVo5UWQybXRHcmNJc2FnU3pnYWdv?=
 =?utf-8?B?eGhraFQ3R3d6QVRlM29yOXdBc2RXOFpCNW9vS2JlYTdlbTNiVjEzYXZrUkhq?=
 =?utf-8?B?RExERlIwcHJEbWxVeHhEYndsRVhjeFpqa3JzTnFZQ1cwOFA4R0xWcTZEVUda?=
 =?utf-8?B?dTRMbGlkeTlVWU44eFFaM3VPNEJQRTYxRStIbVhuZVJxanJsdm9SY1RrTzAw?=
 =?utf-8?B?M1JqMnMxZDh0d0sxVmdRL2ZMdWdnajNZK0tUSFVZNWFPbS9WVFhBNThLYUps?=
 =?utf-8?B?WFZvbXFqcityQ2cyMkhaV2ZjUTREeGlkVnEzMjh1NjM5dmIzVDdPOC9aamdL?=
 =?utf-8?B?MjNFUklRRitVSUdvaW9SOHdRMlNNeUtCQVpJazd0cE9ENVhnRGpkbnVvNjdK?=
 =?utf-8?B?QU1DZHhwWVYxN3hvVzZyYlNzaElBUHRBRHZYZCszWm9xTnRNOW1BZlVOaSsx?=
 =?utf-8?B?dTQxNVBjejBTcFBhU3BPcEdKTkdaK01lY05TRjBwTHdrY0NTWk5Rb2pFdmIy?=
 =?utf-8?B?d0gyU29GNG9ScFlmbW5BakwrRjRCQU1PdHBVa0ZndVcrRHZlMms1Y1ZMa2k3?=
 =?utf-8?B?dS9sUHNYSkh0bFkzNGtyakZWa3p2dVE4WFdCUnZ1NzBuNGRVYkhDclk2OEt4?=
 =?utf-8?B?bVpkbFFlbmxXQlVOSVljeFhNVFloN21qbllEQm8yWVBDclA3bEZCOGNiS3ZC?=
 =?utf-8?B?RGM1RDRLeUxHdytDMENTcDJ2VXVJdFVEMmpsL0tDcG5IY0EyQnF0L0RkZ0xF?=
 =?utf-8?B?M2VhUk1EU3YvK3p4dGJUOFFtQ0hPZ1lqT293dXdRSDBUdG9JLzY2ekFDNWFK?=
 =?utf-8?B?K3F2bFpSb3k0cFg3bk01UG1yRS9VOG16bTB2RDVMZ2x6WDYybXMrSksvSkc5?=
 =?utf-8?B?RVpoMjlaalU5eUVVYVExQ3l6TC9wOU5idzBKSXRzTVNmc3NNdnkxWGg1N2hi?=
 =?utf-8?B?a05KMS8vbFFyTmwzTkRBWHk3Ty9CZGVxUEdmZjh3YlZiTCttN0dXVkVBK1do?=
 =?utf-8?B?T1JuWm9JYVJTRDQ3U0prQjhua3FhaXpwMGhKQ09UUlF3MjFsRXkzSWV0VFZu?=
 =?utf-8?B?RStLVE43cDdheHF0MENlMFBaNytvUEY2em5yOERWb09EOFhGY1dMNmZFZ2hv?=
 =?utf-8?B?WHV3aCtnb1REdlhhNmdLVDRCL0poTC94YjRUdTBWQjNvQ3B2Zjg1d0tJWFU3?=
 =?utf-8?B?aytvYlVZN2xDNVNkdDZHMnhibTNUZWhjWndqVVRxMDdmMTBUaUtESXg4cE5F?=
 =?utf-8?B?emJ1VFh2VDRLWU5sQmdnbXp2SU9wTFB3NkVDQkNNQ21STGFzd0Q3NHZOcFhi?=
 =?utf-8?B?TUN3SkNWaWZJUGJCWGNrTlZ2VENGMXVHNGtEMzJJQmVVb0s0bFdrNW9CYnhy?=
 =?utf-8?B?RnhoUXFvNWVuS3M1a3A4cTl2cG9yd1k2eDJQRXEvQTJ2M0ZIU0VqNWFYT1JS?=
 =?utf-8?B?U0wyeXpZR2FUcm1zQWNxV3d4MGU3NjFYMmFVYUhiV3E1NW5YbEMrekJtckoy?=
 =?utf-8?B?SGhCTHFxNnJrVFZtbERmbDBqT1grQ2lURHZZZDhtUXpXUGc1cnlESmNFUnR2?=
 =?utf-8?B?NWdvTEx5M1ZFZVJ6OTk3MWwzWFRBcTE0enlqb3dLNVhPUU1ja2MyRjhvdzVk?=
 =?utf-8?B?dG5RMkxvVlhKZTR6eUthMC9qd1dRUGtYd3lldXFIT1hxclkrcGp3dmV2K3BK?=
 =?utf-8?B?OEhqN09WV0RzcU1WNWpkbWowUjBsYS9oVFNhem0wWUNWL0NOb1RhdVNhTDh2?=
 =?utf-8?B?aGpibkJmbmRsMm45ZHB0YnBFc3Q4aVpkbVBIZ0pJRlI5dlRKTHN3WjlYVUMw?=
 =?utf-8?B?ajRrbFZ3QjROd1l5OVQzNDN0Y1RZZG1sZFlnazl0UVZLUjdUK1pZM3JsZGdq?=
 =?utf-8?B?VXMxMXpXVHFTeEpNaEhFaFcxWkd1cmYzSkZZdExqKzcyamtKemZWdC9Jd1pC?=
 =?utf-8?B?SC9iS3Nxd0FCZFNMVE9JWUQ4RWsvSzJaa0drNVFVaFVQOTZidUVGeVhseDFt?=
 =?utf-8?B?S2ZBNUhuTStTMDhlU1J3R1dYSk5vc3VOZFBGekZBdFRpWWhCc0dkeEh5eVUz?=
 =?utf-8?B?LzVNUU5GaU5Ba0dGRkpDUFN5UGFGUHNBcURyblBZOGRqWHhZQWNHVVRadjJ3?=
 =?utf-8?B?aHBQU21FcjRlTkNaUnFJbGpLUHlXa0MvRXY2ZGIzYUZUamFQazhmTmIvc2k1?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b58d3e7-7a1b-49ba-75d3-08de36e48a32
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:33:53.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKHfmeNDJ1ArT/c/IVIqbkL8v7Tt6A0CHitECMNuD501GoVzxAEZUf7Nz69MuIrat9WIP6hzwCoLGfBb59+eVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7053

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
 drivers/iio/adc/ad9467.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 9e79b313ba12f92455c009ae3ade01d1e566465e..63428e2e5e07d0a26011a2bba3240acf82bc971f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 /*
  * ADI High-Speed ADC common spi interface registers
@@ -78,6 +79,14 @@
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
@@ -231,6 +240,17 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -294,6 +314,10 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9211_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 10, 's'),
+};
+
 static const struct iio_chan_spec ad9434_channels[] = {
 	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
 };
@@ -366,6 +390,23 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
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
@@ -1261,6 +1302,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9211", .data = &ad9211_chip_tbl, },
 	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
 	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
@@ -1272,6 +1314,7 @@ static const struct of_device_id ad9467_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9211", (kernel_ulong_t)&ad9211_chip_tbl },
 	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
 	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
 	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },

-- 
2.47.3


