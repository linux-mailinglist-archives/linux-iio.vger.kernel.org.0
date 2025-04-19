Return-Path: <linux-iio+bounces-18343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D81A944F0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F076F7AAC0C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CE1DE2DE;
	Sat, 19 Apr 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ln1WftwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997B4A3C
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085567; cv=none; b=MrKNEsWYfTXwagS162MQlZe9fWeI+0ka9oSkeoqUbjQZOoDFoWveE4aVouIuuQB+xaWzbG98ijJSJ4pnDpyQKJmX+yWNaaqJ/jv6VbGY8+sy89+MaLd66MO9DsP5Kd2zftZUm7ovQPAEyBpatuWfF6/dGePpjPp39VO8DZ20KyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085567; c=relaxed/simple;
	bh=loa3ZAk98fhExGreOeZfWaBVIuP0spjL0QRNRXHFInk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsOY7XtNUpTzr36dmgo40ae+lvSEU4BI9IcdGgRP+LreZlWXGzgyohh6sNGNcWF+y2E89sz7xHlcGhpls8ES6bP3ieTrJR+8dPkzvxCzRWAERyEPQE4Aimsr1DYalPlmls+m8WQViphYwfqP7OUbLWoyrndE9CH21+rUlb4QUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ln1WftwC; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-604ad0347f5so655878eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745085565; x=1745690365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnKkaunDg3dQk+CBekNNA4Y8Jf2sXD/RRi4cvuDwGr8=;
        b=ln1WftwCOJOloDZzGkC5U7+Gfun8qoD0n7rn/nKxuI33vzpE3qAWIfsVWY7w/VxKgg
         ZLjfDsBhnzSvpXPtva+vX5T1KXqPnHQXV8kUmYqDG5kd4wjWb9bDmZcY5m/jydqJ1ntG
         9XdPkDSy8NopE/tfegfieqtdvrQOQBZMBo2DlTeMXFoz0PqMQU2AFhcIQaEC+TX0MfFE
         OKPd1ypek71d6tzl9rZwIa2HhcXnar3SMyvWOySdjvn5AzdXndbAskNkeX8sOA9fX961
         7rqT1O9AF6ctwuoeHqpelUq+DYEUIqaCMTfgMp7QwCc1bT3rZvIbuCKsHI1Kj4OEfr30
         erfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745085565; x=1745690365;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnKkaunDg3dQk+CBekNNA4Y8Jf2sXD/RRi4cvuDwGr8=;
        b=TKncpihRBvq66rKUpAxc+eoZba4PSdNHXlz8fmveigV9tOweMEvWi8JLA2haeFIksQ
         MAEBh28uVd6WwTVBJxMAF3mFQznJbd7NNsT0CT0wuRqU7j11HeMhNUvWtNwpcGleiDZb
         n2BQ2p4lWuRBe98M+lewlA9wocXEu0c9CLAEd80deK4PaH4+MBfpERGX2Q/taSamPoFJ
         jrSPx6GYkB7oNjfrm/rurrzjlUJ8qAdvvDmNJ+GfKtTfSoegnFa+dBw+XBeSegvg7Ar0
         xPCaHtDaCDLPmpM3CFqOVkXWhnnWF8QRG59ukvooz5RmguskO6k/bo1HJDXEtRogTfMR
         +UCg==
X-Forwarded-Encrypted: i=1; AJvYcCXmhnDs4OCA6mp626CpoFxLqj99c3lS9yB53VFYmHsE7WK2O9K3USVvmfi49LRGg9ipLFyrhxUfBAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bSuaN79V6Nl/BXg/960wvvlYjPupljCX0F8Vq9gtOrajTtTE
	JiCkHqrzf1o25TXrm6S7niWsPvgx5244VEbrSLl/IPEGeVnCzVFhIzCo8+jGNC0=
X-Gm-Gg: ASbGncsuJRPhHjOrd3cdMnmLu1EPq1oxHeQlICCN1e5Kmjo0r1aVU0TSYFcfxwej5/D
	doUloXSFmKRu4i+Xu5OBIajQKM/g4aQQNMEvsrRFhrujuMm1o8b57ZOR9vGc1kpd+EKWLUtoWxW
	kLZmEVkuzi2bAX/0W65av1dqRTkgWIcLbk0h23OsTvIHKD6o21+cbSFGhC7f/9KxhL2Q19dE0Id
	kKgkyERkyyFSspu2Amfx3o0PqcL3yhvfd3kl5Vyfe4q0tO89K9QtPze63clrcbg3VPVb+nGWR+I
	CywYvod4j+ryndAAQ88t/akpwXMvPlaX3Zv5P4qKwImFbp8S1RoxYrW1PQoStCMr6paFsf6QI8w
	9KEnv//iDTjRYPidI6y3FmKE=
X-Google-Smtp-Source: AGHT+IE2D5qncdnG7FkcjLIJjmUIbO0uuju/gqzyq/hCHB8+uhQUtCCkihQNGxoVbkVtsyhdlp3dwg==
X-Received: by 2002:a05:6870:b617:b0:29e:6bdb:e362 with SMTP id 586e51a60fabf-2d526a8744emr3496875fac.17.1745085564736;
        Sat, 19 Apr 2025 10:59:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:79a:b8ae:edee:ec5? ([2600:8803:e7e4:1d00:79a:b8ae:edee:ec5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489abecsm768104a34.59.2025.04.19.10.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 10:59:24 -0700 (PDT)
Message-ID: <71282f99-ae6c-463f-bd62-1e0664a549e1@baylibre.com>
Date: Sat, 19 Apr 2025 12:59:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-3-ee0c62a33a0f@baylibre.com>
 <aAPRh7f0M9fA3U5a@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAPRh7f0M9fA3U5a@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/25 11:38 AM, Andy Shevchenko wrote:
> On Fri, Apr 18, 2025 at 05:58:34PM -0500, David Lechner wrote:
>> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
>> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
>> and understand.
> 
> ...
> 
>> -	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
>> -			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
>> +	IIO_DECLARE_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32))
>> +		__aligned(IIO_DMA_MINALIGN);
> 
> Why u8 and not u32?
> 

Because this driver supports many chips, some need u16 and some u32.

