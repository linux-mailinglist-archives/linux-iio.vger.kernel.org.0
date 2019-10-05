Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F05CCA40
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfJEOIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJEOIo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:08:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E57222C0;
        Sat,  5 Oct 2019 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570284523;
        bh=yghtZ33VamNed3/8u3AM2n8e7DSzzKkd0Ffg7fuXAGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AQdB61WpznqXsV6wpEEpk4zxk3Zpdo0luZ0qnM5FAzgWuhmO/igJP/S1FIO1kUb/H
         xNSGscaXvoH4UNv5ZQSx0/6p7pKaQUhSf1cIocBf+CsPLuomX2ZxGoOYJiIf1WVJ5X
         GDHjdNMfZjidMGGACaKyHhsSovXK0SkhzLOXpM70=
Date:   Sat, 5 Oct 2019 15:08:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com
Subject: Re: [RESEND PATCH v2 0/3] Add driver for veml6030 ambient light
 sensor
Message-ID: <20191005150838.542b0219@archlinux>
In-Reply-To: <cover.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Sep 2019 16:21:55 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

When doing a RESEND as opposed to a new version, please say
why.

> The veml6030 is an ambient light sensor from vishay and
> is a different hardware from an existing hardware for which
> driver currently exist, therefore this driver submission.
> 
> * All features; ALS, white channel & power management is
>   supported.
> 
> * All configurable parameters are supported through standard
>   iio sysfs entries. User space can get valid values of any
>   parameter (xx_available) and then can write to appropriate
>   sysfs entry.
> 
> * User space can get ALS & White channel readings through RAW
>   IIO interface.
> 
> * IIO events are used to notify application whenever threshold
>   is crossed. This uses IRQ pin of veml6030.
> 
> * Some registers in veml6030 are read only. For these registers
>   read callback returns error to user space.
> 
> There are 3 patches for this submission:
> [PATCH 1/3] iio: light: add driver for veml6030 ambient light sensor
> [PATCH 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
> [PATCH 3/3] iio: documentation: light: Add veml6030 sysfs documentation
> 
> Rishi Gupta (3):
>   iio: light: add driver for veml6030 ambient light sensor
>   dt-bindings: iio: light: add veml6030 ALS bindings
>   iio: documentation: light: Add veml6030 sysfs documentation
> 
>  .../ABI/testing/sysfs-bus-iio-light-veml6030       |  49 ++
>  .../devicetree/bindings/iio/light/veml6030.yaml    |  62 ++
>  drivers/iio/light/Kconfig                          |  11 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/veml6030.c                       | 633 +++++++++++++++++++++
>  5 files changed, 756 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
>  create mode 100644 drivers/iio/light/veml6030.c
> 

