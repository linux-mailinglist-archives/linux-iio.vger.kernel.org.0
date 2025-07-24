Return-Path: <linux-iio+bounces-21941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8FB10829
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA0E1CE3924
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379C26A0AD;
	Thu, 24 Jul 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdoKYBpY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D026A08A;
	Thu, 24 Jul 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354404; cv=none; b=XONchz0D0uBP90qLl2nZb0vHhy4XSZhq3VCicNrRgFlt3W8/B/TlbG/JxUqAoS4vKUNgDJnifcHR/pL/0Wd3lL9Z4ndmLgMgGQgzbYHjgrPLqTpq9O+v4QULeoGjW1knk8ElFJpiH7xx6DoJ5HPTmG5I33p2b6nKtl9fzsBYiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354404; c=relaxed/simple;
	bh=4nnCMJQi9LXg3l5GDgFIPesipEiSOxx6BZIee3cj3tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDJ7HiSILxKq0xbL9C3TgmhOJuFQHRgBHq5glN0dgH26z4nY84TeWrZR3NlADxzG+Rb4FgXxWdI2q304M9U6fdbn3dKt+mmiWzSqWGKQwBtFdDrRrAZlL6agaxnC6EM5xPXlpfiGSzn4UCQZoLfVCThZM4SMbgapwoGWUaxmeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdoKYBpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A20BC4CEEF;
	Thu, 24 Jul 2025 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753354403;
	bh=4nnCMJQi9LXg3l5GDgFIPesipEiSOxx6BZIee3cj3tA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rdoKYBpY/43WN7UlSmqABa2P+hQU8hTL8XrH9BLGdinKYOlIOU92XnEry1uGRbPp4
	 vq06FcYMGSRmK9DJvjeAt0ggsP53mn0blb6Yb+WtaYj6497xRVZ6bBQWaG6oW/LFz8
	 N+c4Lof3uRJOE1kiAZ4JcxfoLfk9rWmLnw3JFzc/ujD3mqqs2ObzCt86btJUhcRO31
	 iCPys6Id7hYeFpbjenhWMTNXZ8fJ/SeFPKRy01LJTd0oQLdmT/SZjo9sZcVGFVzotN
	 92pN4vtGS5a7xuKRadg8U+6jeT4tQO/XMZVU1jGbhUVIYgjTo3ii6Mmtx6Id8o+jAO
	 BtZr8E9/+WGZQ==
Date: Thu, 24 Jul 2025 11:53:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Song Qiang <songqiang1304521@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: vl53l0x-i2c: use stack allocated scan
 struct
Message-ID: <20250724115317.5985f9bd@jic23-huawei>
In-Reply-To: <20250722-iio-proximity-vl53l0x-i2c-use-stack-allocated-scan-struct-v1-1-42f127a6834f@baylibre.com>
References: <20250722-iio-proximity-vl53l0x-i2c-use-stack-allocated-scan-struct-v1-1-42f127a6834f@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 17:26:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a stack allocated struct for the scan data instead of using the
> driver state to store the struct. The scan data is not used outside of
> the interrupt handler function so the struct does not need to exist
> outside of that scope.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git.

