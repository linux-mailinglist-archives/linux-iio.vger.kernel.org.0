Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F0224BD4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgGROdv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 10:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROdu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:33:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843B22064B;
        Sat, 18 Jul 2020 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595082830;
        bh=aGwpt6WMtqY5/WwIWAUClRDNeEjX6lZPDr9q46ZIAzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gge3LrrjfJKyzp//YFHSwSmJVxw7LfnupVN36U63PeAqSXkxRPKvxWsEHCV/LqNw7
         m/EMa0BK62RgKjFd1YnGzoReJaUHRmQSSFzFAPtHYrefkFkPx6R4PFC+BFfN6pfmJH
         ukVYIi2uU1CsfI2Iw0+T2mhjS1OJ1/vJiOOEru3I=
Date:   Sat, 18 Jul 2020 15:33:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Andreas Brauchli <a.brauchli@elementarea.net>,
        Pascal Sachs <pascal.sachs@sensirion.com>
Subject: Re: [PATCH 05/30] iio: chemical: sgp30: Add description for
 sgp_read_cmd()'s 'duration_us'
Message-ID: <20200718153345.0a6a5720@archlinux>
In-Reply-To: <20200716135928.1456727-6-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-6-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:03 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/chemical/sgp30.c:236: warning: Function parameter or member 'duration_us' not described in 'sgp_read_cmd'
> 
> Cc: Andreas Brauchli <a.brauchli@elementarea.net>
> Cc: Pascal Sachs <pascal.sachs@sensirion.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Perhaps we can do better on the wording.

> ---
>  drivers/iio/chemical/sgp30.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index 403e8803471a9..82e407d48a0aa 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -227,6 +227,7 @@ static int sgp_verify_buffer(const struct sgp_data *data,
>   * @cmd:         SGP Command to issue
>   * @buf:         Raw data buffer to use
>   * @word_count:  Num words to read, excluding CRC bytes
> + * @duration_us: Time to sleep in microseconds

Time taken to sensor to take a reading and data to be ready.

Something like that maybe?  I've not checked the datasheet but from
code that looks to be what this describes..

Jonathan

>   *
>   * Return:       0 on success, negative error otherwise.
>   */

