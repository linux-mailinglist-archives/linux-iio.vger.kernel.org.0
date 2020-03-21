Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84818E3C0
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCUSr4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 14:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgCUSr4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 14:47:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA9320722;
        Sat, 21 Mar 2020 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584816476;
        bh=2cT5cgTSXrYWRUgqTyPsF3K14RwZy4F0nyDHrnhmO3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cIvp9hgmq4hqcNeMIIjqkKKRyy2Swlb9i/NFYUNmDmtSXxPFwcZtFoqs1F/cyuK0F
         y3amug9uWe39nvzBjmzfG7jbanBA2TuWIoyWlpA7GSGURzhYilOCZii41J/xSc1GEg
         TbMzLAxE0oEPWQ+NmoGSl/CoWu5MRsrEtLAUVYco=
Date:   Sat, 21 Mar 2020 18:47:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: Drop unnecessary explicit casting
Message-ID: <20200321184751.717f1d4d@archlinux>
In-Reply-To: <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
References: <20200318100754.25667-1-nish.malpani25@gmail.com>
        <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 05:26:52 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2020-03-18 at 15:37 +0530, Nishant Malpani wrote:
> > Provide correct specifiers while printing error logs to discard the use
> > of unnecessary explicit casting.  
> []
> > diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c  
> []
> > @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
> >  
> >  	regmap = devm_regmap_init_i2c(i2c, &config);
> >  	if (IS_ERR(regmap)) {
> > -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> > -			(int)PTR_ERR(regmap));
> > +		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
> > +			PTR_ERR(regmap));  
> 
> Another option would be to use %pe to print the error identifier
> and not the error number
> 
> etc...
> 
> 

Indeed that would be even better.  I'd missed that one being added
to the magic of prink :)

Jonathan
