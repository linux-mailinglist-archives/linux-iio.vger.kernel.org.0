Return-Path: <linux-iio+bounces-25264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF709BEE0DA
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABD9189D6AE
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D011829E0F6;
	Sun, 19 Oct 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJrmSMf0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414A29D29F;
	Sun, 19 Oct 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863508; cv=none; b=vBIsy0kJJWjZU1aIxRP79tebNKbZ98yJ9iiSOA3IBD12Yfek+zXx2yrMOnnOvO1/XOQW8ly7z9iysDrO2AXDaIfA+ZkFcbzihgyA+lA0xwxXMhYjFRfJYqSKPz3OnE5QNyBlbsVaQ8ItSmuYot76zKiXxREXyn4mqesMwEdG9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863508; c=relaxed/simple;
	bh=XNsXfptiTPBzXfAOv2YWIKUVvn2h8DGBaJd5ic+km+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rA1mq5p2JBeaocyUxnIoLijgw1LdcfTF4hxEsKPmo0rY2/aDopAMUsrJMLa67zDx1PcjvV3nxAHG5/kZv5boH09yBC/Z95VePdoB7khGRjpQzMLXL5zCAQblX6N3fIMt7DIT4TGsulDpar8ACN6A46KGy3uhET40Olv+uVCul3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJrmSMf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0F4C4CEE7;
	Sun, 19 Oct 2025 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760863503;
	bh=XNsXfptiTPBzXfAOv2YWIKUVvn2h8DGBaJd5ic+km+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJrmSMf0PGl5tG9QMwvuvHHctsml3uuXMmiSAQzPt0t3V+6qRJBpXuEV7IZQ4GcjX
	 v76zTOALiuWrBVZT1GlPUcYwOMYlwZ2ONCk0WHtslhY8GWYSpteLcA47HNe6wt3hV6
	 TB1jVdObQwr5Al0YU6dI+rerG7bU5HiRuSP0BPbQYbrkKqZyMwgkUCQ2xc2xcNZb2F
	 4YVOm9sooJa51TaGVaZ9hX/gc/vLECc5DVag0q7rAYPtP1gSA9G3oGOypry9oSQwrd
	 VD1sab9aXGBkO8QhxxwjeEzhfuTqtzwwm8munjgAigNwHlP7Grm+TUvIHxeb566FTP
	 /pE44YU38popw==
Date: Sun, 19 Oct 2025 09:44:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-vadc-common: fix vadc_scale_fn_type
 kernel-doc
Message-ID: <20251019094458.141971a7@jic23-huawei>
In-Reply-To: <20251017070728.1637804-1-rdunlap@infradead.org>
References: <20251017070728.1637804-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 00:07:27 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix multiple warnings in enum vadc_scale_fn_type by adding a leading
> '@' to the kernel-doc descriptions.
> 
> Fixed 14 warnings in this one enum, such as:
> Warning: include/linux/iio/adc/qcom-vadc-common.h:123 Enum value
>  'SCALE_DEFAULT' not described in enum 'vadc_scale_fn_type'
> Warning: ../include/linux/iio/adc/qcom-vadc-common.h:123 Enum value
>  'SCALE_THERM_100K_PULLUP' not described in enum 'vadc_scale_fn_type'
> Warning: ../include/linux/iio/adc/qcom-vadc-common.h:123 Enum value
>  'SCALE_PMIC_THERM' not described in enum 'vadc_scale_fn_type'
> 
> Also prevent the warning on SCALE_HW_CALIB_INVALID by marking it
> "private:" so that kernel-doc notation is not needed for it.
> 
> This leaves only one warning here, which I don't know the
> appropriate description of:
> qcom-vadc-common.h:125: warning: Enum value
>  'SCALE_HW_CALIB_PMIC_THERM_PM7' not described in enum 'vadc_scale_fn_type'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Thanks for cleaning this up. Hopefully someone else will follow up
with the description for the missing one.

Applied,

Jonathan


> 


