Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5F34D03B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhC2Mil (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 08:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhC2MiV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 08:38:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99E06195C;
        Mon, 29 Mar 2021 12:38:17 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:38:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 00/10] platform/x86: toshiba_acpi: move acpi add/remove
 to device-managed routines
Message-ID: <20210329133824.1a1fad6f@jic23-huawei>
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:38 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This changeset tries to do a conversion of the toshiba_acpi driver to use
> only device-managed routines. The driver registers as a singleton, so no
> more than one device can be registered at a time.
> 
> My main intent here is to try to convert the iio_device_alloc() and
> iio_device_register() to their devm_ variants.
> 
> Usually, when converting a registration call to device-managed variant, the
> init order must be preserved. And the deregistration order must be a mirror
> of the registration (in reverse order).
> 
> This change tries to do that, by using devm_ variants where available and
> devm_add_action_or_reset() where this isn't possible.
> Some deregistration ordering is changed, because it wasn't exactly
> mirroring (in reverse) the init order.
> 
> For the IIO subsystem, the toshiba_acpi driver is the only user of
> iio_device_alloc(). If this changeset is accepted (after discussion), I
> will propose to remove the iio_device_alloc() function.
> 
> While I admit this may look like an overzealous effort to use devm_
> everywhere (in IIO at least), for me it's a fun/interesting excercise.
hmm. I am dubious about 'removing' the support for non devm_ in the long
run because it can lead to requiring fiddly changes in existing drivers
(like this one :) and I don't want to put that barrier in front of anyone
using IIO.

However, I'm more than happy to see them used in very few drivers and
nice warning text added to suggest people might want to look at whether
then can move to a device managed probe flow

Jonathan

> 
> Alexandru Ardelean (10):
>   platform/x86: toshiba_acpi: bind life-time of toshiba_acpi_dev to
>     parent
>   platform/x86: toshiba_acpi: use devm_add_action_or_reset() for
>     singleton clear
>   platform/x86: toshiba_acpi: bind registration of miscdev object to
>     parent
>   platform/x86: toshiba_acpi: use device-managed functions for input
>     device
>   platform/x86: toshiba_acpi: register backlight with device-managed
>     variant
>   platform/x86: toshiba_acpi: use devm_led_classdev_register() for LEDs
>   platform/x86: toshiba_acpi: use device-managed functions for
>     accelerometer
>   platform/x86: toshiba_acpi: use device-managed for wwan_rfkill
>     management
>   platform/x86: toshiba_acpi: use device-managed for sysfs removal
>   platform/x86: toshiba_acpi: bind proc entries creation to parent
> 
>  drivers/platform/x86/toshiba_acpi.c | 249 +++++++++++++++++-----------
>  1 file changed, 150 insertions(+), 99 deletions(-)
> 

