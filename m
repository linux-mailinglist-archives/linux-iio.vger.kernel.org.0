Return-Path: <linux-iio+bounces-19446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E409AAB2A03
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1BB189974A
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E15256C82;
	Sun, 11 May 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhOn3juR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F361FC3;
	Sun, 11 May 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984952; cv=none; b=kSVW1Y+hpmWhsfUPOc2/d/xufV2fpnjL/sLfaNp1hnEMPN6XxR5XMW+XTFdjlh8INRtREOvLSqI7YPMYIeuJEg/YXQgRd+IGeo1jroishxK9xl7kAgZlx2IOFGVNA171tH1v2Ho06WLFTF0F+ElTIDhX7gPkwQyTt+HK5Kf/UDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984952; c=relaxed/simple;
	bh=ntf5jPKUWH5mcs0SPq8ZSuzRmdoDim4/t3oU1Yllkp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+pIWvqYFM2mHXarcpCsu5jiHvjre0rh9sdZr1aESx8kSbGe/G0xc/q1srG+RzuqFe351+EHV44clvo5kzhQNbtIZWen9A0ox68sEBz6NOYvRLXYFE1FA3y473Gg/fFwmMzVriaTizaCeVHoig5x7xHP4WI8rHQ/wWmMwfD9tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhOn3juR; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4ddb9d80bffso2253023137.0;
        Sun, 11 May 2025 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746984950; x=1747589750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntf5jPKUWH5mcs0SPq8ZSuzRmdoDim4/t3oU1Yllkp8=;
        b=AhOn3juRBWEuUpIelq2uMoJjMcnePjDYZX9ykI1jR/CJ7FXIJ7uctRAAwBn7WH1glt
         qs1g7j5+RC43GNiexHLuBiwf7jXZVdqp3DstmTU+gywBckpKRR4I0gsXUHinmNYLEn7Q
         xDjA5J02suxa//KFzOCpEfJwkquVVnIZ/NPdMEJybq2v0bmfoaoTafFKrbp2uqO48E2L
         O/WZD7bQuGpCZL91/2AfnppLbXghsyG0KVguuqSTfLOn3/7iiDV9q8fkJI36fiXSvQsl
         x8eehBScVsfKu9g3Yywmg5aHf5gMhVQdLJ1TAGMaR3tcztiEDeDtx66//bKrHvGkYWHx
         LyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746984950; x=1747589750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntf5jPKUWH5mcs0SPq8ZSuzRmdoDim4/t3oU1Yllkp8=;
        b=VfF1zpS9yJxSfF65t+a6i9dDGeyEyaebKfJ9FnFFZASF0VnDr+1L+xzvrPrMKSxk3S
         /KUw3inN2ZA2/6sAViTf3DjZ8HC+4qyMTRVOsU/b7obtQx4QIlI0Wi+f3VF24AX6J1WW
         wirSgTQxWQN8uSSjLPgCyMo+U/SsZxl13EVkzjtywXs6jYVX2vbpyCi8LR/Y/1/p632W
         OwMqo6Qo9wRTsiDU+RV3OwspCBugx4j4FIlND+NsRmFpjL9V/4gLeZQlht4zHJkdYU6Y
         QW768rHUJ3xT9lej5qwxAlHa2FH+TPmtpNsuYc2akEPsnjsz90oReWOdnfOb2EX/lr6C
         Y9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZyGh+Y/MMUijyXJxEPuDDW7WljdB3IFknPxKXArnN97DHqeKettUJF4drV1EKdm8V9E2wYh2ZilJE6ad6@vger.kernel.org, AJvYcCV8v+39H0KrTesj/uQq/1T8ng0F0OSdYo22CVnV3yRu2oLFFPOKxXryT8C1J5oMJgQ0SBHqHr8U6Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74VT8s2/nXbR1pS92xVwmB3iNYayRKnrLtaP+6Ifdd+iqFzkg
	J/jvWAaAIlTa4RalK7LqsTy4LlHfcPFRahySwBnmyGHCCmPEAlgTCbOhrlTgZc5byLiwu1+djj9
	zSCzCK4yx1Hk6dYLwr2udT9MVJcc=
X-Gm-Gg: ASbGncsMiI18vaX5n7EiJ4BO2egy2yAqIdEkkWgJtVTuiaCIwrC+YjF4nflxVwioyRm
	uovN3LayOz2Fd3OYjUEzfZ201fHs/VJLyY9kwlr/YZrRB990U1g/9fqtqISlMgB66MmsP2BUFz/
	GqJLtYusgvmF2R+KWZ6PIfZEAxxQAFICZOMqKrzej67ikha2A=
X-Google-Smtp-Source: AGHT+IFqx/U9d6d0rFWoqyUQjqJ/LXu/A3Z0bAsqcmdMdvVWE/BoKnxnO5Rtp3ZHW7IfAHtgBp2P634nJcD3vDLVPRM=
X-Received: by 2002:a05:6102:2d0e:b0:4da:fd05:ab54 with SMTP id
 ada2fe7eead31-4deed33b0a1mr9174302137.10.1746984949848; Sun, 11 May 2025
 10:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510190759.23921-1-andrew.lopes@alumni.usp.br> <CAHp75VcUK3krw4qZyUGyKYhDAW_j9UQ7_VtwEx=6V2NMd2XcNQ@mail.gmail.com>
In-Reply-To: <CAHp75VcUK3krw4qZyUGyKYhDAW_j9UQ7_VtwEx=6V2NMd2XcNQ@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sun, 11 May 2025 14:35:38 -0300
X-Gm-Features: AX0GCFu0cIvrL_fJbZWk2k93Td3jHN-0IltSHfg7kVaTVzrboJJ68ZRffOBS2Ns
Message-ID: <CANZih_TW38JC0U+4wAWTk4UqYxs40B7SKDJidnVhi4K_jr2Crw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 6:40=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> Changelog is missing.

Sorry about that, I didn't know we could add changelogs to patches.
I re-read the guidelines and I'll add these changelogs for next versions.

Thanks for pointing this out.

>
> Also some of my comments became ignored.
>
> Besides that you had a question which I answered in a previous email.
> Please, do not send new versions before settling down on the discussed
> pieces.

Got it! I'll wait until everything is settled before sending next versions.

--
Thanks,
Andrew

