Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5632112EA
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jul 2020 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGASmI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jul 2020 14:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgGASmI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Jul 2020 14:42:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B2020748;
        Wed,  1 Jul 2020 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593628926;
        bh=SGzBlv6qFvyDNHfk7aechs86/O7qr6E6QM6Q0HVdS7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eOLnsih+XR6nvj9wm2mPrE03duUQ1rtTdnCPVrM1pnHLXCBNw5HjBVL2xeLmre15K
         0s3F9w6ekTVKqf4lBFj0suigXV7Q/YY8F5MmAFkjwluGsKk6Ibu13QJJdlniUZNGeF
         Hkb0qk79CGkHV41W/aRZykzZdbq4SLTg6r85Qmkw=
Date:   Wed, 1 Jul 2020 19:42:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v4 4/7] iio: core: move debugfs data on the private iio
 dev info
Message-ID: <20200701194200.716a263b@archlinux>
In-Reply-To: <3ad8e37bc439f0619f63010809fb0080b61a1b56.camel@analog.com>
References: <20200630045708.14166-1-alexandru.ardelean@analog.com>
        <20200630045708.14166-5-alexandru.ardelean@analog.com>
        <3ad8e37bc439f0619f63010809fb0080b61a1b56.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 04:58:06 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2020-06-30 at 07:57 +0300, Alexandru Ardelean wrote:
> > This change moves all iio_dev debugfs fields to the iio_dev_priv object.
> > It's not the biggest advantage yet (to the whole thing of
> > abstractization)
> > but it's a start.
> > 
> > The iio_get_debugfs_dentry() function (which is moved in
> > industrialio-core.c) needs to also be guarded against the CONFIG_DEBUG_FS
> > symbol, when it isn't defined. We do want to keep the inline definition
> > in
> > the iio.h header, so that the compiler can better infer when to compile
> > out
> > debugfs code that is related to the IIO debugfs directory.
> >   
> 
> Well, pretty much only this patch changed since V3.
> I thought about maybe re-doing just this patch, then I thought maybe I'd
> get a minor complaint that I should re-send the series.
> 
> Either way, I prefer a complaint on this V4 series-re-send than if I were
> to have re-sent just this patch.

Either way worked.

However this doesn't pass my basic build test. Config condition
is reversed. 

Fixed up and pushed out as testing.


Jonathan

> 
> 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/industrialio-core.c | 46 +++++++++++++++++++++++----------
> >  include/linux/iio/iio-opaque.h  | 10 +++++++
> >  include/linux/iio/iio.h         | 13 +---------
> >  3 files changed, 44 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-
> > core.c
> > index 27005ba4d09c..64174052641a 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -165,6 +165,19 @@ static const char * const iio_chan_info_postfix[] =
> > {
> >  	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> >  };
> >  
> > +#if !defined(CONFIG_DEBUG_FS)

Don't we want this if it is defined.

