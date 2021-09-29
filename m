Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F296C41BD37
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 05:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbhI2DSe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbhI2DSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 23:18:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69AEC061749;
        Tue, 28 Sep 2021 20:16:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n2so526086plk.12;
        Tue, 28 Sep 2021 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7q1KZGQrg9VSlOg55Y4jOv+nbaa+ZG4SOxiTCfz7+A=;
        b=c4YPx4QoCrd0LGbTXbyUsP5aDbIbvZS1byEnV0+QSmllLjdlS/W4H5oVGH5norE9W0
         ItSVOzSGjeNvSisYf/MBeAseD5hc17VbXOZIYCBzzJ25BLuybrXTDNGJiEv1977rXPk6
         HpgL1kJ/56+u68hhXeRPXEB7Q2XRL+KmwBbRBe80TJPtAuR/CUIo4JCppKW2Iog2SZn9
         TdqpoVTP7O/kaeSxl39+wh2O40vLXPzJ9kPUK0eqwjkbmyHc8ZVWNgiCqaUBpEU09wF1
         zVvG7dVTjeWzHN8OsiKI64BTT492xjV3h7HjietjExDSiV2NJHFefu+qxjtBRQ5jbbfd
         jTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7q1KZGQrg9VSlOg55Y4jOv+nbaa+ZG4SOxiTCfz7+A=;
        b=iw69fbotgMPAYpa/NL4hBCdHIaGU6whUcnb0wTO57/3s4YMyy1G5wBKk1uRDHy5PeL
         OW74p/pU8PnR8zGpXZPV9PVcCT2i48uo6YBTXmCcyserDc9VCoUBIzHjSbbqnZxcK0yp
         kKHY022rG7i/IcHRB0mgf+q3qLENh0Z0xqedeQehRvxJYnIsVzUCfJwblgbyrHQ8/3ZU
         sCyTNjLXvfRBj/8w2UbojzSF8KxXNAAhV41l+PogfQErXtE/2yvbtiobet6WSmh+C/cM
         Ez7NotGWx9kqjSlhS6PfGHpWJU0kVEkTahZrxW+TaY3drNAgrXyCRH3UcdiMIvUT5VrF
         v1/A==
X-Gm-Message-State: AOAM532kotZorOJZGIVW+4Yrkc9I9gQOM9I3igjJd2QG4Cs0MZ5fPcD/
        zNJQmhPbYFfGG5FXApjlGYw=
X-Google-Smtp-Source: ABdhPJzmH04Xwn/NDpUAahm7FPyOQwWagt9o5ZJv6S5XukOPFvQ917pKQ9XMQmQDLQIV2X98MueLMA==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr3646172pjn.69.1632885413301;
        Tue, 28 Sep 2021 20:16:53 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 65sm464203pfv.210.2021.09.28.20.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:16:52 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v17 4/9] tools/counter: Create Counter tools
