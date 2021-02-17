Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F46931D5C3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 08:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhBQHgK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 02:36:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5912 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhBQHfn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 02:35:43 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H7KLWX014567;
        Wed, 17 Feb 2021 02:34:50 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb2d7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 02:34:50 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11H7YlpL003774
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Feb 2021 02:34:48 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 16 Feb 2021
 23:34:46 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 16 Feb 2021 23:34:46 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H7YS3k031303;
        Wed, 17 Feb 2021 02:34:43 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 6/6] tools: iio: add example for high-speed buffer support
Date:   Wed, 17 Feb 2021 09:36:38 +0200
Message-ID: <20210217073638.21681-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217073638.21681-1-alexandru.ardelean@analog.com>
References: <20210217073638.21681-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Following a recent update to the IIO buffer infrastructure, this change
adds a basic example on how to access an IIO buffer via the new mmap()
interface.

The ioctl() for the high-speed mode needs to be enabled right from the
start, before setting any parameters via sysfs (length, enable, etc), to
make sure that the mmap mode is used and not the fileio mode.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 tools/iio/iio_generic_buffer.c | 185 +++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 6 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 2491c54a5e4f..e7c327fa6091 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -31,6 +31,7 @@
 #include <stdbool.h>
 #include <signal.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <linux/iio/buffer.h>
 #include "iio_utils.h"
 
@@ -239,6 +240,133 @@ static int enable_disable_all_channels(char *dev_dir_name, int buffer_idx, int e
 	return 0;
 }
 
