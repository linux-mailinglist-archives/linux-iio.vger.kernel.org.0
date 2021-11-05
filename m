Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799C74461EC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhKEKIA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 06:08:00 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:40677
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233020AbhKEKH6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Nov 2021 06:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHiWmxDoBcuRMVoVfcqTRTQ0gsH2s+IxAdHjBRDFgIkUNA/GUuue3i8+HHtyi8nTG5NdRj/bpw/VXWIOPGfulHWtc7+YBbDdo4YxhuKuaEqDuczc1IS6rrQCeyP55pTKmwYp7DiUVv0jNEjnLuWWnR19iJPjOGdV6sVcHoe4kwl5ByhP0dxUbOPurKnTEv8ITUfGWzmtjYURkcEhkYKq3HjeVP8Im73GMdHnlcMzpeyvJ3YhYbA7RsvGTrtLtscRNUxeN1t2wWJ5ZVm3xAQ1HyWK0YjMVzG9IwSGAJOAXlrWOOCUFRGRV3Qj0a9wG6EtXk6DyniAduArjs9f4ey+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkkJJDhYYR6MuYqxa49kpWMwQ2oZt7drhRTwBrOqwRo=;
 b=M/+yJoy9IQ3A2y/AAE/LwlbMSDMU7wezXGvGPYtkiM2Ndhof707B7hFcBEpQyeNYKDDH2DLzsw0hTVSeDdl8lNxa6NSlP/Csqy/NgDIvr1k7KXhOBSbutVznSh0iDjnozeXr1XTKY2OPCUQvyImwGh68KjETRXyu9IhUVusR0J+lhO/Mohl5pqlkwrkb5WemhYoOXtDOY8XjZvFOffeBKZGlnqwHemSzhaVzLTEXot7NIxXxhNziI5MLWm1Kc2d6HreGV5AkjHUmTMQ2zf66knFBhZruVxa5UVcERYNrgVmZ90zPixLWFHNBlB78MVdr70MvB9fNTG38YJmuhkeupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkkJJDhYYR6MuYqxa49kpWMwQ2oZt7drhRTwBrOqwRo=;
 b=KgDOqa/B6b6QFR7Umo27ca80ev0XuDe4uXp2q4Freiez6Lt6eH4QzDnPssW7C0ZlsecmZoH+jragkFSaknc0Hpkedh128UCCc6Oaq/EEAAqDXbRtBh0TBA6vGpGhbX7DObhqFR2v/3d6X/j2jtkD8dFQGF6QhKtGDVriPkFUReU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com, andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v1 1/2] iio: test: Add check against NULL for buffer in tests.
