Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4D2E7A06
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 15:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL3Omk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 09:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgL3Omj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 09:42:39 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B4421919;
        Wed, 30 Dec 2020 14:41:55 +0000 (UTC)
Date:   Wed, 30 Dec 2020 14:41:52 +0000
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
Subject: Re: [PATCH v7 2/5] docs: counter: Update to reflect sysfs
 internalization
Message-ID: <20201230144152.7800399d@archlinux>
In-Reply-To: <4a1bdcdea3826d9b1a8af3d9318ac952693f400c.1608935587.git.vilhelm.gray@gmail.com>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
        <4a1bdcdea3826d9b1a8af3d9318ac952693f400c.1608935587.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Dec 2020 19:15:35 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The Counter subsystem architecture and driver implementations have
> changed in order to handle Counter sysfs interactions in a more
> consistent way. This patch updates the Generic Counter interface
> documentation to reflect the changes.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter  |   9 +-
>  Documentation/driver-api/generic-counter.rst | 242 ++++++++++++++-----
>  2 files changed, 184 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 566bd99fe0a5..1820ce2f9183 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -219,7 +219,14 @@ What:		/sys/bus/counter/devices/counterX/signalY/signal
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Signal data of Signal Y represented as a string.
> +		Signal level state of Signal Y. The following signal level
> +		states are available:
> +
> +		low:
> +			Low level state.
> +
> +		high:
> +			High level state.
>  
>  What:		/sys/bus/counter/devices/counterX/signalY/name
>  KernelVersion:	5.2
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index b02c52cd69d6..b842ddbbd8a0 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -250,8 +250,8 @@ for defining a counter device.
>  .. kernel-doc:: drivers/counter/counter.c
>     :export:
>  
> -Implementation
> -==============
> +Driver Implementation
> +=====================
>  
>  To support a counter device, a driver must first allocate the available
>  Counter Signals via counter_signal structures. These Signals should
> @@ -267,25 +267,59 @@ respective counter_count structure. These counter_count structures are
>  set to the counts array member of an allocated counter_device structure
>  before the Counter is registered to the system.
>  
> -Driver callbacks should be provided to the counter_device structure via
> -a constant counter_ops structure in order to communicate with the
> -device: to read and write various Signals and Counts, and to set and get
> -the "action mode" and "function mode" for various Synapses and Counts
> -respectively.
> +Driver callbacks must be provided to the counter_device structure in
> +order to communicate with the device: to read and write various Signals
> +and Counts, and to set and get the "action mode" and "function mode" for
> +various Synapses and Counts respectively.
>  
>  A defined counter_device structure may be registered to the system by
>  passing it to the counter_register function, and unregistered by passing
>  it to the counter_unregister function. Similarly, the
> -devm_counter_register and devm_counter_unregister functions may be used
> -if device memory-managed registration is desired.
> -
> -Extension sysfs attributes can be created for auxiliary functionality
> -and data by passing in defined counter_device_ext, counter_count_ext,
> -and counter_signal_ext structures. In these cases, the
> -counter_device_ext structure is used for global/miscellaneous exposure
> -and configuration of the respective Counter device, while the
> -counter_count_ext and counter_signal_ext structures allow for auxiliary
> -exposure and configuration of a specific Count or Signal respectively.
> +devm_counter_register function may be used if device memory-managed
> +registration is desired.
> +
> +The struct counter_comp structure is used to define counter extensions
> +for Signals, Synapses, and Counts.
> +
> +The "type" member specifies the type of high-level data (e.g. BOOL,
> +COUNT_DIRECTION, etc.) handled by this extension. The "`*_read`" and
> +"`*_write`" members can then be set by the counter device driver with
> +callbacks to handle that data using native C data types (i.e. u8, u64,
> +etc.).
> +
> +Convenience macros such as `COUNTER_COMP_COUNT_U64` are provided for use
> +by driver authors. In particular, driver authors are expected to use
> +the provided macros for standard Counter subsystem attributes in order
> +to maintain a consistent interface for userspace. For example, a counter
> +device driver may define several standard attributes like so::
> +
> +        struct counter_comp count_ext[] = {
> +                COUNTER_COMP_DIRECTION(count_direction_read),
> +                COUNTER_COMP_ENABLE(count_enable_read, count_enable_write),
> +                COUNTER_COMP_CEILING(count_ceiling_read, count_ceiling_write),
> +        };
> +
> +This makes it simple to see, add, and modify the attributes that are
> +supported by this driver ("direction", "enable", and "ceiling") and to
> +maintain this code without getting lost in a web of struct braces.
> +
> +Callbacks must match the function type expected for the respective
> +component or extension. These function types are defined in the struct
> +counter_comp structure as the "`*_read`" and "`*_write`" union members.
> +
> +The corresponding callback prototypes for the extensions mentioned in
> +the previous example above would be::
> +
> +        int count_direction_read(struct counter_device *counter,
> +                                 struct counter_count *count, u8 *direction);
> +        int count_enable_read(struct counter_device *counter,
> +                              struct counter_count *count, u8 *enable);
> +        int count_enable_write(struct counter_device *counter,
> +                               struct counter_count *count, u8 enable);
> +        int count_ceiling_read(struct counter_device *counter,
> +                               struct counter_count *count, u64 *ceiling);
> +        int count_ceiling_write(struct counter_device *counter,
> +                                struct counter_count *count, u64 ceiling);
>  
>  Determining the type of extension to create is a matter of scope.
>  
> @@ -313,52 +347,128 @@ Determining the type of extension to create is a matter of scope.
>    chip overheated via a device extension called "error_overtemp":
>    /sys/bus/counter/devices/counterX/error_overtemp
>  
> -Architecture
> -============
> -
> -When the Generic Counter interface counter module is loaded, the
> -counter_init function is called which registers a bus_type named
> -"counter" to the system. Subsequently, when the module is unloaded, the
> -counter_exit function is called which unregisters the bus_type named
> -"counter" from the system.
> -
> -Counter devices are registered to the system via the counter_register
> -function, and later removed via the counter_unregister function. The
> -counter_register function establishes a unique ID for the Counter
> -device and creates a respective sysfs directory, where X is the
> -mentioned unique ID:
> -
> -    /sys/bus/counter/devices/counterX
> -
> -Sysfs attributes are created within the counterX directory to expose
> -functionality, configurations, and data relating to the Counts, Signals,
> -and Synapses of the Counter device, as well as options and information
> -for the Counter device itself.
> -
> -Each Signal has a directory created to house its relevant sysfs
> -attributes, where Y is the unique ID of the respective Signal:
> -
> -    /sys/bus/counter/devices/counterX/signalY
> -
> -Similarly, each Count has a directory created to house its relevant
> -sysfs attributes, where Y is the unique ID of the respective Count:
> -
> -    /sys/bus/counter/devices/counterX/countY
> -
> -For a more detailed breakdown of the available Generic Counter interface
> -sysfs attributes, please refer to the
> -Documentation/ABI/testing/sysfs-bus-counter file.
> -
> -The Signals and Counts associated with the Counter device are registered
> -to the system as well by the counter_register function. The
> -signal_read/signal_write driver callbacks are associated with their
> -respective Signal attributes, while the count_read/count_write and
> -function_get/function_set driver callbacks are associated with their
> -respective Count attributes; similarly, the same is true for the
> -action_get/action_set driver callbacks and their respective Synapse
> -attributes. If a driver callback is left undefined, then the respective
> -read/write permission is left disabled for the relevant attributes.
> -
> -Similarly, extension sysfs attributes are created for the defined
> -counter_device_ext, counter_count_ext, and counter_signal_ext
> -structures that are passed in.
> +Subsystem Architecture
> +======================
> +
> +Counter drivers pass and take data natively (i.e. `u8`, `u64`, etc.) and
> +the shared counter module handles the translation between the sysfs
> +interface. 

