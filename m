Return-Path: <linux-iio+bounces-18341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67136A944DC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4FB1893D1A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CD1DF72E;
	Sat, 19 Apr 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRhDMsLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301051754B;
	Sat, 19 Apr 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083808; cv=none; b=uF4WtCp3GFAL9a0LF8zJfS5A6HShkLXDoavZ8oO/lUn9jXyHJWQdQLa9Yt2NDb/OrcYYHgS4GV+f+uWhnUEIjdKPPdsSUIxN7qHiLWPlJYrxsU1GdOqeSZHA1k0y0vipBHVzcEr5rkB1OBTfhzvrYZM5zRboDVDjlv5PxiZ1hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083808; c=relaxed/simple;
	bh=U6a1wXpun/HJSo+wW8DR+dOHz6jdl4cyLokR8MMuadk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7rO4eTfiKCiqx4Rme3NSO7RdARmJqd9HOpeUHo5QKdeqqkaz0vcOrpyo+HcWjkuTrHMwUpx9STyrGwl/7w8eE0EF7o/QEDePzjdgOztBB9JBNeeFiO02JsWvFUhwoBEXCVJZh3AzUwlpwQVGqtdKZUV1o4qRLebWmMV+HJ5s0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRhDMsLl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736a72220edso2725447b3a.3;
        Sat, 19 Apr 2025 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745083806; x=1745688606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUYxhkgZxR+3mLbUfk63itZQJ8nDNbnX+29tHtzt5qo=;
        b=NRhDMsLl2G12a11CBMc4kthaQS8uPURpVOA+sDu1kDHbUZdJbM4ZF2PjWqs1bJFrNg
         2Dq61XVUiu5ioMFvr6O11ca7M9ElcQjTuqNItWMOn0NVY+VOyue6mB5UtPmLlz8bh5zD
         ipmbgbE0xFn0nrNQnfcZbuZw0N427rBOBybkna9MsrnZ6qM7msALzbGS/cAAxObAxidL
         MWbBNfOxWCeH9r06VZg4mut1ovQXnEUWJWb/Fx6khLOhUt8zaMDQzPQ7PqJ9lKVk6rO9
         ScYLfwuJaPOpHWEWTPm7e52rMePUCi0jnq4uPA9mD4nvFLiN6elaQk2zTYDULCWQwxMQ
         7N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745083806; x=1745688606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUYxhkgZxR+3mLbUfk63itZQJ8nDNbnX+29tHtzt5qo=;
        b=sbiDT6Xe+2O6276p04TH91DlR5ZDYKs/l3X7u3ViK6iC+PUXFf3dkvRdLSLR/WYsFC
         mz5ud0PFc4kuV6N1xnzttX9mkGjxg1qeUBXp9fmamrlI0NU2wKJgx/QlcOm+u0pc9Wb2
         JiFNBlQAm2ofJWla/2G0JZgxiXd3vzlgUTjAyKPMHUOL78bllaKuDv0ws7cRDiL6s4Sc
         2Xv+NGtE3XpIYwHUpcgXaGWYtWcG4DRNgBm3ayfqNDRmV6rHpQZG/9RONLp1gZQCY4hd
         OZn/KIUWXaaktZWVSJO7J5kRCsE8xe/ScCRX6L/NH3XaUM4ijiYWo/vdEivxm2WLq+j1
         z08w==
X-Forwarded-Encrypted: i=1; AJvYcCUMwJm6Pn+yR2AlXV+32Gl2TMc54JElK7GbjUAhXKw5wSNuGQ6K5xoGgpA8mXHWGTNy5biDDqHnYXA=@vger.kernel.org, AJvYcCW3T7Ksfw7YpEqyqTHJjKXHf6KAUNJZ4ZiPLJNjWpxT79Yoyd/wbLihu79AUKWGgTRx7HL0rLgG0EP/x3eh@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnwHNlmMDi4T52lT7uOuyMxGQAqqXm9YYkgkQOL9DoD5DQDNb
	azewYIuUV6FKuNOUpVlJHMXxHkdmsPR4GnuSmcWFKAMTFWzTxZoR
X-Gm-Gg: ASbGncuxCdka+1H26Af9fOS+tLT6On52sTdaBAjhKLT5C4jbm6vZZdLsVUsxND3UjGf
	lsBsWWWFnEsrEHcWpp+S2Cvnb/cstryLjlP7Qp59u44MmjuFEBHet5xFxVQ5vHIP+C4OxTxN8sH
	jDhlvkSSeaiMeZ7veWuk3hlj37QK7TAZhyCVn3+XtOWafWp0QdBdb38zGsw1nbQZHRc3Yt2qdgZ
	+Av4FtuYsVSxLk/CnpAvPbGlX84oPkpd/6y62wawc5YJYRukmQvcSRr7yd/0MTGOPzf9BIuWuoi
	lO2P4m6pNWg6SHL0lvhWMVql8r5/dWHRS3V+1r0CFlWNi0Q=
X-Google-Smtp-Source: AGHT+IEYs0SsZrKjQ3EyxwmjfmzQx6Yk2n8zsra3Z/o5jNp9N6ENiepCtoZecYh2GvEgRlL1Y20k+Q==
X-Received: by 2002:a05:6a21:900e:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-203cbd24088mr10858917637.36.1745083806348;
        Sat, 19 Apr 2025 10:30:06 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b0db107f513sm2447197a12.0.2025.04.19.10.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 10:30:05 -0700 (PDT)
Date: Sat, 19 Apr 2025 14:31:17 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <aAPd5XxfNEzaWdr2@debian-BULLSEYE-live-builder-AMD64>
References: <20250419144520.815198-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419144520.815198-1-gshahrouzi@gmail.com>

On 04/19, Gabriel Shahrouzi wrote:
> The inclinometer channels were previously defined with 14 realbits.
> However, the ADIS16201 datasheet states the resolution for these output
> channels is 12 bits (Page 14, text description; Page 15, table 7).
> 
> Correct the realbits value to 12 to accurately reflect the hardware.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

