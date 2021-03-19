Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE77341ED7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCSNxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhCSNxF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 09:53:05 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9BCC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 06:53:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f16so12131304ljm.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUeLUnlR94xPX9N99aZukfRyU4Iy1tiBeTupyd+pyx8=;
        b=uQuEHNI/9cJcCsjIsiPwcwo459OQnbbXyioPoMHiGAGptuCnLSHP0n0ouWWuUni58L
         9t409IjsGwmh01AQpbNfJGN4jfMwZOy8J7qNQnIgLrjxms1aoiBnQHZs/2zFDHxh1Uk6
         m5SzpC3K6HKp+lTq+KWqNsaEwgNVlyCLWpKiPtJgj/FEpGZ2URREeoDSxaAH1X/ItjxJ
         uiw3+WUx9o+wzxRb3NV49pNZbrvjXPc+ME+6PXiNkR4tLlvDxyrH5w1FhpYT6QQHpvmd
         WGz497YDBlOtFbH2pkgxY6iqav4Cd69WmmcaaYyVbXJJiXuNo71bVN6bJiQnN9rtJIWq
         b/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUeLUnlR94xPX9N99aZukfRyU4Iy1tiBeTupyd+pyx8=;
        b=iPMMJbieFmrX4wuHEI34exO1ROxYpkTLRxnhMvhDIXlqa2jVRW9A52oRJaya0vbOFf
         uRICyYf1/WqHSbaMSQLbhdDMRR6MA/nf38AaVSGCI/y+4X4I2l8QKX47tS+eMQDlL7Id
         ia+QTov1f5BCU2xvnYNsZgEWhMliVyrkvhLYFWgVGx2KJ8kEvsqxqTiRyKwns4J+2bVw
         /+dFpnh4CQES38bVZgqlvPT/LMG6myicPJ0uR6XiMQqgnE6kEqnTXLfb8Yp3k21A1zVX
         +pJ98+crTalMgoXKc2lNoEFUyC7r2J+VEf4isyfB3amBbQFRnA9ObJvC+NyDfhOxR+Zw
         v/AA==
X-Gm-Message-State: AOAM533/tjbfOerNlTQhXgFbtCwNwCFpmZeComrddg1x8jMLpWEh0Cev
        bKm+eF13bequTv9V4UQAfVy1Qg==
X-Google-Smtp-Source: ABdhPJyVrwoaEOYh5yILayEx2npwUSCd2BoK6URqcmhcPOrR83F7KYXrdq74v6y7bujuORin9M4cBg==
X-Received: by 2002:a2e:9002:: with SMTP id h2mr1040208ljg.145.1616161983176;
        Fri, 19 Mar 2021 06:53:03 -0700 (PDT)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id m8sm91795lfa.274.2021.03.19.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:53:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2] iio: event_monitor: Enable events before monitoring
Date:   Fri, 19 Mar 2021 14:53:01 +0100
Message-Id: <20210319135301.542911-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After some painful sessions with a driver that register an
enable/disable sysfs knob (gp2ap002) and manually going
in and enabling the event before monitoring it:

  cd /sys/bus/iio/devices/iio\:device2/events
  # ls
  in_proximity_thresh_either_en
  # echo 1 > in_proximity_thresh_either_en

I realized that it's better if the iio_event_monitor is
smart enough to enable all events by itself and disable them
after use, if passed the -a flag familiar from the
iio_generic_buffer tool.

Auto-enabling events depend on the hardware being able
to handle all events at the same time which isn't
necessarily the case, so a command line option is required
for this.

Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Activate all events in response to -a being passed
  on the command line
- Update help text
---
 tools/iio/iio_event_monitor.c | 69 ++++++++++++++++++++++++++++++++---
 tools/iio/iio_utils.h         |  1 +
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index bb03859db89d..0076437f6e3f 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -14,6 +14,7 @@
 
 #include <unistd.h>
 #include <stdlib.h>
+#include <dirent.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <errno.h>
@@ -280,22 +281,69 @@ static void print_event(struct iio_event_data *event)
 	printf("\n");
 }
 
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
 int main(int argc, char **argv)
 {
 	struct iio_event_data event;
 	const char *device_name;
+	char *dev_dir_name = NULL;
 	char *chrdev_name;
 	int ret;
 	int dev_num;
 	int fd, event_fd;
-
-	if (argc <= 1) {
-		fprintf(stderr, "Usage: %s <device_name>\n", argv[0]);
+	bool all_events = false;
+
+	if (argc == 2) {
+		device_name = argv[1];
+	} else if (argc == 3) {
+		device_name = argv[2];
+		if (!strcmp(argv[1], "-a"))
+			all_events = true;
+	} else {
+		fprintf(stderr,
+			"Usage: iio_event_monitor [options] <device_name>\n"
+			"Listen and display events from IIO devices\n"
+			"  -a         Auto-activate all available events\n");
 		return -1;
 	}
 
-	device_name = argv[1];
-
 	dev_num = find_type_by_name(device_name, "iio:device");
 	if (dev_num >= 0) {
 		printf("Found IIO device with name %s with device number %d\n",
@@ -303,6 +351,10 @@ int main(int argc, char **argv)
 		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
 		if (ret < 0)
 			return -ENOMEM;
+		/* Look up sysfs dir as well if we can */
+		ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
+		if (ret < 0)
+			return -ENOMEM;
 	} else {
 		/*
 		 * If we can't find an IIO device by name assume device_name is
@@ -313,6 +365,9 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 	}
 
+	if (all_events && dev_dir_name)
+		enable_events(dev_dir_name, 1);
+
 	fd = open(chrdev_name, 0);
 	if (fd == -1) {
 		ret = -errno;
@@ -365,6 +420,10 @@ int main(int argc, char **argv)
 		perror("Failed to close event file");
 
 error_free_chrdev_name:
+	/* Disable events after use */
+	if (all_events && dev_dir_name)
+		enable_events(dev_dir_name, 0);
+
 	free(chrdev_name);
 
 	return ret;
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 74bde4fde2c8..c01695049739 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -13,6 +13,7 @@
 #define IIO_MAX_NAME_LENGTH 64
 
 #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
+#define FORMAT_EVENTS_DIR "%s/events"
 #define FORMAT_TYPE_FILE "%s_type"
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
-- 
2.29.2

