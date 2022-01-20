Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491FC49454E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 02:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbiATBDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 20:03:54 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:1740 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344023AbiATBDy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 20:03:54 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0w4gU013047;
        Wed, 19 Jan 2022 20:03:06 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2050.outbound.protection.outlook.com [104.47.61.50])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dprrpg6d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 20:03:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3JIZ19RWcERIIq1c4FmJQMEqPHlJEsGn+UtEQ/cM4y79VWpti3oKGhaKiG+r8cM3Zp+UXJMt+oGRJVFB/6yPWt9rowey+vaH34wDxQnuM260hbeQettel18FBXscQszb+GRgoZEGvEtzocDoL1KRjaGCo4s6QqcyKhe4h+H3cf7LnBrFgHKUfBH7vNoh8tlUwRc4RsKIuw/AaJkXY9zLJWhQDpk89oONvYzkpc9Q02sA5xC3gPDflo2wmj02z9uiUCItvS95xB0rKoWBMmVRx2fcTJxZGvAdwXGiDipGNJvEGtKUSjDj95b6aS7995nDX4GcoAl4MhVSGi3vNWutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EbvfIK5ml9OrTJ5NUqULhZb2XjPh8IkhcVRUz0ltH0=;
 b=iitRv6JlhukxER1wS3NB7ESMM+/mvPaL3g5ZVVhz5GEGTPZzpWFbz/juOVBCly4NpSNmOFF4GuMOhReZB2lQPKc3dckBNDbA0f/xKAD14lLMydIR3XvBZQNWaMQnBTB8o0Og2GlPy5Z5u5KfxWy+cVoFAcMf0C4mo+75wtY1acu+unWX+pzyFh9YA72v7KA6jvgRAGgyrdUttNkqOl2hIxoHGcCQfyazS4aiC6zizuPDFQPScm0HZzV90sgWn25PvyRwC+lBQIDJ1DkAJfjykJR849XJ+33v1DT1JlTbvx84Z4QbSEsuidhprPXCVLQG1q94XEgG6yfOVJyaZ/sJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EbvfIK5ml9OrTJ5NUqULhZb2XjPh8IkhcVRUz0ltH0=;
 b=wvQCTpTMqCfJOpqK5vK/a93nXR5bqR4+ic+2Fv4iixoCMu8w6NgF1tfNdMLu2teJk8LtgNAWt0oWIZQ49vKNQk/EFiqXdZ4o1mVXYx2AB3lMZ17PNu/5sqkW4hoDvfsz/mn4hEFZ6hIFmss5ygivlz8+EJiMoYKgRQgAV/xnpVY=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:20::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:03:04 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:03:04 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        manish.narani@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer register settings
