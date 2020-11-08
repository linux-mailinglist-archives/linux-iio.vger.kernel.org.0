Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0B2AABC8
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgKHPJV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgKHPJV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:09:21 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A1C206F4;
        Sun,  8 Nov 2020 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604848160;
        bh=+G82V53b9PyT+zW/wrnJYL5mP1AcSdZGFD2/L00uskw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJ9BgLAp5BO+FjJ5wUnfFEbtqufgynTcWd82BqyOUura7c+NvGJpSDHFdHlsLSqe1
         eQeVKrhM/QTfI5VtOF2Oi5l17Bg4WUzLE2F0zsrloiksmRP8CXfNg2zIReMtA6jo97
         KWDiENDjM+YZQNSPQh9YdM7xMd6eVSAtg97BffUw=
Date:   Sun, 8 Nov 2020 15:09:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <mchehab+huawei@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] docs: ABI: testing: iio: stm32: remove re-introduced
 unsupported ABI
Message-ID: <20201108150921.11d9aefc@archlinux>
In-Reply-To: <1604685016-2434-1-git-send-email-fabrice.gasnier@st.com>
References: <1604685016-2434-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Nov 2020 18:50:16 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Remove unsupported ABI that has been re-introduced due to a rebase hunk.
> This ABI has been moved in the past in commit b299d00420e2
> ("IIO: stm32: Remove quadrature related functions from trigger driver")
> 
> This also fixes a couple of warnings seen with:
> ./scripts/get_abi.pl validate 2>&1|grep iio
> 
> Fixes: 34433332841d ("docs: ABI: testing: make the files compatible with ReST output")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hi Fabrice,

I guess this got accidentally applied given I thought we'd flagged up those
chunks in the patch as needing fixing.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../ABI/testing/sysfs-bus-iio-timer-stm32          | 24 ----------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index a10a4de..c4a4497 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -109,30 +109,6 @@ Description:
>  		When counting down the counter start from preset value
>  		and fire event when reach 0.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> -KernelVersion:	4.12
> -Contact:	benjamin.gaignard@st.com
> -Description:
> -		Reading returns the list possible quadrature modes.
> -
> -What:		/sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
> -KernelVersion:	4.12
> -Contact:	benjamin.gaignard@st.com
> -Description:
> -		Configure the device counter quadrature modes:
> -
> -		channel_A:
> -			Encoder A input servers as the count input and B as
> -			the UP/DOWN direction control input.
> -
> -		channel_B:
> -			Encoder B input serves as the count input and A as
> -			the UP/DOWN direction control input.
> -
> -		quadrature:
> -			Encoder A and B inputs are mixed to get direction
> -			and count with a scale of 0.25.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
>  KernelVersion:	4.12
>  Contact:	benjamin.gaignard@st.com

