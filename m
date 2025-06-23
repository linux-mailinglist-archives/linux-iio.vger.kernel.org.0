Return-Path: <linux-iio+bounces-20917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09889AE4C09
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 19:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372BB3AF409
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BF2C3773;
	Mon, 23 Jun 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjLZ5eDR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39A2C158F
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700525; cv=none; b=pOT/BebljAA9DdnPvVhvgECdKK2i3vFcSBdu2BBuxczNP0E7sNlXWZPuFadGVn/KILdFW7o7a+mn9E3qV4k35K9EIb3LLzy42CboHWZic/e1UQMLzUtJchmEeZmWNvwFTLSF8kwAMoe+2aKNbkUF52NDgJn5GhtJeeGXYKJ3pHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700525; c=relaxed/simple;
	bh=fEzz/veYOYAKL1HlhPVi5dzlmIcRqMEkbkzd8hSM8Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qggxecL4oEAfW8VWk03qIXZTaMB8Y4a3oEqthQpGudMX1WAG+duzAr3mN4DJ+Tfr9y5TKf/xgv9EQC35UGQ+hBxkwYr6MYIsqg8+8pUmmCgKelpd2iiJLV/m3wYtNuBTk+S3sBQEfyNKMvgeJ/ysDn6xYad7HsedLS8CJnHf+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjLZ5eDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF8AC4CEEA;
	Mon, 23 Jun 2025 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750700525;
	bh=fEzz/veYOYAKL1HlhPVi5dzlmIcRqMEkbkzd8hSM8Bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjLZ5eDRqAHVy8swB7ZRUbrPCMbIZtEfHm7GnDDtzjAMQORkLTInEbUkE+DBzRrNn
	 PZwUpwxQ1AvAwsqFG0WJG2eFbJHhOm9EuIF277PAh5RC1jfDFWK0aV/shOxNONcJ2N
	 fJdZqDLaadOhsVRsxCdns05efNxL3dGgjeVG38QxA4t6qjRFlVM4pbKX8gKWZlq52E
	 G2w1speqwIBt+sXq3pEh4tnrmJ6tLjVEmWt3Z0bj8zQ7EjHcf7KjaS/SvwQWqj90cb
	 BYWzRQ9ZJDtHMIHfF5pMmIsnh2A9gmwCkxY5XKcyVCUwCm8wREDWYOAJVYlQuTKAUZ
	 6UmXmDSzj/7/Q==
Date: Mon, 23 Jun 2025 18:41:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: EXPORT_SYMBOL_GPL_FOR_MODULES() heads up
Message-ID: <20250623184158.28ebfef6@jic23-huawei>
In-Reply-To: <aFkwMyQ4v6i4JBG_@smile.fi.intel.com>
References: <aFkwMyQ4v6i4JBG_@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 13:45:07 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Pay attention to a new commit 707f853d7fa3 ("module: Provide
> EXPORT_SYMBOL_GPL_FOR_MODULES() helper"). This one is what we
> mostly need in IIO.
> 

Thanks Andy - I'd not registered that merged.

I was following the discussion that lead to that patch and
it was targeted at a different use case to our typical one in IIO.
I was to prevent anyone else getting access to a particular call
that was needed for modular KVM. It's about abuse prevention rather
than what we typically care about which is reducing namespace
polution.

Now that's not to say it isn't also helpful for us, but I'd like
to not rush to using it until we see if it is getting general
adoption outside of that specific KVM case and similar.

So let's wait a cycle or so and look again,

Jonathan

