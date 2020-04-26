Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2661B8ED2
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDZK2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 06:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgDZK2z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 06:28:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 316E0206B6;
        Sun, 26 Apr 2020 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587896934;
        bh=pn5qHg+Pn44zc/IxGMp8ZLIkBtQLw6+PAtpwlocbLF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YgD3/h4WC3J4acQyimUkxzGdYUHVcmqK9SZDPUOM6+Csq+N7XM2Zq4DM/KPLNNfjP
         tPfkR6JlaUuVwAQQD37Vqh+SCwQCJgkSXoJ9+3cJZu+2IRcjrwxOAXUMMK+bn42dYk
         O9bMe267usJ5sarWZ1uRSpKWB/lXby8jzaAldggI=
Date:   Sun, 26 Apr 2020 11:28:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 3/4] iio: Allow channels to share storage elements
Message-ID: <20200426112851.65001a89@archlinux>
In-Reply-To: <20200424051818.6408-4-alexandru.ardelean@analog.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
        <20200424051818.6408-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 08:18:17 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Currently each IIO channel has it's own storage element in the data stream
> each with its own unique scan index. This works for a lot of use-cases,
> but in some is not good enough to represent the hardware accurately. On
> those devices multiple separate pieces of information are stored within the
> same storage element and the storage element can't be further broken down
> into multiple storage elements (e.g. because the data is not aligned).
> 
> This can for example be status bits stored in unused data bits. E.g. a
> 14-bit ADC that stores its data in a 16-bit word and uses the two
> additional bits to convey status information like for example whether a
> overrange condition has happened. Currently this kind of extra status
> information is usually ignored and can only be used by applications that
> have special knowledge about the connected device and its data layout.

Hmm. The problem with this (and the reason I have resisted this in the past)
is that this fundamentally breaks the existing ABI.  Whilst we have never
explicitly stated that this can't be done (I think) a lot of code may
assume it.

Are we sure this doesn't break existing userspace in weird and wonderful
ways?   I'm sure someone does stuff 'in place' on the incoming data
streams for example which this would break.

Also does the demux work with these if we have multiple consumers?  Seems
unlikely that it will do it efficiently if at all.

J
> 
> In addition to that some might also have data channels with less than 8
> bits that get packed into the same storage element.
> 
> Allow two or more channels to use the same scan index, if they their
> storage element does have the same size.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f4daf19f2a3b..cdf59a51c917 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1651,6 +1651,16 @@ static const struct file_operations iio_buffer_fileops = {
>  	.compat_ioctl = compat_ptr_ioctl,
>  };
>  
> +static bool iio_chan_same_size(const struct iio_chan_spec *a,
> +	const struct iio_chan_spec *b)
> +{
> +	if (a->scan_type.storagebits != b->scan_type.storagebits)
> +		return false;
> +	if (a->scan_type.repeat != b->scan_type.repeat)
> +		return false;
> +	return true;
> +}
> +
>  static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  {
>  	int i, j;
> @@ -1662,13 +1672,16 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  	for (i = 0; i < indio_dev->num_channels - 1; i++) {
>  		if (channels[i].scan_index < 0)
>  			continue;
> -		for (j = i + 1; j < indio_dev->num_channels; j++)
> -			if (channels[i].scan_index == channels[j].scan_index) {
> -				dev_err(&indio_dev->dev,
> -					"Duplicate scan index %d\n",
> -					channels[i].scan_index);
> -				return -EINVAL;
> -			}
> +		for (j = i + 1; j < indio_dev->num_channels; j++) {
> +			if (channels[i].scan_index != channels[j].scan_index)
> +				continue;
> +			if (iio_chan_same_size(&channels[i], &channels[j]))
> +				continue;
> +			dev_err(&indio_dev->dev,
> +				"Duplicate scan index %d\n",
> +				channels[i].scan_index);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	return 0;

