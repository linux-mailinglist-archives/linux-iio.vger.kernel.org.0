Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C92761B5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWUMy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIWUMy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:12:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC462376F;
        Wed, 23 Sep 2020 20:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600891973;
        bh=VJzs768qwtne0ag6eBSnLTLairbiPmRxCP3NJf33P38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Muw91GTHz4jKR1dgKCs7wW12xT6J4ZUBo4KFsulNSSJADll542/uGLu/+bIU2bbC6
         lTNtqZ++0F4DghhlN6gM7epQ9CEYQdVfuApJeDyTx3I2euP0mX9u4h3C6lsV7OV0cG
         aJ/RqGYAs8+xQQt7O0Na5fa+437aD+EBvitS6XwQ=
Date:   Wed, 23 Sep 2020 21:12:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] iio: event: use short-hand variable in
 iio_device_{un}register_eventset functions
Message-ID: <20200923211249.164241d0@archlinux>
In-Reply-To: <20200921103156.194748-1-alexandru.ardelean@analog.com>
References: <20200921103156.194748-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 13:31:55 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> With the recent 'iio_dev_opaque' variable name, these two functions are
> looking a bit ugly.
> 
> This change uses an 'ev_int' variable for the
> iio_device_{un}register_eventset functions to make the code a little easier
> to read.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Seems sensible.  Series applied to the togreg branch of iio.git and pushed out as
testing.  Not sure if this will make it into a final pull request for this
cycle or not. Kind of depends what Linus says on Sunday about whether we are
going to see an rc8.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * move 'iio_dev_opaque->event_interface = ev_int;' assigment right after
>   allocation to avoid crash; 'iio_dev_opaque->event_interface' is accessed
>   after init
> 
>  drivers/iio/industrialio-event.c | 50 +++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 2ab4d4c44427..a85919eb7c4a 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -477,6 +477,7 @@ static const char *iio_event_group_name = "events";
>  int iio_device_register_eventset(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int;
>  	struct iio_dev_attr *p;
>  	int ret = 0, attrcount_orig = 0, attrcount, attrn;
>  	struct attribute **attr;
> @@ -485,14 +486,15 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  	      iio_check_for_dynamic_events(indio_dev)))
>  		return 0;
>  
> -	iio_dev_opaque->event_interface =
> -		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> -	if (iio_dev_opaque->event_interface == NULL)
> +	ev_int = kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> +	if (ev_int == NULL)
>  		return -ENOMEM;
>  
> -	INIT_LIST_HEAD(&iio_dev_opaque->event_interface->dev_attr_list);
> +	iio_dev_opaque->event_interface = ev_int;
> +
> +	INIT_LIST_HEAD(&ev_int->dev_attr_list);
>  
> -	iio_setup_ev_int(iio_dev_opaque->event_interface);
> +	iio_setup_ev_int(ev_int);
>  	if (indio_dev->info->event_attrs != NULL) {
>  		attr = indio_dev->info->event_attrs->attrs;
>  		while (*attr++ != NULL)
> @@ -506,34 +508,29 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  		attrcount += ret;
>  	}
>  
> -	iio_dev_opaque->event_interface->group.name = iio_event_group_name;
> -	iio_dev_opaque->event_interface->group.attrs = kcalloc(attrcount + 1,
> -							  sizeof(iio_dev_opaque->event_interface->group.attrs[0]),
> -							  GFP_KERNEL);
> -	if (iio_dev_opaque->event_interface->group.attrs == NULL) {
> +	ev_int->group.name = iio_event_group_name;
> +	ev_int->group.attrs = kcalloc(attrcount + 1,
> +				      sizeof(ev_int->group.attrs[0]),
> +				      GFP_KERNEL);
> +	if (ev_int->group.attrs == NULL) {
>  		ret = -ENOMEM;
>  		goto error_free_setup_event_lines;
>  	}
>  	if (indio_dev->info->event_attrs)
> -		memcpy(iio_dev_opaque->event_interface->group.attrs,
> +		memcpy(ev_int->group.attrs,
>  		       indio_dev->info->event_attrs->attrs,
> -		       sizeof(iio_dev_opaque->event_interface->group.attrs[0])
> -		       *attrcount_orig);
> +		       sizeof(ev_int->group.attrs[0]) * attrcount_orig);
>  	attrn = attrcount_orig;
>  	/* Add all elements from the list. */
> -	list_for_each_entry(p,
> -			    &iio_dev_opaque->event_interface->dev_attr_list,
> -			    l)
> -		iio_dev_opaque->event_interface->group.attrs[attrn++] =
> -			&p->dev_attr.attr;
> -	indio_dev->groups[indio_dev->groupcounter++] =
> -		&iio_dev_opaque->event_interface->group;
> +	list_for_each_entry(p, &ev_int->dev_attr_list, l)
> +		ev_int->group.attrs[attrn++] = &p->dev_attr.attr;
> +	indio_dev->groups[indio_dev->groupcounter++] = &ev_int->group;
>  
>  	return 0;
>  
>  error_free_setup_event_lines:
> -	iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> -	kfree(iio_dev_opaque->event_interface);
> +	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> +	kfree(ev_int);
>  	iio_dev_opaque->event_interface = NULL;
>  	return ret;
>  }
> @@ -557,10 +554,11 @@ void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
>  void iio_device_unregister_eventset(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
>  
> -	if (iio_dev_opaque->event_interface == NULL)
> +	if (ev_int == NULL)
>  		return;
> -	iio_free_chan_devattr_list(&iio_dev_opaque->event_interface->dev_attr_list);
> -	kfree(iio_dev_opaque->event_interface->group.attrs);
> -	kfree(iio_dev_opaque->event_interface);
> +	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
> +	kfree(ev_int->group.attrs);
> +	kfree(ev_int);
>  }

