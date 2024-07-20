Return-Path: <linux-iio+bounces-7732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39507938160
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37BF281752
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258FA1E531;
	Sat, 20 Jul 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBgL4kS0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D276C1DA24;
	Sat, 20 Jul 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721479840; cv=none; b=VnBgAiNdnB1TjP3O88SYee4a2Ng9wUZ+gtiMyjeGGTBvfUU8yE2phESMIMhj9NPemxO89dQ9ODhP4thi70kz0mwrISIkDYYaFFaflSP/is8Uv53xxvBxdkRb+fv4xbOQaVJrcU+Z+aIiavUR+JsthcM89al0eIdk6fj66FAtKVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721479840; c=relaxed/simple;
	bh=HV17yG5auF5MNPa0mLRfliQ7owI1hS8cyrzvOwmA8rE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnUVHVF4vTP7J1Gd/RHrWfQfAkg4no5KkELtu+bl0R5RqdF+Zed6lZeQ7MPRBoptSDk54q4yXNPWKZXf5nq/7iEjmAot155N4mvlgzrfnCd/qMNoFlCyLqYWcJ/6658TDoxARQjP2OLYPSPvwcvcEg05bNCA0Q+IUFRro5JmlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBgL4kS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D30C2BD10;
	Sat, 20 Jul 2024 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721479840;
	bh=HV17yG5auF5MNPa0mLRfliQ7owI1hS8cyrzvOwmA8rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lBgL4kS0qUW/RuLubjbG4iN1cuXqgXr57oSsozlsos1cpvGRCjc0zn6onM7/KocXz
	 fGDc2vCLx1Gt3wjdRx0e1nCWszJDA4QvmQO+RiunBHYjHNoEgKY4rxqe5R7a70pVq8
	 5ibN+vf0Whq0IjfuS4gavWYG4AZv26ewmYICOMncR4BRg4aSY1yJggSOOY4ScbzUrY
	 f5yffC0LQDEMiihc0OPwvX/Nn4KY/9IPPc0AZRlD74dws1XqdCIYdsEgMx8nuLxAsA
	 5opVhD6C/pvzwGqJFgVo9aOCmNah28NWGjRqcORZ+U2elKn9oG0OMj5P9S/6dTutvm
	 HCf7Dc+rhEBjw==
Date: Sat, 20 Jul 2024 13:50:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: use devm_regulator_get_enable_read_voltage
 round 3
Message-ID: <20240720135033.3399e83e@jic23-huawei>
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 11:03:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is the third round of patches to convert IIO drivers to use the
> new devm_regulator_get_enable_read_voltage() helper function.
> 
> This time, we are converting some Microchip drivers. These weren't as
> trivial as some other drivers because of nested functions that need
> to know info about the reference voltage, but for the most part, should
> be fairly straightforward. And there is a bonus to remove a remove()
> callback in one of the drivers.
Applied 1-4 and 6. Comment outstanding on 5 so I'm assuming I'll see
a v2 of just that patch at somepoint.

Thanks,

Jonathan

> 
> ---
> David Lechner (6):
>       iio: dac: mcp4728: rename err to ret in probe function
>       iio: dac: mcp4728: use devm_regulator_get_enable_read_voltage()
>       iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
>       iio: dac: mcp4922: drop remove() callback
>       iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
>       iio: adc: mcp3911: use devm_regulator_get_enable_read_voltage()
> 
>  drivers/iio/adc/mcp3564.c | 54 +++++++++++++------------------------------
>  drivers/iio/adc/mcp3911.c | 59 +++++++++++++----------------------------------
>  drivers/iio/dac/mcp4728.c | 45 +++++++++++-------------------------
>  drivers/iio/dac/mcp4922.c | 47 ++++++-------------------------------
>  4 files changed, 52 insertions(+), 153 deletions(-)
> ---
> base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
> change-id: 20240712-iio-regulator-refactor-round-3-17f2a82d2181


