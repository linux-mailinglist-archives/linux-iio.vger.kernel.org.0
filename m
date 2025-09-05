Return-Path: <linux-iio+bounces-23759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CFB451E2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A8F7A666A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D1D2FFDF6;
	Fri,  5 Sep 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uEAS9OUo"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCC280A29;
	Fri,  5 Sep 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061750; cv=fail; b=nyzPMoodexdmFLUsWgaes16lX0qLmuIO/rgcR9D1R94faBXgWI1U5QpjYfcCOw+wgjmg74utHLy7DZpNy0zQfZea9M1p2hxtOeLYzAEEPwvHh/1KOuNBLgALya7kD91LxorSy+rtc0X6vzjJOTQqegmsbc0k378hcTfrVSx139s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061750; c=relaxed/simple;
	bh=Y5m3Jh1C2iQcvCumDKeHuR7glY4zl5oen+77YKJdhA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZqASpa+AcFdyz4hHPb9B2lsx4vbeLkl/dip41IcnO5VrmlVuzoY54gGL4ttmdA234FqH45ZbjQ7Ss2yQFxDvRb/dSAMFkGr6nPO2LB2imj+aEWbj3GTklhi+Ck18lWdpsHDMkE9jf09jNvRQK4ibN2gYz+rXGGgud6+3rJeNhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uEAS9OUo; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ/Dgwf0FwXA4gINHtKdkc8BQBDusWyRQyW/NL2O+Oy0deAlW1qjaTKXSJ8XCzCVkB4VKncCJiZGgNkmQv3YFL0wGR38WwRJKdSDJyMUiPiSKM3KYbhKy9hGdgeoqXBvfK/xY9aGk/zCl4MCnrJH9UhjbcCiQIEprnyPxXUSk/Li82bcQCZfsKGrRwyp3CpQ4gcyx4H+cil9g23OaIY331kXHw9yc+rRcziCeA3osbu/yqThyogujB+I6E+rCbV6B+pvQZPqVpHnVhXEaeXqGP1025EzaOU0iSzoeax8yKpG0hzx04OavvkVz+radgxeadzpfEodlPr52/ajet0zXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JcQbUkDQrLwz13FKDmf3QcTe59Oi4e7Uymi7sjqSnA=;
 b=SJps2/YB6UqLGKo++1wfsLxqG9UseOxxD2Yp0ZA7Ta/7w2DcW9aDiQlpKS3/lCCHOY9Ae4q5lw8DP54mzaRfNB5BJI8zlGjGks0tPq6ASEhQ8zLt/mwsQNm0giA6y3ItKNkAwMzXV88aPq4+i7TYyQf/rg5KWsdua2rG79MOgzv7c4fe6nle9Wy0tSNqFSmVRAVLaQzaQRdxSlGCH1QoQWuf9n789vDMqnAf3QFiMaogF0zcqD3fA+cRRK/sx7PJSsGF7lTF2GSvqktJ51BojaNcFNCDsi+eTdgd5DxBLSqvqXlcZzINMFYgSqzrhAIXzQ1c7+H6HvbBrCICA6ikPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JcQbUkDQrLwz13FKDmf3QcTe59Oi4e7Uymi7sjqSnA=;
 b=uEAS9OUojGpIxoinA4CeD79h3DCglB6Yv5bCXfttKMuouwGjdw3/Hw7meoLNbAcc1b3GZ4QNBja0YnHUf7rmee3vJKG2GXtrvUP+hRfrOkFnJWM9Kqed5imN62i1f9q+EVvJoQq/MzxXFRcZUQesxXWwGEfhUszv/YNQ9rTBOjM=
