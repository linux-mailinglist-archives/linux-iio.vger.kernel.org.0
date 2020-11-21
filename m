Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424292BC025
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgKUPFJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgKUPFJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:05:09 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4753522201;
        Sat, 21 Nov 2020 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605971108;
        bh=iu7BfZLy6UGi+SY2Xjn0aH+r+3b/Rp7gUZ+6OiHyHbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NyxdnkWEvMmm3efv8PpDh2fpHE3aew1ismN0QqTc+3FEU6gD9oqEve6rjJ8A53CeU
         5ZvvniDvsgE49gtl/Qeky2qgyK95fNbiIXcdqfUW3BZQ64V4ThPU7tnueH53CJnD3e
         kDw7rg7t1BtkaJEHrjqtjfSRCmcke0kXYXAWa76A=
Date:   Sat, 21 Nov 2020 15:05:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 090/141] iio: adc: cpcap: Fix fall-through warnings for
 Clang
Message-ID: <20201121150504.32385ffd@archlinux>
In-Reply-To: <b3c1c3f9c76f2f0e832f956587f227e44af57d3d.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
        <b3c1c3f9c76f2f0e832f956587f227e44af57d3d.1605896060.git.gustavoars@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Nov 2020 12:36:26 -0600
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Hi Gustavo,

I'm assuming there is no 'huge' rush for these an intent is that they will
filter through the various subsystems.  Hence I've queued it up for the
next merge window.

Applied to the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/cpcap-adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index 64c3cc382311..f19c9aa93f17 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -557,6 +557,7 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
>  		break;
>  	case CPCAP_ADC_BATTP_PI16 ... CPCAP_ADC_BATTI_PI17:
>  		value1 |= CPCAP_BIT_RAND1;
> +		break;
>  	default:
>  		break;
>  	}

