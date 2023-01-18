Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF366715E8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 09:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjARINb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 03:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjARIMh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 03:12:37 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1b::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6D4FC23
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 23:42:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipdVNV6uzQLG02vP3GskXLxLDvvJ8sQnoi0QBRM6MNByX/Ry3WrCe1xE1vJYtgEauoOi3PuTWUg7d6QmDz4ebdszket8Fxj/GnUWo9o7G1lLx3+E5L/5aWSED4wORbsAnV/gfmLKigj99RnKYajLSKUTUbqtV9qmJi9BMLpFJCYOLJOEvXKwi4flry6bi7DmNSdBHtX5kgoAfkYZYn1SCGOjm/C2ImlAr3PWz/NW3AUQkA2VD8wla9QMFCSLJsISEwMX+wypapg94TF1InzFIV/VC8/xEav0b4kXzb/SwQvok2TmH+X8Qjf1ktJdsFITeJDbxNs2UlNDN8kQUCCgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaQ6Z4kjhgl6Z5dhPt8y5UIOK52Cx2jW3pX6EuOCwR8=;
 b=nZr9csCOa9EGI5NvsIlyspQAwyBmY9nPBdefPOAEzy97Omzr0zkJjlG1HEvbmneG8WJ7hlCJnc9TK2STgYSZt+h/Ikksh9RBxB9wDYXnt0VbkGBG7btsVNtctzIWHCt6uLECxi7s/T8pvefFHauBc6xsZ8u0UJnuEfbftGko3G3Fxqv5IGclhQoxE/hFttcdrG1PRUIRQjoucQyRX0D2BmridVSY/z+ZsE/7wbDpatc7Bk4tZMvS0yz52XGNRlrkKlINqr38NWn7mVUrksWLJebyJ3sXVd1PQaeKg8htCY4ZWl4aWrMf+nvalLXlfffKNS0ACq0vAjw00ozOvuSDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaQ6Z4kjhgl6Z5dhPt8y5UIOK52Cx2jW3pX6EuOCwR8=;
 b=pE8zLiQzShsyMkKQijlzHLIg63Davar4RhVrl4lFR9O1y4m+5SBZb4YrYI5VjWZTgKSOHVf/AyBZ1MY6DRJLrLyvwOEUmnM051VhwISpSsjAe/RBl3Pf3Ky6P6BlD1TejOH3JBF98eqbZSTbYa8KpVGXh7TgsmJReFTGR2am0ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:42:05 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 07:42:05 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 2/4] iio: imu: fxos8700: fix failed initialization ODR mode assignment
