Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E41298A2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLWQWL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:22:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQWK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:22:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A4420663;
        Mon, 23 Dec 2019 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118130;
        bh=WFDx3A5JXRkzlwftDz8veXXcudWbr5CPPMiBKYIN/r0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hIESep0li+SwbPtjxpu1cqEUjwvHAvB0WkTh4jWfV4uRUTuPDplHXx2j5Riq+Gm6D
         8S98YBepV+q7J/ITVS7bxnL1LkY7caUTAmVy24mfAPV/EK2+flj8nhwOtFyoaJktOJ
         uSXUtJqmMa1HtPLBsaCwOT85/0OACeu802Zs+IaE=
Date:   Mon, 23 Dec 2019 16:22:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 7/9] iio: st_sensors: Describe function parameters in
 kernel-doc
Message-ID: <20191223162206.62e5b3d5@archlinux>
In-Reply-To: <20191216173853.75797-7-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-7-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 19:38:51 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Kernel documentation script complains that some of the function parameters
> are not described:
> 
> .../common/st_sensors/st_sensors_trigger.c:29: warning: Function parameter or member 'indio_dev' not described in 'st_sensors_new_samples_available'
> .../common/st_sensors/st_sensors_trigger.c:29: warning: Function parameter or member 'sdata' not described in 'st_sensors_new_samples_available'
> 
> Describe function parameters where it's appropriate.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 4a2efa00f7f2..e817537cdfb5 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -19,6 +19,9 @@
>  
>  /**
>   * st_sensors_new_samples_available() - check if more samples came in
> + * @indio_dev: IIO device reference.
> + * @sdata: Sensor data.
> + *
>   * returns:
>   * 0 - no new samples available
>   * 1 - new samples available

