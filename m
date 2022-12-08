Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150B46470D2
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 14:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHNeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 08:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLHNeK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 08:34:10 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2116.outbound.protection.outlook.com [40.107.6.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19A663D5
        for <linux-iio@vger.kernel.org>; Thu,  8 Dec 2022 05:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc20KaWUIn5I3l7xWEXkviXf2z5a0qQq/ok3jARCvGQ/cTs8T8Fhk4pZjbZnsyZkvIB/IVqUw2Jge8sOxCGv13HpCreDhFB1VgFX3w5blqYExKFLq52/XKQ+EXj9sbEqrIbGOgoKa/tZnEo2k+twdytNXNf3RivL2ZENjcekUXzUqk9am30/pcIDArj4mRWICjlZOF222leCPruD9w8pTAev4uxuUCaLNP2mRVyxLJ13eR9sxZUR8G2/mzDbo23GTZwgRD7NGBKcxc0H/MDNrCBSoX19uAy2zofjCZKcCn3f/YTK2EOV0zemPkBkMTZahsa53YyhQPgE0/+U8EXzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZJ2m5D3AAl///uIXHBVleg7FxjHZbUyOOgEQAIljiA=;
 b=GU2H7IAz8i1F47c5xOnSOf4oc3bmqYkSqhoANz9mgjR1CcWDChwmffGahgSCiOdnIUfKKIerdpZ8i2IT7l8Ptgisd/ymdFoaog0yfbcw6qN5sOVVI/o7TJ5x5BYFcelg/tVHc9qOEO4WcPLpLng8ilGUZ+kCTUzLGHQ8aJBa8zOET5icOp/7xAfI4CWCqq3nE//ko3zud4dmEO63LrrMNdXBOmxnKd3/ZFB0gIYpNVIbQL83v/W/umEusbpqHfnfRCZhVrWC3NeLb8kLYKwjceEbwEgZCvXI4JEj8iJH5t/BTcKOiKRsY26pZSWSLhi5m+QXSKiQ2ewZeyUpV8YEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZJ2m5D3AAl///uIXHBVleg7FxjHZbUyOOgEQAIljiA=;
 b=GnAPB2cQaivncx7QALBgyBXrDC0OXhcEtMnJl5KPeOCsz0EuIFFF23oamWN9AxPMTUfWvXTLxEuZMUDQYn+fzu+eLCTvBZRzBlN7ccxBrGjB0jFP331EcPu29J9FghnnAXFdkMD6pTSHf0TOrOW2i4dBCOuD4cAirXzV5G64wQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by VI1PR10MB7691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 13:34:05 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 13:34:05 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [POC] iio: ad74413: allow channel configuration to be given via module parameters
Date:   Thu,  8 Dec 2022 14:33:54 +0100
Message-Id: <20221208133354.2980343-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <0833ed443220263ce068f5faec33fdef4435226a.camel@gmail.com>
References: <0833ed443220263ce068f5faec33fdef4435226a.camel@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::28) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|VI1PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: c25ec3c2-115c-42b9-fdae-08dad920e04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8g2i5Zn8Gez6VT8f1Ft0NFVFFVTm1nBjlu4rQ9w6QbtL+4sQbeweJJ8UoyD701RZbyMO/hywA+e7Hzsb4zeHkiZNWtX6g6WcDz00uUHeKnQpk8zEcS94h9ebgIre//MhVySdO2akDrx0+972sUsADQGp/U9vuo+J8uoEFdr8xqZsOdc7ccOlO1Zb69Q6OqzCkRvAwOr1i2Bc/ZRbcFTcH4C3cDIupsRee/Zbvt5JtpGP0ilvJD2Hx9o7Ya+Ag0hRQgXQQKGvqPUJ7xZC82v9WCqJ5yM5l2sga8x4KOYrwqVLdJEAUQROxlagF628Q4Rt9kciSUnbckehwYt238m9mX/OBZ1PE0rFY7fYQcI0cm9FKydvGVhHDFoAjeHYpDLHa1tDq51VXVw8pwAyueAHZgt6RqrmyBObuZzq41HmmFqGHX0AlChRcnK2xWzxs+sskfhmPlj2JtXRD/13hhmk4VQRn3JAtdNpOVe8hwwyYKcVnVtl1RwEvzlZnM2UV7UMNU3fhrCbO3e+jCXWAzUzL/sOuNezJJreDWMPP+7vwy2DRl9lqkoQl+EJbRD2ExXDGxSP1ntlbt7ue5N4pHcSJ1lP1PbTl6tolEePEdVHCx/IfAxLLBDKgx0Vbgcuc3jXsP4wY+2oMudJ3EZNYTOo3u+BGHDsJwgJyxM2yNJlvUtJpbaAz3cptEs7nxPVjKPL30iMz/H9rUyNneV3ASrlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39840400004)(136003)(366004)(376002)(451199015)(36756003)(8676002)(186003)(41300700001)(478600001)(66556008)(66476007)(66946007)(6486002)(8976002)(1076003)(2616005)(86362001)(4326008)(26005)(8936002)(2906002)(6666004)(83380400001)(52116002)(44832011)(6512007)(5660300002)(107886003)(54906003)(316002)(6506007)(38350700002)(38100700002)(403724002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bt1Zd7j4+U8zUEvi9SOQBQt6KcqikJvRTp0Z+Muue988Ab2gA0rlFB9v8ZX2?=
 =?us-ascii?Q?XLQ8XiH6SeXXRtcWA+IYgNchVr8fJU2NixVvD78RY5JOKpR6uab3Jjh6gKGu?=
 =?us-ascii?Q?AktDxV2sUlNg1QSb6ZYf/eWVZhNOzgCTztHrK4udFTcXIJAosSRemnqjcXeo?=
 =?us-ascii?Q?Bd4liA6fv8EExhctsheY0yn3gmSSqHP1c8JY0LGP1NbMxmXDAdF2QfBVkAkw?=
 =?us-ascii?Q?ismIzWoth+VSETMVYyXnKgB9Jf2QhhZkUb81yeWB07b8VbQKHYCl6EG+M4iA?=
 =?us-ascii?Q?DBTBNgfdWadLVolBOXPTLlRdp+xsbgDJqXrrmglkFJYCkXikbnLZHzWI0d1o?=
 =?us-ascii?Q?1Fh4PD6JKr2GTSkGll9Srl1YMy7echIdmiJTwAzN87cNtFkdDpf6Jk9nFeIF?=
 =?us-ascii?Q?O9++JT/UmkaWMpEN2rCyzJwro3YG9dpmVQm7twyrnPWsK/n0e4Z58nGFGhKr?=
 =?us-ascii?Q?sui+uDSlr9K2u0y/Vo3JpqCB1u1ixGSwwUxjcjQp/e9ofVzGGgO4lStyjABW?=
 =?us-ascii?Q?ZILmYLYemT6vXQHbHAQN7SA7JuY2ehSfFXaYUo7M5OCzi83oIbB0Lb6MJbJJ?=
 =?us-ascii?Q?jJVIevcQCyq8Gjd3xX6E+pN6J0PqyfQ/o0nDaXmdkaBIgiMPvdJXhuno12of?=
 =?us-ascii?Q?EF3eAteRaV3bTCfHBr9BIikV8CpUgB0ea9BbjAV/k/n96Z/ne5lkZsz77+uO?=
 =?us-ascii?Q?aZi7ar0IntX2kzEhpVTmWOhRSnvfV4th4FNgK+63fCdkkdEKSZVcV1aA1XJE?=
 =?us-ascii?Q?BHLq4zCiB32riMuqxmx3gPh+oFfxh7ZRtuywLMb8Mbrw6XCUfzQJmBDJ3QVP?=
 =?us-ascii?Q?mN9wG8TZJSW6ImnPY78gD7VutWFVUT4AnzXwHK2ia2R0qwgNPLnj9UOiabgK?=
 =?us-ascii?Q?QpyzeSI8MbXzFTaamtgFcYKV9rYtnyV4cbImWxCvdgTSNALWBDgKHLTtYGC5?=
 =?us-ascii?Q?FApdF/XFIVa3AW95hOgy4zNMJChNO4gMxNQSlyOg3cu7qfhho24iQO0w1XDJ?=
 =?us-ascii?Q?Q9kCzXP21ITvbSL6AxqnWOLl9nZPjDvfXOh2q68Cq1MvWx8Wop9Z9ohqWrIG?=
 =?us-ascii?Q?1Xj1ye0OccNWx1QcyxO16kAQX2fk5laSllylgpSDMzqHPTXpTdxDz0vBPVHj?=
 =?us-ascii?Q?+yQkObTuivn3JYeUMCUZX+JHw6odrpWNcmfmIqD5qOA5FvsIgbrvayZcPG78?=
 =?us-ascii?Q?kqxh7dpPJCwfodLWoDZL1xZNhwRmDu2YdknifaZxLHREd6GvmWOpqxS4hsq4?=
 =?us-ascii?Q?/Fj0wvqZ6Ih++MM2F4yKWlv5fNxUhHBUAqmZ/cWr3wSJPOlMdml35Pi92eAj?=
 =?us-ascii?Q?SH5QhbU72/rEM1AOb4T87J2+mpo7BY3fPVYA6q6WZliXKf5TlGRp83WMIukv?=
 =?us-ascii?Q?OgDKSM/8o28y/cTXvgOlAtA/P0oQTcn7THcdGurhUAi/Qvm7IoMrks3D5cdf?=
 =?us-ascii?Q?9rWTAI1ZcxVPcqG4i0yUE392g5jdOfLZ65IDW7S/UtEpJ2FUBsL4rbe5Ps+Q?=
 =?us-ascii?Q?gC70YSfT+y/nYP5x3yP+s+eQj1Tg1lqqkPii2hOcz17kyjThFe4oB4iikTjl?=
 =?us-ascii?Q?xhtxaYrkaRp0zmzyRxYrUABD1PiZPlcEMSxvhatJaaHKWhl6I1+8C8MMRjlW?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c25ec3c2-115c-42b9-fdae-08dad920e04d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 13:34:05.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WV4JuVPPo81QvnnWRikvdY4Zw7fmA7vDZvAnKhqR8J9jD4t1IuI7r+oxo+SnMO1hWpk9/QhV4ABCNl9jmsneApHYsJDX/JHvkGpLuz6St48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7691
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just to see how it would look, I tried doing the below. Since a board
may have more than one ad74412/ad74413, one needs to be able to
differentiate between them. So for now each module parameter channelX
(X=0,1,2,3) accepts a space-separated list of <label>:<function>,
where label is matched against the label property in device tree, but
also allowing * to match any, which is more convenient when one knows
there is only one device.

