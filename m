Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287237143E
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhECL2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 07:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhECL2Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 07:28:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22B3610E6;
        Mon,  3 May 2021 11:27:27 +0000 (UTC)
Date:   Mon, 3 May 2021 12:28:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 0/3] mainline ti tsc2046 adc driver
Message-ID: <20210503122818.59f50e45@jic23-huawei>
In-Reply-To: <20210428073208.19570-1-o.rempel@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 09:32:05 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

Hi Oleksij,

Series applied with the tweaks as per review to patch 3.  Please
check I didn't mess those up though.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> changes v6:
> - get blessing from Dmitry Torokhov
> - rebase against latest iio/testing
> - use simple name for iio_dev->name
> - use Jonathan's version for oversampling-ratio description 
> 
> changes v5:
> - remove type for the settling-time-us property
> 
> changes v4:
> - spell fixes
> - add more comments
> - make code more readable
> - move scan_buf to the priv
> - use FIELD_GET to extract ADC data
> - make some multi line code as one line
> - do not use atomic API for trig_more_count
> - fix build warning on 64bit system
> - add NULL check for the devm_kasprintf()
> - use return devm_iio_device_register(), without additional error
>   printing.
> 
> changes v3:
> - different spell fixes
> - add some notes about driver structure
> - rename the trigger to point on the touchscreen nature of it
> - rename DT binding to oversampling-ratio
> - make sure we have some defaults in case no DT property is set
> 
> changes v2:
> - rework and extend DT binding properties
> - remove touchscreen related code from the IIO ADC driver
> - make trigger be active longer then IRQ is requesting. This is needed
>   to get "inactive" samples
> - make oversampling and settle time configurable
> 
> TI TSC2046 is a touchscreen controller based on 8 channel ADC. Since most of
> this ADC based touchscreen controller share same set of challenges, it
> is better keep then as simple IIO ADC devices attached to a generic
> resistive-adc-touch driver.
> 
> This driver can replace drivers/input/touchscreen/ads7846.c and has
> following advantages over it:
> - less code to maintain
> - shared code paths (resistive-adc-touch, iio-hwmon, etc)
> - can be used as plain IIO ADC to investigate signaling issues or test
>   real capacity of the plates and attached low-pass filters
>   (or use the touchscreen as a microphone if you like ;) )
> 
> Oleksij Rempel (3):
>   dt-bindings:iio:adc: add generic settling-time-us and
>     oversampling-ratio channel properties
>   dt-bindings:iio:adc: add documentation for TI TSC2046 controller
>   iio: adc: add ADC driver for the TI TSC2046 controller
> 
>  .../devicetree/bindings/iio/adc/adc.yaml      |  12 +
>  .../bindings/iio/adc/ti,tsc2046.yaml          | 115 +++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ti-tsc2046.c                  | 720 ++++++++++++++++++
>  6 files changed, 868 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
>  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> 

