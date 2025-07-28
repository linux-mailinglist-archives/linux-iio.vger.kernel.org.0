Return-Path: <linux-iio+bounces-22115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71206B1421C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97629541DC7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB68275AE0;
	Mon, 28 Jul 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvjVS0jc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8421B9DA
	for <linux-iio@vger.kernel.org>; Mon, 28 Jul 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728096; cv=none; b=FxBxk3bTEAooK+/KR+4xs6QJj1CQggL9QwCxJxsJj5tyrPKqsEmRdrl6Lv+r7DqvqGk59RmLjP4vXPpsCAKEZV4L3lhfckgrqpFAqSVCuCLPXMT1SM5HPx8J6BXb20+6o2+8P2INNc3z1HqsH683megh9j/h5P6Q15pzGSwHgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728096; c=relaxed/simple;
	bh=wGsmPw9oTz62nvrMvlW+62zC4DbTiIZVXOW17yV73RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLxiC7TY0x4URuBTq2DirSgzoByBJNExKvo/0U1/kykfIcJL0uWlA1yM6ih/HeMTaCa1A78MHQpWDsMffB2RGrg5GkUBuY9LBWSTx29Z4Z4F8HlZBJcGGNKJSCh7nUbjfzJ6JiADxMw9tJe/LKy0u8a28+JHQ8fTPWvU5WT2Dtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvjVS0jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA41BC4CEE7;
	Mon, 28 Jul 2025 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728096;
	bh=wGsmPw9oTz62nvrMvlW+62zC4DbTiIZVXOW17yV73RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvjVS0jcA2VqLUhjmfHjjPbwclceD6hz6hs65/Yb2ehaxK03SfQ5SSZghc7L9YgI0
	 hxVGs1zCySKZO9OmTeTS5eaA01P7OMuOX/LLvgtH1ST2vtIkazt9Rg2bXhYo0I5XtV
	 pQUedy6m4+husKpn53saBx3kCjYLzNnX3l/WP8axLIvooSQ5E3x8ktYxhPmYToOvQH
	 dXdIL9qDBxke+aeo/g8WGbfk/m9MW9/HrsrRKByvXYzQ/YHoTMfZ1qvsejSg2aK3JQ
	 MdVnJvZ+85nVvT3B5YEuzKEoYiGmltL4Yj8n3dqd+sUcttAaU1CuSpmWN2qkc+/KQy
	 8MyNYraS7fnRA==
Date: Mon, 28 Jul 2025 19:41:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC
 driver
Message-ID: <20250728194128.79798d75@jic23-huawei>
In-Reply-To: <20250727210639.196351-3-hansg@kernel.org>
References: <20250727210639.196351-1-hansg@kernel.org>
	<20250727210639.196351-3-hansg@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 23:06:39 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
> The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver.
> 
> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
> 
> Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
> binding to the "chtdc_ti_adc" MFD cell of the MFD driver.
> 
> The "cht" in the cell name comes from Cherry Trail, but it turns out that
> just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
> Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
> not include the cht part in its name.
> 
> This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
> from the Acer A1-840 Android kernel source-code archive named:
> "App. Guide_Acer_20151221_A_A.zip"
> which is distributed by Acer from the Acer A1-840 support page:
> https://www.acer.com/us-en/support/product-support/A1-840/downloads
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
Looks good to me. I'll let it sit on list for a few days though to give
others time to take a final look.  It's holiday season for many so
if I do apply it and we get follow on feedback we can deal with it as
patches on top. 

Thanks,

Jonathan


