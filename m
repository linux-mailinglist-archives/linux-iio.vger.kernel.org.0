Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59C1224C12
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGROys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgGROyr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:54:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E3D20717;
        Sat, 18 Jul 2020 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084087;
        bh=Po5XWHPqjkgfnMSwLRt8/aD4yr9TfBMsgOcT8X0cu28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2bxVIdif2CrdyL2yaR3EnEJkleZKiaUI7OKBywd27l+1TDctGB3eJbJGhgK4O2d6N
         4AFD1evlt58gk9emBsq59ooEKgNfKUooUmdTxF5Ma9K3yKbzqZDxd+ap+YsBUbCfCP
         YVUbDrONm9OKDlKChbEyWgUiFrx3lJtq+QzdpaQs=
Date:   Sat, 18 Jul 2020 15:54:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Barry Song <21cnbao@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 12/30] iio: gyro: adis16080: Fix formatting issue and
 compiler attribute ordering
Message-ID: <20200718155442.14c420db@archlinux>
In-Reply-To: <20200716135928.1456727-13-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-13-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:10 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format and
> gets confused if the variable does not follow the type/attribute
> definitions.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/gyro/adis16080.c:49: warning: Function parameter or member 'lock' not described in 'adis16080_state'
>  drivers/iio/gyro/adis16080.c:49: warning: Function parameter or member '____cacheline_aligned' not described in 'adis16080_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Hmm. You are going to have an awful lot of those ____cacheline_aligned ones.

Might be worth thinking about whether we fix kernel-doc to cope with those.

A quick grep suggests the vast majority of users of this have it after
the element name.

@Jon Corbet :  What do you think?  Looks like there is special
handling already for ____cacheline_aligned_in_smp. Should we extend
that to this case?

Jonathan



> ---
>  drivers/iio/gyro/adis16080.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
> index 1b84b8e112fe1..f38f9abcccbb5 100644
> --- a/drivers/iio/gyro/adis16080.c
> +++ b/drivers/iio/gyro/adis16080.c
> @@ -38,14 +38,14 @@ struct adis16080_chip_info {
>   * @us:			actual spi_device to write data
>   * @info:		chip specific parameters
>   * @buf:		transmit or receive buffer
> - * @lock		lock to protect buffer during reads
> + * @lock:		lock to protect buffer during reads
>   **/
>  struct adis16080_state {
>  	struct spi_device		*us;
>  	const struct adis16080_chip_info *info;
>  	struct mutex			lock;
>  
> -	__be16 buf ____cacheline_aligned;
> +	__be16 ____cacheline_aligned buf;
>  };
>  
>  static int adis16080_read_sample(struct iio_dev *indio_dev,

