Return-Path: <linux-iio+bounces-26957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B645CCAE37D
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 22:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D3430B6E80
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB392D7DE2;
	Mon,  8 Dec 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqTD+MRu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA1281532
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228683; cv=none; b=OhP9WnAY0xkiueEINXlR6LrFDlKW2BVz85MyGB8HkQZjpCbzyKwZAx5lTlZVpC4dPUNvIaDIFe+tcczqJDlfcbK3V7AZ+To88q5gORy7rHpWn44D+BxVyZlqLG/E98IR8X2CDw7O7u3YUY+2K87Ibr46AQYqxwcnBNBu343vHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228683; c=relaxed/simple;
	bh=7lZ7yFiwE4BfabfizLUm86ygg5oezWglQcFnqPk03BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOC34VRa+FU20d/+0mRB8J41lJaA5CHsUHaCkdnoLQwiiZaSNWa7uOXMPieITbzBdg43t5tX8FKPIagxlEeSwgT9tGV7yi8U/KUyTocoyXaQSAfoRFxgZ37kWz8RFpSTF2bhpvNWQdUFQUmic8P1iVBHNRyQeNOMTj2HrdgKu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqTD+MRu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so38579105e9.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 13:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765228679; x=1765833479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FevBVXsdxMvnzZIFlQ7ZnJU5t6FuMkK60eiavRkgSq0=;
        b=OqTD+MRuf+ggNDx1WnpmEg4cE/RoBU+ipt1XZtUMbaz+BW+355TEGCSuaKiJazxc2N
         A5HB0OOuhZwMTV3JR4jhJyYe4jUREnY31z2O5E+xjH9R7P+DyStlpHM6xN05XZ9tqtaq
         L/xxwrVrMSLtCaOz+NpH2mKEfc8ozzS4zQDd4xlxzx2/2R/WuutaPzkqHGFjTW52+osn
         R4FtViK4LPl4pxIaRtIyuG8xFXr8+/Ci895DefvmkbUlRBBBTiDjE9tOn4Kl62gC5bbx
         4aV+//PYq61ImeFC0qMif4nR2OHpjs1kkxesuzp/DjJqSlgt/9r0YQxr811IgDg+Vm8G
         u3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228679; x=1765833479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FevBVXsdxMvnzZIFlQ7ZnJU5t6FuMkK60eiavRkgSq0=;
        b=gjRUEE/rYbj6c+42zYTw3yr15LsZ1y43GLiY3RPam3ygI+N/EhLMNl+UVrF6rqOAhB
         QF0QY+YYYN0lhh16DNcthyEVS46geNqWtOrcoQH+sST4rBZUTe1EeKVXE9A1xpThNaHF
         xo3nttVVzRLrWjjP6qFtBI/moobv71AirVUtj7ChjJnKd/pTSrw/07yPQ0iXTdHAiZHx
         PSneAJF0jtlDwpx4pn9K1TfAqu5QodMRaaaATx1K4nA0E81DWS7SBxTZX5pA1uGmH19F
         i+WUsAlisSSbW9E0vzly+rg14L6nPvUTix15CoGAzSSyzYKH4fs64vs9SAeAoS5tVA6D
         iKRw==
X-Forwarded-Encrypted: i=1; AJvYcCW0OO4OCLSV1D0Zzeu3IagD+nwNC6GCA+1G1a/1NGGB9fG8v4zBJ+sweE96hBUXDu0U5Vzq991ZONM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydehxZVmIFyQdHgjPcSo+qmqLMveI8y4mLbM6ySB63C0te9mQ
	U7Z6z6gdfXR7kP5cWNYfbPR73vgOpyNqWX+N5yG+cVJJV5PeZgOdyWCI
X-Gm-Gg: ASbGnct1msv7kv/rbEDa9kxN075VJj3rJsIai+hniBor+ZZGQ0w3PLjBBynKbc6uCo+
	aMK65zXZs2NbwN0cS7/AMJ9g61D3SfFXym/DWUuRYnZpMM5i6CIvumxke+d8mxUhKauO4xdc32P
	criIvMVw6GOFnshTqVo671ObKa7ciTmR+SgV0dR4Z/C3k9eN5pTMfN8opdFINdmXF7TNWGXEYQw
	+N4RfD8NF+EoRKV0L1aFcv/mW7Y7dPTqEIq44sgzkgyfHTINj6rGY6JnNCMq2V3RwqrDk/vHzvJ
	05D53GORTHiEm7dAYNneewjAOcMBfFnGn39hB6sWTkVrOZ0pmfYoWS3lmo2HKCt8dqk7fNG0dt0
	167beySr/hz0Lsy6JWJ4h7Ypb3pYGIrVrqUErkRmr+DRHzpzZK+jgFNorJxdrYUeiF68yHrcoFM
	m0Uj31wVykfGi6NL6WpaGWWKlxVFz/p0GmNYlwZlbY//9S5BQpBczp5HR8EK6tB9UcmnQ=
X-Google-Smtp-Source: AGHT+IE4yIfqhzMNdQUtI3A3IPxOwF1ZjFVLCMqKqyD/wHiW98WHchIOle5of1otFBu+XeUJTcxuQw==
X-Received: by 2002:a05:600c:4f82:b0:477:aed0:f3fd with SMTP id 5b1f17b1804b1-47a6f9b153amr68618885e9.8.1765228678559;
        Mon, 08 Dec 2025 13:17:58 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1226:7701:cdbc:9893:8abf:1309])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d810c49sm3855035e9.15.2025.12.08.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 13:17:58 -0800 (PST)
Date: Mon, 8 Dec 2025 22:17:56 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <urniyc27qw5ex6jrwqilqykkcbswxbxlsdshnxqcts5gizdaly@a2ncsddzuyh2>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
 <20251205-staging-ad4062-v3-1-8761355f9c66@analog.com>
 <20251206165822.778606e1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206165822.778606e1@jic23-huawei>

On Sat, Dec 06, 2025 at 04:58:22PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 16:12:02 +0100
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> > monitor capabilities SAR ADCs. Each variant of the family differs in
> > resolution. The device contains two outputs (gp0, gp1). The outputs can
> > be configured for range of options, such as threshold and data ready.
> > The device uses a 2-wire I3C interface.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 124 +++++++++++++++++++++
> >  MAINTAINERS                                        |   6 +
> >  2 files changed, 130 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > new file mode 100644
> > index 0000000000000..a7a2ad761d1f0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > +  interrupts:
> > +    description:
> > +      The interrupt pins are digital outputs that can be configured at runtime
> > +      as multiple interrupt signals. Each can be configured as GP_INTR, RDY,
> > +      DEV_EN, logic low, logic high and DEV_RDY (GP1 only).
> This is a bit confused.  logic low / logic high aren't interrupt signals so I'd
> not mention them here.  Maybe something less detailed such as
> 
>     Two pins are available that can be configured as either a general purpose
>     digital output, device enable signal (used to synchronise other parts of
>     the signal chain with ADC sampling), device ready (GP1 only) or various
>     interrupt signals. If intended for use as a GPIO or device enable, will not
>     present here.
> 
> For the binding I'm not sure we care about which interrupts are possible.
> I guess even for device ready we might treat it as a onetime interrupt. Probably poll
> it though - which requires a GPIO not an interrupt binding.  If we don't need
> to use that mode (and can poll a register or something like that) then no need
> to mention that bit.
Hi Jonathan,

Device enabled (DEV_EN) and device ready (DEV_RDY) are not implemented
at this time at the driver. I believe it is fair to briefly mention in
the dt-binding. I will use your suggested description.

Best regards,
Jorge

