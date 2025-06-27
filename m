Return-Path: <linux-iio+bounces-20995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479ACAEBC0F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F1E1897E31
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8E2E92C7;
	Fri, 27 Jun 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BKTlSKeH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BC19D087
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038625; cv=none; b=oLcaAZF2O9DwHsEI4vzz2oHbQZcV+cB+cfDmQoIWbKdppOdqV8kuSEBeqFn9QJ+sJb3DWm30Fg6NNaYC0FYgHK5RbiSPsND18wr0vBVMQMmvxyj+/qLz3ReyyN3MBqBcMZEQm78dIOA7CJnvMAmwiA2gSxcD16i9OQv9vGPn0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038625; c=relaxed/simple;
	bh=L05rnOXndZLVhMfQ3qJRQh4M1A5e37elmf2Cr01wvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtOZL1P0zrBqXQaMnCRZxKlpkha63pDhVpZ/TRR65NONjotyX4M1krRIQCNwZfHsqwTT2MgvmScHNbqwEcE6abjq+IRbr6wyBFopy0oBcNZ0gsAZ40hZZeSufA8hntYUdcw87FckBLEj31Bqn06XYW+PxkkrJnTUM+cyzLo8fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BKTlSKeH; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2efc0ed41efso726155fac.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751038621; x=1751643421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyWXwWd7tjA4+PxkuP84RvmXNMOjKMwgfrHx1dR9kgU=;
        b=BKTlSKeHlsVM097kn1vRpvY6MJSIB1GQOFVDrUltrC3rVHLxUvlO1ZeyTfw4QjHIKO
         53kMHNpGXT6EQv06X6ckv+EA0o3sdkEuiDOqhqUhYgn+4Taviu+hxLINhuaYt8rITGFW
         972ZeI7/s4X7y/fVd575e74sfw3NYTVfG9oQ1uagn01J8K3GCfRJpppWgkC6asOVKm8T
         16RylRktuN3YunfRgnVhoRO97jNoJNjV/0lKvDMST++VLiP4Js4khf2GOZXobZno3q/o
         HNcxxjze5sW6kkySAxyy1j48TebCdqrzYjOKgU65OBzQabpSh7HK16POh2UeQ6cnve+Z
         p65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038621; x=1751643421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyWXwWd7tjA4+PxkuP84RvmXNMOjKMwgfrHx1dR9kgU=;
        b=Zo5/xAamzMBgwrOT6YOJYaJ8yXCB6ZFv11yXB+6LtVFnodgyE7sj5YyqwFHo2b2+27
         V9l/l4A3rKRWSn28htcI7yhuBHO9rTSjQzi4e1Pv9iQ0/rKOwqMYkmCPBVgbspap2vsp
         0xWGJZJtUpzWASJ6DYPjam4b0obhUtj6mH5IOBhZK6RaRc5MeABraGWc3W6D1ZlLL77J
         HOxb3hWyIBkI7RIazmdPND1r42KbHcCEwOwTsw6X1U0MUvTh28mFx91VJPhAddxF2NUG
         fM8eOAyVmhlpnnVI6PpYmut7ie6XImnfdzshPJyJ5GxFBkluzFOznOu3hdOonxWu34m0
         dqVA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Bi2XidfNknJ7n1iPjXtyK2MJHsfwVCIOqxxXt/vOm1dQ7P/2EfnXlU1KOvvvKKQ1atsq+0nt2j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeEgYZhw5AOm6kj8EKBzfftYZLwo4GmjS2EN9MrReADY6Bm44
	UnMLCEIik/bvtLaOk485WKgw7ifVfEIpJ7rEJeYZDyLlTjj73muAPTyGqoyfv0FtfGM=
X-Gm-Gg: ASbGncvqqlm/W0zkhDn+OZYGeU4A0Icsed2pRKz79aiHNGbpAdz5flYCNlVaQ6n/pwc
	4FC0IElJ+jBrTa2MAEDe2SPl5QumtH/GyUTV4JB+0vfSnAsv+2JWasEkkOZcINDp11U1IHePzep
	ry1juRHFCtB5WN1OyEFvd//X6pM0KNrwCjJoZHXoW8uTpLly2yROd/Dyp00icMdxE8TKZ1WAwJc
	SqskWl0CWmOkWO+LfpuavDMmbBCC3K40b9fVs/o+oGdbvp9AMJcUwIkY/QNrhIfKfMOeDbuyyas
	h+0L4Uqb3zC5QSTF3NYnuADeT0l3Nkf9Qf6+GlI1UncMOl0Lz6vhQOJD++mllllFPIgmPa6SAw8
	BGz2jJVjTKHMQb+bZODCMuAX2DhgiFWsFTNW4
X-Google-Smtp-Source: AGHT+IEXULvmX1+HiFngSX9gyyWo3QBqzKcaZv/DBB4h7Y17r+wCqk9ECg0zGCfRQS8yTSjQl9UgtQ==
X-Received: by 2002:a05:6870:e985:b0:2d5:b2ae:2ebd with SMTP id 586e51a60fabf-2efed7767c5mr2441247fac.34.1751038621367;
        Fri, 27 Jun 2025 08:37:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b857b8dcsm250770eaf.26.2025.06.27.08.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 08:37:00 -0700 (PDT)
Message-ID: <fb2b64bc-a1b1-4486-9766-7c72ada7dd5a@baylibre.com>
Date: Fri, 27 Jun 2025 10:37:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad3530r: Fix incorrect masking for channels 4-7
 in powerdown mode
To: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 3:38 AM, Kim Seer Paller wrote:
> In the current implementation of ad3530r_set_dac_powerdown() function,
> the macro AD3530R_OP_MODE_CHAN_MSK(chan->channel) is used to generate
> the bitmask for the operating mode of a specific channel. However, this
> macro does not account for channels 4-7, which map to the second
> register AD3530R_OUTPUT_OPERATING_MODE_1 for the 8 channeled device. As
> a result, the bitmask is incorrectly calculated for these channels,
> leading to improper configuration of the powerdown mode. Resolve this
> issue by adjusting the channel index for channels 4-7 by subtracting 4
> before applying the macro. This ensures that the correct bitmask is
> generated for the second register.
> 
> Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


