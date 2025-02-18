Return-Path: <linux-iio+bounces-15736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA62A3A1CB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0B318937CF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA926AABB;
	Tue, 18 Feb 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WVQr6IAn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7526A098
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894068; cv=none; b=oZBttL4zBkTlTCZc4K4DeAA61To7lGyRBFnwnq3RnZx9XAUji29BK9EeuvSWzkZ5yX5H4KK97+b47W0Sllk4Ls4Mn3+GLCVRfUb3SxFBu6aS9Py7FiSI7gefRpj689hYzEH5AxsZ4uw/kohbn/uEVihewPAS3znWfMkJdy15PvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894068; c=relaxed/simple;
	bh=wiXEVctysnvVjgm4atZ/mQFHMYMSHxQd/nR4MeHpmWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3HKtVD5beIsRePBywC0YDeDESrswevbCwjpeqPZcsxB0ZI/+F666EgllVBrGAu95TizsrwrfRyUWJVqmwlnYBc1mnadfSp0ErSl+7f0KLYH/K5I5XsZnbaA5gqg0YRlmNpnjVluOSn9tb/ha6NPqpZ/XWnxZ0By0qF+0gRf/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WVQr6IAn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72726a65cbaso1063270a34.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739894065; x=1740498865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRLKsewk0QxcSwsop0HI3PDrjUprLpILmPwp9lHQ/wg=;
        b=WVQr6IAn5Ci6gNWwJEaCXq5VzMwm1n/pJ7WdOsuWIZ9dkBhRK1m7LVbqmS88zHfHEa
         c6DSeUoQXhwNPYFV2eEhldWmpEuu8vmdkxD5S6Nfzj15n1X84sJUSssS+fCSV7xehDvZ
         ZuYqqcL9owMx1z/TA0XaJ89BYFJb1BrgOf1Mwdl6GEF6ESKuNkdzw3378dxqA6EvWOBt
         QN2zhFYyqvJnlmZ9EuoURLQ/96bWzjkeH2ssY7v/RwL1+5mhU7iGGWx9XoElkiAkXpxE
         8vOmys68BaBahsDhnBus2Im2FCw6H2APw0GxYPN5UClIo/PxpuU1StmCqwe06b/WTsGd
         je0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894065; x=1740498865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRLKsewk0QxcSwsop0HI3PDrjUprLpILmPwp9lHQ/wg=;
        b=GuVN767rUzmMer7lDmEmcSK3xlAFzsyOTcHOimMRy+xsrs5QLjIybG9REQb1IV7ae9
         ybxIvTr01l4ol1Mht98E/eYevSxYJxgtjcCdCtPo6yNEcPedh+gE3QCZOg03LwewKC9w
         u9uNJj7s3HSxXwseINhOdcsIFY4id9I0ANRaaM1v504CfbndFmlqkRcA9Mc3RhQoEn4Z
         elaLoWgINR4N8Qvd9sxkEjUwlg/ZhGhweAWNVamK4EhfAL6my+kbwVDDdUcv/0baLRMl
         cxL29rQ8NOGdCOAagdjQm+kJ19hMzF3uJpRw5fK9IgoUouczXYKe40mkhzw8z8jSoDwI
         Wtcg==
X-Forwarded-Encrypted: i=1; AJvYcCV1KGhO6az1Fw4PKdfK7lz+AY5aEPmrp1y9CMRoTF53gmR1RKB36um4r0Jb4q6YF8Q3OeFL2A3u9as=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSiOeTCp7HcK+3hUcMepwP8gLW1wvHNFcUx5W6HsousYMj1TJ
	QqOXINaZHgWLVVDcb6Fwu0tYks1St1y2CSGHmjh0wL9tegjZ7QStbTpero1gKHY=
X-Gm-Gg: ASbGncvGB/464rYup2xPxCAAL8OPqKgFfKoPjv1rIL3Ftyl0KHppvqrITvWcRBlqRVS
	mBJSpkgYGBA1uRUPH9nksFsb2wSroI/vKs//KDLmIXXQTDLYTWC9/XMC21Ol6L9sivUjJs//H3D
	ZwsHJNQReKPRkvRZJFE8G3FQATGbseZ7rsRx2AxdLZ0t2pJDN642tiqIjzJo6Fl3tcG7e4dmSqs
	Wo35ydUxUAHTmBvUWwMBD83gfy0DL84ytsQ6xyQrh8RpDKoVQtBKwL/ON1z/ofENL4UApDsrgwU
	YcKrQ0XatO6FcEHR3fCEJ5rPqOhPn7399IY+HY+VZMHoPSmfW2Ot
X-Google-Smtp-Source: AGHT+IGX45p//JrZUSgDQg4PuHKBYngfkwkvXYmvrPZIegTuPuyD/5ICXuu1ysJxysXJCeIiSiEfTg==
X-Received: by 2002:a05:6830:4905:b0:726:fca9:bb2 with SMTP id 46e09a7af769-727120632abmr9609179a34.16.1739894065566;
        Tue, 18 Feb 2025 07:54:25 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727276837ffsm1030131a34.30.2025.02.18.07.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:54:25 -0800 (PST)
Message-ID: <3ea6bd9d-4ef1-4cd6-b08e-54058e97938a@baylibre.com>
Date: Tue, 18 Feb 2025 09:54:23 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: adi-axi-adc: replace of.h with
 mod_devicetable.h
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
References: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 4:34 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Don't use of.h in order to include mod_devicetable.h. Use it directly as
> there no direct dependency on OF.h
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


