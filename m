Return-Path: <linux-iio+bounces-6294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A461909820
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689DEB214B4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E944C87;
	Sat, 15 Jun 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKsIdi8x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0574A3D;
	Sat, 15 Jun 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453559; cv=none; b=sjCcqvqrhzXCexV7P8lqzSObc2TD5Xb8l4cjxmKlS9DLyd8u940NSK7ZKmUvDzmEc/rvuPn922DosTAek2KavqhNqfj/NusksAfRaTjyo/54XKwR3t3F8JDY6C4f3sn521PTQU/zOPXjz2SVSzkREB7isBYfNAdcJfakd/ZC/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453559; c=relaxed/simple;
	bh=kYHcFOpclZmgp3DRDAGdyvE22AM/3tmX1cHzf6GcUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0LSj0wdTkxMxEZMF0C0g6GWH6fYHFq/NXl/W+2GrjLcVbJ2/47CQEWkheGLXTaLiQcQqeJcxZOcR8f/mb1ARbwMLP4M3/SlBhk1RUS6q2nJ/jwo+V9fKB5iKzni0R/RRRbZ3Of9vEFE0LtPXNGDKfxTM0weQb6L7sSF2hhQrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKsIdi8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1569AC116B1;
	Sat, 15 Jun 2024 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453558;
	bh=kYHcFOpclZmgp3DRDAGdyvE22AM/3tmX1cHzf6GcUV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKsIdi8x4DAVWpfg5kw/pI625KdNMc+dMwN89TFmekREbNjNLPisXWpNNfC9VP2zq
	 qiKmmSlgyRu6/Z6uS4k8ECUYK73cL3KOLBJ76wOryRTHgSY1vBMMYjCM2cPU5sc0ZD
	 itlzqIBSFjGw0UqOwkuqmlbTKC1z9hc/3XsvTNMWIkvCP/ZGNJJvFL4M1HStylRsh4
	 1GJ8j9piBEGQU4UmJSFStt5b6/CwQA3UKBn5l2RVqdWfUWGwXv1HasWywy3iDO0x85
	 3yHD/3V1FSradcdpgcFxkszwr0pa49rQEiSNxcdiAqoxXu3RQgSTeBTcnzmpUWuy70
	 3KR4KTjFBvy8g==
Date: Sat, 15 Jun 2024 13:12:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: ad7266: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240615131230.67fd1b6d@jic23-huawei>
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-2-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	<20240612-iio-adc-ref-supply-refactor-v2-2-fa622e7354e9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:03:06 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

Thanks,

