Return-Path: <linux-iio+bounces-16712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DBBA5A56F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD917441A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C671DF72C;
	Mon, 10 Mar 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gD4So5IK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9081D6DBF
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640509; cv=none; b=dU/Z5gRr3FGRDkyIiyqZer6qHzN22502CkIAwLnrdM+9Mx4tZPtQRA/i2906roAQdslHVJVqlF74Md99xOBsWvX1AHfB7+0baN+CEVNN63u5f1sqzf7b3vqlSbBfElGwzp+GJgaxlC1UC/+bRLGQIS+AkIgv0f7fIo3gE+1Bkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640509; c=relaxed/simple;
	bh=uvl+tCTSBkpkA1JocRjArWmG37T36+NIL9cpQh3h/7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2X///g7CVaN8oAgZyze9Ii1NddEdWJH0lA/f4ay+N1+POGDM98Y61I0/pqA60hSu5fLNPReo6+IZizgSukW4MiSRRUioc8NchbFil/aT0X7+B9npeVY7sXqXQciJqQJEGRGES1oWLJ64se0+6+PI3obl03TOhcYXhJP6q3tElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gD4So5IK; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72b7f553de3so138198a34.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741640506; x=1742245306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh6NBQiJXATQe2dlTg58r4IHLGmkgQvhFuYRHTx4JoI=;
        b=gD4So5IKpAvy5uKSGrhX3CF1MhN8VeXjcQST/2NIsihABLxIdspg/Dwd+gIw5xw1y0
         CJgrkqqYjLvpIlr5VrwOxkttdw5iAl2uEUJEARU4K6xUgi/CIp7DqlZfenA0HHPiAYYK
         utQXzq0EH3UmTzBi5KpZgzjr6V4FDyd7UP7SaKvoYhemwnLPiI61QSqMLJcSAnFAVI6u
         P1KvqD3SHTrxglYPOUpB2KcLmXB+gald9DA/8UZSKhrN03/QEzvZ2SmDmOtU3jCAYm58
         OMIme8YOUnhptFlyAO4qH3SErcyIYF63Jd2yRUnQadTdHu+pE5+AuDtclfVhkpR9MrUN
         PW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640506; x=1742245306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh6NBQiJXATQe2dlTg58r4IHLGmkgQvhFuYRHTx4JoI=;
        b=Wr2ZQBIottFNicwtuYZsGOw8x0tFOlm5uocYiOGvC1Fhw6j4XbOiOauBkA66FSdZZo
         w5HpqcO+XdKEu9Woh+YQtgB5Zfr0e7Wz4GZ33Ia0AR/n+DHhCClZHzBc9xZ+Ma8NL1qn
         TtIrlFkoHKkrmJdsNAdAVnLH+7MAHWZOzGPx0FE450NZCQXDnab3fJiSqZsyvpdE2wEv
         U8xJOTJ+BfBseTG9e1WKqo42f9XuajMq2T0nK9LNJlGeDU+6bC4xpzyq42F8qCEOrHfK
         9PL94Q+0P3bdQ7ijDrATL16xV+LjhebLcKvoerqXkatDCDr7dJGIduo0szKOw5GSqYHp
         YlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4SzVWVnbFgTBbevmSUao8MbJIpR6RcW3zIm4ch5PbLKARad3go0tSyT/BO5znYRcKtNwaXi/HdIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlpiMahVkXmLcSqxkoEcrbHIVcvwgzmw/1zJozgequ8oXwmKY
	63F7z1xitxmJTG/LuKUC88f7oq4HkCpkKazfH0i0mVsWu3RpeYLuEdMiFcpeQYg=
X-Gm-Gg: ASbGnctZ1EPQY3Gm+s1CNFy9Q2B+ioTupFvKv8Zlx/Y/dvb/Y9KAFruW1PEMZaoZcdy
	OifhnHSow1WXKZKvuhJt8JHjnMjA2B1H8apR4Yp+SocGdJ5krvuQgQl5frBUodvQUYugXF4xe0M
	2BbHvue+kxjOJIX1wIbKsKcjSe6WYarVrQd0ekd5D5p+LMXO35A2NOikkLnrAL9ZH2v4ds0/lvf
	h6fRE/w8oRyHt2smA7wB9fwS9UPANnDUfADrdJYRRvHg3lHa6gwPk1hBTGm68lLdQ5YfzfvexXg
	R7E0ze3m+feYD+otN+OmRw9r8JVY/z2Kw2rfoN7WFJXMVTYHSj+isc+nng5XauSNxwrUS/lLM77
	KSioE0z9ljd9mkB8S
X-Google-Smtp-Source: AGHT+IFws383NJzGNKMTduW7VFs/LhYVCds9An+PWkBfwPQGP9vDAELOMSUsERr+wmmRotC7x4j6MQ==
X-Received: by 2002:a05:6830:6a8d:b0:72a:11aa:6ebd with SMTP id 46e09a7af769-72a37c771c2mr8328040a34.23.1741640506456;
        Mon, 10 Mar 2025 14:01:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a7c926001sm1298993a34.32.2025.03.10.14.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 14:01:46 -0700 (PDT)
Message-ID: <3fa4136e-b384-4c3b-a58d-773887b87552@baylibre.com>
Date: Mon, 10 Mar 2025 16:01:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add support for AD7191
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20250228141327.262488-1-alisa.roman@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250228141327.262488-1-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 8:05 AM, Alisa-Dariana Roman wrote:
> 

Probably too late...

Reviewed-by: David Lechner<dlechner@baylibre.com>


