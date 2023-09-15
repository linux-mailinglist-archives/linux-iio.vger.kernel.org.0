Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C737A122D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 02:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjIOALC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 20:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjIOALA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 20:11:00 -0400
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D11CC7
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 17:10:56 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKYfv0029572;
        Thu, 14 Sep 2023 20:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector2; bh=vXZXmq4MGP77f500NxiiocQHcEIzgSCE/fy0i+2vI/0=; b=Hw
        Nzw0+ejsTpY9YYlEBpV2vK1XFdP35iqr0tiyXvXgKYPHSLgaIScXPrWE1D+9EUAJ
        a45PUMZVWE0Z88iXYhJ+QBWI7HyiDMfOdkHIeCtKzUX88/wmt3RH3B8Vic7w/5pC
        T+bpGwOUdYzVScG1fsQ2Nn10OyKI+4pgH1vPhNVh1Q+WfHxwuQ62uyNTveDtxfmR
        +dgXs2xe4kmelTLfLAaLMW5JIhBVjpyJ8dCiNwDTF9J68m3Yc8sgg3L17IkVoH96
        TUOuk5F34nYnSjZrN1m7sq1TG1WVwdVoNT1pPNQEAFWxGTBWcg9jO2EAr/5KATsF
        n+I4IjOAnIsbxPmH7f9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        selector1; bh=vXZXmq4MGP77f500NxiiocQHcEIzgSCE/fy0i+2vI/0=; b=QF
        dutmaesnsFM3b9n9EL1Ysxippe+xW1Xn+TkmS7Xp1x4zMWb1/HFQ+hSUSOVAiaNL
        bqgOH7DiaptRgivLODHmliQ/I41untONwwBdbzI81by62Knja621Vr1ogy1nNQ4W
        Oiig36VwQeKgHTCGoh0G7RTBiHEKljV3wnOqWOpQzcLRrgP+uwzwgZBfsNTuR4j1
        LMCXeEp4ykWeCusZolZmGRUWQ1vZ3hsnpiLNKFWkpXgRYbPaYkundM0WlMn2Z4uB
        u1lm5d5sDDNMtZQ88tZcIVXh9OORiUwM6Dq0z81ayX86GJ688ahUX46usmpiDI9/
        dbC4KeYH7Ds1X7TdI7Nw==
Received: from can01-yt3-obe.outbound.protection.outlook.com (mail-yt3can01lp2171.outbound.protection.outlook.com [104.47.75.171])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2ybea4rt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 20:10:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLofWOP09SYM1cpa/iTjLzuK+3D+DYZbZLv/m5V/suEriYbuxU8Rz/WKYHffQm7x9OM8GhJu5ECEn0yLay8G4r0cOHZxki3OVxrFhhTegKxI8hErxLb52QSlNiaygZTIHo2cdshAcQsEs/DqngkskrqD2HukRDjD1BjrqxajqDSk6/ZlLZWm/Vkte/YwjsRclviBWyDclzM6trp/o8ARsuemNfoSeYevrKaAzy/TABxHBxGegCem4t+gAq1cQw21SJDAvR0yQKkSnGpUYHqE5mD56fkImPTKMwbQK4FAwyRZ5Edk08/T/cQVFd88hEA2o9vK8uEJ3Os2wDI5Byq7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXZXmq4MGP77f500NxiiocQHcEIzgSCE/fy0i+2vI/0=;
 b=FkrkKIDC8mQ9gTLYr5v/oS2O5aK4WxAZq4l09dDdcrKdF9HmM6eei3/kfrHUC/wHQ7k3xk9Pl+SgNYIT2hKGaYiWjlAz0rwY79t17cD8HAXHXmDpVLNWvoqZS8eARWFgG8JHOICOdq/FPw6ejLTFTIo0rtOjLjIJePixMELAZL3m7uikwpjXWMvo9W37PGNoeFxaSMTB2wNs8xQWD1gR6Q0EjSMBLFVuVJ4L8vOCZ7K6rvzUhnQvPx4iT86peqzwQzOMn6MY48jWzNQureqZoohHFAgLCwhL+1S3yJ/6SQpO3HPY4HRYu5MlM4AK8269uyeWe+xV7lzJBikt935/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YQBPR0101MB8912.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 00:10:34 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 00:10:34 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2 1/2] iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
