Return-Path: <linux-iio+bounces-19072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA8AA8B77
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 06:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963F23B1B6A
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 04:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811E1A23A0;
	Mon,  5 May 2025 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="a0/gMNgB"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BA4C98;
	Mon,  5 May 2025 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746420868; cv=fail; b=bzQjgY0Dt7FVkWI23KF2+AVsn4A/7QQk7s0OT8NsC0g8zO6p7S6RbXCsPxdLzzYaKryb49s8aYVO7VhWR5D1bSuy2VCp/bp04O5IYOUcFjhQE3bNsVTzygTExrkPrJkymObA7q5f236eoDrlHB/Sg3J27uq59D0iHSPlvDdgYm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746420868; c=relaxed/simple;
	bh=Zvu5mjQkvPZmj4+YtvpVywtA4Ib0RxbtKnNNrAIigVY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bCD0tZGWZHijLsD3JzzQJEI7q2mpQqGBhEu3K0WnHpviAZ0tbUc9/ehYgfx2bC6nBh/uBsxUvfnQEO09kHOJWV4yjdi3k+uN7JThnImWnJaL+2+jVxxr7v2Uo603RkGZjPd7GSD6dqXIPXJr4fxo+G8+QnWIJjWTtv5l7xMDAz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=a0/gMNgB; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8jmiy+1S375OXIY6Yg12BrgS2+diEbFYZwdmv9MsK1KeFblOXymp5V4d70LYH1Q46hIMgUQxEA+74C5y0tRAlOIeV6rXGWBTc6KMbWjKaYmn0f67o+25oiVoB65BfpV6v3QiZapKG47K20w4AqSrq2olgnosQBWoSeY3Xpl6YGkC+yNWWPqL2YI6oY8eKHCWqSemSXQhk2EM+F8ctt6WQ3RW9G3Z/m6Rqap4ww4sYrKZl884xoVihcQAihixDMmkIYl7ursqlMQfDxXNR7KJomedG/8LDBWvV+aXAiaGQIQdZ406AJlhyzzOxCH9HW6J7ITAlps05i5KAriu9dbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVmdzQzKJtx4GCYNSIGHnsTwxCw3sT8MbqpOYcvsbz8=;
 b=oy4pFALBkH1BSRAmvv4rDhXywqnwD2tqBncxDdCLCxVYGOYGzBVq5fHGHHskmcywsodVUbXXdimBLddb7le4u4MEMjS/N3nAiTYl1DUrEOkALfeVeRh/5Dl8o6Ku9Y0UXf7rx96zPYu5BSk32ioQhtm++oz86Rp1DVOSXL7kbtkspNDJ672Fu7HV2mKT9CNCGz9bCxLZHfpyl0lPVUWIt5lJIDwcedgCL8b3w5WibRPJlApFjG37y+Rhif5567//Ad6iwX+DFWWL0aMZwEDuxhzL1EZOtZvDvRQCP2oxwvr1a9gW5swGuB+PgLBPepk3qkIJKXqe9/BCBkMH0iDEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVmdzQzKJtx4GCYNSIGHnsTwxCw3sT8MbqpOYcvsbz8=;
 b=a0/gMNgBcPXmRltQju+15Kz8bkrJFNKlXrVfqp1qgzTvtkWq4hwILmmJgeCSltSqxTjsj3RQZFCjhkC2ycBqTxcqpIkCpRWmJ2fedb7MPku1AbpSKWRjuVSBHsiyt2AYhKMVblrRI71IJpBkAJycKmuRdhH7p1FGvCgnQ/tREid4BBKS0GdtzLY1bYmNKQsWRL/9N8zFIpGqhDQHyYMc2ab2pJGrN4iaQwrkwIkV6+NPhojZCX1xeh+RExD+UKimMbes34CVglMw5objwnJZnf3myKqMzP9aVM9Ng1CyLZhvHjnUmueD6U6BrFmGHAeQZFRQfTUs1PTD5Bv9RLH7Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com (2603:10a6:800:137::14)
 by PAVPR03MB8994.eurprd03.prod.outlook.com (2603:10a6:102:2ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 04:54:22 +0000
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a]) by VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a%5]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 04:54:22 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: [PATCH v2] iio: backend: fix out-of-bound write
Date: Mon,  5 May 2025 06:53:46 +0200
Message-Id: <20250505045346.29647-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To VI1PR03MB6285.eurprd03.prod.outlook.com
 (2603:10a6:800:137::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB6285:EE_|PAVPR03MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 38198f74-6956-4e4d-5f8b-08dd8b90e6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tb7TZdv1c6uGrc7U+H7/VB8SK2VXGopEVhuQo/nfMG7ZjBkQIMuJNQ3b6TiT?=
 =?us-ascii?Q?xja7dPUludmPC9EieConvUBUBRUE7OPAYwUo8CEyC/79fbe9M3GIa41govlw?=
 =?us-ascii?Q?n+NlHcO44xEdF71o89uyMwu/Y7AERSD9Vbn1JUhMXEzfa5mUoX6yY8CtE6MX?=
 =?us-ascii?Q?YLg127w0t+i7gopiKI+LxeWzHZmCkPADnMU8U6N0TLv/YtU+iLZWCMiVIxfR?=
 =?us-ascii?Q?wC+L0Uco6sfqLFZHY+M/d776YqLQ1ECoZdN/vkNiYr44P/KONACroA08iePo?=
 =?us-ascii?Q?rMu2pdpFcutsNnWHERuJK3QgiB0eoErRhH027BupHzZPLjLbx0PQ+c7dS9oC?=
 =?us-ascii?Q?ZMzpB1R5aKQAfIuJZGqQd4qQYyqScV+EbSz7lN4/rDSpsx2Fshvwqzk5QejM?=
 =?us-ascii?Q?U9h09zei7+eqKC4gPIEoiK4Dz3L6q1WcBOX4vodEIbLoVnOaCwXFDEc9bOvS?=
 =?us-ascii?Q?WZfjEWd2EMpqLlufsBWKIX4Mx4PSQZumFKY5q8e3Y4wo5b4VQ8XPxUL8Y3DF?=
 =?us-ascii?Q?D7p3/stc4TmY/V1ibI+Tvosb5aEvzkFFXQqS4WooBn86+dn88sqX6MRkt29F?=
 =?us-ascii?Q?hmmGEEAqYjxBG5WibXO4AhYUTp9hNP9wF5yAdj31gdWikSqo7nTc22qOryiA?=
 =?us-ascii?Q?eqlYv4j3sVw8HwxRvvCMpRri13rqbrlxTqxX4jsT8XKwZjSOcqvjyC8gk5Bt?=
 =?us-ascii?Q?wBpWd/JEqMZgaD5X0HzOHNYSwr7ZUXCNHotjHVemovP/6Dr7lVL4JwJyXdge?=
 =?us-ascii?Q?mudYYPa3YvCBdlLRdB/QzrMBnwq2C6rTbQUhHLchGZFpopT9487II4HXpRgP?=
 =?us-ascii?Q?ybbQSsVovJ3YF+vDxN5AABhYhPy60K9i1wkAgrG6BGTpVWQQ7bDXPEqzqFOB?=
 =?us-ascii?Q?C0nEarsJFHJx+qsdZotQDzX2D11HSKUDPC6zeaTFyGD72qHDSkLlq8b8MNdr?=
 =?us-ascii?Q?fd0ds/8TzkWliSjPL9PS2CW96w8tqzQaf9OS5U6zuJksGfW5sroKqjFyBIGb?=
 =?us-ascii?Q?KPeX/oRpqcSkyr7dRLFAA+Uhyeit9SX+yv02jlkBpEx8AE45BLWKZEYaKLXi?=
 =?us-ascii?Q?oK5yoxqr1G2yoQeybHOygEhtc/4SHW/8/EcnEfCMjdmV8uTF5ZZaFs4aldwY?=
 =?us-ascii?Q?EfNDfUEuCVvN1Ub56EmuKk8YwNRJVgRYHTs/OlCRWOfEKk05r1ENivh92niy?=
 =?us-ascii?Q?Tu14zU8oO9/+IgHFLolyI2G/qX3uAZbDLIPa1ECCi0Fs+xs0tJEZuBmU1myN?=
 =?us-ascii?Q?Vkk7sR5q6yq2VIw+Z2v33MxJCauQGjc5XeCAybIR5cgJcsx3hkOd07vp0ywm?=
 =?us-ascii?Q?fSAmG7ZnF1DBmreleMPmQK1Yz+FqcJZDI/kCjwU0XapjogaeY5rDcyj9JBta?=
 =?us-ascii?Q?VPUNApbNlYPE6xv54mK/5kUW31W02ilRD0iIz0Iz/Qo0DXG10LAlfeld7x8/?=
 =?us-ascii?Q?RLBF4/uOddUucBLnDQ+aeI+HKwcn7Z/+Y9GX1knFqdWQNMpG4qNCXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB6285.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjRg2ICOuy1dDulsFpoX3vnmVcU04A2iA6uZDts1L0bdrxx407g40RKNnv76?=
 =?us-ascii?Q?F93oi30s3yEnmy8Nn0zkFqujd0G0vEuz+S1zkjLdBAvVdetlY4ZGlmrK0RxN?=
 =?us-ascii?Q?+9fwW0PbqALyBBJ+l9mUdDLQGBuxaV57XFW2w4vBref5Oj6tnFfX7yy8cdFF?=
 =?us-ascii?Q?GGQFl80AVSSpKMCr5nm3TwxYCHql+V/moa5pCKDVBANrH2WmfEhOMdljzQ3Y?=
 =?us-ascii?Q?9k+svu9TV52M1iZsliyWWxifgZoXbK7bYT+ORr5lsqH9nU/gpI/H5FHBOhnx?=
 =?us-ascii?Q?/Sd5Txx1ARkk8JvEav9nSH75/tm/hD6mw6x8Ya6zYve4gP0fe64cYIOA0xN6?=
 =?us-ascii?Q?mQoYKm0qf+DriRzM4xA01U1doJbCrW6jv/wWp/HfPDHlDmWR1Zeylnmk+7i/?=
 =?us-ascii?Q?hcP42ZkKE+WVDYL+SBTnJ/ZnbhobADekcetQ7TFvRr+v84hseNwWNPc9zIc7?=
 =?us-ascii?Q?xFYNHAsXV8p1XOwqT8JlGzSs0BpQCzhdsGkSrJmAifdMSTCtRRSpR3bap+Dr?=
 =?us-ascii?Q?ELtL1jp1KA5PLkKAhmF+8qN64nSTPWzM4G1p7AffnrBaoFmUWCakEpXeBnzc?=
 =?us-ascii?Q?htQgdq6aAYitj+vjNJU8dfKX5W6x+Dlc1fkKN3qp9N/wm3EvzMeJcmDZ8fDq?=
 =?us-ascii?Q?mc1D1rytuZLmMVoXata10s5LRsWh+jlMgrXLzn5/Mt43Jz6AMG36LDPnguXD?=
 =?us-ascii?Q?ZoBID9vjWqqjQRDWR91AzJnLlaRjlkjgN7oDk/vu4ecgBVXPcXISwMA5taZX?=
 =?us-ascii?Q?6NagEKQvSm+UPvTBsEdYIbR99PWm9C6yFh0nXD9x56BR/BJ0VmL8p8L8+aNU?=
 =?us-ascii?Q?I9/ik5Cwfm0hjIvtq485XvrfcVfAH7luKDCER5GwvHno4F0+YPZzw9bwBHUd?=
 =?us-ascii?Q?BrvhpZPi1ZOaAADZm3NmTEI6sXxBhdavNTL7xRvAMC4PybiTCdHPLZDDX7zZ?=
 =?us-ascii?Q?LBSUeIXisPjlZ+EXCR0CJWA3a9uwDUYLqVrHPQjcaVu5rbdr1L1wUCfk0o2K?=
 =?us-ascii?Q?droRVGtRv8zVlDCXxr9+M4O+0tF432/G2Q+WAN3n/beohEwiN5oo61W9eTym?=
 =?us-ascii?Q?2nlp5lcaz5QearhKb0FvKE+7bZdfNYSeXAuGs+wG0MVLFebENYAvB7EpFFsO?=
 =?us-ascii?Q?5Ah3Pi8eFOblOmhPAepTtLon4VnnuIWpU9cB4+UefYDs6IXd8ORJz0E6/mBO?=
 =?us-ascii?Q?f4SNS4YEjibduFSvh8SVfH6No83MALIdX/Hj+H/nTqBcJGTY78pfOJCnRhxS?=
 =?us-ascii?Q?jjz7vJhpR1BqlK0nCgcfmXgw0+IOzX9NMbCCLaA8ww6Y2umiziH3b5+x4qFg?=
 =?us-ascii?Q?4jMRCTatqEoWs6QkIoY2LAqKtsL9daVUFSBsa+F/xmAptht9OO/XyC9PvX/k?=
 =?us-ascii?Q?1svrYvp/Qi8a4xCHidtv6y/NTzaXr0r/6tEoLF0BQPZbPiLgiPDfWoQRS5/3?=
 =?us-ascii?Q?SUBN0kPGYmlYUAQEh9tED26+TTcoYUQfnx7sTO+ZiKRLyNdC6AeZymj/Vbaj?=
 =?us-ascii?Q?CCEF37/ElaiEnThcW+LMwgMN18UfXX13vRQSiIZrfzX8kbY9O8kxkbezDjoc?=
 =?us-ascii?Q?jIFvrGRmLnb+dSB0/1kd8OzdWfsDQHsoc9TuFYo8?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38198f74-6956-4e4d-5f8b-08dd8b90e6f3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB6285.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 04:54:22.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kqa7k2yqIqQrvmLYOnXPF2P6/SMwIs0O2xsz+DBg2Z5z42mmaCsNG7Uh1VQmEGazFAbAsKrejtI1we/P/NVdKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB8994

The buffer is set to 80 character. If a caller write more characters,
count is truncated to the max available space in "simple_write_to_buffer".
But afterwards a string terminator is written to the buffer at offset count
without boundary check. The zero termination is written OUT-OF-BOUND.

Add a check that the given buffer is smaller then the buffer to prevent.

Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/industrialio-backend.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a43c8d1bb3d0..31fe793e345e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;
 
-	buf[count] = '\0';
+	buf[rc] = '\0';
 
 	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
 

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.39.5


