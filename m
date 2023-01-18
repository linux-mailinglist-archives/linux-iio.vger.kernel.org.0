Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F436715E4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjARINY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 03:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjARIMh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 03:12:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E3474D1
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 23:42:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbniYq92ogmhXzwRqXp5zAFhYfbl6RMdSRcghqUXtZ1Z/PVDovCOt1i2y4Bdrg1JjtdGk88FIcjeMuVgHQej4eTc6rw1X9z6tDqdWhezbnbp6t9P+3KMKfN0QkDbzdXoIgSS8tgu4D9lpHRJWYiMH1Ws1ohdkeMDmm/NX4BPwihy67zfWH1gBO985g/s0bbpjA0ChznTBkaR7zT74/bk9B6ODHX6Rtm6A8UfQeGCmj81MIzKMgLKsygoFUXGXSYjh9PjHex2PMVnaQp9hcxipTn2CD9vbygetlB26FchBaU64T2yCoPgBs2Civ0kfViUgq9h1p43y8/Xb9KcTivQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX0h+Hc8PLnL6XhvKQ4nOFlXbANjRAdtDzfDWbCEu1E=;
 b=N9mj9BYUF8Tvr6yI1Zviia+2mNTVlyo38oCM3a17uLR5D4+AuhxCwGBIVS5UC81DZ9tEEwPfGns/12manVHQoYipRNuXS+2TZeL+a7+cmuPleA/kLKURZfZwB00R+h3JP2FXWOD4kSvCXJfr/dBTlYT0HjWu0U8Jubidmr6un37f4edgUkhql9AQF9iIT8HvXx4yMVOLRBJzi36YHmHlRYR0qKpTJN6PfrpOcAq8TJpaYOgepUn4ZyjsLdYrj2bPs+sKM0NqDJpxF0SxnSpk59VbqOneNefQOTmp5ug3h+LLPqFQ7KS3IcJoBnIj+hIZWmmTxaF87FrB7q0/h8o8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX0h+Hc8PLnL6XhvKQ4nOFlXbANjRAdtDzfDWbCEu1E=;
 b=DQziMK071N+rx3ZuHzcQtZDl0y5jJyGoL0DWaY2p77uBTTJ0A+LIsYIEiGCb5lyjCA1N/3xhDUPUjg0Kn9GFoRyRQ9qDDwtWCiwIdOpPw73mnOASc+urMcS6zNyJr51I4Sk+6lDSxCYCIAw4AKFsofn1eGpaYajabNH6YOheiuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:41:59 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 07:41:59 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 0/4] iio: imu: fxos8700: fix bugs about ODR and changes for a good readability
