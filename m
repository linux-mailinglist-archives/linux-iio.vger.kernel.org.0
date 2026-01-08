Return-Path: <linux-iio+bounces-27567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA436D068D4
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 00:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5966A300EB93
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBBC2F360A;
	Thu,  8 Jan 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a9zhTI+E"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB92221FB6;
	Thu,  8 Jan 2026 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767915415; cv=fail; b=G2XzWa1LTu3xHKsecBYeXxIJzj6MoqkIbcDJ9FUtuWb3WBMh8ArJwmLkHey0qfftv3nSsIir9jpwN+Xe6wIQANL6dGSo4gfqj0hio5emRguVuE/887buVmBmn20q54LdrGzJBwjcxq65gzUGmLXWVWNHPaJEyQAx6TFw3XZdmOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767915415; c=relaxed/simple;
	bh=IEKoFmePMlT/Qejg2oAZwRzYsmc02xz6PiW2HgLN2Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQsrFBI/EcVRmMsivvMZdsmmXMz+c0O0YLpDdNcrm3XfiuPnIBAhkrr3e6zs94HAF4RLyrs9lOVFmPr3vomCnKQEQ9bDiDUEqVcZNAWhztQia+QF4lZrAWUI0u9NDeWKqYo4yUKNg+eq8MF7wPKR9M3Wgv0cZa+jlwbC/nfy66M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a9zhTI+E; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBv7fcTooZ/bF3nYHY8J+w0Xt9mq4NSJxYxFpkzRt6p179zprMbJ6kawrUxriJEswCC0ObDH6OInuVpC7XXPynzodaXWz4dv8fXwkazS/pjs1DZ7Fgilny8ulZDXa4YSswrad23Bvb7fiMNa+t6YDpx81+jFoigA9fpTXa430Zoq02AxtbSnNOtDB8cFrqK0kjdxmV9qUW1S3NdryTd9SUPgLA4pN/jwYJu7Aoeb6ya/szPJJA/gcOwiX+HZ1ZxiVUMk74GU2OGa8IK/pjo47ixtXop9vK/vPhq7R42jTR2taqVVoKeuNkrL4he2r9KHcBc4bNIpJa+W8AbZOascBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsVxtSMyqtgMd54Dbyy1QRUR4H9wOKGD1kB/OQolbMM=;
 b=QYJ6PU0qj9BOlcQg2bvR5SLT9PCVRqETRBMUaMvnXusEUzcpYh4IcIwscVkzz9xQ1qpKMeOYdSaovEI1hV82RIo0ikzKgCrvDA2izU/eow+rbqKif0C1SHYYCjlR932Et+AHex4vXFjiMBA6EJz5rzncZO5/wfYKIq0dbftKqraHRaTXGbPz+6efaa0Dcv2YqLCqa7UqNTgyGOdCtz4FdvIkwwNpmgSy8qzgX7xLCkaSDQfi6f62MOThZn06G/oU4x/5CajxItdq0EDsMt4IRyZ8jQAS6hoyy0tR/bzocQ/y2Tr6epoP2ZFvmw9am5gqzS0FVHOPiotFv5KyGowyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsVxtSMyqtgMd54Dbyy1QRUR4H9wOKGD1kB/OQolbMM=;
 b=a9zhTI+E4tKWv43KBeiRPqiF7rvgBGaU4LjZ7re0dpmrlkfJacOt94QFnmc8SkrW7Vhav5ZIs2H+8yGqqRsz0o8Vy5qvqNhKLPjy7u29SwhI3XJqyIAnLgSnHbIKrmHiF0ktc4ey5jdW5dX0IqPSEI5WjJ3i3qpHNWdjzpVjdP2r5mHKloglScn/dVyw7dVhq0z1XOU5UKoeQSYEJYu+pPI30J3mIjJpjuZhd4SnH/+1klgG8AFwijF5Gqgybvlev7HkTo8PF4dymSzJi2ybeicDallYtLfoTMyauahgxKFY+WRsvJW04wFofEku4RPcRW7JJiC41ANdjb1C/avVBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DUZPR04MB9965.eurprd04.prod.outlook.com (2603:10a6:10:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 23:36:49 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 23:36:49 +0000
Date: Thu, 8 Jan 2026 18:36:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: wbg@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, s32@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/3] counter: Add STM based counter
Message-ID: <aWA/ibb7AyA+BBrV@lizhi-Precision-Tower-5810>
References: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
 <20260107133953.2094015-4-daniel.lezcano@linaro.org>
 <aV/eLFO57v567Fwa@lizhi-Precision-Tower-5810>
 <f5a96574-4d81-480f-b5fe-45c437a49288@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5a96574-4d81-480f-b5fe-45c437a49288@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DUZPR04MB9965:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c50c91-a70a-4467-f3db-08de4f0ecb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGM4bXpCbzlJTXN4QXcwdE9WVk1rNWh4RlRVYXlib1RrMUxzVVVIdlBSUDJs?=
 =?utf-8?B?ck5VUDd6Vjk1dmZTNXN4R2phQjFhbVNSbVkvVDk0QjBEWUxtU2Q2R2tyQ3Rl?=
 =?utf-8?B?Q0ZRRG5UaHF4L3I1MmtxVi9aaEROcjYxZ3F1L2taZndYdXZadmhQbkFGUDA2?=
 =?utf-8?B?Zlh4VjI1Z2pwVStOUmhoeGN0WTlEQW9aNS9RcEhaMkhXajVmeWxFVExwSkV3?=
 =?utf-8?B?RnRGUGh5d09ITnlGZ0ZwbUZScG1Cell3cDRoM2FNbVFJS1FXdmYxcEpvOXl6?=
 =?utf-8?B?cVpRTjcrSWQyT0FBQlVaWHhsZnBpYnZFRUV2OXlmVHczQ0JybElzelBZMFdj?=
 =?utf-8?B?VlVuUzhIdzJiOVZZWjBpczlkRnYzYUhuL1VzeE93M08zVGtiWUprYWp2SlM4?=
 =?utf-8?B?Snp0SUxFcDczalUxQW1tbWo4eTBuRk5mbHNyT2ZJdGhlQXVRdTFFL3kxWVJ2?=
 =?utf-8?B?UFBsdHVTWTJBKzFXdW5BRFlMakVWK0JSUDZLSmt0YWRtSUxad2lLdk01YWY3?=
 =?utf-8?B?S3ZKYzQ0dXNiS2FRRDcweVNuc0lXQXpkOWZUWVNMSWtrWWtPckZHdnFabzZo?=
 =?utf-8?B?ZXp0cFJKb0xDVWdHNnBGNXhMSWhud05sU3hlZEx3YlliblJPMDRrSUpWOS93?=
 =?utf-8?B?aTl2Vy8rOFF1MXF3NGd3ZERyYVZvZU0vREo1VGJabXdUcFhIMjJsVXNTTkQv?=
 =?utf-8?B?U3J4TUZEbHFGRVBBNDg3Z3ZsZW1BYjZZVkJZazZJMGRqNXloWG9MN0lLbDZK?=
 =?utf-8?B?dmNPakw2ZTFFMnE5azB3LzNRcW1lTFA2ZkpXVDBkOGlkQTMxM3FZbnNEWEoz?=
 =?utf-8?B?SHNkR2V1Ri9aNFVvWDVXRWhpMmY2ei9JU1lSWjhQWjJEeGdSb2d5T3NFU3NS?=
 =?utf-8?B?eFZxWHk4MGc4YmYvK2cydkt4VXdwZklsaEFMVUEvbGc3RHhOMU9KOWhWL0Zz?=
 =?utf-8?B?VzIzUDExZDhvMGVWUStzcDN0c1FSMVFQUDJRbEtsQzNOMVd4TktNUHhvS3c1?=
 =?utf-8?B?VkdNSjVCNHRkeTFiYVhOaUVaYUVFdEVOb2RjTE9LL2JUTDhGNHBaOWJUZkNB?=
 =?utf-8?B?d1BSSlBqaEhVcTh3b1VlVFBMdi9oYnJPUFZucUJOWThQNjdGcUZPMUxiYWZh?=
 =?utf-8?B?U0xGdmNTRU1LdDA5Z0pMQmhMZjVNSUtoL2dyUTJJZk1RQlNILzB1dHJ2dGxx?=
 =?utf-8?B?T0NtZU0zSFBueTY2R1FBMGhOeFNmQVIrOTU2cnpzMjJSOTBmRTRwR2E0UEJw?=
 =?utf-8?B?U3NxQnFiQWVHK0hXd2RIcjBZWlgyNWFoQzVLdkd5YTZFT2xTZ29FcmtuR1pa?=
 =?utf-8?B?N0JaUlhUczNCK0FsVkRFWGxIVWQ5UGhHSXRPTUhGc1VqNzgzNEx1aCtWSVpM?=
 =?utf-8?B?by9TMVdmVjEzQVl5UUVxUVpUOHdQWEdiR1IzekVWUFhXeDRVZlB3OFBpdzRL?=
 =?utf-8?B?REg5SkFSK1pVcWNiZFFIenpVV3VxVENRYkFOWDU1ODFQNTZrUlZRckMrQW5T?=
 =?utf-8?B?QzJNRkZUaDErWU9WbjZwRml6VUZ2VVdMNmIrdisyeVYvSVJPak5VcHZLRmtm?=
 =?utf-8?B?eHZDWSt6aTVIRWpMaXBqS0JSc2RSUjNEOE9nTFZMK3Njeno0czNUeDNHYXN0?=
 =?utf-8?B?M1ZFZGwzcVk1cHJIL3FSVk4xUG1vcWhYZzFGVkFLUEEvN0w1bFIySE96bllr?=
 =?utf-8?B?YmdtMkhKaHJFTnhYVzg4STZ0NUMvZXcxMnY4WHhmL3VlbVVsYnBjZHFMUHBk?=
 =?utf-8?B?S2U5VzVIbXpsNUE3SVBsZVRwMFVESzl0Sm1iUi9RWVp0bEg3RkNYcEllaEoz?=
 =?utf-8?B?TG1CM2dnYVJMM1pGNkdWMk1hOVR4UWRvR0UvSDV1Z2R6Vy96Y0JWU0krcmZK?=
 =?utf-8?B?YTRYWXgyWVJHUmZzVHZSSFlxdVVZYnAwMjBsL0VZaHdqZkxwb2hSSitzT2lI?=
 =?utf-8?B?K0F2RG9abVg1emxySitxM1c0Qm5TU1lsdUNFV1pGdUFMMEZRYVlPWFl3b2Ey?=
 =?utf-8?B?VDJ5VlZjVURnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uit3M2NlUm5teUFvaG01d2xEOFEvOTJvVldUbHpOR0dFamdydUtUcWI3c1dN?=
 =?utf-8?B?dkFTbXhPKzN6WEhsSGp5OVdxV1ZvcS9VeDJ2MHJRbW9CWkdVWXdQT0JuQmV3?=
 =?utf-8?B?RzdYc05BU3k3U3JOME9IcE5nU1BWMFVpOHJnMEJhSldGc0VQS05aTENUY1Fz?=
 =?utf-8?B?ODZ4TVBLcFd2M2xXZ05aMGwrUjBlYVY4Z2xMbGQvQ1dMU3BybHl5a0lKMGZU?=
 =?utf-8?B?aTJoODFGS01RNTFTT2tDcEpCQVNNR1BscmszamltSlU0MDVpU25CQk5IMys2?=
 =?utf-8?B?azdHdEdGOU1LKzZ1S1BMZ2tMS0l6d1FYbTIrZm5FUXZJd0w1WEZkUVc3bVZM?=
 =?utf-8?B?UEZyZ1VnWnVxVFFxZXYvdU5kem15SXJLanlRTHR6ZjMyV3NqdXpjQVlldWtP?=
 =?utf-8?B?OHY2dFpQSkgyTzRYZFVWV2pRbG8yMVF4TTNZNnpVaFQrZ3RwaHhtMStsVmlO?=
 =?utf-8?B?T1dkNDYxNlZWK3VXamhNZmtjek5vR25RMFo0RklZV0Yrd0dxWlRwaXloWnJ2?=
 =?utf-8?B?R3lObHJIWmtLaG0zcUhBYnVNTlNBVThPOVZEM1JUWTBnS0Y4NTNzdUlONW81?=
 =?utf-8?B?VllLUkhxREd3cmpRTWJrTndmTzdoUFAwNVhhZTJJVFZGT1hGblRJZFMvM05q?=
 =?utf-8?B?YlQyeUlONE9jZ1dYRi9LTFF5bHRNWVE3bmlVUmdDRnJIQXJIN2MxcGFoNDJC?=
 =?utf-8?B?YmFSVCtsMWlnY1BsNVM4UDh5UktZbzhwUU5QQWRVNkREM0UrdFZDaEhQaFRF?=
 =?utf-8?B?Umc1bXJFenlnTHNnQVc0aWVKeXdXTjN3ZjFUMW9aSWNWdHFRZ1FkU2ZxclBW?=
 =?utf-8?B?VUUxTmZNa2JkU05yWTNkN1JjdUs3eHVTMHMyekJNL2N1NllZa3RiZEpac0pp?=
 =?utf-8?B?M3FrcFdqM2tZZThhQW8rUjBuSkZuQ0ZYQmNZRVFWeXlpRjU1aWFkR2VjVUo1?=
 =?utf-8?B?Z1NiUm5WY05OSFVGblJ3TFdjRUhDaG9UU0kyMWtzL2VqTjF2L0VoZVpkbExG?=
 =?utf-8?B?QlNUYXZMbXlLc2pGamhCZklyUER3NEhPSWgrVzVSSWZ5c3F6dVZYbmpGSnBi?=
 =?utf-8?B?YmZLMGF6bzduRlhvYVZVRDd2aG5Lc0NaVms0ODJhOHQxTGFSTSsxUkRVM05C?=
 =?utf-8?B?c3JMYm50Ulk2QjRCM1p2azV2Q3NJRzBXcEhkV1QrUXBtREY0TnVPK3NmL3Qx?=
 =?utf-8?B?MnpOaDgrbTE4VkIwTndwMGRJTlFUQUFWR2ovbjJUV3d4a3BxVWpRWjdRWTdN?=
 =?utf-8?B?VDFFNDBwS1RaOTlWWTdkcjVjdU56N1NkakkxQkZtN2F3MjZUSXRhUTZld0Vn?=
 =?utf-8?B?OWtCVkZ4anBncjdmbnhUOHZpVUhuNXRvTWxkWk5XaTZoMHdLRHFvbithWHJr?=
 =?utf-8?B?VE1XQ0pIdE9QSEpndE9jVWdEYmYyZ1FpSmtJZjNjbUZPSXlnTXQ4ZmRBQ3Rs?=
 =?utf-8?B?SEZSSzQvVk52K0dtTzQ5UzFCWjY3MTg4dlVNd1htcHBpWDQ4OHFpeHhwV2ZW?=
 =?utf-8?B?WWgwSjdrQmVGMDFZY1VSNUZWSUpTQVpiT1RUbWJQYTRmQ2F4b0t4K2ltcG5D?=
 =?utf-8?B?OXhDMkFKeW1paUt1cWRYMHNyQlZ3STZ2amdwOWxQUk5NRXc3YU5RaFJCOFlt?=
 =?utf-8?B?UDBRMDJiamgwbWdQR1JhSkdyRUlZdDdiazFvckh1TjN5Z1F5VnFCNnVDMTYx?=
 =?utf-8?B?MjV5QXVKR3N0ODVkU1ZBU0l0OEwya0NXaENQaTFETVVmNWR4cDAweVU3dHVk?=
 =?utf-8?B?L01oWGdnRWhJZUxmZGtmWCtkdENaQ0NKSUhYL3YxeFk2L2V2blh0OXFFT2ZV?=
 =?utf-8?B?TzJ0NDltNUhTMHNnVzZYRk83VHdmWWdpcWs0VXBPd3ZaeHdDWS8rOWFMZzlG?=
 =?utf-8?B?Y3BIVmN0WFdTckFHaWVJUzk4RFdMN2lxT2crSU1nU1BBY1d6b2d2SURSVEow?=
 =?utf-8?B?MUFsV0l3MGFFN0gwbzlPVEdRbUVTai85UUkyZSt0VFVnM2lCTzdPTTNCS3di?=
 =?utf-8?B?MlovNDhrTEdsS0ZNWjRENzhuMDZrc2pwaFdYc0k3dGlaV0NVV01qMVBLS3Nv?=
 =?utf-8?B?YXk3WXQzVkNjMzNNNTRRcmo5TVdML091dWhKcE42WEZkUjRYLy9SVXZ3ZEZt?=
 =?utf-8?B?OGIxcmFDSElBQjRxTTdYZ2JjR3RKWDJ6UlMzczd5K3d2Q0x4d0VmazF3bkNC?=
 =?utf-8?B?UVVrZ2tqZDE3T1JZVWNLaGM4Rlh3MGVORWhWMlJIYXpHeWZKb2dVcmVuTDdC?=
 =?utf-8?B?N1Q1YnJjdkxYeG1TdWU4NVVLZDE3U2pJYjJRSVNpSWNleTRWbzVrcGNhaENj?=
 =?utf-8?Q?ERxWXaRFv8iHxrkb1U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c50c91-a70a-4467-f3db-08de4f0ecb41
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 23:36:49.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x140v6tK3K5JE2nf8ct9VUJjgaNd95Q7KdsEl8hZpQP5vP/aJg9dzyV9mvi2lF6d04QawlAn9fcZlS0ImRM/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9965

