Return-Path: <linux-iio+bounces-17346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AEA75A98
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B718F1887089
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9961D618C;
	Sun, 30 Mar 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdY9ggmj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C13596F;
	Sun, 30 Mar 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348188; cv=none; b=XxSRxPoBTS1ByAmTKjgP/PFDv+seoy+yGt+qRh58+ynTC1PhIhokHHTyqvuC+j7diFhtIS52VSHls0xVZ14866C9iX5J3iSqrhGrwKFWEjekComlLrT0F/ATGWEXLiFRiaKam28Mk7BH8HCalBngP+f8JO49yTVI63P1qKLI0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348188; c=relaxed/simple;
	bh=YsDxOac7GaJxJqFAeGtRs/VHOTSNqz1kAjuvhtVyu8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZUoKMvUzc8KkambXUr7alEBbvB7Wg8GlH9x33S4zw8vpiL7xk2zGbIZHBzJwfYJ5ThD1S1Q+nrco4D3wFL575w+mcv6pcAHaJsQw+1Rtvs43+CseSe76AnowpYCg+o+KcuuxtvcW+lRQd0BhslRkfoajbFKO6tyOe6c5fqifRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdY9ggmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBF0C4CEDD;
	Sun, 30 Mar 2025 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743348188;
	bh=YsDxOac7GaJxJqFAeGtRs/VHOTSNqz1kAjuvhtVyu8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WdY9ggmjXogv7bZ7fk+q47bkH6hduevtSa1kBSGf0IMcZGjut2falMp5HD9DWD1lR
	 6mExgH+4x44sgh6P8WIaJgH8k3QfJQpZ+duin7OYUzx2XGjiatqrP/IKPRZ1roPMF9
	 ibBqZiwkUUlRNc6NhHK6dhwY7iifb7+bagyLNMe2cFzR92hXQJQL3VtR1zB7MgIRsx
	 gPZlxwj0Yx91XJgOtrqjVCW7i7tVwQGSW4z5f82Fd6B62kt48nAGmDDq8D1VvbDmlr
	 Bfn/V/ivrcA2VSFqSwBgXeoMkLvxZxf2jZT2VnNVXZE6pNiB20C93dLdwLWwFuZwL6
	 dZt54eh2RPSSw==
Date: Sun, 30 Mar 2025 16:23:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, bpellegrino@arka.org, Sam Winchenbach
 <swinchenbach@arka.org>
Subject: Re: [PATCH v8 0/6] Update auto corner freq calculation
Message-ID: <20250330162300.4c318897@jic23-huawei>
In-Reply-To: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 13:48:25 -0400
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> From: Sam Winchenbach <swinchenbach@arka.org>
> 
> v1: Initial submission
> v2: Cleaned up wording of commit message
> v3: Add DTS properties to control corner frequency margins
> v4: Fixed wrapping
>     Added maintainers to CC
> v5: Remove magic numbers
>     Break out patches into features
>     Small coding style fixes
> v6: Converted dts property from hz to mhz
>     Removed blank lines in dts binding documentation
> v7: Updated author/sign-off address
>     fixed patch path description
> v8: Added missing Reviewed-By tag in v7
> 
> Brian Pellegrino (1):
>   iio: filter: admv8818: Support frequencies >= 2^32
Applied to the togreg branch of iio.git and initially pushed out as testing.

I thought about splitting off the fixes and sending them a faster path, but that
last fix is rather large for that so I haven't.

Shout if you think I should try to get the fixes upstream quickly and
I can move them to my fixes branch.

Jonathan

> 
> Sam Winchenbach (5):
>   dt-bindings: iio: filter: Add lpf/hpf freq margins
>   iio: filter: admv8818: fix band 4, state 15
>   iio: filter: admv8818: fix integer overflow
>   iio: filter: admv8818: fix range calculation
>   iio: core: Add support for writing 64 bit attrs
> 
>  .../bindings/iio/filter/adi,admv8818.yaml     |  20 ++
>  drivers/iio/filter/admv8818.c                 | 224 +++++++++++++-----
>  drivers/iio/industrialio-core.c               |  12 +
>  3 files changed, 202 insertions(+), 54 deletions(-)
> 


