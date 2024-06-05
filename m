Return-Path: <linux-iio+bounces-5819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8868FC7C3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1120282B48
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349BB18FC79;
	Wed,  5 Jun 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgok34vk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421D200CD;
	Wed,  5 Jun 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579678; cv=none; b=A0U4a5wNi1225RupCehu7H8u+wsxe3McVdEMAMTfEST6MH1BHFbgaQb4TJr2hj9wkXzDd9UZbl1ViXbNK4FdV804Xcz6MB7fWcG5XlqMWgv9/KC8zMb1Rku7h69OSLU9rkHBMOgHVrK7r0pDVDW6JjM0LoFrzktSJqeBF1pkTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579678; c=relaxed/simple;
	bh=RderhM2PdMV4Iztof/Sjp4ReTZqBvSlj+fgI1I46Yr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bntDqQi3Px8wiWETfrEQYoLbU2FO2fRiOUv/5DX8CzV8sdq7QfKvDSJdESrYAhb7xen1GJB4mJW8DHbQR/ZFeOw3d+G63qIontL7W6WljgU/Wc/6rdTt/xP5fVgn/QKEB7szKh2DPl2zpLcMiQ+a0ecvafWdvd25bW8Y6zE6GMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgok34vk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35dcc681f70so3712659f8f.0;
        Wed, 05 Jun 2024 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579675; x=1718184475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RderhM2PdMV4Iztof/Sjp4ReTZqBvSlj+fgI1I46Yr8=;
        b=Bgok34vkqMc2Nn3TcbNvwtf5yk8Ht9fXP4fAZ4Mcapw9EXRs1SLYc86kuuGwCXIZb/
         G3kfuRW7ywwtqQ9oDTeboQek80GobyZa8gFYdzTDL9u74SO6jVdETmAJWVib5nqlTKKk
         h+VB41r8vW+Ekcvd+dz4RA0dWGaCbIarps7kIPP6eR68OzAFiIt4qNLd3/5zgPZ1mgYG
         da1w38CAbW2jxAlKxt0F8mXm4a1H5FFSkhLjTDajGmJPykSR7YgkN/B1YkCfl3+dCpxZ
         lYAeg6+LyyBf/I4bJ6ynbZ6i2GQeYTbY3oYQZ193AS+55yhQsQ9bV07ZzWDylt43GNfK
         AXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579675; x=1718184475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RderhM2PdMV4Iztof/Sjp4ReTZqBvSlj+fgI1I46Yr8=;
        b=XB6RKBbcTtKYEXFe44Y1kwwhBVTiUA8r8Q2hXiR+LPSaH9/zuGUUct+bEtudKQs8Uu
         7FTXk2E9HuL0E03Vj6Ck4Wm3UudEn3IYU3W76Mt4q73iLqv4tgVS0kSZ1QG6GCsl79DH
         ejNpoE6t78wsIe2ZvnFETj2q2v8tbzz1GasaFsEqpg8SHJq7T3J6C0yrXbcy6TVE5ojy
         kvuxOPrwgU8XpCZpjG4OeaPvO2he88/xPs+7y45gZF/8pXHgdIiGBvolq9h069R0iUeH
         733hm96aICP7FNvuoQnxEwphGxrz77Cl9z4Z3S1g6K/E6/awcw7D0ldXniieCC4mHOkg
         Mr2A==
X-Forwarded-Encrypted: i=1; AJvYcCVpZ+csBYMbaGrfYP+JzJebNwAgGNT6nyJstBmuQWs9mPy8auDIhSsAAjrcty7FbDqHPotQBw7x9yowt7c2tq6fWoWkcS0Neq+tsPAqqiGpSIT5+e2QAUMtSUhU4ctzKJWxd8nPwqc3ePDyngV8Y51QGN16TJ6jE10tM9jAbADO1RXPCg==
X-Gm-Message-State: AOJu0YzBE2HpRzKHcToiufFywVInDtdyQYv8FvQ52pr2MWTHs2MMg84p
	5/fYyVNnsp2adkqNzH6o3y9J6emECuB9XkODD9cJ4GRwJBhFsizN
X-Google-Smtp-Source: AGHT+IFC0Rhhs0lM/dFB2fhY1iaFSG9FX21Z7yRpyWV7l/5BiIZgGrbARU0jQW7NaDNnq1Y0DZPitg==
X-Received: by 2002:a5d:6a0f:0:b0:34f:f540:bdbc with SMTP id ffacd0b85a97d-35e8ef09a6amr1506551f8f.38.1717579674561;
        Wed, 05 Jun 2024 02:27:54 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c111esm13947283f8f.20.2024.06.05.02.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:27:54 -0700 (PDT)
Message-ID: <e396bacff372b34127de15d980dd903af48a9350.camel@gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for AD4000 series of ADCs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 11:31:41 +0200
In-Reply-To: <cover.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marcelo,

On Tue, 2024-06-04 at 19:40 -0300, Marcelo Schmitt wrote:
> This patch series extends the SPI bitbang, gpio, and spi-engine controlle=
rs to
> support configurable MOSI line idle state.
> It then introduces the ad4000 driver which makes use of the MOSI idle
> configuration to properly support AD4000 series of ADCs.

Not sure what happened but I'm not seeing the patch for ad4000...

- Nuno S=C3=A1



