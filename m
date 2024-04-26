Return-Path: <linux-iio+bounces-4529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E88B3581
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 12:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F091C21436
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662651448CD;
	Fri, 26 Apr 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="GBzV+zTr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A4144D13;
	Fri, 26 Apr 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128374; cv=fail; b=J5HKuXoD6eIt7CHOZmH3S9PHPsCwhxCTq/yALLOah1bM4I+f/96Kr1ZnjBWcB3ImP0mu6n3OP2MvK6LbKRoesDb3oP8bgwFBiprvW8AhTTuRDwp6xQe7no61+g17D0W3ml0RDCMVAemIGq2+XhxYLAbyTSycQ5jX4v0F1uHxbZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128374; c=relaxed/simple;
	bh=wFwXmWtQ/G7i23WPZeHVSvHyFRuQuPTOvomm0prRZ4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xhf+wecnPwnUvDlE9FVA+Kp0Iutyf4aIgwHhtDlPVXFhIUcnX/3ueVbS2OYHZ495h7OFSFi9MJLWuVt1rFNsMVIHc8As0/A5RGF9G5ib32I1u9I3LTfOivLvSo5ZqswSTf/pzHE+DCEfLV4NJoEuI+owqIlY2ruzP/myIbRjQnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=GBzV+zTr; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PMmvhl028344;
	Fri, 26 Apr 2024 09:49:03 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2104.outbound.protection.outlook.com [104.47.23.104])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xm49gcyc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:49:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu7+1CLauFkeepHol5kWVuxD72ETjOyuoa/xZK0uvQ3i2Z/NbLeUBP2vYDALF/GPkiB1vi12q3ILDCi4ppPshoXIh9Gyc384HzcKKxm5wAsS9yitGXbsrKAj6t31VTs1bPw5k37pmtfsjDA+E0ag9j2FljxUlE655vOMlkFn3yI3n322VMsQ6nlfdu6U+icaAKozYjGHp+QaG2J+/8HCovq63jiVgNRxA+zI+CR4InBEy+W0nzKVdEJQJezouyTV4dG3obKzP2+uzJ+YAl68gveTNRHnv47j+AZI2f24PUWZ2vR6qz3ykBeAQJk508RopUAv4ZCx3CWwxbV4A3Xemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgIiQrxxvhOoMJhatfUgdZVRlW87AH6m7on934eL7k0=;
 b=LOpombgRJHLiVXVdMhDm9z341Hvfu5E1HROh2T3ggOkTTMUer8TZZiOyepg5RqlV70pcIYLvxnXqTg2BFc985PGzimz4msFpuyIU2WN0Grh7G6cfcrgyB05sTgyR0lUeYBvyboWwQofCJV3z0MRYsllnZfS/l3qXkzRi87z4rgSwJFaW+Raw3IjIVm0osTASaQTPGVppW9Rhb6gYq1NSsIelI3ziwGgM1+R5GkryzvCGUpqeBN8OQHCdOVyopQI12OalP039Nsupq0NxoYfHLmvOLqWNVJFp2SH0+wrtd0ppGXy/3eHuoSiEGkPSrHYFAGkErmtaRDxmmvSrbEC98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgIiQrxxvhOoMJhatfUgdZVRlW87AH6m7on934eL7k0=;
 b=GBzV+zTrq3wyCDC9MBhmz7ZhemTL+nSYWl4N7iL1Foz3MBL0znYnXdbM0lDUQewSOTtWG/gQR3W+VYWa6gko4FpE0tduGf4GennUuaXpPeFM6ZSBYrBtkd8gbBOdn2U0PKEEn/kcpU5TKXXUoPJirKLO2SSo+zplmVntkEfkaaG7Jw9mh+DC4aM+Lj5GVlERtFMEPBhXBEJOK0yMN7SdG7Bd6KpwdkwpJBh4z7cdiZYqVdP+YpCs8apo0Dtf9EkexzUDFn8USXQnbpIz9FikRHXBpnxZKXlFi3Kte9I29Bb6HaPSU3+Bx5eVzvawl/XlCGzyjkV0aTOaMo5LZUrGYA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3619.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 09:48:58 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 09:48:58 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: invensense: fix timestamp glitches when switching frequency
