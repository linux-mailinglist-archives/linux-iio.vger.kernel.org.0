Return-Path: <linux-iio+bounces-17505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55039A77695
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD5A162CF0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034991EB19D;
	Tue,  1 Apr 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="X6lUedar"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B31E9B34;
	Tue,  1 Apr 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496704; cv=fail; b=g1dU6Q7YU4F8dj7IS8cKlY1PCUT+dGSFb+Tdl437uMLB3a+vrk6G67ZCmK9rA1puiuszIzCQCvHCSarS6Jxb/QEwjv1nt2AoTaN3VpBUTxQ5K0aXBhRXvxk6hxzU2hUh9IJkey5WAS4OpWS4Bzqu5Yrsv1sFdgX5t2A/XEoXL9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496704; c=relaxed/simple;
	bh=TLGsc2R/pxPQNuUksZQsrkyx5QoS4bM6Hxpk1t2b2dY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFe2QbbNjDK+UnEvY+mCnl5a/U+akDPoFoL5k4topZrRZy29lPpnOhTP7Q1QGMVMgle5qz3KcU+Dg1jU5ZO2/Xxca1rjvMZ1RmDyX1wzI0tWmqZYJsRnhaGSd25XKa7aV1DTu5eR9+137JyFvMTq0gpZ0DyNK+/lt/iRVKmwXME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=X6lUedar; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE2ZKKBdTJD/Zp1UjwxrGeoy0CHTOMipyTgTFLYbMKnABrG+GWHjofHwC98y8PMHK6yfrxnYgNnDH8Y0EUDGqlceAW27T3VXSo7ohst+98LvXZNjfg0FYnU6Pa0WqrDb+94ymDnLxXybsPe+MvWoZTsd0YO1KkZN6jkAKoXdnK/cAJPi0WIiWyuNOrL1Pg0B/LO+YGiW20oDPiBPTK0ky5cEXa2jX0tpv7iaCUa51cLSsX/Qfw03bYRFQ2u6pojR4Jpz4jrchs7M8wTwb3t9BtgQ/z135qReBg9mLDJAZRzWIzjKF5objlp6/m1ieL36akb9D763avxBYabSc9r69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLGsc2R/pxPQNuUksZQsrkyx5QoS4bM6Hxpk1t2b2dY=;
 b=wAywzKbSnR8o6qhLXQKNH00ikWXdwDKKTxxtrwbwQeTYsE6g2bInl7YlxSzUyctdt1lMJ70h3fyXhr91tUJXY4ocCHsuH/3ZhwmanKKsLPRoEBHvdxi287YhHTytih8Qyh0AoT4SuUZdYf4sWG5g3cQlEAw/kzeqcpreV8Kpl2x0Vs3AcRM60Y734hoi6tD+ELivNYPaJdMKc7Eou+nn54O5pfdsfcbUurDuR5TuC86AtINrHKeFdX43SA7POLDrJBmdUTI9i5cmqGhTIk1KGrPBo/PuqxfqRb6QbkaSmpvEq3hsHZxxdSEyGcARBM9EakBknsD6crozHr/+q8bKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLGsc2R/pxPQNuUksZQsrkyx5QoS4bM6Hxpk1t2b2dY=;
 b=X6lUedarxfHximqBPanZDWW2KB3gd296kvaJNgVFIicZoRCvdT4jpNEmxqyFc2rnLDf0j80rahyslanhNOqLLj22LqGR+JrM9kmuxUGEXSkRV97DYpk024fO2EI2nUxbp3aSMiSJ8ijXtE9V+T93T/IB+9fKAWBpdyiTSkSlF7uJl8lh8xh4hHSoFfBrWBDdNF1Vhe5cXIBQNLrzfvgruM+zScl98M0w9tHqlPbtWnZE1Hk4nitSvOHj8cNBFMqCKNaNye0JCm1D92wUrg+3U6GckDKr9ksgg5xIVNtO0xYD5Gv0g36gSgCgcPTRpCnMyIVHbxXswryBAa9f1sM6/w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB8859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Tue, 1 Apr
 2025 08:38:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%4]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 08:38:18 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wbg@kernel.org" <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Thread-Topic: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Thread-Index: AQHbols1IQCg12nyIkObbOMtTeq9k7OOPn2AgAA/ogA=
