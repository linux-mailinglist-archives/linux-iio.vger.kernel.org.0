Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9827617A
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWT4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 15:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWT4T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 15:56:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4292193E;
        Wed, 23 Sep 2020 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600890979;
        bh=mxvUIgxbMdOtM98Zj0ZF4L5vRovN1v+avpv1s/xqETk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Hg7LsU8BJaPaTkZjRyO168stZhxPxy5L+BIuGGKVpPqKebCgwK35jGTbQ/fFiZpj
         lnQqnysuvnqBYqfeu84vA9XijGkgbLex6ar7JAkqJ1NvPisVPQ8OpaWJSow79mtI+J
         FnYrp6EVr8WRm7CbIzbkuru4hwgQNPSkO5/KFaHU=
Date:   Wed, 23 Sep 2020 20:56:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Constify mchp_tc_ops
Message-ID: <20200923205613.74061332@archlinux>
In-Reply-To: <20200923014838.GA3267@shinobu>
References: <20200922201941.41328-1-rikard.falkeborn@gmail.com>
        <20200923014838.GA3267@shinobu>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 21:48:38 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Tue, Sep 22, 2020 at 10:19:41PM +0200, Rikard Falkeborn wrote:
> > The only usage of mchp_tc_ops is to assign its address to the ops field
> > in the counter_device struct which is a const pointer. Make it const to
> > allow the compiler to put it in read-only memory.
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

I'm not sure if I'll get another pull request out this cycle, so it
may have to wait for 5.11.

Thanks,

Jonathan

> 
> > ---
> >  drivers/counter/microchip-tcb-capture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> > index b7b252c5addf..039c54a78aa5 100644
> > --- a/drivers/counter/microchip-tcb-capture.c
> > +++ b/drivers/counter/microchip-tcb-capture.c
> > @@ -253,7 +253,7 @@ static struct counter_count mchp_tc_counts[] = {
> >  	},
> >  };
> >  
> > -static struct counter_ops mchp_tc_ops = {
> > +static const struct counter_ops mchp_tc_ops = {
> >  	.signal_read  = mchp_tc_count_signal_read,
> >  	.count_read   = mchp_tc_count_read,
> >  	.function_get = mchp_tc_count_function_get,
> > -- 
> > 2.28.0
> >   

