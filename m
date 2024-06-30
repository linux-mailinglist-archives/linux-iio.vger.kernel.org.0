Return-Path: <linux-iio+bounces-7079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CD91D12F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2804F1C20C03
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B92139CEC;
	Sun, 30 Jun 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDf3vzZ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7928366;
	Sun, 30 Jun 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743959; cv=none; b=acgukTPygWAxkBNqr4BkuRSbbm1J44OcMCUAOs55mdYwE0v1BfJ/Xh4SPlaPGnay1OXjtYbzoeIoeUsxaIDXj+lW+EPKsPWyU6yStY2fcpKfkDh+IqW5bp1KGDTJja0ocEiz64BhZMlwC6tm2KAdwGXcrgwaJKMwq/v+Mohr0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743959; c=relaxed/simple;
	bh=Tj4q6jEJqYSn6+jQMgyMtlL/JqoIylWIkWpK/zH/yBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghXX2ep6FIyl3IYjbIrdQrWdYWmBM7pbK5QYX4jMP7nH80+FPiCt08qsnkGiDIin6ZdDTBGjajYT/viqHlrFfymkTn3UBcF5GloHgMoAUMi5019d4QOUANlnSvZW7vnsH1Yp2/TpwGhLhnFqerXv0hU9NNVXUDb4rZpYkwu/k1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDf3vzZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628EFC2BD10;
	Sun, 30 Jun 2024 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719743959;
	bh=Tj4q6jEJqYSn6+jQMgyMtlL/JqoIylWIkWpK/zH/yBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BDf3vzZ0XVb9ANdmS1PxFS8qCXWmdxO/oyM8XnXQx61IvEzCU4MlVQviGafx2yjpV
	 +Tvt6dnl5PwOyHuYCU9KrrrnhlNbp8KsC382+nLhXuijgl5VKV6r3I4uke1Y6RvpUj
	 NDtKBqLxiHAVKvXHUZeOdmKKuj50tZpSqJP7ApVjpkecwbWIRDN0/srARzS7a3vcm/
	 1re8nk7x2NN6I5AVFtHgk+c3c2yq9E1jJjH60Bh3XakiLqEcedQRQ55YkjTm9zx55W
	 qcYxT79AMCtgafVAlvuqVCP15wJvI+KTxHcSffm5p4hMUNnRZ3KeMPYcQJ5UauPles
	 TMjO8FyHBmaPA==
Date: Sun, 30 Jun 2024 11:39:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ad7944: use
 devm_spi_optimize_message()
Message-ID: <20240630113911.7631403c@jic23-huawei>
In-Reply-To: <20240624-devm_spi_optimize_message-v3-2-912138c27b66@baylibre.com>
References: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
	<20240624-devm_spi_optimize_message-v3-2-912138c27b66@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:46:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use new devm_spi_optimize_message() helper to simplify repeated code
> in the ad7944 driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Merged the updated tag from Mark and applied this on top.

Thanks,

Jonathan

