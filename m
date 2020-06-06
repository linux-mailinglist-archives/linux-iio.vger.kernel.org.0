Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5F1F06F0
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgFFOYf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 10:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFFOYe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 10:24:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA542073E;
        Sat,  6 Jun 2020 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591453474;
        bh=Y1/f4/nH+s0u6ptB+tYdwkbkOTRyoRPPpr6YE9YAX3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hM7y9iEb5U9FrzWlhkUeD//h9AnHYCC/ixU4SWQUKrdCAIAkIkp710KGoUXDhTOg9
         OyK7DbIST6Q8v8xYsSvr8X70byJCupLNGq+RVDKYT/RhYfWBW1UlwzEfAoYto8og9p
         Bxi3/KY6XXRt3WyXbsHpVLPVqiPtUsIhZDJ8NC+Q=
Date:   Sat, 6 Jun 2020 15:24:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: make iio_device_get_drvdata take a const struct
 iio_dev *.
Message-ID: <20200606152430.023c9ef6@archlinux>
In-Reply-To: <SA0PR12MB44290C81C03F7DAEE315DBFBC48B0@SA0PR12MB4429.namprd12.prod.outlook.com>
References: <20200521175322.247947-1-jic23@kernel.org>
        <SA0PR12MB44290C81C03F7DAEE315DBFBC48B0@SA0PR12MB4429.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Jun 2020 07:39:52 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> simple and perfect.
> 
> Thanks,
> JB
> 
> Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied.


Thanks,

Jonathan

> 
> ________________________________
> From: jic23@kernel.org <jic23@kernel.org>
> Sent: Thursday, May 21, 2020 19:53
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Subject: [PATCH] iio: make iio_device_get_drvdata take a const struct iio_dev *.
> 
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As this just calls dev_get_drvdata underneath which is happy with
> a const struct device * we should change and avoid potentially
> casting away a const in order to then put it back again.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a1be82e74c93..e846a0a7001e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -669,7 +669,7 @@ static inline void iio_device_set_drvdata(struct iio_dev *indio_dev, void *data)
>   *
>   * Returns the data previously set with iio_device_set_drvdata()
>   */
> -static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)
> +static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>  {
>          return dev_get_drvdata(&indio_dev->dev);
>  }
> --
> 2.26.2
> 

