Return-Path: <linux-iio+bounces-3457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27B878497
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4776E1C2104B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8E4594B;
	Mon, 11 Mar 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="A3UPyQ6A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F404436C
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173204; cv=fail; b=aWRKRxeF3rSh4pLNcDXRZhUVBxvQlRBmiZBuPW6/E5ibjZ0s6ZkGASGWdlEuV8rK52Oui4rfs7ep2Dr9TzBaBGlpO/t4Ff8eqiZ0VdyZA0qX0OLsfGVFzapNz0niCrhGULBz205nbK+cCTHb+/ax12O7EOsp4fRlBPhOuXeDlrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173204; c=relaxed/simple;
	bh=YCJwYKafZg5mdn8SF2BXTduaamYMpMkbmZyE36mt2/I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CBS9dNjSEoH1IviE0cR+2or2aqglgprxBCb/QnsfDpfJHGYU1rgFmKbhsSMVb7uCXDnz14MZKDDj0YqXttSYlKt+v/JE2QLK6L4oR1mA4i7M7d3FxRfTVuVuzLmjrctrgbdieS8fUcRjJgNoSdIZTXr149RTrCz61WDQO/s2sI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=A3UPyQ6A; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9oV0h032277;
	Mon, 11 Mar 2024 16:06:15 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010000.outbound.protection.outlook.com [40.93.130.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wrh4j19vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:06:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBrIl33KOobd30yh4+dA0sE6vbnwmZf0xfXM4xTqmOfHZPC+aMstAk4VxZrDUf+syZ4KZLh6ivuYmfMGcNBQ0AujNB9TRnoc7frCVxxGrGSUCJ6FNpiU4WKjU10A8ZqMBujk3SszqwosiNe/aWyYqW8gMfOJQwCJP3eCIUB+0g0AqEZcqtTmTI+IXbgAMe6rkMf533NUQBLfuv7+V1e46Vn8Z+QFpzCahxiwJlhJAc/kBIWiT/HOf8xhjBVOBiSNlLUv8s9NpExL4DJKiix7k8lG5HUeB/KzHBTP8KwQfBpeDWM6O12rfrj26zITA0NC25IUNzs3VSsMDCbVPppqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9pWBOBre99mHKOr1iKdfUlyXjykoUEnyw+sRgBXSnc=;
 b=Swy0sv0iZudG/DQ2yHHLNWqR3XLjWevflxvAUs0xnAYIzPpTWkFxWouO7oN7DyldTzTVuX8RmydwFrtlMvZnKBxewY6Bq9yf1dpzo0egKE8g/HuHjSKCjHK5dw8a2FLEBuS8VZZJYLzW+u4O/U1tFAz0PWZJ1MFyE1g2oP2Mmht1tWb5649xmqkXZVEFqH2raA/42jokpXPomjCOPZtNC9mBfQbxcwBwK5SW1TtsR5XOt8oa8UXtnwWHxs85kG8qxqpXBOpYE+PNfgUfP5zg3gUXw6YRaXepVO/nB0eMuqeU/uHB/LmgxU+ckUXRv6X2uDFNL5xigbsKlLwS9+q/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9pWBOBre99mHKOr1iKdfUlyXjykoUEnyw+sRgBXSnc=;
 b=A3UPyQ6AY+Ll8GZCbzUzHPskdZsjm7lAZQQfc1BIERFdzdGUq6SZ3zAnTNOhkoJTEMCQBP9vcNrxeOqPS4cbX6TlH7XVEusEKzCrO0ck+PStNaLLNr48h0yrHv16wpwcXuYQX/x7ECWZbrzgW+bdZEHmYzNnHj6OGoWyc1WZVtLlT00r4kc59LzuCKv096gjRWEX7UkQq2hnbbj1FD4ZqvXBSv8r/H2igPew6EPs7doUGon7uq8LT18lqsg5I9hZ/WG8WWiHQesxCX07Csay6BIJ1pT2j0vclBpeIzwB09sGgrnSLpz+bJPpIFUAonjRJ/1sKMYZ1JZFsjwEO4mprg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:06:10 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:06:10 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 0/4] Add WoM feature as an IIO event