Aside from the missing documentation (MODULE_PARM_DESC), there are of
course various details to hash out. E.g., should the function be
specified with a raw integer as here, or should we take a text string
"voltage-output", "current-input-ext-power" etc. and translate those?
Should we use space or comma or semicolon as separator? And so on.

I also considered whether instead of the label one should instead
match on the OF_FULLNAME,
e.g. /soc@0/bus@30800000/spi@30840000/ad74412r@0, but that's a lot
more complicated, and I assume that anybody that has more than one of
these chips would anyway assign a label so that they can distinguish
their /sys/bus/iio/... directories.

I should also note that it is not unprecedented for modules to take
parameters that do some sort of (ad hoc) parsing to apply settings
per-device. For example:

- ignore_wake in drivers/gpio/gpiolib-acpi.c
- mtdparts in drivers/mtd/parsers/cmdlinepart.c
- pci_devs_to_hide in drivers/xen/xen-pciback/pci_stub.c
- quirks in drivers/hid/usbhid/hid-core.c

So the question is, is there any chance that anything like this could
be accepted? If so, I'll of course spin this into a real patch with
proper MODULE_PARM_DESC and commit log etc.

This has been tested doing

  insmod ad74413r.ko 'channel0=*:1' 'channel1=*:3' 'channel2=*:2' 'channel3=*:4'

