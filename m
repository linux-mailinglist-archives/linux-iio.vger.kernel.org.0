Return-Path: <linux-iio+bounces-5021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734BC8C4825
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 22:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A166285DFD
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8C7E58E;
	Mon, 13 May 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KU5LisNH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vhd7laKz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141B7E0F3;
	Mon, 13 May 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631880; cv=fail; b=stNx/pf8ykyFikPAU6OYwd3VZ/68S+TIAaAN4wCm3tAxPycN3Ff5gYJ2UlqUuGz4KfuZomkzTL9pPULfWrVXEMJG3xwtiy6Oh+rquM23aQtbjk3tlE1KN5zciw2aEEjKM7JFNjNdFdIcfULjuIm3Slkm8nXdcRht2pmP3ollydY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631880; c=relaxed/simple;
	bh=cpm0meKxuZy9DRMDjyeWoWeYjBr+vlmZy5hIAkFsSOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrWgO6IrriqN4N97T26nbTp+1byFkW7qkYibqvhAtp1Dc1sddPmkcKZ8BYKgflfUkPLD81keNaVt11daHoNnLKW3zIsrmcUrNsTnR+JQ4DpyD5gmfZLJO2tVgtdQZMj9GzYdqxf3lJK3UcxAQGGfcQVjpyoFvQxQEZcm8MhkbkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KU5LisNH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vhd7laKz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DKIAKa024249;
	Mon, 13 May 2024 20:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=l9ko4qscNrJ0ZNwFh+av7pp/23vBkqiDb+9ARFOE870=;
 b=KU5LisNHVP/83cArd7BZVKTPm5Vpra0DgAGBelMrB4ojzg0UVt5kZRIEnP3G0CD2R6pS
 d3IiHssg/fj3yMzJJf1dr5kDuZYMd3hVel2Rd/bIXVv2YLSKshlRy4FIYTjxwthhvxIL
 IAGc9I6Rlq+QMvsZ4aHfOz4Y/9sJQxWWefyuRb3FPCNNnoQhbhF1rDxTv25IQ/gynn/9
 lqQDF3tXeN0QLQd4dI2r+9+p2L5hPcegATnhi5/Sr7eZXnCznrGE9JKZi52AC1A99+Cw
 GqcR9AJyNm+iukXEEOzTpl61aFKktrLjBWWzmnSzgNPQrxIJIR0DBlkliGEoNrFJtI6f TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3ss9g0df-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 20:24:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DIWwYR019302;
	Mon, 13 May 2024 20:12:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r83umun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 20:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIVxCXo4irMu3zmMws38kv8duQBW43bcqH8hapJjqlKP+YXv1FK6MznqLfQYjbqCK7IMLWnJD1CeU2GF3TrJG4w/JrEpWzCcYyQqRfmu+5C/Jd5bN0AZ4cNVH+qDsI0jvAIYcnlFp47gSbIY1DLk3c3Y85oYNAH6HPeutxlK5fBA2b4t3q90/cjLSFvX6rlnFXtDhjZTQZChbqPKCaAhGMeSexwFhte0HDX0y29kYjqP3tEa/1gZMw117l3QzgdiUnjFkZZ55nFHEossU5zbzEj+zGPOs6pCVf1Mr853FzIIBEY02ugPL+d14fuee0FvRINLyWfNIuiZdC11tLBh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9ko4qscNrJ0ZNwFh+av7pp/23vBkqiDb+9ARFOE870=;
 b=lh54AmfV3c77betb7Z19CUfDjA+g9fTo1rQ71Y9hCXJe33J+0Wsy5hhwawJ+GVDvriQC1eb4HwfEhI1UvrqB/JGTaEmtQ3xKBGK5pTucdyjb4ZgeH9q6xuoVJ+Y6b0CdrjQLtYSmIUoFkjbEosuV6qM4c+tturZtMkHNDpg91eZtjMr1bUhf63l2IR2B9hCuXiFXkYaQ/CHfjNrkwJtwALM8shsdjBivhW8lLO2brFS0AddWsmFoqOYL7L18IiM8Do1OS0e36UOl4gjXFRv8QROSfE6Oyy27IOb8LLNpDgYX9ZrmDUX45mU/zGrCf+/KxpqwrtMrlliqSzsWSBzh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9ko4qscNrJ0ZNwFh+av7pp/23vBkqiDb+9ARFOE870=;
 b=Vhd7laKzO2R1PM++ffJRULQlEz491SRSEN/s9UM21F5NG9EGHKtEVy6xMGWJO3LV+YxzsFWgNnTfmBX7oQFY8csCXzVgxQ8a4IZEMZqq7Ha1ph3BO3MNh2AJ9aArXoy9/o4TcT+I0N9A86+wYkY3s6xtDtzwjZjKa4TgGRJcfZI=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:12:34 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 20:12:34 +0000
