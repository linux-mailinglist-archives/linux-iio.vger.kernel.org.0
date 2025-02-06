Return-Path: <linux-iio+bounces-15079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C3A2AEEB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586901682F5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62916EB54;
	Thu,  6 Feb 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UgLo0OOI"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFE13C809;
	Thu,  6 Feb 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863167; cv=fail; b=aJmJY3OCxOoLRd01GZsGUqds8h6A/HXyykxcdFKojEH7rLxqp+1UEuuuO4N9ZejfWxSTYxP7oD3Si1YFSHJLI7DCoZd/UXPbv1MDG3z0hb0jRUWEy/UmRpz1PRfwhGHLQMk+HGLhtU4qYMBl1+MmKSa70cydfgVJsxGoPxdKvOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863167; c=relaxed/simple;
	bh=szSC+AZMYH03cL6fmt0oNGvehxbOGmgUTzz3cgnFndg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tdyu6efEM7W5HNeztAbAMwA6FxoLIxTU5mu2XKKJdvKBHt1hJMLAt4WwDepSL66OABCP3zND1jsvJLO98kh8T5MRRBPgIHBVRYesIwYZLJohd68Z1q2yl2JESkjzFJBGo1jOWsEHTCyZQGi/XJuxIJK8ac/tyZvSqcU6UHVQ0rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UgLo0OOI; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqE7pgAJK5BlKNMydUdkVDbWsjKhx5XHCpMN3cqSeqK7MMlBm8KOW04QleX1bpdrz0kky6tRGHGVMKjYBnXn/mUMdGN52s+aMuKKbwiPFrgxomoFaf4WAixLAyMuBz4XKPlxV7hnRaU0DqmsePZO7NmOOzyLAXG2RvlJmiWW+7cDD5ydrZVVF9AoDAROx26l3asm2LRbHVEHi2J2q/pneMnuuklgV5WfYeC9kGWbqhfX8BVIFsFtt4gDKPt36FTagyLDXqw6Fzh1V6At0lYnr/zNLE8SZddYX6byoS3fJTMdeAZAz8w3BhrK3J92JGUa6RESDj1dvnyA1SJn5WmYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szSC+AZMYH03cL6fmt0oNGvehxbOGmgUTzz3cgnFndg=;
 b=M/zn25INuTygzCnIiuZJCbna+Bv188j+PF1VrGc8CtXtk26QMfQkSoG2WfYDlDbipVfyZ17bL7wbjxjsPPnkn3ZQvL3vnMFrXu800AfzBsJlPKoGG+UYO01EwYGRoov/y3ZE/CX5sbq2p74474Z66R6R5XHWZ5HB8IrfegjAV2KcsKwYFbgi3Zl8oBz9VNrWmLqwgNnriPp3z6bOCetKM6RyPTbtFGOl+KALVbZVFaAwGzva16TMC9gd/iRBMfJscA79799SUIy42/RBsbQ/whL/sDPLH1+sKrl92Ny5yWnaxMTaxQ4W6xJTE2BM2logaT8NgL5304ZYxxg9skfC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szSC+AZMYH03cL6fmt0oNGvehxbOGmgUTzz3cgnFndg=;
 b=UgLo0OOIPIdfIrom/g6sXHu/b87DADMDCC59ukYtkUAJ8/hUNJt7Vc9abcMKIjBeRVPkZquPvP09fXt0tbnysnBtPkawC4cicqSB1NJJDHngGJ4EQCobvPgHx67wSJMOFdjCy6Ovct8uhRW5SZ1p7Lvef80Rg8CcouPKkYWYGcKn5eASeSgdm2lypjDi7y4R2YMhN7v7jT54b5gET2Wg+5Pl/9WNZuTmeiZEUYm/vW/9tFhlwSahjxP8kcKZqH1wCUhxoqKL5MQgTAhWnCo2fl5OMGoW06jaVxfWbg4SB9tDeMB1enOgJcYIBXHoTXFIGyM0TtLrtYpCxFUyGxs3cQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Thu, 6 Feb
 2025 17:32:40 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 17:32:40 +0000
