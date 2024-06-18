Return-Path: <linux-iio+bounces-6515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A6390D91A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E07B28EF7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991F74654D;
	Tue, 18 Jun 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z3j0Pcik"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2020.outbound.protection.outlook.com [40.92.22.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603D2557F;
	Tue, 18 Jun 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725830; cv=fail; b=gsJUTBktSr9RFuEvMTsNi8pSvr14zepnD8bHQv8Vh9bUOLwuxikkjVtaTVXzBy0/gcVrfb4srVX2MLCrRVbfp9LkVyemWB1bQ3f8D1AZjVKqHzq4Oq5Ys9Tu5FJCI1dTd2kXYoxoBOdj+Idp8EOZCZYa6r70IUn2l8u+bYxr5TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725830; c=relaxed/simple;
	bh=d/OBKCkYmue+NiW0RwkSn8Llp2pH1nzaEhPkAZhMeo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDmvBJRHjVEd5x0TCDYHyZTIlSv6Z0llNyicwHVPk94wI1wSCZwRUp6NxHE5XB2J+dm9D5QlmCitsE3GQiH7Ah5rj97G4A9DdOn3GGQJRIp3wv1BwwWQBTsVOpFweDL5WuaWlM65ZBc/cTJ+NBXCtoElqp4dN2a/oNRAC93kMis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z3j0Pcik; arc=fail smtp.client-ip=40.92.22.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYH52eQ24jpOIjI0lRewQXvUJQOioj+UZBrsurvfwjVqlEg5JC7awwReKVA9BsnzzOSS1zbtOoY0jDjfUbMxh+P6SjDnEweO461N65p2YlvNbpuzjoZQonYu8FKuIOVt8LmmsCbMCw14LMvntFeu5VoMoVUEwkWpvcN5Yflodf5Zh8iCTEKb9QhllsoAOUQlHL7v/b7yGobeksIL9Tp5T1hS/lbb/QRbyznZokA3kJ5FpP636VhzJ+IfeF3XXzviaAHHS1p6TI/X7zltNDZF1BcpJJmoyZGNNUfUJbT66sS68wJ1bYyWmzhk4mQJBvXOIGg2BUxktCM4Ntju5j6knA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9YREF1DaJ6EDQ2bX1Q61UB+9n21lhd+/qCCoNRwxGI=;
 b=UOAsHVRa2EwltF74r2oJSUN/ix7M04S9Ye18lHexeIzzAWbTTU4KnbTMVl2SI608ZO5ed5spEST5OXO/NaCJxGDDifNPocxpX+PlPp+OEseJQpJN5UaHR7Gm1XWdTr7/Ll9c36O5e4LGIFpvi+O/XoBYwSbmgr6nnP8ZrcwEw87u33y1BDpY8JUEIScipWIDXT3fRlZi/QdH7XhyWbmDD4U59dq4j303LfNi0R6pH9rSk+RY0AnoOlYX6C5e8H1FcFTVWFJRvV34m6sxzNwBQYhkkSsXvOt5L50NKZFqMGsA7tnRs1HeB/p0thcXpvgaztNY6JCmg0XlrYdEqWRY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9YREF1DaJ6EDQ2bX1Q61UB+9n21lhd+/qCCoNRwxGI=;
 b=Z3j0PcikvANf7zoa4t4/8TXU+ZEm70l6GeHhuNNzdtAmVuoutQFVvEXFPvH33gEkUBf5DtJ0ApPNc9uopqUsnXh3/Y8Lee+l65W0mwG/aQ73zBqV0Uf+NIgOqUOiyMeojryQ8uQVmQe9PnOF4TJzlYketpEQg33WhW4X1y9NFFaAH5FjNMX1dsLCbEvazzIQ6+54toIxFNaAtkhzoM7QB8mrhYI2K60yE2zwhSckPpdsHEExlgyrBEAzJMXulM4+SB3hNRCRSTFkliyCeiuqPvujBy9Yy+2KQmVionO5irOhK6VgJ7YEZG2Qd1oUDxO9AIrUGZPoEzsGzqWPQV8PIw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:50:25 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:50:25 +0000
