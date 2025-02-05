Return-Path: <linux-iio+bounces-15051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DAA299AC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AB2169E57
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8821FECB5;
	Wed,  5 Feb 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RuhOPjtA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C9944F
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782286; cv=none; b=jeFTxVSCyU9u5jylVw/XWBkdJPleMsMb6Q0NswwvalXU13j7QV34XROOToF0ezm/T80Lw/MxMl+gWK5qCLIpXpWRs5gbR3s6SWgMIcsfV1s0kfonNvEHWgMUNCN42QnybVfTVsaPd9r5ajMlfARjX8vC64XhAPclJ8oYTXdQVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782286; c=relaxed/simple;
	bh=RxNVALwyVubnb46RhavBKviuMf6Kil3QuuTLAp93B+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsHvfATxr5WSOHpJW2fMLVUf9LZeO11Den6fbgUH4mlWeOAZzgksXkO8VximG21HRhMhIqDE6MuVY1h/gohHlPaXYVXuQoHUAy/+Gqj+E8e6cph95PWYNkG9DxpYxrhn08CCHkiFPgnHhm6YK2tsRYdcpggRhetAk9DBUAv0AG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RuhOPjtA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467bc28277eso1320901cf.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 11:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738782282; x=1739387082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxNVALwyVubnb46RhavBKviuMf6Kil3QuuTLAp93B+8=;
        b=RuhOPjtA8JcB+38VcYTDMuLF3wAkeXH5U/dPNzUDfhcEsAYZG5FmKQhFEsbU9kL0aI
         ho9akk64IdbwkHeC/MZ82rSqCG8RYFBm/m+L1bw+lYa8V1KfxIa8SjWUN069BxTeq38y
         +tEXHYBoycVAOdJ7zyvT9h4erjQbeMOjV7OFzxCcucNzCWzXKcAsVNYgA9ZkRdAWktiK
         oPph9A/OmStYVFF0NnKseX4Swgrp3CHuBvc1563FdR2KD32/dTutDxRORUnrVFc7wfME
         kbmRAJxromix+amBqfuyEEk45TLI2J6sKc2BtwD8+mbu5fMu68HxFUk/akNk2E672oy+
         HJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782282; x=1739387082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxNVALwyVubnb46RhavBKviuMf6Kil3QuuTLAp93B+8=;
        b=KHpJaqlwNFKy/T42SWIj3SFZUYPCOa8tU+MuaLPFYnhXVaExQjZbbYT/0DFlfnXDh1
         XG4XpXK0nuQeGuOvdYzwuWrSq9sZCCqXaxRICv45P+nQRES1i45bSc0UNGpbzh21arcD
         4zhRximvgVwOVRE5VvR2Yz5kRcTBG8LnfLVkB8ihEhVb64iEfQU5SANabqqMyHi+7UNO
         QcwJcbA1wuh+QnTj7wvp9s0c+8CUvurnrEYxr1QMd3vokcTc63lDg2cZZdEpIWFs5UsB
         EOhwrv/G8JOwqXQ1qfS6YVhSN7Nsm+HDl80eeoj+qoqa9AXSgZuapNggFa6BwOL6YX7S
         hXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk/JvaH1NPTHySQtpI7ms9VThCKOmaLf3hiN6kMRyW0c9Wm5qNy3f5Tr8GQnck76U5a/TxIZVYPro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1jfElIGDzZ4B14sOpkaSEtcEMu34isE9nAGqcu/6GbpsO38Y
	dfrQpMIa1J4jidxnkgLTt4/dsqbDhA5R80m4E/dYXlNTQrswbs/1heRNDKV24WE=
X-Gm-Gg: ASbGncu/aRHyghP2PNv0BzxV7/dV+XD/FzK810YjXS+xmypEyYH+3jA40ygmFTbU3RC
	uK1A0X3JfiDDVMAbvLqxXY7MIbnqPiIKTpmOyY0mVi+Xd7lG7s8SOPOZI0c96HXnOAKUe+lB7lP
	Wsh7OC2LUxFvflGFZCDO6Jja9MiKm166h3LZfug7sOvFOGqEw5PljPToYjLTJs8XlEMUynkeRQV
	6uwujGHdNgH3NxKGM5p9W/AI9Bqd4PqXIImmpjYm9xxr9GrIqH90Ud1jpplNHB5sB2gO1AEYstC
	ryKnV+xnDXXq7TtixUHG3S9M4kj8nm+y+om8db+Nj03ca0s8BRu6g378fgg=
X-Google-Smtp-Source: AGHT+IGXcywJk0REnE5QaO9od5+htPtcYJ6vjJqAeCxg9vdAySJInwEg8QoUKbbuMSQdQ9bydkf/bA==
X-Received: by 2002:ac8:7f54:0:b0:467:4b94:cfaf with SMTP id d75a77b69052e-4702831f0f9mr52065611cf.51.1738782282151;
        Wed, 05 Feb 2025 11:04:42 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0ce770sm72472081cf.19.2025.02.05.11.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 11:04:41 -0800 (PST)
Message-ID: <040225aa-1fff-4c73-803f-134338273ca0@baylibre.com>
Date: Wed, 5 Feb 2025 14:04:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/27] iio: adc: ad7625: Stop using
 iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Guillaume Stols <gstols@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250204200250.636721-1-jic23@kernel.org>
 <20250204200250.636721-14-jic23@kernel.org>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250204200250.636721-14-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-02-04 15:02, Jonathan Cameron wrote:
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
> Cc: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

