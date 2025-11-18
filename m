Return-Path: <linux-iio+bounces-26286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A20CC69494
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 13:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AB1272B2D2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2931D75C;
	Tue, 18 Nov 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSyJWPox"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93530103D
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467865; cv=none; b=SvR/IQ2WTL3A9c83YXjjBONY9xQzNxBKHMDh/vygSizOQYUeK2PJ3hA3bRA45e2Qf8hu+KUnalKa6UhE5yyTN+/KLF5mfeMFOurPRaEBjHhwsDPX/jDndVnwh8wDhLBAoza3d5ZPClpkElhssSp4t7bblSFsKi3duaUI+Xnd1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467865; c=relaxed/simple;
	bh=17XNnwLdMemyuDuOqXGKlJ5O6NnP79UC4YL65XMZBtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFdD9GWkEEUwmXU7HP96PcO2IAVCF3wzuX0fgvOtk9TFGiTuuuI1UDpJW1ovIdBEX/S4lB63/h3s5S1upcSe3/v86YjS59KWQ6HHK85msZpLxuDyh6bNVVMhK9iM5us9S7tH04Rk6VDBKMF/NKFU0vQ/CbznDVa78yCOGFI/UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSyJWPox; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b736cd741c1so647027266b.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 04:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763467862; x=1764072662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S96NTwNKmvexih7lLAZCcVSzdOV9SItIYr/gsU2pZA0=;
        b=fSyJWPoxAO4jSHOdJIib5sic5IYBwANgfyj1zozA3vQ4oGWTMaPCDh+AO97Tp+AbXU
         hf/dvUJlmIKftYb236v38wuh87IvTv2nJajsTXjcp38iQHSdMqxbPp/oDYISF1U4FYfb
         Dek0gpH3aChBNNxKbWl2XzNTIjmyyjbU0N+hGj3R3DasbPulKspmzhOcSzWtyooIo+Zo
         Rnk9qPEFl6nd0KF77dlx0rznjJlNXPpqV360f5it3FSX9CdJQb1CzWlhJ8x2H55NZGq+
         Lhbbu6/fEm/7LzxUEKaDHjhdXzea6kHiaBzVcPSnpKCMl2fwjR9vdqUEeT9Pru15H+w9
         YpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763467862; x=1764072662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S96NTwNKmvexih7lLAZCcVSzdOV9SItIYr/gsU2pZA0=;
        b=xGw4kQ6WWivjq0X3uZOq8odC8go+riTcOtw9MrvU2yD2PQS95mQgNrZwWeRGTf4dRv
         QURXb4sT02hzEeEfVNghQdQLNg86iJk8OxuiBEr/qNd25+wcBd+t2xej+IDn2koPRzhI
         9cwMp+ZAIB0Lale6xcKbe/HQipQZBkEfny0QN+1ij+rxHLtbpFVaXqZlQo0vF62Kfh60
         hWo2xLNF3pQKTBcS6Y+grSMl9KLFAyccoKbaHzKgCFLz2wEnoz0zYODyPTTm8ns1u2xc
         TJRkAz7iot0eOcQTkw0vdPIvF/bnN5JFtDEBn9DftduUY3pqKIjEnC1DsbkezA6PHX5i
         F1PA==
X-Forwarded-Encrypted: i=1; AJvYcCV9hBQlaza0qqjmkSMFSDEyn5GWCfoqbT6fZgSYcDOEhbiKNKPMpy8CxRckmWrQad5TUf2Jk2FSRO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVtPpKVLKaqNrkz+V/l1p/wpwRf3QyYl7ov4ykj6SpB2q/LRl
	k57Zlp4riy71dgRqXKrEmq+lJN0ZeQU2p+0ehYovm/CL9bGzhim2AWmBTASs+t+40MPWcyjHKl0
	KdhYM3w5Fu4dGx5g8yzMGkojI/DNpY70=
X-Gm-Gg: ASbGncszkDjf8Qz1L8sR2xId13MUa09nTCbwsVl+mknCyc6KYr4zAuxwxWHEPBAq2eU
	KRnMg0SMqXFcoNmDMJmtavHWdjPSM1T4jm6yQOd8VBbxemjolSFZaRcqKC8AWAD95rE/CIeDDLK
	ya/wDF0QB2bYc4SWfpBDE0rwe/ZnkmyAYEVhoLfynS5psknXVSGKLAOHGrRN74acG3mDH9Mb1li
	4zaM9kTbarMyBGYRQM+7AAmHZRIHE7PfbfVthCsIbEB0BsH6bpOMnA1a91PLttnydiRfwIxD6ig
	1zKvmt1EVjfAX1mceqGevS856TUeomV2lFP84t4LvVUSUAEgvE8xlRT8y3CRty78D5JwtYk=
X-Google-Smtp-Source: AGHT+IG086oEWZheGOwau+XoF2l2bVGxVG+fm1vm1dIRHk44wbZ5lS3J9QohWdvbh4rKsAG9075DeYIITho2M4cbvx8=
X-Received: by 2002:a17:907:8dcd:b0:b73:79e9:7d3b with SMTP id
 a640c23a62f3a-b7379e9837cmr1402879066b.25.1763467861752; Tue, 18 Nov 2025
 04:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
 <CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
 <20251116152800.4c1849cc@jic23-huawei> <34a55901fe0729145097d287a98746f23eea13d8.camel@gmail.com>
In-Reply-To: <34a55901fe0729145097d287a98746f23eea13d8.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 14:10:25 +0200
X-Gm-Features: AWmQ_bnlFWB8k-p28R4cyez2s9mHpB0Dy7l8qo3cMKv2hx7hvO6Ni9lYDoVRUbg
Message-ID: <CAHp75VejBvRX=5psgVgGPCsKk7gVgcDUd1q3Gn+4_jyzk=2pEw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with sysfs_emit()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, 
	Michael.Hennerich@analog.com, lars@metafoo.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> On Sun, 2025-11-16 at 15:28 +0000, Jonathan Cameron wrote:
> > On Sun, 16 Nov 2025 13:08:07 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > Applied, but I will note that this driver is a long way from suitable
> > for moving out of staging and I would be surprised if more than
> > one or two of the lines changed in this patch make it through the
> > necessary refactors (should anyone actually have another go at
> > doing them).  Anyhow, I still think this is worth taking just to
> > reduce the noise of remaining instances of this.
> >
> > I'd have deleted this long ago except I actually have one somewhere
> > and it one of the supported parts was still listed as suitable for
> > new designs when I checked not long ago.
>
> Seems to be now "just" in production. So no longer advised for new design=
s. I gave a
> quick look and this is far from being a simple driver. It would require a=
 fair amount
> of work to bring it out of staging. So, are there users relying on stagin=
g drivers?

If there is no choice, yes. For example FBTFT is famous for being used
by IoT / DIY _a lot_. Currently a bit less since we got tinyDRM
subsystem with most popular drivers reimplemented there.

> But I would assume that for staging we are still free to drop support it?

At any level, we are still free to drop :-) Just different conditions
applied. For staging is basically an "effective immediately" case.

--=20
With Best Regards,
Andy Shevchenko

