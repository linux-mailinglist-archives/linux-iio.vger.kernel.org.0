Return-Path: <linux-iio+bounces-7664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F510934405
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 23:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1204B2412D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921DD186292;
	Wed, 17 Jul 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJUzvAH/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657C4688;
	Wed, 17 Jul 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252190; cv=none; b=tslzKC09W8qwktBuM7yYNzG0LyrtupK5NXKW6k0XsChIc+Q0G5CskD7Snqyy0vmS07sD32NwwjidzxTp/oK00qRb1bUEMUh8P1S0PdmJp1jJgSxwDv+ETCkrcvaBhRUMKXNU3sN+l10iQC8AoDfTYzONlmZ1+Vrns60vDOPqhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252190; c=relaxed/simple;
	bh=6nQ1cNwZsUWdVdIzNLMx9HvD8PcLR/VrrWA/4HYZEYk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GkrNePwp54Bvw7KOxkJ3RNC36MHX1NvPANGSf8lhc+vvGVUfYhBMJwlzh906uv7YYaL7SwORszUbUNZLK4MDIKlq02zX3lFGZaT5a/lJuyTwGjSXW2jD+61MxMRnJ37IgXKJ0cI0v3BS4I9uMPaINb70sxJesFobiOVeGR1cFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJUzvAH/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so920355e9.1;
        Wed, 17 Jul 2024 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721252187; x=1721856987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nQ1cNwZsUWdVdIzNLMx9HvD8PcLR/VrrWA/4HYZEYk=;
        b=PJUzvAH/DcznKQGMI69WUCurhBEbZeJueXzCDzAmsEqn+fxx4ExFwmWSV/XPk2xJ/G
         uZSJ0jiqHYHXJJAQARKWpJ2mQPogNBDRQr4q+94Gt2ZUhfrjQ04nLx7dteQ1wDpDp4C0
         zgw6dSSiTyTbSu857/JuM0M4gkp1CJkdj2LM5XZmi+h7AuXTL3E7h9jNVCdav5WWeLM7
         pSLNiQ7Ayh+GjOF827VTGVRH2qG7CN+TtOo5VFzYtRA2dskRmuMyKnqQsar+PMgfvEXA
         rPrV61xyYrPd3Z0+88TbDTNQh55sFEuzzYUWN1l5xqusi7s5U8HFkqHUCvvlDmFgMZIY
         mKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252187; x=1721856987;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nQ1cNwZsUWdVdIzNLMx9HvD8PcLR/VrrWA/4HYZEYk=;
        b=ViT69ZK2eZb9tNxcRaXZY0IvK/MXw2m5bWTrR177xAXoEtrtd8O8RV25rvgLb5qnAB
         YBAB3Rc2hFFlofyXJnye9EWLn6vENXeVvkzv1pFKgt/zZthxF0j73yqEusKYAFrM3xaF
         yArf2EpOF1f+98xBlbNHOa46lUi1hBv1XKLIcOHBbPQqfwv1nl1qYnyhhcRlK/evJGJ0
         QzgsE/3OIN7ZPsZcWg1dI2fqjyu0UrchsVUSTAbdsA3PlStB3JvgCdiOQZKJRYDVcHHi
         zpnT7NUt/OD5+cafulmU8KkkxoSkRMu5KS6hcbmJbO0xEk0veljRswHcCGL9ORrNNmqp
         BTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUryce2s+DuF2CpeS56Xd+5HbNNvCnGFx9EZTu9JfLoKU43vWOwtY+WTn5tNo9UseLx4eyGkMck/juVDvZrb9FCIru5XF5/UgexQYlQegt4MJHLQKLLV3qXPOGx17pxhCKpVGjjL6jnA+g6rb0AKFreu8MAUAs4IuojKK3g9rB/V8+KIw==
X-Gm-Message-State: AOJu0YwN+OA2y8NMQGY4yBIGU2QOMziZNYExAJ+XaOzI/49uI1ebyRrg
	EUN2sYvEDqBtZcXIMfJppf55kQCjwhi2cIrwIjTc8uXSsbRrsXBh
X-Google-Smtp-Source: AGHT+IFu2j+EI7GNZzkEvhjxMxSqj6CxnoSfkyt5uDS+NYKlKsmFFZHxzwhiF9Utib4aIbnvJmEgeQ==
X-Received: by 2002:adf:fa03:0:b0:367:963b:ab81 with SMTP id ffacd0b85a97d-3683175d0b8mr2030393f8f.46.1721252187105;
        Wed, 17 Jul 2024 14:36:27 -0700 (PDT)
Received: from [192.168.175.190] ([5.14.159.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3cbbsm12556663f8f.17.2024.07.17.14.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:36:26 -0700 (PDT)
Message-ID: <f124064c-b9cf-4460-b4c2-f918b591a31f@gmail.com>
Date: Thu, 18 Jul 2024 00:36:23 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] iio: adc: adc7192: Improvements
From: Alisa-Dariana Roman <alisadariana@gmail.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alexandru Ardelean <aardelean@baylibre.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
Content-Language: en-US
In-Reply-To: <20240717212535.8348-1-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

cc: Alexandru Ardelean <aardelean@baylibre.com>


