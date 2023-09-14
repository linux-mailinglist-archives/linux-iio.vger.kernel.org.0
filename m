Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9527A1014
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjINVxz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 17:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVxy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 17:53:54 -0400
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1E1BFA
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 14:53:50 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKVLYk008627;
        Thu, 14 Sep 2023 17:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector2; bh=SAGqRSMhAJS9pau9JFspdr+osCi04ZAdxiQoVZ5jc5A=; b=hx
        YB/Mbkp5YPqiq8F4VpGeOkfEMvuyHat5XSx6DuBvS+BOUaY+Sm/etp1EGYWibDlG
        jRvwd4kTBYcWzAzkAuLcFz4Oa93MQ6ax+Y83JCQeZ5ThrHSle8XiXRivewQtUsQy
        OaXzm1ZYxqJ+V4A940IRnIfR6neWssVUnJVndwriAJqqTolIe/ZFI3ayLWnT/meu
        +B2p654sspB7s0M9Cy1xf+pZcs1gPORIhGJMTWURjBsjauKYbLBr3Q4PUAPQApB3
        rd/X5W8a8irPilVFZGFx0+577zRh0KkqBMQkxpWpGF9owu0tGIvXf8omj0zMYrtX
        Uawv53AvBmWdOyvJx5hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector1; bh=SAGqRSMhAJS9pau9JFspdr+osCi04ZAdxiQoVZ5jc5A=; b=m6
        9MW7m87lOqhOsv0Vt8mTKGsUzG2rujNwG37uHcCiOe40vfF+Vs6Lfv+pECDWEWdp
        i1tpgXQ3hcSKaz9lKcV9cINQIp5ZdrXLgv3yOyIFjjDFCG016Az/u60NeLgxoQZM
        O5og3bju4H15J11AhN0BaiCr7UFlO1s/m2mTukwbWOB9zUpN//PInJIebiPgbGx+
        LqI/EqMLtdE3+3HLdp0aTIQPu1pKbUdfZLFLXzZo+UDYRQ6oPOBuCDlgmVWVqWWb
        tML2ypJqcqy/p8V3qehMlj9p5Y5+6uN2SARq9UbFPsEi0uKN2CgNoUqC9k7aZ4Pi
        n9pGNPZdAUbO8jLFgASw==
Received: from can01-yqb-obe.outbound.protection.outlook.com (mail-yqbcan01lp2240.outbound.protection.outlook.com [104.47.75.240])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2ybea1v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:24:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M10HbykRv+7w58Iks6YN4kbCaKsE7Qu77n6rCZctkb6kzM09PYKaT69aqHy47uypmPBtpfrYAKZH/c9hoBcDhrwoQXBabkM9hWh5JA5xoyqBQElDMDoP1XTF1RBo8aWBgTm813xcABbcTi2bKlCrBI/kDUnsvSbe6Ug/bY1yS7ritJGCb5d10AtNcwec8xIHZ12/yRnzDIiEhq3NMxPkMdSFT72IgjkJh2aNKLgwpQWMAwWfDKOq86bu3rACewgal0KbBeGeebcjX5lGV1D8o5+d5q4/2a+QM4NfyE2bTwfT8hCPSglC0RzvmQrT0MpFtYgWuMAnKk2+Dv0cDVFEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAGqRSMhAJS9pau9JFspdr+osCi04ZAdxiQoVZ5jc5A=;
 b=jeucmPNMKx8n4Hqw9z5SUFR0WiU5uwscJHpRcJFQE7iOPawP8bmGLQ2SjEiXrLWy6njWz8hOCEYN7zDVYhPtafkH/AftY661SFr3CIdqINOROWncZsV3AFvuCnOsMM5UO+mNttgtX9EIDPxfogwH+iUbL/nH3lwojakjDQlyqJZG6kBfAi6VhuX8FbRW437HZdJkqvpHTtnvIcDvZGwC0aac9p4MTa0w2wnD82ZUTVDz8XEWL6rX1AJWq6WH0vhpmH6Akj3apAOPrS7yN0jjQ9OhduTPNswq1+u1FAS2M6Ou2gz4D9ZVoG9WO2YKxB9u6AbAEEMHhBpowggGeXPj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YT3PR01MB5551.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 21:24:55 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 21:24:55 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>,
        Anand Ashok Dumbre <anandash@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 2/2] iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale
