Return-Path: <linux-iio+bounces-3066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE03862B60
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D91B281B27
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F64175B6;
	Sun, 25 Feb 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="AYMUHwA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFD171AB
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876877; cv=fail; b=Z4kPZLF7r1KOJQUUPI9IyT9X6hHQgrnbOUoFxg5EJQkbo4h3LxK8ZDu0BWgYhDOijSlrv3ukLlAK45hSZuxavqXFVMjoLKl50ZRSOt/ZR5aq7FJFxM8jNxEWCvFP5Qku39mt1DW/pesQRlqccWI6+D3rXygSXaLEAqBan0uNIf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876877; c=relaxed/simple;
	bh=8mizCPmEZ5GR980dSpjVpQjLTfAepjOOXvM90ARZBAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JEQ0S4Vb8EX+9q/vrWOw1fv/e9SwaJnb8xZZhaJaXv89OMb53ajqCwc0OuU3cYTK+ADNdg9M/Ccnhs1iF9qRR0bjFOuYrx0UbsV6mG2BXkYdRXzxl1r4B4Cv7MScRVG9zXPd1g+L9G4AJxhSFO37PozW3+kBFJwFL+E+Pnp80/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=AYMUHwA0; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PFo2ci018247;
	Sun, 25 Feb 2024 16:00:58 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wf9tjrf3v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 16:00:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCXJI5u8AsQAQkVtHoXDPEAVHXy9bFeSlIfg/4VlZ+KeBu1u6iwmlIXCaYhcE7TaFuslBHOgPIX1GvIwAYM+9/5T/viS6ox1UTpq+uzekxLMOV8+TJF6uWJ5A6ekIxK0YGaMxWqggpE6zUduLTbaLbsBO0xbn2hG5aF4hM6dPg1sABsUGIMwt7ox+rB6Q1CcI0/0+PLcI162X00u8Ht3y2aNHk8qOuzxoFKWDdh2tF3HFrk93uCXGLU/DeP22CqOjPIMmL6LrNqg7hnCZHtWf1dnKze/YVXDbJRfDVVDo7nPkeC076r5RvV/7BFu8gd+bqd/1GocK6BR7wQjqd5jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWTvL4Q4/9g+MPSfDFKg4niRiaJAz0yjSeoXJ1Gv9iQ=;
 b=XPwN+baZZbvcTdPHsYT1+A30P8PyIl7tP69wXQ+MNnMOfqT9jEAKU8jDgOY2I/D0pekB931CU6RduMm+yAPxOO9x1EvnfWvpmNgkg3HVv0OGaqgcQiClm95YhEAr1hFsXfCK7p0oYGJ5rk+0hPKD2FwlpIv4RRFIBMmiRU5w7wVcNSBs+rVLJcwi2hoQ0laUN+gF2xqKjt+yOhBtEM/Skzt27D5ODH9aAR5424hhHtLkNxXnFVG1fNc66EvvAJKI9BtnkYOoA+919LYhBn8W4GJXkVmBLA8rb34sP/JbLsTD7OF+fPMPyWZokQ1Jk0A4LXvzrwIGkZBrNnoh/ReN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWTvL4Q4/9g+MPSfDFKg4niRiaJAz0yjSeoXJ1Gv9iQ=;
 b=AYMUHwA0duWHsPbZUBDjzhpnTX2SW3uvk4ow1TSBQiF1gQtELLpmEoqHm1xWDQE7wkD3wAdbE/J2b4QOhqstzZx1bZjnrM1XeszXygwziNnFYN5uTpFpNBCETlPXiACkff+DSYzWdOWxd3Wi4rMMeU2UXkbNwdSxxGGEvBIvq6OdSva6yGnLDLST1e4SF0bQXlicDDotmczshZaLDo0PvphvjXcJs8b38Jk9bjRyYm9hvKh6jb/J4WomeouMu22EdmxqMSCzRyxKrKGeplKpOHtLIQMoHMnLc8CVx/VHQvsV22xS2D+hBnHui88IefgiuaWVC1sSNuqOecrrJLSbkw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYTP286MB3462.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Sun, 25 Feb
 2024 16:00:50 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7316.018; Sun, 25 Feb 2024
 16:00:50 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 1/4] iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
