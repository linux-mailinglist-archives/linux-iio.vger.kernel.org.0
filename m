Return-Path: <linux-iio+bounces-4441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732BC8AD247
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 18:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABED28610F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042F15382E;
	Mon, 22 Apr 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="jaTEBHbf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20515532D;
	Mon, 22 Apr 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804018; cv=fail; b=QQ4XiBw7SMHXmFXF4TOjH+VGiOJalCTiTQ3zCqNZdw3Yqxq6UVErdDHfuH5FGsSc6bt5YVTRhQEPKU/3Y3lWLWBsNX2X0rXYo1rz0DIpdyx39jf5PnaqGsHJX8s8DQioHRyKyitr6w2YNpbS1fnq8Um7tSV7uK8xqK/4zz+YzQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804018; c=relaxed/simple;
	bh=Lw7xcZnct3Zmd0IBykH3/2Db3Q70WS3QVHIPEBXV/Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jb8BmUKs5m7LCmPc1iGNmSAYB+ZyKpE+bs8Dg2nzxeNs1m8EeUfqslMUuNH7X29HxkgHoBYZBTU1yUDSQO/0J1S6EM+gCSmJRybnx+Gh9i5IHXyM8WKxhNwE/7QlzDURwuYSYdqFrdKbcCrTkZDmtjxtVJJ3EQpV+VBtADYJX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=jaTEBHbf; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M7tnoD010569;
	Mon, 22 Apr 2024 15:23:06 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xm72j9aw5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:23:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCzILRgoWc7id/JtOAWSx4djwjhc/dPe8NQyyzsEy7cL1Wr/dU5wGqO/vrZvhrKv5z7tyTWQzwG3nY2cQxqN+vjXrZRcdPZ8T+aQutIV7D7tZLjhnBtxF+abMmsA5i9Xg7P5guROMbdD9JjJ7oiP7L+3+QMJSwICJCNWt0eZ+YCE/dFw9nTBt1smfoCxVLLqC0JsOt7cGAKJ4ZrLi7B3fyddnmH8uqBgxgPXw2ugbQjpiHmTzJjBES3q01pa9pSGB+BhIqMfrrWwZGWZi2yt4LBJv9sJonUy6piYh9zwAwUq3+4zmDcTZPtr4zM4ECbzQVAxFlH6JYgYvBmVvO/MZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R/4hW4Kp9/UqGCxMx4BhWsmYzZ5yKSFWWRpACx1RiU=;
 b=IywdS6DHK7eQAYK8BWZ2X4xw6zVHg7yQZqW0YgpE2p4SJ51kSccZthUzczzrgNEUhQl+S7NrXmv7bPoPM1qPqTxQSWhShY12zSbPtQQvre2/sclTrBN5UDozzIgWWPOhhWaWbR18evHdbp/6Wm+CNome1YCsppWq0C0TSel+9zUdA4pfj0GdxD3Ybt2xfwNifqRqcfCl93wqZfXt+eGFyHumL+Eefi4eB7sWfGRaMqWW7djPZSBpEN2fi0LDskX4llLWcWuplZW/PSGenlyx4RN8Nzp+qJI3Rv6bPzdV0E6BOZwtku0TBrPuwBvskc6OYuDil69UQ9ZFs4HfofhBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R/4hW4Kp9/UqGCxMx4BhWsmYzZ5yKSFWWRpACx1RiU=;
 b=jaTEBHbfyehZaEHHYvASDtJyYBu6+fquxOCF1W5fy4tAD/0pv7pH27E+oNtdqSLvyb1KVwF417R6nHa6Zg3VyEmQC9qG2bQT7AetDRWE/tyT5u0lqLDVwuEsdXZ4OzsucjtNkkr+1eHkGpvzK8rvqelyv+6ZeAtBI5hLO8WJmT0wAdnxU/ZQcwZ3ZpvUS64Akx2F5o1cEwLm1WnteYxzLTiGLmVJMQgm1Gxb9a1JgQ1/hleGz4l73/vdVt7J0S1StidIyScMnEvcMjPC0/4gWA77gZZcWPVrwAnnKwkx2uwvs8J1UhlnQSWTzsArJ/qRONgU/0sgZFlXu81WpW+J3g==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB4079.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:23:02 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:23:02 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 1/2] dt-bindings: iio: imu: add icm42686 inside inv_icm42600
