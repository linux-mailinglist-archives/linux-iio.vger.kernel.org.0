Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01D25E992
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgIERto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgIERtm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:49:42 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E98208C7;
        Sat,  5 Sep 2020 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599328180;
        bh=mfMtq/b63zrw4CxSFHeTYxWBAA6Fe0dsrzAYPVvdwyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nwauhk+Za5cFdlqNkfGdWPHHILLERVuef305zvZcklyCwOmYznSI7LDCCI7kivWpV
         bt9lNTdVxLLbq680JR1Et7wWYotv03WmH1TH5Gbmd0QBgSNBFpBj1R9JMN5EXCV1aj
         VF/+E4RQ2cEWtXaaeDc+R8vHpzYZrdxQfPoOp4Ds=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/4] staging:iio:documentation: Drop most generic docs
Date:   Sat,  5 Sep 2020 18:47:21 +0100
Message-Id: <20200905174721.216452-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905174721.216452-1-jic23@kernel.org>
References: <20200905174721.216452-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These docs are both suffering from being out of date, and from being
superceeded by the documentation in Documentation/driver-api/iio

Note the inkern.txt drop is left for now as this is an area not
well covered by the more recent documentation outside staging.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/Documentation/device.txt  | 74 -------------------
 .../staging/iio/Documentation/overview.txt    | 57 --------------
 drivers/staging/iio/Documentation/ring.txt    | 47 ------------
 drivers/staging/iio/Documentation/trigger.txt | 31 --------
 4 files changed, 209 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
