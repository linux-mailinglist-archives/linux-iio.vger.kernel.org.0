Return-Path: <linux-iio+bounces-24965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE6BD048D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CAA3BB0C2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A328F935;
	Sun, 12 Oct 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/wV17n/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D81D5CD4;
	Sun, 12 Oct 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281584; cv=none; b=REcQnaOWSpg+zGk38Uwi7P2ZzVNHI9b3borQgAtdNwy2t2rSF2+wMdpVHdYpvKs81vO6l0Uv1rUEqVpjIpAP8J53+oKiZYvWO4RCcqNsoUs0JLjo1XH0ecAInhjik9CLMvNl0TqBorIHS0qfegJd/PboWveblwk+gkX6fUKdqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281584; c=relaxed/simple;
	bh=QNg9G/nkvSS563f/f2I34o28v/wp4zJ3b8ht7+bMuzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDPYFVg93Upt1iiuf71lbw6W6LlU6FSI3AWu/wSt5zMyiyggkrZfCF1Jp+ZnZMwMeZPQnfVpS4jot8u6YYg9O0rrmL/2rhbfZpPqCt80G5G3nFK96azwOeCQt9zaXP/BicR7yY7CyrrHgykg5rTvYTJwLIDqQW0RmOW1UA2oyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/wV17n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380EAC4CEE7;
	Sun, 12 Oct 2025 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760281583;
	bh=QNg9G/nkvSS563f/f2I34o28v/wp4zJ3b8ht7+bMuzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/wV17n/iEY6XYIQr3tebI0r3HB994fPhQj1pU0QPbUNhblp2SzlD5IeI2p7zMf0U
	 qtRIDMdhZkBaHU1tORd6BPpSPvdmhv8WTFEnoz5YGoc23TV3oIWFe5Tx+EwaZ/7CV1
	 nMUpc1peqVgIEEs+t0pz41pnLv6NLtd3kUKRA/e25FL6mDEDnpaqSYl27OQHd5SaxG
	 XT6r+bT2YtxWKcPDinHUMDOuTw4RdZ/EMYU+ZvWX4HHJwbMgl41sBH84bGsz3Dm9Tw
	 Ab5OlRrh6W4OJPZRZai5YWMqJ6wpPhWPcnZNNAJXp7oaD6sUuAmZp5SCNcyqhLyW2s
	 YPjbrcppMeJBQ==
Date: Sun, 12 Oct 2025 16:06:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/19] iio: accel: bma220: populate buffer ts in
 trigger handler
Message-ID: <20251012160618.4cd15ad3@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-12-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-12-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:21 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Populate buffer timestamps in trigger handler since not all
> triggers can run the top half handler that provides
> pf->timestamp.
> 
> Fixes failing unit test that triggers based on the INT signal.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
I hope that we will at somepoint get the generic code that would make this unnecessary
but it's not there yet so fair enough.

Applied.