Date: Tue, 1 Apr 2025 08:38:18 +0000
Message-ID: <91e5c0dd0b71e5fbf441b7a6f2a8937a7bfc366f.camel@siemens.com>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
	 <059003d1-d725-4439-a6d7-cb354fba161b@pengutronix.de>
In-Reply-To: <059003d1-d725-4439-a6d7-cb354fba161b@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB8859:EE_
x-ms-office365-filtering-correlation-id: 5b263af6-0c33-4f9d-4bdc-08dd70f88da7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzJhN1ZUQitvbHN0emxtVW5wSWdTTVBtZUsxUHZGYmJsTVk4VHkrQVBYcWJj?=
 =?utf-8?B?aU1JZ29QNmEycmsxSVZXa3hrd3J4SStOM1NmQ0JOVUFVN0tnd3IrZStUQjht?=
 =?utf-8?B?akMybVJqZGR3SU5oR0VycllWRmJCYTlUTEt2aEZLbTBSR1ZYNmZtSzdDMFow?=
 =?utf-8?B?a2pPSjhyaktqUk1NZlBLOVhLc0h1UE9rL3dSdE1IVVhUR2czMFQ3Y3VPQ3BH?=
 =?utf-8?B?ck51OVFNWUdEVWtPZTJqeXBGYWxJMGcwQmV0Z2xOcDZLdFhBcjZNR29JZVVa?=
 =?utf-8?B?YURKQXJLaGxmcXVKditRTmo0VWFmWkcrZ09pUmQ1UHNHUXEzS1A2dXF3N2tD?=
 =?utf-8?B?RmQ0RGxRd2hxNGYzaUZZSHF2L3lYTkNjaU1scm1majEvWlo5TmpWeEpUQVRP?=
 =?utf-8?B?VHFNbk91aTI4UDFTdVpEQ25aSkQvN3VPQ2RMUzRTRzZ4cFZ5VzA1QjVWZ1JI?=
 =?utf-8?B?UnAzbUEybUtJdUpibEEzakJlaEkzWUpHQ0dQbWhEdGU0a0FDdWtNdXcrMkdN?=
 =?utf-8?B?NVNKUjM3dE52ajNqRWlNbFI2VDBzZ0RxeGJCa0VXazVXNkN1azdEQnhkMkpp?=
 =?utf-8?B?dklWa2swWjZXbUQyTzB6VUdHZC9OMkE3UFRUaUoxZ2tPL2FIRDVhTnRUbUk5?=
 =?utf-8?B?WUhmVysrNkZGaFFlKzdzTTdCQ2x6ckF1RUoxME5nL2UrZU5Wb2F4b0hnWWxv?=
 =?utf-8?B?aXpKaEs2L2gxeXhWSkE0dGFMd0FqTDRxNGNCeXNHWnJFNkJYOExTQ2xmZ2pD?=
 =?utf-8?B?a3Q1MGk4M0pJcDA5ZlFuOGwxdTc0bXBoMDdDOW1sUmxEWDl4UHVlU3RvbTdX?=
 =?utf-8?B?ZG9xSDVoWW1CcTJGVW5UY0Z3aHFhSVJxSGlFV1N4ZlU5dlZzVmJoTTY0SWxR?=
 =?utf-8?B?ekFLTnFTeWNleEZGZTlQdFJMbnNqTmQ2dm5GWUVhNGRUUDlqMnEwVm9veWF3?=
 =?utf-8?B?NzRtTVd0OWh1SGJxZUVMU3dOaHlvU015K2w0ZWIxU0F0aGV2NU4rMFk1a1k2?=
 =?utf-8?B?WkdRNjhRNHJMZ2VEdzNTdEdPNUZZQzZ0bGpWUisrUTJrYmFISmxGZjlWczJw?=
 =?utf-8?B?VXZRMnJKVTNwbTJuUFp2bDllYVVRa0VabjFUR0tyWklMeFBJOXpMTDFpSjJ0?=
 =?utf-8?B?bzZ4c3JxbDJMeVBRcExOZ3h0S01Xb3hnMnNPWDF3UDRKbnU2U2ZlbG0zVVc1?=
 =?utf-8?B?V01GOU1mMUJUbG5iNGZkSU1DRXlTM0wzNncweDRTS1kydzcxWXROSDgxYkVu?=
 =?utf-8?B?eVNsNVk5cVR4QnFZbnhHczZJTTFlNUVHYkRmck8xMWVRRzNvRTZCMHM5N1ZG?=
 =?utf-8?B?Z2dxdFhOY256Q2t2SWZaaEhsL1d6RittbXRLV1lvVlNnbldpOE9USlNYaWIv?=
 =?utf-8?B?YVZmTmNnR2pzSmZ1SVVyaDJXNENEY0tjUzVSbk1VWTFEUmhRL0ZSdW83aDE2?=
 =?utf-8?B?alk3dVFyVFgyTUVxT2VEeEpyOE9VSUVTUktSY2Q4cGdsUmVFayszb0JpdDhv?=
 =?utf-8?B?bGNpdWVHRzUrdnpldnlJeDQwSWVVczB6bm5GdjdXU3hETHlOMmNjclBvR1lW?=
 =?utf-8?B?R0V4Ump2WGl5cGlsWGxaemRldjFlQ1N6Yjh3c0dvdXFVYkRrRWNrcHkrK0xY?=
 =?utf-8?B?YTFVZlltbVdhVDBXMEJvOTk2akpJYytOdzZBWGRhSGJ0alliNzRBTHI3dGZn?=
 =?utf-8?B?SHliRG52K01aSkwxZVZEbEIrUkpJNlhVek1SNWMrUTFYVGp3OHNiNnU0ZUxV?=
 =?utf-8?B?Smw4bzZLZWZEdnB1SWtWdG45Q1hSWGxPcXEvWkNPL2F1b1kzWFd1R3BiTTVL?=
 =?utf-8?B?Z0JKeVhtWm8vWUZ6Q2NuUFJsVkFSUm1ONGxKTVJXN0R1YnlSVUttekZXSyta?=
 =?utf-8?Q?QFAhgyXAte2KD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWJ2SlQzdmIwVXhpKzk1emMvZTI2WjYwYTJiMFQ3ZFg4NWxJS3FOSHNWSTNo?=
 =?utf-8?B?cUZnTG5FY3dneU1US3pEWGxIa1ZPMGs0L3NQemVDM0VSUXU1TzZEc2VkTWxn?=
 =?utf-8?B?M2pQN0hHY2dpQ3RuVlhmbk1uQzRWa1JPd3lUc0lnUmNnU0JoaVJJTlJZcUth?=
 =?utf-8?B?M1BpcHNkNGh4ZU56UXFkQ1pFbkFMSFEycnJEWmJUVEVXSWJDQmhZT3RwekEz?=
 =?utf-8?B?ekxsWFpuanZMTDZjbjNpSHBycURVOVk2T0FpMTZHNjMrQ012Y3BEYjZzcW9h?=
 =?utf-8?B?cXNpVWtvZmVpd3NIdzE0bGE5SW1vcXJxY054dDhVZXdKeGl6a05KWkxkS0Vw?=
 =?utf-8?B?aC9LSk5TeWxya1MwWU5vaVhNZkFwZHNvUFI1VlZZcmFVdHRJa3NmWFhTM1V3?=
 =?utf-8?B?Z2tnUVhNdmZwaWczMy9qKy9FRnNFYkJVbTdPMEJoUHNxak5tdGhGS2tERFVh?=
 =?utf-8?B?aVBaWkVidno3L05PRWdwTFJHRjUvVGlTN01DNVkrZndzcFBnODNSZTdZcC9Q?=
 =?utf-8?B?cFVKa3R6WkphM1FPTnNYZFd5S21wVE9NQWJsdEFRYm8yOE0vQnZUdlVJRUVR?=
 =?utf-8?B?NmNFaGhWWEZIUkpBVnZNbS9hbFBvb0NXYU4wQWN1WForZjE2RWhkR3JyOHBZ?=
 =?utf-8?B?ZVd6T21ZQUU0WHNhcmFkQTZIZWRkOVhIWEI4d3ZGRVBVU2lCWkhTaEJqUHd0?=
 =?utf-8?B?RTE1RDVuajFBME9ZTC9JK3FiOFJpdzlJYXJiSUZFNU5adHQ0NjJzRi85Mkc2?=
 =?utf-8?B?UFJWZFArK2NSaWNadmFVdTMvWVlEZFI3NitoSHZFejQwcTRrbTJLK3lwbFY3?=
 =?utf-8?B?UTVOYmU0SlZTblQyN2N6NE9XbURjK3JWOGFmTmluR1daYitkTC9hekd6NXd1?=
 =?utf-8?B?enFaOXFFWnVnRTI2VnpuZU00c0phWVZKSmllUmtjUDRKRk8vSGxIbGowQlds?=
 =?utf-8?B?Qm1zSnJVMzEzR3VCMERKMzVuT056dnNRUjRYMXlEOWMrWC9WK05sY0lsTWZw?=
 =?utf-8?B?eFZaYlBUWlEvcW9ZQ09qY3BCM3lqYjdtWjJXUC9MQ0FuaFZ5RFRiZ1plMVpV?=
 =?utf-8?B?UVlkUnZtSXQ2eTJPSTlzUXZBMjZVQTdrOXBJazQxZ0VNb1hjeVRoQ3ZDSURt?=
 =?utf-8?B?aUE1eW1rV3k3M0hOTkNPV2pxN0dnM1pkZ2hrSEc5eXRjdXZDaHN1S2s2MWRz?=
 =?utf-8?B?Z2s1bGtRWW9iK3JOcXFFMHBRN01Ra1ZGOXFGbHJSSGU2K2doT1hJVVpHSGE5?=
 =?utf-8?B?V2RVODZYSXZXTmVzV2xNSm1PWjA1L29YRVJ3dE1JKzFJV1Zaa0J6NlFqWnhM?=
 =?utf-8?B?L1dQUlVCUitoUXJiTGhRazZWeVJGWnJmaCtCalJTeXZmaXByNlVMWHpjYkVO?=
 =?utf-8?B?V2lVd1p1UVk4MzRkZ1FQUy96UnVQN1dMTlVXTzJlZ29CKzhWSHVkMmVkdDdG?=
 =?utf-8?B?a0RETHROenpoU2loV1kxY3ZPbTV3VXBOYzg1WGRkMVI4U01WNUQzd2ljRk1E?=
 =?utf-8?B?TzY0VW9QOHc3Wktpb2Z1WG9ZL3ovVnRvM0IzM1FqV0VrWkVqN1JJcGl6SFN5?=
 =?utf-8?B?R0lXM3h6bCtkNHdydjRIVjRMSUhPWlVqSXI4SktRVkl2SExZYktDUVpOcHBq?=
 =?utf-8?B?YWszNmxTWUQwN3N4OWJ5c09NWEdaUlhzR2NlUFY3MzlJUzMzaE1DNW9JYUpr?=
 =?utf-8?B?cSsyWEQ2TE9pbStIM1dPcU11dkRsOGdPRG12VS9Bekh6TmRTWDJxZ0dLYjFy?=
 =?utf-8?B?djNmR3V2SG1SVEhQTjZnODBuQnJCbzJwMHhRa2d5T2NuVGttWWZpcGlHL0pM?=
 =?utf-8?B?K3VFMGp4amw0cjIwbURyUFo4Z0pqYTRFS3hTU2FvMW9oaVlZNkMzZitJaTdE?=
 =?utf-8?B?ZmlZQkpDaVE1dE9mMk9vZjlveE5oQW9YSk8vVmNnRnJiK0drMlNYdEg1SXBQ?=
 =?utf-8?B?eWlkSDFEUSt0RXVPQ0NySzRXZ0lpY0xPSm5tTkVzSklaazVCZW1MaFRSdnM1?=
 =?utf-8?B?UFFielcvZzZEMllFbGR2VFh3Zkp1N0JHLzdTa2tYK0NYWnN1S0Nlc0JvTzA5?=
 =?utf-8?B?c0NvTXJPVWNWWHhxS09lYy9XNXZkaHJLczJLLzRtaVVGVDRaQjRoWS92ZE8r?=
 =?utf-8?B?QS9sb09SaXYrTng5MEJQQi92ZG1tZUIxYjNmRkd5NW44ZWRLZjlFek45clpk?=
 =?utf-8?Q?E7md5yZwUEldKjAQHZcJ/ys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D7DEA0628776F42A8B314DACBE9569E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b263af6-0c33-4f9d-4bdc-08dd70f88da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 08:38:18.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXkwvZF6X34sBKCJM7J0qXJa5kJICEclu+a3HLryBkLxgBftAxiyGYNJMrkmtWC1/IizA85uonIvbTiOZ0zQu9HkOY9g4WPjie+Z2MTlZa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8859

