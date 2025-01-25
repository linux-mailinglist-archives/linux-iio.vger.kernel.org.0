Return-Path: <linux-iio+bounces-14573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C5A1C386
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA023A600E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF138208978;
	Sat, 25 Jan 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuEQkelL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEE3596D;
	Sat, 25 Jan 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737809977; cv=none; b=Yg9I7BXM/fc2a/ubTr5FkuO/GNSOkQ397I8x/5OMJCSoLHDxjSRyXpRm8GALxqMfgsDBSJVg7ucBGOJJOm/U7c8HCtuBRNZLz3mTq1Dgtu2jdINqTTcWQx5bp855jIbkQ4xVMZLCxyXQgjpz8JkLA3tD0wxVScMMFotduu+oYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737809977; c=relaxed/simple;
	bh=GgEn2bWpJe+6jP08tYNnkHNkEFVIw0xflv114EQSNz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feXCupqSV+cwRX1pwHg+nTf1ZIJTgGOtDib6HTNtjDfuXxkWIPCumrmVISirwjH1J1I4Roq/9Rz7tOyhDtHWhNDQpbLqtapQ1RL+RwBkt507S/iBJAmmwmlvTJKA0wmkERGp7HoDF5iTqFqZQZ58LzGVIwwKfDKjBlJgy2fsePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuEQkelL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82562C4CED6;
	Sat, 25 Jan 2025 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737809977;
	bh=GgEn2bWpJe+6jP08tYNnkHNkEFVIw0xflv114EQSNz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fuEQkelLgHYKGn6dmXGbTsIyScIdvEIVVcqsqq2h4Zt+pEsbtiAwwYbutsn4QdJLP
	 V8cT+W8SP5rCf9cHWf0223OB+QfpF2hs5ciBv0DxntjJb7yzD4JFc/wgwNSG5diFul
	 xAl1y5O85nDfO6/nbZmFZQi9x7ZPmc1Ewn86by0IreEDlMWLBzxRbJZ7E3AQnm0oXl
	 ew5IOo8LHie2s3uNv11JGv4TzZzKSpLQ9YeCyGY7RwrA6UnicJrpPCgAIeY7SAzjjk
	 sR3Hqf98v00tOE5+5WQsdQm/MG5b/v2cxyDSTC3Q6oEAeF+vWyEo2UDJFHUBGG8L5A
	 rVZNAEPsi6LLA==
Date: Sat, 25 Jan 2025 12:59:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: amplifiers: add ADA4255
Message-ID: <20250125125929.1e365b85@jic23-huawei>
In-Reply-To: <20250120105429.183004-1-demonsingur@gmail.com>
References: <20250120105429.183004-1-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 12:54:24 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The ADA4255 is a  precision programmable gain instrumentation amplifier
> (PGIA) with integrated bipolar charge pumps.
> 
> With its integrated charge pumps, the ADA4255 internally produces the
> high voltage bipolar supplies needed to achieve a wide input voltage
> range (38V typical with VDDCP = 5V) without lowering input impedance.
> 
> The charge pump topology of the ADA4255 allows channels to be isolated
> with only low voltage components, reducing complexity, size, and
> implementation time in industrial and process control systems.
> 
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
Hi Cosmin,

In general please add a cover letter to all patches. 
Along with providing some general info and anything you particular
want to highlight, it provides somewhere for others comment on the
whole series + it gives a nice name in patchwork!

I've nothing else to add to what Cosmin said on this patch.

Jonathan

