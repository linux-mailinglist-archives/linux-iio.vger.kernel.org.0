Return-Path: <linux-iio+bounces-3385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD2876713
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44CAB213D4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9891DFC5;
	Fri,  8 Mar 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="GDObxaUK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49A1D54D
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910691; cv=fail; b=gPKSutZMRK27SF0AN2KJgd3KMLrEFh77/kC1rlJHfgCo3pjM4oEeGSONCs37SfheYC+YgLMHsIBEsTfnQd0GroODDyif4n7KM1nNrEIZeRoN6sWrtYIR240eV9kEkKDQ93609+Ms1GvXwBy/yYLsl9H9eCb6GiAhUigXJIGqz5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910691; c=relaxed/simple;
	bh=2E3FK8MSgoRmvoufRurz5pgMZvDdeY5yCV94vkIP5F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXqnKzRZDgahPc5Jtcs/ioZtT6JP0Kv7p+k7nXrMKEZSo3RUZHkX7Hv1pyZVw0UG9lE1W1tYLoLQb14TXu06c4WxzoOHPTJWSpjgP+QvH5ghgehc4Ny0BxHgGrj0ORHQyzq0Iz6/35JJmsgQZZSbfL/uSjE49Bja6XYfZndaoSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=GDObxaUK; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428A25tM016412;
	Fri, 8 Mar 2024 15:11:03 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wkwfjmyah-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:11:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTSob9QNLJkbuIpXBFnzMbV2HXp7zn95sUo5l8yqKHwpkYyhVNNraRETi8DhSQ/XxhflGVjCMMxk2/VJQ962VmdTfMSt+DqH/j5/cfjOuQjYWwQUuS+nvZ0Ho52X6gTmNAsIi8yAVBOpQ88yvHAF6cg7Upn9CTzwaCBWjbjkccc5wLOjV1yZhRxEKagoP0Vl4Ua4OG7/I8BUgXuvGb3QvYriMTqsKOrVaroO6USurIfE3zolg4ugWLs1zrbQqIz4HsqkNOHX2JzbcOwuMpr2tlSQJCvE/Zk34psqjlnvrubxD3StAfgkyeylA8T+zxOVgi5iJe120cEn+hzcCnDkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3rwcKSGlDA1fJFaKs1sV2oBRRsupJlhcydMxPp81RQ=;
 b=Dtga4/V4YYuxuG7nZ8MFYyCTfGSQ3619w/PR8HtimD3VW0swAiZmYWJWfzt7lmUXnKVO+gl/7yMlK7t19082xNMzJVsyHtIHk62QnM7noxKjrcJHiiid53fJKrJBtcC5ibeblpeXw7hkNd0oEoUA3yL91A5Kd2R3alb4fqnt1/OQtW3YTXuzQacFy1plcABWNltnTn/pxTFbUlIE5p4Pb+8ZPOoLuNbPaWTHFUJ7IulFH5pb8m+HAMSRbojjIis/6M5SHMI32jjWSPNWuUPxLDwaNWmtIu6CYW+aKJ6L18agSOBeUOblcStZu8c2T1f1H+czkUb1Y0H9jXvvtqfe0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3rwcKSGlDA1fJFaKs1sV2oBRRsupJlhcydMxPp81RQ=;
 b=GDObxaUK67T0FB5VQRNN2/c1Nl9qt/Gyr4qYfDqF3yy2+eRdcyocnmjSM4NsfwYWAcT4LN7xeamdmUes1UAkLzce+9a/7PjaBSnLUDeEM/nv4hV/nLcbyNrF+CO4qKg6xeRTD0YJ0kCEJfMKrTQoPuFZa9PXa2AQUgSLsESNL/LjyPuu6Q2aGgcBHIrq9JZHnyY7u5S7pm/nZp2AHRjNdQ3C3ZfuvD026VpG3GfJ0noOMgadD7eHkJd2pcoiTdPWqRQTSemMYm6y7haJLtbmsfEYl6+w6sephOLDi9s9KqYY1LTk052kdYMrphY7Cn+WiKtdN76kCf0KL0mWDQ20Ww==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:10:38 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:10:38 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 1/4] iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
