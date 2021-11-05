Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE54461EE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhKEKIE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 06:08:04 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:40677
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233028AbhKEKIA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Nov 2021 06:08:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/9xI67YDWFzqFulLoMkcHjHfOZbpvduzTy9CqILh2jCizIxQ7ejZXhWo/0p2tP9wTEyWS3TO6o5oAeqnOnTHINd+I9sOTr1A+ZG18rXOOiTHNp+3Pr5RKfSFrGhEDSzZu3/um3XAeFiVzdVFQculs065t7pkSOqoD0kc5vA/QNh6PqBo7dZBck/5k8EdtXItm3CMoKoAsNondZDf+e6d4Qd3Aw9/hOy8y+WBOMD2kAR/5IjmE10tcXoF9H3y1XsmDqVMt0R9wCCKgUITwvjrO31FgoGbH3cbzrXBYyyZOcFaJjPUhKSb67xQmmi49ITiewaqEWOIbgw+exq1Zq0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zrPvV4pxRyoveikfDTr8Yyv5itb61eGFF65mOJd2UY=;
 b=HKm1HOD9Z0MzvNxCLfNX+Q12gX6awVDmWgov6t6hvg4Hz+4dmIaj2PRdBEf5XfchucxVcOKOcDYOcNKcp5UdzF2ExCNQvH4ZTg6EiDOF3i8yfIRWKUQMFrrjLOFOHoHSSTsI8+yWpVcPhCdm0sQf9yxjyWrPhNghz9Qt6eJS4CJkAhx7PR2Xdz27YlkLUTlnNE9bjNJ2mvtZxuBYpglPrA9aFSAbiHq/4jp3eVGsszfT+NSSTG8tek8B4S+SajkseHTFJyzRlkV48SMhJdQE2oe3gIzWKjrl0Ry6QcpZ99n62C+GoAmOPO1MT6gdyyKr25GVSIWYwo32BQJmFZA13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zrPvV4pxRyoveikfDTr8Yyv5itb61eGFF65mOJd2UY=;
 b=LVCay9OtWfXsrcFnKxCU6+4KUv68SoKvZh2DEoKH+qJwIgpO8efNZJcFRcrhW1uJKDnsMiWq6TE68xDYVN9iHP4tflcXHqSIiBg+2uwVuYn0iIx//QOWjCdA20fP2XMdybUQjwI8bkIKzd+dAuvuki1j603NNDHwpep69tGIuwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com, andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v1 2/2] iio: test: Add test for IIO_VAL_INT_64.
