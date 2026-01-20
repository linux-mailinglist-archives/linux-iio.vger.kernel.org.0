Return-Path: <linux-iio+bounces-28056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD068D3C624
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCD6D5A6E58
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94A40F8ED;
	Tue, 20 Jan 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuKhgVOs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67240757D;
	Tue, 20 Jan 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905495; cv=none; b=QS5joagxE+OId4WOcOWRi3rHU07amjWtudoKrRqTmP7HWXt4FPkD6+7EbLUSRavlHUlTX0qZfjJDvI8ZsoHdLgRfZRXDQCJjbLpYdW1FQNziACTUmDZZz3IZJ2QIzHLDeS590GWcJm552dqzVCMDFfuxT8cHOgzG2BFh5PZQzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905495; c=relaxed/simple;
	bh=7mREF6bxhEwLB9AmrYmLxpUqve2VcjDdgI9iBmgIEXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+F9Xk4TuoW15ptt3xD+Eqzt49qy1Nb258+UmdHghWKRfopfz/dXKk85fm8WMrPcSDlBRC1Vq7CH0w75sZF1GAs8Yt1W5cZsh7OZZPXoh6Zhf+D2tdOYmAcmAoozW9dsoa0PCPZByiTmeaM1IJl/YeM/tvlH9tyKKD6U+eEhx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuKhgVOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5222DC16AAE;
	Tue, 20 Jan 2026 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905494;
	bh=7mREF6bxhEwLB9AmrYmLxpUqve2VcjDdgI9iBmgIEXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuKhgVOsaYR6n1glWlwG8k+hl5X5tyeHoZNIpXpg0DH8BVrJO8iKRIGzP7H680KaI
	 RKJsoxm2jkAk2/jFUxg8/Sj9LbKrB81lEY9AJaEYpJgmETh5Fk6NtNSAAcK1lO6RJZ
	 7jvJA0lEwWExyXJEqKx3GuBXho1H2khOJAjli3L3tZb1LI9wl2moUDnaoGjygWsxuh
	 qn1M35VXgh5qolvSoXB0Q+HB3+ntMGMgnVDfabuaESlSmczUozNAKnzCth5MBqKDRK
	 gyLSLgA26OQFSq80hf/988j+7w48YYaOajKp3bNVAISrbWR09VQoUE8mWMqc2ylStD
	 5Ke5mZW7jPvpA==
Date: Tue, 20 Jan 2026 11:38:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petr Hodina <petr.hodina@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: add Device Tree binding for AMS TCS3400 light
 sensor
Message-ID: <20260120-watchful-orchid-fulmar-c1f8c7@quoll>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
 <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-tsc3400-v1-1-82a65c5417aa@protonmail.com>

On Mon, Jan 19, 2026 at 06:19:06PM +0100, Petr Hodina wrote:
> Adds a new YAML binding describing the AMS TCS3400 I2C light sensor,
> including compatible string, registers, interrupts, power supply, and an
> example node.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---

Also:

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Best regards,
Krzysztof