Date: Sun, 25 Feb 2024 16:00:24 +0000
Message-Id: <20240225160027.200092-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225160027.200092-1-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYTP286MB3462:EE_
X-MS-Office365-Filtering-Correlation-Id: 508d52e5-9795-4622-c64d-08dc361aefa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mcha3AM5JahDduR8TX8bQIPMxV0WRKcc5Yw9YIZrvx6mlPSV2n4ozuRvWzXTrxelxnUNduBIS1QzmeEQS13WpOwXbrlF3j8NOPnwggJ/qzLDS3Bc3MlLnk3YPgruejuvYSNikemWAsx3I9xp9w9uO0LZEuJN+4rhbwtnhq8rDtNOXC4aahvKwN6uD7w8M6teQKX9Cw7ChbfEyInhIKYm60ywc6VhtDGylkiWupGn5g2oT1lpFC08bOptZlecm9ksXwA/0vuHCPoAPucBsMugmPHcs5kj4lqawNVcFDKW6ktjycpcOZHE/yEjM0dvhYPNsoQtBVGIwFgGm1dmSwoBkjPR5s/WkLG5BsmENgU9GSIU2uDghfB8vjAY4hvWlBxN+gy41uGliL97o7V7lIQ2TGblL9IUAh47YVOFOi+oDQJ4HxSl0nSzKle1QhbW7xjxOo4W5Vo+Sp3GWOzroMLb9bhg0V05DxxGvvxZJvhk9vnMO+vbR7wu71cFJ9//s/rAyZTmmLLYCU60TwORNG7gGHtZGvE0me0DCOe2B/5YVDz2jyjktF6xz8ltxicL1buZsGU8zQ69gM8JPojw0gy7vssq/vjPP4w36Ujxyeh9u55lsIAfPEZlhlcUXVoGEszBwNOZT+DmFAveA6EjDV3bfg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVNwTkY4RnZjTzhINi9RV0RnZ1ZuMUFzMkhzNnFZU1QxK2FGRUJUUzBnR0dL?=
 =?utf-8?B?QWkyZnVDMEo2alViY21wS2kzekpTZ3VrYithaVVBamhTZTh4K2l0NE9oempz?=
 =?utf-8?B?Z25yZW5PVXlMRmhocVdyOGRVdEZ2VGZta0gvVFF6REZvVjBvSWU5d3JxbUox?=
 =?utf-8?B?Y24vWjV1Q3RoQ2h6ZjlOcHJNUmk3ZnlBeTVhYTVkbHI2MENiR3k3dEVvVFNP?=
 =?utf-8?B?dTIzeEprRjZRM2gxZzl3NE42blRiWG9DNnVrL05RT0Y0SDJpRFYvcHB3RVZT?=
 =?utf-8?B?bVhHMHJuZEh5RkFqMllieDBpR3MxajdKQjBPN0hnTVpIUjhHSCt0SSs2T0hu?=
 =?utf-8?B?SC9DWXFzSDN1ZFpScmlyTEZMTUxhRlZSeEFNcG9uYnZweGUrMWFMU0hvc2tQ?=
 =?utf-8?B?cFhWd1Z1Mkk2ZUEzOUVoc2J1alJmSzZiYllGeFBWMEc4dnRiTUtmd2NhdVZa?=
 =?utf-8?B?c2ZMYkduUy9WWXVDZnFkVjJjQjZyeHF4RlZaSTR6TW54Y3RRY3RidkhMRCt3?=
 =?utf-8?B?YzRTV1ppNFJVYkFwbFluY3BVZVc5eTJMcUVFTm5CNkFIUVdoLys2cjFlOGVY?=
 =?utf-8?B?RkhNLzlwWVIvT0JBeDg2VWlsY2crV09vMWpBNEVrMjNvWXdRL2Z1cnhPbXNH?=
 =?utf-8?B?TFJwWENSdGU0azlwbmJRL2VmZFZHU3N0ekxLVUMrcU44T2t6QmNEc2hxYk92?=
 =?utf-8?B?ZHJyRG1kNmVNV3hGTU41R3hxcGgrYTEvYnJrT0FBcTU1cjBXb1I2M2szMzRW?=
 =?utf-8?B?Um9Xa3E5Wll5N2JzaTR1MVl1K04zanVpc1d0SkRlZ29SQTlKdW1yTXRLQk1U?=
 =?utf-8?B?WXRUcithVHVLZUNONHRMNjVlMVYrUkp6Vi82RW5MWVpabGxWQ0RIV2N5Z0Zu?=
 =?utf-8?B?RmRMWDhLM1N2VFRpVEtnY1BpNGxEY0lKZmU5RXNYRjlZUFNVeXhVeVJrQXlr?=
 =?utf-8?B?U2x6QktpUlZ4dDQyTEZqU3N2NTZJdVhjeENOb2ZlL1doVnRDM0xGV2hUK1Av?=
 =?utf-8?B?OExUY1lscUZrV1hDc0Vlbkhra0JST0kwQWtxWUtIOGYxbTNkaUw5WTUzYmN0?=
 =?utf-8?B?OWtMN2pUL1UySTNyNWJzUzZRa3c5VTlnNklDR1lEbVIxM0JMYnlLN3FWZ1FI?=
 =?utf-8?B?dEhLQmk5YngrSC9ad0hEZmdxdU4zcEgxUzRvNGNMSjlXVnEzaW0rZnlESGNW?=
 =?utf-8?B?L3hmbmRuWml4RzhCZERRbFBHQ255SFhRcHMvTkZMTzRQSFZzbjR2VU05MWZH?=
 =?utf-8?B?c0tkL01SdjhoeG5ocHpYUlJYSXNvY1pmL1h0RjR0bTlhem4rY1YrUmFYSXQ3?=
 =?utf-8?B?R0JIMEowWGhnbmZCZmtNQUtyYmxnOGRTMlA4NXFPUlFFeHNCeFcrZXZ3WE9L?=
 =?utf-8?B?ZGd2NFNScXdmTHNGcjUwVldMcHhleE85MDdjaTNLVFdpellyS0RkdHNGdU5o?=
 =?utf-8?B?c1JmVWE0eUZVRmZrWVpPQkVBbW9ZN0x3SStPUWJvK3RWYW84b3l6dmtUbnJH?=
 =?utf-8?B?ZEV6dFdiQTBCaFJ2VVk0em9SVldya3gwSmRPeWY5aW04TDRpb3hLMkdDbFZJ?=
 =?utf-8?B?RFRsQ0lFMGRWMzBvMnd4cEdNQlZmdVZ5aEQvcW1oZGl5ODZkU2pEV2tVZS9W?=
 =?utf-8?B?Q3lYTmU2VXY4YW84SmlRdnNzb0RxSkJqcWZteURBY2ZGSjNmUUxsLzUyY3VN?=
 =?utf-8?B?M3pVUGt2ZDgrZDhyZHRMOFNsMmhTc3ZJQU9WdDNkd2ZCQWVEV1FwN21raTlM?=
 =?utf-8?B?NVlUMmxvQkdxem80bWZ4eXk2Rjk5QTZyQVhwRVlLWDlKR2RkcHpJckJpc1pW?=
 =?utf-8?B?V3dFbmpVRit5SlpvYkpjWFh0OEgzclJJc28rTmtlQnhUODhFS2FRSHR1UFp0?=
 =?utf-8?B?RWRQdFV0THBpdHgzOTFEVjZWUy9VU3pGODNsU3lrcUZDeTdhaWxhaEh5b2Vo?=
 =?utf-8?B?MTQvQW5Id0JXUStQZ1dJczZlek5TSUNrMTFrMzNIQmVjNisvcitqWC83R0R1?=
 =?utf-8?B?L2ZrMUFSUWxpd2pveVhMYjNDLzdDejkvK0V0Zy9qMU1tSldlSzZEWHFVRXFG?=
 =?utf-8?B?VlcxQ3c5RGw5WFRScXFSbVBMa3VZMC9pNGxPbUFCTUFGNlNOWTB1Wlk3ZnJD?=
 =?utf-8?Q?cwZpyGHySJEpioTP/HfqN6fZc?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508d52e5-9795-4622-c64d-08dc361aefa8
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 16:00:50.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH12GynR6iLHD8bfKopYbsNw5v2B7706e17Ln4RGI4TcDchWLfu7jvOBy5Dp0sIUEZok30KEpwWd+rWXXSt32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3462
X-Proofpoint-GUID: D6-NI9FV6mn0-hlb4r52xkp3OObMHTjv
X-Proofpoint-ORIG-GUID: D6-NI9FV6mn0-hlb4r52xkp3OObMHTjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_18,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402250127

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

