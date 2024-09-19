Return-Path: <linux-iio+bounces-9659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D6B97CB9A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC83B1C2293A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7019D093;
	Thu, 19 Sep 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="UpVsDlmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F91EA85
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726759652; cv=fail; b=G2biKbCc2SwovkzwT/RXxe5n08tNVZMuE0Z/EjwYtGeSzRIV0m+UXLQufHALetathAb8vMeOb75dgUxM9tEvEW9cEAj6xPm47CLaWxr5+05FHRcfrkLywXuebDEsLcgz4qDLT37666M/IB2orUgXa23i77znhnl9RdM7dWTWEOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726759652; c=relaxed/simple;
	bh=+a9Z2hu5Mo1AL7p+LEPZflOHQjL2mlmv4N+7bwP4FH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XV3hwVK3yOL+r54zZfzWpzwkrSXgnOu6ZuVTywFhZKWDBLCI82rLsij55vg0XpRusqlyn7gQi+mHP9HVHh/TN2pWBIjh7mW6/M0FlnIi5Q85eBe0Tv+IX3nyVg1QS5++eFYSE3VLHvyhXHW2DRW6b2Lls8R0X96q7SqwGmz4EVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=UpVsDlmg; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IMmljM015343;
	Thu, 19 Sep 2024 14:27:48 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010001.outbound.protection.outlook.com [40.93.73.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89u55f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:27:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXpGbXB3lVtMMJs8vUuDV9iIypnaSP53JBGjT9DRI4VcNd9vr6KVsmdVIT7eypRJHOVIqWAOOXSMI8c4ED0yXqPxX7jsEOn4ORl8uhTtUhcRJ+WP6MJXz1noc60rwEtOmNfzkhiUt1gVj8nUnZWprHornzK0O4F2I9yH8PlcDtTGADqj7xXIo6U262Uz55mH/5PNWQw0uLvEtFJTjZaSlsMk4lsriAi8NLMc+YSpjAAd3JIwYUgZkfJrtUqHoyts23GscDli/cIy70AZcibJXd5oMQADzx8m6yV1WgCrZQDjd7lWIHCwqJA0wV1zJJigYJOwRJIBjWsaVG92YSNgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUvhriuD7Xj2+Ado0Pe71smU+9eGVd08YzI2njhokuc=;
 b=c0+B305GWIDKE+yiQ2BPTYeTpg2ZzpGYfeXdp0LyG34DvDNmOHEk3XjN6vumbAH/PZwTxcPDl+CF9LCgoALxSZOrURh1oUtCbjRsw759zo+5syfGEEYE7X7i9hOdO+8sLolO8hPgvqh1Z+fagvcmCcsLXs83ZgqU+cZb6Xy5LE+Qk1pNXOGO8NLjdHZdHZjxvR3a9kbj0gIuIhl7lNhfK1bw3ctbX4QA1Cv4kyrkSi6BaDs3YHTI8jLoErRzzAp/4s9d9nU1Nnlykmb3yMMN9oKCz8FMIg/Qhbm9YITv7DCU0HoFVtIQvW32XQitsbfu9t4WajKoH7yK3rad7ay1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUvhriuD7Xj2+Ado0Pe71smU+9eGVd08YzI2njhokuc=;
 b=UpVsDlmgC1oOk445LtzLwyAYo+ttZhGbPwn5Q9eBSHcbPyMdW6D2PocqXuOp0vRVCb6zhqugXWw2KSRKr0wS42n6jQ1jdjAMISwBf3/CxYWvinHxJU5lDHrzzhEMT6KW1tPgRvvNayRZF0gY7xspZdljkPANYhSTgGvIrBwxqfUStOv18K8IAa/wU9d831M5/TOsFSh6/fCF0VTpyP4TWPNK8DTgypFsXaJiwD8hxahKVTJ7ZYSB5bJhxgjIOz7uHOkyCQHQhkdruvIevGlIHGIJQ+VJAzZuHyotgj9q347LzeVIog7/DSbXnCzyrmSqAUlKFZowqAgq2SUCAfECTA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYRP286MB4946.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 14:27:45 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 14:27:45 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: add support for IAM-20680HT/HP
Date: Thu, 19 Sep 2024 14:27:19 +0000
Message-Id: <20240919142719.162431-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919142719.162431-1-inv.git-commit@tdk.com>
References: <20240919142719.162431-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::23) To OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:174::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYRP286MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e0461b-e826-448a-cf55-08dcd8b73a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vt/Wq4raWf8gu0Xdq+Vd3qCeg1clYAFILa1vEuhzbGvssLAcitlpy3rtB3lz?=
 =?us-ascii?Q?6NeV8QgnCjgL6Ge4m68/CLDZpch/210h4H+sCL6CkexH0J+IwqLRx/bZnvtS?=
 =?us-ascii?Q?SrJ3Pe8daBUM7VMuNe4VYC0jeeMd6zrPttLR5apslhtOdizaALnT7w0OCfFV?=
 =?us-ascii?Q?SMlreu1v5+E7PDKtRDeef1yZgq2wUZXOOatUj9OnSphq6/LKXhBOjEBN7yuK?=
 =?us-ascii?Q?rAMcZhsrUDO0z7TQrl+ctBgngOdBQa6c8EnFVCmAWin0bOBDUBDLQr4Pz6eO?=
 =?us-ascii?Q?2gE5FHlBBjaSaWWeLmQXofpi6qgtXpdjoSxXjNEjI0dpWOIj6G87QM7aW8jJ?=
 =?us-ascii?Q?2+R4oFsJ368/8vopK1LI4wyH/DvOt8603ib9f4UYiiBXf0C/8GY9jA43fK2A?=
 =?us-ascii?Q?hvJaF6zsjIeFMW6OtixQeKrd/Bu5y1mZbby8bkKaL1eIevOqhvguKu6kAolo?=
 =?us-ascii?Q?+h75niRnd71zJjRRiFT6uRCMEI0HhQlstx8mKG7GMCx6JpnDH3xZtkNdAaw1?=
 =?us-ascii?Q?6depqT3aEXB6WGqIS7gYR+jXGg+yGSDyLO5aF99LcF14XVs/J3CiaDDB6fd4?=
 =?us-ascii?Q?NL+hxesQgGLBCToIR9JblbHwpB543+gczulK8wscckaWhJzjsyryVqPPEXlX?=
 =?us-ascii?Q?NZjV9CMz6NRga5rtwzSrFWOdj8gL+tiMiFtGVvIUFVAwxXVrBsCk8IFbNTJ7?=
 =?us-ascii?Q?G4+de8Vtz3IXK6HCXaLx7j1kgr8k/5W4EFj5+0uCxm9W+/ne9znyGUKgUKWu?=
 =?us-ascii?Q?PoXmEsk6gjxwk4iNpfZwDdgdcN3T1SR1stZ+VxH6hiSd8FC0egE+UNPAFGv0?=
 =?us-ascii?Q?DMgrWwMNjfAAbBS6zfA9g8rofO3iu+/L5FDzhvEqOEXE4ud2pg2L/y64Fypy?=
 =?us-ascii?Q?35Be1q0PgWQgopTFpCpn+OmkVKnrNIPiQJK5i6Phg0l8fHdj9Mu2xOJ6xnXu?=
 =?us-ascii?Q?ERoaVFDtQxjNfAFjSuHVCFY3nX3XSO74gRfIQn7THqaXsS05O6Bztj47WOa8?=
 =?us-ascii?Q?IY36q3KJRV1WhXXWUzq8FCOVv09k0buQTZgBPl+5NK4DeU49J5eorKo5Sbqa?=
 =?us-ascii?Q?+EoggSBmJvrVmCKxSCWoHFhHTYCArNpEbeQt31237Ig+ZDJg3THZJ+xN+Zq6?=
 =?us-ascii?Q?PJoOzoHoT/hnI9z308xzxMlKIHEUWP6uInf+D+0xUraXSOvAQWC8ufqp5sD/?=
 =?us-ascii?Q?kq0mS5C+U9zd68xwpfLmxnShWZFN9aItc8zvpGFk99G/fHYb9eMyPc/8SXn6?=
 =?us-ascii?Q?HbWwulUoljp27mYBNWks69/5IbB2FP2zzM66taMV3oYB2abjvOv4QpyMZLon?=
 =?us-ascii?Q?phJ+AfHPkRDaqHehPCQnaV5/ziLIwM9bkLuLCpVtFp35hjmQ3EcpsQdb44kX?=
 =?us-ascii?Q?2uEshsVIcYmMKVjIIrinSV+uHPNBPEuQe3fXWk7bJKszOBLM2vsTfBC50TNP?=
 =?us-ascii?Q?rQjnjE/j4jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpXZxXm+DredwsWx24Eq5NWNsqRIqjvxVFLzdNMlPMD1ebM/U/qjRXgqIR74?=
 =?us-ascii?Q?hypxZ7tObjU1XAhTU2KXisB76im0zaj/IjFYF0BdPMD58z/U49Kvk93y3Dut?=
 =?us-ascii?Q?Mrz7mdsHiR4ONav/2efEZ/Zyo6/Ujw5/SHHu01UZQbN/8tK+XwYiSRi4BHZH?=
 =?us-ascii?Q?c5RwJcpp5ennwj80EtzJtlrmtPlhQI3vGv9971mCjnsHNEhiLRSLpmP89Iue?=
 =?us-ascii?Q?Dx6JaJdqxTN8lg6BPRuCZhj7CuR3a+8dRRbA1adBu6wgVuxdbrzsGe6NbrW6?=
 =?us-ascii?Q?pX48SmiFjRrbeE/YQvwQL66uOfRhPsp8V9lpDP4XfsMvzGa9jM7nEkpslBn3?=
 =?us-ascii?Q?xZPaLc0eK13R2VK9LVdVZJ0Enz6Ldsz3qXTo+YucURvyOGy3aRt/zfm8TiUM?=
 =?us-ascii?Q?gyJOsJBVHLaZD2m/fDGl3DG53rq4Mgz7kl0qNHIkVeh5iuKw8Xa4fgYQG6cc?=
 =?us-ascii?Q?aPd1T1K+oDqJruF//T/geAeN0D9XOWYpXzpymz9/XHSObObmVJRw4cLTIU6M?=
 =?us-ascii?Q?xRS5xFuo14Yph2hH1MP+K7zoEui4xyJJJo1gc8zZP1Vn5V8Q29gUwXKYRfOO?=
 =?us-ascii?Q?zdsMZQzLJ423H10yJIywztjPCAVOCCkvrVsf8iAQqRRbrCIwedYpTH3zNucM?=
 =?us-ascii?Q?TkI44F8hQOM9aI0HQmile2n2y/sUFZNDRqz2e+4zdXVWPlalFBObnLkLmmtv?=
 =?us-ascii?Q?GjUbvXL+IZJq+72jT0h4lmiEKUbiH0g8rq5hVmSDkZcu2CuA/KZIGrQzJK3l?=
 =?us-ascii?Q?mJFzHdVuv9G84kyW5uvDg2VLwblkksPN3QNT3AWlYFVaRWJmsB3Y1603FjYz?=
 =?us-ascii?Q?cKtTSTmxzC3I1+ceapRpBIh3LcJvstAJ+HtCZlC3+0O9GkRC7KnBL3s2zn6m?=
 =?us-ascii?Q?O6Pycj8yzj2lXRHDCY7rGhkeSNUZAYexCyKzSZ+kCU3YjH+67jp8oPa5CSIY?=
 =?us-ascii?Q?MeNrBIBrsL9gVNrhuV/cpEm3vS+1cPpDS12dmsdqnravt2a0UL/ez9Rxa7dv?=
 =?us-ascii?Q?EBJ5o3biqgFCIWtdzX4vnqW4IvdyLcAsHWgr4YFy834gAOwkv/HxwJtOSaWH?=
 =?us-ascii?Q?weLoT6/HwgY478CvEhcyvrkUSxawZFEaVIWNNF/CaPQQZPe3HePMZb9rRbux?=
 =?us-ascii?Q?Po0WQ87gv0m/67LYoPzlUyKYqYRn5z7yUhFxdzHRmiXhmHqzFs3KDiGqNBqU?=
 =?us-ascii?Q?x0PH1sJUKbqPm+etykqbd4jK2qu3/JrXc5iiNBcvXJAO8PnzP6Qor98J5F9K?=
 =?us-ascii?Q?CBwMUDUZwJj/YEpuX7UeOtws+qG8nrWRrol4OnJObKOKJSUVKf0PU29sPRWt?=
 =?us-ascii?Q?+F5AvC315qRqmz0A4v/U+VnLEKkYTCzIsS0ZJuQkOEdUx14wWRx0X7J+np0J?=
 =?us-ascii?Q?YTGVszPirnSMucQYzqbY00v4QWYsXfZ/Xekh7qg1MA1Gzx/XCZRgl+xd7Ta4?=
 =?us-ascii?Q?VOztQpBg581Zoyno+s4muhx9etYQN66FDnxj36iP5qpe9xk9g3GWTc8afg1J?=
 =?us-ascii?Q?cgxQmYtarWGxGUvToErWKDq2CfL0Iibi3JRqX72A6d+q4BWy2JvZ6dbaGzhf?=
 =?us-ascii?Q?Bs7BAaEygFnhIaMRsJQMlpYCQph1Q3YIC9CWFC5b?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e0461b-e826-448a-cf55-08dcd8b73a6b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:27:45.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2wOTHJp0eGHR0GFev4p/jw+mKZ2VXwppinh5dvyhgWN/dWNsx4qOI7lk7ok8Lx02JXoWiCz3c17DQbY90FQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4946
