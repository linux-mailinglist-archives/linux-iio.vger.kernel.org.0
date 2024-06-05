Return-Path: <linux-iio+bounces-5872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1978FD6F2
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 22:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78031F24C6B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DA155353;
	Wed,  5 Jun 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="d19WH2J9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1981553BC
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617653; cv=fail; b=fIsqJLlzfckxsfwjlK9TQBMzJMpNsVfyyC0x0q3/pkQw1pxqyD4bc1lrZTK4w9VFilDDNNMTw8j9a55ug8KDbpsULyOoWC6Fv8hDyuFFI+8lG6xBydNESR4QD+cm8Iw9fpSVU1wevSmqM7n9sU/kWUWgLq6TOiX80eNVtFOWzjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617653; c=relaxed/simple;
	bh=Yw33NPmGtW507dpcbHG0+zpttDkdpXx4ti9OLtwvjHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRoevUT7E+vd3SVYHepoDxD3eR5SZgMejrZzmBOMKvlU8KzmhSlozYo7JwRAgs+uvKup3wT3tNMmjk0Wyw1GIDklKrKO4SdWihjVT5n84BnzLWuptmk1HkZimxgKaEtoaFRopBnNWJwMvLBe/O1sue/fBI8yx1K1oaI1VmKUluA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=d19WH2J9; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455JMsbL001224;
	Wed, 5 Jun 2024 20:00:25 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yfw4eu9ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 20:00:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeMtXn5jMLJT58voSVP3H3Jw7GIIRaHPf8fwzZ1WaSmZVvkAtW21aJuvfybq1ZVrKhV2wUs+cDimfe+i4S93hBa0oWqO50jvO0p1SDAL9F+bwmHQSNXAZsqOB39qCBUvhwJkB86C9bLGG0ZylyJnoldkBE3zbxUB2imcwGL6JfrjKGdSCHQHi80zGJmhZD9x8SZW6vsLjMnJrFsFD94g0kmT7gDNWAVSVNSX82f3VTjDr/8Jfy9/JUcFNqq6V5r3sQX0URXg7lWKeZ7yBnrt3TZMz3BpAnrXAlnX2kIYJa42vEA9nlx41m+1VT2AtDgCuCa7W7OEyJ2tHq191JJyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zq3w29uBFHk7LbkufxMuGZHt580vn4Bb/1R4/9egxQ=;
 b=kqzuhQifLSi8OZuT0gdzn2FgknEAy7CmgAVgYz99jEPKmFBrkftDNfd9iWrjZ5fpNJPDtaXpzabnE1LL4NRCE3Hu58zWCGembli4lGqvTd/xA+o0OfurS4oJ/yhxN4A9HHL6X8Qt10RnTXzeN0P0PNjkUCtQiRODGkE/WScfvn2mc4uJivTW3C74tvCawQ0Uijr85cfaK0+BxKSX+SSxV+dfq6eNoUsv7Kr1cDNN0xSxTcOMuLc75UnxJiKtSa2rv83Hh6jsDiUECWCOgo1kRIqlsdCuEo4Ao2jtK512XiUoycOe/9YG91XrxED6p/ZTjJNDiyY6sRLcQzmxyPidxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zq3w29uBFHk7LbkufxMuGZHt580vn4Bb/1R4/9egxQ=;
 b=d19WH2J9utCxLvqBP9h4qzN7HHZPp44TZmQYVGm4bCr3AN4QtSPPhGVqedI/plHtZpe93qVb/Nn1O7+RIUUQKW9jxoLuewoLlF0rQ0Yyfj6NAh+R6R0kb/QJPti/WX2QpdfFcGeZwzrK1tUn5WFM7aGrgf0dCd9T1pTMxljvysbRL/y9qXa0zPj0u3MNmrpGx3fBax76Zl8G4MwUC+BG1sKOwr1d+LTebj4lF1/S9sFKIZ6GcMDfmpjVGmoTFZhs0wM3GUG7WdXRJD4m0ibFi8/+RpIuYaNqj2mwNey3Fk72lYgQ6o4kEmZCcxUMbXco5dsfzzv5pLCqh1XTIBtPLA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB2172.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:173::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 20:00:22 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%3]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 20:00:22 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v4 2/2] iio: imu: inv_icm42600: add support of accel low-power mode
