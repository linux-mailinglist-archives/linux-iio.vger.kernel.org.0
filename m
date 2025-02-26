Return-Path: <linux-iio+bounces-16106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F0A46D05
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AA018871EB
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6E2580EC;
	Wed, 26 Feb 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KLtrT+RL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FCB21CC66
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604067; cv=none; b=ImHfCsVgikiVFeYgpTijtoJhdD6/pHZS6bmbQr900lMMZ5DLDgDCfleUSCEQsDTQ638sL0gvwynT01oGhkkAsWl9a92tVbxa5h+ZYLf2Uoy7ioctiKE4mXYUvQ0YvmVOex5/0Hdzcs7V73glaM6jHrsX3dMZY3SshJJ8waAMnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604067; c=relaxed/simple;
	bh=3gNhjM3yKm0K6Ah9xUBppNQkh1jUAuqUXak4kK0YDAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuknJbdxbMlVpqtrWp6gd7a4kEHhukeVkN9/WjGu51ehUk3oWNzx6vGvPSGtkjL+8Z6YcxWXm1DOH+WHbwJr2PQdDrD/O0+w8svNYgmh7eqEggR9+bfT4ar4GflIbo4hrCmjriCyzJ3nUnhAYYEKLoYPpVSAcb/YoNs7v9MR9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KLtrT+RL; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f3f8906c45so192453b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 13:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740604064; x=1741208864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KK1tuZqXEYAuGWGI6cUSPf3OqgxZ66WV1IIk40XRFRQ=;
        b=KLtrT+RLHDIczN/2UAclKv3sxqOp1Rnvz/PgwHPHmZNBUnRxBWxu3PvJx5Pp65xwSJ
         K+EbJg9us/3o+SXuTaTmeiYVR654XHl7V2ESSy6L88IFQtbfUSAbZES3lqlTMapgfTKN
         +nF4oXo/ZTbsX1FygzYPyzu8YcY0f+alBHZDZugBHBDvSrDwv+PAe580xEqedy/syYfC
         t4Vv5UKQ/j9yUURs4856mdnmW7xeOpxfCQ08K9Vq33sJv5UYusWsVTiZnHYte2v6ptGw
         YFdIxxN0mpzdQWecx0qTxLArfc1AiMMkUI4zYRbgWsyCxCCfhD6HlfrW7DwihrJtRC9z
         WUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604064; x=1741208864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KK1tuZqXEYAuGWGI6cUSPf3OqgxZ66WV1IIk40XRFRQ=;
        b=PICFZKIedRIo8HQGb5SV6K2ZvcRPLqjPx6xc2NLnrea6p89IDKxqC/9QbqSQUZQd3l
         KFHe2j09eeBOhXVTS+spLkbw18xZxQZDRypuIXIqaCf2OVaNd8zTxqt11Z459YDeTfAz
         nLDxjrQQhwwRuLjVN84uyz8IUYiU2E6DH5W39dlq0EmmvBY8dAFRoKGhjmlou0yb83RQ
         9O+CZLy9xuFZIlbhrIuCAjl95ZtNWYoRFQ75qKmu5mxq80dIla8mg8XhovHwBNlCNmaP
         1oi89HbOD8In+WNxpXdbkAHDKWZEJrUmx038YwyXHzJlTL0hhCzFM8Zstou/Xtit9fQP
         2SYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtSJySXnCIBa0ozO0ZuXW7Fg1pB64053j2jdeCVQjTbQjxDlFFIy6qKjq+mDeCOr85j6Hhp9wLvj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrnzzgiRySvVOxoSVoshAsPmOsuwLFQS30rerWrK0ftmAwMNS3
	gNzajTwE89wzc1oxv54FuGYUz2K3lzMs3Gdi6KMQHqt7KhVDwv1PG7T8Z3q/yho=
X-Gm-Gg: ASbGncuQj41eaEBo08fMPhzU1lPz6Hdpoo4tkjHiNoi4cU5e22f4gMorGKmwYuf7jhZ
	+DwBRJOKNawUfPwLObWjkqvSce94tBx0UJ/7NQqK7Fmc+z1ZfymT4XRt+CkuXTXuHrQ/yTaych+
	zxOrqcdE8tteCcBl2qxywFW+9ZjYuLCv0MybNmsaJMuaTz0dLCFjiQnOgVYi1M6f1pRpjm3EbJr
	B/rMPC//t5IOvxnfI3+HHjyHUprQwvxU7dIBZXLHOm/A4zITYOyanwrLRiqVvVCkAU4CcztkY9I
	yp3xBaSH6XJkHGI/b3ed5PUTqArNt/nj4ba0dHDq+Y2op4CldVu4AbIcUg6I5mY=
X-Google-Smtp-Source: AGHT+IHssznl155sIKLS2/z36QzUbKdpoR9TisWcZupZqKI+AgB0MKw9+XKqfOAHyCzSuYMlO3Iehg==
X-Received: by 2002:a05:6808:8f2:b0:3f4:2b5:4809 with SMTP id 5614622812f47-3f547e3a527mr2408127b6e.26.1740604064569;
        Wed, 26 Feb 2025 13:07:44 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaab762easm26979eaf.16.2025.02.26.13.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:07:43 -0800 (PST)
Message-ID: <a49c451d-65a4-4a59-8099-8b88bfc8b643@baylibre.com>
Date: Wed, 26 Feb 2025 15:07:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] docs: iio: add AD7191
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
References: <20250226115451.249361-1-alisa.roman@analog.com>
 <20250226115451.249361-4-alisa.roman@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250226115451.249361-4-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 5:53 AM, Alisa-Dariana Roman wrote:
> Add documentation for AD7191 driver.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  Documentation/iio/ad7191.rst | 129 +++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 131 insertions(+)
>  create mode 100644 Documentation/iio/ad7191.rst
> 
> diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
> new file mode 100644
> index 000000000000..6ab615ea457b
> --- /dev/null
> +++ b/Documentation/iio/ad7191.rst
> @@ -0,0 +1,129 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD7191 driver
> +=============

In .rst, the page title really should be a different heading level
from the rest of the section headings on the page.

> +
> +Device driver for Analog Devices AD7191 ADC.
> +
> +=================
> +Supported devices
> +=================
> +

