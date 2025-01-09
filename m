Return-Path: <linux-iio+bounces-14062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBBA07F73
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 19:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217BB1696F3
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01B18D621;
	Thu,  9 Jan 2025 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EN0gaDYM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B11891A8
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445902; cv=none; b=W5JjU2IRgENf186Uf0DlvE3n48nDUziHoz5EUFsYp2iGFoOg4Rppr49hBvfsjZEP+kH7q/NsTZ7mvbCFWG1zH6jfFlKx38fe5upd424ajjQzn5Lfy0Hnsw5xhIZpQRKno/r/wIRCI6yaoI7Zp8QgFyUDscX2wGUVILQiQsJHW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445902; c=relaxed/simple;
	bh=yT2MWo5MDf5De7ksazMqrPvIHhRhGm2z4Q/20iXqm/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hd8jZVftjEXt00KWbCeZl+UcbZ9KYNSR0rn7Z3nXKUY5C8xSYb8q9/jIQlPkHs7y2+KCOWqM3Ct+77QhAt6wXEvfArKtx1tTjVT8JlXOdZ/Pztk7O/C76WqF07q2PlLva3HNb94aUulUJl4v9so6OdAJLRHiKSatIhNrtAXxjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EN0gaDYM; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29645a83b1bso585116fac.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 10:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736445899; x=1737050699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwD2HkITqrGb+jcvZwEbanT3Usb1nbxCYPj49h9i7vk=;
        b=EN0gaDYMn9ST5j918HLwObUKd8RMS9YjRf34cVvVFGBGPYMqeHy4jEdG1izu27oRhS
         3ckP8ne5vSyJovgGOZn7VbnwQOxzT4YxETgcNwD25AQ1/GAhU1uDvf4hHZ2/VJxDsk3N
         U8cF7SBQxYzQIHcMhLywMU0MQI/JJ+0E1J8hVNTqbr++GYLYH48/UStYqPnG6EoV0rmS
         tn6wUM+aA78XIDmDQcIvx55JCYB/wM2WQwhblZFEP2d7QcDsCAsH402QLA0wgiiuag1K
         ZJ34ij3YvGe7//w7EWhE3mCadNEqyRAfA5ACY9c+WfAgHjo6itwly2icoOoa10cyktOE
         7bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736445899; x=1737050699;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwD2HkITqrGb+jcvZwEbanT3Usb1nbxCYPj49h9i7vk=;
        b=uPO3OqQtdLYSB8MGGvChKq1bM4roh+IDZMBzulwc8L2/cr9HozCPXSCEjAXawuiV6I
         POVzNYkr6t1MNNKIGpD0CNf29wkvp4kJr6/CrZgS8A+WrA6XE2BsY2ROSqH2WihKcW6k
         /xUcLyoq4sdosXaY7EkpIVPZQpOZEnOe96PZbF3tFwQQ/eWrGMh0NJ3Xdvj4Jfkg0Dwd
         MfQGUq9bGLheVDuNN/I833SyU7+tJXg2GJdxzvXm90wYWLQUzsHxgxaqEjcOTvgDvZ9C
         ghWKs7gUePxI+gVrqNFTB8/iQIbcb6s8MZo2F+70vwjJTkl+HeUjXVurAHDppwtPwiX2
         qRZA==
X-Forwarded-Encrypted: i=1; AJvYcCXYTUGY4kth6rFrK2XFNecQJC9I1yo20Ocxh9nRmz9ID88wOZAI94g9g1F2+wkXXW667s3YB+Qhu14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuaBHKE9pr429b6TQRVoR+ARqm5dPlRBOW9g3M+Bzt0UISNF5
	QQiwnAk9XEUd6yWtj8HDcBNy+NvNcdPXJ7rT0/Bhm234nwLX3zBcOOaMHAr9wkY=
X-Gm-Gg: ASbGncuCg5Hs1X1+8RgFiMkz8rWLLNS9zzazIqW/+vR32XnjcpslukHxVo3/fC5H44Q
	W6ZrLSgqWBHRB4dHlZ7PVLEkzLEyHc8Qy5lPmjBaaPclqWQca04Y2mUhCTt13bOALz0hNQ1u4QW
	qcqa19HfZSnmos/9e0mmjFbTvKcCouDzgdN2bE5nBOzianov9WyQWBMkO2W2HZ9wIp5UeU8qEJS
	xW4NjZpUF1XnWMf2yCWksc9VosdII1sb5N38A+Ig4L76aee1pn5sqmDxrb3/cgMI6T43UcN05W4
	QxIvdoB1RXc8PIHsNA==
X-Google-Smtp-Source: AGHT+IHbrLRSivqr2piq/yTQLXsZa9fzB6BDVPUjgAIgPde6zMypJfbu2jxfllzI9/lkcN3525B+SQ==
X-Received: by 2002:a05:6871:53cb:b0:296:5928:7a42 with SMTP id 586e51a60fabf-2aa0671071amr3924871fac.22.1736445898028;
        Thu, 09 Jan 2025 10:04:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad804afe70sm457256fac.6.2025.01.09.10.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 10:04:56 -0800 (PST)
Message-ID: <e6bd5a48-1ba2-4a01-af75-fbf74a0de3c3@baylibre.com>
Date: Thu, 9 Jan 2025 12:04:54 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-6-2dac02f04638@baylibre.com>
 <80fa8faf-b5ac-4f3e-84b9-acf8ac6ab26d@baylibre.com>
 <gnh2oayoj5bwqwrixm5x5qtjdq5i3cclokekkezagonl65su3m@b6b4p7duyot5>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <gnh2oayoj5bwqwrixm5x5qtjdq5i3cclokekkezagonl65su3m@b6b4p7duyot5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 11:25 AM, Angelo Dureghello wrote:
> Hi,
> 
> On 08.01.2025 15:16, David Lechner wrote:
>> On 1/8/25 11:29 AM, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>> Use "instruction" mode over initial configuration and all other
>>> non-streaming operations.
>>>
>>> DAC boots in streaming mode as default, and the driver is not
>>> changing this mode.
>>>
>>> Instruction r/w is still working becouse instruction is processed
>>
>> s/becouse/because/
>>
>>> from the DAC after chip select is deasserted, this works until
>>> loop mode is 0 or greater than the instruction size.
>>>
>>> All initial operations should be more safely done in instruction
>>> mode, a mode provided for this.
>>
>> I'm not sure it is really "safer". The way I read the datasheet, this just
>> enables bulk reads of multiple registers. So unless we need to do bulk reads
>> it seems like this is just adding extra complexity to the driver without a
>> tangible benefit.
>>
> 
> this change was initially requested from the HDL team to stay aligned with
> the HDL side streaming/non streaming mode, and later, applied since seems
> a safer way to operate.
> 
> I see that for the driver and DAC point of view, this is "functionally"
> not needed, but streaming mode for configuration or raw read/write works
> until STREAM_MODE register is set to 0 or to a value >= to the register
> size to be accessed, since the _CS deasserting completes the transaction.
> 
> I.e., a transaction with a STREAM_MODE set to 1 would fail in case of 
> a 16bit r/w access. Staying into streaming mode seems to me a bit tricky,
> and setting to instruction mode may be safer since in this mode the
> STREAM_MODE value is not important anymore.
> 
> For me is the same, i can remove related code. As you prefer.
> 
If it really does make a difference, I'm OK to keep it.

