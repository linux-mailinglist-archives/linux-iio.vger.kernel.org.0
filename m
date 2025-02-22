Return-Path: <linux-iio+bounces-15954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E851AA40962
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB1B3A8523
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C815DBBA;
	Sat, 22 Feb 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGtwn3tD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503532CCDB
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237108; cv=none; b=Y3sQxZqw2l9+gFESxXPb9g7SLgkKyGosohnIa1p9iD63ctitsj1gl94uyed+GeDZ2AO0Tp9QRnQoc/OMkqNRDYhpjV3Z3nBnKW3oC8J7hK09m9gtLr2KM/84lKYxOjgDcAlsVUA5GC3VdJUXY13TwL/InlXM/Jis8z3HjMl5sHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237108; c=relaxed/simple;
	bh=Q2hK+km+jo/yDhRePX44cxY1UgC/saBtoq3maZwiL/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpKawQd1QQyq9G2EOvVei2tnb/7stVDCU+u67gYseh3nhGaF4SoZkdFn791djVJu+ai1pmro5aoEEp+bRqH1158Q7BYd8Pdj/VL9UlrWDIs1d5giIZfexVmxAlvqhFIBd/nyCw4DLPpWXLs+oQ5YXovRoVzlfpaBzgZEI99PRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGtwn3tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC8DC4CEE7;
	Sat, 22 Feb 2025 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740237108;
	bh=Q2hK+km+jo/yDhRePX44cxY1UgC/saBtoq3maZwiL/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGtwn3tDIjriKplE90Dkh0ZjmMwV18p+U02ZU2whua+aKyfzuKzkVKCmusItsM3AQ
	 Pycmb67Gyc5e6WTkZg2T2DR6hMhccLf8MckdU4NuCNtO5TcSplGrI3zda0b3UEL2nj
	 3q07rc2pMhol9JQr2Jv9CAj7r2cVCzxphpI+KHWLRzb2VTEO5t72tRVc/At8LLoh2q
	 Kkuy6wL/yedCzj7iP+Trwn8dNsffAZmG60X1SOiL+TVuuLYubBBsXG8k7zjLcPyDev
	 c3Zq7V6gcT6XTytp+fKlhgxrZG0Bk8Ss8a0zGZsZ4FnKt6z9yO3altj/SaEgBHCbf3
	 C0UeW84g8vy5A==
Date: Sat, 22 Feb 2025 15:11:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: Siddharth Menon
Message-ID: <20250222151143.7ca7f718@jic23-huawei>
In-Reply-To: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 21:23:35 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> subject: Permission to work on dt bindings for staging drivers
> 
> I am interested in applying for GSoC under the IIO driver project.
> 
> I have a couple of patches that have been merged into the kernel,
> and am now exploring DT bindings.
> 
> Currently, I am working on Coding Task 1 (sending cleanup patches).
> While running checkpatch.pl, I noticed warnings about undocumented
> DT-compatible strings.
> Would creating the appropriate binding count as a cleanup patch or were
> they left undocumented intentionally because they are staging drivers?

There has been a long term reluctance to pin down DT bindings for
drivers that are known to not be in a suitable state for long term
maintenance etc.  So I'd skip adding bindings for these. Also
they tend to be far from what I'd call cleanup patches!

Some of those staging/iio drivers will probably get dropped at somepoint
so before doing any more major work on them, please send an email to
check they are still of interest!

Your email motivated me to take a quick look.
The accel/adis16240 is now marked obsolete at 
https://www.analog.com/en/products/adis16240.html
I'll send out a patch shortly to suggest we drop that one as unlikely
anyone will expend work on a part that is getting hard to get.

The other drivers all cover at least 1 supported part.

Jonathan

> 
> Regards,
> Siddharth Menon
> 


