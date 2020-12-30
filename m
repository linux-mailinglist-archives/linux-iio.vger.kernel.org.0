Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27362E7A0A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL3Or7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 09:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgL3Or7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 09:47:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DF022225;
        Wed, 30 Dec 2020 14:47:15 +0000 (UTC)
Date:   Wed, 30 Dec 2020 14:47:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH v7 4/5] docs: counter: Document character device
 interface
Message-ID: <20201230144711.45e3d057@archlinux>
In-Reply-To: <1e69b7beae4cf352bddb379220d0d52b20db0634.1608935587.git.vilhelm.gray@gmail.com>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
        <1e69b7beae4cf352bddb379220d0d52b20db0634.1608935587.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Dec 2020 19:15:37 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds high-level documentation about the Counter subsystem
> character device interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter   |   9 +
>  Documentation/driver-api/generic-counter.rst  | 236 +++++++++++++++---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  3 files changed, 205 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 1820ce2f9183..8f6ea0a50b75 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -99,6 +99,15 @@ Description:
>  		Read-only attribute that indicates whether excessive noise is
>  		present at the channel Y counter inputs.
>  
> +What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
> +What:		/sys/bus/counter/devices/counterX/extensionZ_name
> +What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the component name of
> +		Extension Z.

Dumb question, but why is this only related to character device introduction?

