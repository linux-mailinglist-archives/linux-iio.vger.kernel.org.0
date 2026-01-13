Return-Path: <linux-iio+bounces-27671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D394D18A79
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 13:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C35306FC49
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED138F229;
	Tue, 13 Jan 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="vzdpacjF"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020096.outbound.protection.outlook.com [52.101.84.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA238E5EE;
	Tue, 13 Jan 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306397; cv=fail; b=b5Vd+EAyxQrYh0uXkhVFwijWvcsxAVNsMia/zRuethEA4rTVC6/8K1wCl1laQL6/Oja5kfY61IomL0AF/PXEbvC/udjVG7JXp0QmASc80nyeRZoe62je1/bWo34wxMBrx2cLfIWEQUfQGtOXnUGh4IdzwasMXUA2UlgKpiZGNAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306397; c=relaxed/simple;
	bh=UjBQBPvRoOCgNMTJaFEaQAzyXOK1WDMctXeR8dQyHqU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XK7jfzkwQChDPqp0k6frD4N1iRjZK6P7cILkDRGwPfCDaf6m7MaqO0MyYO462UfmQjlcftC8luUF141LfNkmgCaut98AYZa6X3i5iOw0uqbApltgkjyfwEnZQI17WuO9McmHTtM+SlEf6AiN2R0DmhPYazHWFCJHmXs+I1dPlxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=vzdpacjF; arc=fail smtp.client-ip=52.101.84.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy/Z2jcPaX6NrUHy8PkTK0BDxOfU+JI0fIZOYFCsKfV86PKcYO64WnZQbivhK9xVjrUrBdreKA387WjvpYICDBp7pXTtZBATOj2s68a0dy4nNzKkrJVV4yxjPCCHguOuvJ4OcVyBsomNYuWvB6+v4+SZJYtNtkWCQXGEwH3MhkmRQw9CwmsmcE+JVB8TRWJKw3LMztEVk7IrBcRDSqw/2lYgWMo6hazz3DfOQmtrtHXW04YDMhSWX4+lDM41f3ry6iYm51po4HZPMroEilyKnCqFxClWK60dyx/3YoENAioEaCHamg0Q5Ss6J25ffuqH25wtdUAHrTShwzGvy8loHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA7KCPAvmWD16kzoFhwUL1P7xYJGZXrHWcD/N3CUrQY=;
 b=E78gcomZ8UgmPpJNFIcliiJ6VWdcSBEM11NeIJC16TL93Fr/S39JB7WQzj6yWp2Ap3dIn4jaKJ6OSvyUY6ZPs/k4hazeJEcNTUT5YYfMdzJwbKIgWSqrDOtrQLUWIT4yHkkAzzaZG3uZzVVj/i5BSYuawx1TNqDDfnA5aKS/pHgfAsQvzAc+241YkrEnNy/gttFxbplC3+HTduGwuktO9dYqX0oRZbdngTZftrHrPz/8gwzqf4L9aNA+qzCqOhFV6Q4qQP80FkY3zHAg/A0GQp0Wbyhv7oxCJjJtuNAZStWo+Bmn28hQuGNQ53I/g3J60GTWTvWN4svLi6e2XTgyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA7KCPAvmWD16kzoFhwUL1P7xYJGZXrHWcD/N3CUrQY=;
 b=vzdpacjFO7vaD5hCID0jZaBFlntbESRWLXkZnkRe7uSwiew5ATKT4QGVpL/GvCfOfVQaU4txYSa6mB5eTD4zjBnGYBkk/x0s2+HWXzkVzSwRMZcv3HN17QbyQmOisGjbPFYtpLlWLn0uymU0ycV5aSUiMXqa0zftSw9GNauMZ6VVJ1U/yzd3TZt7Glws84y/sJhe54vACbi1m2E1l7tRKu1ZNyNwACmqvVKU1cz3ROlLEvjNmeICo3E5wf9aP6ik7oRBPRKBT10aYnwGzIb2ktiSM4n6bFov5NswuakNjQHRDqzJlDAYERVdYKMK0bwkHU92F9Z/YveNIcwuLBWZMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DUZPR06MB8963.eurprd06.prod.outlook.com (2603:10a6:10:4d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:13:01 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:13:01 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 13 Jan 2026 12:12:49 +0000
Subject: [PATCH v2 3/3] iio: adc: ad9467: check for backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-ad9467-optional-backend-v2-3-0a27e7e72f41@vaisala.com>
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768306378; l=1324;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=UjBQBPvRoOCgNMTJaFEaQAzyXOK1WDMctXeR8dQyHqU=;
 b=FD2qzVoxHOJIK0URcAI6xGywtEuAQqZCT7LnfmLUYX0M09mqgjZ0WwPKMCB9QTa2cNvJXcnTK
 47FKVqne8YnAnUwQFjPgLbjgUJGYBOJOyiDtVQ9DITIwdsUgoN7odRs
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0005F6A1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::129) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DUZPR06MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e55f82-a088-407f-748b-08de529d18b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1lHV01BTXl3VGNiRklJRk5PZVdJMDIyRm1hWGlHKzlRL0FMM2dmajdDWjFx?=
 =?utf-8?B?M2loaFB6TnNnbmVmc1JhWUliTmZIZS85Wk55TnNkY0t4RnU2cVA1YXBJYlRJ?=
 =?utf-8?B?cFVJeXkvazNCcTVyeCtmWEYrOXAxREs4RVYwejNaVE9TVVd6OFg0SmhlMlpX?=
 =?utf-8?B?V0RqRndXQzZYTjF3RGcwSnRpcU40NUU2eTJYYzhUWFF3Yi9GNzArWmxOczBQ?=
 =?utf-8?B?ZHEwUGszZjZ3U013SEpmMi9PZDNKVEQ1MHVSQTh4V1RIZkp4RDZzbjBYMndp?=
 =?utf-8?B?a3AyTHg2dmpDT3doV2trVGcveGZGZmRYUHV2NVd2anNJL0l1VzBCbVFvS3VO?=
 =?utf-8?B?UHZxbm5VRko5ZTYxY1dKVU9EbCtxUE5rNUs4UGMxZWtXa0JYRGdzNVJsRTlp?=
 =?utf-8?B?K1BPZkNIYlJ4SGs4S29FT2hPN1FkdVBjV3V3dUczQ0V5ZVFlUkdkMTdsS29z?=
 =?utf-8?B?c21xdzFpeXJ2RUNGSzFjMVFGL2JieVNwSTFycXNKQ2laeWVGTmJ5VG1OQ3lr?=
 =?utf-8?B?LzRyd0hTaVdrTjZXYTFOem80Vk1wbGFZTjRIVUpuNXBsQkdNOHlyVVNyYnlv?=
 =?utf-8?B?YXpQNHF1TzNvZG5DVGkzdnFMQlBPem4vWk5UZWtCaEhZK29lZWpsT3FUWXg5?=
 =?utf-8?B?L0dXVVpsV2ErR1pDekYwTEVnQ3VLOWxjNk5JVnJTSk9qcThGUnBZV29KaFVN?=
 =?utf-8?B?VTdIeWNadmd1RmV4SFZ2L0xsM3c2WUxiVHNyVzB5ZWJFZWZkL2NldXNHMzFZ?=
 =?utf-8?B?T2NuZ1haWnU1Z0Fyd1o1cEtOaURFc1d3ZURWZkFzUHl5Q3puM1lPZC9sa3dX?=
 =?utf-8?B?WmlEU1dNNWpuYjFOMW82WmdMNWNXdDZQaGxFbGlobTllcGpWUWxuOXhMTHJI?=
 =?utf-8?B?S2lrTUhHYnZWOGVoQW9NM1FYYW8rUjFwaVFvSU01a01NdlJYUXFGYkhZYnZn?=
 =?utf-8?B?aWlwZlowTFZTWExsUU9kL29jTlZ4MWRCNXE3UTUzNVluRWw4dkVVbWJLVFNK?=
 =?utf-8?B?Mm1zY3VuR095aDFrQmtLU21BU1d2TGpSS3dtMnFCLzlyVENHQzAzcjQ0cGhD?=
 =?utf-8?B?bFF1UHdwRDliQVlSSTBobytBSzRGNnFmczY4R3kyYWl3eU1yaXNaeXRIVmR0?=
 =?utf-8?B?a2RIT1gwRmZ3U21ranMxUWZYY3NHVXJEU3dWRjUxbE84MVVtQXBJUFJhN3pC?=
 =?utf-8?B?NjdKVnZKbE9KUXg4NFltbW5qUUYzS2FSak1FUlV1VmdjQTFiMjhpdzROSVVG?=
 =?utf-8?B?WThMYXVTbmNRSjl3blJjdXArZ3BiTFc3VTJ5SWN6RUplR1pZbk5YenVrNlNu?=
 =?utf-8?B?NXZHcmhPb1hQOFlQZ1FjdlVJOEYyTlNpcnlBZkRPSWFZQ2JYMDZPRjJ3VEVs?=
 =?utf-8?B?TzZFVGlEbEo1Ti9jQU9ROEs2bDB5SnAxRlZnVUVyK2RoQVpjd0lrTUJOOXhp?=
 =?utf-8?B?WkhwVlNPOVNBVjltWTJEa3paQ2Q0YVRBWmxhUDhod2Y2NGd3QzZ3aklTYzhZ?=
 =?utf-8?B?SjBPbWgzcFkwaGYzdThJZkJ5Y3R3eEo0YjlBVE1DS1dyd2Nad1l0V1oxU21T?=
 =?utf-8?B?ZjdYaTZ5Y3I5KzdxZFZQRWJndnovaGxJMGxja3NGOWwwV0Z0K1laSXJrQmdW?=
 =?utf-8?B?a0h4dWQ1OWNOL0lGNTRKUVNJLyt5eHVvTHRjOTRxWVBQaW9NcUViWFhqTTNk?=
 =?utf-8?B?Y1dSYjVTN0RtaWRuVFhjTk9JaUx1bVpsTi9BWjhEY3g3dTBxR25jMFFKUDFJ?=
 =?utf-8?B?ZWhrazlnU0ZaNS9tVWNJNmRrY2RNbHJ3eHVBVzk2N2VNTmhnTVJJUGFlK3g1?=
 =?utf-8?B?TzVOTnFScVRCRW8vSEpKWXJ6aHRuTGJJWXdmS3p5R3Urd2p4QS9nakJoQnk4?=
 =?utf-8?B?b3ZDT1VXczZGeXFxVGN2dStvS2laSHNFUWpLbGlPb2tRQWFaNUZnMUt4SlZl?=
 =?utf-8?B?T0daa1R0L1RPNG85VG1mb2VjWGFJTFdJcXRMb1AycUMwOUlJUXNZTzVqdDgv?=
 =?utf-8?B?Q3BDeEh3MlpnTHJRQkxucFdxSVAyT1JDN2drb1Zhajd3VFRGS0wrYVdGMHFT?=
 =?utf-8?Q?XE6ObX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWVEL0FNeWVKRDlidDRmY0VZYm5XL0tmY2llbmZnSzlISk1wdmd2SDl3TXFT?=
 =?utf-8?B?VWNpZWo1VGdPYjllZjArdE5tdmp6dVJKUEI4MDI4Sm0zTG5pNk94dmFzL1Ix?=
 =?utf-8?B?QXFleWtheDFKSzdQaXpHd2psZk1ub0c2UmlmKzNhZXI1WVU2bUVtMjNxUndN?=
 =?utf-8?B?NG5YcUVZekFBNHF5RkRMZTR0L2lRZTNJTEZ5d1JlS2JFckgwZ2tXd09mSWlr?=
 =?utf-8?B?Qlg1MWp4Q1NLMUhnWG5sSEpYT2pRclhacGZSOHZ3QjdVc2RMR25lTUVpYmNq?=
 =?utf-8?B?M2s2Y3Y5RVFUcXNta2c1dEdPNVdON1NxU3JpRTZJQXVvS01idnlmMUdNKzBz?=
 =?utf-8?B?YXh5THh3azJueWVITEkwUEFoV0dmZW1ad0FSSDFacVVtVkljKzVXR2xZUDVK?=
 =?utf-8?B?UE1Jc21veHRxZEhSbjJTSEVRVDFSOUlNMWNmVGwra2NNS2swNlR6NnV5RkxF?=
 =?utf-8?B?REVKd1VqUjJheUJtdE5QSkdNNUxKQU1ON0pFOHR2a2h5M3BmVHNhMVpoUXdX?=
 =?utf-8?B?YmJSSVV5WDM4VUdDU0tCaGc1WDdBb3MweTVVTzhWaTFnWElhN21RRmFudGk4?=
 =?utf-8?B?eXlxZGF2Vm8vcEVCaDQvMkpRaEY4M2NqMTlmMDR3RjZyZjZNQno4SWFUQUow?=
 =?utf-8?B?dVN3K0M3cVVidmdIVjBieGNGYUZIaWc3T3dVbFcyUytxNzlnaDBZWHhoeGJY?=
 =?utf-8?B?aHpQajY2cWMwRUJQTm1EdkxLTHEyL2VqamNXc0NOZnhiZTVxTlFITi9ZRXpN?=
 =?utf-8?B?eE9BMitoU2lWV1JmRFRoaXgrZjAvbngxU2pqMkxPeEpjeG11NkU5NGpOZml4?=
 =?utf-8?B?dURiVWlRRFNHRmlQVDFjdzErNk42eWxxMnIxa3NRUzJMQmFPTkx0RTBiMmlM?=
 =?utf-8?B?VG1TdEZxUkVqRmtXd1ZGeG44ekdaeG5LNWhWbXVwNDhZend6M1NqclovZTRC?=
 =?utf-8?B?SDQ1RklWQ08ySXBzY29UeStuMFNzZHMzYmJ0dUp4eGtldjlLK0VtR3NzajdE?=
 =?utf-8?B?Mkh0cm9RRGN3R1V2SEk1Q0hXQmtVcUZCc1Y0N2hhcDNrV1hibDYxUFpsSGxM?=
 =?utf-8?B?cUpjNkZ4WXpCYzMzUTJTWFJETFd2Ny9nN2M5ZElKRjhjcFVzU2hKaVppWmV6?=
 =?utf-8?B?TlRIbmp4OWlLVSs3c0FUMWJYdkZVMWo0dXFreWJYODc1QWZFYWV2S3NNSmJK?=
 =?utf-8?B?WVpPd2hJdE1DcmJUVzUrYmRZejFsVjVQc2NHT3ZjTXh4RnMzL0x1aXBxWFRW?=
 =?utf-8?B?ai9KVFVnNEdPbVl5N1pJZEUyMUp0dHFvTUlKQW9FbXZDMXZkZFlDSDJLM0xF?=
 =?utf-8?B?VW41VlhFL2k4R2dUQ2N6d2lPZE5vWkllQ1pkZlY4Q0ZJL2JEeVJJTjcrSC9V?=
 =?utf-8?B?M25EbEpaUHlodzNucDNoVm10QzJXcGVIc1RjV09aY203c0ZMK05xeWFvZWZC?=
 =?utf-8?B?QnQ1aVpoR2ZHMTlFcHZxU3djanE4NFd5WFE2SFVDdGN1bVd4N0F0dUJkOCtL?=
 =?utf-8?B?UzdQRVd0NDcwNDlsQ0g4bVg1QVpEMW96clVONjVDME1XdWFPQkJpcWprM3NR?=
 =?utf-8?B?TjlRVit1YXd5d1lnSnBlSm51Nmx1SEtwLzZjZnVZQ3M2cGJWdG5nSGhVY3RQ?=
 =?utf-8?B?SGJxaXFXeTVUemRia2VhTU9KYmVkbWkyenk1N0JoTlBpbTBBT0NZaFRWK2Ry?=
 =?utf-8?B?cGJxYVJyemlMV2toei9NNkp3L3hBYkJlTFQrTGt2bGxVZTVZRDkwSEtQWVlr?=
 =?utf-8?B?bWhIMkR1OFR0WGxKZ1ZOYjNkaW1LU2hNT1V2VVQ1ZzFBbE9zNDYvSUIzY08z?=
 =?utf-8?B?UllVNWVGTlQ3SWtiODVqQzdnUEJTTXpOUzNMSUhUWGF5cUZQd3E2alVtNU9o?=
 =?utf-8?B?TUtNUFdaUnQxZzhXWmRkSS9HTXE4VkNxNFhScVJNMzJtUGxqTjhvaUlpMUoz?=
 =?utf-8?B?cUo5dk1nSmoyVDB6cFM3Qkp1OGdIMFlDSHBwa0JudTRBVG5lSVBGMEUxRlht?=
 =?utf-8?B?Q3k2bk83YkZwMUV4dXlPTFluVStVODdNOVNQZk1EOUNsVFQ5QU80WmFxeEhP?=
 =?utf-8?B?TVo4d3hjK1pMc0NSUFhOeUtPZURERUtkclNpMkl6Mm1ndWJkRG9YOGtwOG1E?=
 =?utf-8?B?YUVHa1hueURySDRiOXUzVVdsV1Z6Z0xHTm9QU3BTTHVSYnZCaERYbU5lSllG?=
 =?utf-8?B?eGo4dUFRYmxZN01FbXNETkRQQ1VCcDc1NEZxcW94czhZSTFpZU1BL1FBbDRW?=
 =?utf-8?B?aG9yNjlNSHZUZ1FRVHlsajdzV2d0TnVuakp6cU0yWEZQRFA5Vlp1YzNtUGFW?=
 =?utf-8?B?dEFxR2owemNxRnRtdEhrQzZpbUYvanFpcEJIcFkvekF4dkk1MDg3NXRtMVY5?=
 =?utf-8?Q?cOXpawUrCIrF9/sI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e55f82-a088-407f-748b-08de529d18b7
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 12:13:01.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaCGgy87Q6UvwxuYt6QJJGR+tDKGvQucpFICVDr4zlBm9ixSZ0cr7ty15fGcN4VW6HsDEFxpewy+ZzLtxvadtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8963

For cases when the backend does not support test patterns or calibration,
do not attempt to use those features.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 9cfe66425d4e91e215cccc40e24a92c5e99e9b87..ce7dde8b79540bb0eabfba9470b3984e8723d4b7 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -645,6 +645,9 @@ static int ad9467_backend_testmode_on(struct ad9467_state *st,
 	};
 	int ret;
 
+	if (!iio_backend_caps(st->back, IIO_BACKEND_CAP_TEST_PATTERNS))
+		return 0;
+
 	ret = iio_backend_data_format_set(st->back, chan, &data);
 	if (ret)
 		return ret;
@@ -665,6 +668,9 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
 	};
 	int ret;
 
+	if (!iio_backend_caps(st->back, IIO_BACKEND_CAP_TEST_PATTERNS))
+		return 0;
+
 	ret = iio_backend_chan_disable(st->back, chan);
 	if (ret)
 		return ret;
@@ -807,6 +813,9 @@ static int ad9467_calibrate(struct ad9467_state *st)
 	bool invert = false, stat;
 	int ret;
 
+	if (!iio_backend_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return 0;
+
 	/* all points invalid */
 	bitmap_fill(st->calib_map, st->calib_map_size);
 

-- 
2.47.3


