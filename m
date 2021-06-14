Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551683A68D6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhFNOUr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 10:20:47 -0400
Received: from mail-sn1anam02on2139.outbound.protection.outlook.com ([40.107.96.139]:5633
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232809AbhFNOUr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 10:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvTyKt9aMNoZvdsqGBE9N+N4wOQMtA1c2IojFlWUxTgtyMPK+paklUook545tfOMpEbOGr572jiSHbbOs7KrzUYdDWsczFpfVOZCY8OmXoeCCSU7llv0iPf2/i+O5XbWyHzNMNsgdqcBZGUiyqQ0tfSfc++JdFPOR9m++GRNa7P7pf/j02XabjHjHzGNeFScOt/6FcfRagG7QIESYAKEpiH6TiPLfPjTjpvOLh6H25JGHPyRUTIkARAkzMWyi6PJuYMiQTYqjay0b7zg8+GFcwT2a6D4ukx38PGJxzuJOI06f8RNqvoABkgbmbfUnKsDTv0fYNZ6y1k9bEy2IFKYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGdGP15G0/Yx0YAScpsPWwkHCYPP6vXxTL0IbPZz0cc=;
 b=DTUlA9pcH3zrB3tPmIKz0Y5Je2TQRDIuIr1oz9jRtcLVJU+Mu9GnFZj0Cg9K1dzXZ9lS8dUu6zXh39Yj5NzeWobccDzVxjtjMYTzlq4RV8Xhv/LOdeKyuNEm2V5auueJfqNEoIt+3jO1DMqNpSWun2LIgAQv81BTc6UGLYiBZzjBC2Qcy+nHeTVn3wPp0l7swS6oC1QgUVezywYU7S0NW6pxJA9yPTsRJKET0K5bEn+zYSHL3b27tOaptK1jWYQDjTeBolLCi3MidF6SNlV/qO4DrydrcJ1aeToqzk46xE9VtyhF60nsnOigXXKhckmYwXUbq98p/zccS/9B4PC05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGdGP15G0/Yx0YAScpsPWwkHCYPP6vXxTL0IbPZz0cc=;
 b=ecH6rD/JpiTMq87t+QK2css2TtOjWrm1Y5TeUBv6oRh32UvcFyxxdZDQCKp6mnB22Y0fB099YXcvHvtZkdJ7SxJDeCBK+YwNkT0LwjOrWH2w0lIQ0YoTQr4Q3J4z2iv5qooDUOq7FkgDhJ27fxFoUOIPdCr/SwTEqIHdcTfF63o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=licor.com;
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21) by SN6PR08MB4573.namprd08.prod.outlook.com
 (2603:10b6:805:9c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 14 Jun
 2021 14:18:40 +0000
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::2429:8693:e618:f534]) by SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::2429:8693:e618:f534%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 14:18:40 +0000
From:   Chris Lesiak <chris.lesiak@licor.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lesiak <chris.lesiak@licor.com>
Subject: [PATCH v3] iio: humidity: hdc100x: Add margin to the conversion time
Date:   Mon, 14 Jun 2021 09:18:20 -0500
Message-Id: <20210614141820.2034827-1-chris.lesiak@licor.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2607:da00:300:7::2]
X-ClientProxiedBy: CH0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:610:b3::31) To SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bee.local (2607:da00:300:7::2) by CH0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:610:b3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 14:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f20ae6b2-3c76-4402-9bb7-08d92f3f4eee
X-MS-TrafficTypeDiagnostic: SN6PR08MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB45739611F03E3CB645BFFAD69A319@SN6PR08MB4573.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2jvgSfnC+8Kh4o/9CUi/9vflaM60GVxToTPS2ztZ2RgsLtpb5zCpT6tudf+Ejk8WeTdRMDqc1yaBW9VXwteBWuoLApVpW+jG34DjEILEnLikhkuB+dU3HjxNK0C6muG1bHUqdpcB5ORxa8MaFqwb9crVmqThKcjPRlfNdR2NI6nHJd9pThjBbWi8G8JSFAacSFhsLkhfblxy5nQSj0RYb9kv8ACZ8b+GYXAQuiAsr7UkldNhfYAPj9LxifGS0JTYeOdAQ0ZohSekphdfIs4ZJEIg426mi9fRVGhFLh3TrbNurAJmtj53HDp+Nfajj9j5VJUIdVyJNA8+4mS0knbryjFngsOMPBko7DMmarlZc+AnyAxHraZYV1OdmfNNrKrsYWrStxctjGW2KYrUFxcvLSrmnmQdVOceHrIRAFpI9aKft3jNzeHRgwykBTNyJUCyBY7iTEJiPuBPWxocmivUuF2XR79mU9mgCr/vtZU0I/ebIFY0Nvd+TEQyDrZi4JAipVZzBtr27paRFCokkqf2hcHCiBORLoXrxv9h+FyCiHv09ZE5Xm2oy0ZVLbtt94GarnK+PigIfU0WJfK+5LgdYxs0JhgVe8e2DpTlmyWyXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR0801MB2223.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(366004)(478600001)(5660300002)(52116002)(8936002)(8676002)(66946007)(86362001)(2616005)(83380400001)(36756003)(6916009)(316002)(107886003)(1076003)(44832011)(6666004)(66556008)(66476007)(186003)(16526019)(38100700002)(6506007)(6486002)(4326008)(6512007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SLykHxm8hWTJuoCELX9xIbvjje1GAtkYecnxWMMll3pCw4tp2cBH49kKvkfu?=
 =?us-ascii?Q?3qWKocX1FcFCn1MJhh5/lhldn97IA9qy/+GKNAedPukpPBugnRb682fKHBbt?=
 =?us-ascii?Q?1JxBgo8IjpPYslhaHM9cbsrP1rgoIYvGPYrQrUxl+qx/NgD2KwNHi3c8iwNH?=
 =?us-ascii?Q?YVfwgEKhxqd1mp7+uhoR8lLZSvuCwttGi9jeTip/Eofg4+1W9tVPGt5MuuQJ?=
 =?us-ascii?Q?rxQUgt4uXZJmTjMnFwMzrqzSt/jiPkH3YmQHQ2LnYdib+DSs1m/jboiZeEzK?=
 =?us-ascii?Q?MzSJMrPnVOVZ0fKaikEVciKMGpUyY6m5XDAYg/XK54HrQh7DQD+CYYhQNzrv?=
 =?us-ascii?Q?nu+nrSvPX+iIMxT/nwkl5lr7u9b6m/b6TT0Ka3hp/AWKRvzl2TSlTBmAUwh6?=
 =?us-ascii?Q?XtuZPgYsyterdbohi/7C+lU4y7Izc9l+ohS6zz4jhzFqTXOlz8lRMNJcx/F3?=
 =?us-ascii?Q?fhM7mbpyq3F7zaELhJKDOusrYNY8m73uel964K6kgcQJpTLq4L54HXB+cT3+?=
 =?us-ascii?Q?ZPGBIGVhw2IK8x6vMuaSykYtBJqKaJN8X7ZSlv0FTq9eqMrRkYy5kU3hrnnu?=
 =?us-ascii?Q?hMfO1+PAP+RVftdV70+DoLvX5gYVcWNrGeVtmiekWcy3ylQonulN/KvgkJYD?=
 =?us-ascii?Q?PoCfraoSR9k4VCKSNjARp1ZowPdkiYkBWD2UhfidN+BvPGMLZJQD6IuQCNJp?=
 =?us-ascii?Q?mds7ETOYp80T5rJsiLOXtrcWFy3yNPuxyV5JR9jiK+zy+U013czN7QwzP/RK?=
 =?us-ascii?Q?PJY6kRk/dRGspqBGpaXuZc7sSzm9eMIb5HCvhCytPBZFr5ZToDYog23h14lV?=
 =?us-ascii?Q?9jkEiIikFHWdM5bVLm3moWEJX/Co5IKEFEQSzwqiL2Rq4wgy/PMJPvHdm6LB?=
 =?us-ascii?Q?OIbPGyrgJ4Iyv7Ei9RMgtnPTSbOAXqcTGG8MMfqSAEUmDDsNOi1aoNbX2e8r?=
 =?us-ascii?Q?uAubc+TdH/r9hTY0WEC2XdlEsNdyAbFVkmazSK7AA+q/W5PlWQhuuUU6Nq+n?=
 =?us-ascii?Q?MfKnVc6VKnBzTx3smXIB8dsevndXCccoRZK8YY9VUwL9oEyEEyDYqwbrqIxy?=
 =?us-ascii?Q?3iy9hUMUCNSRcUeCPuioAyBACj9ixrdShAOI02svMROEqSx/cOWtG459B84r?=
 =?us-ascii?Q?WaO1q3/BRHu6ST0D4Pv8Ms8qs1go/IEjZIbpWrJBb/M2dzLDzUvkZZYqWpJ0?=
 =?us-ascii?Q?3Tf+5+B8H74row5QcP+oh3Uy0chI8IUHtPzMNCg5CyF4QPxBbV1wgFHeMk6t?=
 =?us-ascii?Q?zGJ3YXXvp80eyDtORo/9QEr93dsY4eklQ4Mx/WtYsqXh1/27vwItS01PLJCD?=
 =?us-ascii?Q?7dYXxmWbJauANNHl7M46bcRZASeKl6Ka7TIDrDN9/K2TfA=3D=3D?=
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20ae6b2-3c76-4402-9bb7-08d92f3f4eee
X-MS-Exchange-CrossTenant-AuthSource: SN2PR0801MB2223.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 14:18:40.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+LXiaIcjSCSqhyJqOwXHRq93WgjLjrgvUGuNwxOSEQKgnpKzrYX3fXhUQu+xRkGoy1PBk/vW1Ix+XnbzrnBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4573
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The datasheets have the following note for the conversion time
specification: "This parameter is specified by design and/or
characterization and it is not tested in production."

Parts have been seen that require more time to do 14-bit conversions for
the relative humidity channel.  The result is ENXIO due to the address
phase of a transfer not getting an ACK.

Delay an additional 1 ms per conversion to allow for additional margin.

Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/iio/humidity/hdc100x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 2a957f19048e..9e0fce917ce4 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -25,6 +25,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <linux/time.h>
+
 #define HDC100X_REG_TEMP			0x00
 #define HDC100X_REG_HUMIDITY			0x01
 
@@ -166,7 +168,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
 				   struct iio_chan_spec const *chan)
 {
 	struct i2c_client *client = data->client;
-	int delay = data->adc_int_us[chan->address];
+	int delay = data->adc_int_us[chan->address] + 1*USEC_PER_MSEC;
 	int ret;
 	__be16 val;
 
@@ -316,7 +318,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	int delay = data->adc_int_us[0] + data->adc_int_us[1];
+	int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2*USEC_PER_MSEC;
 	int ret;
 
 	/* dual read starts at temp register */
-- 
2.26.2

