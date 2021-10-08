Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8133F426C3D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhJHOBF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 10:01:05 -0400
Received: from mail-vi1eur05on2119.outbound.protection.outlook.com ([40.107.21.119]:19265
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229607AbhJHOBD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 10:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdgKG/7VFVSIdB2EtAhsLMMEtDCCgwOx2FSE67wakRkNWvSJSpOz1zpXKxrtu+TkEkyyMM7mjpcXWUfdhypBDQoAV3wcNPX5t9xjGyHuYOBT22EyUd4ObEN8d01P2LHbeT5BW3e+nC/aYgizorBJ+rB17ui9DIh500liW42ZE7n67futxX7BSId2/eJK+8Sy+JffT9JCS80UWnG5EUXcUuZr9eJO9BFlBGDirs4SyhHcag/uhvOuGvI6vOHPRtCupZ6WmXd57A5IrQKZZaXIHfouVr7Sl2HdRB9BUphgCRabtuLC45+UO3WhNO5gogD5qGy99FMnUe9VtL1BrlXiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5L/2HWjU/eurgnhgialqdY/P2NRhdYMcvYVUNDt1TU=;
 b=LXFYCKEN7644OzhspBdPkEafjFfBRd2d764Nqhi+tLaW1ica3NPxHYiOh6TFOtNUYNCBAKQauA81ehU5YVBDjd85/RtgmWS4fdwu2agdEya+ujkGiZCPp9BqgnTMEp/5kF60SZORBx3jf5hdSVbiLwuMR2EBPwRXAh9WQJqWOku7FKchGTKLjzEwqkYryhy+BeDYRdk3nDrE7c2xQ+SradLnhl4q4vLC1eSOA1qHBnSlbO9+tEwyB8ifASkKLEPtCnZB7hICFOc7fqBzgRgcFkjH3uFJYxI1JyxnYH9c4CFFY62xpGKeoRbI6diuqU7aU3ozWVuBRTuCjjS0/nqFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5L/2HWjU/eurgnhgialqdY/P2NRhdYMcvYVUNDt1TU=;
 b=Pwt4ZSRJaQGGIToaLJSh4iSQgpfn2JlK3q5oBQZTg/cjKNElrDl4izGoBRvq8mzEtQ+jUpgXowb52QAMuQ3Bl4hbjfRtR3JqH5hSRdRqfb95JveWG6CZLP3tC9nVeMKy4XORQtAStwt9qmiwu8vTMf/30szc9T62aZRW14uP5co=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v4 1/1] iio/scmi: Add reading "raw" attribute.
