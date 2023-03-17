Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385876BE6DE
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCQKeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCQKeI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:34:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B737B58;
        Fri, 17 Mar 2023 03:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUpTiTdzANd0G61Rn0+fQ/9+5hFBDAPtLg2m/nENpp0qvEdGPw2iX/35yY8MGCgsxs2WP9QLUr3R0ELGtHozNOFByPy0e73Us/PhMu9oPEAU91S0TnqZGIKMKw5VkVjsYKcjBV7DzZMCpxaOJqbT28FK1RAQqATmKGd+Vy7tVC5UHGYIOSur+DE2jPN1wTi2pBXCaNyC5RQ1Ifym+GQdeR1vWUPFETL7wUkdVrte+/bJEocBSxbzG8c5Y1k08C2JokSuyoMAuFwNyfGhCIE5vwDEr9E0H8J30s7ms1arm7zpUZZWe3EzCVEKIm3UMDCyN82HwP1CqmJfcomeSU73tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgHBfWanPZkt+c9wiByfId/wRP/Fan5Nmk+IK/0rPwI=;
 b=BX7aZ75xJ0L+1pwKLyihBbnT7dF88xffBs1FAMHgWWSCuY+WiznIi7I5jubG3/6A9q27KtzYcIwsvyn/WxV13IVyBtKyuccg9ZB6m+g0oFrPcbu3x1VrX+gN9oV2A5L8k7gS8aT1aYqBFzAOoiUfNMfb6X3XyzlexOmECDkL6r6ahJyPD8KyNHJ7Ti2thFMVfBFnUGyjXfNoBYMROhwJfauIpHP6aMlUFZelglCWBGwfcgjwTxoV91pTNOijdrfaorT4CbKtpNOLMCZplODLuGw0/3RhntTFy5I7xga8GQT5k+gzv/KCV93B+G2B5H47oNVTSXy+eF4dNH1e1ux1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgHBfWanPZkt+c9wiByfId/wRP/Fan5Nmk+IK/0rPwI=;
 b=IuVJaIoYLPSjJKbRRejufhy+tVIlR7g+m7aaCRWJP0N60cyleGqIJ9h/cqNBadme+NqMs3cMC/P+4ef1gxlprZ3BZasuCfFP0PoZj6HmzqM0GocwbbwJYBv+O9+mDmav17srLPfGQVvdMjn1mcrcSHcLyJe67zlIiCSvmHMc/Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:44 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:44 +0000
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
Subject: [PATCH V2 3/8] w1: ds2482: add i2c id for DS2484
Date:   Fri, 17 Mar 2023 11:33:18 +0100
Message-Id: <20230317103323.7741-4-stefan.wahren@chargebyte.com>
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
X-MS-Office365-Filtering-Correlation-Id: a4d9dcb3-7392-4d72-6cde-08db26d3158a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hbJX3qHVSv/rPs3SMpvrw9RXqJmv8i9+WstYOJTR4n6rl7jysdMqdjkXbAF0h+ycSLtZ+pjfOoWCdy5oWufPH7oPqZcqmWDC7TkrIWTyWk6MiEJVfJJnKafbSBjpCbTcldZVqxwMT4vlUBuJri0xF9j+jZjqF+E/MWyvTVi/4FCrxGarxKd68Wl1Mf+ceqGh/phTI6IFxypfWtSB/pZLIpcSQ6FuVDs7LnGVIfcr0xq542zGJemDgfKoBmPAh0Ai6CD0161VuAjDz2WWsBANDSSyzYSsHcEswTbF9lyiNi0No7VELxYLtLnUj0VyarS8989SGulEz+7BzaazOhAj0V8QfEGZvWpOY5jp3F0MqjB35eXG0fHU1RVE+MQxxR1QpO41pybsdRq2k3bkQ+tkDzzakkuP8RufrfYjwq5p2sga/v54wc8E52LmGSEzPSMYeCJgJgWpdhwMZxuehsWAnBFi0Ope9QQSMI8UdiRVF1asoGqEEEt8syOlfuIwuPpi4PMF9uRJC5GxZYeDul/Gfg6S/ULXFOzvgeyAtZMMAcBOp2a3dfT0rK07LAR3Wp0QQxufvb0ZXPCb8ir9++COozK7wrNiQq/1ovPzUN3Jy4km35hAqOybSsfZdwkSXEEe/WCi/UvcYODs7JpSeA852r0bS3V5IgXZqtyoeXlPCGQugmOI2SrSr+2qBPg6QEyR7Cv2TF680ZOR9mFt1xb1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(4744005)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(52116002)(6506007)(6486002)(966005)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lss4vaAh5+MCHI142dDESsxkAAeCZ+ABWY1p312gST3uwujGyuUWpr47HWn1?=
 =?us-ascii?Q?px2bgVkTuVxAtI4B8KvFbU53oVVHem4MtEax7vuL1Gm0hRjRB2/XEv+4K8/4?=
 =?us-ascii?Q?vwpdhSYvXGn5hoT1IL4CdkF1MGJr1CF6SM92XqdHX/qu5f4/ZH95WPQvnQFS?=
 =?us-ascii?Q?lHUH3JaQTvH2GzpQeOZymRYc7AGGePQI2+FzOf6FwE5eEDS3JSXcmdKCF8+N?=
 =?us-ascii?Q?NvgUZ/kR6xov/ZBCWqVDQbaOswdTXTzSTN59bKYn8SgFcMYinXz063s8bR6n?=
 =?us-ascii?Q?9b3ODG+Rx1++Bq0+Tsvkn1sRKbUTYGkrOObr/pmGMf3KWpsL4q5TSxSLygoO?=
 =?us-ascii?Q?5lyRJaPocI4q21+B8XSGOp5r8pPZ6vI7o23RBfQH+s9NZRoLmvTRwhwPokr9?=
 =?us-ascii?Q?wRH4krM77BXS8e9SIhBa7Hw5CuxHQ9ueeIW8txG5FOWs8SCYXZ6OTqzQfAH6?=
 =?us-ascii?Q?InntukavaAO8NUB4lrsWCzR32TDr6luwDoTo4+ZltnzAm/spYIAXeeOZqvmg?=
 =?us-ascii?Q?3eQSF0+/dA9/Wi/WY8Hq6I88PkvX0sME1uTHtg9t5vvqMZ+tO88VpBvsgc1p?=
 =?us-ascii?Q?0x/EHtWL+bdH7Qq0BQbRUTxvHl22ySKCChZS7yH1KwLMgwmBOVJRv6CbvLCr?=
 =?us-ascii?Q?esXeb3NSt0PoVg5Ooaou6dES0sl1zhw/p6sKNmiXg5jIVFB8an0ekVoX+4ba?=
 =?us-ascii?Q?RJErFjl3dOq0N4JzdQPIGgcXvxFcCj4qbZHPrEotQtfiKY3WVHqSMxIlARvc?=
 =?us-ascii?Q?b23NksYamDrarlsP6dBldyJ+sgxjqRMQ/qK58svFvL80i6uOSPj47nZs1Vbj?=
 =?us-ascii?Q?o/fiq+TSbUDiIQZKXh3AGq/95Ga6gEjMM3bHu6uF4JsOLn6K2anjUmrvZq7W?=
 =?us-ascii?Q?XyFKmzvblUTdbpDph1smE1Fk1628v+cpZdiflMMKRGCMwwWZ//Tyc0GoFRCa?=
 =?us-ascii?Q?rPBVwhU03XTKoNOwltezBd1oCTWg3g39tJOkTIBvhS3AdWNdRVHcg1jmErpL?=
 =?us-ascii?Q?W2aY0cp4ekArDCWEleaNhB7Pv+zygAuQka94jpKZpvOOZdl7YVCzu3da+kvo?=
 =?us-ascii?Q?gazgMEvmJKiH+wtgmw56QkMhXir+2+plOEuvOJAWN67zubfn0NWH5I1TTEGe?=
 =?us-ascii?Q?5quMuThxhoquI77rHTPOLNpmWzfBATC3L//tU8sKD5Ee9vsMpYGzNTxe8k92?=
 =?us-ascii?Q?6iomhYAscqE9V2xZ/CC9jzLZEcS6g0LSpCS12oyid4siPj8VezDl0GOLy8D4?=
 =?us-ascii?Q?/Q9qa5hTTy57UxOhBaPlaDIMoOQmxbZF2bNMgdUJBmUfWB63sVU3+pmWO9LN?=
 =?us-ascii?Q?vS/UGqu3FkQD2m1q3o+0EKimQfDi3aHzSE152xY/Vvh8KYr1XYQ9VGnC38dJ?=
 =?us-ascii?Q?WtAmMOYMmnDBRJmI3BSv7OVIRIgGzWvvoqqqfS/WVOZ5cbbdmG0siqv8HC9I?=
 =?us-ascii?Q?KEQVtd93IsdxKKRIrNzvrezXoi0Zp7bqJVJpiqqgUp6jUf8ps0aSyJWbe+y1?=
 =?us-ascii?Q?Bv4zpVnwHR1DLTudPr2p3ivYkq+lddlkg1Dmm/Y0f+OmNYIyPs0zVOkMFqW4?=
 =?us-ascii?Q?H80z+9yzCCAU0fvtkOrVGGCkFlUk+PYCxNrbX8hPL9sv8CqTFcd++wKjNRP+?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d9dcb3-7392-4d72-6cde-08db26d3158a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:44.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fG1s7BZbDmsmEnlvXf0UnlLzBTMfDtNyasMuCpoPx/VRUbsTBuXs9WQGGhkE4VQ98OHmY61FtWrWn3QGt9kQidO8+thDyHTMcx3mOv+rLkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The DS2484 is compatible to the DS2482-100, but also supports a
pin-controlled power-saving sleep mode.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/DS2484.pdf
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
---
 drivers/w1/masters/ds2482.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 62c44616d8a9..6f6df686e9ad 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -545,6 +545,7 @@ static void ds2482_remove(struct i2c_client *client)
  */
 static const struct i2c_device_id ds2482_id[] = {
 	{ "ds2482", 0 },
+	{ "ds2484", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds2482_id);
-- 
2.17.1

