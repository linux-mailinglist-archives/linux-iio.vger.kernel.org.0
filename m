Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7834A68A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZLmL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 26 Mar 2021 07:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhCZLmH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Mar 2021 07:42:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CBE61A26;
        Fri, 26 Mar 2021 11:41:57 +0000 (UTC)
Date:   Fri, 26 Mar 2021 11:42:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anssi Hannula <anssi.hannula@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?UTF-8?B?UHI=?= =?UTF-8?B?w6ltb250?= 
        <bonbons@linux-vserver.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        Dario Pagani <dario.pagani.146+linuxk@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kim Kuparinen <kimi.h.kuparinen@gmail.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, Lopez Casado <nlopezcasad@logitech.com>,
        "L. Vinyard, Jr" <rvinyard@cs.nmsu.edu>,
        Masaki Ota <masaki.ota@jp.alps.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        message to <vojtech@ucw.cz>,
        Michael Haboustak <mike-@cinci.rr.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <uwe@kleine-koenig.org>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Zhang Lixu <lixu.zhang@intel.com>
Subject: Re: [PATCH 00/25] Rid W=1 warnings from HID
Message-ID: <20210326114202.3862b8c5@jic23-huawei>
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 17:33:39 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Lee, it's a bit novel to cc linux-iio on the cover letter but
none of the actual patches..  Or least none of them reached
me or lore.kernel.org

I'm sure they are great :)

Jonathan

> 
> Lee Jones (25):
>   HID: intel-ish-hid: Remove unused variable 'err'
>   HID: ishtp-hid-client: Move variable to where it's actually used
>   HID: intel-ish-hid: pci-ish: Remove unused variable 'ret'
>   HID: intel-ish: Supply some missing param descriptions
>   HID: intel-ish: Fix a naming disparity and a formatting error
>   HID: usbhid: Repair a formatting issue in a struct description
>   HID: intel-ish-hid: Fix a little doc-rot
>   HID: usbhid: hid-pidff: Demote a couple kernel-doc abuses
>   HID: hid-alps: Correct struct misnaming
>   HID: intel-ish-hid: Fix potential copy/paste error
>   HID: hid-core: Fix incorrect function name in header
>   HID: intel-ish-hid: ipc: Correct fw_reset_work_fn() function name in
>     header
>   HID: ishtp-hid-client: Fix incorrect function name report_bad_packet()
>   HID: hid-kye: Fix incorrect function name for kye_tablet_enable()
>   HID: hid-picolcd_core: Remove unused variable 'ret'
>   HID: hid-logitech-hidpp: Fix conformant kernel-doc header and demote
>     abuses
>   HID: hid-uclogic-rdesc: Kernel-doc is for functions and structs
>   HID: hid-thrustmaster: Demote a bunch of kernel-doc abuses
>   HID: hid-uclogic-params: Ensure function names are present and correct
>     in kernel-doc headers
>   HID: hid-sensor-custom: Remove unused variable 'ret'
>   HID: wacom_sys: Demote kernel-doc abuse
>   HID: hid-sensor-hub: Remove unused struct member 'quirks'
>   HID: hid-sensor-hub: Move 'hsdev' description to correct struct
>     definition
>   HID: intel-ish-hid: ishtp-fw-loader: Fix a bunch of formatting issues
>   HID: ishtp-hid-client: Fix 'suggest-attribute=format' compiler warning
> 
>  drivers/hid/hid-alps.c                       |  2 +-
>  drivers/hid/hid-core.c                       |  2 +-
>  drivers/hid/hid-kye.c                        |  2 +-
>  drivers/hid/hid-logitech-hidpp.c             |  7 +--
>  drivers/hid/hid-picolcd_core.c               |  5 +--
>  drivers/hid/hid-sensor-custom.c              |  5 +--
>  drivers/hid/hid-sensor-hub.c                 |  4 +-
>  drivers/hid/hid-thrustmaster.c               | 24 +++++------
>  drivers/hid/hid-uclogic-params.c             |  8 ++--
>  drivers/hid/hid-uclogic-rdesc.c              |  2 +-
>  drivers/hid/intel-ish-hid/ipc/ipc.c          |  2 +-
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c      |  3 +-
>  drivers/hid/intel-ish-hid/ishtp-fw-loader.c  | 45 ++++++++++----------
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c | 11 +++--
>  drivers/hid/intel-ish-hid/ishtp-hid.c        |  2 +-
>  drivers/hid/intel-ish-hid/ishtp-hid.h        |  9 +---
>  drivers/hid/intel-ish-hid/ishtp/bus.c        |  9 +++-
>  drivers/hid/intel-ish-hid/ishtp/client.c     |  5 +--
>  drivers/hid/intel-ish-hid/ishtp/hbm.c        |  4 +-
>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  4 +-
>  drivers/hid/usbhid/hid-pidff.c               |  4 +-
>  drivers/hid/usbhid/usbkbd.c                  |  2 +-
>  drivers/hid/wacom_sys.c                      |  2 +-
>  include/linux/intel-ish-client-if.h          |  8 +++-
>  24 files changed, 90 insertions(+), 81 deletions(-)
> 
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Anssi Hannula <anssi.hannula@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: "Bruno Prémont" <bonbons@linux-vserver.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Daniel Drubin <daniel.drubin@intel.com>
> Cc: Dario Pagani <dario.pagani.146+linuxk@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Henrik Rydberg <rydberg@bitmath.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Kim Kuparinen <kimi.h.kuparinen@gmail.com>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-usb@vger.kernel.org
> Cc: Lopez Casado <nlopezcasad@logitech.com>
> Cc: "L. Vinyard, Jr" <rvinyard@cs.nmsu.edu>
> Cc: Masaki Ota <masaki.ota@jp.alps.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: message to <vojtech@ucw.cz>
> Cc: Michael Haboustak <mike-@cinci.rr.com>
> Cc: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Uwe Kleine-König" <uwe@kleine-koenig.org>
> Cc: Vojtech Pavlik <vojtech@suse.cz>
> Cc: Zhang Lixu <lixu.zhang@intel.com>

