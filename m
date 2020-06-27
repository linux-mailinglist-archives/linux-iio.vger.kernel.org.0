Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E229A20C1E2
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgF0N4i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 09:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0N4h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 09:56:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE852158C;
        Sat, 27 Jun 2020 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593266196;
        bh=xZGOp7W+Rxc8KS1cQqM7lW8Lq0l2uWFV+KPhgQ12fxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nz3+TyqlyEsmkYUn7YJn+qS8TVFDPdAFklQjKKItZs4XI6kRkoDgYsaj9x4AlMx9Z
         eZtE3EtY3ZIKaFQG9kbsUgt7LX0mOwMEQFvvt9grynyvxrEKlT8BjjLRs/9fsSW4Ti
         X9H2K6sxF0MbJWntoRWQmEUJBYmBl2x22mxTVebI=
Date:   Sat, 27 Jun 2020 14:56:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v6 0/4] Add support for SCD30 sensor
Message-ID: <20200627145633.6be4c956@archlinux>
In-Reply-To: <20200621195701.97227-1-tomasz.duszynski@octakon.com>
References: <20200621195701.97227-1-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jun 2020 21:56:57 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Following series adds support for Sensirion SCD30 sensor module capable of
> measuring carbon dioxide, temperature and relative humidity. CO2 measurements
> base on NDIR principle while temperature and relative humidity are measured by
> the on board SHT31. As for sensor communication, both I2C and serial interfaces
> are supported.

Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> v6:
> * fix warnings produced by C=2 build option
> * fix 0-day warning 'Clarify calculation precedence for '&' and '?''
> 
> v5:
> * set pressure calibration via output channel
> * use kstrtobool() to read value into _enabled attribute
> * drop explicit parent asignment as the default one is good enough
>   (seems 'iio: core: pass parent device as parameter during allocation'
>    series was accepted)
> 
> v4:
> * improve formatting
> * improve error handling readability
> * fix message validity check on serial write
> 
> v3:
> * simplify code by scaling temperature & humidity in _read_meas()
> * update realbits in scan types
> * s/adjecent/adjacent
> * drop IIO_CHAN_INFO_RAW from _write_raw_get_fmt because there's no raw
>   output channel
> * rework locking in _read_raw
> * fix endianess problem on BE machine
> * align timestamp properly before pushing to buffers
> * explain why interrupt gets disabled after registration
> * add trigger validation
> * drop SCALE for temperature and humidity channel as they are processed
> * register action which stops measuring after starting measurements
> * spit generic calibration attr into two doing specific things
> * add comment explaining why priv in struct scd30_state is for
> * rename node in binding example to co2-sensor
> 
> v2:
> * move asm/byteorder.h towards the bottom of include list
> * make channel address names in enum more specific
> * add postfixes to defines and extra comments
> * drop unneeded i2c include from scd30 header
> * break generic command sending function into specialized options
> * expose automatic calibration and forced calibration via the same attr
> * use SAMP_FREQ to set frequency instead of meas_interval attr
> * use CALISCALE to set pressure compensation instead of pressure_comp attr
> * use CALIBBIAS to set temperature offset instead of temp_offset attr
> * fix order in MAINTAINERS
> * drop attribute allowing one to reset sensor
> * as we have dt probing drop board file based probing (i2c_device_id)
> * merge patches touching related files
> * use fwnode API to retrieve interrupt from dt
> * fix interrupt-parent spelling
> * change binding license
> * drop supply from required property
> 
> Tomasz Duszynski (4):
>   iio: chemical: scd30: add core driver
>   iio: chemical: scd30: add I2C interface driver
>   iio: chemical: scd30: add serial interface driver
>   dt-bindings: iio: scd30: add device binding file
> 
>  Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 +
>  .../iio/chemical/sensirion,scd30.yaml         |  68 ++
>  MAINTAINERS                                   |   9 +
>  drivers/iio/chemical/Kconfig                  |  33 +
>  drivers/iio/chemical/Makefile                 |   3 +
>  drivers/iio/chemical/scd30.h                  |  78 ++
>  drivers/iio/chemical/scd30_core.c             | 771 ++++++++++++++++++
>  drivers/iio/chemical/scd30_i2c.c              | 139 ++++
>  drivers/iio/chemical/scd30_serial.c           | 263 ++++++
>  9 files changed, 1398 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
>  create mode 100644 drivers/iio/chemical/scd30.h
>  create mode 100644 drivers/iio/chemical/scd30_core.c
>  create mode 100644 drivers/iio/chemical/scd30_i2c.c
>  create mode 100644 drivers/iio/chemical/scd30_serial.c
> 
> --
> 2.27.0
> 