Date: Mon, 22 Apr 2024 15:22:39 +0000
Message-Id: <20240422152240.85974-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422152240.85974-1-inv.git-commit@tdk.com>
References: <20240422152240.85974-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b203159-f8c4-45df-ca4d-08dc62e019be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?B3BhEJF5Mu+mxi/Dup/Qe3YR6kPfjkx591KVz8PKWisO6Q293oZj4ttuFCBX?=
 =?us-ascii?Q?GLbjkXZemx24roJ+6+0E6Fw3ujM9nluagLaZL0aOhP+HKGxpV/dRYMR9t1VU?=
 =?us-ascii?Q?C55bYYOu1jOM6SScn9n7Beq9rhGxpCqI9P4aG+b5UhA9PYRtGYZkxhXNnl0K?=
 =?us-ascii?Q?cC4Y2Knv69AjvySsNh/4LFRNQcuO/avI5AZM4I9yMzH589EyFlFAhibzXr4F?=
 =?us-ascii?Q?G78pCtrJ6FoY1TzfrxhIjaiFD2NRyUEMmNVbqmkdA480w+Vsxm7vN22eUxJw?=
 =?us-ascii?Q?MD/JJ2r/sb86K1mANFpvTrCfkB7Zdlf0ksd/TF2f7GW94BZqBtjFsIMx5WfI?=
 =?us-ascii?Q?tzV39Fu5kO0rZ0ZgC1Zp7DZbvnW4Ru6cn6wEh+Vlu7QJ1EG2fpjnTAVcv89R?=
 =?us-ascii?Q?Vd+AMT7GLfMbzbQGgnAiMVd04W/ipg505ilPQ5FBnXNFDZiZcwXgq2OcF/Wy?=
 =?us-ascii?Q?9MRNppcYNh1q8lJQDxWET00JwrOrYBg7AtUpg0oCF1PqRPySsXMTsuoyu/KJ?=
 =?us-ascii?Q?2c3xgGy2hl1kXOLkjtZVg1eQUOnCIH8qkjdyI9sLwqWh/P1tYhiig/ya19bZ?=
 =?us-ascii?Q?YhzBurmKyqV1JPkSBZUMRiedSVN0rHBWVrIFIMwQuG08RTb48Bfu0V6zCq5p?=
 =?us-ascii?Q?Y6PjXIReRQ/DfeTuMez0R97SOwpTB/by6Sfzqx8oHT7q2ffCUOKThviPoiMZ?=
 =?us-ascii?Q?PKR/CDJMJkHUDHB0sXDMS944boprnWNQ5syVraAyAXqI02j/KpStLiC11/pD?=
 =?us-ascii?Q?QyPBLrRSLg8E8xBoz5ZuKeMhbRIRKuddzx0r+BK9uz7JgaIWVpYN39ftLPhq?=
 =?us-ascii?Q?7EPBhATUbnNv/bEPRBaOYxXCJMWuTCOvVJAKY+ACHvuSzxfwpZ64dBkoE0hz?=
 =?us-ascii?Q?T0wi2m2Qum9Lh7K9ilZia9/Ic74z8yPah2dcO/TZ1dW2V8e48CjAsCQUZ2vP?=
 =?us-ascii?Q?MzvU7oI0xsabb3OChLta3wp0QhVf/dqiS8Ok6jP2hx8CEyqZKuzn8cDMNHIr?=
 =?us-ascii?Q?lC76do4zaPL37+cq087qUS0nle2YnYMn+Px6gNZryYAVc6AtupJC+Qdi60So?=
 =?us-ascii?Q?fS/uCMLAxnxGxBOMK9sY3SkYoQWLcyTe/EYhSchRCsvphp8n0IqXipCjHaIf?=
 =?us-ascii?Q?OdSMFO/CE91bVqArI+8yre6jx+JkUoAE4d6X8/3KhdcM6FK2aJMo7mNdJAYb?=
 =?us-ascii?Q?eWrOe7G4C94ZOhEctdWhrb2bSm0g9QFkRJoZBorCQlxz0/zs8Gz7A5Fz7r4x?=
 =?us-ascii?Q?y7tPeRxBexXYT/Wqt3UPK1zgb5jL/JZfiw7eZVOs/Pzkhk9ky25oDme4a3fi?=
 =?us-ascii?Q?m8BqMDaJ9SdJYhGA1JykpvYI+hunp8vzQTqCmqEHQV3+nIlaiqvOzGA74XZ8?=
 =?us-ascii?Q?Q4vlNKw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?55sXkAA2FYMN27kMoNvEEl9/bI/hWvBhOx4H44qU1lAQNef9mb+cgtJl1b7O?=
 =?us-ascii?Q?u76oFExoPI3hdc8h/CgtyqTc3iUcHrTvnsxEeVnN5f1w2PhNEPOFHd1ztvJJ?=
 =?us-ascii?Q?rWXcYhqyuCvM/3EwiRSPIj1GQD69Q+sP6rH8akSu8tDFoHO5iLq0RBU4BVZy?=
 =?us-ascii?Q?OOdCVLcSjuL3wePJhoyCfsKttCmmugbY0u0cnJmH+HEzdM9OpI7+bhWFP9Ty?=
 =?us-ascii?Q?i6HkJABbUxde+UbUOZlWxHe2uL5MrSBwS+/12yhSF6foPx0Y5p76ykpFh/9p?=
 =?us-ascii?Q?LKwcPUabwQFf7s6TECVdmFSEyB6nOPAEtS3fK9RVSrQKyxJDLKii2XTyazER?=
 =?us-ascii?Q?qZhzTVzw5NmElLj97Bch/5n1dzqj8kJaRJpe/2uluNtYrAsox7X/LxscD7pL?=
 =?us-ascii?Q?IO8wyyxfg7EfERMWqzJEJBdHcg5sEeaKVyjlGMElrZ9TqDJRUqz2iYcEjEy7?=
 =?us-ascii?Q?l5KrmRLwmFvvc+YQF5rCjG1JuhvotNClcJGL6S7aR6rXsZldn5WUiwhUy1L1?=
 =?us-ascii?Q?OU8QRz4YmM+Gc2CoSZ7le/4w9F96Etp/iiwUus/bfTl9urLu0gz6kmlp/UOW?=
 =?us-ascii?Q?81GxazCMqQ003gy1Nv1AmLbeUsjyPoAf6JwEhPRJm+EmyyK5x1OkJIoYj4tW?=
 =?us-ascii?Q?AJZdWDQ85Cn+JIApATiSkF8BbLYFXbbtkvYPGzYMJpQQ5Att+aN09uPCiS6t?=
 =?us-ascii?Q?ibXaWT7CXll/gHRrkzeiSori1zqtFxgY0uZ9pyK4QP9L8J+Ibd4hO0yKTWLT?=
 =?us-ascii?Q?ekriu0/n+V5VyAllVZ/toRPqmfDjR1Y6u0WbgSGTWCVJUJyHRHcbtNt2N5DT?=
 =?us-ascii?Q?6FaX2n5dHd90oSN/nw/05CoUAmURe1k07bAhIfdS0MMgjkhLq14a1s0I5BtI?=
 =?us-ascii?Q?/xE/VNUnMa4C5br6p9ZK+OH250t1sEFrkwh1uwPktlvEjZQYhjLVrRz4BmeK?=
 =?us-ascii?Q?udQEQvRzxLJDXwyx+dKFwkT0zXnUEEvljjHK8ycrfygGDlTgwV17eDufwhkf?=
 =?us-ascii?Q?+6CDsiElvKhmm+Pu7f2GVjejCSy2oBRLGM7gvEMAeOUUZnfT5ygcAyfneEV6?=
 =?us-ascii?Q?7FM5qzaH1bcSEzA0X2QRaTGxvOr9ceUw2NWOo/T5vFs+0RkxklLv/+CAB90a?=
 =?us-ascii?Q?SX+8XctqpQ1X63IxGLzn0lNT/ZxjGJZg+QeYlo3AIPIFi4NPsaZvXYBc0Q8n?=
 =?us-ascii?Q?3O0ePfokO+1xgzuQfI7Nq66ThJrJpbmgmhQWkq2O3SXrPHjxRopGErntnvju?=
 =?us-ascii?Q?7qa8Qu4hs3wYlKrbZMEpqTSL9Fi+XwpBj3WZBYJ+laJGdvFxsUAbJdTHP7mf?=
 =?us-ascii?Q?848Lmmg+CIiBL6PZ8vmhQChbBBvdttuqunj3ukI36uJoVagA9LgydkSszpgA?=
 =?us-ascii?Q?6X9M5WNELTBrmptJ5+F3683/Rme9EMC9J0wpLqS9lWmAmlzNZczSdjqCiMI2?=
 =?us-ascii?Q?Ybs32gxVk+pGrQlx0/GWN45QPXV9b9eGPQHr3wDb94DmrPKQEcdbP/qHOGMI?=
 =?us-ascii?Q?/4PCVhLTeY9dIjb/q8r8a7oBKcMTItL5a4svlVb7/ji6wk+a0YMfKy/wj0Lu?=
 =?us-ascii?Q?eti/WJdaSVdAbcWiGJiJCWtmSoEV0lELl+VDS/o/?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b203159-f8c4-45df-ca4d-08dc62e019be
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:23:02.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lpGBcnsuLFl5SxAWJCyyp+nM2ENv+BdbRGBMjgBPGBGRjiqZpYaKzs8fpS/Wpa3UiAzQfpa2VkbgR0BcNW9kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4079
X-Proofpoint-GUID: 2iTr5BAgI_BhlSNrUHXvJV6kk3kS6w9x
X-Proofpoint-ORIG-GUID: 2iTr5BAgI_BhlSNrUHXvJV6kk3kS6w9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220066

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add bindings for ICM-42686-P chip supporting high FSRs.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 5e0bed2c45de..3769f8e8e98c 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -32,6 +32,7 @@ properties:
       - invensense,icm42605
       - invensense,icm42622
       - invensense,icm42631
+      - invensense,icm42686
       - invensense,icm42688
 
   reg:
-- 
2.34.1


