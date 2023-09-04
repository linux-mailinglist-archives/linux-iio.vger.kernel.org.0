Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB062791592
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbjIDKQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Sep 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjIDKQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 06:16:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F8DF
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 03:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXDeKYvYVqQuaygW7+YUqEM6nOy2X8j0UnWUjZzgELYpzUQnAQglqEdZwZ5AjDWQdAfWd3tVpqmcHImedGAslEMUtqSpfdPY4zY8YgKYm/YS2FPg7E3x6vNWAZmfDFUR6v/ZMA72r86w7zYMcFX9dyjvCkXs2xdeCLkUXVtx9fW1FgIZ6tRDjKldx1L0eLRJ4iQrryIQzBqnTaSGs0e/Npz1Zc2284Cq/jS4sSH0wXwpcOqfn5mnYsJmrqi3Aw7MgQh9qEbJoObiZeiL+NQACN/gXUfpxcyi8an40MwaK/FtmgvcPyy7eH1N+YFNkOAxEsHpvGD34F8NjiL1qYPh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah/3Q/PpLxroz+WrS3FhRCa7kP+fELQtTNPOFz7DJvM=;
 b=P8OryN3fn0eMKyxfq9xwt2GLvWW4fJgBEibdKzQ0MF2g7GU6e39nQ+CoeXk5LbR1X1FhlRDEfPR3MUxQjLjp3+rdojAOjsv6svKxU6wJyasJkT+BYcF0qqa2CWyx8gT7vMbcKqrg0O5cSO06EW+zBTrjUccEGSgSKCgZWsHFnqkjoOsOMn+zSlSIr2GwoCb3rDC+xqVA7DqsCWSkIJsMAmfuRdXzs36uXFYjSqFfAtiU5BujFIBw53dArnMrzGw+dZRCY/bgAd30sDsErtadJfS+IXOLFtNBXHV3J7hzRV93Mx+e5+gE4qVvkdNd9P5p8TdTAGL2XWJn641rIqxSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah/3Q/PpLxroz+WrS3FhRCa7kP+fELQtTNPOFz7DJvM=;
 b=sfHkhRm6YKVwKyxrdrbGChMa7rgph5kCLcSnYsYdB81UqZlhGNpfYuar863zFPFHGJp31egs7uGJGFFyVUf8c5TT/dtnkd3AQXiXzn8Yt6XhFRaxPHKOMOoV1f90QRfmBCEp1uxo2LVHTMIzECMkfqhTpNq2holENavypfPwTGps587TDUvJ4nbVHdQnlnsFvImRV+zAw4TY6Sm8z7yHg9PCVUMWxL5lavRya2AUsFcN3AndrM96/I8IwKzo8S8SmZTK7ZSKiz9nuiwEBirpF527rt1Eb4WBMN6RHjlrQPz8LrF/gCcy2IEKMAYAQ/bj2GczRFg9paGmmZjMG5hwqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by PAWPR06MB8642.eurprd06.prod.outlook.com (2603:10a6:102:391::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 10:16:12 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 10:16:11 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com, u.kleine-koenig@pengutronix.de,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH] iio: adc: ti-ads1015: support deferred probe
