Return-Path: <linux-iio+bounces-12309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A559E9CF259
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6991F2141F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BF1D5AD7;
	Fri, 15 Nov 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Np7RgKo1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0217C7CB
	for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690438; cv=none; b=UNJNb7hXC+USICDMu8c6bvI7+2ZDm7t7mzWAK4CFOGY/5ophBvlRnCAtlx6EPaUgCPfTKUwn0JVoVNazZqgF1OVjSRNkzDnLqZl1gXQ4OxYRuAVwpD/IVPP1gmcblSWnJXEvkZZga4hYm6wq3zAuSLaAduR1BY3k9XAm0GVTR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690438; c=relaxed/simple;
	bh=VP5vVhv/E2Y9dOFCdX2eV4YEEIPdv/+NzGTYjjBhXXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXxaG4HrlN92eGTtjKyZAlhxJ2wDrv19TRbjsuopv7SVLhdkcWTtRjbBSNNE8LgdkFDMxsvmNBLnfbou39JZ7nxG6djbJifHtK/orn8ceXF7SJZKfr+UTlphi9MISq1DpBoJNG7HcQ+ejsmtJ7BDeX/+95NdEdCNcHhy2VM8Gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Np7RgKo1; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2689e7a941fso560043fac.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 09:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731690435; x=1732295235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIPj5iTtlFyQJqlZm+85SaZXLuC8DmA/9Z4Q3D6vdXI=;
        b=Np7RgKo1YcGDYcgTSDDc7wOCuSgvPuhPwOAc1b3toVS/ha6aggQprjDkPFt61vMOjA
         i9TFnG4PnUqYJ42m7gdlZxeM6KaC/2Fspz4dgMY5b3r6B4haWCqK2geGCdsivVQ0Bpbw
         TIE37tOaAPeHyXgyELIsQv9/2ITR9zsoVkrr8tdxFn/cW6lAIvfithAzkT8gXcG8LZg9
         9vBtWr8e8Cuiju3Jpv5T2OmfEslWQsz3ww7z96xHwSHJx2YDcbUs1eniU9a1iJrl3YyK
         HwR0+niJSfk1vAIOKAjUrtJ3cObiuZDh30gtUdDQ0rqyy9lKCgbPObawSLWBM3ysoMU9
         /iSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690435; x=1732295235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIPj5iTtlFyQJqlZm+85SaZXLuC8DmA/9Z4Q3D6vdXI=;
        b=ixO2QAOrYhTXn6N1oeuhsKuqQ1S4VNDZ16dz2AzGTRKfBb+Qvo26y47/c/D6Uls7er
         mgstl7ex1wytXKzxXhfy6vq5Jp6JHsiE1LIulH/CUVqIn0pQQ2LKlo5MEPWa6Y7jQo7U
         htELznydLFu/VmyLdioOVfqB12lK/2G+roelb4zgZF+aI67cVWxV+FWEr+7GWEJc7RZw
         rDHrDx4ZLZVb+lDuRb8LRGx9Hz32LNNDfm71A1J5ZS825gmRfE0UQjBq++PJC4xpqnD3
         faBKwfWhu8dUtbeM4gW/38sofSnmPNzbXdsM0ax1fu4wwUwomHQxfEpwglkHpIRoFA67
         x7YA==
X-Gm-Message-State: AOJu0YzRmOL2L6VCg0onGWjVp8wsRc/nA8r+FN71e6PXkkoKUHvo+a2I
	Un5DBUtX9skl9SMvTX1l15USPKYuWu8FXx0zWrM47guN1m65YDc1yp1oYGwP7i4=
X-Google-Smtp-Source: AGHT+IGmNhCU4u7yKLh3JMDA/eM7n90+e2YJXKklUJKbTQ3RFU6rgLWGqmASlbfMjQJ+Y4NdR0ldLQ==
X-Received: by 2002:a05:6871:e492:b0:277:f5de:210f with SMTP id 586e51a60fabf-2962e01d395mr3385839fac.19.1731690435082;
        Fri, 15 Nov 2024 09:07:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabcc1d4fsm604521eaf.26.2024.11.15.09.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:07:13 -0800 (PST)
Message-ID: <c42a5815-78b0-46d0-8592-e9bbeac12e16@baylibre.com>
Date: Fri, 15 Nov 2024 11:07:11 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: adc: ad4000: Add timestamp channel
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <7cb2f4f5ca6980e0e5ff4591fb8b7f53124e13bb.1731626099.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7cb2f4f5ca6980e0e5ff4591fb8b7f53124e13bb.1731626099.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 5:50 PM, Marcelo Schmitt wrote:
> The ADC data is pushed to the IIO buffer along with timestamp but no
> timestamp channel was provided to retried the time data.
> Add a timestamp channel to provide sample capture time.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> I was about to reply to the patches the other week but waited thinking I
> would be able to test them on time.
> My initial intent was to provide timestamps for ADC readings, but I didn't
> realize an IIO timestamp channel would be needed (silly me).
> David, do you want a Suggested-by tag in this one?

I supposed that would make more sense than Reported-by: if we are
calling this a feature rather than a bug. Also,

Reviewed-by: David Lechner <dlechner@baylibre.com>

