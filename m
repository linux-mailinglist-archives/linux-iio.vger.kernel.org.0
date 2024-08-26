Return-Path: <linux-iio+bounces-8784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E3A95EE29
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795C51C215D5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887B314659D;
	Mon, 26 Aug 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drIEDpPU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48728146585
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667103; cv=none; b=AyFek0k0eB4ap8LS/4aKx8/7+4EjvXUnTldopnKUtJu+XyrDgGMFXmVUbEHQrDxfk5VSQrK2ljAufvB2iGU6GiL7ox6KyaclEK9Omj7ZZV18CsoUc+gtYzXZRTT6+8Ei3MQW4kLK0HzFxyN4fKbMl9BiqNzSGsBQIHSkAWzkD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667103; c=relaxed/simple;
	bh=1WpKyMnTEn9amhLUmxiaBY+BaCSZ/5B5nnqQaAMqEHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThxLrAlSq0uvZzYwkW3vhMpvm6kzhC4cB4m8j0C/j+WC811bo1KyJYCDZjocrKq1PcUiiURW5KAz4+m/K6MwrEjeBF9ruQHI9rbRTpozUm8crzjMUvvxFOvs8YRcBxm6hb8r4IK6MsuN5aZ6MHxPIc2LgnMBlsVqPMNzD/spWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drIEDpPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2000C51400;
	Mon, 26 Aug 2024 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724667102;
	bh=1WpKyMnTEn9amhLUmxiaBY+BaCSZ/5B5nnqQaAMqEHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drIEDpPUH/ucPbFIneKqybhwk+BgQ5+NQE+e9VAhk4u/E3chp2FynBnk6yfM/TfVt
	 M4KEI4kGaM4cvtt7szLPLMzwDtDGOhYjl9y5oSWGXmnEfTX9poBbQufYtSVK6PHvW0
	 6pfT8jO6QyskbDAF1pd3+44eVbWGwXCOY3TTt/6s/JGuw3i0P7+UXxaJSjMVw/YY9c
	 2hCEMA6L7rrN2cStNrT3yaCLkq+75wD2Or9OU/AxlZZIYwsYmwSzw6HN2AZf57GtmN
	 AB0dCgUZt6bp2iRRJ63ouq/RbwzcdFHowW4QqL9SrD+0yUX2qcGJVddbuHpeW3CxmE
	 8XTWb/Y1AD+sg==
Date: Mon, 26 Aug 2024 11:11:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] New: drivers/iio/imu/adis16400.o: warning:
 objtool: adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20240826111119.2820afe6@jic23-huawei>
In-Reply-To: <bug-219192-217253@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 09:35:37 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
>             Bug ID: 219192
>            Summary: drivers/iio/imu/adis16400.o: warning: objtool:
>                     adis16400_write_raw() falls through to next function
>                     adis16400_show_flash_count()
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: ionut_n2001@yahoo.com
>         Regression: No
> 
> drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw() falls
> through to next function adis16400_show_flash_count()
> 
> Kernel: 6.11.0-rc5 vanilla
> GCC compiler: gcc (Debian 14.1.0-5) 14.1.0

I think this is a false positive.  None of the cases of the switch statement
fail to return and there are unreachable() markings that this
check seems to not be able to see which were added to try and
point out to the compiler that it was failing to identify they
were not possible to get to.

We could add some returns the unreachable paths to work around
this warning I suppose.

Maybe we are doing something wrong otherwise?  I'd like more
eyes on this incase I'm just missing something obvious.

Jonathan


> 


