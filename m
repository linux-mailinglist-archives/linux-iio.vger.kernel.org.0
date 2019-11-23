Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C911A107E62
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfKWMht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfKWMht (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:37:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809C520706;
        Sat, 23 Nov 2019 12:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512668;
        bh=uXELmshH20TztDE2krYFaQ7OE/gtOYnPD3YXi0LvCNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGuVjnHY9RggQ2I5v3gEMDObtGuuAYmCWi5ZupOwuFwUAPZrQSMGcoS8mf3QbVybL
         BZkpWIgEs8BH9/N/i9iXx79Ob3vhnW8w9Jaa/d/OcINSICCyTOpOISKwpvjyLw57uE
         hfyXl7xYgKROlU7Qcr26qcgCThzZo0c0Pl6d82KI=
Date:   Sat, 23 Nov 2019 12:37:43 +0000
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
Subject: Re: [v3 6/9] Documentation: ABI: document IIO thermocouple_type
 file
Message-ID: <20191123123743.0609e1ee@archlinux>
In-Reply-To: <20191120144756.28424-7-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-7-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:53 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> IIO core layer gained a new sysfs standard attribute "thermocouple_type".
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
Applied,

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 94f7eb675108..d3e53a6d8331 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1733,3 +1733,9 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Center frequency in Hz for a notch filter. Used i.e. for line
>  		noise suppression.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_thermocouple_type
> +KernelVersion:	5.5
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		One of the following thermocouple types: B, E, J, K, N, R, S, T.

