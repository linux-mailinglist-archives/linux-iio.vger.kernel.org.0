Return-Path: <linux-iio+bounces-14949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708EA263DE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBBF18834C7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F620CCEB;
	Mon,  3 Feb 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DXYl5a+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEE209F22
	for <linux-iio@vger.kernel.org>; Mon,  3 Feb 2025 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611593; cv=none; b=eC0gEqfJPGzbGiYff3qdb6dZgwIxdmqZwcL6VWzMu7Vz1AhhX+fTCgjyAofaR0ZaTvcU0GDeuxIFrObKawYSZgzZdDT90bRafixo4Vz/pehBsoA8ReiZdviVxwTF0F8h9QUTb0x1tBkACcdbw2auWkeNYZHhfaUhOlJwGuBLGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611593; c=relaxed/simple;
	bh=/nukz/GWXKZKSnXA4M0zIsiw93sVPIl9e86Sl8alprc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOpmHc59IXhCKJ5arKlFVO7jKvPvFQdsC3WMzl4HavHapSxOuCySjGk0NFfD/fQtclpilF/4AWzlhm28Q3+FfpvOy2il9ck2gOzr21mfLju6bFNpyPwGl9CBfRx2R3qL2JVteaGEWT0l8FOmUEVxpwBb7gNqcth6PYwV73ft3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DXYl5a+o; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a0206590a7so2629932fac.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Feb 2025 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738611588; x=1739216388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLhKJbpbcl0F3714e9Wmp/i7a0BEVMhErOhbjcvQ7kQ=;
        b=DXYl5a+oMMXofEHcAXfdG5TLGzWFaLn4Spt6/ZVpsV5Z9TcNm4/k8hbCkJHmwEIpuw
         xE6VIk+PVzD2GCN5Txn5Bg4EPWjrwPtQxfkDF3WSFV1fN6h4wLWFL39I+ZaOR726yU5T
         yXAse3KwG2+mARuZkdWKcj5Ji2xZ5zIL3Tb20BAk9dlV2YlVm01n66Lc87IzzTN7FmIj
         JTBRPnxf8mYKYCC0hoVIwYhkmmVKH/YIedzqf0kcQ03Ku+KNvzwcnkpWeVE8lzqXH4DI
         muFOZPgAfF4MXleeyhChBq50TOTF3yGCvJbZOHO7z7rUHSOlU2rF+epTol86ud5TRkhS
         hdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611588; x=1739216388;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLhKJbpbcl0F3714e9Wmp/i7a0BEVMhErOhbjcvQ7kQ=;
        b=aYK8mX5qXr23nnClXEqy16QZv9OJaRAvbhr9woHGjhIo1/lUwpPer3KcLjSfG6QgIV
         5a/JjkDrzNtx6xh8hEK8AYIa09ly+LSrANSIylpEHBeJXbcIxCFMDCTmvSnT+OxJJV8T
         PMDdKLQUMEoKumrSy8KLmglBXfIHKv4kd39MRsKJPtC5yfifBIgob8KFWfsO6ag6P4hc
         yvvkKDjOqzYPoRL0n9P82fjDC+p8Qna+2r+hqxt2wuCHk1RmEAqIw46uJTIAOZwGudUK
         X3CH8/Rsky090qnmYupP8AQ28R0ABH+MSQRxcz1x24IzECR6M5DXZSNG1PZKi62bUmmC
         8f+w==
X-Forwarded-Encrypted: i=1; AJvYcCUEKFUMRQHs5JKI+ZTv4956cGVLxgr36MK7D5FWhKuhHeK36sXdAlTrr1KTaPRfRoOLNTQ4C9BJWbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6F05hoS6B6PfrrsQR25nLvosKVqMqiMxMTheP8KpxfAf64DL
	V0NrB1emFOsfStWyQDXFZ9y1o6COPtHEFw91TF0hsfoiWTY9v+5BLWTl2XwtHZA=
X-Gm-Gg: ASbGncu85MUP+BimTHlI7v6hbihFpYmg/R7p48V1epT3w4yHsjE1LM+HDn5WbY/eE25
	xZ263bF750GBzqLx7t5xZtLQXjj5rs1mFla81Gy2p9IR5hmcDRAqkCxG2aRW3i/01DEhRBO7nu1
	5WId3qnm3wKhuOJsXj4sTo8U4FikpPAam9CVLEBtKv6TwDx/xP10AcV39ZlvnObyFuIX9SNAv/D
	tIZL+aaYhlia0tl+Xs5kscBjm/6wzORGOyWMrjMUv5p/+xoGx5UIXart/a3t9yAeTadJEWLI9Yb
	YmybMzhBsfS9rRW1zp0kmrVeV3+CXZI/7L7HzEqo0ckUfstEBPH7
X-Google-Smtp-Source: AGHT+IFfucymIugob4KH/abdiJ8VQNg7Vw5VVSmJVGXkdTO2+o2v+fhCLzJBh3eeVsgDk3LVoCc6nA==
X-Received: by 2002:a05:6871:a0ca:b0:29e:70c7:a3f7 with SMTP id 586e51a60fabf-2b32f100b1amr14887069fac.4.1738611588131;
        Mon, 03 Feb 2025 11:39:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b3561a582csm3488650fac.13.2025.02.03.11.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 11:39:46 -0800 (PST)
Message-ID: <06a2cde6-f725-486b-b3f9-beefe3c227d2@baylibre.com>
Date: Mon, 3 Feb 2025 13:39:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Documentation: ABI: IIO: Add filter_type
 documentation
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: cosmin.tanislav@analog.com, jic23@kernel.org, lars@metafoo.de,
 granquet@baylibre.com, u.kleine-koenig@baylibre.com,
 marcelo.schmitt1@gmail.com
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
 <cd749bbbf13b27caac5734b22c716124565a7216.1738608986.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <cd749bbbf13b27caac5734b22c716124565a7216.1738608986.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 1:11 PM, Marcelo Schmitt wrote:
> A previous patch added documentation for filter_type_available attributes.
> However, the description for the value attribute (filter_type) was missing.
> Add documentation for filter_type sysfs ABI.
> 
> Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

