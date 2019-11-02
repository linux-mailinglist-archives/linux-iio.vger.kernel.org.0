Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB1ECF14
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2019 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfKBOIX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Nov 2019 10:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfKBOIW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Nov 2019 10:08:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 432ED2080F;
        Sat,  2 Nov 2019 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572703701;
        bh=zkVv+PBe+dPr9yU5idGOMLaRVmsI1rFpcWxNjSshYZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jY8Zv6GzOBEEsHYV4KOIBoMDK6g0/dT5KGAR/SLnmK7ycjawJlv1qF4drLSOFDtWg
         p57B8XjFFe7N3ouqRlfrx5a5hwFFZZzKyd71iIqBTOYuRomxU2Hx/iRsGnlhU8DRh7
         Xalg355+OiAJYHwGcecz496eevqO+HzjjE/iGH/Y=
Date:   Sat, 2 Nov 2019 14:08:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, denis.ciocca@st.com,
        rfontana@redhat.com, tglx@linutronix.de, heiko.stuebner@bq.com,
        rjones@gateworks.com, drake@endlessm.com, colin.king@canonical.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iio: st_accel: Fix unused variable warning
Message-ID: <20191102140810.3d756294@archlinux>
In-Reply-To: <20191102104125.GA22015@lenoch>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
        <20191102104125.GA22015@lenoch>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2 Nov 2019 11:41:25 +0100
Ladislav Michl <ladis@linux-mips.org> wrote:

> On Fri, Nov 01, 2019 at 09:47:41PM +0800, YueHaibing wrote:
> > drivers/iio/accel/st_accel_core.c:1005:44: warning:
> >  mount_matrix_ext_info defined but not used [-Wunused-const-variable=]
> > 
> > Move it to ifdef to mute this warning.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/iio/accel/st_accel_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> > index 2e37f8a..bba0717 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -1002,10 +1002,12 @@ get_mount_matrix(const struct iio_dev *indio_dev,
> >  	return adata->mount_matrix;
> >  }
> >  
> > +#ifdef CONFIG_ACPI
> >  static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> >  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),  
> 
> So now you do not get any warning for unused get_mount_matrix?
> (Then it would make more sense to put all that stuff under one ifdef
> and provide empty apply_acpi_orientation for non ACPI case)

Does the __maybe_unused marking make this go away?

I'd assume that the compiler will manage to drop this either way
but I guess we should check that.

ifdef magic is always harder to read and potentially fragile in the
long run.  Here we simply want to indicate that in some build
configurations we might not use this.

Thanks,

Jonathan


> 
> >  	{ },
> >  };
> > +#endif
> >  
> >  /* Read ST-specific _ONT orientation data from ACPI and generate an
> >   * appropriate mount matrix.
> > -- 
> > 2.7.4
> >   