Received: from BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) by
 DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Fri, 5 Sep 2025 08:42:23 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::2f) by BYAPR01CA0043.outlook.office365.com
 (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Fri,
 5 Sep 2025 08:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:42:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:08 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:42:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Anish Kadamathikuttiyil Karthikeyan Pillai
	<anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Andy Shevchenko
	<andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, "Salih
 Erim" <salih.erim@amd.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
	<linux-iio@vger.kernel.org>
Subject: [PATCH 3/6] iio: adc: versal-sysmon: Support AI Engine thermal monitoring
Date: Fri, 5 Sep 2025 10:41:46 +0200
Message-ID: <2db88a5373dd410af6c55210032ed81ceae16323.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11086; i=michal.simek@amd.com; h=from:subject:message-id; bh=kVSj/ygXyjOmToPGLBmSJYQTdFYjy8ufby4mRVDowLo=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuTnOIU/q+fmvdd6P0tt5i5n+XGMY29MbNO9R5mCH dKO5plhHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRpmeMDMv55d5dFG4oyZPZ eyOf+/K5F/v+hatuXjlPlU1aZdHylheMDIttdp+y0iuNFFuStnd106IdN/1/Hj748OADO0HrB4K F2jwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: ae246e5f-9eb1-45b5-fdb5-08ddec582277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xf/gL2oXyq1loey3v0sDGaP4P9jUh6xE9LjiccWgiSQmBxY0Ap9lCPFhn0Es?=
 =?us-ascii?Q?iYTX+cJWo9yyNZ3tUCi5dJC56yEoWXEUpaujdqTO7ihA6WWEqXZeR5jNByf7?=
 =?us-ascii?Q?es0jcHR9vJhTdkMB5stbhE/OdyZlR8h9+KrFAttNu7kfSYt68lzDHH8fd7xx?=
 =?us-ascii?Q?9Uy6cT6Cmrle2ltmjEK6UgNHDnoUmRJb6VQ7395uedwBrFXdmFEO5jakjPyK?=
 =?us-ascii?Q?TGMF+rmkiPWvOxkcFfRrh5cx/7Esh3SkGgStE5sVoJwlzWum7XMpWwurPQ+B?=
 =?us-ascii?Q?TVZCJP8fhL9MM0/niSeLWYy5Gy0Lkpry2vefGuUaA3tpj0vGPwXKxdH5hlKn?=
 =?us-ascii?Q?TTz0/Me4GiYULbEs9Kv4EheZnvHMOtO55LnhgnKu0OU2aAZPC1jwxkc5Lnm3?=
 =?us-ascii?Q?Wpc2gh+748LMPUSPhj0YXLFVCEpNCzNnY/hC9tb7UvI+wK9WmPjdRz0Tp6xs?=
 =?us-ascii?Q?XK0MrZS1oVAwKsHWkjrxhxQBYBkalqcFnp5LMpjvbnHExBZPFXImvWHTWGVE?=
 =?us-ascii?Q?fr1KYhg3TT277gnAa2tccQ5YRDlE3lAZ3ASF4V2yXqOktu7dmeEB0lLtzlqe?=
 =?us-ascii?Q?5duyymYEuB83eGMu9IvHWbjxOxj/TSlsRYFlQlrdM1Luie04yyezfzujqK+o?=
 =?us-ascii?Q?alt3ahF6cL3UNezBacfeDxZF81XDD72DqAKVbPiOPsyPFkZfSeVKe+Wo+s11?=
 =?us-ascii?Q?PDOaYfeaV+Y40n23jNpNMescrC6VbYkrtzpJeUo0/KmndT4saOtNO4F7xDzj?=
 =?us-ascii?Q?xvN9Tx2Wc8KVgxF1Nq6sLEbGjoHdw+0EF4VIGND72LWEtAeKVP89UtB4N66N?=
 =?us-ascii?Q?P3Xs5X9N+TYwqRmg3wvaBJqZPY5h4cJOuSXqwraM6bkex9BTCzQGszx8wnZT?=
 =?us-ascii?Q?qbBh4zrVLhPP9x4uGHgAL3G+UW7Q5FsOfIxuFns9bHb9UX23ExzK+7UUKhSH?=
 =?us-ascii?Q?RSqw4RFcw5eOq5VwMOibzERjtPl+LBV66bByXYEwS8LEowC6TOW5L0URX41R?=
 =?us-ascii?Q?cOAEMyoqfnwu954IzlDjXV19sj7A3Yq5v2eSDfEhd2A2mAVBRaujmVZp+joY?=
 =?us-ascii?Q?i2MdSm6RX9M45kIx5jt7k0fNR4yYF1yHNzQBD4v02Z5Qsegmwnf4aJPlLNNU?=
 =?us-ascii?Q?W1qZnPajWCryQ69Eu0bkJRKzJdIvHNFEcT71D6HR/AwZiy68YozQ7cWmduR0?=
 =?us-ascii?Q?/CIX2e6IdB9CoSF9dcQXDnhBE0KuQ74aurfR+G7nCw7Q5fPwAGo4hm9zKdSb?=
 =?us-ascii?Q?6j6wvCWYraVv2+msSgA8RWKtDOOZg3ACxeJOOY/zBLWKF8El6PLBt1PHkC/7?=
 =?us-ascii?Q?RbNVYdZxHeY8il/qM5tmh8qy8ww/UTD0R2yN3ebWlXdJcmlxVN1hNHp2pIbl?=
 =?us-ascii?Q?6mThZo04TDLpcxwto1cyhiFu/kT8rBw5UrzW3KhWAJspQXj0Z42tVgUF7Z+u?=
 =?us-ascii?Q?jgBRvHW+X+XRh3s5FK4QH0K9Y0pkiWwc3TE+rtSkOxP7DFjt+xgVe272ZsD8?=
 =?us-ascii?Q?z8KkYx506fG1nvggEoK8dBMqY5jW6OsiGpYZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:42:23.4707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae246e5f-9eb1-45b5-fdb5-08ddec582277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

From: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>

To enhance the thermal monitoring of AI Engine, the sysmon satellites
close to it are exposed as IIO channels.

The exposed IIO channel are mapped to allow consumer drivers to access
specific sensor data through the IIO framework.

Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/iio/adc/versal-sysmon-core.c | 135 ++++++++++++++++++---------
 drivers/iio/adc/versal-sysmon.c      |  35 ++++++-
 drivers/iio/adc/versal-sysmon.h      |   3 +
 3 files changed, 127 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
index 21b6a413dccb..bd293ff7d176 100644
--- a/drivers/iio/adc/versal-sysmon-core.c
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -272,7 +272,10 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_TEMP:
-			offset = sysmon_temp_offset(chan->address);
+			if (chan->channel != AIE_TEMP_CH)
+				offset = sysmon_temp_offset(chan->address);
+			else
+				offset = chan->address;
 			*val = sysmon->temp_read(sysmon, offset);
 			*val2 = 0;
 			ret = IIO_VAL_INT;
@@ -295,7 +298,10 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_TEMP:
 			/* In Deg C */
-			offset = sysmon_temp_offset(chan->address);
+			if (chan->channel != AIE_TEMP_CH)
+				offset = sysmon_temp_offset(chan->address);
+			else
+				offset = chan->address;
 			regval = sysmon->temp_read(sysmon, offset);
 			if (!sysmon->hbm_slr)
 				sysmon_q8p7_to_millicelsius(regval, val, val2);
@@ -1202,8 +1208,10 @@ int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev)
 	struct iio_chan_spec *sysmon_channels;
 	struct device_node *child_node = NULL, *np = dev->of_node;
 	int ret, i = 0;
