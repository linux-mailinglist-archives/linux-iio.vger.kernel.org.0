Return-Path: <linux-iio+bounces-9781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57703986EA1
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 10:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66EA2834D2
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D81A42D2;
	Thu, 26 Sep 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gItNIB6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD7143C4C;
	Thu, 26 Sep 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338799; cv=none; b=H6orxe5baFiTu6k4hp3b0eDALMkGUJtHmCZXdMgfdWNzP7wAPIZpx7/+UbzC1uiAE9Yvb+KbJvjIRokgcsX2j0QcfhfrjCSL0BsVucxPTTRSopaGcL7FwMREBzDwmEdjiJ0acJs5aISaQzz9iKh5lpQjFzV3y9qyyewbW9cHjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338799; c=relaxed/simple;
	bh=3xkB7qsfl6gEMdb6P+8lKB/6/behm+H5Tvf9MRznwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEQt40klyqzD9YgUbcXEkOg6HBmucSkUQiG3jmxUdYRRaIpwAepASHKeaOvlhpM1nF2IqCMm2E+itB46geTgt5Gudb+TYPQ/ZED2XEzt6HVajhmbd3uhaS4pdjMnjk5G0k0+9NcLOlNPGlT+O8/kUnWLDeYhTGIIkvXUbBc+f+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gItNIB6n; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 296504000E;
	Thu, 26 Sep 2024 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727338789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwLUqRkyD3Eruc35UHJuAT0u8bQ7Br0xc4xyX8+nkzU=;
	b=gItNIB6n7q08IeCqHIYzAnmU51PGZVxXVL69C70WkOp+ECOiIQWWg6m5vEbn/uccqf90lK
	vu4Stj0I7W2pPYSGHzXKszOK3DWMBO2PPLJwBVyJpRMSAUoUTJkz+bb+qCWI9z+CWhGz4D
	o8KTpBu33NAU5YqpktXTGedmWW0hDb9SL6BxJ8JH5YovZC3TUpPPC11IrpQFWNtLT2z7D2
	Srr1yaFvRMUNfW1vtKNOhAAsv3cMc6/51LZOgPRUa1C/XR/BwOjlBbC63oTj8nIVbAOqDf
	180si3I7KuR9ceIwkQmsCsvuNYQAHBhfhZc7b9kgk7Kd+c3OYTFGQMtq/dnI1g==
Date: Thu, 26 Sep 2024 10:19:40 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Jonathan Cameron <jic23@kernel.org>, Matteo
 Martelli <matteomartelli3@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Dan Carpenter <dan.carpenter@linaro.org>, Nuno
 Sa <nuno.sa@analog.com>, Richard Leitner <richard.leitner@linux.dev>,
 Stephen Boyd <sboyd@kernel.org>, Wadim Egorov <w.egorov@phytec.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v1] iio: adc: Fix typos in comments across various files
Message-ID: <20240926101940.22bbc3fe@booty>
In-Reply-To: <20240926034411.3482986-1-yujiaoliang@vivo.com>
References: <20240926034411.3482986-1-yujiaoliang@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Yu,

On Thu, 26 Sep 2024 11:43:54 +0800
Yu Jiaoliang <yujiaoliang@vivo.com> wrote:

> This commit fixes several typographical errors in comments within
> the drivers/iio/adc directory. No functional changes are made.

I think it would be useful to add those typo patterns to
scripts/spelling.txt, so checkpatch.pl will check them, preventing the
same typos from happening in the future.

With that added (perhaps in a separate patch), looks good.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

