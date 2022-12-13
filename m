Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96064BACB
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiLMRQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 12:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiLMRQ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 12:16:29 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F2B848;
        Tue, 13 Dec 2022 09:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjRvIjI00cEvUTbOuV2KCpoL/vYFbgzRPZ+BPeeip6ErNeZ0wUxOGy5PwJIHydKWOrcO6eupw8Mt8ZWdda00FdY0tDsAhTwBxE/Ev9Jfd18NXj7tpBfksc1YrcOW1Lgyx0Si/CXJ54iLCWBmH9npdLZdnWSLqx6r4dgWJRe7cj5/reCv/Fl9p2DK2cR1AjvgtDydD8F5FTO8ygoo25VOkiIxhU97ZN88FVm6NpgHNY6yMhNNxOgm57oh7yz/c6w1XW1QwAYtPhTHmwqA8cEQgLt6MU2ICRNEWmKoCDI0TKtjmRHQrCraIcd9ldtHMcdeIj858TG+le7hpYVtiTy9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDxw0sDJtAzdyTa9164H4BqbnhLOmOS2D/7bV05ZczQ=;
 b=QxTi0XMt+xgIHafTQI6MTcPJmbypwAommsQwS4kQOZGKRL3+r5lszz9NcAet1j2BVynfA/urIfu9eaJqayFS/Hfwe6MCPWKpfT5lqgBIfBAgRpM2ZqDE6SrLxlV3CgDfXvnC/vjXa8Vyr1iVl+ehpct9HmLRILvEUqffOsq4nhRFPFhUUmHl5j30X58f3toeD7s4gxNySZbQoYBTLqUIcZp07S8uKp8pLfx6kXOZ+WEYHEuG0+rsy7nQfH0kYEmlKwMW/eRQlOIAK3I0utwsGR/6+OyL2mG4NZ3bK1XT6W3pbtAcohJtkL66CXokTJ376/eTFOm2V9EwWKEcRwpI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDxw0sDJtAzdyTa9164H4BqbnhLOmOS2D/7bV05ZczQ=;
 b=D9XEHOIJUp53CYq34/01+WLvyNEF68UOG+UUfL/TDC9jRe6olm62J/JOKaBJvKkN/QMVOC/i/9qtgkkxr/ZLG2AlEBuZP1/lujG48Zj4/X6RVZQ3rqVHcPK3HesJYyE0uKP0kGiqbDlO3Qf7C8Kj0FxOeQPAJiJpaLVrsQ419eQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AS8PR04MB8931.eurprd04.prod.outlook.com (2603:10a6:20b:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 13 Dec
 2022 17:16:24 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:16:24 +0000
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
Subject: [PATCH v3 4/4] dt-bindings: iio: accel: fxls8974cf: add new compatible string
Date:   Tue, 13 Dec 2022 11:15:36 -0600
Message-Id: <20221213171536.1880089-6-han.xu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AS8PR04MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5757fb00-2b92-4d06-a517-08dadd2dc2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvQL2v6wXKMc1J7NDyIvG5EXte3dHxeIW5w/R4XqoYWRxMNZyeg1167EigCSp/Y99dYRISk6Ztp1wZyGl2Ep4VJTf9D4et7cDhEHgS4EITxCrrkBlJtrSFTAUZ7jIFqq71lNwGkwXKe07AO/6XFTBqxa2oe2WcIYH+aAJLU9GMVk0i2WHckPThGxYDbjFNkEQNh/Z+AAfTEcmVIhoVb8V57DfKSSlXWpAzY5u7CMF7+gAN0DkihOd1ob4mTYZcgt3HgnawbnHC93MpDupA2c/956vpxg+B5714PoCQBFw/JO/e8jJX/Wf/jV1JFAGtOehAzr468dd8wOX8IM1ZoibHjYOkgl5Ykb5STHtf4M1GjVVhkX7EylJONV40LKzQ+1u6EK23QYsqzDp2E3o7Z0uqZrUEygBdiD8JL9Iqzn2DuDMRQsXQsp8fMprZ1k6P9+eNAuZ37llKEGKpIRY0bPPSncbA8VzTOZzACp/qviGfKsJeyAo92YFY55rvmX44P+Sf4J52YhWaWfhZRJkXUbbFCkWxBen/b1xLxa4358It8+jBVvz405lRM81KLOdH4mDD57JQn+aWyuXqRr/682Zk52l03oxo1/1HyMTbhTH1Q55FRIO2euAwjNcf9xd3/k9PMyaW2YO2XvsmEDUEjTVpnH1kQTyCZRUK9GICoShIKw0c2dEjxeG2/CAS2VxkY4DUcHaCOiqfgFdIucjRO/JDROkSUQCK+72uKs5lNizzFFAfkjHmLGJaMfFOpeyXFSHBQ0ioaO/NwHgB/ZAmU5Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(38350700002)(38100700002)(4744005)(7416002)(6486002)(5660300002)(86362001)(44832011)(478600001)(966005)(66946007)(52116002)(2906002)(6666004)(41300700001)(66556008)(4326008)(110136005)(316002)(8676002)(83380400001)(26005)(186003)(6512007)(8936002)(6506007)(66476007)(1076003)(2616005)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dhypPA2k4Y6S0m6R+RQUp1oq1NPeYr7Qn45tIGeBMC9uPLHvA657l7oHEYT?=
 =?us-ascii?Q?rcOpmPKHExE4CmZ21QgRMxo3LWhtII+X00FHweL2RI3MFKYeha+8F+n0XnhG?=
 =?us-ascii?Q?YgabrNV9i6VkR2svIEtS9fbts5P3Mui/MnMpF85B3W+5lGEfwxUVem37tvQV?=
 =?us-ascii?Q?A+HpXM77cavFHrDNHmpSxA34aZPx80iwkOVxlJnXMITaMQMxG7qGFgKZOs0t?=
 =?us-ascii?Q?pfHoTCe1ydLAJAmGqkhQxivyjvfCDBBGwVDj4gHRBn7L/62jDXBaVK03p8cs?=
 =?us-ascii?Q?HYCPeCBm14pqMsr31SF6+IjwtFABA2S1bDj9bCTwuBChVzTasyAoZe5LJMxG?=
 =?us-ascii?Q?pA2Q5QvySx1ruxl9ZVzgTES6oxN2wX6sFiGdY6RigbW3SPg23/PFydNsiOSL?=
 =?us-ascii?Q?CLtM9aDVPOW4Tlw0UYfG+jWFNlsiULbUXmziG8IX7pQ8352ZwILPU6PuYmEM?=
 =?us-ascii?Q?Agp9It5H24nQ6J45bDTjpYKuY/cyMMH0rsEpn8Hxk3ixGzaAXNg8diCB6OhW?=
 =?us-ascii?Q?xWZULq0+CWzsQxA6S6zVq+1MrMiq2yhhCJzbK/dbpLKCOc4DLw6Vr5y274KG?=
 =?us-ascii?Q?3oHpC1ZZFZf9kdgESwt8FRvwDUgR9rDX46IHrlnOx6ilBBn4iOAd8rMeVxw2?=
 =?us-ascii?Q?bReKrFkKsSBgigrezS6b/ME2IvbTgbNRGDEHzw7oPK3ARMrv/cPTBiXRFTSO?=
 =?us-ascii?Q?ZWuUAQXyLTNldxHwtc4+4KSGWWNVRsVfiWCuYcrYZ0EOvSFVl0tVEFIRA5Ws?=
 =?us-ascii?Q?YoPzKw+ymEUoKOh5G/o4CvsWlkpdlS/GvPyfkY9jM6XTY3YsxZh74liIy4SN?=
 =?us-ascii?Q?TFxOmRdQPDQPpvdZoqMp6OUusTTpgJHfxGNsFTZXxd9QR+42+e4+s5GTDAsa?=
 =?us-ascii?Q?8EqI7Y3wAX/ocz/PjEPE/4HA80mdQpK3ybHyanYYQcCc/Qiy6QhYTanVZW54?=
 =?us-ascii?Q?Zm6kSqrrM9qOMS9q3n+SO7gdopdw/ZXt6HuueqpEVBT0iYnJblkd1PHA3S1t?=
 =?us-ascii?Q?D+SW5LAeXhodbv/XvcdcvdM+sb3aT/Rl0TJXsRrCWBwBqCyKwy7PxOYDfM7H?=
 =?us-ascii?Q?FRhTzlch8RbS1hGLbhWYOSy6kwpP3k3wIrAdkhuRHhMVsexKrqKsTGyCIIG/?=
 =?us-ascii?Q?DluouK1p6tUtMdclWbuXvWntLAqEzDvIDVh5a1j+uQNoCZxq1JL8pxDJVW/2?=
 =?us-ascii?Q?OfOnBrLkCrNCWuV6oWObYKJLi29i3c6zbovJbDx7P2sMstw+cdeLQAcbEcML?=
 =?us-ascii?Q?qyym4yIwcDdQv/UddXK2dqqHms2kZI84+uKqAFODEcL1+wOBacuYMMWcZ46x?=
 =?us-ascii?Q?prOvMvOzVF5EO1DzhUhz9Z+np/sAhaUoRonovwmkN28PZ3Fy/OqRW333SXt5?=
 =?us-ascii?Q?ktj1vg4MDYLDhb7K0apVxG81jI6OT1i1oTNm+1awlp3CgjB6wX31c5IbFg4v?=
 =?us-ascii?Q?BwDOG35j8Cmtmdbc68jil0UFoXuaS4GUgsKjwwSgJkSeisaDUR7NpDCQgajq?=
 =?us-ascii?Q?9Nn+9MTjGXy8KJ/2ZpOTMUXANqSMcfKGUV9icSRVKcHrJcZKez25aAFOXEJy?=
 =?us-ascii?Q?mbd7x1OiBXvjzt7SfAg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5757fb00-2b92-4d06-a517-08dadd2dc2ff
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:16:24.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHyke+DZHKihU80sDXYrxgQrlwFlODPhUe12TNweYYahNrpGFszcYl1VstmvNEqQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new compatible string for the NXP FXLS8974CF accelerometer sensor.

Signed-off-by: Han Xu <han.xu@nxp.com>

---
changes in v3:
- Start commit message in capital
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 8f07ade21abb..34c452e04fe0 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -15,6 +15,7 @@ description: |
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8974CF.pdf
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - nxp,fxls8962af
       - nxp,fxls8964af
       - nxp,fxls8967af
+      - nxp,fxls8974cf
 
   reg:
     maxItems: 1
-- 
2.25.1

