Return-Path: <linux-iio+bounces-15717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580EA38EEE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456D4168EF5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAEB19F101;
	Mon, 17 Feb 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3LgEGYpv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122ED19D89E
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830925; cv=none; b=YEAK+RmzPpjCWlN+47Gsnhz/WIxnxPcyr1SgXpUiDhfQ9/IMq5Nz2q+Ae/x9wdOHr5LMM7s4Pp8VI6nhJ9WfgKcVgb1AUGWPg/jTxxfT2K6dzhM6FJlu//Wjm9JSAhPB9i0EdtrCXKYHaucMs+W89rQDRV6WYc1lIV1C/z2XjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830925; c=relaxed/simple;
	bh=BF+LkjLorCqMtqsR5IN5twxGGiMyZY83PcKM1d0Dvr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnlRr3M+Eaw1RfIPFifwkLrlPkLkW+6wgtNrLisfQ/veqVBe+rhsS+q6qCruYBRPsp64GA3DxjxQTim4/nsEqJuoGdv6EizCUKg9y8WovJUUajuumrEiZRy14jKIMZohaIZE2kbQ9yJKqyST+tcsTX6wSR3SpwTGS7zJA1O2zTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3LgEGYpv; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so1394571eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739830921; x=1740435721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltMBTpF9zJIRgghCi9xKVsdftP7qeKkqOrA3C53WtpI=;
        b=3LgEGYpvg8Z3e/eTb8LEDmeJu64ZKZiZ9e5C9kP+js9nZ66N765JK240fKDl4kbN73
         pxP2tIWsyQ+6axK/S91DmSX+K8p2rnhaI6QHFfE2aKXfqKAls2c6mPrxfQIGZ1AWFxqQ
         6iJqdbSo3rCBvArXNcp0oZJMi6k2HVuTwUtRWlgT/dSB0w2OWFPQU5ZzNi9rR3SddUMW
         j96XKpaymE+5+HSZyyf5K5pcjPO/TtNnMQBxuX0vcnLAFKVINivUG8X1wSN5LxP2QXBS
         rwJFyoN1wlH58ITU8WG9hJNIAqQeW1Al0r2+cZs37WBEBE+xvGyVwI6VCT41GWq1O2Hj
         EU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739830921; x=1740435721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltMBTpF9zJIRgghCi9xKVsdftP7qeKkqOrA3C53WtpI=;
        b=geYb6mLQw8FFyhdhPq5w1jT7W4zfs8UZQiuGcYvs/I4K484oWdUUE7E5yXYi16LZXd
         z/DaJzpFvwXieILiuyXCd8O4GZ2Ae7xtnF7ANKohoV6zzsP3cj89OrRdVTTnJAFlVgeh
         PZwg9dzNoN4lltw0nmYSumYeoFxsv3jC9+EQeghzT7cssKgwK7qkCfFAoyIFN2NBe1iL
         3dQ1lL7RRClR2vQNgcWgHRZ378E5XAozVsQFbJIA+M2wk63HgjK51BDShlmiUEVxNQOr
         MiXMhM5vU37CizArvFsEKwUwQvW3w9s+JHRKhhH5f5Vhv3+HmroBR0bg/QtEUPZk1fsc
         ajbg==
X-Forwarded-Encrypted: i=1; AJvYcCWWKuFwfNj9lMXdXayBdPMrYPWs/+xAZNrt/7qAZIoFL+jn0pw24+odZURKGhsQGI4a9vhLgmzS/FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJchR8W51rdUfuoc0EMZiilcsc6bSFHOeswIkS8GnmkGZlaxt
	SUJVT57ufKGP4SA4kAW7chkRvGODktIQseZJOTSdiiVkmwhvOyGF8XpVn8MhXkg=
X-Gm-Gg: ASbGncs3bc6z6yYZnhbqlsNCh0pCDtvo8xuWa0p34u8ySnfMoEBckaMI5uph+Oms5UN
	990lKFjobTY4+osUCfN5S3aN6u6FZcgskCt1Db6IB3+uZ8uYarhWiwauUU5EJHOQ2Vtt4smeTLt
	11DgNEh0su9Jy4gQScF9dZZHaBg5u76YzjFF/HXSzoaZBlFxdw071u3/Kxy4jZZF0AzBYZUPSSg
	9bdUUNOutEG6MPjD19HOgz8QKgxkRNIiNFAzqHO9Vcq6QP/OCkyi/YTlwfuJLLqchDaoeFq9Tqw
	YLsuQVhUYvW3qJgbRtGwfw2GjC2C1GFQv1zJn2KPnV148VT9vazk
X-Google-Smtp-Source: AGHT+IGhlbju7wjM3RLC9K7fDG+BQQPLYFebmYInexpiEb5MvBppEmCHAHkLzMHsILynbfEPcJHfrw==
X-Received: by 2002:a05:6870:f154:b0:29e:76d1:db3b with SMTP id 586e51a60fabf-2bc99a3e3f1mr7570559fac.5.1739830920848;
        Mon, 17 Feb 2025 14:22:00 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95a6bf62dsm4379081fac.40.2025.02.17.14.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 14:21:59 -0800 (PST)
Message-ID: <d3dc38af-189a-4f46-988e-4d99aed34b39@baylibre.com>
Date: Mon, 17 Feb 2025 16:21:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] IIO: Accelerometers: Sparse friendly claim of direct
 mode
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250217140135.896574-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 8:01 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note that a number of the drivers touched in this series have no
> obvious active maintainer, so it would be much appreciated if anyone
> has time to take a look!
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>


