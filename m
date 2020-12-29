Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABC22E7136
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 14:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgL2NzY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 08:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgL2NzX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 08:55:23 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5440320784;
        Tue, 29 Dec 2020 13:54:41 +0000 (UTC)
Date:   Tue, 29 Dec 2020 13:54:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Documentation: HID: edit/correct all files
Message-ID: <20201229135438.347469da@archlinux>
In-Reply-To: <20201228205327.1063-1-rdunlap@infradead.org>
References: <20201228205327.1063-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Dec 2020 12:53:19 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Make editing corrections to all files in Documentation/hid/.

As with all docs, we could bikeshed this for ever and a day, but
these changes seem to be good to me.

I did argue with myself over "an HID" vs "a HID" depending
on whether people tend to go with hid (as a word) vs H.I.D. (spelling
out the acronym) but I think hid is the one I've heard more commonly.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan


> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> 
>  [PATCH v2 1/8] Documentation: HID: hid-alps editing & corrections
>  [PATCH v2 2/8] Documentation: HID: amd-sfh-hid editing & corrections
>  [PATCH v2 3/8] Documentation: HID: hiddev editing & corrections
>  [PATCH v2 4/8] Documentation: HID: intel-ish-hid editing & corrections
>  [PATCH v2 5/8] Documentation: HID: hidraw editing & corrections
>  [PATCH v2 6/8] Documentation: HID: hid-sensor editing & corrections
>  [PATCH v2 7/8] Documentation: HID: hid-transport editing & corrections
>  [PATCH v2 8/8] Documentation: HID: uhid editing & corrections
> 
>  Documentation/hid/amd-sfh-hid.rst   |   22 +++----
>  Documentation/hid/hid-alps.rst      |    4 -
>  Documentation/hid/hid-sensor.rst    |   18 +++---
>  Documentation/hid/hid-transport.rst |   12 ++--
>  Documentation/hid/hiddev.rst        |   10 +--
>  Documentation/hid/hidraw.rst        |    5 +
>  Documentation/hid/intel-ish-hid.rst |   78 +++++++++++++-------------
>  Documentation/hid/uhid.rst          |   34 +++++------
>  8 files changed, 93 insertions(+), 90 deletions(-)