Message-ID: <b83a3b5a-884e-4b9b-b962-3a625b3072b5@oracle.com>
Date: Tue, 14 May 2024 01:42:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: mlx90635: Fix ERR_PTR dereference in
 mlx90635_probe()
To: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
 <CAKv63uvAe=RkZ6ytWfNkM5exy5ys5n2NwcJER=VMVAP+61-+rw@mail.gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAKv63uvAe=RkZ6ytWfNkM5exy5ys5n2NwcJER=VMVAP+61-+rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc54f2c-c663-4c45-c705-08dc738906e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QmF0WHpOa3VDbFpKSmNhN3RLSElhdFQ5bXpPdkhqaWFWL2xmSFVyam9OZmxZ?=
 =?utf-8?B?YzBYQmVISEV5eXlOVkZqVlI2ajJPam9vb3QrYVpydDJQVmFUMW5yQ05BRjE3?=
 =?utf-8?B?anBYaVBNd1c4U3Ura0NGSVNYcjRTbkNQTjM0T1NLVk9iRWVlNzBNMkNZMHJ5?=
 =?utf-8?B?Rllsay9ZcGppYXU2YkxSdVBmQ1V6aHpuOE5pNEhPdFlZdHVOQms3NkNMNTdP?=
 =?utf-8?B?ZVNHWllPd1Fla3hITENqbHd4TUNLNVRqZFBDblZ5VUNZMzhkUDc3eXUrN21i?=
 =?utf-8?B?Tkowb0gzeWtmYVBWeGFicU8vUnhYbVdaL0pOeW5mT0ppdkttcVdhYm5xYjlH?=
 =?utf-8?B?alE2U3hNZWpGdGlqSWZxWm91eVNOZUJHYjFoSDFwbjN5YXBEWUcvOUJOSWp4?=
 =?utf-8?B?NEVzU3VBZHFHZ2FDdFgvdVhleWFPajlYd0hCWHpHQytzR2tHS0RxSzJ5ajEy?=
 =?utf-8?B?UXo3anBZTDA1bnhaWW5FVnZRV2Q4eDRVejNsb2t5TDEvb1pNTzdZVUNOSmVl?=
 =?utf-8?B?eUlyaFBzRmZueEFKRFVGOU8xVHdneWRZem0xWEllOFZReXF1OGQ0QXBVbEwz?=
 =?utf-8?B?aFJ2TFdVdFRWTkprYVhuSkJ3ZlBEdHFXdVpTNnpCTnZIUVZyMy9hNDZ5M3pm?=
 =?utf-8?B?b2JwR09rcmxoUTRVZUJDeXRVVFdna2QzZ0ZEQXFJMGRINlVEUVIxQzY2Nng1?=
 =?utf-8?B?eENYVnE4a1ZkTmNUWnlIcVJQWmllaCthSDV5V09BOGE2eXM5QUZSWXRIN0Fr?=
 =?utf-8?B?bFN3aXFOSVdrcERaQUVvdGgxT3greXpJVXl0YlhseVZVM2tidlVjMXpYWmRT?=
 =?utf-8?B?amp5dUtldENZcmgrelZ6ek5pT0xleXF2U0hIdmFNNFpRUERtNkFWVFNDY0tB?=
 =?utf-8?B?MzVzOGlHdHB3MElFUnBqTnBTSlJLb2VNeXFTNnJjMXRvM2JFRTAxODlNdWJs?=
 =?utf-8?B?RFhNeXF6MFdsclFxZUpPc3BRVHlweFRZZFppR1NCaDJYZWQ5TkYrK1BTam9B?=
 =?utf-8?B?ZndOK3ZFclpVczZEbzExam9Mb3o5SWlzRmdybS9YY3Z4OWE3RDNWYjJNQnRH?=
 =?utf-8?B?Vkoxa29XUkQyWm1WSUpsTUVMZnFqa3FoYXpsWHBPNmFMZ3lUbHF2V2xPdmY1?=
 =?utf-8?B?cHgzR1hDQi93UFZwazZIbjRMZHhpYWpEN1F1Vlorek0vb1k2QUYwbURnRW9h?=
 =?utf-8?B?R2JrVWFtRnNLc3ZUdnlqMGd5OXJsckMxV1A1ZDFGTVdWbkNRTHpFRGdEVU5W?=
 =?utf-8?B?UndqRldsdUJtajRMai9qUVZmNGRQMVA5cVBDSkVteUhxWUF3d0xNZmdGT25P?=
 =?utf-8?B?NjFvN3FoYVQ2RW1GYmVRbktuaTRXM2l3QlQxaURYK0VYNzJDQldMMTJlYVIx?=
 =?utf-8?B?YkdPWjRmenJhY2JNU01CZm1lNkV4WDFNRi81SnorSXdZT2NScnZTUEp2OHVv?=
 =?utf-8?B?ak9BUmtybmo2bUVBbENWcmdPNXlJdnhSS2lmM05ZMFV2R25QL0tid3pMLzNU?=
 =?utf-8?B?cEJ4SjlIdEcraXZXRWZqZUdNRjJVM0RXS3kzTEthNDlIZENuRFdxMS9nZm1G?=
 =?utf-8?B?OGN0MCtrQkowVW15czZ4SWpudWtORGpZc3JZdTBOU1lMU1A0RVVadkJubkdM?=
 =?utf-8?B?UXp6WnVaMk1YNnNoRkY5ZGtzTjV4eDBrdGhDNnVjV3Y0cDA0RW1EbXpEWWRC?=
 =?utf-8?B?NWU3N0xCZ2t2VFJYcG1tb3diZWZpeHlBYzFUR0RzU3p2R1pXd0NNMkZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjE4N1BNR0VIODJQM09HYy9rbkIyek00V1JzVEgzbVEzRE9vVGxmSC9naHhP?=
 =?utf-8?B?L2Eza2s1L1NSaXl1a2c3M2V4Q2VGUE5kVWM2WndxVjV2SlZaNXZyYUMreHdS?=
 =?utf-8?B?NU5VS3g5MTd6aC9tTkVRdTllQXNMSjVHbnVIVkh6bVlTUEhrNmpSTzlIVWgx?=
 =?utf-8?B?d3NUeEZiUlFQNVZPdXNFV3BHQnFudm5WZDYxUWoxRXlCU0FhVzZzU1p3bTlz?=
 =?utf-8?B?b2JSSk93SzE1bEVkREMxNHQyakxBUTdBbjJSUzNscHJYajlFaEFzcWFKUzNn?=
 =?utf-8?B?eS9MM1d5cE5GM2xXdnk2MjFkejJkdTB0M1BVM0tGUExHRnJUZndaTGQ5Lzd2?=
 =?utf-8?B?YzhMVHc2UmxXUURNM0Z0MlgzbElTajBwT0VGeVFwM2w4UFBMSW1TeTBXb1dB?=
 =?utf-8?B?OVdmYTM1RHBKaTQyLzExQXlkRk4rZGM4a3JBbS9MeUxtNkZSdjRBNDdqS2lz?=
 =?utf-8?B?SEJTN0ZyYVlGWnpDMzArSEpJWnA5UFlQN21URlZxemUzeFpweHlVZHNOS2Na?=
 =?utf-8?B?b2VHUHg0aXE4MlpkcGFTV0JKTW5NalJPQURodm5mVThUU3hUdXlacytjVU1k?=
 =?utf-8?B?S01rdk5vV1VhWUNSUTZKN2MrM1BWS3I3YlJQaDdNM3A0Qk9FYzhMZkVsUUlu?=
 =?utf-8?B?dHdxSlVhOGxIcU03dk41bUVrL0hOYUJVcmdIUG5lZmdDeHhZMXpqZURPZ0xP?=
 =?utf-8?B?U2Z2QU92TlhscU44SWpDdDBoalk3Z2taT3JYOVpvMURIQXNROFdJOHd3ZHAr?=
 =?utf-8?B?blRFQ0pjQmltQUJycllOd2dGRkQ1YXFQd3A3Q2hrbDZrQjhSSFBTWVN3NnAy?=
 =?utf-8?B?MHRYaGF2dHhqQ0dWZEQraWtDS3g3NjY0b0djSVpueGJ0cTFzRmRQUkYxbnV6?=
 =?utf-8?B?Mm5EZzRQNDMrYjExMWFhK0p6UDJ0SUwyZytneGFIQk14VVVIRDRBcnFyak53?=
 =?utf-8?B?cEpnNXJPT2tNYWNjYzJCQ3BlSlBNOUVzeTlpeEE2SDhvUmYvQ01PM1pweVNj?=
 =?utf-8?B?YUsyRjRZYVdGWEhkdmh0bGtiSEJzS3hNVTBHb0NKT0hCb1QzUWtFeUYySURj?=
 =?utf-8?B?TTRNZnFTUG1aL0VNZ3VTV2Q4MnJuMnRySmxwb2NPcHNyVHR5dUFnQTYzWHp3?=
 =?utf-8?B?SEFXeStwbzNsZjYrTkNZd2RBdDREWnZOa0U4MEVzUTljZHZUbUd3b2hOcHNj?=
 =?utf-8?B?VG8rK1NmWDQrd3JsNkhmRXZmNDZiZ2lnT0J1SXpuMlRFYjAxbzd1UEo4Y0hT?=
 =?utf-8?B?aThIZWh2ZHZDdmM4LzcydUQrRU1PQkUzSkZJL2dLYmhGbks5OVNEVEl3SlBw?=
 =?utf-8?B?R2lVQkxkQ1FCYVgvNlBZbFc1cnFPWTliVko5MmJyN1gzOW5rQWhBRDFraGpP?=
 =?utf-8?B?Sm1FRlVtelBLMkpoaHF4RTFNc1AxL0dnOUZ0MnAzODF3NVNRdHhzcDB1WTMz?=
 =?utf-8?B?U29lSEpTc2dRanhFWWxpU2dNQ3VFZW1JMVlmeFNtUXhMYWx5N0tlZ2k1aGRz?=
 =?utf-8?B?S0tVVDJEa2NhaCs4a2pmaXpDaUxveXE4aHFBcmtUTXAzVTZSUms5ZzBVbnhO?=
 =?utf-8?B?MnlkTGlQQ1ZkWGRjRXhKWVdVY3dzNzllNFlpVmJvWG91Y3dLVW95cWRKZkpa?=
 =?utf-8?B?UWo3U1FZejllSHFMb2dqQW9vK25XUGFPd3JHSWhuLzJTb1VwN29qV3NuZXFG?=
 =?utf-8?B?OTl5SUV5QUxVVHc3Z1MvUlJvMjVPeG5jUHR6VEZzMTZXQTR6S1U5VVI3SG5N?=
 =?utf-8?B?OTJXSGJ4WTR3TVJvMTdGZnRRN0g4SVBLSWtRMWhwUVc0V0cxN21iTFlyZXp1?=
 =?utf-8?B?d3VlVTVQbTJKZWZHOEVkK21NdDF2SnkxV1RTUFZxUVRKZyt4WVRrTGZ5cEdS?=
 =?utf-8?B?NHRtenZadXBwL2VuVlA5ZWRqUnpVU1Y1T2lSNW4wdzZGVjdSODVyQ1ZVMWtO?=
 =?utf-8?B?YkxheXpZQnlXaDJrVkcrM2kxVWx2T3V2alNQZTd5S3R6RlR0UHJ6ZGVnbTR6?=
 =?utf-8?B?aTM5M2dhSEJwdGwrV29DZG9KcTBtNER5WTc1V0NtNERvckVqWE0zMk9JdnhO?=
 =?utf-8?B?WGdOZWxjS2Y3TVRBNDdQaEdLQ2ZRQ3ByMFFva0h6VW1UTlJPQ2VkSXNpeXVv?=
 =?utf-8?B?T0hXdkpLMkZaamw3RWJ5Sm12cWtBajlBYzVzNXdZa3g0UTQ3NlJlQVJxRzAy?=
 =?utf-8?Q?FPNJJOvgw7H39oJBbvsOW/c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qh+LQh2Hs8rBicZxGKEd3hZf0aCq3kw5efmEF//w/3bLZ4kWDIVJuexKmmYSMXknRX7tCR5Pd5+VLyprAlwa9FjH4TwTSAXBhlcjX8V1qtEwpHclMEaAyNcW/FwgkgVR8qE8ItBI94yM6v9OdOYaV8iOgsZU4nlj3ukVfwTTd9tWE2LNw/ttSGUQXdwQtOv1ohS8qydh8Xlz6dFPyFpGlNyFDcQDYkN1o1Z+kSloxAow7KWD6MwvuP1T54+YZqOh5zlQLjC3RvbJTtQhuU+p3A1JtlaHiw24BWGTh6uzFqdAHCWtln89yV2Nmf/HFxjcrvaHucri7b9VabLtn4Ut8YkbdLb+1Tff31SzdREl/2MRAZDoywFCkPo6GmzWQhLKa9dcRS5dTt5miQd+G2jcLkgxvizdX1M014gZw/lBy/S45v1nzZBv3SMtyFFM75mgmofKkR8PYij+rvi1JUWgocvO9cLPp5Z82UZjUZ6t8bMEUodo3kgQBYqJT4PmjYJSRMd8AklTNd1PxLyJdO6LjJuy9+dCI9H/mImPFF1FjZTxlgf6S0nB8oe1xpYrQBLI73lgT2NRFeNHAam/XGSmQ/dT5kaqfEoGKvagogF+ujw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc54f2c-c663-4c45-c705-08dc738906e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:12:34.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLyJw5sfqlRDpHk183JhR0vABYYLryrUKeauTeKKlTTrLrvhkHnik7+OeAS9tFJm8ZGVihiFOom8zDB1rjjfH5quLby7t4e8lBpXyeXx5pJcElzhnC5UcGirEu+SNEsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130137
