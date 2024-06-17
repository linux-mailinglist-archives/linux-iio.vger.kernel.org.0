Return-Path: <linux-iio+bounces-6416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2289A90BB5C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19C9B25236
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2D18733D;
	Mon, 17 Jun 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHepPqti"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E376F9F7
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653638; cv=none; b=vCloriXodJZMKL7H3EMLXl7BwZNKKcR14tsKDdG17e0QRmpCzPEI+07Oxvevdt+3+oqzUqZqn56gIFrPobX25ceYc8hIWZohb0ljLdFHQ1XfVA0znA5kuFh4EImOu8nIH62PpeRBhkxawa2RvYx4eo5Q6CVuFwG3nQidx4Mlr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653638; c=relaxed/simple;
	bh=uVkre7o/W7et6eJAl2treBsF0VV6xe2iUfs6PX4znsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTD5WnwPc4iz5PnvdwpMe+iOm/ZZYUXDjqV5iViicfxedl45Eu8EvHm5LE4fT74J5FozrSzMfxgXMlYN3/u8LQEyKZ5C35nSRUzz5lrYnvEzT0Y0tWk2ZDZyaO1BTsv3XQV7VayimVdS9R6w22mlDe9pA/kogWBiEJqfNa3rHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHepPqti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285F5C2BD10;
	Mon, 17 Jun 2024 19:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718653638;
	bh=uVkre7o/W7et6eJAl2treBsF0VV6xe2iUfs6PX4znsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cHepPqtix7vTqZ73PxamtxsqUHm7Q43Rh3hNq903hG19dvyC8yd9VwMIqztQxGUqU
	 fYl8rx6D/U6ORiKB3aOrardTr+/qg9YyfBD5E2Q7CPxGYtvSH0/6YhBp3tsF6+BCrD
	 8LNhVZwwbgEnFBc1MFf9vpXY6I/kd+ICyL2TIOIVJLOgo8QFDn6WBOXY+RkRZKF0Bu
	 iM7Qa8ogs4SlZe3N/+meBwJRW2YIwWhs4EqAX9w/G9D1At94BGI6iN4ASIwS91bv9t
	 BnAYtrscDzKrg+OwoJi/McmFJTMVGdgvKABT82QgUmJjc/BlFsn7WgSTt6Wf2ekY78
	 VaHKEFllQwVBw==
Date: Mon, 17 Jun 2024 20:47:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 6.10 cycle.
Message-ID: <20240617204711.5ca565ab@jic23-huawei>
In-Reply-To: <2024061715-fasting-sputter-4597@gregkh>
References: <20240615101121.09118fed@jic23-huawei>
	<2024061646-deviator-maritime-4e35@gregkh>
	<2024061715-fasting-sputter-4597@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 20:02:29 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Jun 16, 2024 at 12:04:53PM +0200, Greg KH wrote:
> > On Sat, Jun 15, 2024 at 10:11:21AM +0100, Jonathan Cameron wrote:  
> > > The following changes since commit 8f40af31971ce012c0a4b13444900aed3f708edf:
> > > 
> > >   Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-07 21:05:39 +0200)  
> > 
> > Pulled and pushed out, thanks.  
> 
> Really did it this time, sorry for the confusion.
> 
> greg k-h

No problem! Thanks for all your help and for handling so many trees
with only an occasional hiccup (far fewer than I cause for you!)

Jonathan


