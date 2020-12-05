Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EF2CFCA5
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgLESTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLERyc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 12:54:32 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6F92311C;
        Sat,  5 Dec 2020 17:17:11 +0000 (UTC)
Date:   Sat, 5 Dec 2020 17:17:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/8] Documentation: HID: hiddev editing & corrections
Message-ID: <20201205171708.55251bb7@archlinux>
In-Reply-To: <20201204062022.5095-4-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
        <20201204062022.5095-4-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Dec 2020 22:20:17 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Do basic editing & correction to hiddev.rst:
> - use HID instead of hid consistently

One case inline, where I think the usage of hid-core
might have been deliberate.

> - add hyphenation of multi-word adjectives
> - drop a duplicate word
> - unhyphenate "a priori"
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/hid/hiddev.rst |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-next-20201201.orig/Documentation/hid/hiddev.rst
> +++ linux-next-20201201/Documentation/hid/hiddev.rst
> @@ -27,7 +27,7 @@ the following::
>                            --> hiddev.c ----> POWER / MONITOR CONTROL  
>  
>  In addition, other subsystems (apart from USB) can potentially feed
> -events into the input subsystem, but these have no effect on the hid
> +events into the input subsystem, but these have no effect on the HID
>  device interface.
>  
>  Using the HID Device Interface
> @@ -72,8 +72,8 @@ The hiddev API uses a read() interface,
>  
>  HID devices exchange data with the host computer using data
>  bundles called "reports".  Each report is divided into "fields",
> -each of which can have one or more "usages".  In the hid-core,
> -each one of these usages has a single signed 32 bit value.
> +each of which can have one or more "usages".  In the HID core,

Hmm. hid-core is (I think) kind of referring to the code in hid-core.c
Whereas a Human Interface Device core (HID core) sounds like
something different.  Not my doc though!

> +each one of these usages has a single signed 32-bit value.
>  
>  read():
>  -------
> @@ -113,7 +113,7 @@ HIDIOCAPPLICATION
>    - (none)
>  
>  This ioctl call returns the HID application usage associated with the
> -hid device. The third argument to ioctl() specifies which application
> +HID device. The third argument to ioctl() specifies which application
>  index to get. This is useful when the device has more than one
>  application collection. If the index is invalid (greater or equal to
>  the number of application collections this device has) the ioctl
> @@ -181,7 +181,7 @@ looked up by type (input, output or feat
>  must be filled in by the user. The ID can be absolute -- the actual
>  report id as reported by the device -- or relative --
>  HID_REPORT_ID_FIRST for the first report, and (HID_REPORT_ID_NEXT |
> -report_id) for the next report after report_id. Without a-priori
> +report_id) for the next report after report_id. Without a priori
>  information about report ids, the right way to use this ioctl is to
>  use the relative IDs above to enumerate the valid IDs. The ioctl
>  returns non-zero when there is no more next ID. The real report ID is
> @@ -200,7 +200,7 @@ HIDIOCGUCODE
>    - struct hiddev_usage_ref (read/write)
>  
>  Returns the usage_code in a hiddev_usage_ref structure, given that
> -given its report type, report id, field index, and index within the
> +its report type, report id, field index, and index within the
>  field have already been filled into the structure.
>  
>  HIDIOCGUSAGE

