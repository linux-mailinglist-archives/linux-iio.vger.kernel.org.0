Return-Path: <linux-iio+bounces-20149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A6ACB672
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A0DA21F3C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8C225A31;
	Mon,  2 Jun 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tf7LNOno"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AEB1FF61E;
	Mon,  2 Jun 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875738; cv=fail; b=VEYd9GU4GGkTIT5V2ykoRfKLnEKpeQBJEczILC3x3aJJRq52aADxk+079necymjHtppv9pgGvHYozxCcuTJo77KlKjoTo/062oLEu6lbsS4InpOjEhETmDWv2i9QxFlmpPRV7A5sWiqHStLZBAeZj5rW+3aHb10jTGh4BXysmJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875738; c=relaxed/simple;
	bh=DFLmtSPbpEPG2U09sFCpKIRVnvYHBv1rEmWOp82shLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h9mVGDtvuveV8AYVguXlWQ2WwCDdfLCls9hXsBhe8dxK03Gsn0a4mZ5wqskSoj0CWLwRzyJeiSKiufZ2Whlt3CQxcgIdvP+3WPmScm+mQwp2XzmLMaQQfKSrBA/BwE6117n2IJIvu4UO4Vezxi9lS1hU1vOWygw1cIA8Sp2rzyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tf7LNOno; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf4O8DQdUcJRcIMz0SsCogy9dAcEUR2tHRp/21rHJRbhy9tPafn2XUcsDCLUbbMAfvugu3uq4MClmUlpBYvjoy/wyzHKGO7L1btfd8RuibDF2qmqtKmd097HDOKpOZxKaxFnEIEWvW5qard4PxnltwI+LFM91bweg9a34x/aZ6+tbLM8X2lV11mV0KcDU+kTeGdE/C4kBLLNi4X/hO8lG4J4sstuuphWjj5lza5E+5dt0ucmdDn8NX75H1g4+wYC00NZSVHYX8XykJqtsaGNJj8TQTb1E2wfmaIcdJKk5FfIXxYYy+9FcR/eeXgRnfSvwEi0EvW9NktDPs8Zf/myjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFLmtSPbpEPG2U09sFCpKIRVnvYHBv1rEmWOp82shLw=;
 b=cuDw2h59jjUaukpH+bL1z9eqiBM+cAv8oo23ZBe/+8Umeidrv2N4p2jHwON0NskHB4WTdg32Sh99uUk6HeCba36lGH3XDFHtYe1kvZknFyeHlIfnUixPKCFBJcNA2H0ShkCS5X+377FBPuny2fiSUnswBKQQY1Nfgzp7FduLnDNfB7ZDlocYmez0FlEzd5PExTtptoCj5/WXjxCwEV3m/FwvVcL9Te8cACbM7ttb4aTsBzRMA6QSrk2SHUHU8JU2MIs4WJ6vyGQEl3z4dtqJO2YEI8xModseARS4kr3tJqMRWluIXYm2xWkY+S7XNpDZzDi+FRpNnmVW53krT18noA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFLmtSPbpEPG2U09sFCpKIRVnvYHBv1rEmWOp82shLw=;
 b=tf7LNOnomOkWiyTt+cGyrpn/79pP1SNhp5cZoZRAIK0FU4OYSBc1PE+pjdwAzvX07bhbOZG7Z8xPproF43TSelCK7lWxWkBVPMWvP04Nauseo1EW6CbzVPvisfJ98KMB0kktk1oPjvknY2oOOjycJYG2Pn0hpZ+mccgV9xKT7nWi3miBRrDmjCmdrJxhs9EyF36tVDcrY+lHrgUIkcxkEKIPqJ6t2J/Gfa2QaWbSKCX1k34IF+nqn+QkiP5CzJVL4u1M0fYqNNrykAZSb0fQYNPDl+ngLhAF1ui84lqY7eqBLSnZNeYIXdWsIfN2c7TxpAZAuWw06OKCMzaa11NWAw==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Mon, 2 Jun
 2025 14:48:53 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%3]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 14:48:52 +0000
From: <Victor.Duicu@microchip.com>
To: <conor@kernel.org>, <dlechner@baylibre.com>
CC: <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <robh@kernel.org>, <jic23@kernel.org>,
	<krzk+dt@kernel.org>, <andy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<Marius.Cristea@microchip.com>, <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Index: AQHb0H02VwkVCnAA/0y86KUckGKYY7Pp6dIAgAFrrACABKRxAA==
