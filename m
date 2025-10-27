Return-Path: <linux-iio+bounces-25494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C37C0EC42
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01454188B735
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C422C3749;
	Mon, 27 Oct 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X/36PQcf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376102D12EA
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577155; cv=none; b=k6Upvv5SRAmH8BLWzsZkaC0d9rdWVdcmdkMH/btAdQ70Ud6KplT3122MzUwV8Ds+WoXWSU6I8FlxesCNMgSJSbx5/L1IFgTFMmQAmbVLlQXH/j/Eevfg5YOTY3N/ZSgoSWSAcPa9ZXdh5gYUmuuN8GEq48WHoyaXxsHUjxjMPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577155; c=relaxed/simple;
	bh=7wL4+1onpcS68N8zd7qV0fUv0eIqqqeHEAHM6Nw9pSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/RGxqbuYW8Xaa+6nqq65e9sx62/WqNNfgRcMC3YvPRhXeK4QgAU67czLU/XG1KkrD5DkZJiCJOlA28zIkDr91SGwCxoFZKwTuDAxytsLqmMlog0YpMgrjMP3PagoXE0TVtxASJCObnbE0+EJ1eT5F6PW0YCpc8mMKwNhP3dnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X/36PQcf; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3d3116a5a26so1120655fac.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761577152; x=1762181952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42PPEESTPRM1MqRXwgq0RfVuUgixMW7zVQ9CGj4vqjk=;
        b=X/36PQcfCZBVZF/dPsIyUvxa/CJMFGvsJ0hTekYcOxUk3SyIdaN+3lmWUPcqkeqTck
         AQGE62bhBkWyHB9ZJZtQZMnqnSY/iy4jaCSrkGahSFMjGl3+q2URy2Q+Xi2XeKm6WQfa
         CQgOPwGbBaychxI7ZLwg9pjb6FlfjsCCSR7iyRua88EpUcvoo5DaqVRrsuj7KplYynpA
         BJnXU36gPehHoLXyUtqpVJR8gA6T4VIyzSVywFuYGbvvsi50MlZZaPFVCeRDtZkODf5O
         I7/qf1NY/Qdpu+bcOoyOpfpBaQweiO49Z+SpawHFr8V6xNyGnG6tB5clajx4qJfruYDt
         Pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577152; x=1762181952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42PPEESTPRM1MqRXwgq0RfVuUgixMW7zVQ9CGj4vqjk=;
        b=M8x9SRiy3HyTIHENmB4yTrVyl3zcyj7yBzHikGwP5gvm3f69v4Gavpz39BQ6cAHt+i
         N9O6YgJP4RlCpyLcl7T5aY1dPLjqXmNCpDTGmfMGdNu0Dgr85eXElao0+RFz5AUqL333
         D+eV5RblwzS/9oa3pwjZJkmASS0tPkrwB50nE2UmTIBFZm8/Hoh1rPtxaQ8PT5cEt4i3
         6hb/sXQEF/miorFM/Cw6BRSruq9ji95UKVc3YYVEvrWPGUjcHVZ4fyT2CBAfm3wAJXv2
         R2zCCUFrHKKu9NH5Cv0a4eW0gX7u9JH3T7H4TQcaqIded+J/T06/TZ3gWARrVhRkghao
         4lUA==
X-Gm-Message-State: AOJu0Yyt1gmz/pNIhQuawYW9tBOdw2ercJITxG3BSb8U9Z0bnVQJt53D
	qnLspFrgGTVChTOMsJmd5vC3FKfUao2gqaolQsk7KtXmM8DVzzjZVcbPkTuh4CUKNTU=
X-Gm-Gg: ASbGncvQ2cDEXc3mlOLE8zkPETWF6SYC0ap5XjVG2em4ox8eHci6VtYyF8bztdgb+5m
	rBvuP4mTIJWd3KOVM6u7+fwKFk9YBq/rW9zsNHQFu/0W5NeO72vg/YjKl5ef2jit8Mbq9VU9jsN
	dzt9MERKRWFos9n07euPVmAL5DYBVCQAjMwr6xWVYusvyZBcO4hXb3yrHx/2w88041QwOcJwf1b
	p+xA6brxHrCNF+gqlgwW90lUeMgdGSdOEA7wRScyar+PymlbCuhqRdycQPKNywV5A0fBA+kzEKU
	3BCNBg235aNdrV2tXXC4PohciZJ5VH4N0Q2jXhZx8BAbCF/ah8m9Zv/wED7/9IwGmavS8uuHo/p
	uhgOzG1ov2QxKn9Lmnf44CgeF/9GPXDpTg6IziGkwNUmbnCEnUNpBEhb4yPqPywdGcx/rqDY+MX
	ImE/ngDHhlGTOMtK904BEGGDN6+Y47/UEc8gMRlDKKvkoQ4IhrQQ==
X-Google-Smtp-Source: AGHT+IHzuM7f2/mhqN6TNTjfjdCykv8WqRrQS182YAqAkII2xhAQD50KGvCHAYvbwychNayps4clAw==
X-Received: by 2002:a05:6871:ac0e:b0:343:13e4:9d3 with SMTP id 586e51a60fabf-3c98d18e2bdmr17563909fac.49.1761577152296;
        Mon, 27 Oct 2025 07:59:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e2c30b50sm2536302fac.11.2025.10.27.07.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:59:11 -0700 (PDT)
Message-ID: <66c8f410-6bba-41d2-88e2-46dbe133adaa@baylibre.com>
Date: Mon, 27 Oct 2025 09:59:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_2/6=5D_units=3A_Add_value_of_=CF=80_*_1?=
 =?UTF-8?B?MOKBuQ==?=
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
 <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
 <20251027145213.7c93a3e2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251027145213.7c93a3e2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 9:52 AM, Jonathan Cameron wrote:
> On Mon, 27 Oct 2025 15:34:51 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> There are a few drivers that want to have this value, and at least one
>> known to come soon. Let's define a value for them.
> 
> Is there any way we can make the x10^9 bit obvious in the naming?  Or do
> something a bit nasty like defining a macro along the lines of
> 
> PI(scale)?
> e.g. PI(NANO), PI(10000) 
> 
This was my first thought when looking at this as well.

Or something like PI_x10(6).

