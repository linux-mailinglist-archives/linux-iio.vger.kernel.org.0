Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70D53433D7
	for <lists+linux-iio@lfdr.de>; Sun, 21 Mar 2021 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCURpV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 13:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhCURpB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Mar 2021 13:45:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0712601FC;
        Sun, 21 Mar 2021 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616348701;
        bh=fVDAACX8ix9LaRMMegRXWetEFa5OcuvVileJdJEaBVY=;
        h=From:To:Cc:Subject:Date:From;
        b=bHevauPJDQ2Y8aLFxTDRB1AsmJ5dek8KtTMRau3/Gm3XvqdrjQkDQLE7YSEB/Bfs/
         +d8SqB0vqt/vday1fnvmqcWrIiXFdOq5vZolfopLMYSz1Tm5gegs1MzedWW5u6gKcg
         PTJsTBICif68HOtntNPlBnJaKlEy/4/cn3BZDEFML3SDUW4IVSNowCSdyMGIzOETTW
         quO9FpviK6V8iOftuxreOJrXI2kM1QjPP86fBmd5btm6K7gDqHUlhEsMveCom96/iL
         em4C79BOpFuH0R+8ng025GloO51XiOKSaXcQpXRKbBRC+QV0RrGdkoqjoQPSBvCpxE
         zRcYDK4uKjYvg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:tools: PoC client server version of iio_event_monitor
Date:   Sun, 21 Mar 2021 17:42:57 +0000
Message-Id: <20210321174257.784913-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is not intended for upstreaming etc, but rather as a crude
way of illustrating use of unix sockets to hand over the file
descriptors between programs.

It might be useful to do this for the event anon FD, but real target
is the buffer anon FDs for multiple buffer IIO devices.

In that case, first opener of the main file descriptor would
hand off management to a thread which could then receive
requests for the different buffer FDs.

Anynow this is clearly a hacked up mess based on cope coppied
from the internet ;)

Not-signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/iio/Build               |   1 +
 tools/iio/Makefile            |   7 +-
 tools/iio/iio_event_network.c | 545 ++++++++++++++++++++++++++++++++++
 3 files changed, 552 insertions(+), 1 deletion(-)

diff --git a/tools/iio/Build b/tools/iio/Build
index 8d0f3af3723f..077028ae1150 100644
--- a/tools/iio/Build
+++ b/tools/iio/Build
@@ -2,3 +2,4 @@ iio_utils-y += iio_utils.o
 lsiio-y += lsiio.o iio_utils.o
 iio_event_monitor-y += iio_event_monitor.o iio_utils.o
 iio_generic_buffer-y += iio_generic_buffer.o iio_utils.o
