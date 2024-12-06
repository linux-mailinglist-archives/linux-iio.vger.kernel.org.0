Return-Path: <linux-iio+bounces-13134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7F9E618F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 01:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6DD1884FA4
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 00:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D9ECF;
	Fri,  6 Dec 2024 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uDmidVB7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFDAA23
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443423; cv=none; b=l2Gp6NqnH1siV4bZUuxBLBGXAilMfS68lsaysgIQhJHps6HklUnlt3mJkbzmdNEswXq6bHGEMDxDLA/zBiauTaD09JLuIj1AxObSJvdh1jAT/qaz5YUH+6fkS2v8/ETwn0Z6MhP0rAjWVDn5XOGtvhiVb1Juh2WcUnG2o/Vi3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443423; c=relaxed/simple;
	bh=qbCLbXOAmU7/fx5+PDIlZxfkhc6FTJSnBNp9tcZ/sBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTnDQ6o/HLvuqaTxDSOCWtE7sbbVarpnRbXwrpZKrfroLquemt2iwD6a8NdO7zw6nlRiOYoUM72ToK1EWWGsY38bvjsbuWqdn9uOM3SPWG0frhpwf30CJsFhnZQXZA1mnBzcDX7QyGNABQgAIhYFVsFXSa/+MUv9Z2OmODE4IKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uDmidVB7; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29645a83b1bso824273fac.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Dec 2024 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733443420; x=1734048220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5vFET2LxG5T8tpAsNWIDLmJd+E6eUUYCjL8dYpTWOg=;
        b=uDmidVB7oXNr/6cbSTzWwLQC7y8JS/D3KYhPUGf/10suZbkQLoqfDzjsPYTtP5MZs/
         uu6MutZQzAKT+FWYH3DqGL5RMLk84Ilx96t9EkMzK19DDW2FOs+gHfLrH5ML/Yu6Vjfb
         BQI1pvIAlv59LLnAyXRqlelNL1Sns4qQceDTUFjUml79geWGJABXPOhGjsdbwxXCS+uY
         uJZuPRUZHuCWvxnz9E622KMgp/bBh5AzNAJXrncQkeNFYgpAPdFhO1FdYmB5tGpvmKO5
         V6vaWQskXllB0zdabkVEbN8wseNbZ1PYiKLLNTmREbt1gZLhArY5E7NrPtExik28Tit9
         DO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443420; x=1734048220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5vFET2LxG5T8tpAsNWIDLmJd+E6eUUYCjL8dYpTWOg=;
        b=ctInOw4EZc6xpVXLjFRMq0C+cvwtqkgTaqBII7KKhxL/ve7IlNwo8JCP4WXQuwwepT
         VD8zySRU+wH86BdeOVrDBx08WCidC1SP+KEU99aQnIATeq7cOZoYlp8uPywmEDVQUHB4
         TqQPmgWASclNrpQRP1MMsxkfin/mCZrDeI0xEmlsI2+lZXLUO4EUAcbPTWSKl78fBzJn
         s/ag9kt5Lz/nDr7uVMG610pvPc2gey5iKG0pOGNUyEKEiMBeHddprSDcS7scy/89oDZt
         0vqRVs8PkW5E+9tfM3YzfM9pvf0Bmnh6+tbKleyf6FJAzBP0oi4J20Y2809/eQuTDmAm
         AgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2BJ3jRhRCmEBkoRHQkko/oEmG6HZasoGistynfnE+Ut5UYQexmnyJbz+jTj+znbn/18sr20Lmewc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/Yo6XkUNjCiM92CoN1RoQW2vjIxOoXpqhjlKEacwxG0YvizG
	GyxLnCqogL6Yp4GbE9132RFdsX70I3k8KeuTRbdY/8hBzVz+McAcSz2BRDq4F6g=
X-Gm-Gg: ASbGncvnFX7xZ+kqYe4WnZaJdiROYdO0iTZxiPpX6N6XzYNgaqDMZOSvyEC4aRLsdv9
	EmLczAMmI9d5JHoNyqCECw65I1u08pUyCvlZtARfGFHdxD6+yRWuXN+GTgAymduaGUwERydHLn1
	iqoZh/5TzmjELX7hEFlwbas9mEyO5KCPFxmrX9AEk33VtcWqptQw3Qjc63CCEoMU0O3wtWyB17i
	clzt8Ex7FWAJi9ki/3UOTEqq3JTl147xtBx9PEr67Pn0PsA0PopH9BpzSfuHHUwEQ9HvN7+kTCw
	5A5nzpAgeOQ=
X-Google-Smtp-Source: AGHT+IECYU0jj5jbbPl6E6YzHzZxPOVKClUUsz6XXsvoWGW5CsRwuTbkcIDj8EBTYuLuAoRMOO2XjQ==
X-Received: by 2002:a05:6870:6b99:b0:29e:1cd8:4a0f with SMTP id 586e51a60fabf-29f73283e34mr546914fac.17.1733443420263;
        Thu, 05 Dec 2024 16:03:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f56739df9sm587232fac.21.2024.12.05.16.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 16:03:38 -0800 (PST)
Message-ID: <5c2d828b-247a-419f-97a9-a77a6653e846@baylibre.com>
Date: Thu, 5 Dec 2024 18:03:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad9467: Fix the "don't allow reading vref if
 not available" case
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
References: <556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 2:47 PM, Christophe JAILLET wrote:
> The commit in Fixes add a special case when only one possible scale is
> available.
> If several scales are available, it sets the .read_avail field of the
> struct iio_info to ad9467_read_avail().
> 
> However, this field already holds this function pointer, so the code is a
> no-op.
> 
> Update ad9467_info to actually reflect the intent described in the commit
> message. Keep .read_avail to NULL, unless it is changed to
> ad9467_read_avail() in the probe at runtime.
> 
> Fixes: b92f94f74826 ("iio: adc: ad9467: don't allow reading vref if not available")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only and is completely speculative.
> 
> Another solution would be to keep ad9467_info as a const struct as it was
> before and add a new ad9467_info_no_read structure.

Yes, making it static const again would be best. Modifying static structs
that are shared between all instances like this based on the properties of
a single instance is asking for trouble down the road.

> This way, instead of writing in the structure itself, we would choose at
> runtime which version to use. The main benefit would be keep this structure
> with function pointer const.
> ---

