Return-Path: <linux-iio+bounces-16644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C6A587E9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 20:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A351116A5BF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79429215F61;
	Sun,  9 Mar 2025 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEUgcZWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2A2153F3;
	Sun,  9 Mar 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549450; cv=none; b=gJrAUCSNpfoBbhh+GpcEac+a1G3NyK/BTxgVLy3Z3QdYvxUtvSc6R4GqKgM/e6ylqC5B8rZBivsyUsQghaUgXZ3nJ08HdDgjLiBNIJZynhnDdeLX0x3wQ2802YuOBJK1jp1wgLyaYZqGGQ9VB3eH4Hd6cUqVg2deSInXpupwpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549450; c=relaxed/simple;
	bh=WwY1W3tQgFSjIAfiO3XQF5op28JvXU6ecwmLK8zBMEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvtRLlVtczlsZXF+ml/OZ4fuQJs6JyrgQB2SEbs6VVS01pa+okN81AmafzXyOx7gR/A3SdZn4qirlAbvGNPv+0v6j462mNBtKd3GL6HITaieMDioQx+P3afklMW9BBhjVJOodjiI508uorvUOaYC/anXyNZnc+cchJopRbD2xGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEUgcZWQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so13462865ad.0;
        Sun, 09 Mar 2025 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741549448; x=1742154248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYl6otMjDxf5o4MwZVe7zcqDnHx+0uhKoubJ0akptmg=;
        b=JEUgcZWQzZdWWTLI7EHfUxY2fHsdjBq12bLvHPN7m4tZm5xZgN8zmxtiBnIjwuf7YH
         KyogLZ8yaOi6P3eMsIdyXrcb+rCtsMzj9M035qdY64dluW8LWPhby5k2wKhC5KPXUaBA
         u+ofl5JJ93rYNcJo/sgMVJybt5o4TOO4ucD6MtgU+vGb97nt86/uTl5jTeaJz0/XGRtC
         CB2Txz8ZPsqjskcjtR8fLRPuWfuVQ0sorzdhl7os9+fkUEodMK987ddrhHfqLYLO+65N
         qvNmZR4T0RrB8feFAVO7reVGFUYnz5qTd4T/OGYQn4CCHH8Iy+yGyVHztLK/qEDi9Bw1
         D8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549448; x=1742154248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYl6otMjDxf5o4MwZVe7zcqDnHx+0uhKoubJ0akptmg=;
        b=rv9gXCAgzpwJvKNZK7HkdipnkV6zWDXXoyBRgz7BSAk8L6Bspgv05klZ6Q8RaqoFU1
         UYGCdW2Fs7FHbZfBjWr2Iy+doB1wp6lg93D8zTjUUxP4uie6RvS/VGPBIfAkSNXXH9k/
         /X+N4nWlH2oSst53Z+M/iwGpoZa5ftCfGK556inm0ma844yqD0DEnIc117pt0GmdJ9N+
         euCpr+vaLyyDtSA9OhoJK+pUaFlyPuIriifKa1YEry78w2YJzahbR1AY0pYdhx4yvQX9
         SIunHzHOVZsnjn1SUKgDt/kCc7hy/iYC9khnqIbrnuyOSwv+358e4FLHNFeg/oxkDNFJ
         QdRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4pccOGPAVqy0JMdo6LTywZ7dSE0Gk8JEOiPa8YmOGFs/8hPWUz6ezMHzId92Zzbr/4U3rFCw1bofKUqkg@vger.kernel.org, AJvYcCUseD6kKJtCQgJ9MC+NXEvTEjtjff8vogjpsw2M1y98+UbBFGb3z84JOPH3IBJyT5+VFX3pURW0HYYl@vger.kernel.org, AJvYcCVaGRBHd0YeDxEu05p51fn/56wjstmksZHH/KfBZ7fu4a5p2UPXIJK2KasuzYMPw2jNx4gUz6KyyU2g@vger.kernel.org, AJvYcCXOuM1t+K6Hb68AXFpB+FXBCvxcUjf8cosWDWK3+jCCh201J/bJaIQ9HJ4EywkHO6qBljz4GGBQR4fz@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFbv3OtwB+oX+egWh90s1JPesbqiQsTsoHQ4hBdqWvewjHgwE
	jjDF5oZ1zjvUBT84MyhAQEOnLjgnPpzPXtZ4kMSA80MwYI3QGPS3
X-Gm-Gg: ASbGncu1cIGfaffTy8dMpQXokVF8jufAsXcr9VXcJXH409GPJX0ROQgBprreLgxzUf0
	554ym5RKl9jUPKx/vXwWwsJJ3gBDnRm2Zd2n9B/hc5ZsJ2gLNigD9IvgB1ffs4ZXdGcnKYZtLB1
	ywlIYrMNuGDvRKmMSLiFlgQ1HK3ObEmP4886v4+LL90n6gA+6hdOJtp2zcHn8JB1T2898X5gpn0
	JOJ0znW3B7G+zSPZRwMxbzmMH2r/UFRnY1KeJeVFEhS9VY/M+WMYwRGfacPIKbAYGn8sePwczIU
	FwXTl22HXJ+gtjeJoropnU4asPXof2gu+lpYr6i1fq31CaSQ/vmxABwtVmVTn/aoggtOjMRq
X-Google-Smtp-Source: AGHT+IGXBsTw552ea3aL8FF+/CnuSmMcYTPShFFEl56V9oVJGZzP0iyUGDFFyglJTEizSY7RSxvhGg==
X-Received: by 2002:a05:6a20:1594:b0:1f1:431:9d7f with SMTP id adf61e73a8af0-1f544aedbbemr19952487637.13.1741549448143;
        Sun, 09 Mar 2025 12:44:08 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:2455:1853:7000:fc49:126f:e12d:f79c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28109676esm6312073a12.28.2025.03.09.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 12:44:07 -0700 (PDT)
Date: Sun, 9 Mar 2025 20:43:55 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <sf7hqjyzal2jmbrf72xxj4cewrkq6bsjwlkbinqv2zan57cq3s@hwhfwmabtk5q>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
 <20250306-promotion-tarmac-bc5172f38f31@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-promotion-tarmac-bc5172f38f31@spud>

> > +  compatible:
> > +    enum:
> > +      - adi,ad4050
> > +      - adi,ad4052
> > +      - adi,ad4056
> > +      - adi,ad4058
> 
> Can you mention in your commit message what differs between these
> devices that makes picking one as the "base"/fallback compatible
> unsuitable please?
Sure, to be added:

 Each variant of the family differs in speed and resolution, resulting
 in different scan types and spi word sizes, that are matched by the
 compatible with the chip_info.
 The device contains two required interrupts (gp0, gp1) and one optional
 gpio (cnv).

> > +
> > +  vdd-supply: true
> > +  vdd_1_8-supply: true
> 
> You're allowed to use . in property names, and the _s should be -s.
> That said, vdd and vdd 1.8? Shouldn't both have the voltage in them in
> that case?
I overlooked the supplies, the correct are vdd, vio as mandatory,
and vref is optional.

Jorge