Same point as raised in previous patch description.

> This gurantees a standard userspace interface for all counter

Spell check this file.  guarantees 


> +drivers, and helps generalize the Generic Counter driver ABI in order to
> +support the Generic Counter chrdev interface without significant changes
> +to the existing counter drivers.
I would modify this to assume you've already done the chrdev interface.

"and enables a Generic Counter chrdev interface without..."

> +
> +A high-level view of how a count value is passed down from a counter
> +driver is exemplified by the following. The driver callbacks are first
> +registered to the Counter core component for use by the Counter
> +userspace interface components::
> +
> +        Driver callbacks registration:
> +        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +                        +----------------------------+
> +	                | Counter device driver      |

That tab again ;)

> +                        +----------------------------+
> +                        | Processes data from device |
> +                        +----------------------------+
> +                                |
> +                         -------------------
> +                        / driver callbacks /
> +                        -------------------
> +                                |
> +                                V
> +                        +----------------------+
> +                        | Counter core         |
> +                        +----------------------+
> +                        | Routes device driver |
> +                        | callbacks to the     |
> +                        | userspace interfaces |
> +                        +----------------------+
> +                                |
> +                         -------------------
> +                        / driver callbacks /
> +                        -------------------
> +                                |
> +                +---------------+
> +                |
> +                V
> +        +--------------------+
> +        | Counter sysfs      |
> +        +--------------------+
> +        | Translates to the  |
> +        | standard Counter   |
> +        | sysfs output       |
> +        +--------------------+
> +
> +Thereafter, data can be transferred directly between the Counter device
> +driver and Counter userspace interface::
> +
> +        Count data request:
> +        ~~~~~~~~~~~~~~~~~~~
> +                         ----------------------
> +                        / Counter device       \
> +                        +----------------------+
> +                        | Count register: 0x28 |
> +                        +----------------------+
> +                                |
> +                         -----------------
> +                        / raw count data /
> +                        -----------------
> +                                |
> +                                V
> +                        +----------------------------+
> +                        | Counter device driver      |
> +                        +----------------------------+
> +                        | Processes data from device |
> +                        |----------------------------|
> +                        | Type: u64                  |
> +                        | Value: 42                  |
> +                        +----------------------------+
> +                                |
> +                         ----------
> +                        / u64     /
> +                        ----------
> +                                |
> +                +---------------+
> +                |
> +                V
> +        +--------------------+
> +        | Counter sysfs      |
> +        +--------------------+
> +        | Translates to the  |
> +        | standard Counter   |
> +        | sysfs output       |
> +        |--------------------|
> +        | Type: const char * |
> +        | Value: "42"        |
> +        +--------------------+
> +                |
> +         ---------------
> +        / const char * /
> +        ---------------
> +                |
> +                V
> +        +--------------------------------------------------+
> +        | `/sys/bus/counter/devices/counterX/countY/count` |
> +        +--------------------------------------------------+
> +        \ Count: "42"                                      /
> +         --------------------------------------------------
> +
> +There are three primary components involved:
> +
> +Counter device driver
> +---------------------
> +Communicates with the hardware device to read/write data; e.g. counter
> +drivers for quadrature encoders, timers, etc.
> +
> +Counter core
> +------------
> +Registers the counter device driver to the system so that the respective
> +callbacks are called during userspace interaction.
> +
> +Counter sysfs
> +-------------
> +Translates counter data to the standard Counter sysfs interface format
> +and vice versa.
> +
> +Please refer to the `Documentation/ABI/testing/sysfs-bus-counter` file
> +for a detailed breakdown of the available Generic Counter interface
> +sysfs attributes.

Otherwise LGTM.

Thanks,

Jonathan
