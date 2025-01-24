Return-Path: <linux-iio+bounces-14550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2A5A1B4E5
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 12:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1A916C7A0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA621A452;
	Fri, 24 Jan 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="PnB6MCYl"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08C1E495;
	Fri, 24 Jan 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718791; cv=fail; b=oBsLXSWxygX4G6mT+Rf+MnaoT6ey1NZ49oD75duOxATA4KgGSb5HG7R8PVC1BUhNPY5q787bX1R/vHIZXXImbLBAkiqi0xCYcxl2z3SG/e7dbvEeigmhE9RiQjOCFPcar3W6RD/WX+erdFMwokACQBqKrd6xNynuHoHY5zKeA7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718791; c=relaxed/simple;
	bh=NibWBR+/K5sC6U2a2jlF7PgzXdSd/hWtyYHYfYTMmCk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r6RhNY3w1rcnVn0Bn5GEIvpBP6gXVMVqjDUKzW+GTD4YS/r48zGFrubZSnkrjRGnEWAiIts8DBnGJLNR18MnUGu59t+TVOT4J5imtbPYLiLn9nZrErcw3BEm0efRLuovjAi0UAtPepXcK13Go/MUy4QyDRCCl6KEvaAaeenxt7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=pass smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=PnB6MCYl; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfNoRAzt1W+cfFGUXVDdHDD6UIRLO0uK9KjIQRnYuZXE66kEMIUJG0qF2fAM/oyI6+DUikLL23mNtBDusPoKFvL2P5AyPyhIjdbkDwBGnTw+/3Cg52O/+wO/S4rPxZNZv3QkUOPzRsfWIAw3vuyu4Bgu7ZoXK7fv3IEorz6sN3MemGa6+YfwibElRP10UqdEO4MSrjUr2bzNNz/4hYAty1ygeTKC7jFp8OVUTE0lAgesfmo9NIvET87NtlB6J4agY+YkIHh8iPryJhamxgWPXUAUMbWpwpnWFH0/iZvVHG6SAAy3CBZr+31wYhX/EV70SBd+YQbQqxykSb6LrEdOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xI0hEIB758XWazXneqnRB+Nlczu1MB1krEm/F6Gikg=;
 b=uAH8j9B37ClYdMNlFX9BhEKvbb9N38wUrzURgPPj08A/FgPo99lJa/HMabxi+c4IaOaOTdpB8LnCK3EHd96PMuLbWSl6/MAYwZojKFFZ/QkwRv2L8yYRbYmGPr7YTnLfvlj0cdRMNPZsRCEDN8rWjobNCoIqTFUUxVEgl9Xjdh7f48Qy5HW3uJSJAd2ABX1Pa7BXuEOkUU1SZ4Wg/R267sgSg8+TOclbcn3pHHIGAehBDeTIgOHN1i+NHcBPinTBvB+6wg6QC69aJT1gbn60uK1itvULvA4FMJ64+sOFCTfLEVK4y5cdPZvxleSuk5tDevs4JtoyizHAJACSUZdz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xI0hEIB758XWazXneqnRB+Nlczu1MB1krEm/F6Gikg=;
 b=PnB6MCYllCbR8M0y1FUyrzBMdNFaLQ3gzzyFEDRD0xxz02wBDn145jVVXjTX8/18QUN+usFufcV4/Bgb0afxNVsMWlD9mbH40IuA1VVyXwwAmoGKOVdJNhJUvdlNcKU01jghqnRXRrJt7f2/HYgYPX8Ettg1XQmSKili6/L3G0o+ZJjSj8YMFLhjrc0Tet4TCLuo1DOg/QaSqt8Wc02nfYcexJurv0p+kRydFtm/UvAqfoXuf2cO8gnbKjmsLOgCJq2Gdc5UlDyt3peep2vTjNWwEgZKwSmGywiQyPLg/C2K+15UJecItrW6hlB1yUJCm6p2aIoPAi0cTqUjg+6pbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5399.eurprd03.prod.outlook.com (2603:10a6:10:f5::22)
 by AS4PR03MB8180.eurprd03.prod.outlook.com (2603:10a6:20b:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 11:39:46 +0000
Received: from DBBPR03MB5399.eurprd03.prod.outlook.com
 ([fe80::2fec:64f5:1893:f53a]) by DBBPR03MB5399.eurprd03.prod.outlook.com
 ([fe80::2fec:64f5:1893:f53a%5]) with mapi id 15.20.8356.010; Fri, 24 Jan 2025
 11:39:46 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7192: fix channel select
Date: Fri, 24 Jan 2025 12:37:41 +0100
Message-Id: <20250124113741.36275-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0092.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::7) To DBBPR03MB5399.eurprd03.prod.outlook.com
 (2603:10a6:10:f5::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5399:EE_|AS4PR03MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: d29e47a5-4bef-4388-3877-08dd3c6bcd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sD8ljqtbLwDKVzSyS6Pg10tmH80xABi69yhMRBrQ8CTjiFIWl0a3vxVmBFJ5?=
 =?us-ascii?Q?+0EXHKxsSGRKYD/u+ZTi5GhvCCIiVJ+MCRavKQ9KWYdOsFZBwu6s7mScpguL?=
 =?us-ascii?Q?bJV9LEBdprdEzpfBPR3afDePJRk26gymWuZeDuyCdXF1rnd9nWwWwCJuGyYR?=
 =?us-ascii?Q?uE4+UAL8bgb3sFGVKx4Qkylw3Mdg8Q5B7KKjbkD/fZeOM97XAn2IzSUE1IKw?=
 =?us-ascii?Q?W7jfbrjB/LfeEUo1Ep92yIch0S0zxs2ujgUsnHcD7s1SCqhhUBk0y4BOQjbn?=
 =?us-ascii?Q?tGEQa03xXBwsmIpehYQb8r0kjSkLRuQZ3cqFVmc3/LPok6YQrzs6cGJPmUYk?=
 =?us-ascii?Q?eLzhV6yNr1Z+6yaNR8dARS/ctoES/NHciitIO6oHiryLvossQZl0ahYrahRd?=
 =?us-ascii?Q?DYkBAc7hSXKG8kRVMQt0mRv82n4SwZzQCN1Z5AO4qKK2iAuyrJj12ktV36EC?=
 =?us-ascii?Q?Iop793tVlfhXlEgGEOvZ/GhIma4CB4m1eNYGxeGE67JHGyZzwk7yMR0uYO50?=
 =?us-ascii?Q?7CVamWG3fUE5lTFii/Bgk3hLH6tgVbaETVR2ltUemgak0i9EOFHUv/O/laQv?=
 =?us-ascii?Q?qMc/VswrL+lEfKXExgvVCiSA2Z0t5AtDfqvo3WzYYYomrpslbD8xPT1eUPub?=
 =?us-ascii?Q?tfIjrePv3yV6YpaRvSUkwK4NVcTPHrFC/zSc+nq/pKYUZfL8zVEjTp6gRkiu?=
 =?us-ascii?Q?ygY6Iaovi4nrdvh0BdY66jyzvbClPakWpVXAON/be1gaC1PlFVmtLB0QzOuV?=
 =?us-ascii?Q?3+iDIs63BmymXtJvdd61+VqJs5R6P32im+HE+lUbn5RCmU+T6HycHlb3cTlx?=
 =?us-ascii?Q?eaPB8CALqUroUWWeIcrR4Z4kJMEtxMYWutpqlLhCNzAQZwU5i+Lz/S+tuegb?=
 =?us-ascii?Q?cJUwoBfsub/zV0hfYLrMZtXmEdkBukzUXtIQ2C6UbOXk+NRbU7zWt43Ni2OM?=
 =?us-ascii?Q?1J40Uk3botGVpl3opL1jUWTD2/MsxqKpMS7ZSrJy9E+3mJm3cfI45oS6tCJy?=
 =?us-ascii?Q?ztM25/JMhUOctDc9WjH20cox9wwRjV69iYYSxxSbmySbbBbCZ13YHD53wX2K?=
 =?us-ascii?Q?bGy6VFgJSM5hf192kN7LDvuZBIbBZBIF4761pOOAxqQo9jTKl/0pUyGZCTcm?=
 =?us-ascii?Q?kwRUa0TkXJY6UTcnzDhAqq5Vvrb1l0X+9/cAAWlYrenWhioxlJkRhstfL3Id?=
 =?us-ascii?Q?bgM49vm8DvY72wT9Qaz/GF2MSZ7kgxEmoDDl5kTTESENnliTiGqX0CkkDPyR?=
 =?us-ascii?Q?SXEDWFBx5gFbdHP+pUMwFxVdPcptnJqhmSBJDkuOXkQQg6TLcwh7Cg9fA0XO?=
 =?us-ascii?Q?zGLCDNEG9Jk2cLcuZq79sTaHCxjA82AbwO6ZHj+/d7/w0QD2EH+Ae8C27lEr?=
 =?us-ascii?Q?DViAqMNUgzoXHBRHXCvcfSeW+4525ClLM6EsocHtjXePAvaX5Tm9LEDm0u7k?=
 =?us-ascii?Q?6ccps1TDK8NwDZ6n+8Qt7fr+6hAsX9+o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR03MB5399.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/nIwV+43wvOKUT29ay7gTlLTDejObVVWKYuSbSsiT3vj0FfxEJwVosd0TPDb?=
 =?us-ascii?Q?hEs6m9zq0L78hm+sd7i4My/3a2KNdimrqqEf5llduRj7BJqT9zQd/f8clSWG?=
 =?us-ascii?Q?rP4uIzd1RCCSZdtL7eGsN7P1I5CsvurYC9U1KHTUXGOwh2/Ybc66HmtW4WLN?=
 =?us-ascii?Q?AthIPkAfuefQysfCrguyYYufYnsmio2QtW+NM6YvRsBPABbibWDqPzrc8FLp?=
 =?us-ascii?Q?ULqx5j2mVP2CBQt8NIXteZNUYNWFVlzmx5kYaLzj6o0hxIxPHT24xcW3IfXk?=
 =?us-ascii?Q?os8PDKA3ADQEnKMuehvwNTQj5Y/cQjjatuyoYTzC6UeF803gfae9ESKsIlJY?=
 =?us-ascii?Q?ULArisi/L4bKNnAyaLTjg4h5gy0bkI3bJyZumjO+bjFiHgF5kf7yKVWUECys?=
 =?us-ascii?Q?dY4GtHGybAMPR3qrmwVeDOdO9OgzYrfyjw+13/F9IpjX7QBQuNE2xhCYZMnT?=
 =?us-ascii?Q?0P26QcU7+PZv7A3V3NiC7ZO7JgZNFnrh6ylU+Utsl+sLpK8jl4p+N9QmhA4i?=
 =?us-ascii?Q?lQLi+50AzWd2Cs8RLOwpKXc4Jxs9o12pvHPk154LhVT3BkH124C5I4HtJ56C?=
 =?us-ascii?Q?3NgTFBcrX+JpwhvT1tA6aOj645kiqnDDc9tvQdw46oZo20AE1Jo6QIRKM4Zv?=
 =?us-ascii?Q?dLSGn0Fjlt9vnndHpc5RCLfArMGaglTl5uepDgcjFHA8lTiN9JaZH/JihVoD?=
 =?us-ascii?Q?ZECV3J72poGW6z2LY+oqbteQc2cT0nH4Jgs230NMvhV06VTY/S9lQKLAJfKU?=
 =?us-ascii?Q?qCI0YwoJdYhcouBFDAUlB//YjxFjrEewAN+dO3OyzskICOkUZcM7afRnixfu?=
 =?us-ascii?Q?QoDTUfSSJ8/38nU7KRQux4HMQmCV8tNUzU9/US8Y4hmNetJHILTP3zu+wNWU?=
 =?us-ascii?Q?M/r/c2X9J5tfmlKqh/YJsothjMvp/gwnaqSit9o9deusJ4zRcGxXna3EVnfd?=
 =?us-ascii?Q?jzTjlH5NWoazil7QiZ/4ye4dx+FFq4eFL2b2Xn86cMRJe0sa/9LGuKlVIJ4I?=
 =?us-ascii?Q?QVS9EJoPph/pGPjgv+XsLzTVsHRxZP5QyC7lqCAKYjx+VniVoP6eEO3BM/ME?=
 =?us-ascii?Q?Be6QinJuJq/kEJHCMm4keIpcn14gtZInSzpHq2NUNnbxhP4jvRSNHAGB1RCf?=
 =?us-ascii?Q?LriFHa4fHseUW03mMVsVtDyYNh5RAwu/8GaJUt0S7hQNRBmdrQSxpcWmkVFP?=
 =?us-ascii?Q?Pjygb3kyeDysH58tjVAaQP9c4GL4fTH7m2gYGgxeM7lJzq8TnRIM2r6oPku5?=
 =?us-ascii?Q?BF1Jh9CeeKOOVZJ4tFCtUILKki9nD/nTq2InOl4wHoRc3TvemAZhHoGov6hm?=
 =?us-ascii?Q?OmK5FM3N78u3vLHZcUNnU9WiAJE0HHdMgobX6+SBQ2v69ePY/Gqlv6tkJq7d?=
 =?us-ascii?Q?eyoheCf8m+YmDT9Pu5w20TRlSTQRwOFPKxoqXlcxQhIwpk3jpIERTRIDPgpC?=
 =?us-ascii?Q?qyx9MwuMBRw+zk5XAKktqHzyOoFSu1QCQeAsxz/bS/rbTiPxyASAtu+x7a9k?=
 =?us-ascii?Q?gSrPgF4/EeynXvErLgQMarf3PTZqVMsLH/yslAAo8m4mwNTpnrJ03QBgwOC8?=
 =?us-ascii?Q?po03h3VIeGiFc2l2z+2eNJsb/nitdwE7TO79Pffu?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29e47a5-4bef-4388-3877-08dd3c6bcd35
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5399.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 11:39:45.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCiNBYiRLRKDXKBwOCt3wHsnvQWzcH+h1Ew1nP09b4Fdwq0SnQpcx8++sqTyOsKstl6LQlGHdXVcZmFL5ymwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8180

Channel configuration doesn't work as expected.
For FIELD_PREP the bit mask is needed and not the bit number.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1c87db0e0460..c4effe8429c8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1082,7 +1082,7 @@ static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned lon
 
 	conf &= ~AD7192_CONF_CHAN_MASK;
 	for_each_set_bit(i, scan_mask, 8)
-		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
+		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
 	if (ret < 0)

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.39.5


