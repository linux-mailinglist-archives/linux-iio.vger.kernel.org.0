Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13944289B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKBHgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 03:36:11 -0400
Received: from mail-db8eur05on2127.outbound.protection.outlook.com ([40.107.20.127]:37344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231252AbhKBHgF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Nov 2021 03:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/x19ZLuis1ZJeYnhLWPMrhlogU12qYRJboIrFadYyE9C4I1rtRSel6euyVrUk81IoSrvYWx/8N4M2H0I9g0duSS2/0wt54aSCC20XufHLV0RnUvVLeqxqyRSccNbnJ4aY8e3DBpA0XSQFvkNgZdi+Ooqx8pabR2p7xY2ezqBMPEb3kKx1VJXIPdNoyrpiPeUT9VCZ0+bbUI3lsMoZSkq/w+HSKkY2UX6nA+7WU3yB2XblBh34Wvwn0gtNmPU6U8ym0BJj092PlmTHOtDqoVSfhUsm+R+4GDLiwbJKB2uNCNMQMeVyCvn5xE5iuwn3vvNsYxhPQWEC2aSND6eJsRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgrt81klJeu3tyxC/5nc7WgEwzCqjnRssZXTEHdznQY=;
 b=PKk5Qad8x2CX/FQSn1C19Uk1dBheTgRRuZsXRnlyJg0AZ0mYZtXp04EIGeybxhJarNz60yu6201DZD1RIdzDJngYAj0mlyAStNvGjL6cWKKA8jieu1tT0USAX6wU9PVlDjIlIE6Y6/zJkOZvyvm1UoBRP8pzBpPFr+c3qfeQCx+AyLCOPjTm6TZvPss+wj8VZvwgJZ/f0xSUbNQwuX8C0PbZtho4PrzM/S7WsfrTctBs6X4B+ixT13iHSf/K3axG24psbrdYNba8bpDIjG7fhODQqh5chwz7SkfevBSNiuQdTxj8q1UJ9UlvBPmXVM1D1E30tku7hfJX0cRBVTIJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgrt81klJeu3tyxC/5nc7WgEwzCqjnRssZXTEHdznQY=;
 b=RF1ON0SEFswXYXCVGC9zONAL2T2BnIQScZKtoyFj6dwC/8WQ/QCR6HAIimGUXU6DLn2dJdKkIkDvzyvJlv6ulVq/0ul6SjymVvk1uCGdZ8qTKkg7MZgbiydFloLEZNtlCVq94vdDFrgmmCtTkLyZEtEq8+VcakwwhjxQPrip5Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     andy.shevchenko@gmail.com
Cc:     Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com, jbhayana@google.com,
        jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] iio: test: Add test for IIO_VAL_INT_64.
