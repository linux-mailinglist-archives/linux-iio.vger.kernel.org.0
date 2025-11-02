Return-Path: <linux-iio+bounces-25796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF35C28E12
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43973A9AC1
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF182C0F73;
	Sun,  2 Nov 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0lmWSxI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5A2C0F60;
	Sun,  2 Nov 2025 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762082584; cv=none; b=GwjaMIBsYGdYHhNDJxecVtsnJ6fe0APR8UL8C8y3Qizyh8YZWjZ3W++sa7ixAxjrk/+dZQRwqRidlBXcanQGVF7Ty61Ay2pkmCpih+hycpgBwme7g3LkhwRpI+54CsZYsPKocCfQAvrEZqPwSSKQt4370sFluxuoNJMcOvpESXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762082584; c=relaxed/simple;
	bh=f7AGp89xtG2umal3kofhTXQmZHfJxW/OjnpUSWAEZVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI+CTmVv1U6cGnzz4K9RhHAu4fC9Wz4GhMCdPfVQgXaIJoaApy6n9HVzAyMvZb26bZbQNaV3K/T5RfvlQqc1hUpAze20lgDeTSplKJmpnIs+8p2hRduuf9wuAZw33P594cKcgRtKjqF2eoery2AVt5OmwUv5S+6IcF1ngRRp7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0lmWSxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE70C4CEF7;
	Sun,  2 Nov 2025 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762082583;
	bh=f7AGp89xtG2umal3kofhTXQmZHfJxW/OjnpUSWAEZVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0lmWSxIt9+Zs8GyAfCSdMfmBtpXChLYy+oncuDS0GRjG38C+D/3iz6nxEHD8U90P
	 WBcddS035n2bD3U0yykKEjEKkuHhyygwB7zKPhWw+jvgUaP5iPzsxZK138dvY1oPPT
	 2avFzedWEL/eCq+mLDCMwcmSAcslsULDfI4ngJTKG3pzL2ZUa7AHkWdMBwUV3ufs5Q
	 bAZTts8FJgFCoBTpUCfgh+W4k6AI3OG+bshYIVPi/tvSybgSrPY7HvKUemFjChIxG7
	 w/r18lMsjNPAta7io7X3OuB7CEk6IavQm9Bm5D+iuIAS0AZTWTQgTINoVdX4CBnrh+
	 JFPSwn3emQuCg==
Date: Sun, 2 Nov 2025 11:22:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] iio: imu: st_lsm6dsx: dynamically allocate
 iio_event_spec structs
Message-ID: <20251102112252.24138fce@jic23-huawei>
In-Reply-To: <20251030072752.349633-5-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	<20251030072752.349633-5-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 08:27:47 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In preparation for adding support for more event types, drop the
> static declaration of a single struct iio_event_spec variable, in
> favor of allocating and initializing the iio_event_spec array
> dynamically, so that it can contain more than one entry if a given
> sensor supports more than one event source.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Similar comment for this to the dynamic channel creation.
Unless it is really quite a large number of combinations I'd normally go
for separate iio_chan_spec structures with pointers to separate iio_event_spec
structures.  Whilst this adds a fair bit of data it is easy to review
as set of such structures for each device against the datasheet.
The code to do it dynamically often gets really fiddly as it has to translate
between different representations of the same thing.

You tend to get a device model specific iio_chan_spec structure array (or a set
of related devices share one).

Jonathan


