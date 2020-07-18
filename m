Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF5224CFD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGRQZG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgGRQZF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:25:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A9E20734;
        Sat, 18 Jul 2020 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595089505;
        bh=kBotM7AMmbpT90aa7A9GSwVrfTp2GtX3JAD46MGC6r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KZUO6f1kbYzCYkAif/vIxsPMAztKzH7A5ud8Wweoo5tBIA8oxhTx0GdMDb2SIzXkK
         +cbLQijzdqSBEpnnztbzF02xQeOFupx9+F7ivTuzv0q6xQkCPHDyO2zlbK0XZCS4RD
         i7yphtxKgqwDs/lAgRJ9EcOY7XYTz691hDC5g3RE=
Date:   Sat, 18 Jul 2020 17:25:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: trigger: Staticise stub functions
Message-ID: <20200718172501.4ba58924@archlinux>
In-Reply-To: <20200714142456.67054-1-alexandru.ardelean@analog.com>
References: <20200714142456.67054-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jul 2020 17:24:56 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Make sure that the trigger function stubs are all static inline. Otherwise
> we'll get linker errors due to multiple definitions of the same function.
> 
> Fixes f8c6f4e9a40d4: ("iio: trigger: Staticise stub functions")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I'm curious on what the actual build error is?  Static functions should
result in independent implementations in each C file that includes
them. Inline is normally considered a hint.  Hence what am I missing?

Jonathan

> ---
> 
> FWIW: we can skip the Fixes tag from my side; this has been present for
> a while.
> I just bumped into it while sync-ing the ADI tree with some upstream
> stuff.
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