Date: Fri,  8 Mar 2024 15:10:20 +0000
Message-Id: <20240308151023.379705-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308151023.379705-1-inv.git-commit@tdk.com>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB2564:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e94755-9b03-4bcb-72e6-08dc3f81e942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bQTpWlt08hMcRbUh6G0ECdNWgtXtEwPVCW9nGIbty3b+emPS40BSIJWHOixpfT8ogNE6bA/vcr9+mSISYAWKIOjJipXPhDyzaLnvSSW84Z2/U72GGo88Px91CpX/gH0dxjNLbFbgswUYFtygOJCPJuXje/N3Ba8buhALwMgi0bMNuCDMEMkL5m3oiU86lWAFwUfm8heAQUiFQmqt9vdFx+2n0enFFxlXD20342mY0nhHyrIGr+RyfJqWt5r0PokRf+75TuzdLyBrDti4SzfWWuhQqH3UK+U8nZU2e6H2Pl7d/jOnrcY3uYuz0CWd3XrVapVz3tcFnNhspG/Favw7zSyh+8U7b8XcC48TjHmWq6NzhPtUU2b6l+SKmagPZoJJL0NJQQ3h1u75GXvLOwYMkwH7wO5NJJ+9CIzkCjDjxcl+UVD2uDqfPaYLihPNzAMuFyQ633mPmEyvo201euu5IRJ+XMWxMHLnoRMc2J5vUhAcgLFrbkJtLxnvrS0+kE7R38SiM3N+vcm+86Am73Bz4xdWo1tpAeWeHhMcwozrSlXXotuhT5wXmPaO9kZlOiGXlpbeS05DxDV9xM8dYyUjOSEbrSSN6EwR4j0W06GlwN95G2S8ejZxEryUqhszxhvNOPCUwzabjb5B1UdwQiRrgnzsPDr+dyF0uohJej5lgzbuWDGyn9kDXOkQ9uw4sLpT8cdr+qBB+cVULIahh7spAbgAIMguNipvF2mjW5kAb0l4z6RANIKe8vd6q3CxZW0g
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVVZbnd3bzE5T1UvemxLYTRXaHJqTGhrVWRZbUY1anMvWlJqU0YwWHdjblpR?=
 =?utf-8?B?QkpRNGE4Vk94d01TYlJscUxuTldJV000djc2TGVOVFNadkVUc3hnTU5tQWQ4?=
 =?utf-8?B?RnV4cm1PM3R5empIMWx5UU05c2dFUWMzV3hmT1hDVWlvKzZiblRGdkRObFgw?=
 =?utf-8?B?K0pwQzNMMFhNT3NpWkZKbEZEakVwMENwaTZLMTEvZ3B4TGlxUTdQYi9wbmVk?=
 =?utf-8?B?ZUhDU2lEVjM4WW1UTTBoQU5TVlluVzVTQmhBL25VSDU0RUE2aDhPNGFocitB?=
 =?utf-8?B?dFRBNXlidmFzQmRFdWZlU1pLaEFiUTQvdVBzMC9UNVJzTEErazU5NWtKM1dm?=
 =?utf-8?B?amlPSjV0a1ltb0dSVytiSDVQdHJFQTB2UUFYUGxsN0JWa0FBb3R6VXlzcU16?=
 =?utf-8?B?aU1ybDljRnBzSnZLd081MXZuNFp3V24zTzNNT1JnUXhyUzRxcjc5RXEwbmtX?=
 =?utf-8?B?WDhPZHYyRjhDQ2YzUkxGeGhhN0I0Q05USHN2ZjBubEdSQmlKTStBbWY2Q2or?=
 =?utf-8?B?NkF3WDJyU1BleEFZNzRJWTVWaEJlOW5rc2xPNDRUZUtGaWszQ2xPN25SWWN5?=
 =?utf-8?B?ZWg4S0JYUXhlNzQ1YW1CLzAvRjAzSnp5WHREakVPUlFoVXpacXN3YlJuUUt0?=
 =?utf-8?B?a1phSFBMY01HMml0OVhQV2pya2VwTmtUbEdsY3pQb1F6SE95dStIcE5uMm1X?=
 =?utf-8?B?VjNFOHNEZFBLSHQ3amhJWUhjRjJmSGI3KzdIb2YrVDFkRG82bytoRGpZMFNN?=
 =?utf-8?B?enBSaGUvQkYrb1V5MGJuUEdOK0JBR0tveERHN0NMYWVGb3krYlFNZDhRVzcr?=
 =?utf-8?B?R0I1ZFFvUlRDZldsblp6YUdONHpKYnVtWlBCNityclJHZWEvV2hjQWNOYjli?=
 =?utf-8?B?aS9wUDZEendYdTBqTDUzRmRNdWhQeThybXVBQlUvbUVGaDNFcTJuWmxEaHI1?=
 =?utf-8?B?Z3BlL1JhRVgrOUNIeEdlb0l0MWJJcy8yZVFQL2VGeDYwSXhnZW96OUJnMDY1?=
 =?utf-8?B?ZnVCTXFvMTlhMExKRnpMRDlRS0pvTkNxTXRZUHh4RkppRW1FbllRaW0ranM0?=
 =?utf-8?B?Z2xtTFZrZnE0Z25MRE9GSTNrbEkzQWF4Tk1VVnoyM3hCNnpUNXI3bHUzQTdM?=
 =?utf-8?B?YlJvRjlrU2g0TDRHQzdxUk9rbG9XRWpneUp2ZkNSN3hnTWR1dG1jUzlUckxk?=
 =?utf-8?B?RFJBZFFzSG53bThVcnJuRXo3enp2VjRPbUpQWUZjejVwNWVkM0VPdnlIbTdW?=
 =?utf-8?B?b2kwUnhPamxQNXp2cThCc0hSVkFDM25KN3FnSU8xTmE4T3JYQ1V1T1VwVEdQ?=
 =?utf-8?B?eDhiMVY4ZzhqTkxjemtxUnZNOWYzTFUweG51WEtISTlRZ0JzaFNtc25FVVBr?=
 =?utf-8?B?NUNvTHUrVHdJWm5nZ1h1NFBBajBXSkFKbXJvdkQ0Q3IrUWtSZmY1Zi9QZ3Fl?=
 =?utf-8?B?aTF6VEd2Z2Rtd1RWdEF5SDN6YlNjZGlWZzY0Y3BXRXZIVWVwOVdzK0Y3R080?=
 =?utf-8?B?bUZWNDJ4eVZaT25wYS8vMStPNVg5NUxtOWNtQ1hvRjk2bFNwcXFwdjBrTENE?=
 =?utf-8?B?V1psVmRwWk9hS3V5UmF4L0IwSGJmcStBZkd0bDNUZ24zNmtlMnpOd3o0azJq?=
 =?utf-8?B?Yyt6OW95Z05KcU5LZStraklobStnT0VUSmhFN0dtWW1OTmZWNDBaUTlqSjJk?=
 =?utf-8?B?Q0dBREgxVXVSTnZkQStyU0Z0RFBScVNleVNkT3M3c2UzVmxEMiszaEh3R1R5?=
 =?utf-8?B?anNiTkJQVFI0SGVybnQrQnZsMnVveCs0a1V4NlVwKzZ5ZHhsczRvMXJnSUph?=
 =?utf-8?B?MUlzaE56MkMrRENWSk5DNWFYYzhqWGJnUm9sblRGL3RFQS9VbzVUU3k1RTBL?=
 =?utf-8?B?dml2UDRmSnpQSUhqRFFIbVNWc3RieTYveFJOY05zK25HNjBVaGg1bTVpOWlj?=
 =?utf-8?B?SE9ZSnZKaCtQY01TSkNTbHZGNWx6N0xGcVM2eXlMM0pndjlvVnRjUDBrSldW?=
 =?utf-8?B?MmJaVWJLSUVWVlVsdWtKYm0xWi9PYmlvb1JYcSsweU83OUZLQlRLanU3RTFu?=
 =?utf-8?B?S25Rc3BtWXpHZVBHLzV2OFNJTzdLS0VXQmNYSk5qTzFIRHQ1OEFuQTVaaVlG?=
 =?utf-8?Q?vbPRwskj+Gf3AFzdUyJL2Ndqv?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e94755-9b03-4bcb-72e6-08dc3f81e942
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:10:38.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3hC6Kn2j3vk96BqICvjCymTOzrOHo/KYUJ3HX34oYYYMYZMMMoXzev0ItgmndRnSFKfkq5U9VAooIFVgf6IVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2564
X-Proofpoint-GUID: AS-DT9_a4Wx4pb_adOEGsESofOY6yRxX
X-Proofpoint-ORIG-GUID: AS-DT9_a4Wx4pb_adOEGsESofOY6yRxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

