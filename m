Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1236CA0A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhD0RH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235512AbhD0RHz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:07:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D032261289;
        Tue, 27 Apr 2021 17:07:10 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:07:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] iio: accel: sca3300: Accelerometer support and
 binding doc
Message-ID: <20210427180755.001f3d46@jic23-huawei>
In-Reply-To: <20210426081041.59807-1-tomas.melin@vaisala.com>
References: <20210426081041.59807-1-tomas.melin@vaisala.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Apr 2021 11:10:39 +0300
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Patch series adds driver and dt-binding for Murata SCA3300 accelerometer.
> 
> Device is a 3-axis Accelerometer with digital SPI interface.
> 
> Patches are tested and based on linux-next.
> 
Very nice.

Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.  As we are mid merge window I won't push
this out anywhere that will turn up in linux-next until rc1 is out.

Thanks,

Jonathan

> Changes V5:
> Addressed comments from Andy Shevchenko
> - Reversed xtree declaration fix
> - Add clarifying comment and spacing
> 
> Changes V4:
> Addressed comments from Andy Shevchenko
> - Regrouped and renamed #define statements
> - Added cacheline alignment for tx/rx buffers
> - Changed irq handler print to be ratelimited
> - Commented use of goto in irq handler
> - Removed redundant 0x0 value
> - Spacing errors fixed
> - Removed redundant return statement
> 
> Changes V3:
> Addressed comments from Jonathan Cameron and Andy Shevchenko
> - Grouped include statements
> - Revised SCA* define naming and grouped statements
> - Changed to GENMASK() for masks
> - Indentation fix for ACCEL_CHANNEL define
> - Remove field declarations using default values
> - Change to if(ret) style for checking return values
> - Add defined mask value SCA3300_MASK_STATUS for return status
> - Remove redundant casts
> - Clarify comment wording
> - Refactor to remove variable idx and redundant else branches
> - Unify sleep in device init, separate sleeps not needed since operation mode change dropped
> - Drop redundant memory allocation error message in probe
> - dev.parent is set by iio core, removed from driver probe
> - Drop of_match_ptr()
> 
> 
> Changes V2:
> Addressed comments from Jonathan Cameron
> - Add manufacturer name to dt-binding file
> - Update spdx license statement for dt-bindings
> - Remove murata,opmode devicetree property in favor of driver scale + frequency properties
> - Add copyright year for driver
> - Remove X_READ and X_WRITE defines
> - Add _available sysfs attributes
> - Fix errors in documentation formatting
> - Use ARRAY_SIZE where applicable
> - Use get/put_unaligned_be16() helpers where applicable
> - Factor out error handling to separate function
> - Return only negative values from transfer function
> - Fix INFO_SCALE to return multiplier instead of inverted value
> - Change INFO_SCALE values to be actual scale instead of mode value
> - Do not provide INFO_PROCESSED values for user space
> - Add error message for failed data read in irq handler
> - Move trigger handler timestamping as part of pushing data to buffers
> - Document startup sequence, providing reference to data sheet section
> - Convert iio_triggered_buffer_setup to devm_iio_triggered_buffer_setup,
> making remove() obsolete
> 
> Tomas Melin (2):
>   dt-bindings: iio: accel: Add SCA3300 documentation
>   iio: accel: Add driver for Murata SCA3300 accelerometer
> 
>  .../bindings/iio/accel/murata,sca3300.yaml    |  44 ++
>  drivers/iio/accel/Kconfig                     |  13 +
>  drivers/iio/accel/Makefile                    |   1 +
>  drivers/iio/accel/sca3300.c                   | 472 ++++++++++++++++++
>  4 files changed, 530 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
>  create mode 100644 drivers/iio/accel/sca3300.c
> 