> > +/**
> > + * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> > + * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is
> > undefined
> > + */
> > +struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
> > +{
> > +	struct iio_dev_opaque *iio_dev_opaque =
> > to_iio_dev_opaque(indio_dev);
> > +	return iio_dev_opaque->debugfs_dentry;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
> > +#endif
> > +
> >  /**
> >   * iio_find_channel_from_si() - get channel from its scan index
> >   * @indio_dev:		device
> > @@ -308,35 +321,37 @@ static ssize_t iio_debugfs_read_reg(struct file
> > *file, char __user *userbuf,
> >  			      size_t count, loff_t *ppos)
> >  {
> >  	struct iio_dev *indio_dev = file->private_data;
> > +	struct iio_dev_opaque *iio_dev_opaque =
> > to_iio_dev_opaque(indio_dev);
> >  	unsigned val = 0;
> >  	int ret;
> >  
> >  	if (*ppos > 0)
> >  		return simple_read_from_buffer(userbuf, count, ppos,
> > -					       indio_dev->read_buf,
> > -					       indio_dev->read_buf_len);
> > +					       iio_dev_opaque->read_buf,
> > +					       iio_dev_opaque-  
> > >read_buf_len);  
> >  
> >  	ret = indio_dev->info->debugfs_reg_access(indio_dev,
> > -						  indio_dev-  
> > >cached_reg_addr,  
> > +						  iio_dev_opaque-  
> > >cached_reg_addr,  
> >  						  0, &val);
> >  	if (ret) {
> >  		dev_err(indio_dev->dev.parent, "%s: read failed\n",
> > __func__);
> >  		return ret;
> >  	}
> >  
> > -	indio_dev->read_buf_len = snprintf(indio_dev->read_buf,
> > -					   sizeof(indio_dev->read_buf),
> > -					   "0x%X\n", val);
> > +	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
> > +					      sizeof(iio_dev_opaque-  
> > >read_buf),  
> > +					      "0x%X\n", val);
> >  
> >  	return simple_read_from_buffer(userbuf, count, ppos,
> > -				       indio_dev->read_buf,
> > -				       indio_dev->read_buf_len);
> > +				       iio_dev_opaque->read_buf,
> > +				       iio_dev_opaque->read_buf_len);
> >  }
> >  
> >  static ssize_t iio_debugfs_write_reg(struct file *file,
> >  		     const char __user *userbuf, size_t count, loff_t
> > *ppos)
> >  {
> >  	struct iio_dev *indio_dev = file->private_data;
> > +	struct iio_dev_opaque *iio_dev_opaque =
> > to_iio_dev_opaque(indio_dev);
> >  	unsigned reg, val;
> >  	char buf[80];
> >  	int ret;
> > @@ -351,10 +366,10 @@ static ssize_t iio_debugfs_write_reg(struct file
> > *file,
> >  
> >  	switch (ret) {
> >  	case 1:
> > -		indio_dev->cached_reg_addr = reg;
> > +		iio_dev_opaque->cached_reg_addr = reg;
> >  		break;
> >  	case 2:
> > -		indio_dev->cached_reg_addr = reg;
> > +		iio_dev_opaque->cached_reg_addr = reg;
> >  		ret = indio_dev->info->debugfs_reg_access(indio_dev, reg,
> >  							  val, NULL);
> >  		if (ret) {
> > @@ -378,23 +393,28 @@ static const struct file_operations
> > iio_debugfs_reg_fops = {
> >  
> >  static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> >  {
> > -	debugfs_remove_recursive(indio_dev->debugfs_dentry);
> > +	struct iio_dev_opaque *iio_dev_opaque =
> > to_iio_dev_opaque(indio_dev);
> > +	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
> >  }
> >  
> >  static void iio_device_register_debugfs(struct iio_dev *indio_dev)
> >  {
> > +	struct iio_dev_opaque *iio_dev_opaque;
> > +
> >  	if (indio_dev->info->debugfs_reg_access == NULL)
> >  		return;
> >  
> >  	if (!iio_debugfs_dentry)
> >  		return;
> >  
> > -	indio_dev->debugfs_dentry =
> > +	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +	iio_dev_opaque->debugfs_dentry =
> >  		debugfs_create_dir(dev_name(&indio_dev->dev),
> >  				   iio_debugfs_dentry);
> >  
> >  	debugfs_create_file("direct_reg_access", 0644,
> > -			    indio_dev->debugfs_dentry, indio_dev,
> > +			    iio_dev_opaque->debugfs_dentry, indio_dev,
> >  			    &iio_debugfs_reg_fops);
> >  }
> >  #else
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-
> > opaque.h
> > index 1375674f14cd..b3f234b4c1e9 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -6,9 +6,19 @@
> >  /**
> >   * struct iio_dev_opaque - industrial I/O device opaque information
> >   * @indio_dev:			public industrial I/O device
> > information
> > + * @debugfs_dentry:		device specific debugfs dentry
> > + * @cached_reg_addr:		cached register address for debugfs reads
> > + * @read_buf:			read buffer to be used for the
> > initial reg read
> > + * @read_buf_len:		data length in @read_buf
> >   */
> >  struct iio_dev_opaque {
> >  	struct iio_dev			indio_dev;
> > +#if defined(CONFIG_DEBUG_FS)
> > +	struct dentry			*debugfs_dentry;
> > +	unsigned			cached_reg_addr;
> > +	char				read_buf[20];
> > +	unsigned int			read_buf_len;
> > +#endif
> >  };
> >  
> >  #define to_iio_dev_opaque(indio_dev)		\
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 86112e35ae5f..bb0aae11a111 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -520,8 +520,6 @@ struct iio_buffer_setup_ops {
> >   * @groups:		[INTERN] attribute groups
> >   * @groupcounter:	[INTERN] index of next attribute group
> >   * @flags:		[INTERN] file ops related flags including busy
> > flag.
> > - * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
> > - * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
> >   * @priv:		[DRIVER] reference to driver's private information
> >   *			**MUST** be accessed **ONLY** via iio_priv() helper
> >   */
> > @@ -567,12 +565,6 @@ struct iio_dev {
> >  	int				groupcounter;
> >  
> >  	unsigned long			flags;
> > -#if defined(CONFIG_DEBUG_FS)
> > -	struct dentry			*debugfs_dentry;
> > -	unsigned			cached_reg_addr;
> > -	char				read_buf[20];
> > -	unsigned int			read_buf_len;
> > -#endif
> >  	void				*priv;
> >  };
> >  
> > @@ -727,10 +719,7 @@ static inline bool iio_buffer_enabled(struct iio_dev
> > *indio_dev)
> >   * @indio_dev:		IIO device structure for device
> >   **/
> >  #if defined(CONFIG_DEBUG_FS)
> > -static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev
> > *indio_dev)
> > -{
> > -	return indio_dev->debugfs_dentry;
> > -}
> > +struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev);
> >  #else
> >  static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev
> > *indio_dev)
> >  {  

