Return-Path: <linux-iio+bounces-25373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 799EAC0129C
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF8A4E7925
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C45313E21;
	Thu, 23 Oct 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xq4jOx3b"
X-Original-To: linux-iio@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5B30F947;
	Thu, 23 Oct 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222989; cv=fail; b=JFQJHKfr/M11HrcgXz9sSW9Ps5mfh/RZUJXMfA3T9jDPkseNk1xJGtR4/b+IJsTP1a6OZp5OvgpohIyUZAJ/Mfqn2l+JkmSgjbTGRmgGelYn10ZMDmCSc9dRbK8wVx3J9QxV2bMcixVg5WtBZyQsxHUrKsoqQicTPFudV7yApL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222989; c=relaxed/simple;
	bh=A4Die0uF+z7CktjwAPd/uyecKx+iSmmX3i4S3QfEiAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ukAnQj+YvwuU9H/UScWpMV6aqLeo1yBFGT+lsfnVh7GLIJKDTiwhfiBewYRBf/VzJt6XTKyhC6a/AAHI7vSdygvj5tOz/LvkzlPjDetOiBkP9bNN8ANuwab41OdqD9hY/VjHReWHFmRPuViKJN6ke2/5qWD32JXAhvHGPIPCBCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xq4jOx3b; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVc2HygXwNNPw584aQemoK/rQpIxvzcDT2tg2lhrfXrNcZKBnj8UStLKX8jFHqOqnzk+gRJjgbNMPG/ucmcNdBd7qGFi8Fv4GBev9D2nbM4h3Y1To955yqxhMNNgCshxIk/LMceOXIPtm8yrvSE+Uz3QcPS4iLt6CVo35OTEiGnFSA5SQ61bRjFVOmPDEfo9V/07GXQEGuXx/fAQX3rGWGI50WU9pxVT8LP1gOPZ3/eHe8IYsTJTeuPy7OANinZcIkKe484JRCda63/0ACo+LrH9noO1X6F1BxrrOxgyFyf7qVavx8lh4bHChIsxKAXWISBeRMwG5cQn7Z5bE6N/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Die0uF+z7CktjwAPd/uyecKx+iSmmX3i4S3QfEiAM=;
 b=VGv/5vf9EtRdPSucPqHFDwRv8H1jlPW09fh58GSxRxzphdPejfrhHyDNjf3iZImxZmsUVnARJVImtcEjvPJ/WUDVyBgDYcoDu+EPvHhP8i1k//97OL25JA4+WlxLD1+sdh69IfQnZn8dh13zJqHpCo27Q/uyOrBEuYVq1JDzT3EMM5dTBtjvI8GaBDmfxWMRBH5yc34WJrD1UhluP2XvE5sMGJUu7vy1brBvsuQNh/DZhjR991xDqb2OOJsL+JIxBG6g0N99tE5R58i0nyaKvfce3jKJCwO0QdUTZ+3OV7TbGE4Voh2qHV71halx9WbNYlDcwvNpF9hgquF4nFi4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Die0uF+z7CktjwAPd/uyecKx+iSmmX3i4S3QfEiAM=;
 b=Xq4jOx3bnc9rA7GpXpVlwKx8FnKe+vzJdqXKTUSyzJ/6N1UYbHmpoUcByPaM/6EyDtpQY5NdTUzkvI1FSJhVC1yOqBEL73iuF14OTCgS1YZX2FXsTrXMAAvCHOERzOsiVJKRa0Wx8WBjnvovpKiDLnLfJvSaJGP2JWeIloNv69RX2nXwzPj9fob0DO0mVJ3Z7BTw3kG8xpKQzM60CtoQU35H+FNLh15b30XO3mcV1Q+xbbvmE/fGWUbwEEwiBt328yi5FFwmeq9ooAQfAV739T8PFjqo3fzzidvPjt3Iq5vXhxZF4IIHaGiFZzGyoXQg6XoFMXyZ2NxUp5HFWo+YWQ==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 12:36:22 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 12:36:21 +0000
