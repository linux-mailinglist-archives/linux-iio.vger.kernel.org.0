Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91173483A0
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 22:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhCXV2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 17:28:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:35577 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233849AbhCXV2E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Mar 2021 17:28:04 -0400
IronPort-SDR: AIynuTeax0lSDR4QNNDrAwjv5zKQly0i/YD/y0BUrNCul06y1zxVSONEJ2DYy4nAgY8oUOJjJV
 biZiQbh9rRyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="252146191"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="252146191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:28:01 -0700
IronPort-SDR: WfPWxzgv6hRguRTx0Lc0se0H/IbC6vbec18pdDFxd4+6q0LrD3loM5RVaRgzQbGak0sV9tw53y
 2EfXrYrBhmaA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="442424773"
Received: from aksagira-mobl2.amr.corp.intel.com ([10.209.125.174])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:27:54 -0700
Message-ID: <c0121400eea96626cdd212ad95f296a024356289.camel@linux.intel.com>
Subject: Re: [PATCH 00/25] Rid W=1 warnings from HID
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anssi Hannula <anssi.hannula@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        Dario Pagani <dario.pagani.146+linuxk@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kim Kuparinen <kimi.h.kuparinen@gmail.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
        Sumit Semwal <sumit.semwal@linaro.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Zhang Lixu <lixu.zhang@intel.com>
Date:   Wed, 24 Mar 2021 14:27:54 -0700
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2021-03-24 at 17:33 +0000, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 

For changes in  drivers/hid/intel-ish-hid folder

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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
>   HID: intel-ish-hid: ipc: Correct fw_reset_work_fn() function name
> in
>     header
>   HID: ishtp-hid-client: Fix incorrect function name
> report_bad_packet()
>   HID: hid-kye: Fix incorrect function name for kye_tablet_enable()
>   HID: hid-picolcd_core: Remove unused variable 'ret'
>   HID: hid-logitech-hidpp: Fix conformant kernel-doc header and
> demote
>     abuses
>   HID: hid-uclogic-rdesc: Kernel-doc is for functions and structs
>   HID: hid-thrustmaster: Demote a bunch of kernel-doc abuses
>   HID: hid-uclogic-params: Ensure function names are present and
> correct
>     in kernel-doc headers
>   HID: hid-sensor-custom: Remove unused variable 'ret'
>   HID: wacom_sys: Demote kernel-doc abuse
>   HID: hid-sensor-hub: Remove unused struct member 'quirks'
>   HID: hid-sensor-hub: Move 'hsdev' description to correct struct
>     definition
>   HID: intel-ish-hid: ishtp-fw-loader: Fix a bunch of formatting
> issues
>   HID: ishtp-hid-client: Fix 'suggest-attribute=format' compiler
> warning
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
>  drivers/hid/intel-ish-hid/ishtp-fw-loader.c  | 45 ++++++++++------
> ----
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

