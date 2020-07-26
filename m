Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F522DF1E
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgGZMnI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgGZMnH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:43:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F9B2076A;
        Sun, 26 Jul 2020 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595767387;
        bh=rD1nqH0BQds6In7swJllLJX+GDj9Q+kPi3fN2kFuZg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSaFUNV/4NLoHCg1VodFMbHzZKRFNJ8jqhFlOQEO5M8+Zzs4o9MdrZKnoFbd7j5Ng
         Tp76SmsyRvOaQFTy8bXfK3M6jyjApUnHqf8WxmHYgtvyDqqdwSqN7KHATmljMpReFZ
         I6hpv13/ZeOOtA8NmbJCTeCFFyhQqN7pfQzzGAmU=
Date:   Sun, 26 Jul 2020 13:43:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: trigger: make stub functions static inline
Message-ID: <20200726134303.35c01f07@archlinux>
In-Reply-To: <20200720135133.72154-1-alexandru.ardelean@analog.com>
References: <20200714142456.67054-1-alexandru.ardelean@analog.com>
        <20200720135133.72154-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jul 2020 16:51:33 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Make sure that the trigger function stubs are all static inline.
> Otherwise we might see compiler warnings about declared but unused
> functions.
> 
> Fixes 77712e5fbe2e4: ("Staging: iio: Staticise non-exported functions")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
As it's only warning suppression I'm not going to rush this one.

applied to the togreg branch of iio.git

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * fix commit description & title
> * added proper Fixes tag
> 
>  drivers/iio/iio_core_trigger.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
> index 9d1a92cc6480..374816bc3e73 100644
> --- a/drivers/iio/iio_core_trigger.h
> +++ b/drivers/iio/iio_core_trigger.h
> @@ -30,7 +30,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>   * iio_device_register_trigger_consumer() - set up an iio_dev to use triggers
>   * @indio_dev: iio_dev associated with the device that will consume the trigger
>   **/
> -static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
> +static inline int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>  {
>  	return 0;
>  }
> @@ -39,7 +39,7 @@ static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>   * iio_device_unregister_trigger_consumer() - reverse the registration process
>   * @indio_dev: iio_dev associated with the device that consumed the trigger
>   **/
> -static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
> +static inline void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
>  {
>  }
>  

