Return-Path: <linux-iio+bounces-27416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011DCE7EFB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 19:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198883072EA3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7F27A907;
	Mon, 29 Dec 2025 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us/vaexr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A563275864
	for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033959; cv=none; b=XxPWekx0WPEEoYJAZkcvlQZasLchqB+WL5GrrsSRC1EZr7Z78KL02hKiyr5D0UR9xj47KoJtDxkVaq2dso59TkurzniLbOHUM/W2Lv8OzjOa+G4WFMzouG96DBygMb8q4dp7kfQsiEjfaFHt0VUA5iuZVtWvjH1OLNWnGwEZEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033959; c=relaxed/simple;
	bh=u2zY1U/O5G1mW4q0DJbO9nX1EVe6Wz4mhjjdI1xUbhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnruoRRP3UMexDrA6G/ioF8jCnYq9rOVbA7jITnoK/ev3xzUxkyRFvo3hFGWD5Py5fSdufrK2MbX/OVJg8oak9GNgT6NOUNB1QUZYDzoh/V0U+1DUfQM52sTpk9cT7hVCoGeQeQhtrdzYRBzwajLzj7gMVBJ7HUv3Q8saePCtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us/vaexr; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so10921182a12.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 10:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767033956; x=1767638756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz73L7aF/6ZlEa0FxvRTURfLB54A5VMkd9bhOsz/l7c=;
        b=Us/vaexrG1+NlPivVSln8MzJ+fFcTVfumySUh/pp3rxhCBKbspSqMnrX2yvP/PUdiz
         AAhQImetIvYlY3Z6xvUf8qsxxCbwl29kC2rQvOwrDMoJC9VapvVFHbHFKm6qu82XbBG5
         zjTh8k5fLvlgZVmoVI0SM20AsZaCjJ2MDghy0b7C0vAQLW+dhxI7PM1HjGoHQ9ybCUfQ
         /03y33qK+uKj4t2ccgLek5PC7/0+KtEK63hV3Q1w12/CGE0+y4p78Okwj0h/T1RF9z19
         UFut3ZQemDXp1gIXEXPB1iTELDEfAAe2eSs2fh6xqhHnMSGkABT7bBGXYB+34vl0nxwX
         RHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033956; x=1767638756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kz73L7aF/6ZlEa0FxvRTURfLB54A5VMkd9bhOsz/l7c=;
        b=hK0Gf3DnPA5KPDD9po57mdh4hC+mYDHVNFJ23weu4pbOMOC92fhCH7XZ7uDEt3e7bD
         VkxeyBj4AtS8RzSdrPW4/a2oL2pfb5ITdqvPndNooVpAMDv/xBV4BJwHCUlT/MpfOTPt
         fUJ3m82WQ98Yug/qv18unCrAyXzbkw4LHRv4NB8S2q0P4UI+2xmR2A3N9lsqWjqrBIS7
         I9sZW/kwmYUhQm+YHJ91hFfE7dVTS04kRTMIAT0m3DZS1x1zX/d5/ER2aRkAnrzIHAIk
         yuZK8OxHbyEurhhIgreY2tfF040MtA+r1DSu6GqXG8SGi6Pdc6usbGsmyRAyDKz+jJTG
         7Ynw==
X-Forwarded-Encrypted: i=1; AJvYcCXRimLjFhsFPfLCTDRqFc8ectLKj0frfZNEo9ZIn7xDpQ4J2CFtCTPNDlZ2ZNSSIaGZiW9MvULdHCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6LUNEAHfIqz/XJ2wmfr/9yqKa2D+WDb3G7wSw/jD3FBiG5Ak
	c3nci7vmEEvr+Iyy+2xvU+zj5cC4viUkFanXbKCyNI4FtJ4kQPpcF1WCqkupU/0juE7ITcCQ567
	KJt89kLXKMKCnlw0jf+JX8k+NCDwdtrw=
X-Gm-Gg: AY/fxX4CFTuvJCdYhu5HPxMEOy1Jl03cri92tEhplwuDtiBia9CZkmFbS5HCsXu6Suo
	uPKjv53XawYYb0jIIS4/XYhw6Ot5xokPHwIMVMQICQ/v3DONUu04hnZlv40JZ1yvWtNBazDGPO8
	nZ1LwOQW0MJ09A3mLCbZ7PdqJ6sjWEv6ZtHu0qKstyhEXveQ8uddNcc6QH7vjfYVQVeWtFcaZTG
	K+EpXGLbg9LdvqXhlICzyc294yZsc6h25hw0HwQZBtvIbCILq08bcFh7XEz/8KWmtmK9GCukNMB
	Oasr7w==
X-Google-Smtp-Source: AGHT+IEC49B23O+Bts6AqmLDVnvNNZzfpis9MhDL3XTVwpdReLOCpD6kqGv+rd67jG2Rx6ZXlmQ0phscGHJGzhjuEu4=
X-Received: by 2002:a17:907:8686:b0:b6d:7288:973d with SMTP id
 a640c23a62f3a-b80371d670fmr3604915766b.56.1767033956266; Mon, 29 Dec 2025
 10:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221083902.134098-1-raskar.shree97@gmail.com> <20251227174559.33539640@jic23-huawei>
In-Reply-To: <20251227174559.33539640@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Tue, 30 Dec 2025 00:15:43 +0530
X-Gm-Features: AQt7F2p-T1z0aWFMc6ZZeigVmg68IHmZFEwwaPJJdgjGaGINzoxIS_oDpv4nWG0
Message-ID: <CAHc1_P6m11M=1bP-0k_ndgtkLtfnkSCMScznCC+HnWWQ1XtGHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] iio: proximity: Add interrupt support for RFD77402
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 11:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 21 Dec 2025 14:08:58 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
>
> > This patch series adds:
> >  - Add RF Digital vendor prefix
> >  - YAML binding for RFD77402
> >  - Add OF device ID for enumeration via DT
> >  - Use kernel helper for result polling
> >  - Interrupt handling support
> >
> > These changes enable DT-based configuration and event-driven
> > operation for the RFD77402 Time-of-Flight sensor.
>
> Hi Shrikant,
>
> I'm only seeing this cover letter (and lore doesn't seem
> to have the patches either).  Probably need to resend them.
Hello Jonathan,
Apologies for the confusion. I have tried re-sending the patch
series multiple times, but each time only the cover letter is getting
delivered, while the individual patches do not seem to go through due
to Gmail's daily sending limit.I haven't fully resolved the issue yet,
but I'm trying to figure out a solution on my end. If you have
any suggestions or best practices to avoid such delivery issues, I
would really appreciate your guidance.

Sorry for the inconvenience, and thank you for your patience.
Regards,
Shrikant

