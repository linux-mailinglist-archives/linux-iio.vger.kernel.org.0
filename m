Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A17267F18
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIMKHB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 06:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMKHB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 06:07:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93BF20639;
        Sun, 13 Sep 2020 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599991620;
        bh=KXdxCYDiKlr81+I8wmYDTghlMjmlgpNnbUAixwUlnmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oWnRC0MA1tZzk3+HAAh3lNwBon3skOniT6dmaDIBU3lyMMHFK/PEuZkUwYO01bxRs
         ypaf9S5nVZ0Le2oFg55Av8f9htPljjC/y1zy5yuyYxwIKfaR9dvTAoztCyKT/7pTFe
         RaL6ZRiuIRJePBherhqOHQvWRUO4BvtrxRtEFwJg=
Date:   Sun, 13 Sep 2020 11:06:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v4 03/10] fixp-arith: add a linear interpolation
 function
Message-ID: <20200913110654.1702b03c@archlinux>
In-Reply-To: <20200910140000.324091-4-dmitry.baryshkov@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
        <20200910140000.324091-4-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 16:59:53 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> From: Craig Tatlor <ctatlor97@gmail.com>
> 
> Adds a function to interpolate against two points,
> this is carried arount as a helper function by tons of drivers.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Seems sensible to have this.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/linux/fixp-arith.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
> index 8396013785ef..281cb4f83dbe 100644
> --- a/include/linux/fixp-arith.h
> +++ b/include/linux/fixp-arith.h
> @@ -141,4 +141,23 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
>  #define fixp_cos32_rad(rad, twopi)	\
>  	fixp_sin32_rad(rad + twopi / 4, twopi)
>  
> +/**
> + * fixp_linear_interpolate() - interpolates a value from two known points
> + *
> + * @x0: x value of point 0
> + * @y0: y value of point 0
> + * @x1: x value of point 1
> + * @y1: y value of point 1
> + * @x: the linear interpolant
> + */
> +static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
> +{
> +	if (y0 == y1 || x == x0)
> +		return y0;
> +	if (x1 == x0 || x == x1)
> +		return y1;
> +
> +	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
> +}
> +
>  #endif

