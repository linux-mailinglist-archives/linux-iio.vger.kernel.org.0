Return-Path: <linux-iio+bounces-4858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61A18BDFC9
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961302819DC
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020C502B3;
	Tue,  7 May 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ojk9Zlbe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4322064
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077905; cv=fail; b=eCaL54Y43gIV5V+OM5yjEou19B3EUsGNhv4TBubDg8bef4WtzitxeUtOTQNfNeYFym0qh76KAudI20Q1moPfuQG9iDJkGtx6l1g1BYlqSWRrCQ1UCUFIHTMj+Wjtl6MoQC+isLeTZS82kjBIysbP0KSlKuSo51a5vA9WQX057Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077905; c=relaxed/simple;
	bh=Mptfsfy+Snfw+HaB1GAvUCkwnMJJvEqsG7jL4E/C21s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pWbsSqX/zrI8HTTTHdr/OAqA5H4IspkTHVTxHpRfXr5tRzex6ifQu7xqAfKhg5GlDcnmVsxgqck5UB9awGR+ao8O2ZctVRMm1dkDzfUw4RIRPqmU1h/0XvgVfEs4pYG1W24yDAQnJ/ZeRq9C1ZDEckmMtmVDj/OUZhK2I/yqJb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ojk9Zlbe; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446MVuU4011834;
	Tue, 7 May 2024 10:31:16 GMT
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazlp17011006.outbound.protection.outlook.com [40.93.130.6])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xweck1ynt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 10:31:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv4M8cfiDMxS19XUVE1KN4W/shiXeKgeGlAAyZ0IcYp4DCil6VhLLEuq8kl6UNVMBRioG+CmF889XAo4UfBWLPO4Rk6/gRk1/soRhFlBmEKj+nRbuQ/UL2Hex03T9NudwOe8TunvD/7INsKvm5OLzRGLnW+G9WlKp3q3EvGWsJzAvx9Waf94db0vxYjFPE2IZW1m3aqw4Y2KnPwPV50bjrge3/2fI4ZCqnNcF8Fm3ni9VRqERKfADL2UTq0AADn6L5zTzk5c+CCPrbNTgbWhsEyJ8Yxk0Ir9d6BxRdVrrXQPOn/Q5fZauN+06kuCzCg5EpcjPbwj+Owjs7gwAn235Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/w6GeN4YOs3EHjUWxcYGco6ci5mOLeLd5Y/JguIcrY=;
 b=BHqeRCWyr7StrzTWkeRqE9K8ZXdFgjzd68noGXL50Lsuz4D2cVivyImcZv1djBiQB4Avl2NLuexDicf4SEyRDFyIolJqwARYe0X+xQlJgNlhOME5MnFC+nNpUKwMn/2NszKc/6cKr5tfeNgFZ8Xlz6CmfYg5r9yGwv1UFoMhGUIX6+3HHXd3hLLv3G/OcRx+08qY4g9RUVVkHlkBi+Bb2pIe2D+jsGWbnBUTHzDLWpqMgfQuHdvcM5UPgLbNm3t9tZGOHkV3c/e5vyTCXN9b5Cq3VITtDUsKI+gAdgn/Xo+zImixPzsI/uAdN+PLIUMLwLijYKsIUbZpnVrWTLatdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/w6GeN4YOs3EHjUWxcYGco6ci5mOLeLd5Y/JguIcrY=;
 b=ojk9ZlbecFT/k0Eq+K/yd7sOZKqSiDyK6dfotIQdnjA7NYYfnNfpGFY2NO0LXWSY8l5WNPRpta8l1S5uTDwuCRyOuDbk1iEUGIiatPv1TMdUQgHCmtDZg62t1Q+isCY+YDEC7X167Ay6NM6Pj8yngCZcup5zIyOHBMBWRiVy9F3ShEtL4Y0ahWl7GNf/ndJeQZ5Kb46iXhIjv4he46WpvK8jglJT9T5NT+UdCscqwjKTC4IWgrVkF4x+QlMJfi5QklkaS5fVbAqY3JygR+g/jIVoxN+rGndyUkSQR3EMJtW5/kQvXR1LkaWhql02ab+zY3dMarfSUaRZ1oHfaoMllQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB3565.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 10:31:11 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 10:31:11 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_icm42600: add support of accel low-power mode
