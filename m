Return-Path: <linux-iio+bounces-9668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AECE97D63B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FFF1F24BA2
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0017A583;
	Fri, 20 Sep 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="bivuE3S7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665217839C;
	Fri, 20 Sep 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839413; cv=fail; b=puJtXuVCuXwtp1JRpdP4eUqz7q1WW4o7O0hpAA4HhIOKMM8tRwjEGub4rDxiadpUodTAB2njcXeRWAhg/bE3sHtTB1GuEBOtiP4/ILFniIj1HL9ElPrrL47Rm6O6RWsnZse/B52AR+SR+Eh+20Put4yn7n6g6xGdG7LuuAkxoUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839413; c=relaxed/simple;
	bh=+0FiaeFee+RAgY8QAXL92AVcGBseHrHO8TQDNL/+ShU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLMisn9D1oAzQeEKIAiH4DvxKQNh/PqimLDS8ANfaHp0bbCW9VyGJLawvSEHPONJ8/W90rkVKoztUHfzwprp5K4l96ik625OQDsbZfciWp8AxeHNqn6aozrfir0YnpDFoxnqas4xbfz4uvXFUtvYuSvmKhqq1dwQ5gsHv7h1izE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=bivuE3S7; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JMQRsn019950;
	Fri, 20 Sep 2024 13:36:38 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011024.outbound.protection.outlook.com [40.93.73.24])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89v1cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 13:36:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqG1C+CCpXPXzbIPQjmN5UCqMX/WpKHa+JB1FJFhWC+EnasJ/cdbcHD79XkD/eAtDfOLZKw/kSVH+1XV6PF1zJ8ALq6LfWWfnwE874CdX4OCiwd8FvSxaWJEDUvBg3wtMIZ6zIzq0uqYhNXD9SbaubVRhuPSkloC4jltw1rV5QurMmI/dKznxdG+F1Y446OMRUwCuqcgBec1/D4kk4fUvdfOeBidqa5NNwWJdJKO/IoTCYhcWrKYYuf6X7k1DNNEKUUXU7eZUkxnsI3z9Xey7egQSaDOE+rCywNuXB4ZFsMA/ZSgSc2VFcA45mtBK3C3RGMemViXP+HqmaWNzk/BsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCCVlqCmKS20FaZW2s3SpLr9LN838VsxgGFd4RrX0Ww=;
 b=Y0ns/DcFsS2ufBxIT/u8rUUZkSaX6OqiJUve4SWUGp7hrODMktKEd+l3RHilBdKYZ3K1J+HINViA+CZiqpNmnEGlw7sPiOJ3yXtgrjPu/4dPzwU6BFFeBiBMs2Xg8dc2ROG2DNQ6S1ZeKKuRjMRgX69UYt/SFqtP+h+vHEVEFM+rBKKaWT5kXUawKsyN7OZPt7VMCr56QQ3WYrPJD0p8S5jAnxVnrY5IPTcrnGQu8MxvGCo7R57EPLct8dwjK15Mis5TXuJVF8UxDwmbE43NiHx2OZXNq8gC5sWwE7Abvu7L7yznntx41+8ATOjR/aIrxpHTGYaHtv5Zebn1chZANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCCVlqCmKS20FaZW2s3SpLr9LN838VsxgGFd4RrX0Ww=;
 b=bivuE3S7pHOKIiAF9il2aF3nn58nJ32F5DpOxpzENwjaOz53BJt2crOmL7j7t2K1R7P23Id8BBE614cdX/ArkHQC+kgpSwP9XCHtorkxRdKABMlnfS1fCJxB/xhjMVNA5K98yorWJD02wv6qWe+EePDrHTVr5SuMpFLAt+s3mYfoIKpV8BlD33lFnKz3v7QrYBxWYVqvbKNIbYzm0NsMSWY9L9pyYN6agjMec0mTwBTzwr7GDEaOrlPz275VplHZTTJ+it5DuZLMLp83hh2dmmC1wosndcO3GBN8RBw30am1sEHciluCBeWF31aSAHcVKl38xrR2GPuhj6gsoSqBXA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS9P286MB5256.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:310::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:36:35 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:36:35 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
