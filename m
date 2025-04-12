Return-Path: <linux-iio+bounces-18023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95176A86E82
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8A0189E6BA
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E062C204C2E;
	Sat, 12 Apr 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjEffrJ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E5537E9;
	Sat, 12 Apr 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744480495; cv=none; b=OHcOs0SoZpkFDMAjx+z28rbsbMdlGlO3q+sgMF/YPg3+WVmsfufCY94jss19Xt6wFDy8vWJK0dk/4UGVw2dql9VL0R/gg8iLi5nA5kPZiNHA5CNk43OKFCeaq8UVlOWgzjG/AqpQaAx4Jl2wPrRz3biBDN+c5+LK8g8oREe5Yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744480495; c=relaxed/simple;
	bh=xbuahpSaPVBnjCNO9bAbRwZ2X9nVJlK9Sky4zEZfwYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+ztVzHfWNKJ+Xz6pnyk82li1ag7IQWtlGEOJHPbGqBhf2Y7p8eyVh3sOUiVyK2jHwLRDo/zfRMf9GoDSTanzbGoZi9SjdsWDkAH6fm5WBVQj3YAT3U+lbMSNVqmM1fjRyMEESuU8mLUTIDxDkymp2S+Uw91l8mr90waSIIRKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjEffrJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E605FC4CEE3;
	Sat, 12 Apr 2025 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744480495;
	bh=xbuahpSaPVBnjCNO9bAbRwZ2X9nVJlK9Sky4zEZfwYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LjEffrJ57lGbS0AP7tLcVx8PLKoOUZT2H4CQuwGnUaf5xNC66zkGxGEpSJqYQ1Srp
	 D2e4A357/Rt7BMM8BWRy5VQJwrjUQxtLG8EGJHqID/u492rTZqECE7dshW8eXlgAnX
	 2a2Nh3Rc9O/1VnCRKm6/QFgsJVuXCK5VWtL36koWnhtGz2CClZhqFF+/Iehfk+g324
	 7MkMWT0BAAmNo3R1SO7CKTlzBz3sjXUtS1juXkzg+3f0upPfgJa+c4p9HzdPVCfBpj
	 BgwClaKswVTSHu8zaWbBOgeRtlH5W/gUXA/I0KiAe6rAyUXrfb0LPxaFQCOTw+ZD7/
	 nqfaSB5PN19Jg==
Date: Sat, 12 Apr 2025 18:54:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <jonath4nns@gmail.com>,
 <dlechner@baylibre.com>
Subject: Re: [PATCH v5 07/14] iio: adc: ad7768-1: Move buffer allocation to
 a separate function
Message-ID: <20250412185444.6bdf9dd4@jic23-huawei>
In-Reply-To: <11c1777b406875ce1a7216dc4b094ff99af8da7f.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
	<11c1777b406875ce1a7216dc4b094ff99af8da7f.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 12:57:23 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation and related trigger allocation
> in a separate function, making space for adding another type of iio
> buffer if needed.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Applied.

Given the next patch uses the new dt binding (which is queued
behind bindings we are still discussing) I'll stop here.

Hopefully having merged a few patches will make it easier to
focus in on the stuff that needs more review!
It also makes patchwork look less scary :)

Jonathan


