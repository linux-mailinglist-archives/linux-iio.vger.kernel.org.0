Return-Path: <linux-iio+bounces-7048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2A591CE66
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C7A282C1C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E586255;
	Sat, 29 Jun 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDwSqwqf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6F20DE8;
	Sat, 29 Jun 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683243; cv=none; b=WPBzYqmg3AgEM+/3vUhXPEtgKll+0Y6VlpaPWOF2tQdjGUktD6XK/z7cehZDnrqU9LeZNs5jOpCh0VfB4ujZqN1xUKdEmWmlDFYER5Zz/ZQGtw7ZGQpkOCm26vF3cRB43OwNZvp8X642E/LQoVb91Fj3/n749onA/dNU8DB7tD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683243; c=relaxed/simple;
	bh=ucondZEsatUWCjlxK69XIYXU87xs6bDJEuRfh2m1bTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQJniEfPnLWc2VJh8hdGjrirLVuIhMkl+K0wYy6SQeo+xcZOdA7C6Gx3yzr/vjJW3MKrewdWb+IlM/j7S5DKgklqsEL/nyQug9TmBgsFWpChBg7eMS2QSsGIvCA+aaePo0AoF0xweNH4T4nrC/PA+BZI4YS/ZekAlnqLMlxC3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDwSqwqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C95C2BBFC;
	Sat, 29 Jun 2024 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719683243;
	bh=ucondZEsatUWCjlxK69XIYXU87xs6bDJEuRfh2m1bTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDwSqwqf6S6bVCzCKXqp9pOQAV8YFhCgBb0/0aGJnJYPvTudRP54u62+4dKDvsBFR
	 ysNylb8N/dk12vkbVN6Ga4uRovObvf/j99QPkkrlwhYO8dFXWlbGDQly4Czzd7G/Hb
	 mFGDk6GQ0R3YJ4f6Zem0Y3FCXmKmlX1skqiuZRTZ46bitgEneSJ9q4KUxZUceh1cTO
	 J/3+vUgjzbLRNdbdIIwAq09YJLNpufuM1UmKrMIcq/ylOtUsXE0uKBlSf3mEyKbDyh
	 Z4ONY2dtVgpOpoIiNZMkp3jm4wzGBPhyustEK7cpONjntdNj40LRn+p4Jkqi//AG8V
	 bh+zfFuyGF8UQ==
Date: Sat, 29 Jun 2024 18:47:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add AVAGO APDS9306
Message-ID: <20240629184716.69aad230@jic23-huawei>
In-Reply-To: <20240626135231.8937-1-subhajit.ghosh@tweaklogic.com>
References: <20240626135231.8937-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 23:22:31 +0930
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Add myself as maintainer of APDS9306 ambient light sensor driver.
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Applied. Thanks
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ca8f35dfe03..ebe19ba2d62f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3521,6 +3521,13 @@ F:	include/linux/cfag12864b.h
>  F:	include/uapi/linux/map_to_14segment.h
>  F:	include/uapi/linux/map_to_7segment.h
>  
> +AVAGO APDS9306 AMBIENT LIGHT SENSOR DRIVER
> +M:	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> +F:	drivers/iio/light/apds9306.c
> +
>  AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
>  M:	Andreas Klinger <ak@it-klinger.de>
>  L:	linux-iio@vger.kernel.org
> 
> base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81