Date:   Thu, 14 Sep 2023 18:10:18 -0600
Message-ID: <20230915001019.2862964-2-robert.hancock@calian.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915001019.2862964-1-robert.hancock@calian.com>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::32)
 To YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB8838:EE_|YQBPR0101MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3c42ae-fbd8-42bc-2b37-08dbb5802e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkGGqaKmhE1mQKCBtWZ8HuXqVyagGb+uCbeKtVxlSn7OmFlQbkK6Fym+OO5a592a0/KrbqDBbYAYA2zRBISFz3V0CsbUeLClKwnYCo64g90x7XOGqo7h3vDAGnAC9Qth6Xv+nIGur3utknjLydZPVCUSUrXuFBtzBdy4BURPrTeQ90seLR5AVLCxJafrWGDQWfI9j/isUR3bdmRCX/pvMo/Dk8Pwx+/Lq4AN9IQVIfuOLuia4WvH8mrx00WL/Dcvktp70G8UyxEc+/8/hX1EWjG0BM2fcaabPtVhhA6gemT86HMbynOQ3yNf1YC1yIPlNI2XXYiuYAiBUTcEg/7pAdZBrcLrEcPVxkX4D8LtsuIcEefvMyEZXxA/xm9PMeKZrsWvc+26qxH1IFC/Vt633LvzI6/nNN8MUj+rm2cuUE0RwF+P1xkYNNfV1P8zYFHf/p2Jzx/pPK/bSdKktL9tpniU8Aac+Z55RZn+9kacXXWoNC7/7n8OqRghA5XRXRkE8NqYk9p/6d9PaewCslO4GVDjBbEytj/f4/Cc6BeMyevlL5eX5RpbRWoesZFFKjYn1l+iulNzs8PrN+3jbzwZ48L8CgCTVUQSgQQz3gZZiT7Qu0nZe46b5T5l6lEkkiAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(41300700001)(1076003)(107886003)(2616005)(26005)(6506007)(6512007)(478600001)(52116002)(6486002)(36756003)(6666004)(38100700002)(38350700002)(66946007)(86362001)(66556008)(316002)(66476007)(54906003)(6916009)(83380400001)(2906002)(5660300002)(4326008)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tkYCVsOF+fgbo1rQBAmg+8sR4Sqzb1ZHYEKKFFa6hQ9XebrLa2uzIPRzJNX4?=
 =?us-ascii?Q?CsuFs6JQ237oGu+bFSFAwKHv7eT3oc0QaMD/zhG/Ti4zg+yAK/Pot4r7gpL9?=
 =?us-ascii?Q?APM0ZENDFgDmJz24jXYDdwo8/7tKghMVLhr9KQwGg3KMjv0XovkLYxI5KwyV?=
 =?us-ascii?Q?6D/JWzgMFaI8CJf4EIMY/S6GjVZYTmbYth0hfNN13jVZJpmOItRCM1kQigMD?=
 =?us-ascii?Q?txWy8ywhy7yQ4bHYnKO2c8vfLX1YE55s2Hl+97tf7quIQX+4YDmnHAYJsZ6v?=
 =?us-ascii?Q?aq4ISxs2R20HDwIJ/CmgQnq4ntoVHzkX6IPXaWtcvkt7/EVtqihZ2a4qzMzI?=
 =?us-ascii?Q?oYa/5adNIiUSpNY+HNaNYQaLQ0EGs+83fzoJx0VPCZ9YL5m5QFSWDNx1ECri?=
 =?us-ascii?Q?xVlvK29C5SHokNFCU0TU1bD9yUeT31ebmqgO6IL5WmOrExh3XiNXMeOs8MVy?=
 =?us-ascii?Q?czYVN8kK7LMY3adhmHNnhW5c0iI6/YsqEnJNeQWzN8fHifTq5diX7Apdouze?=
 =?us-ascii?Q?H+/pzV08jnm+P+SxgDo8gBssXvq1Ew73ZpNxy3SuQASQOxozhSUhR2nPQ9tf?=
 =?us-ascii?Q?7FtRbefATQyYMYNqiKeDicxc8XIIqeHsYcHFomQycqH+TUtuLVu+8Zi8KMSx?=
 =?us-ascii?Q?2a+wxJv4pDrQaHbvX94oU56CIaYPZjjG+6T8FctfnUZDFT3HEktrZZSA+35w?=
 =?us-ascii?Q?kJHyyoWe6J4a05/UoPoNz/I2ROxm3W+t8Ve3H9qtnovKqh6reW1BuJYvrrG8?=
 =?us-ascii?Q?6GT3ceMJPlySoD1vbwQjcdWYronvGp5PA5zz3uU9nD9UsTMGVhdGNjjGVGcl?=
 =?us-ascii?Q?RhRrKzzSPsIzVwbOSeI7Dw3czBa9UTcjjXeinyEqPYCIVkWPUgC/YnTkTpwP?=
 =?us-ascii?Q?VEcFh+afHVMUQ37UI55H6VFes2K6jQAHKyQjKvt+TqkfQ6VDswo8/AXJPZN2?=
 =?us-ascii?Q?dvla5nH5DdhulyVJtCxeStK9Wqw3mVeTG8casNRa2IR5rQL2ZqIwPBobXXFe?=
 =?us-ascii?Q?VzfMKfExhIwRQ2r/ksLuCtz7QZV0ehEUKbh92zIPPB9m7IuN04ZKYuxUuMgm?=
 =?us-ascii?Q?HaX5kMl7GVvxFiGp2mt5oj9qR3bqnA16zHfMV/mtQyUKsM5n8Yn8AlsMgIVJ?=
 =?us-ascii?Q?pIRwyW5BLGJXbKeF7TzXNwXNipkVIr4jIsK51WR7PK1omEpdM1Ox/JCk6lLj?=
 =?us-ascii?Q?4NFoUA5bAvq/P7hYPl2pmfuaF5hhFgID0PTkpuWGMlC9Mp3pn8bAYe3hsRe1?=
 =?us-ascii?Q?AehfNnuklcAJ/oxWQWFGd2KBsy1a/XKiTDaapmXYEu7hLfCiBoVQVcE9NXWw?=
 =?us-ascii?Q?9UDeVR8qd/kZM9ORQH4FVOdd5A1ahXGMICoORksNntPzbeCyhNURHJwo/zkQ?=
 =?us-ascii?Q?hoRY/iAWaMB3BqWYbYDQzeoBzTRnI4XILorkhYNa17l7dzDILSRQmP5vR0qR?=
 =?us-ascii?Q?tgV82qX76w1NtS9ZX9TMyGoxekTrbAZGwJ6ZUA8j9Fh98YUPBxURJ5olSQdt?=
 =?us-ascii?Q?EwBLAv/WXW2x+2Nzo/JgwtgOBOuRlexdpcWxSd7PrQe3AHDntKnuPDxDfI59?=
 =?us-ascii?Q?SJjKh4oSOA06h5ENATJziLmRdO7ddV7A3Zc8RK3xZAFy28lZdTWLDZ4EIIfd?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3I7KLq7SpoG/+RTRo09GtK6ogJIsR6Hmuu6YBI2taM7wkrPp3tNANp74La31zuvUzt1DK3jQM9uDPHJXqVz8udND68/ZST7VKXbQ3tGsDm4bNgz6/uczrdm38X2k+VfF/Ebh6qnsiFWtzLbg+zJV1LUxcu7YN9R1UhQYiSd5uA+mDEovxtRuEcS8mqdnjW4FANULDTlSUpD/QkduQgR7/bevik4MO0T4QFXAFprn2FSakA0+VeYexDUlFsiPQl+GGGf8uNgYx6k0OQ6GIdFWCzKd/M3pvQDkAVVD42KjsmGt8qKR+mBI5ejsqguVxCOyj2oCN6bBuEcjRwl2tsR7fCbflHabnjZ+8jatZ2BBvsyjnE0cTN1u0ku97apVksofb8iwasFoL1H0qXLe57RsiHejWHPCR57zGTouEycKpg54Q9EGJjMbKpF2NofbBsDJW93ExhLGLL8t2ewf7d8sj3STMJPtgu1w/v/ISWnf/O7zrOS2yqAc4p0EBZHBRc57GATefZdBuuqbY9RuhvD+byXEK3Iq2HkHtKLVER1wxiLzU+I+sQfZULbA0xM9kVz89CXf5uYETPYAjLVBUbaSR947svvmFpP3dozfrfGL/wwsfreFIloR1Nfdy0/C13M4J7vDjIi/DrjyWXJf1yGkGSnlLBbiPFv9qzF83fvlqwxjv4kOlgBNv2OWTkWITx3ITZmFr6j8jWIZ9kZg48FYJrBF+yYM188x5QiSC4RklGm5lT7lZzo0XZutsNIHKCY5hYdT7yNxd+ZXndXnEfgg6dri4/d5LQ6OUUA/TW6/OpQ48qWFEk0Q7Zi4w4Hc0vbQ0MMM+sNCiR4gyqIkg6phmKPgnvIBKna2y/HfpS46blAadY7x8FIyHJxkRWMN5KP2HAqo7SWrAYy+C+ER4FYlkt3ifu/HxixVEgPgk88H+tY=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3c42ae-fbd8-42bc-2b37-08dbb5802e34
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:10:34.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3gnKIvJtP60oCEXi4YoFSqlOzIdVKIF4Ntr2zI302WtaNBbrxRsu0zL+3ms4H/E7q/Xo01UPo3BsuiWLHpzPxx7NLr8jYPm5ZN2vDIu4X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8912
X-Proofpoint-ORIG-GUID: 5tQLzZwQHT-0fbtBb3P4StlQS6WM9qiO
X-Proofpoint-GUID: 5tQLzZwQHT-0fbtBb3P4StlQS6WM9qiO
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

The code was also disabling all alarms regardless of what enable state
they were left in by the FPGA image, including the overtemperature
shutdown feature. Leave these bits in their original state so they are
not unconditionally disabled.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index dba73300f894..d4d0d184a172 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1423,28 +1423,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Disable all alarms */
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
-				  XADC_CONF1_ALARM_MASK);
-	if (ret)
-		return ret;
-
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

