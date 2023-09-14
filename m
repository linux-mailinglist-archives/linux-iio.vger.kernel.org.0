Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0417A1015
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjINVyT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 17:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVyT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 17:54:19 -0400
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0130B1BFA
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 14:54:14 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKZ41v024603;
        Thu, 14 Sep 2023 17:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector2; bh=pDeZ66DosiDD8uj0gctctN9VJkMT0GtVpIb02Mkyhxw=; b=M3
        FAt/3wnX4hPxfKMT7BlHcf/mXHKAdhrABtLxGF/ZRb0bm8y//sInkh+oSODr6z6S
        +ccsvH53FvYivMz0DrMBFxetb+oy+L98p54KAUPZRV0XnBiCc1ms0o77jHHmtCD9
        Yt8XzgrdGYs+MrXpyz4tM6HGEtY06KMEdOdQpWdXHhzxBW33uV1JhUFHjFPrPb/w
        RK5LF9U+t/UJ+CDOXNDsUZyY90HBLZkRtQujkred0fFPYTZok+MNMbmAYRhhhxQ0
        YaWHFn/rpj+xHoBQGH0r7bDZR4fkCp3eOIcazz2PnWXw7guzZpJl8/9UMs5DnMHI
        4y5b4QGlTcWpngrcY+oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector1; bh=pDeZ66DosiDD8uj0gctctN9VJkMT0GtVpIb02Mkyhxw=; b=BR
        aY7zppH0pbPV1V43/ghTqRpK3NzidlFfjQUdgvJ2HS22CYAbJhgltD3yB7JUGsR8
        8Pb9vVcnfSYNY0O7vCAptRcC6zWyLsSOXK+xNP0PWbCiJgkbEh3gGHyG2qWr5017
        y3HNg5uOxMqGl08HH1SDIY8adM+o0bzb9iMHZDzJuG6Sws/pa+whxziFFY38rpx0
        C8F5KB2KBk9yHBaIsrjlff0YgN04orcdPfmXJKd87qCo+zWB8rIzj/tgEG927zpT
        JQUZYxdN9mMfzGAILvYcmV+L+NdY/+Yo7ic5urCKfjkdRWhOShZCX24l8dswgzsz
        kjx1t+4PIhWTkBG5IqpA==
Received: from can01-yqb-obe.outbound.protection.outlook.com (mail-yqbcan01lp2234.outbound.protection.outlook.com [104.47.75.234])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2ybea1v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:24:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSXGcBsjpTubdOopDuCTYSqW0r2oKGlknKqvv8axKIcSPw0wo6OFHOWNjiOV1NElpAdueDSqxEn/NerrItYJwFHDdmK26YJEXVOj59C1a7NLdOt3H0bfDMurdJi1Y7ukVDPPNagOFqvoxAHRpZ6zepowP6oHaOlVdCWEvYY62XS5+LxG7PmXBokn5N1ZOv1dJglA+RrLB/zWNo1HrpsapONIAwHuIUatWg6EnSAkljoK8gQ0qhb6sZAKW8c3OOyKU+jrZleGhjBlG9T5vHpmOHf8iVPW3LwIFcBanKG3+tOTXJzGnNSqJh+ArnhdWi+j1Obsp5b1TO9+8hWKXaOzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDeZ66DosiDD8uj0gctctN9VJkMT0GtVpIb02Mkyhxw=;
 b=mqVhyvJEHob9z+yVNdyZWuA2O0/QVg4yQpXpuWzBGrsYVD4z08E9JbVc9Ig9zcdARj1MT3IqBYIXXy51aB4Uc2witUSVCf6pXnZLROHXYN9fPNSoSqE7UYro92fe48c7HIJbMb8KBRHiZXaT8hIXyYqirUwR+3DHBiGxx9C9ptZ9IzyNAhKS3iXCSldW3rZo7i/Shz2zH56ELBrz4LuxbAUV1MmaTjUdY/FYwvzhbOEQ6LOzuQdeAuzEp+i5mJtS7G0qR9AQYrWc/oLIKQZD1zpL7B/LsoOUNPJYYqfnoMkj722WfAY5/OAp9ankhnfHnRdZR7EJbjWzY+1S1o4VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YT3PR01MB5551.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 21:24:53 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 21:24:53 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>,
        Anand Ashok Dumbre <anandash@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 1/2] iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
