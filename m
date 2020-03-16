Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A3186A4F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 12:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgCPLpX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 07:45:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2561 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729043AbgCPLpX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 07:45:23 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 83B2B9CE06A100C7DF0E;
        Mon, 16 Mar 2020 11:45:20 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Mar 2020 11:45:19 +0000
Received: from localhost (10.47.94.88) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 11:45:19 +0000
Date:   Mon, 16 Mar 2020 11:45:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 1/8] iio: core: drop devm_iio_device_unregister() API
 call
Message-ID: <20200316114518.00005440@Huawei.com>
In-Reply-To: <9a18cedd0e537927aad27001dfc5e8845d302e46.camel@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <9a18cedd0e537927aad27001dfc5e8845d302e46.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.88]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 09:09:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2020-02-27 at 15:52 +0200, Alexandru Ardelean wrote:
> > It's unused so far, so it can't be removed. Also makes sense to remove it
> > to discourage weird uses of this call during review.  
> 
> Any thoughts on this?
> I suspect that this may be one of those "I'd like to sit on this for a while"
> patchsets?
> Which is fine.

Got it in one.   It's both extremely simple and extremely likely to break
someones out of tree driver.  I guessing all the ADI ones are fine though :)

> But I'm also wondering if this got omitted.

Wise to check, it wouldn't be the first time I'd lost a whole
series.

Thanks,

Jonathan



> 
> Thanks
> Alex
> 
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  .../driver-api/driver-model/devres.rst          |  1 -
> >  drivers/iio/industrialio-core.c                 | 17 -----------------
> >  include/linux/iio/iio.h                         |  4 ----
> >  3 files changed, 22 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/driver-model/devres.rst
> > b/Documentation/driver-api/driver-model/devres.rst
> > index 46c13780994c..0580c64ebdfd 100644
> > --- a/Documentation/driver-api/driver-model/devres.rst
> > +++ b/Documentation/driver-api/driver-model/devres.rst
> > @@ -286,7 +286,6 @@ IIO
> >    devm_iio_device_alloc()
> >    devm_iio_device_free()
> >    devm_iio_device_register()
> > -  devm_iio_device_unregister()
> >    devm_iio_kfifo_allocate()
> >    devm_iio_kfifo_free()
> >    devm_iio_triggered_buffer_setup()
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 0b14666dff09..e4011f8431f9 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1823,23 +1823,6 @@ int __devm_iio_device_register(struct device *dev,
> > struct iio_dev *indio_dev,
> >  }
> >  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
> >  
> > -/**
> > - * devm_iio_device_unregister - Resource-managed iio_device_unregister()
> > - * @dev:	Device this iio_dev belongs to
> > - * @indio_dev:	the iio_dev associated with the device
> > - *
> > - * Unregister iio_dev registered with devm_iio_device_register().
> > - */
> > -void devm_iio_device_unregister(struct device *dev, struct iio_dev
> > *indio_dev)
> > -{
> > -	int rc;
> > -
> > -	rc = devres_release(dev, devm_iio_device_unreg,
> > -			    devm_iio_device_match, indio_dev);
> > -	WARN_ON(rc);
> > -}
> > -EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
> > -
> >  /**
> >   * iio_device_claim_direct_mode - Keep device in direct mode
> >   * @indio_dev:	the iio_dev associated with the device
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 862ce0019eba..0eb9e8d7ec68 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -591,9 +591,6 @@ void iio_device_unregister(struct iio_dev *indio_dev);
> >   * calls iio_device_register() internally. Refer to that function for more
> >   * information.
> >   *
> > - * If an iio_dev registered with this function needs to be unregistered
> > - * separately, devm_iio_device_unregister() must be used.
> > - *
> >   * RETURNS:
> >   * 0 on success, negative error number on failure.
> >   */
> > @@ -601,7 +598,6 @@ void iio_device_unregister(struct iio_dev *indio_dev);
> >  	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
> >  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> >  			       struct module *this_mod);
> > -void devm_iio_device_unregister(struct device *dev, struct iio_dev
> > *indio_dev);
> >  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> >  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> >  void iio_device_release_direct_mode(struct iio_dev *indio_dev);  


