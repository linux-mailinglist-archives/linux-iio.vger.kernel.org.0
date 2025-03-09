Return-Path: <linux-iio+bounces-16588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F67A585C3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87845188E729
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0321EF373;
	Sun,  9 Mar 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBRKZk/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5631C1ADB
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536712; cv=none; b=c4z86ZhwpT1JGASMTC25hOPN5cyUoIwEpmhRcpXgrj2rDmjlMYt+gj/u/CVd0h09mPydmNyj2C6dNr9rc+5cmXUgWJjWdme9SPna/5NOVD+rO6jUsZTNFzQHaXhDYi+OE8ungqcDsTVA1VWdNcTxr/VGG0op1ZgXtlo0nix4BTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536712; c=relaxed/simple;
	bh=Y7gi0gnUqp3+nYdZsHPy19DmOHCKq6owxkCZTA4kSjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXEDBIem7xO36oL/PcvbcrrfCaAS+jZ94MQHA7ntUqkyQUsxKAxUvnAJlwU1Q5j1p26jqihKuhLGoWfUDROLFEncKpImY1/J9VulGt2CHxeip8m4bzN3geB4kdN5oXL1N9wOn+jmkamTodz+3JLNQMSWQZ/2qYLnOQyHSYGIHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBRKZk/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6436FC4CEED;
	Sun,  9 Mar 2025 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741536711;
	bh=Y7gi0gnUqp3+nYdZsHPy19DmOHCKq6owxkCZTA4kSjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBRKZk/XM/2cMYuLTy6PJtshpysZdL929IU0AdXuR+wDHdIVPZ3GD/CuInr6MtngV
	 odcRQX+HAPSs0MZ0l3krT7Fq6EtqMETqFHoAIe9puGRif2ujdJXLbgY0DIRauwe/cM
	 pmz90hwJh71sYhIPkiGpJbukVzaFUomTvOIQD6UBMYBWRNbfU+04NxWePdVgjSfSaJ
	 OnCxPb2nenNQ5/dWr+78oaMgSWq50wxuBiv2XW4EHGppRTMWUXq8IeSeoYqXMD4Atz
	 2hSuksFmJyIx79kCTc1gJZgF6dI8FCg0e68G3c69z6cUYIw8nfi8ZlBdIymO7EaR3G
	 OzFnnRA7vIlJw==
Date: Sun, 9 Mar 2025 16:11:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: Siddharth Menon
Message-ID: <20250309161143.2b730912@jic23-huawei>
In-Reply-To: <CAGd6pzMzrJbRBXr2esV1x-TxXjg9zt22y6UdSXgXe7jCO3_raA@mail.gmail.com>
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
	<20250222151143.7ca7f718@jic23-huawei>
	<CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
	<Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
	<20250305145749.413fe30b@jic23-huawei>
	<CAGd6pzMzrJbRBXr2esV1x-TxXjg9zt22y6UdSXgXe7jCO3_raA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 00:25:46 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> On Wed, 5 Mar 2025 at 20:28, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > This one is an interesting part - I have one somewhere from trying to help
> > on the previous go at cleaning it up.  One issue is that I couldn't manage
> > to get a stable SPI connection patched onto the dev board.  It kind of
> > worked if I used a long cable and did a rain dance, but not enough to really
> > test it.  
> 
> I'll see if I can get my hands on one. Just to clarify, were the issues present
> before, or are you referring specifically to the patch?

Unrelated - it was an electrical issue as far as I could tell.  Comes of
patching leads onto pins on a dev board. Not great for signal integrity!
> 
> Please share the specific rain dance with me for future reference.

Hmm. I might be able to find it and see what patching I did but you
may be better off figuring it out your self for whatever board you can
get hold of.

Jonathan

> 
> Regards,
> Siddharth Menon


