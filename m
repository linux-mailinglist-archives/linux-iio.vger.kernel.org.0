Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB631107E5E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWMbU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:31:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMbU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:31:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4553120714;
        Sat, 23 Nov 2019 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512279;
        bh=H72EBwHqjk+3XxOunBG5SyEVz8IooxMqBRSPrnk9j8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tQW4dEqUgwzsl1CM+SfiKhdIqnlYpRP/TXYDUaXAgtFvcduatupNsGoWw1X1sZOjP
         BAwLnnirHKpr2TsN7oYSMq6qRp+j8kMx8BMg87x9ynqtCqyY7Rw44AVRUIiLcO9P8C
         nTgEbZ6FZ1wTAn/jyqtoG5xAmrJI1hm0YsJ7sQyY=
Date:   Sat, 23 Nov 2019 12:31:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [v3 2/9] Documentation: ABI: document IIO
 in_temp_filter_notch_center_frequency file
Message-ID: <20191123123113.58d35dc0@archlinux>
In-Reply-To: <20191120144756.28424-3-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-3-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:49 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> max31856 IIO driver introduced a new attribute
> "in_temp_filter_notch_center_frequency".
> This patch adds it to the list of documented ABI for sysfs-bus-iio
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Applied
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index faaa2166d741..94f7eb675108 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1726,3 +1726,10 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		List of valid periods (in seconds) for which the light intensity
>  		must be above the threshold level before interrupt is asserted.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
> +KernelVersion:	5.5
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Center frequency in Hz for a notch filter. Used i.e. for line
> +		noise suppression.

