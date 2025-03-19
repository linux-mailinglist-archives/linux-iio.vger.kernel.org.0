Return-Path: <linux-iio+bounces-17105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F398A6941E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C74D7A1E80
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D7B1D9A50;
	Wed, 19 Mar 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YHG3sR5z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0521D5CD7
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399654; cv=none; b=rjoQHbdHBU1Cc37VDFuBaXIahT8kUcI7gw2VQNAACGL9GC7N5C/UwiroJZXbQBunIR8Z+DiOtd2BHnKfGeO+RSdn2EI/Xdj7FtCLEfZ7w4FX14NiuOcite+M9TKbzk2ZDBxDc6GA0hRImMXtQVpH5TX8J8bqY6/COQDZdg79k3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399654; c=relaxed/simple;
	bh=uJhYmWt4kz9HYzPP7LyvzGESskOTkR8JU8W7IjmWUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLGb6ZVPon4QISBfkgecWR4TX+oQIdTFvPT2VoLI7k9lZe1IdbWtQUFrcCm9CykJVpwCXmry1thH5AsP1EW1AxMtIeaeISirO2c2tOx0avxGDRZpTckyRhwqQrolOnnTY+M/u6am4ud/A0I9NFqyeqkRzpvYIC6SK5oX3k1MAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YHG3sR5z; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fcfc85f1f5so1553593b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742399651; x=1743004451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJAw2RLlJLWsVz4/sB5t0+VZUbRaLZIqPwHY07oAJCY=;
        b=YHG3sR5z6ZVeEgy0+JLw+ODoAQblDpICmmrf9J5XxJ/ofjf10LzK8qOvSHPn7EXey0
         zBQ3XdRca0ZfiZBGsXmiwBgutVZ91hQVnHy8WOgKaeqAN5NX/DlkY4BnTRX1D7OszDbb
         sgCDeqATYB22EsQGuld9YU5MT6yzH1Qj00fABXNnuZjUv24SSJK1tJNnZDyJp/jlepry
         KlCwNEBBfewT2l6BphW9Ws4ep4euWPZlYS0BOlFP1xsgtASlbyuCXwCECiP6YFsPHhJD
         AYO+7FuHb/TAgs5TAYdsiMNnRzqU6lEMiVWy8/7dnRcYE+7oecIrjXZvNq09YI9F+bYI
         nz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399651; x=1743004451;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJAw2RLlJLWsVz4/sB5t0+VZUbRaLZIqPwHY07oAJCY=;
        b=ZpjZ0JV2/ZMHZVetPKdUPim9OSUWRk/HNtXKw1EA4pXn4YeCQirKEtPZ4U/RfmJ7S1
         hw/BwmWXXyj/jprAhZYVj8XmtcKPq2QOS/hZmEku9e70re14hLRKm/AAmeOMFHeJX/Hh
         yvV8YO+cKwRqSbvTrrJK/IgdDzqzVEqBFqz8QxtlFBUxxknHCyFmCGtQ1mj5Ru77+I1x
         K5bd7p99+p0O/VUIPwQig2qz0dzM/2nDOa857BAcVMWox/Tg7CUITjaAj8tX+2L5GIkY
         x5lkbnPX1lOV32LjRxt/SCWAzE/PnLx8OIOGiR2AaRX+cDrO+dpswaGrleeFoG2jV4zE
         gYMw==
X-Gm-Message-State: AOJu0YzJgpYiCoi/oCE+xe93iQ9RWWm0CnlmtSNVuyVw4+mJOfninssq
	vHkREuNLl7zeDNxGXETyuhFFRw6sDId8CGmnEKX4f8WUx1YBebgkqc5NuPy/+sI=
X-Gm-Gg: ASbGnctCVwHF4XVn0ow4vm9XUpz5cY8IQWeW6EPeTQmufZLe9cBsuF8ekvhoTS2OYuM
	mVOrSDPZQQvDtUDR2KrmATZR5lOAzkkhZnSpuYM5JSD+pbNV7ocDW2YKp/THbvMcQdI6KA1wJdG
	elcCUmxsysDzQEe6362kT9TAGB9MbnpDZpgiP6cp2TMX7POmDvmw2crl6badGy/ASNBbwW0ffDC
	CiNByDHemt0+FtOvEAgj1sTUkdSAKT0nXwAGKNSSRVYdZ5YYBPAXf9h/HYt0mm1Z05oujii/cyv
	DRwCyWGWz5ygNY2M8oGFlLw72VifcIWxlJuj8bhgAgWwoH51z5ZJ2tSp//N7p5nvJFbqcnRFov+
	+OSmPWhzLRkYWgE3o
X-Google-Smtp-Source: AGHT+IGjcbCOR5dU8JA6fAFU3lfPqdzLtlKPsAilRhsTgjF8Vo/DLdEK5WYA3/7mdPtOIyUm8/BgQA==
X-Received: by 2002:a05:6808:d52:b0:3fa:25c8:a037 with SMTP id 5614622812f47-3fead5f73aamr2105453b6e.29.1742399651365;
        Wed, 19 Mar 2025 08:54:11 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b9casm2624226b6e.2.2025.03.19.08.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 08:54:10 -0700 (PDT)
Message-ID: <993d3226-f733-4093-8a7b-cc51007700c9@baylibre.com>
Date: Wed, 19 Mar 2025 10:54:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: dac: ad3552r-hs: add debugfs reg access
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20250319-wip-bl-ad3552r-fixes-v3-1-9975b38c0082@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250319-wip-bl-ad3552r-fixes-v3-1-9975b38c0082@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/25 10:45 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add debugfs register access.
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


