Return-Path: <linux-iio+bounces-3921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCCF89211C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 17:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458481F25F5C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9AD7D088;
	Fri, 29 Mar 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="jztxhbRr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9756249E5;
	Fri, 29 Mar 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728095; cv=fail; b=b9LIlv0ZWyyADDfvg01Ub/6HrL5DooNMkacMktcA6/Sw2fkvYTsG0KpRwfxAIQcrjoZkTk6KDpuqJQ/mXxVBUSV+2OkfC2yVuB3WFeTbVWkK+vr2iRizRIo6wlzLylHXyBJI1jl81gViBloLp+Z89ZxJsyza8gnn1lESSzP9y0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728095; c=relaxed/simple;
	bh=ePPATnv9nysUNtdKVSrP5wJn7lf17Wuc2ZAgdxLx1zg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TXRlPriLVfArIrxX9wUPcWfpy12ebRr9gYHi0eGs+2H4t49PN7y7KlK69FiD3ZlC6XWcJ8tVXPzh2YMB3L4ye9IfavLG2I3jMJcBbA1cRTS+7t65K4GOr6IrR4LQgdYowIpT8a4c7qLeV8kqejdOjYNqATKPH7BAf3NG+Zt7amQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=jztxhbRr; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEdxVI003047;
	Fri, 29 Mar 2024 15:16:11 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010003.outbound.protection.outlook.com [40.93.130.3])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x56f3gxkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:16:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl4By4ERqrcqUmlWuHOxYQDJNbbY2xKsn8Ig2Ubu7FoVOP/favH9cZY3tV5ZqTZebfmc9cPIWHsvVeViYwxDArMV+CZr3LO3q/UQt9Au89j3D9Cb6bw+fky+rORLTNdN63nnKeKjZ7+mHtp8zrM4Oj0gzKEoA6dTakbcJZzIk5mgHIVZgQh/IxNL54l6TrzUa+Tw5qdaX8YploeEp5OLiEAwBzdmPVKAL5EoODc2x3aoEHuFlVxwocE7Tr9ywYrC9gbR9b56rVPyoIaq8yLBt+hkmoURRKqmX/JBW42Tg7FW2cxlM/y4JJdGI0fbUowOQubz+capb1DEV9beoKI3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COS+8XhwWxcKfafXavHqMoG8vZ6qVbMTk60Wjwg4yUY=;
 b=kPAwphdpLqk5rHusyY688gSqqwCUTiLebdpTQViVc1BZJEBl7kvzXOwU+3p3LFDUiuqtqK2YYhGOw/hj4q0Ws6owO8qlEvg1Kg8l9oBQBoTcBHYhl0t6L722YWvkhpKeHLaoO45q4Q2uAm2Au3tteGoQNJtyLqba6T4nFBuZ6BJPy+z+2DEB9V3d2w69mVe7VcG++cb3iT/1reb3WgBMMHjk6LNlXI6+dlJYI20xRQ58SAZ/5FW/jXDJpYLCmvy8HYZeA9eBa8hI5ZtiFNgA6xkGkLGCHEzh6rQR2J8AjIc9wycH/9OVmqo4BM0xOcmdSl2nhe3z/A6UFUOZhygRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COS+8XhwWxcKfafXavHqMoG8vZ6qVbMTk60Wjwg4yUY=;
 b=jztxhbRrcWnSINWoQg0Ryp6f16SD21Rcki0F9M/N6KqYc/OG8D+IQRnbhhgY7n+dIh+SmeFLeEY4B41KC4M8t1uBsUC1ie9iV6Iegw1fN0qwgtlGAJ0TAAidrrqauXAKpAO7ZwJPAJx21L4RgYwjRWeuGEsrayBbThPvoInIO7L8e5nPJcVJVdqonm3XS63nwcVxqj3JZlkpLgH0DI+QD6TzSgAeI9zoc39si9V7wYhJCc3IViFE94F3qDPvIPf+rihxwOXCamtm0fdiCc8i3XeIEln/GyBFGCGZMLeEEkomn1KDvOZ7ipv4Jc4zQhTfSp9YsW8uuacjHcw/uA6iXw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3434.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 15:15:56 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:15:56 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 0/2] iio: imu: inv_icm42600: add support of ICM-42688-P
