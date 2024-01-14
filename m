Return-Path: <linux-iio+bounces-1645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610082D176
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F030F2820A8
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8978290D;
	Sun, 14 Jan 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjRa1CPN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BF5231;
	Sun, 14 Jan 2024 16:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762A1C433C7;
	Sun, 14 Jan 2024 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705250406;
	bh=7oX0EsPakCJqBD0IFggiXJ5U/Z+JIT6KV5MdtYGkk/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sjRa1CPNQHxZhmru9l+uz3K3S8rhb52doPKGR0r1Kz/od8lWwJWWxsEFYcSGu9m2p
	 /RefdFFnEeyTi4gfAsan+RxocJ7ttpzA2tyhL7Y5p/jd7cV6q9b/Vs74HmEKq92pAU
	 m7oOiZf15Dql26IXe+c9KqhBJhWlV84DlrRP6WorFaMS1hktz1fJgFhvmaG9yLZP9q
	 36y17Zbl5fJLLNSu3eZUH3yF1xPNFVXrLwqJugHg3tZnYFqKOXbfHptigVi2Sw84wc
	 Z3EWPnaHKN4q8npGuhdna0tVkL3QUS2lEsu5U9Z9qYa5kkgoz9nD5GZ/B12k++h17/
	 kRoPVT9hrJltA==
Date: Sun, 14 Jan 2024 16:39:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [RFC PATCH 1/4] of: Add cleanup.h based autorelease via
 __free(device_node) markings.
Message-ID: <20240114163954.32e23985@jic23-huawei>
In-Reply-To: <20231221105434.5842ff3a@jic23-huawei>
References: <20231217184648.185236-1-jic23@kernel.org>
	<20231217184648.185236-2-jic23@kernel.org>
	<20231220221144.GA1188444-robh@kernel.org>
	<20231221105434.5842ff3a@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 10:54:34 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 20 Dec 2023 16:11:44 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sun, Dec 17, 2023 at 06:46:45PM +0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > The recent addition of scope based cleanup support to the kernel
> > > provides a convenient tool to reduce the chances of leaking reference
> > > counts where of_node_put() should have been called in an error path.
> > > 
> > > This enables
> > > 	struct device_node *child __free(device_node) = NULL;
> > > 
> > > 	for_each_child_of_node(np, child) {
> > > 		if (test)
> > > 			return test;
> > > 	}
> > > 
> > > with no need for a manual call of of_node_put()
> > > 
> > > In this simile example the gains are small but there are some very    
> > 
> > typo
> >   
> > > complex error handling cases burried in these loops that wil be
> > > greatly simplified by enabling early returns with out the need
> > > for this manual of_node_put() call.    
> > 
> > Neat!
> > 
> > I guess that now that the coccinelle check has fixed many, we can update 
> > it to the new way and start fixing them all again. We should update the 
> > coccinelle script with the new way. See 
> > scripts/coccinelle/iterators/for_each_child.cocci.  
> 
> If the holiday season gets dull enough I'll take a look at updating that
> as well. Been a long time since I last messed with coccinelle.
> 
> Given this is just a simplification rather than a fix, there would be no rush
> to convert things over but we definitely don't want the coccinelle script
> to generate lots of false positives.  + we should perhaps add a
> script to try and catch the opposite (double free) as a result of
> using this automated cleanup.
Hi Rob,

As things currently stand the script doesn't trigger on a
struct device_node __free(device_node); (which is wrong anyway)
or
struct device_node __free(device_node) = NULL;

So we at least don't cause a flurry of false positives via these
changes.

I'm not keen to add an upstream check to encourage conversion over
to this new approach simply because there is no great rush to do it
and it's easy enough to use grep to find potential targets today.

Also strongly motivated by the fact I don't really have time to
learn coccinelle (however useful that would be in the long run!)

As such I'll tidy these up a bit and send out a non RFC version with
cover letter additions to mention we don't cause false positives and
that a coccinelle script to find candidates might make sense in the
longer term.  It may also make sense to add checks that we don't manually
release the node on error paths without making sure to steal the pointer
(which sets it to NULL to avoid problems).

+CC various Coccinelle folk even though I'm proposing to not do any
coccinelle scripting for now.

Jonathan


