Return-Path: <linux-iio+bounces-20862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D7AE305F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971B716D7E2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CFC1EE7C6;
	Sun, 22 Jun 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQlz8JDQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8A19C558;
	Sun, 22 Jun 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602111; cv=none; b=L/VMtY9cjdJjsxGY+yVA1xS2gJCwdvNUq2QaXsebXNBXFIPt0q/evHkpoWipmLm38CxX0KCNam4fbeyHGKeL83+vvvjtI5CGa5X5W4adHpJSIwdShjrja1F+y1vgrOPH1BtwtUilRPly3g9ZQ+8Nmr9DScA/UIR96JAYmmtMXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602111; c=relaxed/simple;
	bh=ikA74oaDH2qI9svb5iXDqtReE4s7qej6YuASvwayhBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moOlLIQA0CX4Ukf5e0ZiM5KR3WMlBQnTh8IxexGNrGt+N5b4+NasWyV8zxpy3gkvTOGA+eDNaHDjKbv3rr7Uc90+GLCIZpDCFc4z23PYRRWVmXkIZ8Mu7xSJIjLkNyeXCZmhRqpAx5sGBdNIhiuImErYH4kyT32eezOOxDtT2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQlz8JDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16BCC4CEE3;
	Sun, 22 Jun 2025 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750602110;
	bh=ikA74oaDH2qI9svb5iXDqtReE4s7qej6YuASvwayhBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RQlz8JDQL4b7JNsyD0/oJdVz48sM297Z8ClO46kzHUvRG7MCjA52udg93s58ItcS7
	 wg+L5MpSTt4dR/qzmM3Rn8J6JWU5UaVGNNIrdig/ZRsuL7z45pjVxqadd0U7jZeRUi
	 GTZHm9xwlKkr2jHuizuNwkv6Zmin30HqkgLM6AqcdUlwO50m/gjVbxIPHV3FCL0XoU
	 y/VRf6rTmVWQ8HgTe1WXjJR9KUGedWbiU/cexmLuH3/nfcB7yjocuqxAJhRZ9UUlWU
	 mF0vEaDPwVzGpx66J4QnV3vj7osqprYWhUu4S/CkNS5QSJLA1dKPmOV3WR4T0FCNfd
	 hG5oGH6AxPGAw==
Date: Sun, 22 Jun 2025 15:21:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 12/12] iio: adc: ad4170: Add timestamp channel
Message-ID: <20250622152140.4731d82f@jic23-huawei>
In-Reply-To: <63ebf4408a118a749481ecb3f5ce7ad67cedfa7b.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
	<63ebf4408a118a749481ecb3f5ce7ad67cedfa7b.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 14:39:12 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add timestamp channel allowing to record the moment at which ADC samples
> are captured in buffered read mode.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Rest of the patches look good to me (3-4, 8-12 I think were the ones
I didn't comment on)

