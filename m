Return-Path: <linux-iio+bounces-4000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923E9894F6F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 12:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31031C22A95
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2B60EDC;
	Tue,  2 Apr 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="GKDYMh6+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F985E060;
	Tue,  2 Apr 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052047; cv=fail; b=AAntenAVI/RRP563UfmblDpEfbE1I/AGDFiDqGKVYYZ8SBByiECGF5H7ls6ZW0hFzIQafQEAs4ahyYM2mPeobFg0p4eZlzqDZbktAb0cwKUmq7xTPbfA7bW1kF1fqqiDN0HcyyW3WvltmZh5pcpwtQY8m6h19tLPoZ2+Mh9FjM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052047; c=relaxed/simple;
	bh=2md0V2Odf6sh2ZIt5amJ6YqVKv3JfRyze/0Ei2qCiyw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RAcLpr3e/7r66pyHdxmLorr7YOAH/FtflJkpNgD8J3667pZMJuUPLCp5SIzviYkiUdShDvAmb12o5cgGCYhLgoyKInU9H0hnsP8fp6hs5TDkc14koUpC5p89iPB9/RGNtLbp19UoCZTf/6/BQMh2k7jqm9CWmEq6BXnExYG2eRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=GKDYMh6+; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431MaeCc004295;
	Tue, 2 Apr 2024 09:01:08 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2168.outbound.protection.outlook.com [104.47.23.168])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x6c3jhwd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:01:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzwYrPUs2HEVu+A7qheRS2jV/yOX2OSXcORO0TPU2ofj8iKjsPd95cSaA5I1Yk3EQifIkugx2o5UcxLm59Il/RiLdAtiPo+o6YHhlU3bVWYwRbdLGMD3pHXNaoxGatZDbDp371Snfy0lgsUewtZ/yYAYxhsskUKxKY6oMY+3AE0JF7xR1UbSa4YPzlOqDXxbT+zOzHCZmSBzd4Q5oeK3sfzTgTrSq9ld4R7k5ZDXs89sOe0ZetgtrGXNF0JlvOQIqT9Z/fGJt5V68rVtQAHnfSwyPCYEZkYTxiRjMKIo72806tYv1AY900a43mLDh1Jn5jSqyDtQGRcgMwItv4rbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uPgQGk0eMQ9+2YQlVCQ16qUqL5Ef36oLSZpQ53JaQg=;
 b=oLi0CeHMBw9WGvEpZl/ErdwZJEnI6YnhGHGzCMe6J/7vjXIkrt1Guz9Ot/rNLg1Az8ENuNIV+jbUF8xLbjQMluTBGxWDUS7mZ5cb8QhIKQf5+5cNmpONehDo/jjsxE5nw+o2UcIPb2h3FqsQvmIKMB3hE1eNbOMDwRVTmIbMW5qUQevN+l6jsreBu/n5Ku39jJRa7QKnHOUI6h8EfNjxD8xSKUtxVqmaUgal9hoemkEQXycGSSbSpm5jry4+QVTb9btmFb00slH/+UGC81O7DQoK7n/LQw72eLbuAW5lJ2uF7dwMQlwvBFIKYNcxVOQUQYNjjyYjiOwVXNh/kgxK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uPgQGk0eMQ9+2YQlVCQ16qUqL5Ef36oLSZpQ53JaQg=;
 b=GKDYMh6+TOe51H5m66qCWG/thKjLqyH6/ZY9HorDe2HG9G311GLHXzXXl2Z0ODjTlr1EdIXgE5hF3K3IFMXdRgxpq/dEuKNOdlVXDCKwmc8TyNby62/qEJm4t7YxgXjjXeJdlJzPwt/lXePS3lOuSRdq9NOLitA308L0yylcVqWasvlKpKamikPE9CpFtU8hQ4oijtEd6WBbTk5Cbqz5d/3YTpk4cuzwJs7MIx9C9IPFlsm1PXQ5ZA9q6m01uqRSo2BRqNP03xrGkv9bRKcZ8xejDQER9NxhD6/Mo3I6hMJm6MW5PG1p3ZW6x5eDNWKPGrjFbMjyrNm916ERYUKhBQ==
