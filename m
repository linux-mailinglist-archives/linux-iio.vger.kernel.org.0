Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A72456CE
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHPIpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 04:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgHPIpi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 04:45:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C622065C;
        Sun, 16 Aug 2020 08:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597567537;
        bh=yhubSh2OGXhJ/RdPAv90EkLHgNzIDGfA5xtx5P1Bbg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IaE126ZERG2hrah5BQLizKVpedwVDN3qp9pA8FS69v+wW0S70hxu0Hc95/MruQwuP
         scUViHimuCBgKGtMdsZj6T/f1wD8OEpccBcx6rmskC59/KAa2lm4q83yZXQeyxSMoX
         k77UkIL5rYz7w6e4EsUaamJpibcEoMOKjOAVvi1E=
Date:   Sun, 16 Aug 2020 09:45:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, trivial@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: iio: fix some spelling mistakes
Message-ID: <20200816094531.004adc9c@archlinux>
In-Reply-To: <20200813065220.23256-1-a.fatoum@pengutronix.de>
References: <20200813065220.23256-1-a.fatoum@pengutronix.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Aug 2020 08:52:20 +0200
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> This fixes some typos found while browsing the documentation.
> 
> Cc: trivial@kernel.org
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3e53a6d8331..ef86702678c7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -49,9 +49,9 @@ Description:
>  		resulting sampling frequency.  In many devices this
>  		parameter has an effect on input filters etc. rather than
>  		simply controlling when the input is sampled.  As this
> -		effects data ready triggers, hardware buffers and the sysfs
> +		affects data ready triggers, hardware buffers and the sysfs
>  		direct access interfaces, it may be found in any of the
> -		relevant directories.  If it effects all of the above
> +		relevant directories.  If it affects all of the above
>  		then it is to be found in the base device directory.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> @@ -1013,7 +1013,7 @@ What:		/sys/.../events/in_activity_running_thresh_falling_en
>  KernelVersion:	3.19
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Enables or disables activitity events. Depending on direction
> +		Enables or disables activity events. Depending on direction
>  		an event is generated when sensor ENTERS or LEAVES a given state.
>  
>  What:		/sys/.../events/in_activity_still_thresh_rising_value