Message-ID:
 <SN7PR12MB8101B6D0AB1246797C67E25BA4CE2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Tue, 18 Jun 2024 23:50:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings:iio:proximity:new vendor prefix: tyhx
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
 <SN7PR12MB81017D645B48DABB297A62DDA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <13e586c7-26f6-4190-8219-404a2637905d@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <13e586c7-26f6-4190-8219-404a2637905d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [0r4QrtHqX+iQpocbsCEz362K++3DHB+KbF0yoI26Sw9K+yZx8/3z6wlLZdKREdk6]
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <e19db0f5-0110-4879-864f-6c551bfdf7b3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: a35b8b79-2473-4215-0555-08dc8fae5e88
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|1602099009|440099025|3412199022|4302099010;
X-Microsoft-Antispam-Message-Info:
	15vuJ32Vi0nDb33UGHjEmffo7pMhIp42MHB62ByUFMcEqVmxzzTHs2eDLqdeOWTeUi9HBGkFeepvtORwAr1rCZvRG1VgSJB7tjzl0taWqu+Hcq5aba2/hCjCcOfLdBCe14Nva2qbjEKTwNRfejkUy/szSfZsvzqiEw2J3RRG+xFzRSNYO6fgNq8Xm6DErPB5Fh4WPmovyMQwerYJefN1JsQD3twUSXXfPhq3HPcAp29ZzBdz8BT/FiOZFHjwXMgO7F0SFz9V17AvKCGBKGxOv6eXIMbD7zw5n/v/gckuScitt5bvuSBup64ANVsoMsl5jmAC/fynYNs1dmPu/rPY+V42HTTxYGBLQ32jYzyq7Adk7/0nnl+jg7lr6nD+vkjsQHT1abaNWL63EV+zG4AJI5+0Y5gApFuEuIgkjiAZvCBfKZ9/vK8LySt5oIu7U0PN4OhI7p4MLXM5JD/AxE4qwVRxoX/2UAbXnrMlGx1f3QV3iZ90/2aa4BMa+/g1PS2SXYzHtbJTtd6UsL717mwJRH2pAhsSgloLQkw3ToTrg7SpaGYGTm+qt8DPDdNR5pkvBy2xhA5pDEwanSuOcFbK8ty9tddh5xga69UMbQAnSznpp15HOIdE6mzwnYNXbHNHjCnwdXB9pHqrLkno3Omw+3RetXoQM+42zX5kDiR3QNI0LX14Ta+4CVFDnVv0zn/Xq7ltWwJkk+YNMSxpGzwmJg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUhtcU1xbzFaRzBNN0F2UUxZY3JJZUN6a0tQYitvQXBhRHd4dlNCMkJZeURk?=
 =?utf-8?B?N3Z5Tlh0UUg4OWJNaTM5dGxwa29ZSXNlUmNNMHphYXRVVW9BZ3Q4ZURWZitB?=
 =?utf-8?B?VGRkTitJckM3N0NUM2l4TElXaEU3eDlmVzY4eVQvNWFUQ1FjQ3QzTTZ2Tlhi?=
 =?utf-8?B?Vlp4R0tsNGhEb25MRytNWkJhb2ZzbjBJRUFiUFFwL05PNmZ4cFJoM2t2SzhW?=
 =?utf-8?B?eDlzQUcrYTVlUE1yWlRJZW0vdlROeU9KdHRVM01rRUpQUDRpYXNZbU9EZWtq?=
 =?utf-8?B?WU5FcUVvNHV0M2dpc1BJWC8zVnFmUCtzL3pIcitXQ0Rzc0JwSGFDZFBVSVM0?=
 =?utf-8?B?dk4wK1RybnhSUVpjektWcmtYblA1L1hRaEUrbDIyeTRzVE01K1EzeFgybWxp?=
 =?utf-8?B?YjhiQzA5eWVLUjlVR2QzNDVJaWNyRXI2cGFUeWI1TE14dlR4TTlQWmNDZ1c5?=
 =?utf-8?B?OWpEcUE4aE12eE5iRXlmSUxOK3IyWkJ6TzVDVklXb2U1eTJDd1dUa2ZnNnNr?=
 =?utf-8?B?U3M3MG9hdnVVRUhycU5ibmFPOWFjQXBWWE5idjJVdDRwcG5BcHI3TmU2djVG?=
 =?utf-8?B?dVJ1TjMyM0c2bkhLS3ZoZ0hvWVBHbmpQTmNRbC8wS1NNeUVxZ1VFVGdKS0xY?=
 =?utf-8?B?azlDeDJpbVpvNjRLWFZMUGdmQmN6bEQwektqV040Z29NMUxCM2dzUjJET1NC?=
 =?utf-8?B?K0laeUlONjBrd2hTcUp5czAzNnhOUHpUNEtGZFFwblhuNUZ3b0dOMUJiNWZq?=
 =?utf-8?B?cDNqMkZWMUs4UTdBNktEbE8wU1duRzM5TnVVaVVsaDJMVlR4OEdTSTdEMzg5?=
 =?utf-8?B?dHJyV08wd082VERSUnp5NjRqek9lYStHb1dWbzJOd3h1WTVPN2FBc3JJNnV3?=
 =?utf-8?B?cHo5RURjMUdqM2R4YllZN3h5Rzc1aXNmbTVjMGJEVU82OGRNL2VMa1lPSHFj?=
 =?utf-8?B?b1krT2R2VmIrM1BOZW5nTGtldkQ4eElUNkQ1OUo5N0d0MXlBTERORkUrc2xz?=
 =?utf-8?B?NmNZU1B1TElhK1hab2NRQVhqRFNuZkYwUHVTaTZJTEo5NzkveHExUXp4WUFQ?=
 =?utf-8?B?Tjg4NnB6ZXl4Ymp5L1pZLzZWNVJEeGttcXI1RDVBNHp2WXZxbTc1TUI1Q05R?=
 =?utf-8?B?SXRoNFQrNm9meVNMTE9vbmhpZ1JxaVFhQ21wZ0cwcnE0MHZoN3BNSklRdnVi?=
 =?utf-8?B?NVN3Ym9qRFJ3RXdIOU1tZjhBM1pNbGM0UmZYLzZWeW1UbWs3NkpvZWp5bERY?=
 =?utf-8?B?NWQvOXRaa0Z6aDlrcGc2OVU1UDNOY3FTL2dzbm54WER0d0JsZEc3c3Fvd29z?=
 =?utf-8?B?RWZyU3RRUHh3dkJPeFBQWHJydEdxTEJtUDJZSFVSSVhKZ05WSFo3ZHNFRWdu?=
 =?utf-8?B?Nk1QYk5Bb2J1K1hYa0hwRFFvWjBvQ1IvY2JDNjZnZGx4cFNCRnN4UEt3RFNF?=
 =?utf-8?B?M2JKNlVtTEZwczlIb090UWpXcXdIb0NxZnhlYm5UREJocm5lNjhoenV1emRj?=
 =?utf-8?B?bEJJZS9qK0kweHJpQ1JaM2ltNFY5MUdiTFpQUHZkYWZQZU8xTDJnekd4MDg0?=
 =?utf-8?B?MXIrckVsVk9IYm0wb2wwMXRUSkhRdjFldmdSOTAvK09BVmp4d1krTk92Wm5V?=
 =?utf-8?B?UUxRQkZkMnd3Uk8zSlJwNEVXdVJnYWp0SW9UTllwaTdnem04eThSbFlrSXRt?=
 =?utf-8?B?a2lMYjRZVHJmcExEUDhvVE1ndTY4akhydzZ0dk9Kb1lwSTBFQktPSnFtWUF2?=
 =?utf-8?Q?DmPVkUEa1aHnIBoAk5Tt5E9X1otZyOofoqXdBgW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35b8b79-2473-4215-0555-08dc8fae5e88
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:50:25.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655