Date:   Tue,  2 Nov 2021 09:33:00 +0200
Message-Id: <20211102073300.13376-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
References: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0154.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::9) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5944132c-589b-4038-3fac-08d99dd30c8d
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2723:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2723483EFA7F5F6898EE11F2E68B9@AM5PR0402MB2723.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iinU2nBuOLtGVjTPuUdl2yU5/yvzQhVq21v+sDVVrF2qXcMNwtDIrvYPMtPH81cTCbAMm6MDueCe5Vba/IOYfuk5XbOQifQ0uGZapVocdfj07rX1fIJQ+sWtWthkqMmca2ugn1gdB3VZ+JxIrQ7TlDzV/7K/SSq4zuJ1NjMQAiGilIoF4+NFm2keO3hrlOuHH4B6OmQEWC6sNgwptiDMjV3RzgfcRZtRlGTYH0I6A1+NZ6La2KeQMVtuJolYQIzQZ34rcjESt+hmFSLnNwXzIryGyjTCXlMzWlNduYtxeP2wjGaBibi7TcNqU+DpP17m1f8d3bVtKor5tLgkWvqt5JHBa3g8k86zCnXHLly1npyQiLN3w8xNk6LlTqqLMomcmCGWwWd2HWSD2XgGQU78lBIJ/9mbBGRSgL2FfAoawhZpiWN90Xyak5jt/4evl+enLDVk07RUvwAIRRgPW1NkBwKcbYxHBhNmYwo3gUF5X0nIRH+5HqbHTGgr2q59Zjiphr6QGABW1uMpZlv5ujapNQsisgnHu+MQf5LWC5FECz89mM/13Q9bizSRYQhUxUvFsS0YyyUlvXuaBcEoDBiU/iWEvQx/ZnSuJxDgw554/N9yE5+n77mCWsCA9duL2UWprwO0GJTlS1gOtFVGgal5H6txwoeqBeOjfZPgCFZo1lx+6lZVEkYEzlk3TQ2ubyxJidZ8c+Hy8LT1o71mE6zS3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(136003)(346002)(366004)(396003)(38100700002)(36756003)(52116002)(55236004)(66556008)(5660300002)(66476007)(316002)(2906002)(38350700002)(42186006)(2616005)(44832011)(1076003)(186003)(508600001)(6916009)(26005)(4326008)(8936002)(86362001)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EEFYCnzbzCViNeSp5s413cmufneyV0h/ivsQLor+4k+psizmh4qVC7i1D5oP?=
 =?us-ascii?Q?uTTkW1pNZN1aTeO+UaS3FJDNRQD+JOeXX6sxpordUzcQIkIOcxvXsWDNOpaK?=
 =?us-ascii?Q?JT1OXzMIFUAAgkTZzMz49MycGVOO+hFV46WlXYAwvHZROWT+fdhKDeTIVOd0?=
 =?us-ascii?Q?E/RfNmldsWkAX7vbjeWLoHXKvtSuBugdVWAz4fsSQ/nA/DMjq0DcX68iz1QJ?=
 =?us-ascii?Q?E27nIYDGrznSVxBMe9i+i0G2i0KZQgMuZyhB6BxmqsfGCAF5v2ghJK82029y?=
 =?us-ascii?Q?prBoN/7WM4zv/4Pg9YOWTDaSEmQvb1UXz9tuoJd+NoFgqJjmVBOK5sTsrr3b?=
 =?us-ascii?Q?1WjdXN0cQbXT/ipcO9iXPzvUn008kCCLpyNs7AnVfFfdpPYbh+cbtsdqmZbG?=
 =?us-ascii?Q?9jIUir0oIxr9HpxYelIwmQYG4WQ/U1OqpHE0Sck7BfDs3SRlkDcNsJ/tTEvQ?=
 =?us-ascii?Q?2AMIduTRG2/aiT0jqV1WZw2dP/P1OZaxDNR5Bu+k7ozdr2WGtQBJtBTKKvhe?=
 =?us-ascii?Q?ksHUj3BJudfTnVIJdQ0oxSkFv6vEsBtxAS9CvAbOx0DvUQIgLxsgaC/dhPm8?=
 =?us-ascii?Q?A7B6KTbOMG5UIOEBU4aMPlaE3+5qtIg8ogLPS+7WMoGbPxVyGeMYS2/lXdrO?=
 =?us-ascii?Q?NPsZMrtgM1IAJ+QrspupjyeQ1G0+iU0cc0xWGkGt++u87kkHLr8pTf5kiI/S?=
 =?us-ascii?Q?RlOqxUtDHsmPqNx79M1mNF0F4PW+62gFhLR3HznOo3OetFpUWB1lGXWa4m4e?=
 =?us-ascii?Q?fMgLMoj03XYkfFncpkyZ2Lpy77tt5Q9sQipg5WxnCkj34xyYOFlhuZoCW85T?=
 =?us-ascii?Q?Cb6Yn5n8XV7Hd0qW0o+d3t2P44IDhs+yBNd8g1lzn5+huKOQ75XQ6Npa6fBp?=
 =?us-ascii?Q?RcimJ7VKMe+FL0wB/peFOposzQdlJsm/sNlthee3I+/wefFvdGYPH/B8Nrwf?=
 =?us-ascii?Q?SnuKXUt16TDE/hh78LH4t4e2LiEnsa/3b60X2Vyo9fj/oxDuO8SOVPQcGFiG?=
 =?us-ascii?Q?Xid3yu6xt6BrH6+dfjgyReDafjc3mv6UxXKe0GMhRSZy2ZvsgHV2pKpXbPde?=
 =?us-ascii?Q?ZUkQT6OKYedKs7VhSiilEvDnaXFgxvFu95uA/X4uAH9PIaYPlY3k4XpRy1Ef?=
 =?us-ascii?Q?T6jwxKzCTDkG7WRkhGYcojpS7ijNomeKbW2oz6Hjh3IuKU7Nx+RKQPFPfFpE?=
 =?us-ascii?Q?mg810am1t1nyTrFQjT/9bKR1qVdM55B3XhvCmihtR7Jr1nNe9hDdsahVDfIc?=
 =?us-ascii?Q?xa2mvsjvg/3XgqAwmJ3EJ3Jfq1EzUHVNKSI6nerpA5I4l5PMfERqc6N9K270?=
 =?us-ascii?Q?ZAahCbWeFj95WvPzy8fcbgO/3aonZd0EQ4Nu66As193cW9b1AomBsWbZeFY5?=
 =?us-ascii?Q?5jYiDB/lsh5w2xnFB7zcN2+CbKINE9UNhJ33OxT8w2ycdThduQsh5g/tTf4u?=
 =?us-ascii?Q?b03gFM7C7K0//3OFrwLK6PoaWTtnlMOsbA6r53s/wYQvdZ+sfZXZI2yqUX7P?=
 =?us-ascii?Q?df9BYorebXx4CvGDpSuNy+5CMKwJ9ENPbP7aN8RevSdppNAHzXknGk5KV4fW?=
 =?us-ascii?Q?fpXCKt6z9XgZp5lgfM4VfCAPKI/MTp0Yu/RxBXF8B0FjSCAH3RgNl0b4s9Gl?=
 =?us-ascii?Q?Ge3FvUxiDQ1wPmeK3enJ6IE=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5944132c-589b-4038-3fac-08d99dd30c8d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 07:33:22.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtyGjXUyvdl/JFtir5rK71wWCxcory0mXa62z5N8TMvPcw/Ts6aUy4154QxX8DSEXf6IvBTIpxeAHOzfkrDV9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2723
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/test/iio-test-format.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index f1e951eddb43..f07945c2cf28 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -182,12 +182,63 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
 }
 
+static void iio_test_iio_format_value_integer_64(struct kunit *test)
+{
+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	s64 value;
+	int values[2];
+	int ret;
+
+	value = 24;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
+
+	value = -24;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
+
+	value = 0;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
+
+	value = 4294967295;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
+
+	value = -4294967295;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
+
+	value = LLONG_MAX;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
+
+	value = LLONG_MIN;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854775808\n");
+}
+
 static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_integer),
 		KUNIT_CASE(iio_test_iio_format_value_fixedpoint),
 		KUNIT_CASE(iio_test_iio_format_value_fractional),
 		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
 		KUNIT_CASE(iio_test_iio_format_value_multiple),
+		KUNIT_CASE(iio_test_iio_format_value_integer_64),
 		{}
 };
 
-- 
2.17.1