> +
>  What:		/sys/bus/counter/devices/counterX/countY/function
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index b842ddbbd8a0..4775dcaff557 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -223,19 +223,6 @@ whether an input line is differential or single-ended) and instead focus
>  on the core idea of what the data and process represent (e.g. position
>  as interpreted from quadrature encoding data).
>  
> -Userspace Interface
> -===================
> -
> -Several sysfs attributes are generated by the Generic Counter interface,
> -and reside under the /sys/bus/counter/devices/counterX directory, where
> -counterX refers to the respective counter device. Please see
> -Documentation/ABI/testing/sysfs-bus-counter for detailed
> -information on each Generic Counter interface sysfs attribute.
> -
> -Through these sysfs attributes, programs and scripts may interact with
> -the Generic Counter paradigm Counts, Signals, and Synapses of respective
> -counter devices.
> -
>  Driver API
>  ==========
>  
> @@ -387,16 +374,16 @@ userspace interface components::
>                          / driver callbacks /
>                          -------------------
>                                  |
> -                +---------------+
> -                |
> -                V
> -        +--------------------+
> -        | Counter sysfs      |
> -        +--------------------+
> -        | Translates to the  |
> -        | standard Counter   |
> -        | sysfs output       |
> -        +--------------------+
> +                +---------------+---------------+
> +                |                               |
> +                V                               V
> +        +--------------------+          +---------------------+
> +        | Counter sysfs      |          | Counter chrdev      |
> +        +--------------------+          +---------------------+
> +        | Translates to the  |          | Translates to the   |
> +        | standard Counter   |          | standard Counter    |
> +        | sysfs output       |          | character device    |
> +        +--------------------+          +---------------------+
>  
>  Thereafter, data can be transferred directly between the Counter device
>  driver and Counter userspace interface::
> @@ -427,23 +414,30 @@ driver and Counter userspace interface::
>                          / u64     /
>                          ----------
>                                  |
> -                +---------------+
> -                |
> -                V
> -        +--------------------+
> -        | Counter sysfs      |
> -        +--------------------+
> -        | Translates to the  |
> -        | standard Counter   |
> -        | sysfs output       |
> -        |--------------------|
> -        | Type: const char * |
> -        | Value: "42"        |
> -        +--------------------+
> -                |
> -         ---------------
> -        / const char * /
> -        ---------------
> +                +---------------+---------------+
> +                |                               |
> +                V                               V
> +        +--------------------+          +---------------------+
> +        | Counter sysfs      |          | Counter chrdev      |
> +        +--------------------+          +---------------------+
> +        | Translates to the  |          | Translates to the   |
> +        | standard Counter   |          | standard Counter    |
> +        | sysfs output       |          | character device    |
> +        |--------------------|          |---------------------|
> +        | Type: const char * |          | Type: u64           |
> +        | Value: "42"        |          | Value: 42           |
> +        +--------------------+          +---------------------+
> +                |                               |
> +         ---------------                 -----------------------
> +        / const char * /                / struct counter_event /
> +        ---------------                 -----------------------
> +                |                               |
> +                |                               V
> +                |                       +-----------+
> +                |                       | read      |
> +                |                       +-----------+
> +                |                       \ Count: 42 /
> +                |                        -----------
>                  |
>                  V
>          +--------------------------------------------------+
> @@ -452,7 +446,7 @@ driver and Counter userspace interface::
>          \ Count: "42"                                      /
>           --------------------------------------------------
>  
> -There are three primary components involved:
> +There are four primary components involved:
>  
>  Counter device driver
>  ---------------------
> @@ -472,3 +466,163 @@ and vice versa.
>  Please refer to the `Documentation/ABI/testing/sysfs-bus-counter` file
>  for a detailed breakdown of the available Generic Counter interface
>  sysfs attributes.
> +
> +Counter chrdev
> +--------------
> +Translates counter data to the standard Counter character device; data
> +is transferred via standard character device read calls, while Counter
> +events are configured via ioctl calls.
> +
> +Sysfs Interface
> +===============
> +
> +Several sysfs attributes are generated by the Generic Counter interface,
> +and reside under the `/sys/bus/counter/devices/counterX` directory,
> +where `X` is to the respective counter device id. Please see
> +`Documentation/ABI/testing/sysfs-bus-counter` for detailed information
> +on each Generic Counter interface sysfs attribute.
> +
> +Through these sysfs attributes, programs and scripts may interact with
> +the Generic Counter paradigm Counts, Signals, and Synapses of respective
> +counter devices.
> +
> +Counter Character Device
> +========================
> +
> +Counter character device nodes are created under the `/dev` directory as
> +`counterX`, where `X` is the respective counter device id. Defines for
> +the standard Counter data types are exposed via the userspace
> +`include/uapi/linux/counter.h` file.
> +
> +Counter events
> +--------------
> +Counter device drivers can support Counter events by utilizing the
> +`counter_push_event` function::
> +
> +        int counter_push_event(struct counter_device *const counter, const u8 event,
> +                               const u8 channel);
> +
> +The event id is specified by the `event` parameter; the event channel id
> +is specified by the `channel` parameter. When this function is called,
> +the Counter data associated with the respective event is gathered, and a
> +`struct counter_event` is generated for each datum and pushed to
> +userspace.
> +
> +Counter events can be configured by users to report various Counter
> +data of interest. This can be conceptualized as a list of Counter
> +component read calls to perform. For example::
> +
> +        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
> +        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
> +        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
> +        | Channel 0              | Channel 0              |
> +        +------------------------+------------------------+
> +        | * Count 0              | * Signal 0             |
> +        | * Count 1              | * Signal 0 Extension 0 |
> +        | * Signal 3             | * Extension 4          |
> +        | * Count 4 Extension 2  +------------------------+
> +        | * Signal 5 Extension 0 | Channel 1              |
> +        |                        +------------------------+
> +        |                        | * Signal 4             |
> +        |                        | * Signal 4 Extension 0 |
> +        |                        | * Count 7              |
> +        +------------------------+------------------------+
> +
> +When `counter_push_event(counter, COUNTER_EVENT_INDEX, 1)` is called for
> +example, it will go down the list for the `COUNTER_EVENT_INDEX` event
> +channel 1 and execute the read callbacks for Signal 4, Signal 4
> +Extension 0, and Count 4 -- the data returned for each is pushed to a
> +kfifo as a `struct counter_event`, which userspace can retrieve via a
> +standard read operation on the respective character device node.
> +
> +Userspace
> +---------
> +Userspace applications can configure Counter events via ioctl operations
> +on the Counter character device node. There following ioctl codes are
> +supported and provided by the `linux/counter.h` userspace header file:
> +
> +* COUNTER_CLEAR_WATCHES_IOCTL:
> +  Clear all Counter watches from all events
> +
> +* COUNTER_ADD_WATCH_IOCTL:
> +  Add a Counter watch for the specified event
> +
> +* COUNTER_LOAD_WATCHES_IOCTL:
> +  Activates the Counter watches added earlier
> +
> +To configure events to gather Counter data, users first populate a
> +`struct counter_watch` with the relevant event id, event channel id, and
> +the information for the desired Counter component from which to read,
> +and then pass it via the `COUNTER_ADD_WATCH_IOCTL` ioctl command.
> +
> +Note that an event can be watched without gathering Counter data by
> +setting the `component.type` member equal to `COUNTER_COMPONENT_NONE`.
> +With this configuration the Counter character device will simply
> +populate the event timestamps for those respective
> +`struct counter_event` elements and ignore the component value.
> +
> +The `COUNTER_ADD_WATCH_IOCTL` command will buffer these Counter watches.
> +When ready, the `COUNTER_LOAD_WATCHES_IOCTL` ioctl command may be used
> +to activate these Counter watches.
> +
> +Userspace applications can then execute a `read` operation (optionally
> +calling `poll` first) on the Counter character device node to retrieve
> +`struct counter_event` elements with the desired data.
> +
> +For example, the following userspace code opens `/dev/counter0`,
> +configures the `COUNTER_EVENT_INDEX` event channel 0 to gather Count 0
> +and Count 1, and prints out the data as it becomes available on the
> +character device node::
> +
> +        #include <fcntl.h>
> +        #include <linux/counter.h>
> +        #include <stdio.h>
> +        #include <string.h>
> +        #include <sys/ioctl.h>
> +        #include <unistd.h>
> +
> +        struct counter_watch watches[2] = {
> +                {
> +                        .component.type = COUNTER_COMPONENT_COUNT,
> +                        .component.scope = COUNTER_SCOPE_COUNT,
> +                        .component.parent = 0,
> +                        .event = COUNTER_EVENT_INDEX,
> +                        .channel = 0,
> +                },
> +                {
> +                        .component.type = COUNTER_COMPONENT_COUNT,
> +                        .component.scope = COUNTER_SCOPE_COUNT,
> +                        .component.parent = 1,
> +                        .event = COUNTER_EVENT_INDEX,
> +                        .channel = 0,
> +                },
> +        };
> +
> +        int main(void)
> +        {
> +                int fd;
> +                struct counter_event event_data[2];
> +
> +                fd = open("/dev/counter0", O_RDWR);
> +
> +                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
> +                ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
> +                ioctl(fd, COUNTER_LOAD_WATCHES_IOCTL);
> +
> +                for (;;) {
> +                        read(fd, event_data, sizeof(event_data));
> +
> +                        printf("Timestamp 0: %llu\tCount 0: %llu\n"
> +                               "Error Message 0: %s\n"
> +                               "Timestamp 1: %llu\tCount 1: %llu\n"
> +                               "Error Message 1: %s\n",
> +                               (unsigned long long)event_data[0].timestamp,
> +                               (unsigned long long)event_data[0].value,
> +                               strerror(event_data[0].errno),
> +                               (unsigned long long)event_data[1].timestamp,
> +                               (unsigned long long)event_data[1].value,
> +                               strerror(event_data[1].errno));
> +                }
> +
> +                return 0;
> +        }
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 55a2d9b2ce33..b7761ceb82a7 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -88,6 +88,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <http://infiniband.sourceforge.net/>
>  0x20  all    drivers/cdrom/cm206.h
>  0x22  all    scsi/sg.h
> +0x3E  00-0F  linux/counter.h                                         <mailto:linux-iio@vger.kernel.org>
>  '!'   00-1F  uapi/linux/seccomp.h
>  '#'   00-3F                                                          IEEE 1394 Subsystem
>                                                                       Block for the entire subsystem

