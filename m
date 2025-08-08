Return-Path: <linux-iio+bounces-22486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029AB1F07A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 23:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D5188F64D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C7244E8C;
	Fri,  8 Aug 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYKwpXRu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D522C181
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690223; cv=none; b=pGm9DV+n2bMq21T88EcU4XsMrzsGig7eraLpQS+nJ3FerJEBjqgP3VncDEKCTtSefOlUHBJJxsIiZ6/tPraf8quT/rosp95Vqx+h8+U/n3u45bWTCMvYJGmVVsa6pU+F2JOvOH//E4bv4OKqZ7jFEZnUXeJjh2zOwFixijD0Ses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690223; c=relaxed/simple;
	bh=ef7j2jX8ArUjPgRsRT2+H2NzOJVUeHwl/8WM72N7JLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEYrnwAcMgU0qFdB+21Z9EvBgPVrwP8ra2UuKvcir8EN3MYtT5jHYlvurczZhj0dryCcc6XyN4eIAN7z9LUTQBLP9z2xOHqBpXjayhjl/Go0UBjpvJGRKt2kNMmNNp7eEwKHIYVzZ68Gvk3I3K8KCdesbp3aiDgMhbOao3Kj7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYKwpXRu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af93381a1d2so450007166b.3
        for <linux-iio@vger.kernel.org>; Fri, 08 Aug 2025 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754690220; x=1755295020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLs3SsXryQfD/cAibSx76ItsdizwVEqnk+421pwNby4=;
        b=JYKwpXRu/CMYVQNp/dHMFs71Xwc2biuFqjdIsSQBjV0TcBgog+kHNMNC+WGHrR5umF
         udMZDCo4+AKu+7qPVEcKPt7Ev9b7JtrCCqvUTnBcYVlc+wRnZMiSa4LW25GBr+YtlU7f
         pincdc9H4aeT3z9sttNQftRgpVndafpVUGEj/x957igEOrlK3uySNjBY032qVGwb3T/X
         XMOeW9onpVfp8S4XXmWQ+5W5ezolVkCIY0td7jzKfGXMpKGiI5BDtUzqa5n1Mqdi0NMa
         VhpenKKIdhKZdMY0WXRWl0Fja0weGlHBlAzIlT/+R9lwAo71PWqT256MCoUwaz4ka/lH
         Uhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754690220; x=1755295020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLs3SsXryQfD/cAibSx76ItsdizwVEqnk+421pwNby4=;
        b=KuqkiNFd6Pg0ilVUzjnJ3/teOkAtZGZmLL7lwsTfh0dCaVFA3CBbF/euxIHhYvvVwa
         OjfPqNqMeV2pXk9mq8SDGVRGFRdNun3ikcwyWVtqSApWSXlJ8uzQ1pBSyIsMZt5huEwG
         ctjU/GQpuflggJgrZNNNpqDcyLRSISYZBj4Lct4yMgguAFbDFOrN4Q827bybctk04XF9
         ODUxn9ept6w9a/Nwso1NFFvS+tvjibn1nFWqggGls2mETSHvPreitqNR5LP+zgRTjJxw
         aH58uxZCQQYbEkTRvNFkkYbRQ7KwskHtHCBcC20aLumPUNCI+lYjouCLKZm22WBxvBnO
         tlnw==
X-Gm-Message-State: AOJu0YwqjS8Ul0SqZNCDtQnz90pcz8q4h4yJLWWjf9h0vAIThKG4U8t5
	8rj3X4vHXYsnrDRh1NI//cFHxZ/qH6uQhWE/sDbSqSf5U593yZQ5TQNxsfuePM5COndirzBCatz
	3fcC7KpbbZ7Ph2RXUr1dBbDpG2GOg5HV/f1B8/UgN5w==
X-Gm-Gg: ASbGncs8wwN64kTB+xUxeMQQOHDr5r275+1jtY/iaTQr7EoxydS3vCDt0Q4UaDoDcbS
	H4kFdh4ZvdB/nWg8Z5iDaYbNM6lZQjEAPfuWtuTDiTNjVlos0NIKL8+UB/7b6qNAXMyV7lu7g/1
	LACIVV5V0jqIK9KOXgw98E0mWn5mnDYX35LXjdqNPuVpY0ddEUMW192wmh4KS6KHX8A2HaKGSU8
	Ah7i8OR9QzDc1A2C6pK
X-Google-Smtp-Source: AGHT+IFCwygGITvzjuZzklplCnrGK28uKLRexBa+yVIR1Tq/lFaWm12CmwxEC9Le0TG51c1Tl7UtTJJq9aea7YW6Jx0=
X-Received: by 2002:a17:906:f58d:b0:ae3:6705:8918 with SMTP id
 a640c23a62f3a-af9c64fcf27mr377054166b.49.1754690220028; Fri, 08 Aug 2025
 14:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
In-Reply-To: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 23:56:23 +0200
X-Gm-Features: Ac12FXxxtrHqdYsQGpqZQ6xQ9E0M24HK3a5V3PieskHfV93DdvA1u0BRnntNsNQ
Message-ID: <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 6:09=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/=
9.
> When set to 4/5, the maximum RF frequency allowed is 3 GHz.
> Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/=
9.
> In this context not the RF output frequency is meant
> - it's the VCO frequency.
>
> Therefore move the prescaler selection after we derived the VCO frequency
> from the desired RF output frequency.
>
> This BUG may have caused PLL lock instabilities when operating the VCO at
> the very high range close to 4.4 GHz.

...

> +       st->r4_rf_div_sel =3D 0;
> +
> +       while (freq < ADF4350_MIN_VCO_FREQ) {
> +               freq <<=3D 1;
> +               st->r4_rf_div_sel++;
> +       }

This is a reimplementation of ffs()/fls() or similar calls. Do you
have a plan to clean up?

--=20
With Best Regards,
Andy Shevchenko