From: <Ariana.Lazar@microchip.com>
To: <linux@roeck-us.net>, <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <linux-hwmon@vger.kernel.org>,
	<nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 0/2] Adding support for Microchip PAC1711
Thread-Topic: [PATCH 0/2] Adding support for Microchip PAC1711
Thread-Index: AQHcPe+NH0OlRK/oF0qZo5vMEBjbZrTJS0QAgABLu4CABiBigA==
Date: Thu, 23 Oct 2025 12:36:21 +0000
Message-ID: <e1f58a61065a0a455cf05458780f8164f6d6e1ad.camel@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
	 <20251019113146.74c3f236@jic23-huawei>
	 <e4193c55-e2fa-4689-aae7-b0520909127d@roeck-us.net>
In-Reply-To: <e4193c55-e2fa-4689-aae7-b0520909127d@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_
x-ms-office365-filtering-correlation-id: ce5f7682-0fd8-4b3a-2e3b-08de1230c57b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mzd0eDlmNE1IUWE1T0NxeVFDOVd1dEdTMlBwM1JpeGlwMFl4S3NmYWRTbHla?=
 =?utf-8?B?VzBBcGRMOHJTaXd4OHU0NUY4QW5XZE9VcWxCeEVKeXpkK1pqY3NlVGJsemRC?=
 =?utf-8?B?dTRzeE9xbkgxNk9RU1lqMTBjOTdmVDBYM3dTazNGV21NWENTNDBHQ2pnN21q?=
 =?utf-8?B?T1V5SVFMVWpuSDVJT0hhNGwwd2hycVJ6VURDKzIvcFdiMGo5TlNGWW53Qisw?=
 =?utf-8?B?aTdPd0lsOC9NdGhMc3BEOHVJT09FM1ZUcnpBNmFkaU1PUlZVMHY0N0U3MVps?=
 =?utf-8?B?NG9wU29SQldBSDJKUGZ6Y1lRZS9MWk1UZ0F2MkNSOGlSa1BJbDBQK2RUbHFJ?=
 =?utf-8?B?M05xcU5yMTAzaGJ0K0tjTDZMUzlsR0d3VWNZKzR3cEJscDRpTUZ5ZUwzdURj?=
 =?utf-8?B?ejVEcHl2c09MWWptWFkvR0xESExHZzU4ZWlMeWsrcjJSQy95aTFmMmJnME81?=
 =?utf-8?B?OTZydXpRcEpQeXlrUitZOFAyVkVIK3dNV294RkpkVndsdmlXNmRYOEhYMEpZ?=
 =?utf-8?B?MUwrZ3RFMWNrUWkzWUZSd0xVbWYxYjZWaC8wWU54YmViNGJmUGZXKzhMVGpH?=
 =?utf-8?B?VXNYNHVkV0hMZHFZM0VPY3FSZlcxWW1yc2UvOG5JWHBqT2FzY0Q1WCtVSnlp?=
 =?utf-8?B?aVFPalo2VEkyUlJWcXVKVk1IL3NRR1Faa2JWNitnMUtRaWQ2T2x5Mkt3NU1I?=
 =?utf-8?B?QlFEV1RhSG1QQy9ncXBWYUlHM2Fqd2liQ2xVU1NZYUF0aENwWjRCb1hCTkR3?=
 =?utf-8?B?S1B6K2xKWEhXeTVlT0QrOG5IdVJTUWY1djJxOG5uTEZBYVNCMkc3bDErQ1lX?=
 =?utf-8?B?MnZNUG13Q3dBUWxIRlp2WERlejNPWnlLK0ZoOGxZblc1QWI2VGszQ1NKTTB1?=
 =?utf-8?B?L1dGMk1DVld3YjhVZTl4bDZyb0xmdzJpZTFsT0dHaEdPQjBPNTJPZXdZaE9W?=
 =?utf-8?B?QjhiSTNkSmRCSHRTNnV2WHFGZ0VQbHZFRVpsLzdqVTZ2N1k2TjdLRjdlQm1U?=
 =?utf-8?B?bjV4ejF6WUZxL29nenhhbFNSZEtwRnp3T1RpRDQ5UE04WTRUcEduQXpIN2NS?=
 =?utf-8?B?bFBTMDcwdU1PRlJWb1BXaitFVWhGalVmR1RmaE0vdGlncW01bkw3elQyTFdZ?=
 =?utf-8?B?TmlVQjFONjRQSlRWZFBhUS9yZ3FuaDZEVkZ2Yzdhb0pKenZYWVI5ZUk3Z3VL?=
 =?utf-8?B?VXgyZGl2OGVPYnoxQjFwbEVwRGhFQ2hVdzFiZ3hvblNvTTg4U09vWFV3Yk5s?=
 =?utf-8?B?Wmp0UWY2ak1PekZ6TGRXNmtjcEYzOUVwZXUybTVDai9xT2ZuN0RTVm12THhS?=
 =?utf-8?B?RXVEWjA5MVA2YVdHb1o4bnhHWUtHSk5ncVNPbXgyZE5ZTk50am9Jd2FDQ0Jk?=
 =?utf-8?B?V2tLL0dURDZKL2lxZDZRaCtka0tsUUZIN2s5bjVQN1l5THZ0N2JHNnhsVjls?=
 =?utf-8?B?clp6dFkvQVNVZTBHS3NhUHNLMFRCRGt5eHVKam9vQmdhQVYxY3VwZUJuUS8z?=
 =?utf-8?B?VWpVaEErTWU1MjRXa0RMajZIeFBEWkwwRG1peWdyakJES1RkSEdNc2J1Zy9G?=
 =?utf-8?B?ZFNuREVIbHh0SjBzcXJ5TmFFSFUzaDFod2gyYkNGYVBVRmNGS095dWMzU3ZN?=
 =?utf-8?B?OUVPN0JaOW1SRlk1YWxvLzhTWlcyaThRRlE0VlRzYmRkc0xKRTk5RVpjUGZH?=
 =?utf-8?B?MUxMdU94UmlIbDRMU2FneWJha0ZENmphaEVTMENXMVhXalBxRms1dUlHL1Q5?=
 =?utf-8?B?UWU2UFR5KzRPbHhCYlVDVEZxSTViekFSYlZOQy9WOE1xb1hPU1U5Y3AzSC9q?=
 =?utf-8?B?WWJNWURSeG1sT2NBYkZoZTFGUHdNZWYyS3FHRFdkNGVXM2FNeUpERmhacEVl?=
 =?utf-8?B?MHlrR2hUWUIzWDBxWTVKOC9ua0NhU21oaldkbHNXUldPQ0owaURQckxtOW9l?=
 =?utf-8?B?SlB1dGxubEQ2QUJyQmVOZnU1OGxxalVVUHZOaW1mcWxNRXk3UmFGYlpQSm9F?=
 =?utf-8?B?TE5DUTdkdHdJR2lvOEhHbm9jMmI0eGYzN3h5aXFBa2tUWkVJYVR4Z205SU5X?=
 =?utf-8?Q?yIidh9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2NXdEhyRmdsYktiVm40VVplamJ0VXpDV0tZeVdvWlE0SXlrNXlEWnJMcTBv?=
 =?utf-8?B?Wlp5UGkyVVpiY04rYWFiaTNhaVpUek8yR1VLc1pMU3RTZFpTR1RBQjNGck5t?=
 =?utf-8?B?N1c3UFo3WjBMWWhFeFozek5maHhMb2RoQ3VyK1FLa2xmaWFXV2ZQMDRnZHp0?=
 =?utf-8?B?ZWRZWkhSMjNkTm5Wckl1WGlBNERhZkIrRGw4UkZmTGt5NVU0K3duM1Z6N25Z?=
 =?utf-8?B?bzZEamxHSHNJWFFKOGFNdjBEQU1oUVNnK3kwekowNXRHRlFQWm5XUU1sd09p?=
 =?utf-8?B?Ry9BZnNhNXJ6RHMrOW9TNHIxRVFUWDd0Y3NuZVB6Y2pMZU1tZlVDd09zQUNN?=
 =?utf-8?B?N0cxdjFEQ2dEcldhSDdHa1lMRHhvNzVrYnk4aVh3Snc0Qnk5VGp5VDhIZFRO?=
 =?utf-8?B?aG5xeks3dzVFWEVXVzZTU3BnaEUzK0V2RkRLM0FibkdHMkJUU0gyTkp5cnQx?=
 =?utf-8?B?cno0VmtxOURKUzFoc1VzbCtYbXk0NjRCZHdhSGZzNUYxZjRUb1dad280dlpa?=
 =?utf-8?B?MTJMdWtXNU5FZmVBM2JUMWFlaS9QczV0UnRTWFFtZGV3UXVVSXZlMXVzTVFY?=
 =?utf-8?B?ZFBPeHhFbzBGY3pxZ05TWTQ3KzF5VGI3ZHM3ZUo2Rms4TlRtbnFrV2VONHZJ?=
 =?utf-8?B?UU02U1cwd0QrYzRzR2dESDN5Mjk2bUloc2J2dkQ4OXd4N3phb09NQVVKb1Y0?=
 =?utf-8?B?UDVjOEN6c3lWb1VIcU4rck1jL2NEY21vNHo4T1JpNFFOVWUrZ1VBR3pKallT?=
 =?utf-8?B?WUlzN0Z6ZWhBMWVkTjczN3ZFYUo3ekoxYjN1UWZaeVYySDFjeFpieHhVdDhw?=
 =?utf-8?B?MmJiT25NM09pUXpaa1dmUGd1L0IrMkNNQnF2NDVBbVBEd0RNSWYxcjhHS3pq?=
 =?utf-8?B?OVBrVkhVRE4rOFNkRkpqME1mclc2WjhoT3hHSlFBVVlUd2F3Y2dHU28rRlBX?=
 =?utf-8?B?MjMrUkNiY1VrMkppWE9lUzdjZEIwNW5lN2NQYTRoR0hwUFRtdDZ0NUtBZk91?=
 =?utf-8?B?Z3JscGpvZFYwL0lpOHdkZVZCWEZvQkNrQlR5WUlmd2FlZklaYlhPSUdYN28r?=
 =?utf-8?B?ejVtVEtSc0VSek40L3hvZ2hudGdNWkpCeUF4OEtPNmduWUlmUW85SzNzUDZn?=
 =?utf-8?B?eHZKQkZpWjljQ0VBTWwyYjFHZUNkaldoa2p5RHdjQ1c2YVl2c2lRSWc2UGZ0?=
 =?utf-8?B?R1NJWkhVUEZJYVdKdEJRU0RGay9ETDVSM3Zmc0ZmKzZ5NWprV0xDZE1hTEJj?=
 =?utf-8?B?T2lWUU4yRVl2M29MdDl5dDVJMDM4Zmo2RjZjUUFjaDVKTzRMa2p0ck9ObXd4?=
 =?utf-8?B?ZktUbTNvYUxNdzN3M0tKYXRZYldBMFRrMWdHekliSWpPSmVValcxbnFDYy9P?=
 =?utf-8?B?REM2Y29wWWVybGgydGtkVWlEY1lLSkU4dTk1YVF1WE1kc25EOHNNTnBBR09z?=
 =?utf-8?B?UHVHdVdiT3VNODFsU0VNWWVjSGNSb3U4UTV0K2V6RXVBQVgrREJOZkJLblJp?=
 =?utf-8?B?T0tsWloyak1SOHpjcmpCSjl2YXZFeUJsNFVLeWZrMjNHWXV5NnVCQWo3M2FU?=
 =?utf-8?B?ZGRqejZZNjFxNCtPdWRWbHluNnVPUFJ5cExpZjZxT2UrZDZpU3ZXTUszRW4y?=
 =?utf-8?B?T1N4MHVJK2d3c3lLUUluYU9xaUg1SDB4OUFEWG80NnZQOURUUGg4M2RSNHBv?=
 =?utf-8?B?UzZOcWtmSHNxZ2JTU0JtbWF5U2ZKVHZiTlcvM2VMLytwbzU2bmxQMXJ4UEor?=
 =?utf-8?B?bnNsQzRRSk54L05ETENvK1ROT2UvaTZNb3J3a1hPTGtaUUVvNnhDaWp6ZTNH?=
 =?utf-8?B?UVFVVlI2dHN4S0JTR21oVkI1VE1XY2tiWjc5UDE1QU5mOWtpS3hSOE9SOVIy?=
 =?utf-8?B?SXhYUm5qZXZPTG5MOU10RkFoVFgxMXI3bHNFc013VmFITTFrL08rN09oM25w?=
 =?utf-8?B?Q1lES0ZHeEk2Ykp4R2I4OVByS2U5c21KVlQrSjFFbm15ZmF3S2MyVEJiVUQx?=
 =?utf-8?B?Z1Zyajc4WWprekFycXltTkN4dzhTNHMzS1dGY09mcCs2WURIalhTMDZ0elZH?=
 =?utf-8?B?Q1g1VWNLNkMvUTVMa3ZxcUxMallYNXBwaFFOWlNZMHh0c3RDYVJGNVhlejlr?=
 =?utf-8?B?a2lxSzlPWVcxMmdDOVVLM1cwT0pYcExZekNnWmlKRGZZd2p3YlFldDhxTVhr?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D97A0DC6B424604E8A7549EEB34DF92A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5f7682-0fd8-4b3a-2e3b-08de1230c57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 12:36:21.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnjZv/xDwQPyZbovuad8fEX1VUlTkjGtwT7y2pQBcRaYNNNvu0dUAIzN9O8VE2bTCQjisHSmsIEYAfX3Wvof+7w2zaf5pdRIXKKPyKqnHvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251

