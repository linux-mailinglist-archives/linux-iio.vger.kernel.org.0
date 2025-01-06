Return-Path: <linux-iio+bounces-13933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725ABA02705
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728937A16EA
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225C1DE885;
	Mon,  6 Jan 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKjA9MhX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE611DE4E6;
	Mon,  6 Jan 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171118; cv=none; b=GRpqmRI6NyI9BIrtwvIvXLJRLJD0jQZDTvbY0Klk5wjAHMoRz9pCDlz++UTOvTUHWYE/YsAqwr0oYK62MjxguYQwGLXTpEQlE+oTPFTOkCvVFrLIL7CvWsEDjQbmPJ2ZgQi/Vm25MwGRqocqQNORNggKq/0snUCiAxkD0eKek14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171118; c=relaxed/simple;
	bh=yS0zY0kAp+pL6lQ0uh/hRLrJOiF+vAJiULkHHv+EE4w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DwFVZLGWKSMAxnlFNEjj81itjR58lA1ixyabI7zW7vQMO7AnCUTkRsbgJLcJZ4gefuNF5jI2vYSeWSxb5uWdxTuzWofIpVstzUh6TihtKtnTzGK4eaAxDL0uLxDXdUa588EHf03JhZKvOTJpmFJ+iyZj4ojiKBPqB6/e9mMsJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKjA9MhX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43621d27adeso99554495e9.2;
        Mon, 06 Jan 2025 05:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736171112; x=1736775912; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItfAlhegRqUnAayH03vNTd/Xo24KQrqpjT4xjTRai64=;
        b=bKjA9MhX/TO1dl/f/i/O2MTmSt26CIRUuuyIqRtJxq5EOOeEXq7JqJy/9Fpe3kKnQj
         QcNWlRELmIa4uAqDtZ+BnP485RtPxiA48lZUTcBknAUFwGLTSxlVPCeBVDhk8LdNiHyW
         gum9DZlgU+3DVFH3cyhKGcw9ghoK7PKfwMEQo9gLk/xEB5sdpbN+oqd+iSZIfR0YyhBg
         geEb5xWAvK/+LzaozJ83yz82CV9+TEAab7Hg+Sq5FdrAB6Wcw/PvyXsPT4aD+n20zLsL
         E/sxb3qKflJJngVjBCav+4ZbKnecDmpRYyKeokZPBi6MkaC/6GnR8uV1eJ9DTGzgQbrK
         AkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736171112; x=1736775912;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItfAlhegRqUnAayH03vNTd/Xo24KQrqpjT4xjTRai64=;
        b=TQavczaN9fwkSIEUoo2lBtJ69DQfu9HUFSGtjOZCHvtlT844AsN1J6V5oL+8/cdFaM
         NsAbIBM3HcOunNB+UzhGy//KFeMNY0xhJTwC7wf6zguOmU36ofjYkkyLhU5O1v3Y4EKF
         uDuJDFt1TABpMaeAup2Zu2T/iKewdXCfJExsmKpDTIQ/9LFZ+2R1xoELkwaxsiRWCFPX
         FTU0UPFvdejBwSE2nyk7+WiF3KA6ysZfoZLD1763Kmi5QEbGuaIk28nCQrVpGrWFIEzQ
         9tMbGd76/hPpvqs0PYAx/b8xBsz4jdt3DeFAXypNrrjNcHTUhEfGyVbYVNzVdQw+GDtk
         IDHA==
X-Forwarded-Encrypted: i=1; AJvYcCUMmHe4BVA+s//Lfyb9XFSglaSL9zY5LO31NmX/wBUBFPRzCmWVIXi+ln9Jh3WufMmj4jvHpP3/b9Gz@vger.kernel.org, AJvYcCWFK2MzT3IytKH25iySu8cnPYuR4sDizZXn1wMdvke8WM2rzvjU/u+bFp0hXJugd21xRxvq7hrD76P5@vger.kernel.org, AJvYcCWWJvUEyPWDspup6pZRqbzOCdDX277Lm9kksmhJnya/nTGyJxgRqZCk4+9QMja/h+ifJVCECkN/0rgTRzHT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uf9WxOsSHNQl6nvxlNjLiMBvF2wVItMq8l+VDGHpi4Uu6X5l
	mTrw+d+EuKALjEAza03PhB9IHKdOyLPWWuFCiCpMj4BbpdnTwqN2
