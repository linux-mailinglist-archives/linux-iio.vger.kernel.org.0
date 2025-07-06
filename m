Return-Path: <linux-iio+bounces-21410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20113AFA6B3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5095189B542
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 17:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C864293C42;
	Sun,  6 Jul 2025 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkoouw2A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116429188C;
	Sun,  6 Jul 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821716; cv=none; b=BJlriCXhBxsIr+q/urlgdrYKu8Rez+M/woIxZ2AzAcWMvwu1hDJAsbp2XfagOjJ+QwPalHUUD8/zV+Q2FcVTNu1XH9VMrUrNvYbVvxb3e/qCYApBTkzmy1Ac3sWYZ93FoA0u3KtHRjTkgo3nGZNlRQebObNl0gVKyL/Pxgi8TfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821716; c=relaxed/simple;
	bh=jGUo/7/3W52plc8HkHQT3J6FKdnd3ZnvZhgvvRpzEE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZB0VE2S4J6MOiha9hYTwT4LF3v69tdTSy6WLk6oDulkWSY4Nd8Vd2WjujfanHJEsa+HBB/bxw/+1d4cRmc7GESUj0O7JxpJCwScuTMfjZ5vHmUW0vnod5rpK/UNrBuzV2mDq1lOfLkBjuO5U9gLqP0cwUZYWT7CNZhBXWRP0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkoouw2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BB6C4CEED;
	Sun,  6 Jul 2025 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751821715;
	bh=jGUo/7/3W52plc8HkHQT3J6FKdnd3ZnvZhgvvRpzEE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tkoouw2A6LT2FlqICOuQDGreRKB4cYG9UeONs2pIFe0OpD1Wl3s7N1Q5C8B77T3Kw
	 96av8TKRW6OHrwxWRRRK9ht0Vf7ygUkZalulpEW2oDSu8foLxFp9EGSnr3f3X07UuS
	 5mdu8gg2xwLg/JARfvwCUAyS3Aex32NtiI/v8LktGV+7wqMJWQiBYpj9ywaRl4hN7g
	 G1f3kh32OxkDLNQzbH3lK/VwFIp9Bm2mQdFpVSRI0eqpOC3YyW10Fnq9G9kB7i2c7o
	 IlYzMwIfSZ0t+5pCI2P873KqMNhuPS3GTRnvhyEWkJIxTMVWIbfh5YohM5J8vOB2eX
	 ycPF3mAGZY0SA==
Date: Sun, 6 Jul 2025 18:08:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
 <marcelo.schmitt1@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 01/12] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250706180828.58fdce32@jic23-huawei>
In-Reply-To: <e8efb5e4cfbefade6a4d4f5ee4109257a333713b.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
	<e8efb5e4cfbefade6a4d4f5ee4109257a333713b.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 10:57:59 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Very small tweak whilst applying.  There is a bonus blank line at the
end of the file that I removed.  Git moans about it otherwise.
> +    };
> +...
> +

This one.


