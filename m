Return-Path: <linux-iio+bounces-25013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E28EBBD0AE8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF42C4E9D0F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0512874F1;
	Sun, 12 Oct 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDBURIjf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274541ACEAF;
	Sun, 12 Oct 2025 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760296721; cv=none; b=my0IcBIRzd4b2FwSNgp9onZquigJmrmUGoAANiAh2NxtOL/7G+X0FLrk2W854r7AFK4hsE4BP93jvus/haFEjeZHmVityh9ek4Wbv2yt9zd6pWsxdGAOB4HaZgIzyQ21DCYW9fD7ZlmireDyfLFSp2zZnnsgUY1MgI6h1FLVkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760296721; c=relaxed/simple;
	bh=4+rrkH06EFTUiCHeYWaZuGT0k3A5LDRmRpsNCoA5toM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC9NmFfODFWR5kcNTuh9iw7GtqVKaaVu/MMLq3pf60UOk+O04PYAlWbZUMQMUfMs5Z1tgiN4xZP+Pc02K7ixKzlO5MLNUYrObjL46/X8NgoTldaONTM1GSVw67yvskwVi3T/gOD99VySJJ+P2HfdFbflXarfWMZcEMNNH9DbEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDBURIjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131AAC4CEE7;
	Sun, 12 Oct 2025 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760296720;
	bh=4+rrkH06EFTUiCHeYWaZuGT0k3A5LDRmRpsNCoA5toM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vDBURIjfKvwT/Ny+h6FIMNSMzNaVQUwoof6TvvLnB+3AtqLKkLaHYi9TicQuS5dkB
	 Imgi350MOwgX8L3tgbujhzHDQl9kn0R2xGdW0BaH73zn8jhwktxe6bpDpDlxFSlZ1x
	 rrNGlQK6eUai/iYfNJFv3+0WSfLIzjBNMLrF3Aq8STanU3vMeA55Ft1zM8qFuOVLNv
	 4wd3nf4twu1VMX6CkzfVeMstN992Dvm8ZS7Mo3zZjv5zqQX2mVH+Eca8odLlGMBAFq
	 UvIsw87BZ1NATELpaKffDmDqckIMDewxosgIwGvhbis8QcJACBL1o4oRqqqOo8YM3Q
	 ayRqs06LzwwIg==
Date: Sun, 12 Oct 2025 20:18:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads131e08: return correct error code
Message-ID: <20251012201833.470ae60c@jic23-huawei>
In-Reply-To: <20251011-ret_val-v1-1-8e968b38790a@gmail.com>
References: <20251011-ret_val-v1-1-8e968b38790a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 13:41:49 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The error code returned from devm_iio_trigger_register() inturn
> iio_trigger_register() can be other than -ENOMEM. Hence return the
> same value as it was returned from the function call.
> This change makes devm_iio_trigger_register() handling uniform with
> other iio drivers.
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
Applied

Thanks,

J