Date:   Fri,  5 Nov 2021 12:05:01 +0200
Message-Id: <20211105100501.1904-3-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0006.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::16) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2c01c4-84bb-4153-b805-08d9a043c474
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2467:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB24673245596272B1F3700FDDE68E9@AM5PR0401MB2467.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWVZt2VJTHKUuwukEBmCqN94X2YcH3YosOZtn2TTAisCv3DEpsSv1gTu/r8Caao1pl09B8Pf1+bH2J+W6XkwBU/FJdz31UdtPw5ob+CQhf7oOBG1lHKOCm1A6sVuK0oBJrSvjG2IGubNQNBF5Sy3iPbPYcgsFF0kTQAYdSYwYnBO2ybD/KpJZUBBrNGFz9XjpIMBoVE9IFr6nZKHaanrUZR4of6r0kw2g7JEenVYbb/3Q1Ur2KEBQaow7Ebpex8c9scqsiWgP4oqcPy3m3XUcOqQX85c942p1+RKdPsIrvuZDDB9ZSWxJ4HlAkzo8/nrCgYvj4Ee2OueXDRB5ftw9USEny0r52J8KP+8759rY5FPmMyt49VMyeU4m4Jgk5+xLijx+/x73vkIn3CwAvCai76/unevOhU2CuDyrxOuR8dCVpY1eCuQ7Zi002Ojhjt0A+zzLpJgCZiFtHcUpOFuAPhqJokP/ZagoP6Ar/fWCl/ZgSQsKPa17KApqtt8iBh9SVbU7FeO14niL48snVs7yNs81498R8ajIqlW5QWTU06MaG2zMKxD/XuPyebPJSobHX4LEOek47fhz+aV3XBw2l3MRxrccAAmajDbgEZa4x4gJjMx2u6KiAazOi5Vymzx0vdAfFwq6EZzoSrtn3xU3WKG3u+fCtY1aHz1yeNU0USDZykf30Kn8uET/Q9a/gRW4JJSeaG7Lhcn/sc6Uw5S9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(39840400004)(366004)(66476007)(8676002)(66946007)(66556008)(8936002)(2906002)(316002)(42186006)(107886003)(4326008)(55236004)(86362001)(5660300002)(186003)(52116002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(44832011)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/7cT8LXzU+vXd/qKGrqGgAdJ3hzJH+alyGPaaOOkLU7SqpxVlnSm73tatY9v?=
 =?us-ascii?Q?wtZ6HRVt6VPnyQRFyTxMw8iFfjcjR6JMvjACxXQALO15mvSpHh/gIu/41unb?=
 =?us-ascii?Q?OXymjQ2qiAZMseCxNJYm+006ch/D3+3CWHwlbegjVRflUXAJoZSJd4gvH8hS?=
 =?us-ascii?Q?oC8+PRAw9dW8CbCzF3zPdGl4EVGCTCNUJOlbDIXltHX/bQU9P5jCiUxkOIEn?=
 =?us-ascii?Q?z5VoaSonyzNK1oDGSgYbGk1gwhK8dp4Z5kpMR5qzLU2e8HXhGob+zodaCEET?=
 =?us-ascii?Q?/+vZVBUUEswzS6kn6y2U8iwq4Se1BoTzPg6VOV5q3fbdKkd5n57owcEcJpvV?=
 =?us-ascii?Q?v/w5Ff7gAc121Y69XloCofVPFcUuO3OIrR7uc1HWu0hGvLKZtJ6uy9oajiSg?=
 =?us-ascii?Q?p8HvrRipydgkC/IZudKTt7iMxUk8uADIk7GoZfpUywoW13PJpV3x2rNWDbXh?=
 =?us-ascii?Q?xcuBhMMPmdS4oQl+0CZ3m2HUhcxSuSUGQbKAO7JSBuFCbsRfNJfGDJeESc+P?=
 =?us-ascii?Q?Vp3ezctQN5n3IWgh8aRv7/VHxGxpnamcusAn4tU7dRleoJmIuxsHCh9oscsH?=
 =?us-ascii?Q?MunDWhZev+mrEgMCpq+Crww63Ky9XmgUlNeA+qzR/IPnFz0naH+b+3FdfLAi?=
 =?us-ascii?Q?Bvv7EY1Hv06J4hcrlcrr50xUk/cpOKd7cC1xzrM9bnsMlklhgnG3jhTWDDf2?=
 =?us-ascii?Q?vspMsAwSUKhJymcT4MivDoG3kPaqeIobW7ZgCsgwsGL7K2FiK5gIN01y4EoI?=
 =?us-ascii?Q?J62zZbQFpQWonSKzZL2uZCzCnPLLjynOGEKyPST/5dgY5sL5GqKOjJDoBdbr?=
 =?us-ascii?Q?R+f8aIb7xAcl8GEOEYpN7jl5GOH9ZNUAycuMg2rniVFuaqaYBEFzDGk+/OiR?=
 =?us-ascii?Q?DQ8y7fbe1MMXk/ANjn7RopQuxZzXWY300zyONWXhgdKUWGm3cFboMPmlGKla?=
 =?us-ascii?Q?zfbpZkbYnTWZDcZ1bgpJ0JwGc82yCZQnG+GzugFgElFIVay8sTMLaGWqZGRe?=
 =?us-ascii?Q?1yS36ML2ZHOLjkso2MrVhfhGyeDpEcJdDXTs2uQh4IQ5Qyg9UsH59lYyc5IJ?=
 =?us-ascii?Q?ywia8UpllWvjyBT/wzPi2H18knq/GDLICwBQ1sgqaRabidQbbi0Z3ZCyesMy?=
 =?us-ascii?Q?sO0hsWV4MayBhuXQ9unjoKE+AJ6rm2Zean1YSEGeoKsIDRFVJN1UzKOZpU6d?=
 =?us-ascii?Q?o0MzbMTLgGEVhjWx0VdxF4MFZmjr7U6Lk23zr+APn9ix2qsPFRJvk4QtSNec?=
 =?us-ascii?Q?G7zjjqbX5Zfnii4YdFBUlKT6yqSILk0GjDfwDbAl3DuYBS+aD9OJWdqC/h0v?=
 =?us-ascii?Q?CbIN2Pm6qoZaG7mSmiFmsIEBDqKJRUBdErUyPJrsN2sEGPEghcnhwCFmQDzZ?=
 =?us-ascii?Q?y8T/ujnMZ50nZPYk/qz4Lbp8Ijo4Sb0TnpIoWG3DfHj65BDKlwE0LDg6Hjjt?=
 =?us-ascii?Q?J64KkFdTLNF8oNNCSt6VfLJu1w780Zw+tPZf0chTTg0NHYtjMqc8zeVlqyi4?=
 =?us-ascii?Q?PFV6iXPDMWiiBv548BjMrG5BDYArq0MwjI+os4qdGY9Qk01USSySDGJpdODZ?=
 =?us-ascii?Q?z11XtZPVZyMd+oD1em2SKCDJf8Deizsd5fYtv6YOszgi0VXuU7Ch5NhP93Ny?=
 =?us-ascii?Q?ClrXjeIp8CtNTvOoTc1Ax9Q=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2c01c4-84bb-4153-b805-08d9a043c474
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 10:05:17.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVJ5iiyevTRxBdhuG7L2fxWXtEADYQxswemk493KgN72MLLsOkh+QguXtd/w9WK+uCerMs3qKb+ULrvAsPpHkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2467
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add test for newly introduced type IIO_VAL_INT_64.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
Changes comparing v0 -> v1:
* add KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf)
* use ARRAY_SIZE(values)
* fixes according to Reverse Christmas Tree Format
* use constant UINT_MAX

 drivers/iio/test/iio-test-format.c | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index b746d00bc0ea..237321436b83 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -197,12 +197,66 @@ static void iio_test_iio_format_value_multiple(struct kunit *test)
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
 }
 
+static void iio_test_iio_format_value_integer_64(struct kunit *test)
+{
+	int values[2];
+	s64 value;
+	char *buf;
+	int ret;
+
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	value = 24;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
+
+	value = -24;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
+
+	value = 0;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
+
+	value = UINT_MAX;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
+
+	value = -((s64)UINT_MAX);
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
+
+	value = LLONG_MAX;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
+
+	value = LLONG_MIN;
+	values[0] = lower_32_bits(value);
+	values[1] = upper_32_bits(value);
+	ret = iio_format_value(buf, IIO_VAL_INT_64, ARRAY_SIZE(values), values);
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

