Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F04888C3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 11:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiAIKqN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 05:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiAIKqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 05:46:13 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF35AC06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 02:46:12 -0800 (PST)
Received: from [81.101.6.87] (port=35362 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6ViA-000467-HC; Sun, 09 Jan 2022 10:46:10 +0000
Date:   Sun, 9 Jan 2022 10:52:01 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Expand Semtech SAR Sensors support
Message-ID: <20220109105135.59464216@jic23-huawei>
In-Reply-To: <20220101203817.290512-1-gwendal@chromium.org>
References: <20220101203817.290512-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 Jan 2022 12:38:12 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add a new Semtech SAR sensor SX9324.
> Instead of recopying 1/3 of the sx9310 driver, move common code in a new
> file. It will be used again for the next sensor, SX9360.
Series applied to the togreg branch of iio.git.
Until the merge window is done this will only be pushed out as testing
and I'll be rebasing on rc1 once available.

Thanks,

Jonathan

> 
> Major changes in v10:
>   Fix spelling in comment, unnecessary empty lines.
>   Add symbol namespace.
> Major changes in v9:
>   Use simple pm macro
>   Unify use of returning on default
>   Add space before '}'
>   Use sysfs_emit instead of printf.
> 
> Major changes in v8:
>   Fix mismatch between documentation and code (setting vs setup)
>   Use dev_get_drvdata to access iio device structure.
> 
> Major changes in v7:
>   Fix one remaining syntax error in device tree binding documentation.
> 
> Major changes in v6:
>   Fix syntax errors in device tree binding documentation.
>   Drop of_match_ptr and ACPI_PTR protections.
>   Fix unused variable warning.
> 
> Major changes in v5:
>   Use iwyu to cleanup include files.
>   Use dev_err_probe() in probe routine
>   Add attribute to shift irq status register, not common among all
>     sensors.
>   Fix long line.
> 
> Major changes in v4:
>   Use chip_info instead of info in common data.
>   Returns an error when setting negative sysfs entries
>   Fix cut and paste errors, credit.
> 
> Major changes in v3:
>   Fix some error in binding descriptions and setting
>   Fix invalid register constant name.
> 
> Major changes in v2:
>   Better interface between common code and drivers
>   Document SX9324 phase configuration
> 
> Gwendal Grignou (5):
>   iio: sx9310: Add frequency in read_avail
>   iio: sx9310: Extract common Semtech sensor logic
>   iio: proximity: Add SX9324 support
>   dt-bindings: iio: Add sx9324 binding
>   iio: sx9324: Add dt_binding support
> 
>  .../ABI/testing/sysfs-bus-iio-sx9324          |   28 +
>  .../iio/proximity/semtech,sx9324.yaml         |  161 +++
>  drivers/iio/proximity/Kconfig                 |   20 +
>  drivers/iio/proximity/Makefile                |    2 +
>  drivers/iio/proximity/sx9310.c                |  741 ++----------
>  drivers/iio/proximity/sx9324.c                | 1068 +++++++++++++++++
>  drivers/iio/proximity/sx_common.c             |  572 +++++++++
>  drivers/iio/proximity/sx_common.h             |  157 +++
>  8 files changed, 2120 insertions(+), 629 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
>  create mode 100644 drivers/iio/proximity/sx9324.c
>  create mode 100644 drivers/iio/proximity/sx_common.c
>  create mode 100644 drivers/iio/proximity/sx_common.h
> 

