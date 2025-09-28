Return-Path: <linux-iio+bounces-24522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6DEBA6E59
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF73517BF16
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9162DA765;
	Sun, 28 Sep 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjn5nNiE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1F221558;
	Sun, 28 Sep 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053208; cv=none; b=WSVl7/+Wm/RqFw7M8SRByLdBQwZCyu8pQrp4nfN9DAbMnwonx6Rr9dka4hfLGQypuF4+rEcgY0ryNafIUChrv/qHV4gYh38c1wJYwzfbIPtWPbG9oqUYw5j25SzxX+pviinmTKwzNjm0gylLWdcJ0WcqO5R4688cmZZGdNhfouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053208; c=relaxed/simple;
	bh=HIf5LX+bx343feP90cVWnAiNYFupJgOU3bNRQcK9Vj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJ+7dDIzoahzCYnHRMUGxpBJWNvapvwR3EA+Rt9D9AHFsrLu429z0FjaJhQdLLzPEtdkGX5Kz8y7kXy2V+wt6RUHE193rABhzXenAcvFIthT8sGR0GmYbNB0FCXYZJjfFZqQCmRhUJoActvam4KtRtuOE9iEDRwWw+jNM8Zpy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjn5nNiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DC4C4CEF0;
	Sun, 28 Sep 2025 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759053207;
	bh=HIf5LX+bx343feP90cVWnAiNYFupJgOU3bNRQcK9Vj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yjn5nNiEoN78pL0G/uwp1CyJkw4U/lIljze+xcm4dbC8J53/J2Epmxl7mvWKAVLNp
	 PvoIrjIg6uLTy0G3WvPy54D8NeZ133D8g7+f3I76+yIsA8ZZSWYwM7aDsq2sI/JFS/
	 a8dFZ4BVTpUmDThxn7Dai6t0JYwivEs6b8n6ZuKEdbamZvWeNToCpCdjIxJb6HmpAm
	 QwWIhUuxJPayRWFRi4TIOCnra63h6/ONZ5kbNG+dsj8w7Nh02rNkf5kA6xWpMukVym
	 qSL+Q7lU6alMYCro57yWqO0NJB4YVT7UHLuLajtIPmVl9DzEOzVPmiiU+noylf1JDk
	 BuGpjgXoNGoMg==
Date: Sun, 28 Sep 2025 10:53:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <michael.hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 4/8] iio: adc: ad4030: Reduce register access
 transfer speed
Message-ID: <20250928105316.782d076e@jic23-huawei>
In-Reply-To: <fd505d37aceaafd6b20626bfd3f25c47db1fb004.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
	<fd505d37aceaafd6b20626bfd3f25c47db1fb004.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 17:39:42 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Configuration register accesses are not considered a critical path in terms
> of time to complete. Even though register access transfers can run at high
> speeds, nanosecond completion times are not required as device
> configuration is usually done step by step from user space. Also, high
> frequency transfers hinder debug with external tools since they require
> faster clocked equipment. Reduce register access transfer speed.

So making debug with external tools easier isn't usually a justification we'd
make to slow things down by default.

Is there another reason for this being useful as opposed to not a problem
to do?   If it had been done this way in the first place I wouldn't have
minded, but to make a change I'd like either some others to jump in and
say, yes please do this, or a reason beyond you are using tooling that can't
cope with 80 MHz and don't want to hack the driver when you need
to slow it down (my tools can't cope with that rate either!)

J