Date:   Wed, 18 Jan 2023 15:42:23 +0800
Message-Id: <20230118074227.1665098-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: b41c7ebc-40e9-41b6-affb-08daf9277b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZTxA6tIJyIofFTi1k0e85jLtROkugfGiwwXkLAmRRQGLAleSKAQFJJ80owp2VRwBCFpJMiEcVuiiKr1rM8psg6vffto0Kgbo2RHmOl1vrM4i3+OfNBLSY8kaUH1fzJjyjxdBhlzxBKUIUyeLyzhHcHUVNLYVlKz5a3AYIDSuA2Jut5469XxV8lC68XyYyqWCXzDiPQ41WdIBKN+xEvMbE5Ao5ZdKyd9vEwNnqK0+QX0JLOt5oYXYTwbYqjO18FVHimz6iqWyGffs6iFTkFeu1atqi8q1DWOWo5aYs7H9BRALQ/mmquBLHd5EcddpXq5QQeRyLr86aXP9QRJd616S2bwp83Inm0at8VNXsrEwpGPURWH4uaHTBNzVYTIK96+ESAjy6JiCX3q2WXc+J33lzU+L7NV/6GO2GYkOpf7xvULs3ZesEMJ7ZNAl6swm4bqky4UUjzVgaYEIuUH8+QaoeuPGNbiSl99yuppWo1KDk9U/j17jdMKkHF7GqXCJa3yShkRBDcq8Qv7Rwnh6bGBxo6YJMM7fJi3hp83RNokV4t2q6i6lsml75uMUzcmKse+/GOMWs6Yrld4mqoZIOB6LGyoUZTZ5pEYT8OYfYKEdPROa0fkoqStjWCvkWRaz4wVPIYo2HOIExgXje6kuz7NBMgQLWIrjI9+uY5hyupZ/r/ao8McEuAlcDT68LdV+KzZR6zb1dap9Ravj/XKqWqXYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(38350700002)(38100700002)(8936002)(5660300002)(4744005)(2906002)(66556008)(66476007)(66946007)(8676002)(4326008)(41300700001)(2616005)(1076003)(186003)(83380400001)(9686003)(6512007)(26005)(316002)(52116002)(6666004)(36756003)(478600001)(6486002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWUvR+LaU/Tj2hy4ImSWKaFWKjstsBzv+H4E0SHNpUEWwLPS8fC5oQLVSvL2?=
 =?us-ascii?Q?Oar2gopojlhKxIGlYTNNp0RaknGUgAW7N8BifApkQEtQqfP33pdTMQjdyI9T?=
 =?us-ascii?Q?kL8cEfy+e3CaS8r68uqFzeQBl3UdI2lB0v69lsUbZIQ90e0OcG6WF++W+2m1?=
 =?us-ascii?Q?cz6l9YurFqfXay+Rk4P/62tT/CiWnG35Ro7iiQDJBDMtLVec8MqnWKjCAtGu?=
 =?us-ascii?Q?3obY3PLcTP/Tra6Vxl2prIyimdJKxbBLcv1Cq5hy+9saNWekaTo6olXjnLav?=
 =?us-ascii?Q?4nStUA5/WF3LReuzZ88f242kbL+oAFeYmHzypiLnFay9k0TI3DmfzvDvmAI4?=
 =?us-ascii?Q?GoXdy36zd1JrUtGH6s/lDkjwyH/JrLmyS1i5BFFmK6i8gA2p+aNExNpyE32r?=
 =?us-ascii?Q?Mbjh0a1uXmagSnNJ7biyN2/wlmWrjqPg3GksUPtacs0whcD21Petap93oP7S?=
 =?us-ascii?Q?h8eqHadk4RNLUz8kPrsjW4g+vZ+O79nt2t71OSzDOl1Avvxi68zJ6unL9Ain?=
 =?us-ascii?Q?ov1e7X2qM9KuyMwGIFh5dchUDd1l+L+CCx9V0nApowfre87KjbJ/s7eYZE7l?=
 =?us-ascii?Q?p8xDHjYQiypLPtnkub/E4JWsKbo1OnPGfFF6c+GsbOl+JuAu2F5ZZqG7kp7l?=
 =?us-ascii?Q?dltHovkOHnF3WM/82pSTYbZ/R/Sl/uMxqncB5QeBV13wH2L7uriqjw+e1nIJ?=
 =?us-ascii?Q?sBFhzZx0AxQ5OpHQ4BXLYp5l3NZQgHaXlNYjX61/C88+Wun/MJAChRtH5lRH?=
 =?us-ascii?Q?VDCNjEiuowH3n2IualP/WrGb+TKljWopRPNjavmxJKwgzmrp+qL99N2GfRhI?=
 =?us-ascii?Q?dOzU4W+QJ1lh0DcFDlQvXuzPgS0ADVKWnJG8cQVNvxID2toZFajzhfsU5Avp?=
 =?us-ascii?Q?jQsc+CxmFh1M5RbaLCIzWB51vYzhA9g0jgHl6ovtd74iw0q8/Pj9QnkwOq7Q?=
 =?us-ascii?Q?Y0EhXi7FC8djXDi/dK58rHBSNJZ6FVVgxDm6R08m8XoHcyh2vL2/d/DTCxes?=
 =?us-ascii?Q?y1auC31Ggh70AJT7SYevtUSeZ6UcbZpCJ8QKGrhiOFunzxcK3wbevtszhaXe?=
 =?us-ascii?Q?dZuj0+lGEFQe7KMXoIT1+GUsUEUIzjwtbCOkkWb+8DZjuyIPhQvOxwYvq3HJ?=
 =?us-ascii?Q?S/1bF7I+Pw30Rn25hgAS+z1lvvKo7YvJWzJmLGE0/JrGfpuZFqRYhPovL0tQ?=
 =?us-ascii?Q?EcOXCBpZLxjnqD2o4VX+3ug9tTfEiCZAW22VG7UOFYy2tPPsN04sxcJlBri6?=
 =?us-ascii?Q?TWlmVygavImfjvscGCET6h/8TW06TgV9Z28HU4OaB2fBqT21Vcz1sycwEQ8B?=
 =?us-ascii?Q?8GOu8cuwsW0xB0GJSfz25PFjNshao90w89Xd4fE80MZFoON5ZtQ5/8CRwpK3?=
 =?us-ascii?Q?8SRUKKlL9wUWh/EMagY9CcHMIqQUSeI3A6d2sbx4tWyH0j4DeoL0NqgTp9rq?=
 =?us-ascii?Q?x3BATvwo4eoR1FerGILI9UgYwymYKie5mzRBZeF5iklekPZgtVMxrW9LY7v3?=
 =?us-ascii?Q?l12GocuF1He99wCgouN2N4g0mElEeoupVpkWLyUau/yHrV4iYgpN077nEo90?=
 =?us-ascii?Q?88+BB11DurvjDZjWP/XBNsudHar1EKb5S7iaMbB1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41c7ebc-40e9-41b6-affb-08daf9277b24
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:41:59.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlyS+m4LHruSucBu1wEpZjv2/a1SkiD5Ogcgoa+xkQJ7FV1p8ZDqlhnt0NaCmZ2Rxiqsphlm92XLlxRrnTM30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
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

Hi, Jonathan. Thank you for the suggestion. In patch 1, I use
regmap_write to modify the value of the register. And in patch 2,
I use regmap_update_bits instead of regmap_get and regmap_write
for a good readability. Other patches have not been changed.

Carlos Song (4):
  iio: imu: fxos8700: fix incorrect ODR mode readback
  iio: imu: fxos8700: fix failed initialization ODR mode assignment
  iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
  iio: imu: fxos8700: fix MAGN sensor scale and unit

 drivers/iio/imu/fxos8700_core.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
2.34.1

