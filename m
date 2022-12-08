Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3464699F
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLHHTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHHTJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:19:09 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC7429B0
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMDblcI34W8rwJOcqKSInVMbASNt4Rxyf/C5twQzXpcHj9R+kCgfqQzg09D8Ober8V9VB3Uuap2Lz67ruojihfQpSmUR/BCqHEpiszHst9uEe3NrvPVBN3Zz7khHvVtyZe2HuVz3rc8QS9f02X9f3bBOV2sASZOWFvJKuDk+YhkAGgMNlayvObhD67XQe64qmT3fu0ijbXSJsABMaLXQC5uDOxsIXCSWJcW40JjPdma8FPY3F0t7BlFDitrhogNWj2ttzksgzPKIkdvkrNlLfPSAsaQ3a4TIkH1Nt1T1iXirSkQywNidh4V3G1DUCg6tbfeionzPhBAtPWIhFC+G3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrXUZM12qns0q9DTr4MC79Spc5PS9+v+pmxJ+TGuG0s=;
 b=h38HRFJSvtyPiuiBIztp1uwPbPppaCaKDv2WOn/c3ntqxqchaEeFiDsZeOMLQkztj5KW3QHnDGYJ+1ZoVZVk2etWSHvyy4h6AEeDratQM06nwDJ1NnkkPpFNNSbpRjbU8sxfAlLDSQjKWzGBI3ZlLmGB45vw2j9Acv2wb+S1YQSAluw5C+uY9/+eu1DIMIi35CE9b6MoLzw7rKaGp/Sh0g1TK7pNlue8+uarWnsSQp1kAtOvvsY9keXRlYVyMQMjprRfW6mkYob+dISgmxkOrNMhHoc3DViHYXwXFNAqrcNSfqDpORyDlhjFRirHZIfgJxS5R0yLdcqx9tULdjWDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrXUZM12qns0q9DTr4MC79Spc5PS9+v+pmxJ+TGuG0s=;
 b=U/McGN/v/muQaMSE2oPlxrG5j7ZRLEz7wFcBBkDqZB8vRDKCujgh0efiAJqIuSuh2mLpI56p3qIA3eP3lXD0XAu4cC3sVeC/8YY6XrC808JISbtk7YkljXTQ2BydEVqj7Ixun4YlXavj8L8Yezq4orHTQgD0aVWiyMqy/ce4jYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:19:06 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:19:06 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 6/7] iio: imu: fxos8700: fix ODR register readback and initialization
