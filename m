Return-Path: <linux-iio+bounces-14842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C113A24AF4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5814C1632DB
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64211C8FB5;
	Sat,  1 Feb 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkOCJJXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A85AD27;
	Sat,  1 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429987; cv=none; b=IF4gq+U+SoEqtMGhrt6IJjuotS26JeotTU2p8ZJ1tHFGrGxBjdg1jBRj2yTg4pT38BEaZBkb3kJ2SXp4+UCVKKjfz7kNrXxvgFhQjg62+sfTxqutYS7+xVB+2Kh2T5v7TArSsVH7dBOFOUNaJEbkO4lS6XzLApJhj11E42oW3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429987; c=relaxed/simple;
	bh=ZgpLENp2T47kA9bzWkanIuL41p+MuHv9NzVMyor84Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckHWrrTtkAEeDDyMfhA+N2eF7PBVbSUkaFQ+orzyCxfHLAqJQZ1Mhl66xjtkFRaP4FHLaim3OV+48d4/zLkXpe5zY+3We1ZkMcFbUXP9Loemp/Kdc1mQHzVjCK4gASe8dFQa2raRTcVlrvfUvAiY9BYDStsm1buGflNgr9hVwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkOCJJXN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54021daa6cbso3228058e87.0;
        Sat, 01 Feb 2025 09:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738429984; x=1739034784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K0EqS/vi4s3kTIfhJVCkKXeeRA4qKMD7JM5EWUMGzk=;
        b=lkOCJJXNyCFSQHLqphZ28hulOIG4JwdnRqPZ3B0LpJWeVrrlUo+uqur3BhV63cGk6F
         C143KdpENEOJt1CYKDtD0FqcpSxGM/OO2B5Tm+2jwm7h7tCseJGe/04nQzTdb8KoII3T
         /y1Gbm5Ef22pYyiW2WsFmC5IWaMbsvVmLelAVVtnhC0OzB786fifXr/+8D6RLAqO97Jj
         +bzYLBgVJNfBEuJq4AhBcRyZp9tpH0ZxSTE60LB+funpYgzN5gqHsQhzyzhDMelOEPbU
         8g23f1fUTdVu5kZinWvMZy3+uuKsJepDYtKRj35jBBFLk0Aj6y2qNV2m0eGYsLkmqxdy
         1TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738429984; x=1739034784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K0EqS/vi4s3kTIfhJVCkKXeeRA4qKMD7JM5EWUMGzk=;
        b=fMZ1CuECC+SGexBl3PrXXEou33641cG6O3GeWpMmqMlm9SYZ+TeReAGfOAIgx+lRmi
         cKq9pVZgjt8TZN3mYEeOwiAzfGJt9/THHnKO9dheLz1xL0jo4fgVtX00zW5ObEGrzTeP
         AHFqeg5wGKY4cJeaTN3E8B4lViKJc/w65t4a5X1u2hzbeqDlrxADGm6VxDlkd8M9goT1
         4gkyIdFomJO9hDfib60FZVYsk4ViRmD4Li+jpA+y0bEtQl4CwEraw4bU/geoGqJpS6y0
         ZhYPr3IEVouhjcGWK2yNwHccPxX8EwelvSukEEION/HWKiuN9tVVt8SHyDKUdMkIlYtX
         A9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU1mIz+P6BbnzaUPC4s7NM4ulj0A5xQgvmKZXQREp3+/z6m6xQHw0b+/NQhWxwCLx5UV5b21rzzcE+2@vger.kernel.org, AJvYcCUpZa/UnTDmP4EAbycOL7NfSlR3lLTHNTYH/nNnd827/Lp3F2NZFqn0AhmN+n4ZJ1no1ZsLGXVpBRitMV5x@vger.kernel.org, AJvYcCVATxPhsAFHjezHqyEEZojkste8Cc256SOf8fGo5p/AIYdyR/8RExDblo5+6Iyz49rY5zdHkFUox4pS@vger.kernel.org, AJvYcCWerZkUPVBtD2R9Pxjj8kLOwU2yNZhe8LgZ88sA8lLOIQlXlHq6+dYnViJNBRWTJehitJtlwlD5QYzAqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyfD2Hge/4r4krSqySBesHVipWByOOlLTjE9YblqrfO+nEs5M
	rA03AkFMZ+x7UcZM5JtjygENEU7y2caLfRQDKaCZ4baOD2nlHdft1L1HgQ==
X-Gm-Gg: ASbGnctrRF2IdanLKlp+uP9lnOnQIK6TUAH70G8HgPih9slXla9ZyDmU56s/g8cAJN4
	C8/5n9yh1oXZplSfdHJYSOIwuTMpF4SEx0xVQgWdT4tiXjr5ah7q/yM0B2NCyu3ytRndbBnFST8
	/+d32iVsZbO7TXxa6FZfFtv+W0N0++ZL+8PYDK6CZZHvbnw5SivWk/RdqhjMDZ10XI8KcjK5JBk
	fZ/zVVSgGQk8r9uiSzZDWcSDXc1MP4FtnjfUUumCvxlnsmnggTTioRUO88s/TsDAiBE/Y3sT3wZ
	qUE5Zx4J2KmiOnIknOhrKdUqJuuhV2ttd2ujQP03WiobXsrr8KgaUasS
X-Google-Smtp-Source: AGHT+IFoyCfmxJJGD5H8LiOmJTOE68QwGKbi5E7qU0uTk0aNzZcpk5fbdX/0inUZd8X6JzC+9lcryA==
X-Received: by 2002:ac2:599b:0:b0:540:2543:1b19 with SMTP id 2adb3069b0e04-543e4c02e0emr4577702e87.24.1738429983420;
        Sat, 01 Feb 2025 09:13:03 -0800 (PST)
Received: from [192.168.1.110] (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebdf100fsm793370e87.9.2025.02.01.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 09:13:01 -0800 (PST)
Message-ID: <9123ef67-2c93-4874-9d71-d2918086ebd3@gmail.com>
Date: Sat, 1 Feb 2025 19:12:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Support ROHM BD79124 ADC/GPO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <20250131170840.00002dc8@huawei.com>
 <5cc01bc7-95b7-4a58-86d7-d4293e0e9966@gmail.com>
 <20250201163051.1d54cdd7@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250201163051.1d54cdd7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/02/2025 18:30, Jonathan Cameron wrote:
>
> Enjoy the rest of Fosdem

Thanks! Just watching the live streams though :(

Yours,
	-- Matti


