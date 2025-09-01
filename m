Return-Path: <linux-iio+bounces-23557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940E4B3D742
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5F7A7E8A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA9222587;
	Mon,  1 Sep 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXcTv0+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F322157E;
	Mon,  1 Sep 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697400; cv=none; b=JnbReDIgMkQ5JkAtacYFcpGQ5RgaXmyrQKDB3qeFNXR8lZxoeq6okhvkHyxbVrKLhxxS8qV/4KQErJNivuM2rmUGuZn7DHyyA6R4OQyepIzmRs9ThmHq0Y3cVeXlLm2wJhuZ9HxBLCbAWL8ia42QavB1Kk/JqxQevUGT47bVIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697400; c=relaxed/simple;
	bh=p7wrxv825L7YKcyo7ajBHyjNzOafvy6Dqcr8NdfqYWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOp90jgFCLb4HEni0mMBZ0cJV8jQsBv0YzPiI7Kq+a0AzttKcuoBbyFZ9WObY0kcD9LURhPwOyY2kJIJ4x5vCzhRGaBeFCC4kAhWBgBk0dTgazS28AmGR63VJH4JPCWQNurdGYFjF3dO4nQY+y6wE/TtwjKpu/uTvt3wqHn0lEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXcTv0+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C625C4CEF8;
	Mon,  1 Sep 2025 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697399;
	bh=p7wrxv825L7YKcyo7ajBHyjNzOafvy6Dqcr8NdfqYWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXcTv0+dtnlGy7CPUIYuKwA6otz+O7hpNFqv0l3vNuvvtmYXz+iGfRTbLw0oEy/lG
	 6PTpQi+s7hS7wqlW1eCpTRBK2GhqCo/qWSrhhU/Dkl+KqAPFXhwlYL/mMQ8GLLWiW9
	 jEN//P4PdR8e/M8c0xqobEba+S/leN+sOlq8/lzg82pi6N4i7CvCkSg9tr2uy13BZE
	 MjfVk1dIWyx+aUO301kaDLb50qdYX43HyiXl2G/3987VQf/C821/cCNX3YysVAKtIb
	 7C1zP08dQH44lNb9FYrvEc6/q5lnAp4z5FQNH4eseU9glCVr/EfvDnshsWiCZNokfA
	 bnCjmocUgjR4g==
Date: Mon, 1 Sep 2025 05:29:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/5] dt-bindings: iio: imu: Add ICM-20948
Message-ID: <20250901-hopping-natural-mackerel-1c7b56@kuoka>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
 <20250831-icm20948-v1-1-1fe560a38de4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831-icm20948-v1-1-1fe560a38de4@gmail.com>

On Sun, Aug 31, 2025 at 12:12:45AM +0530, Bharadwaj Raju wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - invensense,icm20948
> +
> +  reg:
> +    maxItems: 1
> +

... and this was never tested. Missing additional props.

> +examples:

Best regards,
Krzysztof


