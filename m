Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BEF25EE98
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgIFPcW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbgIFPcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:32:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65A3207BB;
        Sun,  6 Sep 2020 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599406319;
        bh=r1mJUxqxQ4YcRO9XMhTAxzaD/yw/TAayOAlyoUf1dVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YaCzG2Pc2cFr7LYdWk3nBlQ1Zeo0n3Y8MvZcsxFLD3rADmp59PtibW3gZjW7X7k3Z
         vAiAd5FerRcVww8UyDEJnlYGSSaZWQjHg3EwTdOEvXrSzDxF627foDFrsY2LHvGiyQ
         VClPzGp9WcANdeKcJ6KhFfEgVLXdqFr6Jlbs7lGw=
Date:   Sun, 6 Sep 2020 16:31:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, peress@chromium.org, enric.balletbo@collabora.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: ABI: iio: Add event when
 offset/scale changes
Message-ID: <20200906163155.4d9f0259@archlinux>
In-Reply-To: <20200901030017.3221295-4-gwendal@chromium.org>
References: <20200901030017.3221295-1-gwendal@chromium.org>
        <20200901030017.3221295-4-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 20:00:17 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Some sensors/sensorhubs can calculate drift or hard iron offsets to
> apply to raw data to get the true measure data.
> These offsets are applied by the user space application.
> When these offsets change, events are raised to tell the application
> to update the cached offset values.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I'm fine with this, but would like to give a bit more time for others to
comment.  Also you left the version number as wild cards.
I guess I can fix that, but I've been known to miss such things
so better to be optimistic and put in 5.10.

However I don't really want to see ABI without a user so I'd rather 
see this patch alongside the driver update.

Thanks,

Jonathan

> ---
> Changes since v1:
> - Define metadata_en instead of offset/scale_en to limit race
>   conditions.
>  Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f77aee8886c66..45f456de1621a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1735,3 +1735,16 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Hard Iron bias calculated by the sensor or sensorhub. To be applied by
>  		user space application to the raw data to obtain the geomagnetic field.
> +
> +What:		/sys/.../iio:deviceX/events/in_accel_metadata_change_en
> +What:		/sys/.../iio:deviceX/events/in_magn_metadata_change_en
> +What:		/sys/.../iio:deviceX/events/in_anglvel_metadata_change_en

I've just been looking at existing naming of events and thinking about whether
we should have a space between metadata and change. From a human readabilty
point of view it would be nice, but from a parsability viewpoint possibly not.

We do have precedent though for such a space (even if we wouldn't have done
it today) in thresh_adaptive and mag_adaptive (see industrialio-event.c) so
I guess one more probably doesn't hurt too much.


> +KernelVersion:	x.y

Be an optimist for patches like this and put the next cycle in there. That's
better than some maintainers just picking it up with wild cards :)

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Some sensors internally calculate offset to apply to remove bias (for
> +		instance, hard/soft-iron bias for magnetometer, online calibration bias for
> +		gyroscope or accelerometer).
> +		When the sensor computes a new set of offset values, it generates an
> +		event for the userspace application to refresh the offsets to apply to raw
> +		data.

