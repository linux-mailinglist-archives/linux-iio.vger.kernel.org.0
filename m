Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200D41F88E7
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFNNRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgFNNRn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:17:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16743206D7;
        Sun, 14 Jun 2020 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592140662;
        bh=++eWGQXrMWbaOFfTJbiV3sV2IYNlyVegRPfYlHUt6dw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qlTzM7yWyCXf/T7Ck7IPddkZbl6zSwEPAI3w9qVmN7cjqHiNJVD33oF5eZJQjW/ok
         f/rFx9ynb2sOK7nRb/pImOEdWm+C+wKMJxjvkulfzYmEkg+xTMwi5dIZ+WCOBRZtKs
         y3rKSfbQ7UVgvADoMO5CpjXj1f5ceUDS++hdCamg=
Date:   Sun, 14 Jun 2020 14:17:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 0/4] Add support for SCD30 sensor
Message-ID: <20200614141738.0645a954@archlinux>
In-Reply-To: <20200607175812.95777-1-tomasz.duszynski@octakon.com>
References: <20200607175812.95777-1-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 19:58:08 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Following series adds support for Sensirion SCD30 sensor module capable of
> measuring carbon dioxide, temperature and relative humidity. CO2 measurements
> base on NDIR principle while temperature and relative humidity are measured by
> the on board SHT31. As for sensor communication, both I2C and serial interfaces
> are supported.

Hi Tomasz,

All looks good to me.

I'll let it sit on the list a bit longer though to give time for anyone
else to review if they wish and ideally pick up a DT review if
Rob has time.  It isn't unheard of me to somehow loose a set down
the back of the sofa, so do poke me if I seem to to have lost this
in a few weeks time! (I'll try not to of course!)

Thanks,

Jonathan

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
>  drivers/iio/chemical/scd30_core.c             | 770 ++++++++++++++++++
>  drivers/iio/chemical/scd30_i2c.c              | 139 ++++
>  drivers/iio/chemical/scd30_serial.c           | 263 ++++++
>  9 files changed, 1397 insertions(+)
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

