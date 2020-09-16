Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4784526C70C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgIPSQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbgIPSQQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:16:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8EB21D43;
        Wed, 16 Sep 2020 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600280176;
        bh=4iBCrQihJ8+zD6yRNlqwbyR2+s09dzZUamroyfJWJ90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sshHFyDIMEKZqmbswUNqNeflQtIYxFG62mbsgygHc7uSv0L4aq/DEdzRdnyUSWUfn
         OznVVnWeB7g4E4sSBu8ZvdSJvstDivpUXEfBe4JRA26AS0d4etZuVVZg8JTZO0EXB8
         9JBJtJKBLwa+QRjgLX1M6nYvs2oMw+86pnKOGDYE=
Date:   Wed, 16 Sep 2020 19:16:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad9467: return ENODEV vs EINVAL in
 ad9467_setup()
Message-ID: <20200916191614.3e189d42@archlinux>
In-Reply-To: <20200916082221.72851-1-alexandru.ardelean@analog.com>
References: <20200916082221.72851-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 11:22:21 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The proper error code should be ENODEV (vs EINVAL) in case the chip ID
> isn't recognized.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad9467.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 1e8fd83b9bc2..8a6682b567be 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -324,7 +324,7 @@ static int ad9467_setup(struct ad9467_state *st, unsigned int chip_id)
>  				  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
>  		return 0;
>  	default:
> -		return -EINVAL;
> +		return -ENODEV;
>  	}
>  }
>  

