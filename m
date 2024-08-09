Return-Path: <linux-iio+bounces-8355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01B294D01D
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CEBB20CFD
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD320194090;
	Fri,  9 Aug 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiLgSupi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB671DFF5;
	Fri,  9 Aug 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206425; cv=none; b=YKl9y2sN+DPtSD7JsIJ2bB+4sbSnvj5hxDbBYP3GBaF6S+To/8lyMvt4+WCFahSL8QPzBXrXvUI4ai14/X4X7yIoHhBJcMfXkT//tMKtgUwjBYnEQxJfIZvdYIqea2Mk4MiJQgPjFHBbQqHCDoVa5EwxVvRSQiFGE/RtKPwTcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206425; c=relaxed/simple;
	bh=QBAbLarvD7MXtt2zSU+BnF6sa8Zn4rsi74VYiSOLVzQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2liZj3WEkHk3pQa0Ah/mSWJxuM8zCtOUyGG2MSwAY+klCbsObFzTe4uFYGObABt8L//Ly+6b53BiY/WOvSVgsl0lQnmYDsIrCLg56dcPhAKrGiqFVBxr8bXMZBDhMQqcs9ypR2KxnaQj01gpfW7R8/GdFzmExDRuqwdVqK4bow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiLgSupi; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so2659986e87.1;
        Fri, 09 Aug 2024 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723206422; x=1723811222; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBAbLarvD7MXtt2zSU+BnF6sa8Zn4rsi74VYiSOLVzQ=;
        b=MiLgSupiVEFbuw6X9WWlhBTL5CAnJZe2mrHznDL57wpmwhUQcfeWVG/GMryd6C5fWe
         t5+YlTKFW8L/rRnbGMgl6/k10ebrbR7ym1a8wHkzktKNQh3K71+M8l11ekt7gzCdM2Vt
         tAmDymWWMkM6fCuHJkOBxmhhIEOhNXxVGgClEgiMr1X9iM+bB3RYsWpFDmZDdq/4uGSx
         2ZdrOFlRCUe1XnofjR9Cs3OjD3WEMilTT/+Dj2L5PQ78/No7UmnH5m+8XMYmjzQ3Iepx
         P8ZarTIE/C696bbHmOxavFzalv+Ab3RlJ09Y68damFjMJFibCSzva1LkRk7kqXChO1Bh
         Jtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206422; x=1723811222;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBAbLarvD7MXtt2zSU+BnF6sa8Zn4rsi74VYiSOLVzQ=;
        b=gxF4vXATJF1UpnQT+N3pQO71BVemHskMjDHh3CabWcrQtk8KAksReyjZJuuN5vPc5P
         djc7ph7HIwFQAv35tovbjyGGURUMD5JMs0YUALnlCo0J+n6ZgtMcq7PM8VJ0Rt7fnSR9
         NyVe0w7LRW7nQLnHozN0qdYysSxhm1bILqlH2pxvRJPGSxmBfjZny98fWj6kpGlvVG9q
         UT39Uv9Myfoc/fihsnF8Kd/9oTVIYietm7Tnbh39YeZmvSiki+ADLjlg9nJFnBeTEmNv
         hKtYFZ8SffdCa0giTYY1ldtQRMaGt8mz8dVQC3iwJku9c9cagNZxG4fgNEt0L9OKFinl
         EMlw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYK9XS8x+O6Sb+ByGL0Nvetmkr0qdw8avM7JRl3lPc+yyRQDzBHGVzcEd2S3Anl/aLyCYFsO/rx3M2s+4EBBi8scqQtr/RmOjmGLtyO/UuC/BCloBL2bqGi5QrvcBif1+UbJQYfMmq6sV8L8jKCI3jgaXz/JQmV+dcBfqC1nPeGL89A==
X-Gm-Message-State: AOJu0Yzw2Du47TPfQffwAt6Hlbyxqt9TMb3oURkRJ+kExaBQyMDU6zqe
	8/18HfNWU52DNjoM75JtBGXDrqqnR8nv9pOdNZEj16MU1cTq85RAslAZNGKD
X-Google-Smtp-Source: AGHT+IG3aVEbYNxOMIrMoFzZSC9DeEN4uqm5CAdUPXKRnnKZEED0mP+beyguYtpdLode4rD8JkKXfA==
X-Received: by 2002:a05:6512:2314:b0:52e:9b9f:9377 with SMTP id 2adb3069b0e04-530ee9cc5d8mr1215291e87.21.1723206421613;
        Fri, 09 Aug 2024 05:27:01 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e77sm832593466b.169.2024.08.09.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:27:00 -0700 (PDT)
Message-ID: <1a3dc92c4f91d271fd54f7b77b2850cd4d95301b.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Aug 2024 14:26:59 +0200
In-Reply-To: <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
	 <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 13:33 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> This commit adds support for the AD4113 ADC.
> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to-dig=
ital
> converter (ADC) that integrates an analog front end (AFE) for four
> fully differential or eight single-ended inputs.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Any reason to drop my tag :)? There a b4 command that can help you with it.

- Nuno S=C3=A1