Date:   Thu,  8 Dec 2022 15:19:10 +0800
Message-Id: <20221208071911.2405922-7-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208071911.2405922-1-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fcefbe-2e0c-4402-fb80-08dad8ec7df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5n/MSgzz+E4KofARpJpUZoUgRMLH8WDMdClWXkx84UVzWIltbc0K1Xuy5VueSRbTlpGy6oCbS2fizKooWkI0eafLn3AADq28WVT7KTVA89IhG38KwpVrrpLdU0QcZhXoPjqp6p6VGj42zH1VMubVFQF2aCgQwWgrKSwXD7lWj7EfG9O9oLpCEw1yihqj9RwuSzKpScoSIWzlX6CLt+SpYXXuqzqFhGpVzsRyX6z4k/MfwyVSgMniVlxVafN453pi/hPSSW0YTDb9Aw6GyMAlTsokGfm7VoCikcYjJOTYpxuMPzwOoKywYjwMEtsojCuYnRahstFn9JG+1ifxgiFBRTeON3T9gFo4+UI9lePKNSHMY+lMtqVlymKWOBEIJBsBGNNC4K5WUtVSgiNkK1XHCB7fVCzxU6nyVU63sZTCKRrBB9ru5SkurZUcYz8OzPLBdhArMoF9eBGo8pMpuSPFZ+18I1TDb7sjq0jal+Uq/EqEeJ2ze5l/YN6rBS086lheCEEhv4DEcjbSsQueLa0QtMoveT5jS2Aexm1aU0Nv8EWR/6cXLBsAXYmpRfNpmAFjtGN0OLd1+1nY18d45VHpIeSM6LVlhEjHADVgeShqsUI1TF8w5RKmG+Qn2i/Azhn7ddIpin3vU0/OX5PimhRmx5svJ2eFojKq9Bb9BmQLuBeqSlGz5De7JR3M7Jtp32xu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(6666004)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1gDfUH+7IqmIr329U2uLeATD5mBMfV9ieN+jqY03p2LvbRUx2sG5Gp1BwiN?=
 =?us-ascii?Q?rGO0uVxS8UCI6Z17PwVGkNJRTj52sNcyY+ki+nGm/URhiQPTQR/ChNCWKPH3?=
 =?us-ascii?Q?2zSGOMzEUDZE6pHJOM3f2PWpmX1yqMAO20OF+wfT65SQjGV4UXLL657qA8Hv?=
 =?us-ascii?Q?9tSofGh5KSilubS18rboRmmRbrLqLTIKvJFTsySZtJUpHflPfBFwbiRY/ggT?=
 =?us-ascii?Q?n95rZ3hVXVUB25wZQCwKHr8QODQ3BEChoTjqdM4QSXqqHVl7/Hm8elsoViFx?=
 =?us-ascii?Q?9X9NB0y0jKUDsHauyIXx4aebaEShQflI/PSfNaEV5zgLcEEKsDeggweo3z3A?=
 =?us-ascii?Q?j5Vw3OH32Ego58GtVroBuiOiaxgAofBT5nU0PvOxMAz874qtmtqUe6eU3j2i?=
 =?us-ascii?Q?5BrXBjPT/9u3xA4AMu1V1VdV2ULJ+ED/yvtH8mr1xmlj4/UDh8p99hVdnBSD?=
 =?us-ascii?Q?QERfkvb9abJhWR2CezDlZXnW6jg7FEWkN8rEBRWXRK2c62gYngaVPRfu2/AA?=
 =?us-ascii?Q?zN7ydQMd8OPlWYOnz+KKudmQZ9ZTrH9NhS+X2BF5wDT05nqc6FvKlsF5BmzD?=
 =?us-ascii?Q?GkfVMmZGAkH5yXdj5GOqw70toJ4e5llU/EWWnmDt8kT7FefIx7afCCtvmN34?=
 =?us-ascii?Q?CYx9qACYottTwZS8KyIUzd2wLZQs0ZbWzokk7cYa3ZElWFlyXacaTH+mOX75?=
 =?us-ascii?Q?IqLfExWeC1I3u+EHNrnAo4e66J7Mt87oJWacMGx9mP1WxXstrPnBMbjqyu+u?=
 =?us-ascii?Q?ZlGSDdeAPCdv/nw1VVpC/gXVCVVK0c3WZwIqjdasOqwTal4mOTPYcxGkqbXQ?=
 =?us-ascii?Q?Y4p7+9q4IT9wEosnEwqaq71ZgeqA0Hn/XEsHZnm9OTmOeZR9fkAp+FpBmisZ?=
 =?us-ascii?Q?J1D1DWk9pkII/yc+wAIujTj7j7xCTuKnKJYenid4s/aaGZa5FtG7/4HM2pel?=
 =?us-ascii?Q?BjqWL1NbgOJyABE9TQGKrloilNPp0A5cAcCwb9LjMRQXNuXBlF3aGtcTO3Dz?=
 =?us-ascii?Q?exp0tBpDIgQ5InOizDCIIuH9X3G+87bNEqsAXnuYX71Q3lOZ6wWEX88MlJ2U?=
 =?us-ascii?Q?YRD1MbOZDab6d8x9r5tGwC8i+lJ6OVPXt6Rt5oYgrXrMfpCmcav4SafmEIgR?=
 =?us-ascii?Q?s1gP6DgN11DatlVspYLEu2PLuea+L7iIsdFZh6/eOfuE0xhwT+vSe5WfIban?=
 =?us-ascii?Q?vfx4Wh63RRs6hwh5E6hGEYMD8wjZfCnlCwQ8DZTgG0mSOni/yiYz+2wvalzT?=
 =?us-ascii?Q?8FM45jHmpjS9CafD8lh+TTTdjemHDZQvzExORE3qEqBGsYs21dfjBeKGQH3J?=
 =?us-ascii?Q?y3fh+rB18MOio0cVGXr5qI2YS8GHYjIgOyWSha0SnU4BB6yVox7/D52RyAGr?=
 =?us-ascii?Q?3aFxwRKAxkUQg8pYQTU3xTtgrSeFkBFFxgA2kPc0oHnaquJAJ5yCIkpxK4r5?=
 =?us-ascii?Q?cnVcJkHBx32P4SLu9JZAlob+F7SDAebSo4l1APqXj+sjSBp6+mhhgFovhoUK?=
 =?us-ascii?Q?1GABb2EuQjmbyeC83s4GL410VRzSNcSk4Fe47yMxg3LPlvJvGVvfv7y0305T?=
 =?us-ascii?Q?ZtvgTc/QL8Bdzmse5eA8kAGkLeG9cBxlKBC9eZAp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fcefbe-2e0c-4402-fb80-08dad8ec7df3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:19:06.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td6csDuVUa6YXYQW5/A6rQPrn3wZFVaS6vA++hFiMUE2QeK2xu+rgtJtc42YVIi2vfmmMlC15PGheqij+36RYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

