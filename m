Return-Path: <linux-iio+bounces-17787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9AA7EC9A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D271887A0E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB95258CDE;
	Mon,  7 Apr 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0fvdEA9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC3823FC52;
	Mon,  7 Apr 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052308; cv=none; b=fAVgZJWBHTh9y3ROId+BU32jB3JjV/rQIyVhGOHDiWdS2qNlRPg2G7kvG+iEsQ07SOWRIll+IUBwyn+UPcLoMeuOEgu5vA7jvmu4V1G/zKQO9yc9cSXBXJqJguYR42WvcQ1Sd5hToJCqxUypU4MX8iEwfXdrfbecF0qrPzIFPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052308; c=relaxed/simple;
	bh=kpnlwU1ua4w3405cDEFSviiFMiWPttNWuxqNWJ6xrhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZYYThZS7AMTMOHGTT9yZ0QzT3mEiZgIcOEab6AALY6u+tVj57P4P5B6dKur8Mm6EWwe7m3qt1l5HRZvCixf+FdRC2jSG9ZjnAMIeTMPLNHmgblCwNVlZJ5Snnod16iXpGFYe/GqBDfGf4JgTYXahcOAfsEzPNsSAFuiAmfwbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0fvdEA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0BC4CEFE;
	Mon,  7 Apr 2025 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052307;
	bh=kpnlwU1ua4w3405cDEFSviiFMiWPttNWuxqNWJ6xrhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0fvdEA9QYp9ibxMxuVd+ukYS2ASZtxn6COss2F01rOz4/UptfXi7frDT5l6MyO4N
	 yWzDF+OcFCgdWR8pj6VAdc1YoOC3K/QA0QGF/8bWOyIXNb/vdIhjvJUHu8XBMcfKiq
	 G5pM57vd/Nt8xKSUs8oCv58SQf89qqhc0rzwqFubjZR2X4gCamJoT/XEUIDXlSY4HJ
	 GcinFmITK+bnmhkYdD1vJ6a+2qm8P8PjVD6wu+bbKjtRwANw95phihW3dgzbXE0r/h
	 sUqo0Lxy3NGoKWtNpXvFdGQQdN0gIadPCs0nYA86PnA22VdaofSD/7Yt/pF1YPo+KY
	 6hP1cPvNh3C2g==
Date: Mon, 7 Apr 2025 19:58:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7606: add SPI offload support
Message-ID: <20250407195819.506e4d6f@jic23-huawei>
In-Reply-To: <20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
	<20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Apr 2025 18:19:06 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add SPI offload support for this family.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Missing import of the IIO_DMAENGINE_BUFFER in the spi module.

Added.

