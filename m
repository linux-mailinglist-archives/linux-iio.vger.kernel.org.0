Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32135318A89
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBKM1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:27:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45068 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231810AbhBKMYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:24:05 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCMnnl016281;
        Thu, 11 Feb 2021 07:23:11 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qg8ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:23:11 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCN9W9004306
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:23:09 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 04:23:08 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 11 Feb 2021 04:23:07 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 11 Feb 2021 04:23:07 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWp011557;
        Thu, 11 Feb 2021 07:23:04 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 17/17] tools: iio: convert iio_generic_buffer to use new IIO buffer API
Date:   Thu, 11 Feb 2021 14:24:52 +0200
Message-ID: <20210211122452.78106-18-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_05:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change makes use of the new IIO buffer API to read data from an IIO
buffer.
It doesn't read the /sys/bus/iio/devices/iio:deviceX/scan_elements dir
anymore, it reads /sys/bus/iio/devices/iio:deviceX/bufferY, where all the
scan_elements have been merged together with the old/classical buffer
attributes.

And it makes use of the new IIO_BUFFER_GET_FD_IOCTL ioctl to get an FD for
the IIO buffer for which to read data from.
It also does a quick sanity check to see that -EBUSY is returned if reading
the chardev after the ioctl() has succeeded.

This was tested with the following cases:
 1. Tested buffer0 works with ioctl()
 2. Tested that buffer0 can't be opened via /dev/iio:deviceX after ioctl()
 3. Moved valid buffer0 to be buffer1, and tested that data comes from it

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 tools/iio/Makefile             |   1 +
 tools/iio/iio_generic_buffer.c | 120 ++++++++++++++++++++++++++-------
 tools/iio/iio_utils.c          |  13 ++--
 tools/iio/iio_utils.h          |   4 +-
 4 files changed, 105 insertions(+), 33 deletions(-)

diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 3de763d9ab70..5d12ac4e7f8f 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -27,6 +27,7 @@ include $(srctree)/tools/build/Makefile.include
 #
 $(OUTPUT)include/linux/iio: ../../include/uapi/linux/iio
 	mkdir -p $(OUTPUT)include/linux/iio 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/iio/buffer.h $@
 	ln -sf $(CURDIR)/../../include/uapi/linux/iio/events.h $@
 	ln -sf $(CURDIR)/../../include/uapi/linux/iio/types.h $@
 
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 7c7240553777..fdd08514d556 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -30,6 +30,8 @@
 #include <inttypes.h>
 #include <stdbool.h>
 #include <signal.h>
