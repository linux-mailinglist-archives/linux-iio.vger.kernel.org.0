Return-Path: <linux-iio+bounces-4610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB48B4DC6
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 22:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72AA280F87
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C5745F0;
	Sun, 28 Apr 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PP99OT0G";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6mx00OsA"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDA745F4
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335916; cv=fail; b=SE2zYSC6dAa/HgfB1W90XrKJlBM9In/R0tm/HodV0eyRqtG9DZwQw8dvINv9p+en4960/5CyZ+yLKy9QaC/pJUyRugbGazS9JA5Rb/tQsKidWVe68ujMkUa09c+QR/bDQrOW/p6/2Y9UUkMga6zXgsScVaYPI277zeHPQnpAVxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335916; c=relaxed/simple;
	bh=eLfWoup3jivx2+0IU8aZN48dhKjFtYDBPAhjcj1YkiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDQ58P7Y36CdL4pqtOcH5AEb8TFPBcsCN0jrYp1am930xjjI6p51wtlZoVuQUqUxpOWtRoi/uFAyaSaKpxvitq2pyh1QVshmqdanEp3PrZFkqZ7xlCS2yzRyCVk8/Mt1+QiuzZg5BKv9ecOk7nyZlr2mVjUy4AvZYkjQ50msTAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PP99OT0G; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6mx00OsA; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714335915; x=1745871915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eLfWoup3jivx2+0IU8aZN48dhKjFtYDBPAhjcj1YkiM=;
  b=PP99OT0GdcgNRR57Dq8bMOTgx4mHSdC6VznX+FL0ra+RZt1VM395KQmJ
   R14wb7btNol8W64FSLduMLzoDdIJrIUSKg3tYaE8BnsvgoS6AW7/9Bhbm
   bxEKjkv0eSj/tmjRqLI3sFoGlw8kzOWD2H+qzyE3Db6aU0Rd71fpBrE1g
   CWMdh0Axr9RMirgumDRi8nW7eNFWXREWA1nIDTBXMI7QtptOuyXmD3y7C
   /dPNH+20cGaRUSh1B6AQi+NjGoOn2j1A/r37zAFb/gwzT1bJqW+7bBYH9
   L2Z58RWjMTrel8nXsOR6F+0M3V+5fEtOo7LDJGEq6wr78Tn2HUrBnxssx
   g==;
X-CSE-ConnectionGUID: a8AKln17TNW1PuSuJuAwbw==
X-CSE-MsgGUID: oZBrvnHcQDefCnTZw7yJfg==
X-IronPort-AV: E=Sophos;i="6.07,238,1708412400"; 
   d="scan'208";a="23120879"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2024 13:25:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 13:25:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Apr 2024 13:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJQoTNPK5hcNTI0isz53BKdHOYl/EEvkkKPzwAGLiWmDgIMt6CEBUAQjtAbLM6J7UBetuWEdMoE8M5rNp8r2cN0rdlGJlgzxhNPZRsGwyLQzSaaD1SaR2pNdivhawOeLspd2+T6BkCBS1PlV8Hci/zAOZflLx6eENpAL7LnXJn+PeuyUEZAL/3vOvYhrzf2XZ9o00IHNMEqHrExvw3NuncRAfevvvf9k/IOyqVOQ9M/GnGLCE88jK5irAKEko2cXFcwnCReOOvseBGAserv07rp36mrSUYji2ZIopJm8E9YPCul4kZ+ZZFEGFt2aP6b0ku5PFUefJWBPJkMFrR5ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLfWoup3jivx2+0IU8aZN48dhKjFtYDBPAhjcj1YkiM=;
 b=UabmEhdPRe+d8QPYw+N+OiwQha+iMiy71cjCB+y/pkhnCeCghuiGv+La5h0pa7nlrbzlUf91RINJjfsaCi+9S/KU3sC6vj/iJRV0EqiOTPXBNFKjMmpAHmFcr1ik2Fdn+ibrkX65I+3jIOvFvseVbQoRQOMXe0SCoozg1xmfnWZ4HGrs4Xhz+6A5wdbLiIYxo5Wprre44bHrXdlTsmfbk2RNEI9uJVhpIBhimwwzjq9dWGNZ1I9MvrGZ/GL/KlgGxGOSxTA2zslazO/LZUHs9YaTxmCLycB9zPExASy/apUsOcH2yYgw578gFsWmaXI5LN+6F1WRp+fQbGz3zK+Htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLfWoup3jivx2+0IU8aZN48dhKjFtYDBPAhjcj1YkiM=;
 b=6mx00OsAwu+xIQ8BM/WS6FX09JnDJPtpdzxD+yNsyqfSnIqyKd4VeXnU1oJ7kEU0txOBrw3ImWOtSq60sAMpG3/o2m5PRry98/FyPGRTGwO0tXKJ5x/0a0njqeWay24wTh10k0GoFcTRbhsxmR7uUCXrEDum+qHqRma+uXD23L5Ja9VZaGVHkTm2R5sX9JreQPPGwYyDIBJdpZpCW5qHxFW5LOcWb+0AveQ2RY+BiDYJtzEXoxzV6MVpjyuFbohPjGkVUHFMwEcL2c1icxhU6Hji8T2ei7sWcxVO40/Csjc8zYHXrWUbeI70m+xqIt4zRlRaN+7WqR8hjUsau3t71A==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by PH7PR11MB6748.namprd11.prod.outlook.com (2603:10b6:510:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 20:25:01 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::f51e:eaf:3934:dba3]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::f51e:eaf:3934:dba3%5]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 20:25:00 +0000
