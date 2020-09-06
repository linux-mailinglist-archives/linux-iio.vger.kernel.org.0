Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2363E25EEC8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgIFPkr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgIFPjI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:39:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F066521531;
        Sun,  6 Sep 2020 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599406686;
        bh=BRvvOSc1aKsxn1Hi0qAtEq48pkWlx9BMbxwQAI50r74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LwKY6fM2OyLfctm4lT6a7PKhjr5xUBreDSVBZ6RPlK/5S1bB41FNc1C/XxblSqPC2
         wkiAtx8Yr+duS0iV24wWs2xKDz9xA0/KxENIHEeyHeBV40Ei+S8CuxF6na1R/JNioE
         BjQOsNlJ8lk1P1zqAPzYO2241qxTTWRAb4cKKa58=
Date:   Sun, 6 Sep 2020 16:38:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, peress@chromium.org, enric.balletbo@collabora.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: ABI: iio: Add offsets for some
 sensors
Message-ID: <20200906163801.76862bad@archlinux>
In-Reply-To: <20200901030017.3221295-3-gwendal@chromium.org>
References: <20200901030017.3221295-1-gwendal@chromium.org>
        <20200901030017.3221295-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 20:00:16 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add offsets for magnetometer and gyroscope.
> They can be use to represent online calibration to offset
> hard iron or drift.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
For these, please put them after the catchall offset block.
It's probably also worth moving the
in_magn_offset from the catch all to this specific one.

Have a go at figuring out when these were introduced as ABI
as well and fill in the version number.

Thanks,

Jonathan

> ---
> Changes since v1:
> - New, split from 3/3 patch.
>  Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 47df16c87862d..f77aee8886c66 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1716,3 +1716,22 @@ Description:
>  		Mass concentration reading of particulate matter in ug / m3.
>  		pmX consists of particles with aerodynamic diameter less or
>  		equal to X micrometers.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_offset
> +KernelVersion:	x.y
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Gyroscope drift calculated by the sensor. In addition to factory
> +		calibration, sensor or sensorhub can
> +		detect gyroscope drift and report it to userspace.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_offset
> +KernelVersion:	x.y
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Hard Iron bias calculated by the sensor or sensorhub. To be applied by
> +		user space application to the raw data to obtain the geomagnetic field.

