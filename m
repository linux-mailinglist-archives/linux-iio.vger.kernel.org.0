Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB756C25D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jul 2022 01:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiGHUTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jul 2022 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiGHUTG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2022 16:19:06 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 13:19:03 PDT
Received: from mx-relay97-hz1.antispameurope.com (mx-relay97-hz1.antispameurope.com [94.100.132.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B132EFC
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 13:19:03 -0700 (PDT)
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay97-hz1.antispameurope.com;
 Fri, 08 Jul 2022 22:17:57 +0200
Received: from EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 8 Jul 2022 22:17:49 +0200
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (2a00:1f08:4007:e035:172:18:35:1a) by smtp.eckelmann.de
 (2a00:1f08:4007:e035:172:18:35:5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9 via Frontend
 Transport; Fri, 8 Jul 2022 22:17:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xky6hHZcJfDUCRF/t09t/wsGCxo7xA85P+c2QaspRCZ2JUzwwq53TRmpPTMOIfCEMmF4Cp9xQ5I1vckWSWg3gcpQYniC3+/guz9QNTKoY59+/O7vcgOJzYAjdV7jD8lELCmAdNlW33k4NKSHOOsbm5vOsK4nR7Jh4UVFDI+dpJN7cLyqGqPt1X4sfc3poUTIiNrU0CzU9GghBySqCactIbPi4nh1VAtPZb3O8QYIWIvSZdUkMHfv0K11q0Duk3EBQq2yV3vVSyqTrtxZXwzVoOBxZYIAnnt+KRHB3dqIKQQ5BENmw2ytuHS52Ah8d8GvQ07kbVUJ9hQldYZ4LM4JYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBLnO9c0heAOoiEPKHPhEtpC7W70jy01CQbIR/uGdns=;
 b=lGX/ZDcQFjKEdHopfo0jxhqhrmwWMngdnWIKWmXOwlxuZ3nrYhn4sEcyQZtN6QsJcafUQI50zZ7MEAMSrcBaouaQNwPAuhpHPRt/mYTCnrbPHBsbgl35iQHsm73U6+g6q5SahbIhC97oItM1WMh/4ouWXuY4D4ziiUaUaAI5wX2Ye4LV1kVUv/Dj/6cYo/u/DKTBGESn9Hbc+faX0FynMDqILrGpXDupysPO0561DPWOb9zogIJTw2CJrz5C/i9xEnCMq9Q0jz/wwaCHjolkQsQyMCsOEP4Snl8cqJEHHuxz8bH7kLc5RIpMOAtDL8ury8NnQKQSNpdNu6vMdGO7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eckelmannde.onmicrosoft.com; s=selector1-eckelmannde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBLnO9c0heAOoiEPKHPhEtpC7W70jy01CQbIR/uGdns=;
 b=M5P04ExZUadMRuG6iEIfsEQccRBaF5xoAE1rIHU+01vp83Ar3vuCPDKzRl5FmsDTVQExu+a7H4dFkrAkAKnTe1PHhQg/lOF6IH1W799/VU0/3zUd8JXh4MpqDYETopdnzgIr8MMQYdhm0pp6ck0LzfStcNt0rHzTwuFK4NQVyWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2fc::15)
 by AS8P189MB2120.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:52c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Fri, 8 Jul
 2022 20:17:35 +0000
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::5dbd:b598:df28:90df]) by AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::5dbd:b598:df28:90df%2]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 20:17:35 +0000
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Thorsten Scherer <t.scherer@eckelmann.de>
Subject: [PATCH] iio: adc: ad7949: Fix error message
Date:   Fri,  8 Jul 2022 22:17:20 +0200
Message-Id: <20220708201720.16523-1-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0041.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::29) To AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:2fc::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e78a23c-3cd3-4a39-90cb-08da611ee526
X-MS-TrafficTypeDiagnostic: AS8P189MB2120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEq7cj5bTuik5fNmZRaL2Pndx8+DgYHpI7mVvmfskUx6FVRRmUox4QH9NQTMlx8eVSgnG4HtmbCrVueBA8lXQokSe+BKWJfNjGeaSukwjYFP+MifpzbMbkNIDT0wMnYbl5biAG7QmA74rPzEtMZrCoDUFCsRC2SyZgZpP3kMCSrrmbUnHgAScfTxE17As6hhcgktS+S9jFggNYeuRwFKAb2mZL3kdwlrxavPKxqddBeVpowQaRgFjk0FEqXBhLKrEh6GEqxMBSiintIs+LdXGHH88TY7mfAC1sDNU/N1c4ONHLfk8oS33esihcjOuohJusuN8mp8lcAkd1RYRDIj+gFL8WYA4z7ZXTjtaNUYgsKlovyoE8w+p3fWC5v1U8BgEJjTgH1KWpVDXJHIM+auqVV7iMndOsjSBPPQokmVrgDXFYTOFIgJGhlLt9l7dl+7IHmfOgXyarU31c80s+giNM8wfUneuCV8FgDvPJeEva1daxI+RoB/eYx7olTWCGr9+L88TFi0k8/Xj9KI/SPmU7jhuxDC/yDjpJ4OEq/Ryz1GXXWOPqfKp9LZRX3teV/dTq8tFRLu9cSmE6sgRB33iTtqmHWZY1y1/G5EB354Q0/eQHM42D5LeKVWC78T7crjELfDexhmM/6WFcT4xX0oTcZjWUIV1I0WUnycyq23M3AoyJoLZUtauEZi+aozIdh4gZSbikkFwYQP9s52DdhJ1atGPY9UUVxCey9M2PFntiOCfUJn8C9uqogwZuiFNG0G+wh3132uJywCMK8NIFm0uaA9ICAik/M6dGtzlimqIqlNz7YKoR0mJa4MKSxWi010
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1700.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(38350700002)(316002)(36756003)(86362001)(5660300002)(41300700001)(38100700002)(6666004)(4744005)(66556008)(4326008)(8676002)(66946007)(2906002)(66476007)(6506007)(6486002)(1076003)(107886003)(8936002)(52116002)(478600001)(83380400001)(186003)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiyz8p5l5Dmq5TbgVobbP/WnOgo52rlNk8/DNY0uh6t0ucoy3kqJzUPcJT7S?=
 =?us-ascii?Q?OsDhN4dg7ZXUbwS2LfgvaS2XJucdCFmWJ0a2t91hwidHsOtKySzrYE/yn1dy?=
 =?us-ascii?Q?xK4lusHG/aayzMlE4JkQh7zAOK4J3OxNImUHN5Co2AzeX3PgTvdNcFAf9TY9?=
 =?us-ascii?Q?3L0LWFjT1M2+XBTk9LMc/qUtNsrKu4o1yD3hq8YM80auJDwraxMZHdiOqdhk?=
 =?us-ascii?Q?oJUqGJX05mmQPRYtlgPbD92Hul9m1gGkNZT4dreo2Ny6K0mIraLUlpiAdwZC?=
 =?us-ascii?Q?/rmVQnhAsLoIsiUFMxZMF3GIaWcd8zEaDeRWq4SqkvcbMa3IS4794vF3m8Cw?=
 =?us-ascii?Q?0q4n98xcFXrBzAmpvwi2Z7m6Z41zRvPa6KVDOf5fxEAUk774Z50cTxCU/PFh?=
 =?us-ascii?Q?wCM/TDu4QguBE1gduj8c1XBo12BKjTRmjnp19sn27bhilBluIlJEuZT2yAun?=
 =?us-ascii?Q?uYC/JqTe1/RFrynvYWHVAdE35rXYiIKmU1GzdIdURr3s+8Z1FBmFQTEgav8w?=
 =?us-ascii?Q?FQ1mIVOXXXuknbM3ehIi8dIfQj3GYgBt6S+hIL3v1PtJzOaxjadTo8f7MfV2?=
 =?us-ascii?Q?7ixcW7vkJK3xDnKuVriQ/8ZTre3RbKFgjKq2FheNSIMfzJ8haTn3GYypz5br?=
 =?us-ascii?Q?bBy4qO0mwBifFB+sxRXBQX+1AsgM3D6Uf7oEKHAcLYEE6CSsU1ZMY3YPngAn?=
 =?us-ascii?Q?HWUtvxWpEEBM1JoGYxSTi9LmgFRKtzl/uDRL8j6kDra3+Ec+ri090nDRKp6B?=
 =?us-ascii?Q?/k7hpH7OfJEMuLq76Es4Fru7EwToq4AoQeKKriAV5tah+ZsmswXs9KS+0nA/?=
 =?us-ascii?Q?zmE3MOwXdLP3nox1AR5fy0OgNmutN5QblAv05Nroc88bbEL4U+g55dBHI52y?=
 =?us-ascii?Q?AnQHMX05z+zBHki5K0rZFZea15VSyg4YdIIYVqu5RuS3mHmkP8Hvr/wCoPaE?=
 =?us-ascii?Q?3h3wKg3cWCvMajfb/RBxO2Pdu2NP2xpdincAkxkU4+UxYQ7hpWdfA9N4fCjb?=
 =?us-ascii?Q?hJKSnudyGeIs4MdENlPUxOLNbQsTdhuuwQJ1oPmswpaKFSUhyVJniAmlZY4q?=
 =?us-ascii?Q?hnwZzEyICxu8Vy7RRYbJjHF7D+BCCRgKYEZaSuxOYfiikB/AtKheIDQ22JB6?=
 =?us-ascii?Q?/WHDu2kNV4cylWxZPGZRErH0DJRS789ol2JXODMG5sbLPDDYUWa1BgUpYXiv?=
 =?us-ascii?Q?z2zJZrdgHdKlsoxSpCt07ti58RDJDbK/v4xOuv5QL07dMa62hg8z5oxK9Ivk?=
 =?us-ascii?Q?JACoPu0W3Dh9UM1nyhvPOJUnnIPgyjRyG0FcrHASq95mh7TQ2Ct3ygeW+hRP?=
 =?us-ascii?Q?gZWkA5C1j2abKI5pJGXyHH42F70WIElss1yrVPpbxoYlWC1tbboDx3HW/n7v?=
 =?us-ascii?Q?iF2jV8ts1J/v6vZx+HrqJZF9uEHeFEYAxhJyB4SECpa35lQNnyPaYSUtCFsA?=
 =?us-ascii?Q?kU1BaH8/PSs9uAy4qZ3d5PZ4yaEf4/JE5FBq6KPIsk0DWuHzoTAlUi9uKn9s?=
 =?us-ascii?Q?xl8oP69B6ucC3n0DUppG59ctbjF1rFg7bO09hzuoDdHHqN5mAiTpFmIu5uID?=
 =?us-ascii?Q?WDwZKRE0yQ6EeVRnBbXfytzV0sFegZU5W5SRJnnDUuUmy0cQWsfL/Dx1y0av?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e78a23c-3cd3-4a39-90cb-08da611ee526
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 20:17:34.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ONy2HLZXlWiRuZHyO4oN015AifX2lSTwJqzDeoU/viWuJnQvveL9GzPJH8NJyj95fLfF0ZQB78xF8XgawIREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2120
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-iio@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay97-hz1.antispameurope.com with 965BADE0271
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security-Digest: 1d097f13639578a845dfd70f6c5aee2a
X-cloud-security: scantime:1.855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=from:to
        :cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=hse1; bh=Jt2D37N9GCgv+IoaWGQut7Rzk
        o8og3g8+mvpYaDvOlw=; b=h2XX2lfzBgxTb3D0IeFyqbocaNIyOtiZ9zaSGQrBF
        Tjr5mzBosR8tItlkYdcTfYcGkwiQr42vYfCI1n2zbBLvuZdz86sSTyoYh22M3p94
        9CEP358xLg9pa0lRmVnLxsGO/MF0jl9lW6M24cZiEenSHFKd/i8zhbvGZsmRtMzT
        ZKG9XCPdZRyBwqaohdIsZMeIstGZnS5BivvqfomZgExbrrzWGA+FkMiquwz9oJXc
        wApxluykd8lFI6q9y1AqkL+N7m6OM/WiJsRcaJrcUlrgrIHn/UdzKOr9+3K/sYxL
        587yYigneBiVfPyXYl3oxpXcT+m71e/OBpIHbcmrKLbfA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
---
 drivers/iio/adc/ad7949.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 44bb5fde83de..12fb5f9971db 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -400,7 +400,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 	ret = ad7949_spi_init(ad7949_adc);
 	if (ret) {
-		dev_err(dev, "enable to init this device: %d\n", ret);
+		dev_err(dev, "fail to init this device: %d\n", ret);
 		return ret;
 	}
 
-- 
2.30.2

