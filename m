Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201B74F56C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfFVK7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFVK7F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:59:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F2E2070B;
        Sat, 22 Jun 2019 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561201144;
        bh=xCov3n+vVgxiEJrOvTFgrxXtp1jxZHWTifXs1Kued78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JflgTq93DHvJsBs9KZsE4pfr6HhNO5f5igz5LyQ9l83Ad+iYEKNHNWkA56EYQkSxy
         XnK7Ud++qZ3+eHf+5ehYJ5m2ph4BkeOLwqG4lYnipWQaOAVFIzePGg7bNSdAYsZ28b
         W/cKvQq72CDGjwZPGvhL5oJVCaHsuK/YNYE0l41g=
Date:   Sat, 22 Jun 2019 11:58:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Melissa Wen <melissa.srw@gmail.com>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] staging: iio: ad7150: use ternary operating to ensure
 0/1 value
Message-ID: <20190622115858.21ceef2d@archlinux>
In-Reply-To: <20190617084033.GG28859@kadam>
References: <20190614165059.7bifufvhxofy6ybu@smtp.gmail.com>
        <20190616111516.1af0d41b@archlinux>
        <20190617084033.GG28859@kadam>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 11:40:34 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Sun, Jun 16, 2019 at 11:15:16AM +0100, Jonathan Cameron wrote:
> > On Fri, 14 Jun 2019 13:50:59 -0300
> > Melissa Wen <melissa.srw@gmail.com> wrote:
> >   
> > > Remove idiom and use ternary operator for consistently trigger 0/1 value
> > > on variable declaration.
> > > 
> > > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>  
> > Hi Melissa,
> > 
> > In general I would consider this unnecessary churn as, whilst
> > it's no longer a favoured idiom, it is extremely common in the
> > kernel.  
> 
> It's still my favourite...  Why wouldn't people like it?  It feels like
> last week I just saw someone send a bunch of:
> 
> -	foo = (bar == baz) ? 1 : 0;
> +	foo = (bar == baz);
> 
> patches and I thought it was an improvement at the time...

That one is nice enough, it's the !! that Linus came out fairly
strongly against though not sure I can find the particular email. 
That one is a fairly kernel specific idiom that I'll be honest I've
rarely seen elsewhere ;)  I remember wincing at the thread
on this as it was an idiom I personally rather liked.

In cases where it doesn't matter because foo doesn't need to 1 or
0 then what you have is nice and clean.

I can't say it's one I care that much about, but I am happy if code
that happens to be under cleanup anyway has this little bit made
the 'preferred style'.  There is something to said for consistency.

Jonathan


> 
> regards,
> dan carpenter
> 

