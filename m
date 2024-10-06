Return-Path: <linux-iio+bounces-10223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90961991DF3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 12:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC82B20D53
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338A16A95B;
	Sun,  6 Oct 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiqKLpBg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78662F2E
	for <linux-iio@vger.kernel.org>; Sun,  6 Oct 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211762; cv=none; b=HSenznbpcy5XDPGRozjjREdzy0+oS8crpuW69ziLjMWznitQ+kc21ha5+Dg4GOYz2M/jDP7CFxxrwNjrVf0VEq6eYOlHDoCZFyplTxDG4D4WE7p5JOfLHMZ2UeF6u7JSGpCoj6o6oli4F11x9epxMzy2O28OexxRY8qHe8GrmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211762; c=relaxed/simple;
	bh=AntQi81TSEgCVKlMiH5LGYX4Rl7gMS/FTSklxLnQUWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kghLQl37XSjJugwb6YbJUiZ4OY+snfePRei0upIWiJzuvClhWXz036hxwgzC5ha8AWusXiFg2o2HrUvPTVCJvyiGCMZ3wWEIEU3ZfCEJ1LYiVqGmeYjhEIr0OHqXeKU8BI08aXmNTnqfTfXMPicfejoHiRpuUEOmD3IAVe75MKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiqKLpBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4088C4CEC5;
	Sun,  6 Oct 2024 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728211762;
	bh=AntQi81TSEgCVKlMiH5LGYX4Rl7gMS/FTSklxLnQUWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iiqKLpBgQMxGUew1+BoaIPKDR3XQJJgQBlA6vpC1svOZtiEFPYQt82gXOeDwbS6me
	 AZeL0q0cZASJk8QXJrOCHJYWqo24d2S2Xplgl0Vye8AxPzSAWlCaP5nrOjZhIPjQsp
	 oh6yBUxi4/p4W97wapTHno33tweIcKGB9riRqTMzYQd7yK0RM8kgs9b4iOWSy2uZ7S
	 9nu9vhea+UdAzKEiyQetwMxHv9Wv9I2bCEWZTP4cYGN5HrsVaQNBdW9Hwhrm+YJ9qu
	 5Oe5uYIbJqqlGkuaEwhab2dZfXLroNJhhfFrhFi7bBqbRS9hJ6mnGsLvM8yeAWWn0E
	 XZVhjbzgh/6xw==
Date: Sun, 6 Oct 2024 11:49:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20241006114918.1333d744@jic23-huawei>
In-Reply-To: <bug-219192-217253-hHOd4hSpUz@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
	<bug-219192-217253-hHOd4hSpUz@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Oct 2024 21:24:56 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
> --- Comment #6 from Tudor Gheorghiu (tudor.reda@gmail.com) ---
> I saw this bugreport and I must say I encountered a somewhat similar but
> not quite the same warning message from objtool when compiling with
> clang.
> 
> This is my environment:
> Linux version 6.12.0-rc1+ (Ubuntu clang version 18.1.3 (1ubuntu1), Ubuntu LLD
> 18.1.3)
> 
> This is the objtool warning:
> > drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw+0x89:
> > can't find jump dest instruction at .text+0x8be  
> 
> I dissasembled the binary and this is what I found at that offset:
> >    0x0000000000000781 <+113>: jmp    0x8a4 <adis16400_write_raw+404>
> >    0x0000000000000786 <+118>: mov    %rdi,%r12
> >    0x0000000000000789 <+121>: lea    0x30(%r14),%rdi
> >    0x000000000000078d <+125>: call   0x792 <adis16400_write_raw+130>
> >    0x0000000000000792 <+130>: mov    %r14,%rbx
> >    0x0000000000000795 <+133>: add    $0x30,%rbx
> >    0x0000000000000799 <+137>: je     0x8be  
> 
> Looking at .text+0x8be:
> > (gdb) x/4i 0x00000000000008be+0x8be
> >    0x117c <adis16300_channels+1180>:  add    %al,(%rax)
> >    0x117e <adis16300_channels+1182>:  add    %al,(%rax)
> >    0x1180 <adis16300_channels+1184>:  add    $0x0,%al
> >    0x1182 <adis16300_channels+1186>:  add    %al,(%rax)  
> 
> I cannot tell if this is an actual issue, or just a false positive,
> but I decided to post my findings here nevertheless.
> 

So far no one has been able to identify an actual problem, so I'm 
treating this a false positive that will eventually get fixed from
the compiler side. Or someone will explain what the issue in the
code is.

Jonathan