Date: Fri, 26 Apr 2024 09:48:35 +0000
Message-Id: <20240426094835.138389-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0071.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::17) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3619:EE_
X-MS-Office365-Filtering-Correlation-Id: bc836ce5-8ddf-4283-e1cc-08dc65d61816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gjZ+SZeSr4blyDV0UVSfqNBJu7Vx6xLBA/MForgKyJh8x0ZAklifXRWgFLiV?=
 =?us-ascii?Q?dbTcPGmTVv5y20gLlQsjILmuvhOddZf/qHlmp2Xs5M2rxW+to5SfWJHC59nW?=
 =?us-ascii?Q?lioVFxW9ehxzCsLSnu3JIwLZzLuSHDnJnnSC/o6n1+14DYA8X84w487TJwCD?=
 =?us-ascii?Q?bweV/0yirpJM865emGYlXKaOCOt6POOktYJX5dpE0Tm9DsGQoxUoFO/SirBP?=
 =?us-ascii?Q?27Q51LYcibLYfYxp1Tdb8Yv8kQfzUzRZM6us59VmhwDfuAkF5BhVieWkpBpO?=
 =?us-ascii?Q?svhLeKhTv68OedQVC+j+ozWNNUvrCaBQ0DY4KxcE28iCClOHLsF9q6I5rS7k?=
 =?us-ascii?Q?KIcIWatZMdTB2vzp/JNW9I0D5+DR4vAdSefgmYLBjwpe8UF4xLFjspandB55?=
 =?us-ascii?Q?sSCrNXiS0e/kIrh6fzXXOfTFbtMSVwKJpvrVyXqxprWAztN2sAoOebpehC22?=
 =?us-ascii?Q?9dYRKu3FT0utKuVz/WlpusmdfZOg5ENgtRrv1hASjd0r5HBVqXtHy2BYkOoT?=
 =?us-ascii?Q?CXaDVy2+j3dMLDBFUTk07e7mPYpsaAWZh+n/ujuFVnTSBqy33bhmkSu0V9Tt?=
 =?us-ascii?Q?uKCn3m5cT0ye/muWR7dFIui2rS72oRHkPPA6cEensnItxiSNeNqHCzmQNdZu?=
 =?us-ascii?Q?d2nKlqAMh80Fm/jo5UBIzzv+XXLnRj+aMSZPmSAYUpoer/eXBh2XVkwABaBo?=
 =?us-ascii?Q?VnFt39r6BzRgIDurGDlmD9oHU9/tFuY61ykU/gzfOdFKvHpZg1dqzY7BaX48?=
 =?us-ascii?Q?HHi+duI3V8LmlIpvx5X+3/hoFX3zlIRIU/GrlTN+iIt/TE/1YNPWhp6GPDVF?=
 =?us-ascii?Q?TK3RxuegAv30df5wY88ZtN2Zil+cvXNPBhu5SyfctcFWceayI7XE20xbRDVk?=
 =?us-ascii?Q?5ISTfr7QpWyB1vRsw8ynPaf49FA59AcyivJ7GDLjSt7yFpnVSVqv7tYP83PC?=
 =?us-ascii?Q?JsN33fwqUafX+7jiEI0HDFfpa8OruG/z+rok1RpBLipfzhumOZoGKqXpvlm3?=
 =?us-ascii?Q?I/rBOBgr8Y94rGwnfIILpNacgLtOe3J5X9l+yZOX3KC6Y2MXpLFGEUGwM5YF?=
 =?us-ascii?Q?P3PeiI44Kz2FpXHS7F5eY/bPvfvXGWvPFGw/hfXx6mmnrN5APe06EcUALi2v?=
 =?us-ascii?Q?Y2QKS4jbVicZ7zBAzAHRl0gKssj8Vy6bjsE6CatFtgSH4anTtcYjMVaof1KP?=
 =?us-ascii?Q?t2rq80XWPcv4xbCO6FJ1lMKCN6GEqXF2e8YGxYANRJ1RYFfGfOSp5WGiKdob?=
 =?us-ascii?Q?+fqTQK1mGtkuixpQdg49FIv1lOTOQ8DItj7NEoYjUuojTcajP/e+fCxw/Afv?=
 =?us-ascii?Q?szE0o/O8S5d1h2EdmneM6aokFbTusikQWQICUJcjaOfT0w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zrVc6aDv0i88Ez+uPjt2SYfvPhhhF1rinQW9nZeBFq9w93GCngDQw+2xpflG?=
 =?us-ascii?Q?Jtubx23v56KvPbNcpFefoqGcZV7dWsJ57OCJnOlsjyx5EedWYAjacvSNa+gn?=
 =?us-ascii?Q?i46vwGL4p4zWDG27s6xSOCdu+S9gGDnmqKzSHkrahUsmTseK/ptMbMe7/kkU?=
 =?us-ascii?Q?cC4z8CPXSDaj7MR61DGqIr50O/KQPXHptwGydt1W6//FUfRAVEAMkRzT0Mpw?=
 =?us-ascii?Q?sym/7K4a5+AG+4ASkq+P3Fm8Tr+3MQrfZGqRP8mE6DkKozVPpGYWDlOuxx+y?=
 =?us-ascii?Q?5XnFIllh0/zVhFl32qdad58r2xXbTHYXdYixqLXJ91mUJZd/KC7ELHOwbCKB?=
 =?us-ascii?Q?LzLCgHsRjnvCLYmcg0q3X7rhMlZkxieBphOhrz/MuvKKqc/62BWFMQ6piVeL?=
 =?us-ascii?Q?O5QBZ5OlWhrYLISgFF8RYZt0podp33HRk1LXfg/POrlo6ZMZ4PcBG1oMjzlq?=
 =?us-ascii?Q?GmbQWESeBHOwlPH5abkb4uIhw4ZDpKkXQlwlKPTY60DGjy8lnGudaWckOWra?=
 =?us-ascii?Q?dN3m5XrCOHE1QPapjMl9LM76ArMNT99X2/vHQOTLm3WLVZl3VMf/EZh8VVRi?=
 =?us-ascii?Q?utmRA2a9bOTjDOijoPueezTmxPxPcxZOC5RMsDCOk6RPPSa7TXOwk34h1bpB?=
 =?us-ascii?Q?eGyjr8IrGJl9xZkBkkKgFAbxYFmD8E4hYpXqnP3pZK5IlKXOCNrmpTU5TMZ/?=
 =?us-ascii?Q?vjUPfd7bIchNkx9s9SAgk23gL2ciCe6ndJVbhgKo6OZzsvpoKfFeASHGUlHn?=
 =?us-ascii?Q?g+olX9BUM6a9LY27lcSUzVRRilCYJf9ETl622PmhJ4BkVzvLIizK4oMfKqko?=
 =?us-ascii?Q?AupCDacLCc/ZjCBNpIrEQlEp5nLTOQLMDjcGLSmrU5iRaUbAbUI/5JxY6Mab?=
 =?us-ascii?Q?ZR1BF/5B5n91W6lk7dY3ZNny3IN9OeZ43fTeloAXujPe0Ruqv8VMFu9YH8fg?=
 =?us-ascii?Q?syxAuHBv3R5JeRL2be0TvrPLjRp0RHig8z47f8NpyHCa3pOwVXiL9msalBiN?=
 =?us-ascii?Q?4UzWmruk2jggZzzEBnEgPZs7mk9xgSeMmw9hpcCvsgXK6AtKOi1WDIZnyglI?=
 =?us-ascii?Q?tmZOBXaZBGIQklzVYaiJCJWwMvRPlM1ElTYLKgcfFRX62+AIrQSs9dkH56j6?=
 =?us-ascii?Q?UmQeJvx5/ZvBrKNkpWHTbQHLP7qeLECB7746mLAR3nMWvRLqETCNIewBLC/K?=
 =?us-ascii?Q?CquJhFhjr3M//VH7GU5Pbu3HPrf8Xy0LjcB+0S/I69qt3ETOpFsm/BrU7zZ8?=
 =?us-ascii?Q?nvWsID6un9OFozC56Gc7BxDrvx3oBOcakc5//80ais5HerbRCZ/Aoa2fL07U?=
 =?us-ascii?Q?6wWcLgY52ktM4LuhcTZMFvGfs2jEWPoQYV5r5RVGn0hhh03VuyYcZYdg1rCm?=
 =?us-ascii?Q?rgxpOK78V46F/t9z8pC3R8I+9Hi13yCdp536PhgWjlkcIBKFr+gfk6KoRwMu?=
 =?us-ascii?Q?a9GBDHvUeOpXDRFqDkBRlDfE70SmuCbUbMUB8tPORm24yDM3N/yfMWQmaSoe?=
 =?us-ascii?Q?0ZNAdmpDoRPFIuGsvz0J5nD4fMQyoV/2xZ/OtO992aWHNNYXhdRdQwIcyWxb?=
 =?us-ascii?Q?HIUmykt6hOFgJYUa7dDe1x/0zMR4b76dFZ12A4zK?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc836ce5-8ddf-4283-e1cc-08dc65d61816
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:48:58.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9CrHkeVXLaN9rEm3TuYJSRf2evOi5Xbe3yRWVFEiQ5rLCOWhAeRgKuJhEd/zk/h3Y98QioJTckEs/blP+62aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3619
X-Proofpoint-ORIG-GUID: 4PCcTQUz-094t3miCFK4hXP88CJ5YHWB
X-Proofpoint-GUID: 4PCcTQUz-094t3miCFK4hXP88CJ5YHWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260063

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When a sensor is running and there is a FIFO frequency change due to
another sensor turned on/off, there are glitches on timestamp. Fix that
by using only interrupt timestamp when there is the corresponding sensor
data in the FIFO.