SGkgYWxsLA0KICANClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLCBJIHdpbGwgbWFrZSBzdXJl
IHRoYXQgZm9yIGJvcmRlciBkZXZpY2VzIEkNCndpbGwgYWRkIEhXTU9OIGxpc3QuDQogICAgDQog
IEkgd2FzIHRoaW5raW5nIHRoYXQgdGhlIFBBQzE3MTEgZGV2aWNlIGlzIG1vcmUgc3VpdGFibGUg
Zm9yIHRoZQ0KSUlPIHN1YnN5c3RlbSBmb3IgdGhlIGZvbGxvd2luZyByZWFzb25zOg0KICAtIGZp
cnN0IGJ1dCBub3QgdGhlIG1vc3QgaW1wb3J0YW50IGlzIHRvIGhhdmUgdGhlIHNhbWUgQVBJIGZv
ciB0aGUNCndob2xlIGZhbWlseSAod2l0aCBzaW1pbGFyIGZ1bmN0aW9uYWxpdGllcykgb2YgdGhl
IGRldmljZXMgZnJvbQ0KTWljcm9jaGlwOw0KICAtIHNlY29uZCBhbmQgdGhlIG1vc3QgaW1wb3J0
YW50OiBXZSBhcmUgbG9va2luZyBhdCBQQUMxNzExIGFzIGENCiJzcGVjaWFsIiBBREMsIHRoYXQg
aGFzIHNvbWUgc3BlY2lhbCBjYXBhYmlsaXRpZXMgbGlrZSBoYXJkd2FyZSBsaW1pdHMuDQpUaGUg
UEFDMTcxMSBjb3VsZCBoYXZlIGEgc2FtcGxlIHJhdGUgb2YgdXAgdG8gMTYzODQgc2FtcGxlcy9z
ZWNvbmQgaWYNCndlIGFyZSBzYW1wbGluZyBvbmx5IHRoZSB2b2x0YWdlIG9yIG9ubHkgdGhlIGN1
cnJlbnQuDQogICAgICBJbiBjYXNlIG9mIHNhbXBsaW5nIG9ubHkgdGhlIGN1cnJlbnQgd2UgaGF2
ZSBzb21lIHJlcXVlc3QgdG8NCmJlIGFibGUgdG8gcHJvZmlsZSB0aGUgY3VycmVudCBjb25zdW1w
dGlvbiBvZiB0aGUgZGV2aWNlIHVuZGVyIHRlc3QuDQoNCiAgSSBoYXZlIHN0YXJ0ZWQgd2l0aCBh
IHNpbXBsZSBkcml2ZXIgKHRoaXMgb25lIHRoYXQgaXMgbW9yZQ0KYXBwcm9wcmlhdGUgdG8gYmUg
YSBIV01PTikgYW5kIHdpbGxpbmcgdG8gYWRkIG1vcmUgZnVuY3Rpb25hbGl0eQ0KbGF0ZXIgKGxp
a2UgZGF0YSBidWZmZXJpbmcgdGhhdCBpcyBxdWl0ZSBpbXBvcnRhbnQgZm9yIGV4YW1wbGUgaWYN
CnNvbWVvbmUgd2FudHMgdG8gcHJvZmlsZSBjdXJyZW50IGNvbnN1bXB0aW9uIG9mIHRoZSBwcm9j
ZXNzb3IgaXRzZWxmLA0KYSBwZXJpcGhlcmFsIGRldmljZSwgYSBiYXR0ZXJ5IG9yIGFuIGluZHVz
dHJpYWwgbG93IHZvbHRhZ2UNCmF1dG9tYXRpb24sIHRoaXMga2luZCBvZiBmdW5jdGlvbmFsaXR5
IHRoYXQgd2FzIHJlcXVlc3RlZCBieSBvdXINCmN1c3RvbWVycykuDQoNCkJlc3QgcmVnYXJkcywN
CkFyaWFuYSBMYXphcg0KDQoNCg0KT24gU3VuLCAyMDI1LTEwLTE5IGF0IDA4OjAyIC0wNzAwLCBH
dWVudGVyIFJvZWNrIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4gDQo+IE9uIDEwLzE5LzI1IDAzOjMxLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+
IE9uIFdlZCwgMTUgT2N0IDIwMjUgMTM6MTI6MTQgKzAzMDANCj4gPiBBcmlhbmEgTGF6YXIgPGFy
aWFuYS5sYXphckBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBQQUMxNzEx
IHByb2R1Y3QgaXMgYSBzaW5nbGUtY2hhbm5lbCBwb3dlciBtb25pdG9yIHdpdGgNCj4gPiA+IGFj
Y3VtdWxhdG9yLg0KPiA+ID4gVGhlIGRldmljZSB1c2VzIDEyLWJpdCByZXNvbHV0aW9uIGZvciB2
b2x0YWdlIGFuZCBjdXJyZW50DQo+ID4gPiBtZWFzdXJlbWVudHMgYW5kDQo+ID4gPiAyNCBiaXRz
IHBvd2VyIGNhbGN1bGF0aW9ucy4gVGhlIGFjY3VtdWxhdG9yIHJlZ2lzdGVyICg1Ni1iaXQpDQo+
ID4gPiBjb3VsZA0KPiA+ID4gYWNjdW11bGF0ZSBwb3dlciAoZW5lcmd5KSwgY3VycmVudCAoQ291
bG9tYiBjb3VudGVyKSBvciB2b2x0YWdlLg0KPiA+ID4gDQo+ID4gPiBQQUMxNzExIG1lYXN1cmVz
IHVwIHRvIDQyViBGdWxsLVNjYWxlIFJhbmdlLg0KPiA+IA0KPiA+IEhpIEFyaWFuYSwNCj4gPiAN
Cj4gPiBGb3IgZGV2aWNlcyBsaWtlIHRoaXMgd2hlcmUgdGhlIGRhdGFzaGVldCBleHBsaWNpdGx5
IGNhbGxzIG91dA0KPiA+IHVzZWNhc2VzIGluDQo+ID4gcG93ZXIgbW9uaXRvcmluZyBlLmcuIGZv
ciAiUG9ydGFibGUgYW5kIEVtYmVkZGVkIENvbXB1dGluZyINCj4gPiAoYW1vbmdzdCBvdGhlcg0K
PiA+IHRoaW5ncykgdGhlcmUgaXMgYWx3YXlzIGEgcXVlc3Rpb24gdG8gYW5zd2VyIHdydCB0byB3
aGV0aGVyIHRoZQ0KPiA+IGNvcnJlY3QNCj4gPiBwbGFjZSB0byBzdXBwb3J0IHRoZW0gaW4gTGlu
dXggaXMgaW4gaHdtb24gb3IgSUlPLiBOb3RlIHRoYXQsDQo+ID4gd2hpbHN0IHRoaXMNCj4gPiBo
YXMgbG9uZyBiZWVuIGFuIGluZm9ybWFsIHBvbGljeSBJJ3ZlIGJlY29tZSBtb3JlIHN0cmljdCBv
biB0aGlzDQo+ID4gYWZ0ZXIgc29tZQ0KPiA+IGNvbmNlcm5zIHdlcmUgcmFpc2VkIGluIHRoZSBs
YXN0IGN5Y2xlIC0gdGhlIHByZXNlbmNlIG9mIHNpbWlsYXINCj4gPiBkZXZpY2VzDQo+ID4gaW4g
SUlPIGlzbid0IG5lY2Vzc2FyaWx5IGEgc2lnbiB0aGF0IHdhcyB0aGUgcmlnaHQgY2hvaWNlLCBi
dXQgaXQNCj4gPiBpcyB3b3J0aA0KPiA+IGxvb2tpbmcgYXQgdGhlIGhpc3Rvcnkgb2YgdGhvc2Ug
ZGl2ZXJzIGFzIGl0IG1heSBwcm92aWRlIG1vcmUNCj4gPiBpbnNpZ2h0IGludG8NCj4gPiB3aHkg
dGhleSBhcmUgaW4gSUlPLg0KPiA+IA0KPiA+IFRvIGFkZHJlc3MgdGhhdCB3ZSBhc2sgdGhhdDoN
Cj4gPiAxKSBEcml2ZXJzIGZvciB0aGlzIHNvcnQgb2YgcG90ZW50aWFsbHkgYm9yZGVybGluZSBk
ZXZpY2UgYXJlICtDQw0KPiA+IHRvIGh3bW9uDQo+ID4gwqDCoMKgIGxpc3QgYW5kIG1haW50YWlu
ZXJzDQo+ID4gMikgQSBqdXN0aWZpY2F0aW9uIGZvciBJSU8gbWFraW5nIG1vcmUgc2Vuc2UgaXMg
aW5jbHVkZWQuIFRoYXQgY2FuDQo+ID4gYmUNCj4gPiDCoMKgwqAgYmFzZWQgb24gd2hhdCBjYW5u
b3QgYmUgc3VwcG9ydGVkIGluIGh3bW9uIChoaWdoIHNwZWVkIGNhcHR1cmUNCj4gPiBiZWluZw0K
PiA+IMKgwqDCoCBhIHR5cGljYWwgaXRlbSAtIHRoYXQgZG9lc24ndCBzZWVtIHRvIGFwcGx5IGhl
cmUgYXMgaXQncyBvbmx5DQo+ID4gMjAwIHNhbXBsZS9zZWMpDQo+ID4gDQo+ID4gQW55aG93LCBJ
J3ZlICtDQyByZWxldmFudCBmb2xrIHNvIGlmIHlvdSBjYW4gcmVwbHkgd2l0aCB0aGF0IGluZm8N
Cj4gPiBoZXJlIHRoZW4NCj4gPiB0aGF0IHdvdWxkIGJlIGdyZWF0Lg0KPiA+IA0KPiBUaGlzIHNo
b3VsZCByZWFsbHkgYmUgYSBoYXJkd2FyZSBtb25pdG9yaW5nIGRyaXZlci4NCj4gDQo+IEd1ZW50
ZXINCj4gDQoNCg==

