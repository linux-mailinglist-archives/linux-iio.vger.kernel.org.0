Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85623FEA2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHIN71 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgHIN70 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 09:59:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83194C061756;
        Sun,  9 Aug 2020 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oWaAVN9sykw0k8emUxb5wR5jVQ2o1BQPhSy1+U7qzfo=; b=dwB1HrHVbcF0ijM9GFl6ucXzXt
        FbQeUXzkeE1IKxVGEWzwlkKuuy30Yj21HbhKusxteFAb3y3Bzp25Fv+FjPXXWSLcHBhNhjEPxGZIK
        5ZcVAQ4jMJXCjNhtslJ4SbtpPgDjYk35EPUF5UjAVeTpkCeiLTuLP5Vlmfg6i47pMVpeBilVwa/y/
        cIhOEOXd2r3FPWa0eGHHbWN1Xo0XRwRr5VPOE/IR+tMQm3EyA67Yxd+/Eje5ed4tcBPtqevvDORJQ
        K9f+fdF/PwbB73uK2y+XsLrUVxNQJ2i6iJ05y4mxLZjF7/letkuCkxqzxXF8p0OCXsldkDLnWGyC2
        MjDClEMQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4lr5-0007d5-9Q; Sun, 09 Aug 2020 13:59:19 +0000
Subject: Re: [PATCH v6 2/4] SFH: PCIe driver to add support of AMD sensor
 fusion
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com
References: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
 <20200809102511.2657644-3-Sandeep.Singh@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3ef30a57-08b4-5908-b13e-c1a52cdc135d@infradead.org>
Date:   Sun, 9 Aug 2020 06:59:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809102511.2657644-3-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/9/20 3:25 AM, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2 processor
> (MP2 which is an ARM® Cortex-M4 core based co-processor to x86) and
> it runs on MP2 where in driver resides on X86. This part of module
> will communicate with MP2 FW and provide that data into DRAM
> 
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> ---
>  drivers/hid/Kconfig                    |   2 +
>  drivers/hid/Makefile                   |   2 +
>  drivers/hid/amd-sfh-hid/Kconfig        |  21 ++++
>  drivers/hid/amd-sfh-hid/Makefile       |  15 +++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.c | 162 +++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.h |  83 +++++++++++++
>  6 files changed, 285 insertions(+)
>  create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>  create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h

Hi,

> diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
> new file mode 100644
> index 000000000000..e73cf9fe1324
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +menu "AMD SFH HID support"
> +	depends on X86_64 || COMPILE_TEST
> +	depends on PCI
> +
> +config AMD_SFH_HID
> +	tristate "AMD Sensor Fusion Hub"
> +	select HID

How about
	depends on HID

We try hard not to select/enable entire subsystems just because one driver
wants it.

Also, HID depends on INPUT, so it's not safe to select HID unless INPUT is
already enabled.

> +	help
> +	If you say yes to this option, support will be included for the AMD
> +	Sensor Fusion Hub.
> +	This driver will enable sensors functionality to user through HID
> +	framework. Basically this driver will get data from MP2 FW

s/FW/firmware/
or is it "framework" ?

> +	and provide that data to HID framework.
> +	MP2 which is an ARM® Cortex-M4 core based co-processor to x86.
> +
> +	This driver can also be built as modules. If so, the modules will

	                        built as a module. If so, the module will

> +	be  called amd-sfhtp-hid.
> +	Say Y or M here if you want to support AMD SFH. If unsure, say N.
> +
> +endmenu

thanks.
-- 
~Randy

