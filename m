Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B894270B4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 20:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJHSai (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 14:30:38 -0400
Received: from mail-eopbgr80127.outbound.protection.outlook.com ([40.107.8.127]:44192
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231245AbhJHSah (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 14:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf4WP8oHidYU3xBoRlmOyRNKuewUu6nHE/ePD/6XdlS/U9DGXgLtBG0PUd2NzpBuBZdIooWIMY82UCU9AtcPFLUHERmlKuibx4n8UmezPrKLKrD6V9YzP5lwQq4kp4KiiwWijWg3UijrCUXSVZpEXSiImcdQIU5nW1x2S7gRHV7BJJL3RM9ikvzrgkeaw9BNx4VMXRfaCc8TpytBHsuLnurRMMhmSfWeAkFRBIk0iA/+1lscn4TDlDbqL7Sr/9JGCTmLNAoF6yadgwdlpCOvTH9n8q1kydCuNUytxMu8ELMxWlXnxtWt4Swb7J6jRyqMv1/sPlfaybfXNSEv1DYB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYRC1khTM4it+uf+o+458KRjuCiNf8neqNl59P1qMis=;
 b=NfiS6owDATJP/c7KwH/TcJNxRjEvZJY6ehKEmjEF0oCcPOFzQzSMd5m/fX3tIjxp0kkn1j9pdyUtPjvxpw5kY3Ikt/7rArbvsArzJSsRXS3nt3dphDF3FrVeyiu2JTR2XCsxQNUHhCeMLjxBCM1x8IfHjviQqNRIAmk+F52UA4gCXU9C6Pzxnws2NsYfSFaCD7zv4BUYh2+SvNueUNSjLs4GNfVLryTVVTPrGcqTRfpNLMRV48lugKRvck1tbatk+yviXN0mz5EBL4crUFMm/MFTvgLfcrWa9iAE5F3t84KPV9hfrt/IdFk56+OJNhwUr5c0r+XLBYa099z+8Z9UCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYRC1khTM4it+uf+o+458KRjuCiNf8neqNl59P1qMis=;
 b=SXv0+xCrBehZa+PMgs7lmIYAk9AWwT8AbrxIPFmWBflqEGSg5JQqQnWyMOYJ921R0frXU239EHoCM3Gk1ddqNoh+SO4M1RSIVMXHxqrs4maIQWyQBRjLI3pm4wo+l/Mpi225mlPwFK6AmXQPJlEq+Ps9KaLDTgsu4z2WXidwnsA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v5 1/1] iio/scmi: Add reading "raw" attribute.
Date:   Fri,  8 Oct 2021 21:28:26 +0300
Message-Id: <20211008182826.24412-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008182826.24412-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211008182826.24412-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0280.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::17) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50432f41-6384-401a-38f8-08d98a897314
X-MS-TrafficTypeDiagnostic: AM6PR04MB6005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB600542CBC8A689FD03DD2925E6B29@AM6PR04MB6005.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pa5CZidMFBhFDvjYZQBb1+0Ag7Qc1LmC3T4pALdqylAsZAkgL2n8h+IzQQuSYzaS1rMov9vp8NIwv5ewwlHE7M4afcvuIinglWxWI3kyiGUdsfYyGYWv139OeXHjK+ES1J4drPOLTuulz/8mIVzp56RbsavaWg+8VBF2wZU8S+Jd89LTv5xXFIOnjjOdGgPF7Woe4soXp/gna4TrJYyXEHY7XD2gOsU06mFMt706tgjYZL75C05BTK0Ev+GiF9HzyhcJl1ooWcnyIo3GQnECsaD+1a0wI9XdVOSOIuIgxzjjaEPKhuiHEKSfzjH/vaOqRDiBETLGN9zwzZ24vg0Ed/RcvQM4Of8NVWB/DFBUcizasBn9NPSC/HWDqtNk1Hoga9d3lCkrjX/TOin3uHawvrvi31K1ftn4TWFP6R3dwlqsWYiybtQ8VwNS4VEZCERLNl2EQhb21evb3ZBfQ37U5pKxgl5WGhX5Tiqkc2NCde39EnJiBsQvlrEpFqQa7gsqweqIAkr990W7d2ECcbZXE8UJDRCYPVtZSFsrmVCCaGsQtV4U+i/gJK/PQw7UX7a96FO5uu3eeGWg/p7EQuT9QUTj6GGmo6JYmIHxx5RmRZUF11h3QmZ8yM3sAZ0h03R2WQrYhFcJpuw9hEO9rluOeQQDkRpdvwvIDg8H44DApQG5yOq1bb3zsGTmuOYUbzv/4nFw9dd7YjPDzuJgpqJZtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39840400004)(136003)(376002)(346002)(1076003)(2616005)(66476007)(5660300002)(66946007)(66556008)(2906002)(52116002)(186003)(316002)(26005)(4326008)(508600001)(44832011)(107886003)(38100700002)(86362001)(38350700002)(8936002)(42186006)(8676002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUNgWRsxrkEZEN8A3KtWPqr7cD/UDSB7T6FyyuP4l4nr/xHN0IjUEr/x7MuO?=
 =?us-ascii?Q?BfNjEL7FAtLttX/CJRR6eyMWh50v88JRp03uZ9raIcFF4HcoyZdK1RWTPKBp?=
 =?us-ascii?Q?bQJbOWdrWYMfThphM9NFHhHOhIRXcAeJWa2yeSKe+j00k0nVEVDmIGff6Ed7?=
 =?us-ascii?Q?1uOUVCWqeHQB9sL9BaPA/QmCxEN7x+OUtzKQesvbd3ZbVH9bslJhAZk6whVO?=
 =?us-ascii?Q?tE3sVcXCvX0P/M7e8aFTBlyWWYiHigdiuAY3MdB3bTZa7GNaFTYn7Lmg16sp?=
 =?us-ascii?Q?9Wbe9WQeyZ0n61c+VQcLKcBsaBeg3mduFcCS54KtZsH81I/y6NkRtzWNfodF?=
 =?us-ascii?Q?i3XNwRJGgR5zRt6Uqb5YQMUvLCVvGxHbosDadbHm1hDa+L2C9hAwg2/JMI96?=
 =?us-ascii?Q?hcwXn3jjD5X8TyAgMwZpb9bg24O7Kzl0zM/QQ9uKTzyzsnXZ+tu1OuBRvUoe?=
 =?us-ascii?Q?qkzGhYHEyV+lMRiFZUaQeYEAiFoCbDOAKuGs8NHl9orA68LxTtF3pdBDJSx/?=
 =?us-ascii?Q?yexvMFBjoskjhSmOhaaf5cKShIaTNhLd3C7Ds0eIrrrwcQdWmLVbEl52RQxV?=
 =?us-ascii?Q?WFwtov/L5S157JiZqzqhswaag7a8NoJIU/Zu6CFRe4NiP8B4FlxgPuQCjIdl?=
 =?us-ascii?Q?PatLZaH2Rh/dPxfp8QwvmJAnARJTPtS4rGHz1h9zn9PlfRd7n3Ys+2rQRbl7?=
 =?us-ascii?Q?PkJvcgQOJcYDTAt0XDdS0FOP3NLPiHJ6z6cwhoSYtE4PfDGc3NWFMWYEHN43?=
 =?us-ascii?Q?zauQqN2HSikJRpC56PB9HA4lXogbqYbTPciDVdZ+9LuJSDkxM8NmzmNtzfYi?=
 =?us-ascii?Q?I+T169/lZ81Go0PAKq+oJplbtbpGtg+OQ+B0B944cMZTUCJ15Vuhc37QfhSS?=
 =?us-ascii?Q?ME3j1qWLUgCgFVjWd6QHhrhJmRFtMFgmUeN7Vkdm2Zw/PxryVYDozjUQfg/D?=
 =?us-ascii?Q?GqVqQ5Fj8M3eu8l/s9IjNV/KMgiCJjlfTW5xXrWSr23Cg8P1kap6a0DYX/Ed?=
 =?us-ascii?Q?uaOi+j31Y+nEHGDRDn0xnl7fDN0AsuHClSwf16sc1qPbGfHtBZLVoDTky8MM?=
 =?us-ascii?Q?tK9/tJewdKehMbwuvWY4UJdCwh1VfwmB4LwTGdQjpbXDkz3YWHYCTmYmCP39?=
 =?us-ascii?Q?nTwRyD2cDewbDFBeLhkaABifo8FDXlxGsu78IMebs4vbFQFXmj3DDFk9lQaP?=
 =?us-ascii?Q?Q0t1WCdEouFhXqffBDbMRj9v1PZDsah2TB2kyXL9KxI/E/XFZkAFseD/5tKI?=
 =?us-ascii?Q?EcMdoeTXojenyKhz5Za+ucUb8K5CbirI7PdJZkd112pW8ExTG3CM1v38ipXS?=
 =?us-ascii?Q?+G15xdrv1Xwuc8ForJLJUvUj?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50432f41-6384-401a-38f8-08d98a897314
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:28:39.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEBZCMCKaBuydaKTQfImMywrt2eXsnWUgeWgnMPXR+sxrIDSF9iA/3n1MMve2ezNjD9/hQ3OoZvxX5PKp2pd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6005
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add scmi_iio_get_raw() to read "raw" attribute.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..691cbbd61e3a 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -311,6 +311,62 @@ static const struct iio_info scmi_iio_info = {
 	.write_raw = scmi_iio_write_raw,
 };
 
+static ssize_t scmi_iio_get_raw(struct iio_dev *iio_dev, uintptr_t private,
+				const struct iio_chan_spec *chan, char *buf)
+{
+	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
+	int err;
+	u32 sensor_config;
+	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
+	int len = 0;
+
+	err = iio_device_claim_direct_mode(iio_dev);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in claiming direct mode for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		goto err_release;
+	}
+
+	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				   SCMI_SENS_CFG_SENSOR_ENABLE);
+	err = sensor->sensor_ops->config_set(
+		sensor->ph, sensor->sensor_info->id, sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+		goto err_release;
+	}
+
+	err = sensor->sensor_ops->reading_get_timestamped(
+		sensor->ph, sensor->sensor_info->id,
+		sensor->sensor_info->num_axis, readings);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in reading raw attribute for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		goto err_release;
+	}
+
+	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				   SCMI_SENS_CFG_SENSOR_DISABLE);
+	err = sensor->sensor_ops->config_set(
+		sensor->ph, sensor->sensor_info->id, sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev, "Error in disabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+		goto err_release;
+	}
+
+	len = scnprintf(buf, PAGE_SIZE, "%lld\n",
+			readings[chan->scan_index].value);
+
+err_release:
+	iio_device_release_direct_mode(iio_dev);
+
+	return len;
+}
+
 static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
 					  uintptr_t private,
 					  const struct iio_chan_spec *chan,
@@ -355,6 +411,11 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
 }
 
 static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
+	{
+		.name = "raw",
+		.read = scmi_iio_get_raw,
+		.shared = IIO_SEPARATE,
+	},
 	{
 		.name = "raw_available",
 		.read = scmi_iio_get_raw_available,
-- 
2.17.1

