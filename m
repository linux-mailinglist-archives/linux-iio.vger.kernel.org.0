Return-Path: <linux-iio+bounces-23301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83CB3658C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCA61BC581B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12A2FC01F;
	Tue, 26 Aug 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P5FDo8Ic"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E028EA72
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215780; cv=none; b=OlfFjQKiXq0SesJQfz7v4y3xlcOBDU8iatY5XqJ1jLzWb/waNrg+tZd3rrDgyuKeIVi5dr9cFihfDs6bQW4p35kd4vjgVLJ1KIH9bkfvStBYWrNIuR6jyJThc19YFJrEqsI6dqEghPLN7vtpMEbpvkVE/hXbpR/sSzbWm/5/C+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215780; c=relaxed/simple;
	bh=IMNmI65FVUCbqdK9+JcQuv1rtH/SRuBK0q4ZgqSMeEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YEd8NjWDvPt3Dwl6dVNUrpXVZa16EVLKnGcwFIRaIAmg/oOEOS6WO7FPF9s4SplwUgdQ5JPEelh8syF9kh756IFKz6Y/9rAgqlzTVvl0AXtCqd2vrBgdl4Ft0FM+1d+OzNmeNBdbX9BUz9NvN62Sj9pKxGj+MUOLWiVAZP3m2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P5FDo8Ic; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381ff668cso3135072a34.3
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756215776; x=1756820576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCSAaSZeoixOuMj1nuyEP4c108bz3Jb04yCTbdf3I2k=;
        b=P5FDo8IcsRn2a8V/Kme9fyG/EKymZKLzBQmdtMYb2itTY7DKOlOkZ96w3+obLG+UK+
         dhPmhgHPSoeNRR3AkVVuE9FkwX/WrbXKcsVvxdbT8n5jrUuEx0rRx1fMHd5c4FUlAJoC
         IZI9zaKCQtX/VXVZtkfsuhPtHj/FemaLx8V5Vmf6YwZ6lwrIaT9Z18VzedY+ZMgO3bnh
         aQ3xAsznGqlAG+xhpEqRgSPGLULLl2O/3IwaGmCyykm9nZYySeCt+hX563WvgAOeu2gX
         71g4whmzHpjZJ7OTqXP7g7h44BLObuuAt3c2sj1EA58mQZ9ZTixlDet8+AC+Hl/llM4/
         k62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215776; x=1756820576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCSAaSZeoixOuMj1nuyEP4c108bz3Jb04yCTbdf3I2k=;
        b=CgPVTY+9m2/LGYW7qM9Y31A3e6kix6yApy40MWwJL3uSQkaCWV3kKGongZzBPBbnS1
         m6W/MI5QJ8wpKJKitkdQZ8YG6hc5EcJZJHZCquL2WwymUlnmuYhbbfZsl7ROj2BzmimD
         FbQzQY6AjcvZBRjQkKlEM1V/+uMUbvtdmxxErat31vm1WXaO66dWIHsJd1azua5rDzPP
         WqGPrLiUCoMwzprBHWuhgIWLzgArllZTPTmlTTg1N2IdeHTLoBWfAlf075ziea/jxhg5
         olUxBrdinz+j9P74Mlta7KM7UKBA79UMv0HWAICUHJP/brXoMz5TQyre6kg+83zTfpfW
         XawA==
X-Forwarded-Encrypted: i=1; AJvYcCXRgtacY0SOlwEanURqglYZKGIA1jkydQU5s5GIhwdHCL5juaQmB5+mom4c18VsX/lemPXhuIPa3MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wz6ReNLqqcN8TK5qvot136UR38kjI9DEPiiZMzn/vS7e2yoX
	f50TTrG33CsbWiy0fvGxXLrg/HzuGk+1e1Jk2QylmD71Kmj+TKCvru92a7gHurVTdfY=
X-Gm-Gg: ASbGncsndj71bCjpXJbBE+uzvg0ocVeTOfaOOwlyORK7Gl/oA7Edm3Iy9jqzc1hfRip
	EEL4j4akIW4mceZr/osRs+jVNbRGmXg3BPnTXUudpiPO1UYAzonzc9DXXWAft0fAfcAMDkjxxNA
	hVyxFCm/ZdmQkL+tNegQxc0cwIH62dmOIq9nJiztBn8V17gdOHsBwynaGaiqQcQZFUaMBsZEBq5
	IHkmEefqghPE/XyRkxa7Bt2i7Tst8ixUD5BuH7Q/CH9u3fPB9LUoJvWRP7swwh4CDngA3KYF8eL
	06KNzdHneaK6LAwuSk813yWmfIbMyazQiVviCaVkG7JTZLwlA/5I3a5sl5OeY3cmLlx2y58sUr8
	51J/bdKguWONBOV8N6QL/erzIfkS0TRjNep17kYNW2Em6GOM8uHHfM539WR48GYGFIB1YzyIiT2
	0=
X-Google-Smtp-Source: AGHT+IH6oPmZUM4auc6eQuClGqcGHr3sDngRnQiYwGTgC1rN0Xhp7/AEI77Wl05/zubuIG3oVUhsMw==
X-Received: by 2002:a05:6870:7056:20b0:315:26b8:8ee4 with SMTP id 586e51a60fabf-31526b894a3mr2347972fac.8.1756215775994;
        Tue, 26 Aug 2025 06:42:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5075:40f3:ff25:c24c? ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e4bcecbsm2335437a34.45.2025.08.26.06.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:42:55 -0700 (PDT)
Message-ID: <d6716d57-ed8b-4dcc-b16b-2528780a387c@baylibre.com>
Date: Tue, 26 Aug 2025 08:42:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: use int instead of u32 to store error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826101825.248167-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250826101825.248167-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 5:18 AM, Qianfeng Rong wrote:
> Use int instead of unsigned int for 'ret' variable to store negative error
> codes returned by ad5421_write_unlocked() and ad5360_write_unlocked().
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


