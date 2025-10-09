Return-Path: <linux-iio+bounces-24875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3060BCA2D0
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203DC188907C
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BD223DD6;
	Thu,  9 Oct 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCnG8vPR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED421B918
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027038; cv=none; b=kqBAysTnL0WBTAkNxr8IW45fnPLkOBvoN2fduhGneBEtvddXLpqpmQaRAEJUy5zrC/SQOdi3MLxFydgMvMFpCpjrvLmn1XYlVAEw0ERpMwsjPK20jb2k1PZ/rEl5FTgSgu/xYOW//XEsGHcmmQj1qSFq/IG+yHG9s8WoIIllzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027038; c=relaxed/simple;
	bh=eVvkeQWqrG4dYBffY48He8ILJTh8EX7LtPQhkX3h+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XonxLU2l5xFUwbmtlz+i9jwEkHvqGfbusQiCUSIMWFBEVSFxvF9BzSZQ8BPEDdqxaCB6iyTAU/SxlL//vfhA7jtvy36/j/w11Ud3i9c8Wex34s6ovctC9o/GTLX6+uPTqKIp8gNCrFNyRC7hrUy9idhPWaRjFBOFGf59S2qxGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCnG8vPR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b63148d25c3so887628a12.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760027035; x=1760631835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=MCnG8vPRQYAB/sRTi4esoaO/JWYoy5ApLLqeX6QndxwVYySMVYJKfC4gJjO3FwPqSV
         S30/FC8jXscm2L1XPxnjUqDd27oc5xOjcOGAGIa/5BlueteWIktVI8o/v3dMZDbmDeF8
         z5AR8SUuVLUDndif6y1kd0i2+o7Wee/2h2SVC/9uVSGcm5WK5k7oueRP+T90pEh+XE4a
         1d/kTqHfwlX9LPsj0YGzfnpL06PNlMtzs7tRQTGQIyBbwtT+lH5U1pKcVbVIix5OkX9B
         3adjH2abP2vWlPTF0J3nPlLFMQsmVhism3zMR9wh1pzs/U7nQ3hoL6WTMqh4mJNEytzO
         UfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027036; x=1760631836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=iW816nKwxz8lugtxHxyl783Tqizh2LWW3s6s2kR1AIsqcx7MET+g3XSSveS5tmHi8m
         DMX0Mp5T5gcG8T/dmPJXwHopySti0pjWWhsROwEZVHhdVAroEpATpN+3NIhBLjjglkhX
         CMmpEy3eLz2rngpzMnoH+wmSmRoMvCG+NtbCW3IGo8uIrag3YiX3emLb1zqE+c6tk+CY
         OEIYAw1ljwYATDZUwl8wqOZc4sUvPY/JikywDYp5NhwAUMIoe2yvhWErCK/N9cM6tGlS
         edWD1GSOU47+KyoL+AjbL9xtmAD4Yi8uyONx/z01i6qUxoKkzxSeEmSNk2pVYqZwW1wt
         TLjA==
X-Forwarded-Encrypted: i=1; AJvYcCUGHO4+MSQyOVgVFelVyE7how44pDvBgVL/4TK5RmgpJKNytO+TN/t40JZnOKEYNwVxXi6sayEVs+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpjQk41GQZ7oGgO3WlVriadBpgsJpFA1N6Y2VRum/6VzHxISb
	PGNOjD7VokSva3AHsKczS5rVyl47AlHxInS46xvY5bzL/qy8HG30Sa1u
X-Gm-Gg: ASbGnct4ixgvKSL0XP6ScN8b1V6EwZ/+7CYLcEJtR0WY6vCJk2Ea4LP2NcgKuhmGh6m
	1UhK4KagW3tdZNW/doCQ3kMMBVUc/3eOhCgFAwosHn92QBOm4CPoH5k8s9sWc5aLeOoIYXQurHa
	EUz8vzMyNNFkqUiAKjxZiae+VBMXLatKiiXdGAI305SIRJxxC5LiBHFHysdMzYB4/CYYo+52Pzj
	rUxREr0xfDVil2lqlS0KgsORyP2hN3rP2yKV2DbWoXyTfqFYN5OSnBuTIIWApyX9a7bvZ0HcYhv
	z+AHuR0XYoLLSPKnkoIXvb4UYuWu3IKK4Ss3x6EpHHWPLi5EAKtcA365NakiYvZkdZvEEVD14YA
	Tx7DdQyRa4JnUig4Zj3jhchwhGqlszT1BxnFzsoBrTES5ey5/rIB+BMw=
X-Google-Smtp-Source: AGHT+IG5iTuS4lml5ybOjWvkOCPTHDj9ZrBTt/dnU/W0P0sGl3oiFllm8k9GBt9WpwjupCqN6+ivSQ==
X-Received: by 2002:a17:903:1a10:b0:271:d1ab:17ce with SMTP id d9443c01a7336-28ec9cd59afmr138719345ad.26.1760027035566;
        Thu, 09 Oct 2025 09:23:55 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034e1854asm33475565ad.37.2025.10.09.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:23:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:24:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, ukleinek@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aOfh1puxPJr367n7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
 <20251008-penniless-tiling-9a83d4b4ba48@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-penniless-tiling-9a83d4b4ba48@spud>

On 10/08, Conor Dooley wrote:
> On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> 
> > Change log v3 -> v4
> > - Now only documenting GPIO setup to control ADAQ PGA pins.
> 
> > +    else:
> > +      properties:
> > +        adi,pga-value: false
> 
> I assume this is an oversight?

Oops. Sure, should have dropped that.
If the device is not an ADAQ (no PGA circuitry present), then we should not have
properties associated to that.

+    else:
+      properties:
+        pga-gpios: false
+

Thanks,
Marcelo

