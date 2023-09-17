Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEA7A3EDC
	for <lists+linux-iio@lfdr.de>; Mon, 18 Sep 2023 01:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjIQXwr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Sep 2023 19:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjIQXwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2023 19:52:35 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2122.outbound.protection.outlook.com [40.107.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D90126
        for <linux-iio@vger.kernel.org>; Sun, 17 Sep 2023 16:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy35X9ITFAFL7/O90ZgFOJQtTn9VzzTEITyNcvNCe4OETQpNQ1juWnVoq0y019Lp/WUIZ693Jk7qfwZVGr5YIj3/PWGkQHi7We60q9uY1Twh8wCto6NkRMCjVcYPT6xcawgQ1LTa1Z/Gdvw6AVnwqvPbBhvADrFLUDlDRfVq0oJVwhqPEfHydI0CIvS/070FGsxgk6LpmqwMG1diYM8vT4tnSiuc573jTjU1qTetvaFquSkX1ftAyu//EqF0YOO4J99PgtPe3310Mk9tQhccgRqXKSMs9tQrEdzHkwrZ2ycGiVHACV2ybPv9NRUqo012zISSS0aHvHBuJabM0XxVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpmA8+7s1uvPIwfTpLV7VHBEpyDpgpjmuMWMgNi/j+M=;
 b=KTMLbnnAWaHnQixg3Uouhjq1SoBIN93ley83jGW+nMc6LKRmvH6Kh0a5Fm6hlXD+LRIJun65rzSTyeee2UOGAe8aCarj2YFgF2XPSkkYHFLiNmN7y1ChD8nP197GmW57YJz08ax+0QB5JaxlB7qZ3QFvXAOPLXP1HsRY0l4JUuJY/l0YsT1SP5WTpKMcQfg7gEpFhTNgzEqf9fukk8I59wqlFpoxvBVS35TOUBRiVmTg48kY0+il1C6UU2ZWBIGPfsFRbHvLQwAz0h9rnKDp/03UtzX+F+7PF6zLwtRq/JoYAmNKGYDyN6nnUlHOcBiS6bgPsHF/2AY+NU0DFIAGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=breathe-safe.com; dmarc=pass action=none
 header.from=breathe-safe.com; dkim=pass header.d=breathe-safe.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breathe-safe.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpmA8+7s1uvPIwfTpLV7VHBEpyDpgpjmuMWMgNi/j+M=;
 b=LPXxKdVcu04UZVnq/1LWrtTA5Svoi3IQ0G6qjBtEoxbp+FrmdI4thXu8DMDA1KUrj4+6aX8vD66uecByM/oRLwwUrcH1r0Cf4wv3ppbIPndcNojLYluLsc0iKQacnZexqv1xmsrd8HOjsvpU2JzOnmq97QcW7qHatR+ikPfCBnOcgAI6DFV/CP5fzyyBv3Qm4I2BmuW0EzN5Yr37g+zZEPuCHyeNcrD1mXZkhcTaG6uTXIfBkCoL3S9GORGgS+FBkTCKXAM7zc+3p4lA62S/zm28VsTrvmtGpoM9yyyY+xKBVVCwg7iHA1eb/ynJVGGawjP3mKDZXqLaiyjkwZ+NwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=breathe-safe.com;
Received: from ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8::7) by
 MEYP282MB2407.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:112::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Sun, 17 Sep 2023 23:52:21 +0000
