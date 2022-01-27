Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2549E920
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jan 2022 18:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbiA0RgG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jan 2022 12:36:06 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:12428 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244541AbiA0RgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jan 2022 12:36:04 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RCIlZO006794;
        Thu, 27 Jan 2022 12:35:51 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2053.outbound.protection.outlook.com [104.47.60.53])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3duu8kr835-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct7UlvcdKvd6YICRagijjzN0/DCxsmjyBu7gPENWic6AaODncMHZI0u7egIpTMDMbqspwbQgwbnSJng48Ldckcy0XC0ma9vXn0gv83JiKa41JgO/vdZZHe29UhVLSyDG7N3jOD4MiT5ly3NZZvFCxe7V0vUtFS6cGU9uJtNNeVsPym47UV5iX4zwN7tV8pJ2qJEAH+UGagPY7ASZF3zhCbpClYQEyitMyogLEdw/VkkXEC8Tc6bCDV02EeLesCEioAiTpU81uZGPzc7tvIEO9zhOW+W1F5Izp8b7hk6l6EWRjCFM2hfEWI2UyOjilF2pTzyAj/gCXPFMKIDE0INA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlHAXbj05qn9RWsqcRK51QW6q2ZXHSzH6cPrjoys8U=;
 b=e5kOGscG3kelCuu6o8A8g0yH0+mRi5i4a2oRJNkvmxVQSW0W0PHwR41qbz7uYzLNt4Iw8f+k5DNi93OZ8oOsXjyy8Uq2/TNGbUzFRukhPYiVKMuN+QDYrvROm3/xyz9RvXLH32kaMe0sBF43lRKibOAmsAtIP15marjufeIcy4fFlK2e81I5u4Tkw/hIJPuFW0/JnhDDlMa4X5XiYH1aTXwAuqS2f1jo8QXOFvc3jt4Xv6zUOspDBon/Gupuub5JvuqCV56I5YCbhFeVFKQtxBZw8Ea8go8Hv+sjFrxo8XPurSFhgvqgcUFxpjKIIgI+twSpVJxdNfTI2N4+pZIKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlHAXbj05qn9RWsqcRK51QW6q2ZXHSzH6cPrjoys8U=;
 b=FI6yCbOij2Wx78YXBjH4S3IN5Xq6XaeB3qIMu1U1ZB4QKz3HexhjCqeee4ClbRV8lwYYoEJMnvlRU/dlrz/WErKs4yCLITE6NNS+P9TdD0nynim1+UDPQx7/1uoYJiExBg7V1m4Iraxy+IuQOfuHIu8ELbpZkeKLCASyWdK6OzA=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:35:50 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.020; Thu, 27 Jan 2022
 17:35:50 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        manish.narani@xilinx.com, devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2 4/4] iio: adc: xilinx-ams: Fix single channel switching sequence