X-Proofpoint-ORIG-GUID: Hn7Y6d2uKH_MBOUKxs9tUqDap0SYZ3jB
X-Proofpoint-GUID: Hn7Y6d2uKH_MBOUKxs9tUqDap0SYZ3jB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190095

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

IAM-20680HT & HP are 2 variants of IAM-20680 with better specs,
wider temperature range, and a bigger FIFO (4k).

Fully compatible with IAM-20680, FIFO is 512 bytes by default and
with correct register setting we expand it to full 4k.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 10 ++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 14d95f34e981..6b0adb7f9ae3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -286,6 +286,24 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
+	{
+		.whoami = INV_IAM20680HP_WHOAMI_VALUE,
+		.name = "IAM20680HP",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
+	{
+		.whoami = INV_IAM20680HT_WHOAMI_VALUE,
+		.name = "IAM20680HT",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
 };

 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
@@ -510,6 +528,8 @@ static int inv_mpu6050_set_accel_lpf_regs(struct inv_mpu6050_state *st,
 		return 0;
 	case INV_ICM20689:
 	case INV_ICM20690:
+	case INV_IAM20680HT:
+	case INV_IAM20680HP:
 		/* set FIFO size to maximum value */
 		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
 		break;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 0e03137fb3d4..7a5926ba6b97 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -188,6 +188,8 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
+	{"iam20680hp", INV_IAM20680HP},
+	{"iam20680ht", INV_IAM20680HT},
 	{}
 };

@@ -254,6 +256,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
 	},