Received: from OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:174::14)
 by OS3P286MB2216.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:19e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 09:01:03 +0000
Received: from OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e47:e0f5:b361:f441]) by OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6e47:e0f5:b361:f441%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:01:03 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 0/2] iio: imu: inv_icm42600: add support of ICM-42688-P
Date: Tue,  2 Apr 2024 09:00:44 +0000
Message-Id: <20240402090046.764572-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
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
	oWqxOCjDTd6XKDBzQs0YohdR57Y+kDhTgua+ngUdeXrlPjGG4TM/dnI6Wlo9XEen8ZnFrTBXC6mgJgvWfvoIM+5xHtrZVxMd+sAlmX/+CDZGww7GholaRIacA004O3as31SSgpGwSERWFfh4+KqDTdVqKKLGRtYjH2FGmQ4J9f2WJR5g+yH0VOQU8nJ3iNEiISPq52CBtmTh7k+478p3c1O1KBJLXds/O+MB3nL/U66eXuL+0swUzwPldut6KPXx/ZI4eXUQbaMfUuw2r0qaZyhvjwir6LgjnY+RBggJEfawJ15AkZoXOBZ3PLkBxunMwmXjKSl3kYrgHsBePbuVdpmAal18IcpderDTrYKkFFGWYqqrCvRmZ38EWrW4fSqFb7Qocx7wN33keE4aNj8VGvJh1+B4y7R803KCOyQEPRUlxHyNJCpkaCFnNu06Z+uWqSY/CPAn6wrRO3V0rtc5VNjl9PknTuecmxzNWlhZJ8QIKAKSJcH/9AKcwP9/OKDFu4uQYuEuNZsHp7h2XWnkkFHAiKZv2ulHTr98Imfgg4LkyBsTp0PCnkztWlw46k0UqZTfx7gok6F6lCZSapCosQXBjnhHgcYQHRXHp76X+oCeauM5TR3yNu5TVTCV8ZcTj/td+RlmewAfmLDOnfZxpxrx+Lgvyg8XnJw3mDG4FRf84OsRyxO4/V6Af2Fy9V1dAyllFSHchwbhJ0uJkFi03nSja0A6FNKFH1aJ11lQULq7/+PpqFOhYatfVLFlbLn3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005)(3613699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PXch3dBO/83v3yg4NACvZNUEtPxuFfC/WN8tOHo+Qv9NL6jjTnO2LBE6Vwpt?=
 =?us-ascii?Q?XBSLwUMZ9h4lGNp6j75KrW2mzxTvR8A2OyfQ0nluqMiN6gfp/rJx62+jKUwN?=
 =?us-ascii?Q?Pdudwu1YY228+tMByc/Cj4jcI2qTkxJCSZqNHKAZ6PE2c2QueOPn1KYgGA8E?=
 =?us-ascii?Q?S3VAooYwOwFKpBwE1MK1/U6eusNYl/HesDpV3PNM4IwZ5xJzT1wVxiFWsHlM?=
 =?us-ascii?Q?2CtY4NVL6Y2nYzkRkk8AAehz2BH3X//dDOI0M/mIg+zRuPLcxotuJOL8W/pS?=
 =?us-ascii?Q?1pG6XD0sUpcmNFW2pUml81k5Lx5d/tC8V7sATvSluv2wVZ5AFLZjhK3F4Snm?=
 =?us-ascii?Q?a30Cn7y5o9CPWXuJ8EeZ3yr6fmJJL3+ee3Y6mcpIxgpaG2rmQA7wBHYcOEwp?=
 =?us-ascii?Q?xs6ffUZTskXAmBGc6DoUvcPHN2TedOATYElBLyBmxDqPTn4C6EYeX4/cd3Ga?=
 =?us-ascii?Q?au66Fi9BziT1ay2lvZvBjWnX6PGKyNT0gknkdjxbeLLQnAlTgRtZNrl3ljHw?=
 =?us-ascii?Q?JM1kZmbbpsZ/cy2y2KLPjoJe8LrJAdeigZTjLtY6Oyaj1AEu18D7a5EsiJT+?=
 =?us-ascii?Q?K2es3Y1OCMVswVu8ovIXtjPjjgwXuPGRKDt+H8MNHfgX5ddXLx6xKEaKdXIO?=
 =?us-ascii?Q?9Wyw+mhK23c70W2xJhVlUukHMgV0mC1kcZ160386M7mbzK4KreMl7bxiQiqr?=
 =?us-ascii?Q?hAqt+4CWow+VzNGRvxJYAdTfKddqTj0Xf/k7SbXq3leanSdvutRFaFaIuhO0?=
 =?us-ascii?Q?6euSfytVw5n+sC4pkm8/ULZmm0w1H7JSWbwxj6lSNSnvIgflB7viV0172WOs?=
 =?us-ascii?Q?KmOQBPwIu5gCuSueywuojt+A/m6fwbU25NTVtldMLxNLHvdgXaZ8GBRZ0tKw?=
 =?us-ascii?Q?WViamV24YcAtecSpDdCcf8FuYFMXWuNO6ToUT8yFkQRfzTN+TsAple8IcgOR?=
 =?us-ascii?Q?hsO3H4+6DDTPQ1xELObTZA4pasgrDd/EvJPkXqHt1sDYZRnQqKEqUE5HTzk/?=
 =?us-ascii?Q?mWKk55yeKYr6GTbJiGCN4HQmgaqPHYJ/dWLvbPAIqONLUNnZV/2b7bZW8Sf0?=
 =?us-ascii?Q?ltEKMR5nXljvdJYHceLbHFk9W3BjUKIX08ioJhz7B+gNfR5P5gUz35ijVJd7?=
 =?us-ascii?Q?20C4ucN/b0OaAEezwzlaAIo40T/hlVLjiZdBTCKRMoqwkDXhmLxV5blRXWpe?=
 =?us-ascii?Q?hsRk9Q4sqJEvUV73mB/GBIedhIyPNnC8M49c56dDSvBJc43cQ2R95ZFg4D8Q?=
 =?us-ascii?Q?yFEsbX9X/UAvS3sv/31yOHLpkW9fgraTm9ICSnguJ4QiHSTWvroc3TEhRBCJ?=
 =?us-ascii?Q?yhjcGr9/RQjrR4LRtOCniD6M8YlaGtedac7GJgaHNG0DD6DBpMmpXK3QmiaD?=
 =?us-ascii?Q?yjSH1WxyQmBznWdEhSo5orfXVAvCVUSRzdmfU27KVoid71GY6fsyTLj3mSKl?=
 =?us-ascii?Q?hGNmIq6cwJ+8tzedSFYKeVq67gVE8501CTYD6fZYruIdVrBRdXuwee293D4y?=
 =?us-ascii?Q?5s9xzHxuy+J7H0xlm4wwtFLHhMESqPXQKOkKn6Brmm+b+9qNXDJH7e56ZBFK?=
 =?us-ascii?Q?wlCxiL6WlXx+icc9xgRMUCE4cSgAPDja/ufafacI?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dc7c98-8f9b-4aa3-da15-08dc52f36bf5
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:01:02.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKzBh9Zp3rqkzBr7jWbIAoEImPUYD8I6y1Dzq9ZYKIHW68yLKP6y8eKr8lJW9fVFUYY9HHfBy6BRWgB5LQ/Gyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2216
X-Proofpoint-ORIG-GUID: gHGotQKui_70uU_gpgd_ss3JTWXTYIZj
X-Proofpoint-GUID: gHGotQKui_70uU_gpgd_ss3JTWXTYIZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020064

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

This series is for adding support of high-end specs ICM-42688-P chip.

Changelog:
* v2: change order of chip definitions and order of patches

Jean-Baptiste Maneyrol (2):
  dt-bindings: iio: imu: add icm42688 inside inv_icm42600
  iio: imu: inv_icm42600: add support of ICM-42688-P

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 3 +++
 5 files changed, 14 insertions(+)

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

