Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF06574C4
	for <lists+linux-iio@lfdr.de>; Wed, 28 Dec 2022 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiL1Jji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Dec 2022 04:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiL1JjP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2022 04:39:15 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FCF01B
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2022 01:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZj3LD6Tlhx8FKcPGDJLwgrCP/LpjNpwZe50Rvhokyfd9smuT+dJgZAT+//hZijHJ+7wgrJ6yTWm8M2Mx+HIjrTwXqdOxvxDL3pBWYT4m17uMOc6VBcX4qxf/E6sRMyii4v45Ic43xm2zJqC4iOiOCpMD06DZ/OhKjX3Smbqpj7Fwj9rHOk1jE38MYLY0H5fteA7xYz0v3KBNBN7e1zPT6q4DrjAwpBMV95jmv/sGlsBCI6A7Yx0+yVPTDwgndVpoMg+ClNw17+WwOeZ2lgtV+U959ESEUvgNz6EC5W0MqLjPOacT56cc9OzbyyWZOQWm/pRq0j+nk2Hjq4LIaRaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbO6xd0v9tYr1SVUTPR9dRz5iKiq5K6H3ZaqSQWEyY4=;
 b=ZLVy4FwPOnJCL08xKCvKI7p0PHEKCxrZV0hz5ewDZob2Qlj/DSNviB33Saca/0p2wHQ9I7HONScbRCvah7om+uOnCzBlVGNMbpyX9hui5BGv1x3w4Bo3HD5+OzLZu+rNH5a3OhZ7Fozyb37LNDGrnKC3AbyGycpeYi36LlFW2lj4QWuYp1/uHiKuj9pKM7v1ZcxewtWAYUGaYpNvxiUwkUUIu7AqeQf52uTS743IPj1jMKjfAF2xUWrMRS1u6ZIRDQskIYUoITc2DRRH2eaj+5QJzVDsk8FWMqIYcAFlzUUIUYeJxn5xztM4HCmfyRlYceZKJ5CDYxGsCwKDMgKlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbO6xd0v9tYr1SVUTPR9dRz5iKiq5K6H3ZaqSQWEyY4=;
 b=QmIrdohwJ3Ndsx6XPMEj9lTlpoYhuBoAPOlq7Sh8WFA1AopQ8ButdCkQID15Zujia8n5YT3yBY7hATHLCsp8fOXlp4oJ4BeFHtOBCyX+1FNJfZbEFc9wGseFuKyW8YniEN5RVUJibVuQg+WX1qITFK5AhxphUBsWQskvj2E8cHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 09:39:13 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5944.014; Wed, 28 Dec 2022
 09:39:13 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 3/4] iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
