Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69BF5ED2
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfKILuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 06:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfKILuv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 06:50:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9E3207FF;
        Sat,  9 Nov 2019 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573300249;
        bh=xMRSKGT5d8qThte8tg4IRWizWryRM89c5Thx1yuW1nQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kl2ydG/OIdj/3jPQyzx6+Dp9X/KUnKJ9X73owi3iaZ7QD5E5bznjpvGwg+czpNQuP
         3uasxhoVs6zzOKUMCWp382oNnNPMKQh4rFDeZRrIR2+8WtS04fE0NK7iEV8iPfVx8s
         osiQkCn5nReSRCjpRLA/iVLEceN78is4pozw25q8=
Date:   Sat, 9 Nov 2019 11:50:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Ladislav Michl <ladis@linux-mips.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <denis.ciocca@st.com>,
        <rfontana@redhat.com>, <tglx@linutronix.de>,
        <heiko.stuebner@bq.com>, <rjones@gateworks.com>,
        <drake@endlessm.com>, <colin.king@canonical.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] iio: st_accel: Fix unused variable warning
Message-ID: <20191109115043.35df2aac@archlinux>
In-Reply-To: <4a6c8c31-360b-1cf2-7d6c-8426199637f0@huawei.com>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
        <20191102104125.GA22015@lenoch>
        <20191102140810.3d756294@archlinux>
        <20191102201535.GA30346@lenoch>
        <4a6c8c31-360b-1cf2-7d6c-8426199637f0@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 09:29:21 +0800
Yuehaibing <yuehaibing@huawei.com> wrote:

> On 2019/11/3 4:15, Ladislav Michl wrote:
> > On Sat, Nov 02, 2019 at 02:08:10PM +0000, Jonathan Cameron wrote:  
> >> On Sat, 2 Nov 2019 11:41:25 +0100
> >> Ladislav Michl <ladis@linux-mips.org> wrote:
> >>  
> >>> On Fri, Nov 01, 2019 at 09:47:41PM +0800, YueHaibing wrote:  
> >>>> drivers/iio/accel/st_accel_core.c:1005:44: warning:
> >>>>  mount_matrix_ext_info defined but not used [-Wunused-const-variable=]
> >>>>
> >>>> Move it to ifdef to mute this warning.
> >>>>
> >>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >>>> ---
> >>>>  drivers/iio/accel/st_accel_core.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> >>>> index 2e37f8a..bba0717 100644
> >>>> --- a/drivers/iio/accel/st_accel_core.c
> >>>> +++ b/drivers/iio/accel/st_accel_core.c
> >>>> @@ -1002,10 +1002,12 @@ get_mount_matrix(const struct iio_dev *indio_dev,
> >>>>  	return adata->mount_matrix;
> >>>>  }
> >>>>  
> >>>> +#ifdef CONFIG_ACPI
> >>>>  static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> >>>>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),    
> >>>
> >>> So now you do not get any warning for unused get_mount_matrix?
> >>> (Then it would make more sense to put all that stuff under one ifdef
> >>> and provide empty apply_acpi_orientation for non ACPI case)  
> >>
> >> Does the __maybe_unused marking make this go away?
> >>
> >> I'd assume that the compiler will manage to drop this either way
> >> but I guess we should check that.
> >>
> >> ifdef magic is always harder to read and potentially fragile in the
> >> long run.  Here we simply want to indicate that in some build
> >> configurations we might not use this.  
> > 
> > This suggestion implies we'll get rid of CONFIG_ACPI completely, which
> > seems inapproriate looking at size of apply_acpi_orientation function.
> > And having both CONFIG_ACPI and __maybe_unused does not make much
> > sense. I had something like that in mind (+COMPILE_TEST perhaps):
> > 
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> > index 2e37f8a6d8cf..0e7eac62d618 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -993,6 +993,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
> >  #define ST_ACCEL_TRIGGER_OPS NULL
> >  #endif
> >  
> > +#ifdef CONFIG_ACPI
> >  static const struct iio_mount_matrix *
> >  get_mount_matrix(const struct iio_dev *indio_dev,
> >  		 const struct iio_chan_spec *chan)
> > @@ -1013,7 +1014,6 @@ static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> >  static int apply_acpi_orientation(struct iio_dev *indio_dev,
> >  				  struct iio_chan_spec *channels)
> >  {
> > -#ifdef CONFIG_ACPI
> >  	struct st_sensor_data *adata = iio_priv(indio_dev);
> >  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> >  	struct acpi_device *adev;
> > @@ -1141,10 +1141,14 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
> >  out:
> >  	kfree(buffer.pointer);
> >  	return ret;
> > -#else /* !CONFIG_ACPI */
> > +}
> > +#else
> > +static int apply_acpi_orientation(struct iio_dev *indio_dev,  
> 
> Does this need inline?

Not that I can see. It's in the c file not the header so there should
be no issue with letting the compiler make the decision.
It will almost certainly be optimized out anyway.

Thanks,

Jonathan


> 
> > +				  struct iio_chan_spec *channels)
> > +{
> >  	return 0;
> > -#endif
> >  }
> > +#endif
> >  
> >  /*
> >   * st_accel_get_settings() - get sensor settings from device name  
> >> Thanks,
> >>
> >> Jonathan
> >>
> >>  
> >>>  
> >>>>  	{ },
> >>>>  };
> >>>> +#endif
> >>>>  
> >>>>  /* Read ST-specific _ONT orientation data from ACPI and generate an
> >>>>   * appropriate mount matrix.
> >>>> -- 
> >>>> 2.7.4
> >>>>     
> > 
> > .
> >   
> 

