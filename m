Return-Path: <linux-iio+bounces-24312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38996B8C64F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 12:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D7658237B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3B2F83C4;
	Sat, 20 Sep 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7frzAc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999E34BA2A;
	Sat, 20 Sep 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365903; cv=none; b=QuKdp8A+v0z3Lh7ADslJwDWOs8jHKbUeF38f0+6b6YkBbiZFkOCdTbCw4BCJ+xWHMpN1mXxRZABrXpZW9+o1iJrsmhvgbrfaZ3two+YIL7Ie599Vy0B/69gwiSTeyyyz0hJX6Yy4lnb7HC6fzH5b3yCTWp6gOu/nEKRbmommS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365903; c=relaxed/simple;
	bh=uE03hdjrQBgWVV3gdYRVlDj5DHUKodItPcgLn5ZptcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnB/1M2PytZ5tPYU2h8K6J22r9EdvnLUlQSs3UazXBcOJLSTXSaBJjSPp7wflpB5EYVQbDt+3u7gMY6gELt/5tIVQexnmp/Uc3Scp0smJf2MdL7ChkbfXGhYwyix7EkJ8fnuhk8qGm41EXxTXTE9e1FNEpmFn4zCdgW45vNTDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7frzAc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F02FC4CEEB;
	Sat, 20 Sep 2025 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758365903;
	bh=uE03hdjrQBgWVV3gdYRVlDj5DHUKodItPcgLn5ZptcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7frzAc5ANy+M7q1TdLrWDtVxg28PAKTOEZCDBQplUz02Agf4oFs7AfkC/c7yAhyy
	 aTGy4LkBQgD8CitzqiYi7fll2wuz2LOyDF7LzDnskumZ2golGsh/PY3hhL1SE1/tMf
	 Skmk7c5VpAk1IKQ4zo8bBoV8BEnJmfKsuSwBjNZ4OV1MK2mpRJynwtuH+2wYgAIXC6
	 gr9dg2WPXyZtpB53C/rzDbOtNCZoXJe/DrQoC91lhqB7zaVstXYwBXfprAZhzsqeMd
	 2qVZAAja5VHCet+FdMreCcA+8ZlyezERC8Z1M9rYg7X8h7+n3VxGh7K9iXkINcrNgV
	 cPYMY2BzAOpLQ==
Date: Sat, 20 Sep 2025 11:58:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: cy_huang@richtek.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Hsu <andy_ya_hsu@wiwynn.com>
Subject: Re: [PATCH] iio: adc: rtq6056: Correct the sign bit index
Message-ID: <20250920115814.2cc3beae@jic23-huawei>
In-Reply-To: <c18d6200-3f42-4a84-bc15-627d1a4174f1@baylibre.com>
References: <7e43ad09f814d63b570ab6b2b9fe3fe17775d22d.1758164614.git.cy_huang@richtek.com>
	<c18d6200-3f42-4a84-bc15-627d1a4174f1@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 07:45:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/17/25 10:10 PM, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > The vshunt/current reported register is a signed 16bit integer. The
> > sign bit index should be '15', not '16'.
> > 
> > Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
> > Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 
Hi.

I'm not planning to do another fixes pull before the merge
window, so I've queued this up for early next cycle and marked
it for stable so it will get backported.

Thanks

Jonathan

