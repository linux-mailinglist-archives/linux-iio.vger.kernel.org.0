Return-Path: <linux-iio+bounces-18022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2400A86E7A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDB0189E1C5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808AB2045AD;
	Sat, 12 Apr 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm3ash60"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5C1EB180;
	Sat, 12 Apr 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744480364; cv=none; b=sE3xy6fwclBaa4agH9+zJo7agOSFPcWqLYLdiIop0M0XDikFl/b7k38iaU0rnUK/q58qyQR519QWfzvpp2Uoi7dYLZRhlUEU8DlDzGz6vun7fEleDsPIkoIeIDlAkRIDEGMv6ZLUp/zBgJToy8uiwU3TmWd98zhgScKGHcN4C1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744480364; c=relaxed/simple;
	bh=tVAyxGy5hcA+WYeQKPWG6gOJgxABjUD9Lx8l+XEH1aY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqtoh9+6gQPJl/YKAUIbH+KI6FS35sIAmjgec67tkMszS2UjFwgef0G/oGz0HAMMKYVo26/jZmEzyWrX/jGyJEyISK9lJkdnk5n/jpBgeMfr61F3NW93kSx0u5BbxzoTgM48ClK51ML1Xe0NDndrwLFDHf+laUQvc+YoK9Ts4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm3ash60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B688C4CEE3;
	Sat, 12 Apr 2025 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744480363;
	bh=tVAyxGy5hcA+WYeQKPWG6gOJgxABjUD9Lx8l+XEH1aY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nm3ash60fpHYNwv7Av5atBaI+eLMLLEhBuQy2Gxw7VfAvCZ32e4302/EfB5nx9LWq
	 uUWYh+1sWxOYPtIrTSpxPnp/qaHLZls/L3bsRwnCor2pjk+GdaREZC7kD/2rrUSj9U
	 kLs8qydzHPpUfBY8Sca+ULbszDKI9pk7E91xmue/6UZ8UuJyl6pye1fFZbFUcvEhG+
	 A0KuSGb49PhV3Mxmy3GOC90eSJasvi2K9Drb4Luxuu3sP5tafpwQCBhQd/gYwQa3bs
	 knOk5oNFQlOw38wHoq1vxK1KYH4BC75ciuU57x2l9khZBKhEtND08G+4XOBeCzC7oP
	 OcaRUdGBzhoOQ==
Date: Sat, 12 Apr 2025 18:52:32 +0100
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
Subject: Re: [PATCH v5 06/14] iio: adc: ad7768-1: Add reset gpio
Message-ID: <20250412185232.478d1c57@jic23-huawei>
In-Reply-To: <25a413babeddf29583f1c26abf4234dfd606a595.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
	<25a413babeddf29583f1c26abf4234dfd606a595.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 12:57:09 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Implement asynchronous hardware reset GPIO.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

