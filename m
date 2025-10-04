Return-Path: <linux-iio+bounces-24698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89DBB88E4
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 05:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABF34C19E1
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5721638D;
	Sat,  4 Oct 2025 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWDKCQRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E417A2EA
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759548137; cv=none; b=YBplSrFgEERPw9XkVi0BRXP/3OP8SlVHKPfvw1TrpStvGGY7noZ9WDL+yv40XmDDKMpony9rkpMHsp0R0Voyv2uiCCVJeKpLgZPsN25H8pOMheC9gMctDsvqlwkXpcGCJ6cn1wdpcdJrNQM8bWT+eojwLKZ/cd4fXAVfoq+PvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759548137; c=relaxed/simple;
	bh=ey/UirZuMoQH6VVDj0zZ1/9OEU+uMzZ+O8OKJwtAu/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxioZx9fNnpSqI7K7mFkyz1Nig/sxy0Q9h3xm2lMoA+vMuMlGokwsXLeMZ7is/e2D6ZoWQ3BwIZNKLZ/0u4i6cdUjBq7sT9adS4AJRH3T0FoEyFV+bhnqShMah/whQ66qZTC5Awln4BXoijEf7yPsuIhWpjOvyTlRBSueoQA/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWDKCQRE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-269af38418aso35542385ad.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Oct 2025 20:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759548135; x=1760152935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vT/ORNW0pW5y5PIVl3vdZCajLNmtGvBDvw6fpaJcnVQ=;
        b=OWDKCQRERpYz8eXQbDiX4hmRiCEC3XqA3Sc49LfxUJyPS35ZyTUdB+zWdCAVtTqSJ8
         ZeA0tmBUoXc/9sFKH56O9ZHA0n9w0qwGQr6fIW4O96nvin5qEsH3rh0h6b9Y4pvx5HSo
         SoEUMQZ55ZepDw2PpWs2sp69z0NEXZPARjTZj3Jf5l7Fpey1ws9beSUVQJ0RzBujgns3
         V46SKM6owzLY8Ky0purH/MyAa0/+sIbFUdFKz1Nmr97qugj0ZcamwcJAUZ7bFPk321lx
         bRb6sR5XwRr1IgwVOZMmmVgZbiDgtt5jbhvMX82KORtYEGkFUGhoi92pHotunkmUKh/s
         VO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759548135; x=1760152935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT/ORNW0pW5y5PIVl3vdZCajLNmtGvBDvw6fpaJcnVQ=;
        b=F8tVQQBQGjJKWQv08uuOcLpzEbx4doIswUUQXMMR11KWBLPpKB8Z7MVcDcz2yXvAC2
         1FAEZG3k4cmcY0iOrcUUDA4/ShJ1JU62M0ijoUmFzbmYo7oWNHdbMXDuqAc2LUmenFbR
         +d83fFj5A7YEqT2v4++0BmouDcfZVM6bwUZ+F0Bo175cuRwoa09YOJpvCYrdCvIVrr1O
         PxV3Yrrcubt18MvjbLF777fMUHxVok3ckVbDXFVeVpv3wKeSELy2jjasiLfaBdAvmwBQ
         6sYagpHZp65r6dncSbv4yN4BQH+xezb0BTzthXdWY/Fu5UtE2eRiLDxTn5irWZognHht
         01qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXnG8Y2dBg32L1nqZyDiWJTDEj66bCJiL9HB6fcPPns+2WbYBpTnpQXCRFfbXyb8XOwuYYD9wPoNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigBf1ggCWepbICmuHgfVZ6WRQOxkuFtGw35xZbI0PgZPXs93i
	nDAG1f3un80EWejNRL+u5bjHe8PQvciEwLHuO/67Vp7volE3BTjC2UhY
X-Gm-Gg: ASbGnctCAnHlDVv15JsB0nD8GoBp6qxLzCJ/dp4DRs8GaA/ux+SNwmH3UygOwx1JVEb
	K7/DD/Wco9zO+AZUmL7nh6WkDoZNuqixsyJtQAeh/tOjqHCFVGP2D/9Upj8acBvFz8Q9me7fhcb
	u/VAGLCbusLkhj7ryfu/Uo7OMiB/cBxaOdYWnQSBT28Wr3VwlNNXmb3KQim+RhQ1QKRBSfwXfDt
	gc7v4Z4qxs91JzYYZCB3/5CbV6q5m7wOmukGQ7+wIZa+IdbpLebSyWtAcs17Kr4gR7UnpngmfyQ
	Wpc4mjqKNoS266/H/KAiDbLYaqNP8m614qy0pAUPhXhckT048+Qwv7wxO/VyNfrG3qfzOM5zUJ0
	e/TIcRFqBVS7fsYtp3kbarDJAwNONdYD237Wnu8Xc+IFLF5CO4ir0rpmeyLaJXJNbHX9CtoI=
X-Google-Smtp-Source: AGHT+IHEj0aXuUhMgTbCirX4CidHBDMcg5LPlI/yovtk5eB8b98mCogwEGyUGrgHax0e9En0MN3Xpg==
X-Received: by 2002:a17:903:2f8e:b0:24c:d322:d587 with SMTP id d9443c01a7336-28e9a60b519mr64976925ad.26.1759548135023;
        Fri, 03 Oct 2025 20:22:15 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.90.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8444sm64824745ad.86.2025.10.03.20.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 20:22:14 -0700 (PDT)
Message-ID: <21b1dc10-acad-43b9-a9c6-24abb2886856@gmail.com>
Date: Sat, 4 Oct 2025 08:52:08 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
 <20251004015623.7019-2-raskar.shree97@gmail.com>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20251004015623.7019-2-raskar.shree97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/25 07:26, Shrikant Raskar wrote:
> The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> 800us, 1600us). These settings affect measurement resolution and power
> consumption. Until now, the driver always defaulted to 1600us.
> 
> Introduce a new device tree property `maxim,pulse-width` that allows
> users to select the desired pulse width in microseconds from device
> tree.
> 
> Valid values are: 200, 400, 800, 1600.
> 
> This prepares for driver changes that read this property and configure
> the SPO2 register accordingly.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>

The subject prefix [PATCH 1/2] says it's a two part patch series. But I think
you send all changes in a single patch. If single patch use [PATCH] instead
of [PATCH 1/2].



