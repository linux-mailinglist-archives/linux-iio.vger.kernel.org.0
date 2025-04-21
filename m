Return-Path: <linux-iio+bounces-18464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8977A95344
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118CE16BFF9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018C1A5BA4;
	Mon, 21 Apr 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cOsln+2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF71494D8
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247835; cv=none; b=DZSA5k6fOZX8GqkzJ9Q91UQ8wni7beXm4vgyftazph8Qgst0qInr5905QP9m3NGZU5uojHfI+CxeCiKO7FugOTuIJ9ehoaoTD+jJ6TPjyU9qh1qP6sKgGgDBH5Cz2hWD9bt1YjPfAIubPb5iHlPJBs+Z1HOyjex5cDEC2ytKDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247835; c=relaxed/simple;
	bh=8MwjBcfr/1YzR8kz1rCpVRVduwHDyHObygHtOZaUxFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBmQMkY0ML4UUm8w3uec7NyipVxRhh4niVM2UHk7nhYeQUvfYUUX69whbTDMLMbo5fboAM2RILEsbD1qityX7/7CAawIfzdhaUSnP7E9jmah5dIonM2EUSWIXyWM6jCyXX3zzZOY716iI2fF/CKI0EzlLAjlQLnHHyoAGMsF8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cOsln+2/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fbc00143d6so2650444b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745247832; x=1745852632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FY2XuIKhV/Sgo0Ecqc8Bv8Qk6YNHmgpAFdhrG1XHihs=;
        b=cOsln+2/8nfmAJo5/zhkcmk1SBokRsehEn0Ujj3m/lZPlzfFetDW6MU4nzbGUADjH/
         7yhhAslai2xhXWf0owiJ7uP1cz/Z8BhxJp+ftDIYzRzUh8DuDl3KF8Tqim2rrggPOy0y
         Rvuxq/hF1HjSda7QmbEzqY/Pj0ooVX30Z2QVsanM+2BeZde/beYag0gMPCx+O1/EJiCN
         msug9oTXe2ub5vkMGowGWUZT+wF/t8T/Ow4yWK3Jq9/gVu3KeuFr3p2iCqQp06S7f53q
         7d8Jmcd6SZsYuN1CtUPsw58y/++ugleyKxNjjV3/Y9ptZqs0djJgTESOlbbuSPCHIRwb
         CNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745247832; x=1745852632;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FY2XuIKhV/Sgo0Ecqc8Bv8Qk6YNHmgpAFdhrG1XHihs=;
        b=inzXHC117Du/+SdRVVSeCqBQ4SR10LCq+mfWWYnkancLJp+fLf/jOzFzTRRjqkQ/Di
         z37ioJBv/CWJeDWmOU7tigp3CpvS8oNBjhotjUtU2oV/z9Q5rbHoLxwEA7JgTWWZVo5B
         XwI5QTGdXqIE15YxCG2wEltLdWVgyq8qu30LDf4GIDE+CaEvNkegnXoD0pTohoHXsVNN
         4OOVgM5J1N/JiqU4ZPrIYc+Ze7YR0FAYq0vNESFCjNQ0MwIy079ZgBe37BkQ8lK03Ld4
         YamsaDQis6l9VkYjZLDbgGNlT+xIow5eQmGcmLdkaYdoEZzjaH1WFN+nF3kwzZTtgD5v
         n0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnG5FWbPJ1mHYKloBDpFT8OPvA/zwJMdAssJwqs+gZIODGeE4uS0ngy5cGTnm5zwQBgFz4XfPNJ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArZvvvzvvY3AVblSLWPzZqqxtHeM0zqe0SPcvBh+edKEzankX
	rQ7+O4Igl92h4cVseItpA+TZ8n4ScrQxUSVPTO8DqYMn3xoE4/YlzHXP4o3hMGY=
X-Gm-Gg: ASbGnctwpB49YwGZ+SsMwKFhx20uEmAwfZIlRkyE1zdfspYYuD21H15Fg3HDUafxHFD
	3rGXgOs4gLb8N5xaiq15MOSOkoLmOMnIciCKsvxtKvUX+7g5NKSqomyOiRM8cypuxyn6UUEeHUr
	AxGWj0za5lzQ059OMhuNjdnsCfO24tj9zZXCu8pXLWwbJ3Eeya26D/79KYqVFHBd3Qt3eZDbjIO
	YZSS0F9jhyQ/WOwSjZfer2DdJyxUzxeAZCZLTdkMb1iXy4sdt9GhNB+6RIu9K7uTlcKAJ0vUTCl
	BzKgd2znexO4l4ikqMs4bp9jDTVWz2Ti6nTHlRLHwBqxlMNFKMEbNaYfLM7DHtthi+CRFr6ZJCs
	DEkurBPa7poWFcJKIvg==
X-Google-Smtp-Source: AGHT+IEUiWQAh0/gbfks+29iIQLKuYGfNAiOaP+vS4xjC9mn5gHUdhe9qiJ3tqJ98liHXSBEqsOB3g==
X-Received: by 2002:a05:6808:8302:b0:3fe:af0c:73b7 with SMTP id 5614622812f47-401c0a70ebdmr6506941b6e.19.1745247832741;
        Mon, 21 Apr 2025 08:03:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:61f2:6de4:740e:804d? ([2600:8803:e7e4:1d00:61f2:6de4:740e:804d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401bf081eafsm1574753b6e.35.2025.04.21.08.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 08:03:51 -0700 (PDT)
Message-ID: <56f5c56e-1993-4bbd-bbce-b9c954fe8b8c@baylibre.com>
Date: Mon, 21 Apr 2025 10:03:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <CAHp75VdcMoxoBU+fKQ5ex28N7YJNcEe96dOuq6hWFxpnn7UYyQ@mail.gmail.com>
 <20250421140342.4097c0c4@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250421140342.4097c0c4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/21/25 8:03 AM, Jonathan Cameron wrote:
> On Sun, 20 Apr 2025 07:36:18 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Sat, Apr 19, 2025 at 1:59 AM David Lechner <dlechner@baylibre.com> wrote:
>>>

...

> 
> Maybe we could add...
> IIO_DECLARE_BUFFER_WITH_TS_FOR_DMA()
> Might be worth it?
> 
After reading everyone's comments, that was my first instinct. We should have
2 forms of the macro, one for DMA-safe and one for not.

