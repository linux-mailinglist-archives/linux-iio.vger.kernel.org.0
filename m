Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7C3C35A2
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGJQ43 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 12:56:29 -0400
Received: from vern.gendns.com ([98.142.107.122]:32804 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGJQ42 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 12:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vYGqf2Kf/srtKQ51k3zl5iWB5A8pjKDlW1+mmgwYypc=; b=WLZSRLeBxg7eHz/DVWKdwJk6t0
        lepVtlgzjM2TRkTPbxa57mtKsrt/dnutLjwn15RUXeUQCdcTQKYGIEkSHg/z/KNqEYVCQ6s3IVh+Y
        sSFv5IkvF4blBNucBXhgySvgdgaK+eVmOnbjk3FhIiuIsUPbvi/3xq8KamMLa0E3N2oDCLO5Cpwna
        CcLtYbsq4vNUp/vr5WJAZ352fH/8uvZKQdcpLGxZYxi/uukS4aiUrKyiqJ8gbV6JB1VGP0s4PB7W6
        jWG5Ul1Pl2XZZAkJ9IdFtGtf0gHSlmJizMdnnw9KuUje7LmsGGa+O1USG8EY9ex9S6sj4esHVagq+
        nVP5aIcQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:46724 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2GEH-00GhKU-9F; Sat, 10 Jul 2021 12:53:40 -0400
Subject: Re: [PATCH v12 12/17] tools/counter: Create Counter tools
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Pavel Machek <pavel@ucw.cz>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e97aa3e529f54d5651df7edcc1b43a8157d9e9c3.1625471640.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <343a2bd3-38b7-7462-bc52-d3f6493bede0@lechnology.com>
Date:   Sat, 10 Jul 2021 11:53:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e97aa3e529f54d5651df7edcc1b43a8157d9e9c3.1625471640.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/5/21 3:19 AM, William Breathitt Gray wrote:
> This creates an example Counter program under tools/counter/*
> to exemplify the Counter character device interface.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---


> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -12,6 +12,7 @@ help:
>   	@echo '  acpi                   - ACPI tools'
>   	@echo '  bpf                    - misc BPF tools'
>   	@echo '  cgroup                 - cgroup tools'
> +	@echo '  counter                - Counter tools'

nit: other descriptions start with lower case letter, so to be
consistent, this should too


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

nit: this can be static

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

errno is no longer valid after calling perror(). Since this
is example code, we can just return 1 instead (exit codes
positive number between 0 and 255 so -1 would be 255).

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
> +		       (unsigned long long)event_data[0].value,
> +		       strerror(event_data[0].status),
> +		       (unsigned long long)event_data[1].timestamp,
> +		       (unsigned long long)event_data[1].value,
> +		       strerror(event_data[1].status));
> +	}

Aren't the Count 0 and Count 1 events independent? Why should we expect to
always get both events at the same time in the same order?

> +
> +	return 0;
> +}
> 