Date:   Thu, 14 Sep 2023 15:24:32 -0600
Message-ID: <20230914212432.2842010-3-robert.hancock@calian.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8bfdb4e4-7ba3-4206-c9dd-08dbb5690a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JZpakXFBNfFjQWPGDZ/UPZ30n38TX6f0KJgCDkmRDYT+xIu8wnbYd6AcfBwspXGhF3BLBhAoMEj8y541CXopJ6rWQHmm8zY99Y8ZH1bk+IYXMPtX6OJR64sA6Ls5hDmZKB3KHnxQLbM903KVBtTxuHpfQ6lF4n5ydN3gn2qqRytJz35DaB/W/YwCRe9aCr+dz4Q/umbm1QcSyiRlBdOEWXhug8m2P5Ljq5LtEo4hU3cp2FLmm0yIS8qifsSx3eNDjCP0nTBMEDuZS7AzglHhje4wIAb3eg8JsV0S8hhjiuxF0CMnyLxoXN8zSfbcT0xOQXaTYzWImr+rQve23CrUxC/yssRXOSkYnabIAmW7c38uKikZ8f9OD60cVUtBGWDwFZzy3wfOQx1KWNrMIlQvcZgfJ0wctkP7mE4E3Ht2u36ALbCiUL7mMl071uvUlf7WYAVEk7LiZbABRzbyrb51wfi3RezvLj/BN2JEO6++h7eJ6zQpnu2dxGGiB64ZnhE0wm3Jz6Dp9g2mRKkDmM1G2YVM/3uNBAcxyhWZ9vStgaG03e9EEGJxVKdxSJu7ws1pUN6J69/aEm8oXKXotLSzjATdiNfze/pbWwu9pNQYX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(1800799009)(451199024)(186009)(54906003)(6666004)(66946007)(66476007)(66556008)(52116002)(44832011)(6506007)(6486002)(41300700001)(6512007)(316002)(6916009)(966005)(478600001)(2616005)(4326008)(8676002)(1076003)(107886003)(8936002)(26005)(5660300002)(36756003)(38100700002)(38350700002)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCqCkFY9yoq+3d3fhm4lpvwsqmgeDd/fHHTSsFmW4e4JdAeaoxuGyZ/MDB1d?=
 =?us-ascii?Q?vuAbZBqwTBG1QOaGiJpqoW0rT310PILDqFzmHlrnL55fWZ4VHmlutPJm8uQl?=
 =?us-ascii?Q?YI1qvpbsftzNAOV8nxaeV7tTdqxgPmYomdH/eg/rHnJRDhazywqICyAhymd6?=
 =?us-ascii?Q?2rqYOOdBlNZ9ozOVp71OcQG5JI1K6ryrx2DrxnpxGzprbSYDwytybQBMKwiT?=
 =?us-ascii?Q?9a2S4b1o8o88NBTFZcgnzXUH3PoGuHY5JPTCChzs44i/VTLDSckqNrtPs5up?=
 =?us-ascii?Q?Jj8YDAo5wqlboKF11GAunURI9wFhlPP0UkrtMu9p0uM519tUdMfMJSjS+NNx?=
 =?us-ascii?Q?xF2eaO+jWl+N7rX1B6m4aMMssprj6gLJGd8NUIBw8qo623SLIH8l2d/XdsPC?=
 =?us-ascii?Q?sod/lwXEBUNCzSZLu0p1IW5QDVC1gAvgBBAP5hLBfnOJq2X/oz1GYjPrNuPH?=
 =?us-ascii?Q?arIQUwwbTvv5Z1+KZv5U1eEWR0YnMzE3vbieee14FrRGr2EWoiB73lYf+Kws?=
 =?us-ascii?Q?yysDEBBihfEgSFfRhh9FFTcMz5z0sRvLPKxUKail57svlSW3LPs4cBZM7jVY?=
 =?us-ascii?Q?ZadoIc0f4PY3Fz6e21CQfOO8C+bGZjg+/9+yu1jIFkE+mX6iv8vpVhKiiJag?=
 =?us-ascii?Q?5IoPnwSCM7TtwC9Y2zu6L2VO123L7OMe5HkjSqyF/koI/nhc8qNFWgLX0cWW?=
 =?us-ascii?Q?o+xGNoFU5dZM18IwTvbVqGorSbiJWHuLIJfxf+4fvcnVVWy/sqvznA1Luw+N?=
 =?us-ascii?Q?nVrN+knC+t9kAdik3C3XsdMvWI9IvdE26xh00hm7yjC0B1UAVbzqdOjsCbAr?=
 =?us-ascii?Q?4AMfwb+04r2Z6j/bRVDzSsXm6yXZwwHKAyaDo0r+XNOeTjLPYmXryU21HfXs?=
 =?us-ascii?Q?4CO/rWjlDMggfXFGCd8ZrM91a1KjrQBa5o4fm8JmtDgO1oV9XGD+Gr9AhZQ0?=
 =?us-ascii?Q?xhg/zaKMyxjldxSTmInxnf1eIsLJS3FQM1sZHjBjegPPssL7+L9POuXdX8O5?=
 =?us-ascii?Q?scIWzgW/ArY86D2BkpJwG7ZAUe7OxsbjyeSLYMjhLx+gIt7niG6Ni27Bhu8Z?=
 =?us-ascii?Q?oP5EE+aNmMQWn1Y6ONi+3+ny9IqRttj6gbBMc6JYKd9C5zB5RB/8b6T5VCpO?=
 =?us-ascii?Q?D4VkhqGPcw1otP7S/RTOmAX3XQhfChEQbV9foDp/FHztp5XuL4jsAPU6TxXV?=
 =?us-ascii?Q?fe/ZuQf8+M17WcgXTmI9sQNUck+UM8gNAmZwnc65RZL65/zjCkwSqTOEa/Yi?=
 =?us-ascii?Q?qIAXx403eaLCNRclKt1lAvIntpZnMYZqIYCfk3zzcoAUJhnhDuEWht3+coyD?=
 =?us-ascii?Q?RTJQcu8sHzxJqhn0/yOlxNj0yQ+sYiS8EA9zNmADpkUMYD2NQWbF6mm5s/ex?=
 =?us-ascii?Q?/qvogHAv0kQzY4upY8RZwg/FsSRwW/5tVZiSU56tmPE3Ip73J/trFCodg15C?=
 =?us-ascii?Q?kIRII1+jYSyp/+1sGJdgbU8o+OKRhTY+6jpddXzGYLu8AoOm3IeoL4XeOSst?=
 =?us-ascii?Q?Z7JWxSZdXYCfSStHnUwPjE8Af0rEBs9foX0MgIj6IEFsSa03HfEwmwshiZRe?=
 =?us-ascii?Q?KYR9kyCeAS1AyyUX06z16xRpknAKf9tRu58TkmFJV3iErEhMWIEWoebtRhUp?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?And98HhwN9GpNKOSTTQmdGzu+basCTUsEaVXerHziQzA0IPnepBingC8OHYk?=
 =?us-ascii?Q?1mnvDtGzIKKrBixNlaAsJyPo/a6hNDgdG5vRQsqDpA1peXbxjOMMM8yh6M6e?=
 =?us-ascii?Q?J8+0auLxs7vdpMjZxabw/s2ymdflghSX8dDjcUt+dykPecerNPISE/DMHxHG?=
 =?us-ascii?Q?TyIL+fHxyQ95DhOwhqw8iRs8W1movnBCDaTxPktrb59yNqENaNsmGfJUfaBq?=
 =?us-ascii?Q?PcyMDuNwZSw48ro3Lm4+UIWTha9rMOqH2hgSShMPO1eXnvRcFIUBGUuC70Fu?=
 =?us-ascii?Q?nthmlX+uDDoZO//qo5ec8SsXt4SQgExHZiQcOkdehyJCPyYUjLWvlQXtIOJo?=
 =?us-ascii?Q?Ghp11+LdCMrddDthBCJB4JfYcnj9XysRFSFcEGqnG4e3Okk2vS4YU9PRpXjL?=
 =?us-ascii?Q?YzkqF5AcIaNlv0rUAUljwJ+g+Qsvwqhvtc9Y6nEWL57mFWt/9jrTvRiQswwt?=
 =?us-ascii?Q?6CYiUTCUCcHHBlssFXeN2WExG7W4QZi9AOYBfYH9nfPReEILiuC/hkoMVM0d?=
 =?us-ascii?Q?HtaGo0wOcKSYKFwVTErS0U6wt9iV3JwCNoccqD3pkkgELnpfH2sybHNiVXMb?=
 =?us-ascii?Q?U6oIUpwgjR/eNOjLMT1IYv6bJEP+kc49WFhlSSfSibw89tIoiFk4BfX1QVvm?=
 =?us-ascii?Q?xf7rrWAP9RVWWiYscE1DnMQSMAw9dv2OV1csvMm1lQN4/e8tbqLuDG9SpE+Q?=
 =?us-ascii?Q?c9tYVx/YQLklufmg3U5fmx/wCu5Dc2wrfBf+NjDvUBCFzfC4om5jG8+VWwkX?=
 =?us-ascii?Q?OBzGV+eLKxYQH23e+38fHIAO6darGT1kakiVCY0fNiO+P/Fo8sgr4NRfnqva?=
 =?us-ascii?Q?uuFyg5/iqoKJ3TCiXP+eZRkuMafVy8RcdWQzLWBCGR2pqzH2Q0OVC6/u0KwR?=
 =?us-ascii?Q?Wtf2Yda41UvE+BO0JQkkoDkKHPTRkCLw23qQ8CaeKBBPtPh/ZU5XGdrxqMIm?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfdb4e4-7ba3-4206-c9dd-08dbb5690a1d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 21:24:55.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF/xsNus+AbPlojRhxt045ly/FmtYftlqlgzYywVOXy8aXjubtEhcj5v0ooafomOvl+2+5APtWPzTI06aZzVVQbyHJiAIqr9bPSBhXYhQD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5551