Date:   Wed, 29 Sep 2021 12:16:01 +0900
Message-Id: <7c0f975ba098952122302d258ec9ffdef04befaf.1632884256.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1632884256.git.vilhelm.gray@gmail.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This creates an example Counter program under tools/counter/*
to exemplify the Counter character device interface.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                     |  1 +
 tools/Makefile                  | 13 ++---
 tools/counter/Build             |  1 +
 tools/counter/Makefile          | 53 +++++++++++++++++++
 tools/counter/counter_example.c | 92 +++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c95ada1b830..71082000046b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4821,6 +4821,7 @@ F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
 F:	include/uapi/linux/counter.h
+F:	tools/counter/
 
 CP2615 I2C DRIVER
 M:	Bence Csókás <bence98@sch.bme.hu>
diff --git a/tools/Makefile b/tools/Makefile
index 7e9d34ddd74c..5da1fde03a9a 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -12,6 +12,7 @@ help:
 	@echo '  acpi                   - ACPI tools'
 	@echo '  bpf                    - misc BPF tools'
 	@echo '  cgroup                 - cgroup tools'
+	@echo '  counter                - counter tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
 	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
@@ -65,7 +66,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -100,7 +101,7 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
-all: acpi cgroup cpupower gpio hv firewire liblockdep \
+all: acpi cgroup counter cpupower gpio hv firewire liblockdep \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
@@ -112,7 +113,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -133,7 +134,7 @@ freefall_install:
 kvm_stat_install:
 	$(call descend,kvm/$(@:_install=),install)
 
-install: acpi_install cgroup_install cpupower_install gpio_install \
+install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install liblockdep_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
@@ -147,7 +148,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -181,7 +182,7 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
-clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
+clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
diff --git a/tools/counter/Build b/tools/counter/Build
new file mode 100644
index 000000000000..33f4a51d715e
--- /dev/null
+++ b/tools/counter/Build
@@ -0,0 +1 @@
+counter_example-y += counter_example.o
diff --git a/tools/counter/Makefile b/tools/counter/Makefile
new file mode 100644
index 000000000000..5ebc195fd9c0
--- /dev/null
+++ b/tools/counter/Makefile
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+
+bindir ?= /usr/bin
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+
+ALL_TARGETS := counter_example
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+#
+# We need the following to be outside of kernel tree
+#
+$(OUTPUT)include/linux/counter.h: ../../include/uapi/linux/counter.h
+	mkdir -p $(OUTPUT)include/linux 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/counter.h $@
+
+prepare: $(OUTPUT)include/linux/counter.h
+
+COUNTER_EXAMPLE := $(OUTPUT)counter_example.o
+$(COUNTER_EXAMPLE): prepare FORCE
+	$(Q)$(MAKE) $(build)=counter_example
+$(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+clean:
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include/linux/counter.h
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
+FORCE:
+
+.PHONY: all install clean FORCE prepare
diff --git a/tools/counter/counter_example.c b/tools/counter/counter_example.c
new file mode 100644
index 000000000000..be55287b950f
--- /dev/null
+++ b/tools/counter/counter_example.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Counter - example userspace application
+ *
+ * The userspace application opens /dev/counter0, configures the
+ * COUNTER_EVENT_INDEX event channel 0 to gather Count 0 count and Count
+ * 1 count, and prints out the data as it becomes available on the
+ * character device node.
+ *
+ * Copyright (C) 2021 William Breathitt Gray
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/counter.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+static struct counter_watch watches[2] = {
+	{
+		/* Component data: Count 0 count */
+		.component.type = COUNTER_COMPONENT_COUNT,
+		.component.scope = COUNTER_SCOPE_COUNT,
+		.component.parent = 0,
+		/* Event type: Index */
+		.event = COUNTER_EVENT_INDEX,
+		/* Device event channel 0 */
+		.channel = 0,
+	},
+	{
+		/* Component data: Count 1 count */
+		.component.type = COUNTER_COMPONENT_COUNT,
+		.component.scope = COUNTER_SCOPE_COUNT,
+		.component.parent = 1,
+		/* Event type: Index */
+		.event = COUNTER_EVENT_INDEX,
+		/* Device event channel 0 */
+		.channel = 0,
+	},
+};
+
+int main(void)
+{
+	int fd;
+	int ret;
+	int i;
+	struct counter_event event_data[2];
+
+	fd = open("/dev/counter0", O_RDWR);
+	if (fd == -1) {
+		perror("Unable to open /dev/counter0");
+		return 1;
+	}
+
+	for (i = 0; i < 2; i++) {
+		ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
+		if (ret == -1) {
+			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
+				strerror(errno));
+			return 1;
+		}
+	}
+	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
+	if (ret == -1) {
+		perror("Error enabling events");
+		return 1;
+	}
+
+	for (;;) {
+		ret = read(fd, event_data, sizeof(event_data));
+		if (ret == -1) {
+			perror("Failed to read event data");
+			return 1;
+		}
+
+		if (ret != sizeof(event_data)) {
+			fprintf(stderr, "Failed to read event data\n");
+			return -EIO;
+		}
+
+		printf("Timestamp 0: %llu\tCount 0: %llu\n"
+		       "Error Message 0: %s\n"
+		       "Timestamp 1: %llu\tCount 1: %llu\n"
+		       "Error Message 1: %s\n",
+		       event_data[0].timestamp, event_data[0].value,
+		       strerror(event_data[0].status),
+		       event_data[1].timestamp, event_data[1].value,
+		       strerror(event_data[1].status));
+	}
+
+	return 0;
+}
-- 
2.33.0

