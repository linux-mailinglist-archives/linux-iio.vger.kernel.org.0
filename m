Return-Path: <linux-iio+bounces-19645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EE9ABB446
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 07:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24DD188F808
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD801E9905;
	Mon, 19 May 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Wy+t5Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638728E8;
	Mon, 19 May 2025 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747630908; cv=none; b=MkGjYMWoMT4vSVEUzRnuK1Vn1YzExYFE2XCCERvf6y2DlWhPl9J7G2Vjwmh2N5RyMDmL46nq+kCORMQlynfdg5GLN5coPUxC57lgH+aTH33eLDsVCVKCjhERqYHLIHgOezYVzpY5+xflkh7aWlIAv8oNMOvmlaZ/a2Ksl/RXIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747630908; c=relaxed/simple;
	bh=oz+iiYglbuMStpJoRAy2WCUOordFow0u9grbEX86I88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtEr3whIOKb23sryfMoLXjlBEDgBV7ttSJqy1VqgA+vJhNEyN4P4YiX1Y3Y8dqy3yvPQT5rYLAMknLmIjlNMTu5+94kTgYoq2ciN1uswR+llRYP94sW2dThG711AupG2akZ/SH/eFW2Q/R03Z7XTfEHbigyBAW2e1iGLoQTkG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Wy+t5Q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3280ce0795bso25034991fa.2;
        Sun, 18 May 2025 22:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747630903; x=1748235703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGJHgZlyTkLvNvsTEs2h9eH1GxcxaHwcToRDMUypeTk=;
        b=T+Wy+t5Q0fOaYHNE8E3VlvMDYrop+FiX0Vc6tT9QDkBBzfmlkPG612WsWBJm0VTlnf
         jlWRrArxIynH0F9cf0YUJTLtzVlEwhMf4r+aL5JvCOOZYr2R6cHWYqEV5HZyAEr9wX5j
         CiiwXVun1OlAVl2CB9xQ+fMCJrNj6ALiNPRt0O/wbQSrTMlTYcNCQlQOJKJxSyu0De5X
         IlaQLMz+mbDgkrDMEhGs2OypBs1YmW39e5oi1LnTXvSZXVLAn969R5oOUt+ongTOj1Vl
         VTRF6A3YfkcU9EtVLKZ5ncjo2TWKHV2wE/pp7NJ9paSDodZ6AjjRj1lscQKsvul6QJ+l
         txaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747630903; x=1748235703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGJHgZlyTkLvNvsTEs2h9eH1GxcxaHwcToRDMUypeTk=;
        b=hbd/oa3UpoAar3LgCxKzo/raA5F7NiuRXNhQQ6JZklCEaZg5O9v7hcDdP8MM5wxlK2
         4C4ZyJsZVdg3G0pmIFFSOGQHHlgCuaVT9l41WqyYjqi6aJtOScu9lZs6dBWQnZDh2N0k
         midNejIj3vYZRPy2pVdT7BfgrIdmihgP+rtE99dqd/h6eb8lkpiYpUQ5PxTN1gENKOA8
         pR1kAcki4uew0WFd02KMV25LlZHQNpsbuech56fZ0LjIfefu5WbS/3iBZQTPcXvle1KY
         mYj4WFJwizIdJuJ4cvP9y8N936rhLOJ1TR+651NUsTeJ2HVikhY0UioVHtNeilE0NmU7
         L3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Lg3Jryp6hu3RXrHmZHZG3DHHK4RTxxYbpRplg3ootnVEKaYYpcKwMYrjQ49tvVsXYWkhyc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uGoQB9MF1iIlrJjYuogha7h5X5888EYanxX9rI6fbI+foQP5
	h4H35TYNhwm4v1fhAxpncXnWTXn+7tns8YHwslEUFpO7qyM6NuR8avG4
