Return-Path: <linux-iio+bounces-5596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CDD8D7493
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB66281BEB
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525E2C684;
	Sun,  2 Jun 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkHyF/+H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91920200C3;
	Sun,  2 Jun 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717320457; cv=none; b=iXwMmdioP1izYXHi3noi4LJMt2TVqPACKro95zqNmlcJonWdDBEOf85zNGzq835U5U4e2zsN5WM5MXaXfa0pvSc8q/ZEjbabqBy3ZDIz1daL9sqRZ+XpcePHUODwXJQTgNgMQe2Rb/Sjv/Cc2oA3YWK4G1Fvq1P0ZK5PQTEn4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717320457; c=relaxed/simple;
	bh=2afbsLR6VJ4RY556N27atcCW5rYmUOB/9oegyq9ivmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPMSDkgel8EfXvbD4ydB/QbysQWM98IcjaVp6na4oxiCrYKMg286KKWk7HAE9rA6qdOzJWZFX7EfmQmulLe8GGN/2KMuyF2TYkwXLgMWov4E2UJUZhqOukiZKktu88XmXb5y7KrGiy+/lQ2Q8WeWdqUH473AUwiNvWxQx/U4ASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkHyF/+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD50C2BBFC;
	Sun,  2 Jun 2024 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717320457;
	bh=2afbsLR6VJ4RY556N27atcCW5rYmUOB/9oegyq9ivmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkHyF/+HhMi33iSykuQNWc5FsfkTs+xZJs8ZhTHD2fHh7biLfLYNTVBG0OYF0OyeR
	 0bFSlK519qRh8eK4anM5dcch/K/6qp4d9Rf//aFsvH/RAsbR7/DofAG3qUDmEaXW7b
	 oIoU+5wYrM9/v1hH7vhM21ACGICvCM8k7GwN1OJ7aEParKJAliRQEutOTPVDjv2VtW
	 vAKDW2K6ZyJOcntLNer6J4RHr6Csy/F+1uPmHGQ+6zy6exlKpoz/AaezP8stNFmDHw
	 cMypK3cbD9XEiYmiCZeLmRqw97o8qKSNVmB7UeboGjXKwX1NaLsRvyh6KEHjK1UHgj
	 pIW7rTV6FHQyQ==
Date: Sun, 2 Jun 2024 10:27:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: add support for multiple scan types
Message-ID: <20240602102726.35120347@jic23-huawei>
In-Reply-To: <20240602102517.438b51b8@jic23-huawei>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
	<20240602102517.438b51b8@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 10:25:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 30 May 2024 10:14:07 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Up to now, the IIO subsystem has only supported a single scan type per
> > channel. This scan type determines the binary format of the data in the
> > buffer when doing buffered reads.
> > 
> > For simple devices, there is only one scan type and all is well. But
> > for more complex devices, there may be multiple scan types. For example,
> > ADCs with a resolution boost feature that adds more bits to the raw
> > sample data. Traditionally, for slow devices, we've just always used the
> > highest resolution mode, but for high performance ADCs, this may not be
> > always practical. Manipulating data after every read can hurt performance
> > and in the case of hardware buffers, it may not be possible to change the
> > format of the data in the buffer at all. There are also ADCs where
> > enabling the higher resolution can only be done if oversampling is also
> > enabled which may not be desireable.
> > 
> > To allow for more flexibility, we would like to add support for multiple
> > scan types per channel.
> > 
> > To avoid having to touch every driver, we implemented this in a way that
> > preserves the existing scan_type field. See the "iio: add support for
> > multiple scan types per channel" the details. The first couple of patches
> > are just preparation for this.
> > 
> > [1]: https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com/  
> 
> Nice series. Applied to the togreg branch of iio.git and pushed out as
> testing for 0-day to poke at it.
> 
> Obviously this v3 hasn't been on list that long, but there is still time
> as I doubt I'll push out a non rebasing tree for a week or so.
> This week is looking too busy!

oops. Goes to show I'm not keeping track of things very well today.
I haven't applied the driver this updates yet.

I'll look at that now and hopefully I can pick them both up.

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> 


