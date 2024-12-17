Return-Path: <linux-iio+bounces-13589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93939F50DA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982791892F53
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4C1F7570;
	Tue, 17 Dec 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nSkkUGQg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469EB1D79BB
	for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452101; cv=none; b=RPSVzoqRje2IfKmmtZkim/0YBd5hE9l2+mjPkiw8bUwcEdTnNmpdCeMMqZA7KcO2Zfw6DCn9nQPRHlkRGn7X/Uqy0pjTXPSsni6wSi16AMyFHdK/FGivzTnAcxOtQXBqjYV0EktAuTFTj4D7KxuYtiE1wudUjPjUQkWckVkFcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452101; c=relaxed/simple;
	bh=QPSYckfiLL1lnDodBtIUNq6qmRcvEFpiARDp6WB18es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo7hWeIeN8h/XBmtNwemAOWV+VCNhr/RG+RicV6uA4zLg5ETPa9tUAzf5jCjhbj0tZRxWAODidf+ywCBttzFVG+k6e4RQiu2ocJUmSlIILUKzUMtQEpr8Y+gB9ay6bMNNwJny/p79EdCv7k5A9USqlHuTawEMNvXpJH3NbYcic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nSkkUGQg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e3167b90dso2471889a34.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734452098; x=1735056898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0qj2ZtXw4mGi7K38v9aznJPLj6SnTFWzYOgNwna2zA=;
        b=nSkkUGQgQv2E41niw4e6a3oayeJU4WXtNTTgq4j3NTQZRc3Hy0ozJ7fv69bKPSQIRO
         ce+4ATmjU8jMuTP2LXwbgT6VBKFtLKUZzNXKOTDEr/qOJ/tgzE80qqfTT4jLJJfVbb4+
         9L+z9cUSIIG8IZ83BkHrHOA2RZUqTF3+rW1cABaaTsw9WwZ9yl70+0SQjP3aBNt/VjYO
         +nKGWmQoxTJSDrxYkvA74cDiFPkHuB7UAnB7lP9Nz62S/gS+kF3WJumVh5vpdNI29fuN
         sfkZ6NlKBw9Eg3Ezb0xCAnm+SwWB9vz3oy0aG84ceaMCIrLpeEUdaP9jKyOgvM/s3hCO
         LP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452098; x=1735056898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0qj2ZtXw4mGi7K38v9aznJPLj6SnTFWzYOgNwna2zA=;
        b=INjoqD/Vxws4YnYlkddbxw6vGp6R1GtUX/8kVQ5NF5Mq1THOomRIgT3kz1fRulIdG8
         KcR7Tyb6aL2iITzC0TexKmLmdIX6e0mANdIqVSIMbuI7xtnuFJZdZTYERwOI/ebQr0bp
         iPLCIOvYGQX+4u1b5mZt1pJcrrdpMyPSwbfXyymGp34yXAVToU8ADlOBpdi7m0nYlrEL
         sNFqXe5atpNJbAziGKBjfZmpDfGRWQITXuw5M6bVs5xAe+oiW9ncZZY2UwYkNgE+HJce
         34BBoIAgG1Jy8WFA1JEDIegaqwxIJIq8UM1Ul/L88x5MzD4WhvHdWs3a/ZtaR3T5ie1J
         Gu0Q==
X-Gm-Message-State: AOJu0YyZ0fdiRSX5kOUnx5ozshC9LYD2WZB1lP7b3Ee1k7whX4S3bOnF
	heJ9YCv0JwyKRUqAcfqKgfUa5/1IQfbwn4gm8b8iD3YkOfDS61i2qyWF693Ub8I=
X-Gm-Gg: ASbGnct0ngPHylEl90PaUCd4sZC6cZavBi47XhtbmlImNXBF5wScmRwoqRCIQTnpx2Y
	R9mulN77j2I3DSQeFhRulhnUl2yIqeZVUd5KIByJGN1DZGD+XHI5iRdEqv8tPx9qHe8IcmOd6Nh
	kbp2tqQn3KrOds0loFIzy6E5Vif8d0XQZ/QYJcwCBNMMLU0fmCjH2I4zRvUKkh8K4YiUOmvANWG
	Ex48roa6xeO4M7oimbfLvVPiaGTXe7W3ugi/lYALh/MYhvfKWsYokAJ0psKDuuGVp71XiA0jGz7
	E+fwChGqswOy3MiYcw==
X-Google-Smtp-Source: AGHT+IHi5YlEBrO2w3hulIZ7f3Hwzjg+RNVJ+wTBdSjvtZ6AqMLZVxIyBU2OF+hr5jFFwnec6Kgcvg==
X-Received: by 2002:a05:6870:7007:b0:29e:65ed:5c70 with SMTP id 586e51a60fabf-2a3ac99010amr10303582fac.30.1734452098401;
        Tue, 17 Dec 2024 08:14:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2913d16sm2845239fac.35.2024.12.17.08.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:14:58 -0800 (PST)
Message-ID: <962f14e6-9b6b-47a4-9751-fa017399e563@baylibre.com>
Date: Tue, 17 Dec 2024 10:14:56 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
To: Matteo Martelli <matteomartelli3@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Rosin <peda@axentia.se>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
 <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 9:11 AM, Matteo Martelli wrote:
> During channel configuration, the iio-mux driver allocates a page with
> devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> buffer points to an offset of the page due to the devres header sitting
> at the beginning of the allocated area. This leads to failure in the
> provider driver when sysfs_emit* helpers are used to format the ext_info
> attributes.
> 
> Switch to plain kzalloc version. The devres version is not strictly
> necessary as the buffer is only accessed during the channel
> configuration phase. Rely on __free cleanup to deallocate the buffer.
> Also, move the ext_info handling into a new function to have the page
> buffer definition and assignment in one statement as suggested by
> cleanup documentation.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


