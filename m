Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88200316347
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBJKJs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 05:09:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65472 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhBJKH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 05:07:26 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AA3CxZ017518;
        Wed, 10 Feb 2021 05:06:35 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw8v4bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:06:34 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11AA6X3s025938
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 05:06:33 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 10 Feb 2021
 02:06:31 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 10 Feb 2021 02:06:31 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11AA5x0M018045;
        Wed, 10 Feb 2021 05:06:28 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 16/17] tools: iio: privatize globals and functions in iio_generic_buffer.c file
Date:   Wed, 10 Feb 2021 12:08:22 +0200
Message-ID: <20210210100823.46780-17-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210100823.46780-1-alexandru.ardelean@analog.com>
References: <20210210100823.46780-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=946 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100097
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mostly a tidy-up.
But also helps to understand the limits of scope of these functions and
globals.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 tools/iio/iio_generic_buffer.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 34d63bcebcd2..7c7240553777 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -49,7 +49,7 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
 	int bytes = 0;
 	int i = 0;
@@ -68,7 +68,7 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 	return bytes;
 }
 
-void print1byte(uint8_t input, struct iio_channel_info *info)
+static void print1byte(uint8_t input, struct iio_channel_info *info)
 {
 	/*
 	 * Shift before conversion to avoid sign extension
@@ -85,7 +85,7 @@ void print1byte(uint8_t input, struct iio_channel_info *info)
 	}
 }
 
-void print2byte(uint16_t input, struct iio_channel_info *info)
+static void print2byte(uint16_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -108,7 +108,7 @@ void print2byte(uint16_t input, struct iio_channel_info *info)
 	}
 }
 
-void print4byte(uint32_t input, struct iio_channel_info *info)
+static void print4byte(uint32_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -131,7 +131,7 @@ void print4byte(uint32_t input, struct iio_channel_info *info)
 	}
 }
 
-void print8byte(uint64_t input, struct iio_channel_info *info)
+static void print8byte(uint64_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -167,9 +167,8 @@ void print8byte(uint64_t input, struct iio_channel_info *info)
  *			      to fill the location offsets.
  * @num_channels:	number of channels
  **/
-void process_scan(char *data,
-		  struct iio_channel_info *channels,
-		  int num_channels)
+static void process_scan(char *data, struct iio_channel_info *channels,
+			 int num_channels)
 {
 	int k;
 
@@ -238,7 +237,7 @@ static int enable_disable_all_channels(char *dev_dir_name, int enable)
 	return 0;
 }
 
-void print_usage(void)
+static void print_usage(void)
 {
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 		"Capture, convert and output data from IIO device buffer\n"
@@ -257,12 +256,12 @@ void print_usage(void)
 		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
 
-enum autochan autochannels = AUTOCHANNELS_DISABLED;
-char *dev_dir_name = NULL;
-char *buf_dir_name = NULL;
-bool current_trigger_set = false;
+static enum autochan autochannels = AUTOCHANNELS_DISABLED;
+static char *dev_dir_name = NULL;
+static char *buf_dir_name = NULL;
+static bool current_trigger_set = false;
 
-void cleanup(void)
+static void cleanup(void)
 {
 	int ret;
 
@@ -294,14 +293,14 @@ void cleanup(void)
 	}
 }
 
-void sig_handler(int signum)
+static void sig_handler(int signum)
 {
 	fprintf(stderr, "Caught signal %d\n", signum);
 	cleanup();
 	exit(-signum);
 }
 
-void register_cleanup(void)
+static void register_cleanup(void)
 {
 	struct sigaction sa = { .sa_handler = sig_handler };
 	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
-- 
2.17.1

