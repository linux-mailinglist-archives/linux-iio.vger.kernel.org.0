Return-Path: <linux-iio+bounces-17161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF8A6AF60
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 21:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FBC3B6ECB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74722A4FA;
	Thu, 20 Mar 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pH5WK6+s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127491E32CF
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503682; cv=none; b=NGuvmLSscarFmkyUrq4zvkks9erALUYj2svt5PNYwyAH5mhFDiaShPlZ0HqHDZZ2wFrVvAlGChrDxaRCy7txZbyO9ZDhBxATEzYKV+lF8IGtRV0h2NZHgfLz2KmX6Gj/5WKheToEUyjfaAIogIvNRlDh+L3sKAUB4Q94nZuzN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503682; c=relaxed/simple;
	bh=eDGBXuuiWlu5Pg7ttzm1q5XQiuarZWutn9QjHVQrPXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kd3uD/hvld4RUSXsywFchf9L0xx7a658R+3mzVhc6KEnpeMC4ZDqMgjRyIyxO32qa0Pua8ARwXOvdRTBSqqNdAcX08dGH3uge+U8gC9ByY3KjQpnPumcAq2tyW647qRPDwdR0G0lKpW24aS4fY0gWrWR3RTcUcVAp6qzxqv+Pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pH5WK6+s; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso1402936fac.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503680; x=1743108480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beP1vvii+h1NQ1HJq/wzuxrHVPQ5wo0QAJatOTA7prs=;
        b=pH5WK6+su6lWxeSXA1iwZtVzMf/G29IeoPKNWTDuxh5U8bEY/VIzE8MwN031nwshV8
         Xr7X3JiPuuBo/oSVaw0FzdtP4ctMsVZi3ZT+1V2LrCYWqAw9gSKgm61LxnHrUtzC8Jwj
         itBnAeIG2Dh4FfDBS/SYio6i/zSmdkKxc0yyYNB30Bo9Yo1hUkLKwrsclPuDy3aqBTWw
         dHQKNY9QyKPXYd2S5XV8Tb4/CQ6vFp/K8RWOmK6niwWMDMYm4hMk+nuKIHt54TgZVizn
         09hPc4XHNGIsBHNW/17ECvLx/kwqGkqoY3X0zLofcdf/ypUYdxSHmXxL+64ZxeksVO66
         fznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503680; x=1743108480;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beP1vvii+h1NQ1HJq/wzuxrHVPQ5wo0QAJatOTA7prs=;
        b=YgBHEvQRHdixmczsrO6bR14xT9jkbLKPPM5VwCS3QmiFexGvGigv05JuJzePImc90I
         dPXpZPBMI5Tc8cgcbSY2bYkze9Fl3/gzNBNGB0yTEstINNglJ6ziJF9AmWqhnRAj06YO
         uL279saVT9iHFwnBIZ1kRzgrCO2WS+9/2P+1WDhxsbCRwHPSh8P5yC+aN6Sc7nLhaNg4
         OhapFmqKXenu4QAgWc5ipfwxafjTfmN1atgyxor4J5woeZqi7RHn2UMR2Bfwpg4DOoJU
         idiFMR5EeICWYyFyi3vOoUORhIY/wis1COCPu7DwUDQW6RbknaZgiGdRH2cJB4gIe0jF
         Sy5A==
X-Forwarded-Encrypted: i=1; AJvYcCXnzEjHpJ2KOOmB+PDF/4j9cjdiMk0yzaEoGgIozJh9deWssRC4wxf9LvuyYbvRH0LfDYHCLpMvtHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhea4vkzUd22bx88x9hapmvbEjko7yvjUvkvk9Rr+/fkj3b1Z7
	N2atBYH8UC47Ges4mTS5kHc+9f/ke/26liuk1rHxn50L8OCHT0j8fJQ9fgvwl3s=
X-Gm-Gg: ASbGncvX6uercs+F67ORjfhtfWb4NMi5FoOvDCmXjFYIWRHZT5K7XIVa4eaten1p+Of
	bNnRi9CDTcxMx9918bFQ1aJma9QoDuYFWes9lyp08iLnxrnKqw80+UXtil/VDE31JVCB8q6OQ+T
	6seWW1GnpCEKc5Zt9Q5y94WBQGAWeeTQ5viTyhKZemmZacLG/nbCPb6NJajKXI52MEBN8A/EA5x
	fFB9TcDAgOIWZhLp6UKJUbID3CTdUBhL67GEmVbhp0bdqO6IT9vo4zEiIPHFTAHaf1XhsqLVQ/T
	MsoESy5CcgFVqjT9J9vYjiJ0hMf4WXye00Bq34KzMJq2WA7GNKoAxiDltwLtzWTvtvmUI2Ollld
	fj9oosA==
X-Google-Smtp-Source: AGHT+IEHcvNG5TJ22D5cVk/9BwK3EJUnny5rC+63WG+YzyHBLSxIc01IiEKpklWBjj5PxfaMrbIEGg==
X-Received: by 2002:a05:6870:bb15:b0:2b8:78c0:2592 with SMTP id 586e51a60fabf-2c780379b3amr710409fac.23.1742503679928;
        Thu, 20 Mar 2025 13:47:59 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm132955fac.32.2025.03.20.13.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:47:58 -0700 (PDT)
Message-ID: <bb8ccea5-49b9-4fa4-97f3-a1333188e297@baylibre.com>
Date: Thu, 20 Mar 2025 15:47:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] Documentation: iio: ad4000: Add IIO Device
 characteristics section
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <f8660f905b3c0d6aa2325c13bb2b29f954afb628.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <f8660f905b3c0d6aa2325c13bb2b29f954afb628.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> Complement ad4000 IIO driver documentation with considerations about
> ``_scale_available`` attribute and table of typical channel attributes.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

With or without the suggested change:

Reviewed-by: David Lechner <dlechner@baylibre.com>


> +Differential ADCs
> +-----------------

Could say Fully or True differential here to be less ambiguous if you like.

