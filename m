Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECB49454D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 02:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbiATBDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 20:03:36 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:14227 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344023AbiATBDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 20:03:32 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JNHfL4017531;
        Wed, 19 Jan 2022 20:03:07 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2056.outbound.protection.outlook.com [104.47.61.56])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dpmt68b92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 20:03:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs8paROcCsrSCtN30FkgToJoDvSjmFOG8QanvfgORSfcV8GYzujOI0jcKCPyjLkN83ZCPFdGvax1/N6OTAl8s3sY9+MILv81mw7L2pP18bQ6UHtSTMYS9vvp5AyRyRxzdZDrCl2eqGSnpNF9ExVl9u7/Rayb+/3j8X1ht5V3llwHRD1oa73gD8UySIvi3ElkIA5gCVU7jwlopopjnSS4C4Z4qwKie23MDJQ0hdVO31RQn7WDnt5uaE5eUyVk8GbkWYzWvTvZwsKigxU9qf9LeC3IWF042TBIhn7WUMQ5+f8vKuFiEq2MKXkm7oNg7xzxmqkTBmJsmSoBkd6mq2UC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlHAXbj05qn9RWsqcRK51QW6q2ZXHSzH6cPrjoys8U=;
 b=XcHTMhiEkkF67xiyFjGuPQze/Opv4dTEeuwgfNd7f+oX6xupSJj9FGhHvcQL2Bbc4YojZ8iDmwNeB+pnKk9cPkeYMHN7jaRkVdkGWsp5VSi6q8xVg+ZRpPF76TVZkL1i4Cr/7dF7Z9TYdUud8Q5sh+JfwYZERmwsEs5nRHlIHi5M248bcNA1xVK4WcQi5oyAvY6+3HYHHqhWkBN57tVFnGmos2zhJy/7/LfI60VM5I9vzPVV/bR2Mv7jGMcYqrKYmSvkIGD8kt4d0H9jMRN0+24HkrojtRMrzP6RGQCk+sX+72LTzg/OB9LeIQl6DWJmerXp/fjJ2Ud6suSXs0clmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlHAXbj05qn9RWsqcRK51QW6q2ZXHSzH6cPrjoys8U=;
 b=cwx6eFEh3kcbqVyNRT+q/qhgvYUGWZueHoJNT6Bw+mqUTG5J1oLHeAawV75UFlfEdXDEPwggLz3awDcwdn8AJr5Fx+grE+nUab5P5FXda5U+8UtVeqpfyuvC15ytcDaMLvVigFEVbpkbPhYOPEdYtf8LlBcufrFhnUBpxnEweQY=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:20::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:03:06 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:03:06 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        manish.narani@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 4/4] iio: adc: xilinx-ams: Fix single channel switching sequence
