Return-Path: <linux-iio+bounces-17314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DFA74EA1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 17:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD03B504D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA551D61A5;
	Fri, 28 Mar 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n+OA2Y25"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612741C831A
	for <linux-iio@vger.kernel.org>; Fri, 28 Mar 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743180016; cv=none; b=MtR99cv011IYtVGHRJEhT55xAfwXD+7Tkf4yLejJX1fgo7SNsudHd537U+yoCkT2Fz1Ek7f1zFlQ0tmD79b7I0vOzcXAYh1o8b8qXXmKXfBjaLsUU6QfvO0v7Gaxri65k2S3G5nuDmX7pTZmYB7ZyhnuFOdNKitYOs8QwGXnXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743180016; c=relaxed/simple;
	bh=UfMGIFBA2NCp8X6+/ZlKX6NWlh6n9aKB62GIyfMRUvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+qsPtWEUEdAgKSKdd7+l0ZtyLkHmiGmk7thihsfUfVAOMVScBNU+uurSQJvGPL6/2b9pjA+lh/HScRx5bvq02bvo2vRFcTeIejbxqhRC1eqk/6OjCcWWYXmnmMYLqcB/MRXF/wAF1zZvifftxBhGTXdRUl1OnOctZ+5yN/8t/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n+OA2Y25; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f8df49e75fso623483b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Mar 2025 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743180013; x=1743784813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzrQJVTt8RVOtbppwh2ghVBNZYusJHBIFxOQR2w/3zs=;
        b=n+OA2Y25AB/Td3LiYIbe01/eQQyVT5ft3mgQrfiFSPx+KdL5o+7TEKw3bgXQ2zObKA
         NgZh4fdIr5gBaw8+hzhVj+nSuIfsBPNL+1EetNsoC0PryNXRSHZgSDE6cMCQYHK7oZGG
         alt3Xs4eBJuUvSqcpR3gN0E5XN05RrbFzbp6J9FROv+2ccUtagUzEiZJ4XlVzajT9o8n
         ZoiEpQOoZUA/O6chZnlt2gUwSSbMrdVAFbHNWvdH2eIn7vfkukQBZAWXygMVDjut31Zb
         S1tokCgQjiMRk4IOa/VBFJ3XwDw2cHYo8zOwO0DphGIVVvpM+5xjS4Ykpr78e8JsmMwk
         zylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743180013; x=1743784813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzrQJVTt8RVOtbppwh2ghVBNZYusJHBIFxOQR2w/3zs=;
        b=ux74725n2SSVYvL61ZUyiUtvj9ZtqRoVJ3R9HNGhXiUhi+MF+HsED/TZFpi1y0Me8b
         1e3c5SbGBWr9efunc3lc03omB8kamtPUxKljzpe2GKfBccnBkv5xh5Me6RE9JeomPUva
         nJG1FbVaGGCBZDyGIRURBayZpN7i6KBt8PI/zbz8Nob+0mZbixZQKVJLrdrzVyfE33IC
         iS9ad5658DvcM74wAmvPqmsA7coA13tHsHGF/fpKphZDpZlAFQlpozOM1PZoDtI2gt+m
         P8scGQsbD4ftnbNtfkHpXyw18s4ncPAuNc3XDIZvUlbvi1jkgF8UKOnGRlr/IRQuzWJ/
         qKZw==
X-Gm-Message-State: AOJu0YyrsLAhcbPE9WIqHVy0zkpX/j2KIvIQr+WgwrPn8keg0PNFD2VX
	sbYOK4sNChisuKg7u69ITqBrJoAftGJpZZr7b1FpZQiHrRTvMlUQc1HR8r4fAuM=
X-Gm-Gg: ASbGncv7tASPIRPY4fOqMn0soQyamwa06vncZroM3Ek/6P35uhzbpyKbo89pw5Fz+ZP
	lJdipuj2qTXix3d4W2qpIfcNYQzWhzateuzVZjjjAaUSwp5n57AGymvBHvEhylPmms9+rbHHEAd
	o+G8rM1rIEpGW1ioNh+BA64Pz1t8CSpHbrf9j0qBaxqxZztqrfSdUOyIExiJWEY2BDGoDAel6h6
	SVvIXhxWCbQuHF6uYOtuwg7KtNChRKbFdy9d1ldUno7HEzFomf0OvD1IEKc0537MVm+WBWPLmSJ
	rA9o35lN2BuQMrBwMrFd7gM3N99YpnrtPVhCjduwK7P0bUSQVsbiXysuWFiFGD7Z/ssAahGgB8p
	TC0KfJw==
X-Google-Smtp-Source: AGHT+IFsPyxd+WXijsrvJhUw6MhgClDj2ObmqnNkt7n1gwXZWKnnQoPsZ/k6D1o8Tiv7eFjViSnK0A==
X-Received: by 2002:a05:6808:244f:b0:3f7:4b65:582f with SMTP id 5614622812f47-3fefa56dcddmr5562104b6e.17.1743180013168;
        Fri, 28 Mar 2025 09:40:13 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-602843bc042sm389572eaf.0.2025.03.28.09.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 09:40:11 -0700 (PDT)
Message-ID: <68db2225-4519-4436-bee2-24fbe320ac4f@baylibre.com>
Date: Fri, 28 Mar 2025 11:40:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
 <2d12ff156996876e5bd85c793c07bb0c6747981c.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2d12ff156996876e5bd85c793c07bb0c6747981c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/28/25 3:28 AM, Nuno Sá wrote:
> On Fri, 2025-03-21 at 21:28 +0100, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> The ad3552r can be feeded from the HDL controller by an internally
>> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
>> to enable or disable it.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---

...

>> +static ssize_t ad3552r_hs_write_data_source(struct file *f,
>> +					    const char __user *userbuf,
>> +					    size_t count, loff_t *ppos)
>> +{
>> +	struct ad3552r_hs_state *st = file_inode(f)->i_private;
>> +	char buf[64];
>> +	int ret;
>> +
>> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
>> +				     count);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	buf[count] = 0;
>> +
>> +	if (count == 10 && !strncmp(buf, "iio-buffer", 10)) {
>> +		ret = ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
>> +		if (ret)
>> +			return ret;
>> +	} else if (count == 22 && !strncmp(buf, "backend-ramp-generator", 22)) {
>> +		ret = ad3552r_hs_set_data_source(st,
>> +			IIO_BACKEND_INTERNAL_RAMP_16BIT);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		return -EINVAL;
>> +	}
> 
> Are we expected to add more data types in the future? If not, this could be simply an
> enable/disable ramp generator thing... It would be much simpler.

Angelo actually had implemented it that way originally. :-)

I suggested to change it to a string because the HDL project for this family
of DACs actually has 3 possibilities for the data source:

	* Selectable input source: DMA/ADC/TEST_RAMP;

And there are other potential sources from the generic AXI DAC like
0x00: internal tone (DDS) that seems somewhat likely to be seen in the future.

> 
> Anyways, you could define a static array and use match_string()?
> 
> Lastly, for insterfaces like this, it's always helpful to have an _available kind of
> attribute.
> 
> - Nuno Sá
> 
> 
> 
>>  
>>  static const struct of_device_id ad3552r_hs_of_id[] = {
>>
> 
> 


