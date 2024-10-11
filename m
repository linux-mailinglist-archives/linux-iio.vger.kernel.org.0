Return-Path: <linux-iio+bounces-10436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6599A042
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31ED28568C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369E20CCD0;
	Fri, 11 Oct 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dktjKo+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19219413B;
	Fri, 11 Oct 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639509; cv=none; b=jklCBxFFelMStRxdhiyUeAz9vwE43GLzne//wDHbaC1SwtsqDu9Uu3wtBSV2lvoh+XrpJTYfwAhFCd1o6UU8AEC1mACmmQy09T9zmzThrxc148ZF5gEE7WZ7Uep+VbxpBmfR2CSMHz6AYQ20QZxYma0DIIhUcI/hj+TCxDNRySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639509; c=relaxed/simple;
	bh=5Mf6GTx8csDzpA0mkUaAeMnX4COPNsr4k4vKRhcmwdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZ+9x7bONCa0ltWfnq5dV0qaQnNgq57idHpp32tBKm5djy4mF3nTcg/pMprICJ71xp4OPlNZ4ku56052cnZoqTelTYq8AhMLxVEnGtbutPRu+mhzQAjBIbJmtNbxkTUbPR+utAnKl+451YQoqaO+1HPFjIopL7Z5ZEAPzZwfiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dktjKo+C; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fadb636abaso17473271fa.3;
        Fri, 11 Oct 2024 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728639506; x=1729244306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8r+1iVRMnmJIUiFNrZEr9E2TtZ6NXmvUzynyAR8gNzk=;
        b=dktjKo+C84ulw8cK5K0nYVFv01MoI5qEJ/S7ba4S5cvP6OX/3bX8A9zMjCp/1V4QbN
         X2HzJ6vgz5oS+1y69efwdQjyhUH5tKU51VaJ/AUPaKWcvOpI6EuqgNLwSCDPzLlrmIqi
         69wZ+TCHQIYpbvvL/XJbPB42BA/K3id2yEtTWrqP5WvJu4wlYwDc7Ex0pgNtVsIvpwCW
         uCNJPASZswMFeU7Mf7XPfpmp1RCSxVR2ij1LCXwkhdOsZBIRaf3qfwDaq9975IRKWMEV
         gCWwgLH+YPYQDh0kwDCY5Rej+h0MtgAf9iliTGZNextoXkeRn4gJ+HkiPsOpvRRAyvoP
         p0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728639506; x=1729244306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r+1iVRMnmJIUiFNrZEr9E2TtZ6NXmvUzynyAR8gNzk=;
        b=Oq8RYy+MLifRsGAzmWBI+NhqFwewtVu7lF9ULdUf3Q8NA34U2zF7ycQiktZxXxkn7U
         hT/gwI6Xg1vnsP2dVHggemQxDuEeXNpY9S7SehUTvxpd7w3P/FS9B8pLKSDk2Ua6WHxh
         XP7yhv5P/kRyhZ0rlqAvYwX4wZxujcRvS8QfFwiGg3mlZUooRHoJLaDdSpTgvEdMAsbF
         AwRzjL3z/Z8Bf1U2Dh2D+En14IjZ1PkJCB3VtvWBmQ4nuplBIZxrIGLz0axhr0jHbIS9
         PRIFDQr7kMP61h1nqsrrjIyzRW5Kg5M9JEG6RzVa7Z+6wrTK72SACP9NlVA2AsW1Pu5b
         d/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpMsA+zDn4GHGx9DKMxzRq0t58vswCehF2lx8KMn1M8jXsn+whRA5Hvcu+SsbvKhrbJ9JJ6d+SLeq+WVKG@vger.kernel.org, AJvYcCXj0I16QUvvay+OFEJ3X7KNHdui5qfL3zZ5Agzk1vlD03MZczaqH0sbHZ+ieB6jnu/KlRExHD3YUdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6tBaSXp6wg8mq79jj+66uaxWxozCLu29zryAtpGR0kkYRBvB
	zyC3nf2didiFiPK/mZLtpkErhglwGsoDxylzK6YY1dVF9YRnTnk7
X-Google-Smtp-Source: AGHT+IGw5MBgmnuIvupXeNOP4bZISFOrfHflAPRvqs1fZVAARZdwD1vFFpWIBK6VL2xtLDGzerIzqw==
X-Received: by 2002:a05:6512:280b:b0:536:7b56:6b90 with SMTP id 2adb3069b0e04-539da5a0813mr836680e87.56.1728639505883;
        Fri, 11 Oct 2024 02:38:25 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e0f8237fsm96293e87.308.2024.10.11.02.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 02:38:25 -0700 (PDT)
Message-ID: <e69f7f8d-33e5-4511-ab21-aa7a88a2d4a7@gmail.com>
Date: Fri, 11 Oct 2024 12:38:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: pressure: rohm-bm1390: Remove redundant if
 statement
To: Colin Ian King <colin.i.king@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010170835.772764-1-colin.i.king@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241010170835.772764-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/2024 20:08, Colin Ian King wrote:
> From: Colin Ian King <colin.i.king@intel.com>
> 
> There is a check on non-zero ret that is redundant because the
> same check is being performed in a previous if statement and
> also before that. The check is not required, remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@intel.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

