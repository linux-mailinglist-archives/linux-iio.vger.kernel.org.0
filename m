Return-Path: <linux-iio+bounces-10210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6441D991949
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DAA1F22214
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BE15B0EB;
	Sat,  5 Oct 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO1JNnZX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9A15B0E1;
	Sat,  5 Oct 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151752; cv=none; b=CXhR04Kvp8cMpiFM4Di4SUujc7HKoz51xvxPlSqfhhyGJydOk1zad/+xHYf1uf1rnXOiLxNJO+65bkCKPo0buKqV4FCKajdbc7icEIG0kcKAYG7CzYfe4jKu6yONBFkFXIOMZHZKYuU3YLQYNtifHjLqRyGCskUNtBVXIqsgJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151752; c=relaxed/simple;
	bh=nqDpF0nxJ6EW02lg5dwer0Czk3Hfm1so5yT0qlE7l58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amw0e+GuMF2MzCNaSjDkAvSQ6ZfjX8EoT0WAKysNe2BIIWTkQ8ApbLfzQX07g/Li0tNhOK+k810HMjeo0kmvcLT8/npFbqmXCUx7krrzBv3yTCXXRLXszxEryLf6amsfd8X1ccAgEn01/X/RxZ2wWHaZes7O9xoYd8ZAYgkEtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO1JNnZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F204EC4CEC2;
	Sat,  5 Oct 2024 18:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151752;
	bh=nqDpF0nxJ6EW02lg5dwer0Czk3Hfm1so5yT0qlE7l58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XO1JNnZXxrPF9H/ZAKdwR5s2UL8Hd1jlawc0u4ywShC7EX0giukaGlTYeyJCGxRda
	 VN2dh7cB9JEMiUWkMEd9IolYQE1YM75zr3rBxHTeDz6I1d0xWW2CHq2txaKxfEUY6C
	 yQ7FvIr1EqeWazlaoEqFESbyh+VhtDr1+otTBS655WvRrMq9JXjcqSa6kk9MoHX4Dk
	 s6ySOiwIwFX25lU1iWymINyTuTmeMVhKYuSP8VBhPjRkdvu+WMYNLQCMQmEa7Lq6hQ
	 nneYDXD9x5B0GozJgHZW6Arj4FpoaKHxBPHMHMcf8p4IUA0e2z7mtKRr9GRyACdru2
	 KmXlAVWMn/aFg==
Date: Sat, 5 Oct 2024 19:08:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: vl6180: Added Interrupt support for
 single shot access
Message-ID: <20241005190851.66145d1b@jic23-huawei>
In-Reply-To: <CAG=0RqJntw8njb-tzbDU5oALCNd2EEb=QFP=Uqzcxsehy4mzbg@mail.gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
	<20241004150148.14033-3-abhashkumarjha123@gmail.com>
	<20241005174755.6864d482@jic23-huawei>
	<CAG=0RqJntw8njb-tzbDU5oALCNd2EEb=QFP=Uqzcxsehy4mzbg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 23:05:25 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > > +     if (client->irq) {
> > > +             reinit_completion(&data->completion);  
> >
> > That's late so there is a race condition. You might be delayed just before this
> > and finish the measurement before the reint_completion() in which case you'll
> > clear the complete() that happens in the interrupt handler before
> > then waiting on it.  
> Yes this makes sense.
> 
> > This reinit needs to be before whatever can potentially trigger
> > that interrupt.  
> Can you explain this part, because where can i reinit it, The measurement
> starts when we write the START_STOP bit to SYSRANGE_START. So should
> it be before that.
Immediately above that write looks right to me. So before writing START_STOP.
That way the completion will be ready for a complete whenever
one turns up.

Jonathan

> I'm kind of confused with this.
> 
> Thank you,
> Abhash


