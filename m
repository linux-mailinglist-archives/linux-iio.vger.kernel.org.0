Return-Path: <linux-iio+bounces-9386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EAC971ABD
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434B21C22D54
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005B1B86FC;
	Mon,  9 Sep 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vQ4ch1Lw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D31B86E6
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888048; cv=none; b=mLRlbOIpQmhFxSGZOBqZbBk6S4CCUJPKwebS1WOOT/jIhWQXXRrDyNYBEV4tWsCyeaKITPs7odIGdW1uYOO8DX0/e0XBS5BjIq2lJH82ZDm5HpYvb+HThZ2CJMqoEdiwDlV3yO2YI2oX3/y6/CCUX7HK1TA5lo48BvCWeWd8ejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888048; c=relaxed/simple;
	bh=funbdZ7K3B2+UFHyR9wWdMOsW0n+5ztnXHtMLhU8ypQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpb3kYttNicmoJZapBzoN6JhMPQ7e1GGxZY1Vi1LCoNBAux64aFjSo9A1vyXJ6qIZmCT+Ci0vEL0PUkAvW3osPiojmcczPOXgqRVqfScueSkzvrRqqH5vfyonFMpZePrZ7h64eLslWOUfZjs5NBR2L04sT3aGLTELdjPTuHo6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vQ4ch1Lw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45812fdcd0aso22697141cf.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2024 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725888044; x=1726492844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=funbdZ7K3B2+UFHyR9wWdMOsW0n+5ztnXHtMLhU8ypQ=;
        b=vQ4ch1LwwodgsYVcX4Vsry9p0aCs6yTDzTXyez9m3eF/rODZieVAp1Zin/LiPcTRS6
         bga+CdEVhJjD816afCmx47qnl32WwDjWlX9zgemRPveasSPO6HrlP9HOAtd8j+70NbF/
         vhnU3RKQAFfHdOSD29/GgGJh0nneqkJJ2a18sa4lbPhipWS3VSVFUURHCqFTxdHGnLJZ
         WYPVZq1KthfXvroRS3EBeKG4UU+jimMLgqttRkyF4jq4CL9CaCo/oRLJtjNfJZJVEgrh
         x9kiG9IU3D95EFTYs+V8Gh9ypX1UKjxcTPlf7LJISMf/JkA9dPVoVSK7hqUODgjl2i77
         Xk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725888044; x=1726492844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=funbdZ7K3B2+UFHyR9wWdMOsW0n+5ztnXHtMLhU8ypQ=;
        b=THNWdPxjOuAaKuHMXxLWE8bD66LIVoQLvk3/RygegyNFENE/EvRmv5Ypmc82PtE9bw
         MHTg3Yhi+iV95C4JAWr6K3qeVpIyDQZooHo20ANQicAn5LefbbVYYZ2G/OD2I44S/ziZ
         pmukZYC2zxSPznen2VUlbyXVVEJl5KXiYOJN55UV3Ytb6XHimcWoMr2ElP23cnXEhCmM
         8TdTlEckhap8WPx/vjugCFuJFP/2iHhIpDtJip7yI4rhP+3eOP4zxexsGiWNmVALiAfa
         XanalnZx5UV87L09DwquoRotakzkWB73a3aOw5QcWS1+JfZiRTJVJYPc/mszUqlYNjRS
         B14g==
X-Forwarded-Encrypted: i=1; AJvYcCUCdxE6rB6h8IXJhTwMZTVIxnaRpvHZzj3glU8fENK/O2MWRHO6yelj21MfZfIgThu246L11sVjpnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7AsSoD02aDEjfbxlbp9IWP2DiUlCTlNrisZfHMfedTk9xU+2
	PKHLQT+WaHxUlx8lAfsDhIebLXAsMEN6SSTlGna9O0llSKhSFyNk4si2l1ajoW0=
X-Google-Smtp-Source: AGHT+IHUG75g9oGUnKbTzwMVD6YxVdew6Qh2TdgFpABqIP1nWkZsjBLY2UDr9LgWMYU21eDVdnM9XQ==
X-Received: by 2002:a05:622a:178b:b0:446:54f5:3181 with SMTP id d75a77b69052e-457f8c63a2cmr308591541cf.24.1725888043915;
        Mon, 09 Sep 2024 06:20:43 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e6152asm20205051cf.4.2024.09.09.06.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:20:43 -0700 (PDT)
Message-ID: <1a3e9f90-b5f9-4c12-9ec9-a61f14604b64@baylibre.com>
Date: Mon, 9 Sep 2024 09:20:40 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: ad7625: add driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
 <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
 <20240908125905.19852719@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240908125905.19852719@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-09-08 07:59, Jonathan Cameron wrote:
> On Wed, 04 Sep 2024 15:14:19 -0400
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> Add a driver for the AD762x and AD796x family of ADCs. These are
>> pin-compatible devices using an LVDS interface for data transfer,
>> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
>> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
>> reference options based on the configuration of the EN1/EN0 pins, which
>> can be set in the devicetree.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> I took another look and LGTM (subject to the other review responses)
Thank you. I'll have a v5 for review shortly to address those.
>
>
> Jonathan

