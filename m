Return-Path: <linux-iio+bounces-3062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B36862B5E
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341EA1F212FD
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068B1759F;
	Sun, 25 Feb 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="tXOXa40Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A015E8B
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876876; cv=fail; b=ZB0sD9bzjo5tRpx2lRfxzzzyW9XwUH3PE0lUp/EEu6Q9PR9otM5i2VG+Ikk5SwzdcUhosrO6ZuZoGlGG4/nN0UWxGxX2FGGlXPZ65oTTEXMmIwiaznWhiQ4AJfPxGQpjvfbsYuDFa24zwQA2Tz87AAk8GZm4GlhiLw4Gut6I1yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876876; c=relaxed/simple;
	bh=lLK8gAAtBfOtcLc7UyjjTRc34DLLT2Kmn1OGK5x8yoc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rqoa9fe/nbgqhDYh4F9JXGkTD7vsIetSDpTggxKGH3EB9aEouFJk5ubI086Wvg8NaOaJzYm9aRkyTH1VoAEu1zB3fVTdU3bF7QTudUYV/M5nJ/t4PgtrMfHB06JvJ3PPST29bX3iGgBzIz6lrP/cZPCdgivIoqVx+UUx7gs1OqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=tXOXa40Y; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PFo2cg018247;
	Sun, 25 Feb 2024 16:00:57 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wf9tjrf3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 16:00:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV1s5yTlFKSViz0zK3NZvlb1ORhY+BEHqP1jz6HcOT5Q+IsaFWi+LvvQ+cuv4NeQlAdlX8oVrnP6G5I9cbd2c5iQ+UehetI+dfby0q4aLnbMasbuFmCjtpWk8ZlzFOo/S1aO7x65zcd/7PxQ/NrX0N+YtLG8podVOu/9SMDxfwfG09xOLMicV25wW7/3LnHHgLJWhtkc+AOC1UXI1iopY/HP0Xl569e3fTLDyzuOmrlTsx1raRB3WbzCb5db03y6OEMNU/YiA6U/NxmzXsrRPKE27G/W6GD4xjADcv7y+uTrVW6L51FrtLDLzqQi8C38BnoRg6SjIibT0S8MBVNhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvRZqC+qXcR8VCQpidaARZEoq7qnhZN86CDBtP9JDPQ=;
 b=SBVEfKA70kyFALbTfx7mmftnatpfiBp2Var7dDKOmXrPWHkPU93jKD82M4N2zEvCaSDK0t1QW0a4Me5jpA3P9Ekpab9uZ4nM5mpzR5UJakAB65sRX7cLrkS+WF9kJ2JLtWwJVJoaw1zEYu9t1RCMPQHdubBjvUGi6LMcDuK2LVK5RPl5oKSLCZhcMQCYJS6Rals5sxA4nS3Q0guxq2xEf3tHyL4Br9sy8pCRqUi65AuaGwKm+/9GEBf1MUu2f5K6ucKd/qUXe0RAK+pe7tW9d4den7Sm9igVUjtktTU1QTKkHUnBPd6swF4lc0aKsz/SAJJ+Lb2oioaE2F6Qx7d8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvRZqC+qXcR8VCQpidaARZEoq7qnhZN86CDBtP9JDPQ=;
 b=tXOXa40YYvWlwuyWXbPcwrnsn0sdiYWW7eKp3AxxTCYoYfGvpUq+ObNgw0KxqkGfz9fKGniATADopP2aZ7a5e1ctOjrYtgM6Z7WnfRkqJte6XhS3rt1fb1EOtFW1Ch/8qLTtlTPPLI8Gh53JYVE/XeCUyaGC6ZMLUliiKekGRLeZ5T0oobX9C+58yFvR8lvNFOBwaTLp3IHj7Ei0s3FtdMDslERsdwiyBFulSZTvGxj7T+0pItzUX2jWd7fERzgKHhZ+UXQRPOg5S9zQ0GdOQYIzg4I0T6c5NmtbGO3IkTIFJV0uEXJmPp/I9yMjeO95EJQtMXAo8qSRBC75h7CdBA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYTP286MB3462.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Sun, 25 Feb
 2024 16:00:49 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7316.018; Sun, 25 Feb 2024
 16:00:48 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 0/4] Add WoM feature as an IIO event
