Return-Path: <linux-iio+bounces-6799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A81914463
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FE81F235D1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90444C637;
	Mon, 24 Jun 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoOyZ7EC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D384AEE7;
	Mon, 24 Jun 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216967; cv=none; b=B2M+G2A3ygxPg+rAO5ERNYR1OK4SsGJUrlP02fGIezM64BgwktGlPJWkKdBrgOeaQZabVqEkf0s6WrQNh69e2rw5Fht+QWX99RWoF10DRZocTRd9k6Jmo0LAJH0Fvpp9Lzt1gngYg5j72GJ+ge47uQ8+LRoaq9S4IUZ91UiWAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216967; c=relaxed/simple;
	bh=anUx2BNECsYVyVyl4y4fqgu2nK2IHw6PKDfw8bAQCPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byOwJhSOBC1xCWoXvaQXZZ3Y6dE+EfPA2/EVjjKb9XpPS6yrbw3hFwvqWxFh6mxXMN5YXlSy/EpZ2mms/DR57fps1dETR4tLXO/5bLL+xOWi/654xyHBc9xMep3CFMchwYuvyUgsBn7mgNJt9GOqaC1bLqbIkGNqHkg398HfeaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoOyZ7EC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so23040915e9.1;
        Mon, 24 Jun 2024 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719216964; x=1719821764; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=anUx2BNECsYVyVyl4y4fqgu2nK2IHw6PKDfw8bAQCPM=;
        b=CoOyZ7ECx+ZhTCREO3cJwuJZLshwFn/MnskoA6Q8n13Bj71jKtoIsgqP/mc5uRz3kj
         TwJPSLRow8v6ANevZAaV9AxXBOOwo9RhHjompWLjytvDMNCH7FzU1w0sxtUVjVXH8bcw
         zTPUQg9CeoTVPN6ffK79qaJD3n3KVVdkw26j6lAgmCbuYWg8w9YBYQNDPj8gtmk0q+dr
         f6hO3d5l9FqLTbraHUa1ivPxhsRSSDuHjsMsy1IyhiZCEBJvwNfp7fH5ZoA18BNyQ4iW
         P0Xo8lsoqrMBb8k9C+MOPt+hNlOSnKjFP57sjTRUNUp8aSYebOOIrU+JArhNJCdsk+eA
         tgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216964; x=1719821764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anUx2BNECsYVyVyl4y4fqgu2nK2IHw6PKDfw8bAQCPM=;
        b=QEWBIp/SbpSPPlK5mAhYpTZMQHNgj3caNGj5ICot3PiO9cqYS5mlL4C6jE1R1HTWVM
         Sk3d89JIOSPKJX/oJA9Dq8w4TVeFMs8Q1QcccXB/Kzh6lLcMVqNopznMY+P4cA2AdiJE
         LutBc3BrNtk4N6Z60NzC6LFu8QObQ8cbtFs5yIg2BCfVvjM5oQ43D+GZ+EewKvbEKEhb
         f2gGmEuze8h7J5j889lA0IbKBS4CnJ9Qw5LuH2nlD6lT2wZGv1NxwNXnkN2Bi2OBWEEy
         SQqFneIYBQierlQf/e75WyiJFFIHGHEOPJOjJnlW53LT1t/0box9v+CNJG7inMH4KtkN
         0p2g==
X-Forwarded-Encrypted: i=1; AJvYcCXpPdu0bQxt8iFJVeVEPuFbyfiCBi6NZq+Wdiu6iJq2Kep58pl6gjeomM4nZrpoNwGXUPuu1LAsf6DARKRISbiQCjIsHaY4pkd6DcAhQu17CER9dbWFWbWcaTwB2504E3FZz3ApPALt
X-Gm-Message-State: AOJu0Yz5uGx/1HSPMvUV9Xzz2Ln194oP3ss3j2gsuRBRuODAicrO3mtk
	YPGTwnh4kPW6pHZb0x96o2tZIT3lPRxWJ5d5Sw3H07c0ffAKP4DR
X-Google-Smtp-Source: AGHT+IEg4YEeXdX4d32s4QZLDhL03W5e0Fpi3DQU+njzoWulsVPC6CqcL8hsNWTIkX1QTrnextuZ0w==
X-Received: by 2002:a05:600c:35c6:b0:421:b65d:2235 with SMTP id 5b1f17b1804b1-424895707c9mr48014095e9.0.1719216963902;
        Mon, 24 Jun 2024 01:16:03 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada0f8csm9279434f8f.115.2024.06.24.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:16:03 -0700 (PDT)
Message-ID: <ae9ba7ceab932277703c048d80b49af4cfff439b.camel@gmail.com>
Subject: Re: [PATCH 06/10] iio: adc: max1363: use
 devm_regulator_get_enable_read_voltage()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>,  Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:16:03 +0200
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-6-49e50cd0b99a@baylibre.com>
References: 
	<20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	 <20240621-iio-regulator-refactor-round-2-v1-6-49e50cd0b99a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 17:11 -0500, David Lechner wrote:
> Use devm_regulator_get_enable_read_voltage() to simplify the code.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



