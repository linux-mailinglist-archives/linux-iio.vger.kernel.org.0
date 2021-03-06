Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E290D32FB39
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhCFOin (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 09:38:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCFOiR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 09:38:17 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9909F64EBD;
        Sat,  6 Mar 2021 14:38:15 +0000 (UTC)
Date:   Sat, 6 Mar 2021 14:38:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 3/4] IIO: acpi-als: Get rid of ACPICA message
 printing
Message-ID: <20210306143812.4da7b32e@archlinux>
In-Reply-To: <6250192.e2TqKytQZN@kreacher>
References: <2775419.haJ69vZeI0@kreacher>
        <6250192.e2TqKytQZN@kreacher>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 05 Mar 2021 19:42:29 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use acpi_evaluation_failure_warn() introduced previously instead of
> the ACPICA-specific ACPI_EXCEPTION() macro to log warning messages
> regarding ACPI object evaluation failures and drop the
> ACPI_MODULE_NAME() definition only used by the ACPICA message
> printing macro.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/light/acpi-als.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/iio/light/acpi-als.c
> ===================================================================
> --- linux-pm.orig/drivers/iio/light/acpi-als.c
> +++ linux-pm/drivers/iio/light/acpi-als.c
> @@ -26,8 +26,6 @@
>  #define ACPI_ALS_DEVICE_NAME		"acpi-als"
>  #define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
>  
> -ACPI_MODULE_NAME("acpi-als");
> -
>  /*
>   * So far, there's only one channel in here, but the specification for
>   * ACPI0008 says there can be more to what the block can report. Like
> @@ -91,7 +89,7 @@ static int acpi_als_read_value(struct ac
>  				       &temp_val);
>  
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS %s", prop));
> +		acpi_evaluation_failure_warn(als->device->handle, prop, status);
>  		return -EIO;
>  	}
>  
> 
> 
> 