WoM is a threshold test on accel value comparing actual sample
with previous one. It maps best to roc rising event.
Add support of a new WOM sensor and functions for handling the
corresponding roc_rising event. The event value is in SI units.
Ensure WOM is stopped and restarted at suspend-resume, handle
usage with buffer data ready interrupt, and handle change in
sampling rate impacting already set roc value.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 293 +++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  19 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  14 +-
 4 files changed, 319 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0e94e5335e93..ad42be809f09 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -15,6 +15,7 @@
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/math64.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -332,7 +333,7 @@ static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 			      unsigned int mask)
 {
-	unsigned int sleep;
+	unsigned int sleep, val;
 	u8 pwr_mgmt2, user_ctrl;
 	int ret;
 
@@ -345,6 +346,14 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 		mask &= ~INV_MPU6050_SENSOR_TEMP;
 	if (mask & INV_MPU6050_SENSOR_MAGN && en == st->chip_config.magn_en)
 		mask &= ~INV_MPU6050_SENSOR_MAGN;
+	if (mask & INV_MPU6050_SENSOR_WOM && en == st->chip_config.wom_en)
+		mask &= ~INV_MPU6050_SENSOR_WOM;
+
+	/* force accel on if WoM is on and not going off */
+	if (!en && (mask & INV_MPU6050_SENSOR_ACCL) && st->chip_config.wom_en &&
+			!(mask & INV_MPU6050_SENSOR_WOM))
+		mask &= ~INV_MPU6050_SENSOR_ACCL;
+
 	if (mask == 0)
 		return 0;
 
@@ -439,6 +448,16 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 		}
 	}
 
