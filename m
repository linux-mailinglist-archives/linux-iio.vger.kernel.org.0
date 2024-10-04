Return-Path: <linux-iio+bounces-10106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832598FCF1
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 07:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7CF1F22E31
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 05:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2930573452;
	Fri,  4 Oct 2024 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL9U3ZFL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF304962E;
	Fri,  4 Oct 2024 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019129; cv=none; b=WooCmkPV37OWnfulLnSJJ1C096UGfCUTrMWOnOX/4knLdjVqTr2afKQ1MkTz6frXqOJD4niuMnx0qT5gdQAzT4fM1roSwqF50hRHFQ/umRrO1NVgTCYME18M+bx9jXt2JC8SuLcrIEXf2hzq8NciHjvn9DRPDd/pza2gGcgtQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019129; c=relaxed/simple;
	bh=zhYNUqwL8/T8pcLWguPnqFeLeTckgJIi/IcyTn+V0tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSbWMfqB6rH3dKC7z3CwuNRj9yGD1yG1zP18IC7XcN35lxsjk/0YOoDiXdVlbTOCYlZ1V0QlLUtHQNdMSqmoFSXRR0g4b0nFk9OT+YQMRAV2P1tE1CO5TqTCBHXEuGyETEZdQsw2Neg+0Jf/QVYfzh0lxOPPtkpgberLV3fcUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL9U3ZFL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso21294291fa.1;
        Thu, 03 Oct 2024 22:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728019126; x=1728623926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rb4LZ3yX0QQKxK4lEDVtdfq42HAy1K16GOiI7cZW98=;
        b=XL9U3ZFL1dyRuxiuUFwS848fwPMXm3iHxBfKI1XMWcFalyc/LYVGZwN2Dt5/FQC9Xb
         e85XYTKuIEBgdsEuSKEsrXZVy9MDonNz4r8TNcLpvCQmk0FGSmIOnDdtHOY1cFyExH38
         O6axaZVG6f4+1kAvM4yKAnX2tQ5f5hQua07aDvC862ptMgQXkCGQLDA7ljP7Wl50esfu
         GywnUsK4XqnCJ2ogPVstRsRHOiVrsRY2+bsjg/AUxl337OtswrajZuPNBvC8OJTmxQRr
         FekUOtbJ3fCWMzbFgKZ8za3UUGSa8/8VtITITmlnWImdyP2Oy5FdL6d+RwB1fWjCYlhG
         a4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728019126; x=1728623926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rb4LZ3yX0QQKxK4lEDVtdfq42HAy1K16GOiI7cZW98=;
        b=ciZxtrt0Ci0aUTfgSFrgoAJTkjtG50WUb7IMd+NTPiyES1/2dC6VtPqNfTfWtyxN4Z
         ihmMif5ec6x+3Ma/bkqTsbzf+o8TvQtRUZxd5eL+8ZawGZBUD9mYgWEGhBpSCTaSzDk3
         rcvpRfxyejT7l+8l7m+Fv0WsVb/qCaEtrfTJddQgUOosPgty4FRXt2YFUxNSMjFENFVV
         /35qQI2cma2f2/1s5smrbFo2vthPhW8xyC/0NhYSyb6SsTBtSKtzHwNR4DfAywWQTEkz
         zUC9co+XLrOiipMETxf+7jWDgQKRj83v5pj/kgfLZgA4/ccqE+MX7Vkqr/iAdLnMiOQg
         iHBg==
X-Forwarded-Encrypted: i=1; AJvYcCX816gfPH+P2ENguTLNSGDtIDhvQD0SbV1/eGNIuDvXzLUZF167+s1Cj8vxpfk+6ISCToq2yx50SDyRkdx9@vger.kernel.org, AJvYcCXGRAJ7WXJuepKRpKBjuzNtyiZCm52K1kJ0GuSeo0sG1FQaayIpuDFTM9b1vgcR8RoTa2yEqxHVuf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtRD7ZEAy0sl/vH7DbUbzFq0TbLHtiGvmouBznY70qpuYvcIJ
	mTqEYZ+8Emix99mpH6/kYHF2pFe/pmhKYDRIjnoUaLPAZ3OXo/cI
X-Google-Smtp-Source: AGHT+IE2i4H3PsFxzBUvkWuNpRZHErlTuQZye1javgB7PmrNgvlZB2S7UcF8EUgjRPXxKZamQuWlAA==
X-Received: by 2002:a2e:a58b:0:b0:2fa:d6cf:28f6 with SMTP id 38308e7fff4ca-2faf3bfff15mr6369031fa.3.1728019126037;
        Thu, 03 Oct 2024 22:18:46 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faeccacb73sm3841981fa.127.2024.10.03.22.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 22:18:44 -0700 (PDT)
Message-ID: <fce61a81-b2a8-438e-bcce-9c423934fdd3@gmail.com>
Date: Fri, 4 Oct 2024 11:16:57 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] iio: pressure: bu1390: add missing select
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
 <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2024 00:04, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


