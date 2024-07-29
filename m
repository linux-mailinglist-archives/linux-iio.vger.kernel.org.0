Return-Path: <linux-iio+bounces-8027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608593FBD9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 18:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20812282599
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F3146A9F;
	Mon, 29 Jul 2024 16:52:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30917756;
	Mon, 29 Jul 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271933; cv=none; b=OGW1YrhiUw4mWHwwyer368zx19xFuKGM5UuZaW7MGqFuxcR26safmNP2CknkO7HR0IwN5oS5feDz0/Rc3WbU89FgrT/Mc5vgPjUA4RnVUERY9V0m5MS7m+COnn+Ka31xoiji8sa9vCvy3OEwcDo5hmNrib2bN4Ii9Wt8pA/iK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271933; c=relaxed/simple;
	bh=B7B6J1Z/yKeVtyZOSRs+2aYFdcDi8KnoZp9Rz3dRt4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBIoh7qgLwlqozyeE7NG8AoIaFEtK24M6uAbL4Y0s1o+wCculudguJta9YW+RQ7BCos9a+kwlHfC36eWaPT/Fk+51ECTT2SN9BQGc6iYvBB/N+u1RN016oG+G9tuiO/4qCgKMWCTXpxbSv6MckSJmGdYX7GCtuVQ+UNzfVwcX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYTbR-0006KP-Tn; Mon, 29 Jul 2024 18:52:05 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 nuno.sa@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject:
 Re: [PATCH 06/23] iio: adc: rockchip_saradc: make use of
 iio_for_each_active_channel()
Date: Mon, 29 Jul 2024 18:52:04 +0200
Message-ID: <2384416.OYXXYNVTWy@diego>
In-Reply-To:
 <20240726-dev-iio-masklength-private3-v1-6-82913fc0fb87@analog.com>
References:
 <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
 <20240726-dev-iio-masklength-private3-v1-6-82913fc0fb87@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 26. Juli 2024, 10:22:58 CEST schrieb Nuno Sa via B4 Relay:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/iio/adc/rockchip_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index bbe954a738c7..71f58e3a8307 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -370,7 +370,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
>  
>  	mutex_lock(&info->lock);
>  
> -	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
> +	iio_for_each_active_channel(i_dev, i) {
>  		const struct iio_chan_spec *chan = &i_dev->channels[i];
>  
>  		ret = rockchip_saradc_conversion(info, chan);
> 
> 





