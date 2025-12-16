Return-Path: <linux-iio+bounces-27111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4ECC10F6
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 07:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E41D3037B9B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E07338925;
	Tue, 16 Dec 2025 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBLMNwqj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ACE339B44;
	Tue, 16 Dec 2025 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865314; cv=none; b=bNI59FCWX1LvpZ44qzRI4T6EuE33IFdhcG9lKKZM6YgllwksbE4E9YAWhw0qc949bSQ8yQ/xJrtHTm3Ilf0BQoEv4deZ47tT6FFXHfcruNVh7+jnuyq4U6prZK4eTonP/JdC4hJHe5uiMVaTF1dCJAINnv+43Dvru0P4avEtUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865314; c=relaxed/simple;
	bh=2zAWi84WvyQUlBO0Sf5n8zskjgwYyuYE4XKw67Rd+Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+xviZz5fdtsy6rA/t58h9JVAEME5DjS6rFNr1h8G7uwmhXKr9EzCROqE6EZ64K2voDOvfcEV+jHSmoVAJdmG/wQ4+igdjU7bObXxqRhyyjbNCJI95OI44j6i5i8d71ghzDqTTD0Im5l5KZLvOGnrPRTYU/6WN7U7Wu9AG7Oe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBLMNwqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F9DC4CEF1;
	Tue, 16 Dec 2025 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765865310;
	bh=2zAWi84WvyQUlBO0Sf5n8zskjgwYyuYE4XKw67Rd+Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBLMNwqjjVOKADQFaXAROpTDGxvbmNsu0u8ppzGK16+gsvCjepOKqsLHDFJXKffwU
	 0f20YuQc/Pfx68thtvd+PjJmPh1l8A/78NW11YRR+VIr692KuG1qJxbJ9+GWH5zNJb
	 C6A2VdZlhxHDkf814SjPj1JkuyxGsOWP4RdcJkBsRFdE2IQ+nRitfzaYSKxt8EzTFh
	 15p0Zn/mY07ZDBbAMAO7oTTxKgVZphCEJ8Qm4QSHDkQzGp9Ssr6KEnsW8LmRZAZH9N
	 T070tG0ebarWo8Y7bFT3bpml5k/H2y6SlltuPjbbT0gtjJZw9/kuepkVG4OWOM8kjV
	 lfbWm4+167DLw==
Date: Tue, 16 Dec 2025 07:08:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 3/3] dt-bindings: iio: add analog devices
 ad9832/ad9835
Message-ID: <20251216-convivial-emerald-chamois-888a3a@quoll>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
 <20251205202743.10530-4-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205202743.10530-4-tomasborquez13@gmail.com>

On Fri, Dec 05, 2025 at 05:27:43PM -0300, Tomas Borquez wrote:
> +$id: http://devicetree.org/schemas/iio/frequency/adi,ad9832.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9832/AD9835 Direct Digital Synthesizer
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9832
> +      - adi,ad9835

Driver suggests these are compatible. Are they? If yes, then express it
with fallback. In any case explain actual compatibility in the commit msg.

Best regards,
Krzysztof