Delete FIFO period handling and simplify internal functions.

Update integration inside inv_mpu6050 and inv_icm42600 drivers.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
CC: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../inv_sensors/inv_sensors_timestamp.c       | 24 +++++++++----------
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 20 +++++++---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 +-
 .../linux/iio/common/inv_sensors_timestamp.h  |  3 +--
 4 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 3b0f9598a7c7..5f3ba77da740 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -70,13 +70,13 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);

-static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period, uint32_t mult)
+static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period)
 {
 	uint32_t period_min, period_max;

 	/* check that period is acceptable */
-	period_min = ts->min_period * mult;
-	period_max = ts->max_period * mult;
+	period_min = ts->min_period * ts->mult;
+	period_max = ts->max_period * ts->mult;
 	if (period > period_min && period < period_max)
 		return true;
 	else
@@ -84,15 +84,15 @@ static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t perio
 }

 static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
-				    uint32_t mult, uint32_t period)
+				   uint32_t period)
 {
 	uint32_t new_chip_period;

-	if (!inv_validate_period(ts, period, mult))
+	if (!inv_validate_period(ts, period))
 		return false;

 	/* update chip internal period estimation */
-	new_chip_period = period / mult;
+	new_chip_period = period / ts->mult;
 	inv_update_acc(&ts->chip_period, new_chip_period);
 	ts->period = ts->mult * ts->chip_period.val;

@@ -120,16 +120,14 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 }

 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				      uint32_t fifo_period, size_t fifo_nb,
