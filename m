Return-Path: <linux-iio+bounces-19869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D2AC3429
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B9B188E74E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B151E7C05;
	Sun, 25 May 2025 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK48NZJx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8928EA;
	Sun, 25 May 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748172093; cv=none; b=Y3UNcNfMibGKhxLv6F27jDKxHaz5H/CXcTkuKqQ3sAYIaUMHWoZjDXNXaCDj62SqKY0visTTp+f1D4yax2Ri1qgKxWG2e/O+wvF2RKXLsCk7/rHmmKkb7+Kt6hYhhAAzvjsM/OGddrQPsQYP8LSqBZVm770Obp5s2LC6en7qafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748172093; c=relaxed/simple;
	bh=PnXQYEzpz5cweYYe1Muan8uhRd3NrY45mUGBt0yYQ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKaZFWFeJaNG/xt7JtLNsfZxnYV2BGw4mwlIxpeQwciKMjDeSSvM9hUgHblV+tX6g3V3UrG/jVGt384YNlXA8kTcmBLF1YSzYbRp0KDiXiMuARg6KDFQbqcLnedBtofFmMBTRtycEHY3gu+LUrSPNfRJLNKMougfScIrsmmnrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK48NZJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571F9C4CEEA;
	Sun, 25 May 2025 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748172092;
	bh=PnXQYEzpz5cweYYe1Muan8uhRd3NrY45mUGBt0yYQ5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NK48NZJxsMyd8NjUFIqYduCKVXHsNckEK7a3Mh5D8K1WQc2KzcAHfhmuKB98I5jUj
	 jXnkdTIN1uTFu+fL2NsJsIPwjULfBg/p4Gd6j7m64WQuongpAoDSVOKkZmYPmdc4Kw
	 OfENLgMQlqPGeA2FTlOXPUIT19Hr5WwE38iljk7XEWmX79HZhfQ/rUwVIR2SN+ulXB
	 E++Y7nswpU910/9JBmz1795YLU/vU7kPGuqRg9AQFwaavZGtuJqyUpFETaO3EYE+4A
	 7TYCLhH3X2gePg66FYEiaCsXrhpV/V9OrnmfYxE29mw/ySk7nfBU4ztFDPsbt0ackk
	 uXCeigDycTPkw==
Date: Sun, 25 May 2025 12:21:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org, Fabio
 Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: max1363: Reorder mode_list[] entries
Message-ID: <20250525122125.201114e2@jic23-huawei>
In-Reply-To: <b6113648-1832-49eb-a14e-460c388c3e53@gmail.com>
References: <20250516173900.677821-1-festevam@gmail.com>
	<20250516173900.677821-2-festevam@gmail.com>
	<b6113648-1832-49eb-a14e-460c388c3e53@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 08:02:33 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 16/05/2025 20:39, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> > 
> > The IIO core issues warnings when a scan mask is a subset of a previous
> > entry in the available_scan_masks array.
> > 
> > On a board using a MAX11601, the following warning is observed:
> > 
> > max1363 1-0064: available_scan_mask 7 subset of 6. Never used
> > 
> > This occurs because the entries in the max11607_mode_list[] array are not
> > ordered correctly. To fix this, reorder the entries so that no scan mask is
> > a subset of an earlier one.
> > 
> > While at it, reorder the mode_list[] arrays for other supported chips as
> > well, to prevent similar warnings on different variants.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")  
> 
> Same comment as for patch1/2
> 
> Yours,
> 	-- Matti
Likewise, dropped the fixes tag.  Admittedly that's the somewhat lazy
option.  I'd less fussed than normal on this because the worst that
happens is we print warnings and sample more channels than strictly
necessary.

Jonathan


