Return-Path: <linux-iio+bounces-18285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71396A93CA4
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DB3B3906
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D78221DAB;
	Fri, 18 Apr 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxXCbYz1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777921C18A;
	Fri, 18 Apr 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745000062; cv=none; b=aeG/pJcI3sZiT/sAep94JXhwT7jGjIikx/umRwbq4zfJwOvoYvithw9IpWKdq00vgibnXzvvWe7gKcJcixyd8ZNWkmMEe5Ku7AYKwgCFSrzQSX7myrn/9SdOsc4BX19IXHm/aE+Rp9xp2toBRFB4/3wiOmk+qfbXg33ma5NAosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745000062; c=relaxed/simple;
	bh=1vBnar/9xtJqF5Pl52RY5X2KmdSf4G3dV/3MlXqODMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgoqYkpEkdUEqcVBZNfqsnYsTtZSX0k7WUiWkDZFJZajwv/j6UaqAUJXJnjMGKlxLgwcASeyg1XdNV+Rota16YErn7fJjAGjdpyeJtyg2yrHpfqKZhPHwAL3KsQ0hFe6eziSPCJ/UxP+lcQHUvAta4sfRchGvgbBTGdH2msCE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxXCbYz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A14C4CEE2;
	Fri, 18 Apr 2025 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745000061;
	bh=1vBnar/9xtJqF5Pl52RY5X2KmdSf4G3dV/3MlXqODMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxXCbYz1/GiaZsMLnL8K6mfTPo/Osn7YfbXFPww47EpFsFM5kqbxYmU5S+WGZbVwl
	 QZ9TL43wLkk6HUBIoD2uuTxsr58qEgPDffDsXv/GmTwhFoLvRizYgnxWy55xf41x+v
	 CIT2484NtwIaKL0tCa6pot0P1mz84R3R2T+b4ouxx0CAKQ7GMArYuRNxcJnGssHh00
	 tH1bEf3w2mb20midqzlPN9Apov3fVjFnYllLqCnxekI5zHIpnha6bD+GxyPiOajb/U
	 7MA8pORipf5SOT4th97As4mhrqZHhj0SOLHU8xFjbRh4R1wQThbm16F5p6u1vO4y+G
	 IpXuV8w10Ue4w==
Date: Fri, 18 Apr 2025 19:14:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 04/11] iio: accel: adxl345: set the tap suppress bit
 permanently
Message-ID: <20250418191413.4a0a873e@jic23-huawei>
In-Reply-To: <20250414184245.100280-5-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:42:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Set the suppress bit feature to the double tap detection, whenever
> double tap is enabled. This impedes the suppress bit dangling in any
> state, and thus varying in sensitivity for double tap detection.
> 
> Any tap event is defined by a rising signal edge above threshold, i.e.
> duration time starts counting; and the falling edge under threshold
> within duration time, i.e. then the tap event is issued. This means
> duration is used individually for each tap event.
> 
> For double tap detection after a single tap, a latency time needs to be
> specified. Usually tap events, i.e. spikes above and returning below
> threshold will be ignored within latency. After latency, the window
> time starts counting for a second tap detection which has to happen
> within a duration time.
> 
> If the suppress bit is not set, spikes within latency time are ignored.
> Setting the suppress bit will invalidate the double tap function. The
> sensor will thus be able to save the window time for double tap
> detection, and follow a more strict definition of what signal qualifies
> for a double tap.
> 
> In a summary having the suppress bit set, fewer signal spikes will be
> considered as double taps. This is an optional add on to double tap,
> thus a separate patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied 1-4.

Thanks,
Jonathan