deleted file mode 100644
index 0d1275b1eb3f..000000000000
--- a/drivers/staging/iio/Documentation/device.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-IIO Device drivers
-
-This is not intended to provide a comprehensive guide to writing an
-IIO device driver.  For further information see the drivers within the
-subsystem.
-
-The crucial structure for device drivers in iio is iio_dev.
-
-First allocate one using:
-
-struct iio_dev *indio_dev = iio_device_alloc(parent, sizeof(struct chip_state));
-where chip_state is a structure of local state data for this instance of
-the chip.
-
-That data can be accessed using iio_priv(struct iio_dev *).
-
-Then fill in the following:
-
-- indio_dev->name
-	Name of the device being driven - made available as the name
-	attribute in sysfs.
-
-- indio_dev->info
-	pointer to a structure with elements that tend to be fixed for
-	large sets of different parts supported by a given driver.
-	This contains:
-	* info->event_attrs:
-		Attributes used to enable / disable hardware events.
-	* info->attrs:
-		General device attributes. Typically used for the weird
-		and the wonderful bits not covered by the channel specification.
-	* info->read_raw:
-		Raw data reading function. Used for both raw channel access
-		and for associate parameters such as offsets and scales.
-	* info->write_raw:
-		Raw value writing function. Used for writable device values such
-		as DAC values and calibbias.
-	* info->read_event_config:
-		Typically only set if there are some interrupt lines.  This
-		is used to read if an on sensor event detector is enabled.
-	* info->write_event_config:
-		Enable / disable an on sensor event detector.
-	* info->read_event_value:
-		Read value associated with on sensor event detectors. Note that
-		the meaning of the returned value is dependent on the event
-		type.
-	* info->write_event_value:
-		Write the value associated with on sensor event detectors. E.g.
-		a threshold above which an interrupt occurs.  Note that the
-		meaning of the value to be set is event type dependent.
-
-- indio_dev->modes:
-	Specify whether direct access and / or ring buffer access is supported.
-- indio_dev->buffer:
-	An optional associated buffer.
-- indio_dev->pollfunc:
-	Poll function related elements. This controls what occurs when a trigger
-	to which this device is attached sends an event.
-- indio_dev->channels:
-	Specification of device channels. Most attributes etc. are built
-	from this spec.
-- indio_dev->num_channels:
-	How many channels are there?
-
-Once these are set up, a call to iio_device_register(indio_dev)
-will register the device with the iio core.
-
-Worth noting here is that, if a ring buffer is to be used, it can be
-allocated prior to registering the device with the iio-core, but must
-be registered afterwards (otherwise the whole parentage of devices
-gets confused)
-
-On remove, iio_device_unregister(indio_dev) will remove the device from
-the core, and iio_device_free(indio_dev) will clean up.
diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
deleted file mode 100644
index 00409d5dab4e..000000000000
--- a/drivers/staging/iio/Documentation/overview.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Overview of IIO
-
-The Industrial I/O subsystem is intended to provide support for devices
-that in some sense are analog to digital converters (ADCs). As many
-actual devices combine some ADCs with digital to analog converters
-(DACs) that functionality is also supported.
-
-The aim is to fill the gap between the somewhat similar hwmon and
-input subsystems.  Hwmon is very much directed at low sample rate
-sensors used in applications such as fan speed control and temperature
-measurement.  Input is, as its name suggests focused on input
-devices. In some cases, there is considerable overlap between these and
-IIO.
-
-A typical device falling into this category would be connected via SPI
-or I2C.
-
-Functionality of IIO
-
-* Basic device registration and handling. This is very similar to
-hwmon with simple polled access to device channels via sysfs.
-
-* Event chrdevs.  These are similar to input in that they provide a
-route to user space for hardware triggered events. Such events include
-threshold detectors, free-fall detectors and more complex action
-detection.  The events themselves are currently very simple with
-merely an event code and a timestamp.  Any data associated with the
-event must be accessed via polling.
-
-Note: A given device may have one or more event channel.  These events are
-turned on or off (if possible) via sysfs interfaces.
-
-* Hardware buffer support.  Some recent sensors have included
-fifo / ring buffers on the sensor chip.  These greatly reduce the load
-on the host CPU by buffering relatively large numbers of data samples
-based on an internal sampling clock. Examples include VTI SCA3000
-series and Analog Devices ADXL345 accelerometers.  Each buffer supports
-polling to establish when data is available.
-
-* Trigger and software buffer support. In many data analysis
-applications it is useful to be able to capture data based on some
-external signal (trigger).  These triggers might be a data ready
-signal, a gpio line connected to some external system or an on
-processor periodic interrupt.  A single trigger may initialize data
-capture or reading from a number of sensors.  These triggers are
-used in IIO to fill software buffers acting in a very similar
-fashion to the hardware buffers described above.
-
-Other documentation:
-
-device.txt - elements of a typical device driver.
-
-trigger.txt - elements of a typical trigger driver.
-
-ring.txt - additional elements required for buffer support.
-
-sysfs-bus-iio - abi documentation file.
diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
deleted file mode 100644
index 18718fcaf259..000000000000
--- a/drivers/staging/iio/Documentation/ring.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Buffer support within IIO
-
-This document is intended as a general overview of the functionality
-a buffer may supply and how it is specified within IIO.  For more
-specific information on a given buffer implementation, see the
-comments in the source code.  Note that some drivers allow buffer
-implementation to be selected at compile time via Kconfig options.
-
-A given buffer implementation typically embeds a struct
-iio_ring_buffer and it is a pointer to this that is provided to the
-IIO core. Access to the embedding structure is typically done via
-container_of functions.
-
-struct iio_ring_buffer contains a struct iio_ring_setup_ops *setup_ops
-which in turn contains the 4 function pointers
-(preenable, postenable, predisable and postdisable).
-These are used to perform device specific steps on either side
-of the core changing its current mode to indicate that the buffer
-is enabled or disabled (along with enabling triggering etc. as appropriate).
-
-Also in struct iio_ring_buffer is a struct iio_ring_access_funcs.
-The function pointers within here are used to allow the core to handle
-as much buffer functionality as possible. Note almost all of these
-are optional.
-
-store_to
-  If possible, push data to the buffer.
-
-read_last
-  If possible, get the most recent scan from the buffer (without removal).
-  This provides polling like functionality whilst the ring buffering is in
-  use without a separate read from the device.
-
-rip_first_n
-  The primary buffer reading function. Note that it may well not return
-  as much data as requested.
-
-request_update
-  If parameters have changed that require reinitialization or configuration of
-  the buffer this will trigger it.
-
-set_bytes_per_datum
-  Set the number of bytes for a complete scan. (All samples + timestamp)
-
-set_length
-  Set the number of complete scans that may be held by the buffer.
-
diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
deleted file mode 100644
index 299a1add98bf..000000000000
--- a/drivers/staging/iio/Documentation/trigger.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-IIO trigger drivers.
-
-Many triggers are provided by hardware that will also be registered as
-an IIO device.  Whilst this can create device specific complexities
-such triggers are registered with the core in the same way as
-stand-alone triggers.
-
-struct iio_trig *trig = iio_trigger_alloc("<trigger format string>", ...);
-
-allocates a trigger structure.  The key elements to then fill in within
-a driver are:
-
-trig->set_trigger_state:
-	Function that enables / disables the underlying source of the trigger.
-
-There is also a
-trig->alloc_list which is useful for drivers that allocate multiple
-triggers to keep track of what they have created.
-
-When these have been set call:
-
-iio_trigger_register(trig);
-
-to register the trigger with the core, making it available to trigger
-consumers.
-
-Trigger Consumers
-
-Currently triggers are only used for the filling of software
-buffers and as such any device supporting INDIO_BUFFER_TRIGGERED has the
-consumer interface automatically created.
-- 
2.28.0

