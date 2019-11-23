Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E81107E61
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfKWMgW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMgW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:36:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8218020719;
        Sat, 23 Nov 2019 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512581;
        bh=NODSuDS1wOpg2hOUJOwHMzNEuH+ircn0kePUjkRDYSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BS3fBHjCOTd0wm5/2vfbJXDnMLPJFco+VI5sHm0nZTqnBPZCHpQ2/59KYigLymN6J
         BeQDQ1FybS0dMReT5vFfuu1Vzju/gwiWSgUPgycFcu2OL/E0CfYWPUrMDiZ1g7oHU/
         yoJQpQdOdt4k8NXU5SzxVSyEll4qrxxwD6OpTuSo=
Date:   Sat, 23 Nov 2019 12:36:15 +0000
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
Subject: Re: [v3 5/9] iio: core: add thermocouple_type standard attribute
Message-ID: <20191123123615.3d6009d2@archlinux>
In-Reply-To: <20191120144756.28424-6-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-6-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:52 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> We have a couple of thermocouple IIO drivers, supporting several chips.
> Some of them support only one specific thermocouple type (e.g. "K", "J"),
> one of them can be configured to work with several different thermocouple
> types.
> 
> In certain applications thermocouples could be externally connected to the
> chip by the user.
> 
> This patch introduces a new IIO standard attribute to report the supported
> thermocouple type and, where applicable, to allow it to be dynamically set
> using sysfs.
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
Applied to the togreg branch of iio.git and pushed out as testing.
Not that I can still rebase for now so any last minute comments
or acks/ reviewed-bys can still be acted on.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 958b5c48a86f..fa2c3b321bfd 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -161,6 +161,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>  	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>  	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
> +	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
>  };
>  
>  /**
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 8e0026da38c9..e6fd3645963c 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -58,6 +58,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_DEBOUNCE_TIME,
>  	IIO_CHAN_INFO_CALIBEMISSIVITY,
>  	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> +	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
>  };
>  
>  #endif /* _IIO_TYPES_H_ */

