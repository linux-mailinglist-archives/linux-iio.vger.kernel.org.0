Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6559664699D
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 08:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHHTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 02:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHHTD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 02:19:03 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483742997
        for <linux-iio@vger.kernel.org>; Wed,  7 Dec 2022 23:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUtsBMG5kCmDr1HgXIy6DCAH+5s87U4BYZJ5eqa0C7TO/KYK0dj9j64MHYEGvgdoHmkNFak/5ZDiMSEEAPepNfIxHUY9N7daByzv+WnuYVaZgVBjEI9SjgQ1XATtaHaCVcu5PWVRE+i3dcthm3lXAQ/2ISGZ9las0mvUhpyeOiRBeA6KgEbZ+lvK0YAPyWk2lOSlPVbE0eQUtdVh+3+9/Voz0TG9JhhILMUvsvcos3McejMIguMUmpL5cTBOlQpzVuoqR6mWvUtQDii2hH1rcw6DFyAcDSy6glBPfgzqvdDs07gsW7Xp7As5b5n+rvvL2hNuDQ6RoxtjKLJAkKEXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puu9mHDfqB1kuNna2HiLWKLLC+93/edZQebyVIGRWQ4=;
 b=LkX+/iSD58Y7pp/F875zkoOriuDBkQE/5SdUdJjdJqtRKu0d3iZ10ZBaqpRzLPGH3wXZYV0cd03ZSoEH6DFEpmNhb9TTjdfyy7MQ0EX0+3c0cHc09HUyBnuCI4MbgroB+4D6P5KAcln609GJpN0ZQoTxiLoF23loZZ3cHCfGZ1xYjBn5OpkUeDez2IJS/kMxtpZ8KO2IhheyHUXPDt8QhWyorAF0d/dx7YKd2XLZKYE3l4i0EHtglBSKjxMnXnpUgBKBlyRku7NH6Q0pevE8flvhSA3wZ1+9njYc+OCjQem7gLNnpRdbKonJmVzMFjEbJ/BnqZ0kUpli+xgelVK9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puu9mHDfqB1kuNna2HiLWKLLC+93/edZQebyVIGRWQ4=;
 b=jaglQcCYgG4vu3DP7AWtViEL5C83fgGbFE9s6gM3ftcIhFQWXQZ1yWlTVpO4PcYCdKk8HZGnanuOdZIz79Jl+czHZaAm/Z2wnxa8D/DdZBazcnoEDJZbObumoolbCoInzHQSJfBoHqUkPPDA3xdBPhcJtpL0DpMLy4w/thO2bdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 07:19:00 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:19:00 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 4/7] iio: imu: fxos8700: fix IMU data bits returned to user space