+iio_event_network-y += iio_event_network.o iio_utils.o
\ No newline at end of file
diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index 5d12ac4e7f8f..d63608fa0243 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -14,7 +14,7 @@ MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
+ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer iio_event_network
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -55,6 +55,11 @@ $(IIO_GENERIC_BUFFER_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
+IIO_EVENT_NETWORK_IN := $(OUTPUT)iio_event_network-in.o
+$(IIO_EVENT_NETWORK_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
+	$(Q)$(MAKE) $(build)=iio_event_network
+$(OUTPUT)iio_event_network: $(IIO_EVENT_NETWORK_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/linux/iio
diff --git a/tools/iio/iio_event_network.c b/tools/iio/iio_event_network.c
new file mode 100644
index 000000000000..186f5cc8bb94
--- /dev/null
+++ b/tools/iio/iio_event_network.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Industrialio event test code.
+ *
+ * Copyright (c) 2011-2012 Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * This program is primarily intended as an example application.
+ * Reads the current buffer setup from sysfs and starts a short capture
+ * from the specified device, pretty printing the result after appropriate
+ * conversion.
+ *
+ * Usage:
+ *	iio_event_monitor <device_name>
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <poll.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <sys/socket.h>
+
+
+#include "iio_utils.h"
+#include <linux/iio/events.h>
+#include <linux/iio/types.h>
+
+static const char * const iio_chan_type_name_spec[] = {
+	[IIO_VOLTAGE] = "voltage",
+	[IIO_CURRENT] = "current",
+	[IIO_POWER] = "power",
+	[IIO_ACCEL] = "accel",
+	[IIO_ANGL_VEL] = "anglvel",
+	[IIO_MAGN] = "magn",
+	[IIO_LIGHT] = "illuminance",
+	[IIO_INTENSITY] = "intensity",
+	[IIO_PROXIMITY] = "proximity",
+	[IIO_TEMP] = "temp",
+	[IIO_INCLI] = "incli",
+	[IIO_ROT] = "rot",
+	[IIO_ANGL] = "angl",
+	[IIO_TIMESTAMP] = "timestamp",
+	[IIO_CAPACITANCE] = "capacitance",
+	[IIO_ALTVOLTAGE] = "altvoltage",
+	[IIO_CCT] = "cct",
+	[IIO_PRESSURE] = "pressure",
+	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_ACTIVITY] = "activity",
+	[IIO_STEPS] = "steps",
+	[IIO_ENERGY] = "energy",
+	[IIO_DISTANCE] = "distance",
+	[IIO_VELOCITY] = "velocity",
+	[IIO_CONCENTRATION] = "concentration",
+	[IIO_RESISTANCE] = "resistance",
+	[IIO_PH] = "ph",
+	[IIO_UVINDEX] = "uvindex",
+	[IIO_GRAVITY] = "gravity",
+	[IIO_POSITIONRELATIVE] = "positionrelative",
+	[IIO_PHASE] = "phase",
+	[IIO_MASSCONCENTRATION] = "massconcentration",
+};
+
+static const char * const iio_ev_type_text[] = {
+	[IIO_EV_TYPE_THRESH] = "thresh",
+	[IIO_EV_TYPE_MAG] = "mag",
+	[IIO_EV_TYPE_ROC] = "roc",
+	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
+	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
+	[IIO_EV_TYPE_CHANGE] = "change",
+};
+
+static const char * const iio_ev_dir_text[] = {
+	[IIO_EV_DIR_EITHER] = "either",
+	[IIO_EV_DIR_RISING] = "rising",
+	[IIO_EV_DIR_FALLING] = "falling"
+};
+
+static const char * const iio_modifier_names[] = {
+	[IIO_MOD_X] = "x",
+	[IIO_MOD_Y] = "y",
+	[IIO_MOD_Z] = "z",
+	[IIO_MOD_X_AND_Y] = "x&y",
+	[IIO_MOD_X_AND_Z] = "x&z",
+	[IIO_MOD_Y_AND_Z] = "y&z",
+	[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
+	[IIO_MOD_X_OR_Y] = "x|y",
+	[IIO_MOD_X_OR_Z] = "x|z",
+	[IIO_MOD_Y_OR_Z] = "y|z",
+	[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
+	[IIO_MOD_LIGHT_BOTH] = "both",
+	[IIO_MOD_LIGHT_IR] = "ir",
+	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
+	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
+	[IIO_MOD_LIGHT_CLEAR] = "clear",
+	[IIO_MOD_LIGHT_RED] = "red",
+	[IIO_MOD_LIGHT_GREEN] = "green",
+	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_DUV] = "duv",
+	[IIO_MOD_QUATERNION] = "quaternion",
+	[IIO_MOD_TEMP_AMBIENT] = "ambient",
+	[IIO_MOD_TEMP_OBJECT] = "object",
+	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
+	[IIO_MOD_NORTH_TRUE] = "from_north_true",
+	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
+	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
+	[IIO_MOD_RUNNING] = "running",
+	[IIO_MOD_JOGGING] = "jogging",
+	[IIO_MOD_WALKING] = "walking",
+	[IIO_MOD_STILL] = "still",
+	[IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
+	[IIO_MOD_I] = "i",
+	[IIO_MOD_Q] = "q",
+	[IIO_MOD_CO2] = "co2",
+	[IIO_MOD_ETHANOL] = "ethanol",
+	[IIO_MOD_H2] = "h2",
+	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_PM1] = "pm1",
+	[IIO_MOD_PM2P5] = "pm2p5",
+	[IIO_MOD_PM4] = "pm4",
+	[IIO_MOD_PM10] = "pm10",
+	[IIO_MOD_O2] = "o2",
+};
+
+static bool event_is_known(struct iio_event_data *event)
+{
+	enum iio_chan_type type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event->id);
+	enum iio_modifier mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event->id);
+	enum iio_event_type ev_type = IIO_EVENT_CODE_EXTRACT_TYPE(event->id);
+	enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(event->id);
+
+	switch (type) {
+	case IIO_VOLTAGE:
+	case IIO_CURRENT:
+	case IIO_POWER:
+	case IIO_ACCEL:
+	case IIO_ANGL_VEL:
+	case IIO_MAGN:
+	case IIO_LIGHT:
+	case IIO_INTENSITY:
+	case IIO_PROXIMITY:
+	case IIO_TEMP:
+	case IIO_INCLI:
+	case IIO_ROT:
+	case IIO_ANGL:
+	case IIO_TIMESTAMP:
+	case IIO_CAPACITANCE:
+	case IIO_ALTVOLTAGE:
+	case IIO_CCT:
+	case IIO_PRESSURE:
+	case IIO_HUMIDITYRELATIVE:
+	case IIO_ACTIVITY:
+	case IIO_STEPS:
+	case IIO_ENERGY:
+	case IIO_DISTANCE:
+	case IIO_VELOCITY:
+	case IIO_CONCENTRATION:
+	case IIO_RESISTANCE:
+	case IIO_PH:
+	case IIO_UVINDEX:
+	case IIO_GRAVITY:
+	case IIO_POSITIONRELATIVE:
+	case IIO_PHASE:
+	case IIO_MASSCONCENTRATION:
+		break;
+	default:
+		return false;
+	}
+
+	switch (mod) {
+	case IIO_NO_MOD:
+	case IIO_MOD_X:
+	case IIO_MOD_Y:
+	case IIO_MOD_Z:
+	case IIO_MOD_X_AND_Y:
+	case IIO_MOD_X_AND_Z:
+	case IIO_MOD_Y_AND_Z:
+	case IIO_MOD_X_AND_Y_AND_Z:
+	case IIO_MOD_X_OR_Y:
+	case IIO_MOD_X_OR_Z:
+	case IIO_MOD_Y_OR_Z:
+	case IIO_MOD_X_OR_Y_OR_Z:
+	case IIO_MOD_LIGHT_BOTH:
+	case IIO_MOD_LIGHT_IR:
+	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
+	case IIO_MOD_SUM_SQUARED_X_Y_Z:
+	case IIO_MOD_LIGHT_CLEAR:
+	case IIO_MOD_LIGHT_RED:
+	case IIO_MOD_LIGHT_GREEN:
+	case IIO_MOD_LIGHT_BLUE:
+	case IIO_MOD_LIGHT_UV:
+	case IIO_MOD_LIGHT_DUV:
+	case IIO_MOD_QUATERNION:
+	case IIO_MOD_TEMP_AMBIENT:
+	case IIO_MOD_TEMP_OBJECT:
+	case IIO_MOD_NORTH_MAGN:
+	case IIO_MOD_NORTH_TRUE:
+	case IIO_MOD_NORTH_MAGN_TILT_COMP:
+	case IIO_MOD_NORTH_TRUE_TILT_COMP:
+	case IIO_MOD_RUNNING:
+	case IIO_MOD_JOGGING:
+	case IIO_MOD_WALKING:
+	case IIO_MOD_STILL:
+	case IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z:
+	case IIO_MOD_I:
+	case IIO_MOD_Q:
+	case IIO_MOD_CO2:
+	case IIO_MOD_ETHANOL:
+	case IIO_MOD_H2:
+	case IIO_MOD_VOC:
+	case IIO_MOD_PM1:
+	case IIO_MOD_PM2P5:
+	case IIO_MOD_PM4:
+	case IIO_MOD_PM10:
+	case IIO_MOD_O2:
+		break;
+	default:
+		return false;
+	}
+
+	switch (ev_type) {
+	case IIO_EV_TYPE_THRESH:
+	case IIO_EV_TYPE_MAG:
+	case IIO_EV_TYPE_ROC:
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+	case IIO_EV_TYPE_CHANGE:
+		break;
+	default:
+		return false;
+	}
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+	case IIO_EV_DIR_RISING:
+	case IIO_EV_DIR_FALLING:
+	case IIO_EV_DIR_NONE:
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static void print_event(struct iio_event_data *event)
+{
+	enum iio_chan_type type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event->id);
+	enum iio_modifier mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event->id);
+	enum iio_event_type ev_type = IIO_EVENT_CODE_EXTRACT_TYPE(event->id);
+	enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(event->id);
+	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event->id);
+	int chan2 = IIO_EVENT_CODE_EXTRACT_CHAN2(event->id);
+	bool diff = IIO_EVENT_CODE_EXTRACT_DIFF(event->id);
+
+	if (!event_is_known(event)) {
+		fprintf(stderr, "Unknown event: time: %lld, id: %llx\n",
+			event->timestamp, event->id);
+
+		return;
+	}
+
+	printf("Event: time: %lld, type: %s", event->timestamp,
+	       iio_chan_type_name_spec[type]);
+
+	if (mod != IIO_NO_MOD)
+		printf("(%s)", iio_modifier_names[mod]);
+
+	if (chan >= 0) {
+		printf(", channel: %d", chan);
+		if (diff && chan2 >= 0)
+			printf("-%d", chan2);
+	}
+
+	printf(", evtype: %s", iio_ev_type_text[ev_type]);
+
+	if (dir != IIO_EV_DIR_NONE)
+		printf(", direction: %s", iio_ev_dir_text[dir]);
+
+	printf("\n");
+}
+
+/* Enable or disable events in sysfs if the knob is available */
+static void enable_events(char *dev_dir, int enable)
+{
+	const struct dirent *ent;
+	char evdir[256];
+	int ret;
+	DIR *dp;
+
+	snprintf(evdir, sizeof(evdir), FORMAT_EVENTS_DIR, dev_dir);
+	evdir[sizeof(evdir)-1] = '\0';
+
+	dp = opendir(evdir);
+	if (!dp) {
+		fprintf(stderr, "Enabling/disabling events: can't open %s\n",
+			evdir);
+		return;
+	}
+
+	while (ent = readdir(dp), ent) {
+		if (iioutils_check_suffix(ent->d_name, "_en")) {
+			printf("%sabling: %s\n",
+			       enable ? "En" : "Dis",
+			       ent->d_name);
+			ret = write_sysfs_int(ent->d_name, evdir,
+					      enable);
+			if (ret < 0)
+				fprintf(stderr, "Failed to enable/disable %s\n",
+					ent->d_name);
+		}
+	}
+
+	if (closedir(dp) == -1) {
+		perror("Enabling/disabling channels: "
+		       "Failed to close directory");
+		return;
+	}
+}
+
+static int send_fd(int socket, int fd)
+{
+        struct msghdr msg = {0};
+        struct cmsghdr *cmsg;
+        char buf[CMSG_SPACE(sizeof(int))], dup[256];
+        memset(buf, 0, sizeof(buf));
+        struct iovec io = { .iov_base = &dup, .iov_len = sizeof(dup) };
+
+        msg.msg_iov = &io;
+        msg.msg_iovlen = 1;
+        msg.msg_control = buf;
+        msg.msg_controllen = sizeof(buf);
+
+        cmsg = CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_level = SOL_SOCKET;
+        cmsg->cmsg_type = SCM_RIGHTS;
+        cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+
+        memcpy ((int *)CMSG_DATA(cmsg), &fd, sizeof(int));
+
+	printf("Sending event FD to client\n");
+        if (sendmsg (socket, &msg, 0) < 0) {
+		printf("Failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int recv_fd(int socket)
+{
+	int fd;
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	char buf[CMSG_SPACE(sizeof(int))], dup[256];
+	memset(buf, 0, sizeof(buf));
+	struct iovec io = { .iov_base = &dup, .iov_len = sizeof(dup) };
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buf;
+	msg.msg_controllen = sizeof(buf);
+
+	printf("Waiting for event file descriptor...\n");
+	if (recvmsg (socket, &msg, 0) < 0) {
+		printf("Failed to receive message\n");
+		return -1;
+	}
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	memcpy (&fd, (int *) CMSG_DATA(cmsg), sizeof(int));
+
+	printf("Recieved event FD\n");
+
+	return fd;
+}
+
+int main(int argc, char **argv)
+{
+	struct iio_event_data event;
+	const char *filename = "/tmp/iio-ev-bridge";
+	const char *device_name;
+	int sfd, cfd;
+	struct sockaddr_un addr;
+	char *dev_dir_name = NULL;
+	char *chrdev_name;
+	int ret;
+	int dev_num;
+	int fd, event_fd;
+	bool all_events = false;
+	bool client = false;
+
+	if (argc == 2) {
+		if (!strcmp(argv[1], "-c"))
+			client = true;
+		else
+			device_name = argv[1];
+
+	} else if (argc == 3) {
+		device_name = argv[2];
+		if (!strcmp(argv[1], "-a"))
+			all_events = true;
+	} else {
+		fprintf(stderr,
+			"Usage: iio_event_monitor [options] <device_name>\n"
+			"Listen and display events from IIO devices\n"
+			"  -a         Auto-activate all available events\n"
+			"  -c         Client mode\n");
+		return -1;
+	}
+
+	if (!client) {
+
+		dev_num = find_type_by_name(device_name, "iio:device");
+		if (dev_num >= 0) {
+			printf("Found IIO device with name %s with device number %d\n",
+				device_name, dev_num);
+			ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
+			if (ret < 0)
+				return -ENOMEM;
+			/* Look up sysfs dir as well if we can */
+			ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
+			if (ret < 0)
+				return -ENOMEM;
+		} else {
+			/*
+			 * If we can't find an IIO device by name assume device_name is
+			 * an IIO chrdev
+			 */
+			chrdev_name = strdup(device_name);
+			if (!chrdev_name)
+				return -ENOMEM;
+		}
+
+		if (all_events && dev_dir_name)
+			enable_events(dev_dir_name, 1);
+
+		fd = open(chrdev_name, 0);
+		if (fd == -1) {
+			ret = -errno;
+			fprintf(stderr, "Failed to open %s\n", chrdev_name);
+			goto error_free_chrdev_name;
+		}
+
+		ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
+		if (ret == -1 || event_fd == -1) {
+			ret = -errno;
+			if (ret == -ENODEV)
+				fprintf(stderr,
+					"This device does not support events\n");
+			else
+				fprintf(stderr, "Failed to retrieve event fd\n");
+			if (close(fd) == -1)
+				perror("Failed to close character device file");
+
+			goto error_free_chrdev_name;
+		}
+
+		if (close(fd) == -1)  {
+			ret = -errno;
+			goto error_free_chrdev_name;
+		}
+
+		sfd = socket(AF_UNIX, SOCK_STREAM, 0);
+		if (sfd == -1) {
+			printf("Could not create socket\n");
+			return -1;
+		}
+
+		memset(&addr, 0, sizeof(addr));
+		addr.sun_family = AF_UNIX;
+		strncpy(addr.sun_path, filename, sizeof(addr.sun_path) -1);
+		if (bind(sfd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
+			printf("Failed to bind\n");
+		}
+		if (listen(sfd, 5) == -1) {
+			printf("Failed to listen on socket\n");
+			return -1;
+		}
+		cfd = accept(sfd, NULL, NULL);
+		if (cfd == -1) {
+			printf("failed accept\n");
+			return -1;
+		}
+		send_fd(cfd, event_fd);
+
+		return 0;
+	}
+	/* Client path */
+	sfd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sfd == -1) {
+		printf("could not create socket\n");
+		return -1;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, filename, sizeof(addr.sun_path) -1);
+	if (connect(sfd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
+		printf ("Failed to connect to socket\n");
+		return -1;
+	}
+
+	event_fd = recv_fd(sfd);
+
+	while (true) {
+		ret = read(event_fd, &event, sizeof(event));
+		if (ret == -1) {
+			if (errno == EAGAIN) {
+				fprintf(stderr, "nothing available\n");
+				continue;
+			} else {
+				ret = -errno;
+				perror("Failed to read event from device");
+				break;
+			}
+		}
+
+		if (ret != sizeof(event)) {
+			fprintf(stderr, "Reading event failed!\n");
+			ret = -EIO;
+			break;
+		}
+
+		print_event(&event);
+	}
+
+	if (close(event_fd) == -1)
+		perror("Failed to close event file");
+
+error_free_chrdev_name:
+	/* Disable events after use */
+	if (all_events && dev_dir_name)
+		enable_events(dev_dir_name, 0);
+
+	free(chrdev_name);
+
+	return ret;
+}
-- 
2.31.0