X-Gm-Gg: ASbGnctVMmFaz8Yq3xuAFuuRYfe+2GlRaikITUifLQLaD75DCZckVkyHHnLtUxii68+
	Eja8lzovYmMuY54+YnycUA9RafBtMbFfJ51ag2vZhJ/2uUBHtXCEG9j1/w35T3gbOYlwXYbzUqJ
	psvV1lJyjC0SBbpkwx2z/ATnOhVD4nKHXYSUxnPxdN9hB6GCO1l/l5mzsndkEtzeZqXDzQI14ei
	782cW1vSxPCA4N80p+nKd3JjxoLRSyFdjFH32oK1D0GJTjgcJxnevNcDG531BhHsO7pozwMlRHF
	esztEZ4lNFdjrDLYmBV+VdX2uz2yRbwcpGTn+AaCPoQKVbQNX79J4Cfxct0TSoTrJHOYT+hntR8
	AiR8ZNyvU052aKU7SUCs0+rnuAA5Jcf0d
X-Google-Smtp-Source: AGHT+IHg8DmHyx+JIFQhBOdci3rI7KtytCBUF0dw9m/v4MA5a121O06XvWnyCApQriNvEdNF5BZGdA==
X-Received: by 2002:a2e:ab1a:0:b0:30d:629c:4333 with SMTP id 38308e7fff4ca-328077ddca1mr42901521fa.34.1747630903170;
        Sun, 18 May 2025 22:01:43 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3280860c113sm17460301fa.112.2025.05.18.22.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 22:01:42 -0700 (PDT)
Message-ID: <a41491e0-595a-4614-a03e-34848446a815@gmail.com>
Date: Mon, 19 May 2025 08:01:41 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: max1363: Fix
 MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
To: Fabio Estevam <festevam@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
 stable@vger.kernel.org
References: <20250516173900.677821-1-festevam@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250516173900.677821-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2025 20:38, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
> booting a board populated with a MAX11601 results in a flood of warnings:
> 
> max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> max1363 1-0064: available_scan_mask 11 subset of 0. Never used
> max1363 1-0064: available_scan_mask 12 subset of 0. Never used
> max1363 1-0064: available_scan_mask 13 subset of 0. Never used
> ...
> 
> These warnings are caused by incorrect offsets used for differential
> channels in the MAX1363_4X_CHANS() and MAX1363_8X_CHANS() macros.
> 
> The max1363_mode_table[] defines the differential channel mappings as
> follows:
> 
> MAX1363_MODE_DIFF_SINGLE(0, 1, 1 << 12),
> MAX1363_MODE_DIFF_SINGLE(2, 3, 1 << 13),
> MAX1363_MODE_DIFF_SINGLE(4, 5, 1 << 14),
> MAX1363_MODE_DIFF_SINGLE(6, 7, 1 << 15),
> MAX1363_MODE_DIFF_SINGLE(8, 9, 1 << 16),
> MAX1363_MODE_DIFF_SINGLE(10, 11, 1 << 17),
> MAX1363_MODE_DIFF_SINGLE(1, 0, 1 << 18),
> MAX1363_MODE_DIFF_SINGLE(3, 2, 1 << 19),
> MAX1363_MODE_DIFF_SINGLE(5, 4, 1 << 20),
> MAX1363_MODE_DIFF_SINGLE(7, 6, 1 << 21),
> MAX1363_MODE_DIFF_SINGLE(9, 8, 1 << 22),
> MAX1363_MODE_DIFF_SINGLE(11, 10, 1 << 23),
> 
> Update the macros to follow this same pattern, ensuring that the scan masks
> are valid and preventing the warnings.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2718f15403fb ("iio: sanity check available_scan_masks array")

I could argue the problem which is fixed is not related to the 
2718f15403fb. I'd say the problem has been the commit which introduced 
the 'offending' masks instead. The 2718f15403fb is not fixed by this 
change. It could help identifying the faulty releases if correct commit 
was pointed here.

Yours,
	-- Matti

