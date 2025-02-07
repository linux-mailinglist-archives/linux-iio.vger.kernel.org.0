Return-Path: <linux-iio+bounces-15104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78804A2BD9F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 09:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCEC3A3315
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871D1A08CA;
	Fri,  7 Feb 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TpTJClj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793D1547CA;
	Fri,  7 Feb 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915979; cv=fail; b=mNCuXAtZFQhYfFSR09b+3N0ojEiUnhlIlDyiMGXoM8NnPuwWDvP2xhrEu11ahIcOyAAEmBtYvZU+7D3SR/fINYHbLF6F7hBI15t4lBnkmesMfYFLgkX9B9zcGfCugFSd1G1BRF7WfIggxgvswijpsuKx4YVbi97les6wJybtJ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915979; c=relaxed/simple;
	bh=/CR4PwCWJXDs8ZdRo3WvN2IVLz+fmDtj+vyTQeuxUuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W/th/ViTzeK73j5A8rMjt+DUhHiL8Q2JgkFKVlPibznMM9k3dqpyQ5fY4403CX3MTfluBba/lDZhI4iLhBabuJl0hgUp5AaiLjsfd+9t/ceox+XLqwqD2GJHN+9CHXW08nMH3GYoYL6xfWrissApnZRBA0tmvLyaaBGTl7etrkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TpTJClj4; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEIZP760vk+rYZ9SNgRGGv20U6JlGEQ8NdbAqhL8H4kNElMPneLPl57qDN+x3xxrGyiB+o4r/VNLuHpnKQ8LRLYRoMaDmj7BSVnEx6rTEgYZrvVl1b3QE1HkrWqJOFxqC+E3clC1BLGFDNfnU30dif8b6ORIGsnW8LP+PLEH0QPHf038YKs9M4l9vCQuZEgRIUuXvXU1X6Yeo+x4LHSkrohTsOVAHUznfWH606RAfIz5W1j/bAAwuOWxJzi4UfjRZbWj/RCA/lLaUYwNfsZS9CZi8l4coymtoPPoqsVrNQUbsycOxi4FSW/L3niqX8PZbxQLMoGTGA0ghOWAYzUsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CR4PwCWJXDs8ZdRo3WvN2IVLz+fmDtj+vyTQeuxUuk=;
 b=lCUIMOLLreFDXXH7CTIGYlBr4BaaOV2etxXiU1LEWI1VYqWLeituiPp0/qxo+f0xWDZrYWYXsI2e20v5ATTjCNpZbVFOBEuuiiQltFvJFwPsF6yB35ZtNDj9K7H9Kp1rb2zWypSz0LhbcJfpTiZu4K/UDxgOdlKKFlkfVG4OMMiLuxfrCiBjUK8AXzDnSvVDAWnu/CkzH2b475YrjoF99DKHI5UjaqhcokzOkLzDQyTmvRx/B1/V1brkRKm209JQ+GCwY7KqGW7UhuheMdSlRMb8/UmGr2sdWRQFTO3P/uAbr3hnw4G78oIDD8c/Myx492raNauXsHlEej4j029YNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CR4PwCWJXDs8ZdRo3WvN2IVLz+fmDtj+vyTQeuxUuk=;
 b=TpTJClj471QE7wgCCk8xsbt5YkuvIqyCiN5hHMKSAJiNf2A4wSlyiCwe7qv0jgRKelDUA0Kn9AW+CCeCrbZUKO8TqVCIDLLBJqAM76aLOSvXpuRT4KVSEVcqdhahpp/Z51+M6rYqC0BMkWxFDVdtADFFzwwtVdnDXWhv9/LrEp0+wuGZZl7K6enZO490Ck0O8lKIjchWDmCvHlBGsRlOH/orxXTF+kmROOaKdwqT/XlgQw1Cx+hePweidKVOF6GUWVSytDUMd/N7zrpIEIu8UP48yHbKe9+AXAVRPksFvefMgISlYqGpLMjWjLtWhNyiQJCnTH4KT5rZCBaHjcJ8Jg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 08:12:54 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 08:12:54 +0000