-				      size_t sensor_nb, int64_t timestamp)
+				     size_t sample_nb, int64_t timestamp)
 {
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
-	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
 	uint32_t period;
 	bool valid = false;

-	if (fifo_nb == 0)
+	if (sample_nb == 0)
 		return;

 	/* update interrupt timestamp and compute chip and sensor periods */
@@ -139,14 +137,14 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	delta = it->up - it->lo;
 	if (it->lo != 0) {
 		/* compute period: delta time divided by number of samples */
-		period = div_s64(delta, fifo_nb);
-		valid = inv_update_chip_period(ts, fifo_mult, period);
+		period = div_s64(delta, sample_nb);
+		valid = inv_update_chip_period(ts, period);
 	}

 	/* no previous data, compute theoritical value from interrupt */
 	if (ts->timestamp == 0) {
 		/* elapsed time: sensor period * sensor samples number */
-		interval = (int64_t)ts->period * (int64_t)sensor_nb;
+		interval = (int64_t)ts->period * (int64_t)sample_nb;
 		ts->timestamp = it->up - interval;
 		return;
 	}
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index b52f328fd26c..9cde9a9337ad 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -509,20 +509,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		return 0;

 	/* handle gyroscope timestamp and FIFO data parsing */
-	ts = iio_priv(st->indio_gyro);
-	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
+		ts = iio_priv(st->indio_gyro);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
+						st->timestamp.gyro);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
 	}

 	/* handle accelerometer timestamp and FIFO data parsing */
-	ts = iio_priv(st->indio_accel);
-	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
-					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
+		ts = iio_priv(st->indio_accel);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
+						st->timestamp.accel);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
@@ -550,9 +550,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,

 	if (st->fifo.nb.gyro > 0) {
 		ts = iio_priv(st->indio_gyro);
-		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-						st->fifo.nb.total, st->fifo.nb.gyro,
-						gyro_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
 		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
 		if (ret)
 			return ret;
@@ -560,9 +558,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,

 	if (st->fifo.nb.accel > 0) {
 		ts = iio_priv(st->indio_accel);
-		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
-						st->fifo.nb.total, st->fifo.nb.accel,
-						accel_ts);
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
 		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 86465226f7e1..0dc0f22a5582 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -100,7 +100,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
+	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
 	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);

 	/* clear internal data buffer for avoiding kernel data leak */
diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
index a47d304d1ba7..8d506f1e9df2 100644
--- a/include/linux/iio/common/inv_sensors_timestamp.h
+++ b/include/linux/iio/common/inv_sensors_timestamp.h
@@ -71,8 +71,7 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 				     uint32_t period, bool fifo);

 void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
-				     uint32_t fifo_period, size_t fifo_nb,
-				     size_t sensor_nb, int64_t timestamp);
+				     size_t sample_nb, int64_t timestamp);

 static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
 {
--
2.34.1