+	int aie_idx = 0;
 	u32 num_supply_chan = 0;
 	u32 reg = 0, num_temp_chan = 0;
+	u32 num_aie_temp_chan = 0;
 	const char *name;
 	u32 chan_size = sizeof(struct iio_chan_spec);
 	u32 temp_chan_size;
@@ -1214,6 +1222,11 @@ int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev)
 		return ret;
 
 	sysmon->num_supply_chan = num_supply_chan;
+	ret = of_property_read_u32(np, "xlnx,numaiechannels", &num_aie_temp_chan);
+	if (ret < 0)
+		num_aie_temp_chan = 0;
+
+	sysmon->num_aie_temp_chan = num_aie_temp_chan;
 
 	INIT_LIST_HEAD(&sysmon->region_list);
 
@@ -1233,69 +1246,101 @@ int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev)
 	}
 
 	sysmon_channels = devm_kzalloc(dev, (chan_size * num_supply_chan) +
+					    (chan_size * num_aie_temp_chan) +
 					    temp_chan_size,
 					    GFP_KERNEL);
 	if (!sysmon_channels)
 		return -ENOMEM;
 
+	/* Configure the dynamic channels */
 	for_each_child_of_node(np, child_node) {
-		ret = of_property_read_u32(child_node, "reg", &reg);
-		if (ret < 0) {
-			of_node_put(child_node);
-			return ret;
-		}
+		if (of_property_present(child_node, "xlnx,aie-temp")) {
+			ret = of_property_read_u32(child_node, "reg", &reg);
+			if (ret < 0) {
+				of_node_put(child_node);
+				return ret;
+			}
+			ret = of_property_read_string(child_node, "xlnx,name", &name);
+			if (ret < 0) {
+				of_node_put(child_node);
+				return ret;
+			}
+			sysmon_channels[num_supply_chan + aie_idx].type = IIO_TEMP;
+			sysmon_channels[num_supply_chan + aie_idx].indexed = 1;
+			sysmon_channels[num_supply_chan + aie_idx].address =
+				SYSMON_NODE_OFFSET + ((reg - 1) * 4);
+			sysmon_channels[num_supply_chan + aie_idx].channel = AIE_TEMP_CH;
+			sysmon_channels[num_supply_chan + aie_idx].info_mask_separate =
+				BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED);
+			sysmon_channels[num_supply_chan + aie_idx].scan_index = aie_idx;
+			sysmon_channels[num_supply_chan + aie_idx].scan_type.realbits = 15;
+			sysmon_channels[num_supply_chan + aie_idx].scan_type.storagebits =
+				16;
+			sysmon_channels[num_supply_chan + aie_idx].scan_type.endianness =
+				IIO_CPU;
+			sysmon_channels[num_supply_chan + aie_idx].scan_type.sign = 's';
+			sysmon_channels[num_supply_chan + aie_idx].extend_name = name;
+			sysmon_channels[num_supply_chan + aie_idx].datasheet_name = name;
+			aie_idx++;
+		} else {
+			ret = of_property_read_u32(child_node, "reg", &reg);
+			if (ret < 0) {
+				of_node_put(child_node);
+				return ret;
+			}
 
-		ret = of_property_read_string(child_node, "xlnx,name", &name);
-		if (ret < 0) {
-			of_node_put(child_node);
-			return ret;
-		}
+			ret = of_property_read_string(child_node, "xlnx,name", &name);
+			if (ret < 0) {
+				of_node_put(child_node);
+				return ret;
+			}
 
-		sysmon_channels[i].type = IIO_VOLTAGE;
-		sysmon_channels[i].indexed = 1;
-		sysmon_channels[i].address = reg;
-		sysmon_channels[i].channel = reg;
-		sysmon_channels[i].info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED);
-		sysmon_channels[i].info_mask_shared_by_type =
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
-		sysmon_channels[i].info_mask_shared_by_type_available =
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
-
-		sysmon_channels[i].event_spec = sysmon_supply_events;
-		sysmon_channels[i].num_event_specs = ARRAY_SIZE(sysmon_supply_events);
-
-		sysmon_channels[i].scan_index = i;
-		sysmon_channels[i].scan_type.realbits = 19;
-		sysmon_channels[i].scan_type.storagebits = 32;
-
-		sysmon_channels[i].scan_type.endianness = IIO_CPU;
-		sysmon_channels[i].extend_name = name;
-
-		if (of_property_read_bool(child_node, "xlnx,bipolar"))
-			sysmon_channels[i].scan_type.sign = 's';
-		else
-			sysmon_channels[i].scan_type.sign = 'u';
+			sysmon_channels[i].type = IIO_VOLTAGE;
+			sysmon_channels[i].indexed = 1;
+			sysmon_channels[i].address = reg;
+			sysmon_channels[i].channel = reg;
+			sysmon_channels[i].info_mask_separate =
+				BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED);
+			sysmon_channels[i].info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+			sysmon_channels[i].info_mask_shared_by_type_available =
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+
+			sysmon_channels[i].event_spec = sysmon_supply_events;
+			sysmon_channels[i].num_event_specs = ARRAY_SIZE(sysmon_supply_events);
+
+			sysmon_channels[i].scan_index = i;
+			sysmon_channels[i].scan_type.realbits = 19;
+			sysmon_channels[i].scan_type.storagebits = 32;
+
+			sysmon_channels[i].scan_type.endianness = IIO_CPU;
+			sysmon_channels[i].extend_name = name;
+
+			if (of_property_read_bool(child_node, "xlnx,bipolar"))
+				sysmon_channels[i].scan_type.sign = 's';
+			else
+				sysmon_channels[i].scan_type.sign = 'u';
 
