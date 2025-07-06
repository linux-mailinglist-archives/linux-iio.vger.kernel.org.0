Return-Path: <linux-iio+bounces-21411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D2AFA6BA
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1BA189B302
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AD293C46;
	Sun,  6 Jul 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qquTHZ23"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890C3595C;
	Sun,  6 Jul 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821831; cv=none; b=ccEhSBJzRv5M+vuoN1NdU3lWFbP08Z/X3LRTQNRgXZnj7xZXbo/IzmB2nGds84GMX9vdZA4LRqyKW04/UrlzpUVVtvSo/tAld4BvWPFebWb4DYHWzO5lB5dXpy2PnnYzcM2uIUk4Qa/w6dmqwGoH75YAO/poZm7J3FYjkFkOa+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821831; c=relaxed/simple;
	bh=b58MCPEgWLQQXb7kXK0EP8YWqtQapdQ2JCbpH7nRPvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHvFzm4wFYxjqaFhZJGvxJNlldYVA6gb9ag8oMM1ca9w7D4JF6lj6RJEJIpYnLzUlEK8uGyvgK1QKwt16K1I0KXcrtHwb810fGkEr5sjK2YumBDJQ0GfSf6lIDM82zqUSWuCMGknnVj2L2RY4KdvvaoZ2heSOAW/JfMb16yGHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qquTHZ23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F406C4CEED;
	Sun,  6 Jul 2025 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751821830;
	bh=b58MCPEgWLQQXb7kXK0EP8YWqtQapdQ2JCbpH7nRPvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qquTHZ23LqjW8K35B8Rn5ofOcSLpF4SUfpqdbmsjkaiHwqM+tvLAfvzzvEDtqtUgI
	 MtCGW2LlSfNdU1AJAqO4zw5VBCLCCkkxFJwgMUlbIdJ3yMhL24jyOzeNkeeEgFawhB
	 cK4haHrn7CNvAMTtiK/tiudvy0+asQth5eWqyaJP19ochbeMTKbb0OMIjgV3neseqA
	 FKutvOO1sCgiBZcWkvAyCvjFKaOMQHLeYja4IDN/l8shvOstoyXJ5M/mgaLzXTnGQU
	 aNBkKi+CAVoeTq7i2ChPyL8R+tk5s1TQBKpQbk9jS1Dbkpou5ZyEQMJ2NYUT0xEybn
	 4hCi6j2Lbadig==
Date: Sun, 6 Jul 2025 18:10:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
 lgirdwood@gmail.com
Subject: Re: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of
 ADCs
Message-ID: <20250706181019.75c3d33c@jic23-huawei>
In-Reply-To: <aGbm5zZMN4FIohM_@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
	<aGTpNNaW7cXC18Jt@smile.fi.intel.com>
	<aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
	<aGUi7r2dgnbqLOAH@smile.fi.intel.com>
	<aGWBgLLtOzVGwXek@debian-BULLSEYE-live-builder-AMD64>
	<aGaP-HBbIbfEoKlo@smile.fi.intel.com>
	<aGbm5zZMN4FIohM_@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 17:24:07 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 07/03, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 03:59:12PM -0300, Marcelo Schmitt wrote:  
> > > On 07/02, Andy Shevchenko wrote:  
> > > > On Wed, Jul 02, 2025 at 09:00:42AM -0300, Marcelo Schmitt wrote:  
> > > > > On 07/02, Andy Shevchenko wrote:  
> > > > > > On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:  
> > 
> > ...
> >   
> > > > > > >  6 files changed, 3601 insertions(+)  
> > > > > > 
> > > > > > This is weird. At least patches 11 & 12 have '-' lines...
> > > > > >   
> > > > > Yeah, sorry about that. These ADCs are fancy such that the base driver is about
> > > > > 1500 LoCs due to channel setup handling and support for multiple combinations of
> > > > > voltage references and channel setups.
> > > > > 
> > > > > About the '-' lines, I will rework ad4170_parse_channel_node() on earlier
> > > > > patches to avoid 3 line removals in patch 11. Patch 12 is only makes sense
> > > > > after patch 7 and I think it would lead to '-' lines if coming before patch 10
> > > > > since both increment the number of IIO channels. Anyway, I'll see how to further
> > > > > reduce the number of lines being removed.  
> > > > 
> > > > My point is that the above statistics is mangled and I don't know how I can
> > > > trust the contents of this series if it already lied about that.  
> > > 
> > > Looks like git format-patch summarizes the changes from all patches when
> > > printing the statistics to the cover letter. Also, git format-patch doc [1]
> > > says the 'changes' dirstat option (default behavior) doesn't count
> > > rearranged lines as much as other changes.  
> > 
> > TIL. Thanks for pointing that out.
> >   
> > > There are cover letters of other
> > > patch sets where the number of '-' lines don't match the sum of lines
> > > removed by each patch. [2] and [3] are examples of that.  
> > 
> > That's different I believe due to the diff algorithm in use
> > (btw, do you use histogramm?).  
> 
> Nope, I was using the default diff algorithm to generate the patches.
> I tried the --histogram option today but didn't notice any difference. Maybe
> default and histogram output the same result for the ad4170 set.
> I'll send v8 using histogram alg. Nevertheless, is there any preferred alg for
> generating patches (so I can use what's best on next patch sets)? 

Given the size and complexity of this driver, I've applied it to the testing
branch of iio.git to get some extra build coverage.  Last minute reviews
still welcome but I may ask for patches on top depending on what they affect.

Hence applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a poke at them.

Thanks,

Jonathan

> 
> Thanks,
> Marcelo
> 


