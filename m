Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF91645E9F
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 17:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLGQVk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLGQVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 11:21:38 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3718C63D46;
        Wed,  7 Dec 2022 08:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7raEawjmPW+OqCrooJ3R7dwxIU/dxtZ+WUeTVKkc4vzdbulF2f2hKXRovG1RFPD8jydvTsN/LXd7FY0rmxK3CER4Ygo/dHm1YK1po1xubEIVQJkDRiYgAYasoh+QfT3lmWr+4wurKSwGg/dM405aXBarfK/AxFy34Znj/MkM0G2NNI+WbG20ebmDjDjTN7V7ZoLRDkqNJnybSKEREE6GdIJygdqfEZCsGUASb/U8WcT6ENTLtN6QRzkj6rjxbW3BYDq8NZ7M80KC+aAWrw/v2RnkrPbFm/EbOh6ZZVAW80iZxvs6FohNJYH41xrisqH89Tg/JjQgdqTBnyKAayJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5fJXSVFJOH1SaEr0rmjfWEiu5EZ6r+dRtsuLoruwZA=;
 b=Evje7WzXXVZDTOOpssIMQHeQQ35Rbs5SBHrEwXP0965V4ItR9bbQYH8/aSSvH71aokYy4SJvQcsz1jVASzj1I0o2UBcTuvonh9yBrVtSf9uCSIg5Gml9hYQfMM0MTElYT7WDe33EVQP/8EcPKcowV9Z/0rokeB5WVQUa8kU7XT2lMQUUN/LHnaVkwk0uiq6QlK7T/H2ZbdVOyVUcDOu4BoGDkXyT6jxEHHk8ju+U/aBfQTdTJdhi1/9VxcEQKkTHb8xNmdLXWWB15VD6tG6YfMIKlZPu9Ryvvgx7RWpGwLByYz0bnFRJYxnaIDgMvUoE0ZZWehKMPqguHMfP80F+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5fJXSVFJOH1SaEr0rmjfWEiu5EZ6r+dRtsuLoruwZA=;
 b=ln5PCBMA4EzG9c+54NtSLO/Gu71UT+/iWM8bLX7Fu/oNMI1jTGbDdL7sMqItqY02yUFBJcCu5a17yo+UEQLSqziDi4vIyWtTeJF8DNiPrAJLmrdjTW3N6tcRdLQBNLrXIuG1nOLkwLCH+gmBQ4/6DjUwEj9lCGvui1Msb2UNgjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 7 Dec
 2022 16:21:34 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:21:34 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 2/2] dt-bindings: iio: accel: fxls8962af: add new compatible string
