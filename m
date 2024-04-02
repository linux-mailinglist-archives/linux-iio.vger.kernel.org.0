Return-Path: <linux-iio+bounces-3999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD89894F29
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720BC281780
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828B59148;
	Tue,  2 Apr 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ekrRWixZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C88D5731E;
	Tue,  2 Apr 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051562; cv=fail; b=dmKjBWXWutkLaHC0rVWTEZ7IW3urLXoM3tcr2XKfcJyDS/RULaScTs2RYk9PypvqAXTDFDvrq+ibLYncFis1VnMKmPL+1n0sEjm8rJYFOWi3VTFkuv6LJYKaGReDfAAA0dTRtC+pAswFuphUbmsl3K5+jbsVwpa9F0pAXxI8fpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051562; c=relaxed/simple;
	bh=p10S4c4D6FO9NhiHfgj/aI/MDzUFlFT/LvBzJeP2Y5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAeBjGeYuJBT368JojhMznere9o0GSfR9ObldufY9FSJC4/cGY2QPm/kJF6tprrtIQOBIvGFJUeLOsIoNpOe+vDcSpDTbEumcjJU0zbsRlSTTAA8yF5Dv4tcpgNa9s8RZWMxxpaE2bhBr49rg5MAfCvp09c8M1FWoqSkICZ8uJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ekrRWixZ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431MaeCd004295;
	Tue, 2 Apr 2024 09:01:09 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2168.outbound.protection.outlook.com [104.47.23.168])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x6c3jhwd5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:01:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOdabP0V12QgeEY2dOl+owx38F88Tzegx1GHnJsaATV83UKL54ajGYRNJZ7DhjSHsahzOF1CFIcIwx8d3bqaFm2VCzFEqjFiQjDMju+gyyjEbOmYFoStO14VuGX47DybZ3HRnhVTXFjPD9cRlTKjRLxiDzaZ5cQgOE/H18TN82b8D3G+lqjVvVbh2t5Ow8L6Y6MXNyAwlefjiD0KVjrHc18VbHVpdkQ6JGrPlVNfP30o3StyTUVSOZPfw+zuOetP57PmkbRufcsMdm0hcDT/TUFFnQQ12RDrngDdFHjDUD+nAchiYKRVSIpLDHMAlC5W+Nhph7OdgDSOxz2ioh9V+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brhJJ9bPx3T2L6fRx+N9zbEt7NAU4MLUeD9wfLSA1SM=;
 b=Mc/72yzQCEbjnfOO5m29Kb53QeAl4UA7WITUHKRbRODQ3x4DyD742S1nsM8S0od6ibwpVTy6e3DN6OYHNFwHHoGVgxWpcFMiC+1Lj84IZKJT4Oru7h17m2kHKlBLLpaiaafIbGRSJlsOXbXu477Bv+3Tllno3u/t/JBMuE4l6Q39xb70+8Qog3ARevoxJ3mxZ/pOcD9h4qQR5k0oNoTqb6rgaUZwF4LsgUu4D/O5luEIfApGduTX/pEci1AYQ5+62H8mNgO31ibwkIwEdQnk31Q0/jNLlMMGkNkAHMaHk9WtK8/ZngSdfjNkLkm9YWhH7H7Dc+KcjlC2INLBjonfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brhJJ9bPx3T2L6fRx+N9zbEt7NAU4MLUeD9wfLSA1SM=;
 b=ekrRWixZCxZiA1rse26k4TL8hRihmN+tZkZYBBgj1U7w2eg0ZaAJePAl4WdHV2897gPn9+rGzg0tMFdmc0vXciX4TexWsvGTz5s7D04DPjiDQDjJSbvZ4kkbpAeS4e+OxMEQz+iHfXUoXhzQJLoI/YQ6aJynwJpmKWpfEAzBhTcAh5tYEs8looXQd/2hDcasnJKDXYs4k+a3iCwd6t/XHnfyE7GI6qGwe4SwMH4Z9qavV1bdvo9RJzzQJ3GFAq3ona0/w5si4/RuzrGHpXCY46g31IV+XLY/LvIf2mVB/5/+JubbJui4szk8LfV49qM+fVJf0KEO188/yW0LXQr0Ig==
Received: from OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:174::14)
 by OS3P286MB2216.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:19e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 09:01:07 +0000
