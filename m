Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DBA1C2BF8
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgECMBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 08:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgECMBJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 08:01:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C8D20757;
        Sun,  3 May 2020 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588507268;
        bh=HC1KNrA/raxGpfyGWqskbIFiSi8/fj6Mk4pXn4ra93Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ve1K2UW1Ty6onsP55MtI+FiZYllxDPzWzAM83Nk3qrq6qneiBUusjs7v/UL3CLNnc
         JXcuhzj7iZYWNHrX0/065Sw8iyfLIQWRDOTPq7E4Rf469vZ5Yytr83lzKNbQXAAoVb
         8o80Jifm6kRumXSgt7shAqStdX9yHpciA6QU+eB4=
Date:   Sun, 3 May 2020 13:01:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: accel: wsen-itds accel documentation
Message-ID: <20200503130103.16a92131@archlinux>
In-Reply-To: <20200429133943.18298-4-saravanan@linumiz.com>
References: <20200429133943.18298-1-saravanan@linumiz.com>
        <20200429133943.18298-4-saravanan@linumiz.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Apr 2020 15:39:42 +0200
Saravanan Sekar <saravanan@linumiz.com> wrote:

> Add documentation about device operating mode and output data range
> supported according to operating mode
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-wsen-itds       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
> new file mode 100644
> index 000000000000..5979f2b8aa1a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio\:device0/in_accel_samp_freq_available
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading gives range of sample frequencies available for current operating mode
> +		after one data has generated.

This is standard ABI so should be the main docs, not here.
It also takes absolute precedence over the power modes (as mentioned below, no
standard userspace will be able to use those).  So if the frequency is
only available in high perf mode, then we change to high perf mode.

> +
> +		Access: Read
> +		Valid values: represented in Hz
> +		- range [12.5, 1600] for high permormance mode
> +		- range [1.6, 200] for normal/low power mode
> +
> +What:		/sys/bus/iio/devices/iio\:device0/operating_mode
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Represents the device operating mode. High performance mode gives high output
> +		data rate and low noise compared to normal mode. Normal mode consumes less
> +		current.  In single shot device enters to lowpower after one data has
> +		generated.
> +
> +		Access: Read, Write
> +		Valid values: "lowpower", "normal", "high_perf", "single_shot"

The issue with these sort of 'mode' interface is almost no userspace will ever use them.
They are too unpredictable across different types of devices.

Some of these should also not be exposed to userspace anyway as they are about 'how'
you are using the driver.  For example, if you aren't doing triggered capture then
single_shot is almost always the correct option. Annoyingly I see high performance
mode gives lower noise...

So no need to expose single_shot to userspace.

For the others we are just looking at different power vs speed and accuracy trade offs.
Those are better exposed by what they effect.  Here the big control for that is
sampling frequency.

So if we assume the user is never going to touch this control (if it's even there)
then we probably want to assume they want the best possible accuracy for whatever
frequency they are running at.  So transition across the modes to provide that.

Should we ever support low power mode?  It sounds nice on paper, but in reality
userspace won't use so I suspect we should just drop it - certainly in an initial
patch submission (as it will hold up acceptance).  Even if we did support
it, as mentioned above ABI controls will take precedence so we are looking
at a 'hint' not a control of mode.

ABI is a pain, and we will put a lot of effort into not expanding it unless
there is a good usecase plus no way of mapping to existing ABI.

Jonathan


