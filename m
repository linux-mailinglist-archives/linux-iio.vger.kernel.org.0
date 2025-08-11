Return-Path: <linux-iio+bounces-22576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29711B20C40
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8EF6263EF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8D22571B8;
	Mon, 11 Aug 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqI5z/pX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3A253B64
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922960; cv=none; b=FAhyvuf6bAkUCfq2cBONRA7hfoNGQRubgpR3FmspSV/j1HTej5ewuCzABxK4rlnrnpsbCmzeVetrSsqafhOYqRKLkHIw2dPuZujvUu9KPjneQV79wolUmUSaS98w0XESJftGDn1AoDqxJw3AeBnuH+LTK1U82AvoP7CSrkdGff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922960; c=relaxed/simple;
	bh=aG2r8k3HZO6CkEAEOvANO4fnBvXMhklWc9N7xTLohTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLNRDACvdYWAnR5hOD7vwUY4rbHellxx8/MZH0qdRJKWQW3xFW6mFqixqwOt/lhoOmCUTsoJZrdqnFtx7/UJlzqaU5oEwKyiK3l85Yzjxw4c6vRyNu+fDBuUe2KH+R+FGNcZn3xEBsVpiaWIrKvNn8gImxyFLW65Jf/HAQeoXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqI5z/pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1F8C4CEF4;
	Mon, 11 Aug 2025 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754922960;
	bh=aG2r8k3HZO6CkEAEOvANO4fnBvXMhklWc9N7xTLohTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EqI5z/pXu93eU9pmuDbu/EiZknSqMwc1xii8gcdm1BZw155piaXpZddgbPi45gi6N
	 NdLyg5lbkffYbcacAduZn0u6v/S8HiK9d/CLY8cz34s8/pXBZw057etGxYftVX4UCG
	 wMECnaDhS2J7N4TKVfjvBbzkZDT8qjgLpNzmWu3aOMz+WJktsle0TFPo9GMSDh7l8x
	 kuxJ4lhyEHsPgyA0qdBS6c+HcPw6214pbPy3R1wQLBjGvD9J3GRo/pdKeahwhGnO5h
	 JtuuOSXeXj5yd9htJo5osr9bz+p5KcsjroVb++nwTmwooyGdyU3AqgtCuazgIxT7tg
	 6LtNBr7n7xcpQ==
Message-ID: <4a9cd814-6019-442e-829a-794bb3216e5c@kernel.org>
Date: Mon, 11 Aug 2025 16:35:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
References: <20250727210639.196351-1-hansg@kernel.org>
 <20250727210639.196351-2-hansg@kernel.org>
 <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com>
 <73d5746d-a9fb-40c2-9ad2-bcf970683284@kernel.org>
 <7810b341-1216-4fe4-8c05-17acb00430c7@kernel.org>
 <aJnj7w5aJ3B-AGGD@smile.fi.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aJnj7w5aJ3B-AGGD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Aug-25 2:37 PM, Andy Shevchenko wrote:
> On Sun, Aug 10, 2025 at 11:12:24PM +0200, Hans de Goede wrote:
>> On 10-Aug-25 9:25 PM, Hans de Goede wrote:
>>> On 29-Jul-25 7:26 PM, David Lechner wrote:
>>>> On 7/27/25 4:06 PM, Hans de Goede wrote:
> 
> ...
> 
>> +		switch (scale_type) {
>> +		case IIO_VAL_INT_PLUS_MICRO: denominator = 1000000LL; break;
>> +		case IIO_VAL_INT_PLUS_NANO: denominator = 1000000000LL; break;
> 
> (s64)MICRO
> (s64)NANO
> ?

Ack.

> ...
> 
>> +	ret = iio_multiply_value(processed, raw64 * scale,
>> +				 scale_type, scale_val, scale_val2);
>> +	if (ret < 0)
>> +		return ret;
>>  
>>  	return 0;
> 
> Simply return iio_...(...); ?

That will change the return value on success from 0 to
IIO_VAL_INT, which is 1 not 0.

> ...
> 
>> +int iio_multiply_value(int *result, s64 multiplier,
>> +		       unsigned int type, int val, int val2);
> 
> There is room for type in the previous line.

type, val and val2 is a triplet which belongs together,
since it does not matter for the number of lines this
takes it seems better to keep the 3 together.

Regards,

Hans



