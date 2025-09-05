Return-Path: <linux-iio+bounces-23781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C88B45A34
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3540566FFD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9860836CDE5;
	Fri,  5 Sep 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E99Om9WQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286F17F4F6;
	Fri,  5 Sep 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082113; cv=fail; b=eJ5PvLL7fUEDZyh7Wt/1Daef4CWQr3IfZ2DHY6O144LSE8ou5hNUPFAiY758OtUwjRNzEf1jXDBKxVDgo6EntoJnGWgFeQHQ071Tn8IKCTc+R0X730wy/7wKaFpfdAO7Hd3jCd0eiDK9h5KT1ywD+7nFE+74jZkpXtFcT1hic6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082113; c=relaxed/simple;
	bh=G7FNbS2rL0Z5IneaVHEHheYlRl0pNYgpoq5AhrvIgCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIEhUpoEyTqu/p4c6e9kaFAjxgvHniaJBXS+g1AH+puZ3m16Oy/xFsS0sBT1nb1zQt4GuBGS8q62iedqdNFWnfqsTfHPhOYO+f4l9RhgwF3Wv6Q9G0+JLsG156qin4PH3sMVimeoAw3o5kq2ZxvlvYw033dJkWrl+C5E09YSPZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E99Om9WQ; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHisW+v016sE7e/J8csxwqyxa1weGHNIRZf3f9Qj/tkOsQuCEu5pN4ang50Yu+wxdLFSHcbFZHVgEH7waZznwlHIqem/Gis/CBniGZ3OGj0bjJx7rQ/vtFVUUk9r40kQrJRgiLiR+Qp6G2kumw8MpgagvWm2U3x6fqluvJoIi30cN7BZetCLifOrfHOpCYk6QQ+DiFwlOTkySNvjmK6aQquRQ1CbkUh122g8vjuBZY1yEcwxQ1zkPhQk1NNN3F+B7tDNg5o32Sb78rqm+Gy86j4A7hXxfN3A4+wMIHf6AK1AMlD5/LuU0UVUofLuvn/Ouwry1jrnb/+U+J3gUH0scQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7FNbS2rL0Z5IneaVHEHheYlRl0pNYgpoq5AhrvIgCU=;
 b=FufNBbv4aPwmHu/QOBr68TyjCZuqxXb7ALoXeximaGENZNM8mvg3CDRRlmqwbTZqeUca2JuagxTjO4nJalftGfUo0xFjerF0QpQjvffGiZ3RRoksUohf9tvUWAmivmVcsWyUZGOB3ta5Mix+PCBVpnc7qEunLzZwg8SjSLbU5wcRWeBKRfCFxqvZuMdr6eLEnSYMfrouOJfUyKyYsfhwTknKVj27BmerQnfaEGUtLsDfazTIRNm+tx3jkWKDbEwm9TC5VPXyhG4AI5uxtvbL0HDMAgJnt+qdLfjNFq1iBbux9IKn6DvbezEPZJYkhBcMtZ1lL+7ZvOXO0iNT7FX42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7FNbS2rL0Z5IneaVHEHheYlRl0pNYgpoq5AhrvIgCU=;
 b=E99Om9WQsXwSZzyL3pJyPZ/7ex4dC7ugsJ7w9eoYPthH7vlD18HFb5MHsAv56lZ3AQra1RSKnaPOsfF9zFkN3iu4lFwLco8S4iKLz5rvJv8QXY3OIhmfOWWOOFQELot7sbeJ3n5BblOiueM/2a0tRIrQDf/Or7P+l06YnvSElww=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 14:21:47 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:21:47 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"monstr@monstr.eu" <monstr@monstr.eu>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "git@xilinx.com" <git@xilinx.com>, Anand Ashok
 Dumbre <anand.ashok.dumbre@xilinx.com>, "Kadamathikuttiyil Karthikeyan
 Pillai, Anish" <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
Thread-Topic: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
Thread-Index: AQHcHkD8jMtoPjo/1UafQBuEC5tFH7SEdFkAgAAQrgCAAB6IAA==
Date: Fri, 5 Sep 2025 14:21:46 +0000
Message-ID:
 <IA1PR12MB7736D056E505103AC246DC2E9F03A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <cover.1757061697.git.michal.simek@amd.com>
 <610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
 <20250905123006.000031a9@huawei.com>
 <5f21169b-39b8-4fcd-b7d7-e5bcb1885549@amd.com>
