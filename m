Return-Path: <linux-iio+bounces-17517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20974A78102
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E9E3AE124
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9AB20E32B;
	Tue,  1 Apr 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dnv9sZxA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C08156C62
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527114; cv=none; b=MhnKFcFg0eYGvNw5TGHldyWyz4DJpky3RPSbcef/oU65OWk4eEfSDnk4FfEZA/Pr1YgO+MxGstyQuBL3jqWYbCkJTgXw22Y4ds711NvubfGhe4LKJxtLHDFCtgB2UZFBD4xLXqWc2VbTQ/6oMtf1nPQx6h4VfuhWKjKN1NiZpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527114; c=relaxed/simple;
	bh=aGC9dm6KUtiiQ68RVH7jvL+r6CQi36l1rZPcfEThsok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6cBN2h3MObIfXnhni4jVKSvcamFBZs6zf9Z2q14HAiOh47BYjfZZKC6+Q+DpmaXS6BSVWzBBstI5Ilrj/kkwyslyfJvwGtzXwVyAXiCNHu4YpjKGKXqAavHRPsTIcklDwehoO0tqD1+8rPGmvAQbJxSihoN5QaXwfCn08ENxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dnv9sZxA; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3feaedb39e9so1881024b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743527110; x=1744131910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GHNg+GZR1xh3puiq8oEcYCi8euQPRHec8+8+bjsNQ0=;
        b=dnv9sZxA4Fbtq7LdaMS4xRm7tsqaxKj4NjytCh5QzWIELI1bthtiByDtOlxGXjZkyT
         yK9E05l3/Z3h7AmEFCDtZfyCdsPBqW/pZD9OVUJ76GyzwDLQXG59b+FZTDszw1Ot4TpJ
         2nBAFaTuJwKTtoTWDQ2lguABp7ZieQ4pKJzlDFrZ/5AMW/zGrMB4io4Gg8ZALMSvvibJ
         0WZFuHR6cKu6BpR36PcZhRnxujqcKVfgLCMqzE7BMJ4/fpzy4YYkLlYUP5Pa9P1GthxH
         XybmCVqHldrPaasUoLN+N2oM+aMU4a2p8/9raXDLwznu2+6hkhVy9HJJY5EmibWbZ9W9
         zdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743527110; x=1744131910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GHNg+GZR1xh3puiq8oEcYCi8euQPRHec8+8+bjsNQ0=;
        b=d1N2EXU4s3ofV/Mr6TyzoIr65fmy4Yu8eZ46BbghD6LQ5xGJimrQKQHkWbByPe6J6G
         cLARLNvExWiRPdWeqpoUS4lbJJ2sSCmfO3gsNiNLqrVV3oVKTdx2NsSItHMDH45r5NtR
         FDYrthp+yYfX/2AhcG4HNbatl9B0EjShs+IDJ7hSW6Grr+OOwtOH5hGHZAy3QelKFsKB
         9AdBrT7H8JPPQ7hJWT/fO9TaGn/MIBrdwvqOV0NnZj/N/kj6eoKpmtIdO+wUvZVh36Mj
         ne8SXp3k+L9AsZ/QqCtAurMeOOzKMSquNRU3oFtM547MeWJdI0xxbfzE2rOq528RHJ0X
         Hkyw==
X-Forwarded-Encrypted: i=1; AJvYcCVta/aKTSMIeIZih3BRuXNXfXnT1T4CVd9w50rIiq053BLW184xHGn7RMzxC+YankPo41aVkltpFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFDNd1YnhCIctJ3O5RYdcg5iSAB+ad5oXBduPw5FP2GtTxxoD
	C4k7/Q5rdxC+ULx2YwqR+ynMpr037NqlCtiVQNQrxBm47cH6PO0yPPQBAbUsBy4=
X-Gm-Gg: ASbGncsZ/D51/mnaQhRsX7z2jtsvthnoVzbPvwFHyFhZnzMworkf+lkbn41W2ko+2/o
	JpmC0Snj22jH0+nLfb58Zt9ME1YXQROSWdYxpTMQX4Kft3toYy5dHxrOtILDuA7HejnFmwwt7mS
	+Hd6s8QKMjPXpYvyXEJqFTLRv/j4yQjqBacjrLPMyEc3fwrxCJqWRYbU7CUklqwpsdB1xDddgaF
	+zFO6egf53oje+8NbSGjBK/BdrjTZlPTeUe2PKmNuDEyHE7/6wJWOo4hHv2RihjXG7G9PGe4ii8
	XEMDsKkM7SSfALfdVNb3TJc4JK9u2oa5aNpUMuNnojm5vNXEPw1bvr13aP4KHHNJMe4gUGLb+C8
	6GlbWIg==
X-Google-Smtp-Source: AGHT+IH8zT9NfafTp39gA7w1GuQhxmWEGB+Q5BcMBLrZm7s6gO5+wURUfgUr3IvdChYZ47bg36HrsQ==
X-Received: by 2002:a05:6808:151e:b0:3fc:11a6:7433 with SMTP id 5614622812f47-3ff0f637b5bmr6831543b6e.36.1743527110260;
        Tue, 01 Apr 2025 10:05:10 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff051aaf60sm2022138b6e.28.2025.04.01.10.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 10:05:08 -0700 (PDT)
Message-ID: <df59accd-76da-43bf-b52f-8ef5de0db060@baylibre.com>
Date: Tue, 1 Apr 2025 12:05:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] iio: adc: ad7768-1: replace manual attribute
 declaration
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <6d429bf18851e9e423e90252d351db550b2da536.1741268122.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6d429bf18851e9e423e90252d351db550b2da536.1741268122.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:04 PM, Jonathan Santos wrote:
> Use read_avail callback from struct iio_info to replace the manual
> declaration of sampling_frequency_available attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