Date:   Wed,  7 Dec 2022 10:20:45 -0600
Message-Id: <20221207162045.669958-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207162045.669958-1-han.xu@nxp.com>
References: <20221207162045.669958-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6bdf1c-3fe9-4b92-5bb1-08dad86f1b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SnH02UL2+1TvPYAJCVX/f46+hhlyaUzPWUstGm1colQZCcl/c9hXVIn/e0x2KIJtYiy/vgEXUqySZbS/FKTSZkfgjVQ6nBpSMKfs4373EfNZDgkTny8JcfLqwQmLQI9M7qAsMabUgmW4wkjsBM0XkzV3gIdCFupSz4fQoBh76+CF1QdCjrBozj8uGR5lhLIIB7m7C+3uwTjy/29FAX35s+J6GRL9jXRVp2j7kjEy8IwZcN5G14e2ISmmx2jodX+X/AKvkzJzacplmvZF2ezoeU2rbixOu+4DgkfC2qJUtNiKxZkwgnUjilKTVjR3mP+gZnFWjUPO65J77KagXuyB8k3cknt/hlHDw/JZvErOOPCmturrZgSqbrG3QrpDGxOgcQBWffoqjKnaDvLpa+7g6TTG8jwnyaG0/U6HqzoNONpvdjfyZ0NTFd3I0yMCDHkTdmaw4cZ/IMfMFDc0DKF+grjwpgdLvbgKPbltTtr4HBZOG26852zta43lB4om+QLiZZCW7qG5AvQKNVnUJv6Q+EOmYB7cTLsIIXzh6787okDntjVmwHo6+dUmTgh5L5Ii+OI4X8fsmkWpfoqn28s861Rf+nFi7up3pCdrIBvyL/VY4jzTGITiVJ2zaY61lrSoqUEyf1ZUqJeO8ZDcozhFBd/Ev9syRVJU/P6VM5oWFo/Dz0UmLBjN1TVGlo3y3/Bhk0tA66iniF36oKFvP4aCxCtVE7MFv8sm/ZeCP4yjByBtJyYF7JUWi2opgLXmIIQnPqqiVf3rGQzwsiMI+p4bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(36756003)(66556008)(4326008)(66476007)(8676002)(52116002)(66946007)(6486002)(2616005)(186003)(1076003)(966005)(26005)(110136005)(86362001)(54906003)(6512007)(316002)(478600001)(2906002)(6666004)(6506007)(41300700001)(8936002)(4744005)(44832011)(38350700002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiKCNgJ1B3XC3b9JntpD0qgVi9atU9H/9L/Pm7+sjy1tFciy/TYPoKTJAaJE?=
 =?us-ascii?Q?6PDxaaEH/HVQ1l5zO4hVrHMx1Zls+3N++JzEY4YLlzkZZBH0daf/gna+XWMA?=
 =?us-ascii?Q?1ukzRLDhsfGar8GfMSS34LaUW3cUsFGupFZ61vwcP5DCpx3X1QbUWKAVAzKl?=
 =?us-ascii?Q?EMNod2Ez86A0iFLKEHTeFj3v5XOycfYjPEAYqY97yBAtbkuCp76q208e4sPA?=
 =?us-ascii?Q?gWiRrA5KaytW2746wxBnR0ovs/0VFtsdodiUS4t+vk7Px/B1ZLbK3gy0oIj8?=
 =?us-ascii?Q?z9Sczl0ahyGPc19RaXUpRqDN9+zP3Us4xlTu16exm1H5wlu89ih9dBmfPRxr?=
 =?us-ascii?Q?4+gWyJCGTWL12GdUCxv538/lBJ3CVf7r2R7jn2bn+4BEZ/3vN17FcDCVnFjU?=
 =?us-ascii?Q?xV/tyPHZ3gq4BknOGtwpPJz+Q04tWpwswhFfk1ugUmHv/YplxYkytx0C6xvh?=
 =?us-ascii?Q?ZKppU+Psv3FxKFbi88+NTP6IkK6TBXLwEcgGZrZqHU+9hf3tChyqoMn9GUyL?=
 =?us-ascii?Q?syenzCWym7xyfckZaTq8pJcrwjn4h32UkfODuIQiRbSnFW7uF5PVbSOp61Pk?=
 =?us-ascii?Q?ghw+q9aTdNZ0ViROTvHcHJhOihOXxjY9oNmytNAIkeZ4xkw5dYdYgmJ+0+D8?=
 =?us-ascii?Q?uKI30Uvgn/29KGm6Qvl9cRu+1WCTOZkRYJBLynUX2WdjDAYeHQxYuxyjdYit?=
 =?us-ascii?Q?jKH97StzdbTCOhZUG4UjyXZWs1TlitFJsPS6bitVvwRIvY6YDxdP4TbjAV+w?=
 =?us-ascii?Q?6D4mcyaAMC5NwNZG/HwVwvflcwDhpEK9T6/T0yzyIJCC7CVmnlBPjfOTHXeb?=
 =?us-ascii?Q?Qgn4AiHgPFqmzkFle/tvZGBYQFcTYIDr7beMF0axypV2/Kl5jB26tQTQRVJL?=
 =?us-ascii?Q?l/Q1tym2CjR4O0/rfyOs8C75qHuODFnTxgi4fzzTw9tIZTsCoNGOIXah6hVI?=
 =?us-ascii?Q?cGQ34wJLDbizaJ3GiI3OMixe/bq1MotbNnMj4OhPLl2cqESIvKGp8R0ho4+p?=
 =?us-ascii?Q?7KREt5PuD/zHWb1PUjHgNIr8HowJJ9Mw+fDqVDL43pHxDLMx00dybAZOZxJm?=
 =?us-ascii?Q?PwhaTd0SKh4qp19JCL8iUX/E6/a46ghVI1hFlKictZOfn3FAlKs+6WR+S9qc?=
 =?us-ascii?Q?ONsY7E5nabS92qCi9rUXD2pcUmbNns1K65QHtAbiADux95S1voxBh0Ihesw5?=
 =?us-ascii?Q?dp2JXcqpNxYz94ETBcUo13JwVrBvFsr+C+0d+kbNr2JiDtQcCs1WYymE6sZ1?=
 =?us-ascii?Q?nSfuNn6mc/oU+/LcRB5zpBCP2c3O/P6M/b+khDOWwd53pgF0YSSIKXB4dVKz?=
 =?us-ascii?Q?rOCSzDKYPMlyqP3wZl+vDLW0HeFwGvquxwPCSXwp9/uJGAmYhxrYL1Nc/6ps?=
 =?us-ascii?Q?uV0ybPZ2oPXhz4PiYidJjop6GvpMpf8asgqxTdOu9CpFxuCDo+hmZS81Bds0?=
 =?us-ascii?Q?LLIq8UHN73sWNTFmxmXtDFDleFQiGu/L3jNsPY39NPz2p9YocBjAhtyUKCB1?=
 =?us-ascii?Q?qqhwqH8REpNWjvRyd5MLZF+NR71iTFHRPp0qTkOTqEoLmPK/t/MiIQLm0yvS?=
 =?us-ascii?Q?KpRKe+xO4DkZRDXLkgE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6bdf1c-3fe9-4b92-5bb1-08dad86f1b8f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:21:34.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDPLm1TCF0sAcGfJdEC66FcOXyFmL7NdJQ3ks7IvoerojaJQONadX9ZyUk9cy7u8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

add new compatible string for the NXP FXLS8967AF accelerometer sensor.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 65ce8ea14b52..400eff3ff315 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -14,12 +14,14 @@ description: |
   SPI and I2C interface.
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
 
 properties:
   compatible:
     enum:
       - nxp,fxls8962af
       - nxp,fxls8964af
+      - nxp,fxls8967af
 
   reg:
     maxItems: 1
-- 
2.25.1

