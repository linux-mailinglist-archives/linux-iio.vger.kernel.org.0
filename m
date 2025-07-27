Return-Path: <linux-iio+bounces-22063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B885B13195
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F351896537
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 19:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4108224892;
	Sun, 27 Jul 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krs+6mN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244410F1
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646160; cv=none; b=l3hzXPYDHmU3/oq/unpBZSnJ2CepiwGnlxsM0R/FivP64TPc2+AFbEIsbqV2PPk4Ayffd+niWbSrUJJqYkeU8xJ/VrXkILNtYUOy1cH6hS8rkkHCrGqGpv/oa73lWqkObhU1Kwwy290iSmnXVwyJejpxnzEecrJSHRNP/kKJoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646160; c=relaxed/simple;
	bh=ZwhW23jWXeVtNJcJKmxY+zk7onSoRqdaepyut9cBIbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpw7k7j3XRTOLmpXeU1xJSS+38NPLSrcqVQ3ro9VCt/hzR6QYakPYn0PXu1SSyfdk5bZ9J38hUjV2PC9CPWmRT0SvzoeXd78P0dnzUaCqf+i4YKu1gGWQBqOcSF9aIAa2pLdMcBwfeG+aXDoqZFmy8BoTzWK1MQ5Ztuhh2ciOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krs+6mN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903E9C4CEEB;
	Sun, 27 Jul 2025 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646160;
	bh=ZwhW23jWXeVtNJcJKmxY+zk7onSoRqdaepyut9cBIbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Krs+6mN3xw1UwOYJffjyX4WUXA7d+yb1eULWeUgRGUiI8kNI8SXVt4tbX3pMTQ900
	 dFZsXUAZO759JaH7SVJb1Hp22GMbmafgUrpTfU+lBI2OZPXEHQobSbnXBM/ex/XTVg
	 s+t2nrfQ/O8VCInC4KKS08WXLgSTDUA0Oe/a7bkcysnsNJPwYeBnOwTUjzdILqjOC4
	 TNP+d8fcFQGivf+ykXNPZUvQTk7Hbt9GX3MW0gmTJXX7v/NClPC/UpNlQolosbEn8G
	 tNW64R1TDqQQELUtiMJoKu4FkJN+gxevnMc+OgslidpwkgTsG+cX9UAWD7x04k+exd
	 D7c//uH9eE0EQ==
Message-ID: <361aaf80-a85b-4288-9131-5745a75b8e9a@kernel.org>
Date: Sun, 27 Jul 2025 21:55:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-2-hansg@kernel.org>
 <aID8fesLq-z0c-uq@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <aID8fesLq-z0c-uq@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 23-Jul-25 5:15 PM, Andy Shevchenko wrote:
> On Mon, Jul 21, 2025 at 05:06:13PM +0200, Hans de Goede wrote:
>> Before this change iio_read_channel_processed_scale() always assumes that
>> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
>> IIO_VAL_INT on success.
>>
>> Ignoring any fractional values from drivers which return
>> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
>> might become non fractional after scaling so these should be taken into
>> account.
>>
>> While at it also error out for IIO_VAL_* values which
>> iio_read_channel_processed_scale() does not know how to handle.
> 
> ...
> 
>> +		case IIO_VAL_INT_PLUS_MICRO:
>> +			*val *= scale;
>> +			*val += div_u64((u64)val2 * scale, 1000000LLU);
> 
> MICRO from units.h
> 
>> +			break;
>> +		case IIO_VAL_INT_PLUS_NANO:
>> +			*val *= scale;
>> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);
> 
> Respectively NANO.

As I already mentioned to the same remark from David:

iio_convert_raw_to_processed_unlocked() uses 1000000LL, so for
consistency I would prefer to change this to 1000000LL (dropping the 'U').

If we want to switch to using MICRO + NANO this should be doe
in a follow-up patch which makes this change consistently everywhere
in the IIO core code.

Regards,

Hans



