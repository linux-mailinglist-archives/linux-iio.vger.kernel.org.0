Return-Path: <linux-iio+bounces-5830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6598FCA32
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11CC1F26B67
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5805192B98;
	Wed,  5 Jun 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWj/NARp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3A17C79;
	Wed,  5 Jun 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586294; cv=none; b=aZukQrWjVwNBgeq5biPdFx3URy/WEbgQozB2pLUF8DEdRiOcC1q0241kd8HEzxViS2Sra43SY573B5O/FmBbAabi6lvdWTe8+QO0XPtN6I0r7lJHeK6DvKLZoBwkCafimpRMOTl91/k1ROA9XJy6kgC4mvnV09J3/vsBOfDoK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586294; c=relaxed/simple;
	bh=ceROS8yyd9DLlt9sItpiT1/+Xw1T+ut1aQgzVqy/LV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls82N6LR7/IrNPOE4Sna2Y5OLIBr3Wumu+SbvQTUd5X2K5TYc/RTH/MDil24I4LU6Oi23g6SctjbsdecBpOUaTOAmUbb1JNNNT+Kc/3u1dQbEUv0jxdnY3OekUGABUtYit30y892Rf+j8ThJv2XMlrkcnu54MTHE5yLgZH/7AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWj/NARp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-702492172e3so2034503b3a.0;
        Wed, 05 Jun 2024 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717586292; x=1718191092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AEIPnFs3OXFyH040kLJZpDX4Ff/OGTbFBy0D654/+yU=;
        b=mWj/NARpuIsp5B8yiBBsBLv0cgjaeG5J+67sPi5T94vGIAxf9Z+MTZnFgdQQxlYU5r
         8uvySip/RDoy74UQabpvn1coxEYspy66UwW6Mc7nxzgET57utWf91S4KikI8DfKHs4OA
         7YdoBEqAlAAeksJySxqtiBR3yXVHhSyP6BJgAlLCn+3VdEq5f6XYMuyIHGROPp/2x4LS
         SX/WZpqXJkDUxnrKb7ikdUMBVNohBX814L4en5mopSETG/Wh1Fufo+P1YUGg8XmKs6J3
         Nk7+hQrL33xCw8qjIUSg1/GFZItI1wnxqV5OO1KVdUXGxuFlDJr6y3MBG8z/wfcoHbpu
         q40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717586292; x=1718191092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEIPnFs3OXFyH040kLJZpDX4Ff/OGTbFBy0D654/+yU=;
        b=Qkl29wlUqtuaaZA81m8wt8B2CKtM4N3CwOsA+MAIKKmaVzKTKT5TVjJizpM2D2jbu+
         o/s80smYKk7r50Eu3zF2mQ3BCrXKG+IGhmVS4xgCi/WeSI6cx5Jwm4dUZ+xui4kaFpE2
         bOiNmhKX3C89v4wu6yiw+iBVQj01nGB5XI69jbZxlh9h3G78svu125EdO6szqvwLkqRV
         lvZsy6dBDqWFPn/GDVp3hUQo27R9U8y6GXch7IXMBuyxai1EB+FYuZvd8H76C9ODUVrb
         W3Ja1wm35X69j/3DIpNVN4FZbFKSYqL8StnkXTf0z7QKSHDKocf12EqK4r0RrHJgMFvM
         UMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEBiz0DaIB9PC/IcBWSQOH6aKiEI2P9hY855P3uVn9B9wy0pgTMMOsAvR/iJnOSU777Kewr9lrizW+yDOthpITvxzVR07lXrZVf1pPRvcrQ1olTnDxn6qEAViOx/5YpGzOGveKxpJdSCmgGHmMsvxqqOzwbmXDsgG/9E4WnuUSyc1QiiV+apweDq4WuE0lDQCeEmoz0CYcjtY6F1/WTQ==
X-Gm-Message-State: AOJu0YyKjwRA2aFmnP6/Ut5PzACgwgwielRpbGo8L0655hDJfFt5gzc8
	+6XwynrlBh+2S2VDffIjDCkSPYy/WBtSbfCS6FQtAp/IvLvzfpqB
X-Google-Smtp-Source: AGHT+IH60wShLzZqwxcRl7Dp1uBnogAAVjYp7UnczKKT3vQbibKXgvdCJeYSWy3sG2ph43xTO5idWA==
X-Received: by 2002:a05:6a20:3d87:b0:1af:b0be:4661 with SMTP id adf61e73a8af0-1b2b6f95856mr2991636637.19.1717586292244;
        Wed, 05 Jun 2024 04:18:12 -0700 (PDT)
Received: from localhost ([2804:30c:b6c:6f00:4a71:dbc2:c9bb:1cd3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067a391sm1213945a91.19.2024.06.05.04.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:18:11 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:19:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add support for AD4000 series of ADCs
Message-ID: <ZmBJvFbq3nonrpjs@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e396bacff372b34127de15d980dd903af48a9350.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e396bacff372b34127de15d980dd903af48a9350.camel@gmail.com>

On 06/05, Nuno Sá wrote:
> Hi Marcelo,
> 
> On Tue, 2024-06-04 at 19:40 -0300, Marcelo Schmitt wrote:
> > This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
> > support configurable MOSI line idle state.
> > It then introduces the ad4000 driver which makes use of the MOSI idle
> > configuration to properly support AD4000 series of ADCs.
> 
> Not sure what happened but I'm not seeing the patch for ad4000...

I thought patches were numbered up to 5 only and forgot to send the last one.
Sent that one now.

Thanks,
Marcelo

> 
> - Nuno Sá
> 
> 

