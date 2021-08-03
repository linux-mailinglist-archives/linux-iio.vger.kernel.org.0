Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE5E3DED87
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhHCMIF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhHCMIC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:08:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E050C061757;
        Tue,  3 Aug 2021 05:07:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k2so5893777plk.13;
        Tue, 03 Aug 2021 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AX9CwwBscIOgAMZ3W/Ftf7Z+sFLErOLPH4IQHM47ydE=;
        b=DwZFNpb8ZlPUJbdMtF0KTVj9+4Le8Zc6yBJ3vATf8QcipGp5SrJjIMm0XEIEKGluf6
         9NaT0piMagUu3cmSURDEVreiQmnJ51vo9oDfomtIp4nz0axRBIep9lao/GKEb/nCzCOi
         bq5B6qqwfJvW3LklkobYas/+Aj90LMIJ20R1J5Pc9+fGauIu5n42pZH1Yp/mHRSv711R
         oRdNsC7pBmL9xCFO6J3TcsgZ/AZBWyUTKehEXKlnWzqdSk2cWOmRPpfJQJkcdQr6BkvI
         utZUaOO9rMutH3KSf3sFy7bMBURatTj9XIn53nSqRZF+HPa5Rc23TVx75xHR3veak+OO
         rxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AX9CwwBscIOgAMZ3W/Ftf7Z+sFLErOLPH4IQHM47ydE=;
        b=VFamy7BeGnYBYbZbII8pw57WxoIPFtSCEEYnrKK1TYM/d4QgWcujwOlOPCI0AYaiXS
         ICXGdQbghT87VgTgLPuV4TZvoE2O5soMI20PWAI+5HL5Z5GdJk+MlC30FXNiOB8lUPZV
         MDFFuZ7u8ip4RPoCS1extJYWCJg76SScFriDzaAUyg0wLQZhfEybJDIPwgzfrCypTSFi
         Ybfs3ibh6HomnhDCZIhn8IptyhxRHD6ys6ugsRw6GNVyTaqdLgWrr4xtcyf37xVuuHl+
         f+WFOyu+Umcdv44BuQr3fbDmtLnxo6cxJ5aejkJRjgfPCJ0c9gPAfNmu9wEQA4SxpeV1
         0v6Q==
X-Gm-Message-State: AOAM533uX8x1nBMTb9hm4HE9q9B8byGvF9PSmF/ElUAoARqNbXl20RhB
        AUGlD+AxkZMaSUHON8LTar8=
X-Google-Smtp-Source: ABdhPJyLk8ZI3n5tz7jnu/PUqD/OMEka8Wn4rppc/buVm5FvDW1Cj7O+24INGiyYUTJb7ZF+pA3vXQ==
X-Received: by 2002:a62:1d46:0:b029:3a9:eb67:c0c0 with SMTP id d67-20020a621d460000b02903a9eb67c0c0mr21986937pfd.60.1627992470875;
        Tue, 03 Aug 2021 05:07:50 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:07:48 -0700 (PDT)
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
Subject: [PATCH v14 12/17] tools/counter: Create Counter tools
Date:   Tue,  3 Aug 2021 21:06:22 +0900
Message-Id: <fd51641e28c1517dc6b4a172cc032d1a1b9d47ca.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
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
index c0817c45401d..b6e809c269a5 100644
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