Date: Wed,  5 Jun 2024 19:59:49 +0000
Message-Id: <20240605195949.766677-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605195949.766677-1-inv.git-commit@tdk.com>
References: <20240605195949.766677-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::23) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB2172:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f99f35-9bca-43e2-89cb-08dc859a21e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|3613699003|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wDW3E/bE5JNDsEw8tw2R448IKO7FuxVVYVhDFB+RRtiJicJ8I89uNQEqyZ5M?=
 =?us-ascii?Q?OsHu+VsH53VwJ219IvtYo4Dyv+Xjhr1HCJd0c+XXhCvpqTmeMPSCoyOwCErt?=
 =?us-ascii?Q?oDtxVxFi9ZNrKIQvIP02d20VcXJRPrPGGUBYapSFJdp69fEoOfexfR8LeCDO?=
 =?us-ascii?Q?FBJs0nwiZGmFU3ZXHsUR0LM37tlRK6OViuXpS5aye7Zx0z4vMFLyhPDDRZsT?=
 =?us-ascii?Q?iZYuBaipf9ZKzAlULMTlDsNrdhK005yQmvuViWuekpCRJk9EPF3cOPehKHx2?=
 =?us-ascii?Q?2mb9mldNGeYnh0zVwrE0VAu+lx7bJFd2TwiyIVzqly9aUNCaw2jgGcB3FUXE?=
 =?us-ascii?Q?cUDlyQEhY6WDwNGCje1EUmGdkDg3hYLSEWYX/yx1jeAzTWjQhReEHVnLyrzN?=
 =?us-ascii?Q?Mk21e2j98w8DpJm4wPcGklqWmDciM082soHvOZjitycJYWau3Jd9eC4nGk6f?=
 =?us-ascii?Q?iqfFQxnepekdRmsRKnRkCBpuLfbctHzQmNa7N/fpK9UnWko8vROAmr0nMoKD?=
 =?us-ascii?Q?3jxpLxpMWNsbVBJWRBbRzIsIHJnu/hHhMek+OLRM33PPG36U1Bxw5dVFCe/V?=
 =?us-ascii?Q?JL+tcH0SYXTsbunHFbpu3Sr2xp6/uvPEH949Gbiw/FH/5C5L3rwlOa0RCSK+?=
 =?us-ascii?Q?V3S5NvgRac/cDS07H/szu5RBUZFuPZtO1bzYs8gkU+zGqLIAEYM8e4A37Pu6?=
 =?us-ascii?Q?dJYNVXZAFns0HkFqtyF8zf3svi4ZmixNzMVKJ4ZkN60+CilGlImag+V/GBbw?=
 =?us-ascii?Q?+bJubjZvi63j80m64xXpXbjSXO3ufsSCfAHnEJg4+Ts3xVY5WLzDKfV0JFgU?=
 =?us-ascii?Q?gZ4/S+AeQ0z6QziVQhB4thVNI3n9usX4a9reo1Hp//7RRxEIiXmZOhnsLpox?=
 =?us-ascii?Q?RFwpyphzqnHLB1Lf+RnzNwnGd47V0rvryUIV3UanBLZzv09IYjFlm00IFkmF?=
 =?us-ascii?Q?dmSXYTmqCWz+2WLnNXP7g+lz+/cTahjQOY0fpg4Dpm0UoRULa8x1VMKVJvwc?=
 =?us-ascii?Q?KYtLjEm/8IIkAMSPrakDSyKCEe7Omc0tSXlgexMuLdrojPoYpmI+XoV/SYoQ?=
 =?us-ascii?Q?rsszwMkKZX5NhPU/tpR+o00tyjMfasMQNeqvOJPmaxh69hjAzG3zi9L3RZOa?=
 =?us-ascii?Q?JAt7U1mVOnci9n0F46w2y/rkrfSx2nEUFjIj15eW3qZ27E/uz/yQ6sWByuNv?=
 =?us-ascii?Q?wQycRTYT6wopF5WqxaGyfMvgUNkiWMoKXzX2zu+Z+k2aKdLjTaFTS4cFIbGf?=
 =?us-ascii?Q?d6sdan2x1LBufE4D3G3mFza9XaIo8/MMOeBZ58ZDnGIlmRteGRmQ5JM7ikGv?=
 =?us-ascii?Q?1TBV8tP7c+g20j3TIZLNsa0L9IhUFwQvDdSPOosHUFIRdG63WrH26J+hDVhZ?=
 =?us-ascii?Q?RFY54yg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iMZ0fubysdRrdG1x7Kw1bTRDkyraeyB03XMhzI8mWWKCxQA3+QUTldiU4Ptb?=
 =?us-ascii?Q?vOZs3UREIdl5bjWW20zkmPgVX31C+se8dzCN2Zc7U4kQHI/k56AqtvNL4RQC?=
 =?us-ascii?Q?815N6VQPu6j6TdchgfyRZS7kpQX9nUZw/uVPFXn57AAQ+XOUBYpnUX9/acA/?=
 =?us-ascii?Q?FjukXpR/Juf8/xAjrQIVDmoNU8XeuH4q7RyiSRTnpoZl8/kGh9n9p6dEGR27?=
 =?us-ascii?Q?LNdrLEa35bl+kN9w3RMcNEcS75eOdvg3g7/ScgYymnYjIA7NSJ/Uj/+KTBe3?=
 =?us-ascii?Q?sgP/wlykUciIgWXz66XxUrNVn4UWTz2YhQMGQNttVqS6yUq7x//gZYpKJuQJ?=
 =?us-ascii?Q?YCw6DVLEUEzoyz9nfV7J7FVigrPx8JV9mcftQj0jYBKL5v5OBaDQFK7CX34p?=
 =?us-ascii?Q?fcPVr6Ronb2qbnoX0ON+t13oYaOjQjbHuoHBWfOB7Qx49qw3fkUTApI82yvp?=
 =?us-ascii?Q?kTKeDTzoWLCIqjLStnBkWL9V3osSqGc4q2GrLGDNmGbnqo4zrkYgDwlPK6G4?=
 =?us-ascii?Q?6vedUwtKpLiV1ATNEYBYbwxzlqFGSH1h7wqDEGgxIiDaAkmy6dPsM/e1JGeg?=
 =?us-ascii?Q?tjS03Q2TD9IUZEVHizH5FvL9BVHQ5alhuHW6IjwoT1hKZdd7DS0bYZOch39J?=
 =?us-ascii?Q?rdVKaAfM3llr6ged7/TNYXZHxFpFu08oY6szknTx3FOkjR6jIGkPwuv2RCgL?=
 =?us-ascii?Q?Jecp+gQ5kQVT2Q5OYt9rMw+GQaxcg/GW3vLm85RBr73kZeXqgywjQrhDWFoH?=
 =?us-ascii?Q?rVZ7hHWyM0rTmrcN1WvyINQJLLDvxdeuSw+BJfUlirc2aLlxmAiwR9zhrsEz?=
 =?us-ascii?Q?KcjtcmNACIsoMKEXqBxhl1eB3VSrLwh3ZevZU8o1oW64o1W2SEvz2WSdhmcv?=
 =?us-ascii?Q?t6/WgijnjFJAHnHl6ASduUJmhcyzIBG7oSOIExOoPefgHOFvOzcI+60iIY4X?=
 =?us-ascii?Q?FAg8mY8nwGgfDj2jDBoMLzW685pBYFviaeBqbTRiGVI1D/7ClR2ojYJemY+S?=
 =?us-ascii?Q?dkedcgWEmerTuw0YAsrdCTMJza/Y0/7TKQxjdCMRM8/q/oXRse0VganOMPpi?=
 =?us-ascii?Q?qigy2J5K1j6ZGXFjdKpH4P5zSu69inx3cM0CpSG0u6GAOllGkzcqeftrjH1v?=
 =?us-ascii?Q?6ZhB2I6VWJIilC3g4dNhwoOctPC4y6030xOnmieGJgEvhH90Abd+Q3nURozJ?=
 =?us-ascii?Q?OlizbQiAJ1nMqK7Fy6qBcDSVhb+AWIlwjj0b3KlCyOq+8x8bwbbSNNsXQ9rM?=
 =?us-ascii?Q?Vnx+UZYSh6HWPTZSToZIFlehT9KI8z2hAQxVvxFH6J/DKH+T9eS8UFV6IrRO?=
 =?us-ascii?Q?QlKNNKLKD25Rp6Cluv27DgHfH5XUrM4IvvdK69n7JvslMnLD2/yuQnn8zmfY?=
 =?us-ascii?Q?meRKZDgV40NkM1mwW7ACDOfcQHqUj8tYODp7TfK5OxFuk+2ukL72SUX5i1NN?=
 =?us-ascii?Q?fnFiwz7eDnMPtVkFwhrz9WhU1JoVXfuQlgQd413QG31ssVyIhdomtft7el2a?=
 =?us-ascii?Q?NhqBuUyKSdiqeLoQuCSEGew1V/BqFm2XAa0FZfpbDlAwAUf7qCFec6LBy0Xy?=
 =?us-ascii?Q?a4rKmUT+Z6oRTu0+FOVpJ2WIY0HljmSKSVPqLZpz?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f99f35-9bca-43e2-89cb-08dc859a21e9
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:00:22.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ/cy3DDiD3yhFxTg2gRadGUdvDyxWMBtmrFHuur40bPSBHd1ybZi/Rbh94lqx7fjMlcMiQpIkCKbZZMWTsotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2172
X-Proofpoint-ORIG-GUID: oiMCyVZaM2oXFFOXtt4joF98IKDdFBww
X-Proofpoint-GUID: oiMCyVZaM2oXFFOXtt4joF98IKDdFBww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406050151

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add ODRs accessible only in low-power mode. Switch automatically to
low-power or low-noise depending on the ODR set.

