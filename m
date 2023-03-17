Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237ED6BE6DC
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCQKd6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCQKd5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:33:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA72CC42;
        Fri, 17 Mar 2023 03:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys99zSaafY8w02Zx8CTBFjHxDzs6rBYJyJ+zqWE1W53XeWraPMr7T+YTlRF7yNntsZ1BF1YM/on+2ioGP9KwD9iPKO5c6A0y6N7HynKiUGbPA6Ad91ggpcXzbR6MotX6SrAs5B27ZBYprH+dg39+borX6tQH/+yWOL1mu/BctEmeHiZ1KO6nutwBH2Pcy2NQnJlGKi4ypo2/NgmOuoWLkuLhO8Cuw/fmYpbBzMtQaSUhheNhPL6l4cAEBcq55ffLdA85jGjuPcwLMumnjlQP9jhbfXDOwP0so4lsZcOjqzFo0ui0s1HaacB+WA1IY6NgNC4MasS9ulbEu/XdrwqkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtjZ184xP4sUDld4v5sEvavh+sm1SVUsnjrJB7OS2Kw=;
 b=DzhOgyU2epc5uwI15UMOk0hAaP1HvOwtARlLbyFEO4897d784hbzIDqPcLb7ZvALnc59MbQJ4EGJ0KzFLxeIXGJbkjZgk6KwuW8xZOX8MllfaMP/6mNfCQyqsU22RHT+OnuKAY0yr1szXZq1RjZM76V1Xvic2+GbcxKwYgIGHKejmum92NsWrzW4vrgH9rchgD84XUGyrt6eTz3blOYrkylJNy5l9oRQRDR6ztSLTD719S3StHSechnhFkB7dalv+cBtEDkjpTHFrDIR/nNGVUl6OEo13wh9MG5fWXMsJN9FxL20MXCekUy0RRljQgcWLLL9wxprZA/EqdedFbb7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtjZ184xP4sUDld4v5sEvavh+sm1SVUsnjrJB7OS2Kw=;
 b=cQ7pxvUuPwcTgUIvKyETgmsrHgX/VCIwifv3JcwPjCUQ35moMoPJzVFtYF7Cutd4ypW0D8mEwlmKCV7JYMS0YZifyTsJC2wbzM6AKyL4qlAeSZCl/tlwAiV7e282h7NMaVeE8KmZbJmygERcxTBIeXMmv48NtH1jn0ru6xY3DC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:43 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:43 +0000
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
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH V2 2/8] dt-bindings: Add DS2482/DS2484 as trivial device
Date:   Fri, 17 Mar 2023 11:33:17 +0100
Message-Id: <20230317103323.7741-3-stefan.wahren@chargebyte.com>
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
X-MS-Office365-Filtering-Correlation-Id: b40ebc37-a6cd-49a4-22d7-08db26d314c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vn00X3g/+entfFxjDd4eMhgy3ToKx/ZGv3MC8zdUh3w+ItWyqAksTQUefaxCgdMFTLpxeSvqroA/N5f6teSfTY1ndT36D3t6v5+AlC3ehT+J8hSo5GpnaDMzL6t+JQnlX/3vdqDJQD+09p2Gm0Pj3hLYXGREuc2as0y3BzKmUyqf1tQZBRnNfoHzwn6IxJvm92pyAMTYaKJKCrlgQo+mmxdlMIti1h9C5XdUXhIRnGhAHNJsfThDLNwBVKj8BhD57pkZyXPNqGRwzorzHaUMA3nTTRPwUyOuGZVf98meAzjdU2IXKiysuxmdiGFa5wVibi5irY7LNeN/w5yTx6xI/aHEuc0JoPc+gIAYQoM0903/Sl69ZFD3lKtWtrh93UeP8fi9fdEtmEKztNoekivy6zOj9iRCYQX2UIH1V2/vV/Ma5KD/tvp5SuD2dwSzvbY22iEeCTAzLNO2WUCMHAfa5Lp8imaxUie2uv6etlQ3fHSGFViunsCqG/5QHI8mMB7FIsryzUn+rcnC2gmVNaSfBW1hxaFpLdKhp1ikjMAQgBGw6Sm/QWG4ZscoU036FXiDaaKF6dwRHFi9ZEHM4xuWs1ZABPHh+mQ8hwh+Sxz2vichlLOIgIFQkQgt0SMDdOB0G3fRxLK6W3cub9w6+kjpxfjH9eGotl3XfA/CiZdhXFqPFluB2a3Yujq3NH5RBUit6Gvgiff2kuAdjap4z4M0Gzg+mjRjZA14lsmEk2fuzv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(4744005)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(52116002)(6506007)(6486002)(66476007)(2616005)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?498fyFzClZVNDuq9yPYw7525Zu+WrobbjspiyZDk1ic67AmMl1LJeLLghCWw?=
 =?us-ascii?Q?qSZBYqAamw3l9cxV/baYzcwOw1Gkec7Mv7eIwEVNqbEbGSpleF2jNpNbOCl2?=
 =?us-ascii?Q?klNOrmSudwq8HJzkMnd9fPS+YpelIV8u+grN06yUpjFJEI7J56KPUzkBj9oM?=
 =?us-ascii?Q?DSj49H/8byQpDIiKkL2tn2lsbsH/kCy7vaMYcluHxrVNLQo6K/sA7Zva6AJi?=
 =?us-ascii?Q?c9BLr26+o4b12QW3iOETH43tba1OPiZqDqA7kHFhJEzWk6bXwsJFNVdez2mn?=
 =?us-ascii?Q?NnaKoAyoa/cY//2i/J4S7MShEvFRkVW86YEd9mijE/FiRI+l5YGB3x9qWfHx?=
 =?us-ascii?Q?znaHmYCGTUN4AGS9JG8pCBcYjZuQ7ok/4mXS/yOhCHKdy2Xgii/tQjRclYQx?=
 =?us-ascii?Q?BtCS34VXwJGTKAU+KaS7ub4LApxChlxhfZ3IZ/+TF5S+bYWslcA1XsktmTKI?=
 =?us-ascii?Q?RmASK/kuGgcrhMtb10uAMzl1+6ZtjQTiFzQLAvtutgrXMxSQgN+uyq0rLW4y?=
 =?us-ascii?Q?8/cMK4c8Ud5sC57ZrTim31LoSf7p7k+7G1HZFytAaR/Ae8NMdpF9KYYu4hxb?=
 =?us-ascii?Q?i3po9bXI77R2neQlj3IKhSsamLRiQcesB5Qlpx+OHkE6S7Or6re1OVbCcIdM?=
 =?us-ascii?Q?q1RtMnM8chM/+izVCsjfjnwRxkmwMboRwtveDczFD3xHryoOiNb/C+hBZep4?=
 =?us-ascii?Q?zwRtYPsOoY8NWyjkAToIgvAPNqfSBCXVWuVQ0jqvOus6mhJJ1BPGKUyPN3M9?=
 =?us-ascii?Q?wpKFLRHW0XXrNHegBm0eWLEw+uYdAhP7uCjyTlPbr7Yi/6u+kAMhhrS3nAtR?=
 =?us-ascii?Q?R85sIxIRJHjgZoHFHjIaKHdwAZ+r1Rg+CCe6ELjhexYbzdalfou9zzhxdaVR?=
 =?us-ascii?Q?qJQsljtQ6lnEmvfkcBpNQKhijF2Wpir3QH1wOJVgdGNNo3i7i6djJ47JqSqD?=
 =?us-ascii?Q?dq7XvZu+GDOyzbojIp+pEdhXNU5j4fU1LOYZjrvIzPA1OxRV5bKCuryQp2lK?=
 =?us-ascii?Q?iTqb3hJx+HPuvC1beIgYzTwjcwWZo8jJbeTClIjqXtqTtvcAJmYQlT+Xvkr8?=
 =?us-ascii?Q?yhuk6NtNnS9YdG/ZuFNG06uvmU9vlPG1zhMsWRPTcRaiWbrIQzoULvQTHA2m?=
 =?us-ascii?Q?D0peQamLLA1XCOdTElcEoOCQl3IReSjPYh0C/BZGzwoD5qQkvVPJWrA884Nd?=
 =?us-ascii?Q?t+6m/wj/rpRyK8uP+D0FC9SormznwXZ3eF10dYfOHtbochDc7vHKsZbO6jbA?=
 =?us-ascii?Q?GJuvmJFzWdhcC0rqS3mIkBxvmwzbwXdd7fihtreae7gYxkrb8Zz4ZGivPxlU?=
 =?us-ascii?Q?giNhEYFJjN2orvHgEczLvHmpD9epagX7GjDLexJv/XPKWrFS4KtF/DuuXA5F?=
 =?us-ascii?Q?fn9mR6bRWuPmqSYzX0ErEbLJqP28CUpSQKLuCQCyMDvRjK3KBt03TwGDoLax?=
 =?us-ascii?Q?uugMcWIJ0Uy8lFZQKNzBuC2Eq215dWiTWx0qE4B+yq+t6Gcqu/6m73vEIRzy?=
 =?us-ascii?Q?Ve0NM3Urk2LwN8Qj/0TxvSpzZVxxpVnx7izoJdPGvkdaGrz18q9SmZ+fR1fi?=
 =?us-ascii?Q?vW45F/gGuqYNDfw6hV6JXnrhz1z2x22UqXVoKdUdxD0QR5Hcz0vne1X9eaS+?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40ebc37-a6cd-49a4-22d7-08db26d314c9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:43.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Dxi9i5ktyj/CkI2Wdp4khJ+N+DpDd7509pMc3DOzZSo8c5Cc5qpcOy03uMYwt0nWcDZOEokNIPbstnv76MZoBrsBpBeAihjVN+ElOfinhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Both chips are I2C to 1-wire bridges.

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..9b7b24989359 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -183,6 +183,10 @@ properties:
           - maxim,ds1803-050
             # 100 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-100
+            # I2C to 1-wire bridge
+          - maxim,ds2482
+            # I2C to 1-wire bridge
+          - maxim,ds2484
             # 10 kOhm digital potentiometer with I2C interface
           - maxim,ds3502
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-- 
2.17.1