WoM is a threshold test on accel value comparing actual sample
with previous one. It maps best to magnitude adaptive rising
event.
Add support of a new WOM sensor and functions for handling the
corresponding mag_adaptive_rising event. The event value is in
SI units. Ensure WOM is stopped and restarted at suspend-resume
and handle usage with buffer data ready interrupt.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 237 +++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  14 +-
 4 files changed, 261 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0e94e5335e93..fca7fc1ba4e2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -332,7 +332,7 @@ static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 			      unsigned int mask)
 {
-	unsigned int sleep;
+	unsigned int sleep, val;
 	u8 pwr_mgmt2, user_ctrl;
 	int ret;
 
@@ -345,6 +345,14 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
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
 
@@ -439,6 +447,16 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
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
 
@@ -893,6 +911,202 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	return result;
 }
 
+static int inv_mpu6050_set_wom_int(struct inv_mpu6050_state *st, bool on)
+{
+	unsigned int val;
+
+	val = on ? INV_MPU6500_BIT_WOM_INT_EN : 0;
+
+	return regmap_update_bits(st->map, st->reg->int_enable,
+				  INV_MPU6500_BIT_WOM_INT_EN, val);
+}
+
+static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, unsigned int value)
+{
+	struct device *pdev = regmap_get_device(st->map);
+	int result;
+
+	mutex_lock(&st->lock);
+
+	result = pm_runtime_resume_and_get(pdev);
+	if (result)
+		goto exit_unlock;
+
+	switch (st->chip_type) {
+	case INV_ICM20609:
+	case INV_ICM20689:
+	case INV_ICM20600:
+	case INV_ICM20602:
+	case INV_ICM20690:
+		st->data[0] = value;
+		st->data[1] = value;
+		st->data[2] = value;
+		result = regmap_bulk_write(st->map, INV_ICM20609_REG_ACCEL_WOM_X_THR,
+					   st->data, 3);
+		break;
+	default:
+		result = regmap_write(st->map, INV_MPU6500_REG_WOM_THRESHOLD, value);
+		break;
+	}
+	if (result)
+		goto exit_suspend;
+
+	st->chip_config.wom_threshold = value;
+
+exit_suspend:
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+exit_unlock:
+	mutex_unlock(&st->lock);
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
+	/* support only WoM (accel mag_adaptive rising) event */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_MAG_ADAPTIVE ||
+			dir != IIO_EV_DIR_RISING)
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
+	/* support only WoM (accel mag_adaptive rising) event */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_MAG_ADAPTIVE ||
+			dir != IIO_EV_DIR_RISING)
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
+	unsigned int value;
+
+	/* support only WoM (accel mag_adaptive rising) event threshold value */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_MAG_ADAPTIVE ||
+			dir != IIO_EV_DIR_RISING || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	/* 4mg per LSB converted in m/s² in micro (1000000) */
+	value = (unsigned int)st->chip_config.wom_threshold * 4U * 9807U;
+	*val = value / 1000000;
+	*val2 = value % 1000000;
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
+	const int max = 4 * 255 * 9807;
+	const int max_val = max / 1000000;
+	const int max_val2 = max % 1000000;
+	unsigned int value;
+
+	/* support only WoM (accel mag_adaptive rising) event threshold value */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_MAG_ADAPTIVE ||
+			dir != IIO_EV_DIR_RISING || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+	if (val > max_val || (val == max_val && val2 > max_val2)) {
+		val = max_val;
+		val2 = max_val2;
+	}
+	value = val * 1000000U + val2;
+	value /= (4U * 9807U);
+
+	return inv_mpu6050_set_wom_threshold(st, value);
+}
+
 /*
  *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
  *
@@ -1326,6 +1540,10 @@ static const struct iio_info mpu_info = {
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
@@ -1706,6 +1924,12 @@ static int inv_mpu_resume(struct device *dev)
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
 
@@ -1735,6 +1959,12 @@ static int inv_mpu_suspend(struct device *dev)
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
@@ -1743,6 +1973,8 @@ static int inv_mpu_suspend(struct device *dev)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
 	if (st->chip_config.magn_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
+	if (st->chip_config.wom_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_WOM;
 	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
 	if (result)
 		goto out_unlock;
@@ -1767,7 +1999,8 @@ static int inv_mpu_runtime_suspend(struct device *dev)
 	mutex_lock(&st->lock);
 
 	sensors = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
-			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;
+			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN |
+			INV_MPU6050_SENSOR_WOM;
 	ret = inv_mpu6050_switch_engine(st, false, sensors);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 5950e2419ebb..519c1eee96ad 100644
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
+	u8 wom_threshold;
 };
 
 /*
@@ -256,12 +260,14 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_INT_ENABLE          0x38
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
+#define INV_MPU6500_BIT_WOM_INT_EN          (BIT(7) | BIT(6) | BIT(5))
 
 #define INV_MPU6050_REG_RAW_ACCEL           0x3B
 #define INV_MPU6050_REG_TEMPERATURE         0x41
 #define INV_MPU6050_REG_RAW_GYRO            0x43
 
 #define INV_MPU6050_REG_INT_STATUS          0x3A
+#define INV_MPU6500_BIT_WOM_INT             (BIT(7) | BIT(6) | BIT(5))
 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
 
@@ -301,6 +307,11 @@ struct inv_mpu6050_state {
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
@@ -320,6 +331,10 @@ struct inv_mpu6050_state {
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


