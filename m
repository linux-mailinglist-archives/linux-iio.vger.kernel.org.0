Return-Path: <linux-iio+bounces-10543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308999BFEA
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 08:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2D71F22F54
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 06:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3013DDDD;
	Mon, 14 Oct 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bbCfuEBy"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7583E47B;
	Mon, 14 Oct 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886718; cv=fail; b=EvyOYysWxsZDBjhSUo9/nAHsFVNmX06puW4zLGxEH9jXKmnHXeaWKTMcABL8BAi//o7HL6yYzw/2XhFykPP2e59N4u1ZBlHo7HgMVDBkF+krlgeeQ2XMm4EqpexfAvRn0UTQ3KdWEcgV7aFDK4YHTxXj+nXgT7qGi/qTmbyL+1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886718; c=relaxed/simple;
	bh=G6fkmGDdRxIE1+B85bTXgonhwiNMACdHfCG0Hnf2KHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DRMxhRknLuw5J8Odw5Ig7VMeHaxjQsJqfMD03+7QgErCfIyE3CihmLrFthtbYNbCWt7VQYdP1CC1Ex4g3Wjf/67Qlef5xCFC2qkG6GHYp85jcEzEPoyHGMgLeiZxHe04OGKgmZ7jL9W7OAplXEvC/Qm/uND9MWvnDhBfoU4g7Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bbCfuEBy; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxJ8SB6tQEuDm1x6bUz7xnR5/DENhj+g25rpQuEDdXASiMuj/XsFuZjxzMcIWP1Nea4XQuVCqtORFpi26SXoM/QnAyWLyx0SPvt271Zm0/TM/HimVvkLRBqR6k8YxpNy25zebiDvRRn8LKDAy7ygjxFHmxYSE6PVsJ+NM9us+h/adPqCBEwkfUiRUtCBI68MKgsmFn0L9KjwA7ZSqf2+Kn5ursn/qItz4OQmyvtsssOZe1SORhE7TvTyh/Ox0IxBcM8qQ/HWhIC2waxe0LKP4+0iFODhEACCO7cPKPHZRldVaP/ROJ/jyJV6RoSi3Jw7JzzGkEaQn6aS9hYIWNYq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6fkmGDdRxIE1+B85bTXgonhwiNMACdHfCG0Hnf2KHE=;
 b=DvGFAZ0UVfK6NhTYxCk2aUNZZuWVuNcasWb8MbYcmzm36OGQ5pyuyrUn2XII0zo5PQNIL6/ZkK6nKq8QYxJb1uM549CVmqRLuczRn9Dli2d60CumxBTQxVcepS0t2cjmIf1ZUQjslJZ90Wwnwv2aSWgux8PkCLIAC6AH2Q+QsV11OGU1Q3nab2J+FgQ1Kwml2a2RirmxmiJ6mJa5fK34xWNdnxkB276+trIbujCbviuS3BvRlZXHlpQtSiTe+sIoSPkGjUH0E1HCvX2HH1fp96nsalH89G6HFvKi2mTM6jx2CV8qsP7DaeGRFM9TBGVaoQZGTeZ49smYuKRZjo4bvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6fkmGDdRxIE1+B85bTXgonhwiNMACdHfCG0Hnf2KHE=;
 b=bbCfuEByq58jF75HhNoc9lBggjHZEPkbRzjZ3d8SC1TXBJJ7DBP3B078hXkDTlhVUeT0k+oVa7A0t3bHxLqPJxheAAwmo2prXcL67rOp9BUIKT+uwNQaZdJmrdlNCNlFjeMEUGaX5qv0ZppLMdIQ51wjEphCKFoXtgBdjKz6UCg=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by AM9PR02MB6721.eurprd02.prod.outlook.com (2603:10a6:20b:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:18:29 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:18:29 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index:
 AQHbFY8HuXJEWWs0RkmgVD58ZYYY2rJ5uMQAgAEugICABWagAIAA4L0AgAIYDQCAAo/4AA==
Date: Mon, 14 Oct 2024 06:18:29 +0000
Message-ID: <9e93042237c3c9815d7b1be5ba85be61239b76e8.camel@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	 <20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
	 <20241006141624.3fa5bf34@jic23-huawei>
	 <b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
	 <20241010184742.1747bfe2@jic23-huawei>
	 <fab164228b4d567a147cd8d93150e687c6db0c70.camel@axis.com>
	 <20241012161040.1506a7a4@jic23-huawei>
In-Reply-To: <20241012161040.1506a7a4@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|AM9PR02MB6721:EE_
x-ms-office365-filtering-correlation-id: cec0e5cd-3563-4475-0526-08dcec18056b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzA4dDZNTGRKcmZWeGV2YzUyT0pJRWVtZXVTV1dxVm5xaE9QS3NVY24vakk2?=
 =?utf-8?B?dGFTTTIzKzR0dUhJek9KWFJBbVVQZytEUHo1TTRmb0VqRnZXUktnblFhNU5R?=
 =?utf-8?B?MVJkYk9UV2E4VGlmVS9qVTU4ZTZ0aUo1ZGZhUVZ3NFB6RHMrQUc0Y0NmKzFP?=
 =?utf-8?B?WDRaWUdpYkdPOXNxVDQ3aFhHc0FIM0l4NjJBdU5KbHN6ckNHSE9UbThjSVBX?=
 =?utf-8?B?RjlhalQ1TUVQbXFQc2ZzK3I5MlArQ0ZycVBzZlBkUUJ0VGlyVzJVNDBKYmtt?=
 =?utf-8?B?OEZ4QkdhY0lFNC9FalNubC9nU25pZC91Z09EVWtSS3QvV2VvQyt1QkRJN0sw?=
 =?utf-8?B?cVBsV3BwZzdXZUxkaXlrZW1lUWhraHZjU2Z3VmVBWlJlL2JiT0k0dGFlN1VL?=
 =?utf-8?B?dEo2eXhVS0pxWm5jVk5OTzVqeVRWMGhSdXA5ZEVrM3BDQjhJREorUTVSNjBV?=
 =?utf-8?B?bUlscUVZL2hkMk1nRklxOC9hbGFwN2pWSVdOQXRUK09tR3lNcWpjZnYvSVFn?=
 =?utf-8?B?cUFlbEsxS0J5djQvRVFRSkRPdG9zVVEvS3NmY0w5VHhnZ1lidlBLbU94dFNZ?=
 =?utf-8?B?WHU4UEhNb3FLUE02cXpaVE1xMVdISitPRVE3Slh1WS8wZHVjMDZnU2xiMHBn?=
 =?utf-8?B?SFZTYTBWM1hCZDlwSXdIeEswQzJ0RFJhMUEveTZnVTNoayswSHQzZVorblVr?=
 =?utf-8?B?dHBnMVdpdDdxa2V3Q0hja2JabEhkZGdsYU9LbjlkZXRpeTBwcjRiOE5lbm5r?=
 =?utf-8?B?ZFZPVTQ5cUtRRXQxM2FUWk9TdVBML3pZRXAzM2lMbGtoT1FkcVBweTQyNzBO?=
 =?utf-8?B?c0l0MTBRSytCbTVDYXY1R1JOeVBoVFV0WWFPVzI1S3BjeEJBSGg3SG83Z1k5?=
 =?utf-8?B?M1dsRlF2cE0rYnlyNVpZRXIxZEFaWDN3bUIzWmRyM1I1RmFDayttdWVyNVRZ?=
 =?utf-8?B?SXNLSG5rS3o2V3d0cVdQSUZEVGFkbG1ENWhtYnFXZHRKZHlzTkxTNFFKbDh1?=
 =?utf-8?B?My9Tdkh6MTI0b1pmUUdNSWxZSXNpTnpBdHVXS0ZycHNEempnbEE5YmVMTEt3?=
 =?utf-8?B?MURKelduNHdOZjVlTnBubmJMeUlXaW5STXptSExaZDFmazJaenE0SHV5WExS?=
 =?utf-8?B?cVdLdC8reEJCRU5XUXIwVmsxdmxwOUk4akRVZDVJcDk4UmU3bVgrSm1TVDlq?=
 =?utf-8?B?K2tsR2l6TkptdG91OHUxeXU4L3hVZjV4RWloT0ZYZHdIK1pnVmUzVlVtWHk2?=
 =?utf-8?B?b3d5bEdlN0srRHl5azhFeS9MUDJlTTQwaFFoZU5CWXdtNHNYaFhkSHZpMmky?=
 =?utf-8?B?UHNhODEwcEU5bzFJVndUemE1bmE1MUYraWg5eVA3UGc1MUJxY05Ub09oU0F3?=
 =?utf-8?B?SlliTlNraW5rQXVwTWpJSXJxWXFodnE1ckZQSFJlQ1NraVBCZitzNHZIeDNQ?=
 =?utf-8?B?UHRMMStaV0YzUUFIMldjUDQ1eisySHllOVp2MkdlUnpVeUprM0tFUXpIVUli?=
 =?utf-8?B?UTlIbUhJQXd6by9BeEM1bEJKNkYvUGhuMSthUGZrY3I0NnBwUzh0S2M2N3dv?=
 =?utf-8?B?TWNMLzc5V2RHdncrVXFWVHJ3WTNpZDJ4SzQ2K0FNeWdxR2Y0cndvUzB2bys0?=
 =?utf-8?B?Y0tQMFpRM3IySGlIM2ZwQi9TZjZ6REZqV1M1d3ViNlM0aWVMVForT1hsTWNq?=
 =?utf-8?B?andBcGlXRlM2QVE2WkI1d0hhSHJPTTVDT25yNGtOdVBWYlhvZVMyZVg0c3Nh?=
 =?utf-8?B?bDg0VnNzK2E0SWIzYmphUXJaVHZKSFdwaTZrWng2SG9nb1ZBVXRPWE9qSU5s?=
 =?utf-8?B?T01CRzZFSStpT3RBeHpqZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1RYWGNoeVJKeURiWnlRQXZYVHYzb1lOVUt4TWY4ODRWWUNKejRoSG8rV2h3?=
 =?utf-8?B?UTBTM24xVGVoNjI1blBTUGNBM2ZoK0F5M3JmM0MwUVdHMVB0a0tQZVdSTDVF?=
 =?utf-8?B?L0J1WHNsQW8vSE8wWDlTbS9lbG44WmMrZEJVaU1aN3FtbnkzWGJyMUI0OEFo?=
 =?utf-8?B?cDdjVStPNVdZOGV1RUh2TUtpNEpZc2NTdDkvdkZFVHJPbzVCeG8zRTJERkpP?=
 =?utf-8?B?a3dMaXQ3dHlMbEl2V2pxalhJZmZHOHdKdEhaejZybXpzT0ZSQ3JLY1d1Q0Ft?=
 =?utf-8?B?WnhvSmRrdTJMT09PckpDdEdleTgveGdocGxwV0tRc0dVNDFETmJsczZWdnV0?=
 =?utf-8?B?SndGTUYrYnN3b3Yzd2U3ZkVtazZCOE5UaisyY2pWQ1lBQVFDZkk4U01ZZGIv?=
 =?utf-8?B?Zm8vRmlsTnhOc0RtSTdJQ1ppcWlWaC9xeU0yQ3M4Nm5kQ21CZTJPZTF5WEpx?=
 =?utf-8?B?WFQ5cnlDWkF5T1lzZ1NvTlVTM2FoNFVudTFKZlRhNjZ1Ty9MRVBEUjNFWlh0?=
 =?utf-8?B?QnFtMXVuMXVGZUlkUEJqZFM1bTkwMnBpemdlUXRoWkU3dGxPSFBVMGM3bE5L?=
 =?utf-8?B?UTNFMEdMTGtpdEdiMERXdFkxZVN2b2N3R0Y3VWdhS1VRcDUwYkJxK0llcG5q?=
 =?utf-8?B?dmF1bWFMc3FKVGhvUUorQTM5RlhvTEsvdVhKQ29taE1LemkzcVlxY1dKbWhw?=
 =?utf-8?B?RVpEVEJUUjZLZ3o2Mm51dmxWSURjV08yVUtWd2NERGt5OXNNY2kxalA2bGlx?=
 =?utf-8?B?Wi9rU3BLR3ZXMmdPQTdYK2pZSDhNVEhkUjRVQzgvQko4WTh4RjhleHgzV29Z?=
 =?utf-8?B?dUQyeVJITm5TWDc2aGtuTEk0OFFDSnNCSnEyS0JyRzNnd21BUHJKWENLZnpk?=
 =?utf-8?B?TGEvTUJTNTFuZ1djQ0xiSUtnQzJ3MFpYOXBKa2ZJbi9JZmtKaWRuL2hlajFW?=
 =?utf-8?B?M3RWVlA1WFV3Yzl0SFFQRU5vWG4rNk1VT3cvNFo3QUhpYjFka3A2elF5aHY3?=
 =?utf-8?B?OUY1TVBKMVkzT3BQai9OVGZaNmoyTXJmOGdTSWRIajd0aWNCckVXOXowdlls?=
 =?utf-8?B?V1ptZFNwTDVpQ1NIeDd0YXdTdlAwNWh4bGlnTHFFQnA2ZTE3dy91V2tiaVJI?=
 =?utf-8?B?OVlMeFhxQjdISkFhNFJ5UW1HR0dKc2hLdmJGdlRpcmRMWHh1SVg3NElsdThO?=
 =?utf-8?B?cmsyMXlWcWk4Unp0VTFkOUhHVzhHMHZTM3owaGIxYUNUU0FRbHBWcDJRL1Q4?=
 =?utf-8?B?M3dXV1ZIVkJHZjcyV01RWEo2TmpuTUFWcmlja3BSUEVzZlZJN0poSExKQmth?=
 =?utf-8?B?OTgybDFTSFJxempLZDVXMjZTR041SmloOG5RdGxFeDF1OHVlL1FEekk3SVdo?=
 =?utf-8?B?cTRSc2czU1RFVklRSW1md3Z1NFRSeG9LME1xOHdaK2p1eUh6WW9Na1NxU256?=
 =?utf-8?B?ZVVscExuQWVaQUp0Z21JaUJ5UnFjWlRFYWlsVUlIR0REQ3dudXVUUm9UanJJ?=
 =?utf-8?B?eXZHVm9aOFdkKy8xbE5NOTRVMjh1REFZamRLMWs1a1pzYklOaWgxRXNPbDhu?=
 =?utf-8?B?K3Rjd0RadEFhemVLV2gwUTV1Q3FzV25QUDByMTI0MnN0UWxZZlArdnV0K3Nv?=
 =?utf-8?B?eWRuM0V4UTVoaFQ2K3cxUDlTWkFJa3ZnVS9BVi9ndUY0NTQ0UmVEZXNpR3dk?=
 =?utf-8?B?YUh5T3RnM24xUnd5NEMvS2JUOUgzU2ZVZXA5SG1lUnc5UURGNXBvZ2xGTXlk?=
 =?utf-8?B?bmU0bVNWYnJaRnk3ZDZTTVRoOENmQUtTTCtxbmdzU09wWVVWYnJGYjlZMlRu?=
 =?utf-8?B?US9EYkEyTEpVa2U0QWYwa0puaGtJcnJrbDYvLzYrdUNEZ081a05LWG1HOU5j?=
 =?utf-8?B?bmtuNGN0ayszU2hvWCt1Q3luaWdkWlFCcGJVSVBGaUh6clFrL3kvWFpjRDVS?=
 =?utf-8?B?REVvQjh1MzZJd25RK1BqRVFXQlNGRWRSdkJ6d0NqUlVEM2lTS0dzaXhHR1Fy?=
 =?utf-8?B?WFg2T2xGUnNwWGN5M29vbTNGb3VkMGI2QnJQa0RZSVFDYk43aWNGRXNzQlFX?=
 =?utf-8?B?RmI4QVJKeHdYSlBoS3pVY1pWU25ZUzd2c2t1L2hQckxIQzBua0h6NFB0UEsv?=
 =?utf-8?Q?NtMpqnJvkQN+hpKxKt7qzx/uU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5D3369B594404884EFB8862F202379@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec0e5cd-3563-4475-0526-08dcec18056b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:18:29.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7qCRjGfGOZncWhsEhRvMlKNV6/PLD6IWg4KWX/BvcvwUYuywhLLHiFwjxLVTj1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6721

T24gU2F0LCAyMDI0LTEwLTEyIGF0IDE2OjEwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDExIE9jdCAyMDI0IDA3OjEyOjA1ICswMDAwDQo+IEVtaWwgR2VkZW5yeWQg
PEVtaWwuR2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBUaHUsIDIwMjQtMTAt
MTAgYXQgMTg6NDcgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiBPbiBNb24s
IDcgT2N0IDIwMjQgMDc6MTk6MDYgKzAwMDANCj4gPiA+IEVtaWwgR2VkZW5yeWQgPEVtaWwuR2Vk
ZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiA+ID4gICANCj4gPiA+ID4gT24gU3VuLCAyMDI0LTEw
LTA2IGF0IDE0OjE2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOiAgDQo+ID4gPiA+ID4g
T24gVGh1LCAzIE9jdCAyMDI0IDE0OjIyOjE3ICswMjAwDQo+ID4gPiA+ID4gRW1pbCBHZWRlbnJ5
ZCA8ZW1pbC5nZWRlbnJ5ZEBheGlzLmNvbT4gd3JvdGU6ICAgIA0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiArc3RydWN0IG9wdDMwMDFfY2hpcF9pbmZvIHsNCj4gPiA+ID4gPiA+ICsJY29uc3Qg
c3RydWN0IGlpb19jaGFuX3NwZWMgKCpjaGFubmVscylbMl07DQo+ID4gPiA+ID4gPiArCWVudW0g
aWlvX2NoYW5fdHlwZSBjaGFuX3R5cGU7DQo+ID4gPiA+ID4gPiArCWludCBudW1fY2hhbm5lbHM7
DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCWNvbnN0IHN0cnVjdCBvcHQzMDAxX3NjYWxl
ICgqc2NhbGVzKVsxMl07ICAgIA0KPiA+ID4gPiA+IFRoaXMgZG9lc24ndCBjb21waWxlIGZvciBt
ZSBhcyBvbmUgb2YgdGhlIHR3byBvcHRpb25zIG9ubHkNCj4gPiA+ID4gPiBoYXMgMTEgZW50cmll
cy4gIFlvdSBjb3VsZCBlaXRoZXIgZm9yY2UgdGhlbSB0byBiZSAxMg0KPiA+ID4gPiA+IGVudHJp
ZXMgZWFjaCBvciB1c2UgYSBwb2ludGVyIHdpdGhvdXQgdGhlIHNpemUgYW5kDQo+ID4gPiA+ID4g
YWRkIGEgbnVtX3NjYWxlcyBlbnRyeSBpbiBoZXJlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEpv
bmF0aGFuICAgIA0KPiA+ID4gPiANCj4gPiA+ID4gSGkgSm9uYXRoYW4sDQo+ID4gPiA+IA0KPiA+
ID4gPiBBcmUgeW91IGJ1aWxkaW5nIG9uIHRvcCBvZiB0aGUgcGF0Y2ggdGhhdCB3YXMgYWNjZXB0
ZWQgaW4gZWFybGllciB2ZXJzaW9ucyBvZiB0aGlzDQo+ID4gPiA+IHBhdGNoIHNldD8gVGhhdCBw
YXRjaCBhZGRzIHRoZSB0d2VsZnRoIG1pc3Npbmcgc2NhbGUgdmFsdWUgZm9yIHRoZSBvcHQzMDAx
Lg0KPiA+ID4gPiBTZWU6wqBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MTYtYWRk
X29wdDMwMDItdjMtMS05ODRiMTkwY2Q2OGNAYXhpcy5jb20vDQo+ID4gPiA+IA0KPiA+ID4gPiBT
aG91bGQgSSBoYXZlIGFkZGVkIHNvbWUgdGFnIHRvIGhpZ2hsaWdodCB0aGUgZGVwZW5kZW5jeSBm
b3IgdGhpcyB2ZXJzaW9uIG9mIHRoZQ0KPiA+ID4gPiBwYXRjaCBzZXQ/ICANCj4gPiA+IEFoLiAg
WWVzLCBJIHdhcyBoYWxmIGFzbGVlcC4NCj4gPiA+IFRoZXkgYXJlIGdvaW5nIHZpYSBkaWZmZXJl
bnQgYnJhbmNoZXMgKHNsb3cgYW5kIGZhc3QpIHNvIEknbGwgaGF2ZSB0bw0KPiA+ID4gc2l0IG9u
IHRoaXMgc2VyaWVzIHVudGlsIGFmdGVyIHRoYXQgZml4IGlzIGluIHRoZSB1cHN0cmVhbSBmb3Ig
dGhlIHRvZ3JlZw0KPiA+ID4gYnJhbmNoIG9mIGlpby5naXQuDQo+ID4gPiANCj4gPiA+IElmIEkg
c2VlbSB0byBoYXZlIGxvc3QgaXQgYWZ0ZXIgdGhhdCBpcyB0aGUgY2FzZSBmZWVsIGZyZWUgdG8g
Z2l2ZSBtZSBhIHBva2UuDQo+ID4gPiANCj4gPiA+IEpvbmF0aGFuDQo+ID4gPiAgIA0KPiA+IEhp
LA0KPiA+IA0KPiA+IE5vIHdvcnJpZXMuIEp1c3QgdG8gY2xhcmlmeSwgZG8geW91IG1lYW4gc2l0
IG9uIGl0IGFzIHRoYXQgeW91IHdpbGwgY29udGludWUgcmV2aWV3aW5nDQo+ID4gdGhlIGNvZGUg
YWZ0ZXIgdGhlIGZpeCBpcyBpbiB1cHN0cmVhbSwgb3Igc2hvdWxkIEkgY29uc2lkZXIgdGhpcyBw
YXRjaCB0byBiZSBhcHByb3ZlZD8NCj4gQXNzdW1pbmcgbm90IG90aGVyIHJldmlldyBjb21lcyBp
biwgSSBjb25zaWRlciB0aGlzIHJlYWR5IHRvIGdvLg0KDQpHcmVhdCwgdGhhbmsgeW91IQ0KDQo+
ID4gDQo+ID4gQWxzbywgZG8geW91IGhhdmUgYW4gYXBwcm94aW1hdGlvbiBvZiB3aGF0IHRpbWUg
ZnJhbWUgd2UncmUgdGFsa2luZyBhYm91dD8NCj4gMiB3ZWVrcyBtb3N0IGxpa2VseS4NCj4gDQo+
IEkndmUganVzdCBzZW50IEdyZWcgS0ggYSBwdWxsIHJlcXVlc3Qgd2l0aCB0aGUgZml4IGluIGl0
LiBIZSB3aWxsIGhvcGVmdWxseQ0KPiBwaWNrIHRoYXQgdXAgYW5kIHRoZW4gc2VuZCBhIHB1bGwg
cmVxdWVzdCBvbiB0byBMaW51cy4gIFRoZW4gd2Ugd2FpdCBmb3IgdGhlDQo+IG5leHQgcmMgYWZ0
ZXIgdGhhdCBhdCB3aGljaCBwb2ludCBHcmVnIHdpbGwgcHJvYmFibHkgcHVsbCBpdCBpbnRvIGNo
YXItbWlzYy1uZXh0IG9yDQo+IEkgY2FuIGFsd2F5cyBtZXJnZSBpdCBpbnRvIG15IHRvZ3JlZyBi
cmFuY2ggb25jZSBpdCBpcyBpbiBhIHJlbGVhc2UgY2FuZGlkYXRlIG9mDQo+IExpbnVzJyB0cmVl
Lg0KPiANCj4gSW4gcGFyYWxsZWwgd2l0aCB0aGF0IEknbGwgcHJvYmFibHkgZG8gYSBwdWxsIHJl
cXVlc3QgZm9yIHdoYXQgaXMgYWxyZWFkeSBpbiB0aGUNCj4gdG9ncmVnIHRyZWUgdG8gZ2V0IGEg
bG90IG9mIHN0dWZmIGluIGNoYXItbWlzYy1uZXh0IGZvciB0aGUgbmV4dCBjeWNsZS4gVGhhdCBt
YWtlcw0KPiB0aGUgaGlzdG9yeSBhIGxpdHRsZSBjbGVhbmVyIGFzIEkgY2FuIGZhc3QgZm9yd2Fy
ZCBteSB0cmVlIGFuZCBlbmQgdXAgd2l0aA0KPiB3aGF0ZXZlciBpcyBpbiBjaGFyLW1pc2MtbmV4
dCAoaG9wZWZ1bGx5IGluY2x1ZGluZyB0aGlzKS4NCj4gDQo+IEFueWhvdywgYSBiaXQgb2YgdHJl
ZSBqdWdnbGluZyBmb3IgbWUsIGJ1dCB3ZSBoYXZlIHBsZW50eSBvZiB0aW1lIGFzIHJjMyB3aWxs
IHByb2JhYmx5DQo+IGJlIG91dCB0b21vcnJvdyBhbmQgaXQgbm9ybWFsbHkgZ29lcyB0byByYzcg
YXQgb25lIHJjIGEgd2Vlaw0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbiBhbmQgZm9y
IHRoZSBoZWxwIGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MgZm9yIHRoaXMgcGF0Y2guDQpCZXN0
IHJlZ2FyZHMsDQpFbWlsDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiA+IEJlc3Qg
UmVnYXJkcywNCj4gPiBFbWlsIA0KPiA+IA0KPiANCg0K

