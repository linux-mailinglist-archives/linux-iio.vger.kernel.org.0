Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C7AACC9E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfIHMRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfIHMRP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:17:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889F8214D9;
        Sun,  8 Sep 2019 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567945034;
        bh=7ehaco2qzcBECkdVLE2Bi7N2WkovW0gj5P42IUx3Jtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JabEnJUuErW6vZATsqdg5uUeR37WLWxsIttn0aW3AyoK/+2OCFkKln9WeMqFHaw69
         6FBEh0rqsff1I5pU44mTS9yOzEqX5rSJB9xBOHL5kbxabHaT++RvvxnelM7iCuLh9x
         fBy6Hca+lCNyxtzLUnGCdKa8PVNrBnwm2kb4WD7o=
Date:   Sun, 8 Sep 2019 13:17:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH 2/2] iio: core: Add optional symbolic label to device
 attributes
Message-ID: <20190908131708.79bfbc60@archlinux>
In-Reply-To: <1566876924-63608-3-git-send-email-preid@electromag.com.au>
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
        <1566876924-63608-3-git-send-email-preid@electromag.com.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Aug 2019 11:35:24 +0800
Phil Reid <preid@electromag.com.au> wrote:

> If a label is defined in the device tree for this device add that
> to the device specific attributes. This is useful for userspace to
> be able to identify an individual device when multiple identical
> chips are present in the system.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Looks good to me.  I like this as it finally gets us around some
perhaps slightly dubious decisions I made about the name attribute
a long time ago and the bunch of uses that don't actually conform
even to what I had in mind back then.

I'll pick it up for the 5.5 cycle once you've respun to give
more example friendly names in patch 1 and Rob is happy with it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 17 +++++++++++++++++
>  include/linux/iio/iio.h         |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8303639963d7..2d7fb7629095 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1300,6 +1300,16 @@ static ssize_t iio_show_dev_name(struct device *dev,
>  
>  static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
>  
> +static ssize_t iio_show_dev_label(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->label);
> +}
> +
> +static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> +
>  static ssize_t iio_show_timestamp_clock(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -1416,6 +1426,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  
>  	if (indio_dev->name)
>  		attrcount++;
> +	if (indio_dev->label)
> +		attrcount++;
>  	if (clk)
>  		attrcount++;
>  
> @@ -1438,6 +1450,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
>  	if (indio_dev->name)
>  		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
> +	if (indio_dev->label)
> +		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
>  	if (clk)
>  		indio_dev->chan_attr_group.attrs[attrn++] = clk;
>  
> @@ -1709,6 +1723,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>  		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>  
> +	indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
> +					   NULL);
> +
>  	ret = iio_check_unique_scan_index(indio_dev);
>  	if (ret < 0)
>  		return ret;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a74cb177dc6f..3f89db50d3f6 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -556,6 +556,7 @@ struct iio_dev {
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
>  	const char			*name;
> +	const char			*label;
>  	const struct iio_info		*info;
>  	clockid_t			clock_id;
>  	struct mutex			info_exist_lock;