+	{
+		.compatible = "invensense,iam20680hp",
+		.data = (void *)INV_IAM20680HP
+	},
+	{
+		.compatible = "invensense,iam20680ht",
+		.data = (void *)INV_IAM20680HT
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e1c0c5146876..a6862cf42639 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -85,6 +85,8 @@ enum inv_devices {
 	INV_ICM20602,
 	INV_ICM20690,
 	INV_IAM20680,
+	INV_IAM20680HP,
+	INV_IAM20680HT,
 	INV_NUM_PARTS
 };

@@ -424,6 +426,8 @@ struct inv_mpu6050_state {
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 #define INV_ICM20690_WHOAMI_VALUE		0x20
 #define INV_IAM20680_WHOAMI_VALUE		0xA9
+#define INV_IAM20680HP_WHOAMI_VALUE		0xF8
+#define INV_IAM20680HT_WHOAMI_VALUE		0xFA

 /* scan element definition for generic MPU6xxx devices */
 enum inv_mpu6050_scan {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 05451ca1580b..e6a291fcda95 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -80,6 +80,8 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
+	{"iam20680hp", INV_IAM20680HP},
+	{"iam20680ht", INV_IAM20680HT},
 	{}
 };

@@ -142,6 +144,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
 	},
+	{
+		.compatible = "invensense,iam20680hp",
+		.data = (void *)INV_IAM20680HP
+	},
+	{
+		.compatible = "invensense,iam20680ht",
+		.data = (void *)INV_IAM20680HT
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
--
2.34.1