Date:   Wed, 19 Jan 2022 19:02:45 -0600
Message-Id: <20220120010246.3794962-4-robert.hancock@calian.com>
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
X-MS-Office365-Filtering-Correlation-Id: 011b6738-58d0-4fbe-ff8d-08d9dbb09d1a
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1065:EE_
X-Microsoft-Antispam-PRVS: <YTOPR0101MB1065CCA2F862223C31D3F67AEC5A9@YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxN8bjNkJaggdcqWC9xUGOJNjO9PJIzn9ijioHIu3CWfeMkmbaTDkfSgwZ+PGamKobWoLIGMgCQkZHLar4IV4il4v1kNdY9cQ3RIPPTyjuCWUa5z4ZCTl5Mi5W/WcEaeqAxUum/nPe45491SFifg53M7lmRRSOMcylXSU5UHb+DfG3vtmwxzqnCwNvcPED4OwSrm2HxpcQ/2mqFcN2Ttxir2uY+otsR2Hkta7sV3Pi23TZVHNbKSEISyzvQkVgOkU+0Di5MgXiwg6dkUs1r0NI7Forbm+eOV48ZVVAA88zSHCzHB+DDqdJ8EXK07xwHoxjMzuhkRvBKTN2j1UnQq3jGASPGOzLIK6tKKMCGC3VvZ3RVgyGP471ErYH/ZLdLzb2lE26FPkC7Yck/nnQxQltKEZHz+hSijMP/+IvJzjzmM1VhWiWOI2/d+hRT+iGzFtDW/ZDUER5J1Md6hmCE31NOlYqst6hh8nYkm6t/kA5AAbbBBHnlLXumDjRY5JzmjMLOyBBqcFwuVnJfoPVWZBWTGLaPmwFe8W6xJhCTB/e1bszRFZD+WKzqDxYIV70oySO7kxaG4+TJSUirxWGQ22bfKs3AGRO7+TIVASvCl55Bl43JuDwBsN0epmmzNbAHRqPBzsNhhwif1OhnWpnfLuBbFifkmX9ulnE8BlQ+WWo8mVyM3yVPAJ8N4+T+uUXPjl09WaNbd5McKdWBWqp4wxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(4326008)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(1076003)(6512007)(38350700002)(26005)(36756003)(6506007)(6666004)(38100700002)(52116002)(5660300002)(83380400001)(6486002)(107886003)(86362001)(508600001)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dr56mB4dIzXdo6f5X6Lsfi0zYdS450nh6b01LCssrj1sWVdmUfLwPHq6qTQW?=
 =?us-ascii?Q?UcsspGohvhu3z9oW3Ep4hFCCI1YTiqAVPBNOHeKA5WM2w5b1sncJgCDSVoMK?=
 =?us-ascii?Q?WSwE8ZCCqznXJlVKNgoYQuIVuasSshu7riiczpgiyFjZTRlksJ/vCPG1/htk?=
 =?us-ascii?Q?4Zk0tWyPlDcL4wmPbZc2Jmx6x6kxxYCuwly+rEKWu6BRHiLPRQmlBeZE4t+O?=
 =?us-ascii?Q?k4A/7Hiq/rFL9oTZGKYnPGjS6lC0JVBSKYrLqV2a9LKNT367xwo/dGMZnBh1?=
 =?us-ascii?Q?YUTP8eQresLk7NQfJq2bK+A7UGjaqfRWr9wTTFZQvMszkeZA15iZdEVmMkZ1?=
 =?us-ascii?Q?DUeBAfA4C2GV7DpFRpBiOTsLYBVJ0mRGWW9NmQCaAy0Dnlq/db5YoSh7PUax?=
 =?us-ascii?Q?Dj9XWsz2dogWTXWApq/ksOLWvjXAoc8b3T5johipz1is6F5ajHacZgiWSPRd?=
 =?us-ascii?Q?tDCJGre+QRPRAkj3jNHo2Wiv0cs907Uq9FoYkFMF4/1PqwMl6p/opSk2Bm+4?=
 =?us-ascii?Q?zVyKpStUVEQhvRSGHPEqbrE3mVPhIIOn1u3eWg3UKyG1ZlsB6pBFNPh8KoUb?=
 =?us-ascii?Q?zxBX6YbEWItaqnuFEj5dATGuo+h1H5vJj3QG6R3AvYXUdA6ie3zR0tdRJh84?=
 =?us-ascii?Q?+sLMTPxk9sWKIx2FmGN9b4iXopoSxgKF/5zLXIoGR9CL4gbed9JHaMFUEubF?=
 =?us-ascii?Q?U6pwIHrW7gnXhOEsdhgNDBPUrDyX5eu7x0mQ82TFUw1VWEgTADVGm9XKHE0/?=
 =?us-ascii?Q?jZr3YY6zxSJ+qY9Futst2WV7ncDeIy+cqxCoeLMHuSSiKoXu78yrgBxW6fD8?=
 =?us-ascii?Q?JHjzh9hFYJCIPsHSlhWWmLiXPFgKZoDAIoxwwfPIbRjFWsVyXLlP/cAndD8f?=
 =?us-ascii?Q?S1p5BwF5f0pSbtHlk0IzyMthU2gGWi26W2QKYP3qmwvMDawwnrOe61c6Kgmt?=
 =?us-ascii?Q?svhzBVVQTuB4y6/ZNTbIichwDe3ZfbJSTm/ujHHdVsAqQLk+yS5oJMYmEd9D?=
 =?us-ascii?Q?Yg/2RF3mrpRjPimtpia0fq3+gUqHJElZV0/qGtp0AIS1FavMXGoKZyPredHW?=
 =?us-ascii?Q?1ClFhwzz8WbgPyurtXxZqNTlo+8JJ9tSBXJBy6hJIL/KiYMNx6KNuFNAWVoH?=
 =?us-ascii?Q?HpQ8S6I+x6JjWfA+dmfW9TDXzfquAKCcVPbYeOu75vnyF8llcjScvTzPi8Mz?=
 =?us-ascii?Q?WIHe1cBflwvRin27HbYIEflxkLeaiZXXDUnOuCHkVRyYisDo/DT6SvKBrGgF?=
 =?us-ascii?Q?TfxuKNIuFS9Mk7PCPEM6/CwMhd4/fFsHgUOrmr8UBxrBn812YjTh/BYmluy4?=
 =?us-ascii?Q?9yE+MovbNorl73voaY8qx6H+jhoIPZ4+ATyIdHMOIK5NOBnH7uH6VFcU71IZ?=
 =?us-ascii?Q?FkW07YtdLcRtrTRu0fjswIEc0ozIKVeey8rrFEMOMexzHLW7L5DR1q4RJigs?=
 =?us-ascii?Q?GEDOgYECAAT8AySRQYFs+BYTqNl2eAxX3rGA2O7OiWUS4qxmOjbRlm31Z/jb?=
 =?us-ascii?Q?nhCkMZEKSDyB4ygHVWqA32SZm+yGyiAHe2nsMjbSXKGqxmVPIiIUYQRvjLRB?=
 =?us-ascii?Q?2d7Vfn3RD6kjmrfHij0y+XKrP1n2Pky2yHgQT4Qr9GvmZFjT3+vvmgd/Qgwp?=
 =?us-ascii?Q?GL+ouYRos1s6dOuVfHO18KJAcksJtgxyKaCMjO8Hr8xwtUVNZ3bcDSaB26FH?=
 =?us-ascii?Q?dyNeEJeh7iP5eODlv9XAYxNyvz4=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011b6738-58d0-4fbe-ff8d-08d9dbb09d1a
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:03:04.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elipaSNEpWqqH0ELe2t9xha5jBOTHQDdW3bmpdEiC2vNPFSKpApQBBTlKjY9Z4ZBnLeVoszw2JOe+7v/CQSYk6pblfNGnZZ0CE6A9IF4Q4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1065
X-Proofpoint-ORIG-GUID: v3gkoeNrc1juhIkhNxG-F4WLTeZXyPo5
X-Proofpoint-GUID: v3gkoeNrc1juhIkhNxG-F4WLTeZXyPo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=958 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200004
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Register settings used for the sequencer configuration register
were incorrect, causing some inputs to not be read properly.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-ams.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index b93864362dac..199027c93cdc 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -91,8 +91,8 @@
 
 #define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
 #define AMS_CONF1_SEQ_DEFAULT		FIELD_PREP(AMS_CONF1_SEQ_MASK, 0)
-#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 1)
-#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
+#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
+#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 3)
 
 #define AMS_REG_SEQ0_MASK		GENMASK(15, 0)
 #define AMS_REG_SEQ2_MASK		GENMASK(21, 16)
-- 
2.31.1

