Return-Path: <linux-iio+bounces-22465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD3B1EA56
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25DA18C7F95
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C027F007;
	Fri,  8 Aug 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJkDxbkP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0527EFE9;
	Fri,  8 Aug 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663048; cv=none; b=LBDvpXn2QcyziwOH+3N8V2d2na6w1lt9++mW7ywughCIP5bEfDjUMgp8w1nCr9imzO8WJuqrzCwPMydXlzgRjZ9jQ2uf2dtKsTM65XDxIcwRRlZUJ2FLpx11IB7h7A2RJGm8MTK0gTqUW+k5NeVo89zrS2PvXwxb5DmigphhIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663048; c=relaxed/simple;
	bh=KCZSOYF8PSHj4jQs4HpUDoXYbfQq1/bAG9Xt+aFTqdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5NyWb56xGGyTJ+56J9prUuNtuOJ1VVQP3gL8I1rgL2/eThjwooscshXD56n8H9tVPQKQhyd3maroHENfjZIJkrWK/sOPxwm2y6pHE4Bg6axIXSHFdeTvNR/ZHxT3mLoI7ATZ8GMonEhf3/Au75pic9eo3ej7VfG5ktK0co1tvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJkDxbkP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3323d8e0ac4so16610041fa.0;
        Fri, 08 Aug 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754663045; x=1755267845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCZSOYF8PSHj4jQs4HpUDoXYbfQq1/bAG9Xt+aFTqdU=;
        b=SJkDxbkPEiaaj6a2eJ4hTfPpedY+abfpa10tLZlz2RL2DcmY0yYgCuqAuL8mJs31ud
         oo7xk1Pd2FSwmIgUo08uAAYWMwTUYB4/0wOet4JssbePX8dKrVvJx68PBFvupiQNO8FP
         gk+47A9bYtvX9wCAurcKhnFmE089MzQSaRbz4RONoyoGCs1b13PIEalGNBs8rf9/CKN/
         NOqUpd7Xl6nEbC78kZasv0ddhAMUW66Gz4/65DB1HEfWPysiiO6wMAzL7O1TwhUenaH7
         GUw2h9KXQGZy6JGmeiOGz2fJuRX0awhpnumsfqYs228RqrgDzZ3GEQlvphbyrKuJaMuv
         sazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663045; x=1755267845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCZSOYF8PSHj4jQs4HpUDoXYbfQq1/bAG9Xt+aFTqdU=;
        b=fhwBYy2lByM3mUzhxQdZsAAFcpiKu116p2CHcXfDcDxvybx0Xb84gInaVDIAkS2WOf
         XZUL3IsgotM1XZhytmKg1vHFIIwSxhhtKElZxOtw059iUzjTAKWs4/RdSKAAV5ApDpqa
         MjMQddHTRhJeyv25iJyAyy7jTybWIewF48vvVRMr1nXXDp8a6y/+mLNrhCrKlqM4P7XF
         NF/5GGSbaohs8YoQVFrca1OwJcwFbauYfoV22Teq0bH6j8sxlMlfmxqd74TuT18/bPwx
         s0DWkJtW8vDUYgPgl7W+AYaHmslH0kZa5PWF70KOUFN/q3NzuRPmmh3p6W0j+E3kJUtp
         16cg==
X-Forwarded-Encrypted: i=1; AJvYcCU3fRrdIB1EeLeFfedzjcqIf0KOkBbuf/PPX9InLOyK4hA1zdHoZSELLZ67JQzLFORq/03tGwy7gfLe2cVj@vger.kernel.org, AJvYcCW2pjyfSMnzHxzv6nDlwi6s6+SlHHVTZq1VylzdA3vUhR7MVn/CGslH5fOZyjpxW1ePFgfuC9UFKIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDg/hnQTRDzfScKfwRHW7F84BQUdefuNrQkuZbUHRMfuGqzwA
	jbBhMIHfsqx5Jlr7voMDsNKFzo3J8x6XvphlgvB6opCoyaiAm1KtAUpESz1K2mIUiuQwQcSHG30
	oIbv/0/mdVBBkboiVtHycYzbmS2U0Z4U=
X-Gm-Gg: ASbGncu8na1svCBpolw/v/WxRFcE5Z5he3UuQVE5LY2DAb6JYaIWQXrBd8EM3JJ/JKm
	1+B0mIjdf5GsYMtP1UkXZF/Qxiwnylf+JONo4MvWbyMQv+wyTz9T2PC62IDI7xFBhn5UrTo2QZa
	oLFF/5HWmsTXmjLRVzJ+/XnnNoOQ39ozv4QZgfgMSweks+sjGTmgOY0LWjqxEORxV8HHKyrN6CA
	7URKcqj
X-Google-Smtp-Source: AGHT+IHY23/V+6FwJ2b/4h9ZiCv+zAo8Xxlfw740RmHcItGB7nsxEZIuEWooQO6eMQZ5iW1V9ldfh3maKoMW1qPa+UM=
X-Received: by 2002:a05:651c:2152:b0:31a:1e23:a46e with SMTP id
 38308e7fff4ca-333a213bc0bmr3789101fa.14.1754663044368; Fri, 08 Aug 2025
 07:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
 <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com> <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
In-Reply-To: <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 8 Aug 2025 19:53:52 +0530
X-Gm-Features: Ac12FXzivJOBx1qjuN5gbLVqGTlza9oQ4g89hXLDrJTM3SITu0ihM4mvLo-DbvI
Message-ID: <CAE3SzaTq90n3HP6UrtimxqbmhfkxPNBdby0tY9bxbxzc9pqvqQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:18=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Are you sure about the remove stage and how it interacts with runtime
> PM? Please, check how the device driver core manages PM on the remove
> stage.
This driver does not even have support for runtime power management.
Pardon me, but I am not able to see how runtime PM came into picture.
Am I missing something here?

Code walkthrough says the remove call flows from
driver_unregister------__device_release_driver--------
dev->bus->remove ---- i2c_device_remove-----.remove() callback.

Request you to correct me here.

Thanks,
Akshay