Date:   Wed, 18 Jan 2023 15:42:25 +0800
Message-Id: <20230118074227.1665098-3-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118074227.1665098-1-carlos.song@nxp.com>
References: <20230118074227.1665098-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: a480c1b0-db08-4c40-4f01-08daf9277ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfujMuklxlgkZo1MDfheEaYbjr0423ZmSM/JJMspxLSogMuqchlRSdBq+UvnT06ZVV96VfaCd8ALTZ9o5yyC46NESKIIQwm0XaIfyq4LohA+oRcFXIg7OGgkxVw6qYTEaGS9EpCeyWXJzHS1xq8GGVqeYjmCv/nPKp+E6MIBNKcl5aW6JOnvHGMddn9M+2HTqbbd6dOaoL/d09ab6JOzSDWXN6LLJu5PdMqJxaC8TYOeMS67fu1xT9Igz4FUrxlEyg0ThtSGXZnuhFg7UwSfE7qT2MZZYsERspR4+eRM59h2ffIyQJwdSgzLX0g+qugRbdnuGUJZgzQCOmzZKspVfoxtoC7bLjSlb7Js3M0AVFRd/GsPO217OCk7XC1H04BRoiq4ZxF1kcvkqO/TiQC3FB9NZVkLQ++fNfRqoutx+78/XkKmz5WkDb2kxBG0u5HmJckhdlF7Xg7ZfbFTXrpr/7vd5tZvyFnvOr4z7ifyN0a8MMKZyK66+q3yziXq6ligxq9LgsFu3YtreyKj3BlO39X6fSE8jJaRWaLIhhT5k+yiGXKqyOCKoLjpjfSEa1RHrAVG6t6srMvv6MWyAKl7dLgsJZx879NoAP1cmslZwaZBuxZvYhk+92TFekhO69MrejcAtF54z3qGevPsNc6YU2e78zLaVUdbRvKpuom/QsofdJkUC++42kkbglUkgLjxpHmBx40W98k3tIfTzVibOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(38350700002)(38100700002)(8936002)(5660300002)(2906002)(66556008)(66476007)(66946007)(8676002)(4326008)(41300700001)(2616005)(1076003)(186003)(83380400001)(9686003)(6512007)(26005)(316002)(52116002)(6666004)(36756003)(478600001)(6486002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OI67xCxhYytsS0HULU+qSTNZxHYwbYWizgS7HoR+9+IqWa8rDv2LDyaNuFua?=
 =?us-ascii?Q?tfaiqEDABCVeIeOKEFW5jCs7q0z5RjbyrF4mjAUvNNtMvesn+WRPicfH5neQ?=
 =?us-ascii?Q?sZALYkg130eeoO3UQM8KkvtBzDDWBmBYJnnmBgipif1U766hf/9Lzw+/iS8B?=
 =?us-ascii?Q?fXuZAdv24cWKJNEdHpyFPSAILBAGBEptAWKm0K5zDvLUbyKoUTvGokUnKcUo?=
 =?us-ascii?Q?eB32HFX7iBuSM6YLAgMz/k8E+sItRmo4aGiBFyp0WQGylhfZ84mGLMY945i8?=
 =?us-ascii?Q?+vDSR9K+W10CDbepxRwgiRO7y2jFWzDBLg10RymVLpzhAJ5qoPj8O4rHI+Q+?=
 =?us-ascii?Q?qH1kEGZBIkLK4RAK4r9k/Kc1wa29R4vzBGlJDQKwYkiMe5wspthYjdIoM4hf?=
 =?us-ascii?Q?G9F7ptFvHu5MSqF0f+7eKX9gpBYN+Q/E6UG4BYb3faCOZTS1E5qNv7ZA3PoW?=
 =?us-ascii?Q?1O2f6/ApWjt8mW3+l95q+CczTi1ZY/Y86pMWkBFg5YzU5tcWwW/ZHY0dLSPO?=
 =?us-ascii?Q?2PV2HSJD6iCa3q0ukNXrgUTNbqjl1fIkX5PlLMTeCMnsA2jzzCOKEqjDm4QK?=
 =?us-ascii?Q?+h3APu2Rb0zZ1DjOo17UVHaALbn1pbTrUngRy0wHx7JLFaRqA5BlmsY6Hc3A?=
 =?us-ascii?Q?NbzO15anyJxrvPiRf8OLhpvjspPkVHYy6S6LUKhsSsgpOiMd5Ld6weJFSgxv?=
 =?us-ascii?Q?7a5CLvYk2JjVmriBdAOhqSWbfHWnvURhN7kFFeRsC7oOwzSYUEiKuL916Fah?=
 =?us-ascii?Q?fB1DUcJtYsM3OzxlCVd57xeM0FlYGZ/FnvAczFA492de0Anu2r3y/obNxChM?=
 =?us-ascii?Q?UTLYONFw2vRN/DVLwCqkp4uDO9IKK57mk73AznYN2Rp7m1bXHRmeCbuveI0Y?=
 =?us-ascii?Q?sWMk9qbi+ErI2V92QR4bW3BCrtJo2XxYIev7zHgy6B3EwHqR0UGw37RMUEZZ?=
 =?us-ascii?Q?u2zgkTQlWKj5GLTuLvoAJKGOSYgZjSEckyHRpa/l9PafZCmV1gwaqc4B7KWc?=
 =?us-ascii?Q?iNAb+hJG/EmDTWfGauoE6arT2Qdm4StbFwkL65fz9R0GaOWyFTNR1qL+2gzF?=
 =?us-ascii?Q?V1VmQC00m6ojqkosYQWaK0u4SAz2iKBka0GP9n+TTNbCPD4ICv4LSfx2V9+n?=
 =?us-ascii?Q?OaybPC0b3aykqL7FeEOEuGYzp+M53llstFZwPR+bsPsWIOi9yMdVuwdoK5T7?=
 =?us-ascii?Q?3qPRpNdhWE1YK7byhwFylLZq8e9ZXaCT/cfVOwwtdViRcijw6YTRCg1xQeYP?=
 =?us-ascii?Q?M6edPszAig9wdKHWx2FyWEOm/aLzg6hn3+cTAxSzteDGYJkUj4aTQo36jeOq?=
 =?us-ascii?Q?z8RLcQ8c/ydaBMYFO+jaNMjZZAAPlZ8HUrj1EcANCemfHe+WIouJV0lcnk0d?=
 =?us-ascii?Q?fwWsIV0Q/xleE4ccT1owUq8qqhvGC6PV7ekBfh/QVSx9vP8T9KGa7G3MWDyh?=
 =?us-ascii?Q?dY6aY7NAFqYYkCpB9psHdB9bhh2T1Xjdwt0fK8GTkEgQkz3GIufZIe4m6AQq?=
 =?us-ascii?Q?DYTshNpXzvbF+EnxN7hkO1HUHSIMi01IgjnmrWtu/FYw3BAhPhoQE+gBeSGj?=
 =?us-ascii?Q?+LOr8420oKmB6dzdFcKcsBJCHTSBMLMu8DNIuMHb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a480c1b0-db08-4c40-4f01-08daf9277ea0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:42:05.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CtKhOoEvIjU4C8AahDVQAjU3VOj90yl14oWiZ/nC3/cBNDsVp8UZerzbIF4vOtpOCaMmLWUm4mZ0/oCIS+j8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

The absence of correct offset leads a failed initialization ODR mode
assignment.

Select MAX ODR mode as the initialization ODR mode by field mask and
FIELD_PREP.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Changes for V5:
- Use regmap_update_bits instead of regmap_get and regmap_write for
  a good readability.
Changes for V4:
- None
Changes for V3:
- Legal use of FIELD_PREP() and field mask to select initialization
  ODR mode
- Rework commit log
---
 drivers/iio/imu/fxos8700_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 419039d3fe86..12433343807a 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -664,8 +664,10 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
 		return ret;
 
 	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
-	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
-			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
+	return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
+				FXOS8700_CTRL_ODR_MSK | FXOS8700_ACTIVE,
+				FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) |
+				FXOS8700_ACTIVE);
 }
 
 static void fxos8700_chip_uninit(void *data)
-- 
2.34.1

