Return-Path: <linux-iio+bounces-16360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB7EA4E317
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C18884F03
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91625A334;
	Tue,  4 Mar 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOKcZPIE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BC25FA09;
	Tue,  4 Mar 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100662; cv=none; b=MqLlugXp9kqY/7P1dWs3R7pnY8eQOVwjLCblqDqlNlJuGawYPnAGOAivAy9hl7cjE2QE58SomcWiC2y5oPe+IbNDI3r1EhTyF5446FXr9+qzBcJ161hiVwZRjkNfYdqgFsJKlymtwAmi8wR1FMJ+1BFOgBZKvtrhKrIGxltU2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100662; c=relaxed/simple;
	bh=+o6T0HzgdvGFUJUX7UuMNF1GylzuupLD2kKACC8bxn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZnVFU8exnXg/Ru/Ba2PQx0xjyn3pjRNhms7T8vsVO9l0qe8x0rAtndY55F2RZVLYrjUCztQ0wwvSQYA6OGyyCUvPDVZ1KR0dnM58ZZQPPFuZB/xeGCSsMelRCZx2gP9ZmmS8RBX7x/w7T5tbnw7eRZlLE9Ic06yAgolhciIhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOKcZPIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2276C4CEE5;
	Tue,  4 Mar 2025 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100660;
	bh=+o6T0HzgdvGFUJUX7UuMNF1GylzuupLD2kKACC8bxn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOKcZPIEhcrkofgzaIVvzJHIRBcXFmCvpTQnHlmEAXJgUuy+KP0OKvkIFjwFB3ont
	 T2c5/8G9ogWmCYYbgcBF6/oFbLRXW2ZSclmf5viUsP4cABtvbh2CllxuUrqKUW5whE
	 O/vdRVnol73I4fAxzswWq1F9SCApNRiFVE+lHBKjgsMt6t5IhQyYonBYPiNKCjIPGB
	 iznXH2YiNwDxhystF12REQU4yKwq4mBvodK5ks2obqz+LjFF8Pu6Yf+nw7Numd5G6A
	 Si54WASMn9PdPPDy5jiayoNOYb1QgYgBjmecoYwM7T9PzyebI/OoxI5VjZIOvDyYoq
	 ySQo+O1oM/qNw==
Date: Tue, 4 Mar 2025 15:04:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, Simon Xue
 <xxm@rock-chips.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] iio: adc: rockchip_saradc: add rk3562
Message-ID: <20250304150408.60864bbd@jic23-huawei>
In-Reply-To: <20250227110343.2342017-2-kever.yang@rock-chips.com>
References: <20250227110343.2342017-1-kever.yang@rock-chips.com>
	<20250227110343.2342017-2-kever.yang@rock-chips.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 19:03:43 +0800
Kever Yang <kever.yang@rock-chips.com> wrote:

> From: Simon Xue <xxm@rock-chips.com>
> 
> rk3562 is using v2 saradc with 8 channels.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/iio/adc/rockchip_saradc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index a29e54754c8f..9995f95bafe0 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Rockchip Successive Approximation Register (SAR) A/D Converter
> - * Copyright (C) 2014 ROCKCHIP, Inc.
> + * Copyright (C) 2014 Rockchip Electronics Co., Ltd.
This 'fixup' should have been mentioned in the patch description.
Not that important though so I'll leave it this time.

