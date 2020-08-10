Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90959241388
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHJXDh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 19:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgHJXDg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 19:03:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94AC06174A;
        Mon, 10 Aug 2020 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gnabiwdB45hFlhtdmo49Peh/hpNgEzAL3CueMw6vX4w=; b=BYUZamtad5DlKTYo+f7nvfRPRO
        NiFxde+hX4idWHucyB89yrO1CM+lxekMOPkKfitUGdJ8qUirVRoVdZn2yAf96oDpMsGNR/ybf0JjW
        9MtsVrgQvmAXigiCLFsulZDy310vSCIzJgjoaRf/KlFtrxwmvJzdWFTJCk+MqJeJN3xIxiBcxtBIn
        KLbvymAGLZz/bZjY/UpDHfVD3L04YTu6Lrcu5UAaA5u03pRlPmxAewB5v/aKLELgkPy2eCv/ZxRYT
        Xie3TNv8R9/1P9keeiOGbAbEcskC5AUGD+S98vhfyE0/gORZ1AP+k4coaiVlJAt6fHzPmRmFCy8MN
        9sdw9c4Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5GpD-00080q-23; Mon, 10 Aug 2020 23:03:27 +0000
Subject: Re: [PATCH v7 2/4] SFH: PCIe driver to add support of AMD sensor
 fusion hub
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
 <20200810213055.103962-3-Sandeep.Singh@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <163a507b-1606-f37a-1733-67a06a4dc950@infradead.org>
Date:   Mon, 10 Aug 2020 16:03:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810213055.103962-3-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/10/20 2:30 PM, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2 processor
> (MP2 which is an ARM® Cortex-M4 core based co-processor to x86) and
> it runs on MP2 where in driver resides on X86. This part of module
> will communicate with MP2 Firmware and provide that data into DRAM
> 
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> ---
>  drivers/hid/Kconfig                    |   2 +
>  drivers/hid/Makefile                   |   2 +
>  drivers/hid/amd-sfh-hid/Kconfig        |  21 ++++
>  drivers/hid/amd-sfh-hid/Makefile       |  15 +++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 164 +++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.h |  83 +++++++++++++
>  6 files changed, 287 insertions(+)
>  create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>  create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
> 

Hi,
Thanks for the update.

> diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
> new file mode 100644
> index 000000000000..a042048e8dd4
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +menu "AMD SFH HID support"
> +	depends on X86_64 || COMPILE_TEST
> +	depends on PCI
> +	depends on HID
> +
> +config AMD_SFH_HID
> +	tristate "AMD Sensor Fusion Hub"
> +	help

Sorry I missed this in v6:

help text should be indented with one tab + 2 spaces, so all of this
should be indented an additional 2 spaces.

> +	If you say yes to this option, support will be included for the AMD
> +	Sensor Fusion Hub.
> +	This driver will enable sensors functionality to user through HID
> +	framework. Basically this driver will get data from MP2 Firmware
> +	and provide that data to HID framework.
> +	MP2 which is an ARM® Cortex-M4 core based co-processor to x86.
> +
> +	This driver can also be built as a module. If so, the module will
> +	be  called amd-sfhtp-hid.
> +	Say Y or M here if you want to support AMD SFH. If unsure, say N.
> +
> +endmenu

-- 
~Randy