Date:   Thu, 27 Jan 2022 11:34:50 -0600
Message-Id: <20220127173450.3684318-5-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127173450.3684318-1-robert.hancock@calian.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:33::16) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73b1e208-a52d-4bd0-f7c6-08d9e1bb75bd
X-MS-TrafficTypeDiagnostic: YT2PR01MB9665:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB9665A3EAC08A9322B2AE2E25EC219@YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imaiPYa5qIwVTmikppXcoaiUQlKmn51Q4jC+i3HkuF7vxR0amOL0r2mp8EKA+s4v9YLuhbvpW+30uJTETkbJyTrharBBxlg0414l/i5MuC9bIz5rhhMdSGE6CkLydp1L9kcNmq0KVrP1BHxlibHSNlu3s5oKfVZQeBjRUQDzs+oq9bPVhCBLXAtgGghqNSrx77AkIVlQIMBChNaURmosu2ZvxnKrhEedBKHKUmmaMnabM7ak2qSTy2DsC1HqbIDAk6ZZFR3KcVoIKdp3+EGWSvjhsQ90i8XW5cUTttHg++7BJEd2eEDQhcHwdGePK1PRy1ITWPszcedCy0HcuoNhKNruQ/p+Csu19ueTokAz7AvlflThHxQGjbHkB3Y/PjVx0LIfK1S3FfzvjHstAy63F2drtBw6ML/olM6RNdSyigBqdI9PwQ+GMbPYPr0UqbVXUgeWEZ6FQ8PeX2mR7nYY+ax8TAqudLrEUqBrKzg9PEeC2CklSL8v9okUoNw2A8ZAGQGpM21gknQpP1wqkiFIItla7FfKKg6nfkpBW5sgGV8vF5kKRewojxkHSGlF+SzNuhd6NZ4HyAaoe04gAv9ZCnDiFpiakNSXJVFJzLsxbkVj+XgEnlqOQPgj/8Bcc7ZA9KwcHDLHBER+NQZ1+3FfVAIvek9X2uqK6V9tsiraD5/Zj5jNTxqne1bxaaXVisjBZRrmwkA54+bH7Ed+lGQjKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(86362001)(4326008)(6486002)(66946007)(66476007)(8936002)(44832011)(6916009)(5660300002)(2906002)(107886003)(26005)(6512007)(1076003)(186003)(2616005)(52116002)(316002)(36756003)(38100700002)(6506007)(38350700002)(508600001)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVrfpXMcg/z+tralZwa/JWu5/ul7T+FOQ1MML3buUrN8xTmtbPRQr+UX59Z5?=
 =?us-ascii?Q?hFYVVBl1F0FSVI3j9h9YnWOAiw1OYMBjKNkeolRM9Sxn+gPsG/tMo8TGULYk?=
 =?us-ascii?Q?ekndvbLxISaDMnEkNmVdiPGSm3AY7OZsRi3PBm5v1CyjPP1BX4sj8wzEqasu?=
 =?us-ascii?Q?3UJW7NzqD2kp7feu9UXl6lYla69nSkMj8hCNOvWpGKgjPzQ68B3CLHI237Sc?=
 =?us-ascii?Q?WI+63vFK/XY/rrYeX6QbGBSV2bUmDKl/IGEAQbj9IJdty9rS62bBnkJ2gO5L?=
 =?us-ascii?Q?vRmbej48WDyIY55l+rIVCkYlg5LsmtCs1/cXmibMlahmXHbg/YC2Uri4ECc/?=
 =?us-ascii?Q?m5CXSdEbEy02mImV+b6tENucY4SifiztrLXd7yr1BCqJBohgf6gvSAe8xQZf?=
 =?us-ascii?Q?oXLwEIHLOnmsijrM1UbHgaMI2dQVSGV80K9XaV/P+jhLCaboZZS/m9ZVyP7h?=
 =?us-ascii?Q?PDsdNhiBs4f1TmWTd6ySXFgSgXQF9Zj8fQSF5yD+MRjOguO7V6KmXwYXcmmh?=
 =?us-ascii?Q?5+ns8PQqQB3h4IRezlCE0UnLGZlEZndIJoFUT8NfP1PSd7cLg8AqE0gDijuI?=
 =?us-ascii?Q?ruBKy3J27E+VItVGV1k3DFLqIFTXH4B8bYr9FRBkaJwURNE7kYx8u3i55npt?=
 =?us-ascii?Q?fx9nRIn3pkQNIFEhwo37LxDMDZNZX5Gx1YRl2VfZEzWuWIlaUBdzqZhbg7Zm?=
 =?us-ascii?Q?lCzx229p8wxdx+bBgEIpWb//MhPwPVB8C7POfaRa/hdT7S86ODNvkEp498LJ?=
 =?us-ascii?Q?ReUMnS4ZZWYnWVGC+S1GIMu79OetaeaOft+f9QwtVE2W7JKd28hcHDOzSTBU?=
 =?us-ascii?Q?GddAJq71G+2VPOmDAVyD9CCO2aS5KLRepikfXRYDPaYgENiBu/jAo3wX9Pxu?=
 =?us-ascii?Q?bWoU1cGuIpRkjVg7/k/59vRhor9lEHrDlHKHJ7/apWs6YyfLfYX0XePuAO4v?=
 =?us-ascii?Q?Gnu+aiqB+NaSQoVeNYy26TINbW9CZHmAlVAxsgs+ps2BMujpyZ9vOn5RAJdO?=
 =?us-ascii?Q?UO9KhfI67IdcYm+wM7cfSkBT94iSu2ZQy/5XX7fhKw3hPyiH8dOSj1Y1d02W?=
 =?us-ascii?Q?8wPFTshwIsanRQuxHBY5ZPCjd57aVMa+DLSdJ7wm5V10ZYb9bA9vfxS4ZFQc?=
 =?us-ascii?Q?ttLf/OeNYl/m2ycdpbqjg61wTm2suBZdrpUQyxZUGo7JcG8Ut8vQDrpdkSPe?=
 =?us-ascii?Q?BESDoi7zIZKPRefXDgFP/onxxQlnlwPdHUfVisLRFSxRIy5QHFL2FaXKfMt6?=
 =?us-ascii?Q?ib9dQzZj7w00wxHm5mEGAh+61XVM6R6X8a4U84vpsMe4lMskiOdUnejzUQ/w?=
 =?us-ascii?Q?ukBUA90mgbr8yIDrB75yuerW0XeET4cUVRLq2f49av1+GpvUc/wuWLUHfHtq?=
 =?us-ascii?Q?BztvdqBvAR5m0yvD6yVopGrdJxN9GS796zQVj9LCHChHDd9VJHVZJofRo9ia?=
 =?us-ascii?Q?ofhyKfkwNo/QRW/qRiACK0agmwbDBXX83aHx9//cycxGhz+zTkSHqNpABaUl?=
 =?us-ascii?Q?IX62zjum7Qk5UJlP3lWTlesYKXH8cnEgsE9gBG2l2+G0ymMvKTTn4COA/Pxb?=
 =?us-ascii?Q?cITcYoZTyrFADrzcl+PniXdHwABvJp/j52nhrByQNNfZk8VNOcpJES0Yn+/G?=
 =?us-ascii?Q?8edWErTlzYQLbwodK1PxYhtvBKTBe1dHXmhWoXDyGAqIPkvh3gvHUX128sHo?=
 =?us-ascii?Q?BjjyS79KXlmKITL0i++DLGQ1w+4=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b1e208-a52d-4bd0-f7c6-08d9e1bb75bd
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:35:50.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FmtOPuiu/k2kS1uhiKW0vvFECAB/bltbxDVAq74TgstORWODQZ1vOm0QgIRVOarxMCs6Ex+0xV3xUDM2So/dKzsUGlXuEqu/MG/R7MyjNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9665
X-Proofpoint-GUID: h5YDwUsRX2hSL-bkkRjVlJ6YFpgY1_jr
X-Proofpoint-ORIG-GUID: h5YDwUsRX2hSL-bkkRjVlJ6YFpgY1_jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=695 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
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

