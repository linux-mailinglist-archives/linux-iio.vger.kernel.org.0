Return-Path: <linux-iio+bounces-5457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56D18D3B56
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5503286792
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6BF181BB8;
	Wed, 29 May 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="onbaliBk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF4374D4;
	Wed, 29 May 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997685; cv=fail; b=qIdTJexXlkraCZ+ITYFdoAZTSAQ01zBA4hKxzqyq2Z65nBOUbtN1c/UH2SIJwWtw/pHrxhniJiNVbRrfgm3RSdWFRXgrmLRgQwfmnjcFhHZjRTQ6uvRDz9sPWKfH+pkD8PtQzTHtlUf/xh5hKFeZ8zKBkwiljT2qPGyLBkHZ4D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997685; c=relaxed/simple;
	bh=+b+hzqM+0yJAxzKkaENCysYRIFFpIeFuJCLh2y4RuMI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rCkwee7av5PrQAjtf55c0HXA14VUXpSnap7rFMo9m+yAXD9waBqh16ZRsyGTJJxsi0K9kVNpvbTSSTXXEz//1d8TsGQmaXwcVAHSyNIMIsxos8/GJDNofbZGUPpVKUqVQrmjmJNOmHShBMXa9rYtDF2TNfg8Ze1qbCqQl64uwAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=onbaliBk; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SLn5eA000678;
	Wed, 29 May 2024 15:47:36 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yba4xb55h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:47:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npTfYmCux7JByd7dYMFyK9/GiaeJiASOd8XjJ5cISzRrf+oCHFtd2NYWeIpTcpKLZXM4xMKFnGYPnS9yvDycqEjiYAPtr5FMs0D5yawC2TPqVwYC8tL/oPfhypkbvqNlELKdx//Vw/cYjXJ6hlhk/ggItOpr0q64Bz9Ud600IBKjQ1VPOf+F2E6ta7bC7jdjl6d/MgvuwREVheg5b9EBoNh+GrrZv9eUwmbggZfUMXnnkewLD3OuxrhhzNDeOtiPE8u3aE5Z6ri78P9sTDPWU+pn4LDngfSPEI9gBCqqZH+hCwLCkx5mmG8PVzVhfG+wflbigNs4I7ARXof+vPufOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zPHyFA7lH6pg4pOkAQ7tfZKK0p0sxbrxNBMVOyq35I=;
 b=jsVHh2CgyfZn7RpKylKJsqJNMFHe4LwNFWHvR/HdkPB+WTF8Y88/QJS3Ny8PPrSHvkfMu7OoGuDYwdnEr48u6EEN/90CJ2hhZeOlCsi3yq9WAs4+l5BVlAkRoEKqNqTtkZO/rM+s60yYcH3jvFaYjO4CDJDN2nrKG3MqxEPQkfcFFG97zrKwqpqThNXKuoCTEOpoyQBI5DIotM8yiYFq7J9wBczG53geaDZdHkZQrZMZywZG3fLadfj5OWx0I/fX1s3E95VXW33VyNBRmKFXXOk1LBZZVupJqf+1is+yF9rLdBEftSSLTEcd/4qjqLxKO+Czy9HmcBqR+7CbHBIs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zPHyFA7lH6pg4pOkAQ7tfZKK0p0sxbrxNBMVOyq35I=;
 b=onbaliBkKVteFH4v9yGCAgWZRh4VeOm4d3xSoHfb5iJ0dp9jZg7cu9RwNy8L/y6d5n/ezzfKDrhFT+MazZlmpzQUhtQnKDvCVoWxTlCDjl/0w6gHgHTAm1x1GwzbHhFYUO0Z/0MlCTyyp4BXST91Sw6tzsowlNnVpekTo/ZZcYYULXxCMjS03sLT4Nx77h/mBpiMIILG7DcvpyIJVDZnZoFf31tNAJpuyP4d09a+EQy8HvbUi5QMSh4yN+/A8x5y2LZiqBAuleFYT/Id8AwYvu8R2ayQydct9hLIiv3OYsedDkChcAH/asYkpZUG3TZNpeUHFFr86rrr9M+xiPXAkQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB2617.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 15:47:30 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 15:47:30 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_icm42600: stabilized timestamp in interrupt