and seeing that the channels did indeed come up as expected, where the
device tree specified CH_FUNC_HIGH_IMPEDANCE for all of them.

---
 drivers/iio/addac/ad74413r.c | 37 ++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index ef873737c33a..284bdb358dec 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1146,6 +1146,35 @@ static const struct ad74413r_channels ad74413r_channels_map[] = {
 	[CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART] = AD74413R_CHANNELS(current_input),
 };
 
+static char *channel_function[AD74413R_CHANNEL_MAX];
+
+static int ad74413r_get_channel_function(struct ad74413r_state *st, u32 index,
+					 struct fwnode_handle *channel_node)
+{
+	const char *s, *c, *label;
+	u32 func, label_len;
+
+	if (device_property_read_string(st->dev, "label", &label))
+		label = "";
+
+	label_len = strlen(label);
+	for (s = channel_function[index]; s; s = strchr(s, ' ')) {
+		s = skip_spaces(s);
+		c = strchr(s, ':');
+		if (!c)
+			break;
+
+		if ((c - s == label_len && !memcmp(s, label, label_len)) ||
+		    (c - s == 1 && *s == '*'))
+			return simple_strtol(c + 1, NULL, 10);
+	}
+
+	func = CH_FUNC_HIGH_IMPEDANCE;
+	fwnode_property_read_u32(channel_node, "adi,ch-func", &func);
+
+	return func;
+}
+
 static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 					 struct fwnode_handle *channel_node)
 {
@@ -1171,8 +1200,7 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	config->func = CH_FUNC_HIGH_IMPEDANCE;
-	fwnode_property_read_u32(channel_node, "adi,ch-func", &config->func);
+	config->func = ad74413r_get_channel_function(st, index, channel_node);
 
 	if (config->func < CH_FUNC_MIN || config->func > CH_FUNC_MAX) {
 		dev_err(st->dev, "Invalid channel function %u\n", config->func);
@@ -1494,6 +1522,11 @@ static struct spi_driver ad74413r_driver = {
 	.id_table = ad74413r_spi_id,
 };
 
+module_param_named(channel0, channel_function[0], charp, 0444);
+module_param_named(channel1, channel_function[1], charp, 0444);
+module_param_named(channel2, channel_function[2], charp, 0444);
+module_param_named(channel3, channel_function[3], charp, 0444);
+
 module_driver(ad74413r_driver,
 	      ad74413r_register_driver,
 	      ad74413r_unregister_driver);
-- 
2.37.2

