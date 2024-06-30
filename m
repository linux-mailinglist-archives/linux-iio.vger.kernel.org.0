Return-Path: <linux-iio+bounces-7083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D991D14A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6691C21167
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27013AD22;
	Sun, 30 Jun 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF+iED/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5B4084C;
	Sun, 30 Jun 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744799; cv=none; b=fxBawbMcdq/5PYE6ZLvEbnExT+1JfnaYBRFggj/lwkdyaN1VVXeD/kyy+Si6kuObSnwjmUrlmRbKrvlmKhSmxeGTN0169g1COhGKckgwea5s6YReSvu39MWTHKGY5smhD7H5gCvd/9fiNZX5g8o3+tWSnW0Zh4rzc/kxGHl2hZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744799; c=relaxed/simple;
	bh=X03voHUifmb8bqmnBGtDT3nywiB2tpmsP5r6Xw2xkC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afnVCwI8vJopsmcwm4rnYvXU6BrPlktjhr8mlZtSF7JAn2JzVSifEqP5FP+tOtoVqj+pHauDxnn7f6qvFUE8xVwD9uTlnXVhit65O+gQF+k4C6/13uWHGTsYNHlUmPdd7Ra5mZO6LrUYigxAIVN9ToTk8LDR+wgFv2axu/gV26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF+iED/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54737C2BD10;
	Sun, 30 Jun 2024 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719744799;
	bh=X03voHUifmb8bqmnBGtDT3nywiB2tpmsP5r6Xw2xkC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KF+iED/v174xDcyrhsshlcnMfEM9TxeoedZu0DZmgcbqPlJfFmDGM3Ui8Y62nrVYg
	 C9wz09t3zcHRgorYywuel9qTkbh69n72si85C22J0S5eOtZufIyHKWaoWd/VwxDuzS
	 lVZixKciKW2CUKLNP/9sxo4prTL0xHkMQQidEqW+knzGs6dcjjHl3hGdWde0Y5GiEE
	 0oigJQ2AUlWL3Dby/rurYZ8k3nZoiByvtEvw13AAZRPBYC8HbyDw88OhR4TTyUyDnq
	 TVZCKzFy4K/e1qurEiE+eCU8c+Vonc7ubJxj/+HR4/FRL2En5kFJHvD5FdJMaszREy
	 nH7glmjVguIyA==
Date: Sun, 30 Jun 2024 11:53:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] spi: spi-gpio: Add support for MOSI idle state
 configuration
Message-ID: <20240630115307.19865a2f@jic23-huawei>
In-Reply-To: <02a6d235b75d79eb227f0927c5a4614d4b34007b.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	<02a6d235b75d79eb227f0927c5a4614d4b34007b.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 16:05:33 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