Date: Wed, 29 May 2024 15:47:17 +0000
Message-Id: <20240529154717.651863-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB2617:EE_
X-MS-Office365-Filtering-Correlation-Id: 083d14ea-4060-4d7d-7cfb-08dc7ff6a5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t0Lwh3F2PdxCNmejLcyHo6klRW77WSOauyutf93/V3we4GFSNZ/HyKNpGIeb?=
 =?us-ascii?Q?ObO5riuFk+4IpQEItXXnvcK/kUuhDDbqxin1Tui+zq6Q+57TR4wVzS5R9IVJ?=
 =?us-ascii?Q?s2nYnBrdFOa7TLHLOX4IZ+iZ68VTk81dMRssEpe2gp7WEankdxpJ8xialpVX?=
 =?us-ascii?Q?d0hWSx22SJ82wCaUrjnGyvg44fWebKpnoFOdAGemrT69Zv02L2gDTt0Yasuk?=
 =?us-ascii?Q?AJIbHUpvIyfapNIHZoHG5vC9OC6g0wHXtucYRCx/Z67VIrJ8qn/0q4sBh1x2?=
 =?us-ascii?Q?YIjQrJUFPpJTk0r1SMTr6FZc0Mk7UHmFKZdwf0FpRv/AWLuUPvdhDYUdxp13?=
 =?us-ascii?Q?QLfidYW4t3pfM/NIm/f+9RcxxyqG1RkpRAb76zITDjkacu7B2mUpfnpk0PSt?=
 =?us-ascii?Q?8fQp24YtqMcHmfrO9JEFlnqgPQlIeRtTj7bX6MlKE6/JtCTHDvcJdJ8cg8xI?=
 =?us-ascii?Q?lWKew50C8ak/M6Ln8FxeXCNClRTdw9V2vejJG/IgMWGOiNV7mOjRGRJXLHhY?=
 =?us-ascii?Q?SuM43RjzCpt1EzS6hSXyysHZuXd50FMbQOgyIXoNc5KdWh4kjJC/CTcoXdwm?=
 =?us-ascii?Q?2VN8b/FQQZSK12OWURYs2di5qEPTErjhrO673XbATKhSIJ44FxvoXCYa67eq?=
 =?us-ascii?Q?KQnS79dCeymaVlfAzUZXsGPi46PC+qLqD5mog3a4c1r2fZ6SNZpP9RENvEOK?=
 =?us-ascii?Q?FX+2N+9PdIqwbkEp24rGg76bq6uaMRwooEvzvlbh/j57gd+boVBb7LhySPC0?=
 =?us-ascii?Q?5igzc8T2pAfMhFAxUjItcUrUxYw2WVFtlZ+euvn/BSqTTxyEI3L95S+CIyok?=
 =?us-ascii?Q?TbJUnEyBMOQxIG+0ndQoFfISP6+ZO248mjNKlTLdz3boBMyjFGqaHjTh1sGo?=
 =?us-ascii?Q?MPSijymuenHXA7Xw8Lr8hmFY28pqgSHLVTTy9bq227K2obT0W2xWyrhX+lQb?=
 =?us-ascii?Q?pKDm/L9wobUgGb9keU9iAX3itZy5XVfRmCXQ6z4GHVNvC3xYMr0et5qfaILN?=
 =?us-ascii?Q?5ZUyu55UDPwgil9brghNli2+Gaqis2iedb1aG0ild4DlYm180OywO8/6yj6/?=
 =?us-ascii?Q?NCnMS8d6a7qJz3KVhTBguqvdvKsIG+4XScJcC3FItp9aMlEqAcKg7pSA6ddD?=
 =?us-ascii?Q?3nAuo3nvBRhzmCnlVIvv2yNIm98nX+3XUJOgbcdfHS11QfzBPqDhA/1kmiRs?=
 =?us-ascii?Q?wXIF7sueg5Az43IDeN6W8FUdVWNNh9wR0dkCHPCNExn34CFwqX8kdprF01Es?=
 =?us-ascii?Q?NyJhKBwBiYagmlMkgKn7bdXyevzaAxl4DNh+mqe44xHrEztk1LeczOFCmfHC?=
 =?us-ascii?Q?f/LDeByxbxMSik09wJduChd7igO0MHSc2449b62Wp1154O+zMq5wETuRTtbE?=
 =?us-ascii?Q?Zknn2S4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qvojH9VHX69nwbq2ZaQIlRqkbhw2BI2AQeeJNw7Z24atS4x9T0zOzQei9DJL?=
 =?us-ascii?Q?W9b9shUMtkMamUKPBuTQ3H0TEr9jtZLXqKQe3Mb857m0G+oxjrjzq7EA6A3C?=
 =?us-ascii?Q?DTsIOndPzGRYOsy/lkeb5WzWWYeJV17QvT1V1VyO8q225D9b9nHoXd2YfbOI?=
 =?us-ascii?Q?KMZmP/65UgRDnlJrcnzeHfjAeQSHw+bk5Fkvs3NfE9e2jr5zg0USZBIqqRh0?=
 =?us-ascii?Q?DPUIaHk9HLeCZ9NnyROdv0nEARhbRkmJKhRGSn7Areb2i0hCfeS7/eMjDmG7?=
 =?us-ascii?Q?D0tOulsq0Oh7NDE92rBuxfuZdL+nqumRwS6d2V+IoHfFS717INdvZ1/TiIo+?=
 =?us-ascii?Q?dcMddIIgTHuZYMwD9wHs7KqhqMNnheb8IZxFZPxwjHme1E9fG9eZsbSgN974?=
 =?us-ascii?Q?fodL8ulODW7p9a39TifQzXT48DPCKxqIUiosr0SA6osD6l+EWvCOfFY20Ydu?=
 =?us-ascii?Q?A6tVDCUgpIdQtf/qo5DVkWlVFwXAIc4/SEjqzTvYx9bX6d7E+490YXVKFb1P?=
 =?us-ascii?Q?Io9teSGz+QnqgaT+1poFaD2AV52fk5mvpgYmaKMx3TTxQyUbZArcJAqsgmFp?=
 =?us-ascii?Q?kVIo6qPTIySdOpVz2i6T1t1h2srwWOWSaK7tz9fjeExF3pmbiFahHSv7c6LK?=
 =?us-ascii?Q?7iuYdQkxf2cK++2S566xCOyFKFup2Owt5mmwJXWEbfC8VKnz4Y/rpP1Uuq3D?=
 =?us-ascii?Q?HvgtA2M/KCJDucIw3gijN2oOoCcHVipgCYXaiFu9Gw5eeXRzejctjrw4+7M3?=
 =?us-ascii?Q?ReFVWJptX3/siOiavbhOsfBs6OGiaLlq7UwvQznfdf8L2eeFbhEtOFpS0vrU?=
 =?us-ascii?Q?g9XVcEjQnxd1crzxQ6BHSMZnQMdBLe/vc/4o/P849HBX4pCzIaBE/nIyzSwY?=
 =?us-ascii?Q?x8LzEc4H0sUFx0pHmdeCSWeZ1JgACHrRp33esaDZH8ZFZOajE7I5nyicSKLW?=
 =?us-ascii?Q?1l1AOWgVhvjEvqjkCHE+Xy0l9jz4xozkhSWfilexJL/ofquZWNEQC9FlJSU8?=
 =?us-ascii?Q?ZO6TlB6nGJm3hpW0WVed8UJYLJcYfriVQyBKTsBJ8NdAFv00NUWylfgChDhd?=
 =?us-ascii?Q?5xLKgos9kBw3hiPGn8IHZ8b0PvfPMsbQNX0ml5OLLxIHGYF/2JfDKd/8PbpZ?=
 =?us-ascii?Q?Q6VmmGw4YhaBJ3XHvC0CuMmaQ2AzEAL+CrGjhupzkHRdG1PUngczgvgYcFzC?=
 =?us-ascii?Q?RtCdzObdK8PhUQvyV5hlJBCZZpjRuGM3StcEqNzcGjSWREvIqw3Tmxcv3hae?=
 =?us-ascii?Q?1hmQPyMNchJijc+TnQbbQFGk2O+gvu4fRqmS0LTFuHE7Oj8rl5YspWNNeTKV?=
 =?us-ascii?Q?GN8yu7nOov4v0RvN9rQ+KJ/mDgko0goov+NQwkP3rO14BcaKGC4Br4WxO7SW?=
 =?us-ascii?Q?eoKh4IU9V0kx2A4hX68wk13ZDHmO9EHZZmV9EcCgzwndLaB4u62i0h4TsDVh?=
 =?us-ascii?Q?ko8gszJspYhCZD60DMYCQyIWDoDI1j2ITEpJT/L+CGepjSzC+LDH4Namhf+D?=
 =?us-ascii?Q?+aONmFP7FTc+gKPKCdrV7Ulv68cM4VpE3Akl+SqJdQSBu3ahXApAc/eydtaB?=
 =?us-ascii?Q?j9ooDUQgaV3qLzFWIQSzInuNZt5uQ06aHNjWnIRm?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083d14ea-4060-4d7d-7cfb-08dc7ff6a5e0
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 15:47:30.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Lnkn6Ey/ifeky3pQWaNBKsAjsNWF927fI43uGrauwvAkfjGt8tpnW9/KtcoF3VB3Czw+GkBmPEqsAfCQEWBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2617
X-Proofpoint-ORIG-GUID: 3-5ou2S1ji2_WlGjwGbQ159tXgtTSSuI
X-Proofpoint-GUID: 3-5ou2S1ji2_WlGjwGbQ159tXgtTSSuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290109

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Use IRQ_ONESHOT flag to ensure the timestamp is not updated in the
hard handler during the thread handler. And compute and use the
effective watermark value that correspond to this first timestamp.

