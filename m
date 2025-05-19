Return-Path: <linux-iio+bounces-19691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCAAABC204
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE84A2EFE
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07F928540A;
	Mon, 19 May 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p23ZQnAN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472D284B33
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667737; cv=none; b=HLro5Szo6XSqLFYmRYiO+IQLfAC0Gx5pf24PILJDdG7MevYA/nBaSMHM/02peUv1aBb9Og520ozP3c5hDQcerylCt5yuFhqdWdsJf5ao0OxgwyHPlhO1lVeKsB/zFvysuu0R3S6w8o7fif00u0rfqG/HubKy1a39UIas+V7Nlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667737; c=relaxed/simple;
	bh=7i0z8dkp7Rwv38waMV96QXnhG505dF5lZuodME1r1go=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B7zPzcp3DidEZZMhx7PzAwqTOwCHnYQD7eoU13ALAylwIwW79PzBIgHuW6Y5RBws0BBVMAo2YASAwOr9V1+Sh0N+XU0+B4AdyD/ODa1Usfyr2FNaKxc72bdkcAANsw2BiJPqjVKIPHSUjGxNmnloP2LkY+AfjbbAc+s2fmD+aBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p23ZQnAN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7304efb4b3bso2975329a34.0
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747667735; x=1748272535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJGdgARxukTLZl+ZyZJmv0v/UH1pE+9UaVbHtn6qyms=;
        b=p23ZQnANNFxiZjcxgF9i47sULZd+nGsQWGkYi78IqP+M9KrCNAtyOifMUUKKoEF0ac
         DzcPcGE/ZmfNpOtaNcJ8+/0mdHnpDT6upCBbMnLSJ+So8ZBtsrGyYhd8ivdWNl6C2XOw
         wbIlMLF/S8oLuXiLNbquMdZT3jkwXkSQ9NfZJewftZBlasgvd7ueMidBDl/dpVV1tP+z
         4UQX95oKbmRyjQZHEIt72qBnK9GMeTQQ6W7SFDag/JAVnJs7DQQk/0l23M6gpMqMk5Cz
         d2gGvHf0ivjiZm21y8Dt4pv2UitAjQ2AEIdMChIF1uqhm12B8XSZSIx57WszxVrjylo7
         ligw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667735; x=1748272535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJGdgARxukTLZl+ZyZJmv0v/UH1pE+9UaVbHtn6qyms=;
        b=Ph5YmH8fO1fxn78H2Ad1mUpqGUCQ9qH1QEi2sxHRKNycnjGrhX5uvA4mCXsyfZzzzL
         FMNN0gHPsCDWGciybtGBUhf48rOXJrDySCE56cs/TGR73hamTasKCtAO+SJGbPmGymNo
         +qXnr2epep+fxIQjPXJxGtW0Cha+xDFi58X2FM9yz+F291dFDlW89+BH4bP4FPi38uGi
         a0L/lpvnrQVOPsq7Ze8sHXEQed6nequtjy4wOVg42DT7va5t+IjzB+XXtDPZkSnadGua
         +ojLkOL6h0f//z9PpUa3PU2PAxe/xLxH5dJu1xvhEoYVaI6C5i10x1OtwjJVUjJElznE
         /IoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYFsEiRaxCRzB4MVNaqmB9EGv4N9R1sqU0zAkZfsNVFmuXHOHq2y9Dt0Grbq5GrcosRtG5+3SDy1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyyapyo7i16WWlUbHAsw9+0zWemZuTUbEVYjux9hq+vP1xJpp
	hVN65CdCquCMAVGSbeiVdC4bI17gjsW/YzBeVSSvLk2pbo8MhWPAkzI/zWAqKav0IBw=
X-Gm-Gg: ASbGncuvy8yya6PBme4ErkIR/tpeThrszqtAkTj9opBWALSCLMEOermOyMcOvmxV0l9
	vV3mg96dz1KxWWjar64JgZdkXATdxbIzxvcQk/yXA/Q7hasFUjdIDFXjljq/5TW+3uNnG4CGIVq
	VMBOxfjKJxmSe3lvH1A2UH2h0dgp/79SQrxU4Jkq0XxvAnP3o+ZfCpeVmEYTrcLnVCDPHAA7V4u
	JC/aZboqwwhNuCtfhS7zO++MOwzV7w9pN9BZINOP198HckueMIfH0m9nCfg5h9vcpkjeDZ7LCzs
	gLGPpNzCGwkOWV2fK7TfmHQ5RnGa2IhKPUKYKJRFj78TezlLfPEgea5X0LhTCzN4+vrBCraMMSj
	Sfo4K0XPPmwfIbDI2O8dEiXAj4Q==
X-Google-Smtp-Source: AGHT+IH6Fik1SZYN5QOy8Bw1FWgY0vjMNTWd7AkwjVQ2mOYKw62zzRRz5BNUCHUdDCUwYb6OqvRO9w==
X-Received: by 2002:a05:6830:6481:b0:72b:7faa:93b0 with SMTP id 46e09a7af769-734f6aad6bamr8417490a34.1.1747667734957;
        Mon, 19 May 2025 08:15:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6a4b0ccsm1443928a34.4.2025.05.19.08.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:15:33 -0700 (PDT)
Message-ID: <d40df6be-53d6-470f-b93b-520e21880c18@baylibre.com>
Date: Mon, 19 May 2025 10:15:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] iio: backend: update
 iio_backend_oversampling_ratio_set
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
 <20250519140220.81489-3-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519140220.81489-3-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 9:02 AM, Pop Ioan Daniel wrote:
> Add chan parameter to iio_backed_oversampling_ration_set() to allow

s/ration/ratio/

(This is a good commit message because it says _why_ :-)

> for contexts where the channel must be specified. Modify all
> existing users.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


