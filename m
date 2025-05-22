Return-Path: <linux-iio+bounces-19783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF64AC0869
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 11:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5FF1BC4FFB
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1B288C87;
	Thu, 22 May 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1+8WRwQE"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06959288C35;
	Thu, 22 May 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905492; cv=fail; b=MFNwl2ERnZLwIWNl4ejZSj25SS5EzEF/R9PfreNZe6XrlhbB7qNOHzUtHfsfbH126FvETJKMNbSB5vxQmER4Dttr6mB4qwre6wFq7shVmOy/2u5Foa3yNDupzYON9OVNvGwebxRJ8QEJlNGJIRAQzGj/zOdVrQoKo76UFnzUmgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905492; c=relaxed/simple;
	bh=ds8NXHmvWkCapp6zNnB77hIGrwh4WE0Jc/tNGZjZzEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZ0G5TjSjZS5sa6BoEuuspCBJXTs61WJ/8xmD7dRWTtdwxvapUT91aUlG96WxTDoQmnqAy1T15zmKy1pki/+w/FdtqXcd9c9IpHVd07VLSu1QyPHQpgtAvRnwsYPfOh8c3VxTAkoRbaizAkay2cfnchAv1d0wdy4oNiwQ2+8LeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1+8WRwQE; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbJTPHUR+X+rF9cyvchysuIOtfhBPhXQ64uYIpsk5YuO3dCSkWzel9Ty+GodPSrd7OBxf7sG30Rc/C13xVhcjm6MEuxf/t/BjDpXpe4A2VvXgAUsFoyVbusWr+rp2cjAoHO5P4NhHqPSbLFBfGoQkb2wqAXX/AlxnhkoWOCg9EomhqsI8/3LB9ICX1qXdrAj6VW8iBhLHlnzuxYb8wzhmZC3NWCK6VloEw2tfoz4cVxv2KGq2OCy2wdIXjK6ofrGz3KkxW8em9G1hcUnTaBnVCRuzDyl1iIWSFjv5JRVsjySgz7YiGswSN2IBa4IdME+YlOuQOnWRdoHyig6PDB2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds8NXHmvWkCapp6zNnB77hIGrwh4WE0Jc/tNGZjZzEM=;
 b=wwF6Ot766BMfgNmsOfMiXTbwGjHb0O8x1FZMIsFvlDOV3L5CusiMgevqr2439Zf9p7UHRaOFIaC4flPW0BazlmfRyMormtq+TxTkeD8qJJqpChCb9CzCXGgZgX3dXfxTMZRBYmbbWHFhlJBYx+/yKiVVjN81acgdjblN8o2BdRm/jrcRxl/Z0Z52u9nyqfRiNC8YaWj6mrny3AL5NkSeGzWOsopJzbn0SA5lAAYcFgBR6cgQ9h+sMi8aZmWaLkoEB2JzzoVbcT5lw5Fn1deubaE7Z0KtSwwOntaTgITMDzUNwnd9FOs1fLq2C0M9dMe4/qCycWVgAZKNX3SgBAJzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds8NXHmvWkCapp6zNnB77hIGrwh4WE0Jc/tNGZjZzEM=;
 b=1+8WRwQEzSMxqULZncbP5z0pQSh4suVSvVEhpFIY0yhMt94Bs7OsLqh2LSYknnWChk7cgukSR0BIq8312G6jFprpKk+gttnkpi7klWNOSyw93pAQzo5nrpKiyKy/tZwAtO17MmE42nAnVLlOACxsmI8vN1rawRQwX/V5eq19y8OInr0KRPZs5c2Xlb23W5tds09aCMBYJWoW5yTjD+CXosg8MoT5F+qZR/taK149hME8VvB6YwKqXfwxyblCyO+cCouwJnsMDJDCxgyerxuDm9Dp3M5bwLodpOZk4vNcifyJ/Em9ACsT3Y7jjRC2l7dDdRiGnz8mwLMqDSqAFs0+lQ==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 09:18:06 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%4]) with mapi id 15.20.8746.032; Thu, 22 May 2025
 09:18:06 +0000
