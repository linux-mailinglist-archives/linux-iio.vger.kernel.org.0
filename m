Return-Path: <linux-iio+bounces-22992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC71B2C7EC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF967BF5CA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5527F756;
	Tue, 19 Aug 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P+UGCskE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D027FB1E
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615449; cv=none; b=SPUmIkN5CNc8g5OwodMncYQOyp+GmHWY1Yf7UrLjFO2BrJRdl+SX1L2Qq64CrE/DFvH8UCzNDw/LpQFTH18sBuoE3rdOiVTaF1ehQe0L/c02hEJCis0DV8joRcMzD95R0UaokhXHJZfkZmhdLZV978/fz7xqDETYcUT3ec1n8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615449; c=relaxed/simple;
	bh=7EZJU8EieTZCa/QAirNvhaC/lS67AJjOcGCkNE4mpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qROqqHalOgN9+2HalB71VpCtED2FfEs+vVzdUrQXnIBv9pwdXu0N8sEDcIlsK4Cj6Fd1X0ZAswD/G0ipEZZeBcdsZn7qO9PAwPcI3VDpqUHzyyHY09QBJdcv22sqq3H4kW34Xj1stWmED/SqXd+SJQEhH08tirmKtzO4HqLGc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P+UGCskE; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-435f98e7a51so1187011b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755615447; x=1756220247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j33DSRA1EWH9BS/A4h9RpWvd4kG0MI4exSJuHlC5IE8=;
        b=P+UGCskE1WjuiKE0pLB5MUSoaUAj6INjm0wy4K99rcn303ZEA0wnl/TubSUJq/uiPf
         IeSMXmyUtSkOHAItbuHnoFOkzaQnbvf0pSp5JRdJ9d60plMYMp7B+iqg7HEcl/OvMNpo
         k0jUgJQT3T7Dz4Uo0BhQvXd4Gg3aj9s7IfvdMkAIiynn7+GLiM+OBwNAtN+5kdFRY6Ca
         nWUf7yrVnD2OEjGt51nnb2F0QQQ1eSH3Kjs4RhxyDh1AO5LidmcYJF3LjdWQmh8iTHCs
         vNPLu8s3tdjtyGhf2BSE0IWAchQHzT7Pmufpb+LUY5g3vq6UZxSG+hqOJxEI7jk1lAF5
         2/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615447; x=1756220247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j33DSRA1EWH9BS/A4h9RpWvd4kG0MI4exSJuHlC5IE8=;
        b=bTui+mCLaY/lFBhRJ/p3vKimP9gM42WDc0PV09hNZsjgcF0udQlhfK9zX0owot2gMw
         7BjdNR6qCfHhkNCfQOyvlheMKzMHkR6YUoA2/G4aDNOwmuOIIiahtIxIPyPa00JYeyAY
         0aM+szOO584kDxvW97VeJwZ6dZgtXGM7ccyXaBMNp3IYLPZOTQN4FwXqHENiF/YZytmb
         2gm0JMJPJUb3Qz8Lr4SCCdlrhxmCeS8jLqQqYXoWmYclPx9Ve3JVSQGY6NQXgVptv3bR
         Fk668XG8XtbJ7JtTFsK6BNaSHYotocurPDOPpKsa7FfLgHnLxU7z7gvsrre1IDKsSXUh
         A71Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+OIuYvtzIB3b0QxjdsThNHAuL9JRe/bFWuNXyj2l2PDyIofFC+1uj/nGD973IUOHyWawLcAaddnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUo1KoFjBIpKXSJmIkAaSwStjw/PEtHETCqEbhGdsJgGZU/wI
	WeiPP1lLJxRETHwdUkRyQWKqbV3NIOUCklYsII8MsRk1D2N0EZrND3Xle9hvZLKZpUs=
X-Gm-Gg: ASbGncuPetjiB0o6K6AtPyogGt+9RVKLpoDX3BK2ZBToAeeCI52bEObz3JtsYZiJOXu
	gqaEMx2OE0t6xOJmJRb+d276hJwvWeWGfPH2P9jw7WsILECn5kyFaBKN6L/2rFNBzwQnR/zISM1
	rEpBLD7zm/tDdkEXU2F5Vq77LBcZSL1s/bCiFbWU6l20yOHZhOwjOHOFMWjxyotC7AnD7TX4dbc
	mN5qqcj4aXDPkkC/fL/29cIkYgGujXkkM7iyfrKsk+FgDKawGdG73FK8X7eDx+Lg9yb4YRUQN3z
	Ans00rm6NwQdYbuYlY8WGtaCNTrYYU0JcZ2mQQ2UAkJckTMuJBmbDEJFqqZ5mTP8MrBJHs1kTcY
	RGST6OprLq9cYxal4BHxzltCz1QexdslaVSuxsxkNSbIwmxAKN9e1rVTy0Vgi5gRt2W7wPvCQJ3
	A=
X-Google-Smtp-Source: AGHT+IHPlSLH6hZeAeLnJjJgwE76N7/FQQiTxPqI0a0U3Io0rzBzG0AsFNUvGq8BqYM0uzYltC2DgQ==
X-Received: by 2002:a05:6808:1191:b0:434:8e2:33c1 with SMTP id 5614622812f47-43738c2d23cmr1484476b6e.10.1755615446945;
        Tue, 19 Aug 2025 07:57:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed205941sm2284247b6e.32.2025.08.19.07.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:57:26 -0700 (PDT)
Message-ID: <a9724713-6787-45e4-95e9-f020e5e510e7@baylibre.com>
Date: Tue, 19 Aug 2025 09:57:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iio: mcp9600: Recognize chip id for mcp9601
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-5-bcollins@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818183214.380847-5-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:32 PM, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
> 
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
> 
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

