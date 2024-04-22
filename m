Return-Path: <linux-iio+bounces-4436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2838AD103
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1588B1F230BF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E84615350D;
	Mon, 22 Apr 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="hQIbjwEj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DC153586;
	Mon, 22 Apr 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800109; cv=fail; b=U8a1cyjlmNAefXRYNOIJvfHEoBWoFNaP0aoL4AtUJwFHl0+dPXjQzrzyaRH+g84RH/eF37a3pFjY2dF29uakemgCwSlDMC8jZImEQwoC4XJ4ogeKqqU4YYWwr9yCM4/61N05o8g/n7R3Jnc7MBvAp/Jpwy+MzLNqAjUSQmk02Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800109; c=relaxed/simple;
	bh=VXkWNUhNWKFHtdPWUfDKjaWv7WTwJxNo+AbDL66RfJc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T8U4Twg7etqMtE2q8/XzS60RUqadJHGC8cWiVBz3lvNOjzOzU3dDiSGxzwr1qggPV6XVp99XJZXhwliMdVmzQFTERWe+b9Gd0TZ+bKB3D3AoLVY7GaMCpIWwl9ClrdJMobkq6YRRRkcEOaUSCQr3meQR1gyJsGlewZUi+TwugJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=hQIbjwEj; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M7tnoC010569;
	Mon, 22 Apr 2024 15:23:05 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xm72j9aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:23:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRGXfnhNHmlEBiOIE/B1xJFO3Rmf3zot3si2a66RcZRrC+WZUKXyTXk7h4je2FkakGKbTu1i4Fpx5Uvoqj3N2DbyjdNWksadsZ3EX6kCBL0bYrYH1LIq9D/mOz3mUQY1hbHQRdC4lbzuQyW2n7Gg3gtE4DVvNkXSUbVvm/+ybWvuEtLfxgwOmKUa3nql0JB3/+m/DWstboroW+2LbandAScobolo37/c4XTo5/is7izZjZo20MUJc0PdM8XOHhJbABwVcIqcCntZ3PMyODA32+20j+8S6Wd9ZhERVsE6XtfCcz177FUifzYvvj1xwV9QuUkXYnmJ3FT3DTw7DVu4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhTzuHXetpCyCTR7dHoYS07PnrX7hjyZMsth7azjbLE=;
 b=fVkAQsPqKb3j+FBrrpIdhfUIMcCjV9PUfODlObuuV1rOSAfZsy0tpp2KwzAQt3oEjWCHSjPzS6FoKeygZ35bdQY+R2nA6JNEzmKdxRWu4dvDpHGYC0MYBLuN1mnSrAjlEQ8o1tGiewfsma6PxFhj6TWPN8a2s+EcOqA0b/JVhF71XFkZq5NCLiYl5o1w/CCsB/f9LpoMRJQlMfm/6cp5gylYQkqn3jZinuytW9l8EjJd7xnxiUM4N0gLfGQpDnIVOGZzy5dogk2v5IQieFLrC/w/r79Lu/9Dei0lJxaSSkR4PXt5Xnq3zgcFqhRibQbjJdkVs6CUjQb6bDEOriHl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhTzuHXetpCyCTR7dHoYS07PnrX7hjyZMsth7azjbLE=;
 b=hQIbjwEjycLEC40W+yr/A3g3imZh4+7MExMlNggTYxux7awayyH0S4/2vqerjKDRf0tWFp8ZOORnu7I/jGBa4XeN25W4rDA1AFHpCfkXN00wgK4OvwwzHDjPBOAxdMDjeGajAY67ONZZ0PbGd9Z0y3USbYGWuDcuPOaUzh714T6oREQ/qdkrCIhyBKJJcV1WBwzLA/OWu2LMBTC+BkfkEi0u15n/xMiJUGS1Go18LOsadAMvdZSDCNMrG9mGYc2ISGzgM9+2yAItjY+BwUIUCx723v1bFMV2/enuj8irjsOxpzZCIVXEwWVrOfzAyLVeztNePFNasOazn+GBNNBkKQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB4079.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:22:59 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:22:59 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 0/2] iio: imu: inv_icm42600: add support of ICM-42686-P
