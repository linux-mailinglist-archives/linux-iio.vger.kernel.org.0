Return-Path: <linux-iio+bounces-4153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6F89BCEC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0DE1C21527
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717F52F83;
	Mon,  8 Apr 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="YG0GAHF0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881B52F82;
	Mon,  8 Apr 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571659; cv=fail; b=Kr0igDt+kws3GyZgjFvww820ONkKsfmd2p+tWZGzBsJy/yO/kA7CYXMK9mQ+dAQC0LIas127U8p6J9/qzuZLJsqH38C7Pr0IENI0ixgTY/BLgGD7Jhttg7BSzHfNhOC5cNKjw4wl8YRKSpbx2O53C5R1bVzNsu3enqkoFeH037w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571659; c=relaxed/simple;
	bh=sRXpyZb/+vkpgwmHjTfpPSkG5j/2pwGwAugReyXEvX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gILN2r8uRlpowWbPpchSZ7iR0AALaHEdyTNkMXVzEkPZGW69ym1Mf+cGhRTNuOCxEDk9vFQjWFam3SgxeyQpYn+a4a2Gsm4sPTX67CgHfS5LZfqwx039D/IWzUHGc4Fi9vDG/axgUtRMKiroDq00RNgXZt+mZA4rAtjz4ILChXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=YG0GAHF0; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 437NHFda005047;
	Mon, 8 Apr 2024 09:07:42 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010002.outbound.protection.outlook.com [40.93.73.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xavryh6a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:07:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OodsPvXJVEIi60mUxGBqEYY6auEOO+cOSyacmsemtrzlILTIKeHRRv8mdSbsBthG/VifAwwp0OQ29xTJ//UzBbgosXjKPQBPOd0k4kPrcPY73GMZWt6lgcSwyJLrvIsb24AvFYcYpUtnNAaSWB/VRALQmvxkEBy0lMFx6SP3J/j3jtgz4lM6NE/RByHMUEtREyBt9z9Y/1cYFOZU7d4w9SqpmAD5ri7Sp6pz8ZW107Na2Q99uLtwCskK02TSbz3gqauaVVfZJzIrFeco0IUoTYIyqx7FCmXbjDyCMyG5Iqlq2akL9Jk0NrKaWS2q3KTwYQKzk/hzFh/kneE9T/BmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+SFB+JktnX98OdFnclo14PD+vI3aBqAi9ZBbDi1I5c=;
 b=CJQNTxQnuf0gDeLhU1Sj+9NiDe5KA1lCGNYu80NkGOmTxpep/elYGo3m26JgfX59y6cw3ffk/tLXTFVPof/BDhwciggyNZcbu7b4P82fSYli78aS2Y/ZTImxo5h78rIZD8Q/ZICl9hi0t8SC7I4SabXoRQDtcl2lGB75CuaQ9n9LBShQdQO42dZbbyrZhmKeajqvJdczhrdjdhE4OrJaFdPkV8SYlgiseWAOxBjrBb2iHVjRmLVJ3Dzj4MmMhpEaC4ZinoSuFSpebIwxxwzeldtEGFRcFtbY+U4lBZXCyv4xQSJYkEQIJ9vXGHmOKHLL/GCDxeY1lrn9ifqYn+HEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+SFB+JktnX98OdFnclo14PD+vI3aBqAi9ZBbDi1I5c=;
 b=YG0GAHF0IXZPO5xFuNrMtOuynXTYKB1pSicyaaOWLCNhb4ztpTWWQE7HLc7BVbUKxW3W/mwZV/Y6gLhb4pk9aqCQfwAmgkKiFUEeIMXZ98FmoMUW2T/O2X2HgzF7I6GXniEJzr1mMFCOJmGyMYqxpJQj79FNSdNzb7AXt4lC/+/ODIfbpfnvdggjeLU+SDekAQbSFqjIX45jh1LCOmtvmxET1g0MmzcUI+hkZDPE1n+857L2hLgRO/hUxB9gbkAC2C+wZkbSliie7SypLDqZRHrdBLbfLsL2kO6P7VmQQNwyRrjkTtrwHhuCeVpcKixVTMhGw/+U4IvGlvBBAszk9w==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3342.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 09:07:39 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 09:07:39 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: add icm42688 inside inv_icm42600
Date: Mon,  8 Apr 2024 09:07:19 +0000
Message-Id: <20240408090720.847107-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408090720.847107-1-inv.git-commit@tdk.com>
References: <20240408090720.847107-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TSIdCHJB1BtQau6yMb8mNJkSLZdpgiIZf7Mkn9dbPai0Ugb9cFz5FLuVc10sKRvN9ygmSEHKC4LRIFphWZ6dM40bSXwXxirspen47bFq+sBrbt9wiNH8itaxItj4mg4385JrHBjuyr7/2rQH2/F35E49KnKUArQIMrMRABkzYrduE0oxKS1/N+J+Xz0td8N9+AHm0Vk7mh1khUepT6/wlrv4MrOyNib86hNcriVmD0+yvzSgIVj96onOp2ZjZawQIoFdybQgzos6yLWqHbR+8wkwkYoMyyGtKOtuQM1/K/8XcyGGFq4u8OOnhDMJpkaO/woC7sEMx/tR6X+bHPfCe08LJux+aw//w8Q8iljwBIHcsoLp670Akxa0/EBotEi5yC+M+X1ghJAc0fLrxuxwWKK5FsykVbsS4ruRthVtMWuWWN/SrDb9yiq0FQBtbArxZ1M26Hs6KzPmTX6GsB6rcik3e4Lmd9A1ESy/57OEuZuERFGDxCgEgSctSDb27I2MCKHUugMpLFy5e4vHZDXcH0wiaZSeQVAIo13SNFRhJcgpCUxJDgZ/WxN9HszzISAExuoS9Bu8YILgpolb+DMpf8Jj/aULVne8KC3T/ol+XKHWbfpXvTf6F5UNl25DEPFyLpLwZmdZCyPHNWBneaoV9UjZvOMGIse3F4kwlzoyV1c1hhFLo9qxzbzoJBpO4hGR1YCAlWj+3uZQp2p0FMe0A644uOwUyCPt50fHC/eFqO5Ds9RBeHesz5HldUfWUprG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EZAI+aaAqP870dVxHUtVyphh10YRZZMWULXsZ2z3d7+OhrhMJCt0KABysvGk?=
 =?us-ascii?Q?AcmVvpstJPNPnxvu9NHKMTqVGtjybVJM0QrNQhtBXncAP5KPZntGpZZFsFnC?=
 =?us-ascii?Q?IkgxBwBj1M7ea8TZcL3PVwJRB6HMBS1qxHvtSta0eTsaNEHvJhsxLVa7QvR7?=
 =?us-ascii?Q?/6MrynMOynK+MbEn3SLnVaeS4YVqwRnKjQvJnFTTtvq0oBeei3EZloqjrASI?=
 =?us-ascii?Q?tc5xSqYMyVSQs3EPcZqwU3ie+O7bAWrHN/hYrjzB/4Vo6qA75ILM2f0342Oh?=
 =?us-ascii?Q?ZTSq1bMVkLiYnJAl53ZlUnZ6RrO6w1XhdURAOHkBrIF3Wxv7N0KDzTuDZ477?=
 =?us-ascii?Q?J+io4rRtI6/ozws0Fp0FqmWBVKyGZvHD4Wthfd/nY9E8SbZP/Z/CaFHBd4Wu?=
 =?us-ascii?Q?kSu25XgjkISeDT7Scas70WDJSUSKwAO7MdLS/0wIKBl2/qraxT4vlNHmrSXv?=
 =?us-ascii?Q?dRfgPne1qMGNuW98fd/mdJTqUraQO1uoygyI8u61msVniIR/nwMyLWiMSUFy?=
 =?us-ascii?Q?7ErMRs9lDNj/LpLNCoKw87xvUiCNV12qSBfZpqA02J+yE9n3lxCti8dt5229?=
 =?us-ascii?Q?Cr+v9fNgGa8ljBXbnzYYDgHtvkGS2tOXJ7rUlcZOvUMcomC1qBTKgUQ3vdIm?=
 =?us-ascii?Q?1gHANQsKNx3NwCl+DJAWnXCZXGJmMf9RguiVx3C6YHPJX/tYyYgfGJKRNmGE?=
 =?us-ascii?Q?H4DaBxx9HVPOpiW1/Jk/U86HAIgMLeH9sx+Ywq/l2M5/LzLyHpcATGm94aqC?=
 =?us-ascii?Q?DKgfApaeCVAC0C/rWs4cTnsHF/7TZfqAJr96iSioZBmgJ2JuGQHbzg1sTL8v?=
 =?us-ascii?Q?8NjJRjWtZz+a3V2NYhvy9qU0i3wj58tLo9ZDHZ0c80r7E0hO4I0NG3gyHZxq?=
 =?us-ascii?Q?wWFhbqucTDEABPf4VOex9mO0KwHV3qZMRdOS6781z4YK4nQYCSBSEVQH52Mw?=
 =?us-ascii?Q?CHcURICmrLO3mlpYDuqGQBF5ryco3tnHAx0CK6D+C1CMehYuCvUljEU5nuTM?=
 =?us-ascii?Q?PDwjAKduWlRXR70B1o3qpfCtwYdgMuiCbrbCrt+ZsxO9CWNECOosgEUqJ5MM?=
 =?us-ascii?Q?1gm+WziP5kNqeXerhOYFGSzBBDJbZy/TY+wPnEZ5okOq0XN5NynmeJForKHL?=
 =?us-ascii?Q?XFFfEfdsMMfs38Itt2gZvT34th/ob1ylArwkE2Gg64ZFLbgMTfY4Ll8FMklO?=
 =?us-ascii?Q?Bu4Nch8sHDlZDyEMEe5ekOu6agghb5Ve0wXsevnAp2haZnrL+buWNnIMJ/3C?=
 =?us-ascii?Q?xa+R9JGgMslyeh+xo/gRMpo+E2iEuWMzNCzfgPtE5Y7fSshVW1rCkplKljPl?=
 =?us-ascii?Q?/8lFAi2cKC43sOATjoVANRCM2gv7H5pkJVCL6LbHpkTj1X+IAxe3yNewnQuQ?=
 =?us-ascii?Q?UuhQmhGnA69+WQjsZhhlD8LAjpMzo0DLgHafoReEDqYrH9cQsYTa0b6BffaV?=
 =?us-ascii?Q?pRi/c2t2GykNoaXBnS+gL0H7+VcD3kNOQJ4xq1eDg+f/ore/Bn2OQj+e7rCp?=
 =?us-ascii?Q?4fLwU9vuPf23rvg34cC9he2wtPDl25obdFrYvzWNcKsBq1Nt3MK0v5Wcq5rb?=
 =?us-ascii?Q?fIL1VAwL8cP9R+1Hnhw+DBZ1ibqzyHUXX4end/qZ?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ca8178-2e08-4c55-8ae7-08dc57ab56c6
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:07:39.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7eqOEPW7Lq1/FP0ixWs95UHVQZ2S8dNfT1QKKC1Kkm5M2gm3tiP/ZepKGKVfsm3ggm6GO2pz/lR6K7ZK9SfWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3342
X-Proofpoint-GUID: FbDdRQV_sWhN9OXyxb-jBrkMNLpw_LHM
X-Proofpoint-ORIG-GUID: FbDdRQV_sWhN9OXyxb-jBrkMNLpw_LHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080070

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add bindings for ICM-42688-P chip.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 7cd05bcbee31..5e0bed2c45de 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -32,6 +32,7 @@ properties:
       - invensense,icm42605
       - invensense,icm42622
       - invensense,icm42631
+      - invensense,icm42688

   reg:
     maxItems: 1
--
2.34.1