From: <Marius.Cristea@microchip.com>
To: <marex@denx.de>, <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 1/2] iio: adc: mcp3564: Use
 device_for_each_child_node_scoped()
Thread-Topic: [PATCH v6 1/2] iio: adc: mcp3564: Use
 device_for_each_child_node_scoped()
Thread-Index: AQHamZMy18JTQbSJC0S0aQdq6bMgj7F+ISGA
Date: Sun, 28 Apr 2024 20:25:00 +0000
Message-ID: <c6fb32ae909811e441cec9da5c52501d41b53ec6.camel@microchip.com>
References: <20240428174020.1832825-1-jic23@kernel.org>
	 <20240428174020.1832825-2-jic23@kernel.org>
In-Reply-To: <20240428174020.1832825-2-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|PH7PR11MB6748:EE_
x-ms-office365-filtering-correlation-id: 28e6596e-1da8-4c0c-35d4-08dc67c14760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?anV0cFUzOVNweWRPUnpUV3pSQTdNelgzVmpwaHIwL2FpVkxpc3pRM1NENXgv?=
 =?utf-8?B?blZtU0RzTEF2U3l0U09Ec2pGemFadjdSNjd2dlQyQVFsWnFpTWNzLzBTQlEz?=
 =?utf-8?B?Z0hZWjhwRllROWNCdUU1YVkrczdnVC9RQjNYbEVWT1NLTE5CMTc5NWt3dWVN?=
 =?utf-8?B?T3R3c2dhcndSU1R3dktXaCsreUxqWUtkZDRCZDFkdGNNV3g0QzRPMjg1OU9Z?=
 =?utf-8?B?UXhGRGdIZDFveTRtc2tFOThBVWRhRnh6U0NZWWpSU3BnNXJPUitqdm5kR0xk?=
 =?utf-8?B?Y0Q3MWRUeWlQbERINC92Q2U0bUU0VFZsOXE2NzZudXBSTWtwV3MzOVAyY1dN?=
 =?utf-8?B?ZjlRVHZkQnc4SGxiZms2ZFZ4bDdhVm9JemlIb2dRUzE2M0g4OGxZTzFvcksv?=
 =?utf-8?B?NkZoSm93ek45TjdUcm1qZzlSbWRwVXc3TzllVVRyQ3M0ek5WWEpqd0FkNER3?=
 =?utf-8?B?bnRObSszam9ZWTZHWm1mb0RDNk1nZlhsdTd0dUExcmVZYVhBbVdJUzYxRHM1?=
 =?utf-8?B?SmtoZS8rMGZHZ2pMK2YyYlhMMkwwTzhWWmZnRzZITGdrSXZnbzlZTTUzaWFS?=
 =?utf-8?B?MWV6RmorZS9tOEdKT09BbStIQm5zc3gxVFkyWkxlYzN2TjdNODlXM2Nkd3la?=
 =?utf-8?B?bzRJMjlpMW5VVVFhNVpnUjVEd2h4ZkJiV1hJTGgxSnd6dndYNC9KL2dSbFlX?=
 =?utf-8?B?NkEzUXFwUlVtRlZGY0k3WWNrM3dYK0UyZmZweVNEYnZxWC9XeDlRNTNLRW50?=
 =?utf-8?B?KzVwTytCdUhIc2xoNEpoajdQYkF6MHpqc3ZSK0xBN05heTBrMmZMYXdzZVBp?=
 =?utf-8?B?c3BmanlzSEVzN0UraWppZ0krSWFvWDc0WXViNzJTQ0RDK3hiUEg2RDNMWlVS?=
 =?utf-8?B?T0lpQnltQVdSMXA5cVFzL0pEbDA5MDMyYTF4WnFEaVBCdTd6SkZZdURDaUtS?=
 =?utf-8?B?Rk96QjlOY3hzV2FCMngyWjJOdkJiSVJtVURRYy9FSXBXcGcyakRiU1o0Qjg5?=
 =?utf-8?B?TmYzWEdtSGtQTmJRVWVJZzVZMDJZWEg0MHBwWXl1S1U0Tmt5KzZRU3RvRTlC?=
 =?utf-8?B?cHpiU2pVMUlGYmxwbHhETEs0eGJlMS9ZWTNmRmxHdExyNlBPUnhPNE80V3k1?=
 =?utf-8?B?ZnkzaTZIN2FPUEFlcjBFcTRhMGlYL2Q1Y0lRUExaaFZna1I0blBHOC8vZ0Ra?=
 =?utf-8?B?cm9ndjlMY1dJK3ord25LOThWL2k3UkZrbGNqNDFaQ2dJRlF5SUdlUnBWUnYv?=
 =?utf-8?B?clBRQUVNM3JtUm5kdXhEU0ZEYndZVm5BVkxncHAwODY3d3Z1SFRKdzc2RUxh?=
 =?utf-8?B?Uzd2T1o4akRkeVUrRkJUTnQ3RTEvUEEyZFp2c0dFZTM3M0lJRUJJRVNxOGp3?=
 =?utf-8?B?UHlIUU03UklDQ0o3VTJzcnlXcGtPMkZPaGpLU2o0Rk1zOWRPOW1mK21OZGxQ?=
 =?utf-8?B?UXZJMWVqKzViWkhMV1V1LzFLaUU5TlNtM2FMTTlzUzU0UmZMUU9mQ3ZqaXNv?=
 =?utf-8?B?V0lMamE5eGxLZFNBSDUwdXlpdXoyRnpQci9MMnZ5aDRNUEh6VGlocVdJM1JF?=
 =?utf-8?B?U1IwaTZOQUJDZ1NiSGV6Tlp1NXJvanRyRzBMZ1dmR3VIanZkTkRsOHpjdlBo?=
 =?utf-8?B?M0NyM0paYTdmZytGUjN2MkxVMVh4RjZuMkVhU1J5Z3JUSVpqZjBQc1V5U3lX?=
 =?utf-8?B?ODA3UDZEamRDcFc1Tk9zUUdmeFYwU1BmOTR1d2FMNklSVGRveTVHRmdqaTdu?=
 =?utf-8?B?STZjVFZ3Q1hpc3dxdFRHU055V1RVOVgzWFNETTZmSDZCaDhtaUh2RmR3dUlj?=
 =?utf-8?B?Ukc4VEZJSGtPR0NZeU80Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFpQOFEvWGcxandzbjh2UmpvUTVpeXFydkMzT1hYYXNrMnhydk9SbFY0N3Ix?=
 =?utf-8?B?ZlRjZUE2VWhQWndjay9FNGtCZ1RpMzhoL1IzY0lnZEZERlpGMlVhQzljaFBa?=
 =?utf-8?B?V0M5T1czY3ZhUXpkZVlKcVZBRXlaVllnVktDZWdIQ1BEZ001NEMwUGRuZlRq?=
 =?utf-8?B?VDkra3VLSTR1VGNyS09kRmFsVlZwUDErdVlJSVZNTmR0TFJMNG5BMG85OE1E?=
 =?utf-8?B?aWh3bVZMUHN3WS9qZWQvaDBPTDBpeGdsbUVaL0hVRVNuN2pBT0Jtb1NTcHVD?=
 =?utf-8?B?YmJDNmJDbGx6UlNxMkxOV01sbGxhZTBpdHdBOHRwOWI2TFdoWmM4RGlYSElq?=
 =?utf-8?B?bkRzRVFETWorNUl2Y3cxT04yV21aUHdnSHRwT2xSYXFFZzBFUUNkUmxUZyta?=
 =?utf-8?B?S2FZWkdhQW0xTElJUmNSRldJemhqWWJpTGZ6VHZvSkFGZTBJNlJpeGl0dEtI?=
 =?utf-8?B?dnVsSGtBd0REOXFmOWlGdHhqSlBzQmtDUE9pN2NDMGVicm1UUjB1WEFUUzFz?=
 =?utf-8?B?dUhOQ2RUQzZxcUhLMlkxV011Si9CU1J3VXRVNTlzaDVmcS9IMVRFUnBSUHVH?=
 =?utf-8?B?Vno3NjBmNHgwN3FqY04vcktYWXpGWE52Y0V0WVJzbFBwMmJoOEo0V1JFQmVO?=
 =?utf-8?B?RFpIeEU4NXR6Rytyc1YzOG51dlpEdEZEU2s4Y0thTEhNTC81N3JvZ2psTnR2?=
 =?utf-8?B?VHRscVRaN213VGJYcnkyRDVvSGJHdDlzcktaendubndneEdKaDNTWDVNaWlk?=
 =?utf-8?B?TWJzNzRpMTdtZGhHZnlodkZKV0xMR2hqVldMdG0xQjgvWnpxdExUczdHS1cz?=
 =?utf-8?B?OGxtT0VURHhEajZkbFRpbnJnSkk3eHYvUUcxbE5rMnZ1OW1IdVBnckZrbjk5?=
 =?utf-8?B?SWM1RDY2bXArU1hHdzdEVGt1WWJFVGx2aHc2NUNaZmZVVGxmdXRqbzNmNXFO?=
 =?utf-8?B?Y2l0MkYwc1Qvb3J4MGJ0cFhuUlNlM1g3NmZ6TnE5ZlpBVk0wME5pUHN2Y0Jz?=
 =?utf-8?B?OHlnRVh1Ym9nRTMyMm5WT3pCb1Q5eHRWSnNJTGh3Q1IzZzhVMllQZjY0Mzl0?=
 =?utf-8?B?ZGR3OXNWeGtzMEY1Q282NGVvR1o2b21FRkpIWUJpcnQwRmJ2ZmNkNVFmbWEr?=
 =?utf-8?B?R0hQT2pQVytLRUtrUGxBVzJXZFZFWmRTeG15TjhMRGwzRy9MOC84L3piUi9T?=
 =?utf-8?B?N005ZDNvZWhIYjNDTVZKZ3RhLzEzWFNGWERjeVpZeDRwbUoySDUvdXJqYW1P?=
 =?utf-8?B?ZUFIQUY0VDVkcGsyMEJlSENScTBtNFFRN1YvSzlQczREOE5UWWFqZGJML0dz?=
 =?utf-8?B?ZGh6VWhaWmxya2hVaGFDUmo0azBXTXZGTTJWV1oxUWZBZnczTWRHNjZJakdt?=
 =?utf-8?B?aGFtTWhBZlJMTzV1cVhweXNDeWNLSTU0Rjg3MS9jcGhTNTFNUUJTenZqQkEv?=
 =?utf-8?B?V0lFNzVWYU81cDk5SmtHQXRuajM3d3FpaWR2bm5zZUhXVTJBRGpkbjg3WVdR?=
 =?utf-8?B?OXBtR29PeitCSmEvYURnaTQzTldldHpzbTE2TVV5M25WdUpNcXU4djJCOHhT?=
 =?utf-8?B?ZWczNExZSG5hUGM2VG90eFBwam5QQ08zbFcwZExYZXIyd25FSXpNdSszTDYz?=
 =?utf-8?B?YUExOEVSRFVoc3Axa1dMYjcySVAwa285aFlTenMwV1FySlV2MjQyZDNFODRr?=
 =?utf-8?B?algwSHZ1d0l6SXJKZ010aEN5OUV1bGoyN2Z0dnZjYWtkL3kxSzJBS0VDRVR3?=
 =?utf-8?B?bWlERXJiTTZ0dXk2NTVlNTBlb0hiQzM0S2twdlkwYmp5SHlXdGEwZTFzRjlj?=
 =?utf-8?B?VW5VelR2VnFjWS9lMlRseEI1VTVlS1JQSGgvQ0JqNHR1MElJY1RLMDQ1WVhx?=
 =?utf-8?B?MnVEOXBaMDhKNndaSXdMNndhUGREdG5HM0JkL2hvdjdqYTZpVkF3bnVsbW5H?=
 =?utf-8?B?RVJrYmhKWm54WFVSd0RWMzBtNzFrNTNvenBNakxzNnBmbkd0bDBSVzFqTXp4?=
 =?utf-8?B?TzRxbVVnZTc4VEhDU0RyZGwxM29veDNZM1NWQ05nWFRvRlpuV0FVcUZSYndK?=
 =?utf-8?B?MVlLM1JUemgvVGJDelJIcUxRNS93elBxa0g5akp2NlhXMGRpZ3plc1NKOWhw?=
 =?utf-8?B?YjkxNHlEbEQzTVdxdDJqMWVmZmJ4b1VjbTJQelRMMm9nVFlTcnNtVG5NNXVF?=
 =?utf-8?Q?d95YelskgKb5toKjjjKAZqM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AEA5A880938A542B055D396EE16BFE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e6596e-1da8-4c0c-35d4-08dc67c14760
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 20:25:00.3427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29j2afza2HQ9Uh+DanQAX85XXXy0LEcv5kFLpQ2ojh++IfHrB864NFNMed2le4z0ZBZWKMIt2NtU7knPulOy4Nc+89BIoNCfwxatreRwR28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6748

