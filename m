Return-Path: <linux-iio+bounces-14765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B4A24288
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53BF3A86E6
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E101F1312;
	Fri, 31 Jan 2025 18:26:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216921386C9;
	Fri, 31 Jan 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348014; cv=none; b=Wn04VlYDLg4c5Urkf65xmH/8DSQE/iyBsm43qfhGS5KAYIcb3KtVIxSDufaNfutiBdYdog1UdOLw0A30vCd+TscmYR1JLlg8oOH0lz0df2U3zickzQ/ykZ7h1sLHQASKQbrxAyicKhnlUXWK/bXbInlgthTTCunKmDHrY2zdnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348014; c=relaxed/simple;
	bh=89EpppYLahohyJXwbRVtozTnNghfoBYxxrd+uwpQ6gI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdBOKmqbo0tWR2XBjt9k7MmhJG5n3y4sv3a+zW1i5L90+P5BihnA09YgEEyi4f15JRUoHVAiCA28JLJ7n2HUyV3l7S6xiVuVyclvJ4Dk1byViAGO/1ugXahwne9sqF3jH8UBfT/VOAj8WHihd3NGHz7GYGW+OnFKDX6G7cei2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl46g06r7z687rH;
	Sat,  1 Feb 2025 02:24:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D1B44140520;
	Sat,  1 Feb 2025 02:26:49 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 19:26:48 +0100
Date: Fri, 31 Jan 2025 18:26:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
CC: Alisa-Dariana Roman <alisa.roman@analog.com>, David Lechner
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH v3 0/3] Add support for AD7191
Message-ID: <20250131182646.000074b6@huawei.com>
In-Reply-To: <20250129143054.225322-1-alisa.roman@analog.com>
References: <20250129143054.225322-1-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 29 Jan 2025 16:29:01 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Thank you all for your feedback! Here is the updated series of patches!
> 
> I addressed all the replies' points, except for the one about the size of the
> avail array being 1 when the pga/odr pins are pin-strapped. David raised a very
> good point, but, for now, I left the size fixed to 4, since the functions for
> setting the values return error anyway when they are pin-strapped.
Shouldn't have them pretending they can be changed when they can't
(which is what I think you mean about size fixed to 4). So this needs resolving.
> 
> I thought of 3 approaches:
> 	- dynamic allocation for the avail arrays
Probably best avoided.

> 	- different avail array for the 2 different cases (pin-strap or gpios)
That works for me.

> 	- different channels array for the 2 different cases (probably too much)

It is a bit odd to list avail when only one value, but not wrong as such so
I think no need to go this far, though maybe there is a userspace library
this might confuse?

> 
> If the current setup if not good enough, which approach would be the best?
> 
> Kind regards,
> Alisa-Dariana Roman.
> 
> ---
> 
> v2: https://lore.kernel.org/all/20250122132821.126600-1-alisa.roman@analog.com/
> 
> v2 -> v3:
> 	- correct binding title
> 	- remove clksel_state and clksel_gpio, assume the clksel pin is always
> pinstrapped
> 	- rephrase clocks description accordingly
> 	- simplify binding constraints
> 	- specify in binding description that PDOWN must be connected to SPI's
> controller's CS
> 	- add minItems for gpios in bindings
> 	- make scope explicit for mutex guard
> 	- remove spi irq check
> 	- add id_table to spi_driver struct
> 	- changed comments as suggested
> 	- use spi_message_init_with_transfers()
> 	- default returns an error in ad7191_set_mode()
> 	- replace hard-coded 2 with st->pga_gpios->ndescs
> 	- use gpiod_set_array_value_cansleep()
> 	- change .storagebits to 32
> 	- check return value for ad_sd_init()
> 	- change to adi,odr-value and adi,pga-value, which now accepts the value as
> suggested
> 	- modify variables names and refactor the setup of odr and pga gpios,
> indexes and available arrays into ad7191_config_setup(), since they are all
> related
> 	- add ad7191.rst
> 
> v1: https://lore.kernel.org/all/20241221155926.81954-1-alisa.roman@analog.com/
> 
> v1 -> v2:
> 	- removed patch adding function in ad_sigma_delta.h/.c
> 	- added a function set_cs() for asserting/deasserting the cs
> 	- handle pinstrapping cases
> 	- refactored all clock handling
> 	- updated bindings: corrected and added new things
> 	- -> address of the channels is used in set_channel()  
> 	- addressed all the other changes
> 


