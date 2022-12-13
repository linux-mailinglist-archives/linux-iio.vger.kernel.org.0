Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C664BAC9
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLMRQa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 12:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiLMRQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 12:16:27 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABFAE0ED;
        Tue, 13 Dec 2022 09:16:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpyYTAqqcHfaLr654qYqVIDTnODPR8AlS0MQCMrLS06GXwJ2hndtcn5c3LBOdQMaf0QwCNIRSJSRtTD4H9bRm0J2BMHNA8iP7WOU44Z7MuksHEYTWTd8LY4f2bUq74lP0d5W9sHy++lZcvBbUzfGr7nQ8YRJMMYHvqSCakmO85eT6Cm2RD7nxGLkIMdftVyMCGJWHEZvpbvyMpUq6W6NDeF1q6PRMAT4osSFI230t4noMr0+mn/40A9WuhTDKhFD/UFtAUTxkkW89AHTEnDmNM6kjbmtPut2t/0KEgAu6FAwfhGhd30uo8QbCIanDswAgGDkB/OTHktMGo7suWgEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VAQrY6TgTwLQOkBBgMf5ZqjWDkvQiqbDdKVa7pCP70=;
 b=MLs7YeLIRvTdr5w5cHNb8cACP4Jte3diaiG+ffJf5cmKE6YBwK087myqNidBN5eoAmccpt0z73SUYh5/9HytSHJRONfWEGCA8NrqHJyM+NozleLW9bV53kNTFMG0FPQXKbjV6+GMU2q7hxNxrOXRnLoKWvIcVRmwEhpiQq+3e8yNBE9qwKDR2509bDLkEnbRO7g1GYzhz8r/sR+l6u3l1t7JDYSTt7Ar7bYZORy2Q83pimsn9I9kw9MtpGrv574faT2FX1lcllRXe6i2CTH/2lP3ILkvLfVWzYW5XhTwsMdEAEmXLDFWuppVNh1SsoZC0/ec64QJVP7zNIUm0V+NOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VAQrY6TgTwLQOkBBgMf5ZqjWDkvQiqbDdKVa7pCP70=;
 b=hPU/hdhTS2e/P8kFENcGMDie8zIMfEmEWwr2CXdJKUs8BTN8D5mLg5Rj+EV6Cux3fTLUWAzjVoAyaoeEE1Y+yQYZXU83IMKnBgKrhXwoFr5TOPR7hc8YjEzlzS7XSHRfk+CQJl3fDAqGoCQTiPNWSsgH/ENHbBlDEhuK4cd/kV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:16:20 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:16:20 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Han Xu <han.xu@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v3 3/4] dt-bindings: iio: accel: fxls8962af: add new compatible string
