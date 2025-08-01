Return-Path: <linux-iio+bounces-22174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C517B180BA
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307D21C81EB2
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC723BF91;
	Fri,  1 Aug 2025 11:12:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAC238D57;
	Fri,  1 Aug 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046761; cv=none; b=dVqMs5le/H2ilGpDH0Fubtz0PKR3soFw2KoJqbZWIkmfoQghL2etv9RJ2KEOFVoWHC6/DORKJOrqnzA4+xGBKh0fMTbirWyPMaCF8ytOpTOGb80HxlpmtIJgV/JE/KJcC7VSI2QTIeMd1A4PEz1FiVjbsPKks7irfoZNalgTZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046761; c=relaxed/simple;
	bh=QNJ/tvonAX7hZ3GTAWAF6A0zR1tbH2Np4TTm/hN/1Nk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leVlTPxZbHCGTF/eZP20Sd/QdR09J0BHomUNggsUzZUgWXBEKFKKVbRSqTmCwrvpnI1Azzy45a0+yzRgD7T05iviNxBTVtao/q4FVwdCKRTLoM1NRjB3YUG1X4XrT2AeEi8H7VKrzanPAcTmBSdjF8ShJ6cfbUW+Fe/G6Lu+v6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btjqL6Cz7z6GD8B;
	Fri,  1 Aug 2025 19:08:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4699B140371;
	Fri,  1 Aug 2025 19:12:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Aug
 2025 13:12:32 +0200
Date: Fri, 1 Aug 2025 12:12:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] iio: adc: ad7476: Simplify scale handling
Message-ID: <20250801121231.0000298d@huawei.com>
In-Reply-To: <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
References: <cover.1754041258.git.mazziesaccount@gmail.com>
	<1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 1 Aug 2025 13:07:39 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ad7476 driver supports variants with different amount of supply
> regulators. On some variants there is only VCC, which is used as a
> reference voltage. Others have separate VREF regulator, and some rely on
> internal VREF. Some have both internal VREF and option to connect
> external one.
> 
> The ad7476 driver reads the regulator voltage only when the user asks to
> get the scale. This means the driver needs to do some dancing while
> picking the correct reference regulator (or internal reference), and
> store it for the later use.
> 
> According to the discussion:
> https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawei/
> variable voltage references are rare, making it hard to justify the
> added complexity for supporting those.
> 
> Drop the support for the variable voltage references and simplify things
> by using the managed regulator get and enable interfaces.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

So there is risk of regression in doing this to an existing driver.
I'm not that worried about it because as you note, we almost never
see variable reference voltages.  So this is the whole, if no one notices
it's not a regression exception to Linus' rules on regressions.
 
Looks good to me.

Jonathan

