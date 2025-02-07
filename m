Return-Path: <linux-iio+bounces-15153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A13A2D1C0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 00:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5A67A527E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799631C6FE3;
	Fri,  7 Feb 2025 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI/RxAiu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F98176AB5
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972120; cv=none; b=V9/N11QsTGOvV9dvKOzitGZ5OqvtY3KlDasDwkq0j3YCxblUJ6lPf9vv7vRHQUC+eCyN7705o9nPJ727wxuElmI94193pf5pA2noMKX7QKF3vhOM9VwW4DaCZHItKKBlGVdZxuD/Ujn5enfcXmiMhQ3SeDo3v55/h+t1lUP2URo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972120; c=relaxed/simple;
	bh=/JAs+FLF69klpaokjEZEc0d7BUnLnEsy0tGpGTYIYQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJKWfjLcxx0w1JNRghoBmnPuHak3DP7VlF7Y5+Rq6bwYqpK/m2zLU0nKxcAW+3hlqov22ELVqxCyRjQD248c1SgRD0an3jX2Fp9/uVEhYZpwySDAEmuEdOyPPk92Q/QKr43ys/DM5UkB+nj17Ab48xUSwF1/YzIhy3YuRaFdcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI/RxAiu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso453213766b.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 15:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738972117; x=1739576917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRPQNWWCg36IMGdzbC3xNUBx0Nw5nQ5pWkfefs2azCQ=;
        b=QI/RxAiucG0Ux4ORxgjF3NbBljBIfcckg3Om9c0dOlt9hRMhW2FydhR18QSuAc481j
         UsXh1FsW3t2rTWx19rRj7t8V+p/N06aP8PQF1HDqBuHUFO0x0QqB+tbW/yWG4eIUmfBg
         B3Q7YRj1F7ylzFEXc7ILYRS0NWbwFw9NJRVFm5BifOvD7k5VTv+k+OAyWXmfbZVqUj9s
         jvPi9oG9m53KsYkpVfTRc6clsIpht+vymDQd+QQzYZmsk1q0CIYgY3xCP1rmR7i9+Z8k
         qgOJL68xOfZeICa/W2y17V9kr14HI3QDSG/XpwC5maL4ITKTiwW/vZUMS+Vs567H++kp
         sdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738972117; x=1739576917;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRPQNWWCg36IMGdzbC3xNUBx0Nw5nQ5pWkfefs2azCQ=;
        b=nmaHAsB/5AKWyMvf3WzxJ2R12gW9rkWKAtWsCHJs8sa7wyVhVb4ZtKeJHoWBGVwkhJ
         zDEU6rKQJ3oO8i8QEYsaGruJarY5rzpeVWZH9zQuY0CihQa1Ag/yCUljUOcwFTJ8cgSZ
         d0jpO08KonBXb26+zjG8lDHQUq68I430JOav9r8cdhc43fs+DFEXt/tl5tjjdV1LjPJq
         AbWfq25fZBzZBuZ+Nry0HlHLcoN35o86UNrmVTH0zsu0mud6p31J+FpiSxxNUrMidmYj
         A2jJJfadAU0opldwGtYBEFzgAULilwrRGqNC1QHrxq4sS3TeOJ1QqFKrFyr6g7yp3GLP
         aV+w==
X-Forwarded-Encrypted: i=1; AJvYcCVCzXMYBrxV61QXEwVWkrSrLTgGegzfBphdUuBlIJ1zJMubVDEPm5AaFZc5zJqfR8GrwgLxRzNVVx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXlI0Wq8Is6IEjoobgPfcmsuhfMYtNSMgf4M+9sDk/DJx7Pvw
	EFO/1kXk6DDhpNlvHsbikumJrHyIscVwWyObEGzfHdhvZ1MTJkm3
X-Gm-Gg: ASbGncuWjbsCRiRou3XDky6suj4EL4K8Uz02kkZPXA9Ewus2k92F8ueDssM4P89TYFP
	x8+fj4801RssBXfhdEg+d+DMqgdFXj7jBTBF0Uz5eKzDFNcphPRdaGdxhH2/D1Lo6LS62LUuNnC
	hzTqUUIHzb+CSVKjXmlMELkWAY/G3eUyrCaG4cdAkw7dysktrEqa5w+6cyBmcQ85PfsoBbyR60A
	1gbIy0J4TAusCeGn5+6j0C2tGMTtqp/YM1I15Car4lIoA25W1CHaVxPqI08j6enkDHTUUucGt5o
	rjgM1Kwk0b15X0tkpT3ltychdw97Ww==
X-Google-Smtp-Source: AGHT+IEEiSCQnABf2U2kKqL08XA5otlDJ1pqRu6c2os2lwR1gomeMUGXNL1UkPyMfJ+px3nMxJFNMw==
X-Received: by 2002:a17:907:9484:b0:ab3:84ac:4dbc with SMTP id a640c23a62f3a-ab78979492fmr513547766b.0.1738972116512;
        Fri, 07 Feb 2025 15:48:36 -0800 (PST)
Received: from [10.199.205.98] ([148.252.129.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79a07398esm62963166b.40.2025.02.07.15.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 15:48:36 -0800 (PST)
Message-ID: <adf4f042-a4fa-45da-9d83-80084b2faed3@gmail.com>
Date: Fri, 7 Feb 2025 23:48:29 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mudit Sharma <muditsharma.info@gmail.com>
Subject: Re: [PATCH 26/27] iio: light: bh1745: Stop using
 iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Julien Stephan <jstephan@baylibre.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, David Lechner <dlechner@baylibre.com>,
 Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250204200250.636721-1-jic23@kernel.org>
 <20250204200250.636721-27-jic23@kernel.org>
Content-Language: en-US
In-Reply-To: <20250204200250.636721-27-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/02/2025 20:02, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mudit Sharma <muditsharma.info@gmail.com>

Reviewed-by: Mudit Sharma <muditsharma.info@gmail.com>

