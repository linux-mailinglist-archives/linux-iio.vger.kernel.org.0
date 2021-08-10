Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C673E45CC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhHIMjA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhHIMiy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 08:38:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA3FC0613D3;
        Mon,  9 Aug 2021 05:38:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so2285112pjb.0;
        Mon, 09 Aug 2021 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXSYO8/BwWj1jkPsmAzp9p2Ds5N4KMNWurLCAF8mkpg=;
        b=LV/uM29KdhXRNOjS4nl880QPZN07FXTqp95f+WARngjt/Gzgj7kMtbuj291XfDJKiI
         GkwzgeP/IDKL+o/rX3mvmupS/tPbv56sl7kr+mUeEhDr1mtfSf+ar96+sacegqG6RWAH
         sQUwxNlJgu1YTEy2Dtmhy9JkcNyB4ld41SmUE39di3oIJyvd9B2xt3eu3Ef4eGFR9X52
         AIpzYXAGSG8abRwse1V2GIBsqKrq/DxuTTf+adBlO5YML1VkelFS6tMmSA8ra+1B2mSF
         dS+3Awhv8RitF9tNbd4HHGubtwHyBcWkFz76i9ogDVcldM1s0IA2zGXIUZMxcZtBI2kp
         ijjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXSYO8/BwWj1jkPsmAzp9p2Ds5N4KMNWurLCAF8mkpg=;
        b=r63K+dPEDdtG0hTlHoqdnHX6uxdPZeLoGAK22XKwR2vFJe2n2LFT8MuABn3MTMXQeN
         Ok3xVLwCUewUNypzE2CKcgMJunxPXDZD8XM4bSrn8YDgIDGDgvnSM74m8TqdW/eg05lg
         T5S3lXcTC/Va7Di0OSj9H+yGUSz23yl9A8WWUWPb1buKSZcleSTN+1ktnZJ8s2Wuv5sq
         ulSjtNtfynh7ytM/+9Pd7ZxE6t3uFRzx3Uwovs5wgeMzhzdzU7dXjEZsbjrDLe64s+A9
         p/Jp1lt75L9+2esIRf2gsSyde72LzCoFKig8FU+/5533U+12TlqfRuVNszSeK4MUxEm2
         qgHA==
X-Gm-Message-State: AOAM5316RGWObsXjcgnzCfpCNwHNabWVfX4Uw10cIzTruMZEzceGWxvj
        cV06zaVWR3V02YXa/pvv+gc=
X-Google-Smtp-Source: ABdhPJz2850q47E6oyZRwODglt4Hdd3ng1el1OCsZFaP5+3VSQypdjQFfWCHZiUeNee5HOo9ut7yxQ==
X-Received: by 2002:a65:6910:: with SMTP id s16mr132393pgq.270.1628512714109;
        Mon, 09 Aug 2021 05:38:34 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e35sm22382177pjk.28.2021.08.09.05.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:38:33 -0700 (PDT)
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
Subject: [PATCH v15 08/13] tools/counter: Create Counter tools
Date:   Mon,  9 Aug 2021 21:37:33 +0900
Message-Id: <060c8c58a5b4250a5dcc7fa3bc7b0b4945ffd49e.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
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
 tools/counter/counter_example.c | 93 +++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 6 deletions(-)
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cef0f840e142..45488c9b8e94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4765,6 +4765,7 @@ F:	Documentation/driver-api/generic-counter.rst
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
index 000000000000..90d69fb9463b
--- /dev/null
+++ b/tools/counter/counter_example.c
@@ -0,0 +1,93 @@
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
+	struct counter_event event_data[2];
+
+	fd = open("/dev/counter0", O_RDWR);
+	if (fd == -1) {
+		perror("Unable to open /dev/counter0");
+		return -errno;
+	}
+
+	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
+	if (ret == -1) {
+		perror("Error adding watches[0]");
+		return -errno;
+	}
+	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
+	if (ret == -1) {
+		perror("Error adding watches[1]");
+		return -errno;
+	}
+	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
+	if (ret == -1) {
+		perror("Error enabling events");
+		return -errno;
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
2.32.0