In-Reply-To: <5f21169b-39b8-4fcd-b7d7-e5bcb1885549@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-05T14:19:04.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|LV3PR12MB9329:EE_
x-ms-office365-filtering-correlation-id: 812ef1ae-6c58-4f39-8f28-08ddec878c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHgvcVBubmxNY1NRVXFYSmZqay9rTkFGR0xxbTY0QVdOOEhEeWRsdmx3NUdy?=
 =?utf-8?B?SjBtVktDTXhpdWdoL0loZ3BDQlJvS2tpbkNqYWNIWDFvQmRPN3NDcTkwSjNj?=
 =?utf-8?B?Ny93K28rM1RHVWlBKzlnN1cwWjdxWUZHa2pJYzRDTW9HOUEzeTF4bUZJV1gw?=
 =?utf-8?B?TVJWRi9GaGlmbTRmWXM5MmJRZDlkVlBycW1qOWlpdG1VNllYeGNKdVd3ek96?=
 =?utf-8?B?QWszMGgrSXVER3lhOXpVMmlyRE5aVjUvYWhqTVBaNVEvV3BnbWJodFE1ejA1?=
 =?utf-8?B?Ri9GOERCTkJtQndkMmlsQUJJc3hHaWhoSUdPVE8yUnVzL3VDNlp0VndJc05i?=
 =?utf-8?B?dENIS2UxN1N4YmdwU3NieWNuRG94RVpCNlBYRmpETUM5cFNyNlNjVmhTM251?=
 =?utf-8?B?angzTG5xWnk0WUFtVnBwVElWQllIMG1LaStYQWtDckM1SVpjSVJTMnJualBZ?=
 =?utf-8?B?OHNWam9NRmZrQWFkY1FPV1gzazA0Yk9ZQWtiT2JUVlRHUzBaMjJuRDJaRTV2?=
 =?utf-8?B?QmhBaTBPYWRFTWpJWHBnL0ZzbCt4VCtrM0RYY3RHZzlOQUFPKzdnU0I1WHZv?=
 =?utf-8?B?cVR1NFo3YlFMTS9rWWJsU0NNS1lrN2JhL2NtYU9ZbVRoUUphVGcxdU8ySDVo?=
 =?utf-8?B?OEtsTk4xSG9ibjZXcG9BV1A5VWE1SXhPNGpEekxTK0xBdTVncStFMlhyK3ZY?=
 =?utf-8?B?dFRMQmI0bjdLNWRzdTE4ZWQ1VkNUSWIwRkpYUWlxdmtVd1JLQWs4REdRWXF6?=
 =?utf-8?B?TXJkRGZ0TWdENFB6RFltQzNPc2djanFZQUtpc2ZROHJXT01BdXVRY09GY09U?=
 =?utf-8?B?SEVYUk82V21UOFU5M01MVk9zT3ZvbzFYUGVpYXpIa2dBUnVpc1Awd2hrVUpT?=
 =?utf-8?B?cWs2bmFWcyt5YmNlWW5pUUFCb2JENDIrYjcvZTE3dFNxcXdRdnR6SkZPYVht?=
 =?utf-8?B?VXVveVBTU3Y1blc5SnVab3d6Y2s2YUJZdm5zQVVwS2J3R0ZuYzFCRkUyT3h0?=
 =?utf-8?B?cTFzSG9qWWc3RzJIK0NwU3VuUXMzRUthWGJiaE5mUkxJdkFrWThxWDA4NjdL?=
 =?utf-8?B?TlY3L05GS25jU1NlcDN0RWVzTTFBZ1ZVQi9seCtQMlhOSXBhV29iWTJScG5V?=
 =?utf-8?B?cHl0eWkzRXY0czEyeXVhUk9FT1N2Y2hDQ1dGNTFRMVlVemlJRlRtejhBb2t1?=
 =?utf-8?B?eTU1Y3NtS0xjS01QUDBPQjhuRFBVZE5IaEpWWnlac3dpOWRMdWthWnBZZjhn?=
 =?utf-8?B?Q1BtTWdGQWVva2VDWmg0TUZ0VzN0aUcvcDc3aVVOVUFmS3VqdDUxQVBjVDRl?=
 =?utf-8?B?SW96TXpaNFo0dDJXZnJlR21BQjhZTGhhN1hMaGhObzlFaEJySkkrUTc4M3NW?=
 =?utf-8?B?Ui9VejNxakNJMmZJRXdGN2NnMEM0TGcrMXQ2U2FibWZsajU1QUZqVXZTbW1m?=
 =?utf-8?B?cDdMb0ZFdWhBcWl2NE9yeTlMYVk3bm8vYWYvZjU3UnB1b1ZiSHVwVW5GczNn?=
 =?utf-8?B?VzNtcTN4YVlDM05XVXRvUFZPMmZtcEFOd3NabnVsb2NtdGI0aHl3aWZ4Mmw1?=
 =?utf-8?B?UFFWc0FSZGU1aTgxc29OeTJzY0MrdTJ3S09IVTNHRHFaM0VlWkV6QnJ2aHVz?=
 =?utf-8?B?d3kxenduR01tZnhJUjJFL2g3TlhJUjg3dkNzb0IzdFpFMXZsTVhVKzNYMjAr?=
 =?utf-8?B?bkpIOUo0ZTdSREN0NlZvWk5SanpmMENmSGxNbEJucVZzUisvY2tpUXMyOVAz?=
 =?utf-8?B?T1VtMWd0VmxtOUdTNFcrZTdZSmNjMU9JVGJpTzlGV3ZwR1daYjczam9nQzFN?=
 =?utf-8?B?Si9SaEFnamxEZzlWeHBSeThSVE16R0h3OTdLZFNKdE1zTXZIc29JcGR1dTVX?=
 =?utf-8?B?SEt2cW1mRHBSdGtWOG5JRDF3alQyWmp0VkRUMUZSOEhhQzRGWnF2SWVrNmNJ?=
 =?utf-8?Q?XJlAbZr9WnhAZQumNssWQINJgZ5oQH2d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlloazVLU0ZHbk9QQ2JWeUtJaXhnNnByZ3ZSYUxGRnN4bHU3aUhib24zMFha?=
 =?utf-8?B?NDNBT3NwYVlPc29WanRSam1meGMxM3RuOHVQRHVXRGJpYUJLSEdZUkNFOTFj?=
 =?utf-8?B?bjdzeU5JM0FBZldZZnlWMzFvZHNObnlBTjV6dHQ0czhaMlFKRktLODJzc1pB?=
 =?utf-8?B?Y28wbm0vUTlPbVZjdktNVnFuZmx2Uy9lNDdETzgreEw2SXJwV0dCRzZKb3Q5?=
 =?utf-8?B?SXdSNHhoUFZTNHlYTUk1aGlOa3hiaXR5aTFLMk9DMnQ3Wml6ZVM1ODI3OU5G?=
 =?utf-8?B?Nk1ST2VZWjRXUU83bkZqK296Y1dKVHMzL0NPaVU4OGlyeXFTb2NsTXJmN0ZU?=
 =?utf-8?B?dm5XaEpaRmFXMGM3blhpSWU0TjcrOW5Gci8zTUNxYStEUjFlT0hnRDNqeHFJ?=
 =?utf-8?B?Zm1tUVgxcnBaWTZZeDRURU8xdkRwRGx1MGtPMEd2U2RFMWRIK1NpemNTZmhU?=
 =?utf-8?B?b1dQWElnYjdvYkl3UmpGSnJUMnAvellEQjNEVG9yNUVzL1pLbWd5TWdFMEU2?=
 =?utf-8?B?b0hweDloWGpld0JYdWFKSlBrZ3JZdnl4YmxCSUdRMmF4elVYNm5maDFnNkds?=
 =?utf-8?B?R09nK2ZSV2tmdHhjTjdCcWtqSDlLSDJ0YnZyQU1xeEJvUmhXSVowdU13RXhv?=
 =?utf-8?B?UzhIck5mbmVJUlpLZ0N2eWp1NFQrTUlYOHJ4S1lHaFFYYU5RRjVHTWRoSm1S?=
 =?utf-8?B?Tit2bkZZdHZxc3hoODA2NDBZOG5lRC93aHJLbThhYlZRLzA3TzAzeHVWdGFX?=
 =?utf-8?B?TWcyTjJTaGhDM3lIYmJiQUN2L05XNmI1R3lTZDJJQk1TNG5jRTVuVS9WcTM3?=
 =?utf-8?B?c20wUWdIdGFTL2J0VHlZbXAyUlVqOGFlTTJaQ3pRS3JqWnVRd3E1ZnBWVTFq?=
 =?utf-8?B?TUdFSzh4S2MvVGl4ZGdyYUR0dDhzK0xqR1kxVWU1TENSTXJRWUtEakVmNG9h?=
 =?utf-8?B?OEVBM1pLZUw5RGFUQjlZN3NyVWRGK3p4UElubExCb2g3a1U4NXBwRXA3VzI3?=
 =?utf-8?B?TXlubHZGb0l0SStrM3BPWmlnUlJKOFlwQ1dRS3NmWHFyMlo1am5VUW05L0JZ?=
 =?utf-8?B?MktDbmVXNllKbWZrVDcyY2tiQ3RnQk5Uek9Da3NwUFR0MVNCZ05SMndIekFu?=
 =?utf-8?B?N09UMUQ1YlJUNG9qYjRhTzNFRDRyaktQcTdLWkZyUDZ3ZjVQdVlVL3hqU0hL?=
 =?utf-8?B?ZUdlZXhBZW9IRTZGOWZTcWc2NFp4MmR1bm52dFI5Wm5saHNFVDM5SEY2TzhW?=
 =?utf-8?B?aUtHY3kwRkU0K1RvTlVFNUY0UU40aE9iQmhGbzRUTEFLV0wyb3lYYmVoZ0JO?=
 =?utf-8?B?QU9ES3BOYjJhbGFwcFFXL21KcmdhM3ZMLzFFQVM5cXRSWm9iZkJ1SDBKTHVY?=
 =?utf-8?B?czVoV2ZHR2QvV3BlRlVVZ2NOM0lDbUpIZHlIL21VQ2dPeUlZcEc3OVVGR05a?=
 =?utf-8?B?bmZvQjg2c3gyaDRiTjVwSnVaSFA4bW5GQU5mZkJLNzhFMHBYZi9rSmFDamt5?=
 =?utf-8?B?N2NhQTRNQ1hEY3Y5R3REc0Zpd1BidkFmMFd4b1FyWXdJclkvTlZ5SmdBSnNm?=
 =?utf-8?B?RkFtSEpEbDBvY25KczduVERiZXRoZGtvaXZPaDRVdTExYUZLWHlFeEMzeGNK?=
 =?utf-8?B?TytlVUVuQ0Jmb3hVUWVDNjRBWW1KODl3QUlLN212YVIyWWh4R0Y4eXl6YTdv?=
 =?utf-8?B?ZFJURVowRERKYmdRTmdXWXNibndvTW00NjJrVWl3L0x6MzVaSk1yK1BWTGw1?=
 =?utf-8?B?NkRSMTdWNlBHSDlPbXdzaVVvWnBGU3FOWFUzcFIwNEJFK2FGVGhRWGUwejVz?=
 =?utf-8?B?eVIvODBCMzJpQWJpb1psOXB1QUVtMG1acTMySk9BQXVyakRJK2pueFE3cmZU?=
 =?utf-8?B?VER0dlN3Sjg1RzNmTDZzckw0UUlFU1lJK0pURzJYdmlvNUpQelA3R1AyZHdm?=
 =?utf-8?B?anR6NU5xVkZTVlNzOVNMRlFrQjVKejcyNW9lZnJuaFJoNnplOC9tMVRna0Fk?=
 =?utf-8?B?aWFPWjY1WHFSUGFjNVdFWFVaajNOMFVueW56QXJ2SjJodGlUZTJQdDk0TGRv?=
 =?utf-8?B?MGR3ZE9mZ21VOHQzNDZKcG5RWHlqRjREclNYei9paEpOUFM0NHNMUWcydXpr?=
 =?utf-8?Q?Mvzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ef1ae-6c58-4f39-8f28-08ddec878c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 14:21:47.0140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brcBgb52fq7wPTCfD87nrWZAo1MNr+d3g379cNWcWE4C7Z3VbBk95ROjM5RpMFAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWljaGFsIGFuZCBKb25hdGhhbiwNCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgU2VwdGVtYmVyIDUsIDIwMjUgMTozMCBQTQ0KPiBUbzogSm9uYXRoYW4gQ2Ft
ZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbW9uc3RyQG1vbnN0ci5ldTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207
DQo+IGdpdEB4aWxpbnguY29tOyBFcmltLCBTYWxpaCA8U2FsaWguRXJpbUBhbWQuY29tPjsgQW5h
bmQgQXNob2sgRHVtYnJlDQo+IDxhbmFuZC5hc2hvay5kdW1icmVAeGlsaW54LmNvbT47IEthZGFt
YXRoaWt1dHRpeWlsIEthcnRoaWtleWFuIFBpbGxhaSwgQW5pc2gNCj4gPGFuaXNoLmthZGFtYXRo
aWt1dHRpeWlsLWthcnRoaWtleWFuLXBpbGxhaUBhbWQuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+
IDxhbmR5QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBE
YXZpZCBMZWNobmVyDQo+IDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBKb25hdGhhbiBDYW1lcm9u
IDxqaWMyM0BrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6aytkdEBrZXJu
ZWwub3JnPjsgTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxy
b2JoQGtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERF
VklDRQ0KPiBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IG9wZW4g
bGlzdDpJSU8gU1VCU1lTVEVNIEFORA0KPiBEUklWRVJTIDxsaW51eC1paW9Admdlci5rZXJuZWwu
b3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNl0gZHQtYmluZGluZ3M6IGlpbzogeGlsaW54
OiBBZGQgRG9jdW1lbnRhdGlvbiBmb3IgU3lzbW9uDQo+DQo+DQo+DQo+IE9uIDkvNS8yNSAxMzoz
MCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiBPbiBGcmksIDUgU2VwIDIwMjUgMTA6NDE6
NDQgKzAyMDANCj4gPiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPiB3cm90ZToN
Cj4gPg0KPiA+PiBGcm9tOiBTYWxpaCBFcmltIDxzYWxpaC5lcmltQGFtZC5jb20+DQo+ID4+DQo+
ID4+IEFkZCBkZXZpY2V0cmVlIGRvY3VtZW50YXRpb24gZm9yIFhpbGlueCBTeXNtb24gSVAgd2hp
Y2ggaXMgdXNlZCBmb3INCj4gPj4gaW50ZXJuYWwgY2hpcCBtb25pdG9yaW5nIG9uIFhpbGlueCBW
ZXJzYWwgU09Dcy4NCj4gPj4NCj4gPj4gQ28tZGV2ZWxvcGVkLWJ5OiBBbmFuZCBBc2hvayBEdW1i
cmUgPGFuYW5kLmFzaG9rLmR1bWJyZUB4aWxpbnguY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBB
bmFuZCBBc2hvayBEdW1icmUgPGFuYW5kLmFzaG9rLmR1bWJyZUB4aWxpbnguY29tPg0KPiA+PiBD
by1kZXZlbG9wZWQtYnk6IEFuaXNoIEthZGFtYXRoaWt1dHRpeWlsIEthcnRoaWtleWFuIFBpbGxh
aQ0KPiA+PiA8YW5pc2gua2FkYW1hdGhpa3V0dGl5aWwta2FydGhpa2V5YW4tcGlsbGFpQGFtZC5j
b20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEFuaXNoIEthZGFtYXRoaWt1dHRpeWlsIEthcnRoaWtl
eWFuIFBpbGxhaQ0KPiA+PiA8YW5pc2gua2FkYW1hdGhpa3V0dGl5aWwta2FydGhpa2V5YW4tcGls
bGFpQGFtZC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNhbGloIEVyaW0gPHNhbGloLmVyaW1A
YW1kLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+ICAgLi4uL2JpbmRpbmdzL2lpby9hZGMveGxu
eCx2ZXJzYWwtc3lzbW9uLnlhbWwgIHwgMjM1ICsrKysrKysrKysrKysrKysrKw0KPiA+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyMzUgaW5zZXJ0aW9ucygrKQ0KPiA+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy94bG54LHZl
cnNhbC1zeXNtb24ueWFtbA0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0DQo+ID4+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMveGxueCx2ZXJzYWwtc3lzbW9uLnlhbWwN
Cj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy94bG54LHZl
cnNhbC1zeXNtb24ueWFtbA0KPiA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLmE3NjgzOTVjYWRlNw0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3hsbngsdmVyc2FsLXN5
c21vbi55YQ0KPiA+PiArKysgbWwNCj4gPj4gQEAgLTAsMCArMSwyMzUgQEANCj4gPj4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFN
TCAxLjINCj4gPj4gKy0tLQ0KPiA+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9paW8vYWRjL3hsbngsdmVyc2FsLXN5c21vbi55YW1sIw0KPiA+PiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4+ICsNCj4gPj4gK3Rp
dGxlOiBYaWxpbnggVmVyc2FsIFN5c21vbg0KPiA+PiArDQo+ID4+ICttYWludGFpbmVyczoNCj4g
Pj4gKyAgLSBTYWxpaCBFcmltIDxzYWxpaC5lcmltQGFtZC5jb20+DQo+ID4+ICsNCj4gPj4gK2Rl
c2NyaXB0aW9uOg0KPiA+PiArICBUaGUgWGlsaW54IFN5c21vbiBwcm92aWRlcyBvbi1jaGlwIG1v
bml0b3JpbmcgYW5kIGNvbnRyb2wgZm9yIHRoZQ0KPiA+PiArc3VwcGx5DQo+ID4+ICsgIHZvbHRh
Z2VzIGFuZCB0ZW1wZXJhdHVyZXMgYWNyb3NzIHRoZSBjaGlwLiBTaW5jZSB0aGVyZSBhcmUgb25s
eQ0KPiA+PiArMTYwIHN1cHBseQ0KPiA+PiArICB2b2x0YWdlIHJlZ2lzdGVycyBhbmQgMTg0IG1l
YXN1cmVtZW50IHBvaW50cywgdGhlcmUgaXMgbm8gY29uc3RhbnQNCj4gPj4gK21hcHBpbmcNCj4g
Pj4gKyAgb2Ygc3VwcGx5IHZvbHRhZ2UgcmVnaXN0ZXJzIGFuZCB0aGUgbWVhc3VyZW1lbnQgcG9p
bnRzLiBVc2VyIGhhcw0KPiA+PiArdG8gc2VsZWN0DQo+ID4+ICsgIHRoZSB2b2x0YWdlcyB0byBt
b25pdG9yIGluIGRlc2lnbiB0b29sLiBEZXBlbmRpbmcgb24gdGhlDQo+ID4+ICtzZWxlY3Rpb24s
IGEgdm9sdGFnZQ0KPiA+PiArICBzdXBwbHkgZ2V0cyBtYXBwZWQgdG8gb25lIG9mIHRoZSBzdXBw
bHkgcmVnaXN0ZXJzLiBTbywgdGhpcw0KPiA+PiArbWFwcGluZyBpbmZvcm1hdGlvbg0KPiA+PiAr
ICBpcyBwcm92aWRlZCB2aWEgZGVzY3JpcHRpb24gd2hpY2ggY29udGFpbiB0aGUgaW5mb3JtYXRp
b24gb2YgbmFtZSBvZg0KPiA+PiArICAgdGhlIHN1cHBseSBlbmFibGVkIGFuZCB0aGUgc3VwcGx5
IHJlZ2lzdGVyIGl0IG1hcHMgdG8uDQo+ID4+ICsNCj4gPj4gK3Byb3BlcnRpZXM6DQo+ID4+ICsg
IGNvbXBhdGlibGU6DQo+ID4+ICsgICAgaXRlbXM6DQo+ID4+ICsgICAgICAtIGNvbnN0OiB4bG54
LHZlcnNhbC1zeXNtb24NCj4gPj4gKw0KPiA+PiArICByZWc6DQo+ID4+ICsgICAgbWF4SXRlbXM6
IDENCj4gPj4gKyAgICBkZXNjcmlwdGlvbjogU3lzbW9uIFJlZ2lzdGVycy4NCj4gPj4gKw0KPiA+
PiArICBpbnRlcnJ1cHRzOg0KPiA+PiArICAgIG1heEl0ZW1zOiAxDQo+ID4+ICsgICAgZGVzY3Jp
cHRpb246IEludGVycnVwdCBsaW5lIGZvciBTeXNtb24uDQo+ID4+ICsNCj4gPj4gKyAgJyNhZGRy
ZXNzLWNlbGxzJzoNCj4gPj4gKyAgICBjb25zdDogMQ0KPiA+PiArDQo+ID4+ICsgICcjc2l6ZS1j
ZWxscyc6DQo+ID4+ICsgICAgY29uc3Q6IDANCj4gPj4gKw0KPiA+PiArICAnI2lvLWNoYW5uZWwt
Y2VsbHMnOg0KPiA+PiArICAgIGNvbnN0OiAwDQo+ID4+ICsNCj4gPj4gKyAgeGxueCxoYm06DQo+
ID4+ICsgICAgdHlwZTogYm9vbGVhbg0KPiA+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+PiArICAg
ICAgRXhpc3RzIGlmIG5vZGUgcmVmZXJzIHRvIGEgSEJNIChIaWdoIEJhbmR3aWR0aCBNZW1vcnkp
IFNMUiAoU3VwZXIgTG9naWMNCj4gUmVnaW9uKS4NCj4gPj4gKw0KPiA+PiArICB4bG54LG5vZGVp
ZDoNCj4gPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPj4gKyAgICAgIFBMTSBzcGVjaWZpZWQgc3lz
bW9uIG5vZGUgaWQuDQo+ID4+ICsNCj4gPj4gKyAgeGxueCxudW1haWVjaGFubmVsczoNCj4gPj4g
KyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPj4g
KyAgICBtaW5pbXVtOiAxDQo+ID4+ICsgICAgbWF4aW11bTogNjQNCj4gPj4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPj4gKyAgICAgIFRvdGFsIG51bWJlciBvZiBzeXNtb24gc2F0ZWxsaXRlcyBjbG9z
ZSB0byBBSSBFbmdpbmUgZXhwb3NlZCBhcyBjaGFubmVscy4NCj4gPg0KPiA+IEZlZWxzIGxpa2Ug
c29tZSB1c2UgLSB3b3VsZCBtYWtlIHRoaXMgZWFzaWVyIHRvIHBhcnNlLiAgeGxueCxudW0tYWll
LWNoYW5uZWxzLg0KPiA+IFNpbWlsYXIgdG8gdGhlIG5leHQgb25lLiBIb3cgaXMgdGhpcyByZWxh
dGVkIHRvIHRoZSBudW1iZXIgb2YgY2hpbGQgbm9kZXM/DQo+DQo+IGl0IGlzIG51bWJlciBvZiBj
aGlsZHMgYmVsb3cuIFRoZXkgY2FuIGJlIGNhbGN1bGF0ZWQgdG8gZ2V0IHRoaXMgbnVtYmVyLg0K
Pg0KPiA+DQo+ID4NCj4gPj4gKw0KPiA+PiArICB4bG54LG51bWNoYW5uZWxzOg0KPiA+PiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+PiArICAg
IG1pbmltdW06IDENCj4gPj4gKyAgICBtYXhpbXVtOiAxNjANCj4gPj4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPj4gKyAgICAgIE51bWJlciBvZiBzdXBwbHkgY2hhbm5lbHMgZW5hYmxlZCBpbiB0aGUg
ZGVzaWduLg0KPiA+DQo+ID4gR2l2ZW4geW91IGhhdmUgc3Vibm9kZXMgY2FsbGVkIHN1cHBseXh4
eCB3aHkgaXMgYSBjb3VudCBvZiB0aG9zZQ0KPiA+IG5lZWRlZCBvciBpcyB0aGlzIG5vdCBjb3Vu
dGluZyB0aG9zZT8NCj4NCj4gcG9zc2libGUuDQo+DQo+DQo+ID4NCj4gPj4gKw0KPiA+PiArcGF0
dGVyblByb3BlcnRpZXM6DQo+ID4+ICsgICJec3VwcGx5QChbMC05XXsxLDJ9fDFbMC01XVswLTld
KSQiOg0KPiA+PiArICAgIHR5cGU6IG9iamVjdA0KPiA+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+
PiArICAgICAgUmVwcmVzZW50cyB0aGUgc3VwcGxpZXMgY29uZmlndXJlZCBpbiB0aGUgZGVzaWdu
Lg0KPiA+PiArDQo+ID4+ICsgICAgcHJvcGVydGllczoNCj4gPj4gKyAgICAgIHJlZzoNCj4gPj4g
KyAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+
ID4+ICsgICAgICAgIG1pbmltdW06IDANCj4gPj4gKyAgICAgICAgbWF4aW11bTogMTU5DQo+ID4+
ICsgICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+PiArICAgICAgICAgIFRoZSBzdXBwbHkgbnVtYmVy
IGFzc29jaWF0ZWQgd2l0aCB0aGUgdm9sdGFnZS4NCj4gPj4gKw0KPiA+PiArICAgICAgeGxueCxu
YW1lOg0KPiA+PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9zdHJpbmcNCj4gPj4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+ID4+ICsgICAgICAgICAgTmFt
ZSBvZiB0aGUgc3VwcGx5IGVuYWJsZWQNCj4gPg0KPiA+IFdvdWxkIHRoZSBnZW5lcmljIHByb3Bl
cnR5ICJsYWJlbCIgYmUgdXNlYWJsZSBoZXJlPw0KPg0KPiBsYWJlbCBzaG91bGQgYmUgZmluZS4N
Cj4NCj4NCj4gPg0KPiA+PiArDQo+ID4+ICsgICAgICB4bG54LGJpcG9sYXI6DQo+ID4+ICsgICAg
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gPj4gKyAg
ICAgICAgZGVzY3JpcHRpb246DQo+ID4+ICsgICAgICAgICAgSWYgdGhlIHN1cHBseSBoYXMgYSBi
aXBvbGFyIHR5cGUgYW5kIHRoZSBvdXRwdXQgd2lsbCBiZSBzaWduZWQuDQo+ID4NCj4gPiBUaGlz
IGlzIHZlcnkgZ2VuZXJpYy4gIFdlIGhhdmUgaXQgZGVzY3JpYmVkIGZvciBBREMgY2hhbm5lbHMg
YWxyZWFkeQ0KPiA+IGluIGJpbmRpbmdzL2lpby9hZGMvYWRjLnlhbWwuICBXaHkgY2FuJ3Qgd2Ug
dXNlIHRoYXQgaGVyZT8NCj4NCj4gbm8gaXNzdWUgd2l0aCBpdC4NCj4gQW5kIGxpa2VseQ0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy94bG54LHp5bnFtcC1hbXMu
eWFtbA0KPiBzaG91bGQgZGVwcmVjYXRlZCBpdCBhbmQgc3RhcnQgdG8gdXNlIG5ldyBvbmUuDQo+
DQo+DQo+DQo+ID4gVGhhdCBiaW5kaW5nIGRvZXMgcmVseSBvbiBtYXRjaGluZyBhZ2FpbnN0ICdj
aGFubmVsJyBmb3Igbm9kZSBuYW1lcyB0aG91Z2guDQo+ID4gV2hlcmUgYSAndHlwZSBvZiBjaGFu
bmVsJyBoYXMgYmVlbiByZWxldmFudCBJSVJDIHdlJ3ZlIGFsd2F5cyBhZGRlZCBhDQo+ID4gc2Vw
YXJhdGUgcHJvcGVydHkgcmF0aGVyIHRoYW4gdXNpbmcgdGhlIGNoaWxkIG5vZGUgbmFtZS4NCj4N
Cj4gSXMgdGhpcyByZWxhdGVkIHRvIHN1cHBseS90ZW1wIGNoYW5uZWwgbmFtZT8NCj4NCj4gSSB0
aGluayBvbmUgaXNzdWUgd2l0aCB0aGUgYmluZGluZyBpcyB0aGF0IGN1cnJlbnQgc2NoZW1hIGFs
bG93cyB0byBkZWZpbmUNCj4gc3VwcGx5QDEgIGFuZCBhbHNvIHRlbXBAMQ0KPiBidXQgYm90aCBv
ZiB0aGVtIGhhdmUgcmVnID0gPDE+IHdoaWNoIGlzIG5vdCBhbGxvd2VkIChkdXBsaWNhdGUgdW5p
dC1hZGRyZXNzKS4NCj4NCj4gU2FsaWg6IFdoYXQgZG9lcyB0aGlzIHJlZyB2YWx1ZSBtZWFucz8g
SXMgaXQgcGh5c2ljYWwgYWRkcmVzcyB3aGVyZSB0aGF0IHNlbnNvciBpcw0KPiBwbGFjZWQ/DQoN
ClJlZyBpcyBvZmZzZXQgaW5kZXggdG8gb2Zmc2V0IGJhc2Ugb2YgdGhlIG1lbW9yeSBhZGRyZXNz
ZXMgZm9yIGVhY2guIFN1cHBsaWVzIGFuZCB0ZW1wIHZhbHVlcw0KYXJlIGxvY2F0ZWQgaW4gZGlm
ZmVyZW50IG9mZnNldHMuDQoNCj4NCj4gPg0KPiA+PiArDQo+ID4+ICsgICAgcmVxdWlyZWQ6DQo+
ID4+ICsgICAgICAtIHJlZw0KPiA+PiArICAgICAgLSB4bG54LG5hbWUNCj4gPj4gKw0KPiA+PiAr
ICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+PiArDQo+ID4+ICsgICJedGVtcEAo
WzEtOV18WzEtNV1bMC05XXw2WzAtNF0pJCI6DQo+ID4+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4+ICsgICAgICBSZXByZXNlbnRzIHRoZSBzeXNtb24gdGVt
cGVyYXR1cmUgc2F0ZWxsaXRlcy4NCj4gPj4gKw0KPiA+PiArICAgIHByb3BlcnRpZXM6DQo+ID4+
ICsgICAgICByZWc6DQo+ID4+ICsgICAgICAgIG1pbmltdW06IDENCj4gPj4gKyAgICAgICAgbWF4
aW11bTogNjQNCj4gPj4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+ID4+ICsgICAgICAgICAgVGhl
IHN5c21vbiB0ZW1wZXJhdHVyZSBzYXRlbGxpdGUgbnVtYmVyLg0KPiA+PiArDQo+ID4+ICsgICAg
ICB4bG54LGFpZS10ZW1wOg0KPiA+PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy9mbGFnDQo+ID4+ICsgICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+PiArICAg
ICAgICAgIElmIHByZXNlbnQgaXQgaW5kaWNhdGVzIHRoZSB0ZW1wZXJhdHVyZSBzYXRlbGxpdGUg
aXMgaW4NCj4gPj4gKyAgICAgICAgICBjbG9zZSBwcm94aW1pdHkgd2l0aCBBSSBFbmdpbmUNCj4g
Pg0KPiA+IFRoaXMgb25lIHNlZW1zIHVudXN1YWwuICBJIGd1ZXNzIGl0IG1ha2VzIGEgY29uZmln
dXJhdGlvbiBkaWZmZXJlbmNlDQo+ID4gb2Ygc29tZSB0eXBlLiAgSSdsbCBsb29rIGF0IHRoZSBj
b2RlIHRvIHNlZSBpZiB0aGF0IGFuc3dlcnMgdGhlIHF1ZXN0aW9uLg0KPg0KPiBpdCBpcyBzdXBw
b3NlZCB0byBiZSBpZGVudGlmeSBsb2NhdGlvbiBvZiB0aGlzIHNlbnNvci4NCj4NCj4gPg0KPiA+
PiArDQo+ID4+ICsgICAgICB4bG54LG5hbWU6DQo+ID4+ICsgICAgICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZw0KPiA+PiArICAgICAgICBkZXNjcmlwdGlv
bjoNCj4gPj4gKyAgICAgICAgICBOYW1lIG9mIHRlbXBlcmF0dXJlIHNhdGVsbGl0ZSBleHBvc2Vk
DQo+ID4NCj4gPiBBcyBhYm92ZS4gbGFiZWwgdGVuZHMgdG8gZ2V0IHVzZWQgZm9yIHRoaW5ncyBs
aWtlIHRoaXMuDQo+DQo+IG5vIGlzc3VlIHdpdGggdGhpcy4NCj4gPj4gKw0KPiA+PiArICAgIHJl
cXVpcmVkOg0KPiA+PiArICAgICAgLSByZWcNCj4gPj4gKyAgICAgIC0geGxueCxuYW1lDQo+ID4+
ICsNCj4gPj4gKyAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPj4gKw0KPiA+PiAr
cmVxdWlyZWQ6DQo+ID4+ICsgIC0gY29tcGF0aWJsZQ0KPiA+PiArICAtIHJlZw0KPiA+PiArICAt
IHhsbngsbnVtY2hhbm5lbHMNCj4gPj4gKw0KPiA+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZh
bHNlDQo+ID4NCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==