Date:   Fri,  5 Nov 2021 12:05:00 +0200
Message-Id: <20211105100501.1904-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0006.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::16) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b7db6c-3b10-4502-cb41-08d9a043c3e0
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2467:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2467E340DF47EA88AD24C9B8E68E9@AM5PR0401MB2467.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWbMt4im/Rvir4Qn/EGgpKTstsyBSxPrhARd/ZPz1erqfUud6hwmTafMN39YDFNIhrsRioj8ra85oqW28Wt59PPxc/CsAiobXzFBl4/tfRrURTlPPu1gpXJ6cvzR5KkhmVuK/xyaFDXuY8B0wFnyOCf2mdx6+HXt+jr7e8o58s1BVRy9mjMg2GU5kP7R6trdKinnpLcGXc48oXZNZlmKFXelok3OpH9NUPs2cjFYg73PYFyk6+NHdjYYPggvI/LsK+CWoQwLCi3d0EwvlYrnzxES0UgHMygRlEo8smVVl0lj+ocQ/zSPkb5TXDPRdxHQkPNbfNk5J9pDFt9jNCkiW0HP48mAxx8/1JAWbqpcu5LX5tkO4m8guahribci70OPD5lmzABns3xbRhO+tB82xzQiZb3dnofqn05Tx9P/QYUCT/DzkAfx7WqeMIi2YTvSpfrL6/6igFajRPKm3mE2FJIPUsg3m7I8mZ3deb0BCfeWs4HbAu3+2wHm8V6Z7KmPrMs/MD2IemLxab8waK3oZ+DBpuevM+ZSEA0Ekuuml/KG5yovBixhgYYYFUpyZkyk3zWtku6BiKl51UEXTzuCgzWdhFQEFVRH1efaZsVlkagAu4xAbeExob5KNx7tWQl9s9crK5SjqXk2K129HKrx11mzK79AplIgX1ADFKWD+I3Cz/llq9/vlvj5z/tYNT3k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(39840400004)(366004)(66476007)(8676002)(66946007)(66556008)(83380400001)(8936002)(2906002)(316002)(42186006)(107886003)(4326008)(55236004)(86362001)(5660300002)(186003)(52116002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(44832011)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8goalj4cV+AegfMHtDD5OZjJ2uEwM/krOiyFrEcckiLKo3JT2ExXBUWk7RB?=
 =?us-ascii?Q?UQ2vHn5XDF4b3jq1/P16/xQsbyA8JL+1P5+iH9LEQO4wUFX0Ir3uvUYArdT2?=
 =?us-ascii?Q?QsXpsq/UQcV7OHpa823CQ61LXJXhtUkQDYNTX8XX0nf3GK6/Hs5XKcsN04xB?=
 =?us-ascii?Q?yyOAHRoTyHzHVbcq2aUrGs2UdJBvFArEumYc2aGFC55qRkDhKXMeIevheoKQ?=
 =?us-ascii?Q?3XJvQv0DBaQxQNMFgYeWqegkHHFejDwiFRgJQYyWbg/DDR6jgAlivu4eLbfk?=
 =?us-ascii?Q?FPSyJu6SXmYJ4bXDFJgbAnIYVTVmFHVVUC08wNV/JY/uMf4hR2VrzMkEYRAk?=
 =?us-ascii?Q?m8UyTdbqgJUAlE9ZJ2umo0BA8jiLiUtqenEW5Z4wPgyI2b9wRI3B8q0cVR6a?=
 =?us-ascii?Q?IeG+ohuIG0TSVexTJuSoGne9VF0rwhUkijFQhKG+keCLyF0oZ3zr2DUriwbk?=
 =?us-ascii?Q?0hev3l9AoH6EByVy/lpj7gFmaVsk/QO/j5IGMZ0BOrFlIIOcJGXNhRRbxNrT?=
 =?us-ascii?Q?rBH84dOxQ5mAzJgYhwt0U07Ul0Uu9uhUVPPG94N7Lh/LhJ4tsVl8WaKJO5fW?=
 =?us-ascii?Q?Yfa40KROcA+GjJTw6Mlrxv0PZqmY4C8uVXu+hsaPkUacTVSDYjrpRrlIpaxK?=
 =?us-ascii?Q?V7Gnb6RsBoYXe42di93teK0L2s/1W2RpI5MwQvRYkhgmMdVPAWxWptNF2SSj?=
 =?us-ascii?Q?Hi/ggq0fDFAthZLfiv0sPLz88lvGISV0hrFZDUUU19CA2XyXyDRjfBAdSC79?=
 =?us-ascii?Q?XnBeFkG5siyjR4yiTargOrSk3lpUq0ctVk33z+x1Inj20xXkw5IgiRQPyEwq?=
 =?us-ascii?Q?fXE8jT19wCXV+8Gx3zcMHdAVKO4lkXJVIR2dLmfpBxlE6kzi9OYrniyYINDQ?=
 =?us-ascii?Q?/0P/YVztugTuxk15uWtp9SEYr/o9oR3TaQyAv4TAsm9lE9Md3094o+RXtz+a?=
 =?us-ascii?Q?k3uDTEtunvJPf9n/CwQOhl4W6clfYwaQd7dtjetBdSQnZ5pd5V4ogEF1Ro5v?=
 =?us-ascii?Q?cdJlfc808qmPRrPue+F9xL7pkLF3aII6vrH4kejGmSN4aiv4M67KBLS+3UTr?=
 =?us-ascii?Q?7yf7CmkVYVq9YXyfJ+Qncps7EdLaWfsXyDzbyWb0RvzFUd1+luPW9Nd1h/Vo?=
 =?us-ascii?Q?/5bj7MlYZMz0nwnUDwmlQukKpFiue8jCDoyylUG5a9n8A3w/poEwrVVbZuve?=
 =?us-ascii?Q?mWF0ASQeytGuZuK5FcVyQqBeI5EaCTjrB0/jz7Htyn1RQ6+dM8rJh0yowcjc?=
 =?us-ascii?Q?0mEnNAH0e8ewi3wpyEcGEyALYKfs6QCk91BHuCcPKYe5k6Tcf7yRCmQzpCeJ?=
 =?us-ascii?Q?2xZfw/mpRST6bAfjFr8WgUmxzDM0FTNQTKsccV1XbMYxe5r4dAo6OJMxAF/C?=
 =?us-ascii?Q?XBY5FL/Nn3gesjDTpWsesYdE6KR6fSxZwBbHvyAJlWKEnZPwFlYkJoKZvU/k?=
 =?us-ascii?Q?vQOS16/AKQk3DsMqqv3jJH6w7Pq9YmQCwnnQLxVeLfB8rfS/7X1GsFv1pGSN?=
 =?us-ascii?Q?rkJCbzoEdrbg+Oy2pWSWQtmfvTpOi+IEKnNUFkubAYSM7/2uMRhKAtJcZo9l?=
 =?us-ascii?Q?qTta7DQHivw9lvfC3jy/QaeKBuQan/eVNKrVDPe0ROTQT4a4Tx9HK7/dO/GA?=
 =?us-ascii?Q?UreI1x6ixWDxc3M0N5X3JGM=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b7db6c-3b10-4502-cb41-08d9a043c3e0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 10:05:16.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkjWvhuxLDcpLAU+1VcxhvmNBxF4B4BIFESN1utYbvAdjhtn9+Rg5OKJemvHWWJ0MAx0sUM+GgoL2RdlRPkqTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2467
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf) for every test.
Also use ARRAY_SIZE(values) where it is possible.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/test/iio-test-format.c | 69 ++++++++++++++++++------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index f1e951eddb43..b746d00bc0ea 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -14,10 +14,13 @@
 
 static void iio_test_iio_format_value_integer(struct kunit *test)
 {
-	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	char *buf;
 	int val;
 	int ret;
 
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
 	val = 42;
 	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "42\n");