Date: Tue,  7 May 2024 10:30:56 +0000
Message-Id: <20240507103056.291643-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB3565:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bde125-8143-49c7-287c-08dc6e80cfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|366007|376005|1800799015|3613699003|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+2rhOpinQHJQEsn+Oj22+9bzDr0iISURGVmRmsgGEIb9HzB2/qT7IDnlrcI8?=
 =?us-ascii?Q?rFbMK5nGB3iFoWNqa5OdjXgsosIXpyacQgXMkKNJGZkZeAWK/T3HfSkFJVBg?=
 =?us-ascii?Q?XxTKlggiZbR+u+gkAfAbajcuL8jCjEpS56K+AOKwus2uFjSOCcSPB9rFWfo6?=
 =?us-ascii?Q?muW+qg8c9N/jLQ25HzYlvSNcmh+PMjXscRKFaqSt/p/bKOXYO5Ss2uCL77nj?=
 =?us-ascii?Q?eYEXkvy3t1KMfP9mRK0038sXkiHnScfj8MDsnxrhVOPZjKKb0DQJtZaqScSY?=
 =?us-ascii?Q?0VZ7Yrwl4rL+XWtR+3eW+Hmb4h2asI9fA7jZgd61UOgr8bfXlqKyKXuaZ0K1?=
 =?us-ascii?Q?g9+k9rX9+DonhFdJhjWeg/zR5as/6kkkTYtBklxPIy8rfE8L1yi7CNpad/ZT?=
 =?us-ascii?Q?hd6rwKIfh21e/n+WhfTcFqmikU7Ovx1kjKXw/H89sFjITxWzyJ+ohiNwa6yX?=
 =?us-ascii?Q?yXpn3AzT5ohl+uMNvDgsVej568udqu177FFSM24MKTmPFAiqpAujez2rFQIM?=
 =?us-ascii?Q?J0kZfkHcpbnETwZa1uLDZ7NrgjeEszPZWRZa4MpsGboGZ62KDy/0iTtGQbCN?=
 =?us-ascii?Q?fd+tXkJz2+DDqF9CMBjv/IK/h6NhrXFfnT6jb+Oj37uBqq6dXUmTufseqLmt?=
 =?us-ascii?Q?csuWhawOqJTKUOXFXOQKcgJlEB7xqJMjmqE9ETck69LVYiUVYNJjmOCFlK5C?=
 =?us-ascii?Q?9yQK6+MkDNtVi4aSFDaJ1z2Za038z001WGLWR3L7D2deXlL3FEW50okik6O4?=
 =?us-ascii?Q?aC9wniPi/fGmzNR6E/5lsFRYrWzThCXxFmMCwGrj3O8nwV2c6Xo8/Ie3uGxV?=
 =?us-ascii?Q?s542RKattHeeAnfXA+E39CsM3pexuR/myT6RWGv+GhcFzbjv0+qLDOOS66k/?=
 =?us-ascii?Q?QeaOgcprEkUmHTWmmFwN2bIzekpphhs5rHa4ydPa5lFZg81m6y0KTJLgesJH?=
 =?us-ascii?Q?J81Yi4oVqcO6lnwBQHMe835oPyCPtpZ8BSYrtQUDYBrMJAljXTXo/hbsxk4I?=
 =?us-ascii?Q?LB70lfxEfuV9mWu3LKJxS7MVKF4QlIdFKqXL1VkpN/Ww64G2A34CX8SWh9Yj?=
 =?us-ascii?Q?TjtfHAYbdwCnPbQVjHgwRfK+h+hQxzDrz8SYr5JB6NVdKmyLSCr1l50A0Zxn?=
 =?us-ascii?Q?WVw8PjddJp5t2XzKdc21sd5xhYqrZs0YqEJHNlimwlyQ2raHa7IQovYQAnB8?=
 =?us-ascii?Q?LuJxXVOiP85uteQFPqya0a92GfzT+VNJy0aEIVAkufehrxadF+z15kh2IgZB?=
 =?us-ascii?Q?9tMZWAoa5lOGKq4OWj15ULE82XiA6LD0cz5aQsACOW3zNDMJq8uFQaiGHRx3?=
 =?us-ascii?Q?VVWqwV9YCBoeE3l/J+/iGQ0B5NVZ//Bm93On5W+DQvSTjV3xJv1NqtZNT20e?=
 =?us-ascii?Q?ylDU3qs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3csKtdufpJ4WyW+RIT81KrSbFjNtpwyRNcHBrNt8Rf4dJ+cR07jTdPj8Fg1r?=
 =?us-ascii?Q?BTCTspcbbywwYWK371a7fgU7hDclKqgQQar1fCZHGXP8b4asMVKtX1nkghXb?=
 =?us-ascii?Q?/RnZ+8QQRJodBe7YikABaLAAHu1xZ1uToGfwDWpW2eJxUSohtUau8IIGAxpt?=
 =?us-ascii?Q?U/pP/IW/BDrUHgCcAWSPGDON+XJkaIem7FBU+Xukmq5C+uINYmo5ortEOM9x?=
 =?us-ascii?Q?SMkeQ4IBrAFwssY1VYi2H4ck4yTyxSJPRQDNdCnjMNVO2FDfx3FN51otNzHy?=
 =?us-ascii?Q?k3Uh4q/MT7wibRKL3ybudC+vEgBQw18Axo4x0ZNpGxtAnF1SVQxKLc0XuzTW?=
 =?us-ascii?Q?QvK5emxiu0bNdoc/Rvc6v3KaQdsk/Urn9TcIgHNMzLd+TjGR5b+NP8iTR9uO?=
 =?us-ascii?Q?6zRkpXeKyNQkZUMa9/KW2LfFEox2q8RH0CBAx0qp02wyokUcgdxF/eEVtWt5?=
 =?us-ascii?Q?KqZ6Y39xnQ1lviOoXEiIsjakTV9AHAVXgumZ3WpuiVOz6YuMLwr6TN3scq0Z?=
 =?us-ascii?Q?0pC6wbIAJaDnzZ9wdIx8gkigQ1aTFBNAxis7Zyol5ySCSPc9TfblpPXnTAUa?=
 =?us-ascii?Q?TvHb8TMQ1QI4+b0kSjHKr2VdmY9eXBSUCSYTaE6ElDDrr6fteWN2vjPMTSDV?=
 =?us-ascii?Q?1wJ+MtaL/0o4ssdHLtRfURzTfQ0Ids8VmPLC5YkOy1CWlurIRmEN9Bu9QRZw?=
 =?us-ascii?Q?GKTi8iUw/sWR8ODElPwQpeHv86Qx8HZNsVXbw+bO27USA/JGw2l3L0Ua+u6d?=
 =?us-ascii?Q?Sp5T/dX5a7AXxSApiJgQxhzT/79d/n7BIhmmI0PkyXhLpYmvtsJSKy2OoCQN?=
 =?us-ascii?Q?M+k9QlYYbe/bWrezC64J39KPA1X+GrL7gDsw0upkKh2kz60/2I9/klqyOZHI?=
 =?us-ascii?Q?WiN+CJONDnrRK9/VCggJ2/bRHVJIcEYYEsUQrudiNwOy/cwZNRc5QkyGGsRG?=
 =?us-ascii?Q?//Zp3RIh3Ae6oVy1LyLUwX8n3ozRbGq56vrGd6mNKA+wTuT+WkJmvBIm871Y?=
 =?us-ascii?Q?go8Yli/wkXmoryM5XbVP8PFVzk87ijhRhNIHYRN8tqI6PiAR9ziRu1iJT0Cn?=
 =?us-ascii?Q?HEYosN8UEcBU7pgLWnumBDntfGupVeyq2YZDim8ML7itfiQPiix1kCEhp/nw?=
 =?us-ascii?Q?68scT6Cu3NbkNAuyJTEFK6aLnpF81vvmPOGHPpp5kUrsV1CQtHSffq0qrYZb?=
 =?us-ascii?Q?eQXiqZC0sRmrXc9IeHx30lwsg8PrHzEHk6yM17N/rbUnH2D/d4t9BlKKCHzk?=
 =?us-ascii?Q?XtM1VCf08/ZLUPFL4mOqvYtV8FdLyz6c89kPts9ZfocIKrthAkmcD2XUdih6?=
 =?us-ascii?Q?toH/72O7NTXxIf953k380rzFcvKJwdyYjmQA4KorhbQrE0e99+5353ZjNr4f?=
 =?us-ascii?Q?q6/NIHs5BkUM2fZ0OHjeN2Hbrsx2Zn5dnt6Lzm2lT7yJ4ULp2y9EkXgLg4Rc?=
 =?us-ascii?Q?CO2crZCpoumUz2D70eDr/1gUVcpOE1sI3nXRTKneWs0sxHQO5DkbF0TKoCoH?=
 =?us-ascii?Q?gvDfiDd+gTIAY7yefY4HXF5w6Qt9VzxaEk2kRdshN+AtXQNuTVDa678G3DAn?=
 =?us-ascii?Q?zghpgoXyM2HUnglpmuNnW2zmKahpeLDfwQCQIJoF?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bde125-8143-49c7-287c-08dc6e80cfef
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 10:31:10.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KtBZzvy/tjKeLdkdjSZ8AyQZ3uy/EDRWrG7ZNVjZX1mKNt/BbkVGZjYqckVyLfDkT29x2izyKC+HR+c3G2+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3565
X-Proofpoint-ORIG-GUID: a7wQ8D4nUpvklkItVXNiSwDBx0j52UT9
X-Proofpoint-GUID: a7wQ8D4nUpvklkItVXNiSwDBx0j52UT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_04,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070072

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add channel attributes "power_mode" and "power_mode_available" for
setting accel power mode (low-noise or low-power).