Date: Mon, 22 Apr 2024 15:22:38 +0000
Message-Id: <20240422152240.85974-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b864f9-4e67-4abe-5424-08dc62e01762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?thFJqgb4aDyoeC4EhS7T0KEjlD0Iy4wF/h+0k9Qg5/y0vjXEP+JFwLQBGVXv?=
 =?us-ascii?Q?XTeI/Q2YoBbHlyx+w3wxhxC/jUsKt+tJdFwfHb4RvMFAkdk2GV0WiXoFKntE?=
 =?us-ascii?Q?FiVrmA70PJvwXs6/LeFLUPdHiAH8nMaVRpg/6dmHKQYeci+OL188KL5XCxsU?=
 =?us-ascii?Q?VAKWx6plJEaEXJgtA9MA3MLTiX84N37SDrMD8ndmyZXrO6epmX69Alm1I8uA?=
 =?us-ascii?Q?rCt9gET9iyy2F+ekCy1DjzkiIa5HoYPY2E4O4lFsx3RjU/H/X2TwQX46UDRm?=
 =?us-ascii?Q?s7okBpHUKvrucqBw5OOTgGUftcYr1+AImcRWH1jFnh30g7DYsdUu/o9miJoh?=
 =?us-ascii?Q?tWSGscrcpIDOpYJ7Uv++XaWXRX/18mi2b711f91c+vkojwuJtVv3B2KytHf2?=
 =?us-ascii?Q?tYX2ZAOoFltsTIeLfxCNnOFdjpjzfz1WudVat5pI94Yy5CzHWo0tNrFju/b5?=
 =?us-ascii?Q?AwSIkmFwG8wDjZowGzVdpSbWrxDa58OMBmyggjpIUkFYHxEhG9dVRmiKj0+v?=
 =?us-ascii?Q?S+j2FVx1cfJkOutxX1LZuTlHOOoTruJQwJpahFVuUMooKOeuRxM/a3EVnt0e?=
 =?us-ascii?Q?8HSgO06ZN6MaMIQhdWnlvMeMALO+/z3q+3ZhIQT4vgR28SPR1DXCNYhhuOCg?=
 =?us-ascii?Q?hMQa8GsNXqec5ZdUBL3knlbvR9RHCPSw3OjFLxcs44i9uPcKFBhocXLLBg2S?=
 =?us-ascii?Q?FCTfVD6cnCC0asHE7IXW0KdhfPwu7xy2+MHz5uKyfoiLU4mBRU4ClALjPH0m?=
 =?us-ascii?Q?il58PGJ3RoZNPLalOJOTQKy5Bt2jbl1DBF2cU2DMVDgbZAU+mCXT/2VMUECi?=
 =?us-ascii?Q?vBZ1RqEy/21z6Y2LGgHsro+TtexcaXgAhWeGcZjbM6VTnamov8+8Nk/MOX5O?=
 =?us-ascii?Q?/Pj2hpbfb+nOILU/AbH7TFyYlKdKnmB+EBNxqRn9iXcdQ2kJYMjsudc6Uefb?=
 =?us-ascii?Q?2wRtXxkYDopWRNEjB2dqEhV988lYeDzGfRlrli40ThcVeVoOxFVK3FNa3Hm2?=
 =?us-ascii?Q?jbA1NaSJLsSMTsqPl7ai2SC/FRh0ifgSsGz1gsBOX7MagLR1UzKlCs2zBIO/?=
 =?us-ascii?Q?lI8a9RlLXNNq6NOhUK8sR6J+gpHw88RCRkBwO/SJsy41ALZy76Zu0b4PILG3?=
 =?us-ascii?Q?TcmcIe94yPx9U9Ee63kjOEAfrLhJaLJ0fVlqyglBXZzZ0aFpQC6IDIovs45g?=
 =?us-ascii?Q?kH8XXW8W8jyk9XAluYxsfkWyuvoj45jpfXiJe8edacq0BGIDRVkicbsb6Jpo?=
 =?us-ascii?Q?L8rT8riB2sspKLa4ViOb/pH8YtO8/FsqInM9VUmPD55v3hOMcGmUv5g7OLdl?=
 =?us-ascii?Q?dfJPW2gzzMSxObHm9GPBHTNTBLnnEUuZ65D5X4xAKaCovbSq0gHO178TEQWz?=
 =?us-ascii?Q?FUxXWc0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1zI7yKXpKGejFTUqVwX0jjRPTfbmFzheB89kUvUXcEFe331+YIWxjCEP3aEk?=
 =?us-ascii?Q?qlVZaHlg62mTev8tH6xN9dsaCmP/lKEeq/nssfwMcq6Y2Mr809HQ2ReLVHaI?=
 =?us-ascii?Q?9Tq+XgrTh037JMsWvXXvpFfui3UZBJwV6XbHj2ftisZ/EbM78EBUvvez8emR?=
 =?us-ascii?Q?LjQXQITEVXc8dztcqCmoEhBQb3d1sF0jAjOPgUPaBVdA6/wdrR3XLejuMshf?=
 =?us-ascii?Q?KHreu4ELB+6Fisbn/RMLE3Z2YRQABGZ2vOaGAcw3o4zvAnFwjUMKwsbbGii5?=
 =?us-ascii?Q?hfn48EGKn0Hq+79t+2SdMkyifD8PZH+oYu/vlqBK2KVIRw8gidMivl0gCiLd?=
 =?us-ascii?Q?ZPIIHhF07MwQxcfm6BIuDTMi1fw1kX9bcS2lU1qYyVJimDHjxzYHgYaMjQr6?=
 =?us-ascii?Q?RsGJxFDROGcgx0Z58PHoQ/TWrotybFo4xmx8QC8G8cy7GxcHsOyF60m+CH1t?=
 =?us-ascii?Q?rc+lIQhF37VJpBMOK915/BJiiuh0/0ENFOx0k9XvacR5u0O/rNmo3NExQpPG?=
 =?us-ascii?Q?9fZ6eppXonVSbdz5JB29NSBDmF6GGKxuG7bZ5x/fJ3Y/9Lteh5t5sfBGucoC?=
 =?us-ascii?Q?5yiTUubZOSPxM2xozEl9mfdGBKogDwtiMlvYydnPYNQSc6/bljI19fX54nmf?=
 =?us-ascii?Q?wI6adIUGeRF/DzY83X6OUz0bvQTmPkzcihYsH/8bxIPUt2b8ZGuiX78ZuknS?=
 =?us-ascii?Q?cE7uWCYCnZZ3T4Tj+dLpEP9AQMkuqdnIrgI3fTimL8zNsbDVNj1aUQnN8TzU?=
 =?us-ascii?Q?HlZJQdew4P44hqJiD0OPqc2LDD/hOI/lj+L7tpWjK2UCw2E00IJaKbgfrDiB?=
 =?us-ascii?Q?mhTble5euvFDpP463mYu7J6G80ONRapZiUfjigIov5J5ulTEPNgHSodtbPSo?=
 =?us-ascii?Q?FrTmkvVcf1BM6FaOG52V2VSmiNle/Pb1RHAEv7jmR1iXY6VklfKoq4opz2Xk?=
 =?us-ascii?Q?fJi6vb2CSjbdMBD8HYZZ9zJFRyqi7nmny2vXZLY/PCgz9Y7jxurmp7djYe02?=
 =?us-ascii?Q?pwmtmeWb/4ZTFbZePhGnG9Llmp7QSncWsprDJpYm3+Lrhz+lM+Fjhe2y6FK8?=
 =?us-ascii?Q?XURDaLgGwrYCgt3DZpStNc/G4qtz4ABqQOBs8xApty56WcOGUoLAOCiFQ/K8?=
 =?us-ascii?Q?D1vSIxRos2/BPQDl4AleA10suB5E/Im4usqCu5AHELaL6JJytfOpcWlSGEoQ?=
 =?us-ascii?Q?0Nz24KenAYQkTew49Q1DmLs7DjB01QiUhroWd7mXv5gRIwDua6d4eiVR587P?=
 =?us-ascii?Q?axDLEdnOaNYrx6CgRbBwfJvVXwIxNtaSZRzFMeKQyYnZeDE63clPQq8sMGiQ?=
 =?us-ascii?Q?3bVuBEy8Thkd/h9OWHktacc8yGsmyDnZvNH2uQG1Tf7CCdnNStBHaJrdEfLr?=
 =?us-ascii?Q?hHlwCIaEbD5TNtb+S4JVF22XC8+uN4wWf5s7Bq1XvFW6swxd7pd0XjfRFze2?=
 =?us-ascii?Q?m5IRujM1GR76bZYBFW+h7nsOv1KxOy6dF2EAma8vEJrc7o0V6nivJao+xoOg?=
 =?us-ascii?Q?8K29VlblvuLyEZkiLLsFBycLQ5fDUgZP/byfuCOiFct3Q4lGp6E92aWdarY8?=
 =?us-ascii?Q?gb1/XPc+gcgB+51BWAv7jH5ThwTa4VhEDHcnVdiy?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b864f9-4e67-4abe-5424-08dc62e01762
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:22:59.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU+bYETVrrM2QJFq/d6pSCl2MepkkguM8WSEFweYZqFngm26tPjUlyks5U8lBqB8xGLR0qUJnZDiodnSXs0Twg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4079
X-Proofpoint-GUID: RX0DlrXB1khrxmq7nYeioVubOXxXGopS
X-Proofpoint-ORIG-GUID: RX0DlrXB1khrxmq7nYeioVubOXxXGopS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220066

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ICM-42686-P is a special chip supporting high Full Scale Range (FSR)
values. Up to +/-32G for accel and +/-4000dps for gyro.

For supporting this chip, we are using dynamic scales tables set at init.
Introduce a new sensor state structure for olding pointer to the dynamic
table plus the already used timestamp structure.

Jean-Baptiste Maneyrol (2):
  dt-bindings: iio: imu: add icm42686 inside inv_icm42600
  iio: imu: inv_icm42600: add support of ICM-42686-P

 .../bindings/iio/imu/invensense,icm42600.yaml |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 35 ++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 75 ++++++++++++-----
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 15 ++--
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 20 +++++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 84 ++++++++++++++-----
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 +
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 +
 8 files changed, 193 insertions(+), 43 deletions(-)

-- 
2.34.1


