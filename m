Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297142E72FD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL2SVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 13:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgL2SVe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 13:21:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75FE207AB;
        Tue, 29 Dec 2020 18:20:52 +0000 (UTC)
Date:   Tue, 29 Dec 2020 18:20:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter:ti-eqep: remove floor
Message-ID: <20201229182049.3ef72268@archlinux>
In-Reply-To: <88a5ed56-ac49-bf64-4d52-8ada6d3af4ef@lechnology.com>
References: <20201214000927.1793062-1-david@lechnology.com>
        <X9dQeKy/Ol4d+3iM@shinobu>
        <88a5ed56-ac49-bf64-4d52-8ada6d3af4ef@lechnology.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Dec 2020 08:05:44 -0600
David Lechner <david@lechnology.com> wrote:

> On 12/14/20 5:46 AM, William Breathitt Gray wrote:
> > On Sun, Dec 13, 2020 at 06:09:27PM -0600, David Lechner wrote:  
> >> The hardware doesn't support this. QPOSINIT is an initialization value
> >> that is triggered by other things. When the counter overflows, it
> >> always wraps around to zero.
> >>
> >> Fixes: f213729f6796 "counter: new TI eQEP driver"
> >> Signed-off-by: David Lechner <david@lechnology.com>  
> > 
> > Is the QPOSINIT preprocessor define needed at all anymore, or should it also be
> > removed?  
> 
> There are already many more defines for registers that are not
> used, so I didn't remove it.
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > 
> > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >   
> >> ---
> >>   drivers/counter/ti-eqep.c | 35 -----------------------------------
> >>   1 file changed, 35 deletions(-)
> >>
> >> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> >> index a60aee1a1a29..65df9ef5b5bc 100644
> >> --- a/drivers/counter/ti-eqep.c
> >> +++ b/drivers/counter/ti-eqep.c
> >> @@ -235,36 +235,6 @@ static ssize_t ti_eqep_position_ceiling_write(struct counter_device *counter,
> >>   	return len;
> >>   }
> >>   
> >> -static ssize_t ti_eqep_position_floor_read(struct counter_device *counter,
> >> -					   struct counter_count *count,
> >> -					   void *ext_priv, char *buf)
> >> -{
> >> -	struct ti_eqep_cnt *priv = counter->priv;
> >> -	u32 qposinit;
> >> -
> >> -	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
> >> -
> >> -	return sprintf(buf, "%u\n", qposinit);
> >> -}
> >> -
> >> -static ssize_t ti_eqep_position_floor_write(struct counter_device *counter,
> >> -					    struct counter_count *count,
> >> -					    void *ext_priv, const char *buf,
> >> -					    size_t len)
> >> -{
> >> -	struct ti_eqep_cnt *priv = counter->priv;
> >> -	int err;
> >> -	u32 res;
> >> -
> >> -	err = kstrtouint(buf, 0, &res);
> >> -	if (err < 0)
> >> -		return err;
> >> -
> >> -	regmap_write(priv->regmap32, QPOSINIT, res);
> >> -
> >> -	return len;
> >> -}
> >> -
> >>   static ssize_t ti_eqep_position_enable_read(struct counter_device *counter,
> >>   					    struct counter_count *count,
> >>   					    void *ext_priv, char *buf)
> >> @@ -301,11 +271,6 @@ static struct counter_count_ext ti_eqep_position_ext[] = {
> >>   		.read	= ti_eqep_position_ceiling_read,
> >>   		.write	= ti_eqep_position_ceiling_write,
> >>   	},
> >> -	{
> >> -		.name	= "floor",
> >> -		.read	= ti_eqep_position_floor_read,
> >> -		.write	= ti_eqep_position_floor_write,
> >> -	},
> >>   	{
> >>   		.name	= "enable",
> >>   		.read	= ti_eqep_position_enable_read,
> >> -- 
> >> 2.25.1
> >>  
> 

