Return-Path: <linux-iio+bounces-24968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5ABD057E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275364EA198
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFC2E1C55;
	Sun, 12 Oct 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0zgHRwX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E92E0923;
	Sun, 12 Oct 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282439; cv=none; b=fFwcIkTLZG+Y0XRf5W9oMvJHAMV6wd595orkL6/ckKMHESKnSVwv00/CseI2m84COy9XBkd6hEc3USIDrP4087sxAJQpbdTVs6WRMPnONzHs+FbLA9a/pYpNXnLoRODIXXeehUAhnpSBpvAhmZAF7oG0fAo1s0oNH0v3qvkt2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282439; c=relaxed/simple;
	bh=883lbv62pR3Im17Uj4oimrcwwxfR6KmlWo9rLSWutvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGA3sfzBq2jTQ9DsxXm7cirX07PuKKvnciXtr683N8gExCXip+1jtYXf8XWaH2kgnUP/hsyCcoaVyAg7FGlwCo5BAGYoxsAa0LMcgNfd49hAHlVMlUvFyLCyxk6jvShM7jOmjEFSgnEEzY2HBAivxgQdnqaGqT+0ShOJhwjFNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0zgHRwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9374C4CEE7;
	Sun, 12 Oct 2025 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282439;
	bh=883lbv62pR3Im17Uj4oimrcwwxfR6KmlWo9rLSWutvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I0zgHRwXcHTm9gHND/XXPayerq8yO8Ty7kRWrXJOXRjk+3919vy6oEz83vFBFwvLZ
	 v++tze5JqrFGcberuZtAhW9KUa56OltFyu0eLxdV6SwNHU9OKoFhrbX3OG2sdINE/E
	 DD8SATF1QF8INl9JYw5lqjPZXSDgdesDd2rWwFPAdNzIP/vHswqvxsXuOdV5PnyLqB
	 zsgaDKtg1zyLrQwgkCvDJ3qqLzofIyJsddSDoSNNUfRNE2uyHlbRiwCVFAuTjiBokT
	 JxeUo0+VcEKfU8WsdFW25ykS7I394Jy+U9OJ3Z2ciDF5He5H9PUJFD9dRGDAAxWgsY
	 6Gcn9P/bby+QQ==
Date: Sun, 12 Oct 2025 16:20:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/19] iio: accel: bma220: add i2c watchdog feature
Message-ID: <20251012162029.55b9d9a6@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-15-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-15-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:24 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Sometimes the sensor gets stuck and enters a condition in which it pulls
> SDA low, thus making the entire i2c bus unusable.
> This problem is mitigated by activating a 1ms watchdog implemented in
> the sensor.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

Thanks.

J

