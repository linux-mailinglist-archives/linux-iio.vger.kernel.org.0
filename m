Return-Path: <linux-iio+bounces-9667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38F97D63A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEA2B229EE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B38179204;
	Fri, 20 Sep 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="CMgP5YdM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7416DEA7;
	Fri, 20 Sep 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839412; cv=fail; b=L2DxQJyU/WNEJSioPDXHRRtxs93NtTc85/VFkspHWoH0uk/gPjpOVyV8uyhjJYvI/44bTGGmc5h05tGFj9ibmlrcFj4HvTWgvnhest3JBsK/vU+udENWNVExPlugK/N7l6FqI3+/rRf9i2FfS7TpA/k0llzzaGPn0b2hDkIbpS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839412; c=relaxed/simple;
	bh=ewmejB/Jr+BabxR0EBqgAem45BX7HThNGsxc43KnjwA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=M1X8TNRSzyi5OSuDa/CQ1ovdLQQOoVFuw4MF0hen6PSXFXQVCvf05fVqB45Boobjii6vW+toyxqxd+pMtgdOLHjU6XKURc4UTkO0Du1R32vXrNrjuczxJSzZAZ5wgssJ5PO+/LaryYshY3OTek3MyEMqrj2uNzbb+UA7svOYGRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=CMgP5YdM; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JMQRsm019950;
	Fri, 20 Sep 2024 13:36:34 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011029.outbound.protection.outlook.com [40.93.73.29])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89v1cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 13:36:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpTM8ehmwQv6YVDCQTtxbbrzhHZIFOCyy1Tpzn+JdPKhZcrXc1Jtl2KdTbylE647fhs92xkUuL7Twb8c6wORke9hEsUio9PcEqsf1LRHR71xoWeGPXBt+lJQUciTxloMnzIP97yn/ljilmExRE5wopPoIT52hsa3uFd1midt6Pq8xQ5CeFh6nwxFqUhA7dAM1ZTEsprROJ7T8xfJnWodQdreQ2w2yOhzOJ72KV761CqV45H/tQ/uDGYFxUUWhTfDHiDa2dVq2QCODL/oSECdAXVS632MoOrDUzRBiIkpIM2pvRcPT8OxvxWH/G5LUpz1M9fImRVmbtuq/ii4iLeYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMoaQi8Sp+mGcBVCwyNe1vwD4esFKsu8TQ+Xk+XNglo=;
 b=OUF+nRMy0ngkm2dcz5jo2bl1i+wo6NRH5IA3SCwKfHu/2+aEwSrQ1zQhUFeWqjsbJ9C5L+NveSpETxaPY+pqmgFmnXY3rdWjEHNutGEYDnZad3SldtQ3/1tyVLt91uKQoW1EuVz7DSVCeXDdXl1VcrYCA8QiOQppngeABAmV6V9lpSpx0oQ6d66B777ciUauAL96q42JqiQz5WQwtG3b7d42hFdqBrEl/Iadb5nd7eSmEZGF2RYYJ6omZVvGEZfNIpDVbFTk5q3OmvQy7fQVC9nxE50SntTPtqwI8Hs6xILP2ubFyVkztn5+Hd+GidaZtgj1ZI9waxeeavTJnJ+ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMoaQi8Sp+mGcBVCwyNe1vwD4esFKsu8TQ+Xk+XNglo=;
 b=CMgP5YdMb+naMVquM+n/Dj5+Bglv/hjVqt/9/V/FtQLrpL7TQmYbQdKyWdWqgE5VJv29JeBubz1IetIadrNbFjxVKw7JVJPeOrTVFYoH4GnUBCEw+T+nEFeg76aO61t9EWHnMmQhV6Gsup6iHPQgh8G0pywIVmLBWb7SgXcCq74H3iX9hpBbwOlfuhypwjYs9EPOCiEowRVbOVUv8mEcGnDd3GYzsmg9OSQ+TOqMjvSLFqUK2DOvp9jcRfw6NFFxb4gkhz4Hngw5PRIoE1Ody6VzhJ362c6P8BCjvc8vWhEJoUZi2H8HeWMvm/vcVubX8eKZ05rbxSZWSksXp86r6Q==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS9P286MB5256.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:310::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:36:30 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:36:30 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 0/2] Add support of IAM-20680 HP & HT