Date: Sun, 25 Feb 2024 16:00:23 +0000
Message-Id: <20240225160027.200092-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 50b53bbc-f8c0-4389-eac1-08dc361aee65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u69Xzzha3B8ZV56deBroJP22KbkV1dZbWHIfgSHWHjbkDg5VzNDwj28EgeDhYPaUcDqRyNk5p8ePP4JxaQVR6t89UIjpcwe08L8Cobhk+W1LZK5gd80uwm8lEfX3tdVVQfFKFIiARAH5fg2FaExhw94YXSF9lcPxfdYJPE/DJ9dIHEOtAxnMbELd6J7ALNpqCab08R46xxZdheGmId+okFhG3M1uL34OLaoaCs2Lu4TEEahm88cLRhF4VphrEU/2pNYlJnSjhYkWcT9MW/3jhKGunlcu+HjRvck3a32qu7raH8+KXOgWjvz1dNswEJZ6f4pFQNqfYdJSjfxBgW8PKNZfPZFky4B6STbr7BoTodGGaDLMotybG8oFdjcdsMrVZpkRRhpnkFmYZr/bOHLjx3Oh9HrGGpnaIILNZdglp7DxELsnVH/MF0Yl9lbnrmM10q0maI959LEiWWwBbaGl4Hkfx6dWglyBM1fHkG6L1Lt2YE/DcC6P38aKMRfKoqpFK8i35tSBI8AAh3cUqJ+m7kb2Win6f7XsFB+RjHcTKd5u40swnA/CNeRI+x3cmLxXp/4lIULe7JvwE061QEk6l5CtpWnPJJKPLoeEJ2AZFnv3fk1R09uNzS9pr4+xZUBj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2J6fPlf5hgKyYYGCyBEij+KcztP7OnNhmr/aA/a2Mkw5GD9Pl6gDKm4g2vbi?=
 =?us-ascii?Q?8TM3zVuhaV2JGxyLoJRrAe7O1C2sdA542SbjDi14ZWDaCo9SsfWA+EA+H5nD?=
 =?us-ascii?Q?b84cEMaBKfX2lAjFfxDkIZzlw3kJWl68i8Xdq7J3rOVc1xvEvwCp6PoeNI6r?=
 =?us-ascii?Q?PNjokHFmet9y/Pf8SH2D1z4Zm4uO19gzsE8r29PWJQGUCq8qGit20NIcfjWx?=
 =?us-ascii?Q?fIOtPhCN2VZ9x6BYZ0ds8Dgs4tpiqEF+n9h9KVPAPC0q2I19IT/tbRD4NNuW?=
 =?us-ascii?Q?KfMLeJwRz8mLj6G1XMstkcJlJdtLHbhi83KKD/WuOO8JyFd00qzaVdTqdFbz?=
 =?us-ascii?Q?H1aCQQjSxUX7/aiBgTbIYLZETZgRa42ivfEYwMm0s7BTBPUGNXpilz9NDYdu?=
 =?us-ascii?Q?ANAuwIIJ8tjo4PIk60DJ9YNl6zjSbciNLl6/GTmPAdqwmpNaxgkQqQDQRPsX?=
 =?us-ascii?Q?k4If0DqsZ6h9JwQGWkVObnZ/fohkQm2FW0GuuYW7BT1cHWlJ3f9dKEMDV+Dv?=
 =?us-ascii?Q?p/RspXTPjm66pKee05jtB51RnQFbaibEDwNZHBh0TdqchID7nRTxBzVV11rg?=
 =?us-ascii?Q?zQZqRQqtBEOrXkr3Y4H+h282Trkext2Q24A///YBo9otkdimypKAUUYzQ2NZ?=
 =?us-ascii?Q?ScGWZOzPIHm8ygXit3W8v9UIs9MlBoj+rgT+s1n/ImQL5Xu4Q1JDxS+hbgns?=
 =?us-ascii?Q?nYyWPIZ+zFyj3Rmd6crbaI+KwLugoh01IBi3SGOaCfx+lZll89kwBoylaKng?=
 =?us-ascii?Q?16j3ygzhET/3+R/tz1GWyQf5ZI0EuX3u3mVItsOOgSFAYwFJz3YU14OSKmnC?=
 =?us-ascii?Q?eUokjSS+KP9QRJRfOT6hhTd05dp9egksOkK6kpMdP0wEOZAodAwNJifN+jRO?=
 =?us-ascii?Q?QC5nxlV3a6thVI0mYY2KjVx2T3gDLglDAJkJANiYvRfuzHu1vjNGU7RFs8k9?=
 =?us-ascii?Q?3A6iAXLjZaAt5kPL4TnUziL0mcdra0rDM9jpl23mGW/QlznFbXSjV4CrftuF?=
 =?us-ascii?Q?/ZLuyq3ptYlrEPOCB0ybzaRQN7cIBxspgDBcRu8K5ROxwTeYS8tOYycmAaGB?=
 =?us-ascii?Q?c7Up9geXvFvDExn3Bc6rP4RvW7yFNIDhe06n9jgov61+Vz6WP/yLSpINlpew?=
 =?us-ascii?Q?kDxnRGC6eTBe5rkdZNsFikuhTDS+FR7vkBfREgwtqUhU84T/35w/AiPWmSk6?=
 =?us-ascii?Q?k3cwZJelO2aU/LWAF8Iyix7NltvIFfWgFqfWgMflWVzdHtI+rguLc+BT143E?=
 =?us-ascii?Q?qS6cKs6Or5W7WaQ0bVgjJ4jn1cSi/n1i/VQPgU3p8C2b3usqf4iIlWqwrQA1?=
 =?us-ascii?Q?wBAGoEXt7n2mPP+y5qxcPq8FS+BlT298/WpBFmkiDWkDDFBMzAs4BMtWiEHC?=
 =?us-ascii?Q?atSJ4oGV8FlfIH1iYzrlW2S7VMZsha6e+8H3smy4WmaabSlhPsSTlbFT4bmW?=
 =?us-ascii?Q?keh01nKBGL4tqXuTIdiOi6iJuHvEpgc2NMtQ+JGF/D16LfyYRkgnX9rAF5W/?=
 =?us-ascii?Q?5ITlFWGlbqxtSzY6pk0Qh/4hdjD27EQqnJEHBZLIg1wYSenmdXHz9dxrB2nR?=
 =?us-ascii?Q?KKOvXaqKZWQYCB+JDOX177kloR0aoZtKfoqmxLAZ?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b53bbc-f8c0-4389-eac1-08dc361aee65
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 16:00:48.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDddezfBYY+Ncck2antgPfnYrg2t9LW3Ck3831DeA2/SVBvrvQrBEGkrXG9KaLmjP1zFlkTUDRzAwyDNsFoEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3462
X-Proofpoint-GUID: MkbKER1mBEDQiI7CjvrgX2Rm9XQacp0J
X-Proofpoint-ORIG-GUID: MkbKER1mBEDQiI7CjvrgX2Rm9XQacp0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_18,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=968 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402250127

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM (Wake-on-Motion) feature for all chips supporting it
(all except MPU-6000/6050/9150). WoM compares the magnitude of
the current accel sample with the previous one against a threshold
and returns an interrupt event if the value is higher.

Report WoM as an accel mag_adaptive_rising IIO event, add system
wakeup functionality if WoM is on and put the chip in low-power
mode when the system is suspended. WoM threshold value is in SI
units since the chip is using an absolute value in mg.


Jean-Baptiste Maneyrol (4):
  iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
  iio: imu: inv_mpu6050: add WoM event inside accel channels
  iio: imu: inv_mpu6050: add new interrupt handler for WoM events
  iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 523 +++++++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  33 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  70 ++-
 4 files changed, 541 insertions(+), 102 deletions(-)

-- 
2.34.1