Date: Fri, 20 Sep 2024 13:36:14 +0000
Message-Id: <20240920133615.167726-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920133615.167726-1-inv.git-commit@tdk.com>
References: <20240920133615.167726-1-inv.git-commit@tdk.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3c2b119-61cb-4160-17e3-08dcd9793ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09zQIDC9rFZ/usgRQcQ9/d06JaraHImlcYwfI8baHWTbvBWrm1mnhP5KWv9L?=
 =?us-ascii?Q?vlTUFScwyJfXMvwVMk37EMB7mcHlXDN28WuNsI1aB8nsr1kxxHlltw4Zl8am?=
 =?us-ascii?Q?uah42N0iSJh4NQVRZ3vdkeu4VaCfDdl0n1G01JoHpSTcKHPzsTGg9Ngg3+D9?=
 =?us-ascii?Q?pWe+jV1u58NwJg7CsL7TP+VaJmhqblEX0dy6JrBLZ9TUuURIAEq3rx8CejEg?=
 =?us-ascii?Q?b/FAi8GxuBuUK9nKGwyvILtdaEThVc9B10MVaWEK3q7EQX6C1zv6WAW5HcT9?=
 =?us-ascii?Q?tmNKVlMKuE31FhNHOmA/lGgkH2mMhzZLbeab9BZl7/fEGam4OcRPiMIKaJ67?=
 =?us-ascii?Q?Sy0ZzAqigBJZVRwdstXKhuHq72QUzs+YWgK/XuvPZoAVMlX/wkoV0VczbnRw?=
 =?us-ascii?Q?DIc7ReUPCALyC6xB6hS4hQEjriwk8nsdiyQdKjIfPizpbhOARlPqNjlhRP20?=
 =?us-ascii?Q?eeA/1qgPNkutL10HHO78XQzPs/dZQMZ5gAx+1uMlGY/mzRkD91uDcYSJK4oI?=
 =?us-ascii?Q?m6oNavGmhyf/gtnd948wWOtcdOjAdBwhAjTDiwvwnkOkrvsHyN2MWDoM8sCq?=
 =?us-ascii?Q?DrrPQGv9fvPf0kIuqtGALHtxM48vWU+FRne3q6kJ38Z7K+SUKnJQkmUqgQI0?=
 =?us-ascii?Q?ts7UQfi5oGK4qHwzSvnWVnacZJh/7telHhWz53YXsCPTL0H8IWH2ViLSz1OU?=
 =?us-ascii?Q?GJywlZ4REgKQsYgtcAhy3fjwHi3kY6Lauok667xe3czaHl6AoqQXAlH23jU4?=
 =?us-ascii?Q?oFmIl8Y0xzuuWueZ1tvCbtzUAYC9O2F5sK1/qlEfgrKMTSwkCYCmUf2Uz/AF?=
 =?us-ascii?Q?X0d+/3pG3TTmANEHCyhEle6CHHMyOSLieLJ/gLr3WK2iRbPhyimLwIL7yjqn?=
 =?us-ascii?Q?K0yzbG/z+2sjXoquFtvIhs7mcugI1iPGXAXWI8//u99/rUZ/yh8Fdg4Jfv4V?=
 =?us-ascii?Q?H+TQzJvU2SU9Fn+qOtxXb3ZkCCDcGpPG8wy0MG7NeMNVdE5lR3Jl6v0d3mFe?=
 =?us-ascii?Q?Iqmj1BUsU29gtbFzQIrWLuMA9G+DL34XHw01Gm6AszuXSxHDH8nErV1jcXOI?=
 =?us-ascii?Q?lGXlsC0cet/3HrK3xPBj7GPZ7CWaWqJFmt26BzMQjHFcvWxyXfC4DQ/R4AtR?=
 =?us-ascii?Q?F8+K52DYN85HWipcl6/tEaMxpt4wpZTcTQzoXDL6ZmCazflkxpyR5+J+PWO7?=
 =?us-ascii?Q?WS8qdDUh5d57eMw/xJH7+lUuziTr8kXkCfAo7NNcvRMt6q1nhhmNbIY7gvSL?=
 =?us-ascii?Q?iSPSYmzP+paDwMvt58c0FWDxZDBeZMm7r/fnISJ/RKPQfGdxaCWdsx40Sq86?=
 =?us-ascii?Q?j2Rz3+LJ1C+3U0OG/QX1S/yH5PVW1EQIMPndL7s6UWhQZJu5AyRVqT8Nf4SM?=
 =?us-ascii?Q?+iUNbuQgJHKUBgDAhLKM68ewVhsk+cNNRzOqVg6NIhW7aNmfcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wL5oxqJnYrrTcSj/E1IpW3mLdaDN21ZNeANFEjKet7sHyqJxkngMcL3HKeJp?=
 =?us-ascii?Q?A0ogxzjF1rvRliatRqK3WDqytzRDAlouPMO5mL4a3ES/oSLmN84izjJhl7Id?=
 =?us-ascii?Q?XBgbeBqRdWaxCV3bj3RIeEaCEelJzQ/pQ1YoIjxz0Bs87ZTV8X4TIVChNjoI?=
 =?us-ascii?Q?PHQoWRa7nUYp15yog0iPlKiLZuSiF59onR2Go1QtuVYflVzmuTHFtJ6/rw5m?=
 =?us-ascii?Q?gE1Evl8ldzB0L+EVy0XfDAfgSUQkrhnNucXrk1wOxWQ0ye4W/1yTdK98tFQA?=
 =?us-ascii?Q?RssaVKHTvCNxXo+JfFt/BbLO4NbcluLISQ7w7JUfHmtlTHFjGtxsMT5TVK0w?=
 =?us-ascii?Q?5RaBEcs6TfuK9jNv7t3JYK63WJOAc9xqpfwI5ViH7kOMD1aWk/ZvYnjQXtk0?=
 =?us-ascii?Q?PjaZnr8orlUxa0sgkdirxbo5jWJiUkoZ1V9WvJegCvt5oYCS86PfecOs5Shd?=
 =?us-ascii?Q?FztT3y09+uFYApuHRfTIq8mIxETqZjLg0qeh2L9kRILp9zZnhja+qTwp3wEi?=
 =?us-ascii?Q?G+kgUOgWoOAL/IHJciwFUQM87oURmcCOdVTIPhHtqNslx4DYqfZ3PsPQiivx?=
 =?us-ascii?Q?GqNzks+iv/SqOCAhxN9R9mP3DDC+Ck2YXzVIJwd/+T4IzOodIoRtKRAOoNk1?=
 =?us-ascii?Q?lcVJM7U8O3gKX6zaK/Bek8b2ivCMxYZgWQkQWzODncyV8sAvdSVJ2lhPGDE4?=
 =?us-ascii?Q?JcI27g7SGcnMsfn17soNDFOJhEPpPS7U+z8FTKK2zWIVLsY2hEX2lz+xSfij?=
 =?us-ascii?Q?/UoioJXvt9XwFrYeCIWZJxuB6oAdApV0+5yrUT4l/iqc/1Qpcex5HemeMuoz?=
 =?us-ascii?Q?C2TcGxxfG2J6KGONKIpQ3MhiUtKMNx87P0Hz8vlXMeHRMK8h4h9/4IeVf1D7?=
 =?us-ascii?Q?lyVSOLx1UIJ/vfvCw6VI2MpMMy8FiCV+W/gYwgsD29p5i4X1s+QoBQPuc0Z/?=
 =?us-ascii?Q?LLXWvROFBAIlFVycdR8/cvSBWNeyZCwaMq0srU6KkHhmImB4B2weIQlm91pN?=
 =?us-ascii?Q?d4MckWnKbh6+kIQ/IpMc8LiwDvtlZXXchhPwrr1rHDZm3r9ku5hZ7HiOHkse?=
 =?us-ascii?Q?trHuR3nq+0MzCl9Rvcknn17gaPYHNeBVIkxF8aPrbc1IG3oQ2on27Z9lsY4L?=
 =?us-ascii?Q?nvMjbccL6hW7d4Fl5fajw3sdcPokSiym63wmdKlyVBHxaOnHPc7EXIV+gkwc?=
 =?us-ascii?Q?Br+nptBlX7b/Fq/lnUfVm57psfjJ6YFYj9NpgaQWTaAZqogFHX8jIoFe/ht9?=
 =?us-ascii?Q?JH3zMAaIyNvxJMkUTpFk5y+5YYmSvsOhAfecr5wxbzkJmh6+CQroaABePyig?=
 =?us-ascii?Q?R4uHPdtZPZPsZWGfb9v69f7pqLutyAFRd/Ks2eF4iXLghXKet8CBxqU7pCp6?=
 =?us-ascii?Q?Y9Bv9+uRUMfK8W9dQR6SCHucQCaom1giL8GzXPs4Tyu8sO7P/sSYi6JS+/rd?=
 =?us-ascii?Q?54O0qlSH/48VWOYFm/AsFSOW5sDrXKUlIdJpv0StHnuPVghmqnlxO6E333Qq?=
 =?us-ascii?Q?cn/UqiIPgtTSbiRZRvBzrxQL8vGkbJ1z0zSsJzm08haTvDHys/zufd52GVcv?=
 =?us-ascii?Q?PpQt4mLTnKOunk5STOZJk9ay+JYYgnOxSf8nY1wu?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c2b119-61cb-4160-17e3-08dcd9793ee1
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:36:35.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fYg78fJgsbOUvOMnDN+s6FzrR1c9UIEKhKgsOV/ZbSRH1mlMhKDu1PciryH5WvIq3+MLpWFbui9XwTfe4cp3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5256
X-Proofpoint-ORIG-GUID: 1lmyxK7QvR3vBKV3xXLqPgzTzzbtApS6
X-Proofpoint-GUID: 1lmyxK7QvR3vBKV3xXLqPgzTzzbtApS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200098

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
They just have better specs, temperature range and a bigger FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 587ff2bced2d..a8d30ef015fa 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -36,6 +36,11 @@ properties:
       - items:
           - const: invensense,icm20608d
           - const: invensense,icm20608
+      - items:
+          - enum:
+              - invensense,iam20680hp
+              - invensense,iam20680ht
+          - const: invensense,iam20680

   reg:
     maxItems: 1
--
2.34.1