+	/* enable/disable accel intelligence control */
+	if (mask & INV_MPU6050_SENSOR_WOM) {
+		val = en ? INV_MPU6500_BIT_ACCEL_INTEL_EN |
+			   INV_MPU6500_BIT_ACCEL_INTEL_MODE : 0;
+		ret = regmap_write(st->map, INV_MPU6500_REG_ACCEL_INTEL_CTRL, val);
+		if (ret)
+			return ret;
+		st->chip_config.wom_en = en;
+	}
+
 	return 0;
 }
 
@@ -893,6 +912,251 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	return result;
 }
 
+static u64 inv_mpu6050_convert_wom_to_roc(unsigned int threshold, unsigned int freq_div)
+{
+	/* 4mg per LSB converted in m/s² in micro (1000000) */
+	const unsigned int convert = 4U * 9807U;
+	u64 value;
+
+	value = threshold * convert;
+	/* compute the differential by multiplying by the frequency */
+	value = div_u64(value * INV_MPU6050_INTERNAL_FREQ_HZ, freq_div);
+
+	return value;
+}
+
+static unsigned int inv_mpu6050_convert_roc_to_wom(u64 roc, unsigned int freq_div)
+{
+	/* 4mg per LSB converted in m/s² in micro (1000000) */
+	const unsigned int convert = 4U * 9807U;
+	u64 value;
+	unsigned int threshold;
+
+	/* return 0 only if roc is 0 */
+	if (roc == 0)
+		return 0;
+
+	value = div_u64(roc * freq_div, convert * INV_MPU6050_INTERNAL_FREQ_HZ);
+	/* limit value to 8 bits and prevent 0*/
+	if (value == 0)
+		threshold = 1;
+	else if (value > 255)
+		threshold = 255;
+	else
+		threshold = value;
+
+	return threshold;
+}
+
+static int inv_mpu6050_set_wom_int(struct inv_mpu6050_state *st, bool on)
+{
+	unsigned int reg_val, val;
+
+	switch (st->chip_type) {
+	case INV_MPU6050:
+	case INV_MPU6500:
+	case INV_MPU6515:
+	case INV_MPU6880:
+	case INV_MPU6000:
+	case INV_MPU9150:
+	case INV_MPU9250:
+	case INV_MPU9255:
+		reg_val = INV_MPU6500_BIT_WOM_INT_EN;
+		break;
+	default:
+		reg_val = INV_ICM20608_BIT_WOM_INT_EN;
+		break;
+	}
+
+	val = on ? reg_val : 0;
+
+	return regmap_update_bits(st->map, st->reg->int_enable, reg_val, val);
+}
+
+static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, u64 value,
+					 unsigned int freq_div)
+{
+	unsigned int threshold;
+	int result;
+
+	/* convert roc to wom threshold and convert back to handle clipping */
+	threshold = inv_mpu6050_convert_roc_to_wom(value, freq_div);
+	value = inv_mpu6050_convert_wom_to_roc(threshold, freq_div);
+
+	dev_dbg(regmap_get_device(st->map), "wom_threshold: 0x%x\n", threshold);
+
+	switch (st->chip_type) {
+	case INV_ICM20609:
+	case INV_ICM20689:
+	case INV_ICM20600:
+	case INV_ICM20602:
+	case INV_ICM20690:
+		st->data[0] = threshold;
+		st->data[1] = threshold;
+		st->data[2] = threshold;
+		result = regmap_bulk_write(st->map, INV_ICM20609_REG_ACCEL_WOM_X_THR,
+					   st->data, 3);
+		break;
+	default:
+		result = regmap_write(st->map, INV_MPU6500_REG_WOM_THRESHOLD, threshold);
+		break;
+	}
+	if (!result)
+		st->chip_config.roc_threshold = value;
+
+	return result;
+}
+
+static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
+{
+	struct device *pdev = regmap_get_device(st->map);
+	unsigned int mask;
+	int result;
+
+	if (en) {
+		result = pm_runtime_resume_and_get(pdev);
+		if (result)
+			return result;
+
+		mask = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_WOM;
+		result = inv_mpu6050_switch_engine(st, true, mask);
+		if (result)
+			goto error_suspend;
+
+		result = inv_mpu6050_set_wom_int(st, true);
+		if (result)
+			goto error_suspend;
+	} else {
+		result = inv_mpu6050_set_wom_int(st, false);
+		if (result)
+			dev_err(pdev, "error %d disabling WoM interrupt bit", result);
+
+		/* disable only WoM and let accel be disabled by autosuspend */
+		result = inv_mpu6050_switch_engine(st, false, INV_MPU6050_SENSOR_WOM);
+		if (result) {
+			dev_err(pdev, "error %d disabling WoM force off", result);
+			/* force WoM off */
+			st->chip_config.wom_en = false;
+		}
+
+		pm_runtime_mark_last_busy(pdev);
+		pm_runtime_put_autosuspend(pdev);
+	}
+
+	return result;
+
+error_suspend:
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+	return result;
+}
+
+static int inv_mpu6050_read_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int result;
+
+	/* support only WoM (accel roc rising) event */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	result = st->chip_config.wom_en ? 1 : 0;
+	mutex_unlock(&st->lock);
+
+	return result;
+}
+
+static int inv_mpu6050_write_event_config(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  int state)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int enable;
+	int result;
+
+	/* support only WoM (accel roc rising) event */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	enable = !!state;
+
+	mutex_lock(&st->lock);
+
+	if (st->chip_config.wom_en == enable) {
+		result = 0;
+		goto exit_unlock;
+	}
+
+	result = inv_mpu6050_enable_wom(st, enable);
+
+exit_unlock:
+	mutex_unlock(&st->lock);
+	return result;
+}
+
+static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					enum iio_event_info info, int *val, int *val2)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	u32 rem;
+
+	/* support only WoM (accel roc rising) event value */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
+			dir != IIO_EV_DIR_RISING || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	/* return value in micro */
+	*val = div_u64_rem(st->chip_config.roc_threshold, 1000000U, &rem);
+	*val2 = rem;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_mpu6050_write_event_value(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 enum iio_event_info info, int val, int val2)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	u64 value;
+	int result;
+
+	/* support only WoM (accel roc rising) event value */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
+			dir != IIO_EV_DIR_RISING || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+
+	result = pm_runtime_resume_and_get(pdev);
+	if (result)
+		goto exit_unlock;
+
+	value = (u64)val * 1000000ULL + (u64)val2;
+	result = inv_mpu6050_set_wom_threshold(st, value, INV_MPU6050_FREQ_DIVIDER(st));
+
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+
+exit_unlock:
+	mutex_unlock(&st->lock);
+	return result;
+}
+
 /*
  *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
  *
@@ -989,6 +1253,12 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
 
+	/* update wom threshold since roc is dependent on sampling frequency */
+	result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold,
+					       INV_MPU6050_FREQ_DIVIDER(st));
+	if (result)
+		goto fifo_rate_fail_power_off;
+
 	pm_runtime_mark_last_busy(pdev);
 fifo_rate_fail_power_off:
 	pm_runtime_put_autosuspend(pdev);
