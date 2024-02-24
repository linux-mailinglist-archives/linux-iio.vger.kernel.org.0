Return-Path: <linux-iio+bounces-3001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1AA8625CB
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C49B1C20FC8
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A746436;
	Sat, 24 Feb 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHJTCleZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6704502E
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787982; cv=none; b=VjmWxcQ5BWBsEFwGx3uotRSv3FKev3BG9MXnnYTy09tKsgMcGdiep9s5Nf4u0auLByPd1Ou6o69vZTKXtccJhL4Co9VPbDJ+9HJto8670JrLN5v8kRzKMaFtRsTr50fxeJFQh9bjy4Vlf/+M+y9zqzEXOXyGgS6X0fr6lb/dc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787982; c=relaxed/simple;
	bh=KjLqhGuvjxLQ7zt/3I6u3Co26GdNetWp3qmFIrIKenM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrD7aHxD6pFDbV7+QiFL9OuYjwvKgvAicrJDVzjZYte/3aVlzjOagaFhpigV5Y6owYKnvwUJtpa476r8kNqaF9VkidMi8ubOmxxDY/QKYtKecjI5E4EnL+QNccKpDn5apULJAoClmEevqaw1D1xHamU3gcucZOP3npNJAoRhBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHJTCleZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D3EC433C7;
	Sat, 24 Feb 2024 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708787982;
	bh=KjLqhGuvjxLQ7zt/3I6u3Co26GdNetWp3qmFIrIKenM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHJTCleZzBDfl6d62dMqSIpv7mfkawCuD7xveFdePERRrRes2dpSHpNbhVBrSCKQF
	 6qcA/gbdQyRQbuKugtJ84OZsfJCn7iMDkHLHUpe4SidBlS2odRaDuSy3Eda9CPhuMr
	 jEdICK2MhMVjfNyzvML4Fq7S0Re+rK1IY+FtzFoq6txJCmfs7vUKPQhCYK99TeQKrO
	 BLaX6TKmltuIGbcCcCivGc95GDKSoakF0urrivViTxR9E8xbE78awqOM2d0vKVMrQv
	 rmgUIjJW8NsCBUsD7HTeBxOHHAugrSmjMn6AEMLIxUAvSikArrEj4gKNe2Uo64tHZC
	 tB+CHkfFdsoWg==
Date: Sat, 24 Feb 2024 15:19:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Haibo
 Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/8] iio: adc: ad7124: Switch from of specific to fwnode
 based property handling
Message-ID: <20240224151926.335f118f@jic23-huawei>
In-Reply-To: <ZdNCXFpPpsNgO6VJ@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
	<20240218172731.1023367-4-jic23@kernel.org>
	<ZdNCXFpPpsNgO6VJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 13:58:20 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 18, 2024 at 05:27:26PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Using the generic firmware data access functions from property.h
> > provides a number of advantages:
> >  1) Works with different firmware types.
> >  2) Doesn't provide a 'bad' example for new IIO drivers.
> >  3) Lets us use the new _scoped() loops with automatic reference count
> >     cleanup for fwnode_handle  
> 
> Similar remarks as per other patch series...
> 
> ...
> 
> >  	struct ad7124_state *st = iio_priv(indio_dev);
> >  	struct ad7124_channel_config *cfg;
> >  	struct ad7124_channel *channels;
> > -	struct device_node *child;
> >  	struct iio_chan_spec *chan;
> >  	unsigned int ain[2], channel = 0, tmp;  
> 
> Shouldn't ain be u32?
> 
> >  	int ret;  
> 
> ...
> 
> > +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> > +						     ain, 2);  
> 
> ARRAY_SIZE()
> 
> 

Agreed.  Nuno or other Analog folk, want to clean these up?

Jonathan