Date:   Wed, 19 Jan 2022 19:02:46 -0600
Message-Id: <20220120010246.3794962-5-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220120010246.3794962-1-robert.hancock@calian.com>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d791f610-5560-4f82-3bf2-08d9dbb09de8
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1065:EE_
X-Microsoft-Antispam-PRVS: <YTOPR0101MB10652CD2AACBF11EAF7DD58EEC5A9@YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytiv9BbZ7kNlu8SBWUrOAVyo1x8Dh1ZseJ9jYhOWZb//CHvEhEtwqpZ2pEsxnHE3jfVeMC7GEqeA0MwzZat4cbpFhiL68OqTVpSsyOjdi+F6QgCmNqGB558KxI4FapZlWYm0RDHDmWV8ixWvKqv479YnoG+TGD16iXTF43fYthq/by/pgD2KL45eScUF9CWnmTk+1Kvaknrtmmz1c6XoHVE0sKsRMciXaaX8WrhKzfohkveNXHTJvWCR4etzSgNuyzUZaSW/C3Po/xzajLuKWUGW4LOmJ4yffUTj7//YxYqyvK3yiGylRellJdRnVJGmsShUnRM20oAHz77102IXHLz2Bm1mQjjc9K7BorrbppWwZ5u/0uRIklpKuRPioq0ExBPEiTb6RfLS9Fx2Onrtv/P2+5KnzkbEcUqj3JeDKOA1y8J9aG2YpmUwSL0KMeDQNcQJh4zOFj9SxSCM0Z4QHZQgDsuGfFRZatdKvlLjaF7krbrht98aFIp7VdrqR2hD5YOM8Tj5aGBtxp9RpwPVsNIlkCGuXFdkEqvb1aezPwod6HLK4lzB7BcecQr8EAF5UvSzjTLxnkePorbAETNHA9IVIMrLGPkSD8KgtN+7J8HahqZ/sxLRiJfy3Sk5/6nhdFZdHqdfylC8n5HQ7iO2M1B9s7CSpJAq7b0DXjo+IDNJ3ZUTiWOaJE7dmj9RC8mnenpV2dpjWAjxHKrxYS6yGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(4326008)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(1076003)(6512007)(38350700002)(26005)(36756003)(6506007)(6666004)(38100700002)(52116002)(5660300002)(83380400001)(6486002)(107886003)(86362001)(508600001)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/O/AMc1ZZC2v6y4QmLTgONtRBPed3WV1LkZHvLfZxzxnyaYxi39YKpUF19Xk?=
 =?us-ascii?Q?zIXc9yWH9N5Rvd30aEHZT8JfX0nDDXZY7pAm/L2r1MlMBI3ETY/1UEDesXoX?=
 =?us-ascii?Q?PDiSLYqerQ7HpWGU/U38XRzbcpticcruGfcC+ANdLiVJClvWR8tHG7N+7osQ?=
 =?us-ascii?Q?70eNQXZfZQ+UgzE+zX3sfwCJ8JTG8JI4Q2W+TGmiwA+KEMa+wewG4VgfJFQU?=
 =?us-ascii?Q?JlrMgwyZyG7FWOgtmUd8DMyvhAGlCMlIYxvvSbXsY+05R0nPMH0b2LKuax77?=
 =?us-ascii?Q?AO86I91dGt632jzxZGvS9btEamdNe940BFOMXoWn8a002DZAp/g/uUBPMaxY?=
 =?us-ascii?Q?cBzQQutKXoKERP6vMFKYwqBLkQW95aKRvcLXIib1EQ2WGrBssMgQZZnNfLBS?=
 =?us-ascii?Q?Mkq8WlAZMhm+Wgu8qPoxizq5e83XdLTGsHLymw5T42FJmHktl/yTQ08qGXLH?=
 =?us-ascii?Q?4UQ61JWg39J2WFBk36THarc6uzCI9sEo5A2wzVevJAzSq2D47yeszz4gm/Fb?=
 =?us-ascii?Q?RBHGYyHiDSe+3IFCBAZUK5iIFGCZWuCJUC52gVu/+5vJq7hl+2r0POPPQ/R2?=
 =?us-ascii?Q?9ZaOTlT22GDGvpKdlliA3JDoTTpp5WdnE9DwhWhXYXhVeOLdc0/1Puz03FG/?=
 =?us-ascii?Q?sypZnHFs92enJDSPR0YCGDzM3qqJy9LgXVmde/0KbWkUEYWhsdQzq81TyChs?=
 =?us-ascii?Q?NXuHfJfT0YrOQFAzlWmUtrs0lgzNKjyuBVGSwq+kODf+4nEYHCHsMJPIH5WC?=
 =?us-ascii?Q?LfhE3SdrVhEg3mGMsFdYXv0axwm2PFyiHr5+kFjdFxKfhNV6yQGEF4Mauxd6?=
 =?us-ascii?Q?h1Sk6kyUcMNXtd39k4jAnqcsl++4h9FIRret93m/kQmIs085iHpNlUH3i0tF?=
 =?us-ascii?Q?E9/67Gx9vPvMW2Qk1PfLK+6lTM7QKSEBzR/H1Kw7frDB40xqI0MQ1AMmpocg?=
 =?us-ascii?Q?sbBhtgAcgqsAiGmkzZ0PZ3AGi1ql9qr2yBMUz97oJyuFXiAU6X7gixziqpbu?=
 =?us-ascii?Q?+sYjVRvTcY1GLGcVwu87MOCm2Z+Y1s9CtXhyg0bohdSK7/NyS/lV+IQW0ogS?=
 =?us-ascii?Q?jBXIXW2KfqvIwNt4gN12eB211uhy9CbgvD+Mr6J7MgNEsgKya+CGwNPqgcZC?=
 =?us-ascii?Q?SaQ0sx2bgaVzWQ+azgm2EUoDxleReSMeuL4eU69hbysbrepBpupgfYLrX/9t?=
 =?us-ascii?Q?qwct1/4XLo3d6AIQMNXFKe4RzwyfOMLwAcamTJPIoaaCRIRgXHipd6uACto1?=
 =?us-ascii?Q?7sDnTSptXKrGCH2vjR7hsMs8LTOronjn7c4DIvZ1Q/jwpXYG6b3dNYUNbU5f?=
 =?us-ascii?Q?Y5eG2rnfehyhk8A6AHvbCcUTIj4LRVdwU2nsVwz0hD7BhvAv7Fr9KpncaTbD?=
 =?us-ascii?Q?lnHqpA2tdUqegO4V75ue7RUwMrfFgXEDuXKxYHhX5+N70TvMgjGgmxlGF0/m?=
 =?us-ascii?Q?dGQOhtYTUEH16K+H38hAt64WlmoixuIxSY+XrzPjh6pUFWVasB1F3az0ysmW?=
 =?us-ascii?Q?hWeM9wqvjF9zv4PPtVkU0pPGm//NhSZWDH6evP+4gps+6TREs4LDOd+p8eYp?=
 =?us-ascii?Q?8xo32OqpqbFjuvbcmqDsoNk3yLlRI5YHKlI5a9SrlFoZkTiRPQp2SIWAnOo3?=
 =?us-ascii?Q?ZksULQUMM+2b2XWR8KwhTUNPfprNUHQZJgqita9QwXI4e7hEQ9cwP2fXOKEd?=
 =?us-ascii?Q?oC/XH3Pgi1okGFwW8luVtgiEF7g=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d791f610-5560-4f82-3bf2-08d9dbb09de8
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:03:06.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADaFm85sbRVk8EENEhERg1RCxEDdnqCGZuqUKGdhSf9a+cr+bLwcJx1T3qJU3UrEOb0D52LGAztnSW4F04ptH4nKBjaneNXabkyZaWPESfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1065
X-Proofpoint-GUID: 9gaOnxvw_GEtQ46BdxTXKgPM0VwoxRfz
X-Proofpoint-ORIG-GUID: 9gaOnxvw_GEtQ46BdxTXKgPM0VwoxRfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=827 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200004
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some of the AMS channels need to be read by switching into single-channel
mode from the normal polling sequence. There was a logic issue in this
switching code that could cause the first read of these channels to read
back as zero.

It appears that the sequencer should be set back to default mode before
changing the channel selection, and the channel should be set before
switching the sequencer back into single-channel mode.

Also, write 1 to the EOC bit in the status register to clear it before
waiting for it to become set, so that we actually wait for a new
conversion to complete, and don't proceed based on a previous conversion
completing.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-ams.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 199027c93cdc..7bf097fa10cb 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -530,14 +530,18 @@ static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
 		return -EINVAL;
 	}
 
-	/* set single channel, sequencer off mode */
+	/* put sysmon in a soft reset to change the sequence */
 	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
-			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
+			  AMS_CONF1_SEQ_DEFAULT);
 
 	/* write the channel number */
 	ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
 			  channel_num);
 
+	/* set single channel, sequencer off mode */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
+
 	return 0;
 }
 
@@ -551,6 +555,8 @@ static int ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
 	if (ret)
 		return ret;
 
+	/* clear end-of-conversion flag, wait for next conversion to complete */
+	writel(expect, ams->base + AMS_ISR_1);
 	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg, (reg & expect),
 				 AMS_INIT_POLL_TIME_US, AMS_INIT_TIMEOUT_US);
 	if (ret)
-- 
2.31.1

