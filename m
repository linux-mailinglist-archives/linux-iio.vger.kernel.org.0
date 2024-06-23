Return-Path: <linux-iio+bounces-6770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31748913C95
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F072826A0
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42E1822E1;
	Sun, 23 Jun 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt95iErR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7557604F;
	Sun, 23 Jun 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719158355; cv=none; b=j6MS7jTIEyLml9IiP2NTDECrZOZv5NiAYsGS0KqgxEuPgIrawKP4EfAfFPPtJoahXBXC3P1bf/ta/iixba2Z3FQqRdITdPxUFR4oaAiVQAG4s7EdxBg1VvKjwGwAeiAZ6Kz5xaiQ6SBLTe2OQmLCRoqChe4UVnJ5W3gYBE8R9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719158355; c=relaxed/simple;
	bh=rj/GmVeB1kCNaqRtDGk6WKm14Zsxiu1WVZXkop3OAl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryEyKAjhMScW7zq8oJ2eToSoActwnhsdMeKJiawrvwqqoy27RPBnW2n0bJgwmlqipcxw+dhqSaEM5RF5xFEF2X2UC/kODthwz3m4wdZYZWd88O+32Mkk+MakH5hC2B/NZGX2pfa/CprsCeWA8XDlLeRbMSzMMcErA0vJw8yerP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt95iErR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC77C2BD10;
	Sun, 23 Jun 2024 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719158355;
	bh=rj/GmVeB1kCNaqRtDGk6WKm14Zsxiu1WVZXkop3OAl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mt95iErRwCHtScBBcfh5Oq7TUtyWjfTPzcisMcicv+HxjP8GahtvuPlNcKes8CaCI
	 M0ppaI9jNqvHffanN2eIrFlzUNaaeX3WX0+pm6Mv0eGIkYdFv4FWjugx8xKDWAyrEq
	 JTbKaiIacbuHLdkOxglp2C4dsZA+zjZpJh3f8w9M0eAUQoAEd8uIa4Wfz3BUBko/yz
	 hJKzD4WC6izo/p43E69BZOV4ARjgoDGD7LlJWVjUvJqrfd+FhTp/708LOF16VzSnsB
	 KpHFx63w/LOhcn9zZBx47tKc8LguG+edkS1807QYJPPwiGOnHWFBdxknZsCBxd5j/R
	 FujV48KnIhcZA==
Date: Sun, 23 Jun 2024 16:59:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v5 1/6] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240623165906.05e112a1@jic23-huawei>
In-Reply-To: <20240618142138.520192-2-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
	<20240618142138.520192-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 17:21:33 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> From: David Lechner <dlechner@baylibre.com>
> 
> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Error messages have changed slightly since there are now fewer places
> where we print an error. The rest of the logic of selecting which
> supply to use as the reference voltage remains the same.
> 
> Also 1000 is replaced by MILLI in a few places for consistency.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi Alisa-Dariana,

When you post a patch from someone else as part of your series, you have
to follow the Developer Certificate of Origin rules and that means
you need to add your own SoB after David's. Without that I can't pick it
up :(

If nothing else comes up, just reply to this saying you forgot it and
include it in that email and it should be sufficient.

Jonathan

