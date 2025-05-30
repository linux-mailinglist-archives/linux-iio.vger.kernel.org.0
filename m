Return-Path: <linux-iio+bounces-20045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E02AC936B
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AC23BD488
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA771D63C2;
	Fri, 30 May 2025 16:19:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF519ABC2;
	Fri, 30 May 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621952; cv=none; b=iRDXYXP6Y0PUS96ONSzIc68FnCxNqAbf/A2f27iEPnN8OGhilw7lg16turhc45CJ3pYgdZA+kcM2mCcLxVGxRMTBBqcOa7ba0bWf/IZVt4M/DEXlTNJ/0ixlSZhAlsW1T8gHdA0u4Yh+fFbAHkBiVLICkYSfSPO4gUmBqNMwIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621952; c=relaxed/simple;
	bh=Y+pQZL/C6jxu5H0SS1Bse9YECSORKb/K40rcX08hx6Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb27mispSUq9mrWs1b1UbWRtd9FC02x1RB5wyin7Bww9yIiYkcweEeUxANhnl5j4Sg9wr7euQJZVftgdX5Vt0pND64NnHXIcOixj1f+WxjsZ3TYjXtgCFGCz2z9YJjNCK58AESAv7ugu7e9sTWJmasuN08maHKbYFzavQFqtir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b87gb6Wm5z6K9GB;
	Sat, 31 May 2025 00:17:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ADA1014027A;
	Sat, 31 May 2025 00:19:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 18:19:05 +0200
Date: Fri, 30 May 2025 17:19:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <andy@kernel.org>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
	<jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
	<linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
	<andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
	<djrscally@gmail.com>
Subject: Re: [PATCH v9 00/12] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <20250530171904.0000467c@huawei.com>
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 29 May 2025 19:47:57 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> This patch series introduces some new features, improvements,
> and fixes for the AD7768-1 ADC driver. 
> 
> The goal is to support all key functionalities listed in the device
> datasheet, including filter mode selection, common mode voltage output
> configuration and GPIO support. Additionally, this includes fixes 
> for SPI communication and for IIO interface, and also code improvements
> to enhance maintainability and readability.

Looks good to me.  I'll be waiting on at least some tags on patch 1 though
before applying this.

Thanks,

Jonathan

