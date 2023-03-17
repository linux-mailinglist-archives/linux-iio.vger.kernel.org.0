Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDE6BE6DA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCQKdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCQKdu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:33:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B01A30EAA;
        Fri, 17 Mar 2023 03:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NncOqRHqFtmNYzuMAipozyPfXpcdiHpqUtocvSrPUnPQDi6Row9iJaS9oMz1DJC+Kp4JU55Kfrs7Scn7cR7O1uHykOHZn6q/exIesU47wJToefpIfP9nUjg2ErlXdHK1WSjpRywSLBsOSs7yyH9y/PCQCTemFNTsZP9jB9qoNFe+ljMUqW4njQ4gZI8GFFfI/FkbUtZbXYzquxvoHJ8oc3WnYLFgYWIYK6aAH03noIu0UxILlF6oYyUGt2vIm7roz2ZA2Cv9hagJPtpIFtSpcwB/swQskEIX3gTejrZJu7OUEzWOrrkSJf5rqZEb9sdL1m/ZD+UPSvWe7qpuPTs6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chp7th0QoE3lCiI0yzGk6wSlZzn3QyI0CK3YfwMwZKE=;
 b=nf6NFT04Yy6a3XFdjdI3OhlZMPR+QgVZRprG+0839aUjwjptBE0kWYOIp+KnLLGPE9/tdfBWT3glEJSOSL3gA1Jl1mLB5byXYfaoJb+y3zVE5Josn94GFY5r4EtqOvXeRnXBdhDvQlDDdoPMKRWr4USy0+tkcpUuGCnw6q2pdxphatEWlgPWKFBY3qsPlEzVNjzRtJ+XZkS4Bv5iq3VAmbHO2b/HUSBoV7O+snLR46LyAUrtuO0SKY9oyjGwEXyG8bovCHL8VuQ61rTCSpFPHHW0JCigchlIx6c7/A4yzDMQgQ7Bpm6t22fv7SS5zOz0+oS3OZMMU/IOSxrWk5e7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chp7th0QoE3lCiI0yzGk6wSlZzn3QyI0CK3YfwMwZKE=;
 b=kejLR5ESMSolMB+6IlpnQ6SMyB/XESojLW+hzaZQsRA2oGlphLi1Om/EdeVV71eTJcW7F8NrfemmapmRcvPHD6p+uO/IqnRh/nYDndNeEgeDF29P9V6O8dp4oAewvs6pOcXJLHShj6+/jNDb+CT5kb+6KWlFVf+LHEeIiqo08WM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:41 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:41 +0000
