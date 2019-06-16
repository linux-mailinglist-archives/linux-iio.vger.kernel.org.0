Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3247436
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfFPKUz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 06:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfFPKUz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 06:20:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F092084A;
        Sun, 16 Jun 2019 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560680454;
        bh=HeAVqFhEnFHaGE/MLt8iG4KF9+eU3HYvjifK8118Rak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mnf1Pj/huamHWR6SCw8l2VcZkO3Fh1eunBrqAEP/wKDkhAUUfaux8hWOgKsdOv+TR
         6QZq0TcotwXJEGHe5WTci4kjd1ChlSG3g6fiDA9U2TpHKqicsxx5yFiU/QPmZrBENG
         WFG28OKNi7mHn5KtT1U6V9lDlWbIwSB9sn/xxGgU=
Date:   Sun, 16 Jun 2019 11:20:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/3] staging: iio: ad7150: simplify i2c SMBus return
 treatment
Message-ID: <20190616112048.67082117@archlinux>
In-Reply-To: <90e8a25eca0825878d55fe0a9e760906b4689035.1560529045.git.melissa.srw@gmail.com>
References: <cover.1560529045.git.melissa.srw@gmail.com>
        <90e8a25eca0825878d55fe0a9e760906b4689035.1560529045.git.melissa.srw@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 13:32:54 -0300
Melissa Wen <melissa.srw@gmail.com> wrote:

> Since i2c_smbus_write_byte_data returns no-positive value, this commit
> making the treatment of its return value less verbose.
> 
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 091aa33589d7..7d56f10a19ed 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -202,16 +202,11 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
>  	ret = i2c_smbus_write_byte_data(chip->client,
>  					ad7150_addresses[chan][4],
>  					sens);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> -
> -	ret = i2c_smbus_write_byte_data(chip->client,
> +	return i2c_smbus_write_byte_data(chip->client,
>  					ad7150_addresses[chan][5],
>  					timeout);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
>  }
>  
>  static int ad7150_write_event_config(struct iio_dev *indio_dev,

