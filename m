Return-Path: <linux-iio+bounces-21581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC44B02252
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6DFA41C25
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D42EF9A3;
	Fri, 11 Jul 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M3xXNyiv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B02586DA
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253634; cv=none; b=UuR25XY5US2zXH6eqCZL24mBW+eez6BIwvaAVxE5n9eSLz87wOfLjYwrFXaPw4BFD+4ZH6i6bwVQ2hSWQ4Q/2m5tcf653T+x3rtbgqbv0+Cws8Q41hFiD0o97GJtqeUcrDTO/SNYlcw5p/Sq43QdR6Ead9HDcwp7g3QzeaPyLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253634; c=relaxed/simple;
	bh=FQajfC6hj9vjgjYWT16Osu25UTqQIQVqEGZHV5VAkWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS8LiOPQO0Hdyu0mnlRMeMKjgojsQm/s9l7oCaTe1AuIykQI07/ksfovcEAXRYVATAr23tvRnNDMBhWA0djKqF8JTdakS9dLvXQGKdZK0WDrV26vm7q+USppEyxPrLurV9YjWjY7PAws6mpGk+Zwfw3OJXlKUjh/G3BmkQMrQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M3xXNyiv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735ac221670so1354196a34.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752253632; x=1752858432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x+YACVlc10+DgeSv3LaeOJ8nkJHg18kDmNVpt3dpyQ=;
        b=M3xXNyivoTlYIHMXttVOLGelH+aBmAXkElSZwMO+FZAnpj8PU7+6KiD48a17HFsdDi
         poSylHsLN0MaRDpY9QvQjP5UyQcyDVwDLv3WaA4PpQPjR1tbd3XRpQLBwGWwWxfq9zgh
         TvtAcxMrt9JVAPHnRt+MVJ4SLbfdv0U/4lHJURkYCJ+K0o4Ia252Vx77O2t6XtFgBb8f
         D05z4qeOYOwEihDxgsloxJNQBhwbQ6KSZ5wIB+bMxADZnkZIGf49VbNUqKhk4ocKLdqn
         kL3Q/SurM0J9PIBrDhUbjQcukJUmQKGj1ip7xHT/1tHNohOsHF7PNixfpqi60QLK1jwu
         4AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253632; x=1752858432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x+YACVlc10+DgeSv3LaeOJ8nkJHg18kDmNVpt3dpyQ=;
        b=V1n0omaaWxUC1vHoO3YGw1rhFbthNt8XiXtm+VUSinBqKDQlR7EV12vkOll7ErYP+3
         uem3htRNd/iWU6POnOY5aTQfL7zW22iimvvsoAO+a0j6O/K7VyJH0GkE5gv2PmckNEVR
         exTN07vLn9XIn4x8lYjUXlnR6HB2DKlmImi1gyEENxRyBs7tBaZ2qyLUgO/jw0WtN6KE
         +FcpjNdY0w0Xgn+MXyeOAwpAZG6j/VfNiYHxtP7i4ce3FG52topE07nZ3EZJK2trndly
         3evYyhQpAn4gxB3f60+ZuRgIpUztLZPw8MmcOvDlk+7lOrdcwbhufF66NnB4coIcuqXF
         eJHw==
X-Forwarded-Encrypted: i=1; AJvYcCWnBXCylqdmKNmaC8P3PHeJRx/k/zA1o/Qq+TBX/GvDg4ZZK4NF3m+oqMSLsmaEgYhmsNnWkW5Ku0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NyAirwnpEpgeapaDdGcZfGp11+P20VB+Owx6dxDw0HW8K5Au
	uc3P77wdZQJuZue/RlQAdcm+L7cybp1gjoBXUC6yBbGUwxsGpo4nPefni6uAKXJSWTtVyEDb4G4
	O0CLpS9c=
X-Gm-Gg: ASbGncusnlqYf46+tcm6mGyhCNxmz8ChKGxrfQLiFMd6N1G53guC67ZdLYXCwCqeKLl
	iEKYi/y4zkzn9baFccgkGtfCPtzC1h7CKkpnVz7KgGkIoGVOKIsRVisLOAau4G+oY6lunrexyOg
	ytTu4tq1gFScBdsIAQSTLSncF7GsG2ElhC6O54T62u0bpf+GDIdR4RySE2YjVZr6rWGxbi0B4hT
	TBEwtLjKZ8y8JLjJplGySfp0y2sSDXB283G3A6z+eiDkB01xxVagf/vCVLXGP7Lt8xOsJDewYNM
	+p1S/qxfPkA+HYDQVN8n8ZPZxRlx/cLgvs2LolEXP0x18fnLZYU7mr/tm/pdmSOAM2sWXnQ/5zY
	8SmtgzHwVQFaK6HeVcZqeYq8bMBlnFnjVMTe78/0e0+dKTZ7XA7HOpoyGXUZTOp6wBQCNlWBbor
	s=
X-Google-Smtp-Source: AGHT+IEkY01cCKVG6Clr6ikQhS7ALcIWi2oLXjz9bIzvCpzXVCR9GAM5QlPm1WCudIYi7GuRrEJkeg==
X-Received: by 2002:a05:6830:3e93:b0:727:3587:fd1 with SMTP id 46e09a7af769-73cfa255053mr2108055a34.3.1752253631790;
        Fri, 11 Jul 2025 10:07:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a60b4sm621174a34.50.2025.07.11.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:07:10 -0700 (PDT)
Message-ID: <3372c362-96cb-4ca7-aeba-89a72e065dea@baylibre.com>
Date: Fri, 11 Jul 2025 12:07:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: srf08: use stack allocated scan buffer
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
 <aHE_ecZNTgRW79VU@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHE_ecZNTgRW79VU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 11:44 AM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 11:07:20AM -0500, David Lechner wrote:
>> Use a stack allocated scan struct in srf08_trigger_handler(). Since the
>> scan buffer isn't used outside of this function and doesn't need to be
>> DMA-safe, it doesn't need to be in struct srf08_data. We can also
>> eliminate an extra local variable for the return value of
>> srf08_read_ranging() by using scan.chan directly.
> 
> Why not with macro?
> 

In cases like this where there are a fixed number of data values
read, the existing pattern is to use the struct like this. Furthermore,
IIO_DECLARE_BUFFER_WITH_TS() implies an array and usually we try to avoid
arrays with only one element.