Date: Mon, 2 Jun 2025 14:48:52 +0000
Message-ID: <91c1d757a4ac051c115a821779a8c1fba764ea05.camel@microchip.com>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
	 <20250529093628.15042-2-victor.duicu@microchip.com>
	 <0f68e3f9-cba5-4df3-8e56-2cccbccf35ce@baylibre.com>
	 <20250530-dramatize-camisole-0a1aa9a38281@spud>
In-Reply-To: <20250530-dramatize-camisole-0a1aa9a38281@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|PH0PR11MB7588:EE_
x-ms-office365-filtering-correlation-id: 3aa97bb1-69d2-4803-b98c-08dda1e497d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUp4eFozMHkwbURCNDhEWUpJWkthT0VRcnV4aUxIakhPRUdNVGtwTFdUS3Zl?=
 =?utf-8?B?UTlzdGFQc1JKSEVvYnBMR1MvMXMrY1BwdkVNeldUMG1Lb3JaT1czVXd0Rk0x?=
 =?utf-8?B?Q3AwUGRlR3VRTG9uNjA0VWpUT0tsTVhqU0FuOVM3Z1lVV3lGS1BLOG5NaXE5?=
 =?utf-8?B?L2RyekZBZ2JzTWZxMG0rN3BmdnlzZEdlemx4UGVHdnpycFYxVjZBMDRneFEz?=
 =?utf-8?B?WFplOEZ2aFp2MUVIQTl4UlZlalVvN0RiY0pka1A1VmpFQXZZOFZ5NVVFQmY2?=
 =?utf-8?B?Sjc4OGEwWEhPRFdjdDA4Rk8zdHMxL0VzYmJXR3NUK1pvM0h6bWZEbVB2R21w?=
 =?utf-8?B?V0lHcmQwU09mbzhJRFVQY3JFbXV1Q09vMGJOQnhOa0poenR3Y2RiVDNvU25Q?=
 =?utf-8?B?eHhLVUpZOFRLT01tVEc2c2dDSkh1c0tWejNyZzBLYmFhVzQ0UWVBMTQ3ZFJY?=
 =?utf-8?B?U21KOFp0Wi9CVVdKMEtvZlV4Y2VjUzVHTTJxOG1nSjgxMll0TjJNSGxzWTht?=
 =?utf-8?B?bEptNlJreVB0dE4yaFdoTG1XOHVQaTI5Tm5ZRyt5Y3N0V05KbHh5VVJsT2lE?=
 =?utf-8?B?d29VRGF6TSt6WVBGRVBrOGtJY3pCQzNYMmRDZ1NsM1pERm1RSWVHLzE3N1lr?=
 =?utf-8?B?d2J6SFVDTHBJaDREcUNsZmZkeGw4eFV4eU5FWHA4QlJ0eUx4a3lEdXBJZ3ZC?=
 =?utf-8?B?UHlPWWVSUnNKVE9PSktJZnZGZXhJVFg2ZENKT09sS0s0MUw0WE9TY0djWElx?=
 =?utf-8?B?NEZyMkRUNzQxTXlsOVNRbWFZaGRqWWxGcXAvS3QveXlrczJYVE9HT0dyR2gz?=
 =?utf-8?B?ZzFHRWQ5WDZMZmUyYWpMV1ptRFR6cWFYZ3dZMHFRRXFuVnB1R1R5T1hmZEdK?=
 =?utf-8?B?Wnc4d09yNmMycFNGekFYbjY5azJBK3ZYL00xZVZKYnp1a3Z6WU80ZUYwNDBp?=
 =?utf-8?B?TjZaTkJYcmF5VXExNHVxV1JWWElZMnU4ckhaY0hlU3gyUmtwSHY3eENweW1I?=
 =?utf-8?B?ZTFtWnUrcldibGxGQThOS0orb2VRSHJ0MmhVbytub0RqM2oxQVFLOEdZWXB0?=
 =?utf-8?B?bm81eElGZ211WlJsTjlNNDcxZmNhdTF3dWtJUDlEdHV2OHRNMnlkM3NwYXAv?=
 =?utf-8?B?K2tpajdjU0ZqelNMMVVvMGhvM05JOGdyc1ZRU1ZrMzQvYnBreUlGMTRBRmNH?=
 =?utf-8?B?eVg2RE5uK1ZxMlRkbFRmaWZBbmxyL01ReFd0VktRTG1BTVB5ckJtRnVaUlNQ?=
 =?utf-8?B?TW5zR01DQ3pBb3FPOVpkSXdIRTFuQUVMMUNPU0tSK2Yxamh4cGxiZDlCMU5w?=
 =?utf-8?B?NGFxRUZkSXFNU3BhcUw0aUNwSldBRnFjWUdsS0JLa0pXblBYdkNSbS8vbFJB?=
 =?utf-8?B?aC9lTGgveCthekpNMFlXVkMwRFdhUUhXMWJBMlRoSkd0cFRjK3JFamFqM1V3?=
 =?utf-8?B?dU9IcEVjRllsR3RKRE1wdXB3MHphMVQ1WDBKdVFMejFUYzY1aDFrT1BIdFVa?=
 =?utf-8?B?bUQ1cStsVjdNY2ZpY2lxZzk0RDAxYUF3SU4xNEZXbTdUUi8ralRWTUltWmps?=
 =?utf-8?B?Wm43RytIMXMwb0dvUEZmNE1xbHV6RW4zaEpETzM1eFlCcW84M1d1TWNHYmY2?=
 =?utf-8?B?QXV0aFhDN01UU1Rvb0NycDNGWG5BU1IxZDh5ZmMrNnZiaEhvU09oWnFDall1?=
 =?utf-8?B?VWZVY1dmbEw1d1kvcVpsWUZCYVVFRGI5VDBaYklmZmJVQzVSMTRYWHdnTExN?=
 =?utf-8?B?RW4rb1hZRDk2S2VGZlVxcnlYYytPc0lMa2VaWk1NTDI1SytvM3R3YkMyb1RL?=
 =?utf-8?B?TW9UZ2JpQXhEbU1nSW5MSjFiWkoxU2RpZTc1YytUa3Qva0ZEeE5xRTNnSngw?=
 =?utf-8?B?U09qczlmdmk4bzAvQnVTeW9qM1Y2WkJWeUF3RTZKVkwvWVVsbSs1bGZiS1gr?=
 =?utf-8?B?YUhEVlZYaThoRGJqemx1US95SVdSZXg0VVIrNG8yS2tocDdDWXlzTnlxRlFN?=
 =?utf-8?Q?PhMKcMv/NEEbTnm6lEPPAZ0IIO3TJ4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkVNU0d4RzFiSHZGWVptNEp5TTNEK09OZDhodW1MZFNuYmRhWTdnRkRCUFZi?=
 =?utf-8?B?ZS9QTGtxRE9XVWVyb3kra0dob2dQVktrbmVST2tJTWJWeEdJT3RhSDBBelhX?=
 =?utf-8?B?eHljTHBKTDhQVmMvdHBZMjE1bXIvdFM3MTBMWUtIalQ3SVBYdEdwdG50VFYx?=
 =?utf-8?B?MGtjanJBT21OMnoyeTgyNnhQMW5wZWtKYUhkQVQzL0hUOFdDRDF4ZCsrN0lD?=
 =?utf-8?B?YTdtR0ZLT0RHYUxaWmlpOEYxaFJvdndSWFYxYWZhUVNCLzZUV0lONXJ4RkR0?=
 =?utf-8?B?OHZmVTYyN3hxSEdmaHdRQUtkaDFyb0o0VjdjSmRVRmt0bWdkQVJYNW56MWtF?=
 =?utf-8?B?YUp4UkN4N1A3SjRJSzVaTGQ0emlxUHIyT3FGeUdFSDhISHJyTlpwSUE5WlBM?=
 =?utf-8?B?blJCSTNkb3RPRHBMVEx3SjdGZTJoRzRlaStjUFFubXFTZWljRVNKRVo4T0Rv?=
 =?utf-8?B?WkhmMEY4VVVyaTNsdFM4MFQ2Z2w4d2Ywa2RBMi9XbmI4b3JpcjJmS0tMczlk?=
 =?utf-8?B?Ump2b0RVTnMxSjFxZXp4d0liamJXcjZvNFNHWjA5UkM5VERNU3E4a2cxM0pz?=
 =?utf-8?B?YldRU0JyTmpPZ2hVN0IyakNoR3k0a1ltc25iVEJvamNnOWgyYTVFUzRrRENz?=
 =?utf-8?B?QUViZnFrdFJnZzJPUlZ5R254OUlyVlV5TENhU1BMR2tNd2Q0V1BydXhIejF3?=
 =?utf-8?B?U0l5dllMOUN0UC8zdXk0MHVlMC9LSHAxNVg4WVk3R2pGTlc2SjB6YXFwQWxH?=
 =?utf-8?B?aGpwMFlYS2NRaTB6UFF0OVNVMU15cGxqSzlFT2JBU1BRckg2TGpWU2FicnFi?=
 =?utf-8?B?SmE1aVRpck1Dc2hkUXVFMVNSTjFWYXh2VWZtMEgxcVhkSGx3TFBXNnpaSGdZ?=
 =?utf-8?B?QUVGNFppMlRGcWQ3VWgxc3RtaUlPMmRMS0UxekRSOFFjc2RDalk2Q1g1RDlj?=
 =?utf-8?B?aHpCVENZSTliZHhwbHQybjdheUxkWUE0azB6ek4zVVlCcDduTitBVmt3UFI1?=
 =?utf-8?B?cERvb1ovUzVvOXkvZjA1K2VkM2FBdUtZNTd1NnY0eGUzQWZTR2J2bE5pT1Fo?=
 =?utf-8?B?eXI5ZHlqOGRXdHFFakxYem43TDBDbmVIbVhYOTVuSGNGU0lHejc4b3I4WnhK?=
 =?utf-8?B?UnczWFY2SWNFaytEcXYweEFCaGozNXZ0VDFWL2VuZDZLRkF5UC8ycjVXRHlY?=
 =?utf-8?B?am5yN3d3MTVUbXNwOVd1SHdhS1loOW5jSW8xeGRmek1MOUxXS2lKV09mNU5r?=
 =?utf-8?B?SkxtdVdwc3hqZDZuOWZ3NWk0ZVBvNnJjSjB1SHdhSnhpS3RZR0Y3eWtnQVRs?=
 =?utf-8?B?ZWFoM0t5OXN6YXF3ZFREcHBKWWMwbHNwUWhQVFB2UzdndEtVUHB5NEp4K0h1?=
 =?utf-8?B?d1pZd0ZmenVmdE0vZzlpRWttNGJ2eVJaMzhKUU1zck9xV0RMN0JEZDFIWFY4?=
 =?utf-8?B?dVY2QXJBSmpXZkMwQ0IzWS9TWjZZemRHVFVQV0pod0grS2lCN1BDdnpVWnpl?=
 =?utf-8?B?NE5Sb3krY0IyV3RzWVdnY0RiSm9sNEFyTWlUdDI3VmExSzBxcFJkYVpwam4r?=
 =?utf-8?B?bllLN2NVMDJDbjE4aDBOc3k5QlZHUXBkelBEWFFLNmpRTFlqeVBPUnBTQ1Z6?=
 =?utf-8?B?eWlGMnJ6dkQ1cS8xU1dQOUV1NE5CK1phQjlzQU1vM1NyZDQ2blAzekFyZXpl?=
 =?utf-8?B?SERTUmdvRWU3WGVzMmh0QWZzdjh3RjdONUNHNVFhUXBKdnVyeDB0QnlPcnc5?=
 =?utf-8?B?ZUVHdXdtMEQ3SmZERnAvZFRTUmpqS3cwVVRIblRWNjZMNVQ5Q016YmlJQ1Z0?=
 =?utf-8?B?aytXdmU2Z0k4d0I3ZHQ2bTJ5aUJzY3MzRlJSeG1lOVhWUUNnSk8xVjdhc3hB?=
 =?utf-8?B?TEFZSjJBMW11OVRORFF4TlFyREw0cGlEWEVzNzhSTXhoV1k2dkgrclM4U0JH?=
 =?utf-8?B?ekViNjVtcWVJYjlzK1VtZTk1RWw1d1g4SmxNVFl4OXk0aXFLb1Uzd1Y4YTd6?=
 =?utf-8?B?RVhid1FldXBGUXF5WmpPeG9IclF4UnJvRktER0JWbitlNEMySkJJNzZsOFly?=
 =?utf-8?B?UURlYUxCejBkbVk4d1JiRWhXeWpwdXBRYnlaVklHYU9ySFB0b1BVSFo3S09S?=
 =?utf-8?B?ejVzd2hBZ2xhSEhtTnErdjB1TFQvcklQVnRZaTZWVlg5cTJ0VWpTZjBlakhX?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <049215A3293F9E43B49C9DF0EDE95835@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa97bb1-69d2-4803-b98c-08dda1e497d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 14:48:52.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5XMA3XOG2yrIiwfcagAlf2yrB1FiYjYqwXd109ygjIhd+cynJigg2cLpRIu9hqQrpK+Pbtr1dCMI/TozCJp6HwN2M89/sexTDXpGLgTWhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588

