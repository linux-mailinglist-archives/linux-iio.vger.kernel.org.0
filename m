Return-Path: <linux-iio+bounces-26076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E6C4413A
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E66C188C074
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CC2FB094;
	Sun,  9 Nov 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkIOeFV1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D22D6400;
	Sun,  9 Nov 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700644; cv=none; b=g+Q2NzF0nyTk55B6V1ckeWd6/mFVsuciY1mDO4eQ+iANmJ9hkQ9rx/qDE9HysUmx7VFm3MUgPZPWcGMSHhJkuqJlRQO1KL2RGwz2QNKdwbM6WqAZfHHtL7KcWLS6Zdngi8tTYNkQJ4YsKr+3/odhUJOY3HwbeQgz32ZCf6bfqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700644; c=relaxed/simple;
	bh=IUXxyPcnqpDHiv1qOb2dy4VYfAq79Wb3o8hOBTShskU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RODcxzvHy3hGHLmy16WuHBL/rL3z73oHS1tv9GWdI9oBgduSk1Hn6TZeZXq9nNFW6J9COgcz7d2f7aOI/5062thBDkTrYZwChW+RhJvYWwV4Wk4R6P7IG7rPEZyihVoN7Y7FM7med0L2eb0TmqbNRoZAalZ2unyauespT6CVUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkIOeFV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5045C116B1;
	Sun,  9 Nov 2025 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762700644;
	bh=IUXxyPcnqpDHiv1qOb2dy4VYfAq79Wb3o8hOBTShskU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DkIOeFV1+f18yDyApLUJy74bTRcPycSJScKMDXtjh3tIhxmXLqADiOOBXZhAF0uqo
	 h3rVu6lHHaCdm2TISoR9+A117zDZhQKc8IM4iXJSOMDV7LaHpYL6eK3nMWlDBiLRur
	 YBD8oaHA44QzSL665ddvLAmpZvaph/jDhKh+C74COZxwvp7q1k7PxUIyvLiUA/USjB
	 czfi8cgRi9iyQo3bV3TOzBNxFs0QDaxxbFOfxh3WB23vr+yHNKCQC2o8FPr3vxUx33
	 qlBAE3cjey5WcPjgh3W4IzGu/U6zai62L5drBm1ksFsV6wJKgHOhbrjVLM7oyNQM5q
	 5fmyCrqvVBVLw==
Date: Sun, 9 Nov 2025 15:03:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
Message-ID: <20251109150357.513e3a25@jic23-huawei>
In-Reply-To: <3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
	<20251103105217.1764355-2-billy_tsai@aspeedtech.com>
	<3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 09:20:48 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/3/25 4:52 AM, Billy Tsai wrote:
> > This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
> > which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
> > they are functionally similar to those on AST2600, the OTP trimming data
> > is located at the same offset (0x820), but uses different bitfields.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Series applied.  I'd have preferred a cover letter given more than one patch
as it both gives a meaningful series name in patchwork and provides a common
place for replies like this one.

Thanks,

Jonathan