Date:   Fri,  8 Oct 2021 16:58:42 +0300
Message-Id: <20211008135842.21896-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008135842.21896-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211008135842.21896-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0060.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::31) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ee36bd-aafc-4bdd-60af-08d98a63c925
X-MS-TrafficTypeDiagnostic: AM6PR04MB4309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4309F3D52248A5AD7A843E4BE6B29@AM6PR04MB4309.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVauruGuwBP/thSR/dlQZlVafXTCralmflRuZAvgx+n2Sx0IuakCNaMwRepdOYgNOVoj9u9P4Woj3Fua8u00ydXQwDE6S8K8uPjqAlgi85w5cswXfEv4R14bo66Qtlm7e8hfu8udyA5M6RuNTwpr+VZKiFD81TurR5zVRq1pSFLnjU0f3IbTymn1408BKFbpzlh+ptNoNq8NT8ziIdGAWT99gORpN9odKcsxJZnII4AYthfcAqQC9+1C+oaHaLwCvEdHEX/3lAnJ7MzexvZpu4zp2U9cICCR+PgXpaT/tyPc8zSLp6ZyazNFM8tQFgTorrj7PRo6HvR/FFK+nqGDFDAFUHzzjCtYYkyyRd2QHMZFvyry1ewb5p48/2hCxCLiPSj+mci2Qs5SXBS+GXBf/n7vRMjpJxhhoojotwJBnfS/H3vK1D+tpLJjEnZoWoJlL3WvASHx37fUYKpNNqTguIDhG1Bs8HfVJ0PyoSTOtBXiXRJLwjY90lexnT8cDiHxX8ezvFgOvUrvlbj7dtYkKIwUQ1E86FC998olYHiUVCKFIlY6DggmAijsuB9BBeAw963oPNlvuMfWoIQb77css6jlyxBycSJlR+yrIO+cTU5AlFDMlVuDyOxveSIJib5rCeAW08gA806UGsCoG2XGMrw+UExNxOJiUtqUbOiISy8KT4eEVq4NWQrwtdyCpB2DCwuQ1Ybhl4Nye4SP8znx7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39840400004)(396003)(2616005)(42186006)(5660300002)(107886003)(316002)(186003)(66476007)(1076003)(44832011)(8676002)(38100700002)(38350700002)(66556008)(36756003)(4326008)(66946007)(52116002)(2906002)(26005)(86362001)(508600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vLdpng5PhRuv10vY8g0X3REmXcrpwjBi/As1NgTdiNHN9HZjrY43fYi4+dc2?=
 =?us-ascii?Q?x46RuUC9Qz/pio3/5abo4KcCEIV0uzXBmU5CRtQFRhUDGKjU764uYPqgNskR?=
 =?us-ascii?Q?bkBzVeRogv7uN8YbCTET6OG9dhJrk+jxMgoSdBX/i31DbxgBgGv8N+CGQ4hL?=
 =?us-ascii?Q?+lZ9uTZ63tvSaFem0RjzEf010Yszgefd51gR86RXNvi1OwX5vK3l95mmyDRP?=
 =?us-ascii?Q?4VUryAhyAOIJELoYviJYw7Ymbpv1fnAm9+5NgqcM4EjgbAWcnMtcjPggqWcJ?=
 =?us-ascii?Q?2sIqCv+k4bIcOZQBT6o/orci7b0jFus+oGIG9gdRo8IAsVp2AQbEsGZPoOO4?=
 =?us-ascii?Q?lVUd1Ecd3MggGseLVjkFoedLdFY3Tc6Qfnpe5EZcMWAqCf9l/9IYEvcpJs8v?=
 =?us-ascii?Q?xWIfCpwY8ezWPZtaYZhGsXrvRYwXSeUgT2lpO9vomFvxhZWbZfqA328OU8iW?=
 =?us-ascii?Q?mXqFYup16UTWA2o0ABOkI6WZnLqs6GKv3b7JntearZ6WB0IX/mJ/+SpoVnDC?=
 =?us-ascii?Q?M77e8QZAihP3LgGCNbh/KNYxLLaBTZjpdQ8Yu/XBRHfObyTmuPH5y0tX1KBv?=
 =?us-ascii?Q?ewmwy93SS8IxtFN0NVOhA0x5FuAMNtpm5RdpGbOS589ffDiM3pY61ZbKH9BK?=
 =?us-ascii?Q?GERkqhXIZQKlJ79ro83fPCI4jgWroYefYXeNSQKBUL71ZCRewBYsqEcnp0E7?=
 =?us-ascii?Q?+kRBX6JZvBKrYzJSw8wRkZpWXdGUSDxqcI6irCSLz35BHNPyz8wfqxQb6M7W?=
 =?us-ascii?Q?a0ux2CuAegGfLRvhjhf6t0I83Ht3xKtTdxX+YaJdue9hSP1OGz//3Nmt2IgP?=
 =?us-ascii?Q?IXTSVrAE5uyPYHaDD7fPQ1xvS60l+jcevKku3+5eZMX0VYUyibwYYxIV94VT?=
 =?us-ascii?Q?67trDG3wly0Bzwa8zffloPa/bOOARASnKDYmXs3LaFPufTL1AfrKAEqOSsap?=
 =?us-ascii?Q?Wp5snnT0dsCi+k5kHFI1pg8L1c5z3xYP+kM8ndlJTz5tD9pRn534jN1xeJ//?=
 =?us-ascii?Q?tB/CY8GhasA5qH65zO7qN6jFNMN7Mj14HwNIkKf5jS4mSHFvCcCvuMIQqgch?=
 =?us-ascii?Q?Aikq4DVn8+O56ppLtnjE/YWr17GdQpzWs9GqKb0SClpUhD162JMXnvqYmIcu?=
 =?us-ascii?Q?mj0m2FBq1PZAzADdLJN5lO646YJ0DTbORZtNTukGJK82qGJkbvbRaxV268UQ?=
 =?us-ascii?Q?62ToYA6rH18Ck7sFZWUzsiV18PNxDEgL3x6aS4TQ2joPk2R6d9Nh4z6NfO74?=
 =?us-ascii?Q?JH3QVntx3b5XZEwFlCDYi9pnO9pUwl3ogTfzxoACIwoNyYPnmecrDtiQ7fuH?=
 =?us-ascii?Q?08vslRXcH+Q6+6/obWDXO0Q1?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ee36bd-aafc-4bdd-60af-08d98a63c925
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 13:59:03.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqtY2WuIPGT5ePclghImdApz06i8m+jNg3xSSYdhAUTL9vA07Vni2zIhjVUsbUPrLWwYdSrBuFzyc28svTywPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4309
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add scmi_iio_get_raw() to read "raw" attribute.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..c3bd48ea85b8 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -311,6 +311,67 @@ static const struct iio_info scmi_iio_info = {
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
+			"Error in climing direct mode for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return len;
+	}
+
+	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				   SCMI_SENS_CFG_SENSOR_ENABLE);
+	err = sensor->sensor_ops->config_set(
+		sensor->ph, sensor->sensor_info->id, sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return len;
+	}
+
+	err = sensor->sensor_ops->reading_get_timestamped(
+		sensor->ph, sensor->sensor_info->id,
+		sensor->sensor_info->num_axis, readings);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in reading raw attribute for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return len;
+	}
+
+	sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+				   SCMI_SENS_CFG_SENSOR_DISABLE);
+	err = sensor->sensor_ops->config_set(
+		sensor->ph, sensor->sensor_info->id, sensor_config);
+	if (err) {
+		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return len;
+	}
+
+	iio_device_release_direct_mode(iio_dev);
+	if (err) {
+		dev_err(&iio_dev->dev,
+			"Error in releasing direct mode for sensor %s err %d",
+			sensor->sensor_info->name, err);
+		return len;
+	}
+
+	len = scnprintf(buf, PAGE_SIZE, "%lld\n",
+			readings[chan->scan_index].value);
+
+	return len;
+}
+
 static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
 					  uintptr_t private,
 					  const struct iio_chan_spec *chan,
@@ -355,6 +416,11 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
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

