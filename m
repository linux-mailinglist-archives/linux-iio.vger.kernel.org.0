Return-Path: <linux-iio+bounces-5870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5958FD6F0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E521F24CC5
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD41553AA;
	Wed,  5 Jun 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="SbPdOY1v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6F15572D
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617645; cv=fail; b=aABYyBSy2KbnRDmUErHBvOqf2yW0N4AQf+Nw/LDXPqaGI7EfTrBB1yCWE8TSDF0x0gpAMIKhj7TaAtJpLUsDqQezcsgSPL0ywzKvprHjMn5lJQFMquN4e9p2r1W96YQVX4nQaO4B5vmkH4AV4EpWGxKuwZY1IPLSToH6nIFCDdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617645; c=relaxed/simple;
	bh=hRmhGcQwGngclrt4wae4WqCLQbzMz48SKWb7rssJdYo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sSC28eDLHRztlzVT379rTE+OVU7CcZf+SCMXk0ykdZiyUEl4vL1Ke+Txf/DJ/3bQTEFKR1KPepW278U6sG4iOiDjkAWOQAhTBm/W2zx1vz0HWFAoTQOY/04KiM5qrMcUL/hiCLRIx3+98tfyve0jv7lqPc5J0j8DTXbmBLwqPWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=SbPdOY1v; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455Jlvp4007940;
	Wed, 5 Jun 2024 20:00:16 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010002.outbound.protection.outlook.com [40.93.73.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yfw0wk9q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 20:00:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUgpwKr8S+PtG9fzZUzaHnJW9HRBsAY8wxfn0lMyT+m9gePJqxlM/7oC10cSi8CBfOL9zQc4Un6tWWFTEFWQVlNVZQasNlN0pLLt6NpVStK/gjRW8lPmjp6PUr8yaf12pVS5CqWxHP5XwiE6PRqniH10AdS0dPEKGVi4no29y2o2c/4uELOve3cf96weJWz6txNmsaCTqUyIsCO5r06IR2LLK3/rRMyuvFCMe9nPEFFeCf5oxrY+PIjHnlnhWuLJx79BTv6M/hu6MNRU+rTXScRLsa+iL54EVkEMhcB2AxElLD4wE7hRYgxBAzICkBO1EHsdwVxV5xjnPjsXlFSImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWkn71k9MJkwv+sT0m48WE3s0xaxjgfRi9qB8nQR2IU=;
 b=hwLyO9fiI0lzWjGlq2zA/B6a83jmAVgLTW45MdjDI+Omf45dwtgS2QzEHm5FsXNVicmYFvZmOBVNSFJ/NyGlZmM6u6ymHtAARNLC8FefUzBijqktp4J88Ci+/3nZERxzmAlb2+Th2khhv+UjqlRpQBkTxjfELHLKZwanQbOHKPkX82vfbxrx4RapbougXL4V3GdpXCgFvefqdLBgtF1xeH5d/Wre3liwuFBfphv0TyfJw6vZO6WwICmNgRlhdgj3UzDPcWjJyEOy3yciYfw5I12n9BJEdMme7pp1tuDvJEBPmkMpwgywcVQtQ7eu9aMmI7IuFtvN/xzuYCQCsvpI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWkn71k9MJkwv+sT0m48WE3s0xaxjgfRi9qB8nQR2IU=;
 b=SbPdOY1vDNocbI6G7kzK9r+Us2um1dMHbqa2zMYOhjbdiOn/0D/sroJF40Bb69QLb4RXv+hH0VbjdXkwdmb9dZBFdoET+hx95FAFjZDPqzupugoPAxRHAYJ3Ci5ILcdMK9ynE74+kk0zEjQ3YDA1JDex0JWcIc2JgArzpvkzekvhUGTtGnZNiYOp6v7KEEVacfUJOtSuK9ndCo5M2LlP2xouKlxhmdwwE8XPrm+6vG9nb8843379bs3hnEXO48lKqDlvm+Mz0wOlw2ceaEb/uFzWDD1gOIQ6tJ8m/Kn4/OihBrvI/MSyykEbfBx7ZgHiTMRSPnGXItBXwuMfB2nN9w==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB2172.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:173::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 20:00:09 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%3]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 20:00:08 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of accel low power
