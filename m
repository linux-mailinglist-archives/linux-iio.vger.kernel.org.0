Return-Path: <linux-iio+bounces-2543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D4854644
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3A4283273
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB312E6C;
	Wed, 14 Feb 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJbENdeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043512E44
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903599; cv=none; b=KqW5Pe452jKuuD6rsWyaFNgaJay9uqrbwLCGQAzyJy3IpqhosedS5yA+QwTX6kZ0baBEn3724cOiCL0FxukoBfzP/PMP96O9tvPgPRGGv654Rvycvks8BQAbg/iMoaGhjKTMXPK5m9QgitBGvwfAEREBATnjrZDJrL9wXPD2myg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903599; c=relaxed/simple;
	bh=LZcJ8gWPgyD/rehHxuErbTmXQoPuv0YqCojCADVl2iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE9KGxe9jbXO1Z94EgkVy9QYVs4CPFF4yYpYn9xKlnsJkoXafKfLKTxDz3gx9aC6cIEP8uMvKY9ILYlmNjh/PgxI9/JXwE87USQUhp0BCv06fGyNcQXXG7qgNm0RtZ+PMawKFP/LwfMup4A7kGCexexnd4+jUahd1EEohZ2vc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJbENdeV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a389ea940f1so612879966b.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707903596; x=1708508396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sa84/GkxvyPsj0jYuRHYttmGrs/Pk8ShoR5d/FxzTU=;
        b=MJbENdeVOzkqkWQChMaG5W0E6csM2ro+i3iGi7i4qaWwRFpMNCd3+zOUffmztKdXEg
         iK7A6/CefA1bFilo5snwj4XUdDqAiYzsr79mDPW8cMwLX2QCOC1jPo0DL7urYejcuHH0
         fCDRV7h4Ler/FDvFnG918tE6Jtpm9zFHcFaJGsOXW5j9WACHk851AXi0yMAgVoL4mtZe
         PHewTddu8Hu5Deb5RVl1Mz6lkNcSEsZiec3SZKWlKBbO9uU6szvLPQygiH49swnu26BH
         vmPjAHA2IeO0hpm+z/jxWztk2WR2dXjhgxOYVEjM3nZ3SeHqX2REDtSKSVQ6rNGd4Q1L
         9hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903596; x=1708508396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Sa84/GkxvyPsj0jYuRHYttmGrs/Pk8ShoR5d/FxzTU=;
        b=wmlWpLMt0p5hySjFTvL+MIZd8hn9ohIMD+XbcKuvjA+xRqnX2baMG3agOO0UGyaA5N
         Z/KlcOSf7RMkn6lDfGSM2+CJKz7hRuIYdnUr/EKRwSgjyH2elZEnL5+jhNqu2knw2AFM
         kHF2AYnCrliWI+P8MTAP2xDNY2GlmaBhVYo9sVShal5DQpZq8/Ad2mFzoy4KnyrAwzzn
         JJuqqRINGLntTWcr85Q4IoNOFLEr8kFgxhJO2MQgyDnAQg48m9ircxbVzSS4Kfp5lRbO
         Mggz2c3Tx5ygxVyD9Fy7XqaQweRJtKKCc3fRfwrqITCU7Wp5B/SJVtxjV+leWNS3WnX5
         ml8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKT6NPc4tmRqn/CMTsSOGTUr1Aqyu7QZqHKpxZWSkDakHaJw05dOuU2tfcA8dNsLDeiA0pWnPt7PD44ZlcLFqV9TRmM2myDjmj
X-Gm-Message-State: AOJu0YyhfTd8Rs7y2ojhkP17oKXDfptOVMPbZNsKbzm7ETY4mfVZ52Mz
	Ta1kwazku6rncWZHagSvbxqN5JujRpMNfXnZeFOQbV1M0gmUapY/S1hfmMNbP/toKyDQ0DjI6S5
	PErYw9bQnLnKVbMRsJFcskcFAHmc=
X-Google-Smtp-Source: AGHT+IF+BnCeNNNp7glqk8bWxsHYlQcxvuIUY6fNYC0H8fic1i8scyYJ10fge79oU6/xb2OICYkFpx2NadVm26Rltg8=
X-Received: by 2002:a17:906:d9cc:b0:a38:981c:840e with SMTP id
 qk12-20020a170906d9cc00b00a38981c840emr877154ejb.19.1707903595533; Wed, 14
 Feb 2024 01:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <20240213223910.27127-1-jlobue10@gmail.com>
In-Reply-To: <20240213223910.27127-1-jlobue10@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 11:39:19 +0200
Message-ID: <CAHp75VermmAb3J8D1h-PkyAJ0ZH64vzB3vvQFZzRsr4Nr3o7+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:39=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com=
> wrote:
>
> This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
> driver with an ACPI match of "BOSC0200".

With the remarks below,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(carry the tag if you send a new version)

...

The below comment...

> +/*
> + * The "BOSC0200" ACPI identifier used here in the bmi323 driver is not

s/ACPI//
s/in the bmi323 driver//

> + * unique to bmi323 devices. The same "BOSC0200" identifier is found in
> + * devices using the bmc150 chip. This creates a conflict with duplicate
> + * ACPI identifiers which multiple drivers want to use. If a non-bmi323
> + * device starts to load with this "BOSC0200" ACPI match here, then the
> + * chip id check portion should fail and the driver should relinquish th=
e
> + * device.

This seems different wording to the other one. Have you looked at the
code if it's indeed the case? Because we may not rely on the module
load order.

> If and when a different driver (such as bmc150) starts to load
> + * with the "BOSC0200" ACPI match, a short reset should ensure that the
> + * device is not in a bad state during that driver initialization. This
> + * device reset does occur in both the bmi323 and bmc150 init sequences.
> + */
> +
> +static const struct acpi_device_id bmi323_acpi_match[] =3D {

...should be here (and indented accordingly).

> +       { "BOSC0200" },
> +       { }
> +};


--=20
With Best Regards,
Andy Shevchenko