SGkgQWhtYWQsDQoNCk9uIFR1ZSwgMjAyNS0wNC0wMSBhdCAwNjo1MCArMDIwMCwgQWhtYWQgRmF0
b3VtIHdyb3RlOg0KPiA+IEVuYWJsZS9kaXNhYmxlIHNlZW1zIHRvIGJlIHJhY3kgb24gU01QLCBj
b25zaWRlciB0aGUgZm9sbG93aW5nIHNjZW5hcmlvOg0KPiA+IA0KPiA+IENQVTAJCQkJCUNQVTEN
Cj4gPiANCj4gPiBpbnRlcnJ1cHRfY250X2VuYWJsZV93cml0ZSh0cnVlKQ0KPiA+IHsNCj4gPiDC
oAlpZiAocHJpdi0+ZW5hYmxlZCA9PSBlbmFibGUpDQo+ID4gwqAJCXJldHVybiAwOw0KPiA+IA0K
PiA+IMKgCWlmIChlbmFibGUpIHsNCj4gPiDCoAkJcHJpdi0+ZW5hYmxlZCA9IHRydWU7DQo+ID4g
wqAJCQkJCWludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKGZhbHNlKQ0KPiA+IMKgCQkJCQl7DQo+
ID4gwqAJCQkJCQlpZiAocHJpdi0+ZW5hYmxlZCA9PSBlbmFibGUpDQo+ID4gwqAJCQkJCQkJcmV0
dXJuIDA7DQo+ID4gDQo+ID4gwqAJCQkJCQlpZiAoZW5hYmxlKSB7DQo+ID4gwqAJCQkJCQkJcHJp
di0+ZW5hYmxlZCA9IHRydWU7DQo+ID4gwqAJCQkJCQkJZW5hYmxlX2lycShwcml2LT5pcnEpOw0K
PiA+IMKgCQkJCQkJfSBlbHNlIHsNCj4gPiDCoAkJCQkJCQlkaXNhYmxlX2lycShwcml2LT5pcnEp
DQo+ID4gwqAJCQkJCQkJcHJpdi0+ZW5hYmxlZCA9IGZhbHNlOw0KPiA+IMKgCQkJCQkJfQ0KPiA+
IMKgCQllbmFibGVfaXJxKHByaXYtPmlycSk7DQo+ID4gwqAJfSBlbHNlIHsNCj4gPiDCoAkJZGlz
YWJsZV9pcnEocHJpdi0+aXJxKTsNCj4gPiDCoAkJcHJpdi0+ZW5hYmxlZCA9IGZhbHNlOw0KPiA+
IMKgCX0NCj4gPiANCj4gPiBUaGUgYWJvdmUgd291bGQgcmVzdWx0IGluIHByaXYtPmVuYWJsZWQg
PT0gZmFsc2UsIGJ1dCBJUlEgbGVmdCBlbmFibGVkLg0KPiA+IFByb3RlY3QgYm90aCB3cml0ZSAo
YWJvdmUgcmFjZSkgYW5kIHJlYWQgKHRvIHByb3BhZ2F0ZSB0aGUgdmFsdWUgb24gU01QKQ0KPiA+
IGNhbGxiYWNrcyB3aXRoIGEgbXV0ZXguDQo+IA0KPiBEb2Vzbid0IHN5c2ZzL2tlcm5mcyBhbHJl
YWR5IGVuc3VyZSB0aGF0IHRoZSBvcHMgbWF5IG5vdCBiZSBjYWxsZWQgY29uY3VycmVudGx5DQo+
IG9uIHRoZSBzYW1lIG9wZW4gZmlsZT8NCg0KYXMgSSB1bmRlcnN0YW5kIHRoZSBjb2RlLCB0aGUg
b3BlcmF0aW9ucyBvbiB0aGUgc2FtZSBGRCB3aWxsIGJlIHNlcmlhbGl6ZWQsIGkuZS4NCmlmIHlv
dSBvcGVuIGFuIGVudHJ5IGFuZCBhY2Nlc3MgaXQgY29uY3VycmVudGx5IHdpdGhpbiB0aGUgc2Ft
ZSBwcm9jZXNzLg0KDQpJZiB5b3UgYXBwbHkgdGhlIGZvbGxvd2luZyBwYXRjaCBvbiB0b3Agb2Yg
dGhlIHByb3Bvc2VkIHBhdGNoOg0KDQotLS0gYS9kcml2ZXJzL2NvdW50ZXIvaW50ZXJydXB0LWNu
dC5jDQorKysgYi9kcml2ZXJzL2NvdW50ZXIvaW50ZXJydXB0LWNudC5jDQpAQCAtMyw2ICszLDcg
QEANCiAgKiBDb3B5cmlnaHQgKGMpIDIwMjEgUGVuZ3V0cm9uaXgsIE9sZWtzaWogUmVtcGVsIDxr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQogICovDQogDQorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQogI2luY2x1ZGUgPGxpbnV4L2NsZWFudXAuaD4NCiAjaW5jbHVkZSA8bGludXgvY291bnRlci5o
Pg0KICNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+DQpAQCAtNTYsNiArNTcsOSBAQCBz
dGF0aWMgaW50IGludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKHN0cnVjdCBjb3VudGVyX2Rldmlj
ZSAqY291bnRlciwNCiB7DQogCXN0cnVjdCBpbnRlcnJ1cHRfY250X3ByaXYgKnByaXYgPSBjb3Vu
dGVyX3ByaXYoY291bnRlcik7DQogDQorCVdBUk5fT04oIW11dGV4X3RyeWxvY2soJnByaXYtPmxv
Y2spKTsNCisJbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsNCisNCiAJZ3VhcmQobXV0ZXgpKCZw
cml2LT5sb2NrKTsNCiANCiAJaWYgKHByaXYtPmVuYWJsZWQgPT0gZW5hYmxlKQ0KQEAgLTY5LDYg
KzczLDggQEAgc3RhdGljIGludCBpbnRlcnJ1cHRfY250X2VuYWJsZV93cml0ZShzdHJ1Y3QgY291
bnRlcl9kZXZpY2UgKmNvdW50ZXIsDQogCQlwcml2LT5lbmFibGVkID0gZmFsc2U7DQogCX0NCiAN
CisJbXNsZWVwKDEwMDApOw0KKw0KIAlyZXR1cm4gMDsNCiB9DQogDQoNCkFuZCB3b3VsZCBydW4g
YHdoaWxlIHRydWU7IGRvIGVjaG8gMCA+IC9zeXMvLi4uL2VuYWJsZTsgZWNobyAxID4gL3N5cy8u
Li4vZW5hYmxlOyBkb25lICZgDQp0d2ljZSwgeW91J2Qgc2VlIHRoZSBmb2xsb3dpbmcgcXVpY2ts
eToNCg0KV0FSTklORzogQ1BVOiAxIFBJRDogNzU0IGF0IC9kcml2ZXJzL2NvdW50ZXIvaW50ZXJy
dXB0LWNudC5jOjYwIGludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKzB4YTAvMHhiMCBbaW50ZXJy
dXB0X2NudF0NCkNQVTogMSBVSUQ6IDAgUElEOiA3NTQgQ29tbTogc2gNCnBjIDogaW50ZXJydXB0
X2NudF9lbmFibGVfd3JpdGUrMHhhMC8weGIwIFtpbnRlcnJ1cHRfY250XQ0KbHIgOiBpbnRlcnJ1
cHRfY250X2VuYWJsZV93cml0ZSsweDM0LzB4YjAgW2ludGVycnVwdF9jbnRdDQpDYWxsIHRyYWNl
Og0KIGludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKzB4YTAvMHhiMCBbaW50ZXJydXB0X2NudF0g
KFApDQogY291bnRlcl9jb21wX3U4X3N0b3JlKzB4Y2MvMHgxMTggW2NvdW50ZXJdDQogZGV2X2F0
dHJfc3RvcmUrMHgyMC8weDQwDQogc3lzZnNfa2Zfd3JpdGUrMHg4NC8weGE4DQoga2VybmZzX2Zv
cF93cml0ZV9pdGVyKzB4MTI4LzB4MWUwDQogdmZzX3dyaXRlKzB4MjQ4LzB4Mzg4DQoga3N5c193
cml0ZSsweDc4LzB4MTE4DQogX19hcm02NF9zeXNfd3JpdGUrMHgyNC8weDM4DQogaW52b2tlX3N5
c2NhbGwrMHg1MC8weDEyMA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0K
d3d3LnNpZW1lbnMuY29tDQo=

