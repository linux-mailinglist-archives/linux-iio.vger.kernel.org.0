Return-Path: <linux-iio+bounces-10105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC498FCEF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 07:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330A01C22423
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 05:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30254656;
	Fri,  4 Oct 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7gy4O5y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7D81E;
	Fri,  4 Oct 2024 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019073; cv=none; b=Wy4d+VN3R52Xw43zW0TJomqBMsehJ+YdTs/Qkmr6uAEGUbZUvnVNV6pLkkFYGzk/ipjOUspe+e/gjfG1kipkS/AKXzm0UaO8CUwZukC2nV3ovGT63RNz5e42Fi9wW35SBG0oliBNBl8IWKggrxnZaWg1wFYzBXAjJymlVC2ByoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019073; c=relaxed/simple;
	bh=+fBk7IFqCNjsUwRi2FqXzXYFk6+tw3wIA3m6oDtIunI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xy2k7ON24skoMB6URG4IKa01dOq/uD/vknF5Nam4kHAPAO5hJVIHqxDpY33TEkLIJl1YO90Q4kW7nlhIbjuK+wNtBwdjq/YrmQso2CGD7Mn9VkvihhpucWKHKH6Z7jHGj1kIHGyb5qc7SoI7KKbaAae/ZQ3m/jtbxdk2FW++c7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7gy4O5y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539973829e7so1689892e87.0;
        Thu, 03 Oct 2024 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728019070; x=1728623870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aCFDyHoHoDbgO0v7sJEQUIlTXYtnKJqT6KUQfPrH/I=;
        b=d7gy4O5yJk73WW7AfAyWufkhTX6sVL7FzAj6mC4Y+PrikEBBw8UH2znHVCVPKzm66j
         OVos9Bo35djopkGTXBt/j8hPgbK8G+juLz3MHmIi/JlhrxhOeDV57JeSPg6d2tmxl7Ra
         qoAf91uuFczhlzkuDYtd9WEmQKfiXGYuPqWHvNhIOuu6EPqQQUhZixamEfFJ81ram0oj
         /oQl/2gl7Gmv73wSFJ9r4kbqQAzcUa2WRvj9A+KAbqp0n51fCoUAp3x+9O7/mlYffRTK
         /B/90fbIx985wr61YHB+78gmKSTKhdCxz2NhLrpkgk1dEZKbIloFi4JRXKTx+sSiWfAc
         Zy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728019070; x=1728623870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aCFDyHoHoDbgO0v7sJEQUIlTXYtnKJqT6KUQfPrH/I=;
        b=ilhXdV4xhKqVey8w37lYM6yAAV6b9rryBjf+uhZz90xEhAfRGIoxtMf185IKwxfdiR
         iPFGBxd+FUGXjkXuz3iPVskxk3+sNhr6lrFWMV+4tumSAH7pw6LFn8nIs7amVDTWhdgu
         g8RNbZxrmfY3EUYYbmyHVcHS++rztLKwx7Tcr/JsO/c6qTgBG5V1uU8SRSoMpib4ptCD
         5OiffGXHoP0zqYyJxds8ZO7LB5PAe/aEZ1HC0d/+PuT80cHhHn/nr4jeUmu+lyp8Oo1l
         SR4woL3AohiilZkqBOpG2JfIVUlet31TGhZ+eZrOy2cQV0qLHUofKkY5eL/sNHirSRLx
         BxLw==
X-Forwarded-Encrypted: i=1; AJvYcCVHsXrfKWjElLNevwmkN5MnPLlPI2+H3KyPDivSCiK5ps1ASnZA4qLNlG81cLbLk/f+a/v3A2gNQ0A=@vger.kernel.org, AJvYcCXCC5ieEojpkqptNdBbvT7K4VSX0t6A7g9Phw5AQUU63TiHAnhPkc5MSwXS9o44xaNlhSwubztYlxzI+ZD3@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKbMe7G0UiNxDKNqqPaOyAOsKGaZAhGcfos2iY6VVPjm6UkQb
	2/24amYfgpQiEqmwNLFqPOYixE3ZodwloQjfE+waqGeEIAgVUvSv
X-Google-Smtp-Source: AGHT+IEFiNK95lx/7Iu4CaSwTSzEGHBwKDwH9RpCrRqbcly5HgYkF711zz+cHyLHKH7FQlFz/+D5jA==
X-Received: by 2002:a05:6512:234f:b0:539:9510:117c with SMTP id 2adb3069b0e04-539ab9ed82fmr677400e87.59.1728019069343;
        Thu, 03 Oct 2024 22:17:49 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82a2f43sm327874e87.186.2024.10.03.22.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 22:17:48 -0700 (PDT)
Message-ID: <c30c46c5-7f6d-4230-be7f-d7fd766bc1c9@gmail.com>
Date: Fri, 4 Oct 2024 11:16:05 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] iio: light: bu27008: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>,
 Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>,
 Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ondrej Jirman <megi@xff.cz>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-10-67c0385197cd@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241003-iio-select-v1-10-67c0385197cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2024 00:04, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 41ff93d14f78 ("iio: light: ROHM BU27008 color sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


