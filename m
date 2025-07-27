Return-Path: <linux-iio+bounces-22051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2ECB13019
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197627A55E5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98131216E26;
	Sun, 27 Jul 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+uGytLq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237D7E9;
	Sun, 27 Jul 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753630805; cv=none; b=LNBCeU3otXl/TeXsspyIG+NS4l7wJxYMnryH7xYncgkobzP3X/hf/y07Pay07qTffKA9n7KO8B4GlUOutYeg0AnbIeH0klbGJXzvYuSxJjwt+4R2zVnYnTO0Il1v6qT4pCnj5dhvBZshsVl8ihPUYzfACr0T51tD5mddIBwIes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753630805; c=relaxed/simple;
	bh=EWVQpn8H5eFiOGbMApRsYkUIQj0EHLhsSn2WfoYfiYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMOvO/3UGDMpouNk/qmxe9DCXHVo0yCGpfyeMfvTJa/z5dyG6KPrHClW5Tpxu++fnl/UulnzkRsd91UXNp/bwvudZMDuTCs2Gd07xngFD2SfuQpqKEzHT1Jtfj4lkan9B3UaqVD+rD7mMEXFjfGY/j3v4Rob+IVxO/BGJCn7M84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+uGytLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A04C4CEEB;
	Sun, 27 Jul 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753630804;
	bh=EWVQpn8H5eFiOGbMApRsYkUIQj0EHLhsSn2WfoYfiYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o+uGytLqQoCpqSMM/uZsdZUJeac8b4OJefzR6DXvk9SfMlypTimvdPv2aMJh+BJoZ
	 JnbdZPnS9Iu6dgb2y1Pvb0sVPQpnuG4PAhLG3PLbeE5wnCuA6+p8g2nNMiU6iQEf0Y
	 4v2lG+7n2UdBDDitzmG1rgtItOe2U7vlWir1NNp5Mze7V4CkvSnmBj1PnURRYI2gu6
	 Ym+H7GwUUlsxgQt6EXuqicssXEZHQdakIGm42C1Q6vlGa8B3rS1PzFQOfzoBilGt+m
	 mGOkCBinqHm7+4FaWLz2pZpNASSUTcxEb32AjO6cC+yNvKoiyt9LgHAsfbEQcG/cdu
	 u2nAQHV3sHELQ==
Date: Sun, 27 Jul 2025 16:39:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: adc: ad7137: add filter support
Message-ID: <20250727163958.1ed6e764@jic23-huawei>
In-Reply-To: <fe3f5832-469b-4d8b-9d02-ea716c07c5d9@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
	<29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
	<20250724142001.72181c21@jic23-huawei>
	<fe3f5832-469b-4d8b-9d02-ea716c07c5d9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 13:50:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/24/25 8:20 AM, Jonathan Cameron wrote:
> > On Thu, 10 Jul 2025 17:47:14 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 7/10/25 5:39 PM, David Lechner wrote:  
> >>> Adding yet another feature to the ad7173 driver, this time,
> >>> filter support.
> >>>
> >>> There are a couple of leading patches to rename some stuff to minimize
> >>> the diff in the main patch where filter support is actually added. And
> >>> there is a bonus patch to clean up the ABI docs for filter_type first
> >>> before adding the new filter types introduced in this series.
> >>>
> >>> This was tested on the EVAL-AD7173-8ARDZ evaluation board.
> >>>
> >>> This series depends on a bunch of fixes, so we'll have to wait for
> >>> those to make it back into iio/testing before we can merge this
> >>> series. There is also an outstanding patch to add SPI offload support
> >>> to this driver, but that doesn't actually have any merge conflicts
> >>> with this series, so they can be applied in any order.
> >>>
> >>> ---
> >>> David Lechner (5):
> >>>       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
> >>>       iio: adc: ad7173: rename odr field
> >>>       iio: adc: ad7173: support changing filter type
> >>>       iio: ABI: alphabetize filter types
> >>>       iio: ABI: add filter types for ad7173
> >>>     
> >> I don't know why, but I really struggle to write this part number
> >> correctly. The subject of this cover letter is wrong, but at least
> >> I got it right in all of the patch subject lines.
> >>  
> > 
> > Series look good to me. Give me a poke if it looks like I've forgotten
> > to pick this up after the precursor fix is in my tree.
> > 
> > Jonathan  
> 
> Sure, no problem. Can we pick up PATCH 4/5 ("iio: ABI: alphabetize
> filter types") sooner though? I know there is at least one other
> series under review that is adding more filter types and I am
> getting ready to start on another one that will likely introduce
> some more variants.
> 
Sure.  Patch 4 applied to the testing branch of iio.git.

Thanks,

Jonathan



