Return-Path: <linux-iio+bounces-14209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCAA0A9A7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4171881906
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD2D1B6CF9;
	Sun, 12 Jan 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYrc9Dek"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65242175BF;
	Sun, 12 Jan 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689017; cv=none; b=ItFj5IBGpFgIPk3i+i99PvZCmXqyE7ba+S3HQmQfMv3+W4O+wcyu7NEyqXUGOesrtgDlfCKH6HOCtpDEqgZuGdHspqdrxojZeixRNvFl3HcloZvRJyEBu+nEFRFaTCVyLTyE7I5MU2XJ0Jf2v3sWcnT8v9XCReM/jRTcf2NQOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689017; c=relaxed/simple;
	bh=vPy1hLUG8wZU3yv68j8X5Uv0HM7tXsCpnV7gQBbFKhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9Rq8oyNhQhKq7mbkaRRLQsk4LxfrX1jMejjW0BIwhKuLpvNrNrdtZrQw58kmJYO8633tOLIk8UsOrXgkBiiOfyxp/H8g8goRE6MuGYIw3Gx/jJ74MNgMjigPckNrfnHAvgB2E4oqUQoCXlP+eWYOZIfOwBzRymBV8XFJTqHwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYrc9Dek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6478CC4CEDF;
	Sun, 12 Jan 2025 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736689017;
	bh=vPy1hLUG8wZU3yv68j8X5Uv0HM7tXsCpnV7gQBbFKhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYrc9DekIqL4ahEviBKf0NRinvmutVCuaT3zpeKGH1OHShFYs821xpkdUpU4jyXMM
	 UEGx7apekWNGCqoB5lUMYnyy4lrh34Ey72vwn29NyMskvJHytsIiznDXym+efSZkAW
	 iRwKt/ZGZRr3htQjnOz7ge1+ee2sCJl5URmhKEqfxuQln6rU7pQh884l68j1LM3sFF
	 grQvhdQyOeKI7cqjjrkNm4BDSk0SB7LwE3HQYqNF/D+T05u80n0Ir34vLPJ4zLwm0N
	 ZNwBUeK7Kf2CUsmqiglO7IY9y1og/meLUVeovTs5pUXF8qiqpii36FdrtNB1njK8jw
	 ucg0grAzeNnzQ==
Date: Sun, 12 Jan 2025 13:36:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Mihail
 Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] iio: dac: ad3552r-hs: clear reset status flag
Message-ID: <20250112133648.7ae8f9c1@jic23-huawei>
In-Reply-To: <f4b036e5-ed01-423e-8211-b6b24931a27a@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
	<20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-2-2dac02f04638@baylibre.com>
	<f4b036e5-ed01-423e-8211-b6b24931a27a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 14:51:00 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Clear reset status flag, to keep error status register
> > clean after reset (ad3552r manual, rev B table 38).
> > 
> > Reset error flag was left to 1, so debugging registers, the
> > "Error Status Register" was dirty (0x01). It is important
> > to clear this bit, so if there is any reset event over normal
> > working mode, it is possible to detect it.  
> 
> Do we need to do the same for ad3552r.c as well? Separate patch of course.
> 
> > 
> > Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the fixes-togreg branch of iio.git and marked for stable.

