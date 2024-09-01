Return-Path: <linux-iio+bounces-8925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD99676C8
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 15:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CFCB21395
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EA17E016;
	Sun,  1 Sep 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmMrml3+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24961FEB;
	Sun,  1 Sep 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198065; cv=none; b=BHm5ZAPRl3nBaCWkugbcCUhJlsNvfbedFQGlkx6S2m3AQEDMgWapgR3S+YV/+8ktQ0AVWzhgZ7JKyyvPPJvwd3lweVar2RcC4tbuSbJ+A2c9uOvhPuGRwVF48j7xviCXWQNSLUc7cvKJ7+4Mj8Qr4x7l90u4e3+U2S2TUbjT/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198065; c=relaxed/simple;
	bh=tXHeqiUqOFXGvWoUKfIJGlj5u9CZSs2HMjaf837ADSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TW8yzAIUnzsm2GJYZfAbt8rHKJfVVvZDJvad1FhRGN89DvJPJCh5gJQuTJIsV99P9WjyX7nrkvGwInVTWRn116WSvl0rAkRJHkCoNgJAo8kvuACR304pJy8W4QsVOZsaDQGgBVRLwBnAz04icpcSQJgnywScue5a6g+f13Zrzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmMrml3+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1818273a12.0;
        Sun, 01 Sep 2024 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725198064; x=1725802864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaFudmlePtimQjBZfYVX3i7AwPN92rG+FAZRbK6Jtws=;
        b=kmMrml3+yUn0jkRz3BEQpJV0IMydcnRIkSlidHh+QmjexdsY+Gm0/W3DsIlu72TTME
         2okzYauvclLlFDSaHYu1c5+1Yuft/7NOyh2fvskuSzxsW26XuhW2S6ly2bpjif5DfaHi
         aAFFC2VijoSF8y4FxSNKccxQ/4U/qecnuu456AmYHCCyR6cU56xRPzbhDRwFWjtN6IYf
         1omndwRVFsSdbiyD2kQiSvYIt0hFAaeVDWos4BXbZO7coymnpFlaE/RX316IeRukBMBA
         aXhe0gAlnFYzbd8X++FYC3ytkOv7Y5pbLytR54WwrjrWJIz+tN+dsBtnFo/nsFbFIXdH
         9Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725198064; x=1725802864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaFudmlePtimQjBZfYVX3i7AwPN92rG+FAZRbK6Jtws=;
        b=HJPKAXjpP34Gfxqny5y/nfk8tXb+LOFvepVr9iIu5aCfCDjsX+YifKE+pTKa0wJNPP
         5+pi1ekOX8f5K8AL9v43QO4pUYzQypNFSSsMA/OfBZYhCK1RUhwFKzB4IrHjrsNBzqtX
         p5SOsAdkI49WmRK2rOkWZQjYKhgtWvRGFHzOPADxhr1Iy7nFdmW4sw2T75DBg90iyoDv
         2mm0VVNu88n1cvtBTgCyelAsNnn2srqrQU6uQsDnmOccFel330h1Qy57JvucfvvTIPin
         0weOFYVtkUroUEMI3QAm9ZfiTnSJJ9o0tKg4ATeJg9jD/lNIskZdVuAllJvSAnI7Nrmt
         kG3g==
X-Forwarded-Encrypted: i=1; AJvYcCXqTL6OQ9lxjHk/Kn2p5yL76cN8hgXlp9w06ZtDXqhACMOXFTrRRFHc2nkvFpl9K8HewOvOqpu/I6TQJ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSW9MnuAlAQ+jycmzYBymkgAPXVOEj6nivccJdVG97s/0ua/h
	ORZWdrfxg2w6B32BNniqxsu8Npw6z2QTzoio6ig9FpAKIbzEjGbfHZUr5j1B61QAEin3HAVLBXq
	bhFzEuyUgqrVkWtQ1U0/gfPFL1TjQNczquf2W0ZRK
X-Google-Smtp-Source: AGHT+IEhwqeHy8ydo42E9/pecMoieQ+oFgkRtai7v5K1e2qk5CwAvQuJoaXrj08Fve0jiDwA71kVHNqDBJLtkDZuQEA=
X-Received: by 2002:a05:6a21:394a:b0:1cc:e4d0:84e9 with SMTP id
 adf61e73a8af0-1cece50235dmr4676852637.17.1725198063550; Sun, 01 Sep 2024
 06:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901091214.15199-1-gye976@gmail.com> <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
In-Reply-To: <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
From: gyeyoung <gye976@gmail.com>
Date: Sun, 1 Sep 2024 22:40:52 +0900
Message-ID: <CAKbEznvriPOTZHFyNVoNkAce5q2vy+itN5yJ20kCQw3Akn_PEQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I apologize for the insufficient explanation.

---
Before the change:

"end_session:
    mutex_unlock(&st->lock);
    iio_trigger_notify_done(indio_dev->trig);
    return IRQ_HANDLED;

flush_fifo:
    /* Flush HW and SW FIFOs. */
    inv_reset_fifo(indio_dev);
    mutex_unlock(&st->lock);
    iio_trigger_notify_done(indio_dev->trig);
    return IRQ_HANDLED;
"
---
After the change:

"flush_fifo:
/* Flush HW and SW FIFOs. */
inv_reset_fifo(indio_dev);

end_session:
mutex_unlock(&st->lock);
iio_trigger_notify_done(indio_dev->trig);

return IRQ_HANDLED;"
---

Here, 'flush_fifo' and 'end_session' are not the same. However, the
work of 'flush_fifo' is a superset of 'end_session'.


On Sun, Sep 1, 2024 at 9:08=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > 'flush_fifo' label performs same task as 'endsession' label
>
>                                             end_session?
>
> The number of actions differ between involved jump targets.
>
>
> > immediately after calling 'env_reset_fifo' function.
> > so i remove that duplication.
>
> * You would like to specify a corresponding goto chain at the moment,
>   don't you?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?h=3Dv6.11-rc5#n526
>
> * How do you think about to increase the application of scope-based resou=
rce management?

firstly I understood that you might be referring to RAII. but I think
this issue is not related to RAII.
thanks for response.

>
>
> Regards,
> Markus