Date: Wed,  5 Jun 2024 19:59:47 +0000
Message-Id: <20240605195949.766677-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 94ef1332-502a-4cc3-b288-08dc859a19a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|3613699003|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7rVBk9NmpRVx741qOUhUIffPWzR0NOtQyHK78YkYdnoIGMO8N+3uyDp5PEJd?=
 =?us-ascii?Q?R3SbclvHrLVkmGghExKqQ1uPsR61UThT3JQQnqi1Yf6ueT395i24PJJJyF6j?=
 =?us-ascii?Q?DEc83mspraB7643xO7wRRn/iSFpAxd3G2pE42jJi1t7kjPZJCM9DP/x2oN+s?=
 =?us-ascii?Q?L7iAkN9O6Zp7BCLixqyn+JiRYgM9jDKabon7tfL90Wa6RrMnkTbQgX8dZ+zk?=
 =?us-ascii?Q?3ncMSDrjrRrIgjYlB87iHQYSC9/yPm7J3QXCBLXWeVTWgVcc/nRymJe9m5U+?=
 =?us-ascii?Q?pTFPjbykT+516VMuBW2nUJkzjyguwnWeuXZsoSlMUmCtYxvUP7biQ+K1MeGm?=
 =?us-ascii?Q?mDXrLQoWx8Akj+BM2Qk8j3iC2UVtQ/hDpZGZQ5cLC2nHpB7nAbCc5FDtIltN?=
 =?us-ascii?Q?9vgYCHG84xU6NRs+29A53tSEK+n48+oMFETq2igu8c7kKwMKbj0IWBwy83KH?=
 =?us-ascii?Q?D6s5kPlnmPXNq+lI4Gk/d0nvIsMn4BUEsRN7LPNahIDqRU+RyBflCx1BpH80?=
 =?us-ascii?Q?NL0WOOveehKnPgbZJL2UVhUu33Qcxy6Z6o7mwof0I+xVm3LpqIGAYAbCXSHE?=
 =?us-ascii?Q?kEjlJypQ0gjcUoxiGexZMrzGC9e3zY1HFqCEXcYuST5UYVcnthFfjJLaweY1?=
 =?us-ascii?Q?YgHWb0CG+Ueuj9I/wvcjhjEr0gdY/TeRUYSAWUCKeCZT3s+u5VTW1tfIg2ko?=
 =?us-ascii?Q?CnGEg7BHsAjdwsIieBLf/6WGNq2UhjSAAeEKQm7G4VUpCbbJuR63UCV/yB7G?=
 =?us-ascii?Q?rtZ9ZQdjHF0rH2/aTVDH8n1nJOOVl3UizynrmSf7NghYZU1jdcdbxlq1ADQ+?=
 =?us-ascii?Q?K5TQDEUy/WixiJqeC17oeZ801Vq2U8VU4axP31mfqLYWWMrspoNe/6pe2szD?=
 =?us-ascii?Q?qk51Whd4yuE7xo8XjP/Wzq3OhCShD8IoArTcum4CpPL7cEAZDD1/GrJYGezq?=
 =?us-ascii?Q?zSXhbhV9JqiWdOUxTCnX3Nbqwwpma18VZV8H0xctEarDPjOl8GbQvGyXgB4J?=
 =?us-ascii?Q?kjsOJONKJBVe+3J37kH1IBXmU2Suz3VIfeTTuST5CF25UOdYuJpgGtH6zHHl?=
 =?us-ascii?Q?IjO/V5HrDqfRwwl+b6+AC3N5rvbokcYLD5iITS02T/UDjfY+RTtnV5OsVnHc?=
 =?us-ascii?Q?c6LrHYycTowmwBBVewJNqdjIFJN2qwmq4XLjaW5fXxdGaGWOmKpjLxP5KzWP?=
 =?us-ascii?Q?FHI5JW/RwX2wihk2KzA0FRj4I+bjiTFrsz9m4INF7Y5Jby5QBuTnEFRPWPgl?=
 =?us-ascii?Q?HA4jUNe4xdS6Sx5CfEhkIZDFMPbvRSyUSps66Zzd5NL/qvmAqrf4H7EyFTVR?=
 =?us-ascii?Q?F0u4UwF157BX+hXAF5z4ZpkPeb3JJQ11uiGp7wElGll0Dzw0fpdt1FIDUjKi?=
 =?us-ascii?Q?u02ZWN4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gfEdoBPiynpPRWdhv6hs6XclGh/27Ih2gX9SbqS/6yziVvUXCYZSKIOf5IBe?=
 =?us-ascii?Q?km4JNcxzLUQT1cP/Jd44ZECSHkeRLIShzoJNC/QIbPMeAe+rEACOkcSKPNru?=
 =?us-ascii?Q?Q6U4lxf3UTEs7tR2er9fLHcqCGUpUDTQ9lVbyGT+Mk57kywsgd4NvPwE3IdO?=
 =?us-ascii?Q?lXbmMyk2Lz2t1AYbzggDh8wKUQVIFYP5s5UKQDX9Zxtbx1c4zH0M8xi1TUwe?=
 =?us-ascii?Q?01jPYOLS7TuIPA/69Dh6u/0Ll/RFvZyzPFy/ybgK1pK6kFXaSP5Av5vB02Lp?=
 =?us-ascii?Q?Qv4uJqX5OhBpHmxS0EEyJw2J5ZLFKZAs60Wlsft52EJK4Yc5Fvq2HST6FbWY?=
 =?us-ascii?Q?Sp2ZdxeZgYEcH1ZonZ8+PapD5stBlSkid5p8UaLC/3hFz/Dd/ieDMl3Z9kD1?=
 =?us-ascii?Q?AfrUMAE2xsyLBtz8a9QWYaSQ6i25guwQ/4zZWrmdfnG+mzcy08+UDqmSxTek?=
 =?us-ascii?Q?sBD2Z7EDTes/Ukrf6yH8Jkd6p8OdIJ+iRUBpWcRRzdZP+zksU+17RkAiRXxi?=
 =?us-ascii?Q?x31/pnvm2nNvXLiwmrNnEoGHseGxGh/w8lyfgenfCYT8/foGkqI3Erho4Jzm?=
 =?us-ascii?Q?SujXBA0nSONO8IkSXdtEsPtRKXhpgSJNe0anJklUX04kY4ZaYn4fyRJD4iZX?=
 =?us-ascii?Q?PGCbRnE0EXx+gL83OOCiGi5JaSK6BXVfer5W3DBX8P01De70K/LDBUn/mcx5?=
 =?us-ascii?Q?TFJrnRgKuUZZm6IN5yBS33XRZlm+wOmctttfS5VGoW2sj6dUdkB0te7xTlbq?=
 =?us-ascii?Q?dWfypIdnzM4AIRgm8ZeRo0ZnbSVwZCvWhX0hzf3abOi460yRz/RuK0aTPcib?=
 =?us-ascii?Q?4SY1qWEArWdUe9/tk1x6+hsfsOEcYZ1ZID3AhI3JBdDT559kBPDTrWL1UaGX?=
 =?us-ascii?Q?CIN0MupFwUPgcheZmrmgfncjX2L/M89tgFMx6cif1dzJT8DREKsOspG1QGcE?=
 =?us-ascii?Q?onYmIgB9KdZ42KQwOS5gDYKpMH3DI9yOVt84nYrabDb3E8HnzJfEqway007x?=
 =?us-ascii?Q?8wKpaJaEv0Mg61T1WsyL4v546KeWCw2kk2S1aFUnuE84+r7H7kDosIAMC+dZ?=
 =?us-ascii?Q?0s/5gHVA/wC/7BJeir9+QN3prdcE80bDRrkV46tqaRIfddmeUQXgu0WDyeGG?=
 =?us-ascii?Q?CmMinOwREO3Xfhd0hBzXsEAfpgjh0zgNy4oFGoqy8h2Bqe1+m20Kzt/FxnhM?=
 =?us-ascii?Q?ycxQBQrDcRAfiVSOYdAxNLgJzW7ACEWXuHvH2HqDgbrbXD/CbXXIKdN8QMOx?=
 =?us-ascii?Q?Bxuz36HC/q75YKb/SW+KQ8XfkUNn6ljhXZYFCyNXftgjHmXYCkRHzDLPIWmT?=
 =?us-ascii?Q?Z3+z4u7O9zq92xe2pDOxzvHO9ucQfAP0t+5Ks+xkCd/c2W4TOTmUwWbfJEH2?=
 =?us-ascii?Q?Tev/A60ZN90zPkoNlJslTTW1x4E/sEMa6AFTHir2kWrIO294wX4FIR8y1Zjz?=
 =?us-ascii?Q?Ywnm5/cjAjGzL3kUbPCQCrWH9AvtP56eEo1mrjok6BtKJRsYJ2QmTnSX/FbT?=
 =?us-ascii?Q?b6n+NeY4NpWqdZg+1oBeJdO5DxoCia7UYT6HfUiEtgAznvFK9OIz4jg0a0xf?=
 =?us-ascii?Q?OH/IEJWu7EjE9vdQO7dl3sY8LHCjzWnf7zfliKuQ?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef1332-502a-4cc3-b288-08dc859a19a6
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:00:08.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FC8/JmYwDUpFBrri4VIzwFUKQLUl1D9sWudO4SlPFwF+D1merHOeuNqfriartgVwU18Gp5r+ZY853QuRnIhGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2172
X-Proofpoint-ORIG-GUID: 3_qDej-UjOD1HiZnVYz4C3N6JNLwSwnY
X-Proofpoint-GUID: 3_qDej-UjOD1HiZnVYz4C3N6JNLwSwnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050151

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add accel low power support, enabling use of lower ODR below 12.5Hz.

Add new sysfs API for controlling the power mode and enforce power mode used
when using an ODR that supports only 1 mode (ODR < 12.5Hz or ODR > 500Hz).

Changelog

V2:
- fix patch missing Signed-off tag

V3:
- make all ODRs available and switch power mode automatically for ODR supporting
  only 1 mode.
 
V4:
- prevent power mode setting when the ODR is not supported
- return the actual power mode when sensor is on, otherwise the requested one.
- add sysfs ABI documentation

Jean-Baptiste Maneyrol (1):
  iio: imu: inv_icm42600: add support of accel low-power mode

 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 124 +++++++++++++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  27 ++++
 3 files changed, 151 insertions(+), 4 deletions(-)

-- 
2.34.1