CkhpIEpvbmF0aGFuLAoKCgpPbiBTdW4sIDIwMjQtMDQtMjggYXQgMTg6NDAgKzAxMDAsIEpvbmF0
aGFuIENhbWVyb24gd3JvdGU6Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UKPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUK
PiAKPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
Cj4gCj4gU3dpdGNoaW5nIHRvIHRoZSBfc2NvcGVkKCkgdmVyc2lvbiByZW1vdmVzIHRoZSBuZWVk
IGZvciBtYW51YWwKPiBjYWxsaW5nIG9mIGZ3bm9kZV9oYW5kbGVfcHV0KCkgaW4gdGhlIHBhdGhz
IHdoZXJlIHRoZSBjb2RlCj4gZXhpdHMgdGhlIGxvb3AgZWFybHkuIEluIHRoaXMgY2FzZSB0aGF0
J3MgYWxsIGluIGVycm9yIHBhdGhzLgo+IAo+IENjOiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNy
aXN0ZWFAbWljcm9jaGlwLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL2lpby9hZGMvbWNw
MzU2NC5jIHwgMTYgKysrKysrKy0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L21jcDM1NjQuYyBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMKPiBpbmRleCAzMTFiNjEzYjYw
NTcuLmUyYWUxM2YxZTg0MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5j
Cj4gKysrIGIvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYwo+IEBAIC05OTgsNyArOTk4LDYgQEAg
c3RhdGljIGludCBtY3AzNTY0X3BhcnNlX2Z3X2NoaWxkcmVuKHN0cnVjdAo+IGlpb19kZXYgKmlu
ZGlvX2RldikKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWNwMzU2NF9zdGF0ZSAqYWRjID0gaWlv
X3ByaXYoaW5kaW9fZGV2KTsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
YWRjLT5zcGktPmRldjsKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hh
bm5lbHM7Cj4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqY2hpbGQ7Cj4gwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGlpb19jaGFuX3NwZWMgY2hhbnNwZWMgPSBtY3AzNTY0X2NoYW5u
ZWxfdGVtcGxhdGU7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlpb19jaGFuX3NwZWMgdGVtcF9j
aGFuc3BlYyA9Cj4gbWNwMzU2NF90ZW1wX2NoYW5uZWxfdGVtcGxhdGU7Cj4gwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGlpb19jaGFuX3NwZWMgYnVybm91dF9jaGFuc3BlYyA9Cj4gbWNwMzU2NF9idXJu
b3V0X2NoYW5uZWxfdGVtcGxhdGU7Cj4gQEAgLTEwMjUsNyArMTAyNCw3IEBAIHN0YXRpYyBpbnQg
bWNwMzU2NF9wYXJzZV9md19jaGlsZHJlbihzdHJ1Y3QKPiBpaW9fZGV2ICppbmRpb19kZXYpCj4g
wqDCoMKgwqDCoMKgwqAgaWYgKCFjaGFubmVscykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRU5PTUVNLCAiQ2FuJ3QgYWxsb2NhdGUK
PiBtZW1vcnlcbiIpOwo+IAo+IC3CoMKgwqDCoMKgwqAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25v
ZGUoZGV2LCBjaGlsZCkgewo+ICvCoMKgwqDCoMKgwqAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkX25v
ZGVfc2NvcGVkKGRldiwgY2hpbGQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bm9kZV9uYW1lID0gZndub2RlX2dldF9uYW1lKGNoaWxkKTsKPiAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGZ3bm9kZV9wcm9wZXJ0eV9wcmVzZW50KGNoaWxkLCAiZGlmZi1j
aGFubmVscyIpKQo+IHsKPiBAQCAtMTAzMywyNiArMTAzMiwyNSBAQCBzdGF0aWMgaW50IG1jcDM1
NjRfcGFyc2VfZndfY2hpbGRyZW4oc3RydWN0Cj4gaWlvX2RldiAqaW5kaW9fZGV2KQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiZGlmZi0KPiBjaGFubmVscyIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlucHV0cywKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBBUlJBWV9T
SVpFKGlucHV0cykpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFuc3BlYy5kaWZmZXJlbnRpYWwgPSAxOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gZndub2RlX3Byb3BlcnR5X3Jl
YWRfdTMyKGNoaWxkLCAicmVnIiwKPiAmaW5wdXRzWzBdKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4g
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFuc3Bl
Yy5kaWZmZXJlbnRpYWwgPSAwOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW5wdXRzWzFdID0gTUNQMzU2NF9BR05EOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkg
ewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmd25vZGVf
aGFuZGxlX3B1dChjaGlsZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaW5wdXRzWzBdID4gTUNQMzU2
NF9JTlRFUk5BTF9WQ00gfHwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlucHV0c1sxXSA+IE1DUDM1NjRfSU5URVJOQUxfVkNNKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZ3bm9kZV9oYW5kbGVfcHV0KGNoaWxkKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlucHV0c1sxXSA+IE1DUDM1NjRf
SU5URVJOQUxfVkNNKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGRldl9lcnJfcHJvYmUoJmluZGlvX2Rldi0+ZGV2LCAtCj4gRUlOVkFMLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkNoYW5uZWwgaW5kZXggPiAlZCwgZm9y
Cj4gJXNcbiIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNQ1AzNTY0X0lOVEVS
TkFMX1ZDTSArCj4gMSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5vZGVfbmFt
ZSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjaGFuc3BlYy5hZGRyZXNzID0gKGlucHV0c1swXSA8PCA0KSB8IGlu
cHV0c1sxXTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhbnNwZWMuY2hhbm5l
bCA9IGlucHV0c1swXTsKPiAtLQo+IDIuNDQuMAo+IAoKCiAgVGhlIGNoYW5nZXMgbG9va3MgT0ss
CgpSZXZpZXdlZC1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5j
b20+CgoKVGhhbmtzLApNYXJpdXMK

