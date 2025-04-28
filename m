Return-Path: <linux-iio+bounces-18781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0DA9F3BA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496B71A8377B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9007270559;
	Mon, 28 Apr 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6d7HThx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C926B975;
	Mon, 28 Apr 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851539; cv=none; b=aynZKsaV9OtD/gLfKFsKKeo91ColQG6c0fJUJ/3lSgXkHwSa5IXiaJ7tqEftU0Lwp/52khzodcy6FywlMIUQUW7q6Oo+hEwx64qGfShVd4guXu5N81kmL/5EvLOc7W7ELhedaads9UTDgnLu5tMjQMKEVAU3eSgNtvQ0K2hL3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851539; c=relaxed/simple;
	bh=if1ElJXs4BD2wEbzwPikS2BmwQMxk0vvMfZzdFI8wyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNBRIPKjDiydyLBpvsPNN2XweTLVpKDLeeXYcMzJ8DvWg5k3EQHy5zdQDYKIEfb4rduYJftaZcmlkhtG/+rZmlIp2YWrFuCSt8NRgkppRxJ34daaa3CvbjymShEIZdNUj5MzjYfTU+Uijv5qSNswbsaOKzN49KqZtCK37cyL4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6d7HThx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso35013975e9.1;
        Mon, 28 Apr 2025 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745851535; x=1746456335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0gqk8PcI67gFYGLqmc9GmDGJSBdRzcr5ObnxNnUlmc=;
        b=B6d7HThxa5/bJJTE/OR3oNQlXvngAHOFyzJZBe/B4LF6ucsD9XvnJPoqj5iC1T3mp5
         i70xckXJWY0Cq7blgvSW3seSZeWKGgYA+HT9v5ThLBUyKTeeXOnMU/m4dfLEq1ANR7r0
         y6HQ4GH2+91NEZk4BbpNfLJ9OkWW4X4AgZuDqTytYIVOHzuV/u2RD1+/MEYw/8Vk6fAP
         XomOV6ORlVhv0361cO9lwSoHtOt1J5if1P94lgnQZ0PmN5EH+U04ANVR3Szo47qUszXK
         fXwVPhSX4e3hW02T0rjGe0yYwRk/iDXxTaf84axx9nJ/EX70IrAXdvFys5WLcyKWBIv0
         mDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851535; x=1746456335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0gqk8PcI67gFYGLqmc9GmDGJSBdRzcr5ObnxNnUlmc=;
        b=U6YJYzwhAwUBXxgknfDJ/6mBHTwy8AuYONbe21hmk3l3Cob5wdSoovl/p3sw4dh5i2
         9GKSGQE+qCgVlIYR4iMZf6vjZekzh7KpqyvPiQuMFxoAisCLQ38zda9bLKH9crCG/XBD
         E8cQsAop9sRGVemCeL6WJn4PM6sBjiakR7ILYTf2bwY/WjV90q1V3QV0DDtNHZ8twjZS
         u1tCrCloEaQfEmtDAQdO0LnbF+hC5Tgkc6DJGPehQ/bkWYJdF/N5u7ZzMp3Ks1T31vrr
         qGQXkU16I1qbT35TiWpWNiWO4B2rArnw/d5XsRDmAC+HWlWR7GxPI00keGRo6t3tNKsn
         C7kw==
X-Forwarded-Encrypted: i=1; AJvYcCUdE8AErd5gl00ic4anM43yP0Bg1FuwZjgeetmJNxMoVe1v3wM64TU9DGYkVx7aY5ITXrZ4jP/icbxv@vger.kernel.org, AJvYcCUjCWFue3bTHaw3qdDvzV74vgPI/C1ZY4Uxhq9WpQC5KRzBHAXfcQjX/Hmb3EKeDEJQEuh1jZOZVXE4q6jc@vger.kernel.org, AJvYcCUt2qsPcXGb5kGst4NLJIV22solwtqaeE9FNC6nzKsW8WVJ6Aw6Cggu60xhEstRX2cv4qIS99rpMqjF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+StI3ltBg1BnkoVajP7NySc5JYXaqRLTDPMhZ4KROmEIQecL
	i6GnrC6+2oUc05XbuDiXEk/xAm1gEYaoBSrzq9nkf25fcqyWYSXN70CNoznI
X-Gm-Gg: ASbGncspEiEzYkUNFnoL910BduIC/t4TdGciHSGKCJj7Uo0B5pT5bh6hYw1gfn+h41y
	JxdtEVLfNwB7FgcDFfKnCVQRRM2AcU1Wo3m/ukDr87J5kwKCSLETrGlda42vTNbCTsChnUEzixt
	PREFH1gThuumBKG+93WV6zlnCGT1sDHPNbxAB08kR2cFtQqvn6a8lADGm9FKHTaJNILCrgTt+ka
	JTKeiBno/Osr0yK8w5wmcjK1pkzyRFrOprZpqSGBZQbaNTczYnGho8939JLkd4+fol0ZyFsAbqa
	mgL/HfQwDP9jy3Qbsvzo8BVL07MORQt6dBgHRCUNcDDsL0pylOsDFOJBJBwI+UEzlv/PtUQ4ga0
	=
X-Google-Smtp-Source: AGHT+IEE8H5H5jgUoXBtcMdT/naMhVHvzUf2cqBjkIMV0r7lbe9x4XD7kY53798eAZulnwNl3wfhVA==
X-Received: by 2002:a05:6000:2483:b0:39c:13fd:ea9c with SMTP id ffacd0b85a97d-3a07ab85d86mr7417671f8f.47.1745851534559;
        Mon, 28 Apr 2025 07:45:34 -0700 (PDT)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e461bfsm11462195f8f.79.2025.04.28.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:45:34 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:45:32 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document SEN0322
Message-ID: <uju5lntp3hzibbrw6ej53xhgvkkpjory74l5et2jspwocuj2xr@bbterxtg3ba7>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
 <20250428-iio-chemical-sen0322-v1-1-9b18363ffe42@gmail.com>
 <9463c3b0-ce67-4c67-a8e9-91b4ffd09a58@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9463c3b0-ce67-4c67-a8e9-91b4ffd09a58@kernel.org>

Hi!

> No other properties like supplies or configuration? If so, this could go
> to trivial-devices.

I don't think so, I'll add it as a trivial-device then.

> > +      sen0322@73 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Choose something from above or similar devices.

Noted, thanks!

Best regards,
János


