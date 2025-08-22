Return-Path: <linux-iio+bounces-23140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C399DB31614
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 13:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDDF7BC8FF
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD72BEFFD;
	Fri, 22 Aug 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gazNdxXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D52DCF47
	for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860705; cv=none; b=bDIHW4UjOtmxuRuByIEozba7ayonRv+w+AllZYcIyRjVn3Y9p9+ox1aoPOutDilA6cOGxcjbe28n+bkQYy8nC69NVOwnNEY6auWYlY3eCcxFQFcDjI64Ooe1ojku/kauke8KD5e+pCfIq3rAkoqUwJ5DeFEETfmO8vAbiaEApNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860705; c=relaxed/simple;
	bh=AGAOKjpJrGgFUmAnp07OzofmI3F/wHr6c///Vqpwpsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/xUCo+cChuErQdSEJfnfPGc/l/Dt+p3C4KP9yD5q09EVX+KOe8w7Td7Kix9e9nWe9zDdSWYGPgwGbdRTRLv+g22Ob9zQNta7jlYaYMK3A9CNBhX4vWRZjJBYwB+dGgxBj9wsqJ4mkELv6hHlSUS37Ge6iR5Qsfy4B5Ypo3Os28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gazNdxXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB0CC4CEED;
	Fri, 22 Aug 2025 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755860704;
	bh=AGAOKjpJrGgFUmAnp07OzofmI3F/wHr6c///Vqpwpsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gazNdxXjYXMKgx2+fe9CsBCKMTqF+IW87ofcac60d0lbC0sTvmu5G/tavs2TkKXXH
	 aqhdv5zfPlx5bCGMPMut79pxkaUpLEokJ0X32ZEdt2Vg7GFJH6vrnJB4qrhehqmVS0
	 bszYQKlU5oHLPDAphupB3QaU29jhHpcuLcrmYmzI1Wqa7vtubIA6wUTJ9o9r16ZwYH
	 OYDvv4PCeSxiDdedQM2Vr71sMYFAI7mUHhNuH1Ek7FUOng7XkDeORLekLcgQ5zSO9q
	 yBN5u++033DpdQfmAiiyB8e85EZHMtYg3RUATlIxFsJXlcqlT1YgXb5Yf2Y2QEv9mG
	 +Md7FEalh3raA==
Message-ID: <fc29e932-0c05-445e-b6a4-f40d47f07319@kernel.org>
Date: Fri, 22 Aug 2025 13:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] iio: processed channel handling fixes + Intel
 Dollar Cove TI PMIC ADC driver
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
 Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
References: <20250811155453.31525-1-hansg@kernel.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 11-Aug-25 5:54 PM, Hans de Goede wrote:
> Hi All,
> 
> Here is v4 of my patch to add an IIO driver for the Intel Dollar Cove TI
> PMIC ADC. This has turned more into a series with fixes / changes
> to iio_convert_raw_to_processed() and iio_read_channel_processed_scale(),
> with the new driver tagged on as the last patch :)

Thank you for all the review comments.

I was away for vacation and I'm catching up on email now.

I agree with all the review comments and I'll prepare a v5
addressing the review comments when I can make some time for this.

Regards,

Hans




> Changes in v4:
> - 2 new bug-fixes for iio_convert_raw_to_processed()
> - Factor the bugfixed code multiply a s64 and an iio (type, val, val2)
>   triplet out of iio_convert_raw_to_processed() into a new
>   iio_multiply_value() helper
> - Add a kunit test for iio_multiply_value()
> - Redo the "Improve iio_read_channel_processed_scale() precision"
>   patch using the iio_multiply_value() helper
> 
> Changes in v3:
> - "iio: Improve iio_read_channel_processed_scale() precision"
>   - Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
>   - Directly return IIO_VAL_INT from valid cases and drop the final
>     return ret after the switch-case
> - "iio: adc: Add Intel Dollar Cove TI PMIC ADC driver"
>   - Use new more compact DC_TI_ADC_DATA_REG_CH(x) macro
>   - Use regmap_set_bits() regmap_clear_bits() where applicable
>   - Use regmap_bulk_read() + be16_to_cpu() to read ADC value
>   - Use sign_extend32() for vbat_zse and vbat_ge reading in probe()
> 
> Changes in v2:
> - Add new "iio: Improve iio_read_channel_processed_scale() precision"
>   patch to the series
> - Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
> - Add IIO_CHAN_INFO_PROCESSED which applies calibration and
>   scaling for the VBat channel
> - Address some other small review remarks
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (6):
>   iio: consumers: Fix handling of negative channel scale in
>     iio_convert_raw_to_processed()
>   iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
>   iio: consumers: Add an iio_multiply_value() helper function
>   iio: Improve iio_read_channel_processed_scale() precision
>   iio: test: Add kunit tests for iio_multiply_value()
>   iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
> 
>  drivers/iio/adc/Kconfig              |  11 +
>  drivers/iio/adc/Makefile             |   1 +
>  drivers/iio/adc/intel_dc_ti_adc.c    | 327 +++++++++++++++++++++++++++
>  drivers/iio/inkern.c                 |  77 ++++---
>  drivers/iio/test/Kconfig             |  12 +
>  drivers/iio/test/Makefile            |   1 +
>  drivers/iio/test/iio-test-multiply.c | 209 +++++++++++++++++
>  include/linux/iio/consumer.h         |  18 ++
>  8 files changed, 621 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
>  create mode 100644 drivers/iio/test/iio-test-multiply.c
> 


