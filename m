Return-Path: <linux-iio+bounces-9852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7FF9890B7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 19:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4F11C20FF4
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10413D53E;
	Sat, 28 Sep 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkjoyE25"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440B1E531;
	Sat, 28 Sep 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543768; cv=none; b=QpATyIj4DLsoTNpTNfS2pXpp9aVMxkEKDxCMAR682pWSrW/Yi8u0P15CCrLkOhCbzlxHINrD71xpZPMQkC8y1XARx6rR2Hd37IJOHARA9SqXDyoHTwAR2m0Zbi40ZwpqNYmKsnXjtUE+M/5GmFWSmvWaCFosOED4L0PMQcTJJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543768; c=relaxed/simple;
	bh=njwJBAxOg1Vdkt2Au6KXbbqUhLaPUK/sZBnUjEFKoWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJ0nr/aGMGsCiS/kA54FALbXPN+Mz6kliTTQ+wyaXIm+JyyapkrGoi7v+dsEw/RNGOCQZNv6/7tPb+lzn6V94vsmA+cd3cZ2/MGYdhOGpCbqcAz/ouc3fZdJaj0Ojkf756mJ52Qu9xnaSG3ePrcTkWdOjiVNqdUZg0eDJZMUmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkjoyE25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6465BC4CEC3;
	Sat, 28 Sep 2024 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727543768;
	bh=njwJBAxOg1Vdkt2Au6KXbbqUhLaPUK/sZBnUjEFKoWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BkjoyE25I2KnhKPv5fqZTevPWhQH1ncMHAVJFFiN8oZ857SP2Yy5tpbsBgR3S19KB
	 IAGSC/7wUu73t8kbNN0JEkBxJikFjNrCnKsO70WhlgCZkImeuL/8xnDVhYTKxg/fvN
	 /PKuxwerzL1qyaYMS2hRJih88htqz1BGWWSuSd7kCC0yDMzZS93NmNFT9D9TQwhUnj
	 tzh684cwtoG80Cndim4DGQQQr9eJWwrOEuTRzTgfUUVrVa38f3L6TBmhqnOJzTV+eI
	 G9bZiA9MHE55Fk9Bcovg+BR6A/PMW/B+TtJJr0S/2KSRXOwyHBrQcwMZeTUmLNHv/v
	 Hu8m2h10rQrNw==
Date: Sat, 28 Sep 2024 18:15:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, Dan Carpenter
 <dan.carpenter@linaro.org>, Nuno Sa <nuno.sa@analog.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Richard Leitner <richard.leitner@linux.dev>,
 Stephen Boyd <sboyd@kernel.org>, Wadim Egorov <w.egorov@phytec.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v1] iio: adc: Fix typos in comments across various files
Message-ID: <20240928181558.03bdb444@jic23-huawei>
In-Reply-To: <20240926034411.3482986-1-yujiaoliang@vivo.com>
References: <20240926034411.3482986-1-yujiaoliang@vivo.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 11:43:54 +0800
Yu Jiaoliang <yujiaoliang@vivo.com> wrote:

> This commit fixes several typographical errors in comments within
> the drivers/iio/adc directory. No functional changes are made.
> 
> Detected using codespell.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Applied.

Thanks,

Jonathan