This way we can ensure the timestamp is always corresponding to the
value used by the timestamping mechanism. Otherwise, it is possible
that between FIFO count read and FIFO processing the timestamp is
overwritten in the hard handler.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 19 +++++++++++++++++--
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |  2 ++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 63b85ec88c13..a8cf74c84c3c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -222,10 +222,15 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 	latency_accel = period_accel * wm_accel;
 
 	/* 0 value for watermark means that the sensor is turned off */
+	if (wm_gyro == 0 && wm_accel == 0)
+		return 0;
+
 	if (latency_gyro == 0) {
 		watermark = wm_accel;
+		st->fifo.watermark.eff_accel = wm_accel;
 	} else if (latency_accel == 0) {
 		watermark = wm_gyro;
+		st->fifo.watermark.eff_gyro = wm_gyro;
 	} else {
 		/* compute the smallest latency that is a multiple of both */
 		if (latency_gyro <= latency_accel)
@@ -241,6 +246,13 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 		watermark = latency / period;
 		if (watermark < 1)
 			watermark = 1;
+		/* update effective watermark */
+		st->fifo.watermark.eff_gyro = latency / period_gyro;
+		if (st->fifo.watermark.eff_gyro < 1)
+			st->fifo.watermark.eff_gyro = 1;
+		st->fifo.watermark.eff_accel = latency / period_accel;
+		if (st->fifo.watermark.eff_accel < 1)
+			st->fifo.watermark.eff_accel = 1;
 	}
 
 	/* compute watermark value in bytes */