X-Gm-Gg: ASbGncvTQVxFzb417Shi1U5trjCQ/Spg0pbARtMqhT816iMHO+XBNJC6WCirHYSbDoE
	cGTCHwgVX485UNGm0xaHECjj00Qd7T3y7tjrn6b+U/8yMXnbPEcIf5wrYsBre/uioZWjdR7kU8P
	WQ3Gd8eMzNev1plFuYq77iyAPKQGKvG4LlmNUOek4HWaZrcgOEny3LEmnWDLbcTQgpBkx/xBFhm
	CY8qWdZ9jhR8O/XcOZURTeQGcfh39J2n3daP0yVSmqnXW7WRQXh65D4wLLax/zv/VeFE6sVhI/x
	2x8=
X-Google-Smtp-Source: AGHT+IFpYq7jObg5i1HWdwSt3YUPjDcKdkOSTUzwLSeVbBRKvKflO+nH3UXeFLKIJPIauB4ckmahgA==
X-Received: by 2002:a05:600c:4510:b0:436:5fc9:30ba with SMTP id 5b1f17b1804b1-43668b783d0mr462344865e9.29.1736171111550;
        Mon, 06 Jan 2025 05:45:11 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474c2sm47324663f8f.55.2025.01.06.05.45.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:45:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [RFC PATCH v1 2/2] iio: adc: meson: add support for the GXLX SoC
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCBxaVet9HxW98uCSDnv1XVXV6r4V9Z3BRmZJypTcxDZ0Q@mail.gmail.com>
Date: Mon, 6 Jan 2025 17:44:56 +0400
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 gnstark@salutedevices.com,
 lars@metafoo.de,
 robh@kernel.org,
 krzk+dt@kernel.org,
 conor+dt@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CEDC847-2653-42F3-A85E-A06D6E5DB135@gmail.com>
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
 <20241231194207.2772750-3-martin.blumenstingl@googlemail.com>
 <20250104135912.390ec87c@jic23-huawei>
 <CAFBinCBxaVet9HxW98uCSDnv1XVXV6r4V9Z3BRmZJypTcxDZ0Q@mail.gmail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3826.200.121)

> On 5 Jan 2025, at 7:49=E2=80=AFpm, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Jonathan,
>=20
> On Sat, Jan 4, 2025 at 2:59=E2=80=AFPM Jonathan Cameron =
<jic23@kernel.org> wrote:
>>=20
>> On Tue, 31 Dec 2024 20:42:07 +0100
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>=20
>>> The SARADC IP on the GXLX SoC itself is identical to the one found =
on
>>> GXL SoCs. However, GXLX SoCs require poking the first three bits in =
the
>>> MESON_SAR_ADC_REG12 register to get the three MPLL clocks (used as =
clock
>>> generators for the audio frequencies) to work.
>>>=20
>>> The reason why there are MPLL clock bits in the ADC register space =
is
>>> entirely unknown and it seems that nobody is able to comment on =
this.
>>> So clearly mark this as a workaround and add a warning so users are
>>> notified that this workaround can change (once we know what these =
bits
>>> actually do).
>>=20
>> So IIUC this is to make some non ADC component work.
> That's correct
>=20
>> How are you handling dependencies?  The ADC driver might not be =
loaded or
>> is there some reason it definitely is at the point where the audio =
driver
>> loads?
> Unfortunately there are no dependencies at the moment.
> To me it's not even 100% clear if those bits are a dependency for the
> audio IP or if they are instead linked with the clock controller (more
> background info: some of the MPLL clocks are - at least in theory, in
> practice we don't use that - are also used as input for the Mali GPU
> and video subsystem. The only practical usage that I'm aware of is the
> audio controller).

In my testing it makes no difference to the audio driver when the adc
bit poke is done. The audio driver probes and loads and you can play
media without generating any visible errors. There=E2=80=99s just no =
audible
output on GXLX until the poke - it=E2=80=99s like hitting an un-mute =
button.

For the series:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

Christian

> Christian and I have both tried with all of our contacts at Amlogic
> but did not get any answers.
> If I knew the purpose of these bits I'd model them as whatever they
> are (resets, clock gates, ...) and provide proper dt-bindings.
>=20
>=20
> Best regards,
> Martin



