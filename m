Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4325A256971
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgH2ReQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgH2ReP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:34:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654AB20776;
        Sat, 29 Aug 2020 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598722455;
        bh=JsRfcHMAUtykiySUJrxET5UZEICNIvU0g3gaDowz5fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dY18OHr99lS7ibwElbriBR6unFe8ZJae9xARl2UZpSePRMLBQsTuzNhpl3TxIrtLb
         rsEewI/I+X28lOhbEJa/hqMkhEv4lsfPU4zXLDoNq49kVicZmcZM8AZCarK1phL5BT
         tYtFEV3G11Zo5abnFC0EB+ry9o03D7AP9/8ZEWAg=
Date:   Sat, 29 Aug 2020 18:34:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: accel: adxl372: Add additional trigger ABI
 docs
Message-ID: <20200829183411.58cac8d7@archlinux>
In-Reply-To: <20200810093257.65929-3-alexandru.tachici@analog.com>
References: <20200810093257.65929-1-alexandru.tachici@analog.com>
        <20200810093257.65929-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Aug 2020 12:32:57 +0300
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Document use of additional trigger supplied by driver.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372 b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> new file mode 100644
> index 000000000000..47e34f865ca1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/triggerX/name = "adxl372-devX-peak"
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The adxl372 accelerometer kernel module provides an additional trigger,
> +		which sets the device in a mode in which it will record only the peak acceleration
> +		sensed over the set period of time in the events sysfs.

Innovative use of docs.  I was thinking about adding specific
docs for the event/* things that are tied up to this.

If you think that is useful, perhaps a follow up patch?


