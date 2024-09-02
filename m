Return-Path: <linux-iio+bounces-8960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC696837F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7421F22D93
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639B15C15E;
	Mon,  2 Sep 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mGZLM7ax"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111918661C
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270220; cv=none; b=H+68fgE/q/4Vcici9mkYjDYv3L4bCmVicZK2lcbEVNqnlkcrLOLvzIe5SNS7xCBFfWCpzGu7fbWOy3zd6fbYXpecfepXPQnYOzPm7KGHq4sK3mHQMZHGm0p7SxJVbXBIIZFD9gVqiJRMjyP3XooS3tMdov0ug2bM4PHOFpxOxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270220; c=relaxed/simple;
	bh=vFYXzliYbulbZFPDtTP1Ukj2Okf7o7Ju+zFe6FYtOtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJhTv40rjGbQKquYJu2o9X4LwqHrr0TTl8ojlN3UmV8GsFRgM/5yKif33hzoulImktO7ViD2IJdj7cPMd/U3jKs2lsN+0mHuhBAJNNR0j1tEbZCwrwimDyJ5Y9bGQzikf/h+QeOBRPjxgOyHU30pUzGm/VI67gO7DHAhzKHtpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mGZLM7ax; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=UCK2xw5wUWdxOfPsMgwaIImsMASZGcwJmPeb5lXBOKk=; b=mGZLM7
	axj5gk9it3n0nHllltYQUDEEZQnchIXxxrw/z7ihr8U7/v39FdZ7MzF66xiDEea66UKAUOQQWV/s+
	3IcZYrlzqIbKDshJRUD232eGwInOniIlZ6CcOMOqysa3lV5+rRMgAlRt1uApj0y4f3CQA4oQNQXxc
	JKVYTz3ryTLNfDDi9t8u8LTTaVZv1jjs7AhAKEZUwcyzwiBkT0DickTe6Mj8AutedmQo55Pmh5Q1E
	dhLwJ2uxoWOHs810DRPe32z94c678mAJTm2pZfVNdsbgZzRPP1Fm5HDaQtxvqLicJuQos8M0qWA/k
	XXJZM5zwlUuXKMkWRCBDa95TbIkw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sl3ED-0009Q7-8P; Mon, 02 Sep 2024 11:20:05 +0200
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sl3EC-00086C-0H;
	Mon, 02 Sep 2024 11:20:04 +0200
Date: Mon, 2 Sep 2024 11:20:03 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Marek Vasut <marex@denx.de>, Denis Ciocca <denis.ciocca@st.com>, 
	Rui Miguel Silva <rui.silva@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Danila Tikhonov <danila@jiaxyga.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vasileios Amoiridis <vassilisamir@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/15] iio: accel: fxls8962af: use irq_get_trigger_type()
Message-ID: <ldiwvdejanohe2cettwwoocizpoxmerfs6aeo3acpeya6xy2rh@u6nbqz5nkrby>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-3-jic23@kernel.org>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27385/Sun Sep  1 11:03:40 2024)

On Sun, Sep 01, 2024 at 02:59:37PM UTC, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Sean Nyekjaer <sean@geanix.com>