Received: from OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e47:e0f5:b361:f441]) by OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e47:e0f5:b361:f441%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:01:07 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside inv_icm42600
Date: Tue,  2 Apr 2024 09:00:45 +0000
Message-Id: <20240402090046.764572-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402090046.764572-1-inv.git-commit@tdk.com>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB1950:EE_|OS3P286MB2216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4Q7GKYBOO0RRTfv2kUnE3YZ2VA9WO11JLaVbHPWrUnP+5pu4wXPV0Gz7RB3V45xcL5jyNBwyqaWS/nIIIV05NBilq5be6IL+Xs94GKEjl7UirSj/XDSFuvj6nOcRYPSnCYt9SUCZ7uBPf9Pi2c6UrpLNB2rrpO1D3XX4vHM4zFglLBwmiolfuQJWbx0Ej4RSib17mJTD/esL0qmjU9Z6NbVl3WZm0YpJL/9Y0wUXhuhnNP/R5VEFOB+IUGuEbSPp64OpYIwZ8xu71RW7ccaHihlFY3nP/gKyUoglUSL1dMSUpvS6sUdrn3YW6YhCDMfEjDzt/xCgDcYOmwYNrSrGflYJARwQDajro/m0RFGzE/mTKR706qYjk6UBAsOfZJBrhJQnsBMDCZuTxzIv350Pce4EEnZ0Aq5HrzUaGUPJU1EIzlIm0i+aAF6T1NqyKMveCsTCZqerh7dq4txZT0CCcF/s1AYrz5FZEC5vTLMc1f4uEUsd2TxRrSoPDM7O7jSlrksLYw0wgdSkDMiHq4aobKI9p3jLZBNEuE9hJn2BHJ9oVjPDLKNiP3Q6OFKiBLWZk58RBfC0MjA+CtBz2BAhLqkdwe59YC4UxP9WSStEB9yiAjmrlKxDDDGmnYZ4GtF2/dPC/CX1S6FInM+FJWsR9FRmEeM/2xOqu0xKFySh8nthzFfJYziH/j5qoehKpmDlNYVwo72QkT5+H7OBUFYaS3WFKqw1R6j8SrN7uBAfbnv4dCE2qN4Rl5TF1vID75Fa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005)(3613699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5qsT6RMARUYnWkQJPuhUSygyTXhPHMQWgtWwdGPt5wt0gv9CYcungwgUb3UX?=
 =?us-ascii?Q?WD3HmrgYX7owRkakCNjcS9rbBcON4Cg7MfYsJGDLhmBK129+xyRw9p1V8h3T?=
 =?us-ascii?Q?vUeMwtkuDJx+6Ret4pzlAaqWupUyvL6ZilRNWlTXfJCZKcEBxkTjwWGgCbce?=
 =?us-ascii?Q?n1oV9Gfa1vIBPi8MJxcEBm4jshkzJDFAt9Z+WV0eexG/eAmbZNA8T+P+PCyX?=
 =?us-ascii?Q?M0N5LI89Pxhdt4TzvIIgI9TyDORh8HThVRe/d6RYp/rRRPXB4XxmeKD8lOkt?=
 =?us-ascii?Q?XGq3k209RnO3Hvv8Ed32b7Pncc2i7fDuLNm6xJqYqCN+oy4uVcHJNFfREen5?=
 =?us-ascii?Q?gEGasILb0HWSnMOsmCisOhRfNjEf61vfowNPnFPEyf4fBfvxOQktJxQWl6bG?=
 =?us-ascii?Q?HmdZx9itAleIdxTxtmJTOfiCxogYhBXGFq7TUZciWDgppGGyLOF3el+BXQdP?=
 =?us-ascii?Q?ircGhqnusCDhmT9B1CJRpg4cCdgc95F80RXrA7iG2RAhT0fpXCf2Op18Kjh3?=
 =?us-ascii?Q?99S1oJOSfEnspK+iOLTi6N5L2rs+Jao3qFLjnuGZghs7isWyyGzcuF42enta?=
 =?us-ascii?Q?6HAbovnVABp9ZHZPUmziYrfc/Y1ElQPXswT7AtZpZZW+OQGrRjhQ8JEmBVlB?=
 =?us-ascii?Q?kpLfkAvmH0H5UUPgvFPstoOwA2qR/otDa9ews7ND4WCKRySlmOUc+tUuUnu0?=
 =?us-ascii?Q?VCfXhOei2+s3lAZIk7G9Yu27B8K2s7go0YVFsfpO9wiZ7fziirEwNos+dKFc?=
 =?us-ascii?Q?/t0P5L/PiFx3Ruz5D5ntfVPdIMP9n5xCckfk/G1N1+M23ohcXwf/E2KWWd1u?=
 =?us-ascii?Q?WMpcThSRpJd2bG1wRH2qHx0EXBMgHbZoqpT+LyIuVcLS1Mrfma2VVgfukPiK?=
 =?us-ascii?Q?NwbSIjLjJ7YFsFtXw8ojdR8NEyuE6ytfJYbyyJCFNbxYDWmUHZISOtSgUY3o?=
 =?us-ascii?Q?Evl81giBImweO/Y8KYqDmc2DFe2a82rmQGsKMNkyroBXtRFNJH9nh2xT7pNe?=
 =?us-ascii?Q?LQS6gqggkldBrTLLqxW1QjiC3umW2hFuOcIewEOhoxYQXOBCyb+qYF9mXLC9?=
 =?us-ascii?Q?QOJNuq47kooq1a3P+jMZG8o6/mt5b/J3D455pc/nUak7qf0ljMZ8dY2x2QoS?=
 =?us-ascii?Q?9WaPHQ+4sBJ9rBCBtJIgKEdg+ZIy+MhPhowkdgPwu5ZT1Mwl2kNAG7hffYBh?=
 =?us-ascii?Q?ewmwlSI9Bl3HYjzft3A/FTdQHrkYtVAFDy+t24Diera/325By6a63dc5SnYd?=
 =?us-ascii?Q?F9i1WDuJs8bcae7e1LdTwEUDKhzvsAAqQ11+Anj6840g3xNcCcIIgKm0/pfI?=
 =?us-ascii?Q?pgVNfY6yrbhbJYAPnwIsuUXnrR0yp5MCA+zXIJsb87VWPtH0FrrjGVYgxKGa?=
 =?us-ascii?Q?M9zI9nn1Wn67Jn+Vh4+GrJ+Ddb9vw98X5MzrOn4mQU+ogQH85nlNE1314rEI?=
 =?us-ascii?Q?UQnwvZN+kvPU6/CKINcZuUDux6ZuJXBLpBBWzSEV3EgFzh2dKT3tcykz2mZC?=
 =?us-ascii?Q?v2OUiFDxJByg6jYyumLnazR/ZSHfczufuc0B9q9kicUnhTxmBq43PuFjDA+k?=
 =?us-ascii?Q?aUeH8OfEc25LZTQEoIGh3/2rNN/7OPS4ibyE0oJ4?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6818ec2-6532-4525-bfca-08dc52f36eac
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:01:07.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtD/VXwGYk0fPPYlZoY7PDFx0VtqwPCyFWgJ3Bl8P5RH63Egtt90e3zkRNvPtNAeG0HgKWc4rDshnYLiSh6NJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2216
X-Proofpoint-ORIG-GUID: Sgje1iChs2yi471kjzE5vYf_44Gjelad
X-Proofpoint-GUID: Sgje1iChs2yi471kjzE5vYf_44Gjelad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020064

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add bindings for ICM-42688-P chip.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.=
yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 7cd05bcbee31..5e0bed2c45de 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -32,6 +32,7 @@ properties:
       - invensense,icm42605
       - invensense,icm42622
       - invensense,icm42631
+      - invensense,icm42688

   reg:
     maxItems: 1
--
2.34.1

TDK-Micronas GmbH
Company Headquarters / Sitz der Gesellschaft: Freiburg i. Br. - Municipal C=
ourt of / Amtsgericht: Freiburg i. Br. HRB 6108. VAT ID / USt-IdNr.: DE 812=
878184
Management / Gesch=E4ftsf=FChrung: Sam Maddalena

This e-mail and any files transmitted with it are confidential information =
of TDK-Micronas and intended solely for the use of the individual or entity=
 to whom they are addressed. If you have received this e-mail in error plea=
se notify the sender by return e-mail and delete all copies of this e-mail =
message along with all attachments. If you are not the named addressee you =
should not disseminate, distribute or copy this e-mail.

Bitte vermeiden Sie den Ausdruck dieser E-Mail.
Please consider your environmental responsibility before printing this e-ma=
il.

[X]

[https://www.micronas.tdk.com/sites/default/files/header/2024_04_TDK_Trades=
how_Banner_250x135px_96dpi_embeddedworld.png]<https://www.tdk.com/en/news_c=
enter/press/20240312_01.html>