Date:   Thu,  8 Dec 2022 15:19:08 +0800
Message-Id: <20221208071911.2405922-5-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f328e4a0-f4b4-4000-e5b4-08dad8ec7a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOMxGiEu5KqQr+Y8jUGsq6b7uV+zK7qdtcBijVedCK/WwHKRLvD7m7hgxe+5qAqxFUsxVQt59X0w0HxhnTQn2EyYNOpnRo+m/paLdSmiH09BQr1ZG6qfky794mnmID1QtofdGi0LvNsTAg3ROtbgf4xEAK9852Imj5W2gifoCwv45tuwqha3zW6276/0oY8+Ua8JqaX0cPDg5/Pqd/3MY7/ToGYnVH1S92W1FQmW7pKKksd6WmmUOTjJujSOiEDEUWGwKmYRLNcHF7cyx2QDFIKXCdRbS/C6W25tZE2Ss7R/K9gw226kG96YJHAxsMtl9s+wnmsuHmDwGi0u6dUn8bhj3XGWXzf1MdzAKMvwaJbvApQqokHgh3PfpEIIBY/KWFAaV/xZoQaT9zh7FKJKlObmJVk7FWMs5a8MM0Vkl+dPgqiZJAKBvg+W9qUFCzLeKIBVQ3Tv2mxyvEwspnp3jZFK3AJa8hQRI/tozHlpfhk8E9UWeN1IckRXqK4MLJBppH4Ag7WKZecQfLn4vi2ZEM9rcjCzr0l3pNITI8HdDvZXnyse44tclqDwqKdzmnksSxp4zXAaAtiZmpNc1BzInZE9curyQBrzEHbZ5g5lhc7weJNueimsi+5BjiOqAvDvtdcZviDkg6LXNPb07Oeo6oq1HsTFeXpNnP2lhnsjuHMoKscFjRd2hAWisAY9fjWM5avt84z9dp0r+SJaDBDnww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(36756003)(6506007)(9686003)(316002)(26005)(83380400001)(2906002)(186003)(6486002)(6512007)(1076003)(52116002)(86362001)(66476007)(8676002)(38100700002)(4326008)(66946007)(38350700002)(66556008)(478600001)(2616005)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6z0Dj6+8f7o20gVnAX3dbUu7udCfZ6qiorP4F3i055Gjwf+rl4vGdBnRiBhA?=
 =?us-ascii?Q?xujbpkMLVArhLqUS56z2jviFpwtJGreLBl29zEQ7NPmFmUnsofk45+hj2HfO?=
 =?us-ascii?Q?ESPNo4bSSGzMXJB6k7E559HjUqU2WlYA+2UmCRLPy3QlZyVk42YsCYiF32km?=
 =?us-ascii?Q?e2z+VzWj8pki+2F7UbSdh6XhNxeEDKab/zrYu/yKyMkbDqk//spubkgYkIbB?=
 =?us-ascii?Q?uWaBYTv5t7bYr6bjg+0BW9gdaOeC4NzpQ2uIG1wx1VPI5yS9BCNKSQe0JLkS?=
 =?us-ascii?Q?D4lbSdmJv9GxtxeCyJat0h3I/exlbfSEZJaABZb1QWI6/L2mrIQPSUdTckcR?=
 =?us-ascii?Q?6HubtVHDkbdaiRBiTjdb2Zk97jIe+IeM1UPhRQcuH9liatf+tQSMRhBDmWXh?=
 =?us-ascii?Q?teq2F+Oss195oMe1H2Nsgjzw/YaQvZOc/FKWwKfWIu9glVdS63ounuwcXicc?=
 =?us-ascii?Q?O+cpOWR78oECoH/2/vU5Yts2tajHE/yhSlORgiErEppy8qN9xQ3M24RC/1Kq?=
 =?us-ascii?Q?lXz2U0/2Fbxqg4uhjFFWa9znKRSihWVEC7FyjboX8A2K3wbX9OjD7QxB3a+2?=
 =?us-ascii?Q?Vqj6TmKBowjurQYhQnfetFBwKdqNdOhEeFdmA/0MCCsmp4G1wUj0gTZdwuR7?=
 =?us-ascii?Q?dFQQXCtQpBq8ADc1IZ7jp45g90ZbUpHthVSFWz/9+PpruSpl9snQ6i6ON1Wh?=
 =?us-ascii?Q?tfjCzLdiwUlPPY47Zd4f7p32A76TmdQf2S/dU/tp00f42pYW4DhHNH9uaMg2?=
 =?us-ascii?Q?Tdpb9PI1jAYNQFdIiRJ0Sio9w/WXE0ZjngCOhRU5uxeI2rVEfZmCK7idMviC?=
 =?us-ascii?Q?YHliD45SlKGOObSQlR3ruaV+Px70hcU9az1txLx+AEPEoufxqVE5mY4umxKB?=
 =?us-ascii?Q?1juWCjEoP+r51s74ouKxurW4BtCQd3GP9roMIL0T2RsFOpu2EEOtXBUGnw2d?=
 =?us-ascii?Q?tLBlDxZwGXW4/6yVtY9wFCk4Udh4fDOCi+mPVmYJlkyl3HbdJjX4J4eCwsEA?=
 =?us-ascii?Q?Zvvm3VMs1IPVj/4mP+HHSV9xwtZ647KTfO2H4MI2qfH8bYoDCmO4qsKhfIzO?=
 =?us-ascii?Q?qHSW9VdFNHauXrFNPyOA8nv8/3Dag8X6AyNgvOCJoWISwDZ0MzIlu1EDj8wV?=
 =?us-ascii?Q?I9mlmtOX7ORUm6ptkV8UfDXLUC0fouVG0Lk3g6dV+JsLdbLpzgD9EQq6WRQj?=
 =?us-ascii?Q?/Ov6+bdNEZVVwdF7OOlcNdMfhRxO4a98UbeUztPzE+Vs7mq+y+bkO4SJQg4Q?=
 =?us-ascii?Q?fXTfL/L/NIAc799nxq1xQ61iZbYcJMT+NpFXi3+CvbXhdAV/CSPM0ZQkEZmI?=
 =?us-ascii?Q?odMV9lnfumMJysG4QN42F2rUzdkH5+fcY3wNSnDGdday+9UA2MjWB3o6uXMk?=
 =?us-ascii?Q?qEgEWyTB9CpDZbiDulPf3dL6HoauQJZgcumOzUofaRbvVki94Y3Us4BDGpfp?=
 =?us-ascii?Q?vxIr2ekURlxQRv8cJRBuy5XO0qNdALMHRG10DN17/74Fka4480VPYJKSCMuD?=
 =?us-ascii?Q?WxiDP+sLqqWFozHANGmrFTAtSNUSSQRkE3q0zwQEpp3qvH68rnrwMg+xI+Qq?=
 =?us-ascii?Q?gF4YEV03vFNwmP4S1+E3nDpBGggWOmSmmwvWIyDB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f328e4a0-f4b4-4000-e5b4-08dad8ec7a81
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:19:00.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f53XIQtBjcUqxs3hYghAlfgFJVSt7EOalT+u5juCo0Vsb0GPTOiaRZ11XTCwwQjkJlU9eCTG+FJ5O8Dp66p6Q==
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

