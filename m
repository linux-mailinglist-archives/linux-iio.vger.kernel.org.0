Return-Path: <linux-iio+bounces-25223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0344BED055
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7742C3BE778
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96C1D9A5F;
	Sat, 18 Oct 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQMktIMq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9410FD;
	Sat, 18 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793549; cv=none; b=bJva1xl33nCZETmQyAOzdE8ALfnvgVon35AkLLCM82aewKYCkkg/WxqxYvd0CO4A1I8YqKhLJaj9u0wYjH9cNXtRYJExfUxRApoHbZIkWNzksKpoSkLV47xsY+txaX5QHKCFNAWKArtQGswXLLyCmMY44CukYy5y+o7fKTs9PBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793549; c=relaxed/simple;
	bh=UY91JhhPw0u6d7gOpg0TeYX2WO7c0xr+Gf9oHU3hIzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCcJ8Q53Al+CZu/J8KIcMD8/4iWFQtxiBP4QxqpnQYSR+ONkVONDIixOozPVmyhtwY3MG2atzrZ3oDczhH+wDVe+0tD1GdAJfBMUvwk+EQR3FIDrrZl29gzK2wTJ4q52sNAyFVsHWB4h6G53EC+p8Ezuiury1GYUloDBjZFtgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQMktIMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5414AC4CEF8;
	Sat, 18 Oct 2025 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760793548;
	bh=UY91JhhPw0u6d7gOpg0TeYX2WO7c0xr+Gf9oHU3hIzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQMktIMq9m5s0nPtlD8PtLVnR13w/4qKrR4ngjq85p2BLU3D0JBjZslzCS1QCTQZb
	 O26QQOVLZqjtxD2vjS5tR0UUchAy1/S+2elkMmEmn6ob94+NGZYPYEubelUt1rmcqd
	 Al2Zb9lOZ8aWNSCwL4FyyTk//MhPBBZNsWrFzffW9IfR1qb0WtNDKxK2CAthdAzKL6
	 F+VBrAhVj1LDJqXCFSaExxWr1Zmg2TJ67ykG1/bCzKiQOV8nhe9mU1NiQs76QGTIYj
	 Cel5neErNn0N3EKfPqfk3EyM5P2Buy5r86ywB+ODjocAM00l39xhcmY/qrcMNGW6aE
	 wqg5eWNlzChyw==
Date: Sat, 18 Oct 2025 14:19:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: adxl345: document second
 interrupt
Message-ID: <20251018141901.4c989cc6@jic23-huawei>
In-Reply-To: <20251013-reexamine-sniff-55195ddb2254@spud>
References: <20251011210513.3253-2-wsa+renesas@sang-engineering.com>
	<20251013-reexamine-sniff-55195ddb2254@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 20:51:05 +0100
Conor Dooley <conor@kernel.org> wrote:

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Applied to the togreg branch of iio.git. I'll push that out as
testing for now as there are a few build issues that need fixing
before I mess up next.

Thanks,

Jonathan

