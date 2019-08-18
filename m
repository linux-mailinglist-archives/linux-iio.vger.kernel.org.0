Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FA9184B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRROw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 13:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfHRROw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 13:14:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E4C206C1;
        Sun, 18 Aug 2019 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566148491;
        bh=Yw8c9+3onw1UpC97BP+SV018SH390YF//JmW4tbD1Zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IOwEz44goAFmho5oejHFacREn70pemE6Baf6rLSLSCO+0l0iM9khqgMRSsUx5EtoF
         diQlZl9YDeS6YOo58G2lJov/7XtWDc938szJfyb3NFkXjEDk/NiZdeE8Fd89ZR7+z0
         xBro/KwxcyCV+CagcvNpR4cwnb1lEJQUj9n1+RUs=
Date:   Sun, 18 Aug 2019 18:14:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martyn Welch <martyn.welch@collabora.com>,
        Sergei M <fizik1@yandex.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][iio-next] iio: light: noa1305: fix missing break in a
 switch statement
Message-ID: <20190818181444.55fc35b3@archlinux>
In-Reply-To: <20190815074339.32380-1-colin.king@canonical.com>
References: <20190815074339.32380-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Aug 2019 08:43:39 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a missing break for the NOA1305_INTEGR_TIME_400MS case,
> fix it by adding it in.
> 
> Addresses-Coverity: ("Missing break in switch")
> Fixes: 741172d18e8a ("iio: light: noa1305: Add support for NOA1305")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Hi Colin

Fix already on it's way in.  Was also caught by 0-day.

Thanks,

Jonathan

> ---
>  drivers/iio/light/noa1305.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> index 7b859ae1044d..5ebfbc52f541 100644
> --- a/drivers/iio/light/noa1305.c
> +++ b/drivers/iio/light/noa1305.c
> @@ -85,6 +85,7 @@ static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
>  	case NOA1305_INTEGR_TIME_400MS:
>  		*val = 100;
>  		*val2 = 77 * 4;
> +		break;
>  	case NOA1305_INTEGR_TIME_200MS:
>  		*val = 100;
>  		*val2 = 77 * 2;