Date: Fri, 29 Mar 2024 15:15:33 +0000
Message-Id: <20240329151535.712827-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3434:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sRa95htai3nwK6oaOziWlB1e8nDO7pxwUyngpgSP0SJTKOENzTYrwmAZ/ogMWRMThNy5LkYMnaQHi1P2/MtZowz3nXFaynfZP+YRoNF815NraatSXywyTg9j4Tjue1gEhSts5/mH48/7EGL6SVzZ6vKGnH/OYXYpaK+vZVILAsovm6cbb28+SBqDNLgPIV33DCZy4uBtJeSZxJH1WdOHRnlq7JnlRNq233cSrNaAE4Gt+5uUy13fMxmJhwTxXTtM+2Tywi29ii4QxkqF4wvd5CvtaBC+e2werPYcvJQJ6F1lJYxEEqwtIZEyGu/n4syoP3e55fpX260Z0K4VNCEHjlacAGu3Aj4YHLq66CljbaJkJWwO+FSajPzRHvXmX7BdFZ4+03KTEQpVsAWg7hg2i69ByocPqJ0XAWUJTrt6Fbvy98RL5dipvCUoz8/d/CKAHyPMb3ERh4jSWiJ575hkkHOxkUkiq/y8O00C7pTQDBy9CE1RtT27pct2CtoxHKokn0dhtoHhmawt9HdCTFCTiZ4nUTcMNU6jet1EcsRXnpoGMpOa2G9xXE2Aqhfo2TLw2NroQnQNFz2mS9lE1/uSi+L20vzvIqkliFngFqDQe8cSUbVkw/2ED9llh6MooK6gzwnp2023xJYSTudH1w0dHg+7kvU6cEJ2A2Ry2w8jMldKbqTpWENakaxh0dz5faIMs/8DS2KMKar2VRTQSBXTaDRL/V3I2YyMD6pg8JL0uOscdHIbM9a68aNMVYXTtLAr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5R99QwEaQZROMFKDRn6S0EQTj5wlsHsxRW2fo4udEf/NwsbW4aFOLqhdLMbs?=
 =?us-ascii?Q?KxBzhw+Pmvu1ZQ1K+qKrCp3ODwfHuRQnlBs67yjzgbe8wDjjCMXcOPNAm049?=
 =?us-ascii?Q?638CN0eLkYQp01PkBD9RViIuZyJILbSYujlQAmW3isSqHcRKRfSQfBHyPkjY?=
 =?us-ascii?Q?oKEK5RN3UCMpKZZQFcMFqrPIsF2TN8tsFb6qIV8mFdDjcs3V9hPiaUaKPqkF?=
 =?us-ascii?Q?Nz77DrTW4MkxsBqQwU9P7H4qFSXXrpfJMt5rAyljT6z1dMVQ0ggL+u5KKbXc?=
 =?us-ascii?Q?TB+7qldvJGWKuEgfnZslEUoVy7lhRU0wY16311pb8sCVcPw4LMb7tRawC7Hr?=
 =?us-ascii?Q?RGz8i38p+1u/s87wWtrml8TGi1ksseVe94QleuN106Vi4tfD+OaO0t/e7B2e?=
 =?us-ascii?Q?vEa6PApbgnDLH/mu8Jk/J1uxQpWVLzv1Uxxlh+zyq3/Q8B7VkiAnTMzztI6P?=
 =?us-ascii?Q?GkGxBZaKhqDVN7UHcEFnDPF4URY6rNTGi3XwBgPNop66YPx7ojVN6XPlKGce?=
 =?us-ascii?Q?eMHdL8YL50p8FWs14gKKOqjhQMtTbWZSSh2pls5b/BveB8EV/ex+M/QSeK+a?=
 =?us-ascii?Q?WIiVz+wLzDeTAWy/c2dAJRVeu2GN1dgz++f3EDneo0JR6Dcs/wDWlb2zQ1gT?=
 =?us-ascii?Q?J4IuRYJUjdMaWBypH4DYZMh84IPJExj0A36/S/RyHoBYjPmJ4SzPHWDXkVjV?=
 =?us-ascii?Q?I0J3EZ9CLXXgxu55xfhyl9LEeZc7g2ioxcmYyh3nilGPbN/VGrdE8ERsQGFI?=
 =?us-ascii?Q?wc5ldbANy8KtDuYhMi03ws5WoEbJiBmAz1w72kbf/q84hVOVNZba/xQ+eAGh?=
 =?us-ascii?Q?H4xvHdVbATETL42td5CbD+OL9ZyuKvfTVzkhI3OoZPmEu4xs+CsTb17QDs7l?=
 =?us-ascii?Q?ctY3Fcw9PoYqOfDGlqBPiTgqB0Ro5KEXcQzKrj7qWTTR1qzvpssZVAyzqdu3?=
 =?us-ascii?Q?A0ROAgssbaYB+SnfPqTwE0I6O04bH5OllvcbkbQbubP4PwlcIAbIPzTKAT9J?=
 =?us-ascii?Q?BwgrfG6mf87m5QELGgONYrMt89kkpVkgbjZKMdBN3Otly9OgzDG+5PAYo8CU?=
 =?us-ascii?Q?YygfY17uMsbLijS5HcNs3iJ5GMmOmViPdrUhjAHwiLL59y9sDFJCn4aQKOu5?=
 =?us-ascii?Q?EuTyD13uFegtud40+8LZE2FYfvU+bR1B0AOQsn/CNUTIxwjKlq97n/txY3gO?=
 =?us-ascii?Q?L6cEp5VUepC1cG2x+o3fP0CCkRN0I0dVn00fDANSbOVPYSWN3I6HhapGOsbp?=
 =?us-ascii?Q?q1R4keN3ga96VUsA9vuAqhijpCo9FicfY/sq/wix0xK1Qj7kLKn5pzBzSzy2?=
 =?us-ascii?Q?dBq5S+tWxshzQf8bubXb56L/eEVInyKPPdamoojUmdaysE5UWl3rswRbSHhf?=
 =?us-ascii?Q?L1eV/Eg6vblKfi//NG8T2REpOTBiRoqWin8iRsogsx0jgwIkhTXaqIOXfOVL?=
 =?us-ascii?Q?zkEshzOa2zG+m3Qujpo7zkNEbHits79+ecoW219XoYVe60OwKEWmOzUJib4E?=
 =?us-ascii?Q?HbryqzYUFYW2aOuEmFEu8dAoGZ5+Q56NjEuUNoxDG5m3ZCTllTFYCPYGRUIQ?=
 =?us-ascii?Q?UV4ykqqYUlOqm76SqWTDhyiNDBCvvsrMsdGrP9NR?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d33d9-8870-4284-6d66-08dc50032196
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:15:56.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdqJoIvsQsLuHKCG3iE3qxS3oVVYx2eTusLwoke1co6Sm1Ni57uevyz+smwbP9zF+CKZWbQaQ2uwIE23iQhoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3434
X-Proofpoint-GUID: EQWOD5m7SwJstQNp96dwQT6VDr_FQxFL
X-Proofpoint-ORIG-GUID: EQWOD5m7SwJstQNp96dwQT6VDr_FQxFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=940 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290135

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

This series is for adding support of high-end specs ICM-42688-P chip.

Jean-Baptiste Maneyrol (2):
  iio: imu: inv_icm42600: add support of ICM-42688-P
  dt-bindings: iio: imu: add icm42688 inside inv_icm42600

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 3 +++
 5 files changed, 14 insertions(+)

--
2.34.1


