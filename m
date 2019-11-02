Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9190EECE12
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2019 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfKBKlb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Nov 2019 06:41:31 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:60982 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKBKla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Nov 2019 06:41:30 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990406AbfKBKl1kwUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Sat, 2 Nov 2019 11:41:27 +0100
Date:   Sat, 2 Nov 2019 11:41:25 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, denis.ciocca@st.com, rfontana@redhat.com,
        tglx@linutronix.de, heiko.stuebner@bq.com, rjones@gateworks.com,
        drake@endlessm.com, colin.king@canonical.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iio: st_accel: Fix unused variable warning
Message-ID: <20191102104125.GA22015@lenoch>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101134741.25108-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 01, 2019 at 09:47:41PM +0800, YueHaibing wrote:
> drivers/iio/accel/st_accel_core.c:1005:44: warning:
>  mount_matrix_ext_info defined but not used [-Wunused-const-variable=]
> 
> Move it to ifdef to mute this warning.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iio/accel/st_accel_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 2e37f8a..bba0717 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1002,10 +1002,12 @@ get_mount_matrix(const struct iio_dev *indio_dev,
>  	return adata->mount_matrix;
>  }
>  
> +#ifdef CONFIG_ACPI
>  static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),

So now you do not get any warning for unused get_mount_matrix?
(Then it would make more sense to put all that stuff under one ifdef
and provide empty apply_acpi_orientation for non ACPI case)

>  	{ },
>  };
> +#endif
>  
>  /* Read ST-specific _ONT orientation data from ACPI and generate an
>   * appropriate mount matrix.
> -- 
> 2.7.4
> 