X-Proofpoint-ORIG-GUID: bLmTvQQ6rMJZ5Z2LgIwr_UuahbmM4bwS
X-Proofpoint-GUID: bLmTvQQ6rMJZ5Z2LgIwr_UuahbmM4bwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver was previously using offset and scale values for the
temperature sensor readings which were only valid for 7-series devices.
Add per-device-type values for offset and scale and set them appropriately
for each device type.

Note that the values used for the UltraScale family are for UltraScale+
(i.e. the SYSMONE4 primitive) using the internal reference, as that seems
to be the most common configuration and the device tree values Xilinx's
device tree generator produces don't seem to give us anything to tell us
which configuration is used. However, the differences within the UltraScale
family seem fairly minor and it's closer than using the 7-series values
instead in any case.

Fixes: c2b7720a7905 ("iio: xilinx-xadc: Add basic support for Ultrascale System Monitor")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 17 ++++++++++++++---
 drivers/iio/adc/xilinx-xadc.h      |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 88d523ac7881..1c6314dd4d1d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -456,6 +456,9 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const unsigned int xadc_axi_reg_offsets[] = {
@@ -566,6 +569,9 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
 };
 
 static const struct xadc_ops xadc_us_axi_ops = {
@@ -577,6 +583,12 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.interrupt_handler = xadc_axi_interrupt_handler,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
+	/**
+	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
+	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
+	 */
+	.temp_scale = 509314,
+	.temp_offset = 280231,
 };
 
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
@@ -945,8 +957,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
-			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-			*val = 503975;
+			*val = xadc->ops->temp_scale;
 			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
@@ -954,7 +965,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 		}
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has an offset */
-		*val = -((273150 << bits) / 503975);
+		*val = -((xadc->ops->temp_offset << bits) / xadc->ops->temp_scale);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_samplerate(xadc);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 7d78ce698967..3036f4d613ff 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -85,6 +85,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	int temp_scale;
+	int temp_offset;
 };
 
 static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
-- 
2.41.0

