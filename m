Return-Path: <linux-iio+bounces-18518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA3A97268
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BD217A60A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C828FFC4;
	Tue, 22 Apr 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="unCQKiFU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2621764B
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338780; cv=none; b=MyNXBpWPKRLbUz2iLzwfNBGqbik8Yt69cuf/5Gk49GYIk3XSUv2hX3LIrr8HaASRHhTG8wEQbA3PY2+4bBSAostOciwpJ+F9R6kb9oj4s0Mx4xNgx7c/XgeMFvR7keESlQc3gEUCcR4BRj47yQDJ/3ta9yjlUsP4v59aQ90sU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338780; c=relaxed/simple;
	bh=4/RzQ1LIVvZG3U85Dpg80Q2UbbVOrbHAeO2QxKYyG44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5yTip+XRXxwLeU77ggTlFs0ckSdhga2wvbNMp38N6y9CHKA1n4+PAXxcBAyoAuC8Sa7Brre0oc99X7vT6N8MZchUQPqu86ZcCzV+D196SL4VEJbEFTkKCOn1qIzIhrSOIq7HSN3v+pZOZaD/JIZwnNS9vM9/y1v0XNoF0VYV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=unCQKiFU; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b8e2606a58so2966503fac.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745338778; x=1745943578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tfn9NtUR+iFG2oeEiO9AF3LZGUmoabJt4G/s63Re//E=;
        b=unCQKiFU67U1YgVGh5ia8HRmopDtqcoPY8TP4Nx00VtVlkIxKA+F6ERqynYjVeJMv9
         V8IX6YtNYDx1lYWjrH/tC3k04mNz/N71muXTpZqPAwUjCNi/atXNyKimLRSmytlhqOKQ
         eaoar5JZapR6BKpB+3hC1f50yYJdw8exresIjz2T54DnVw3sTTcXbyRKTzVZ/NM6Iue5
         r9ThZ5upz4Q9O+YOH1fnrW7gwGHP3PcovrEzLFuTdCzGgNnLffF9+EJ+hRepVR41HviA
         CNjuGj3y0iRCnISzrK4yXAbgfXMBpiHS46jmVc6Bw+brQVZaGhNvSaR+5Mhrw+d+9Idi
         OoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338778; x=1745943578;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfn9NtUR+iFG2oeEiO9AF3LZGUmoabJt4G/s63Re//E=;
        b=cBjMF0IZnAPXDVMnkx8xGzZ4PCMz8BPo5cvKnAlHV2lOVFTz2S20mnpKYq9Un8tD0E
         3OEJ67lujk7LbMnSLtz/pCWOT1hbS88Fv0VwAydEftrJM8WqgiwNfpI5wWlT5hQGiTMv
         k1C+e7XY6L9JDAUMtv9qdJez49EjDmDIJXPeYMJMvYyqSp0Jpi6cXups45kh3cpOsvLm
         mPdIc3kxR2nr/wo88aGZKeGKfdOjN84KZ8t5rD/Uk9Q/4TfOBpBfwEAb8VlPWbtrl+lZ
         9w188rMKfmaaTEmdvhSEd6zlINpc/yzTqLl5iK3puEOeom3Hl8dHpRm3hC7tN9rXMPFU
         kkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1tU6AKy95MoFU9/YWd3C5WYNqyxDvZS6pmQ0g56ABkMVWovqGFDxTaeJGOWqpsLIRwSLIu838F38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuDFOeGBDgPKVV5xt1vrYUAuNRgX49GgXLctIB7Y2hZ1UTpJu
	1ddVZlIMRb12G4g/meC0f5/NTO6ptc3DZ+h66rYh/PtAvw3O3vanC1xgMcoMxPc=
X-Gm-Gg: ASbGncsdjTuO6AAqWDNvIfXd7yXISMGD/N2TbNrctSbpR8bE2MU3Vx+Y1EINJ5cvTKv
	Rs23chTu0adyii0TWdaukHOK1OzA3u/icHzo4W8g195XzpCfiRIZ1e1tyOewrBSrF3yoYNIKdoO
	NCdAXWWPNn4ddL1UJzuyZ/xLyZG1ifUn24Uz6Kp29H4irvZA99INPUlyl3r4ui+uUDiSkhQuRlr
	hPbHBK5aOUkG8SFO72MnuaINUgS6mYCLQ048+OrWnjpMq59uRFsZ3nDq0is/bO02rwP93e3FOGP
	74l8M+ashxnL+hIP1/dq/baH15Hzg+uT/UuvbwOc6QYPDr8DL5uK9inerKLg2aHB/SXjNd+AuEy
	Ve6ZtR5baaI6zT18uSg==
X-Google-Smtp-Source: AGHT+IHnHLF/MJmsCEVOMpIEMAi20+FfoYD+9h/aOe4dW6zU9BD2Q0se95enPxwOaKkNpTjn8U+TfQ==
X-Received: by 2002:a05:6870:e06:b0:29e:2da3:3f7b with SMTP id 586e51a60fabf-2d52696fa41mr9068798fac.7.1745338778018;
        Tue, 22 Apr 2025 09:19:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3? ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5212c97adsm2615604fac.1.2025.04.22.09.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:19:37 -0700 (PDT)
Message-ID: <e43442a3-d36a-46f3-ab13-7c1b56d2993e@baylibre.com>
Date: Tue, 22 Apr 2025 11:19:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
To: Jorge Marques <gastmaier@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408-abi-oversampling-events-frequency-v2-1-4059272b7364@analog.com>
 <6rgtuq2mtk3a63d3tlzbgjhauslkztgemn7566qyi3mzwywprq@lxhsvwofnvg2>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <6rgtuq2mtk3a63d3tlzbgjhauslkztgemn7566qyi3mzwywprq@lxhsvwofnvg2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 2:30 AM, Jorge Marques wrote:
> Hi Jonathan, David
> 
> Should this patch be submitted differently, such as under the AD4052 V2
> series? Or are further modifications needed?
> 
Jonathan already replied that this should be included in the series with the
first user, whatever that happens to be.

https://lore.kernel.org/linux-iio/20250413103110.572de81e@jic23-huawei/

