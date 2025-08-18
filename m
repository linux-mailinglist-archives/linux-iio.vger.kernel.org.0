Return-Path: <linux-iio+bounces-22928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234AB2AC63
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A89E7A8E8A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6E433C4;
	Mon, 18 Aug 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t8dIHHYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835123182D
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530221; cv=none; b=moxu9ARWoZfRA02bzo3inpLmvXsOMf7eIoX37CmraA4+FzA5L93TI9MvJKbzV4T32r/9TgEe4DkJgcGqo9IYrfXFOjMxY6knUacLUsAM4W7O4fJqDPIxrMLgppmJ5hSOS7dtOoMsqiRvetuxR5glc9V78TAHfrHQ2Jg2/dvbChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530221; c=relaxed/simple;
	bh=ZQ5q5cwLBvzEWKcFeidAaKR4mpwl8Ihe+MXj7VrWfMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoQXDeF0rsIeZd50qPZt/C5Ql1mNGQlbPtg/YAMbYTknBlJiJj7KbRO2tsG8IJdq6/pp8m3QG8lmgmF0PtmAfZ7UbfWtB2CrOqsxRKeYluremiwlfEvN42FFqFVjkXeCbpxC+/N8pQgPkewjS1uImifGhmdahm3aflDxv753dpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t8dIHHYV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cceb83f85so2316191fac.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530219; x=1756135019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3c3Gvew1aX6fRPuhI9Jg/FD49YDakQTVCTXjiPRQnM=;
        b=t8dIHHYVFwQr+rcY69trDG2w2EVOJ5jP9uBnl3tvtiVlgQKDq40uRUyzCVQTGzRgby
         e2smdDMUZsbt9Jaa47BMq7zarVoLTmsqfAdVrQmCOsJwMznEwxbMP3/72Hjz0QoGoCD9
         AOc6mjmeXl2svHZnrwx5QltaulCDP1uZzDlYoqicb4shEjmQh5wNknbYtlm0WjRzqSgv
         wfdwXYE8l08PH/JV7WpbJ6BILVfsUCtZBX0cuGe5OXKbZYoph2HZj95c3WeLrlED1Xst
         9r4fe9ld+5R+87Ib7/CsLQcXGg0HdhBWs2+85NTGFZ2qnyswiL2EVC1VF7MZSqThWBlC
         6Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530219; x=1756135019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3c3Gvew1aX6fRPuhI9Jg/FD49YDakQTVCTXjiPRQnM=;
        b=EbxHpWkyr8iFN4Z/+m3brc3PCdxEtgDcgAjWUYQ6hZKKjKEHWOfHmCQyOkO061uEAL
         s+gql+HSOqXJ1rYHlCJilVT/lt2DXetcVKNhQOh2v3+jK8oUNduqssoY+54Q+aGTd3OC
         jEUwJlY/8XkHg2G0DqXJm/OfYwnAl02n+cMFp9Ek7XUMPJW0oi+V3u+Xx0g1QiVrNZ8Y
         56Q6cVqNd1hkUOwaUNkwD4/8T0tdFX3Dw8U/QeRupz//56DXRzRfbhAbVP95uTq4tk4k
         Q2pqfaGXnuwh5GG5IvuGmh0f1C4frZy8A5k2goC1I3ixzTxSKAnZeJWL4eYFK3UEH64o
         yviQ==
X-Gm-Message-State: AOJu0YwKirMBqk9r/fL2K338Z3/TfexvtkYTKvz3Z1ER0NzdqIpOu2h5
	D2K3gpR+IgiRxJiKQ3dF9RbENI8eAxRXVz0rhZFPcd/Xc34333/xi5juioP7D463y2M=
X-Gm-Gg: ASbGncuYNoO7tNnxwzpyYfJJtoak/l3Evoy8PVLsb2cx5QEwZyz9UxCxg3YdNeeD/x4
	ci5R1nc59ppjiKcC0MPrTtwjtOYN6JczIvkKFJoupZTyzXSGx6zfIoEZ7EdKHCQlkFMiHSWu6eX
	QsZ9ZnhyNHUfKQYVTTIpiHWLV99/ktZ+7QiSDtBPjtwAWjKneBNIZGz1/GmRt8EM8IV2DKaYCar
	WfESUEnGrfjL7O1wU9DU2K+g7Gi9tQf8xixlfBdvgS71L/EaUh/VnhmdWadX5tnVxdVtJ04U3Ed
	1dCjZhV/4Fhvn4tAhhDDGqHOZJJWQURIRYemin82i1LbYt/AEuPvTzBc3NiC3n8RNabTHQpoaVK
	VKwc4TbY8+IxgGd1NcFYnyRPRobneSjTPCPc3ZsLxmhdNE4vNIh0dkueFun+X/kQHxnnaVbqAgq
	Cr/PlEAFMnzw==
X-Google-Smtp-Source: AGHT+IHZyxk+kZ7n3rFj6tDtFYVDJ76v+ifqvF7+ofV/wgR1Z5viCvG2a2JUh6/y2oi4HtsHAUqRNA==
X-Received: by 2002:a05:6871:7283:b0:30b:c9ed:7f91 with SMTP id 586e51a60fabf-310aaf7bd7bmr7700347fac.31.1755530218704;
        Mon, 18 Aug 2025 08:16:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf853bsm2713127fac.32.2025.08.18.08.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:16:58 -0700 (PDT)
Message-ID: <a7ce7e35-b761-49c6-9e8c-e3f849fae846@baylibre.com>
Date: Mon, 18 Aug 2025 10:16:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: ad3552r: Fix malformed code-block directive
To: Jorge Marques <jorge.marques@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818-docs-ad3552r-code-block-fix-v1-1-4430cbc26676@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818-docs-ad3552r-code-block-fix-v1-1-4430cbc26676@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 9:44 AM, Jorge Marques wrote:
> Missing required double dot and line break.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


