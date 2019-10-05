Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB3CCAA8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfJEO7M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfJEO7M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:59:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC8E20862;
        Sat,  5 Oct 2019 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570287551;
        bh=kUtKNxagIQzys5EiEB0gL8TZR3nX7HBQAeI0f4mFzfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eJyPHbNl1bj142Egz0Cgl21skCOVluW1hWKwhtEHTj3E2PIPqesJIw3jWQAHMeR8b
         NbOe6YkQld+cPxR4stZgKfHLlWwKvtpim2RfGkYYzF3wuSCZmauGs6snsuzh4tWLzB
         rlLFLIT1QgzrijIXE1yD06orMgXx1uiHcBM4ozAk=
Date:   Sat, 5 Oct 2019 15:59:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH v2 2/2] iio: core: Add optional symbolic label to device
 attributes
Message-ID: <20191005155905.7fe1681e@archlinux>
In-Reply-To: <1568903768-65998-3-git-send-email-preid@electromag.com.au>
References: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
        <1568903768-65998-3-git-send-email-preid@electromag.com.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Sep 2019 22:36:08 +0800
Phil Reid <preid@electromag.com.au> wrote:

> If a label is defined in the device tree for this device add that
> to the device specific attributes. This is useful for userspace to
> be able to identify an individual device when multiple identical
> chips are present in the system.
> 
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Glad to see this going in given I thought I'd already applied it
and told someone they should be using it early today (oops ;)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks for doing this.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 17 +++++++++++++++++
>  include/linux/iio/iio.h         |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 524a686077ca..f72c2dc5f703 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1238,6 +1238,16 @@ static ssize_t iio_show_dev_name(struct device *dev,
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
> @@ -1354,6 +1364,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  
>  	if (indio_dev->name)
>  		attrcount++;
> +	if (indio_dev->label)
> +		attrcount++;
>  	if (clk)
>  		attrcount++;
>  
> @@ -1376,6 +1388,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
>  	if (indio_dev->name)
>  		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
> +	if (indio_dev->label)
> +		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
>  	if (clk)
>  		indio_dev->chan_attr_group.attrs[attrn++] = clk;
>  
> @@ -1647,6 +1661,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
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
> index 8e132cf819e4..a2527c7ab934 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -553,6 +553,7 @@ struct iio_dev {
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
>  	const char			*name;
> +	const char			*label;
>  	const struct iio_info		*info;
>  	clockid_t			clock_id;
>  	struct mutex			info_exist_lock;

