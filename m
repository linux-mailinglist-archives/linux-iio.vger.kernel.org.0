Return-Path: <linux-iio+bounces-17578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA148A79C42
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 08:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129AD16CC1A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21871A23A1;
	Thu,  3 Apr 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvFHIHfj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37319D891;
	Thu,  3 Apr 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662618; cv=none; b=NyExCyV0zL/g9wA+pdLZWV3AkRwi4De4mXnNt1BdOfXhnV6rEAI8c4A4PUlRqtiK72p1cjMWWZX/JlkiyjIzsxayVUOCuTlp9JJ8qPU/hyhep7N91aFdYnN0gLL5RnKhBQYwDBr6+3emFD7IcXtfaLhgFxm8a4YTfAFotfw8iTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662618; c=relaxed/simple;
	bh=81W5cCvEQsw4XwZ7842BJKjtgGqao+5IOnW7y95VUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP5FUNmwS04EQKlqv8I96vyCy0M3KnUJ3MtnU3ndmhz3ehXLCQq+SO5EjfsW3kuv6DMEohadxEIXOidSrsRK1vrYkSgCMdqHjmzzyGFZFAAA2fpg1CpO7V9Lxf+BazAfv9WqSZwqLxrrMrDPxDXgV/Mbhnsr9/vGGxBV2skWG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvFHIHfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D596C4CEE3;
	Thu,  3 Apr 2025 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743662618;
	bh=81W5cCvEQsw4XwZ7842BJKjtgGqao+5IOnW7y95VUBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvFHIHfjy0OboL5Wl2/rFkR/FmF9GOzkLJmNe4Uxs3e0HxE62O0lNsHNmCBnnLCus
	 3bvqSdIbHpWtVrN9h2wSQ9fKSes7rHKkdmdMb8BETuYS5E6kCfNQxXYnmPMZ6oPfR+
	 IQbys7rJxVnNmnjgu+irMEJFprgpOtXgEMf+60lWf8BYbmaQWe+giwnTwKBry1yGbR
	 WWQ8bPqTYzikrMghw2fkZ8oJLvNCa+T55WeUHS3LTGUQrThlpF1f9OsAlzYfxw/2ng
	 m6QrUKDT529Z3ZrhkhlAAYMSKi30DKKSx1HEkYG7LYZpeA+gcnwZMuGpIkkV7o6rvB
	 YU5l0ZJUumWcQ==
Date: Thu, 3 Apr 2025 08:43:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add driver for AD3530R and AD3531R DACs
Message-ID: <20250403-bison-of-glorious-force-4369b6@krzk-bin>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>

On Thu, Apr 03, 2025 at 01:33:54PM +0800, Kim Seer Paller wrote:
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disabl=
ed
> by default.
>=20
> The AD3531R/AD3531 is not yet released, so the only available datasheet
> for now is the AD3530R/AD3530. The only differences between the two is
> the number of channels, and register addresses of some registers.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> Changes in v3:
> - Drop ABI docs.
>=20
> Bindings:
> - Drop reviewer's tag.

Why? Explain why you are dropping.

Best regards,
Krzysztof


