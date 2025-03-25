Return-Path: <linux-iio+bounces-17263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFDA6FAB1
	for <lists+linux-iio@lfdr.de>; Tue, 25 Mar 2025 13:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA1A189EBE5
	for <lists+linux-iio@lfdr.de>; Tue, 25 Mar 2025 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9A92586D5;
	Tue, 25 Mar 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6eNhgxK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A81EE7A7;
	Tue, 25 Mar 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904040; cv=none; b=kRgBe9bGH8CQf1TbStUWX20GliLzwwAOALi+BNSPcajORRPm7pwmgYl4EgTjFh/Szj2meJU50tnwxrhAZq30FY3f9qSHe1gxSvV3InqyrL2rn/ZFEgLDaqZepQ97Lm9F/8GhnuEQvgQUU/6c6X/Gswq7FkPpU4qLMYsVFCDdvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904040; c=relaxed/simple;
	bh=b2OhConKjzvSgsnTcl2fL5GUDaph0WJpGeSsM1KI984=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxW0HhlQpW24e2JxPZ442MnaBry9YK7agfmJgHvKwCVlE8HboThSx67B6e7GKZIwmiEiayCdi0gCWnw1B8acyM5AxsT1dR7oUnS6OoZ8ijkhBog1uqE+Zi+5LMeGhM3oEAHe7TFx8pTBnUgCaipBMVTT07vPjQRuBFhSpU+sD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6eNhgxK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e573136107bso5173635276.3;
        Tue, 25 Mar 2025 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742904038; x=1743508838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnevdrSoXCo6uIk6bcR0nLToODaub7C10ZjJRxxcJ+Y=;
        b=E6eNhgxK+jbHKS7D35u/aDI7yJvI8JtCcviXOeU/2LQTrpi12Y3KEG5qvgIcxMOGUA
         bEIt8PaBPsMD4oQYsebGFGnKMv4mXpNqNZh4cQZ1RRzxZ+7dVEhc0Qb00h3kvyEiCNhH
         VIafH8rW3NW/h/HO+noqHYYaXEnF/VqdqiRftgMqVuooOBLl7g59OTsds/JoFAoXju+n
         VO/gLeBWrG8LFf2Sbcp+AAyP5yHbFkDVJoeDbayPVdMvPNu0sTyavMCjnWRlqCcJeS96
         GKS06Y6yoh629GYwh7R8LKCTXZgPq2kYimDaL+4g+qhhpa9jpjRHA/sFgIQKgGtz4CLX
         A0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904038; x=1743508838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnevdrSoXCo6uIk6bcR0nLToODaub7C10ZjJRxxcJ+Y=;
        b=ZD7Ml1Jk0g5/EbmFe5Az1lX2rWVXQzLOl2byC555DFPPSrM3hVsPC83td8y/5uQR2n
         iJX9eJrPsPsmUzZwkJ9ozyVC95hC6ghN2Daxfd71iYvRaqStS6xO4O3y1HZBC3OoRwfR
         iCeIBsbpsXQ+NmOgTHrSZTRJXzfVe9SlArj9qMWKpZm22qlf2U16waoko14Jm8pxZN4a
         QxgTWQZ+W2w5UPdh9UbeKBUH43T2Z8eZpD5p0C8aVbt7xLWyB+tygPnECjuEfOll+k+T
         Lg5Grc6Ik+X+Jr+ou5KETvRfgmF6lyCnaf3zKbnUInPvG6WmA/difLgZJzjSjB1BdTMS
         suRg==
X-Forwarded-Encrypted: i=1; AJvYcCWp1WMbam6sSFQfdbsXsRXU4TT4xz7NovzEXDv641g1tY2juyGFyPScN6fHxZvsnYkvYuceenzq3RLX/4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEkpO0F5TZdBu8b7SIF9/voQHO8hw6qvpvZY4egLMo7DoAIZb
	9mu41LOXuiUoyyNBLoK/mDRMZQf5HFVK4hg/2Lw7EilJUUX0cpbfvbJ1XUVLQlysp838/0WHDva
	IoXU7LaR+98p6U0z0f94Bh6N4yug=
X-Gm-Gg: ASbGnctflZcV26Et2B5gUSTgU5mp8B2d4HLKBpyt8q8lJ/bIYMCfByRWSl181fYE6qP
	EXZ2IsCC1DUSew4tQIM1LiCk4CVdS60fHcDcQXEFS5GJ//+GZ66X3TlUdUpICU/uVhKdIMuucvq
	O+orfT/yjnKbmtQSvuInA4TAmA1b7pqzxZaaUU+g==
X-Google-Smtp-Source: AGHT+IGIu5/NuCLnAVC4CwB7tKr+pW1IvXMHLfQddMFlTu1BRQOatTVJFYfTSGg3D5iR4Ev+dEuYNeLjzXsJzAIIKj0=
X-Received: by 2002:a05:6902:1ac7:b0:e63:f25e:68c1 with SMTP id
 3f1490d57ef6-e66a4fac372mr20419441276.34.1742904036331; Tue, 25 Mar 2025
 05:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319045212.72650-1-simeddon@gmail.com> <Z965Rz8NuXhbHrgy@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Z965Rz8NuXhbHrgy@debian-BULLSEYE-live-builder-AMD64>
From: Siddharth Menon <simeddon@gmail.com>
Date: Tue, 25 Mar 2025 17:29:59 +0530
X-Gm-Features: AQ5f1JoLIpcp9qEnovJpq03xpcbqdCTU9IxuEWqZb4IANYiAHmkxj7qd5cXRz1I
Message-ID: <CAGd6pzNW2JKxTfQ8rLD8V7bdUgq8fc0R+ayChf3J0VdRm9Ptrg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Mar 2025 at 18:50, Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 03/19, Siddharth Menon wrote:
> > Refactor code to use the FIELD_PREP macro for setting bit fields
> > instead of manual bit manipulation.
>
> The word 'refactor' by itself isn't very appealing.
> Instead, maybe promote how the patch improves code readability saying something
> like 'Use bitfield macros to clearly specify AD9832 SPI command fields and to
> make register write code more readable.' Use that exact text if you want.
>

Thanks for the feedback, I will update the commit message.

> I think AD9832_PHASE and RES_MASK could also be declared as a mask, but maybe
> that change can be made on a separate patch.

I shall send in another patch addressing this.

> > -             st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
> > +             st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> >                                       st->ctrl_ss);
> Not sure about this assignment with mix of FIELD_PREP and non-FIELD_PREP value.
> Maybe have
>                                        FIELD_PREP(AD9832_DAT_MSK, st->ctrl_ss)); ?

From what I understood, I don't think that would work out. AD9832_SELSRC
= BIT(12) but AD9832_DAT_MSK only covers bits 7 through 0 GENMASK(7, 0).
 It could exceed the maximum value allowed by the mask.

Thanks,
Siddharth Menon