Add channel attributes "power_mode" and "power_mode_available" for
setting the power mode to use (low-noise or low-power) for ODRs
supporting both mode. Reading "power_mode" when the sensor is on
will return the actual mode and not the requested one. It will be
different when using ODRs not supported by the requested mode.

Use low-power mode by default.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 124 +++++++++++++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  27 ++++
 3 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c4ac91f6bafe..3a07e43e4cf1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -177,11 +177,15 @@ struct inv_icm42600_state {
  * struct inv_icm42600_sensor_state - sensor state variables
  * @scales:		table of scales.
  * @scales_len:		length (nb of items) of the scales table.
+ * @power_mode:		sensor requested power mode (for common frequencies)
+ * @filter:		sensor filter.
  * @ts:			timestamp module states.
  */
 struct inv_icm42600_sensor_state {
 	const int *scales;
 	size_t scales_len;
+	enum inv_icm42600_sensor_mode power_mode;
+	enum inv_icm42600_filter filter;
 	struct inv_sensors_timestamp ts;
 };
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 83d8504ebfff..3927829dd344 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -55,8 +55,108 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
 };
 
+static const char * const inv_icm42600_accel_power_mode_items[] = {
+	"low-noise",
+	"low-power",
+};
+static const int inv_icm42600_accel_power_mode_values[] = {
+	INV_ICM42600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42600_SENSOR_MODE_LOW_POWER,
+};
+static const int inv_icm42600_accel_filter_values[] = {
+	INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	INV_ICM42600_FILTER_AVG_16X,
+};
+
+static int inv_icm42600_accel_power_mode_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int idx)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	int power_mode, filter;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
+		return -EINVAL;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	power_mode = inv_icm42600_accel_power_mode_values[idx];
+	filter = inv_icm42600_accel_filter_values[idx];
+
+	guard(mutex)(&st->lock);
+
+	/* prevent change if power mode is not supported by the ODR */
+	switch (power_mode) {
+	case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
+		if (st->conf.accel.odr >= INV_ICM42600_ODR_6_25HZ_LP &&
+		    st->conf.accel.odr <= INV_ICM42600_ODR_1_5625HZ_LP)
+			return -EPERM;
+		break;
+	case INV_ICM42600_SENSOR_MODE_LOW_POWER:
+	default:
+		if (st->conf.accel.odr <= INV_ICM42600_ODR_1KHZ_LN)
+			return -EPERM;
+		break;
+	}
+
+	accel_st->power_mode = power_mode;
+	accel_st->filter = filter;
+
+	return 0;
+}
+
+static int inv_icm42600_accel_power_mode_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+	int power_mode;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	/* if sensor is on, returns actual power mode and not configured one */
+	switch (st->conf.accel.mode) {
+	case INV_ICM42600_SENSOR_MODE_LOW_POWER:
+	case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
+		power_mode = st->conf.accel.mode;
+		break;
+	default:
+		power_mode = accel_st->power_mode;
+		break;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_power_mode_values); ++idx) {
+		if (power_mode == inv_icm42600_accel_power_mode_values[idx])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
+		return -EINVAL;
+
+	return idx;
+}
+
+static const struct iio_enum inv_icm42600_accel_power_mode_enum = {
+	.items = inv_icm42600_accel_power_mode_items,
+	.num_items = ARRAY_SIZE(inv_icm42600_accel_power_mode_items),
+	.set = inv_icm42600_accel_power_mode_set,
+	.get = inv_icm42600_accel_power_mode_get,
+};
+
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
+	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
+			   &inv_icm42600_accel_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
+		 &inv_icm42600_accel_power_mode_enum),
 	{},
 };
 
