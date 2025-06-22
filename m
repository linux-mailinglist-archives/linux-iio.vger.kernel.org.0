Return-Path: <linux-iio+bounces-20864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0179AE3063
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C79016F261
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D211E1DEB;
	Sun, 22 Jun 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efE1+PNP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAF1C2437;
	Sun, 22 Jun 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602398; cv=none; b=K0Wt2BydBly9ROLyb7jlQY+pikNKrdxLspU3U7vQeTR3SvqW8kVq4cHgM7k+Lg8ODXTmmSd/WAVIO0iWecBWlWJXdkA6rRz876R71nGzGLkvS274pXZ8VYY+RDYxLX9pMC0cRYQHxbAXWJAm/zEhWgxoGz5/cCBvOZ91gaDnkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602398; c=relaxed/simple;
	bh=rxMXe7GWBbBeIkqXFyJZDmmgHSr/pPCQ+m3lHill9Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icwfOTJt6aTKA4uZZPjsVotmHHZsYJepBmXcsSUQTGihbmwvrIQaEaMuU3ZQPL8VUKIk+aN3GhWV9aleY7GJUoqdnAC3ZCTsSvqknCPhfw3A89gaELdOby1Z6ZuXVFR23lUjUdzo9TwavjMKHc6HGsfBuI8DDmp617S0ncDlXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efE1+PNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF84FC4CEE3;
	Sun, 22 Jun 2025 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750602397;
	bh=rxMXe7GWBbBeIkqXFyJZDmmgHSr/pPCQ+m3lHill9Y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efE1+PNP+hW4cuCuXO7ePwOxSoP7eAPDzTDNNXX1e8aw5xo16MCh4FP8wxXx3i3KP
	 PtrkLuSmLlDYQ/AlMBF0CnVHOytrXDKA0n09RG0hAwBAqprdpH/Fgx7RzJuuOpf2Ub
	 jrDr8W+/cy4FPXsMni1+crLNtjM9yBB1ckOtAXFpXx0511G1nQtEaEljXxlUdamRwX
	 ljBCT/z12are86IvfptXGHZwJZEwE5W1AGtD2AwgYWBsE38BNgTcZA75DPmMcyWUpX
	 BqLuashAgkaosGGcsAM7AfBQfA71pFdXLiprMdBM2kbm5ta8DbmymW+xKq2xYYRzpS
	 aEYn93+4LrB1Q==
Date: Sun, 22 Jun 2025 15:26:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: simplify clock enable/disable
Message-ID: <20250622152629.70cd864c@jic23-huawei>
In-Reply-To: <20250620-iio-adc-ad7173-simplify-clock-enable-disable-v1-1-8bc693b190ec@baylibre.com>
References: <20250620-iio-adc-ad7173-simplify-clock-enable-disable-v1-1-8bc693b190ec@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 09:30:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use devm_clk_get_enabled() instead of devm_clk_get(),
> clk_prepare_enable(), devm_add_action_or_reset() to simplify the
> code as it effectively does the same thing.
> 
> We can also drop ext_clk from struct ad7173_state since it is not used
> anywhere else.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

Thanks,

Jonathan

