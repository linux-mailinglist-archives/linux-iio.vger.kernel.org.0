Return-Path: <linux-iio+bounces-15042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184BA28C12
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B20E188990B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC781591E3;
	Wed,  5 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuAQKhFZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC613B2A9;
	Wed,  5 Feb 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762855; cv=none; b=HZckoaZFUYoNCE1/Qg40UXm+B/nZ9fbQmm+xIITKc98/+La91IYm9zSDgMPvOHJZUO/NTEXWhEtx+zK/GrS9PViW+y/z1Iv6plVOj1xA/6WkJ1r9xaCz6IX8MRjOtZqfcQno8vOQD79WJgMgVA8/Iu/A8Y6odIlHHy2iF7aoLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762855; c=relaxed/simple;
	bh=OrkzGdY0sumfkhYTUq24wys73oL8oitkJ3czLXYp+xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBLRksdeGu6Tl8fjSrZ6f80Vbrh78X80fjp6GAZQjunKyMUDV5OIVostBnyyWojR5m80Q1AZvwuqizTsie0Gt8cM9DkhXVkmUeMcCWp0Pc7pkuqzWJF5gbXse085uJ4XYUbPcahPzn/NNSyKF/orPUiKVuahuKP5O/WgD5O3qTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuAQKhFZ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e3c47434eso1796140e87.3;
        Wed, 05 Feb 2025 05:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762852; x=1739367652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GN719TuoxO4YsIOjDnajbk8vtJPTQW4i4hIOs0Rj4E=;
        b=QuAQKhFZ4yznxdSo6TZUEZL0TVNt9Ky8MlAH99qxYfhpvlr813CcrxwtpQGD7wi6+l
         h3P4uQbRyKG9NwiTddH9uFHIRbMvTdiqBSDoI1RrBwxPj9QfWdgmNCexD3YNS4JTuhLZ
         di0Ef1HuVviiYUD+s4mEwiRptjnll7eKKjvYyXhlueyjW0AM0IGISsmwpFWh0KbeXKCX
         WsDPUSv7Iqe1FvzB7SoBx7DuDy/tyRQ3f87b0yHY+EsAy92OI9iLlqenKvrADPDekuJa
         BAo5xW+l2EckABHHihs/I/LLBo6DMMCjiG5iPK6OjLhN1xFwlmSHcXDeSg4WBab7dq4x
         uZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762852; x=1739367652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GN719TuoxO4YsIOjDnajbk8vtJPTQW4i4hIOs0Rj4E=;
        b=YOHVKbxM5kfWUemfSa6UkKetZ9gkAlbIXSJiW7rrraRAtL1N94O60z/p8YwM7/fdXC
         KLuKL7N4gGkbfEzu0R+0pugjJf9sDUNGE3QmqgEhI2MKtelipPv2qGtsEjMoQIA5pAxy
         X3yZiEwBIpJHJS+oOKWG9wiElOmwZeGVSNaEr7TqhMG1ok25YWWqls7Z+JGzzzyY1ItW
         0C4KceA+1/EuLeYBnxiBtskLAZOuq7G1Drjb6uT6GVs2xCntDCQEzgjyzBb8ULCk0Hj6
         2J/s775bMhhHWviDyEY7FkvUyR6qFpiGrwvJIvYwjoO19s/sva9ZHJ6/H/KXTvYFuyNE
         CEdg==
X-Forwarded-Encrypted: i=1; AJvYcCVGjhsO5038aJ23VDh66r1cA+ufs0hah1dK8qp9oQuts1+js9yeaq6caBttH3Xv+7Su5wk1qom0U10E@vger.kernel.org, AJvYcCWAj9NMK6gh2Z379jjvScxInJaR9Jiv+D5/v/uhrTsPP9WaIjFhElhNHv+a2jnnzFBvqEcVXIERmX6gy25T@vger.kernel.org, AJvYcCWk2PJEFwheLIFGzu0W9xgkSBmFNcaR0xPCa38kq1N2nLMkgIvtt40GA+va+5Y8rheEwavEa/tjYzIh@vger.kernel.org, AJvYcCXuqroNw1uNt8KOXeRb2TS0kFZ1fJu4Kybo/3ACjfhWvyVkcozteM91OXLv3s05bbJwQcUkaXkbeUZqRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrX6uZdlcCHkwst1fKjA1nRl6bWallIv5oxG2MXwIJyfDMZBNa
	T1MoQnzZ/lg9oyS5tSthWRiM2LPf9NpPmIbS+Xy/VZi8DQHciZDo
X-Gm-Gg: ASbGncsIW4XeDWcsBXG6DlKEzxHiKvlU4V3dPwrgTG+w5Klo5VhQ4+Ge6jXGrCev7OI
	3524SvUGvTxS2PDxRQgfXgNJCNRfSuYOdlQEkocTYeoO8w82AS4PjcNjZ13KB2QMZrvfVO8UkRy
	+WHMqGqX/BiuWbRIrwy4Zs6lyzmSS5+LqaPLTZxdwjYk99acHbNrI13wKcrfjIhOmi/tO4dHGcd
	uf7dmTE42yZEsyKHQP/h6X7oTNABN4aQGUqqBfmegZ3CeDfwoO5yjw3mCkTcKAOAjXFkaVBYAUi
	XFaFAhJr1eYnDz88LeIuoGl3HEec
X-Google-Smtp-Source: AGHT+IFinl0i3936BDhu8URCWoiB/j2p104Vei7TF7Cq1ZQvV54Nc2cSrbElXy04Nhn5nrpvuuDpDg==
X-Received: by 2002:a05:6512:1044:b0:540:1d37:e6e with SMTP id 2adb3069b0e04-54405a438a5mr888379e87.33.1738762852017;
        Wed, 05 Feb 2025 05:40:52 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe10319sm1873509e87.66.2025.02.05.05.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 05:40:50 -0800 (PST)
Message-ID: <6867812e-7269-4686-9fc2-55afd9fa91bf@gmail.com>
Date: Wed, 5 Feb 2025 15:40:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] pinctrl: Support ROHM BD79124 pinmux / GPO
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2025 15:38, Matti Vaittinen wrote:
> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The AIN pins can be
> used as ADC inputs, or as general purpose outputs.
> 
> Support changing pin function (GPO / ADC) and the gpo output control.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> 
> NOTE: This patch is not properly tested. More thorough testing is to be
> done prior v2 if this pinmux approach makes sense.

Just a note to reviewers - I dropped the pinmux from v2. No need to 
review this any further.

Thanks!

Yours,
	-- Matti

