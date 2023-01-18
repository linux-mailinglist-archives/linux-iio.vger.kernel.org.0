Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223FE6715E5
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 09:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjARIN0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 03:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjARIMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 03:12:39 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF74FC2E
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 23:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhTZtjzn0SQZRl+w6DcDW4mru48B+hmOEKc1kTlHreM3QfTc7fGrPlxvxxqfIpwam4meVvBvDLcqI4BUaEwCvPehVhLfoYPncUTP9TZIqD4bx4tTXBoS9uexp2EZunGCol6O0QtiI8t0dIOaum1NeGAU1hlGgyfBH7KhyBEZRzjbml4KKXB3xM7lWbjIkL/xn2wxiiFzP/tsL6GwzV54DptfAlWg2zYGE/AD1xHF5+tJKShvpS+L9Z7wcHDJP6fhP7lJUgVf9zPizk6un1RfZ95j/Grrtwyi35taCdod0ftD8s7kS2VnTjMnYO4asrXJwYQTiwVOlH9rm2RPSl0vZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SyouKJqyW1m6Cy1QB0bDosBq7IYhcwdIe26ncjC3BM=;
 b=BoENRlyiuPJ0zCNknO8cDgLFAzobD7JQTzJ7jsT3h614t5wDbXk7izKIcnpdQmaOmL/x6K0pCcnnbgivSBw7QYMC4FbaqLbMeFyiE9rEaeWKWJz7ALIRRPmyIiFt+bdQ2kshB7JBZvVVVC3Q2ZOfvdtFJygxHCUCG+9WBDya0D1MCeErH3fgJ8S6cXVv5KFOuPBIAABNtVt5Gj7nDL1ev1S6JlzvKMrOE2wDgXSO4A4ITlP5IUZLq8MUVDC0+XjopsTiXsGIrsm/wEul2M/sQR3v2qt8utyed9PI3oXUvIUXQZkcTWcZgDHbe2ai3vU0wU+L5aRNIz3KVvfdq1JzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SyouKJqyW1m6Cy1QB0bDosBq7IYhcwdIe26ncjC3BM=;
 b=G5y2lihL3e03YZxAR6g7VYYJqwdsm6ezyuSZeE9tW0HMuY2ccws+FeWGN4NuAgc6JWRICvnkHMu5h/BiClHk2cWgEcJw26GP+W8lsSbrOdujONd30qQcAofdUmoVsBn6ixNHOkjVPZwTLg3fcLocDiy1fKKVWKuwZYedl8GVFr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:42:08 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 07:42:08 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 3/4] iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