Date:   Wed, 28 Dec 2022 17:39:40 +0800
Message-Id: <20221228093941.270046-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228093941.270046-1-carlos.song@nxp.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6a4cfd-d784-459c-c6c3-08dae8b7610c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kc3s3e/aZ/4z4EWOTuHAfJPVwDW0wL+Tmr9wOdYYX3FPhcAZqIM2laQ+icqCfcUxxFFiiO5z6uCC6cNBUmWM1BYRNCgZZ6DP71Q6p+uZlic4rEtaEViiZpPNnSwS4Oh3KfAWzTZfayn/5ELE2iatd4kPVuxAXkSj9m3jvuxc78UgWo3UpQmENeHHiDCxNmShVyVptzoM2YIiekVELmy+L1Sm2zMg+73WwbL70lVW+ISOtuZnynSzBJcO40Frb33VdsnEQIT6SHxqK4qZlN8MiTwbQojVOtnQuziZ+pkVA+FCuc8G9nirNciSZrANk74L0bCYpUeLGDjWooSi5lGT1uTlOwVoIxeZ5HLlpFYa37lTLo1wqkWWYM5c7M6ArtGJjZmITSWwGmAThY4p3YyywvUDh8ljJfRtRVFjcs0f6DidutZQ1vsbTnmlFdIsnYwQEHR+6fYXPA7Lq5awY0hxT5VPwfQSjfC+AIFTO2CwUd3o02pK2PD0LmI/2pC1O9eqcV+dBiPwtLBNZAVwu4N2lSdoqwi2WQ1b5vn+/Rwn7yaRCCqiel3xNVnvFo5phTKP8Qryiw/0XIgSJRFFzzZ2/OLWOtBymNWlUge8UPEyo6PuUTF2NNMvUHUodCcDXHsxiB+wk/3V4KjFLU94sTZbu4jDsml0wytHFUmDR1VhWrk/aXAo7Hogrv8fw4OIwvcjYF9Uo0fuO7uye3GyXE7H2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(66476007)(66556008)(4326008)(8676002)(8936002)(86362001)(5660300002)(66946007)(41300700001)(36756003)(316002)(2906002)(83380400001)(4744005)(52116002)(6486002)(478600001)(1076003)(6666004)(2616005)(6506007)(186003)(26005)(6512007)(9686003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNWr1FgLRyY89AevxGBe7CRbabEhL+hH+RTgFsFbjjiJ5f3T9vR5hGyD1SBY?=
 =?us-ascii?Q?QD0evBQml5DOJEF3sRpGPAWyfuXO/1frzcIEO7O36rY7vXAzJfY9V6mJWgv3?=
 =?us-ascii?Q?KcidwiWLWZsoTltmVKLsQ/F6NpepFMfsSzE2td7UidPzRne0NXANlISdRHx4?=
 =?us-ascii?Q?VMzfHW8LfIXxQN1Wf+xykCfpVnKBjH7/Wf6TCELhyGCWeZUeoaACA4PZ3Vhb?=
 =?us-ascii?Q?KYyN1VP+y5tkBrcU3cIAr7bfPk/JrZ+9YxHDOjs6rq4rkpUgFQ0HawnULalv?=
 =?us-ascii?Q?pkv0ClwH7oLAq80WuxGBORRIbUXoxdIBNToyri2sSidnXPyyCR7u8WyREiGT?=
 =?us-ascii?Q?WS1aw5seCGvYQMzRfNF8iKUkKIW5QBjhToFPjxuoW7LD/TpaFds+TBRnAayZ?=
 =?us-ascii?Q?COehqfX6AB1OhqNpr+mTi8R2twmE9XWzJlrZ9qtZurxN5EACWt9TpLjw27Wv?=
 =?us-ascii?Q?Q8XLbgJ7p+8z1wiQKBjmZ++fy4fvSxrWGkT6IcMIpYXdBmviKN4wAxmU2mw/?=
 =?us-ascii?Q?jRCU8r8nJKbwIJORbrAE6yWj5Wc+OMXb8jWMtyh9XsXb0GcGV88EG5XCCnnG?=
 =?us-ascii?Q?Qe905Ua/138OJvzNyCrD41WvlPRjzR1AqvKX4wla+g+g4AggN6LhbIftIgUK?=
 =?us-ascii?Q?au4uG/suzihR0cbplqEkvTq1dBk4iiv3tKQatG5FZoAIUqMlOdV7unoSdGIL?=
 =?us-ascii?Q?Tow5L9tNjv+srg32PpzJcznYLBggcADUlrcW7FHBaG/opwNBowyU3e+JayCt?=
 =?us-ascii?Q?X+Amj6TnHkHaGLg79raYNCifSBu9u3GHkorZ0MFDjKValg0RLI62jliwlSmf?=
 =?us-ascii?Q?ZGNGcbtR7w8PlY7I8bV9gIfMS0bmuWS8dGfVC12OQuzG0sgvO5qMtrjUoXec?=
 =?us-ascii?Q?xoSRnL6Tays1PemRsm0VFj9Jj8tdFb5OWW8QV9/f9hHlezN+qnjguCcr2zMa?=
 =?us-ascii?Q?ezHNa0Gx2vo1a7XgEufWUOs6Oa6kO58R2vHaTEkr1g8AYDSu1y89/InMvSYM?=
 =?us-ascii?Q?Z8ASgUB1tkiTxngp/hHw/gvokqCPIBVFbfXTvGkpC6djr9C5iWjZhJ1q7aZr?=
 =?us-ascii?Q?WlkHC8mv57eTwa6C7kZ9ulQyvGmvnAtIi798On/DtmJ/K+iXZYNWzArNZoaf?=
 =?us-ascii?Q?r6TRXqxbqaXwpqavCmNEa8o+NVwSz2jjkHY3lCG9fL5d8eFp2LWnAJ0+Mjbx?=
 =?us-ascii?Q?02tz6mlwY6CEPM1jZR52VQIUykL+qE8fK+Kx59Apt21w2nwKuuPoWv5ZEui4?=
 =?us-ascii?Q?9QSHwnhTUeNUjl6DGE6Ogt+U4tJeLwVzBfB1dA//TXXq2XeyxDemNV/NMRu5?=
 =?us-ascii?Q?HJ7EUiDz8o9/C8g4pcR1iJeZL5a2uBZWo0ZOf69cP4IWTh4xTa/Fd1z7CdmU?=
 =?us-ascii?Q?OIY5xSvFXIfA9IH6nOR/sVUpqZpGp7/Cqq5iR7w69xR0IjNLsDvog8ew8b10?=
 =?us-ascii?Q?SVVkyy6MmcKr7X5x81g19UbfZCrSq6DuoM+2FnW/zbtGgl50dmUP7fVnwg7j?=
 =?us-ascii?Q?anTlJUvvZfB7FojH5SaHiTbhI1kDScAPynbbCgXQz29QAyeVSMZOYHg+0kY2?=
 =?us-ascii?Q?5MXMFI/vrSUqA59P9+vciJbmipwD5D4DxWtChwWJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6a4cfd-d784-459c-c6c3-08dae8b7610c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 09:39:13.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVxEY32uf9P23dspLs8ElnKVTRouBnUFl5I/qZCRkQA3NFndkMsXwIF/6zD/RJh9ntIvtTbEtV1fMT3Kbk3KiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
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
Changes for V4:
- None
Changes for V3:
- Proposed a separate clean fix
---
 drivers/iio/imu/fxos8700_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index de4ced979226..7b370bd643a1 100644
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

