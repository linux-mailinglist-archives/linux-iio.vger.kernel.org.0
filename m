Return-Path: <linux-iio+bounces-24517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE92EBA6C95
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A2917DCAD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC642BE7A6;
	Sun, 28 Sep 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVC2ZglZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD792C3261;
	Sun, 28 Sep 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050014; cv=none; b=fce4u12WilfDB1vV3v7mFIbkGrMq/YwubMGGgXrf+P7YF/RoJ2X+nyUxhMgtp7ifXa0RbfXFFCa7k3WOxePvIXLMdA+yw1of/zu3a47M5R9k18IU4Gb9p+zkofcCQPBmIW7tUJP2eeqhZTivtSRqvpJaCiJ6yWWAxF+hNFMktJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050014; c=relaxed/simple;
	bh=ZFLVCWtu/eGhRy4jxIgr6fDXsYlllC+1e37F0gzICpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSQYV+AeG+kloZpz2mUFXMJNR6V88yCJbznm/X5kjT+ZGuB5k41FTS5+Geyhf9zvnNrgbGZWHEqOoaskS0mfzpCObWg3FNImPTE4JveniiwAFjnHCxcMEUBRVxWfuJN1jGxriqaGzlD8LFTzsABHSOtw2kyvpViHT2TvVriCvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVC2ZglZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B187C4CEF0;
	Sun, 28 Sep 2025 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759050013;
	bh=ZFLVCWtu/eGhRy4jxIgr6fDXsYlllC+1e37F0gzICpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVC2ZglZ4GXpyHKHTUQ4sl/RqWWLLus+6y1fSYabsJ8PM/82Jh+X3H326SNKYnHCH
	 vOKnCrcXkGgkDz5a8akHLgyWG/LJCNXvr18tAuY0iClK03IX8/CNuZn9QY138zXrgJ
	 LrDbKGBIuPDq4UmWsaIR5M+P3pIeT1pz443ZnFlnumgun2uKYDw7QWswkSdYugPxzx
	 egRzmfbmJpRyN59Hi+n9VKbU9WBK0G/lLomo5A7HHb+B1qZZfXnFP33iS7eaXSyvjZ
	 XDr0NRh6tKwpqM9k1EBrvh9oZXanOdhY1h+B1WOft3vQDAqPec2xrvZHVBKsDAtJOK
	 AGYmgmFUCfD8Q==
Date: Sun, 28 Sep 2025 10:00:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 7/9] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Message-ID: <20250928100007.001ce645@jic23-huawei>
In-Reply-To: <20250924-add_newport_driver-v6-7-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
	<20250924-add_newport_driver-v6-7-76687b9d8a6e@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:24:00 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add SPI driver for InvenSense ICM-456000 devices.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Other than the missing include in here that the bot noticed, the rest of the series
looks good to me.

Thanks,

Jonathan

