Return-Path: <linux-iio+bounces-26787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A95CA77D9
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 13:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B233077E4E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1F732F757;
	Fri,  5 Dec 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Zo+Mi/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8A319850
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936002; cv=none; b=qp7RoaJmWKXIkvjIYaq/Ek9SfS9CUw5oIsEzo7A9nJu+Z0pza/XBApK3RnMDkO83A6zJnQKbUeWm564DnlKIp/fslSUAda6xmWRiHOcYzdCUM5klut5aCiLLIs4bdeIom3zlUzyEtDsr6MuDBv2EhC5iuk9BM5UYi71Ud7ZlIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936002; c=relaxed/simple;
	bh=jVqMrg+A47H2zjTYGrLGwGz2mIySQrWA9BXlTHSCoj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N763CcK3tjd6O0cPbUYOMp3HUIbrIxVXLyUt41hELMvYeSbzhCqChNMPs65iqNBnP5Ee9YFkGxri2P4plMqNSLsOX82JQPz70u5dkoS+6RbLv5mcNIJLhBAAXBdItY5eNak07CkOlj3UPwBnLJWuLz8Cm6HGNgfjPYYdoKhOUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1Zo+Mi/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b76b5afdf04so302424166b.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764935998; x=1765540798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVqMrg+A47H2zjTYGrLGwGz2mIySQrWA9BXlTHSCoj0=;
        b=P1Zo+Mi/36P0ALphUhwPq6kb+SdH0/UPh2e0M3cGaJbRHL2TswWLBprtl6B+JpxphC
         Bf1JwZNF9GiA6sac3Mqp95YZWj8GaU9K7WcD9DkZwSzb8aQueVuf7BANngABMTAF6U4f
         bq2fIvmf81T4L6yy6UdltYAh32LcU7hJH0Qktbp1U6DIDbwzr56onaOW1fsmV/imlNAK
         juzialOgl+6CkGs5eu66a0RURlIdgydlUZdeyP7duraAq72djruVV6QMSjT7OTlxfkGz
         eyu7MW7+IrTGasofZKx68a3c08mh2LpypfMJD8SxZ7FbmNg5S39eTfI0GXmDdt5wlkpl
         whSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764935998; x=1765540798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVqMrg+A47H2zjTYGrLGwGz2mIySQrWA9BXlTHSCoj0=;
        b=bXFaFFrGPR6k+CLVemVCIiNcmp61lg/bize+en43EjK23yUOJx2PZC4q4g4hHi/dB+
         h65obLUrOlD01xxaXFr2byP6FCPm1Je+xv26L4KeIjeL8SmzIT/QiCHhzLdxayalnjRL
         zsYLAPNboz0KVEBbfIqzjltBLoCT3zpf+0NrHIQMVD4rhLdzrjjI961NOKt8NGiPskCv
         ExQVtwJfjkxg1JmLi/NId0WHdI80saX3+4YI105CxE2DWCuAAgv+COAIec6JtVHUNtfO
         PC9MPVY56Su+VVgheFa8cbSLKJEeWybcAPz4QoKX3xGAAEWxs6LGGQVU8buBmfsEfBmF
         JAmg==
X-Forwarded-Encrypted: i=1; AJvYcCUf6lSXSlE9264ZH8BpeGpy5P5zLTC5bPQwIXHjYHGxh0OFceulsF88qeskppM5JnYqtf49ApR8H0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVCmvHPJzzXNN7SQYSQdgWNI9HkZ5QmkBoy+vzXimLuyzC3Gj
	j3Y12kQ9QMyn0RuktHq5Oxa2v7RTYaoBi+Rw2NBVT12P4jllNjqxD4qeTVOlwjN8k5snF7wK62S
	4bmds9ipj5NugjaAi8hvEVmfq/BWelWo=
X-Gm-Gg: ASbGncu/gHbwKtxaGydLX1obZuxMbxSgRPoX0ZwPHlLaMeDkZri8S3bY3Als9Ur+U/1
	dKJdtNn0FPp0N1X5+8uCuSWsrE4XRk73qP7/rJoAIrWf6RaJ5uhkkXtnrb8Kj9s3dN55d3mNi42
	e/miIvPDaEoWoXm8IadPqi/dDKdTRqELRAm4HZr7Le4SBJ5Jy/e18Scw/S4HODdIkZrFmv7c72Q
	QMLQpMeWfDV8YhkM+xm33RQmlNwGlIaDg/JaaGR3xXTvMFd1Roetc1mOTE5tz3rF/28UqhQ62lw
	mTOSXIkHoeCOwYVvjEhTrY4hhQjSZih6bCSO/KOmwwhQ6phzO7A8+G5BjzixG9D2Cf38k0A=
X-Google-Smtp-Source: AGHT+IGOCYPdLfHy+mrMcAwzJiVXn2hrBbSyAPUcFQ7TxX6PZMhE0DKFSXlFzbZ8l/wWYlRGRGVkoXNMC0NTaFa4CXE=
X-Received: by 2002:a17:907:970a:b0:b54:7778:c62d with SMTP id
 a640c23a62f3a-b79dbea380fmr919219466b.15.1764935997559; Fri, 05 Dec 2025
 03:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
 <20251204-iio-axi-adc-minor-change-v1-2-2d441d6c5b65@analog.com>
 <CAHp75Vc46cy7vGPAHksFB5QT0Mc_ztGaODtyLeEQHveNrYKg=Q@mail.gmail.com>
 <d385344e47410305be75aed6ad1d1183cb93d450.camel@gmail.com> <CAHp75Vdk7tsqzf04SGWuCY+=q95HhA0A4dQy15QceGieQqQO=g@mail.gmail.com>
In-Reply-To: <CAHp75Vdk7tsqzf04SGWuCY+=q95HhA0A4dQy15QceGieQqQO=g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 13:59:21 +0200
X-Gm-Features: AWmQ_bnn7Gx1nIQ8uaxdVvpqVVqKP2HAXwmvE6h8sBaJozB9XkIBY13G5q2BLwM
Message-ID: <CAHp75Vcxu87JFwpd=+yGonhYZB0a=NK=1MffP4j=Md7Vb8G-aA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: adi-axi-adc: Turn dev_info() into dev_dbg()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 1:58=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Dec 5, 2025 at 1:24=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> > On Thu, 2025-12-04 at 21:11 +0200, Andy Shevchenko wrote:
> > > On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >
> > > > We should not abuse logging and logging a successful probe is clear=
ly
> > > > abuse. Turn it into dev_dbg().
> > > >
> > > > If it turns out the IP version is that relevant we can make it easy=
 to
> > > > get through a new debugfs interface later on.
> > >
> > > Hmm... This prints a version information. Does the user have differen=
t
> > > means to get the same information?
> >
> > It can read it directly from the registers through debugFS. But is that=
 a blocker? I mean,
> > there are tons of devices where we could potentially print some product=
_id or silicion rev but that
> > should not be a reason for bloating the console, right? Or is your argu=
ment that once done, it's a
> > bad to take it back?
>
> At least when one of my regmap patches regressed, this was the exact
> information that was printed by the affected driver and more or less

Just to be clear, the "affected driver" is *not* this driver.

> immediately visible to the user and/or easy to get.
>
> > As mentioned in the commit message, we could add a "version" debugFS fi=
le to print the same info but
> > that would require a bit more work.
>
> Not sure it is worth doing so.
>
> > Anyways, if too much trouble, I can drop the patch...
>
> Up to you, I'm talking from my own experience.



--=20
With Best Regards,
Andy Shevchenko

