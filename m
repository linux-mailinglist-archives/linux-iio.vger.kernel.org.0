Return-Path: <linux-iio+bounces-21084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21111AEC9AA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74621691BF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC928751E;
	Sat, 28 Jun 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oInSwLpU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50022727E2
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751134507; cv=none; b=j9K9eKIHgy2kqcV3oXc9ACRKC0bijT+s+pLXOtk3Cb1Q0XHbWjJiA2IXiaVuhm7YfzYmVv3ltYFv/tfOGfpZMJDf/8csgaKwDKHuRWB80e3Dvv0AAiCtXHrlvjmdjopjAG7rCSucrbGhfclaeY2wxxyTBpJz44QgJHtdTxYUT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751134507; c=relaxed/simple;
	bh=HhJu0nej6YkZjmJ541Hrwgt9nV16rqq0gQmZuoI48xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGXW2SG2b5rLVaBol1ckmrT4EcoW7VS2sQTQ2u8lPrkPiGkEeEPDl69Q3AT1Pz9Ukx4oDpacSXsuPyPgpwuHn7vOhQIfH+JPYqM2WaNmZ5PCHlBzT4iOXB02ClttwaEhs2uLEcw4jVoJKH2ZsUGZ9SbgV5EA41D59IjWU9Jw4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oInSwLpU; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c27166ab3so674792a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751134503; x=1751739303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opMX1Qwlgu2eO59hinQtvPB+M4svOAtsX/gx/lV1xqg=;
        b=oInSwLpUKI48r+kfhv4mzfGO3WH2llVMu+CkFNv29gm9JTl8hZL+YwC3rbFCzHMCAV
         h6d3Mj0dQdY2Wq1YRhO0M5vfF+Mzvx4wF0q3f58CNypYQwOOqn0oJwaIdDbkB88z/7m8
         p8oj31FLBYL6zHAoH8XLsOZG9SFG+Uv3ot6pw8Aalsnc5XyLkbn8y82I1RLIJhQl1hr/
         O9SNwD/vCuA1NC6vn/xLqq72yyIsSx6CusxukngGLt8NjEo6wtxO30QYGp2r63XCWMU2
         ut7KC8nmuJeO0Xbmn5rz7M4XnECQOGWZA2vRopmk3YqugpvJG0hsO7GiIoWZuLYNYoue
         8kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751134503; x=1751739303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opMX1Qwlgu2eO59hinQtvPB+M4svOAtsX/gx/lV1xqg=;
        b=sJ9mnaFbe8YVnxr6x9qnd/NRW+CTZpV/4HRmlQPgPdf0kLEfhjXgoaPIr8RQ0uWauW
         54NQJdI12ccgS+DTuauRiLkWd4z80UnNd2wMvR2lDylHyhC9WlSt2tNWZeUWNla4WcX6
         YaVBvWVkjareo6Aqx9YjXO+ldO1eyQxpwcQB8V1x+GP9pJiGAbiq9TkszmX1BpEnL8jR
         lw8EHaWD6pjbijy/9weWt3udCspx1z5wXBAAJUO2aeNQAoRG5ywjoyt8ucZLe+cc3XfR
         aP/eZBQHKokAAgOkQUOdyf+NsHT8QKDV0L9sc8O/eG4GOtOZN2TVzKF/FqTv6P32qlL2
         O+fw==
X-Gm-Message-State: AOJu0YyKyblxJv8d3h0RwV6mMyKbfVHx3IYhTSCtHffqvFVubVwVqjRt
	E1QDPO2DYmo8D8dDoG3e9NDZOb7vqn35tZ1ScEbYvFBv9co27GxH1aj+0/laXMjA/oAkwbe6aU0
	r38Et3EE=
X-Gm-Gg: ASbGncs3mK+yop0SJ6WZzS7C0ufYPgKecA5CIt8AboXJ7y1fu+k9FkIB0B2d4ZNpuOU
	1CoO+jp4ri7MMx2zvb1NXcW4RHtJU54gVfROZTwZy03YChSVZ+LrDqInzUL3K2JP8CulXTC+qha
	bg0C+S+Yfcxhnjyy8+tKHwvon7z+OuoJ5ZsX93uqf3x7KLsdsQJyLIFAyajZn6eAX/FLV0dbnlo
	3C6ZvRGewmAj/t7MDPw5hx3ABDgDw+9Tdwm/4XdBz4yg7Wltx+CcpHWVgaxdSLcCCOpAo1za28z
	T0QprnMmPtlbRm09L9g472gSxHA4ejiMGmZvVqfL0Tarz7a/7q8tIszBiki8BTrsJCo4jX/gnZM
	aFeoSD3eVlNptLKjmK0iFW8sA86Q33U8FscUO8Eg=
X-Google-Smtp-Source: AGHT+IEEQkM1gJRIew9gOz8gjXb3IwEUoI9QxGNe8m7jXfBjfsS45L+o6phsIwDzLFXqm/Od5/VXeg==
X-Received: by 2002:a05:6830:8009:b0:735:b9db:5939 with SMTP id 46e09a7af769-73afc3e703emr4147723a34.10.1751134502681;
        Sat, 28 Jun 2025 11:15:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4? ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb01d79csm905055a34.28.2025.06.28.11.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 11:15:02 -0700 (PDT)
Message-ID: <bc8d1e7b-bcd4-42de-9011-4e1b6fc3a23a@baylibre.com>
Date: Sat, 28 Jun 2025 13:15:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: dlhl60d: make dlh_info_tbl const
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250628-iio-const-data-24-v1-1-353b97281534@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250628-iio-const-data-24-v1-1-353b97281534@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 1:00 PM, David Lechner wrote:
> Add const qualifier to struct dlh_info dlh_info_tbl[]. This is
> read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

I got in too much of a hurry and missed that we can drop the chip info
array here. So skip ahead to v2 where that is done.


