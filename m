Return-Path: <linux-iio+bounces-5092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04E8C8A94
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA4B1C220B6
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10F613DBA5;
	Fri, 17 May 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="lej6hFq8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F313DB88
	for <linux-iio@vger.kernel.org>; Fri, 17 May 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965824; cv=fail; b=XzV8jnhyuuvTakKq7obm+iK1AEdIW6072ywn5uLXOBhmzYmVZBe4tA8PF5/eHYlUAOmUyfxOy+5b3aOOX7wX/YX3Cxpd2hGodpob7BhdJQNS4KgP07yqtwyfcGMnXFLyI1gBRX/bOtDotPz2UGXqKgESjxsfhhtBgVWbvsbBA5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965824; c=relaxed/simple;
	bh=MkTQvgyPZGf0A40KALDcdqgPlr0ydX72K8yNa199BGg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=btNeymLE/RH1gGq+z9lh/KSMVdvlv9C+RLF3qsAOkdZb+9ienfnEIcVbtp8NtskGRa3Vh/mM+DLI/Xyoe1yjQ2jZSG4SRnrcggKSY35LXPXejJ62LZt488doL2EH7rTb+5zG7743nwvWeKi1dbHPcjRz7oETFNhlm/jcs0q3nSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=lej6hFq8; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44HGrOfN009019;
	Fri, 17 May 2024 17:09:55 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3y4096aywg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 17:09:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYYyUf4Lrre8n5LpwaO8YW06owOHQthyrT+P+OjaYdmU/sUkNa0UdYc2Ha0tZYkKrTLzdbeU9XaT9MfRl81Zy7k/kW9bHndqocX/37JP7kG1mqa70m2/ArJvhODXjt+xwDNBWXeTX2aJX9TpLFIj8Eiw+IbmwTQycpOPPFVgqnF6lguAdIVTwxFAN9LgTVusjULZutTEAAep6AOfbGQMLrGTGxxev4V0CZJh8+bRaxZJJH0+gWE70fKfyFgpOWtUlxwSWO2ROzWs9J5nPPs3mwodM+xP55Tt+Gq37iibaUS4IgRGJhUkHkIYApbvpOuK23eAhqXKGrmFioFNOLFqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgNF+1n9lsPNz2gdT47EhS4Gy1oI/4BQhUxjVL6zV+w=;
 b=fWN3XUXDNwPVOyQXgI/nfoay6g00gZYNLX2XiGrlwoC4kAmwjB9Bg3h4j7pS/uEX4sp5PIUJTiezn+Ynu7/OxnAdOIpti+S5KtylK9ay+WT4VQmyQDIQKdRKe3PgArQ3VZSTt7lqsamKGlw75XpWVw8aF3v5C2/XimZehTHMpKICrCDoGmEBLP5CslUzreRa4/RSijIIfy7UQcJDUu3+1bMXXXv2EXuv1PWmWlCzhmqjhMUuSlAAwfSCrw1Dr79BMix+wVp2F7KUnko/LPO0DPsHrH0fnjs/zehNkp5D7xJCHh/LEejDAkPL9aMvVlZBFlZgSuEXVdWPWC/T4TgxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgNF+1n9lsPNz2gdT47EhS4Gy1oI/4BQhUxjVL6zV+w=;
 b=lej6hFq83IVHbNlLdWcSfKjrGkfTT8B7WPzZLJmDZwt/ED/SsVZV9/NQjhs3YF/iMXOjbSf6B9qQnWm5msl+vy+TlBZ35EeACjVNr80j6ZKntejRlP4F9SpHlKW41lmxftGnfM24uQdjoreWxmEtL+V4eCuDfLZiN9aYXlPsbNZKAz3zRFlgRh6aRrm7gvW3hIR1eTAP0ID66epMUWjdSYSoTrPnoWnjpkI2+5UXvfXRU5ioFyFIdAk9FbvIvIZr66X+bJKvFWxed9xSh+nCmgOPM9rF652roY+1wTFP41jDMHfbX2JcdJG0RSTDfW5uOg3lWgwHOwZIbreOmnSQ8w==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB3266.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 17:09:52 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 17:09:51 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2] iio: imu: inv_icm42600: add support of accel low-power mode
