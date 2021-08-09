Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14173E4D76
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhHIT7j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 15:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhHIT7j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Aug 2021 15:59:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6096D60230;
        Mon,  9 Aug 2021 19:59:16 +0000 (UTC)
Date:   Mon, 9 Aug 2021 21:02:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [RESEND PATCH v9 0/2] iio: accel: add support for ADXL355
Message-ID: <20210809210207.2140c31a@jic23-huawei>
In-Reply-To: <20210809080729.57029-1-puranjay12@gmail.com>
References: <20210809080729.57029-1-puranjay12@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Aug 2021 13:37:27 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Add the dt-bindings and the driver for ADXL355 3-axis MEMS Accelerometer.

Hi Puranjay,

So these both look fine to me (subject to that tiny cleanup in patch 2
that I'll do whilst applying).  Now we need to give time for a device
tree review. It's in their patchwork instance and passing the tests
so Rob will get to it fairly soon.

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210809080729.57029-2-puranjay12@gmail.com/

Jonathan

> 
> Changes since v8:
> 1. Make scale and offset defines inline and remove them.
> 2. Change dt-binding doc to state interrupt polarity only for DRDY pin.
> 3. Remove triggered buffer support from this patch series.
> 
> Changes since v7:
> 1. Update MAINTAINERS to show all driver files.
> 2. Set CONFIGS for buffered support in Kconfig.
> 
> Changes since v6:
> 1. Use interrupt-names property in device tree document.
> 2. Add triggered buffer support.
> 3. Use a static table for offset and data registers.
> 4. Fix coding style issues.
> 5. move defines from header to c file.
> 
> Changes since v5:
> 1. Used get_unaligned_be24() and  get_unaligned_be16() to parse
> acceleration and temperature data. This solves sparse errors and also
> make the code more understandable.
> 
> Changes since v4:
> 1. Fix errors reported by sparse.
> 
> Changes since v3:
> 1. Fix errors in yaml DT doc.
> 2. Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause
> 
> Changes since v2:
> 1. Add separate DT binding doc in yaml.
> 2. Use ____cacheline_aligned buffer for regmap_bulk_read/write calls.
> 3. Make code consistent by using same style in switch case.
> 4. Use FIELD_PREP in place of custom macros.
> 5. Make Kconfig description more informative.
> 
> Changes since v1:
> 1. Remove the declarations for static regmap structures from adxl355.h.
> This was missed in the v1 and caused errors.
> 2. Make switch case statements consistent by directly returning from
> each case rather than saving the return in a variable.
> 3. Some coding style changes.
> 
> Changes since v0:
> 1. Move adxl355_hpf_3db_table to adxl355_data structure. This is done to make
> sure that each device gets its own table.
> 2. Make local regmap definitions private to adxl355_core.c.
> 3. Other minor coding style changes.
> 
> Puranjay Mohan (2):
>   dt-bindings: iio: accel: Add DT binding doc for ADXL355
>   iio: accel: Add driver support for ADXL355
> 
>  .../bindings/iio/accel/adi,adxl355.yaml       |  88 +++
>  MAINTAINERS                                   |  10 +
>  drivers/iio/accel/Kconfig                     |  29 +
>  drivers/iio/accel/Makefile                    |   3 +
>  drivers/iio/accel/adxl355.h                   |  19 +
>  drivers/iio/accel/adxl355_core.c              | 578 ++++++++++++++++++
>  drivers/iio/accel/adxl355_i2c.c               |  64 ++
>  drivers/iio/accel/adxl355_spi.c               |  67 ++
>  8 files changed, 858 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
>  create mode 100644 drivers/iio/accel/adxl355.h
>  create mode 100644 drivers/iio/accel/adxl355_core.c
>  create mode 100644 drivers/iio/accel/adxl355_i2c.c
>  create mode 100644 drivers/iio/accel/adxl355_spi.c
> 

