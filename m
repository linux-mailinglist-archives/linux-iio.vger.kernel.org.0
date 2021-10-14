Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB38842E01D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhJNRg3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhJNRg3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Oct 2021 13:36:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6458F610F8;
        Thu, 14 Oct 2021 17:34:22 +0000 (UTC)
Date:   Thu, 14 Oct 2021 18:38:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        ddvlad@gmail.com
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in
 probe and remove
Message-ID: <20211014183833.70b49732@jic23-huawei>
In-Reply-To: <1a3a5582-51b0-4c58-ad6a-a58025054128@redhat.com>
References: <20211014035338.3750416-1-yangyingliang@huawei.com>
        <1a3a5582-51b0-4c58-ad6a-a58025054128@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Oct 2021 10:20:34 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 10/14/21 5:53 AM, Yang Yingliang wrote:
> > When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
> > memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
> > memory leak as follows:
> > 
> > unreferenced object 0xffff888009551400 (size 512):
> >   comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
> >   hex dump (first 32 bytes):
> >     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
> >   backtrace:
> >     [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
> >     [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
> >     [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
> >     [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]
> >     [<0000000020115b9a>] i2c_device_probe+0xa31/0xbe0
> >     [<00000000d9f581a6>] really_probe+0x299/0xc30
> >     [<00000000c6c16cde>] __driver_probe_device+0x357/0x500
> >     [<00000000909852a1>] driver_probe_device+0x4e/0x140
> >     [<000000008419ba53>] __device_attach_driver+0x257/0x340
> >     [<00000000533bb466>] bus_for_each_drv+0x166/0x1e0
> >     [<000000005bf45d75>] __device_attach+0x272/0x420
> >     [<0000000075220311>] bus_probe_device+0x1eb/0x2a0
> >     [<0000000015587e85>] device_add+0xbf0/0x1f90
> >     [<0000000086901b9e>] i2c_new_client_device+0x622/0xb20
> >     [<000000000865ca18>] new_device_store+0x1fa/0x420
> >     [<0000000059a3d183>] dev_attr_store+0x58/0x80
> > 
> > Fix it by remove data->dready_trig condition in probe and remove.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: a25691c1f967 ("iio: accel: kxcjk1013: allow using an external trigger")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>  
> 
> Hmm, wouldn't the right fix be to also move the
> iio_triggered_buffer_setup() call to inside the:
> 
> 	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
> 	}
> 
> block ?
> 
> Jonathan (jic23) can you take a look at this, to me it seems that having
> a triggered buffer allocated without any triggers is not useful ?

It can use another trigger not supplied by this particular device.
e.g. sysfs or hrtimer trigger.  This is common for cases where
we may or may not have an irq wired and the validate_* callbacks are
not provided (which would indicate we had to use the device's own trigger).

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> >  drivers/iio/accel/kxcjk-1013.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index a51fdd3c9b5b..24c9387c2968 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1595,8 +1595,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >  	return 0;
> >  
> >  err_buffer_cleanup:
> > -	if (data->dready_trig)
> > -		iio_triggered_buffer_cleanup(indio_dev);
> > +	iio_triggered_buffer_cleanup(indio_dev);
> >  err_trigger_unregister:
> >  	if (data->dready_trig)
> >  		iio_trigger_unregister(data->dready_trig);
> > @@ -1618,8 +1617,8 @@ static int kxcjk1013_remove(struct i2c_client *client)
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> >  
> > +	iio_triggered_buffer_cleanup(indio_dev);
> >  	if (data->dready_trig) {
> > -		iio_triggered_buffer_cleanup(indio_dev);
> >  		iio_trigger_unregister(data->dready_trig);
> >  		iio_trigger_unregister(data->motion_trig);
> >  	}
> >   
> 