Received: from ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
 ([fe80::cf3b:e4f2:4933:19a4]) by ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
 ([fe80::cf3b:e4f2:4933:19a4%7]) with mapi id 15.20.6792.021; Sun, 17 Sep 2023
 23:52:21 +0000
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: iio: pressure: ms5611: ms5611_prom_is_valid false negative bug [PATCH]
From:   Alexander Zangerl <az@breathe-safe.com>
cc:     linux-iio@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Content-Type: multipart/mixed; boundary="=-=-="
Date:   Mon, 18 Sep 2023 09:52:20 +1000
Message-ID: <922-1694994740.375607@iEuc.VJY0.oC_q>
X-ClientProxiedBy: SY5P300CA0028.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::19) To ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB0996:EE_|MEYP282MB2407:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f63e49c-1e6a-445d-36e0-08dbb7d92222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +brL9czRDSx0eCWhmDujQEyFewi/2LkPBwCFD98HSqeBTmbyenAL2XAeS6Gcr+IeP5MWNog1+Y3qRyX0ZS2O3hBsH5lRxeCzH/X3wqHL10Js1Q94TL2Xy/Izfkp4NqJRIwcYGV28C+w3AF8xprp5BBZUQba87v7SjKvcqYvB+7dDpf12RyNTCssU3tdn9qKccKzzOQAiAQpv5bC9mD+YjQst0K41tmoLnl40SatYf+YYF9VQoC7Hy3WYvTNU/Syxr5N7+tcOmHnFBpDoPiJWKWTjvDomdWrfFSg75jw6WwfyicBpDch7p4+TPrF605xO2ixXHXJA+LEecZm/Dht5pX/dZmb+QegcmeT2Ll3xwIVKFN5NHMsX3g0GHYM6tadoVAcdcpg+QWdBfbgfZk5KLl2YwWiNM3xL1Wd3URcO/O7gwAIuGswwsqcF4wgScdcw7rxvqJhegnPqmhNYThtuzcFn32URiMnyxRazj9wljMpWejbx5EKuTyZMoXJqsJlg75yl7IxEDjURoCcizBv303No2IeHHFqtC8LKq+vutReE7SSfsNN/7PSaYF+wcrIm3iteNN5w+IAm3HjdE0EoK42nkv1y0B+mG0p2eC8+ljM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(346002)(136003)(396003)(376002)(186009)(1800799009)(451199024)(53546011)(66899024)(6512007)(44144004)(6486002)(6506007)(52116002)(8676002)(26005)(9686003)(4326008)(8936002)(5660300002)(2906002)(66946007)(66556008)(110136005)(66476007)(316002)(86362001)(41300700001)(38350700002)(38100700002)(478600001)(966005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91IZ9BP0Kcxy8RJrPJvWowNOOqaDAPhuf0jPMOo0oPSQHFKt72JRKRT4SgxW?=
 =?us-ascii?Q?hRbiqmaBmGdfpJ3f3JmkrhTQiv+uxXDagjynwEP2fhDEi1bL2yisjCMJRptT?=
 =?us-ascii?Q?wNtULE+jlnXWrtjqNtCg5MhbKJdkVndPbxE+I6x9hQgyw1LEOaNo/wqv6U6r?=
 =?us-ascii?Q?B/tIxbUWReQxK0LLHjb9S765A8LtiqfpQghSvu/f55vmDI4BmFY+zQ2nDnGn?=
 =?us-ascii?Q?6FV0x+Z6GUmKKzQPo3dG2UAUlikRbgwmMCYBmvHASQX84MyW7ZhmMp7AgLvJ?=
 =?us-ascii?Q?ZUk1yXK9xZ4Foqk62zI+qGa0KhyijC+V70E7P7srymQbEaDPMyD4SXQ7za8V?=
 =?us-ascii?Q?NgdN1vZlbLzSMVgm8A3DBItRXQ/CgnyA7IEfMFoOtWx1K+zEPJ6ASXVf7Ny2?=
 =?us-ascii?Q?r7zvfw6ahFDUsRugqvd9jnCE1rFkm+Mx8JenTGaAXYjHf9ZPU3+5s5Djc5Aq?=
 =?us-ascii?Q?ZkC7juPeQ1ondX3bOI67A+I4BbzksQ/fpM2HXoh3OuCckpGi8M55YQ7z25EY?=
 =?us-ascii?Q?eT2jCe+kuPTBrO9YFg3T/CXQ4aJ6funPaSYzGXKOS9nJJiUuyeFyPdll+dPL?=
 =?us-ascii?Q?JN1OKtw5V20+Xn0euZ89pa+eTS2upZGLSI/H5tw+dNjSdL92jhMQYxMZbk9k?=
 =?us-ascii?Q?dXjQw1eblJcNCV0QfhU6mrzABWx0JkYT8HUoajGeGxv1/WCGGfC1be3lqqrr?=
 =?us-ascii?Q?lSa4NnmMlQlwBKIQjAzigepghC+y7mYeYuE7qfDhXNQgrhNVN8WH0J9hPShU?=
 =?us-ascii?Q?+kz39R1o/Y2pTpnRWMedVE/HHnFjWmvMSJ/TgYMNXiKks56eLc8UDpEKN8/4?=
 =?us-ascii?Q?hOLlMbE53E9NjRS3/wAcFPGYruhJ8HYajEBHGfke2xlbS+HhvTfzIX8NCjTj?=
 =?us-ascii?Q?jf6u9N7dUmqNWrf4WdlMI2rjmpAaZ593OnClh9uKg7wD5FODXscB12O5JKvt?=
 =?us-ascii?Q?deNYNsh6nsbW5eCavciSvsLzlgflGjlQ10kuWHUJVnXiAJ1M/84VugDoAVLZ?=
 =?us-ascii?Q?xgXaMN1sVwfAS5P6mC+rVW7cp/gZ1P0SKd6J6pMCmoMQBlryatN8AWEuE0s6?=
 =?us-ascii?Q?1aH2uciFLSwZuE5zaPqC1FK5zP+y1rW7EAxh4DYyRdp3bJB5xaG9SCgG1mIz?=
 =?us-ascii?Q?BR1tlRSbMkO9wOiinuueK42YJco5en4oQRac2+fHXkuh7vOKnESzOLip3SSp?=
 =?us-ascii?Q?+Z+9KsUE2LT7ulcODnu51BMefYTmKXBFenP41X2t4Ezw9yLf/4TVEV+AH8lm?=
 =?us-ascii?Q?rqEIlPT2Douq7OkzyqzcdY94u9MnkO1pUx3cJ8qJ/mHEQb+9hdfejSm8MDNe?=
 =?us-ascii?Q?lGbA4j9VzUQ4i0Fd/TcXw1RxvpyBtzG9nNuCG3du+UHjGongVpmgqfQ6cM/b?=
 =?us-ascii?Q?ZRgjqcc/hlSoseWr1vPmWs6CBgG+D2g4fytoiSutLTfmj5vFd1CBqgv/b2ZY?=
 =?us-ascii?Q?3yIehttWXWgClA4LXBQDqG+PC/lD+e6eOrMwZPOyu3V+7UPKBFzpRHd1gR5E?=
 =?us-ascii?Q?2AE8xOJGR1UVQQBcZ+sLVg9peJHkNqkbd5PXfOfCScmmxyQXWa8rCne+0iRJ?=
 =?us-ascii?Q?1xSmqESWWtlhEuvtbc2NKtVp5aAzfwZNKSKfurmm?=
X-OriginatorOrg: breathe-safe.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f63e49c-1e6a-445d-36e0-08dbb7d92222
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 23:52:21.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6631c47-0922-4559-8cf6-3bd141897089
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0kiOspoGSyvU/c6cus1c3GIfH5n6C9yk3leJCBaml3IHpt6tIHBWtGWo9nAQEyfR9mHd2KmzUo3CvabRl5Wag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB2407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain

the ms5611 driver falsely rejects lots of MS5607-02BA03-50 chips
with "PROM integrity check failed" because it doesn't accept a prom crc
value of zero as legitimate.

according to the datasheet for this chip (and the manufacturer's
application note about the prom crc), none of the possible
values for the crc are excluded - but the current code
in ms5611_prom_is_valid() ends with

return crc_orig != 0x0000 && crc == crc_orig

datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5607-02BA03&DocType=Data+Sheet&DocLang=English
application note: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=AN520_C-code_example_for_MS56xx&DocType=SS&DocLang=EN

i've discussed this whith the original author of the driver (tomasz
duszynski) and he indicated that at that time (2015) he was dealing with
some faulty chip samples which returned blank data under some
circumstances and/or followed example code which indicated crc zero
being bad (i can't find any traces of any such online, however).

as far as i can tell this exception should not be applied anymore; we've
got a few hundred custom boards here with this chip where large numbers
of the prom have a legitimate crc value 0, and do work fine, but which the
current driver code wrongly rejects.

(i can provide some example prom dumps if required.)

the attached tiny patch is against 4.19. but that
section of the code is unchanged up to and including 6.6. 


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-ms5611-crc-zero-is-valid-and-should-not-be-rejected.patch

From 653b5cf063e07d126e67386b152e4e76d4f8c1dc Mon Sep 17 00:00:00 2001
From: Alexander Zangerl <az@breathe-safe.com>
Date: Mon, 18 Sep 2023 09:44:00 +1000
Subject: [PATCH] ms5611: crc zero is valid and should not be rejected

---
 drivers/iio/pressure/ms5611_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 5c7a734ede54..9980c6f3335e 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -79,7 +79,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
-- 
2.30.2


--=-=-=
Content-Type: text/plain
Content-Disposition: inline
Content-Description: Signature

Best Regards,
Alexander Zangerl
IT Engineer

-- 
P +61 7 3276 7833 | M +61 415 482 341
E az@breathe-safe.com | W breathe-safe.com.au
A 62 Mica Street, Carole Park, 4300, QLD


--=-=-=--
