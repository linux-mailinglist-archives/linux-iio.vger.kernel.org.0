Return-Path: <linux-iio+bounces-11011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EC69AD325
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 19:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12221C21DEC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342B1D0B8B;
	Wed, 23 Oct 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PfNRqMVd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA931CFEC8
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705568; cv=none; b=inxQLQBLr2AzBcdSSJ81qVrsszLmp/kdAkoSTF2yzye/zlkzgBn+5nhUXOf6zJ8RN9jkf9qynZ2wSd/mya7kvXj4AX+3yVUhf2a6t/P5JK8r2oEmbJDncwqG2cWGC2D082nGYiTtRoZo4ZoNMrIz0jztoMoG4xKXO+cJrdYeB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705568; c=relaxed/simple;
	bh=HhCRM8LXsD648EezB/Ag71ruZTVUBPWIrjPd9FGl4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRMOzhwOFKD4/TMeoF/voli6sFin84D8btIlGyHQ4JBDzdXRoE048reSJQZhXWKaajipaA+VAwSexo32if62OOEeyIU80XcFvKGVKtCCUtxxq6oro92TequHJhLC1GgcRb2tPAwKc4SJ/cti49D86rNwHkQgi92yw94H0TuA0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PfNRqMVd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so983212566b.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729705564; x=1730310364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=PfNRqMVdmHs1fU+LK8FFyPDvmOvLnYzZ2a46Zh6rulUgi2z7zoX7LspJvHR2aT8rAV
         WNvChqPrimTnEzqOWz3OebW+0acLVmqfqwZMu9z9heLbB7uZXox+VZRCUxbVAJ+4Vwn2
         fxMdAr+VP1DH3MzbvvvIKxCOvS82QFFjkGhaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705564; x=1730310364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=ZkcxGQfsIzJGyqvQnfYOO9pSDsvWKepBvYHJRy9H8EpNUABXC6/tPgBeUa+3Qf4BYy
         ybRFusQUhdRR959qXgc3EQ48dz6pbyR/TGA6lbzQDSji8ANAeCu6sFEIdMZv1KyHYZ0P
         2J1qV3E+H6VPa+v3fk6Qr571webdk/hx16uO5tpda1iwVtkSUTrF8K0HyNgpukC2gzmG
         cM26BgqWiPE4gG9fqrBdNpIlZwfTQS4IImicd/pUrMm6cayw9IeCe3FZ91y/mO7PI4vW
         Zi7Mgr8zHEiMU9RkT/pgVj/Q6L/sJikIe9NHwU6daadyFU8CT+tGCSHQmgGr4+esCc4z
         xJUw==
X-Forwarded-Encrypted: i=1; AJvYcCWuctplOKEyBN+0WyDnmxaxMGAGxGHksBQ3+c6mh6jPu6CJe5dR6m9IgXEFRA++zYI3R+OX5Sj4sOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLeibehaKyw+IZziSHIL8UCAzVvML2/fN4dLucwlKGwMMhFLb
	9XpkhiJThTckoUU3SSqz4JljU/WDfIHyodCGgnqN7HLTAzAPH6OXK8mgRJPhHeFmRf9KrSIKKoH
	fjRQ=
X-Google-Smtp-Source: AGHT+IFAnTX9o3qoma83v3U5A/TXR7wVbSYflZBs0y8aER7VAZQhc7F64V4Lx80gB9OcwlDVDmrG9A==
X-Received: by 2002:a17:906:730b:b0:a99:e5d5:5654 with SMTP id a640c23a62f3a-a9abf84d04amr323262466b.6.1729705564410;
        Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee59dsm507452066b.71.2024.10.23.10.46.04
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a998a5ca499so877665966b.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfi6vjGNBXt6hJ5pE3whhm5AI3DHxTYbYkpQLS9zltQgBY9Q+0NXSBKSSrOfhlOpJDQUZWMLwydqo=@vger.kernel.org
X-Received: by 2002:a17:907:94c3:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9abf94d4b2mr369489566b.47.1729705563762; Wed, 23 Oct 2024
 10:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
In-Reply-To: <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 10:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, gregkh@linuxfoundation.org, 
	wangyuli@uniontech.com, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

Ok, lots of Russian trolls out and about.

It's entirely clear why the change was done, it's not getting
reverted, and using multiple random anonymous accounts to try to
"grass root" it by Russian troll factories isn't going to change
anything.

And FYI for the actual innocent bystanders who aren't troll farm
accounts - the "various compliance requirements" are not just a US
thing.

If you haven't heard of Russian sanctions yet, you should try to read
the news some day.  And by "news", I don't mean Russian
state-sponsored spam.

As to sending me a revert patch - please use whatever mush you call
brains. I'm Finnish. Did you think I'd be *supporting* Russian
aggression? Apparently it's not just lack of real news, it's lack of
history knowledge too.

                      Linus

