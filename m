Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C431E6BE6E2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCQKeT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCQKeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:34:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468A423D8A;
        Fri, 17 Mar 2023 03:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL9e5lKJiR8HF/YXGjEMu3t7jLPtgQomc8rd9drBqPfcMJONpNqUCwsdCVgS3nmWBCqFnd3Td2N+kY5UsKBNkf7zhEve5LolemwdWLCzWCjAlXjh7nXuR2mafuUtO15KuJMVMYkj3POp8yHgRy0wjtntGQtQ4mPD6R82zudo6Yzx0DXt32TzuzDKt46hzYlBOeH0NlyQk1RZvfSTB37Q30TVM9xAxm9+YZvXnyHHgR1lZc01p1/WZza/N+7i8qAsEa6fMFz9Fb9qYBh7xXKkRQZU5zWddF2qEF+3MW4dkN7zcsT31nKqa+G1iwKJy02qa6KJ8HC/fHR6w3BmK+zPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeUhuvw9TL35oJlF/Muvaig6ND4jOS84+QQ2+LHum9M=;
 b=h51QA4LmTs2wfBufpwDyAfv906qx13HPnd05PSmukAC57f7Pd5AkIMQprwAYkuG0EO9Sg6+i2m7/G+7zA447T4ioGzKZFcFERJ38YAMiykVLMGsAMCChN+PER91CBMBn7Pe5Nv/mHcuPcTKdbFV+2w+SXaBFqH16N8vEltRKmkEtHwQq1NOifo/2ZzDRj3LZq9l7PuFwdmkKybiXtj9hE8n+CUKD69fu5NTtjHU7qnfyTyN9c0FAdaHatHMN8NxwzcXp4j320h0FfbTspdYmCk4iup8QvblZJF/WQfuus6JSVnEMCqRNg/eTMApFVnjewEi6rSuGKy3+izNO6xPWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeUhuvw9TL35oJlF/Muvaig6ND4jOS84+QQ2+LHum9M=;
 b=QRmZm/m/EX94iIsbP1VZw5GRSjyLPCx6O63U0CorXat3Y2vC9J1vgMLjPaju9d1NJoWSMlx5lcqYnfiwoqJ4tdutw+/9PpN0NmcSnlvtNvY4UT7Ad95AXqewktd5wX7gtdbLI54NdNurLZQmWIaPZL+ZmZewyKe1dffgnuap9TM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:48 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:48 +0000
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
Subject: [PATCH V2 6/8] dt-bindings: ARM: fsl: Add chargebyte Tarragon
Date:   Fri, 17 Mar 2023 11:33:21 +0100
Message-Id: <20230317103323.7741-7-stefan.wahren@chargebyte.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c85338a-85cc-4174-2536-08db26d317ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNl6T76UOqLYcoiEKrae2KdvO91La/9iTRgNfdKN0+HZvgoELm5D8cVYRNSGJGPaPFPyZ1sLfOfQHlFCkhJXRoAXC94gvVxW26Du88amHKB734jBtH4vYo77bH4xpetmJzkYW4H+Gbn2wPpSbPL4Sq0hPnHtCo2VkBHQMhYlhO+pPz7aQqh36QLpu0ICX70thLu3qmDbNlZZj9NuREU1xN6l68n0FZhIfHTBDMvMJnj8AcDDp290dxQwf0iS7wwGunPUyWpSHsS5/CLqJfJtNOC5+Iwawr4lbLUnHPnXTsjodF6Cl0K4o9w5Y1xX4pVa5q0dmbCnuPZme4izEgyueBZrZQgMCkCI0aDZFXuNSoZwZOwtTPSxmbErg4EXV9dhKEb3f055hALMpuCcVPRXLoPreReJDC7wy9k/rX0gU7h/MbRhfryarzo+srw6yXFTNzOi6hUfl9bWCRAdFAQCX1pylfwuA09LMPhsBoMf0ZWE3KASU5YKZqqd6USsLyQ9xZRr0/q0yQb25Kh6MZ8C5wMAj80+KzhohJ7QDS0Bu9nHAgmCQWMiKEKbSfDBZ1WSBHMWWWYfLuKB/h4wiGoPxrwaPaeH/dQd853DeRiXW1AXUegjqnvdZ/OFR6k8LQ6gcY1YZbjx1H3V8WiCzuX5ms6u5YNnow2k9zSqi7+zblJyDQv1i6G9GJ8gYSq7njEBdLdDzXoOYNxpz8YLHuB8u7Bvy6z5DdcGv9xkWwoV1K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(4744005)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(52116002)(6506007)(6486002)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYIZyvVWop0gVGnJC2RA0x75dro4lTuoJebm9hgQ7uUaoWkbksnzdr3sgkAG?=
 =?us-ascii?Q?Or1Q11bQo5l9Kdvh3EqSiBnl2HhvIFVQYccz0aulXPu9YbxxSuegJTRL/fgw?=
 =?us-ascii?Q?UB9v8dYqR+phVxDDNe4807sHVvYDtNEvQfRj2gkHnBO+W4BwJj2jC4kcvLeU?=
 =?us-ascii?Q?cz8f2KpY5X8QH6CXnmqVp8x6ACy2PzvNWI3al94KbzuepLsXQwOQq+1RIB9k?=
 =?us-ascii?Q?R4vZtzZ03aazrChRQR78Kc1eaL2xQy7qXgyN8X/0GXvnAc63O9+pOeZYSQUM?=
 =?us-ascii?Q?g9DVVEVkMmC90aHY/vi1+GTgwrHh+nNFhG+p+q+zoEcXJ1aA7mdjqzRQT2Xl?=
 =?us-ascii?Q?QStFmBCxL9KI+cfR5n/qDnsGcpN2C7SFoZQAbNWxZp5H4+6k31e6FYA/lYYu?=
 =?us-ascii?Q?eTY0u6B+IgPyw/S+63QdpPPZ8XkIYO6A0F1yHxOCQ2KMPmByXp9yejLcf5oP?=
 =?us-ascii?Q?1qlK19/tUZkb24vKSC5h8ZnnBGqlcqmkNi8mvApdpG2OAP7wvsXvFvfsZgWb?=
 =?us-ascii?Q?vEn/G4Tut1VDjhTasrkUbC3z3xUN/zS/rxwsLsG9JTVWyCxEcGPTT87C4U2w?=
 =?us-ascii?Q?Bc63KQRWhhwyfPZESfqzwKQrEsUbLrGjiDV9gIXVBqE36R11Nigb7EbRl3EF?=
 =?us-ascii?Q?e4n26lPws9hdsybF3XGtSvrnshtBrlXyw1hAOhpOjmQrSfCUUiyhJQhEGs35?=
 =?us-ascii?Q?lkMzxgZ2wkgaNqt4JT/Vj6/tiMXHmYFnQGQN5q2rHCT6UhlvstUfynNqhZnO?=
 =?us-ascii?Q?IRV6ZkhAy0xOgUJWDu756m/cxlCMOXNMJNkmZ6Vk86G8PmyGGtl+uSd0boHZ?=
 =?us-ascii?Q?v4ZVCu0GrgEUhtDNLx2KWrVZR+cf0mLKpjAuRyOsAwy38/XchI0i2g9EoHvR?=
 =?us-ascii?Q?dv5BEqo9FBX0zVmIH5j4Yl2Wz1AKNOy1u3TRZDhmfK454gFVPVWb7rqGyHbz?=
 =?us-ascii?Q?iyRXfQeYlXrXWm35C0H0c554xpdkuH2uny6HWI3f1hJdFqsWPByZNXwDoaSD?=
 =?us-ascii?Q?mIvoDSrylr8URmlRVJN0QuJNHXtrEiJQJCbDlGGR9/V20z0rzzPcVwkY0s+8?=
 =?us-ascii?Q?iF1X0IDQjBuYKTMSuRGsj943H0An1IxC6thBYfpEjDD7l0Ad/tCNI+g3gOmW?=
 =?us-ascii?Q?dbLz3NgN32XvvFEgq7Y9lG7L0WY7GSvR4gCxX1/0jDy0rKTTKrvVmd+o5AXy?=
 =?us-ascii?Q?aENYKnRqtKHyTY0gX/AtvtmEN2w8r38+YE9P6UY69f1/wjH46CLHw09exfrJ?=
 =?us-ascii?Q?TG/G95wvcMi9OBTKbxlLrzRuBjVOu5xAwLGlrBAm9dNjJnjlJZK3CJZjRBfz?=
 =?us-ascii?Q?iowwzykfwGtQtHowQQUFajv0ZVGoWcvFN/0TrpA6IYVyT1tGNqLK/NDCVB41?=
 =?us-ascii?Q?qhHGmFEWYjzdXFikfXsCSB2k/OPMjwcBUcxdEFWuVnxA1Q0CIuY+/PraEKRx?=
 =?us-ascii?Q?JtrrDUFUH8kr2HpMBpQz+1g7dKVA0bdhYcmYA+hIjPcZlKQJiPa86SmDSYmO?=
 =?us-ascii?Q?BfLJ2fEqq7kb3L8FlGs6u4Zb2A1wbodgDPy/deQT7r8mUNJZkm5Ic7SGzF8K?=
 =?us-ascii?Q?v2VXp9zD9Hqu1IPE2QodQ7YeF55u8prm/17KABmK4B5Q324O4hc0JO90brrP?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85338a-85cc-4174-2536-08db26d317ef
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:48.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhjVJ35OA5IYI6PTY59lz/LVyTI3uPGclPRakQbv0C83t81XCsjTLOMhAm6yvgcX1I2+PK/En/WCtKkpFlsv6gF7HovlbV4IJRZhhf5dh6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds the compatibles for the chargebyte Tarragon boards.

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 67a325ed5794..d4615ead4967 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -702,6 +702,15 @@ properties:
           - const: armadeus,imx6ull-opos6ul     # OPOS6UL (i.MX6ULL) SoM
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL chargebyte Tarragon Boards
+        items:
+          - enum:
+              - chargebyte,imx6ull-tarragon-master
+              - chargebyte,imx6ull-tarragon-micro
+              - chargebyte,imx6ull-tarragon-slave
+              - chargebyte,imx6ull-tarragon-slavext
+          - const: fsl,imx6ull
+
       - description: i.MX6ULL DHCOM SoM based Boards
         items:
           - enum:
-- 
2.17.1

