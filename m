Return-Path: <linux-iio+bounces-11344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575059B18B6
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864691C20B61
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8E1C695;
	Sat, 26 Oct 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUZ4c6En"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A314A91
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954180; cv=none; b=jEpI+/Ycn0N6yI+W1nM5s2oNcoNele4RhKvIC4JdKnjGg2z1p7KpSe9Y0vnMeKHnXj+Z3sgkWk3Muwh5jtWOCJazr6oe8pTQ/iGidsGNLHUMXIcA1xPfdgSp90XS/9Lnt+NB8QrP74D9LDkKbsxw4DG9bKa44xfYUfITt8q6KSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954180; c=relaxed/simple;
	bh=5kjfpTBLN4xuVdg24CtN/5XzJGhHffuHzs6ybBJZqcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnEVcuApwzn1PBUK+gs33Gs+8BUyzF8FMKcHjBTfNbSU277Rfsz/bmBRKOhgdtloK+iDoBFmjc0ax9ObOohsCv4deMk33VrT28JFc2bERoii45coCS+D3Ro3Ypg7INZ1peNLK+vzRSxxd3WHaXc9sChpN/LUfEBmjhy1pUIKwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUZ4c6En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87723C4CEC6;
	Sat, 26 Oct 2024 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729954179;
	bh=5kjfpTBLN4xuVdg24CtN/5XzJGhHffuHzs6ybBJZqcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUZ4c6EneXXvKzxZZWQS3G6ut59u0lSFGaogjTjHO70On4wu+fyiU2mooKV66qFtW
	 otOCalj3dKvHiOVEHP+otARtRuzQhaqXbPBbCAAzxu63GHfS6keQUEFVgY2tYatxfp
	 piGycjz8MGh0b4PSYRBH4VypuPUyGctrDNG1qmS69eCXaYT6wDFjgqjwvGST53T+2d
	 JKDXNUmHT6NATOqws+fk4z3J04NZc6LxUp0hapYzUFIPGcaPyhPFC1K79EhEnorfSy
	 fLADzryS2GPymlxsCcVhhyqgm8Jhp2Cs1d2eUmuyfA8uUp14bdTnC9k1NjzITegLLN
	 EmE/Ic+attUag==
Date: Sat, 26 Oct 2024 15:49:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219418] New: BOSC0200 Accelerometer Invalid chip 12
 initialization error
Message-ID: <20241026154907.7eb3bef4@jic23-huawei>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 13:17:20 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219418
> 
>             Bug ID: 219418
>            Summary: BOSC0200 Accelerometer Invalid chip 12 initialization
>                     error
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: cameraphone77@gmail.com
>         Regression: No
> 
> Created attachment 307035
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307035&action=edit  
> lspci output
> 
> Hardware: Acer aspire spin 3 A3SP14-31PT-38YA
> 
> One line summary of the problem:
> BOSC0200 Accelerometer Invalid chip 12 initialization error

Unfortunately that ID is used by the windows Bosch drivers for numerous
completely incompatible devices.  So we can't do soft matching on this one.
We need to know what the device actually is and add explicit support for
it.

So it's going to take some detective work to find a device with ID 12.

Any other information on what device this might be?

Jonathan
> 
> Full description of the problem/report:
> The Accelerometer is not detected by iio and does not function
> 
> Kernel version (from /proc/version):
> Linux version 6.11.4-arch2-1 (linux@archlinux) (gcc (GCC) 14.2.1 20240910, GNU
> ld (GNU Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Sun, 20 Oct 2024 18:20:12
> +0000
> 
> 
> sudo /usr/lib/iio-sensor-proxy -v
> ** (iio-sensor-proxy:2007): DEBUG: 22:33:10.952: Starting iio-sensor-proxy
> version 3.5
> (iio-sensor-proxy:2007): GLib-GIO-DEBUG: 22:33:10.954: Using cross-namespace
> EXTERNAL authentication (this will deadlock if server is GDBus < 2.73.3)
> ** (iio-sensor-proxy:2007): DEBUG: 22:33:10.991: No sensors or missing kernel
> drivers for the sensors
> 