T24gRnJpLCAyMDI1LTA1LTMwIGF0IDE2OjU1ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgTWF5IDI5LCAyMDI1IGF0IDAxOjEzOjM4UE0gLTA1MDAsIERhdmlkIExlY2huZXIg
d3JvdGU6DQo+ID4gT24gNS8yOS8yNSA0OjM2IEFNLCB2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNv
bcKgd3JvdGU6DQo+ID4gPiBGcm9tOiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5kdWljdUBtaWNyb2No
aXAuY29tPg0KPiA+ID4gDQo+ID4gPiANCkhpIENvbm9yLA0KDQouLi4NCg0KPiA+ID4gK8KgIG1p
Y3JvY2hpcCxyZWNkMTI6DQo+ID4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOg0KPiA+ID4gK8KgwqDC
oMKgwqAgRW5hYmxlIHJlc2lzdGFuY2UgZXJyb3IgY29ycmVjdGlvbiBmb3IgZXh0ZXJuYWwgY2hh
bm5lbHMgMQ0KPiA+ID4gYW5kIDIuDQo+ID4gPiArwqDCoMKgwqDCoCBPbWl0IHRoaXMgdGFnIHRv
IGRpc2FibGUgUkVDIGZvciBjaGFubmVscyAxIGFuZCAyLg0KPiA+ID4gK8KgwqDCoCB0eXBlOiBi
b29sZWFuDQo+ID4gPiArDQo+ID4gPiArwqAgbWljcm9jaGlwLHJlY2QzNDoNCj4gPiA+ICvCoMKg
wqAgZGVzY3JpcHRpb246DQo+ID4gPiArwqDCoMKgwqDCoCBFbmFibGUgcmVzaXN0YW5jZSBlcnJv
ciBjb3JyZWN0aW9uIGZvciBleHRlcm5hbCBjaGFubmVscyAzDQo+ID4gPiBhbmQgNC4NCj4gPiA+
ICvCoMKgwqDCoMKgIE9taXQgdGhpcyB0YWcgdG8gZGlzYWJsZSBSRUMgZm9yIGNoYW5uZWxzIDMg
YW5kIDQuDQo+IA0KPiBXaHkgYXJlIHRoZXNlIHR3byBkZXZpY2V0cmVlIHByb3BlcnRpZXMsIHJh
dGhlciB0aGFuIHJ1bnRpbWUNCj4gY29udHJvbHM/DQoNClRoZSBwYXJhc2l0aWMgcmVzaXN0YW5j
ZSBhZGRlZCB0byB0aGUgc2VyaWVzIHJlc2lzdGFuY2UgaXMgZGVwZW5kZW50DQpvbmx5IG9uIHRo
ZSBjaXJjdWl0LsKgDQpJdCBpcyBwb3NzaWJsZSBmb3IgdGhlIGNoaXAgYW5kIHRoZSB0cmFuc2lz
dG9yIHRvIGJlIGF0IHNvbWUgZGlzdGFuY2UNCmZyb20gZWFjaCBvdGhlci4gVGhlIG1hbnVmYWN0
dXJlciBjYW4gYXBwcm94aW1hdGUgdGhlIGVycm9yIGFkZGVkIGFuZA0KZGVjaWRlIGlmIHJlc2lz
dGFuY2UgZXJyb3IgY29ycmVjdGlvbiBzaG91bGQgYmUgYXBwbGllZC4NClRoZSB1c2VyIGNhbm5v
dCBpbmZsdWVuY2UgdGhlIHBhcmFzaXRpYyByZXNpc3RhbmNlIG5vciBjYWxjdWxhdGUgaXQuDQoN
CldpdGggS2luZCBSZWdhcmRzLA0KVmljdG9yIER1aWN1DQoNCg==