Date:   Thu, 14 Sep 2023 15:24:31 -0600
Message-ID: <20230914212432.2842010-2-robert.hancock@calian.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914212432.2842010-1-robert.hancock@calian.com>
References: <20230914212432.2842010-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB8838:EE_|YT3PR01MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: f6858644-a11c-4b34-f2f4-08dbb5690938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB8zy0d6u3v1gsdmtauS8dCtWXt0wNEbrUB15TIX7XNImye2UTDs86ucp70f6JMKUURgsSr42KMkA9OMD2dEa5f7kYMJjQPdScCsvOKzm++KXKuSNelaUK51H6iWU3sM9+1M5XhFKw4ZptwfktfrN6g013NingTQVVAHLxBoUeZZVsx5J+mnjTswhmvO27Nm7UfJSYNU3r/KfXyiLDmGsHwN07cELhYlwUznqi2UxsZeUXcPIsHQSxUjvuPA5nrkiSTwj/V8pTPDw8VJXZy84He1jF+SsOx8a8p3CU068vkJKJKmEx4dajUhjH4cusZUtqW/lHP3kODDT30X6RUd2UqWfrcMsZmKy95pFTvDGGmv6nMbewuMyuxn2QZZbhmDlHyeSPEWrDXDZPVi5H1cnFs3uxoQhfC5WLRS+TfCXZgKo6C7jZ2nQT1J4bD3g2LjwTXPOLwPRqSIHFOYVUrAj7KFtdL9sTdm2OeTm4FToEiYlRsL5Y0cNknLfur0fHLNXaBNOjcMCYD9YjhEuI8Ladr51EYTTW5WFwM5335s0UfNSqFH+UNq/Y5OqsQCO8vjbc3bdo9HuYFa8tlPV7h7WdLWXM8Zdj8o0lhJ7biHarwLaMbUh4K22qcw+1YXtxv4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(1800799009)(451199024)(186009)(54906003)(6666004)(66946007)(66476007)(66556008)(52116002)(44832011)(6506007)(6486002)(41300700001)(6512007)(316002)(6916009)(478600001)(2616005)(4326008)(8676002)(1076003)(107886003)(8936002)(26005)(5660300002)(36756003)(38100700002)(38350700002)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVK/t+xDmdfiNDSIrtGNxPC+MTiSfCiJwnF8r4ITgX434XeJbcj84NlgPp2r?=
 =?us-ascii?Q?GF7fd/Fjmsh5GaKsO9qsZ3fYjvb7QtHH36TUW5kckjmpjY8ehTzzLzk5OvAN?=
 =?us-ascii?Q?mLrjX8EXIc1lHYN+YQeVgk/eJCjmQpziXW/SvtkLOTTFy8qcjudznrxlavrv?=
 =?us-ascii?Q?OeF3JclShJBtJP7OeSES8XPWogEXNA4F4TgNiIvOym3W58eaOT/GMTjjWOkx?=
 =?us-ascii?Q?I4n+adScYbNcK/ZOo0FwrqjiFrF4/WAYJALPFgnG7NphFh4hxKAwUvARfdrG?=
 =?us-ascii?Q?pWbgA8YBbEsgUi5nShyPE2Uj4sAHnb4eqNVKCWBsHA9JtBUhMkcTmST90D2l?=
 =?us-ascii?Q?4N04OzbyJiS6a9NtfMLRXsUeckpJX5oT/vT6pfjSrqRmaFIRe7UvrCWB25au?=
 =?us-ascii?Q?Lq080ZXh7PKAHSspTD17xac0eukAzUUs3LGfstaUTeO4HqjX5RfG6HU9mi6h?=
 =?us-ascii?Q?s0WtetW0DvE71CFsBmWx7SMFiu4gbcUoBAYBlfp2/QJU/hWiM2TT9/CVZbnc?=
 =?us-ascii?Q?j19iHCTk7qrdbfU6Ls2viIcSqTtTw3y3amLOj+GCmxRWOHfo5RNqoX6hFfoD?=
 =?us-ascii?Q?1/GgI6xB0P3D9Nwt2+whYBlavawRO0Q/5ik7fGmOxpp7pEl3lC8MKgkBWRne?=
 =?us-ascii?Q?ub5ZtRHdn1pYf6M+TgvcT8z7nNU/Xexj6uLnqvU4JJN+q/nOSAV9UKgnE27U?=
 =?us-ascii?Q?gVFgA6rdrgw7AzeernnCgi4qeoTfRmq17am391U1cfkjy+zQllQcF780GASO?=
 =?us-ascii?Q?T468AmkG6Mit6WcYNWduygd8GMGHveTm6s9Kckgzcee4YD03Ic3wHL/6DlmT?=
 =?us-ascii?Q?O/NHFgmC5hp3BCh4fRtix65nw+VCNXZHGxGLYvo3yXXPR8zdF1wO+cYBdtWZ?=
 =?us-ascii?Q?sHUDIDoY4wx2RAFL1CitahNDZq1Y3pspl6Ylw2yUqDLtl3JXN3qDFKgbur50?=
 =?us-ascii?Q?nIU9ayKftBte5i9uX9A/B0dHs/+HonW36tTSKG4JteYe8BlZEg2E5lurLVnw?=
 =?us-ascii?Q?8uV01m0tdxqTv7ooXHLFF5c6J9ndIlx8beLDds1Nszqo9EZNLnJziMRmqpyo?=
 =?us-ascii?Q?w30hhmiZupI/Wgq5tGCAX/cs1ZIXuAdwRv1CX6h9d6MEebhBy71iNmlvMn7D?=
 =?us-ascii?Q?WhNZvn29cijCswig+xfAe00KIWkv61kTd6LMI2x6Ua5f+ZV8kTLZcsH+9Kn/?=
 =?us-ascii?Q?8OuBQlc0VaIfMdPg3ZSbhh2tJHNSzd8MrK4C3lMbh5+/F+qt1GclRWUAaP0E?=
 =?us-ascii?Q?Ka//aZJk6smjtFPvSs6L4kNDup3kDO+NymCe7x3+IFpMUD1x1AVqHkd5PV68?=
 =?us-ascii?Q?wtD894/BzRVRDPZqiQyg1cVB3X03SVudlVgd6HuunCg2Z3ys/W49tqO6kMQg?=
 =?us-ascii?Q?T8IaKeNEiML7tXVXJ1OIOdLYDsTBhzYJLCSfQ8OXjsx3E5uBFmkdTRzReWsM?=
 =?us-ascii?Q?lYXmiKiVJq5uNA77euaAIj8ixJog+XlzXPoc0p5FCRmj2usWmHGsvK7ZLaIm?=
 =?us-ascii?Q?v2Q7zrJAw86CrrdL9kbjYIDUZ5apS5D8EKAfLdJCTq1ZOyb2wCbZmexYnOe3?=
 =?us-ascii?Q?l/YgEq+HWVvmPq4tpz+HrwTajsGYJwT0ePZDbnVgsosklQqvzxcmjml8LD9o?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XmjvLwO4a8Kc4zYvogh86qqiiUdeA9dFGPYmRDM+uBM4vJHiWqXwxNeQSFn3?=
 =?us-ascii?Q?p3DI2DFXCxLitzffjCDdfxXvDXPTXSeknb0kclVkYIXFU3TSAzx56dASeq3H?=
 =?us-ascii?Q?S9FI15YB2NvFK8LYitR3s6WEC6vs2ZgVoJxsu55cOp8xQrdqeCKSLpkxW2ZY?=
 =?us-ascii?Q?l6jFbjyhiaUe68COK66hD7aMm+pbl2iDv1CBZAxKmHFFVVEB7nby2yCGPC6F?=
 =?us-ascii?Q?s/NtnYmxZryANoDja9CAi7cWbvNOveEILea3xQyC4VDIZvIfoB8oyTp2ihzC?=
 =?us-ascii?Q?VSJae22LtKMl0DflPstsvc/MvrR7nNogolReFag0zD9w5TcHtbY2d4bntrlS?=
 =?us-ascii?Q?qoAzKF1zKaUG8GNz3YwX37vaUly/B4qA7ecqJhXLoLcxLzaYad/zqclF/0yf?=
 =?us-ascii?Q?pyIvsMQ73fEpU0lo43DtiRBv0iMj+c0X/bV6NpFnawELtECk5hYbRK/m8iew?=
 =?us-ascii?Q?nKLn4iwhTgmkDiqTm0ajFrlJZWd/7MZkuOgWmmmOM8uPpzCsiRs5nOuCuoI5?=
 =?us-ascii?Q?6KdKp8g/mqSqnEFdXtxCRnpsYdRilVy61+d+6OI2mK4y2f1KJLX0XGGs4jS5?=
 =?us-ascii?Q?thgXSrDRUNXoQfR5aMIlKt+UiU7fCqXFXpn7ddTTBZ+YESHt4+onfpH6154V?=
 =?us-ascii?Q?BeSn4A42vzPWVscpIYMMgzFDdO2Hel8AurJWe7nzvRYlmE0rFB+5Y5GubTs6?=
 =?us-ascii?Q?mbRglI8XDQA4ynvR4CPnFWdrDBZqx8pYZYiM561KKeJNfhSyuCFEtbZkFXs/?=
 =?us-ascii?Q?khdEB9IwnFLlKN9mMOmvVw1A2AkqAiUyI8+WBRtkrcCi+CWLtzp5SyEupIkh?=
 =?us-ascii?Q?JcR1UJ7uZzE/RpEkIYjgqbSZsI1fhktVEqcT87yWP6L/DHCAAO1tc7xmEBa4?=
 =?us-ascii?Q?8msMeesaIjS+ejDhrbJ3rkghbM8EyPs9jJ4TmLNlFDuCdF3uwspAJnRV7aKF?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6858644-a11c-4b34-f2f4-08dbb5690938
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 21:24:53.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7alNhJZacKd0rZLTucU4UFWMSL2dsPocXwpa7SaYoENWNgFBsZ3IX4yNfjM35hFgnH2ifqygo5fwPXBcGL3Z7zYd2ihxa5/aaNaIp170Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5551
X-Proofpoint-ORIG-GUID: 5b9Z5CGz1R_UX4JsFoXzO4EtBXbXz_DG
X-Proofpoint-GUID: 5b9Z5CGz1R_UX4JsFoXzO4EtBXbXz_DG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the probe function, the driver was reading out the thresholds already
set in the core, which can be configured by the user in the Vivado tools
when the FPGA image is built. However, it later clobbered those values
with zero or maximum values. In particular, the overtemperature shutdown
threshold register was overwritten with the max value, which effectively
prevents the FPGA from shutting down when the desired threshold was
eached, potentially risking hardware damage in that case.

Remove this code to leave the preconfigured default threshold values
intact.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index dba73300f894..88d523ac7881 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1429,22 +1429,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Set thresholds to min/max */
-	for (i = 0; i < 16; i++) {
-		/*
-		 * Set max voltage threshold and both temperature thresholds to
-		 * 0xffff, min voltage threshold to 0.
-		 */
-		if (i % 8 < 4 || i == 7)
-			xadc->threshold[i] = 0xffff;
-		else
-			xadc->threshold[i] = 0;
-		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			xadc->threshold[i]);
-		if (ret)
-			return ret;
-	}
-
 	/* Go to non-buffered mode */
 	xadc_postdisable(indio_dev);
 
-- 
2.41.0

