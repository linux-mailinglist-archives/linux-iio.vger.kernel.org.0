Return-Path: <linux-iio+bounces-10099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1B98FA00
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD2F1F23B63
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 22:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E91CEE8E;
	Thu,  3 Oct 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X0ijg2KR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507351C9B68
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995452; cv=none; b=ms5U7MdQZ/IIFOTvD6/J51QoHoELMZEqCf0gGSOfDfQpraIW0zC+9oIdgObr/Fqr2XaqoQ3AzIfu37t5Fe8c0sUm4YiYeyetnYyZ6JBJfH6dbfECluUhArAedi/nwONDZOCEYuUjUCKLxpifXj/yPV42e9jvvOmm94t4Bc8dtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995452; c=relaxed/simple;
	bh=kVTFIVwlbHy+PahJ42D1moY3n1ciO1dOnvG4qOf6CoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G00i8L5yR/uGwheOuhg8LgA8+g29wHNWM5b0aQfYro/Q1l2oKQw9eI86TglDXw7K6Hb2cFtHrhGtGGzhQ3DLTUrc++SwWlQv5CIY26U7zNM5As5Cv4jrITWq64AayBw/ExTD+0w+wXnVI3I7Rb5QbcHmAnlgq47jwoYigjozkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X0ijg2KR; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e1b50fea4bso746391eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727995447; x=1728600247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4sIfYmvEQ0fXK3kcNKbbuFY/VzGs8w7xUM83WsF8Zk=;
        b=X0ijg2KRXFC/biHcSawo7V6GiIVZexQoP0jXbc1xC6cg+6XpogPWUC7O8RgMLiK8c4
         bDa9xGiWerrC9v/kA3qxxoBnK2sPHF3PNhWz/gzVMYUtbu0JOucxsf66PzAueJxVoVbg
         U0TNJutQ4EMp4DY//vNzKD1dNLh1kdfNX+Uem/cGr8PixMd67s8+GVDDcizgQAH1+X+c
         cT0XqC3Fqklqm8LoF0+5cIVJ2CPEy5PbOhlXgGfRjpuUjFe3yyNkw6UGjYw1ueMJpcHN
         3IVGtd55IWLvrzK2m3FR5BARnU+USOH8Uo8kCkvV4SsZyS+7swiDdXZ+4Spqu3eTKB2r
         u62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995447; x=1728600247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4sIfYmvEQ0fXK3kcNKbbuFY/VzGs8w7xUM83WsF8Zk=;
        b=T9C/Jo9p8QySJBWSX+ulHcRFMOhZo4WtCuYTmFc37lrqYzdUW8rRmhyT0cwFwjtQ8Z
         4ph3ZJpdbC9ODTlcs21DM93rEZeehaNdHXYehjHeCxkdRfH8zQDLZ3/EWB6HnVIsZZFC
         wNJuwTaKLmGjXgPKqNieSyV13mlv+2cuHWl2zwMr20oBea9BPusUVZFhG37cLDMzl8z5
         t0l/z+XvpHJDzzKrB0gA8huWzRuFxVSIAF/5RM7VlmgrN0Ej6n+vmKXut5PkCRaVAJ3e
         /hAla58vDahkI5v2+llv94Eo8QOT5+90jX/75WC4DAF3Yg7uWNToKwBE4jSY0paj9A+/
         bAtw==
X-Forwarded-Encrypted: i=1; AJvYcCWzQptTHUnvI1weZ/DmRpw7S7sRmyF3j5v3BwQAiMxJN9uBe0JQy7AOtiK9zVR4D7Du4/Gi7Ke3szk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5smk6At8maUezeAX0sIwp1RJ/JzDcAZk+vpPnvPUtTGycn/x
	8Tbl3QJ9FxpLixqyCDwL9B2xg4Pxsng6oSSEZ3QmRJM7kaTJV9xoNRknQJ1CQYg=
X-Google-Smtp-Source: AGHT+IF1uyUXuChsEkA32m6Q9qC6BH/pjnr1Nakuj4vblrPqYLHOXbVoOwG0vT59b82NASlQzoMRnA==
X-Received: by 2002:a05:6820:168a:b0:5e1:ba38:86e7 with SMTP id 006d021491bc7-5e7cc0a2bebmr442362eaf.5.1727995447367;
        Thu, 03 Oct 2024 15:44:07 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7c0edca79sm597380eaf.43.2024.10.03.15.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:44:06 -0700 (PDT)
Message-ID: <a322e7c6-2944-4159-9632-bbccdc0b56fe@baylibre.com>
Date: Thu, 3 Oct 2024 17:44:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iio: resolver: ad2s1210 add missing select REGMAP in
 Kconfig
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Cristian Pop <cristian.pop@analog.com>,
 Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
 <20241003-ad2s1210-select-v1-1-4019453f8c33@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241003-ad2s1210-select-v1-1-4019453f8c33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 11:49 AM, Javier Carrasco wrote:
> This driver makes use of regmap, but does not select the required
> module.
> Add the missing 'select REGMAP'.
> 
> Fixes: b3689e14415a ("staging: iio: resolver: ad2s1210: use regmap for config registers")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