From: <Victor.Duicu@microchip.com>
To: <andy.shevchenko@gmail.com>
CC: <Marius.Cristea@microchip.com>, <jic23@kernel.org>, <andy@kernel.org>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Thread-Topic: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Thread-Index: AQHbrgobzeBGETVwGUalvAKTnXO4a7OlFqCAgDmCJgA=
Date: Thu, 22 May 2025 09:18:06 +0000
Message-ID: <82538eaeb9bfc8dffe0b67d7dd00826b96ed573c.camel@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
		 <20250415132623.14913-3-victor.duicu@microchip.com>
	 <CAHp75VdzVzNV1k8RqG6Rxsg06Oqu_p1o-4QFeT10xBjrFOEZHA@mail.gmail.com>
In-Reply-To:
 <CAHp75VdzVzNV1k8RqG6Rxsg06Oqu_p1o-4QFeT10xBjrFOEZHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|SA3PR11MB8120:EE_
x-ms-office365-filtering-correlation-id: 1fa67558-92c4-425c-eafa-08dd99119016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVh1U3k4Skhab2R1TmcwKy90TytuSGsrMFMwUllHVHpTSHdhR1owVy9obTU1?=
 =?utf-8?B?a2xGSnZFT2tXN0NuSW42T3lMVzFYQWlVVjNxczdXTTN6NkpMelVkbnhlQ3ht?=
 =?utf-8?B?MUwyQkY1TFBSdlV3QVlpanE2UXNrYUhCWEc3Z3I3QzBabXFuMm1OZVRHZmh2?=
 =?utf-8?B?ZGxtYkhJZW5OQTE0ZXhDdnc3Sjg3NDhjb2dEc1pUSk9YZDlFLzFFbjd2dGFk?=
 =?utf-8?B?UkM3QUd3MGd2QUN5RkZld0hneUtud0twa29ibU1ZRXU5UXcwTWFHcFhqN1pI?=
 =?utf-8?B?dFNXQWFpZ1I0aE5pblhYYjYyS09ybVg4a2VIMVhoaXFXL0xGeHg4UFQweFhK?=
 =?utf-8?B?d2UwYWRaczZlMGd3dFhKRUZRV0UvTWZWNXNqVWdjR1lSNlErSGVwK0phZ1BT?=
 =?utf-8?B?b3kwdi81UHJ6b2JnSEZ6SzNsVFBVOHM1QVJ1SnV6MmgrQnB1TC9TZTVPREtJ?=
 =?utf-8?B?ODBldGR3eDdjWWdka3I0eGlnci9ZakY5RGpyS0MrVFFDai9MamU0WUlSVjNU?=
 =?utf-8?B?UGd1VWFuY2FjWUtFK3VGWnNHV053Mmhua0NwSStQdHVkdmUxMFltaDErQUsw?=
 =?utf-8?B?NVp4WkRHaGtQM2JKa2IzQUxnbXBadTIxRTk4QUViK0tOM3NZRXFTMW1RRnhE?=
 =?utf-8?B?anJMaFZMUHRHNnVkbjh5UVhQZEJRVVdrdU54djZWaHJENXJyRm1CMFg1RnJq?=
 =?utf-8?B?STJHTGRlTGhEd3pMU2MySDhTWko1Q1VWc3ZMamNUeWlvaitTVVB6NXZxTjVH?=
 =?utf-8?B?ZGtyVzB0VDRJdWQwR0ZuVWsvbGdpQkxOcnlIa3JjV25iaThkQitWcWRYOWp2?=
 =?utf-8?B?SzdFSlZrWi9LVzlXZGdnZy8zeStkTTBpK09WUGNKWlNnYkhQcTJWOS9SNkJX?=
 =?utf-8?B?cWtsY21YbldYa3hZcnRFZXBYZ3dFVTZhQ2habDloaWVNYytjdEw1OHQrVW1L?=
 =?utf-8?B?bzNqRTRqTmhZa3o0WVpydkNqNlcvR3AxUHhubFA4djlNSVRjZDAxa1duaC9J?=
 =?utf-8?B?ZmljcUJ6WVZLdlZ2L2UxUFRuRDRnWnhrUms0b3FvREpIZ0NWZk53cTZWUE9n?=
 =?utf-8?B?ek9uNEtyemVFekZaYUJMK1V2VDMvVGZqUDRQYWZyZmxNVzFYNGNOTldmUC8v?=
 =?utf-8?B?RnNuUHY0d25zRHErWWhvU1YxUkxvZ01LMENQdXZQQ2J5bjJPSzFYVFR2Nm9n?=
 =?utf-8?B?S3I1ejQwV2QrUXBsdWk2ek1Hd1hXdHM0eU9KZ25TelBLYmRvU2gvejM5S1kx?=
 =?utf-8?B?TEFDTnMvQnNrazR2Tzg4WExkejhBUHJZY2pubmxJKzNEQnBBNGFkREtGZi9m?=
 =?utf-8?B?NWFaTitNSHpoNUp0YkR0Q0xhVEZORVNOem85VmJJOFpZZ21rOGNTS3Q3c0o3?=
 =?utf-8?B?eU1VVTczMUYyS3NVZDJBblBrZHRhRysvcytWRnQyNzhxckRWRWNCRW1veWdW?=
 =?utf-8?B?QXNETUhvaGlPMStQeG51SVdYb3Y2M2w0UWU2cVVHRVY0aW5iTERQOVcxSnVC?=
 =?utf-8?B?LzRXUUlldjNxMmRkQUNxOElRbVpVeGxhV2NabmxiM3pVaGx4VG4rZjBwbThj?=
 =?utf-8?B?RFRaNm5CSXRaOGVMYStPWmlPZXExYXBMUzBqQXRVdTNybkc2RHhoYjc1WUFT?=
 =?utf-8?B?S0pLNUhEMEtTRmRzYVhjTjc5dnhSNUQ4bkk0K2Zid3JKNUd2eTUzVS9tYXNY?=
 =?utf-8?B?VGZnQ0QvNEdQUFowUytYNVlwcHhtTTRBOS9ncXBjQmd2RUxkWXlXcWdLZEty?=
 =?utf-8?B?TEpNSDQ5SkZsaHlIajUwcG5WUk9rSTVIQWhJN2JLelpNelk3NzYwUlExaVNo?=
 =?utf-8?B?cG1YOTJnQ2dEcWpVTklCMWZNVm5FT3hISElhQkZZRm8zZk5JeWwwREtOMHVJ?=
 =?utf-8?B?RHozR004cDhoUEY2UUhGVzdtMUc1VkZMV2RTbVdXZkFKY1plQVJ6ZHVlZVFv?=
 =?utf-8?B?MnhiVUlLeG9BbzcxLzV2RS9RdEpwN3VCS0Z4b1VsUk5LdkVSMnVHb0xpNFJU?=
 =?utf-8?Q?ZL4OwoW995IkiEEcwuzwcMgxIGBAsk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHM2ZVJ5WWhDdjM1Lyt1MU96eFVvaUQvRnF4bTg1dDZrTnJQSWt3bUxoSGNQ?=
 =?utf-8?B?R05VUlA1cHJKWENSYmZjQzVkVWwwa0hjdHRGMGIxbVpqWnVKQTFIS3NKVkxi?=
 =?utf-8?B?Ympubk9GY2JDWUZkSnEzVFpRaWNTZFZwS0NkczE1RGtnOEdzN2YrVkRkRTl1?=
 =?utf-8?B?cFNZRHZFcWtSM0VRMStLRElTU2tFRnpOcFNhTENwWVhiMnJNSkh6cCtFRTdM?=
 =?utf-8?B?clh3NTZlQi9JZHhJd3FKaFlCTXdiY3ErS2EzQlJ3WTFTQllxeDVScDFGbFlq?=
 =?utf-8?B?Y01KNUpyK1l2UEFWaWEvNVluODdNQkxNdUtGQldsb0xPQVRKYzloVEpUVGM4?=
 =?utf-8?B?enhITUZWV09WUUE2SjJHZ3VQREF2ZGU3MjYvZU5OVFM3UFE5UmZWeG1sZWV6?=
 =?utf-8?B?UEQ2enhZQjlUbm5uWXFjSUYvenB1ckJPOHVxeUFuLzgvT3krZmJnQWczY3FV?=
 =?utf-8?B?QmxhNXR2b0k5RnV4OEkwQ0pwcGxXcy9za0F0VTI1d1hRWC82b0VTU1R2eGY2?=
 =?utf-8?B?OVAwTUJzSEkybmxnZUxaMUF6cFIrU1B2TThQVE1vdTh2ang3QUNWeUtuQnRy?=
 =?utf-8?B?TkhyQkFNb0NKVXRLQTZlV0YzQ2VPaWliMlp3bUx6OXZhVFRDajM4YjEzaHJR?=
 =?utf-8?B?Q3ZVb0N0VXYzWG1xaWlzeUpBY0RJTnJ6YUxLZStMdU90YllORForWmxBVVc3?=
 =?utf-8?B?SGZQTWNzKzgvMmtGYUkxSnYvV2dGNy9UR2YxczQxVDEwYUwzaSs5RXc2NnBw?=
 =?utf-8?B?NDdkQmZ1b2lPWGJyOXlSV3hXUWVVOGhqNUdBWWc0RVQ2OHpqV0ptUGFtdWpk?=
 =?utf-8?B?WUNISTVMWUNRNDJqUm52bWI5WCt4WGFHQ05QcjIySnZXdlNmRUpPUFJ6bHJV?=
 =?utf-8?B?VVVhK1NER2d0ZnhlNENlL1k0d29TSDNVYUFHT3FHZ1h1YTdXcEpFQUZ2REp6?=
 =?utf-8?B?SkFzN2lIQlRlMjVrWTNxR05RQWNnZ3p4Qk53VWJ3YXUxaTdaenlKemVMd2I2?=
 =?utf-8?B?NS9nOElZWTRkOE5IcWxQbTlYY0s3Sjcza2s2cHhESVNqcFZuejd1NzhWaDhO?=
 =?utf-8?B?TzlXaWRnS0daeHVKU3VSUE5HVlpRUHJSRzRJVEVQemRtRFpGNlBPcnFGc0kx?=
 =?utf-8?B?YnRmMmRyM2dmTE1JaWZvOEdtZk1sVXZOUzJhU20wcXB3cWlRSjUxYUxycENL?=
 =?utf-8?B?cjNGWVpUOHB1MnpWKzZ4R0E5b2tmdGtOYmJuQ3hhdzAzMjlPREdmTGNYYTBX?=
 =?utf-8?B?cjA4MWtkNDd0Tldpb0VCRWNpamxST0hlcTI3b1BaTy96MnJaQm9aYWQxTjNB?=
 =?utf-8?B?dGNiYVVqMi9HNHIzSUxhY2RkdGtYK3pvYWFQbzRHRUpkMW5YMHB3NkF2STYw?=
 =?utf-8?B?U3czTk92ZkQ5RkMwdVlzRVQ2VHNCYjVXRTJXRGYxd1k3bGp2WjBpMHA4eVFv?=
 =?utf-8?B?eEsvc1YvdGdlbFZDMTdZTGpqbnhRK3JGdnlocWc5OVpVQnd4WEZVTmM1R1pM?=
 =?utf-8?B?WkxhR2pWN2MycVoxcThzNDVhMmxaTHB1T3VSYkl5Lzkra3NEM09qcnh1UEVN?=
 =?utf-8?B?VWlzODB5WVp3VkhGY29NS1JjRjhOb3VpYU1uUUppMlZPcU1LcVBpT2dGVzk0?=
 =?utf-8?B?YzBma1N1a2xLazdQaHY2d0M4KzJqYXcvMFpXeDdVVVp1ODU2N0Z6N0ZPMjhx?=
 =?utf-8?B?bytpN3UwS2daWHkvcVFMMEo0R2hNcGQ4TzRXWFN1QlBOZGtRYjFjSnNwYW83?=
 =?utf-8?B?NXA5Z2kyb0VCbURFaHAxOTJrV25wRlArQmI5bitnM3ZBMWY2QTY4ZUJXTjdD?=
 =?utf-8?B?dEtDV2VLbzk5blAvS2kvY1VISTA4UTFFVVF2YW9oOUkxMDMwclhCOTI1b2Jr?=
 =?utf-8?B?eEtVU2NFcUJQRjc2ZHpNUlFBWmNZOEt4bnRuaWsvaUZkSjJpMDFTUjg3N3Er?=
 =?utf-8?B?czZDMWtCMnRIZmk2Z2RVVTRSR0U0dVh2bFEwTEtqTDJUZ0Nnb3dkV1Bkc0ly?=
 =?utf-8?B?S2ptdlE1V2cvYko2NzhON2lmdXpDcVEzK1JQWWUrMFR0SDYwZnlMWmMxRmQz?=
 =?utf-8?B?bVVaOGJOVktHWmM2TzRuUDIxdGovaDY5aGQ4ODVBVSs0a0tYWE1LYTgvUmxz?=
 =?utf-8?B?clhxZGNMZGZlUDE5bTF5QW8wK05BSFRPcGxmNFNGdklEejMwcG84RStWVHI5?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF0F12B0A27344BBD66302D9C02FC6C@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa67558-92c4-425c-eafa-08dd99119016
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 09:18:06.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/s5ck7D7aTqSX/gE8+PpOhMnlzylCudLtRBNgnL+UHnHUlIEP/uHFL1qeyx3Q3rezgsFdNUKTqZ/0+xg6kVcBaBqjo2Y9jsi6pwBQeWTYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120

