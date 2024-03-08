Return-Path: <linux-iio+bounces-3381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179287670F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A422810FB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FF1D556;
	Fri,  8 Mar 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="kan+IeHF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40973567A
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910689; cv=fail; b=PXc4lbJrL08E226YqsB4yFvWwbzBGK2bxVsQwMiCImGu8uK9E5G4dm6fjTaNnR+pytWmYKP6zkiAwOfLXdDelQeNfNZOyyjq5NADb8/92Z9OiHVb31VtNbip0hSchlqYyvvztGO1dTcEHG8p7IgovZNhJZ0R0dV+3pstgDBWqwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910689; c=relaxed/simple;
	bh=3kNq/L7ZpEUIW1gwEKqbnY7rkb+OPLMJsrlXe/EE2bI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pu2/F9+QuqvCHSV+HDXZ1kszOTMWTitwxqrrIQFxKZ6EXUpTEcNo7XCWfi2qPTlUmduRYQ8CXhdjMBxXJ4ZbCgcTie3pcpqs3v7OFBTGeqgpoGVBC03uq1JP7Tr5OkKi02ZetdigGGazFM2A8u8Oxj7PGc0SNgMDiHnxXh0/qEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=kan+IeHF; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428A25tI016412;
	Fri, 8 Mar 2024 15:11:00 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wkwfjmyah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:10:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGDC4Qd2XtX0QwlyP/z1IKxg58K5ecldqkvdOjibdH+58ZIhb9BD03wEPrggQWevO1xari/+3xEOaRQ+iKhcrfm5HaMo+VBUfrZgcWZpjiV/30COjd6HKH559DTFBESJXNYeDWLXgO1okkxYRntEDKJjk3GvuPV/W4H22DLFxrxF6st+ZXmEw1UDyiR7or6+RQ4J3bfr9g/9X6u6HOAlref1w9NOmKj9BMthe8bHeNQfJEhjCLzAz7jiq+0u3iszNKAVvgTlDQbz7aMPiZKN4bQeD4JkmrWwcqXFk5llRXkA5yi5wJED3+rBRI/AX/1VoAKuS4rTAoc9VwWlifVjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcBaNJs4SlF5Wb/3K2dP0JFPc6/9ojKHfMBVmyrvPo8=;
 b=VFmnXTznLps/5dcQPemDkRDaIbApwteBKRCiafsKyRQ78J4QTu5zKncXoeML/FFYnZUWPgXkzee/Ylw99xcgKfh6yTEE9r/FCBKFjLzqR+tkK5o5+HXIZ3NheGMMCBXvSBtuR2IMymr4+xpAq2GFFCvLrWhUJQN7MOwHB0iqaqkatyBAHWtW+KOwaCA5/lIAAC4zZ/EuSZpO4keNvyTVa3mImU2gXHcrrGy6LPYTZUNcYNuI6HbM+zOZUGA35sQh7bfAQYDKbaYODcrqZM4mBl9PnrsTdNxkvYpkF2T6ZKrTvwOlPDVdL1PbzY6k9zHY+LNHJMmrCkHqcc0qFVLOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcBaNJs4SlF5Wb/3K2dP0JFPc6/9ojKHfMBVmyrvPo8=;
 b=kan+IeHFM+TT9SjB6ecaH4v7oFWGfcWI5PUEOWjWvXhQTUqR8adubb+PNHsyMMfHZy8K6nL//hVo348Vf8rQyRTi9XpVB1EQ2edYwIpBFrKy20DCaBua7i9ov0rhK2aTCFHLXc+jT4LRknqSkcwmoktvd1QDKw9bcPAuS/OEI2tg0zJiu3jN+4symdxVgd3IiNGYpWGd0uhZb3qfPbh9yoFYJFCIapW7i3V/MsUCLXlRg6p4++XRzEzoxRe1MGj1kOg081qSabKyt2e51dX7AQKnxvRcRoSwRCdxjenbpuC7I0g4dUMukJ8iPunYCmA46grHaKxfFmicptnQ0EToxQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:10:38 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:10:36 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 0/4] Add WoM feature as an IIO event
