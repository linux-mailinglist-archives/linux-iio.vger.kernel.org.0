Return-Path: <linux-iio+bounces-22868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A4B2942F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246D45E3BF5
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E092FF651;
	Sun, 17 Aug 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJublttu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77552FE079
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448656; cv=none; b=BOVSAsrpFg89o5IGvlNy8ebCQxgLKT54r8dITwmKLQcGrqwmaKyYqY9NNGkMfKG7nZAVtV3V4kvXxFBDbGtdUE5LewiWNiRlcoa6fqKf8pT868m7mvworZAFc0sB9jJPNZCPdPO36xvc7kj2FFvShPhUNCJdu6lc9OTGMXIOyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448656; c=relaxed/simple;
	bh=RwUv3Cw77EXzuaYUZdUO+lyothr6OWbQPJobbHfZQYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibvK4/jIhw5qBs+PRCupsKTyF5guJCtq8Vnf9OfONiTnx2rsSBxpl9tx/kFgIZ02fw+UuT2rf0VX3c4a+BoJCbvZnCXC9ILUP1xgX0kU6UqEo4VC0dSfO32Bb7ZLFzTPhFIOo7pf/3y2ViueiL33K+UnfVI3OeJQwOV2WhVR29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJublttu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE7C4CEEB;
	Sun, 17 Aug 2025 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755448655;
	bh=RwUv3Cw77EXzuaYUZdUO+lyothr6OWbQPJobbHfZQYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJublttuovuvcCE9LbdvM3z9QgMVgiAobwYHVNteB4Y5MdO7ItWZXhWNgVhYxwQmV
	 QDE8ZblM3mojXONvAP4ZSaw7DlkjLTO8JWQJdiLYAdLbOyeArZKC8JLC8nDCGsspjB
	 81/yHx4JUnJRt2xZFR8nZeyr2ueUPCw9BRuGIquG9wLNwV1ztUeJGl+XFw4KrFfbof
	 cc+qSKB1tkVzjZYck+4EQqv963uJ8cduprZdC2lc7TNgrAULgFfVcMiUwq9WKxMofM
	 HL9WPKni8NKHb48sb1x5nxMCPy+NugwxjI6Hfc/ajKiovQusDU5+SwovIHDT4x/WIW
	 XXqw5l+eYJyFw==
Date: Sun, 17 Aug 2025 17:37:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 6/9] iio: pressure: bmp280: enable filter
 settings for BMx280
Message-ID: <20250817173728.251e7898@jic23-huawei>
In-Reply-To: <20250810185846.114355-7-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-7-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 20:58:43 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> These devices were using a hardcoded IIR filter of length 4.  Enable
> filter_low_pass_3db_frequency settings to control the filter length
> settings of the device as done already for the BMx380 and BMx580
> devices, even though the 3dB corner has an inverse relation to the
> filter length.  Remove a superfluous offset of -1 from the internal
> handling of the available values and use the table entries directly.
> Keep the default value at the previous hardcoded value to keep
> identical device behaviour after module load.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
See continuing discussion on v1.

Jonathan

