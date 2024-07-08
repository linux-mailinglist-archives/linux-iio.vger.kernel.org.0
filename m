Return-Path: <linux-iio+bounces-7446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05992A6E3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9C71F214F1
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE162146D7F;
	Mon,  8 Jul 2024 16:09:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379F145325;
	Mon,  8 Jul 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454966; cv=none; b=pTZxRFLXDx3kDyAQMNdYm/HfK2MUWfwD42DqZPrW+NpjQESJz8qE9XSX3tMHodoJUwsH6rfYuRNbDSeoZTE2m1GJXgdggKq08NzjaRe3Q8P+TaPv4Iu+95wflhL0WwPd3xIzybNa8nO/bnIDmTtc6LvxWRRUEPN6oZl8ihjJnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454966; c=relaxed/simple;
	bh=+YSFfZdBcRElqfc6eZRiCHjZW90d0oX/Mv7xgN23IB0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLAF90REvkP3ciyqwCNTNf6x0gqXja/WfZlk4dH/g1N/KJ7WgKR4zerqduEx/hP1hOrsC79nkkPGDfIdHfAVEi5nP6Bw3ZTCF3K0iEnzUFBDkxkjP0WcG7Xt86Uw8gARxzHdP0IRpHfxEcIK13jeU61ujOLDfZ5y7J/AiRHfn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHptn6p7wz6K5pY;
	Tue,  9 Jul 2024 00:08:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AA9F1140C72;
	Tue,  9 Jul 2024 00:09:21 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 17:09:21 +0100
Date: Mon, 8 Jul 2024 17:09:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC: Alexandru-Aleodor Ardelean <aardelean@baylibre.com>, "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Jun Yan <jerrysteve1101@gmail.com>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: accel: add ADXL380 driver
Message-ID: <20240708170920.00003164@Huawei.com>
In-Reply-To: <CY4PR03MB3399017B1616B06636DC0D0D9BDA2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240701083138.15891-1-antoniu.miclaus@analog.com>
	<20240701083138.15891-2-antoniu.miclaus@analog.com>
	<CA+GgBR89nOCwrGgU=fsS_+woj9mDeqR_hizZMjNgLtxoZ+pY=Q@mail.gmail.com>
	<CY4PR03MB3399017B1616B06636DC0D0D9BDA2@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

*Grumpier*

Crop to relevant parts of email.

