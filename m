Return-Path: <linux-iio+bounces-23810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961B1B463A3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598BA16F8CE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254527815F;
	Fri,  5 Sep 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GuoWSHhS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D992773DD
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100576; cv=none; b=cdPfy+MFM/qYPiJ8Vrp+MYK6m/5KeuecMQW4YAgTFOosbJXn25DTiO8VETDrKtpJyOREUqlTMO0LH4l1dwXsyDsPuF2I93AZzz0sysqd9N+GIIUwwQOvzIRKg8u7SP3LEooeYy0QI7lhYJ779mIqULYBOTcj3f/xK9vSzbvO1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100576; c=relaxed/simple;
	bh=45wlAR80iTJXd/llXMmkzBDPgoF5VQC7g1kmFtJctW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QThbyz/7qwbWlSbvn9RWHSgdJ2qqKxamIi8y27L41wE/TSH/cG58mjw3jHKIffPROJMXqEA7Hh+ELGGmhODff1Dxmfcn1TvN25PUtsxGyagA8SEWj6N9ah+uSKCUbnXrYUdmPcCll+1EpIOb5oIV4xr7oxxzPK5aqUJPuRQRkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GuoWSHhS; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7493d03f426so314276a34.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757100572; x=1757705372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+g+5lforXyEuqg4W8dX6c7NFSSdIzchmf9h56lBoXdU=;
        b=GuoWSHhSv3gWdEJO2LW0T2P+PZrF8WnykOzipzN2SlkNTrr63ADXxr6o1DtrUeQ4Me
         AMi2SliE1dValyVsONREaU+FLh4CPNJfuzAmnz5CvpOGAAkuwUj9ebD8DTUTjQgtjQbz
         VQ6pp0gBEWQ/qfDnDOXBEVvue2SLTNcegoNjz8R4WgChXxpShQ/1eZRibNoVoBiXdH1H
         ghvfVX/iFlr3o561nVdFLvV76YdpXoeLY2js3UUEVo3QkWFpi+xgt5f2vJEZemsfxBtY
         gzItt24XylT6E8fx9NgKLnyPWxHFtGxNWzqqDuXu1fbD9DMwTrQj+XVJiUE7LYqbL557
         cemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100572; x=1757705372;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g+5lforXyEuqg4W8dX6c7NFSSdIzchmf9h56lBoXdU=;
        b=MA3+NAQaV+tkIZYjA0szx66yomzpANTtcFF09To6khgLgDnNuP9pECv+1sdTYiism2
         w2dCmrXp5xWClQQUzmqA8lI1Q+KgFCxoDvOrxDKZ7+ez53RkXtbvGgWkMTWzylLbfIs0
         uFVo6HQ28fp5PUfZTLH8/AMQdEZ69isJIWjU5F9v09j6NwNeaRfY3rPX1mJIwEi7ek7w
         jngwwulkLXOsoarjE++dnf4IBNXFRrYrEqhZXI/NUk41uzsuOLnJsxzh7m2JSoiixY27
         m9GChlDCdoUXIehQkdkiQFS1NAqnA4Ix62jgsfegtotDzuNTF5LuSR/W4FppYuOk5Uok
         KqXg==
X-Forwarded-Encrypted: i=1; AJvYcCXZVMsaLc+K1dCoV5Td/n3K+9q8f1ZFai7T/c7q62VGmYaprZ6Z2O/eC7IfCvr5m33MzA4Os5jpWoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKtr0mrjO8lSzcgeypYERLY5333pmAGtgc/yjmwEHiKVzNOng
	njRa1ch9Qwk/HyWBBmAUfVm7nwimC9bkaqxmop5bKHg+BTy4uZQULxg2I2b9GSBCe54=
X-Gm-Gg: ASbGnctu0Z4EQQv6sPvkgIHas84E5aVO6jHA2sslszqkSUvqtwftgOF8W3TxSeWIjxs
	Gdx5tvoYkN346D7m2nJ2CAC4n5+bYB6XNqXtSnTETcG8RgwRvGFDrenmqksuPytwthrU6clTgB9
	JcT+N2YoScwSwO5GJhyBox4uWL2XBwaDhcMhBPJXbJTiVbM2Q8jAGCVgeS0D9C2mbLYDwSYnMt8
	Dd8DklWbPEfOlmvJ6lVvWCWxya7AdbiDt7FTjPl/w7cUQoNYGKhy9+SUEg5kPV0aEwufjCuCs/5
	TJ3VBLVEsQ9qXVvhpRzLQBwPxNLmGYStGQMbDt7Eylg03T1IyUS3DbpSp6ybtLapPaAUnZwEqg4
	GxA/0zEAlxGoXIKqrmhJF9bA1l9HJUoRlepgSLd4a44sLZzyoywQSgcEqN4jYhshe3+wR7hZX
X-Google-Smtp-Source: AGHT+IHn2V7ETZFEtt07s7/dwRywKF9uaieyn00nGQKviQB66glTz8VWPcgFktJvmad+rsH5s4ufmQ==
X-Received: by 2002:a05:6830:65d0:10b0:745:a0bd:d71 with SMTP id 46e09a7af769-745a0bd0f2amr3951400a34.23.1757100572644;
        Fri, 05 Sep 2025 12:29:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-746db95ecd2sm1054074a34.37.2025.09.05.12.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:29:32 -0700 (PDT)
Message-ID: <57fa4ea0-36eb-4e1d-981d-7b2a1178c84b@baylibre.com>
Date: Fri, 5 Sep 2025 14:29:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: proximity: isl29501: fix buffered read on
 big-endian systems
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Mathieu Othacehe <othacehe@gnu.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
 <20250724120329.671dc192@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250724120329.671dc192@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 6:03 AM, Jonathan Cameron wrote:
> On Tue, 22 Jul 2025 15:54:21 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Fix passing a u32 value as a u16 buffer scan item. This works on little-
>> endian systems, but not on big-endian systems.
>>
>> A new local variable is introduced for getting the register value and
>> the array is changed to a struct to make the data layout more explicit
>> rather than just changing the type and having to recalculate the proper
>> length needed for the timestamp.
>>
>> Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ok. This probably is the best minimal fix but there is a bunch of other type
> confusion around this in the driver (not as far as I can see actual bugs though).
> 
> Might be good to circle back and make the val parameter of isl29501_register_read()
> a u16 as a follow up.

There are a lot of places where *val from isl29501_read_raw() is being passed
straight through to isl29501_register_read(), so we would have to add more
temporary variables to handle this. Not sure if it is worth it.

> 
> Applied to my temporary fixes-togreg-for-6.17 branch on iio.git and marked
> for stable.
> 
> Thanks,
> 
> Jonathan
> 

