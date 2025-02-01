Return-Path: <linux-iio+bounces-14802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2B9A24881
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00A3A4C77
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA39146D55;
	Sat,  1 Feb 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjjgUJXO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089224A3E;
	Sat,  1 Feb 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408833; cv=none; b=VPWN65M3ufOZ9YC2n6QlAp9V8/WHkO5qslMEz5MrhXxlZ/gfPWCgb2f6NJmfPnAe7gYI2g/Cg4g331kLugld5PMpo0HGLmfUi/PecbLFPppRf1lXcGg4GBMvqFvZxW1944YlWvFHTVmbFQvYr+KCKICkTImnndgafFi5vbve1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408833; c=relaxed/simple;
	bh=EPGKkzRGnArATFcQrMGpntjK1Jx5rNPGp2FvZq3TkqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k58dDQUmnO4Pn11TcayZUPufEo56f2PZG1FhDEt06Ny13DzekVLC8Ak+zBEJ5mH7UXkfW2rwh4jZt09bf1LlzE4XtHaUNKWaae9/ScXiA2UYnOhyVlLeFVp0wgCpNuaA56Vy+XSa8ErmCsphLuKsZW2addRh7ar907tQpItKLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjjgUJXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F0C4CED3;
	Sat,  1 Feb 2025 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738408832;
	bh=EPGKkzRGnArATFcQrMGpntjK1Jx5rNPGp2FvZq3TkqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UjjgUJXOtnYWZes/IxmqH2k+gOBVeFKrp7N3b0itki6rMSn0myagJ202YNo83Ey6w
	 Djxu15lHpDfgaM1lcoBZV6hHrWKtbCdyA2u2Q3mONel1yHyTtW2ngqQmQXftudnB2k
	 D6WiSQq/xaIoFWGidJ2OWtATcdl1iQMgwlIHBjc8MojHZL42y89/7VQFbj+EV5c/ys
	 m9R95q8JJ8+bT8pP/XHMSQGqf7wwv0+aotICs107cUtR8XilZHaUSFRE2PvlP3FGzr
	 YtpsGKSJVy8p5KHI7HCy00ys6CqzaxavENj2FfJrqE3bOLbIgJ9cuflIkX+5blbhtE
	 xjaLXjrzkgI6Q==
Date: Sat, 1 Feb 2025 11:20:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Mihail Chindris <mihail.chindris@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad3552r: clear reset status flag
Message-ID: <20250201112024.45fca2ea@jic23-huawei>
In-Reply-To: <20250125-wip-bl-ad3552r-clear-reset-v2-1-aa3a27f3ff8c@baylibre.com>
References: <20250125-wip-bl-ad3552r-clear-reset-v2-1-aa3a27f3ff8c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jan 2025 17:24:32 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Clear reset status flag, to keep error status register clean after reset
> (ad3552r manual, rev B table 38).
> 
> Reset error flag was left to 1, so debugging registers, the "Error
> Status Register" was dirty (0x01). It is important to clear this bit, so
> if there is any reset event over normal working mode, it is possible to
> detect it.
> 
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Applied to the fixes-togreg branch of iio.git and marked for stable
inclusion.

Thanks,

Jonathan

