Return-Path: <linux-iio+bounces-16687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D012A5A204
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D713A62DC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1A23644D;
	Mon, 10 Mar 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nNJIXz+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F69236420
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630535; cv=none; b=j3EKH/69Ht9Hr4+3fAu5H4DVCGi648WBPj0z11PSFqYHWMDF8YpIsLlT7zPh5v3leDks5vOsIjcVfQP9IrjpE1Jw9MgyrPEjZOkkqvdLnwXjgRMmtz1Ch90OTtfLabDbrjIFdRiKABBaGnNV24khW4usVaMq1RUGifplEOSOXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630535; c=relaxed/simple;
	bh=VBMDMcDaeNPanNhbLfuWCz5ZdQmWuAoWaVJLnBMRzt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtJYt0t7QUZCtape28TqlEn5dFKHagtZg//+k3o+qRwQFdqtTVzhGwRy0OwAnqYj/orrKUQJYmgEz/UtVqPJeJE+hdhoUp3MMmzr7Fa41aEsuRwVA2pR8BxypU3hSCT0ux1T7CO1vuigU5S5BEM8nY6oxRTxK4mjvJMsXP/nasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nNJIXz+C; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c186270230so1164078fac.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741630530; x=1742235330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAI8ciAGS5zB0DvlZGls9s/FLbP/T+sobHPu1PwltT0=;
        b=nNJIXz+CQM1cWkei3jZCvsmDC85sN7gvCfPgT9WQC2xPbAQNHGlwIn622ZKVzrEnED
         5hBxmAFPxUwJb9slYfCPzJ8xw8QrBIByXj5v0QXUMg6KFxpBgElCtXTStDdIddLpMA8K
         KfARzDHuOaE67RZ1kQHnM4gxGM/hoqtDYYO86UuFKMMouO0FH4ESL4RZOKrxwYhbqVFz
         WJVCTbKeuwFKx0j+yst11gnss1GzqtSYc9DNRDnMEbSu4umUGsgfL+5iq2DFlE7DF5Vy
         CM9BAy62UM1vqKS+a8GtVIxCqW6ey1iz+If7shsSRsApdeWzMuUY6CVHaGOpnwis4S0r
         jIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630530; x=1742235330;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAI8ciAGS5zB0DvlZGls9s/FLbP/T+sobHPu1PwltT0=;
        b=Qw9Mq9Db0Dro0+ZXmnW/KhTdo6AjNepvt8iTVYKeo290dLwG16uSqT65mhVSfRcHQj
         580Hi0O29IQNYFcy9PGdGkzytSuRuqKYJcnsP4TXkWl8ACEUScshHZRXO5PwE65LRlF4
         xkKJtCU1b2QXPqcrHcGhqIgex/shhtXKtReC69qmuflzsE3I3rdn0L7jeWzs6PFRXlfs
         pJc/GVaF/rkCa7F7vApCZW5qH0z35/8t9WwzsipFRVoQZ+5q588Q+lj9dbA9uHgL4amq
         gWkGk36VrlX88o7TLIQJyGMxPTe3ZqmEwR+3g++Pv9qwN5ijrc5XRF7L2+C/j7lO87pT
         NoyA==
X-Gm-Message-State: AOJu0Ywshf2Dzgog+hcH4butRNxA33VYl6haI5waK70DXzqGAOaznF2K
	C+sGuofz1hpN+jKsK7nKVM0X7pj7Y7f/rLDE1dua8BQuJFyD5IHyqCSgljus0oYI8c2HAh15jIo
	GsNg=
X-Gm-Gg: ASbGncsaR7KWBPNv2464G2eZtUbED0AZ0+hScCAXK+0UOq8XL2A7q45JkB1q0LTw/SN
	ldExObiEIxi60CjfQx3dMyZAbIk/DASi1Omnhkv6Xn/blcsIXmPYN0NiS9Co7X/XpNEhk6sXsQL
	VSEg4/M7l/g19n2ilzOVxmbqiXZLtljJTjtX5ULfTkazNk8DXPFDS/W/LFlaOE0pY/tFHVr7Q3U
	vXYEEozDM4tgl0vr1yjhhMC1PIwtZCQ9ZkTdx+Z7E2v0nxR+U5WyW2HoFfLkhD8BWxmafSVs4cP
	jvQe9HgLArLSMdNvsGo/HxbJnMLzbDzFA9u+DhTKeuwAbr8elge8abR4hcCu4Th+xpI5sHjflsb
	5qX9rFg==
X-Google-Smtp-Source: AGHT+IFhWOlrUQlGauNsiAPR7fPPcoFbbBV+CDBh9F1smUyDI9GdLswjsb6iYSCOJNi0ClTHTURvww==
X-Received: by 2002:a05:6870:9110:b0:2c2:b9cc:afb8 with SMTP id 586e51a60fabf-2c2e8699e64mr372641fac.7.1741630530098;
        Mon, 10 Mar 2025 11:15:30 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248d56112sm2276239fac.31.2025.03.10.11.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 11:15:29 -0700 (PDT)
Message-ID: <cf5b14f4-ac10-49a1-9f02-32cdcf62839e@baylibre.com>
Date: Mon, 10 Mar 2025 13:15:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] counter: Introduce the compare component
To: William Breathitt Gray <wbg@kernel.org>, csokas.bence@prolan.hu,
 Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
 <20250306-introduce-compare-component-v1-1-93993b3dca9c@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250306-introduce-compare-component-v1-1-93993b3dca9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 1:05 AM, William Breathitt Gray wrote:

...

> @@ -301,6 +309,7 @@ Description:
>  
>  What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/compare_component_id

Prefer alphabetical order?

>  What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/floor_component_id