Use the hexadecimal number to read and write the incorrect bits of
the ODR register. It fails to set MAX ODR mode in chip initialization
and it will return an incorrect ODR mode to userspace.

Use of regmap_write() instead of regmap_update_bits() to update bits
is good for readability. FIELD_GET()/FIELD_PREP() can help clear register
bit definition and avoid separately to define an offset. Unified use of
regmap_write(), FIELD_GET()/FIELD_PREP() to read and write correct ODR
register bits.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Modify FXOS8700_CTRL_ODR_MSK MASK instead of hexadecimal
- Use of regmap_write() instead of regmap_update_bits()
- Use FIELD_GET()/FIELD_PREP() to avoid to separately define an offset
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 773f62203bf0..b4baef82f6d5 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -10,6 +10,7 @@
 #include <linux/regmap.h>
 #include <linux/acpi.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -144,9 +145,9 @@
 #define FXOS8700_NVM_DATA_BNK0      0xa7
 
 /* Bit definitions for FXOS8700_CTRL_REG1 */
-#define FXOS8700_CTRL_ODR_MSK       0x38
 #define FXOS8700_CTRL_ODR_MAX       0x00
 #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
+#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
 #define FXOS8700_HMS_MASK           GENMASK(1, 0)
@@ -481,6 +482,7 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 			    int odr, int uodr)
 {
 	int i, ret, val;
+	int odr_mode;
 	bool active_mode;
 	static const int odr_num = ARRAY_SIZE(fxos8700_odr);
 
@@ -508,10 +510,10 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (i >= odr_num)
 		return -EINVAL;
 
-	return regmap_update_bits(data->regmap,
-				  FXOS8700_CTRL_REG1,
-				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
-				  fxos8700_odr[i].bits << 3 | active_mode);
+	odr_mode &= ~FXOS8700_CTRL_ODR_MSK;
+	odr_mode |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits);
+	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
+			   odr_mode | active_mode);
 }
 
 static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
@@ -524,7 +526,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
 	if (ret)
 		return ret;
 
-	val &= FXOS8700_CTRL_ODR_MSK;
+	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
 
 	for (i = 0; i < odr_num; i++)
 		if (val == fxos8700_odr[i].bits)
@@ -612,6 +614,7 @@ static const struct iio_info fxos8700_info = {
 static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 {
 	int ret;
+	int odr_mode;
 	unsigned int val;
 	struct device *dev = regmap_get_device(data->regmap);
 
@@ -664,8 +667,10 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 		return ret;
 
 	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
+	odr_mode &= ~FXOS8700_CTRL_ODR_MSK;
+	odr_mode |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX);
 	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+			   odr_mode | FXOS8700_ACTIVE);
 }
 
 static void fxos8700_chip_uninit(void *data)
-- 
2.34.1