Differents ODRs and filter are possible depending on the power mode.
Thus make ODRs and filter dynamic and check values when applying.
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  12 +
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 230 ++++++++++++++----
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  33 +++
 3 files changed, 226 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c4ac91f6bafe..83219088e697 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -177,11 +177,23 @@ struct inv_icm42600_state {
  * struct inv_icm42600_sensor_state - sensor state variables
  * @scales:		table of scales.
  * @scales_len:		length (nb of items) of the scales table.
+ * @odrs:		table of odrs.
+ * @odrs_len:		lenght (nb of items) of the odrs table.
+ * @odr_convs:		conversion table of odrs from Hz to register value.
+ * @odr_convs_len:	lenght (nb of items) of the odr_convs table.
+ * @running_mode:	sensor running mode (low power or low noise).
+ * @filter:		sensor filter.
  * @ts:			timestamp module states.
  */
 struct inv_icm42600_sensor_state {
 	const int *scales;
 	size_t scales_len;
+	const int *odrs;
+	size_t odrs_len;
+	const int *odr_convs;
+	size_t odr_convs_len;
+	enum inv_icm42600_sensor_mode running_mode;
+	enum inv_icm42600_filter filter;
 	struct inv_sensors_timestamp ts;
 };

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 83d8504ebfff..d76288dee225 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -55,8 +55,158 @@ enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
 };

