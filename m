Return-Path: <linux-iio+bounces-14221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B7A0AA61
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D373A7035
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D71B4238;
	Sun, 12 Jan 2025 15:19:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5814A8B
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695176; cv=none; b=fw3dwrk2D2Gh8x6ebdkz3sU5peUvOngV/gVu05Hb382jn6662UEdtqowHvYiASTvH41cjrjNo1ThPXP6KEaL63Cg3iDo+6UWFckvoDv0zvSjK1sh/XlbhuvBBQ6hd+7YGUHLhiVC87KmErlIhZKiUuyzZqPPWPmK/LM5erF/Hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695176; c=relaxed/simple;
	bh=Y859hFfsyLG+z8zpMAplC1EJG1kcGjOa5EFaIJocxyo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpnHs+8N8l2/xixqx/2BuxsL8K037ynSMXhRjsxlFlKkeAZG1dDItaYIXa3lDWqdaC1vEzuEANnSq7CkA2EgEl9aqEJPCdEcj5FLk6G1W0KeVkt5t4snbrVlsIZlJWcf/U0IGRT2OHaY1CesGZu2R/Gs732/JaRquROtMhy3bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 76eb2478-d0f8-11ef-9cd8-005056bd6ce9;
	Sun, 12 Jan 2025 17:18:24 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 17:18:23 +0200
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
Message-ID: <Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>

Tue, Dec 24, 2024 at 11:59:02AM +0100, Javier Carrasco kirjoitti:
> The configuration and ID registers are not volatile and are not affected
> by read operations (i.e. not precious), making them suitable to be
> cached in order to reduce the number of accesses to the device.

...

>  static const struct regmap_config veml3235_regmap_config = {
>  	.name = "veml3235_regmap",
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.max_register = VEML3235_REG_ID,
>  	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.rd_table = &veml3235_readable_table,
> +	.wr_table = &veml3235_writable_table,
> +	.volatile_table = &veml3235_volatile_table,
> +	.cache_type = REGCACHE_RBTREE,

Any specific reason why this is NOT a maple tree?

>  };

-- 
With Best Regards,
Andy Shevchenko



