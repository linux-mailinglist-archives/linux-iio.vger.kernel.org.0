Return-Path: <linux-iio+bounces-1739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D5830D72
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 20:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E652881EB
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7B249F9;
	Wed, 17 Jan 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONWT1AeX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1530249E6;
	Wed, 17 Jan 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520866; cv=none; b=pi6x60KFXS8SZ4oE/ix2+WKZ/iDMWe4lHX8sOyiuo6vSVPj2fvHvSn2Ytca2xeUvtRuvIZJIAUp5oShccpD0D658AZkEJTU4A0LJNOlzX8mCdZ0ryOrHrUs1uW8THTXFqqixWM94+1DPoLB4hQueieLW3+6p5y4fFikKgzR8ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520866; c=relaxed/simple;
	bh=KX+tkWw26QcXxBlLrnie/0Q22kLhSDPAxk4r/KQ9zB4=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=VvekptHgj3CaxrFPJ/o1e+2t3emh1NE3m9596codeXXy465yuAMZu907S8UldDMwGm4VVB7Zwm+MYVnzNd8F2pOzFJ9BvluusGjGHmUfohcpWPYICPWfktLuX8YvqV9vfjK2Ehbs1uZ0+oqVqqWUz5o/rx3vwJ3FlfIb7eE6tfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONWT1AeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D44C433F1;
	Wed, 17 Jan 2024 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705520866;
	bh=KX+tkWw26QcXxBlLrnie/0Q22kLhSDPAxk4r/KQ9zB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONWT1AeXyp9b82CSeMjj9J5oxIzYexEkEfyY698/s9WbSU6yBzIITQJAYIsIQ1jiq
	 a0no/MSjnENHLVYZWSIeb428fLmXYeXveYUlkViOpNi6CTTpC4L3HaVW5nFNHQIlEf
	 4RoB8FjmNrJfAOehgsoHD9pdGMmssdV/rIi0ObL3B1/83BfFeHXyk0P2oJE18kRB59
	 kCx13E8UV2xT1DiBR+eRpvuK12DPEMtbT+Lm24k2PgQCGOjh1RNtsYPP0YZ7fCN4Uy
	 FOYQIZY1UUTPqlHxucvXxavDf6q0VyzVFqGqWgFNSf99wPcomncqaX7ok6ucIxQXh2
	 oANh5EU41JstQ==
Date: Wed, 17 Jan 2024 13:47:43 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [PATCH 2/4] of: unittest: Use __free(device_node)
Message-ID: <20240117194743.GA2888190-robh@kernel.org>
References: <20240114165358.119916-1-jic23@kernel.org>
 <20240114165358.119916-3-jic23@kernel.org>
 <CAL_Jsq+vsXgBYtj66NG+3eZM-9gGw4QkU-bpn+JprAmG+UWmTQ@mail.gmail.com>
 <20240117170144.00004a43@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117170144.00004a43@Huawei.com>

On Wed, Jan 17, 2024 at 05:01:44PM +0000, Jonathan Cameron wrote:
> On Tue, 16 Jan 2024 12:26:49 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sun, Jan 14, 2024 at 10:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > A simple example of the utility of this autocleanup approach to
> > > handling of_node_put()
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/of/unittest.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > index e9e90e96600e..b6d9edb831f0 100644
> > > --- a/drivers/of/unittest.c
> > > +++ b/drivers/of/unittest.c
> > > @@ -233,27 +233,23 @@ static void __init of_unittest_dynamic(void)
> > >
> > >  static int __init of_unittest_check_node_linkage(struct device_node *np)
> > >  {
> > > -       struct device_node *child;
> > > +       struct device_node *child __free(device_node) = NULL;  
> > 
> > In another thread[1], it seems that initializing to NULL is bad form
> > according to the chief penguin. But as this is a refcounted pointer
> > rather than an allocation, IDK?
> 
> I'm not sure the argument applies here. My understanding is it's not
> really about the = NULL, but more about where the __free(device_node) is.
> The ordering of that cleanup wrt to other similar clean up is to do it
> in reverse order of declaration and in some cases that might cause trouble.

Rereading Linus' reply again, I think it is more that you see how 
something is freed right where it is allocated, and the way to do that 
is the allocation and declaration are together.

> Here, the only way we could ensure the allocation was done at the right
> point and we didn't have that __free before it was set, would be to add
> variants of for_each_child_of_node() etc that did something like
> 
> #define for_each_child_of_node_scoped(parent, child) \

Note that you don't need child here except to define the name of child. 
Otherwise, the variable name you need for the loop is implicit. OTOH, 
defining a name which has no type defined anywhere in the user function 
isn't great for readability either.

WRT the whole renaming, it might be better to keep 'scoped' in the name 
so that it is obvious how child needs to be handled. Or is the compiler 
smart enough to catch any case of doing it wrong?

> 	for (struct device_node *child __free(device_node) = \
> 	       of_get_next_child(parent, NULL); \
>              child != NULL; \
> 	     child = of_get_next_child(parent, child))
> 
> So that the child variable doesn't exist at all outside of the scope
> of the loop.
> 
> I thought about proposing that style of solution but it felt more invasive
> than a simple __free() annotation.  I don't mind going that way though
> if you prefer it.

My only preference currently is to not get yelled at. :)

> Alternative is just to make sure the struct device_node * is always
> declared just before the for loop and not bother setting it to NULL
> (which is pointless anyway - it just felt fragile to not do so!)

Would the compiler know to avoid invoking __free if exiting before the 
variable is set?

Rob