Date:   Wed, 18 Jan 2023 15:42:26 +0800
Message-Id: <20230118074227.1665098-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118074227.1665098-1-carlos.song@nxp.com>
References: <20230118074227.1665098-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7200767b-cdcb-46a4-82cb-08daf9278041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hJjYznHN8qf/wmtz0kb2uHvZzi2yev+rWl4VFw/5y4vfSoZaH9hQ/rnRGHvv1V/wdYan34wuR107etMQTg2KcXfx+MImBrz3zdutilGdmoKv3/QJSx9Cen4q4YgdJyV+u6+HFSUNulQAWJ+WteBqEVE0tKJl0oLMzI2Z9dyHvK8l5J0TVgveDozxrtOTJ26IEEdZL0jEZwAQ2n2G2YxT3eMoRYXNYFEVMrw4icNQc9DIHg0PgLOCKTFpTi1nuDez/woHGWLSsLGWEfOFujzJyx1OK3XbE0gzry/HBQ7fPPJ6Ny0h7Dx20SRrPynqYjB86eFwaHsEQrS7wMBxHXWOimM3dH5tlj4vKs/ZD/iDLBqMAOYMVj1dnpaqXwUGRQsM20Yj4WXsDblzyv20shpFYnB+42lvcLfs9a/v+ZqOKUKgZ19IqNCAQ4tej3yyJnLx26kC/ApeX7AdZbLUWH8oQAyD28CcWB+jXQvS5/lns3+evm8ydg7ize+v766zcEGgJL0lvHpbqObDqwlgh1Q7FI9IeFrmX4W2Lu5Ml6oQN7zsbaCSHdhycBP++wyTdW9vjzsYtx5aYYfEpfvWKxEcTLDzj+ztwTMTrDzK4NyAo2DTRPoUPZ2j4m0xpS1br622WUyIrzFhiccR0Nh2IDTkkY9+X8/3/gp8xXJFU1WNvQRFvyF0oH8PIQcr9TDvNU+WkuARe7XLClzmoGAEC/4JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(83380400001)(8936002)(5660300002)(41300700001)(4744005)(4326008)(8676002)(66556008)(66476007)(66946007)(86362001)(2906002)(36756003)(38100700002)(6486002)(2616005)(52116002)(38350700002)(6666004)(6506007)(478600001)(9686003)(186003)(6512007)(26005)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmwTeEvW6sYhQZZGZ6b+unWKqXwCq9EzLMUG6maFZeN2cHLB68IorxdP1LfC?=
 =?us-ascii?Q?bB4gL581WRwyU3IFzqyBxfkf87363wUfSw8oKwrzwjofG8NxxB6GPZiCQMPV?=
 =?us-ascii?Q?WUkm748ff6+3MBOId0NqQ28dXs5uiKkEF6bACyfsscCQ8N+ay4y2Ft6Uw236?=
 =?us-ascii?Q?EcLQJI0O2ZZ21H0aEGSifyaYReyPVC+ibGTDmq+Py5FyRazkYkyegfTJIyfZ?=
 =?us-ascii?Q?wSN2PR52EMTFRRAUGtHq36/Iz+NnINmnS4Asmk8nl5+B6IXEk3Krz8pZkysx?=
 =?us-ascii?Q?212PhEf+TAbcjY78LiPqQKNR5b9imTPImE+99A/8C2rRrVg/RgXhKvgLUSnX?=
 =?us-ascii?Q?LDaCn7uwhPDU1cmUkqiI7Ay3dQ7XbtyN8TjBiiYMtuhQKZ3uNb+sjdlqDX/F?=
 =?us-ascii?Q?QO/mMElisSW8B/ySRBdroE/4tFdShdgYLA9Mcm7J5sI16Zx8FuN1ztjbBJeg?=
 =?us-ascii?Q?iKHP9OHSV33ksSLy+bmzbbjkwL9c+cP1E3Hu5oG8lsIDd1/oMOKmxP5hZuK4?=
 =?us-ascii?Q?Aaf/mkK3ADEo0zbPHpKxeVyleBmIMAj41eY6ykBr2MjxNCaBoTH/C4AEaZmE?=
 =?us-ascii?Q?/Nzpd0ggXJTd6iCptWLpGOpbwYrAZOIbOp3xaqFzoim4X5fE10acNsfuAwzR?=
 =?us-ascii?Q?+/O+5MxyA+G9Icp+tQfB/wibI0+222DJbSz1TcNbCuhb5qFZSn11lS+MYN/y?=
 =?us-ascii?Q?k32ndiawOm92HLWrwYWB2BCmXUNXOWUbO5SwlNcCcbmDaJWdKmRZcNtJyFpv?=
 =?us-ascii?Q?/E6kU16HdQCMqafiQzB/hAsl3IuwSsGD1h+I1Vut49E/1wgjLnuvrJJelUW8?=
 =?us-ascii?Q?mNWE4aez0xZEUbRNNeuQHjBSGgT+Z+cO4bTJUaczeiWUVuOfhgN8/ateW2bf?=
 =?us-ascii?Q?upyYyL4zQg4U6/vVPqji34LDeL1S/9hLKRviNQ3RTcAuVzjfCQKcYEzwa2cg?=
 =?us-ascii?Q?hDgD/NLb+FqFR5OjIVhYkAJCIf7XiEDcvph+jsQ4XP2ycTtByLDCWJgDOhoq?=
 =?us-ascii?Q?xOl0KgVf/N0bdiPM9KqjpCHOwTatNK+C2aEPs6up29eLyxn3+OlJiQZ1/dsl?=
 =?us-ascii?Q?PD8guEiZnClzUuVz6JLRX4ZCUfe+EZKtKqo2f9JdC38I9m8KjcFEwOCRQQvM?=
 =?us-ascii?Q?uo2fBuUa5RWkKOhSaEi2BtbMYZhOyN9IKMo42MyMQYteAeo6yKvR2w2Ui1EX?=
 =?us-ascii?Q?/1q9l+XCz0rlzd99BEj4NQuBq6RRboiBxUo0nyo/hv4FwDsQe647xI0mPXwk?=
 =?us-ascii?Q?CO9NPidm7JtOpjttgmvxzNk3LsjgUlQtJuyalSRjlwplAXe01vcT0n8MD/Rf?=
 =?us-ascii?Q?HWJCd/Ee/ZHwyuPC6sUYBCzGhTE46LbA13odlvJqpEx6zbbVd2VT1LeXYklE?=
 =?us-ascii?Q?5DpDDgqmGXmplWcIyqZdqdHIcj3dho5m8B5k3jWQrsNfsgNL0Kw5fYVfrdwr?=
 =?us-ascii?Q?hpgnt4qrgIwB3YoahLh1mqMrWw6ApGh+wCzZA+4VwXlgGP3O2HCuMPAd2J7F?=
 =?us-ascii?Q?AsZc3ddFhvW9IYk9I5lB8FJloBzgTJ1TVCNy/fsB0HN+935FP8jwNoLF3zAG?=
 =?us-ascii?Q?DeEmzhuP2NAT9gcz2C2dlAQJW8AnDulPksWbOMcm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7200767b-cdcb-46a4-82cb-08daf9278041
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:42:08.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+H6WVxlCH8vX+KBNLUHIEUsAkrcdIPpHI/GyqxnLlHEVSRZX7XAJUJ5vB92kjWiV2UozYmslHMTAP5ZINGQjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410
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

FXOS8700_CTRL_ODR_MIN is not used but value is probably wrong.

Remove it for a good readability.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V5:
- None
Changes for V4:
- None
Changes for V3:
- Proposed a separate clean fix
---
 drivers/iio/imu/fxos8700_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 12433343807a..44e4befcf3f0 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -146,7 +146,6 @@
 
 /* Bit definitions for FXOS8700_CTRL_REG1 */
 #define FXOS8700_CTRL_ODR_MAX       0x00
-#define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
 #define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
 
 /* Bit definitions for FXOS8700_M_CTRL_REG1 */
-- 
2.34.1