From: <Dharma.B@microchip.com>
To: <csokas.bence@prolan.hu>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kamel.bouhara@bootlin.com>, <wbg@kernel.org>
Subject: Re: [PATCH v3 1/2] counter: microchip-tcb-capture: Add IRQ handling
Thread-Topic: [PATCH v3 1/2] counter: microchip-tcb-capture: Add IRQ handling
Thread-Index: AQHbeTgVrFiuRafRzEqxkGCWelF59g==
Date: Fri, 7 Feb 2025 08:12:54 +0000
Message-ID: <ed8b9d03-0f03-4872-b9e0-ab670e307450@microchip.com>
References: <20250205104957.95236-1-csokas.bence@prolan.hu>
 <20250205104957.95236-2-csokas.bence@prolan.hu>
In-Reply-To: <20250205104957.95236-2-csokas.bence@prolan.hu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|LV8PR11MB8463:EE_
x-ms-office365-filtering-correlation-id: ee996544-7d6f-4eb3-290f-08dd474f3941
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzJVaHZ4clpNOTZYS3NzZTBxemk0WlJJNkhDS0ZBTkJWeW9vUjdFc2crdWp1?=
 =?utf-8?B?d01ZaUt0Mmp2QzRFRUY0K01KbFRNSmdwYjhzM2dFSUtrS1RWUVBCcFRDMDVT?=
 =?utf-8?B?TlMyanZMMFFqY2gzUUpRS1JzS0hQNnVNZENPTlZYU0hwM2NLcVVLMms4c1Jo?=
 =?utf-8?B?ME01TWJaT2k5TTE4VEVSYTB2ZjdmMHpXb0xkeEY5SjR0Vm1jVG5XYm44QTJK?=
 =?utf-8?B?SERxZUlXM3dTQlRUVlVXYnZrelpXeFBIdGhuam1WMlpCNTcrYlFTNUs1dy9n?=
 =?utf-8?B?WjBhUmtXSUFHV2IrdnFWR3I2QmhCeEpldXNuTnNUWElJMGREdmhtMEdtWEJU?=
 =?utf-8?B?ZGdCQnc1RzFVR3JHUS9Ec2pieTdGbnpyT2l6cFBqQnpNM05teDV5MnZwWlp2?=
 =?utf-8?B?NXpBWW5WM0Z1di9DeWZ1VmhZV1ZveHh3OE1FOGgwNXlIWEFORWtPNDRWTTdo?=
 =?utf-8?B?Q2tyb0dLejNUOHRUZTNWNUlkVU1JOXdqblZTQWExekZhUVVLSHp1blZVVERs?=
 =?utf-8?B?SnQ5RXZMczRVdzlJM1Q1ZFZRRStMZzExcmZVdENVcHFWaER5YmRUdjN4SjE3?=
 =?utf-8?B?NG9oL0ZHNEgzbUYwMlB1cWNERDBqQUw3ejVQVUwyalVZVkNmZW05WkhHUkQ4?=
 =?utf-8?B?Rit0YUdYMXdMenJzRUtieEYwSEFwTWNnL3Q5a25ZMWtHcVNWc3NZcmw1RXpM?=
 =?utf-8?B?bTFuZHpEYk1pdStYR1NPazJCM2JVK3lZY2ZFS3pKUFo4S21XZUlycm9LcUZR?=
 =?utf-8?B?V3lxQWRjY3J1SkVReWlHYkF3dmVkNklHd0x4U3dQc2FlTW5qVU00alpGUGwr?=
 =?utf-8?B?eTZLWVFxTW5JdUNEdnZ5cW9JbFYzY2YvbFIxdklTTmQ5alhpenRxaEEvNGFP?=
 =?utf-8?B?QzlVVVpVYW5Wb2FlOTFNa3UrUCs3Sk5JVWNqWWpudGhDSS9ja09UR2dPVXpo?=
 =?utf-8?B?ZjdXVUJjcUt6VVFWcUM3UGRIbUhPVTc1eDhqSUNYdWp6UGVpdGp2L01ZRlVX?=
 =?utf-8?B?Vzkybkt5NzBWbTNNcFQ5QXhlVm1wR0xUeitTSjJ4eXBicHFqeGtNU2dIQVBH?=
 =?utf-8?B?ditaTVUzRkRlYnpkbFlnOXU5bjlJR3VhcWF0V2UyeWdVdDNVYlk0bmgxMStK?=
 =?utf-8?B?bS9hMDFlc1NZQmVHQ0VuUjJEb2dCQkV2Tm9kbjFOeGwwNFA3dVlTb1prbVl0?=
 =?utf-8?B?czBrQTJCZnEzSi82OGswd3c3dGRxSlRleTJZeTNZZGc0OW1EQlFFWDZjOVFY?=
 =?utf-8?B?b3NaUi9tRGlsODM1VlFJZGxLZWVRTHkzaENJMWlHcjB2NStONUNjdjhpWm1B?=
 =?utf-8?B?QW1EZThzeHc3VlhyNGg4Tk93TUhBUzIyVm9meEgrU0N0alRPa3FvUEcyMmZY?=
 =?utf-8?B?R2hwdHVQdzJzZi9DMEwySU9iTklaNUE2U3FrNHdRZmlhU2c4WEJiV3Fobmpr?=
 =?utf-8?B?YXRyUi9TT2hRdXh2MjJycDBvT3BRV09kT0d6WVBrTzk2Zjhpd05ITHBvblhY?=
 =?utf-8?B?NjBHRTE3cnBzK28zeVc0aDZLaS83WVUrZzMvUE55YjhQUmJOTEJYdkN6NU1K?=
 =?utf-8?B?emp5cGI3amg5N1JPM09laTBscmpNUlBvN3pKaTR5ZDlQVytmTis1WE9MYlhM?=
 =?utf-8?B?TllIYmhlM2IxZVhIVnBqMzdkam9tSmhIc3RQMWExdHMyRDJXTW1YR2Evc1My?=
 =?utf-8?B?ZWR2M2ZVTVJrMFpMZzB1SzRCN3VNblNkR1dzTjR2ZkN0Q2tPei9yZEU2UCtG?=
 =?utf-8?B?b0dlL0ZGYkFPcXRSVVQ1OHlzT1V6K05kVlRxcnNGK3hlUEdJZm5vcWQycEda?=
 =?utf-8?B?VHRaV0lqTCtNSnBlN3JJRG1taTlVZVFyMm1zbGo4T3l5K2VPZU82bGhWYTdh?=
 =?utf-8?B?TEdLWnFXWXdPMEp3V0JwaTJhTTlzaEsvSjF3OGxuWGZYQ1dOMUlRd2pCNXdV?=
 =?utf-8?Q?XlcknaM/O52zbFcUUxBeCgh+TMsVgB5F?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm1XcCsrOGJmcTNxRVRBKzNpMy9MK3JTTnRubGd6V3V6M1MvajBIdGZiZ3Vz?=
 =?utf-8?B?aWs1a0VHVitOVFdFV1N6ZENBdjgvOENGYjRZYWs0b0RJTkV3amNtRUdNY3lL?=
 =?utf-8?B?b0VMSG1qeVRKNEFBcGtRaEsrK2g1UkJ1a3NkSXQzeDQ3NTN3QlBKTmZjdXdv?=
 =?utf-8?B?VEJwQ1FHWVl1TXMzQzY3NVlmdFZZMkRsWFBEbVZ2d0UzRWY0WFZXZEtyUURM?=
 =?utf-8?B?OXJUdDFGKzJNVnM0Y3VPazIzaUNKZW1jOXRXMm5XODArY2xYQ1BJREZTNDBS?=
 =?utf-8?B?Z2tPOS9yUDdSSkxJZmFZUnVwNm9mcDFLUHEzUTBOYTNCaTcvMjA5WUJxSDJy?=
 =?utf-8?B?S05XVlhJVE82VXBrS0hzYlFHYytkZXNiUnA0dUJtZVJSQXFYblZqd2JXYmtn?=
 =?utf-8?B?MHRwclJUdzlnQjN0UENwQnptRzlvdDZ6bzlGc0pxVFBYS3RpN3ArY1NhT0Jk?=
 =?utf-8?B?dHltZ1l6SE1Oc2EvMjhQTWZYVmo1Tk13LzZYS1NYM2xWc1dlV3RoZ2gvTUNJ?=
 =?utf-8?B?bllyZldKY1dlQTJ6ekRLdFRoSGc2REc3cDM3TU8xWDBJSHNLVkp2ZEdoTzh5?=
 =?utf-8?B?cUlCS1R6YlpkSit2Y3dMRHNmcFhSeHpoOVJpYnkrQk1pQmZXNnhCQ3lYVEFX?=
 =?utf-8?B?eHVmY2E0NTFUMERuOFJxbHFkdWdQd2hvNDIreDRRSDJKZUNta0JKQkFHclNM?=
 =?utf-8?B?UnBZWEJxNTBCdU83UVh0WFh6RFNKRVNWTkNvMTFYZTVLRUw5cFZNbWxST3J3?=
 =?utf-8?B?cmhPWjMxYjVzY0xsNVdTN2ZsM0NWSzZyems3b3kxS3RJMGozQ3R5Rk5adDJj?=
 =?utf-8?B?ZkpBMXpubFloNDNJUy9JYXprZVVjZ0dhc3ltME1BcFI3WEtNQjFFYzJsRGw5?=
 =?utf-8?B?ajB6VWpRb3R1bHlkd21QY1AzL3gxNUYzRlFPWk9qREZPSzRDVUxnN29pVEhh?=
 =?utf-8?B?bnFIdjY2RzZLclBKVEpGT0hEb25RNzNnRzVrZjMzYUMybW94RTlzRGtnVmEw?=
 =?utf-8?B?U0NJbURBenlEZDJDT0FsMmdBbnUxTVdIN3RyTUY0NWI5NzJHL2lNQi9hRnBl?=
 =?utf-8?B?QmFvQTZpTm1BcDg1OTlhei91QXJLTmpuSkZvV0x4KzJDRy9jdEVuUDAyRGxy?=
 =?utf-8?B?ODg4czZ0dVVlSEcrL2pqN3pHMEppVVRZRmlHT1QydWVzUXFIaEZCcms2eWFN?=
 =?utf-8?B?QXpDb0hWcGt6UlNTZjZTaFRLTVlFNC9LTVEzcXZKTnh4NEhZODBxbXZ0UXh0?=
 =?utf-8?B?ZzdUeldsQmNuSkJpOVhVWlQvVXZPaDZXVkJOSG1mSnB4RmUrZ2xKYnNkbjNZ?=
 =?utf-8?B?UUlDUzNGeDFCbWt2SlJscy9FWXFSb2VUYUduRnJxMjdiYlZ1WllQalFMcTdn?=
 =?utf-8?B?U2pJeDF1eE5GL1RjbnZXc2N0blQvZkNWYkgwdzUxcW43K1YvVFdHYVdjOFY2?=
 =?utf-8?B?V0RNdjc0c3VweXdLVHN2ekh3K1MwckJjTlBaelpBOVdXUWR3WXEvbnU2M1BZ?=
 =?utf-8?B?MWIvQ3ozY0xreVI1OFF3a3BWOVF0a2hEZ0RxdWJGNUZ6bnN0R2FlUGZPNmEx?=
 =?utf-8?B?aXhxTzdxSFZRbjY3bDlpUDBMV3BuV0RscDQvaFdDZnJVTVEyZ0szZXMzWU9E?=
 =?utf-8?B?SHZhdTNkZzk0VW1ia3NrVG56alpBMTAwekxZdHZwME40SDd3ZFJRTWI3SVcz?=
 =?utf-8?B?UWZiTm9FTXp4VmNFK1RoeU9kZGxzVXlYOWp5aU1iQzJxTmEyRFVNVHZXMGQ2?=
 =?utf-8?B?MDNKMHZJbHVaN2dzK3BNTXQvOHJIWWFnSWRWWXJBRzlzKzFTU0lleVR2dmVn?=
 =?utf-8?B?N3p3R1g3TkF5TU96ZVBEYWwrbDF3K2FlbVcrTDR1SGdiSzN1V3BPdXllZnZX?=
 =?utf-8?B?RjRUZDQxbjNFNk9NOXpxVmJ4WEs4YTBEOFphUDNMVk1nazRBTnFLdzJXSkxG?=
 =?utf-8?B?Q0NiNXRHQXYxZ3I4YkM0ZDBWZVZwOWg5RzVnZ05TVk11dEFIeDlCTHAybnl0?=
 =?utf-8?B?dG9mbmw5MVc3elVHZmM0S09ETjVHOEtOOU1yZlR4N3Vob2EwelZLb20rNmxW?=
 =?utf-8?B?bUFONHNlYXhrNGcyUFFEanJXZ2VSQXpIaXdtaHc1UlM0WGNzaGoralFOc1ZU?=
 =?utf-8?Q?5Hy0+eGX5qmiEMNE11Ap+ZLGL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5369C2507B6404799D77CD606D7195F@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee996544-7d6f-4eb3-290f-08dd474f3941
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 08:12:54.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFowYW6MAEs1ddKbsq/1oZYH8NjvbD/ecNns2SCyj3dWJKxvZ+bJuX5iqe+RM0ydMoqlRKQDovGzfep2xWxMYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463

