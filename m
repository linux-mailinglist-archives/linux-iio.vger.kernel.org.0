Return-Path: <linux-iio+bounces-7723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F133C9380CB
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D9281B15
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310484A52;
	Sat, 20 Jul 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqLVkqwn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133E5FB9B;
	Sat, 20 Jul 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721472385; cv=none; b=RPULO+m7F+zb6V+YQbfZ/t+n1qHD19T6PIT4IEYuCkJw/vSR/Oec0RasuNzkwu0FGGhRWJvCVXjE3wYUIo+DFWz7UXPjqd/Hl0qfWRA6scDNY2ByoPN8QWKSUGoWZACEKXOeyH8kv6wySfHDR9qqvfPSbjbjbgjco0EjRwKV+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721472385; c=relaxed/simple;
	bh=addw+UV070SE9KBd9DI/7W8xv9e6PI3NlKQHVV5pUps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD+PMP5Qst7FHF0KEttmJbL0iqdJ938boVwXdaYC8HR0dNEecFIvmTKJbLphltGsCkqpwvag4uP83qJQm5015x9CNGI4NE/2395jwwrG8cdoG9U222Rsy4gYPARwSUzuUa5Telyy8HFwctrTsTz0nIGBTHWVS6RYgt8DeTysFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqLVkqwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C075C2BD10;
	Sat, 20 Jul 2024 10:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721472385;
	bh=addw+UV070SE9KBd9DI/7W8xv9e6PI3NlKQHVV5pUps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqLVkqwng42PKrDzFzUuR3mjoqJ56VFAqsXnrKlPDtnpXXjnDaEXQCKMWnAQIF6X1
	 ryZIxEeqcvGB0EpRf/bZ9VL6uuQ9j7TGmvrg7TypYsaKYRmJhH4682L5dgsHw3Mqsg
	 gPdimcC8TQWJbn/I89tUEQ47Axatry02MG3MM95oO82Ebntk1Rze05M7SFnLgY9BvH
	 HoKcQmpVk2gLHFVM21HXPGfbUocYa6+WNnVU8dcf3U/zKBvpBkAAIvZRh8Iku4kCnV
	 9IUAIxn8Df03RpoIbQwZr8Qk3tQFjUwMeKQDsF7H3xcU7ncVAzusjKXdlw/UerAYZC
	 a38SWESCw7FZw==
Date: Sat, 20 Jul 2024 11:46:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v4 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
Message-ID: <20240720114616.33fa8e08@jic23-huawei>
In-Reply-To: <20240711-iio-adc-ad4695-v4-2-c31621113b57@baylibre.com>
References: <20240711-iio-adc-ad4695-v4-0-c31621113b57@baylibre.com>
	<20240711-iio-adc-ad4695-v4-2-c31621113b57@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 14:15:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
> The initial driver supports initializing the chip including configuring
> all possible LDO and reference voltage sources as well as any possible
> voltage input channel wiring configuration.
> 
> Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
> is supported at this time. And reading sample data from the ADC can only
> be done in direct mode for now.
> 
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
My line length gremlin side is active today. I rewrapped a bunch of
places where adding line breaks kept lines under 80 chars without
affecting the readability.


