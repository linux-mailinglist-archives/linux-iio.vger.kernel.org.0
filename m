Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF82617CE00
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 13:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGMJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 07:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgCGMJu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 07:09:50 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADA1206D5;
        Sat,  7 Mar 2020 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583582989;
        bh=wVfsIRTo1dZQhjeuU0x1McX2IlXWTN3PEbN4+tM98j4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2sLERTBveKXyRYHPBsO8wyvQyqkOI8fKx97HGemxCj7RJPhpCYW874E8XV1n5G4Ht
         e/Y1GZCyI+n6uRnFpUKjIcOSZY75rBEyMfMgtKFJGGjsaCTJo1mYishV1/CpvYTWxU
         gW8zWYsU8DPc1xRH5w06sEI07YzG3brSxoPDJeAM=
Date:   Sat, 7 Mar 2020 12:09:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] iio: accel: adxl372: Update sysfs docs
Message-ID: <20200307120944.5e369676@archlinux>
In-Reply-To: <20200225120909.12629-7-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
        <20200225120909.12629-7-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 14:09:09 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch adds entries in the syfs docs of ADXL372.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-accel-adxl372   | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> new file mode 100644
> index 000000000000..709376b54bec
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> @@ -0,0 +1,30 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/buffer_peak_mode_enable
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows to configure the FIFO to store sample
> +		sets of impact event peak (x, y, z). As a precondition, all
> +		three channels (x, y, z) need to be enabled.
> +		Writing 1, peak fifo mode will be enabled, if cleared and
> +		all three channels are enabled, sample sets of concurrent
> +		3-axis data will be stored in the FIFO.

As this is referring to the internal fifo (I think!) should we name it
hwfifo_peak_mode_enable to separate it from being related to the software "buffer"?


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/activity_detect_event
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		adxl372 works in loop mode. It will loop  between activity
> +		and inactivity detection mode. The thresh_rising sysfs files
> +		found in events/ need to be configured in order to define when
> +		the device will mark a sensed acceleration over a period of
> +		time as activity.

Hmm. As you noted in the cover letter this is a bit odd having a mixture of
an event and a more fundamental state control.

Please state what value this will provide when read.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/inactivity_detect_event
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		adxl372 works in loop mode. It will loop  between activity
> +		and inactivity detection mode. The thresh_falling sysfs files
> +		found in events/ need to be configured in order to define when
> +		the device will mark a sensed acceleration over a period of
> +		time as inactivity.

