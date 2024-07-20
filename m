Return-Path: <linux-iio+bounces-7735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F041938173
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32D2B21464
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE912C559;
	Sat, 20 Jul 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7AK963A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F128EB;
	Sat, 20 Jul 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721481764; cv=none; b=KC/c+L/v4uB9OJPcYuiJ7hOQnGTS+v7HKf03QQLbgXi8MtnmMgy9oCTmaY1s0o3BoKj21xsevzPwhM5FPKVPBu3T7fUcR1kkm4rmrFtNe0ri8Wt43c9PJz3HSGGNeFMmmTWBM2+lc2ztb9nM0RdpSoWxLRZLbQUFfAYYKZulmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721481764; c=relaxed/simple;
	bh=t5Vr1EhrfEYVc9b45fKg74aiDdG1fj0P7Fuf5jkhOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbOgMMj2gf/rlqpQzECbL2pd15y8Q/xS1KEToStNdetJp9q8pjYPw8MIYp7KVatX+FsYE12qELfg43V5OYqXZPpl46iurLfXQPoCvCL/Q7XJ7sgfVrsSpYo+a9vZSulfqYaW/tQ03i3wANPyOdNq0r9+PXXDYNOmVuSq6I6fvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7AK963A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A06C2BD10;
	Sat, 20 Jul 2024 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721481763;
	bh=t5Vr1EhrfEYVc9b45fKg74aiDdG1fj0P7Fuf5jkhOuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7AK963Ak8uD/tL2b0Tu+jP5pS9eCRjOCteiMMWlinkUL2Avkg12TdCFfBI608DWv
	 HKIjnWxItG55INvNV1tWVnBo1WHfH2QHBs4WBXYwUR9+lneD2E64IThSEzhLbYbzZm
	 ke3KJQHJ7gdYi78MM9HIioLVao1EpXu5xT2xGYh5iM/fuwenxSjOMk7Pkj/5jCVB6K
	 8062aQcVzxDorD2Z91OiAKNuPZC4AFr1xTH/PUPKI19LqiTMpTFzbWtGDqTfCZQvfI
	 HU1EHFP+pg1oIYyLFd0iEYPuOXkm5yHp4VVhRnkkTRDws1d8eG21tVyYefbB5MP5Q6
	 RLlojqmYFwfBg==
Date: Sat, 20 Jul 2024 14:22:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut
 <marex@denx.de>, Andy Shevchenko  <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Document the device name
Message-ID: <20240720142236.22f8dbb2@jic23-huawei>
In-Reply-To: <20240714193709.543509-1-shreeya.patel@collabora.com>
References: <20240714193709.543509-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 01:07:09 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
> via the ACPI + PRP0001 mechanism.
> Document the device name alognside the compatible.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Hi Shreeya,

I'm guessing you used get_maintainers for this.  Always check that there
isn't anyone else who should be added.

Given the root of this was the discussion about dropping this undocumented
binding the DT maintainers and list should definitely be CC'd + Marek
who was part of the earlier discussion.

The fact that this isn't a typical ID from a Windows consumer device does
change things a little, but I'd imagine a firmware update for the steamdeck
is equally unlikely to happen in order to fix the vendor-id.
(I was surprised to discover they provide windows drivers for it but
not seeing the light sensor in the list)

So my opinion is that we should keep this ID in place with an enhanced
description.

The other suggestion from the Krzysztof's thread was the risk of this getting
abused.  Perhaps we should specifically fail to probe if that ID is used and
it's not an ACPI firmware?


> ---
>  drivers/iio/light/ltrf216a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 68dc48420a88..e97ff8f7ecd0 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -528,7 +528,7 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>  
>  static const struct of_device_id ltrf216a_of_match[] = {
>  	{ .compatible = "liteon,ltrf216a" },
> -	{ .compatible = "ltr,ltrf216a" },
> +	{ .compatible = "ltr,ltrf216a" }, /* For Valve's Steamdeck device */

Add that the steamdeck is an ACPI platform using PRP0001 as that's
the key part that is different from a normal 'wrong' of_device_id.


>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ltrf216a_of_match);


