Return-Path: <linux-iio+bounces-23988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AAAB534BA
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 16:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C9B63E2A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530C32F76D;
	Thu, 11 Sep 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfx82vAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02B335BAC;
	Thu, 11 Sep 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599208; cv=none; b=Op1uzL77bRPJJQVlB5ISs5o/y3ramMl69/lJALM4eEOVgZtczvzPCPCc09/O/A2smxoMJrDksxlM1pCxyZLSaLpZy94sWzd8VAhIyDDy1CY4W4dRDgeHXMeIew7fHZmCFeeqojZ8bEaa7IoPB3oyFH+/o+mAUEC+RpnmviGUlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599208; c=relaxed/simple;
	bh=KAWNXHJC490Xdv/Jm2f53Hj3dPJm3UGG+5Ivgh+fgdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbAt4bJvLVAW3ksDvyYBqV+iE/bmHqzKsKDBFXm1mK+K/yh9tyJAUG136vjJer+F2ee9omLAfWmozbsYC0Ohw0cbvJrLdNfcNVYp4v3vjJJJZRaapu9efO/kaTP7mUvGbbeQ3YtpgGN/pftcSvG1aWRGHIPn5OCh+hx1RgWFNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfx82vAF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7322da8so147391166b.0;
        Thu, 11 Sep 2025 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599205; x=1758204005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAWNXHJC490Xdv/Jm2f53Hj3dPJm3UGG+5Ivgh+fgdU=;
        b=bfx82vAFhYi+SX740k7qwg2iP9PoEMkZ3IbRbQxka6tZT+l7zd5rCMOG/bpUXDzYmT
         R+Tj8FUjjoPi6Semtrz/IrtH5V8mtuJhIW6w/yz7YJ/MAdVUT4ERsyfN7lMtpPcuDDEE
         IOv5gMMtPqqxKUMHpHo0YNfwFvDHeM10sul8y5bVMY9eZ49ZLFD2X9DIILoibQTbbZW+
         tQL3Tv8029O9aQNV7jf6GMtViZqYn7yGsmfanNr0LoJQFbiJ1ee4p/BEaHHrI4TZ8ngh
         Ytjn4hoobaYOR6DuVl2+H0pjw0Li2/l8Z8VIC1jIGvqO6tMOWeoJbNr8LQo7S8hizorU
         qviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599205; x=1758204005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAWNXHJC490Xdv/Jm2f53Hj3dPJm3UGG+5Ivgh+fgdU=;
        b=hWuD5MOJLmCrWJw+DTwXorx7lLfNAuVGJuR5ktpDgnDeZlV9O0eSPWcUd1ZF1loEUA
         QLwmVH+yRJ0pIIPlR9nP2yAsLLAW9mB/xUTn8qaVXGwx/LSFMZLXAaKR0fhszBWGUaxQ
         TSS11z3juxDWZrT29UU8yQX1Nv8poe0Xrp2ziBAe0s598lYmgWU5hUkFQE5nZd2TXd/1
         Ww7ygy50bYy8hRMI5KuGi9yMTdt+99u5rawjN2Qk1d5ON6HbLRsxPO16GC+macKwnb31
         MoN01+Soy+uH+j3g01iVOFnEgYJnoMq5dpsdcT8gLZAzD/TYM+DSE+H7xvddJtqbI96J
         K2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8s/J4se0AiILfSRGCN5oFczziv4ZK9eZsqzuXy8Ojb9vlG6v3Gry69DC0Pzn3UooRcxON88kdesy/@vger.kernel.org, AJvYcCVNCVohKGkQLX6n+QkR88nn0mSZOyzs2sqOTPjBUfYcGUFcdglT4wSxhjjLB304IlNib3z5Jusfcw+vISku@vger.kernel.org, AJvYcCWP6EKBrrm+WzEao2mehCUAJSE5n7Pxjj1A0TexV512l+Uj2mmYvby9s+Bh8uedVV4uxxhqRjSc/kD4@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLQSO+dJrFRtU+HOfo1BANkNr9fbc5i6n8Sf+2zyP8biLPArq
	tYI3k6S0vzC0Fo5H/OEVP9j7zxzdSO6Jm/ckhXK3SMzGnw1WKRg5OBHmPU9qUvn7RereFXp+TtT
	vQc1VzO+x+GOdlSK9kfYFLTAPcuGPUyE=
X-Gm-Gg: ASbGnctA/zZ7xppr1/KCz/D/i90lHSZn1dRqz+EnH1UrLDKRWYpshjwY9pzURpvIInk
	m+ctv4TfoZuoZp7t3dnm8pTbvkf3Fl61Bi6tV3J8UYKD+v1s1x/rX1GIhfBqlK0RBfg+Zdyu8BQ
	l24B/JcDUlLobB4ma1aEgTLgHvywtz9a8m6uwA+lo+CmQW56XdRcSAOh4rN+XCVL3VPVHIKz1Hu
	sni+2XDfw==
X-Google-Smtp-Source: AGHT+IFMSIxT0DvJYxyQvFL1fjp2tZVRPvFNOGQw2mzuUtE1CKhFGnz+lVXAWGyHgFJrJmYFfytJFnJ0QvBeWqr9YRA=
X-Received: by 2002:a17:906:fe08:b0:b04:3a9c:33ac with SMTP id
 a640c23a62f3a-b04b16bc468mr1856224966b.50.1757599204251; Thu, 11 Sep 2025
 07:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
 <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org> <aMLCWFatVkePTxCa@sunspire>
 <391229ff-d85a-4707-8e7c-ea64e0e3d7cb@kernel.org> <aMLUDkKhF_jhios0@sunspire>
In-Reply-To: <aMLUDkKhF_jhios0@sunspire>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Sep 2025 16:59:26 +0300
X-Gm-Features: Ac12FXx2dgo7w9UN0OCgpi1IaYy5kDkzCRoK71yDqZm3JQPTr_NmqaDeLEStBnw
Message-ID: <CAHp75VdGX7ntm356mm4fLKtYfpuUMnHx7xZVE90MOd_CxTwmmQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init stage
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, "Nuno S??" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:52=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
> On Thu, Sep 11, 2025 at 03:07:05PM +0200, Krzysztof Kozlowski wrote:
> > On 11/09/2025 14:36, Petre Rodan wrote:
> > > On Thu, Sep 11, 2025 at 09:35:52AM +0200, Krzysztof Kozlowski wrote:
> > >> On 10/09/2025 09:57, Petre Rodan wrote:

...

> > >> You just added this code in patch 6. Don't add code which immediatel=
y
> > >> you remove. I understand you re-add this later, so basically it is a
> > >> move, but such patch diff is still confusing.
> > >
> > > sorry, but this is an artefact of 'git diff' I don't think I have no =
control of.
> >
> >
> > Don't think so. Before bma220_init() was above bma220_power(). After
> > your patch bma220_init() is BELOW bma220_power(), so that's a move.
>
> you are correct, these two functions did change places due to the fact th=
at
> _init() started using _power(). I preffered to do the move instead
> of adding a forward declaration and leaving _power() between _init() and =
_deinit().
> the code was optimized for how it will look at the end of all this patchi=
ng.

The idea is to balance between two, but for certain I agree with
Krzysztof, we need to avoid "ping-pong"ing the code in the same
series. If you need to move, create a no change patch that _just
moves_ one function up in the code.

> I thought you ment the code that was added the previous patch was not rem=
oved per
> se from _init(), which was not the case.



--=20
With Best Regards,
Andy Shevchenko

