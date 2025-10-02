Return-Path: <linux-iio+bounces-24653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC3BB3BBF
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C501C0367
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784ED30F552;
	Thu,  2 Oct 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Oo3xoMSp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F771514DC;
	Thu,  2 Oct 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404262; cv=fail; b=KkUHNtl/oY8DrSuAex1drg8odyoIFG2AQ/ex/3FqLb6ylruoMm7PFOT/3zxeMQ8bQMeSq5guaNlUvv7qIh1zg1/ExLC9bgsa0oOxXVwJoHxLJ3o7LrYXmdjNFtUNAHtIWBTFlM/+cZIDM5kcJi8zfZC22kvlJKiomNqyZzTHu6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404262; c=relaxed/simple;
	bh=3ZU9Zk130gFtyVs18+I7XTJWV5+iw5lWkPkwb6WtLTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZnZR3Bd+nzsZyDnXE4ktN7tYTn0/RoAg060c7HeILWwfNq/0oqwFZC5xUEm930lHOV7pgCr7dFaO6t8eLQk0yAYML9YWdb3t8TO1bR+Oq+bvQ+/3v2GWafwH3pQYpcg8pq4msMI3sK1sd+s5rS8Dvr/KEWJvRnBBirpk+OR+As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Oo3xoMSp; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Ad7aF027544;
	Thu, 2 Oct 2025 13:23:33 +0200
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49e524mjjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 13:23:33 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkLbDzlg2PUxAkLWVfaY0Sq8YWIdlanoblKsMCcR6Xd57i8NgzmfeHcYt488IDEg7jtI6J8yhS8nu+ZyQomM6DEoTzxm10xGSpUDziwViXda3w07aG8Lf1vpY/HGqnlfJnxXo0kmuwJLVQToB45EzNjoAWlxmcuf1zB607b74pybTX3gWCY2XybxcMMCtYV+39PMKGsslI71PsrfP0bFuD4Q5bFef4DQuxgQHgzK7JpS/KYgKxPu2KtICxHEB73O2HDciBIJuFsApIrxtEg5LKtsFnSdQk5y4PssN7naBVkrUrveOya3gFuzZuR4G1idEeBKPrxnHLWZUagGvjVx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWIGgJSCHZhrO+VfB8RYqINb3Ymu/jfxHZ3QQE4kgAM=;
 b=I/bQd6ydDxZFlVsKaypBnuJAMNR/Hpsj6D4Unkbs2NtIB0XDiSdhHmBRERrK40vJ0YdtB6aGgucER5XAnwCTLgfrC2oECM7+wWAhT9txi4OK5azJ1bgJ63KdPsBu4xAz2Jd+V+kKxqYlBphw+KL6S6P69RvzdBiV+i8XYSkG+LxpRB9q8+twuQLJLgatA0xRTEtJngFSVEttslGJ88WbmgdBiFeLDeuoMRESV1OsEo2+lEVvk/OhvaN3Kxy3ijFGIchKYbN/MjtCnV2V0q60tv6JsMSMyYBRlwZL4jT78TUK536fu1E2H/a/zZz3GKZJpYnVfjC9VRCfNJw5fQUZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWIGgJSCHZhrO+VfB8RYqINb3Ymu/jfxHZ3QQE4kgAM=;
 b=Oo3xoMSpcI1k0lkVge3Jg8Tl5TSTSIUbQ4i0DJDXChZ83t4HpIMPkcdsrvQCHnWQ66zR2RhhoAhvsXAqcD+md3LXR5tpR2g0iVpTjlVn3qWmApaUJVzf5EhtBioDonyCMn/sttxa657QTbLEqLgWS/Nu8vtMXWhOlbsGTw3TkpjcNi4QLkLN3q729GgugZ+UPOzPtrsFHk115ZwXiAq1SvjRjsPiEEuFqHiXj6egHR1/eJSZYM7lIoZlVT9YnV++xEj2qCnCPn4Jqsh1ktV/3Zf3U2+iEINiIhNi2rqG0LB+h2k7fTI0+An+aw3WNl7VUjCZqJ4PM/6+sfpelm4e7Q==