+struct mmap_block {
+	struct iio_buffer_block block;
+	void *addr;
+};
+
+static struct mmap_block *enable_high_speed(int buf_fd, unsigned int block_size,
+					    int nblocks)
+{
+	struct iio_buffer_block_alloc_req req = { 0 };
+	struct mmap_block *mmaps = NULL;
+	int mmaps_cnt = 0;
+	int i, ret;
+
+	/**
+	 * Validate we can do high-speed by issuing BLOCK_FREE ioctl.
+	 * If using just BLOCK_ALLOC it's distinguish between ENOSYS
+	 * and other error types.
+	 */
+	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
+	if (ret < 0) {
+		errno = ENOSYS;
+		return NULL;
+	}
+
+	/* for now, this */
+	req.id = 0;
+	req.type = 0;
+	req.size = block_size;
+	req.count = nblocks;
+
+	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ALLOC_IOCTL, &req);
+	if (ret < 0)
+		return NULL;
+
+	if (req.count == 0) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	if (req.count < nblocks) {
+		fprintf(stderr, "Requested %d blocks, got %d\n",
+			nblocks, req.count);
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	mmaps = calloc(req.count, sizeof(*mmaps));
+	if (!mmaps) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	for (i = 0; i < req.count; i++) {
+		mmaps[i].block.id = i;
+		ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_QUERY_IOCTL, &mmaps[i].block);
+		if (ret < 0)
+			goto error;
+
+		ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[i].block);
+		if (ret < 0)
+			goto error;
+
+		mmaps[i].addr = mmap(0, mmaps[i].block.size,
+				      PROT_READ | PROT_WRITE, MAP_SHARED,
+				      buf_fd, mmaps[i].block.data.offset);
+
+		if (mmaps[i].addr == MAP_FAILED)
+			goto error;
+
+		mmaps_cnt++;
+	}
+
+	return mmaps;
+
+error:
+	for (i = 0; i < mmaps_cnt; i++)
+		munmap(mmaps[i].addr, mmaps[i].block.size);
+	free(mmaps);
+	ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
+	return NULL;
+}
+
+static int read_high_speed(int buf_fd, char *data, unsigned int block_size,
+			   struct mmap_block *mmaps, unsigned int mmaps_cnt)
+{
+	struct iio_buffer_block block;
+	int ret;
+
+	/**
+	 * This is where some buffer-pool management can do wonders,
+	 * but for the sake of this sample-code, we're just going to
+	 * copy the data and re-enqueue it back
+	 */
+	memset(&block, 0, sizeof(block));
+	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_DEQUEUE_IOCTL, &block);
+	if (ret < 0)
+		return ret;
+
+	/* check for weird conditions */
+	if (block.bytes_used > block_size) {
+		fprintf(stderr,
+			"Got a bigger block (%u) than expected (%u)\n",
+			block.bytes_used, block_size);
+		return -EFBIG;
+	}
+
+	if (block.bytes_used < block_size) {
+		/**
+		 * This can be normal, with some real-world data
+		 * terminating abruptly. But log it.
+		 */
+		fprintf(stderr,
+			"Got a smaller block (%u) than expected (%u)\n",
+			block.bytes_used, block_size);
+	}
+
+	/* memcpy() the data, we lose some more performance here :p */
+	memcpy(data, mmaps[block.id].addr, block.bytes_used);
+
+	/* and re-queue this back */
+	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[block.id].block);
+	if (ret < 0)
+		return ret;
+
+	return block.bytes_used;
+}
+
 static void print_usage(void)
 {
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
@@ -249,6 +377,7 @@ static void print_usage(void)
 		"  -c <n>     Do n conversions, or loop forever if n < 0\n"
 		"  -e         Disable wait for event (new data)\n"
 		"  -g         Use trigger-less mode\n"
+		"  -h         Use high-speed buffer access\n"
 		"  -l <n>     Set buffer length to n samples\n"
 		"  --device-name -n <name>\n"
 		"  --device-num -N <num>\n"
@@ -356,9 +485,15 @@ int main(int argc, char **argv)
 
 	struct iio_channel_info *channels = NULL;
 
+	static bool use_high_speed = false;
+	unsigned int block_size;
+	int nblocks = 16; /* default */
+	int mmaps_cnt = 0;
+	struct mmap_block *mmaps = NULL;
+
 	register_cleanup();
 
-	while ((c = getopt_long(argc, argv, "aAb:c:egl:n:N:t:T:w:?", longopts,
+	while ((c = getopt_long(argc, argv, "aAb:c:eghl:n:N:t:T:w:?", longopts,
 				NULL)) != -1) {
 		switch (c) {
 		case 'a':
@@ -396,6 +531,9 @@ int main(int argc, char **argv)
 		case 'g':
 			notrigger = 1;
 			break;
+		case 'h':
+			use_high_speed = true;
+			break;
 		case 'l':
 			errno = 0;
 			buf_len = strtoul(optarg, &dummy, 10);
@@ -659,6 +797,29 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
+	scan_size = size_from_channelarray(channels, num_channels);
+	block_size = scan_size * buf_len;
+	/**
+	 * Need to enable high-speed before configuring length/enable.
+	 * Otherwise, the DMA buffer will work in fileio mode,
+	 * and mmap won't work.
+	 */
+	if (use_high_speed) {
+		/**
+		 * The block_size for one block is the same as 'data', but it
+		 * doesn't need to be the same size. It is easier for the sake
+		 * of this example.
+		 */
+		mmaps = enable_high_speed(buf_fd, block_size, nblocks);
+		if (!mmaps) {
+			fprintf(stderr, "Could not enable high-speed mode\n");
+			ret = -errno;
+			goto error;
+		}
+		mmaps_cnt = nblocks;
+		printf("Using high-speed mode\n");
+	}
+
 	/* Setup ring buffer parameters */
 	ret = write_sysfs_int("length", buf_dir_name, buf_len);
 	if (ret < 0)
@@ -673,8 +834,7 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
-	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size * buf_len);
+	data = malloc(block_size);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
@@ -721,7 +881,13 @@ int main(int argc, char **argv)
 			toread = 64;
 		}
 
-		read_size = read(buf_fd, data, toread * scan_size);
+		if (use_high_speed) {
+			read_size = read_high_speed(buf_fd, data, block_size,
+						    mmaps, mmaps_cnt);
+		} else {
+			read_size = read(buf_fd, data, toread * scan_size);
+		}
+
 		if (read_size < 0) {
 			if (errno == EAGAIN) {
 				fprintf(stderr, "nothing available\n");
@@ -740,8 +906,15 @@ int main(int argc, char **argv)
 
 	if (fd >= 0 && close(fd) == -1)
 		perror("Failed to close character device");
-	if (buf_fd >= 0 && close(buf_fd) == -1)
-		perror("Failed to close buffer");
+	for (i = 0; i < mmaps_cnt; i++)
+		munmap(mmaps[i].addr, mmaps[i].block.size);
+	free(mmaps);
+	if (buf_fd >= 0) {
+		if (use_high_speed)
+			ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
+		if (close(buf_fd) == -1)
+			perror("Failed to close buffer");
+	}
 	free(buffer_access);
 	free(data);
 	free(buf_dir_name);
-- 
2.17.1