ACCEL output data registers contain the X-axis, Y-axis, and Z-axis
14-bit left-justified sample data and MAGN output data registers
contain the X-axis, Y-axis, and Z-axis 16-bit sample data. The ACCEL
raw register output data should be divided by 4 before sent to
userspace.

Apply a 2 bits signed right shift to the raw data from ACCEL output
data register but keep that from MAGN sensor as the origin.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V2:
- Store the shift in the switch and apply a shift by 2 for ACCEL
  and shift by 0 for MAGN
- Confirm the scaling is still correct for the acceleration channels
  given we are effectively dividing by 4 compared to the previous code
- Rework the comment

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index b62bc92bbacc..d2e784628820 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -394,6 +394,7 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
 			     int axis, int *val)
 {
 	u8 base, reg;
+	s16 tmp;
 	int ret;
 
 	/*
@@ -421,8 +422,33 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
 	/* Convert axis to buffer index */
 	reg = axis - IIO_MOD_X;
 
+	/*
+	 * Convert to native endianness. The accel data and magn data
+	 * are signed, so a forced type conversion is needed.
+	 */
+	tmp = be16_to_cpu(data->buf[reg]);
+
+	/*
+	 * ACCEL output data registers contain the X-axis, Y-axis, and Z-axis
+	 * 14-bit left-justified sample data and MAGN output data registers
+	 * contain the X-axis, Y-axis, and Z-axis 16-bit sample data. Apply
+	 * a signed 2 bits right shift to the readback raw data from ACCEL
+	 * output data register and keep that from MAGN sensor as the origin.
+	 * Value should be extended to 32 bit.
+	 */
+	switch (chan_type) {
+	case IIO_ACCEL:
+		tmp = tmp >> 2;
+		break;
+	case IIO_MAGN:
+		tmp = tmp >> 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* Convert to native endianness */
-	*val = sign_extend32(be16_to_cpu(data->buf[reg]), 15);
+	*val = sign_extend32(tmp, 15);
 
 	return 0;
 }
-- 
2.34.1