SGkgQmVuY2UsDQoNCk9uIDA1LzAyLzI1IDQ6MTkgcG0sIEJlbmNlIENzw7Nrw6FzIHdyb3RlOg0K
PiBBZGQgaW50ZXJydXB0IHNlcnZpY2luZyB0byBhbGxvdyB1c2Vyc3BhY2UgdG8gd2FpdCBmb3Ig
dGhlIGZvbGxvd2luZyBldmVudHM6DQo+ICogQ2hhbmdlLW9mLXN0YXRlIGNhdXNlZCBieSBleHRl
cm5hbCB0cmlnZ2VyDQo+ICogQ2FwdHVyZSBvZiB0aW1lciB2YWx1ZSBpbnRvIFJBL1JCDQo+ICog
Q29tcGFyZSB0byBSQyByZWdpc3Rlcg0KPiAqIE92ZXJmbG93DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBCZW5jZSBDc8Oza8OhcyA8Y3Nva2FzLmJlbmNlQHByb2xhbi5odT4NCj4gLS0tDQo+IA0KPiBO
b3RlczoNCj4gICAgICBOZXcgaW4gdjINCj4gICAgICBDaGFuZ2VzIGluIHYzOg0KPiAgICAgICog
QWRkIElSUXMgZm9yIENhcHR1cmUgZXZlbnRzIChmcm9tIG5leHQgcGF0Y2gpDQo+ICAgICAgKiBB
ZGQgSVJRIGZvciBSQyBDb21wYXJlDQo+ICAgICAgKiBBZGQgZXZlbnRzIGFzIGJ1bGxldCBwb2lu
dHMgdG8gY29tbWl0IG1zZw0KPiANCj4gICBkcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1j
YXB0dXJlLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDY3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NvdW50ZXIv
bWljcm9jaGlwLXRjYi1jYXB0dXJlLmMgYi9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1j
YXB0dXJlLmMNCj4gaW5kZXggMmYwOTZhNWI5NzNkLi5mZWY0YmI2OWI0ODYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvY291bnRlci9taWNyb2NoaXAtdGNiLWNhcHR1cmUuYw0KPiArKysgYi9kcml2
ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMNCj4gQEAgLTYsMTAgKzYsMTIgQEAN
Cj4gICAgKi8NCj4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L2NvdW50ZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gICAjaW5jbHVk
ZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
ICAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4gICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiAgICNpbmNsdWRlIDxz
b2MvYXQ5MS9hdG1lbF90Y2IuaD4NCj4gQEAgLTE4LDYgKzIwLDkgQEANCj4gICAJCQkJIEFUTUVM
X1RDX0VUUkdFREdfUklTSU5HIHwgQVRNRUxfVENfTERCRElTIHwgXA0KPiAgIAkJCQkgQVRNRUxf
VENfTERCU1RPUCkNCj4gICANCj4gKyNkZWZpbmUgQVRNRUxfVENfREVGX0lSUVMJKEFUTUVMX1RD
X0VUUkdTIHwgQVRNRUxfVENfQ09WRlMgfCBcDQo+ICsJCQkJIEFUTUVMX1RDX0xEUkFTIHwgQVRN
RUxfVENfTERSQlMgfCBBVE1FTF9UQ19DUENTKQ0KPiArDQo+ICAgI2RlZmluZSBBVE1FTF9UQ19R
REVOCQkJQklUKDgpDQo+ICAgI2RlZmluZSBBVE1FTF9UQ19QT1NFTgkJCUJJVCg5KQ0KPiAgIA0K
PiBAQCAtMjcsNiArMzIsNyBAQCBzdHJ1Y3QgbWNocF90Y19kYXRhIHsNCj4gICAJaW50IHFkZWNf
bW9kZTsNCj4gICAJaW50IG51bV9jaGFubmVsczsNCj4gICAJaW50IGNoYW5uZWxbMl07DQo+ICsJ
aW50IGlycTsNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBlbnVtIGNvdW50ZXJfZnVu
Y3Rpb24gbWNocF90Y19jb3VudF9mdW5jdGlvbnNbXSA9IHsNCj4gQEAgLTI5NCw2ICszMDAsNjAg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRtZWxfdGNfb2ZfbWF0Y2hbXSA9
IHsNCj4gICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICAgfTsNCj4gICANCj4gK3N0YXRpYyBpcnFy
ZXR1cm5fdCBtY2hwX3RjX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+ICt7DQo+ICsJc3Ry
dWN0IGNvdW50ZXJfZGV2aWNlICpjb25zdCBjb3VudGVyID0gZGV2X2lkOw0KPiArCXN0cnVjdCBt
Y2hwX3RjX2RhdGEgKmNvbnN0IHByaXYgPSBjb3VudGVyX3ByaXYoY291bnRlcik7DQo+ICsJdTMy
IHNyLCBtYXNrOw0KPiArDQo+ICsJcmVnbWFwX3JlYWQocHJpdi0+cmVnbWFwLCBBVE1FTF9UQ19S
RUcocHJpdi0+Y2hhbm5lbFswXSwgU1IpLCAmc3IpOw0KPiArCXJlZ21hcF9yZWFkKHByaXYtPnJl
Z21hcCwgQVRNRUxfVENfUkVHKHByaXYtPmNoYW5uZWxbMF0sIElNUiksICZtYXNrKTsNCj4gKw0K
PiArCXNyICY9IG1hc2s7DQo+ICsJaWYgKCEoc3IgJiBBVE1FTF9UQ19BTExfSVJRKSkNCj4gKwkJ
cmV0dXJuIElSUV9OT05FOw0KPiArDQo+ICsJaWYgKHNyICYgQVRNRUxfVENfRVRSR1MpDQo+ICsJ
CWNvdW50ZXJfcHVzaF9ldmVudChjb3VudGVyLCBDT1VOVEVSX0VWRU5UX0NIQU5HRV9PRl9TVEFU
RSwgMCk7DQo+ICsJaWYgKHNyICYgQVRNRUxfVENfTERSQVMpDQo+ICsJCWNvdW50ZXJfcHVzaF9l
dmVudChjb3VudGVyLCBDT1VOVEVSX0VWRU5UX0NBUFRVUkUsIDApOw0KPiArCWlmIChzciAmIEFU
TUVMX1RDX0xEUkJTKQ0KPiArCQljb3VudGVyX3B1c2hfZXZlbnQoY291bnRlciwgQ09VTlRFUl9F
VkVOVF9DQVBUVVJFLCAxKTsNCj4gKwlpZiAoc3IgJiBBVE1FTF9UQ19DUENTKQ0KPiArCQljb3Vu
dGVyX3B1c2hfZXZlbnQoY291bnRlciwgQ09VTlRFUl9FVkVOVF9USFJFU0hPTEQsIDIpOw0KPiAr
CWlmIChzciAmIEFUTUVMX1RDX0NPVkZTKQ0KPiArCQljb3VudGVyX3B1c2hfZXZlbnQoY291bnRl
ciwgQ09VTlRFUl9FVkVOVF9PVkVSRkxPVywgMCk7DQoNCmNhbiB3ZSBoYXZlIG1hY3JvcyBmb3Ig
dGhlIGNoYW5uZWwgKDNyZCBhcmd1bWVudCkgZm9yIGJldHRlciBjbGFyaXR5Pw0KDQo+ICsNCj4g
KwlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG1jaHBfdGNf
aXJxX3JlbW92ZSh2b2lkICpwdHIpDQo+ICt7DQo+ICsJc3RydWN0IG1jaHBfdGNfZGF0YSAqcHJp
diA9IHB0cjsNCg0KPiArDQo+ICsJcmVnbWFwX3dyaXRlKHByaXYtPnJlZ21hcCwgQVRNRUxfVENf
UkVHKHByaXYtPmNoYW5uZWxbMF0sIElEUiksIEFUTUVMX1RDX0RFRl9JUlFTKTsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGludCBtY2hwX3RjX2lycV9lbmFibGUoc3RydWN0IGNvdW50ZXJfZGV2aWNl
ICpjb25zdCBjb3VudGVyKQ0KDQpDYW4gd2UgaGF2ZSBpdCBhcyBtY2hwX3RjX2lycV9pbml0ID8N
Cg0KPiArew0KPiArCXN0cnVjdCBtY2hwX3RjX2RhdGEgKmNvbnN0IHByaXYgPSBjb3VudGVyX3By
aXYoY291bnRlcik7DQo+ICsJaW50IHJldCA9IGRldm1fcmVxdWVzdF9pcnEoY291bnRlci0+cGFy
ZW50LCBwcml2LT5pcnEsIG1jaHBfdGNfaXNyLCAwLA0KPiArCQkJCSAgIGRldl9uYW1lKGNvdW50
ZXItPnBhcmVudCksIGNvdW50ZXIpOw0KPiArDQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVy
biByZXQ7DQo+ICsNCj4gKwlyZXQgPSByZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBBVE1FTF9U
Q19SRUcocHJpdi0+Y2hhbm5lbFswXSwgSUVSKSwgQVRNRUxfVENfREVGX0lSUVMpOw0KPiArCWlm
IChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0ID0gZGV2bV9hZGRfYWN0
aW9uX29yX3Jlc2V0KGNvdW50ZXItPnBhcmVudCwgbWNocF90Y19pcnFfcmVtb3ZlLCBwcml2KTsN
Cj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiAwOw0K
PiArfQ0KPiArDQo+ICAgc3RhdGljIHZvaWQgbWNocF90Y19jbGtfcmVtb3ZlKHZvaWQgKnB0cikN
Cj4gICB7DQo+ICAgCWNsa19kaXNhYmxlX3VucHJlcGFyZSgoc3RydWN0IGNsayAqKXB0cik7DQo+
IEBAIC0zNzgsNiArNDM4LDEzIEBAIHN0YXRpYyBpbnQgbWNocF90Y19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAljb3VudGVyLT5udW1fc2lnbmFscyA9IEFSUkFZX1NJ
WkUobWNocF90Y19jb3VudF9zaWduYWxzKTsNCj4gICAJY291bnRlci0+c2lnbmFscyA9IG1jaHBf
dGNfY291bnRfc2lnbmFsczsNCj4gICANCj4gKwlwcml2LT5pcnEgPSBvZl9pcnFfZ2V0KG5wLT5w
YXJlbnQsIDApOw0KPiArCWlmIChwcml2LT5pcnEgPiAwKSB7DQo+ICsJCXJldCA9IG1jaHBfdGNf
aXJxX2VuYWJsZShjb3VudGVyKTsNCg0KbWlzc2luZyBlcnJvciBoYW5kbGluZyBpbiBpcnEgcmV0
cmlldmFsIChjaGVjayBmb3IgLUVQUk9CRV9ERUZFUikuDQoNCj4gKwkJaWYgKHJldCA8IDApDQo+
ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCByZXQsICJGYWlsZWQgdG8gc2V0
IHVwIElSUSIpOw0KPiArCX0NCj4gKw0KPiAgIAlyZXQgPSBkZXZtX2NvdW50ZXJfYWRkKCZwZGV2
LT5kZXYsIGNvdW50ZXIpOw0KPiAgIAlpZiAocmV0IDwgMCkNCj4gICAJCXJldHVybiBkZXZfZXJy
X3Byb2JlKCZwZGV2LT5kZXYsIHJldCwgIkZhaWxlZCB0byBhZGQgY291bnRlclxuIik7DQoNCg0K
LS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K