Received: from AM0P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::29)
 by GV1PR10MB8913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 11:23:28 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:208:190:cafe::75) by AM0P190CA0019.outlook.office365.com
 (2603:10a6:208:190::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 11:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Thu, 2 Oct 2025 11:23:26 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 2 Oct
 2025 13:16:09 +0200
Received: from localhost (10.48.87.151) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 2 Oct
 2025 13:23:23 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: stm32-dfsdm: fix st,adc-alt-channel property handling
Date: Thu, 2 Oct 2025 13:22:49 +0200
Message-ID: <20251002112250.2270144-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|GV1PR10MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: e045a02a-bd5a-48d1-507e-08de01a61b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sZfdFJ3XL3WFwxupah2/j86qHVk/fJC5zEOCkWy2Fs2TgTaUk8Hnhmjz3wse?=
 =?us-ascii?Q?EoI5lH41s1aJSE8YIanbqWmlf/JSbTCyGVLMzugebHXjh4fdCBcKN+Fm52iJ?=
 =?us-ascii?Q?loU8njBmIXYU6tBm+l+qXnRu0eQx/vylIfo/kj3ec7Z63bQllbWxe9bNfgvL?=
 =?us-ascii?Q?KVK190J9U2A3zQYPq9ejl57sbPfYUAzfAzglovmTUhBO6Kljsh+IxEEYGg1T?=
 =?us-ascii?Q?Z24WjkRZsXnIPU34pdzcvFXgYKuJprZSckvd2XF93+m5/Vza5rTSRoIWI/px?=
 =?us-ascii?Q?rRvJIki+x2pcYqliWu+MDDXXgNpny3fRglOm+Ahy28f1J00J/r86PUKBZSQM?=
 =?us-ascii?Q?zQ2Fhck4ofbd0onaxB6Tu2N/CkaSPlNDZArdU3Hi1gd8DJh5Ebt2upAvQOe8?=
 =?us-ascii?Q?0a4Q9A6q1J1XE65J8hgDbQ29HrVVqqOnONxGIv0Wp+snomjv2l+rIkd22a1H?=
 =?us-ascii?Q?Co+LY0yYPqUA/RPvQfMKEAxSc6eMYofJ7VcAgMkFhYFWwpm6vkwFyJG5q3DM?=
 =?us-ascii?Q?vrekmCXEJnTjTtAOGHBPiUA2S3FRS0IIQ6iHXkKo0XRy/w4V5lKunQ/PLX3V?=
 =?us-ascii?Q?1na8+O4ujl+2Dyciph9buLJSOuOFIibTfJJ3B93+7tRZWDjvmM1IGcG0pzTC?=
 =?us-ascii?Q?MjCiyNrlQG/YcPUFOuWz/RrbY4S1VX/HbroCgTrzXZT3hUPasOKtr93MqBU9?=
 =?us-ascii?Q?CC/MQnod0tVmChMJlHVjw8JASggrqg36MjtZm/uFOqxr9BRIeHqRlofaQqJG?=
 =?us-ascii?Q?ICOdIoJJ6OjuUqXdXkoW7GjY5oZJnOkIljFWIMdogM+TVk41fe7Tb39RtHRg?=
 =?us-ascii?Q?BF/tDmEGbQQc/RBpK98WJhHVlgFcqfKsJRe/gtHRFi2tndjba1Zv7vwg1tNB?=
 =?us-ascii?Q?Vblnd+um9Z4zAomYJfKuJkFaEDDdCiNMjXm4iYSap6dXJiuNKKBQh1/zwEhh?=
 =?us-ascii?Q?IEsxv/Ci1DsH1eRwW5XFFznf5KU00el5Fjn0E8yBb0r7FZD/XheVaUoKWY8f?=
 =?us-ascii?Q?uTyA/NQTzzZmshRWalhykZpN2+bJBT0maXTEivTVRxJYpaKqKPqsPHprCQqZ?=
 =?us-ascii?Q?0kG6aH7U8LT+gkbC7ZngWr51F1xFDZjuCI8l3MIhzzdnFW5nrSzxJrmkbaC+?=
 =?us-ascii?Q?Hn0hsHgdb9rSLlsB+YBcYMqOnlTekaaTACXcH/Nw1/mHFKn9+OFzvIvsJFyN?=
 =?us-ascii?Q?6jI8kL8e8A84KbFUH/PJDN/wR94nogNXD8GYNFU5Tzbdc9MkgzuWiZgWjiXa?=
 =?us-ascii?Q?WtypLvVDh6kG7fdfZ5UJbSz8oWszeoDINSBS7VeQ4LFj0cHZ4nR63BJXOh23?=
 =?us-ascii?Q?PWeQTOlX4VOABv9CKmYUIgCz1+cXbCiJWNKXK7Q3vyqgNREQk4TqNfBxtulY?=
 =?us-ascii?Q?b6ilPwg/SCpvmvqHJYvVplcW2MyV/OezB2UYoF6+9TKL3vd4bWgMUSvjJ6w3?=
 =?us-ascii?Q?Jfwr7B9kLJi4V72BER1FtgflQ8zbM1yqh4MOwPmP6U3tp4Zj0YLGjuglwmd/?=
 =?us-ascii?Q?PuvXMoj4VsGXUpunnaFMPjsw/GWddlLZdEfrQDR+7P1rrUyAjPf5yCtrz8fR?=
 =?us-ascii?Q?BDUYQEwI8S6mCK7Q82o=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:23:26.4773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e045a02a-bd5a-48d1-507e-08de01a61b35
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8913
X-Authority-Analysis: v=2.4 cv=HqN72kTS c=1 sm=1 tr=0 ts=68de60b5 cx=c_pps a=caHvpjIXtg0psX5ICJsGNA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=mu5hXWdz7wwA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=8b9GpE9nAAAA:8 a=XY4wnwgGm-UPpo4hl4EA:9 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ag2fTJLylxfuna1lQeEpSGhQiVtDw8fw
X-Proofpoint-ORIG-GUID: ag2fTJLylxfuna1lQeEpSGhQiVtDw8fw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNiBTYWx0ZWRfX6bSXWKHTq75D i/NY9G6rvQJRVvIpMMgqnVOeCv8iTr1Z7MIq20/Ep9viOBy2VHBVwFc33BUQnYTWcU6h9pwo59k oI7T6WaNnAMsMVrjIAL4+0s6ApLuNDxNMLj2Rwcg2MRqYk6P3oSZ2R0LMFfuUFVDAOx0aQUdvgO
 XyP2uIint1BdS6sLXRKClmJU3u68ftgd3hQ1mqDH0/4R3hMcKyG/fmsxNlCda8TWAswHRnfMjRD y08iyQFY9aorOQssQa+AQyuQmbPK06WOe0PYCU4SUMiKmj8Kygp4uxr+iXKfDtoLyzJE2Y9PnwB 9itt3LWcslUTlF0BDejVSk1I6ih8CsEkdY035uxkg9ja63dx7ZGHYC45yd953DE/o9FOXCjg0B/
 j3y9MG3NpxG/lIWtLtmAKJdIQLu/7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260216

Initially st,adc-alt-channel property was defined as an enum in the DFSDM
binding. The DFSDM binding has been changed to use the new IIO backend
framework, along with the adoption of IIO generic channels.
In this new binding st,adc-alt-channel is defined as a boolean property,
but it is still handled has an enum in DFSDM driver.
Fix st,adc-alt-channel property handling in DFSDM driver.

Fixes: 3208fa0cd919 ("iio: adc: stm32-dfsdm: adopt generic channels bindings")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 74b1b4dc6e81..9664b9bd75d4 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -725,9 +725,8 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	}
 	df_ch->src = val;
 
-	ret = fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch->alt_si);
-	if (ret != -EINVAL)
-		df_ch->alt_si = 0;
+	if (fwnode_property_present(node, "st,adc-alt-channel"))
+		df_ch->alt_si = 1;
 
 	if (adc->dev_data->type == DFSDM_IIO) {
 		backend = devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
-- 
2.25.1


