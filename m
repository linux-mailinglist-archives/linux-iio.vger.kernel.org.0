Return-Path: <linux-iio+bounces-9211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF5096E208
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CDD1F22756
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA787176FD3;
	Thu,  5 Sep 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+RAfAm5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F48821;
	Thu,  5 Sep 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561074; cv=none; b=ePusA8AdqpfdrpuR6v1UBYb9U4oKxugbmkt5W/46QJSFUvzd6uhxXTCenuLAcJ4lvXzMsPvnPWxwocYnHGdZ8/5T2VTbp8OU9BfumqsicV60p+muJw+xwb0GtJ+VpcmGglkyeNiDUc5sIIkyky/PplCIilY9rjLDp3JSfNaOlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561074; c=relaxed/simple;
	bh=GwzqxSiTBCO2xewW5t4Ce9dzQXimbeoRoVoQ9B8E/ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/3xXogL1Efgy1KPYIEOTz2dhZFAcH6GxNQVLECDb61kzgRqZkWqqRjgbN54HcTrnri2tzb5AWMaumlaXyddS3uvYWT1Z6Lr809Nsni/6xJ4eH1XlwlfwXzpmFyEQ/eMogvh1qW0jblmm6YHN7rZHV8vzJoYWQoUiFTOgCyaEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+RAfAm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D9C4CEC3;
	Thu,  5 Sep 2024 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561074;
	bh=GwzqxSiTBCO2xewW5t4Ce9dzQXimbeoRoVoQ9B8E/ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+RAfAm5cQBVNXZdMrsjq6gwsZuC3EWvdoUmfw9T2Wkf6vVSOMa2KE16cVTZIGxG8
	 EJOSkzuFTXtZBBnTXupoTZaUMiZGDGw5z6EBml0jzmX7turzzjVOtWnSvN7jDMhTDN
	 ZhPsV32kElFn1dYVfnqT+ojyg4OsZtBmyemb8JoIORxHdSCXNLS2wHte0VI7YdlEZb
	 Aa/ncee9R/jifzXi5e/KoCtHcw1tCapb3BEeAmggImskDS1WFh88mRy/5aayN02/my
	 pl+XwT+Dr+nYK0dQ4sMddKBHJi54+EfxX/KuS+wJZz04n0LHpDYwpc1FVHvqIHk68y
	 28rMhFYEk3n9w==
Date: Thu, 5 Sep 2024 19:31:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 andy.shevchenko@gmail.com, liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V10 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <20240905193105.16a4a060@jic23-huawei>
In-Reply-To: <20240904113555.1538635-3-wangshuaijie@awinic.com>
References: <20240904113555.1538635-1-wangshuaijie@awinic.com>
	<20240904113555.1538635-3-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 11:35:55 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> AW96103 is a low power consumption capacitive touch and proximity controller.
> Each channel can be independently config as sensor input, shield output.
> 
> Channel Information:
>   aw96103: 3-channel
>   aw96105: 5-channel
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
Once a series had been applied, send patches on top.
That means if you want to adopt Andy's suggestions then break
it up into a series where each patch is a particular type of change.

That allows rapid review in comparison with sending the thing
all over again. As such I've just fixed the early return issue directly.


Some of the changes would be rejected.
> +
> +#define FAR			0x00
> +#define TRIGGER_TH0		BIT(24)
> +#define TRIGGER_TH1		(BIT(24) | BIT(16))
> +#define TRIGGER_TH2		(BIT(24) | BIT(16) | BIT(8))
> +#define TRIGGER_TH3		(BIT(24) | BIT(16) | BIT(8) | BIT(0))
> +#define TRIGGER_TH_MASK		(BIT(24) | BIT(16) | BIT(8) | BIT(0))
No. If you want to use BIT then each BIT needs a meaningful define.
If the bit's on their own convey no useful meaning then define these
differently.

Jonathan



