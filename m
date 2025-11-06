Return-Path: <linux-iio+bounces-25930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E7C399E9
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 09:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6B41A237C0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADE308F38;
	Thu,  6 Nov 2025 08:44:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25975308F2A
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418683; cv=none; b=nPGvOHmhYegXOj/CTj8vPl1CtA3brf4qrlN4ELAH4OPEdL6iFg142bm3YqctdBAmMBUw1GUIJlTixuj2Sk9BSay6ikCdIRB5uBmqcddrvrO2+PHWjlI3GjU4qk0cWu+RQL4cfQG+QSaMmxdxlsFvv4OdAwl8BxmV3mBoNc38oPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418683; c=relaxed/simple;
	bh=4e2WDzqLKYzpn41/EU08/ysLwcMnKhTYCq1gfsIkVBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYfvs2kEorbbDA05Rs+tdYpLgGZrCf63yk9pI3tSGQBhFpchs9k4p78wUoSOOVdEhnWlnhuLdOSbnSDypMhjqW27s0w7i0m9YqwWIV0SrF6jAKhyFNqXocD8Jawk22fOhzT8zlhg79HxYDAMs0QvoA5TlUOMuhUY3acafJM2d50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-551b9d94603so176203e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 00:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418681; x=1763023481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mz1Q2mn9SZfrcMx6xhR+wHR4X9YWp5k+qUP26CNzhQI=;
        b=jucKIgXh5Hd8nAo6Yl7EHBO+xxkowx3lXE0R8VBfKFhx4nlDDvZqSEANOZMOXfEdJM
         gL6FR/sO8/R6Q/6S6efB3bNsm8IgyhDYwNZEPRbgGnvXkGW44qzQl6alPF2aQd3X0u1/
         O9H18TQRcmT2yHv82rhDQhu6DabHhQt2wsUxcNSZBYz8BTO1wFsOWumqPdj0VZD50uwA
         Mq1SrucZKGJI7gRn66PsM6gLo2+6Erkwla+c8gG9pWEzXDxBA4q/EqlOltDrwW5Bpu3v
         VZZO0yIGO9W3AIXZ2+jZbbycb+5MX5/6/hJ9xnLVVH8GnvvNLJdz8egSskGqlEKVrOBJ
         32zg==
X-Forwarded-Encrypted: i=1; AJvYcCWeqoQsqlfEsz7j3wMpKh0XokNpEvnsu0uYVwJLs8LwHC5QtAg7r6fHQsnu6GS5yrxp/+O37/Lq1Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDSYHWczLS/h6ZJUkzg6XQlDGRBGRbdWkaA6WbB5jMqtltAkr
	kknXxNtp3lamoXDZTb5d6Fj0MqcvzX68xunLaVl4WVCjRDkFOUrQ+dfvrsFZYQkt
X-Gm-Gg: ASbGncsnteBInZOXNGTxKUNHFE7Edy/fvaQ34UAMctfTnKiTt8rPG15UiVdmO4bDvPW
	o35Wza6UxPYFuvsTPZcxZWRf396lCTRhlfqWDI1ZdqoRKanV4sLai1dAK8c5aqOALlzFkK5yvnI
	MX6Lr1VWHgKL2f/tKTA3TsGtwsaK8C9dNpF6I6uWDifhYBqBmiCjxYkqSi2ZK3dsGflN/E1iA56
	bXmBx0PFONFOA+znJMBbaV/MusncF4oZR8xgd3jBBCvvkngX+p/zRe2wORK828GozKd7ANizbnL
	ylEG2MrFq2QhjQga6gldXBOFFsE1+mcQPCacB1wA4MfB/2wjZ8CpER68GmtDUULaOLGDp/BVspH
	dkKE138Iqa/wrQK6+mWrjnnhdWoM590egoktXjSbqolK9UAunz+HkyXtNr7SYj36WN5AQ6P4fUu
	5KFUWwaYSwgIs5M3LlGB4OS1kJwYvho+ZTGrDwo0Yw/Y4r8ihGHpPvLS+ckws=
X-Google-Smtp-Source: AGHT+IGsJ64cs3l0AdHibZb/YDVLTqLMZtbcr9oVx2R96s7j39ELBkltIIWGBCMas6wAUeCiNh/5Hg==
X-Received: by 2002:a05:6102:374e:b0:5db:f615:1819 with SMTP id ada2fe7eead31-5dd88ef3ed9mr2125130137.3.1762418680815;
        Thu, 06 Nov 2025 00:44:40 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937088206a6sm785442241.6.2025.11.06.00.44.39
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:44:39 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-93516cbe2bbso218400241.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 00:44:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcOMr+Uh2kM7i95sIGbIxteu5pJgccQ86S3PYa30rQQcfvaWZENhdwDTYMiEpk2P2GA7vRRajYuyE=@vger.kernel.org
X-Received: by 2002:a05:6102:e0d:b0:5db:cc92:26e7 with SMTP id
 ada2fe7eead31-5dd8926eff6mr2132593137.38.1762418679294; Thu, 06 Nov 2025
 00:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
 <20251006172119.2888-2-wsa+renesas@sang-engineering.com> <20251009204726.GA3306624-robh@kernel.org>
 <aOgsxSfGIVBpfkpb@shikoro>
In-Reply-To: <aOgsxSfGIVBpfkpb@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 09:44:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUf2QB__ZXsJK-iMAt7U-89d7s76oRB8KE9Jj0XywxzJQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl7RbaNV7V4JGT9opu1pZKZ4R-1R9XxMMdHotgYEewUqOZDK542sndaY3s
Message-ID: <CAMuHMdUf2QB__ZXsJK-iMAt7U-89d7s76oRB8KE9Jj0XywxzJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: accel: adxl345: document second interrupt
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Rob Herring <robh@kernel.org>, linux-renesas-soc@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Sun, 12 Oct 2025 at 02:01, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum: [INT1, INT2]
> > > +      - items:
> > > +          - const: INT1
> > > +          - const: INT2
> >
> > This is better written as:
> >
> > minItems: 1
> > items:
> >   - enum: [INT1, INT2]
> >   - const: INT2
> >
> > It is mainly better because using 'oneOf' results in poor error
> > messages.
>
> But wouldn't that allow naming both interrupts INT2? Or is this
> magically prevented somehow?

    "That's because we require strings to be unique entries, so [...]
twice will be rejected."

https://lore.kernel.org/all/20251009200054.GA3245555-robh@kernel.org/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

