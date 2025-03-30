Return-Path: <linux-iio+bounces-17357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB677A75AFC
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C3165D1D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79CF1D89E4;
	Sun, 30 Mar 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwQ3RmUP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B9158A13;
	Sun, 30 Mar 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352863; cv=none; b=rfZH+fYMy3UvfZQwCRwRU9zgNTvwxVKHHepCliMrxBOqryRV0HLBqZ+tIjuQKgtil6JV9JIfvfXGWwWjgc4eJS/4b8kvXRqhAhO1T7xFmyVFFtY3leBQ0Sxd2XvKXqZlR2eaEuzltgOd1G+gCgnGKvLRwOhutXNJz4KqLO1qBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352863; c=relaxed/simple;
	bh=qwtIpLMU8NhYZdxIh2bjHPrxN0bwfR02BAxJV+lwOTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIwOdJ2htEvTRtWrYmsSYeJEkwJ4/VAacAr4JFCAXyzjNtpZGa5ApvaNGpQusDWNFHLH46X0NByLstvhu9TcMMiWszGyqwLzTCbj0QQiaMMqavsdF1ySZBeE220g/6i0HUrIGXGQ4h1ctTc02a539ihTs9A5utFBxNLprK2V8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwQ3RmUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDD0C4CEEB;
	Sun, 30 Mar 2025 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743352863;
	bh=qwtIpLMU8NhYZdxIh2bjHPrxN0bwfR02BAxJV+lwOTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwQ3RmUPhbgy59bU5T+oL7zFKkNn3WZE6HI9dgR6h426YMsAgRgURG0uhCI32Wd/+
	 eJbyEDqpaWLKc42Al8499eMdUeQ4RV2tXg/JVix1cpUzpatKQv6/Y4+w/SDXsO+fQR
	 ++wHrtygbDc5ulQrWjWp081znA7CKcnkvuFgteRl6rfkyn3r9MRnZ7MoiEZVJbBhcF
	 T3eB52YECWlqPLYRCBdL32+m2NXcWyNyQooetLokR6u+f2A5lukgyPcntiKlda5dwZ
	 KV7KoIw/O9LpNc/DobKNPpKCTCeglhTn24RqY27HVyLI/5KhW2yZIuRZ6aPnY8azM7
	 SyP0FCMC68o1g==
Date: Sun, 30 Mar 2025 17:40:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250330174056.35e3f046@jic23-huawei>
In-Reply-To: <CAGd6pzNL_TRfEhinDYa1Tveam-gvdV3dB976mRqOoE=vz+kpkA@mail.gmail.com>
References: <20250322163211.253009-1-simeddon@gmail.com>
	<20250323120211.000b4305@jic23-huawei>
	<CAGd6pzNL_TRfEhinDYa1Tveam-gvdV3dB976mRqOoE=vz+kpkA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 03:19:31 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> On Sun, 23 Mar 2025 at 17:32, Jonathan Cameron <jic23@kernel.org> wrote:
> > Marcelo gave a Reviewed-by tag.  This time I've picked it up
> > manually but in general it is the responsibility of the submitter
> > to include those on new versions. Obviously sometimes things race though so
> > maybe that is what happened here!  
> 
> Sorry, I was unsure whether the tag still applied after modifying a patch or
> if it needed to be reviewed again.

It is up to you as the submitter to make that decision, but if you
do drop a tag due to changes, I'd expect to see a comment under the ---
(alongside the change log) saying why.

Jonathan

> 
> Thanks,
> Siddharth Menon


