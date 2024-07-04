Return-Path: <linux-iio+bounces-7288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B80927047
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A26F286046
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7071A08B5;
	Thu,  4 Jul 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZNa5rzy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0613E024;
	Thu,  4 Jul 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076986; cv=none; b=PXK92DyiXMKnauzBTHStb9JQZJb0wW8pMhM1yqTt3gxWQn6MVtfwX9QrEbtvoV/wqpL8uaeRByJXifSQ5FG9VUg0Tw5E9olOgvrltdQDmtLEUk9n44o1bqnt0z6263gEEl3V3pIT+lb2Kz8lV0RnKmsHI6PGSL3dHDyLgvXPRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076986; c=relaxed/simple;
	bh=TfN61d9Z+JvI5eZhDIZcAURW1cvs7TBQnj992M6M55k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DAFxyT6YbfFwDAQX1vuLQC8odb+DdiLLK5vux8WUWzujGk/DcAmwhYIjpbUK/W2m/2Y3BedVz7kuFOG01KmKTqOGP6zerrA5gVqbJVJsv3yIIYAlDGr9gLyXIWbfNdCXvY4PHwpKJ7dxj3LA/j+bDz1DVxurdrLocoS7N1P3nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZNa5rzy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424acfff613so2442985e9.0;
        Thu, 04 Jul 2024 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720076984; x=1720681784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TfN61d9Z+JvI5eZhDIZcAURW1cvs7TBQnj992M6M55k=;
        b=IZNa5rzyraVENK+YzLa2vNnHboLMLlJIP7r1jTWTvP5oDeJM9guYy4xE0IirvoUDlh
         QRNpLTF16DcKM44MIdd3mHCR25J7jCSLD9jgk6At9DRW2jzdiuN2mW/bHyNKgKUFhzE6
         RJDm1BLN5EsMkXMgIttx9FANi+Y4RAb+z3UI47cE3uiIuuo4rdx90H/ZTNC/KYymjU+N
         5Vv/D22FFuQjtxLd2W+AtdiZgFSoNcXhTp6VAolpX5xm8Gdv/Z1mPh2v0wVK+k8YFALz
         fmTfuNjAsgwU9jkFVGqQa/C71gygnSu0dLOHbDInzNi6i8i2ic1sV/DY7sN2+/Bi3U2N
         2Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076984; x=1720681784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfN61d9Z+JvI5eZhDIZcAURW1cvs7TBQnj992M6M55k=;
        b=UwwUjBuVjgJkxiDPd47mjRMLTJY9aJaYJPxFUg80h8OqhVP/trYevwlJ2z4GUTIpHZ
         CeT0dWhOHXmSBQFkW5I0MZuM5dAQs7QhIhCqhe3Nm+ITB/KbQ+W3UtiQLXf+QGV7aBM/
         PqvyuohRFEwBKvogRX1NJ6MiCnf99bP/zGSAFm6ItZSDKM419EZiUUgJ6qXW3abUoqDY
         u5rla2coqPEd5NOmZ22VeyM5qsDscArljZUXlbtvzZ8YeKLIs/lZ00o7/7K449ggw98Z
         cBK9yRSd8H60uOENLcvcP7WuXV8KvQZ1iFC7nn5aCloRUPPMSVSU9IMbhtZdRl1SkHcH
         dH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUhRXmo/pQm+3qKM2oEVFt4Sp3J9dvE1xOMvS7OhdGrh/ss0qtCQ9jSLYbIDe+Y0+ZC+sfUwFTjlFksMEgxPdI6ifeW7zF4tJsbZ6Ya
X-Gm-Message-State: AOJu0YwPNM3H+5mJYzEeQk5UhEWYs3ElGVeCU/nhmqUtE2o9EvLr1m7L
	C41Nt5OF7oPYISHfy9iQTAC+Qh5xiV/CfawLZf+hu60NOJseHRR2
X-Google-Smtp-Source: AGHT+IG48DNSbm/5dnSKa3ug3j+xo4Xg4tVdoFXh3G2cp7yahaH7vRmyEhUac+pMJWeT/DVmSARGaA==
X-Received: by 2002:a05:600c:4f4a:b0:424:a58f:cc9a with SMTP id 5b1f17b1804b1-4264a3d00f1mr7081995e9.12.1720076983256;
        Thu, 04 Jul 2024 00:09:43 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cf55sm11782375e9.27.2024.07.04.00.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:09:42 -0700 (PDT)
Message-ID: <5625fde838cc85f9188748d9e038f41ded82414b.camel@gmail.com>
Subject: Re: [PATCH 06/10] iio: dac: ltc2688: Constify struct regmap_bus
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2024 09:13:36 +0200
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-6-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
	 <20240703-iio-cont-regmap_bus-v1-6-34754f355b65@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 23:04 +0200, Javier Carrasco wrote:
> `ltc2688_regmap_bus` is not modified and can be declared as const to
> move its data to a read-only section.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Indeed,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



