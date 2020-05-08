Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90541CB996
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHVOy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 17:14:54 -0400
Received: from mail-bn8nam12olkn2109.outbound.protection.outlook.com ([40.92.21.109]:27518
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbgEHVOy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 17:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZbPx/KaXttFIodfVyelUcoJ3/CpuMF+UaNLHU9h8rahhln3RBlIPhdNJdZ+B2P4/k1KKbPnwwcU4/oKV6mz6rdBP+ykci0QpZNyOx5GYwtRWg+y52vppzDJlQ085vbsa9zPKcAzEnv5JBkadoZ6c4NCvxjAiyW16qI2zxyFidxdh90Fu6UFa3o9xypfKnVO5apuvk1knpa/wn9b8cZNE4lOcXb2zuBlwGOtU1d/RJfLRHH8k2hygiuvg2C1wQX1qLEoWwG49CBI6T22d5e/fiBF4zJKHnQahfSauItsAUTyGsd3ZPFFHIT3bD9tURNNn4GRs5CpTv467KTYI6bwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaJ8Zvg8tpP+6moRgpB94Nh4d/XWf7CQ/9uwfJ1/qdo=;
 b=bwrXFwKyNCxC2cQPpcljySwl3lpM2YOX+R6j6/VpLav283Jybh0hbYSv90TMNqmIS7jTI46iC6jdtq+msoXrMEHxU+r5pTZfyCrCNkoqoD7kYTT36vWe32KihXTg5g+b0blk76x/xeM3QniFqQZDLHR0Ok+v7zIhhoqUBEx54IGMLuGDwz39qFypQ2S77Neb/MO2l3Z9yqnRawLPThHWi67oVpHfT38KBak0MGA3c67hR0Cp/GvewqGtUNGV0xi61OZsq6DPR/jNppNTVZPQrA5mdmdRXT9UnxgJ3krnuaDosZ9xDV6Upf9aINXhJNWesp0YW0vj8Vwj0UvU9vcVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::45) by
 BN8NAM12HT050.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::386)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Fri, 8 May
 2020 21:14:51 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc66::50) by BN8NAM12FT021.mail.protection.outlook.com
 (2a01:111:e400:fc66::391) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Fri, 8 May 2020 21:14:51 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:06776E2FF24144209A2E0CFDE5529DD976ACD0226A571A4F9737159889DD865E;UpperCasedChecksum:6E73B9349D8014CDD5809BB51FBF3EF60F3141EC88BFBC2FAD0D8602A36CF634;SizeAsReceived:7927;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Fri, 8 May 2020
 21:14:51 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, kgene@kernel.org, krzk@kernel.org
Cc:     cw00.choi@samsung.com, kstewart@linuxfoundation.org,
        mpe@ellerman.id.au, m.szyprowski@samsung.com, swboyd@chromium.org,
        tglx@linutronix.de, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] iio: adc: Add scaling support to exynos adc driver
Date:   Fri,  8 May 2020 14:14:00 -0700
Message-ID: <BN6PR04MB066058A68D6471E7F6AFCFF7A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:301:1::17) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200508211400.13529-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR11CA0007.namprd11.prod.outlook.com (2603:10b6:301:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Fri, 8 May 2020 21:14:49 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200508211400.13529-1-xc-racer2@live.ca>
X-TMN:  [D0Lq3ThbWiHpFKsiIZ2c9S5/TxRcltNPkVoqalZ8/AC7xtCR6s0yTYXgeC+C+4AT]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1ca81421-2e72-46f5-4651-08d7f394d871
X-MS-TrafficTypeDiagnostic: BN8NAM12HT050:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHV94a6LDtYwf7UWI/VkBBkvG75ICpP/7DHtTeo9ioeHHpnCQi0baPQVxfVI0j0deY42hTt4apCc2eDznGdeLxbuXiBJy7IHLQ26vFhYmeTQFfF0gBXKJfPmjp8E0iBs7yTNddw9L8gfmJAwXbZWo0TudhqfxUiJ1zFIIxBI5zASIOBn09tb9z5LsGKAy6CbistGHifvT4pA8ZPgzpIuMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: aCfHowuZ0+YX50DGnPFmf4cJs1eoati7OQ5GX8+Ai32DToG+ZJvJGumMUUEm3qa6Z3OD63xOFP072rHTmmPRrgg0Vqv94YYpaPp+hMilzWhQ5ajTd/6bRVpsP22sE6rgyoH/SHXLC4SqpKzdoiIKsMB1lFHKfZKnyuX9nySBzc4N1LrxGG7JNScQvgfBCpzdBGxA6SlPJuNPQHeGUI8blw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca81421-2e72-46f5-4651-08d7f394d871
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 21:14:51.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently the driver only exposes the raw counts.  As we
have the regulator voltage and the maximum value (stored in
the data mask), we can trivially produce a scaling fraction
of voltage / max value.

This assumes that the regulator voltage is in fact the max
voltage, which appears to be the case for all mainline dts
and cross referenced with the public Exynos4412 and S5PV210
datasheets.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/iio/adc/exynos_adc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 22131a677445..9d29b56805cd 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -531,8 +531,19 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 	unsigned long timeout;
 	int ret;
 
-	if (mask != IIO_CHAN_INFO_RAW)
+	if (mask == IIO_CHAN_INFO_SCALE) {
+		ret = regulator_get_voltage(info->vdd);
+		if (ret < 0)
+			return ret;
+
+		/* Regulator voltage is in uV, but need mV */
+		*val = ret / 1000;
+		*val2 = info->data->mask;
+
+		return IIO_VAL_FRACTIONAL;
+	} else if (mask != IIO_CHAN_INFO_RAW) {
 		return -EINVAL;
+	}
 
 	mutex_lock(&indio_dev->mlock);
 	reinit_completion(&info->completion);
@@ -683,6 +694,7 @@ static const struct iio_info exynos_adc_iio_info = {
 	.channel = _index,				\
 	.address = _index,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
 	.datasheet_name = _id,				\
 }
 
-- 
2.20.1