From:   Stefan Wahren <stefan.wahren@chargebyte.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: [PATCH V2 1/8] dt-bindings: vendor-prefixes: add chargebyte
Date:   Fri, 17 Mar 2023 11:33:16 +0100
Message-Id: <20230317103323.7741-2-stefan.wahren@chargebyte.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230317103323.7741-1-stefan.wahren@chargebyte.com>
References: <20230317103323.7741-1-stefan.wahren@chargebyte.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:33f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5211:EE_|DB8PR10MB3863:EE_
X-MS-Office365-Filtering-Correlation-Id: 1670cf85-fd3f-4a3b-42bf-08db26d313cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXAKjGu5/Y6SWVF60ROgBozg2d5LbrtTZ75PVl/mPwtLiTQUyf7m4R6pPUjMJ5tUmcjou08z4bUuFZ+lxkx00nvZRJlrUaDvNjGWn0zu3EjkpqFeR3uQ0RB8tQ+juUeo3jLRKFFf+R/zZqQE2vkuMQApaRuiSpDL21NO9TfsWZ3Imav5nCYagdPS2Lj9KmMMTMvQoixzHSEXJWdMY1w9j9i4v8ewyXrkRSATo6Ly+WcdSOVi4tqdPM4SmNwUh3R1CW146H+7H2/WiE4y9LiAwnh5A4t1NXab/SIX7PlLjv+sknqALYS5AQvcNOBjuxk1ObO7CwrND/JcBsn3Wjc50Bfhf5wfC8n6EMJAf7Q5CM8wpREUuoP5zUCd0GG7cT+bH3IwVzDZAVC8b1XrhWjGYtD8wFrbTgWh0UBo9eCiXYxaj3nuWzw5/j84sbDBbE73hul6Rb9cJHAeuDdRWV5jFHaG/Luw1+lNaV3IleKjqLf1wb+VSId6jwqXAILZ7mqaBEFLWdL3pFA/KDOob+Q36nJjaAmwpMIBZpUkYSurYDDGTXlLvEFKrNLoh00YsDSNKlNUR8/zNWh4tF7MO9uElB/b3NBrPdQ4YBVw6zoMdj/lp2zSCfAFxPKzoRnS8cyZXPepBCMQeZHuaV4XALai9TQqnnD+Y9YoYtxuOwP5yXpx+sW0WlhihO4oGnpcQhbLCe342H3mLeOev9ScZTH+Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(4744005)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(52116002)(6506007)(6486002)(966005)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6fpauRnI/BLMMcCO9eGU0sGRcdCodz4vnDtzWsWJtoEREyF2+1MXhJjSBVhr?=
 =?us-ascii?Q?lpThgE3kNG+f9n2yGAKpBENXUzLwHk5A8uuR09f5ZIi9uhuXxP0a/DBdLhMM?=
 =?us-ascii?Q?vUiHF2YjiO1fu217ZzBjFMHPEFnoBdmLTo9D5Ziicg5rxufw2zQ2wL/S7Ixr?=
 =?us-ascii?Q?b6lMjMatZAgXp34hLiOTf4Vb6xTsnd5ZpkZ6HzpBpcmeJJYwVBcOaCl+WiaX?=
 =?us-ascii?Q?74fBFhXzMhMqvvmPi7tU9eUiKzRweAhxe79iwp2gIXicsTLcrp0h5mQRhXeX?=
 =?us-ascii?Q?kclT5TejP//lcNOt16C+UMxKY6155bCvZZFs1kbcpJwWnlXKMNzRml75eFqB?=
 =?us-ascii?Q?HbYcQ2S7gSvmV1JUmsaNmOi4IQSWo7hnVD4BVlDaeB8IY9qI2XMrb2RI5gE+?=
 =?us-ascii?Q?uN3pnQbKJuRvOIsuY5Hr7sGmmuhKYnJJZdSYKkOnB+bqOzJfNMIl8gUA/KQ9?=
 =?us-ascii?Q?1pgKr4hjuIhkcFTvkD0/Trytk8SLTMop3lQ58Asj7pqGvGnrKwb1YR/6gLjw?=
 =?us-ascii?Q?JJ9iZfCaFV8ciIUYtJyXkWv+VHUyO02y2o2q+TYH2BqDWLY/GYuhKvwapoMV?=
 =?us-ascii?Q?kSBZKV8/mYnCAlyj55viX/W6SmeqHA3KvUXR5O3RXYDrlSDdj07C6cFlJpc+?=
 =?us-ascii?Q?avlGEl1/HfCRQ6j68YsCGPMVbMNp4PT8kqzV41MgC+TXeWJFqscNMx/P2OLm?=
 =?us-ascii?Q?pH4hmEaa2uTTz0q44/ZQ7h8u0devhSuMXaflzDSRDD/swJIyYNl04CltQqa2?=
 =?us-ascii?Q?dnkiA5GMYgmoiz3IrXi9+3rOHYuhxsLsQwGkyVwddJfTkNvb33/HnkPVXGci?=
 =?us-ascii?Q?+MlQ1fZuQ9SnyQs3zsBQuAQJcnwF063EvsANFQVb4uH9sC0+RfHxmcrc6X45?=
 =?us-ascii?Q?q8z7ly7oo+gZdY10y1H7fHu+mBo4qAxg77L5sFsggyzHPLHHrp7PTDirF6zN?=
 =?us-ascii?Q?Ezi8zWJOWUxl/sZPbPh5Qqg9F4pSKEmE0ch7gIn7otaSjche+gSb8ICHtz7o?=
 =?us-ascii?Q?gAOYPr6Dni9W16TCRcBpVQ73hlXiQQ5VONwOPh8PEfdV9d8iDyXbUteXBGeY?=
 =?us-ascii?Q?TczRX64ksJ7q98jAN6+rVWrgGHwabdoyWycG/IXwC4rc97B4OjBnFmE732ud?=
 =?us-ascii?Q?Kftpahq9Y+ZbNXq7Frx8xjbqXWUz9UzGfiB1Rbk8QS6e710Skeyvj7IUwuo+?=
 =?us-ascii?Q?wfk1Zpp/qyZT/ACMde9Ab08La/LMZhswNKbIuBkUthD6dq5yLd5Ozq8/4A63?=
 =?us-ascii?Q?nBPkuW1vyWOs2niUnIpVhZhvUV16aou4FBMA1cwV6CyOnDdm03ulstHs6rjE?=
 =?us-ascii?Q?EeXZZo89tCrkwJJ1GAUVsNMseX0/s3NqcAZKsYLQoDURYJimkOrKrMp5b8iI?=
 =?us-ascii?Q?bRbns2GxhQKbpKGRVhZOp67uDgrluVs0eZqU9iaOjUyLGxcWqF/qr1O4ej1r?=
 =?us-ascii?Q?3WoGrZzpPL9QN7mMSwUpT+hI3kOsV4uxXjLO/y92iBVeEPA3brlvcj0HahqH?=
 =?us-ascii?Q?uxOE31ycsLj8A7mZQFOTJxkCYlNMeNHxF8BgEGJ6HybRylHwISLvpbHv9vmg?=
 =?us-ascii?Q?FtAG4ZpPTZCJIrSM0C1jvtIfNsKdT8rKe6UIazp12axLtxYhgxSUXqG7qtjQ?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1670cf85-fd3f-4a3b-42bf-08db26d313cc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:41.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REBjV4rIFugRTFLlmygB40W/SqKtSU6dxU1u/rwaNaKyeY7Gxwpu5CBQVSpuyXLqraZftm/DpujMeLYItOqcF5H+sZCydzx/mYs6Lb+tl+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

chargebyte supplies hardware and software products for all
aspects of charging communication.
https://chargebyte.com/

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..b8d8fa1d1fd6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -240,6 +240,8 @@ patternProperties:
     description: CellWise Microelectronics Co., Ltd
   "^ceva,.*":
     description: Ceva, Inc.
+  "^chargebyte,.*":
+    description: chargebyte GmbH
   "^checkpoint,.*":
     description: Check Point Software Technologies Ltd.
   "^chefree,.*":
-- 
2.17.1

