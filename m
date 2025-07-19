Return-Path: <linux-iio+bounces-21770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6516B0AF75
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF2A1AA361C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC4B21D3D9;
	Sat, 19 Jul 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByOBc4xQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AED221FD0
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923065; cv=none; b=kdUI/yDEpHeVmdm3SIFKH2y4BopX+GQ3l36c984GZ84XvOuoVfOu9fAKYV6dDSmHHwQUvg/AUWmYcv4kn5xKA7lSuqpvBb6sdAtKqD8Bil9mmHkX4Z+yZEQs0Z3FJ06j1LI8xXwDm7pY22KSkumubN/npJrRPvdrFlu4kUCs18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923065; c=relaxed/simple;
	bh=Kk9PDXqyT6VHtUPHmnFrV0Jo2ljHug1/0opnOMT8VxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6dmtPHiCnsQiInoyIbmizckAY9ijMOgMlz+JLUUxPdOc20Ixm6g8wzXlNhdrLw/V1EqrP6D3qdVZqRDcZF6YgovtPXwNp5lrg/kAH1jvjnWrrgkzJisS8LRsy74unT8K79qh+qu/ESrAnoOFA2Lk1Kzq+Ia8PIPsts/nCPT4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByOBc4xQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B003C4CEE3;
	Sat, 19 Jul 2025 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752923064;
	bh=Kk9PDXqyT6VHtUPHmnFrV0Jo2ljHug1/0opnOMT8VxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ByOBc4xQ2/tSm4uian0FmWOlIwwGZSJ5wG1gRjRwcl8iEw5kcoO8Qq+qWOWYAs2p0
	 0IN2tWvcOEF042jHTXGeGLW0xWI289mIOITKbgycFn8C1FoxVLGzN9H9HeopJCOVeK
	 HaXUwbvDW+6U4daoceLsKFyqmmhVZYMCpBEsBILRtAxsZepLWHtwGxFLsLXA5Rt6f8
	 RewjjXTaDK4InWoCKatD8zQznkRlrk5i9zalOl+2nKGPePSJMI9gxGsy6EJ6i/UPie
	 ql4l8nPjeEUj1oKJZYaEWtCdL8ocBHboD7/gmENLAhBtDHE94GEkXW9coULz0e/2PJ
	 UYzuA0fYnQgOw==
Date: Sat, 19 Jul 2025 12:04:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Message-ID: <20250719120417.7bef0731@jic23-huawei>
In-Reply-To: <a0d1bcf9-74e1-43cb-9f4f-1fb6f5b20724@kernel.org>
References: <20241219230028.55987-1-hdegoede@redhat.com>
	<20241220194249.434244e0@jic23-huawei>
	<a0d1bcf9-74e1-43cb-9f4f-1fb6f5b20724@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> >> +	ret = wait_event_timeout(info->wait, info->conversion_done, 5 * HZ);
> >> +	if (ret == 0) {
> >> +		dev_err(info->dev, "Error sample timeout\n");
> >> +		ret = -ETIMEDOUT;
> >> +		goto disable_adc;
> >> +	}
> >> +
> >> +	ret = regmap_read(info->regmap, chan->address, &msb);
> >> +	if (ret)
> >> +		goto disable_adc;
> >> +
> >> +	ret = regmap_read(info->regmap, chan->address + 1, &lsb);  
> > bulk read and an endian conversion + mask?  
> 
> This chip only supports reading 1 register at a time, I'll add
> a comment about this.

Set regmap_config.use_single_read and bulk reads should be fine.

> 
> >   
> >> +	if (ret)
> >> +		goto disable_adc;

Jonathan

