Return-Path: <linux-iio+bounces-24893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5EBCBFE3
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 116154F28BF
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219E275AF0;
	Fri, 10 Oct 2025 07:55:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8D274650
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082929; cv=none; b=Cuc6FzIguq58Sts1iXAqwOIaOclqHV7lTD/nMzGnekSlpbZ+Rx/Q5QFvrIiVwwunTsWHAWjlkf5JjYFbINUcTdCbOQOCy7o7U43pzBZ5TUwe4pGYIYM5NM/PcNp6mh6pvzOnN/vKYnBBSYfMEgOOc8Qvyou5JhvmebYGCKc8rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082929; c=relaxed/simple;
	bh=GyMrdUSzxTxaoShfISf9Kv4vkeRyaQViM9pgJ0KDv+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3dHsSaM1hMIAyyrGQFSP/ZPslFjqNVUKNMPODfdzQ7g5D2hqX+PjajYbTVYNgWWb2dL6ehLFFfsmOjscaNKsqeuY3uRC9VlP9ucw87tO4obn1aItQcntcGFgwWtqHfNhw08cGWxCoNej++TUogCI8XW4hrbY3yrUmNhcxXnDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bbf3329c1so1548284e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 00:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082926; x=1760687726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSqWlPqtUKmbPUvFOiSDBYm62ZRg96NdFDUtSMt7Zrk=;
        b=aIBfMT0c5yojPR4NbYfun3l0XtRzR9+hIbqMxEw4/ru/gMDDcJnWeBeh9WQo3YicTL
         cS/Gp4z61jZELPO/PD8eus1lGvAVS4wJtQraJQG2OG4RuKU/HNGJHSqFCXg8ZjZ/jCj4
         Ar00I3mKsRRSfIU1UsL8S/pUESjpSx4Vx3m6+okv7cWfeN3G/K5ZdfrFt76KVhznkoxf
         mY4LnU5oK2LFjmkapdR7apARqTEx6ncnKRcNnsGjUxbqXezvNYUXKiVEWP8YpDC92PUT
         O5ghr+QrbK8eS9nI3cMy7+Ckgx4sINieqkpbuhdf+fbAeAjWfBoqM0/f+4lbEgjYo+HP
         MsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbOlUs5UvQQOYN0kj+l+cUZnQ812i0lg6/in1jzoJEnH7e5SWqJE7KYas3hNawb8fuEHLpTUByXpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01qMyVXwoRXz5GvlrNTeUE6BUnLNUiX5anFPuRwkcuscyvSC8
	aUvtWzgMg5n+yzpQWwPDm1IPbduMfcGjGYqGu+EGG+DNgV9po+HIBkVZ70Y/5dck
X-Gm-Gg: ASbGncvvV3B+e7+scMptcJyoKxzwac4TCJ+B251mUPkC18TLKYcdJc4Urs7/AH2pHyf
	dQFDaf/hDdFFVjw3eVzV9CiRTX76KFgKsrA0hgHZJfwOUNCneZPvE+IuNvzHqUlxjZw4HGEKPoV
	qN/y6Pakv/VAhChIaHbevdz7khnJsM6ZIv0R5ReUzB8YQoADtoXA3H84c0Q+NQ5UQpcA2WHt0NF
	jyu0Az3r5re2kah1afuWOWH2u/GuJvj5mY7cYKZ37J4q5ROxqta0zzLbFbzbbF48jO8m43udwIJ
	9lw4ZR6xstS/TiJ7XDIzYpPatJa0y9+bLxLB4f8zRpw38tUKJXEZD/NUSIZH6E3nzzZgruRwYcw
	vumvKP9lHl5O4gZmnM0ysM3L16ZMfMaiq+lEDSJqtDLxnG9sFu+UGaj+uNlMAd50trhGXDTBotM
	VT3xfBrbBsKWoyMQ==
X-Google-Smtp-Source: AGHT+IFwwvl/uTssVMMDyvXzRt9U2V0BkUEyeSMWV1Nfy39HMnUmCmiAfAfmuIFz5gw7C1LH6l8uhA==
X-Received: by 2002:a05:6122:1e08:b0:553:6cf3:2be0 with SMTP id 71dfb90a1353d-554a8f27c38mr6828513e0c.5.1760082925955;
        Fri, 10 Oct 2025 00:55:25 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f0fcc3sm549577e0c.10.2025.10.10.00.55.24
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:55:25 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5565a83f796so1616275137.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 00:55:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9tJcikWKGYVT59h6V0zIsiFoSYQbkwbxVeOvbsxSBZB8DCTIu1Ex0zQ/3apsRaY9gF+YfRmMS/bg=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:4e5:8d09:7b12 with SMTP id
 ada2fe7eead31-5d5e2590490mr5331971137.7.1760082924542; Fri, 10 Oct 2025
 00:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
 <20251006172119.2888-2-wsa+renesas@sang-engineering.com> <20251009204726.GA3306624-robh@kernel.org>
In-Reply-To: <20251009204726.GA3306624-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Oct 2025 09:55:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXc6pchOxRWu_ZKUhR9zLoojjckFPB-pdwmM6pnJj8Edg@mail.gmail.com>
X-Gm-Features: AS18NWBJ-7Zse1vXv3tpHpxjY70K6erRYutOhSP9XUIFow6FgrAIep1olb_lk3g
Message-ID: <CAMuHMdXc6pchOxRWu_ZKUhR9zLoojjckFPB-pdwmM6pnJj8Edg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: accel: adxl345: document second interrupt
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Thu, 9 Oct 2025 at 23:22, Rob Herring <robh@kernel.org> wrote:
> On Mon, Oct 06, 2025 at 07:21:17PM +0200, Wolfram Sang wrote:
> > The pinout of all the supported chips in this binding have two interrupt
> > pins. Document the second one, too, even though the Linux driver
> > currently does not support the second interrupt. Boards may have it
> > wired nonetheless.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > Passes dt_binding_check. But uncovers another issue. See coverletter.
> >
> >  .../bindings/iio/accel/adi,adxl345.yaml          | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > index a23a626bfab6..806b0250ec07 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > @@ -35,11 +35,16 @@ properties:
> >    spi-3wire: true
> >
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >
> >    interrupt-names:
> > -    items:
> > -      - enum: [INT1, INT2]
> > +    oneOf:
> > +      - items:
> > +          - enum: [INT1, INT2]
> > +      - items:
> > +          - const: INT1
> > +          - const: INT2
>
> This is better written as:
>
> minItems: 1
> items:
>   - enum: [INT1, INT2]
>   - const: INT2
>
> It is mainly better because using 'oneOf' results in poor error
> messages.

For those that missed the other email, where you explained about
listing strings like "INT2" twice:

    "That's because we require strings to be unique entries".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

