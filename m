Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68356BE6E0
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCQKeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCQKeK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:34:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4437728;
        Fri, 17 Mar 2023 03:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUfbOpHQr7eWbV981VGPZjOGjNj/vjMi+v9oPkvNlxepJrsZViv0imPFGXFSaDFxvE1l9XCEgqjWDG15pw+S87rbDB4DOLV59bCr+fR3O1wyNlVVf8UWdUQ7KV7EGh6fCk4qm56Zcsi7FJdtNPU/qP2tWpux6LCP8PJS2Hxap/cuDJCXZjJcPpinI7Ri1ylcvEaEWrm7+sGl7e/EhtLnm/OPXorDA4g2pqcoL/4DnxH5YxSmX6R0RPWDFwzX7uNOHsk4qHFpghmC2nN4TXpWPFra9KJsz/CRfRUerkuXZqy2+WRvxUr7NkTiW0PRPjW4I/qJk0TJoEd6hJHkzbcOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK9IhfWvifxqYkvtiJHzE0JVw9fnhfQxF1tpRPNV1aU=;
 b=bpuifRCkaB6tfoJz5eT1z6GN32cwJCZOhV0JW2SvUqExp0tpv8te6S2YPMpY7GYYLhZ4FHj3r9cMkFtP4Gkg2nMyg3Q6R8M/h/fdatDXEqwYuizB5eWgNiP4iTlgBtYMh1ax8GzuY9Ho5k10+D792prFWhvKWCFdTsvQONqWF8X3MOI8fpB+WVCJ97nX67/rBwoM4GdyYR/HsymVEeZDvcw/2DJcfBnN1zTuXpjeMQgB5GQmLatIHVSad48VF0H4qCwIx481Anqn9eiEZjM9IIgDIuUok8MOT6fX9Pj9+Wiz+DNP+c/l163Z95V5XC6Wcvec9yNTwGzmJTo1vGO5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK9IhfWvifxqYkvtiJHzE0JVw9fnhfQxF1tpRPNV1aU=;
 b=WOcmksa+wb4uH+VEvR6skHHTanL36+Xyzy2yeVwvnq7HUFJbIImUNk3Xv3bYxUlAsvQqRjV39mCnNC1w5Jh4kYpC3IJZgeTHuIfwHWzITi3FcMOSy3lWS3httTUMsDtrUfgYwjD26ATJQ1RxoNOep7tUySXYf7jf6J6O5NXkJoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:46 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:46 +0000
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
Subject: [PATCH V2 4/8] dt-bindings: iio: st-sensors: Add IIS328DQ accelerometer
Date:   Fri, 17 Mar 2023 11:33:19 +0100
Message-Id: <20230317103323.7741-5-stefan.wahren@chargebyte.com>
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
X-MS-Office365-Filtering-Correlation-Id: cab8643b-0713-4dc8-c734-08db26d3164d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSnh607zC2us3KPABG7EZ/G4XBcKGbnlw0jsD16N3iWVdtFmlBeyk2IldYyV5ySS2C9M65+Swpm1Ma8UNkxCMDGANfbGfGHg8635/BRMnE1hgAytoVRTldlC1LuAntHWThUmwCMZoXhTJgn6fie1GksZsKwL3j7tRNsUbL4/7p9sSEYFcs/yjavxGtpx9iYcVKQjRTlO0xcz/agl2URkFcg5gwKuRGZgwjEiSHoyg+EMOxYMSsqZHmZAwuWDGskfb0XrafPlsVcF4A5jSKyLFZLW3asovchFpvsu9N8BRgVOxvs7LP0Br1UsnzKXqFBDZhM50M3iGcV6jJCfdP66ZC1dHWv8qVYj7B/b8+6B7hZQSnKbBm5LJ0UNrA0J7PYGTuQ4dcAfoaFvNQ0tW51bT1PyuhOR+iRSyyXvet96sLOroiWxcuWqqVdc3e0nPFS3COow7UFWAEBIJTIip2Jt4XNuyRx3xPdFIYAlG/sKQRJJolerSFZIJBmvjNcn6ncHwEBuZ6KlZo3i2fuIn2LMla7+mlktWd9Ew1Nw/F08vTjB55HyvMevbt1d6EPuSb9Zr52Jeb4C7ZhAQqIIJbBeCgYOeQUs7/3EqMvwqYKGCKQRMPOFXJSIGxqy5G+idmQ5r5BOlnx7sdGPHkGtCqQZl+4TyrL8Q/2lD4C2N3WNRI+EDvxllcTNBFfyFJdA8x03k5TN3Azm+etBWY9O7j53DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(4744005)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(52116002)(6506007)(6486002)(966005)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACvfXTse7wO7v3Lxq/7Ft4jw7h48ChKVgLn+ECuuyFEYm/Yd+9ER5OrTCdKo?=
 =?us-ascii?Q?RYGl5ZOsyAXi55FiFBQYvPfZH4EeFqBtunDbeJoTLuu22hjEsx8FFDV/59Mf?=
 =?us-ascii?Q?sDAE/5ZAdpYlkNJMbOxKCoYKBYBFHMPk3DxkMknXbYC5IIvc5THda+rmrNOz?=
 =?us-ascii?Q?weiNs8tCw1yI5lR7XegBniaHWDKPF5nmRVcfWutOBXjRESQLjYln0sEkfsa0?=
 =?us-ascii?Q?q2W3Tc4fX2GYn/CzUmku9zQq+O5Oqxed5AYFTkXkrcTtVgxIrzwpzN41HIst?=
 =?us-ascii?Q?ZeIP2Z+UP080FYH4zI0XLpZjP3XIz0B2D39e25PkGNjohQGgKPR586qJJCwj?=
 =?us-ascii?Q?oeWAGVpRSNivBtpSrv4u47vUg94Vs+mwsGDiH11w2hPE/r9f4pDQg7N2ejJu?=
 =?us-ascii?Q?4qHSukua2mRJAADpfjMk9l8bFfJA8AuOMVjLYFFRCxO2Apv30IttFeR0Tio2?=
 =?us-ascii?Q?3mwKqi+HPb4ThKdVhFYdg0UFdQtqEMlfyO8LRi8L9vnliFYu8OHsmGmNRZMj?=
 =?us-ascii?Q?1Sb1ZyvG3qqjhusYLVczw5pcwnmDiqdAn8W0EC8GRmKPCc9NcR1gEIZ8YUNs?=
 =?us-ascii?Q?z42r8JcYgYtA2AleKlCAOscONwOybdusZ+K/F+hY8xYoeE/une+Bud8UouTG?=
 =?us-ascii?Q?y1dVpiS/UYfcn73oBICrm5cUicLRdA/pLyKsB6GE1Nv4sV+G906lNBhwrG44?=
 =?us-ascii?Q?5WpGY5W042AB40SblsFa5VDwE6eH9yVEgPXmaJUFWFdeVAC9E6VKtmPIyrla?=
 =?us-ascii?Q?BIZxRY5dINY2enrAzXftgWCSpwYxW1fntlHdfnqA3I0szEWd/7qAZGVT8/Oi?=
 =?us-ascii?Q?QCkKW0SXOH646OWnPsi3lTViNZRQ0DzGMwAjdHM9TdGETs16GJcjWW2vWtOl?=
 =?us-ascii?Q?3hE0MQXm/VgQ5UBtPNr6zhbEaFfrPkDjy7oBIKDnMB7/4MyWE6t0O9Ip6zCG?=
 =?us-ascii?Q?t7mdRauRDtgp/pBvUrju/jDg2+FVKtnvE6rMzvix9+9QHBRAMBrtlPKT8crH?=
 =?us-ascii?Q?Kug+Z2Xtl3NAZuBYAzzoYuV3f01ex5mxpQcYquYT8bctQwSznK/epDoB2+K3?=
 =?us-ascii?Q?B3sXAEZNhsyA6yZkokmwXlar0JHVeawqjePV2NTPf5KMTydnCqwENu88rzOH?=
 =?us-ascii?Q?FY3P93AD7O+lTqeHZbaXLePe+hGgTHDvy5QRflU40tnrraw3yfkQ429VoNq6?=
 =?us-ascii?Q?lJgW2NMsoE+MG+PMSwegWWoTUTIO+WS5ZFJlT88ohOyiH29AdeGhq7e1wCOe?=
 =?us-ascii?Q?G/VlBQb20J9gnTQmcd7MCk6cp42+fU0Kfdw05S99Rwd2219f75fGuqkyWNwT?=
 =?us-ascii?Q?KxJt2U3pKmf5th0qkUdIJfEJ7/iGSXi0xTMxIGiEBNAkzNyakhsPR5AOVt+D?=
 =?us-ascii?Q?eN8aiowZdpP6Qumle0Z3udyyJXwxVAp+IV99xIClndwxtKFv1LHOxCvv4MV8?=
 =?us-ascii?Q?QmWLBLijfGbHqr2L3FYl3G94lAZtI0n2jWjbi9UljZa8xz5KX4OnwmDj3oyV?=
 =?us-ascii?Q?e0DlMOFDR0s1gX0lZJvJvCIxawd/NMkqcJa2xMS9VkW909XbXKuatEGtfTUW?=
 =?us-ascii?Q?33p5qFKeAVE7Wz7LyVT+fo/JwQHXvEepV33wULZSDIFk8tm++L2Jb4vP8v37?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab8643b-0713-4dc8-c734-08db26d3164d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:46.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSFa81SHk4wL7+mzUJsGAW15wDqNf6AlnaLZMIYBCj7yi3qt2TU4Itm/7/2Pmcq1GaJkwnnHY1tgHjbiIfLSFSBR2jI8ve/OAZ4tvHkjboE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ST IIS328DQ is an accelerometer sensor, which is compatible with
the already supported ST H3LIS331DL. So add the new compatible
with a fallback to the ST sensor binding.

Link: https://lore.kernel.org/linux-iio/2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com/
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index c6201976378f..5eb71b24a7cb 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -48,6 +48,9 @@ properties:
           - st,lsm330d-accel
           - st,lsm330dl-accel
           - st,lsm330dlc-accel
+      - items:
+          - const: st,iis328dq
+          - const: st,h3lis331dl-accel
       - description: Silan Accelerometers
         enum:
           - silan,sc7a20
-- 
2.17.1

