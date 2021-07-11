Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3F3C3CCB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhGKNXf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 11 Jul 2021 09:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232868AbhGKNXd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 09:23:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32BC61186;
        Sun, 11 Jul 2021 13:20:40 +0000 (UTC)
Date:   Sun, 11 Jul 2021 14:22:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v12 12/17] tools/counter: Create Counter tools
Message-ID: <20210711142255.725b2f03@jic23-huawei>
In-Reply-To: <e97aa3e529f54d5651df7edcc1b43a8157d9e9c3.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
        <e97aa3e529f54d5651df7edcc1b43a8157d9e9c3.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Jul 2021 17:19:00 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This creates an example Counter program under tools/counter/*
> to exemplify the Counter character device interface.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                     |  1 +
>  tools/Makefile                  | 13 ++---
>  tools/counter/Build             |  1 +
>  tools/counter/Makefile          | 53 ++++++++++++++++++
>  tools/counter/counter_example.c | 95 +++++++++++++++++++++++++++++++++
>  5 files changed, 157 insertions(+), 6 deletions(-)
>  create mode 100644 tools/counter/Build
>  create mode 100644 tools/counter/Makefile
>  create mode 100644 tools/counter/counter_example.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5de4d2164844..e96797f57f04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4688,6 +4688,7 @@ F:	Documentation/driver-api/generic-counter.rst
>  F:	drivers/counter/
>  F:	include/linux/counter.h
>  F:	include/uapi/linux/counter.h
> +F:	tools/counter/
>  
>  CP2615 I2C DRIVER
>  M:	Bence Csókás <bence98@sch.bme.hu>
> diff --git a/tools/Makefile b/tools/Makefile
> index 7e9d34ddd74c..4c26400ffc03 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -12,6 +12,7 @@ help:
>  	@echo '  acpi                   - ACPI tools'
>  	@echo '  bpf                    - misc BPF tools'
>  	@echo '  cgroup                 - cgroup tools'
> +	@echo '  counter                - Counter tools'
>  	@echo '  cpupower               - a tool for all things x86 CPU power'
>  	@echo '  debugging              - tools for debugging'
>  	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
> @@ -65,7 +66,7 @@ acpi: FORCE
>  cpupower: FORCE
>  	$(call descend,power/$@)
>  
> -cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
> +cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
>  	$(call descend,$@)
>  
>  bpf/%: FORCE
> @@ -100,7 +101,7 @@ freefall: FORCE
>  kvm_stat: FORCE
>  	$(call descend,kvm/$@)
>  
> -all: acpi cgroup cpupower gpio hv firewire liblockdep \
> +all: acpi cgroup counter cpupower gpio hv firewire liblockdep \
>  		perf selftests bootconfig spi turbostat usb \
>  		virtio vm bpf x86_energy_perf_policy \
>  		tmon freefall iio objtool kvm_stat wmi \
> @@ -112,7 +113,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -cgroup_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
> +cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
>  	$(call descend,$(@:_install=),install)
>  
>  liblockdep_install:
> @@ -133,7 +134,7 @@ freefall_install:
>  kvm_stat_install:
>  	$(call descend,kvm/$(@:_install=),install)
>  
> -install: acpi_install cgroup_install cpupower_install gpio_install \
> +install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
>  		hv_install firewire_install iio_install liblockdep_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
> @@ -147,7 +148,7 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
>  
> -cgroup_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
> +cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
>  	$(call descend,$(@:_clean=),clean)
>  
>  liblockdep_clean:
> @@ -181,7 +182,7 @@ freefall_clean:
>  build_clean:
>  	$(call descend,build,clean)
>  
> -clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
> +clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
>  		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
> diff --git a/tools/counter/Build b/tools/counter/Build
> new file mode 100644
> index 000000000000..33f4a51d715e
> --- /dev/null
> +++ b/tools/counter/Build
> @@ -0,0 +1 @@
> +counter_example-y += counter_example.o
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> new file mode 100644
> index 000000000000..5ebc195fd9c0
> --- /dev/null
> +++ b/tools/counter/Makefile
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +include ../scripts/Makefile.include
> +
> +bindir ?= /usr/bin
> +
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
> +# Do not use make's built-in rules
> +# (this improves performance and avoids hard-to-debug behaviour);
> +MAKEFLAGS += -r
> +
> +override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> +
> +ALL_TARGETS := counter_example
> +ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> +
> +all: $(ALL_PROGRAMS)
> +
> +export srctree OUTPUT CC LD CFLAGS
> +include $(srctree)/tools/build/Makefile.include
> +
> +#
> +# We need the following to be outside of kernel tree
> +#
> +$(OUTPUT)include/linux/counter.h: ../../include/uapi/linux/counter.h
> +	mkdir -p $(OUTPUT)include/linux 2>&1 || true
> +	ln -sf $(CURDIR)/../../include/uapi/linux/counter.h $@
> +
> +prepare: $(OUTPUT)include/linux/counter.h
> +
> +COUNTER_EXAMPLE := $(OUTPUT)counter_example.o
> +$(COUNTER_EXAMPLE): prepare FORCE
> +	$(Q)$(MAKE) $(build)=counter_example
> +$(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> +
> +clean:
> +	rm -f $(ALL_PROGRAMS)
> +	rm -rf $(OUTPUT)include/linux/counter.h
> +	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +
> +install: $(ALL_PROGRAMS)
> +	install -d -m 755 $(DESTDIR)$(bindir);		\
> +	for program in $(ALL_PROGRAMS); do		\
> +		install $$program $(DESTDIR)$(bindir);	\
> +	done
> +
> +FORCE:
> +
> +.PHONY: all install clean FORCE prepare
> diff --git a/tools/counter/counter_example.c b/tools/counter/counter_example.c
> new file mode 100644
> index 000000000000..71dfec673c11
> --- /dev/null
> +++ b/tools/counter/counter_example.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Counter - example userspace application
> + *
> + * The userspace application opens /dev/counter0, configures the
> + * COUNTER_EVENT_INDEX event channel 0 to gather Count 0 count and Count
> + * 1 count, and prints out the data as it becomes available on the
> + * character device node.
> + *
> + * Copyright (C) 2021 William Breathitt Gray
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/counter.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>
> +
> +struct counter_watch watches[2] = {
> +	{
> +		/* Component data: Count 0 count */
> +		.component.type = COUNTER_COMPONENT_COUNT,
> +		.component.scope = COUNTER_SCOPE_COUNT,
> +		.component.parent = 0,
> +		/* Event type: Index */
> +		.event = COUNTER_EVENT_INDEX,
> +		/* Device event channel 0 */
> +		.channel = 0,
> +	},
> +	{
> +		/* Component data: Count 1 count */
> +		.component.type = COUNTER_COMPONENT_COUNT,
> +		.component.scope = COUNTER_SCOPE_COUNT,
> +		.component.parent = 1,
> +		/* Event type: Index */
> +		.event = COUNTER_EVENT_INDEX,
> +		/* Device event channel 0 */
> +		.channel = 0,
> +	},
> +};
> +
> +int main(void)
> +{
> +	int fd;
> +	int ret;
> +	struct counter_event event_data[2];
> +
> +	fd = open("/dev/counter0", O_RDWR);
> +	if (fd == -1) {
> +		perror("Unable to open /dev/counter0");
> +		return -errno;
> +	}
> +
> +	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> +	if (ret == -1) {
> +		perror("Error adding watches[0]");
> +		return -errno;
> +	}
> +	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
> +	if (ret == -1) {
> +		perror("Error adding watches[1]");
> +		return -errno;
> +	}
> +	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> +	if (ret == -1) {
> +		perror("Error enabling events");
> +		return -errno;
> +	}
> +
> +	for (;;) {
> +		ret = read(fd, event_data, sizeof(event_data));
> +		if (ret == -1) {
> +			perror("Failed to read event data");
> +			return -errno;
> +		}
> +
> +		if (ret != sizeof(event_data)) {
> +			fprintf(stderr, "Failed to read event data\n");
> +			return -EIO;
> +		}
> +
> +		printf("Timestamp 0: %llu\tCount 0: %llu\n"
> +		       "Error Message 0: %s\n"
> +		       "Timestamp 1: %llu\tCount 1: %llu\n"
> +		       "Error Message 1: %s\n",
> +		       (unsigned long long)event_data[0].timestamp,

I think there should be no need to cast this one.  __aligned_u64 is always
going to be of type llu anyway.


> +		       (unsigned long long)event_data[0].value,
> +		       strerror(event_data[0].status),
> +		       (unsigned long long)event_data[1].timestamp,
> +		       (unsigned long long)event_data[1].value,
> +		       strerror(event_data[1].status));
> +	}
> +
> +	return 0;
> +}

