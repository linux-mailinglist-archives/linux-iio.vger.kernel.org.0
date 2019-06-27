Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88E58AFF
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 21:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0Tip (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 15:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0Tip (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Jun 2019 15:38:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF3720665;
        Thu, 27 Jun 2019 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561664324;
        bh=fiwmCE6GCb6TF6KF/QxYIB81jrEtg/6+MmofeaLxQ7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GEhONFXlClLLfF1SkNmCwqyS0jKnNmLvFg37edRwSjBlP9H8yZGAvV+uHawvbh4C8
         0QhKr+fHowf1bptuKZOo1vQo8jvsvxmORpsQEpCPoq/G53IHVIDVubvopByzycHA2y
         f6XymkJo/xPoVABZBW0FJxMszS2Dke+dZ11cvMZ8=
Date:   Thu, 27 Jun 2019 20:38:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: iio-utils: Fix possible incorrect mask
 calculation
Message-ID: <20190627203840.75328b15@archlinux>
In-Reply-To: <8b5ad111c555eb548c4f3da6d55e426a15ebf59b.camel@hadess.net>
References: <8b5ad111c555eb548c4f3da6d55e426a15ebf59b.camel@hadess.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Jun 2019 09:20:45 +0200
Bastien Nocera <hadess@hadess.net> wrote:

> On some machines, iio-sensor-proxy was returning all 0's for IIO sensor
> values. It turns out that the bits_used for this sensor is 32, which makes
> the mask calculation:
> 
> *mask = (1 << 32) - 1;
> 
> If the compiler interprets the 1 literals as 32-bit ints, it generates
> undefined behavior depending on compiler version and optimization level.
> On my system, it optimizes out the shift, so the mask value becomes
> 
> *mask = (1) - 1;
> 
> With a mask value of 0, iio-sensor-proxy will always return 0 for every axis.
> 
> Avoid incorrect 0 values caused by compiler optimization.
> 
> See original fix by Brett Dutro <brett.dutro@gmail.com> in
> iio-sensor-proxy:
> https://github.com/hadess/iio-sensor-proxy/commit/9615ceac7c134d838660e209726cd86aa2064fd3
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
Applied to the togreg branch of iio.git.

thanks,

Jonathan

> ---
>  tools/iio/iio_utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index a22b6e8fad46..7399eb7f1378 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -156,9 +156,9 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  			*be = (endianchar == 'b');
>  			*bytes = padint / 8;
>  			if (*bits_used == 64)
> -				*mask = ~0;
> +				*mask = ~(0ULL);
>  			else
> -				*mask = (1ULL << *bits_used) - 1;
> +				*mask = (1ULL << *bits_used) - 1ULL;
>  
>  			*is_signed = (signchar == 's');
>  			if (fclose(sysfsfp)) {
> 

