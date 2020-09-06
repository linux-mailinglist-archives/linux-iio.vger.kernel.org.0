Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B140925EF05
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgIFQK7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 12:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbgIFQKy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 12:10:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B1120709;
        Sun,  6 Sep 2020 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599408654;
        bh=EKKo/Pr7cbvXEL/uhyjxvvcTU18RWBi/KO8A9ZBpESM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RRVLstSGSZAGrFXwmLxAMRpdW09YPwib93S8F0KNv+TVU2IrGUjKhkrkehP1XQmhv
         At1b9wRn4fncsLuSOdS2lR8U2T3FIdL91IrFdjfuxH0LiNDeBFT+wldmDbWNzOwhq4
         SNDU8xOVKJGLiO0rh06cKhy5kQO0O7bnBnRVZ43s=
Date:   Sun, 6 Sep 2020 17:10:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Move Hartmut Knaack to Credits
Message-ID: <20200906171049.5aa5b99b@archlinux>
In-Reply-To: <20200903181926.5606-2-krzk@kernel.org>
References: <20200903181926.5606-1-krzk@kernel.org>
        <20200903181926.5606-2-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 20:19:26 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Hartmut Knaack was an active reviewer and contributor to the IIO
> subsystem and drivers.  However his last message on LKML is from
> October 2015.
> 
> In thanks for Hartmut's effort, move him name to the Credits.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied.

Thanks Hartmut.  With the other reviewers, you dug me out of
several holes where I was completely swamped.

Hope to see you again one day, but fully understand if you've
moved on to other things.

I probably don't say this often enough, but those who review
for IIO are the only reason I keep up with things when life gets
busy.  It is very much appreciated.

Thanks,

Jonathan

> 
> ---
> 
> Changes since v1:
> 1. Fix order in CREDITS
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 32ee70a7562e..c741455498a4 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1942,6 +1942,10 @@ S: Post Office Box 611311
>  S: San Jose, California 95161-1311
>  S: USA
>  
> +N: Hartmut Knaack
> +E: knaack.h@gmx.de
> +D: IIO subsystem and drivers
> +
>  N: Thorsten Knabe
>  E: Thorsten Knabe <tek@rbg.informatik.tu-darmstadt.de>
>  E: Thorsten Knabe <tek01@hrzpub.tu-darmstadt.de>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a120aec90a2..c585449b9084 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8488,7 +8488,6 @@ F:	drivers/iio/multiplexer/iio-mux.c
>  
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
> -R:	Hartmut Knaack <knaack.h@gmx.de>
>  R:	Lars-Peter Clausen <lars@metafoo.de>
>  R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>  L:	linux-iio@vger.kernel.org

