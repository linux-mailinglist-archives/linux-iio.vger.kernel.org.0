Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE88842825D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhJJP5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 11:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhJJP5N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Oct 2021 11:57:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F3C60EFE;
        Sun, 10 Oct 2021 15:55:13 +0000 (UTC)
Date:   Sun, 10 Oct 2021 16:59:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 0/4] iio: chemical: Add support for Sensirion SCD4x
 CO2 sensor
Message-ID: <20211010165919.51f06938@jic23-huawei>
In-Reply-To: <20211008101706.755942-1-roan@protonic.nl>
References: <20211008101706.755942-1-roan@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Oct 2021 12:17:02 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> This series adds support for the Sensirion SCD4x sensor.
> 
> The driver supports continuous reads of temperature, relative humdity and CO2
> concentration. There is an interval of 5 seconds between readings. During
> this interval the drivers checks if the sensor has new data available.
> 
> The driver is based on the scd30 driver. However, The scd4x has become too
> different to just expand the scd30 driver. I made a new driver instead of
> expanding the scd30 driver. I hope I made the right choice by doing so?

Applied to the togreg branch of iio.git with the issues Randy mentioned tidied
up. Pushed out as testing for 0-day to see if it can find anything we missed

Thanks,

Jonathan

> 
> Changes since v5:
> scd4x.c:
>   - Fix bug in trigger_handler
> 
> Changes since v4:
> scd4x.c:
>   - Minor fixes in documentation
>   - Reorder trigger_handler so memcpy is not needed anymore
> Documentation:
>   - Change information about the KernelVersion for the 
>     calibration_forced_value_available
> 
> Changes since v3:
> scd4x.c
>   - Change read and write_and_fetch function parameter. CRC byte is now
>     hidden inside the function.
>   - Fix minor style issues
>   - Add calibration_forced_value_available attribute to the driver
>   - Remove including BUFFER_TRIGGERED
>   - Change calibbias to raw ADC readings rather than converting it to
>     milli degrees C.
> Documentation:
>   - Change description of driver attributes
>   - Add calibration_forced_value_available documentation
> 
> Changes since v2:
> scd4x.c:
>   - Change boolean operations
>   - Document scope of lock
>   - Remove device *dev from struct
>   - Add goto block for errror handling
>   - Add function to read value per channel in read_raw
>   - Fix bug with lock in error paths
>   - Remove conversion of humidity and temperature values
>   - Add scale and offset to temperature channel
>   - Add scale to humidity channel
>   - Move memset out of locked section
>   - Remove unused irq functions
>   - Move device register at end of probe function
> Documentation:
>   - Copy content of sysfs-bus-iio-scd30 to sysfs-bus-iio
>   - Remove Documentation/ABI/testing/sysfs-bus-iio-scd30
> 
> Changes since v1:
> dt-bindings:
>   - Separated compatible string for each sensor type
> scd4x.c:
>   - Changed probe, resume and suspend functions to static
>   - Added SIMPLE_DEV_PM_OPS function call for power management
>     operations.
> 
> Roan van Dijk (4):
>   dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
>   MAINTAINERS: Add myself as maintainer of the scd4x driver
>   drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
>   iio: documentation: Document scd4x calibration use
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  41 ++
>  Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 -
>  .../iio/chemical/sensirion,scd4x.yaml         |  46 ++
>  MAINTAINERS                                   |   6 +
>  drivers/iio/chemical/Kconfig                  |  13 +
>  drivers/iio/chemical/Makefile                 |   1 +
>  drivers/iio/chemical/scd4x.c                  | 689 ++++++++++++++++++
>  7 files changed, 796 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>  create mode 100644 drivers/iio/chemical/scd4x.c
> 

