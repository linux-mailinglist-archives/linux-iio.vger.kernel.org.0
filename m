Return-Path: <linux-iio+bounces-16590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3977A585C8
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894903A648C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1DA1D61B7;
	Sun,  9 Mar 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUKHRJDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0E1FB3;
	Sun,  9 Mar 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537151; cv=none; b=iS4o44Pq4KIS1LyVA0WBw3+PBrPbd0/c6ECoR0IiLQu+9A9rIj6GkcuX+JDiNzoCQXhGrsJODwq0hHbxs08/AtL/zJRZibOW9qU/fuDiq1eL+Z53+pJOWyxqO6S/UgTm/NRBWKGhCgndNA6c/KMQmr20+4kZkWUI5owTkZcUMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537151; c=relaxed/simple;
	bh=b63ExwUFEQ/ox5h1ORFbZVPiaUUaeRxOj12qcgx53jA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7Wc8L0wrcaNeLqNWzDorzGojXrYC5/ELeOMzv1q09AINOLbErkHSNeedBDNN2qP5CJ96/FUsjaBP6JZ5AsAUPna351l+rpi5wLL8TNslrhA+S+xtcbEftW2RrqP5i7avdWgRRqm4YiSc04DlmZ6IR9NcXTc2M9qCfxBw0zB8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUKHRJDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB03C4CEE3;
	Sun,  9 Mar 2025 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741537150;
	bh=b63ExwUFEQ/ox5h1ORFbZVPiaUUaeRxOj12qcgx53jA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NUKHRJDPsWncPDeYbHfi2HDK+5Ru/yb5cSze2tNx7klh2alTG8e/e3tGO0PUFTa9Y
	 f8lzhzI7E8AasXph6PUanHvhWWqu+Np6NjMrWevxB1+nHl8GlNzG21Gj4/ZKCWXb8O
	 BYFEesZCmO7NusnmzVHVqZe/bg4Q4ZwRYwZqfS3WG4goGzM/qlk1Nf1mfSAqaz1ztT
	 DZ1l1+Xc6TKk/V6tq7OowzA5Y+CkTf5eZw24sa0/41TobxS2mRn4yCGP93EpqP5ckL
	 zeS/Vvs5wxhGWDrWpcnJH5AJGBGL4S8WYBPJzszBz5Gj7L0S91/7C6VHg5jTLd+ms2
	 rxXcjpKxPIf8w==
Date: Sun, 9 Mar 2025 16:19:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Saalim Quadri <danascape@gmail.com>, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com
Subject: Re: GSoC Proposal 2025
Message-ID: <20250309161905.4b029278@jic23-huawei>
In-Reply-To: <Z8xh8jsz-NYYdmYT@debian-BULLSEYE-live-builder-AMD64>
References: <Z8U4mr1vO-TWz91c@debian-BULLSEYE-live-builder-AMD64>
	<20250306003130.1555755-1-danascape@gmail.com>
	<Z8xh8jsz-NYYdmYT@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Mar 2025 12:27:46 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hello Saalim,
> 
> On 03/06, Saalim Quadri wrote:
> > Thank you very much for the initial pointers,
> > I will try my best to contribute initial patches into IIO.
> > 
> > Regarding proposal, I wanted to ask, how to get a draft reviewed.
> > Shall I send it here in the same thread, or do I need to send it
> > somewhere else.  
> 
> GSoC candidates often ask for proposal reviews on the mailing list.
> However, as part of the mentoring team, I will not review draft IIO driver
> project proposals to avoid favoring applications of any specific candidate.

As I'm not a mentor, I might offer feedback if time allows but only
on a public list where other candidates will be able to see the
comments and have the option to take them into account for their
own proposals.  It will probably only be broad generalities however
rather than specific details.

Jonathan



