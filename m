Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8E513BBE
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351212AbiD1SpD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351204AbiD1SpC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 14:45:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799FE68316
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 11:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0293E61C5E
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 18:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11DC385A9;
        Thu, 28 Apr 2022 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651171306;
        bh=yC0UFWk9rkWsjE00tuPPQyYgh7l0WJLROgoTdEVIhg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0bXZHl/k9QV1QJrhFHfCtqCkypq5L8laVRPEjWSynhnaFDpI9f5ZQDdZzlITHLUa
         VO0PC/UkDuBwUTEczZsnNFf0cei7T71I+ReELptZByzCmEQC3f/ss+r2R5GGoPxOJY
         L21ZYXmyfAdq7VYfoFdUIGlY+XE8gZxsV6uBevRB8XxioLuZZQmVJMEmy2hr6dV7MQ
         eYLfglgsyc/t4t9M26Egh4Cl2uTK+9T0010L9A2X0bNf64r+ztRH0zmsGBSm/ZXiJj
         B12L0CVH4Do5o+ZLmLpr1IWi7puesewjVK2mRiRbQarRvNSpCXI37RY5rvqbQlEj7s
         +w2OnKrkWADmg==
Date:   Thu, 28 Apr 2022 19:49:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan.Cameron@huawei.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, michael.hennerich@analog.com,
        vincent.whitchurch@axis.com
Subject: Re: [PATCH 01/17] iio: core: Increase precision of
 IIO_VAL_FRACTIONAL_LOG2
Message-ID: <20220428194957.4d51edfa@jic23-huawei>
In-Reply-To: <a684c794-3f28-7ce5-92fe-0aed3ae52d91@axentia.se>
References: <20220418192907.763933-2-jic23@kernel.org>
        <a684c794-3f28-7ce5-92fe-0aed3ae52d91@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Apr 2022 14:00:49 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > With some high resolution sensors such as the ad7746 the
> > build up of error when multiplying the _raw and _scale
> > values together can be significant.  Reduce this affect by
> > providing additional resolution in both calculation and
> > formatting of result.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-core.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 2f48e9a97274..d831835770da 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -683,14 +683,21 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> >  		else
> >  			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
> >  					     abs(tmp1));
> > -	case IIO_VAL_FRACTIONAL_LOG2:
> > -		tmp2 = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
> > -		tmp0 = (int)div_s64_rem(tmp2, 1000000000LL, &tmp1);
> > -		if (tmp0 == 0 && tmp2 < 0)
> > -			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));
> > -		else
> > -			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
> > -					     abs(tmp1));
> > +	case IIO_VAL_FRACTIONAL_LOG2: {
> > +		u64 t1, t2;
> > +		int integer;
> > +		bool neg = vals[0] < 0;
> > +
> > +		t1 = shift_right((u64)abs(vals[0]) * 1000000000000ULL, vals[1]);  
> 
> While the multiplication is safe if val[0] is 24 bits or less, I
> wonder if that's OK for *all* the existing stuff? I would have guessed
> that something somewhere needs more bits than that? Did you consider the
> rescaler? And if everything currently really does fit in 24 bits, do we
> really want to make it difficult to add something beyond 24 bits later
> on?

Good point. Perhaps we can do something a bit nefarious and check that
val[0] is sufficiently small and if not fallback to lower precision
as we had before?  Or if adventurous adjust the precision automatically
so we can get as many digits (at least 9) as can be computed without
overflow...  For now, I think 2 steps is enough though.

Jonathan
 
> 
> Cheers,
> Peter
> 
> > +		integer = (int)div64_u64_rem(t1, 1000000000000ULL, &t2);
> > +		if (integer == 0 && neg)
> > +			return sysfs_emit_at(buf, offset, "-0.%012llu", abs(t2));
> > +		if (neg)
> > +			integer *= -1;
> > +		return sysfs_emit_at(buf, offset, "%d.%012llu", integer,
> > +				     abs(t2));
> > +		}
> > +	}
> >  	case IIO_VAL_INT_MULTIPLE:
> >  	{
> >  		int i;
> > -- 
> > 2.35.3
> >   
> 