+#include <sys/ioctl.h>
+#include <linux/iio/buffer.h>
 #include "iio_utils.h"
 
 /**
@@ -197,7 +199,7 @@ static void process_scan(char *data, struct iio_channel_info *channels,
 	printf("\n");
 }
 
-static int enable_disable_all_channels(char *dev_dir_name, int enable)
+static int enable_disable_all_channels(char *dev_dir_name, int buffer_idx, int enable)
 {
 	const struct dirent *ent;
 	char scanelemdir[256];
@@ -205,7 +207,7 @@ static int enable_disable_all_channels(char *dev_dir_name, int enable)
 	int ret;
 
 	snprintf(scanelemdir, sizeof(scanelemdir),
-		 FORMAT_SCAN_ELEMENTS_DIR, dev_dir_name);
+		 FORMAT_SCAN_ELEMENTS_DIR, dev_dir_name, buffer_idx);
 	scanelemdir[sizeof(scanelemdir)-1] = '\0';
 
 	dp = opendir(scanelemdir);
@@ -243,6 +245,7 @@ static void print_usage(void)
 		"Capture, convert and output data from IIO device buffer\n"
 		"  -a         Auto-activate all available channels\n"
 		"  -A         Force-activate ALL channels\n"
+		"  -b <n>     The buffer which to open (by index), default 0\n"
 		"  -c <n>     Do n conversions, or loop forever if n < 0\n"
 		"  -e         Disable wait for event (new data)\n"
 		"  -g         Use trigger-less mode\n"
@@ -259,6 +262,7 @@ static void print_usage(void)
 static enum autochan autochannels = AUTOCHANNELS_DISABLED;
 static char *dev_dir_name = NULL;
 static char *buf_dir_name = NULL;
+static int buffer_idx = 0;
 static bool current_trigger_set = false;
 
 static void cleanup(void)
@@ -286,7 +290,7 @@ static void cleanup(void)
 
 	/* Disable channels if auto-enabled */
 	if (dev_dir_name && autochannels == AUTOCHANNELS_ACTIVE) {
-		ret = enable_disable_all_channels(dev_dir_name, 0);
+		ret = enable_disable_all_channels(dev_dir_name, buffer_idx, 0);
 		if (ret)
 			fprintf(stderr, "Failed to disable all channels\n");
 		autochannels = AUTOCHANNELS_DISABLED;
@@ -333,7 +337,9 @@ int main(int argc, char **argv)
 	unsigned long long j;
 	unsigned long toread;
 	int ret, c;
-	int fp = -1;
+	struct stat st;
+	int fd = -1;
+	int buf_fd = -1;
 
 	int num_channels = 0;
 	char *trigger_name = NULL, *device_name = NULL;
@@ -352,7 +358,7 @@ int main(int argc, char **argv)
 
 	register_cleanup();
 
-	while ((c = getopt_long(argc, argv, "aAc:egl:n:N:t:T:w:?", longopts,
+	while ((c = getopt_long(argc, argv, "aAb:c:egl:n:N:t:T:w:?", longopts,
 				NULL)) != -1) {
 		switch (c) {
 		case 'a':
@@ -361,7 +367,20 @@ int main(int argc, char **argv)
 		case 'A':
 			autochannels = AUTOCHANNELS_ENABLED;
 			force_autochannels = true;
-			break;	
+			break;
+		case 'b':
+			errno = 0;
+			buffer_idx = strtoll(optarg, &dummy, 10);
+			if (errno) {
+				ret = -errno;
+				goto error;
+			}
+			if (buffer_idx < 0) {
+				ret = -ERANGE;
+				goto error;
+			}
+
+			break;
 		case 'c':
 			errno = 0;
 			num_loops = strtoll(optarg, &dummy, 10);
@@ -518,7 +537,7 @@ int main(int argc, char **argv)
 	 * Parse the files in scan_elements to identify what channels are
 	 * present
 	 */
-	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
+	ret = build_channel_array(dev_dir_name, buffer_idx, &channels, &num_channels);
 	if (ret) {
 		fprintf(stderr, "Problem reading scan element information\n"
 			"diag %s\n", dev_dir_name);
@@ -535,7 +554,7 @@ int main(int argc, char **argv)
 	    (autochannels == AUTOCHANNELS_ENABLED && force_autochannels)) {
 		fprintf(stderr, "Enabling all channels\n");
 
-		ret = enable_disable_all_channels(dev_dir_name, 1);
+		ret = enable_disable_all_channels(dev_dir_name, buffer_idx, 1);
 		if (ret) {
 			fprintf(stderr, "Failed to enable all channels\n");
 			goto error;
@@ -544,7 +563,7 @@ int main(int argc, char **argv)
 		/* This flags that we need to disable the channels again */
 		autochannels = AUTOCHANNELS_ACTIVE;
 
-		ret = build_channel_array(dev_dir_name, &channels,
+		ret = build_channel_array(dev_dir_name, buffer_idx, &channels,
 					  &num_channels);
 		if (ret) {
 			fprintf(stderr, "Problem reading scan element "
@@ -565,7 +584,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "Enable channels manually in "
 			FORMAT_SCAN_ELEMENTS_DIR
 			"/*_en or pass -a to autoenable channels and "
-			"try again.\n", dev_dir_name);
+			"try again.\n", dev_dir_name, buffer_idx);
 		ret = -ENOENT;
 		goto error;
 	}
@@ -576,12 +595,25 @@ int main(int argc, char **argv)
 	 * be built rather than found.
 	 */
 	ret = asprintf(&buf_dir_name,
-		       "%siio:device%d/buffer", iio_dir, dev_num);
+		       "%siio:device%d/buffer%d", iio_dir, dev_num, buffer_idx);
 	if (ret < 0) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
+	if (stat(buf_dir_name, &st)) {
+		fprintf(stderr, "Could not stat() '%s', got error %d: %s\n",
+			buf_dir_name, errno, strerror(errno));
+		ret = -errno;
+		goto error;
+	}
+
+	if (!S_ISDIR(st.st_mode)) {
+		fprintf(stderr, "File '%s' is not a directory\n", buf_dir_name);
+		ret = -EFAULT;
+		goto error;
+	}
+
 	if (!notrigger) {
 		printf("%s %s\n", dev_dir_name, trigger_name);
 		/*
@@ -598,6 +630,37 @@ int main(int argc, char **argv)
 		}
 	}
 
+	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Attempt to open non blocking the access dev */
+	fd = open(buffer_access, O_RDONLY | O_NONBLOCK);
+	if (fd == -1) { /* TODO: If it isn't there make the node */
+		ret = -errno;
+		fprintf(stderr, "Failed to open %s\n", buffer_access);
+		goto error;
+	}
+
+	/* specify for which buffer index we want an FD */
+	buf_fd = buffer_idx;
+
+	ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &buf_fd);
+	if (ret == -1 || buf_fd == -1) {
+		ret = -errno;
+		if (ret == -ENODEV || ret == -EINVAL)
+			fprintf(stderr,
+				"This device does not support buffers\n");
+		else
+			fprintf(stderr, "Failed to retrieve buffer fd\n");
+		if (close(fd) == -1)
+			perror("Failed to close character device file");
+
+		goto error;
+	}
+
 	/* Setup ring buffer parameters */
 	ret = write_sysfs_int("length", buf_dir_name, buf_len);
 	if (ret < 0)
@@ -607,7 +670,8 @@ int main(int argc, char **argv)
 	ret = write_sysfs_int("enable", buf_dir_name, 1);
 	if (ret < 0) {
 		fprintf(stderr,
-			"Failed to enable buffer: %s\n", strerror(-ret));
+			"Failed to enable buffer '%s': %s\n",
+			buf_dir_name, strerror(-ret));
 		goto error;
 	}
 
@@ -618,24 +682,26 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
-	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error;
+	/* if this is buffer0, check that we get EBUSY after this point */
+	if (buffer_idx == 0) {
+		errno = 0;
+		read_size = read(fd, data, 1);
+		if (read_size > -1 || errno != EBUSY) {
+			ret = -EFAULT;
+			perror("Reading from '%s' should not be possible after ioctl()");
+			goto error;
+		}
 	}
 
-	/* Attempt to open non blocking the access dev */
-	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
-	if (fp == -1) { /* TODO: If it isn't there make the node */
-		ret = -errno;
-		fprintf(stderr, "Failed to open %s\n", buffer_access);
-		goto error;
-	}
+	/* close now the main chardev FD and let the buffer FD work */
+	if (close(fd) == -1)
+		perror("Failed to close character device file");
+	fd = -1;
 
 	for (j = 0; j < num_loops || num_loops < 0; j++) {
 		if (!noevents) {
 			struct pollfd pfd = {
-				.fd = fp,
+				.fd = buf_fd,
 				.events = POLLIN,
 			};
 
@@ -653,7 +719,7 @@ int main(int argc, char **argv)
 			toread = 64;
 		}
 
-		read_size = read(fp, data, toread * scan_size);
+		read_size = read(buf_fd, data, toread * scan_size);
 		if (read_size < 0) {
 			if (errno == EAGAIN) {
 				fprintf(stderr, "nothing available\n");
@@ -670,7 +736,9 @@ int main(int argc, char **argv)
 error:
 	cleanup();
 
-	if (fp >= 0 && close(fp) == -1)
+	if (fd >= 0 && close(fd) == -1)
+		perror("Failed to close character device");
+	if (buf_fd >= 0 && close(buf_fd) == -1)
 		perror("Failed to close buffer");
 	free(buffer_access);
 	free(data);
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index a96002f2c2d5..aadee6d34c74 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -77,6 +77,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
  * @mask: output a bit mask for the raw data
  * @be: output if data in big endian
  * @device_dir: the IIO device directory
+ * @buffer_idx: the IIO buffer index
  * @name: the channel name
  * @generic_name: the channel type name
  *
@@ -85,8 +86,8 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
 static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
 			     unsigned int *bits_used, unsigned int *shift,
 			     uint64_t *mask, unsigned int *be,
-			     const char *device_dir, const char *name,
-			     const char *generic_name)
+			     const char *device_dir, int buffer_idx,
+			     const char *name, const char *generic_name)
 {
 	FILE *sysfsfp;
 	int ret;
@@ -96,7 +97,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
 	unsigned padint;
 	const struct dirent *ent;
 
-	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
+	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir, buffer_idx);
 	if (ret < 0)
 		return -ENOMEM;
 
@@ -304,12 +305,13 @@ void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
 /**
  * build_channel_array() - function to figure out what channels are present
  * @device_dir: the IIO device directory in sysfs
+ * @buffer_idx: the IIO buffer for this channel array
  * @ci_array: output the resulting array of iio_channel_info
  * @counter: output the amount of array elements
  *
  * Returns 0 on success, otherwise a negative error code.
  **/
-int build_channel_array(const char *device_dir,
+int build_channel_array(const char *device_dir, int buffer_idx,
 			struct iio_channel_info **ci_array, int *counter)
 {
 	DIR *dp;
@@ -322,7 +324,7 @@ int build_channel_array(const char *device_dir,
 	char *filename;
 
 	*counter = 0;
-	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
+	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir, buffer_idx);
 	if (ret < 0)
 		return -ENOMEM;
 
@@ -503,6 +505,7 @@ int build_channel_array(const char *device_dir,
 						&current->mask,
 						&current->be,
 						device_dir,
+						buffer_idx,
 						current->name,
 						current->generic_name);
 			if (ret < 0)
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index a5d0aa8a57d3..336752cade4f 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -12,7 +12,7 @@
 /* Made up value to limit allocation sizes */
 #define IIO_MAX_NAME_LENGTH 64
 
-#define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
+#define FORMAT_SCAN_ELEMENTS_DIR "%s/buffer%d"
 #define FORMAT_TYPE_FILE "%s_type"
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
@@ -61,7 +61,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
 			     const char *device_dir, const char *name,
 			     const char *generic_name);
 void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt);
-int build_channel_array(const char *device_dir,
+int build_channel_array(const char *device_dir, int buffer_idx,
 			struct iio_channel_info **ci_array, int *counter);
 int find_type_by_name(const char *name, const char *type);
 int write_sysfs_int(const char *filename, const char *basedir, int val);
-- 
2.17.1