@@ -120,7 +220,8 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 
 	if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {
 		/* enable accel sensor */
-		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+		conf.mode = accel_st->power_mode;
+		conf.filter = accel_st->filter;
 		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_accel);
 		if (ret)
 			goto out_unlock;
@@ -144,10 +245,12 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 					  struct iio_chan_spec const *chan,
 					  int16_t *val)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int reg;
@@ -175,7 +278,8 @@ static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);
 
 	/* enable accel sensor */
-	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+	conf.mode = accel_st->power_mode;
+	conf.filter = accel_st->filter;
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 	if (ret)
 		goto exit;
@@ -277,6 +381,12 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 
 /* IIO format int + micro */
 static const int inv_icm42600_accel_odr[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
 	/* 12.5Hz */
 	12, 500000,
 	/* 25Hz */
@@ -296,6 +406,9 @@ static const int inv_icm42600_accel_odr[] = {
 };
 
 static const int inv_icm42600_accel_odr_conv[] = {
+	INV_ICM42600_ODR_1_5625HZ_LP,
+	INV_ICM42600_ODR_3_125HZ_LP,
+	INV_ICM42600_ODR_6_25HZ_LP,
 	INV_ICM42600_ODR_12_5HZ,
 	INV_ICM42600_ODR_25HZ,
 	INV_ICM42600_ODR_50HZ,
@@ -581,7 +694,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = inv_icm42600_accel_read_sensor(st, chan, &data);
+		ret = inv_icm42600_accel_read_sensor(indio_dev, chan, &data);
 		iio_device_release_direct_mode(indio_dev);
 		if (ret)
 			return ret;
@@ -754,6 +867,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 		accel_st->scales_len = ARRAY_SIZE(inv_icm42600_accel_scale);
 		break;
 	}
+	/* low-power by default at init */
+	accel_st->power_mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
+	accel_st->filter = INV_ICM42600_FILTER_AVG_16X;
 
 	/*
 	 * clock period is 32kHz (31250ns)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96116a68ab29..edf19a8a2f39 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -248,6 +248,23 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 	if (conf->filter < 0)
 		conf->filter = oldconf->filter;
 
+	/* force power mode against ODR when sensor is on */
+	switch (conf->mode) {
+	case INV_ICM42600_SENSOR_MODE_LOW_POWER:
+	case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
+		if (conf->odr <= INV_ICM42600_ODR_1KHZ_LN) {
+			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+			conf->filter = INV_ICM42600_FILTER_BW_ODR_DIV_2;
+		} else if (conf->odr >= INV_ICM42600_ODR_6_25HZ_LP &&
+			   conf->odr <= INV_ICM42600_ODR_1_5625HZ_LP) {
+			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
+			conf->filter = INV_ICM42600_FILTER_AVG_16X;
+		}
+		break;
+	default:
+		break;
+	}
+
 	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
 	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
 		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
@@ -441,6 +458,16 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	if (ret)
 		return ret;
 
+	/*
+	 * Use RC clock for accel low-power to fix glitches when switching
+	 * gyro on/off while accel low-power is on.
+	 */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG1,
+				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC,
+				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC);
+	if (ret)
+		return ret;
+
 	return inv_icm42600_set_conf(st, hw->conf);
 }
 
-- 
2.34.1


