Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113AF2CFCAB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgLESTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgLERte (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 12:49:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6106230FF;
        Sat,  5 Dec 2020 17:12:50 +0000 (UTC)
Date:   Sat, 5 Dec 2020 17:12:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/8] Documentation: HID: amd-sfh-hid editing &
 corrections
Message-ID: <20201205171247.5225d844@archlinux>
In-Reply-To: <20201204062022.5095-3-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
        <20201204062022.5095-3-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Dec 2020 22:20:16 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Do basic editing & correction to amd-sfh-hid.rst:
> - fix punctuation
> - use HID instead of hid consistently
> - fix grammar, verb tense
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Trivial suggested addition inline.

> ---
>  Documentation/hid/amd-sfh-hid.rst |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-next-20201201.orig/Documentation/hid/amd-sfh-hid.rst
> +++ linux-next-20201201/Documentation/hid/amd-sfh-hid.rst
> @@ -3,7 +3,7 @@
>  
>  AMD Sensor Fusion Hub
>  =====================
> -AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen based platforms.
> +AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen-based platforms.
>  The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.
>  In terms of architecture it resembles ISH, however the major difference is all
>  the HID reports are generated as part of the kernel driver.
> @@ -45,20 +45,20 @@ the HID reports are generated as part of
>  AMD HID Transport Layer
>  -----------------------
>  AMD SFH transport is also implemented as a bus. Each client application executing in the AMD MP2 is
> -registered as a device on this bus. Here: MP2 which is an ARM core connected to x86 for processing
> +registered as a device on this bus. Here, MP2 is an ARM core connected to x86 for processing
>  sensor data. The layer, which binds each device (AMD SFH HID driver) identifies the device type and
> -registers with the hid core. Transport layer attach a constant "struct hid_ll_driver" object with
> +registers with the HID core. Transport layer attaches a constant "struct hid_ll_driver" object with
>  each device. Once a device is registered with HID core, the callbacks provided via this struct are
>  used by HID core to communicate with the device. AMD HID Transport layer implements the synchronous calls.
>  
>  AMD HID Client Layer
>  --------------------
> -This layer is responsible to implement HID request and descriptors. As firmware is OS agnostic, HID
> +This layer is responsible to implement HID requests and descriptors. As firmware is OS agnostic, HID
>  client layer fills the HID request structure and descriptors. HID client layer is complex as it is
> -interface between MP2 PCIe layer and HID. HID client layer initialized the MP2 PCIe layer and holds
> +interface between MP2 PCIe layer and HID. HID client layer initializes the MP2 PCIe layer and holds
>  the instance of MP2 layer. It identifies the number of sensors connected using MP2-PCIe layer. Base

Based ? (maybe)

> -on that allocates the DRAM address for each and every sensor and pass it to MP2-PCIe driver.On
> -enumeration of each the sensor, client layer fills the HID Descriptor structure and HID input repor
> +on that allocates the DRAM address for each and every sensor and passes it to MP2-PCIe driver. On
> +enumeration of each sensor, client layer fills the HID Descriptor structure and HID input report
>  structure. HID Feature report structure is optional. The report descriptor structure varies from
>  sensor to sensor.
>  
> @@ -72,7 +72,7 @@ The communication between X86 and MP2 is
>  2. Data transfer via DRAM.
>  3. Supported sensor info via P2C registers.
>  
> -Commands are sent to MP2 using C2P Mailbox registers. Writing into C2P Message registers generate
> +Commands are sent to MP2 using C2P Mailbox registers. Writing into C2P Message registers generates
>  interrupt to MP2. The client layer allocates the physical memory and the same is sent to MP2 via
>  the PCI layer. MP2 firmware writes the command output to the access DRAM memory which the client
>  layer has allocated. Firmware always writes minimum of 32 bytes into DRAM. So as a protocol driver