T24gVHVlLCAyMDI1LTA0LTE1IGF0IDIyOjA1ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UKPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiAKSGkgQW5keSwKCj4gT24g
VHVlLCBBcHIgMTUsIDIwMjUgYXQgNDoyN+KAr1BNIDx2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNv
bT4gd3JvdGU6Cj4gPiAKPiA+IFRoaXMgaXMgdGhlIGRyaXZlciBmb3IgTWljcm9jaGlwIE1DUDk5
OFgvMzMgYW5kIE1DUDk5OFhELzMzRAo+ID4gTXVsdGljaGFubmVsIEF1dG9tb3RpdmUgTW9uaXRv
ciBGYW1pbHkuCj4gCj4gLi4uCj4gCj4gPiArI2RlZmluZSBNQ1A5OTgyX0NIQU4oaW5kZXgsIHNp
LCBfX2FkZHJlc3MpICh7IFwKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGlpb19jaGFuX3NwZWMg
X19jaGFuID0geyBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudHlwZSA9IElJ
T19URU1QLCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaW5mb19tYXNrX3Nl
cGFyYXRlID0gQklUKElJT19DSEFOX0lORk9fUkFXKSwgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsX2F2YWlsYWJsZSA9Cj4gPiBCSVQo
SUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEpLCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAuaW5mb19tYXNrX3NoYXJlZF9ieV9hbGwgPQo+ID4gQklUKElJT19DSEFOX0lORk9fU0FN
UF9GUkVRKSwgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNoYW5uZWwgPSBp
bmRleCwgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmFkZHJlc3MgPSBfX2Fk
ZHJlc3MsIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zY2FuX2luZGV4ID0g
c2ksIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zY2FuX3R5cGUgPSB7IFwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2lnbiA9
ICd1JywgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC5yZWFsYml0cyA9IDgsIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAuc3RvcmFnZWJpdHMgPSA4LCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmVuZGlhbm5lc3MgPSBJSU9fQ1BVIFwKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0sIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC5pbmRleGVkID0gMSwgXAo+ID4gK8KgwqDCoMKgwqDCoCB9OyBcCj4gPiArwqDCoMKg
wqDCoMKgIF9fY2hhbjsgXAo+IAo+IFdoeSBpbiB0aGlzIGZvcm0gYW5kIG5vdCBhcyBhIGNvbXBv
dW5kIGxpdGVyYWw/Cj4gCgpJIGNhbiBoYXZlIHVwIHRvIDUgY2hhbm5lbHMsIHdoaWNoIGhhdmUg
dmVyeSBzaW1pbGFyIHNwZWNpZmljYXRpb25zLgpJIHVzZSB0aGlzIGRlZmluZSB0byBzaW1wbGlm
eSBkZWZpbml0aW9uIG9mIGNoYW5uZWxzIGFuZCBhdm9pZApyZXBlYXRpbmcgY29kZS4KSXMgaXQg
bm93IHByZWZlcmFibGUgdG8gdXNlIGNvbXBvdW5kIGxpdGVyYWw/CkkgY291bGQgaW1wbGVtZW50
IHNvbWV0aGluZyBsaWtlIHRoaXM6CgojZGVmaW5lIHB1dF9jaGFubmVsX2RlZmF1bHRzIFwKCS50
eXBlID0gSUlPX1RFTVAgXAouLi4KCnByaXYtPmlpb19jaGFuWzBdID0gKChzdHJ1Y3QgaWlvX2No
YW5fc3BlYyl7cHV0X2NoYW5uZWxfZGVmYXVsdHMsCgkJCQkJICAgLmNoYW5uZWwgPSB4LAouLi4K
ClRoaXMgd2F5IHdoZW4gaW5pdGlhbGl6aW5nIHRoZSBjaGFubmVscyBJIGRvbid0IGhhdmUKdG8g
cmVwZWF0IHRoZSBjb21tb24gcHJvcGVydGllcy4KRG8geW91IGZpbmQgdGhpcyBhcHByb2FjaCBh
Z3JlZWFibGU/CgpLaW5kIHJlZ2FyZHMsCkR1aWN1IFZpY3Rvcgo=

