Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB04270EE6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgISPXt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgISPXt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:23:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BE72098B;
        Sat, 19 Sep 2020 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600529029;
        bh=1EeKdlmsmU+caUMfvOqBXfsDpnLBdhbdpm6tlnkp3Ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1pEsOL5fIWwve6PgdC1+REytce3vMzPAdtpFJM66+4V6Uus32SOUBo2D5W4z9KrjG
         wwVqMo7jm0+niToKdNQcQDqUquiJ39baP4LeWVds4eTB2AuoG/eSCC9XOoDSnX3r7X
         onEGh4Wq19m5e2lE9hfUSBQLMA5drhhzCUk32g5w=
Date:   Sat, 19 Sep 2020 16:23:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio:Documentation: Add documentation for label
 channel attribute
Message-ID: <20200919162345.12ba91a3@archlinux>
In-Reply-To: <20200918093337.93621-1-cristian.pop@analog.com>
References: <20200918093337.93621-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 12:33:37 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined in the device tree for this channel add that to the
> channel specific attributes. This is useful for userspace to be able to
> identify an individual channel.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changes in V5:
> Create a separate patch file for this commit.
>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3e53a6d8331..f2a9a03b8af9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1697,6 +1697,15 @@ Description:
>  
>  		Raw counter device counters direction for channel Y.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/channel_label

That naming doesn't look right. Should be something like
in_voltageY_label

> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Optional symbolic label to a device channel.
> +		If a label is defined in the device tree for this channel add
> +		that to the channel specific attributes. This is useful for
> +		userspace to be able to identify an individual channel.

This isn't devicetree specific.  The driver can elect to provide this
label from all sorts of sources such as ACPI, or it might be hard coded
in the driver if the channel is internal to a SoC for example.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
>  KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org