@@ -514,7 +526,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	/* handle gyroscope timestamp and FIFO data parsing */
 	if (st->fifo.nb.gyro > 0) {
 		ts = &gyro_st->ts;
-		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
 						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
@@ -524,7 +536,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	/* handle accelerometer timestamp and FIFO data parsing */
 	if (st->fifo.nb.accel > 0) {
 		ts = &accel_st->ts;
-		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
 						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
@@ -577,6 +589,9 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
 	unsigned int val;
 	int ret;
 
+	st->fifo.watermark.eff_gyro = 1;
+	st->fifo.watermark.eff_accel = 1;
+
 	/*
 	 * Default FIFO configuration (bits 7 to 5)
 	 * - use invalid value
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index 8b85ee333bf8..f6c85daf42b0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -32,6 +32,8 @@ struct inv_icm42600_fifo {
 	struct {
 		unsigned int gyro;
 		unsigned int accel;
+		unsigned int eff_gyro;
+		unsigned int eff_accel;
 	} watermark;
 	size_t count;
 	struct {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96116a68ab29..62fdae530334 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -537,6 +537,7 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 	if (ret)
 		return ret;
 
+	irq_type |= IRQF_ONESHOT;
 	return devm_request_threaded_irq(dev, irq, inv_icm42600_irq_timestamp,
 					 inv_icm42600_irq_handler, irq_type,
 					 "inv_icm42600", st);
-- 
2.34.1


