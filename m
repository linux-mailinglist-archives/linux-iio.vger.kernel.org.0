Return-Path: <linux-iio+bounces-28022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF563D3BA22
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59F4E300B9C9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EF2FBE12;
	Mon, 19 Jan 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDJiW44V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFD26B0B3;
	Mon, 19 Jan 2026 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858728; cv=none; b=XTZWfAeBoSQxXH4s8DV48SXj5WMpXGAFZoKDOAv0wqkpu7EUNJtAF9epEUKdwB8iT1ymKUxeDDUtkqYZJZqGeY0JjL55o8rZa5raMcGlynbk5dDCf90dBu8HEM/JAX7qWu8UN7K8SMnqtD+JMuPxsfHjQURUP6XFyMzVxwunAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858728; c=relaxed/simple;
	bh=cy7xeGkEN05Ai4z5AEgtdJWUp33QkqeTsicL5QHQwM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn+E+y2xyakp+4fWbH9KcOch23DnvrjcldM8Ddl5+rG+l83rKkMSnGdKjmsXqBHRK8WALIcoi6TXhUFpqzNL5nklmoTsDK3hkGMpaHaWQYYXhD6vuX4Lai9RUOsMM6zFyaW5uP1Fazz4pnVnmfcX8wW1L/7BCyl4h1ssdXPG/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDJiW44V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9275AC116C6;
	Mon, 19 Jan 2026 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768858728;
	bh=cy7xeGkEN05Ai4z5AEgtdJWUp33QkqeTsicL5QHQwM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDJiW44VRLmL1Npyk+++l/QzMXAN9TmDT6b1MkWUHBTzulg9wCuJtFEaHIijb3m3a
	 TpgDRJLOeLoNCPgWfTi5+0fWIJHc5SelrFoIuAuEyIFtu5mJqYvhmty1DLWWMLQo3k
	 Dc0I+1IHUMjmLDoxgHaSOXk1M6eSPAtPtbj8hvyJxgHfEk17XlCa6+27JSSRBMuF0O
	 Anfgm62XTCQEXm0k1AdaTwGvTQK6u8RIOnh6DMAVLjmUeLhf4VekEVwuRP1CdBQje1
	 dEyWAC5TSsha8I4Vp6Q+LP9/4+x7uAo2FNypFsCVPMEd0l46SErS24mojRwNRfXP23
	 tvCGLQUs1uAog==
Date: Mon, 19 Jan 2026 21:38:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, brgl@bgdev.pl,
 conor+dt@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
 dlechner@baylibre.com, jorge.marques@analog.com, krzk+dt@kernel.org,
 lars@metafoo.de, linus.walleij@linaro.org, linusw@kernel.org,
 linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH v4 0/9] Add support for AD4062 device family
Message-ID: <20260119213836.52a641fe@jic23-huawei>
In-Reply-To: <20260117151232.215213-1-sashal@kernel.org>
References: <20251227163506.2fb90815@jic23-huawei>
	<20260117151232.215213-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 10:12:32 -0500
Sasha Levin <sashal@kernel.org> wrote:

> Hi Jonathan, Jorge,
> 
> Heads up: the AD4062 driver uses the deprecated I3C API which was
> removed in commit 9904232ae30bc ("i3c: drop i3c_priv_xfer and
> i3c_device_do_priv_xfers()"). This causes build failures when
> merged with trees containing that commit:
> 
>   drivers/iio/adc/ad4062.c:471:24: error: variable 'xfer_trigger' has initializer but incomplete type
>     471 |                 struct i3c_priv_xfer xfer_trigger = {
>         |                        ^~~~~~~~~~~~~
>   drivers/iio/adc/ad4062.c:472:26: error: 'struct i3c_priv_xfer' has no member named 'data'
>   ...
> 
> The fix is straightforward - migrate to the new API:
> 
>   - struct i3c_priv_xfer -> struct i3c_xfer
>   - i3c_device_do_priv_xfers(dev, xfers, n) -> i3c_device_do_xfers(dev, xfers, n, I3C_SDR)
> 
> The struct fields are identical (i3c_priv_xfer was just a #define
> alias), and I3C_SDR is what the old wrapper used internally.
> 
Thanks for the heads up! Given this driver was quite a way back in my tree and I'd
rather avoid a rebase, I've sent out a patch on top that makes the changes
you suggest. I'll carry it on the iio/togreg tree now just to avoid causing
build mess in linux-next and just rebase the top the tree if any issues
turn up in review (or to add tags)

Cheers
Jonathan