Date: Fri, 17 May 2024 17:09:33 +0000
Message-Id: <20240517170933.471347-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB3266:EE_
X-MS-Office365-Filtering-Correlation-Id: d61894de-92ec-4a26-5705-08dc769429b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|38350700005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FuJ2ysbLnSF4YtKGX4kvZm66/BiqHCzDzIhJe0JdbzZvAt+Prxn/4eZqSAU7?=
 =?us-ascii?Q?KI+d9zFLRQX6cuuFhuUyk3NLToH1p6V+1RisiFf2Ln5EBZUjkQZ1448dVRhx?=
 =?us-ascii?Q?0Nys+/G+3nXVgpVShAq8Q/Gw/gNt61G2Z3i063jMKlT8EXUWggt9h9OEW8SX?=
 =?us-ascii?Q?pujN5jYKb+gshUlD4KaocWDt4r8Hk3IuE8rpFibCBmew3e4Cqok2nf6RS70L?=
 =?us-ascii?Q?Q91TIPbl2o7o8ma1ufCDbwR+L5UvJEgT6PXQlwVPAcY/94jvISRwZaONID1T?=
 =?us-ascii?Q?I4aKZR/cD6F60ycvWLEI4CZAVJga0PIl8jatPNPdyrBVXPufnPA2MdDRvrRF?=
 =?us-ascii?Q?NETffpdlWNoEsOgVwVZGl2bIr79MMxh+X+pyeBByAFMuAeI05JqCkHP+lhc6?=
 =?us-ascii?Q?gpo3j56NUNO7LACEesAGKyccdP+H0jZFRBtpgqPkpY+N+uqa/9M+bjqPTSv/?=
 =?us-ascii?Q?+D9y9RFU0JMWDbvLHOyxoy8M1D82mA9+meAOMLOvFZffLHKSeKz5lVg2B0U1?=
 =?us-ascii?Q?2ann6X4/luBGL1GyR0muOz5Lo0Agp2RGfDmPsgCXBckoA3I6OLRweZVF8H/q?=
 =?us-ascii?Q?ooUgu/i50fpDaiGeAk+lv9xp+HKGtuAB2mrat84Bl3f/AVaJWACVQQLY+rbS?=
 =?us-ascii?Q?7mxx+0gZKG6Hm/8DKNilvypiBGscaXLslWr4SFPrnbaPmRwwA8OmEah/MIvM?=
 =?us-ascii?Q?7IhnAa2g9hSkNP9WGYWAhuNpgKclQOTFqPONSjk/zYW2rdttpanlQYZbS9YG?=
 =?us-ascii?Q?2O4HGNp1DdhtWGPM3TStFwUTiaUzzag89uwBLsNuKu5wouYqae95G7B721Gs?=
 =?us-ascii?Q?mM3s4UGwoBXfEwdcKNdlPUweKts47F+m2xtiVXSAqtUconDJFCRLoFIbDYs9?=
 =?us-ascii?Q?0GCFoD7jFeImY5EWluJNud2DlZD1yBOLT6D67eO4cUfPv6wnHcaUK0xB+pG5?=
 =?us-ascii?Q?SfJMcXA6amv0MdtLmdZbLpyzYwcgn7g3c8udl9WkHorMOKbdQ+/ymmR3+Yww?=
 =?us-ascii?Q?GoGP4VRwEaBfs7wyeMDt/dF2/pBsYS1eJw1QdltusUzeKzkfFu/9QwqXhvHK?=
 =?us-ascii?Q?ESyYw85+Ua+UTFlTze4dun5e9m4OV5xAbdvRKKv5arHZpY9FEbOQHmaD6Ddd?=
 =?us-ascii?Q?e0hF8Kbu1OyJm4QwNsz/DPouY7NWUnbHdTU8vPUwLfpuuAvgHIDD+L+FArEg?=
 =?us-ascii?Q?vcFatPUjvA7+DdPrIO55P1tSdNoDbe/KOVH4NDOCQLnrIHM+9gVw2ixLzXTD?=
 =?us-ascii?Q?e8X5MY2bdDA3Qgoc4yFdWnWLKV8bXRXgkLQ+QlkmyV09DP3qYFW3O6ASlw0P?=
 =?us-ascii?Q?cK4tOCNdKSjPo5iBAeOnUc3cz8B2Cg8cRLpY6Ta6yYq2FJ0wavF2Wq4UlUZY?=
 =?us-ascii?Q?VNu3YQA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZZ35LF5ewIccshXptGgmsNZYCUtQel6Ci/mMaQDsT2SXxB11EOlIZhukdry2?=
 =?us-ascii?Q?plzXXIchmHJIOFuOk/biuffRFlRKqNC/3mXe3K0DkTUSy7RPey+jb/kDtNCZ?=
 =?us-ascii?Q?gc6uLLoB8RjOdvp6Tda7rXFhwt6FRmyW17DZuwx18KCoXAw68FLpSQqJ1M2J?=
 =?us-ascii?Q?jgkvKS+04Rs6WYe6/YRZXVuGyYouATP3gq4J1xapP8Ng3UkfHU2TUVNiizxE?=
 =?us-ascii?Q?pXZA8IkckCoCAp4MRaKTDDV6/2gRXuuo1mY9zaiS9zJQK88YyBIV8MLIjoIB?=
 =?us-ascii?Q?dZ0M84tltpUrQaqxi3RCoUFRwuOETnD+rDyn3vxQSaNo8i/UYODuiF8Vd1N0?=
 =?us-ascii?Q?sj2L473io2V2+WsRcYQyys6lW4beN/tA28xAGOM0Z2QoUYOD9dqEXEQ+xxRW?=
 =?us-ascii?Q?lgapeW+OpPZQVMPpPV5qMnVoN9/i0J5lFf9VRiwsTBL7f1pNmkFzkag5qt+1?=
 =?us-ascii?Q?AGTx4Hba68F4PIPHrzBtd/FwWKPMFRR51p/8eNQYlanpFeSJnQWgtm36/rhY?=
 =?us-ascii?Q?LYZGvpLnnYgy8bgRebNYe79orsdA330k9rK+gnAyfDV3x/ueQN50FO3w8ZK0?=
 =?us-ascii?Q?BABU5J2mLB1MIG2nB/QootAzySg7f3xU6Q6zVrBvfbXFzjBO1bjvsTF7FQTJ?=
 =?us-ascii?Q?2EYPkiPk3ev/OIOcR0XdkPsHxeL6dY7yhT5ggelq7ay+98bgLCdenxamGoQd?=
 =?us-ascii?Q?m/yNGOhxfnlaPuLdy47l1OptKxk9RadTERf3rtOKRjKABxjrvH2Ph0kQYKsT?=
 =?us-ascii?Q?xsxHsP5YRHdTpq/o9VHcAzjQRBITmRSk8WC4dzooBNZRdGBM1g0QEgi2qmdr?=
 =?us-ascii?Q?gEW1byLZa5fAMktiDu8ifbcjWoUOFIS+o2pKunGwl1z8v3cfdWYelOS80BBu?=
 =?us-ascii?Q?KaWQ5Yl7uEl9VoOtiTFcwKfp7/pYeQCH0jFgfFBuC6rAPHXGIMCXkTnl8gy3?=
 =?us-ascii?Q?h1sdHumA4DjAqIUSNz+1i+Sl86EXUYtgo8ExOiUeG6DkGHKfXwXfPpSOUgZI?=
 =?us-ascii?Q?7MVDleat3ognn5dllS2Flh+g1Jlgrcff2+yhatGl0bf4eYIk9f+AP+CjyXdR?=
 =?us-ascii?Q?gIkclKI0F8BIl9I8porSNOaLM0X8GNZ+V0GCe1mtS6JveE1zTY6IARVwJl1p?=
 =?us-ascii?Q?oDyrlTXoLmN9yC7MnjOT+4PNJMz5qlrmbaAE7jFklo35d6Wc5e7V+H30Okd9?=
 =?us-ascii?Q?adXUZ5WwTQJi+P3cvWxGObVTqP2fQbzy1jxNvGEf0fGQmQKghkFyP9JWcDR3?=
 =?us-ascii?Q?HnZ9MqbT1q/5aZIfoiUfRrcORFjBR8zBtulfnvDfY5dc2rfIJQpcBHVXlL0+?=
 =?us-ascii?Q?FfS+PpF3WAdXMf8huRNNvU4+oTywgU3cVDTAjL7eXxhwwVj4lbdxEzMgP3UT?=
 =?us-ascii?Q?I0+GntWc+Y2Xz45QqWxlM8NMaC1ozqSWEEHJq9Gk/gv/GjwSrt5e9Gs583K1?=
 =?us-ascii?Q?iJKqjYwwz+KHYBJpXWMMfRv9WQ/doSp9NuMp2wt0uMbE0oySD4Qcrz6Gq8TT?=
 =?us-ascii?Q?kBojVN+6CJ+dJBObn7oOFr2KmEOFUm3xQXMwnF9yk5NjXBHPC/eUvktAM7vB?=
 =?us-ascii?Q?dd6JXVIryuCQJaTBdX8ewIUx9cTMuhGtgbkLY9BC?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61894de-92ec-4a26-5705-08dc769429b2
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:09:51.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPkKgJXHBd3TTpJaXIi9EIUg8RM2VT9JHjqy5fmUV8EutoES8g9+4l6EpvnpcXw7/lKt7ZveeeimPcvi9ukALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3266
X-Proofpoint-GUID: xSLja-xAlHCstY0eie4qitC0lFlaIfJF
X-Proofpoint-ORIG-GUID: xSLja-xAlHCstY0eie4qitC0lFlaIfJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_07,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170134

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add channel attributes "power_mode" and "power_mode_available" for
setting accel power mode (low-noise or low-power).

Differents ODRs and filter are possible depending on the power mode.
Thus make ODRs and filter dynamic and check values when applying.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
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