Date: Fri,  8 Mar 2024 15:10:19 +0000
Message-Id: <20240308151023.379705-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 4f6828b2-9c28-4ff7-1bac-08dc3f81e7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xor1AlxDPMUIFbglzpptrQ+kLzDuCiSAEoO4qMTkhZ44gsGxi2ambjxDhgmB2gCF3X0n/8kdKMCjEhA/JrW5dW4Ln4/hFh51tqt7PzTFLrnOj0rLb3/S73jfeR0X4mmJ4oHlWe3GBZ+6Ilia1Eb8HpdhjikBHOPk58Rqejt9UnRrm2A4JTep5EsNuXbPB9zpUOOT9V1xP/NYcuV3WcX+dhP8nZCTdSXHgnQXO0Pq0H00VmhowNaWRhtpOlPaWrzczhInh4cyUovIKWaOAr5fni5QgayZ8JZZiFyNUiXoDKyv5dTRCecPso2Uo4HvrJ9uCApAcWrVc6vgJJ+DNaA0HQW+tU2a7sQU9+qzGMj7Vk9V8/c/MKeSdNZYnAIkS7RK5Oi9Q6cnyE1E7M86xnBk/0ZPqo3oKc3S7+c0fBR2tRYN0thbWM0FTOjzdaTFRAUNF8p1PUOVW1GEhmG8NSAWk3PZ9cATHjTYb9F30ehg39MdWsEHmOT9g3Li9JW0w5AYkzxNgRERrzdl4MgdgU3/vHzYb8wxJLOX5El4QqhMIVSq66PEQgD2wu2Ba4JqvwkvmjTmKTl9NKs/2PgBpKFvpnryhETj4Ig6UhSABgOQHZ31n15l7LKS/4PfMDI6UoW4eGeJ+AJ6IipuzF9uaFk9igO5N9lInZarNPg8siyGg7/XSWzQBVhD8UvVTaMZkG4QECjduG07O0u1OOyAf8vX1A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aLsmT93rbFMlsTnywe0AeUNtnLAZAbY7YcRmyRJ9bVCClIuYYOhgC8i2AqOz?=
 =?us-ascii?Q?QxCBbVhdLnMDBABiojK9vuYshowxoBz1TwJJUcekZmKvkghxi0zu1nXCf8jp?=
 =?us-ascii?Q?TvzFfVaidUP1CBna4jYDG/VNikO65FFHBRnUINyDw5mlbz/Me7zTuvcPzYWV?=
 =?us-ascii?Q?KFzjyGA3KwQT1PJURfeg6DtrUDdrc95GBupeaEk3c/NguSglxSnL6sVF+WAR?=
 =?us-ascii?Q?x18wW76JYqG9xRZtZy+J4no4vVdqRE/QJu5rFXlQtnQnuqQLGbVz2bbHQ8dr?=
 =?us-ascii?Q?X6i9vbpZFNHhyfYnMMYlVRYWjKC8v/+luedU0rovUPtrDUtcIQrJE1StYm6N?=
 =?us-ascii?Q?gRENeXfxLPwPnOlbWeN40yWbwS0PuNovZyHc4YXVcUc0Mm6u7GJRIOtMFbsI?=
 =?us-ascii?Q?+0srd92nl7ZB40Hl+/ypp+lOf31ghbu+fDJVGVivovWuEYOeu3lYolBorknI?=
 =?us-ascii?Q?2nFTTNJWQKUYhioB32ZCsCTUSDA/hGf/1mOi9X0M06rzrBfIYgvdNlqTb71a?=
 =?us-ascii?Q?EriJlt6TTvE58rwxCu0o/uRgQ5Wbql1B/BsCjZe8kBSPrXu/1PtMm8y49mrl?=
 =?us-ascii?Q?GbHnLU4CeO8CXSSWS8hw2zU7SVXnSl9v0Zwk5inuh/ZA5kb9bdzbAjuwf+/l?=
 =?us-ascii?Q?gKTjvOoJXOfRSrP90XtX+7wqb6DFKOJfAUJy4QjMneUz8jqJKFqjHjvAxu3B?=
 =?us-ascii?Q?uKKuDh/ydbAtr+yAjfrg4Re/goVfKqxXd+RvOw1Jyggxc8aSTS1VOPwAnRGP?=
 =?us-ascii?Q?WaKr8dwrzJjn+G5ulTq0Rx7zmNnsJLfFE9/XG0EhVYxqbTBWnJ90+FKQNq5U?=
 =?us-ascii?Q?i+W1LQCtm1YmEVzbmiH/vcp5OPa+88pP5EoH8dhrBFe1+rS59xJBV1MFEak8?=
 =?us-ascii?Q?KCJmIuDKkJ/DU1wQIwjEEzLJ5p9d04hTVAJ6NgbpfDzeQKOh+oUeuEOa9y2x?=
 =?us-ascii?Q?PQOKAtv+nVQBSxbb7Zj2qnBN2H4ctUFXnPtifSWpuEutTIBRykGtCAQ+eXRL?=
 =?us-ascii?Q?Xshe9coGJaP1rOFheRQY2+RHl0ANw5t28E9+dt5jHAw0Juo65ubw47XMzP2j?=
 =?us-ascii?Q?mPMudi++rwMOGBt/TUwtS1z0zxIwTaaxQXCCPB3H2UXo4ON0ddoeTqIVkQO4?=
 =?us-ascii?Q?fzvl7ggP+EKKam5AbP43vcgPxZgS/DT0Qmv5cTNw/tYuKvE3Dky1Smem7aDa?=
 =?us-ascii?Q?fswjjIdEgJ8Us1KyUxsOfa//JgIPYhYlGANypIRH86gItlrOs1J1JxBhO7hP?=
 =?us-ascii?Q?eeB8pLhYcMzOpOPACD8XzEg5CoY3704dneA6ByoP4+PO7sHY9IkJzZeJFxik?=
 =?us-ascii?Q?tjKNjMQo4j9XLvvE64zbRUcwBIkakq+sSbhhbleI5/ZLcbXHRmIk4SdMrF4l?=
 =?us-ascii?Q?qfUDRlGWIGVEP8bvj+rGIoO5S+nBzaFy5BfWB1e5rjJq/1Ylh6VH0Gpl17HH?=
 =?us-ascii?Q?0nHCevqvMi0vh98Szb1kBIlM6rlk7kp4dxnQiWuZMT7MvWTP7HdiPXfWoMDm?=
 =?us-ascii?Q?umvpTv3llU6M+CXbXpgcnQ3alB7gx7ODBeCGSGEilcBHYFu20mcMVXwM5OBp?=
 =?us-ascii?Q?+TwcIoMv5Ymi9WwnzVWhyD5Z2K2BpNUs5HkFgyGL?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6828b2-9c28-4ff7-1bac-08dc3f81e7be
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:10:35.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OG4shPV7/uecfoEdfca9itL0F6nIgydvqxHmlncmwZ2f/r8aoxH5cU2MROxiFH8Br1rqNMmrjOuQ/f7HUlJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2564
X-Proofpoint-GUID: aBbHkBiKif5trmJLa4MWNHVfTiiZqp6M
X-Proofpoint-ORIG-GUID: aBbHkBiKif5trmJLa4MWNHVfTiiZqp6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM (Wake-on-Motion) feature for all chips supporting it
(all except MPU-6000/6050/9150). WoM compares the magnitude of
the current accel sample with the previous one against a threshold
and returns an interrupt event if the value is higher.

WoM is checking against all axes and maps best to ROC since it
compares the last 2 samples. Thus report WoM as an accel
x|y|z roc_rising IIO event, add system wakeup functionality if
WoM is on and put the chip in low-power mode when the system
is suspended. Corresponding ROC value is in SI units since
the chip is using an absolute value in mg.

v2:
- Rework to use accel x|y|z roc for reporting WoM event
- Use only datasheet advertised bits for MPU-6500 family chips

Jean-Baptiste Maneyrol (4):
  iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
  iio: imu: inv_mpu6050: add WoM event as accel event
  iio: imu: inv_mpu6050: add new interrupt handler for WoM events
  iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 529 ++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  35 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  86 ++-
 4 files changed, 600 insertions(+), 67 deletions(-)

-- 
2.34.1