+/* IIO format int + micro */
+static const int inv_icm42600_accel_ln_odrs[] = {
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+	/* 1kHz */
+	1000, 0,
+	/* 2kHz */
+	2000, 0,
+	/* 4kHz */
+	4000, 0,
+};
+static const int inv_icm42600_accel_lp_odrs[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+};
+
+static const int inv_icm42600_accel_ln_odr_convs[] = {
+	INV_ICM42600_ODR_12_5HZ,
+	INV_ICM42600_ODR_25HZ,
+	INV_ICM42600_ODR_50HZ,
+	INV_ICM42600_ODR_100HZ,
+	INV_ICM42600_ODR_200HZ,
+	INV_ICM42600_ODR_1KHZ_LN,
+	INV_ICM42600_ODR_2KHZ_LN,
+	INV_ICM42600_ODR_4KHZ_LN,
+};
+static const int inv_icm42600_accel_lp_odr_convs[] = {
+	INV_ICM42600_ODR_1_5625HZ_LP,
+	INV_ICM42600_ODR_3_125HZ_LP,
+	INV_ICM42600_ODR_6_25HZ_LP,
+	INV_ICM42600_ODR_12_5HZ,
+	INV_ICM42600_ODR_25HZ,
+	INV_ICM42600_ODR_50HZ,
+	INV_ICM42600_ODR_100HZ,
+	INV_ICM42600_ODR_200HZ,
+};
+
+static const char * const inv_icm42600_accel_power_mode_items[] = {
+	"low-noise",
+	"low-power",
+};
+static const int inv_icm42600_accel_power_mode_values[] = {
+	INV_ICM42600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42600_SENSOR_MODE_LOW_POWER,
+};
+static const int inv_icm42600_accel_filter_values[] = {
+	INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	INV_ICM42600_FILTER_AVG_16X,
+};
+static const int *inv_icm42600_accel_odrs[] = {
+	inv_icm42600_accel_ln_odrs,
+	inv_icm42600_accel_lp_odrs,
+};
+static size_t inv_icm42600_accel_odrs_len[] = {
+	ARRAY_SIZE(inv_icm42600_accel_ln_odrs),
+	ARRAY_SIZE(inv_icm42600_accel_lp_odrs),
+};
+static const int *inv_icm42600_accel_odr_convs[] = {
+	inv_icm42600_accel_ln_odr_convs,
+	inv_icm42600_accel_lp_odr_convs,
+};
+static size_t inv_icm42600_accel_odr_convs_len[] = {
+	ARRAY_SIZE(inv_icm42600_accel_ln_odr_convs),
+	ARRAY_SIZE(inv_icm42600_accel_lp_odr_convs),
+};
+
+static int inv_icm42600_accel_power_mode_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int idx)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
+		return -EINVAL;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+
+	accel_st->odrs = inv_icm42600_accel_odrs[idx];
+	accel_st->odrs_len = inv_icm42600_accel_odrs_len[idx];
+	accel_st->odr_convs = inv_icm42600_accel_odr_convs[idx];
+	accel_st->odr_convs_len = inv_icm42600_accel_odr_convs_len[idx];
+	accel_st->running_mode = inv_icm42600_accel_power_mode_values[idx];
+	accel_st->filter = inv_icm42600_accel_filter_values[idx];
+
+	return 0;
+}
+
+static int inv_icm42600_accel_power_mode_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_power_mode_values); ++idx) {
+		if (accel_st->running_mode ==
+				inv_icm42600_accel_power_mode_values[idx])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
+		return -EINVAL;
+
+	return idx;
+}
+
+static const struct iio_enum inv_icm42600_accel_power_mode_enum = {
+	.items = inv_icm42600_accel_power_mode_items,
+	.num_items = ARRAY_SIZE(inv_icm42600_accel_power_mode_items),
+	.set = inv_icm42600_accel_power_mode_set,
+	.get = inv_icm42600_accel_power_mode_get,
+};
+
 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