X-Proofpoint-GUID: QnnQWmiVciuwNb7s_z3rvOG1m4MjDsSd
X-Proofpoint-ORIG-GUID: QnnQWmiVciuwNb7s_z3rvOG1m4MjDsSd

Hi Crt,

On 14/05/24 01:32, Crt Mori wrote:
> Hi,
> I agree it is is copy-paste error. Minor remark below and a few typo
> fixes in commit message. Thanks for your contribution.
> 
> Reviewed-by: Crt Mori<cmo@melexis.com>
> 

Thanks for the review.


> On Mon, 13 May 2024 at 20:47, Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>>
>> When devm_regmap_init_i2c() fails, ragmap_ee could be error pointer,
> When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
> 

Oops, sorry for the typo, I will fix it in V2.

>> instead of checking for IS_ERR(ragmap_ee), regmap is checked which looks
> instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
>> like a copy paste error.
>>
>> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is found using smatch, only compile tested.
>> ---
>>   drivers/iio/temperature/mlx90635.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
>> index 1f5c962c1818..2b61489d5ee0 100644
>> --- a/drivers/iio/temperature/mlx90635.c
>> +++ b/drivers/iio/temperature/mlx90635.c
>> @@ -947,8 +947,8 @@ static int mlx90635_probe(struct i2c_client *client)
>>                                       "failed to allocate regmap\n");
>>
>>          regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
>> -       if (IS_ERR(regmap))
>> -               return dev_err_probe(&client->dev, PTR_ERR(regmap),
>> +       if (IS_ERR(regmap_ee))
>> +               return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
>>                                       "failed to allocate regmap\n");
> 
> Maybe fix her would also be to this regmap error message to include
> regmap EEPROM?
> 
Should we make it like:

"failed to allocate EEPROM regmap\n" ?

Thanks,
Harshit


>>
>>          mlx90635 = iio_priv(indio_dev);
>> --
>> 2.39.3
>>


