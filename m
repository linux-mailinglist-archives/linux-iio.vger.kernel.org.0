Return-Path: <linux-iio+bounces-22751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB40B27C21
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067D2A2788F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389A52F3C35;
	Fri, 15 Aug 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1REpBiW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBC2F39DC;
	Fri, 15 Aug 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248198; cv=none; b=ZVnT9KXVNPUbXW5RV/U1rPORRH3xhq1tRmR51iXDuCLc1b2o5P+xann9tc6Go3sUZ0zq9TBsCP5g8fj+xL28tH/DN4pllL4GCsTZijzRMc0PBwkcf49OU8gpJLgY3aP5sYrdfnvuu+5N3vK/lp/QS2jOgqnCJ5+FKpWlsYswAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248198; c=relaxed/simple;
	bh=RGMlpvpTQSMExozJzkOz6BmL8Zte6c4xFpuKD3X1WCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SazMiw7fFMAKdOcxFFAQrvZlKqMBV7kc22EaokLvkXl0x1Ap8Qn5lE3FD9q3FtqlEHbOrycJz7EGLOOr3L4+F6s0/41LCm7UCSG1mdxwwgghX+EYeE6ercUyf9s9QcRh4W6RlRoWU4tTDriEQUrI2g7NSqgGPZUWcw1z1lACw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1REpBiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E35C4CEEB;
	Fri, 15 Aug 2025 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755248197;
	bh=RGMlpvpTQSMExozJzkOz6BmL8Zte6c4xFpuKD3X1WCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1REpBiWgG5VdeqpNssMMVddtGbUpE/J9q2bwmIf62sJrU/040C4ElbC4kzVGv9AM
	 u6XoLHEkgyQyp10zBo1tGxSI06xDy/ihEeoiF4/pfw9xTcQ7vaybHGGut2YPtbB0pI
	 Qm5FOz2CcMVU9KkxPD29Yxo4zjUScjHUwXgW2LxnFZY/6sG4u5XfOW47fUBUPJFkBl
	 J5He+KrXV55zzrBl9NgSBlb0Bt4LgTlH6hDA7IFLzG3QAAWiV6yFhop7qjF1/Ad/re
	 dMQSkPWAIEx4cygELyWQf5lGvocEjlVVl/AHXwHM43J9j7RBcwpFBID6sdcYI8SS6u
	 mh6Q4vxYOyClw==
Date: Fri, 15 Aug 2025 10:56:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: ltc2497: add temperature sensor support
Message-ID: <20250815-agile-crafty-labradoodle-227dfb@kuoka>
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
 <20250814-ltc2495-v3-3-c2a6cecd6b99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814-ltc2495-v3-3-c2a6cecd6b99@gmail.com>

On Thu, Aug 14, 2025 at 01:00:19PM +0200, Yusuf Alper Bilgin wrote:
> Support for reading the internal temperature sensor on LTC2495 and
> LTC2499 via a standard IIO temperature channel.
> 
> Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
> ---
>  drivers/iio/adc/ltc2497-core.c | 141 ++++++++++++++++++++++++++++++-----------
>  drivers/iio/adc/ltc2497.c      |  28 +++++++-
>  drivers/iio/adc/ltc2497.h      |  15 +++++

Thus should be squashed with previous patch, otherwise previous patch is
just incomplete and broken. Unless... your binding is incorrect (I will
comment there).

Best regards,
Krzysztof