Date: Fri, 20 Sep 2024 13:36:13 +0000
Message-Id: <20240920133615.167726-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS9P286MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: af7acacc-756f-4cd9-d21f-08dcd9793be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0u4zj4kkAIPResNsv8YAPh8ewZMm9yPS7bMqg6evh7k526doaCrKIyK7O18o?=
 =?us-ascii?Q?zRcKu4ilA6y6uulkk5eoPlPQzjEtX26RMmyzVI0+9cgDz0AGziA2NNBZbWMY?=
 =?us-ascii?Q?C+RDxUGXAH37vibu2jfYgtS2o9QBBTMrdvI9pPIAq9tJ9qmhNPqGuktWka9y?=
 =?us-ascii?Q?WX6C2aVYNs/mXEtNUdf1kN4Pf0d/Z4SP5pTPP33Ejj0uxlcrzxLj2GzhBjWH?=
 =?us-ascii?Q?EbBpjd9/BywNmON9iN1EX71gr+hgpi2Mstsixw1XcgDcmo+pQpnaY3TtMJi+?=
 =?us-ascii?Q?X6OUWEbT4SNJOCGEXM7pmR0EAVbgJW17bGCy/n6yH3xb0pdkxoEA0lAaQLvE?=
 =?us-ascii?Q?STJw2xDmTfUHX4KN34iIheIb/T5l/2zpXs+42qnC1WkOtdCMBchC5NbETs4r?=
 =?us-ascii?Q?/XTpzySxq+amyc+C66ur+buthrbq/vGlzOCj8dpQ6MtI6R/RlfwYeCx97m5I?=
 =?us-ascii?Q?jMSjutfVDfS3BX0WwyiHTnJvAE7lw4tYrHQmdw7ZMj3HnQjkUkSk29dIH2vE?=
 =?us-ascii?Q?6qloIz8vjdWXVZrBeI/SiRVpjdrOiVFp5pE0xq57RPd7Ita7xownziupc7Ja?=
 =?us-ascii?Q?h3qCu7fw/IePDEkUka8/2cO84VHS8UFCOGCUTrmHOqpHCPGx10UeDIcIRPQP?=
 =?us-ascii?Q?7oLxWxLOxKfft9acMWnYUKx3qC4q9w2swek1Sm4jFhoOP0c0ctFfgE71if1i?=
 =?us-ascii?Q?9n25H7J8T55zNPSvFxzVwwaqLdZvfS6aM7jvX15Bz26O+L3bufIPSAvECUz1?=
 =?us-ascii?Q?rji0OJPI5URqjFDRfeoLHQGCqXBwCpisx5pJ03EcUAFTwUNY9fRjq0U+cFZv?=
 =?us-ascii?Q?JDfZ4pdceGh5ksfBKURrwMdBdoQZGlOoBtlIWCMc8B9BNFoFzg9ecNkSQsvY?=
 =?us-ascii?Q?wpQhdFVus+C1hKpF5WsfHjdZnPJO3mbUv/LuLdqiqtiv4eZY7cCYnbu4Zjze?=
 =?us-ascii?Q?5l9OoyVz6Snk3uKZRLNNNRiNH1f9e7sDg25h+l+LG+FdZcP+Eqag5YV2netV?=
 =?us-ascii?Q?e935c/0oQV02AdUSEexbDGMGXSiZ9X5QYEwhBHEWyeN/h/GZBFigdRX3eJny?=
 =?us-ascii?Q?oBUb5ogW0Y+ic8KxQA5WKeC8aplB4HTh5MMV3ESMIjydtPEc+ypRqVsjF8EQ?=
 =?us-ascii?Q?oWuZt/HlVU08P5DXd+1NmU96OeDgrm9Guea+PWb6cAtJDxrTXNtHs3QHf+uK?=
 =?us-ascii?Q?eVKChKBm7c963FFSzlGAuKUW6AgztN/Vi7Jwxcx98bMIv2n+gOf9jkNpy9b1?=
 =?us-ascii?Q?fbBBbBFafVWA9Us2Ksw4FbY9kYudfAzqD0Lyji3ZpfZ6HF4d2XhF7hBy3ndl?=
 =?us-ascii?Q?6csmcvJ3RTuUomLEXQ6OR4ri/1iUanBf67Mm2vualmQiDtoKAZvyqTwzUzK8?=
 =?us-ascii?Q?aWnJs7XXd3HAov14jWxpr40NyLD2zKvOLYUCOchr6MBCEf2npA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5hBexj/KattAvvldKEe/k0zr/7eIcQDAB9CS/ex+VFdcSoympn45zAoSyvA?=
 =?us-ascii?Q?OiWM5QKDjdfWLB7K1SirCG2l5O8CLhdc+6UXP85d07i5abeLcs0HUtWKliCx?=
 =?us-ascii?Q?atzTY2FtznSfSAzmG5Vzm/WTEKVr0zLWrzngM/AdAou1tUnozpf1iuTSRZ3c?=
 =?us-ascii?Q?LEWEg6v+irR2aUS2wim5L20/yehzGkkhTfh1bUoxE/5rd84Px7iwwqg+K+Dq?=
 =?us-ascii?Q?XZvwWNzGN/1gNZscepvp6qc+hjZ1B+3wtKEuvdKOeJeMIAuehIKW8diOxHsO?=
 =?us-ascii?Q?Ert0crt7AxW7Ir6xWrsIk6EDOO06Ii8ehf33j8ORezOhTk2xEn5k7n/Z8mgZ?=
 =?us-ascii?Q?L67+wzaqg6tbAeAtsy5O5nOAwvb/yj2G1lyFfvUT5RZUPjQRQVy3yZOgbvKK?=
 =?us-ascii?Q?TSkirOkV/NWzBkTYnSQA4fA2IWfExGQc4s8xykmLrVCPBWF6otxiH0xUAFSB?=
 =?us-ascii?Q?hjqkdknY4hGBX9u80tnLJowgLCoM+4kDzpB3+p56UNvWg/q5kPO2wJydHEIg?=
 =?us-ascii?Q?b0aMySIHTCjY3k1Qu55R96+fzQWLoQhUiiaq2FcTwpxd2uCDz6Of/YXp6+m2?=
 =?us-ascii?Q?3LhwvbbHS9NNA3njxvtB+tL6K7Ks3hgtvq9MhYuN+lkkbLwTgPC6PpSUJ7SA?=
 =?us-ascii?Q?gB+RXdvmx0sdOvNKOp+nvb/HKiuLdGEm5t03dc5Oq9Sm0Fgh3IRmRuUyzgWy?=
 =?us-ascii?Q?ZJTLjZF5++BrsmXT0i1EcRCHOuvPIv3J3lcnE3KiVLG+pQkZznS+dsyu8XIy?=
 =?us-ascii?Q?z2CoEbYBwCE/Ysvjz16oNcP6GW1BR4kgJmFPVTKb7hm88H6AaFCk+VktRyoG?=
 =?us-ascii?Q?v1KAhpA8mqIM3LiiKAf9eGR2yZkaShKzxDfjBgkzSjR/hs/HJWwX/j5pT31C?=
 =?us-ascii?Q?qwxQuqb1jC2VVrOzzHEh97opNpEpdh+3AF5FuxEM42mIgPU5UA1XYx9t94Ya?=
 =?us-ascii?Q?fO0SmEbiD2qSXL/2ORuE+Z5gpzdzRi4Cqs+ld8twxQ6zPFWS2k4zdPPhSHEA?=
 =?us-ascii?Q?E71I5J3vpDASZCyAJc+oN5FBDYrjqyugp70EvY+tM2clwkkJMnj3rlkDgJug?=
 =?us-ascii?Q?ky6NmpZlBiVMTPo8AbfU66AwuHS+95EkmpS2SvyytshUWDnolzwuNWAudeWU?=
 =?us-ascii?Q?uGz+WKIAWy0C6LtBqcqr8vywQotLuBC7dIdFNgKP4WLKkfrHt7Yh8j/6793S?=
 =?us-ascii?Q?hbxT9Kch9tSbeOwA1d9mWrzlXcMyYpijfEckqJ54mqzArBwHuPFIvvmxi4er?=
 =?us-ascii?Q?6zXLRhejsGC1d93oSHTT7bV2cHGygPuQ/ZD+3onggzHxldITrZsMROsI6cL+?=
 =?us-ascii?Q?7hr6Xc04CanBfecjD4yf+kxLmPnLKMOyNja/rY6nCod1lJ2b6jiKhOq1iCFR?=
 =?us-ascii?Q?Yj8qTn6fC+6W6fcxHp1kmHBaxiGQnWL6UMZK68Vmpb22+Fb+taUBvAd0CRXL?=
 =?us-ascii?Q?8eQZgzDKnME/V8+JjAG5MRrUjUKkjG2xiYZ8J8fgNtFmGZjhGlUVCaojOtn/?=
 =?us-ascii?Q?yIm1bGoffxy/xmaYAiCL9WIkL1pfQIBjRK0CQZjD8CKXFdJmdBXvQbGcSg/V?=
 =?us-ascii?Q?ra/aNxNEO1Ox+93bTu0iMYaOI48qhwBi2iwHiFWW?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7acacc-756f-4cd9-d21f-08dcd9793be5
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:36:30.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA6ZS6dBQa8BdCEXM0XUZSoijc3GIes3BbIYacc1BqJF6z45ewvxwV6EfePz+sLKPXUxYEC7laKOz+3JscEbNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5256
X-Proofpoint-ORIG-GUID: EfMVNYc2CQUG723TPmkazvhweGjsOCCQ
X-Proofpoint-GUID: EfMVNYc2CQUG723TPmkazvhweGjsOCCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=994 clxscore=1011 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200098

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add support of IAM-20680 HP & HT variants. These chips have better
hardware specs and a bigger FIFO while retaining full compatibility with
IAM-20680.

Jean-Baptiste Maneyrol (2):
  dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
  iio: imu: inv_mpu6050: add support for IAM-20680HT/HP

 .../bindings/iio/imu/invensense,mpu6050.yaml  |  5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 20 +++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     | 10 ++++++++++
 5 files changed, 49 insertions(+)

--
2.34.1