+	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
+			   &inv_icm42600_accel_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
+		 &inv_icm42600_accel_power_mode_enum),
 	{},
 };

@@ -120,7 +270,8 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,

 	if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {
 		/* enable accel sensor */
-		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+		conf.mode = accel_st->running_mode;
+		conf.filter = accel_st->filter;
 		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_accel);
 		if (ret)
 			goto out_unlock;
@@ -144,10 +295,12 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	return ret;
 }

-static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 					  struct iio_chan_spec const *chan,
 					  int16_t *val)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int reg;
@@ -175,7 +328,8 @@ static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
 	mutex_lock(&st->lock);

 	/* enable accel sensor */
-	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+	conf.mode = accel_st->running_mode;
+	conf.filter = accel_st->filter;
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 	if (ret)
 		goto exit;
@@ -275,54 +429,25 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 	return ret;
 }

-/* IIO format int + micro */
-static const int inv_icm42600_accel_odr[] = {
-	/* 12.5Hz */
-	12, 500000,
-	/* 25Hz */
-	25, 0,
-	/* 50Hz */
-	50, 0,
-	/* 100Hz */
-	100, 0,
-	/* 200Hz */
-	200, 0,
-	/* 1kHz */
-	1000, 0,
-	/* 2kHz */
-	2000, 0,
-	/* 4kHz */
-	4000, 0,
-};
-
-static const int inv_icm42600_accel_odr_conv[] = {
-	INV_ICM42600_ODR_12_5HZ,
-	INV_ICM42600_ODR_25HZ,
-	INV_ICM42600_ODR_50HZ,
-	INV_ICM42600_ODR_100HZ,
-	INV_ICM42600_ODR_200HZ,
-	INV_ICM42600_ODR_1KHZ_LN,
-	INV_ICM42600_ODR_2KHZ_LN,
-	INV_ICM42600_ODR_4KHZ_LN,
-};
-
-static int inv_icm42600_accel_read_odr(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_read_odr(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
 	unsigned int odr;
 	unsigned int i;

 	odr = st->conf.accel.odr;

-	for (i = 0; i < ARRAY_SIZE(inv_icm42600_accel_odr_conv); ++i) {
-		if (inv_icm42600_accel_odr_conv[i] == odr)
+	for (i = 0; i < accel_st->odr_convs_len; ++i) {
+		if (accel_st->odr_convs[i] == odr)
 			break;
 	}
-	if (i >= ARRAY_SIZE(inv_icm42600_accel_odr_conv))
+	if (i >= accel_st->odr_convs_len)
 		return -EINVAL;

-	*val = inv_icm42600_accel_odr[2 * i];
-	*val2 = inv_icm42600_accel_odr[2 * i + 1];
+	*val = accel_st->odrs[2 * i];
+	*val2 = accel_st->odrs[2 * i + 1];

 	return IIO_VAL_INT_PLUS_MICRO;
 }
@@ -338,15 +463,15 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	int ret;

-	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_odr); idx += 2) {
-		if (val == inv_icm42600_accel_odr[idx] &&
-		    val2 == inv_icm42600_accel_odr[idx + 1])
+	for (idx = 0; idx < accel_st->odrs_len; idx += 2) {
+		if (val == accel_st->odrs[idx] &&
+		    val2 == accel_st->odrs[idx + 1])
 			break;
 	}
-	if (idx >= ARRAY_SIZE(inv_icm42600_accel_odr))
+	if (idx >= accel_st->odrs_len)
 		return -EINVAL;

-	conf.odr = inv_icm42600_accel_odr_conv[idx / 2];
+	conf.odr = accel_st->odr_convs[idx / 2];

 	pm_runtime_get_sync(dev);
 	mutex_lock(&st->lock);
@@ -581,7 +706,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = inv_icm42600_accel_read_sensor(st, chan, &data);
+		ret = inv_icm42600_accel_read_sensor(indio_dev, chan, &data);
 		iio_device_release_direct_mode(indio_dev);
 		if (ret)
 			return ret;
@@ -590,7 +715,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		return inv_icm42600_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return inv_icm42600_accel_read_odr(st, val, val2);
+		return inv_icm42600_accel_read_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return inv_icm42600_accel_read_offset(st, chan, val, val2);
 	default:
@@ -615,9 +740,9 @@ static int inv_icm42600_accel_read_avail(struct iio_dev *indio_dev,
 		*length = accel_st->scales_len;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*vals = inv_icm42600_accel_odr;
+		*vals = accel_st->odrs;
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = ARRAY_SIZE(inv_icm42600_accel_odr);
+		*length = accel_st->odrs_len;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		*vals = inv_icm42600_accel_calibbias;
@@ -754,6 +879,13 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 		accel_st->scales_len = ARRAY_SIZE(inv_icm42600_accel_scale);
 		break;
 	}
+	/* low-noise mode and ODRs at init */
+	accel_st->odrs = inv_icm42600_accel_ln_odrs;
+	accel_st->odrs_len = ARRAY_SIZE(inv_icm42600_accel_ln_odrs);
+	accel_st->odr_convs = inv_icm42600_accel_ln_odr_convs;
+	accel_st->odr_convs_len = ARRAY_SIZE(inv_icm42600_accel_ln_odr_convs);
+	accel_st->running_mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+	accel_st->filter = INV_ICM42600_FILTER_BW_ODR_DIV_2;

 	/*
 	 * clock period is 32kHz (31250ns)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96116a68ab29..50380f2a5ebb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -235,6 +235,7 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 				unsigned int *sleep_ms)
 {
 	struct inv_icm42600_sensor_conf *oldconf = &st->conf.accel;
+	int min_odr, max_odr;
 	unsigned int val;
 	int ret;

@@ -248,6 +249,28 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 	if (conf->filter < 0)
 		conf->filter = oldconf->filter;

+	/* sanitize ODR setting against power mode */
+	switch (conf->mode) {
+	case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
+		min_odr = INV_ICM42600_ODR_8KHZ_LN;
+		max_odr = INV_ICM42600_ODR_12_5HZ;
+		if (conf->odr < min_odr)
+			conf->odr = min_odr;
+		else if (conf->odr > max_odr)
+			conf->odr = max_odr;
+		break;
+	case INV_ICM42600_SENSOR_MODE_LOW_POWER:
+		min_odr = INV_ICM42600_ODR_200HZ;
+		max_odr = INV_ICM42600_ODR_1_5625HZ_LP;
+		if (conf->odr < min_odr)
+			conf->odr = min_odr;
+		else if (conf->odr > max_odr)
+			conf->odr = max_odr;
+		break;
+	default:
+		break;
+	}
+
 	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
 	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
 		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
@@ -441,6 +464,16 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	if (ret)
 		return ret;

+	/*
+	 * Use RC clock for accel low-power to fix glitches when switching
+	 * gyro on/off while accel low-power is on.
+	 */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG1,
+				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC,
+				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC);
+	if (ret)
+		return ret;
+
 	return inv_icm42600_set_conf(st, hw->conf);
 }

--
2.34.1


