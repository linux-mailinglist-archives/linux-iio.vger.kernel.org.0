Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5760332D6E4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhCDPnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Mar 2021 10:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhCDPmy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Mar 2021 10:42:54 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BB7C061756
        for <linux-iio@vger.kernel.org>; Thu,  4 Mar 2021 07:42:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d3so43896658lfg.10
        for <linux-iio@vger.kernel.org>; Thu, 04 Mar 2021 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMbajUgnTB/2LWOxJznLMcb3muehk9VHUKLul6lQFrs=;
        b=O4jgkvo7UnKbOu1E+ZKa99UoLlWrncYqRtDwoVJ3s/sksFoe6176pRydiexWvEVJtM
         VK7G6F/a++LULWibIVdEMpDdiMNFPd5aBgFt+dqm/mX6VUwWQNHVyyTj1b7CYFfo8vnb
         NmlXpTae05RKZzSR1lEIwPgsYiM3kGIQEz62S8e4mC+j3n4SR0r14tlXvnx2tvQSNxbi
         IGPeIs40sqoPjyTAxPpaW50ihb30/8rKkY0oyZkL+T5E8CRhfKUZng/I9i3YUfL+G2M3
         HJTC38fMQ7ufuLG8aFMBTFVHC6Ei9m179FJLW7zQ4FbDkPgPRL66CHhXZN8nqtJ2+RFT
         0N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMbajUgnTB/2LWOxJznLMcb3muehk9VHUKLul6lQFrs=;
        b=F4wIAJX7sLRGDQs0v2NbfPA+E9HIeTbVgZlPCTQNWAMXAx97nF9BGlD1MCc+4XELPG
         BYzz+9BRAog0ULuy9N/gm1jEnR1H+JC9UlKIA87fBa9E1+lWU/v35KWcsEyWaPL9m9Z7
         27Gt9pbace/v4Sk4vkRjKiIOSUKwb7uedzGQ6LX42QBmhN4cSqIBeYDN3KzCC+r4v84D
         /+pJPTCTmXHkoCX0PwyRHysu2kH5zAswp0T3SFHEri6nOVGKDpWKrQYMNBnJVekBRi+H
         W34lVZbh6cCeN6qs++ENOfsz6TVq6KySWQe4pOTORCa9EQ+8KxYBiPr5csiIuFc/XpQ1
         0oHA==
X-Gm-Message-State: AOAM533ifbf7zuWvuRacScmZfZpZF7JsZA5bemJul/HFKU1JtNNOcZnO
        2wluZyJWHUVy+mlYNRIYXXYsdw==
X-Google-Smtp-Source: ABdhPJzGXDEC1nZXLr6SJpWZkXcj7gtoXYETC515L2lQIboDvNQpIY2iY+TnMfEOcOf/1IvSkqTozQ==
X-Received: by 2002:a19:3f93:: with SMTP id m141mr2567676lfa.423.1614872532566;
        Thu, 04 Mar 2021 07:42:12 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id a3sm2202417lfr.55.2021.03.04.07.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:42:12 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] iio: event_monitor: Enable events before monitoring
Date:   Thu,  4 Mar 2021 16:42:05 +0100
Message-Id: <20210304154205.1918124-1-linus.walleij@linaro.org>
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
after use.

I didn't add a command line option for this, to me it
seems pretty intuitive and mostly what you want the tool
to do for you.

Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Bastien: added you on CC FYI because I suppose maybe
iio-sensor-proxy isn't yet doing this and one day people
will wonder why their events aren't arriving.
---
 tools/iio/iio_event_monitor.c | 51 +++++++++++++++++++++++++++++++++++
 tools/iio/iio_utils.h         |  1 +
 2 files changed, 52 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index bb03859db89d..27778fe28f82 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -14,6 +14,7 @@
 
 #include <unistd.h>
 #include <stdlib.h>
+#include <dirent.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <errno.h>
@@ -280,10 +281,49 @@ static void print_event(struct iio_event_data *event)
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
@@ -303,6 +343,10 @@ int main(int argc, char **argv)
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
@@ -313,6 +357,9 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 	}
 
+	if (dev_dir_name)
+		enable_events(dev_dir_name, 1);
+
 	fd = open(chrdev_name, 0);
 	if (fd == -1) {
 		ret = -errno;
@@ -365,6 +412,10 @@ int main(int argc, char **argv)
 		perror("Failed to close event file");
 
 error_free_chrdev_name:
+	/* Disable events after use */
+	if (dev_dir_name)
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

