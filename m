Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7F15D8F8
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgBNOGA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbgBNOGA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:06:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD6A2187F;
        Fri, 14 Feb 2020 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581689160;
        bh=nqqK+fKvkLZHnclQOXpb/w6rt8Jru29JAuCrVR2XDRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7ddZMcfzyRyHqqR+RoTuh287BHIPCdwiPuXHTHxU2LUbVssmfOXbMHYhoij09cjN
         ksF9W+fGGAvAF3tb0Xlo8dpcvvqijKuybK5I0IWCsSReullAWAmGyXtctQ4r06Oi4L
         FYbbJ9tQrah8vHpCrP2PuFjrRf3Q0CHXWI4Vq7vg=
Date:   Fri, 14 Feb 2020 14:05:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] iio: amplifiers: ad8366: Add write_raw_get_fmt
 function
Message-ID: <20200214140555.3b732ad4@archlinux>
In-Reply-To: <20200206151149.32122-2-beniamin.bia@analog.com>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
        <20200206151149.32122-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 17:11:46 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> This patch add write_raw_get_fmt function to specify conversion for
> hardware gain.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v5:
> -nothing changed
> 
>  drivers/iio/amplifiers/ad8366.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 0176d3d8cc9c..95972ab60f42 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -180,9 +180,22 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad8366_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return IIO_VAL_INT_PLUS_MICRO_DB;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_info ad8366_info = {
>  	.read_raw = &ad8366_read_raw,
>  	.write_raw = &ad8366_write_raw,
> +	.write_raw_get_fmt = &ad8366_write_raw_get_fmt,
>  };
>  
>  #define AD8366_CHAN(_channel) {				\