On Thu, Jan 08, 2026 at 06:11:28PM +0100, Daniel Lezcano wrote:
> On 1/8/26 17:41, Frank Li wrote:
> > On Wed, Jan 07, 2026 at 02:39:52PM +0100, Daniel Lezcano wrote:
> > > The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
> > > three Cortex-M7 cores, along with a large number of timers and
> > > counters. These hardware blocks can be used as clocksources or
> > > clockevents, or as timestamp counters shared across the various
> > > subsystems running alongside the Linux kernel, such as firmware
> > > components. Their actual usage depends on the overall platform
> > > software design.
> > >
> > > In a Linux-based system, the kernel controls the counter, which is a
> > > read-only shared resource for the other subsystems. One of its primary
> > > purposes is to act as a common timestamp source for messages or
> > > traces, allowing correlation of events occurring in different
> > > operating system contexts.
> > >
> > > These changes introduce a basic counter driver that can start, stop,
> > > and reset the counter. It also handles overflow accounting and
> > > configures the prescaler value.
> > >
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
>
> [ ... ]
>
> > > +
> > > +static struct counter_comp stm_cnt_count_ext[] = {
> > > +	COUNTER_COMP_COUNT_U8("prescaler", nxp_stm_cnt_prescaler_read, nxp_stm_cnt_prescaler_write),
> > > +	COUNTER_COMP_ENABLE(nxp_stm_cnt_count_enable_read, nxp_stm_cnt_count_enable_write),
> > > +};
> > > +
> > > +static int nxp_stm_cnt_action_read(struct counter_device *counter,
> > > +				   struct counter_count *count,
> > > +				   struct counter_synapse *synapse,
> > > +				   enum counter_synapse_action *action)
> > > +{
> > > +	*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int nxp_stm_cnt_count_read(struct counter_device *dev,
> > > +				  struct counter_count *count, u64 *val)
> > > +{
> > > +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
> > > +	unsigned long irqflags;
> > > +
> > > +	spin_lock_irqsave(&stm_cnt->lock, irqflags);
> > > +	*val = stm_cnt->counter + nxp_stm_cnt_get_counter(stm_cnt);
> > > +	spin_unlock_irqrestore(&stm_cnt->lock, irqflags);
> >
> > It think there are still rise condition here.
> >
> > cpu 0                                            cpu 1
> > 1:  nxp_stm_cnt_get_counter(stm_cnt); (0)
> > 2: 						 irq_handle()
> > 					         counter += INT_MAX;
> > 3:
> >
> > when wrap happen, nxp_stm_cnt_get_counter() return 0, but, irq still not
> > handle yet.
> >
> > so nxp_stm_cnt_count_read() return 0 at 1.
> >
> > it return INT_MAX at 3 suddently.
>
> Thanks for the review. Yes, it seems like there is a race for the reader
> result.
>
> Except disabling / enabling the counter when reading the value, I don't see
> how to handle that case.
>

I think needn't handler overflow at all.
See stm32_count_function_read()

comparor always is u32 val + delta.  it can work if delta less U32_MAX/2.

If you real want to up to 64bit counter, perf counter have common solution
for that

x_counter()
{
	u32 v = readl():
	stm->count += v - stm->last;
	stm->last = v;
}

you need enable irq, make sure at call x_counter() twice during counter
wrap period.

No lock, no stop needed.

Frank

>
>
> bool is_started = nxp_stm_cnt_is_started(stm_cnt);
>
> if (is_started)
> 	nxp_stm_cnt_disable(stm_cnt);
>
> /* If the counter wrapped, the interrupt fired already */
>
> spin_lock_irqsave(&stm_cnt->lock, irqflags);
>
> /* Counter can be zero (or more), we don't care, UINT_MAX was added */
> *val = stm_cnt->counter + nxp_stm_cnt_get_counter(stm_cnt);
>
> spin_unlock_irqrestore(&stm_cnt->lock, irqflags);
>
> if (is_started)
> 	nxp_stm_cnt_enable(stm_cnt);
>
>
>
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