From: <Dharma.B@microchip.com>
To: <csokas.bence@prolan.hu>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kamel.bouhara@bootlin.com>, <wbg@kernel.org>
Subject: Re: [PATCH v3 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Thread-Topic: [PATCH v3 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Thread-Index: AQHbeL0elb+f1HxVnkG1cMH8dZiNEg==
Date: Thu, 6 Feb 2025 17:32:39 +0000
Message-ID: <498d31c3-1756-4274-906e-ada5135e4e54@microchip.com>
References: <20250205104957.95236-2-csokas.bence@prolan.hu>
In-Reply-To: <20250205104957.95236-2-csokas.bence@prolan.hu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH7PR11MB6980:EE_
x-ms-office365-filtering-correlation-id: 09ee7171-5627-44c7-cc2f-08dd46d4415d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXlaT3VtS2kxWFZPMGZjVXFCamRQb2ZqUEdyWVppVG05RXM4anREMzBIQk1I?=
 =?utf-8?B?WGZVRFJhUzh2VEM4Z3VUZGtUZDZLbUlvblkvdnd0ZURqdUxWUi9UaEtreFcv?=
 =?utf-8?B?N1dacGx4MUF3SU1vNDhpRDJwVjV2N1V0WUpmbzR2OGtGUkY3WUE5Q016L3B6?=
 =?utf-8?B?cUJ1QURyeVVyQWNHeVVqMTQ3SWRKSk9COWRsazIxTTg0WVM1TGI4S1ZNTlRX?=
 =?utf-8?B?bWJpdVBNUEE0bGRrd2cxRStEZlJwdjhZME1mTjdhK1dUbVV1Nzl4dmIvZlVK?=
 =?utf-8?B?Y2VaSHJVVC8wYkNVMmZrTGYxNTl6cVlTQzVNczZkZktUSzJtZzBuOHhLSS9Z?=
 =?utf-8?B?WEgxbVNqVEdNSzE3eUs0bzFEUm9rakU2RWtqbGhFUU1uSytRWFF5eEZTQ1NQ?=
 =?utf-8?B?blFRMG8zbWFldnplelpBU3ZLZk5OYTBtc2lhd0tOWXBPcWo4WUtaV0dHbi9V?=
 =?utf-8?B?RUNRN09uQVBWa2t2b3dBWStWWHlVL3JpVUgzcTh5K3dMTnRCVzlncDZGaGow?=
 =?utf-8?B?VXA5Y0t0NWVTMXZ6VnBlejFXQXV5ZlR5aFd3TUEza0o1UmZseDVOYTFDbTZm?=
 =?utf-8?B?QXh6VTRFMHNmR09tMFFsTlVuZHc1cGNHc2ZDeTFlTEpVYkI2ajUxM1QwaktQ?=
 =?utf-8?B?WHpBTkxQNExHMXhCWFQ5VHFHYzlNR1NPeU01YXVlc1N1dkxpT0dpaE1OekFX?=
 =?utf-8?B?d2RRR2ZITUNIdHk3UlN3WHJpUlEyVTB4NGVybDY5ZzIzTlhiZEowQkJLdmlO?=
 =?utf-8?B?cE10NU56WHRnUUFIN2d2MWRZRWJ3djM5RkhrK0VxbmFmYmh3VjFtdFowRG5O?=
 =?utf-8?B?aG1jR2R2cmQrR0JCTk5nRFVZa2paMDY5cGo2cEIxckVNRjRBbGRVTDVjUmVx?=
 =?utf-8?B?cnRzbzYvWTVEdE9vNGFSV3liSUd2NnNvMmNCRytNaHQzcnJqVXNBT2VOb0VK?=
 =?utf-8?B?OW1ZTU5UdGNIMTljWTJjRTZGUUcvN2srOUUrdDhVNXJlWDBtTDU2WGNGWGZG?=
 =?utf-8?B?cmpNakQ1SjZNMkJNTmE5bmtYdm9zY2FXTFhTQ0E1Tis0QXBEc08vTVZaTHdh?=
 =?utf-8?B?b0VzZWFrQUN4MnpmT3V5OGlwcDBncFVJREZtbWVuL1RENDNsY0V3Q3NoOE53?=
 =?utf-8?B?RGNGS0s0K0QyQ2pGeE9iNGxFL1lpQWVOYklmSTFySWQ4SnFPVjNBY29DalZF?=
 =?utf-8?B?eE5yTkE3OTRydyt5T1Y4VUZvZytvU3gzM2EyZ0RNL2F1VUNSdFArNTh3S2xl?=
 =?utf-8?B?VkpmZXhFem11UkUza3N3L0Uwck9TY0NpTUVjSXhlT3hhQThLL2xEVUlDQ282?=
 =?utf-8?B?UmNLUkFMbTU0Sk11YkJxRC94ZVozWThsQndDQnFMb2FLSkVBdkRNUUUwclp3?=
 =?utf-8?B?NEhIa2F1TkVVdDlpaWhIUmVsMnFINnF0d0d0YzI3ZTlUOEdwRW5zTGRHZ1A0?=
 =?utf-8?B?RHlJT3ZWc0lXem95T2dVYXJLRWhLbk1wa1JxYVVxSUtxR25JNC9jSEkzUitY?=
 =?utf-8?B?R1BiR2p1UXZvQkJCSWs2bU9xRjdlOUZFd05XcVdkVHBScWFJNXY0bmhXYVhI?=
 =?utf-8?B?UVZ4bmMzYXQxazdJckpDTTV3UGpBbWlFakpxSlhkZzFOZUJPMlNiS0xJUmtU?=
 =?utf-8?B?bU0yaFZlK01EV1ZBdk4zbkR6YnY5YmEyUWVTK01JdXNadzZqeFNRcUZXelBo?=
 =?utf-8?B?WE5XVnhBRzhyT1JvWHVBZ3ZkOEFOTHRMZ2Y5eUN2emhJS3hTSEZXdFFlQXNk?=
 =?utf-8?B?N000VmF6RGkxUjBLekUvdHlkNS9rV05xNkdycXZHOG1ubW1UWWxUZFR6SkZQ?=
 =?utf-8?B?QkNBY1VJV1NZREsrczFKcXZPNGRpa0JtVkRiOTBiWWFmb0dOVzdHU1ZMbDlU?=
 =?utf-8?B?dEVsNElNb1FEMUJFb0I3RXNRcUtkL1FQbSt6ZW14S2FyeTAyNkVidTRMN3F3?=
 =?utf-8?Q?My0Xtn9Qec01MMc7JNoDdM/GI51YEzRL?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckNZd3dEUGZPQkF2SnFOeVRqRXkwVXlWYWRUcC8xNkJhK1AwaUphZVJSelN1?=
 =?utf-8?B?U3NSb3ZZVW5QUnI4dVhpWmpqSG9TbE8yeXRrT1hmc2NjNXNtOWdOUE5lTWds?=
 =?utf-8?B?RzBvSkR3SW9vQjlBMElZQnVxUDdHOC9JSjBGZmRPY05MdS9BekY5eTBueU5P?=
 =?utf-8?B?bmx3Y2FsUlhMN2phUmVtMmZGY3ZBNmMycXdFMHBmTE9JV0ZJL1RBK3JlN3FH?=
 =?utf-8?B?LzBKK2xONXZqdHU3Mkh1dFBLSUdjNWJxVGpsdWRXSDNDL2pIenREZ2NBUnpN?=
 =?utf-8?B?UkVXUTdCK3M0d2VRbVdtZndveTFvMG1qMzVkZnJUKzNsdUVoMUtZN2lIOVFI?=
 =?utf-8?B?ZUFUd3VrSWtHRzE5WDMyRFRpWFhlOW4vbURLTUlLSEtCRUYyWkFrbDdGSFZG?=
 =?utf-8?B?SFl5cm51U3RuSUhWZHlQRVVRaGNwV0NjcmU3bnN5dHJTVjZlR01UTHZkSUg0?=
 =?utf-8?B?TFFHQ1dkSnZTM0crT1JwV1JTZjVydnZaRTA1S1RHWEkrU3g0YWp4aEtQNnBs?=
 =?utf-8?B?Y1Bua3Fsa3llaUViN3EzMzFwdVQ2L2RXLzU4ODdEay95OXlmVUU4Q3NzcHBj?=
 =?utf-8?B?SG5YV09RZ2lndTNiVE1IUEMxMnpIZEYxOGM5SWNqSm5UZGNGN1JDY1BRRm0v?=
 =?utf-8?B?RFN5WVBoOHlmNENCU3VDaHJXSk9IeEZNNWxYdEtaUWpVUmt6a2gxbWNQN1du?=
 =?utf-8?B?VTVaZmlBWFNXdEUzUml0alZ3ejM3eDNZQlE2M1pJNU5pZmFYZTN5ZWVPMlQ4?=
 =?utf-8?B?TGRCYlgyVFF5QzI1OWFLc3BXSGVUN0lvUnc4ZzhYSGNNLzdDTFlvaVcrN0Z1?=
 =?utf-8?B?M2tUQ1A4d3VNV0R3TVhJUDFObFYvSWpYMUlWWEh2YkEremdYMVFTWGt5ZWNH?=
 =?utf-8?B?eHFsMFVLNUIrTHh1MWJURHpJU29rYTAxcVpJTTVYZEFIK3AwakVudGw0U0h3?=
 =?utf-8?B?QzA2dEVYMjlHdkpFSGZuUG05bDZ3VXhic1R2NWlESHVkZ2QvYVVFTFFnT2pH?=
 =?utf-8?B?OE45UktzbmFHTWNMVENYUng2UWYrSlFyN1BNWnhqRTJIdlkwZnpVRnU5UzZy?=
 =?utf-8?B?bHpPd1lKYWlKS1hyVGUxUVoxWkpuNXFQSWZIYXBJdVY0YmtXQmtrQWdSNmxJ?=
 =?utf-8?B?VU4zb2k4bDZXc0MvOTNESUoxdlBLRXRPaGpET0dFcTJuWmc2Qm1WSGFSUWFG?=
 =?utf-8?B?SUtDMEQ0WEE3NGplK28xVy9Ja2g5ejV4UThoMkc2dDQrWkZkQXBUVHJmUitS?=
 =?utf-8?B?aGUxZ2hmUVFNMzJuWU9TQ1lWV1VBd3gwMENSN1ZKL1VmTzRrZ3I4U2F0QU05?=
 =?utf-8?B?RGxnbUR0SFNVU29Qa2JJK0ZFZ1pFczB2WTJWdG9OWGlrd3YzN2dsN3RxRk9n?=
 =?utf-8?B?Vnd1UmU1aE8xdFB2dFVQak95UUlURkZQYS9FZXI3WFJIcEtiOVZ1YlhSenZ2?=
 =?utf-8?B?VWY1eEIwM1phVmdBVGhMUXRpUFB0VkZIeDhoWkFFc0JKTU4vdTFTY3FGV0ps?=
 =?utf-8?B?UklBL3krZDJ0WEVpZGtiUHdqNUFpQ3lMcmIyOTdReVNJa0dYWk5nMXNJUWlO?=
 =?utf-8?B?M3pmeWRQWmtyK2lxK1V5LzFOVWVRRXdhV3NWWDhVT05YU0NwekpVTk5hVER4?=
 =?utf-8?B?cHlLOFNYREQ2ZDlUNytQY0tHWTdPUDJMQXFwL1FVbUNmVm9BYjBjZ3hBYmJK?=
 =?utf-8?B?a3BLUkY1NnhsL1I0d29vMCtqMkxyY1EzTjRJRDM2WmFjMkw1Z0ZPOXZkZk95?=
 =?utf-8?B?dUdPVEN1NjNlSG1vQWkxRnNnTVBMMzR3eE1zWHhWRUFKajdGQ0NHMGloTXJr?=
 =?utf-8?B?S0MvcnJYWEpoOU5YREtiMTVHdHNsWVBZUklrKzVlem5QN1U0dHUzakE3MzJT?=
 =?utf-8?B?Q0lhTElvd2tzUVNzL29XcW5LcXI1eXhyeDE1ZTFhYkxDWWRld3dzSkRFeVRZ?=
 =?utf-8?B?OTNPY0d1V1JQd3ZJOG1mL3dPS3pkeEd1ZWs4SU16VnV2WmxyMWMrbWplT01t?=
 =?utf-8?B?RDNYZXNJOFNtejRHTFpZcFpPSmozVlBEUStpdDdPdEUzeVpUTkp0UUl0eTN4?=
 =?utf-8?B?cWtNMjIveFRkQlFYNVZKRGNjdWMwRTVTclNDQklhY3hTbHo0OUdvakNlVFdD?=
 =?utf-8?Q?BHa3Za2WQTwcM8iCm+bYHK/1U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22C6BA77FC36D84EAE0263330AF47872@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee7171-5627-44c7-cc2f-08dd46d4415d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 17:32:39.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WkwDLE2IasDm+IT4v1wJCP6mC4tICn3cgywcIoRLbHUeYi8FOeq2oLjJs4D0U6kL5QDIBfVbrV+/JEwH3l0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980

SGkgQmVuY2UsDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KT24gMDUvMDIvMjUgNDoyMCBw
bSwgQmVuY2UgQ3PDs2vDoXMgd3JvdGU6DQo+IFRoZSBUQ0IgaGFzIHRocmVlIFIvVy1hYmxlICJn
ZW5lcmFsIHB1cnBvc2UiIGhhcmR3YXJlIHJlZ2lzdGVyczoNCj4gUkEsIFJCIGFuZCBSQy4gVGhl
IGhhcmR3YXJlIGlzIGNhcGFibGUgb2Y6DQo+ICogc2FtcGxpbmcgQ291bnRlciBWYWx1ZSBSZWdp
c3RlciAoQ1YpIHRvIFJBL1JCIG9uIGEgdHJpZ2dlciBlZGdlDQo+ICogc2VuZGluZyBhbiBpbnRl
cnJ1cHQgb2YgdGhpcyBjaGFuZ2UNCj4gKiBzZW5kaW5nIGFuIGludGVycnVwdCBvbiBDViBjaGFu
Z2UgZHVlIHRvIHRyaWdnZXINCj4gKiB0cmlnZ2VyaW5nIGFuIGludGVycnVwdCBvbiBDViBjb21w
YXJlIHRvIFJDDQo+ICogc3RvcCBjb3VudGluZyBhZnRlciBzYW1wbGluZyB0byBSQg0KPiANCj4g
VG8gZW5hYmxlIHVzaW5nIHRoZXNlIGZlYXR1cmVzIGluIHVzZXItc3BhY2UsIGFuIGludGVycnVw
dCBoYW5kbGVyDQo+IHdhcyBhZGRlZCwgZ2VuZXJhdGluZyB0aGUgbmVjZXNzYXJ5IGNvdW50ZXIg
ZXZlbnRzLiBPbiB0b3AsIFJBL0IvQw0KPiByZWdpc3RlcnMgYXJlIGFkZGVkIGFzIENvdW50IEV4
dGVuc2lvbnMuDQoNCkkgZGlkIGEgcXVpY2sgdGVzdCBvbiB0aGUgU0FNQTVENCBYcGxhaW5lZCBi
b2FyZCBhbmQgb2JzZXJ2ZWQgdGhhdCB0aGUgDQppbnRlcnJ1cHQgY291bnQgaW5jcmVtZW50cyBv
biBvdmVyZmxvdy4NCg0KQnkgdGhlIHdheSwgSSBjYW1lIGFjcm9zcyBXaWxsaWFtJ3MgcmVzcG9u
c2UgdG8geW91ciBxdWVzdGlvbiwgYW5kIGZyb20gDQp0aGF0IGRpc2N1c3Npb24sIEkgZ2F0aGVy
IHRoYXQgeW91J3JlIHdvcmtpbmcgb24gYSBTQU1BNUQyIGJvYXJkLiBBcmUgDQp5b3Ugc2VlaW5n
IHRoZSBjb3VudCB2YWx1ZSBpbmNyZWFzZSBhZnRlciB3cml0aW5nIHRoaXM6DQoNCmVjaG8gaW5j
cmVhc2UgPiAvc3lzL2J1cy9jb3VudGVyL2RldmljZXMvY291bnRlcjAvY291bnQwL2Z1bmN0aW9u
DQoNCmNhdCAvc3lzL2J1cy9jb3VudGVyL2RldmljZXMvY291bnRlcjAvY291bnQwL2NvdW50DQoN
Cj4gDQo+IEJlbmNlIENzw7Nrw6FzICgyKToNCj4gICAgY291bnRlcjogbWljcm9jaGlwLXRjYi1j
YXB0dXJlOiBBZGQgSVJRIGhhbmRsaW5nDQo+ICAgIGNvdW50ZXI6IG1pY3JvY2hpcC10Y2ItY2Fw
dHVyZTogQWRkIGNhcHR1cmUgZXh0ZW5zaW9ucyBmb3IgcmVnaXN0ZXJzDQo+ICAgICAgUkEtUkMN
Cj4gDQo+ICAgZHJpdmVycy9jb3VudGVyL21pY3JvY2hpcC10Y2ItY2FwdHVyZS5jIHwgMTI1ICsr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMjUgaW5zZXJ0aW9u
cygrKQ0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=