Date:   Mon,  4 Sep 2023 13:15:22 +0300
Message-ID: <20230904101533.455896-1-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::11) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3625:EE_|PAWPR06MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: a6100482-2071-4d2a-0e18-08dbad2ff692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj9IUdSiDWA8wDj+rN0sSbthGOHPn9lNPfxjpccEyh/Hqa35tMlKrWxOpSqOyByi1Yi8df6nyKPt21jUokVbE8O22pgCk7x80eu5j3EWAErytyFmzewsEahq0b21foDwTxuTbqxxrBp6KwsYrCMrthrtYxIGt35ftovB+um3qA1O1lyVrrruAEaqzxfhlSOyZJGIvThzCtVdCKNtDlsslLPtlI8Vdnn8x1SyLP7VDMxuU74FKhaWsezkRFoZ7DfWTIwNdscvCoLYc/+VwNEVIuQwsUsvPfyGcNaLrtyleS+LCMZEkgDJ+0497Ubj/KYR3ijvlbbzJ55d/yUr0jwRfZWx31Vf91MjE0OwQ7+baCKiSHc26uRHL57Nz5MXkS18b7aQe0bna/D84IXDXZQR9w2I4dwI0Kcz3cBPpfqAJz50neN6vRFlVm9DVPULGBY380atxLnzViW0qDhsQ3/K2YMOLmSkL0o+nCgMkwvTzV6cP0Z7IklkShu6HIUWvuu82CMGd3zSNvvkC+i8HbST1sji7KwO/OgvRVyD5idX11qUCMzLDA6k+AMRN+10vLSnmYxu8Xurs2yyTtHtLnMAViq6Pkx3G/KcJwltlCowaAT87aWfo1+yYGIW7A1tn8Ga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(136003)(366004)(346002)(451199024)(186009)(1800799009)(66476007)(66556008)(316002)(6916009)(36756003)(2906002)(66946007)(86362001)(5660300002)(44832011)(8936002)(8676002)(4326008)(41300700001)(1076003)(6512007)(2616005)(83380400001)(38100700002)(107886003)(26005)(38350700002)(478600001)(6666004)(6506007)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ROsgVjoLYkWkXgcVxtEsvK37US8y1lmPCIg672Y84O3YszCj38S7yHvnk/m4?=
 =?us-ascii?Q?Q2pMeUqNV2YWuDIGh57a06Y09mjoENBhCAnJfl588xEp8061N7+f/5kP+/y3?=
 =?us-ascii?Q?mJ6SDQpJIxankHVUVT6okUeLXU075QXS/QgPS3tT/Lm9UJP0rnGrPomIsmh6?=
 =?us-ascii?Q?sZIBowKyiaV4TxYCq/4uzpQYvcprOeCsJnruqW8+uDW1d007ebNokHpAuGxn?=
 =?us-ascii?Q?wbeHkeZp/z9UuwgwZw/LXXL7+HHPbV5UZx7JUYTPBrHT4rIL/ci4CjQHXgSF?=
 =?us-ascii?Q?eNWUKTU6raT3TUdJEqtWn1LFkSBZX5t3OggNlNLMMJMwoaRuvpntb5rBJ2RJ?=
 =?us-ascii?Q?2jGzwEMcT3+FgSHKpI2Dve2cxP9ruuQ/hyx1X09XLKKptafb0wJebPOJ5zrU?=
 =?us-ascii?Q?A7yAqXdchWJEa4EVqIQ29oxn4ErXhBF8oH8QaniYFgZzixCwwQzS+zdcz8zR?=
 =?us-ascii?Q?0qbWFM68kYM3rbiGw2SLkXNW2+hOJ/Rxb4JciYU4psnGzZeHGgccw18Yv7az?=
 =?us-ascii?Q?41YmOlebK1SIW9VCumyrQaSaMzXO+avUqW7Ai7tthNJ5t/K3s6Tki4EMeVnH?=
 =?us-ascii?Q?TDCooakOMdTGaEDWzQ7joamO55thTksi5zU7Wto+bGCG0sqVVX4iS+A3rV01?=
 =?us-ascii?Q?OUMUJWSNWyCGIP73sMM/QRhfeWD/A/ZwwAf8UVxC19Pw/mcV4C+s0WgUExg/?=
 =?us-ascii?Q?VeLTH+LUN3yhiKvpriGXkRd4RWnI6xZWR9gwK9bUwp4dQP9bo0ZKRxG8JRs5?=
 =?us-ascii?Q?pVhfhrxIpnpY/LB4kpXjhDHJr3cuiUozXWxSt0y1xl54/48awy63hgobEz7O?=
 =?us-ascii?Q?b8mRdP31zXXnNzCIyVd0F4b8qfRR/dNbBfB3FQEVvJ7G4oeYrsBhbll037Eg?=
 =?us-ascii?Q?IDt/j/8QafoeeXSnYeqWFLuTWkyyWDfd142aA/gKfRVQX1R6LiqB13duBYlc?=
 =?us-ascii?Q?wewwdK96Ik9+MUsOTGQkdjTf173gi4cpv9kUO+dYagzRZ7Dr0R6SOPkrhiVj?=
 =?us-ascii?Q?EdkAf6VgLr0sCrHnRpXX9GTdEaA/hDt2b1+FrSCn5t7QUbwi/rspjOGPgh0t?=
 =?us-ascii?Q?fKRAIyv5+t9Y1mU1+gCYvcM79lWWfEDO+Rh1Kh113zaxptCWR2XX7+DWQ26y?=
 =?us-ascii?Q?6njUyUZQ8/ezept+AZvcxuP2iXfmGmSXZmtM50W0+fGs/ozC1kal4oa5IIxX?=
 =?us-ascii?Q?Gl87mPrKmb7ndjilXlQyI6LMLxMhrJupqE0pJCiBdEAsDfTycESnLaoyJIXF?=
 =?us-ascii?Q?gSZXjEqHP9MBZAtyPuuHIOffiRNjhXo1fhxRVO82oSZF1KSuIAC6VV3RT3aH?=
 =?us-ascii?Q?t5VqaFBEKoQOgCtJ7wB+8b1d0BaPFe7706oADzmcEKyDmfQ7YIUSUUe6CuVR?=
 =?us-ascii?Q?SIxOq20vfTs3seub6FxA2nB3hNPNpKjhFx+wo8y5wSnp4J0nkJY3+crW7iIJ?=
 =?us-ascii?Q?dQQu/hTs3QY2vTe3d0ARx7Jn7eV+004uamvZMnBOq491UzjMn/SMgnfXmED6?=
 =?us-ascii?Q?xATbsGxDzbNjfG2Y5p+51q46x0mvkrVEE0LWCCU4MT2fkpCot7UMCZ+HzSPj?=
 =?us-ascii?Q?nYUgeLnZBB8W0wqzV3lNIq9Xnc4HLuYwPQTCULrfUX3rRrREpMACXSncbbki?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6100482-2071-4d2a-0e18-08dbad2ff692
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 10:16:11.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4MiEopL20Da767+KqkrqhlbXcxK9UtRWKQUnAW8mWHtcgmLw/ypqDZ8/ZpkE/0NqfcARVPu1cyifFqFpEG5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support deferred probe for cases where communication on
i2c bus fails. These failures could happen for a variety of
reasons including bus arbitration error or power failure.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ti-ads1015.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 075c75a87544..f7dfcb894408 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1062,7 +1062,7 @@ static int ads1015_probe(struct i2c_client *client)
 		ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
 					cfg_comp_mask, cfg_comp);
 		if (ret)
-			return ret;
+			goto out;
 
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, ads1015_event_handler,
@@ -1074,7 +1074,7 @@ static int ads1015_probe(struct i2c_client *client)
 
 	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
 	if (ret)
-		return ret;
+		goto out;
 
 	data->conv_invalid = true;
 
@@ -1092,6 +1092,11 @@ static int ads1015_probe(struct i2c_client *client)
 	}
 
 	return 0;
+
+out:
+	if ((ret == -EAGAIN) || (ret == -ENXIO))
+		return -EPROBE_DEFER;
+	return ret;
 }
 
 static void ads1015_remove(struct i2c_client *client)
-- 
2.39.2