在 2024/6/16 15:43, Krzysztof Kozlowski 写道:
> On 16/06/2024 09:36, Yasin Lee wrote:
>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>
>> Add NanjingTianyihexin Electronics Ltd.
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
> Best regards,
> Krzysztof
>
Hi Krzysztof,

Thank you for your guidance. I have modified the subject lines according 
to your instructions. Please review and confirm if they are correct:

commit 18f572f2b3c2c7827c168d9d44a471d4610ecc6d
Author: Yasin Lee <yasin.lee.x@gmail.com>
Date:   Sun Jun 16 10:35:32 2024 +0800

     iio: proximity: Add driver support for TYHX's HX9023S capacitive 
proximity sensor

     A SAR sensor from NanjingTianyihexin Electronics Ltd.

     The device has the following entry points:

     Usual frequency:
     - sampling_frequency

     Instant reading of current values for different sensors:
     - in_proximity0_raw
     - in_proximity1_raw
     - in_proximity2_raw
     - in_proximity3_raw
     - in_proximity4_raw
     and associated events in events/

     Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

commit 4aeda539237a0eeb02458aff617e6ac2db539e3f
Author: Yasin Lee <yasin.lee.x@gmail.com>
Date:   Sun Jun 16 10:34:43 2024 +0800

     dt-bindings: iio: proximity: Add TYHX HX9023S

     A capacitive proximity sensor

     Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

commit 98da4516aa8169465ddcda67ed9d7c526fdebeb7
Author: Yasin Lee <yasin.lee.x@gmail.com>
Date:   Sun Jun 16 10:31:06 2024 +0800

     dt-bindings: vendor-prefixes: add tyhx

     Add vendor prefix for NanjingTianyihexin Electronics Ltd. 
(http://www.tianyihexin.com)

     Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>


Best regards,

Yasin Lee



