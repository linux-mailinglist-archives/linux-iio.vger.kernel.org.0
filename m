Return-Path: <linux-iio+bounces-24955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5E2BD0386
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AF1895764
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7422857E6;
	Sun, 12 Oct 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iniuhQkW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2587285412;
	Sun, 12 Oct 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278978; cv=none; b=BHhgm6xbMX7c92y9+PavOEk1yKwQb+FM7pehHYe0sqvpVsIZB8Fcl+CkA1VMmHBvwlaMAMwYvdfhLwMnveLYZUSFU7JX7sadFtL4YUnXjJB7Q81PNMfIRnve6WhowkN9v434jV6LVgxdO4h499zylA/D84at/bzkMKGoRLV8bXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278978; c=relaxed/simple;
	bh=KuVT83t66k5V6mf1HN1UC7DkR4RMze4mx/one+NIRzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSEJppJHOGJqaSu1LHUwUR7SwSwYZf5V79IZJUkB5nKGhy6fDOqD6QVjKP55HBZiY4cZVQ2ppvUOOyrI8txtC/oaT4tci1+NMb2gikz9c0z6GQqJF3uXq5+noBRB0UNnO9x5D2kUOoEexKA3pv5IUytfRdkL2/+V04BzPwlB84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iniuhQkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9190C4CEFE;
	Sun, 12 Oct 2025 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760278977;
	bh=KuVT83t66k5V6mf1HN1UC7DkR4RMze4mx/one+NIRzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iniuhQkWcKHKkVXvwrVV39LvQ1GdUjkTLQ6NcKAYGamxz0TZhcIr47D9gZsUfjPrE
	 JTRuMkxUPza4+xvkfmINLXdA1nRm9wtXI7OS/V2jMSlTEEEew9kjE3hGmVXJc7BomQ
	 ae0vmKlzKY3g5+3O/dWesV+/xr921BAnBS5M055/rD7w4bf5DRTe06U+ziUY56OlbE
	 2x4eFALflu8PyMyd06UGp8GelB9ZaHnmNMR1i+mKoRu1KvaoItceQCCRFG5e4Q0d78
	 EJE4BrY8DyYFX2piTSFHxepIjhuFAuNembw7HY3+PY22+d+lRKjlOHPzi+HnxQKmP0
	 y50xYGHsuiN3Q==
Date: Sun, 12 Oct 2025 15:22:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/19] iio: accel: bma220: cleanup license string
Message-ID: <20251012152248.0831079a@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-3-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-3-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:12 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Fix checkpatch warning about use of "GPL v2" license:
> 
> Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
> ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.
> ---
> v4 - split from bigger patch (Andy)
> ---
>  drivers/iio/accel/bma220_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 02ee6b4d51c0816a88ac258f0e5107111ec2a2bc..8c313debc1dff7f4bae7c165bc555ee190996291 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -332,4 +332,4 @@ module_spi_driver(bma220_driver);
>  
>  MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
>  MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
> 


