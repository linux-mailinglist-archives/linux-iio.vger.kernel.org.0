Return-Path: <linux-iio+bounces-23313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F3B372D2
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5520189A107
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9712F548A;
	Tue, 26 Aug 2025 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajpLG4kt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E081EB5F8
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235080; cv=none; b=lgikqu70d05lhLmnnbbCzvBI+8quK7WLPcwb5S/hBpTyqfhuDpEsLpXVOwHE0VofRqi3fRwwZ44Ur/ZORQddtX0o2lPfV0HKoA+nLb3hPm5qRTxAzDMYAFYc4jxYdlu/qqAVqkp5Flx9K1sWwhDT1XViEtFXdY8C55AsZn5HA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235080; c=relaxed/simple;
	bh=qQS1iUmusOSLDidPCQWXIgZP8/qktM9DU5x7ZubTQtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cf4lbiRmTIbrmUjkS6MFJCvGLspFMnwpPjmlvD0uthc9H7L8VMs2nDBybyM1gDYymnoDO0OWCTOMdASd0kwstiUqDOYU/QXvQZ29KjWPoVuWpGjW3HK3H4FwpiWfCkNQ0/7wOfaTrX8bKCIwdNSlmMT/akFXvyXgQg+eaYhzSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajpLG4kt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a16441so947988766b.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756235076; x=1756839876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQS1iUmusOSLDidPCQWXIgZP8/qktM9DU5x7ZubTQtc=;
        b=ajpLG4ktDQVAKv70G5B5jnPVSo7H+kt811gnuNsfLHsTKtlg3e7ebx/zb0li0RhLwI
         os77Uz5FJ3Kyfmx4i8bQNnJRULftHa5Varb1b/JBzsV9qzO9v2y5xXox0SBi8xPoxiYG
         JYJVTLdLlqh71o47eIApjTlh8atiJRtedvhByKTFsKNWNumdNq+RX9RBRcMgaXzap5bD
         G7kpjwm/RXMrzgEez0XFHIqyb6lIDYHE5SITt5bRROhphnyU6GCvGCEMo87uxycidVag
         h82gqXwN4MQwTPsAg03uJCxaQAuXSB8jNeqNTO8Iu2jgtvfBKXUKxWfW44AnfXP9awuN
         GjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235076; x=1756839876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQS1iUmusOSLDidPCQWXIgZP8/qktM9DU5x7ZubTQtc=;
        b=shGHp1BVIzFne87IyCRPgItdIsNBPnFhfL3EC8U9WQcHye8Wt6ovOGbcNRFdo2Af0f
         MEepW8cyjaE33URY7JRCo9UgYXBm/aPS82SW1+8LU7GckdcGWDEYyoixKvM33WGyzRFx
         CLHtnO5g6hTRK5gZwh3bVOrAXoPsWaaamQtpIxIWjpO0uHDdPkhOjqL2Pd/sG23NYnmA
         szRYuWOGzd1x8kQ+cB+2d2jbs9V3PmJN7I2USH2zGodTa0v15tSzgR6WUeSwbsN3R9M7
         anwa7Y16EquEIMxTDp1GFzLV311QWWloTk3c6nPVirBFH18C81isGCaA/MDPunhmILjy
         /5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW4qACKWc8DxviZ0V3HBAywZlwcVitSP/cVd6PYqkZ9NbGyOsN5XbPTo4MFIFtywbwC1oELn5AYuzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6rPhtDS9i+T5k6PNeXu4MUeJg3VHYvpUzgJO5bM/sl0NBZPd
	ZnBAgD/9X2soMjkmZhhwenjuFG4HveTIkJ1/H1I8qtrG5P849yoEDHoC75rqCsjBvfJu3+m671h
	hgvRkyna4jZsSh+g4+IuT1lB+MhMxVHw=
X-Gm-Gg: ASbGncvtfjFjSaBmn5f01Rp4CjyDjYObpKtDqpc0n772PO8Ea+okEwebJ3J4RofkFyD
	9tL3BrXMQHPTzssZOw1N/URttD+2vkMvCjynFQ0SNdubAo8XRNnLp5Fn/iMelUUXyEtStNYdTyS
	Iu+vPfpzHgnmUbHrMX4hzJ0A4GnJ9VmjGFU63vwAsFEv2Cgu0GSCspYDdPoZQUYA6Egh1qq/Ta7
	Cd8r6A=
X-Google-Smtp-Source: AGHT+IEWIv8Iu0A/7rEIVCTu2yZTFvfZbxw6UENwid+dLY3ZZKyhvqoB7zDiwMxrqKxIne05XwhXWqrN7TvAUgOLp8c=
X-Received: by 2002:a17:907:7ea9:b0:afe:11:2141 with SMTP id
 a640c23a62f3a-afe2953815amr1795734666b.31.1756235075979; Tue, 26 Aug 2025
 12:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
In-Reply-To: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 22:03:59 +0300
X-Gm-Features: Ac12FXzvCa9mpZzYm6JNrqJzoSApeuvgaEET_xhqCWDO94jFcRQFONua7oE8fHE
Message-ID: <CAHp75Vcte3F3VNhKZPd4vv45Kedzok0LKQax1jt=geG9w7b1EQ@mail.gmail.com>
Subject: Re: [PATCH] chemical/mhz19b.c: Replaced datasheet reference to new revision.
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: "gye976@gmail.com" <gye976@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:59=E2=80=AFPM Sidharth Seela <sidharthseela@gmail=
.com> wrote:
>
> Hello Gyeyoung,
> The previous reference was to datasheet's v1.0, newer revision at
> winsen-sensor's website is at v1.7.
> Hence made changes accordingly.
> Thanks & Regards

Commit message is not an email in a free form. It should follow a
specific template.

> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---


--=20
With Best Regards,
Andy Shevchenko