Date: Mon, 11 Mar 2024 16:05:53 +0000
Message-Id: <20240311160557.437337-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::7) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f88e7b3-4d7d-4b58-fa6c-08dc41e52aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vzqurc68RSXtIQyTyocwl0wulPsut34DmKYpqnLN9ct2y7rACpWyQIoINKQgNVZ0/y4wS5j0nzKfmS+skmgb2OuOOW3ncexE6tbP5cGf0mXfnZh5JK3HZjpo3h76zcXXjjxxnodh2lcwLpyin8O33jPT0xq3nqVzpOUH15M2rNs8dSV1q6U0Pp/YOO6GodSwHIOjs/AXsDhcntMX0kz7xdnkmfjhqKIIfv/PeNSB7GKYUQGhLGS6cfJuGgVV0ivMY/5WhHvxcec9CTdz46rqxuiZba1ZoM0TW7g2yeiqMXJ/F/zg+nxKXHCTU/+H1ERbSeG+sw9MqG8Spv6B5bR54OaN3eGE4LcrEMIDuxjbPOqh67RA+ZvOBemNSouCRbVhAl9YslDswkDRUWqgbXb5XMrvCusBiNAUSna59IGgf/HI0AdU2iv4um27ZlX751qHXu9cKySSNa1vlZITMXF+0JIdec4G7IYdUWYGkiAkUdG8b34rqsUTS4tVG3g0jeVY+K2Py0BEwCM69qOEAPTdZO1bQD+USLk/X4M/i3I3DggMx71UUc2vBzq5Y86gV6DTPBtPDLRiuMUWPJqRIgdC6/ypwKSprZ4c36XC+loGhWeLy0+4cYwBpT3zXR8QnIq3k8b22yuS4UgPhg4Pt2HZGKxCJFi1l8YTg1evdWkGdqvxU9N/kD3lHnHnWtR+y0EXmdGYVh9x0vZ208KY81e+9Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Mxxh/nrkDZrmhI2dldnXk/+fux4cvMYp233c7wGIEY02nx5c5PhHA1axdlSK?=
 =?us-ascii?Q?Trj5zQJvz86Z1eQ+oVA6/WnZc85g9rX9qRO2g6Wad3PXebmGbinlVTKS3gwQ?=
 =?us-ascii?Q?TEW0qoWi6N/ialNjc2pNcefUJ55G8WEVA9UYbfMMhZdTq/dYWyB2uo2UkQAz?=
 =?us-ascii?Q?kDU27YtsltYPwCMZ1jyffpo7Fef6bG9cWBOAYfACiQnSO2QIe7+VqL67jwEd?=
 =?us-ascii?Q?WyoxdKOmx1cA5eqFpzxyXWz3lshCCF3cp5L/B/P/b9owYN+XDm2auv07aPK6?=
 =?us-ascii?Q?80WUbJc3gjKVA6xvhjgw6a1ib/AAv8yLCXwz+diptXKsYnTNrghXcdYcWgip?=
 =?us-ascii?Q?Cs+Re7DksHpFgONKtxUeGRfwUzAC7x4aoxFrcqMx3EOx3EisNSFCTWJJg+Xb?=
 =?us-ascii?Q?HJc41oeP3cp82tZCAFb1NTtDYWZ6a9Ou/3aRKZZJLqxEEZAFBYNXHDAPwY2C?=
 =?us-ascii?Q?Jn12NbZUzm0uu4wbpp3o/fW1PWNFjFQyK/O+nqLG6lSZ4kixYehIUiBxVrrM?=
 =?us-ascii?Q?4BQtWW+dH8KD5CfRE7SrZVrQuixZAlovhW1SpCh+5ixisiNzE2AzvH8SUay5?=
 =?us-ascii?Q?jCEWprGUHpaSV6dLc1GBQrLpe/CrS7NymqnMO3q+9/exaZf2csStMKzeCMWk?=
 =?us-ascii?Q?NIS382hhJp/lxfrf1vFYvgjf4roVFSYZRfOFVLlVcLWIiH1Cz1b9jzy4ry9P?=
 =?us-ascii?Q?blh6ZfVW5yGECHvroh5IqaOiYrl3PYz1Knmiss4xyTFDtfC12clMkPQjdUGc?=
 =?us-ascii?Q?997mVIvP/v2AVFOWadTgR//elIteBxQ+8SOASWpxZmAAm+iCRSy56XTkDfqI?=
 =?us-ascii?Q?tdsHPQA3DWLE42n8aOA9HMMEVYq62EJYuSOBdbuKKy9aLeIDy5CsaLNswAG3?=
 =?us-ascii?Q?zIc52pdKanOz2g5i98ThrbRPuaTd1giWXyv8V+kq3qLyomKXBI2ssvpZfXX+?=
 =?us-ascii?Q?PAKk/cGjJr1qluT3nBX6x+43WpTlC7Trb3P5zJZhj8FcPPUiCZJe7XQHx7tf?=
 =?us-ascii?Q?7uIZfYaMSkYPe25VprzTz0DoC9Rgw4m1RRhevAehIiQFz4J5WH9yUBSqzbk/?=
 =?us-ascii?Q?NwPjIy3fON4pIkcZi0BbEz0dcSIe2mfyRbz2qzrqg7jvXWoyDbbZHhMznaxu?=
 =?us-ascii?Q?7nMllq0iESfBGoJ3y6TDxCygjuae2knYRzypJ/m6KltHuegfcpau2gE5yrCf?=
 =?us-ascii?Q?H9BnY3p7IALEYK7caNxMd2rwjws4WcB+MHsrfat6usM2RPNg5xvVvTSS6SpM?=
 =?us-ascii?Q?ABFqMllxf1twfnMgiRy07c1+FmNvd++U80c55EQU/77qMYoeDnWmIjQUunj+?=
 =?us-ascii?Q?swRDbf8HVGfkQnH5s57GWJcbNEbH0e8u2CdJ/6oy5dNaH7ier7Zw46HRFKSM?=
 =?us-ascii?Q?reAb2h45lTZe/5gCwp0vRSUEhKFCLbMm/QdONW/lX8pZ5nsxDXnSi8wXL4Ez?=
 =?us-ascii?Q?zm0e/ouq1wqPX9HTtjgSEce49T6X5ky4JnsouxR8PLi4BAsBqHeVK85Ptqpp?=
 =?us-ascii?Q?Tc9vuecCopUkff0LojzhsKggJ25EP0E5Fqw3ZrGDI3VlKSUquIg5vUz+uXh9?=
 =?us-ascii?Q?HkzNIRvIFFOJp1MoJG2oddJ5OemnsE3cMKRgbjBC?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88e7b3-4d7d-4b58-fa6c-08dc41e52aa7
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:06:10.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFQcMiPPY94v851WUpn7lW537lEhcxi/Tk/et1UYu8IVX+CUgQ37kIun9IgBm7m5ce3ZNg3ONSVunfkRDsy/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961
X-Proofpoint-ORIG-GUID: WypjNP0UUyZ-IbgmECHk4beVhe6wUs5n
X-Proofpoint-GUID: WypjNP0UUyZ-IbgmECHk4beVhe6wUs5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM (Wake-on-Motion) feature for all chips supporting it (all except
MPU-6000/6050/9150). WoM compares the magnitude of the current accel sample
with the previous one against a threshold and returns an interrupt event if
the value is higher.

WoM is checking against all axes and maps best to ROC since it compares the
last 2 samples. Thus report WoM as an accel x|y|z roc_rising IIO event, add
system wakeup functionality if WoM is on and put the chip in low-power mode
when the system is suspended. Corresponding ROC value is in SI units since
the chip is using an absolute value in mg.

v2:
- Rework to use accel x|y|z roc for reporting WoM event
- Use only datasheet advertised bits for MPU-6500 family chips

v3
- Coding style fixes
- Convert mutex usage to guard/scoped_guard

Jean-Baptiste Maneyrol (4):
  iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
  iio: imu: inv_mpu6050: add WoM event as accel event
  iio: imu: inv_mpu6050: add new interrupt handler for WoM events
  iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 542 ++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  36 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  83 ++-
 4 files changed, 595 insertions(+), 83 deletions(-)

-- 
2.34.1