Date:   Tue, 13 Dec 2022 11:15:35 -0600
Message-Id: <20221213171536.1880089-5-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213171536.1880089-1-han.xu@nxp.com>
References: <20221213171536.1880089-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1e2f09-23d3-41a4-4bd5-08dadd2dc091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycYPtj1BzS0GEO0NZ/W1JLyQjU2E3e3gEd6asjX4kMgBoYFkY+yknoR0fAcZOBTpkPSYC4lnd6SKbo+MKq7+w9toVXm+H+BlwawdYr23Y+cpVwN7Wd73ip38r+EvvrHaJTkPB2qir0eGbQzjqYY33rAqZgrlMiSwqNzfzwhKRiUY0QofaDzwgC0EZrNue81XHSJFzQ3bS06s2wraf/ONosUqiMCaFfmDQR9FlNutrS2rqG7uIurBD9NUHVulvAAoajVeDuTCS6DjwJOe94r6ftFe6BDh27wXZiDycexZEIPqVI0vt5yVMy2SXrAdBJoEbsvQd/lH5FnPqRtfkzenU1fQnDE2HhhYkb4ghyw3IAd0C5TbysWWaFukq64bTvFo160eARcmrHE6B6kBx3D1yw3QGlbhVUf+yHAisMcF7R2LtVopfCPjKrXBC1UBinoAvfS6zDhzmto6Wm15YwZV0QeS3aWs1wv8NOYRUZyFe+yz9NNAjcREA2u4nrxAxyTMZOKnN1TJ/ns6MHY1iKoF7w7Yg4FLlIb78fC+yXhmMrqVi9hSiAtOAlOmz8wTWy58h3XBIRnqINl5zOinV7HjBm4HTT6nw7htma3Ludqdl5Vj8PXGjnU4Zh/a6yAbMhBerOG78IRNFZrwc0TF7GjslevAkZfexbCplr1QeavEYmo4m1MY+Xa/3Xjjkr7B/kiOlxKkOL1bMlm/BE/EX6lsJ5dCgO8u5ViWFJsl6hRS4GF5etNRFUcG5uA6mjz5A8kNxP+FB9dWsUN2J0GtVhV7FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36756003)(966005)(6486002)(110136005)(316002)(478600001)(86362001)(38350700002)(38100700002)(54906003)(6512007)(1076003)(52116002)(186003)(6506007)(6666004)(2616005)(26005)(66556008)(44832011)(41300700001)(66476007)(5660300002)(66946007)(8936002)(7416002)(2906002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HfMpXA5h7G+UF0SIzSVCD4ZO6NR2nnTp7BOejVivsIhS12lHl/HR8iE5Y+3Y?=
 =?us-ascii?Q?2Iklg/BGTyZqxk/PRG4wLaLSHjZwwqoMb/b902GZHn5Njh50R+npjUOlbzcQ?=
 =?us-ascii?Q?5Pg6TMnXzYvM4zfuOge4vp6sjw0pUCXZk+3KY8vjDPK73K4d5uDLjp6WTM/N?=
 =?us-ascii?Q?fCQOfYLTGcN7xuqK/a3Q+VJFLPiXf2Bvn6Ed9kK6f9/80zAKCFxA4Xj8Ej7d?=
 =?us-ascii?Q?UGNHHnESIm9DvDI47gvJuUPRWPrz9bJSLmTZOMs+f45+9RDCcF8Kkixjgn4V?=
 =?us-ascii?Q?dQPb8olplGsIn7HEigOFcJ3UFCr6tzKJ+jQvgOjXOr4z2cvd/Wz+UTtYdAGd?=
 =?us-ascii?Q?zEQ8kARTsrc/AUtSLXKo35klGgp/4CUm0nteR/49LRVk7P7Ita5smjaAtABR?=
 =?us-ascii?Q?D2yunXz+Ryc97m2TMk2RY7dsFRrC11sF6dwR04VPV/Sfh2SqLFb4K04k7c5q?=
 =?us-ascii?Q?N32Bq0aotNx8CnFZeGh/pOcGGGLRobR4ZsvlGTsjojwUEfkBzBLfi+xZfjFn?=
 =?us-ascii?Q?Gw/qw4EChe23rmV6Zg3BwMflckMuvBneEuaodBBrsCXd5ydYXhJkfAZqrn4+?=
 =?us-ascii?Q?i8I13bL+mZTp4MKNRvFXu4lLFpGtRfljZciJpkzWRYgngic0bwH2R4gd7mzJ?=
 =?us-ascii?Q?JYVqfD8W+1LY4MwjS6N9BH4VlJpxJ2RXHAfeDPdxZYhcIZYCL9FDHrzf8BVk?=
 =?us-ascii?Q?mLs+Z0vNInfpPDznNmljTClITaad5Ya+9/qXKpdo9mosSm4P2MHtMdARebqz?=
 =?us-ascii?Q?t70SQ4ctBCeOwXnNqv+Fcb5BwTP06bBWMrZzN0I7TqTNoxQEflJ5GseU75o4?=
 =?us-ascii?Q?LpPNiA7V+8I5ZheLw31DeqhkjuPdQ9wW/OL4J+HnApbJvVMDtd6heYOiNXUy?=
 =?us-ascii?Q?nkJLenHIkBtK/pjwlTl2kCMXsrEwwOYc3LzspF1/K6GqUONHQqtUbisIWzSI?=
 =?us-ascii?Q?4UxDfbWOfmEvEKiIFQ2JSkxGPjI0dmzOs4OB0ngWG4QwZVVMOBwy/Msle61a?=
 =?us-ascii?Q?Nj6+jcQCi2YNvQVfrnrr9jv4pg9zxgviP4kiSsid455hmIg5XdfoLOo0hwdt?=
 =?us-ascii?Q?wJM4iuyGPGzHNUlBGtFuasBVYYQrBgjecRKo8qbeM04/v0K7F3gFrzPQCEGU?=
 =?us-ascii?Q?9ajckFVs5RM2HYFVLhLP8O00WYeBhX21+YkwynLAAN6QrVRpJihHPRjhtYp1?=
 =?us-ascii?Q?TL1pnryuUFLlVywbPJCUAbVAC3BxmPPO8pa3MN/G1k7A/Q0IGHvkWvwU1t9F?=
 =?us-ascii?Q?jRXtd8oxzuCRPKdwmL1o8v/p8iYiNQca7S0t8cBVfoESnUcoP5vjogfm5QiH?=
 =?us-ascii?Q?Jga37Ae5KEe5HezzwltPTLrPg0MpBoRLU68LcVqyFmjDZQwwBumr9T09tHXm?=
 =?us-ascii?Q?c8QXTaQ+8ippx/0o/MLV3JL8cvtlQEpFhCBvvK23BA/DMt64hqLOVjRdk55y?=
 =?us-ascii?Q?XVXecmBImcgSIetxX3ipA+iqVWtPRluIx0TEqFjZ2ysC4shM8SU2AJku2Dbh?=
 =?us-ascii?Q?FYXYKl+Z6zvzDXulg+1vF7FqRcpz+KQSg7cab2fZl7ON94K/qW/hplpstkiZ?=
 =?us-ascii?Q?mFebrFsk7Jv8Lvg4fFQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1e2f09-23d3-41a4-4bd5-08dadd2dc091
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:16:20.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI84NWwIzCUr3DBvDItteQitsVZ3vNHD2BTDWPRrDwzjary617luXxLONkJiazzL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new compatible string for the NXP FXLS8967AF accelerometer sensor.

Signed-off-by: Han Xu <han.xu@nxp.com>

---
changes in v3
- Start commit message in capital
- Describe all these chips are compatible
---
 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 65ce8ea14b52..8f07ade21abb 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -14,12 +14,16 @@ description: |
   SPI and I2C interface.
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
 
 properties:
   compatible:
+    description:
+      These chips are compatible with each other, just have different IDs.
     enum:
       - nxp,fxls8962af
       - nxp,fxls8964af
+      - nxp,fxls8967af
 
   reg:
     maxItems: 1
-- 
2.25.1

