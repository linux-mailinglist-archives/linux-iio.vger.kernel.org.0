Return-Path: <linux-iio+bounces-22193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF793B18E44
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A25FAA4A31
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3FC222590;
	Sat,  2 Aug 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg0WJ4ia"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD88836;
	Sat,  2 Aug 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135447; cv=none; b=cl29ovqCqJ0ZJHw/2sudXAc86b21f60yBKWK8BCFU7vScjM1AsQyqNMG8wlE34HenBz3nm9QSmYouCcqnAqGvOy2VcJIDaMWQheszToAqpdlSzu8gmfYHXGBgxTMv6qKZv/U5Uwd9sjJNAqy0FSl+P5YUXx3UNsKs2bxmJ0Ejjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135447; c=relaxed/simple;
	bh=4hcyyY0ycxXkMqvv8873RLDK7Dzwl+Bmd7CBnlGgJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/Bb6qx21BrQOUKdZLpub+vsO3Nl14rsQx/Pd8CDLluhvjgjeGm3bwn1b7rKB5WKaL+Cy7Fz9Yq8D1dyY1gzHal73V0dkfDoOqAR6GHXDbnKhlmoFPNWfToaKrp45x3d+3q9RVe/9mCiRArieg8k6hHe3jWlCEf+gn/rd1HvBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg0WJ4ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D08C4CEEF;
	Sat,  2 Aug 2025 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754135446;
	bh=4hcyyY0ycxXkMqvv8873RLDK7Dzwl+Bmd7CBnlGgJw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sg0WJ4iaWt2fmucMbQ7OojnyCy1CbGoUATBLz6MdVpVqniPJ4jczxovgUhiA7+y01
	 FNjBRxNEt34uujktLT1+lJqiNdWQvXrb3zy+Vzb2HKbGYKFXcy0wN7KadR3SnU3MpV
	 NHcX+HhRyLlkvHF8J412g/c/vnIiZgRWIdGydRew+7AnbfQfTVINKQ4IRRoxDo7bi+
	 tpbZHX9BRikZiMJzk7wCXec8c4KEhLackYWcJ0SfGNvoqES+trEpICrymjdXsp90nq
	 25hc+FsTrew22pUMwiNHXBXOglL9B2CFvrhwx3LZNcQCbF35WFD0h8EMXMQvffV4Os
	 VluRLOBm+9Nhg==
Date: Sat, 2 Aug 2025 12:50:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Akshay Bansod <akbansd@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <20250802125038.7a02cbce@jic23-huawei>
In-Reply-To: <aIIdU7mJi_cEdRuI@smile.fi.intel.com>
References: <20250723141359.11723-1-akbansd@gmail.com>
	<aID01DxC1Hf2PK0i@smile.fi.intel.com>
	<20250723164100.34e864d6@jic23-huawei>
	<aIIdU7mJi_cEdRuI@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 14:47:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 23, 2025 at 04:41:00PM +0100, Jonathan Cameron wrote:
> > On Wed, 23 Jul 2025 17:42:28 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Wed, Jul 23, 2025 at 07:43:59PM +0530, Akshay Bansod wrote:  
> 
> ...
> 
> > > >  	fs_table = &hw->settings->fs_table[sensor->id];
> > > >  	for (i = 0; i < fs_table->fs_len; i++)
> > > > -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > > > -				 fs_table->fs_avl[i].gain);
> > > > -	buf[len - 1] = '\n';
> > > > +		len += sysfs_emit_at(buf, len, "0.%09u ",
> > > > +				     fs_table->fs_avl[i].gain);
> > > > +
> > > > +	sysfs_emit_at(buf, len - 1, "\n");    
> > > 
> > > Still looks a bit weird (while working).
> > >   
> > > >  	return len;    
> > > 
> > > I deally we should have a helper doing all this under the hood for plenty of
> > > the (existing) users in the kernel.  
> > 
> > hmm I'm not sure generic is terribly easy  
> 
> I agree, I have some plans for %p specifier extension, but I was stuck with it
> and it in half-basked state in some of my local Git branches.
> 
> > and I'd prefer this using the
> > read_avail callbacks that require the data in an array where ever possible.
> > Mind you that does the same print at len - 1 as this.  Let's play. 
> > Completely untested.
> > 
> > 	for (i = 0; i < fs_table->fs_len; i++)
> > 		len += sysfs_emit_at(buf, len, "0x%09u%c",
> > 				     fs_table->fs_avl[i].gain,
> > 				     ((i == fs_table->fs_len - 1) ? '\n', ' '));
> > 
> > better?  
> 
> Without extra parentheses this makes the job.
> 
Akshay, can you spin a new version along those lines?
> 
> > It's definitely not more readable than the above, but it does avoid the write
> > to len - 1.
> >   
> > > In any case, I leave this change to others to comment, I don't object pushing
> > > it in this form, either way len - 1 is simply weird.  
> 