@@ -41,142 +44,154 @@ static void iio_test_iio_format_value_integer(struct kunit *test)
 
 static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
 {
-	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
 	int values[2];
+	char *buf;
 	int ret;
 
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
 	/* positive >= 1 */
 	values[0] = 1;
 	values[1] = 10;
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010 dB\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000010\n");
 
 	/* positive < 1 */
 	values[0] = 0;
 	values[1] = 12;
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012 dB\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000012\n");
 
 	/* negative <= -1 */
 	values[0] = -1;
 	values[1] = 10;
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010 dB\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000000010\n");
 
 	/* negative > -1 */
 	values[0] = 0;
 	values[1] = -123;
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123 dB\n");
 
-	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000123\n");
 }
 
 static void iio_test_iio_format_value_fractional(struct kunit *test)
 {
-	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
 	int values[2];
+	char *buf;
 	int ret;
 
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
 	/* positive < 1 */
 	values[0] = 1;
 	values[1] = 10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.100000000\n");
 
 	/* positive >= 1 */
 	values[0] = 100;
 	values[1] = 3;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "33.333333333\n");
 
 	/* negative > -1 */
 	values[0] = -1;
 	values[1] = 1000000000;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000001\n");
 
 	/* negative <= -1 */
 	values[0] = -200;
 	values[1] = 3;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-66.666666666\n");
 
 	/* Zero */
 	values[0] = 0;
 	values[1] = -10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
 }
 
 static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
 {
-	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
 	int values[2];
+	char *buf;
 	int ret;
 
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
 	/* positive < 1 */
 	values[0] = 123;
 	values[1] = 10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.120117187\n");
 
 	/* positive >= 1 */
 	values[0] = 1234567;
 	values[1] = 10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1205.631835937\n");
 
 	/* negative > -1 */
 	values[0] = -123;
 	values[1] = 10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.120117187\n");
 
 	/* negative <= -1 */
 	values[0] = -1234567;
 	values[1] = 10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1205.631835937\n");
 
 	/* Zero */
 	values[0] = 0;
 	values[1] = 10;
-	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
+	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
 }
 
 static void iio_test_iio_format_value_multiple(struct kunit *test)
 {
-	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
 	int values[] = {1, -2, 3, -4, 5};
+	char *buf;
 	int ret;
 
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
 	ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
 			       ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
-- 
2.17.1