-		i++;
+			i++;
+		}
 	}
 
 	/* Append static temperature channels to the channel list */
-	indio_dev->num_channels = num_supply_chan;
+	indio_dev->num_channels = num_supply_chan + num_aie_temp_chan;
 
 	if (sysmon->master_slr) {
-		memcpy(sysmon_channels + num_supply_chan, temp_channels,
-		       sizeof(temp_channels));
+		memcpy(sysmon_channels + num_supply_chan + num_aie_temp_chan,
+		       temp_channels, sizeof(temp_channels));
 		indio_dev->num_channels += ARRAY_SIZE(temp_channels);
 	}
 
 	if (sysmon->hbm_slr) {
-		memcpy(sysmon_channels + num_supply_chan, temp_hbm_channels,
-		       sizeof(temp_hbm_channels));
+		memcpy(sysmon_channels + num_supply_chan + num_aie_temp_chan,
+		       temp_hbm_channels, sizeof(temp_hbm_channels));
 		indio_dev->num_channels += num_temp_chan;
 	} else {
-		memcpy(sysmon_channels + num_supply_chan + num_temp_chan,
-		       temp_events, sizeof(temp_events));
+		memcpy(sysmon_channels + num_supply_chan + num_aie_temp_chan +
+			   num_temp_chan, temp_events, sizeof(temp_events));
 		indio_dev->num_channels += ARRAY_SIZE(temp_events);
 	}
 
diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
index 79be5111b56c..b839dfdef712 100644
--- a/drivers/iio/adc/versal-sysmon.c
+++ b/drivers/iio/adc/versal-sysmon.c
@@ -108,8 +108,13 @@ static int sysmon_probe(struct platform_device *pdev)
 	struct sysmon *sysmon, *temp_sysmon;
 	struct iio_dev *indio_dev;
 	struct resource *mem;
+	struct iio_map *all_maps;
+	const struct iio_chan_spec *chan;
 	bool exist = false;
 	int ret;
+	int maps_size = 0;
+	int maps_idx = 0;
+	int dyn_idx = 0;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*sysmon));
 	if (!indio_dev)
@@ -183,8 +188,36 @@ static int sysmon_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	if (sysmon->master_slr) {
+		/* Combine static and dynamic iio maps and register */
+		maps_size = ARRAY_SIZE(sysmon_therm_static_maps) - 1
+				+ sysmon->num_aie_temp_chan;
+		all_maps = devm_kzalloc(&pdev->dev,
+					sizeof(*all_maps) * (maps_size), GFP_KERNEL);
+		if (!all_maps)
+			return -ENOMEM;
+
+		for (maps_idx = 0;
+		     maps_idx < ARRAY_SIZE(sysmon_therm_static_maps) - 1;
+		     maps_idx++)
+			all_maps[maps_idx] =
+				sysmon_therm_static_maps[maps_idx];
+
+		for (dyn_idx = 0; dyn_idx < indio_dev->num_channels && maps_idx < maps_size;
+		     dyn_idx++) {
+			chan = &indio_dev->channels[dyn_idx];
+
+			if (chan->channel == AIE_TEMP_CH) {
+				all_maps[maps_idx].adc_channel_label =
+					chan->extend_name;
+				all_maps[maps_idx].consumer_dev_name =
+					"versal-thermal";
+				all_maps[maps_idx].consumer_channel =
+					chan->extend_name;
+				maps_idx++;
+			}
+		}
 		ret = devm_iio_map_array_register(&pdev->dev, indio_dev,
-						  sysmon_therm_static_maps);
+						  all_maps);
 		if (ret < 0)
 			return dev_err_probe(&pdev->dev, ret, "IIO map register failed\n");
 	}
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
index ba47b6d32f4d..f49a4e60de65 100644
--- a/drivers/iio/adc/versal-sysmon.h
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -45,6 +45,7 @@
 #define TEMP_EVENT	164
 #define OT_EVENT	165
 #define TEMP_HBM	166
+#define AIE_TEMP_CH	200
 
 /* Register Unlock Code */
 #define NPI_UNLOCK	0xF9E8D7C6
@@ -215,6 +216,7 @@ static const unsigned int sysmon_oversampling_avail[5] = {
  * @oversampling_avail: list of available overampling ratios
  * @oversampling_num: total number of available oversampling ratios
  * @num_supply_chan: number of supply channels that are enabled
+ * @num_aie_temp_chan: number of aie temp channels that are enabled
  * @supply_avg_en_attrs: dynamic array of supply averaging enable attributes
  * @temp_avg_en_attrs: dynamic array of temp. sat. averaging enable attributes
  * @avg_attrs: dynamic array of pointers to averaging attributes
@@ -248,6 +250,7 @@ struct sysmon {
 	const unsigned int *oversampling_avail;
 	unsigned int oversampling_num;
 	unsigned int num_supply_chan;
+	unsigned int num_aie_temp_chan;
 	struct iio_dev_attr *supply_avg_en_attrs;
 	struct iio_dev_attr *temp_avg_en_attrs;
 	struct attribute **avg_attrs;
-- 
2.43.0