@@ -1326,6 +1596,10 @@ static const struct iio_info mpu_info = {
 	.write_raw = &inv_mpu6050_write_raw,
 	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
+	.read_event_config = inv_mpu6050_read_event_config,
+	.write_event_config = inv_mpu6050_write_event_config,
+	.read_event_value = inv_mpu6050_read_event_value,
+	.write_event_value = inv_mpu6050_write_event_value,
 	.validate_trigger = inv_mpu6050_validate_trigger,
 	.debugfs_reg_access = &inv_mpu6050_reg_access,
 };
@@ -1706,6 +1980,12 @@ static int inv_mpu_resume(struct device *dev)
 	if (result)
 		goto out_unlock;
 
+	if (st->chip_config.wom_en) {
+		result = inv_mpu6050_set_wom_int(st, true);
+		if (result)
+			goto out_unlock;
+	}
+
 	if (iio_buffer_enabled(indio_dev))
 		result = inv_mpu6050_prepare_fifo(st, true);
 
@@ -1735,6 +2015,12 @@ static int inv_mpu_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
+	if (st->chip_config.wom_en) {
+		result = inv_mpu6050_set_wom_int(st, false);
+		if (result)
+			goto out_unlock;
+	}
+
 	if (st->chip_config.accl_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
 	if (st->chip_config.gyro_en)
@@ -1743,6 +2029,8 @@ static int inv_mpu_suspend(struct device *dev)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
 	if (st->chip_config.magn_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
+	if (st->chip_config.wom_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_WOM;
 	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
 	if (result)
 		goto out_unlock;
@@ -1767,7 +2055,8 @@ static int inv_mpu_runtime_suspend(struct device *dev)
 	mutex_lock(&st->lock);
 
 	sensors = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
-			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;
+			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN |
+			INV_MPU6050_SENSOR_WOM;
 	ret = inv_mpu6050_switch_engine(st, false, sensors);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 5950e2419ebb..19adccf388cf 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -88,11 +88,12 @@ enum inv_devices {
 	INV_NUM_PARTS
 };
 
-/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer */
+/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer, WoM */
 #define INV_MPU6050_SENSOR_ACCL		BIT(0)
 #define INV_MPU6050_SENSOR_GYRO		BIT(1)
 #define INV_MPU6050_SENSOR_TEMP		BIT(2)
 #define INV_MPU6050_SENSOR_MAGN		BIT(3)
+#define INV_MPU6050_SENSOR_WOM		BIT(4)
 
 /**
  *  struct inv_mpu6050_chip_config - Cached chip configuration data.
@@ -104,6 +105,7 @@ enum inv_devices {
  *  @gyro_en:		gyro engine enabled
  *  @temp_en:		temperature sensor enabled
  *  @magn_en:		magn engine (i2c master) enabled
+ *  @wom_en:		Wake-on-Motion enabled
  *  @accl_fifo_enable:	enable accel data output
  *  @gyro_fifo_enable:	enable gyro data output
  *  @temp_fifo_enable:	enable temp data output
@@ -119,12 +121,14 @@ struct inv_mpu6050_chip_config {
 	unsigned int gyro_en:1;
 	unsigned int temp_en:1;
 	unsigned int magn_en:1;
+	unsigned int wom_en:1;
 	unsigned int accl_fifo_enable:1;
 	unsigned int gyro_fifo_enable:1;
 	unsigned int temp_fifo_enable:1;
 	unsigned int magn_fifo_enable:1;
 	u8 divider;
 	u8 user_ctrl;
+	u64 roc_threshold;
 };
 
 /*
@@ -256,12 +260,16 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_INT_ENABLE          0x38
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
+#define INV_MPU6500_BIT_WOM_INT_EN          BIT(6)
+#define INV_ICM20608_BIT_WOM_INT_EN         GENMASK(7, 5)
 
 #define INV_MPU6050_REG_RAW_ACCEL           0x3B
 #define INV_MPU6050_REG_TEMPERATURE         0x41
 #define INV_MPU6050_REG_RAW_GYRO            0x43
 
 #define INV_MPU6050_REG_INT_STATUS          0x3A
+#define INV_MPU6500_BIT_WOM_INT             BIT(6)
+#define INV_ICM20608_BIT_WOM_INT            GENMASK(7, 5)
 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
 
@@ -301,6 +309,11 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
 #define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
 
+/* ICM20609 registers */
+#define INV_ICM20609_REG_ACCEL_WOM_X_THR    0x20
+#define INV_ICM20609_REG_ACCEL_WOM_Y_THR    0x21
+#define INV_ICM20609_REG_ACCEL_WOM_Z_THR    0x22
+
 /* ICM20602 register */
 #define INV_ICM20602_REG_I2C_IF             0x70
 #define INV_ICM20602_BIT_I2C_IF_DIS         0x40
@@ -320,6 +333,10 @@ struct inv_mpu6050_state {
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
+#define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
+#define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
+#define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
+#define INV_MPU6500_BIT_ACCEL_INTEL_MODE    BIT(6)
 #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
 
 /* delay time in milliseconds */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 66d4ba088e70..13da6f523ca2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -33,10 +33,8 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
-	result = regmap_write(st->map, st->reg->int_enable,
-			      INV_MPU6050_BIT_DATA_RDY_EN);
-
-	return result;
+	return regmap_update_bits(st->map, st->reg->int_enable,
+			INV_MPU6050_BIT_DATA_RDY_EN, INV_MPU6050_BIT_DATA_RDY_EN);
 }
 
 /*
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 676704f9151f..ec2398a87f45 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -134,11 +134,13 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
 		if (ret)
 			return ret;
-		/* enable interrupt */
-		ret = regmap_write(st->map, st->reg->int_enable,
-				   INV_MPU6050_BIT_DATA_RDY_EN);
+		/* enable data interrupt */
+		ret = regmap_update_bits(st->map, st->reg->int_enable,
+				INV_MPU6050_BIT_DATA_RDY_EN, INV_MPU6050_BIT_DATA_RDY_EN);
 	} else {
-		ret = regmap_write(st->map, st->reg->int_enable, 0);
+		/* disable data interrupt */
+		ret = regmap_update_bits(st->map, st->reg->int_enable,
+				INV_MPU6050_BIT_DATA_RDY_EN, 0);
 		if (ret)
 			return ret;
 		ret = regmap_write(st->map, st->reg->fifo_en, 0);
@@ -171,9 +173,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 			return result;
 		/*
 		 * In case autosuspend didn't trigger, turn off first not
-		 * required sensors.
+		 * required sensors excepted WoM
 		 */
-		result = inv_mpu6050_switch_engine(st, false, ~scan);
+		result = inv_mpu6050_switch_engine(st, false, ~scan & ~INV_MPU6050_SENSOR_WOM);
 		if (result)
 			goto error_power_off;
 		result = inv_mpu6050_switch_engine(st, true, scan);
-- 
2.34.1


