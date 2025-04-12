Return-Path: <linux-iio+bounces-18031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A6A86EBC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A882189F8EE
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D520E70E;
	Sat, 12 Apr 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpV+TzIy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5B1C3C08;
	Sat, 12 Apr 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482451; cv=none; b=ttYjOZX0WwLGNTHADUWNUEgWtWBKNNBFJtVS9N+4COknvqz4jQksXpknlIWxT1mfjPyl5pkAWC7ZAOiyBJHIXY86wl4RnTGpCMu/fDN/mHmbn6NFQ2OIvHTB7vvLu/KN3S/4zTjeo/tqyBsTQhOLmIDI5rITy0D0y5H/5sjpaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482451; c=relaxed/simple;
	bh=Tskq+K7zK+lTQikjqFG5d9o/wEzX5mULVhPt4y3t5o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+XwjJvEel4ihzNwjYcj4Ee/VT5Si0uIk8gAo2JNfCKh6ku6cALVfcVK2uwCUU4gaB1emk+ug9QL8uOuSz4oFClYEnnfuMV16LdOf1eBex+QE5nkY0GB6DqkJLijD4BauOZb+5Cy0FAkBgeNPoxpKdFwan3CsHlGCaiOfjMj8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpV+TzIy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so5098136a12.0;
        Sat, 12 Apr 2025 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744482447; x=1745087247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OuVdSBAYNzkN5ACXz9m/9B8zVMUdQvEL0boKkmXDBY=;
        b=MpV+TzIyZpERNGMUGTUQ4J9Ax4OdZ9vO8JbZOquGqqRdQbe5pGR1Jx88YZ9ip8HGjl
         5m0f7LQaJgxC/N6mR2qCdDmoo13SyT0a0FyDB9Pz1qV2LIx38UDPqUGbvL9ml74W5jZ2
         YQAvKmKJDcCr/rMrbhSC1dNw/bRM9uYVi2wCMdWuMSJQcrDUYJGb9esJC+FL4kbtvrdm
         KYP3YadCwsCpaTMb6tqWUBwy6nZGQKq6HLDpGCRKQxgwunrV0sVQUgzD+dyR5dnII6o7
         vOy7b89Y7cEtzP11IMdZiCfhfLOKup4bRHySh4DQFrzeEqFTTqer2XTNP2lBAH33yMPO
         qTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744482447; x=1745087247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OuVdSBAYNzkN5ACXz9m/9B8zVMUdQvEL0boKkmXDBY=;
        b=NEvmjhU4jR6PjTTKYc0KhslvIxTEtkyqt7DlL7xdZzCmDDF66lavIwJpD6UmHTOky4
         G3gr1W5pSWX2Qbje4AdiRgx6Gfyw57ao7RuY9S/W7myBe042VBr1Je9NoxQgEEY3wV1R
         ax9R2MS7Os212O3eixKMdebctXqWX9Blo/7p2gyJEFZxwZN4ktUaZYR+Gaog/+T5MZ/r
         TUBWyAS3E6UZHMXIAoeTseo72u5u3uWkDLFaDl086t1wkfIAlz5yZyUnCfuugPDBVDpR
         A/hDmZHOnxxk1a5/ZnPdHPoqMAa3B3eU1oD5BHI91CpB9zOrvwUG22ezsofCmgwZpBno
         m/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY4UFULxN1s+418yEIrcfaLVB0cr/TqBxuegbWUDNVeOkZwBi4iYKIMfb4j4/bO+xQPir0F5+tRpNx@vger.kernel.org, AJvYcCV36sa2zaqEVviHPtX3AJkITAPHPV0t8I+3XM9YvkdpRfVmR2ryu18fyRHbdDiHXEtlBx11k0/NlP3a@vger.kernel.org, AJvYcCW6gfGQSehCmvSH9ieJloTB33T4UJ/XMWi0hNOuqgIgzD0WpdCHNar/3/4WexXU2kPapxN4UzZV/zqO7pdN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmw/9F7vV9DoQ1XlAGjzYYHz+TXgVB5BTTtvQ2tTBafRX/NrcT
	I8YwoX/wxTZ/G/ljJYDBPBRqdH5k2ZDH19VAQwryrETvY5hI8GZc379Xd6oSrglkFuefJEUB03c
	C2b4mUgxAGhol59JM+mDAo4gUVWc=
X-Gm-Gg: ASbGncujVr0cKbWZA1OCTep6GTifjHrm8Sd1jopJ8NiZpkCFCkOlgfDAywsEH3KoIR+
	WtYTr/e8vrY1HjHKqztgMRK9jd9J8dLdx6Ab3HiWjjSqxnhuZdePBU0sqBYMs/sZWIllhuzQExy
	XzKSp2SaQiF0t1eLjg9ylHQA==
X-Google-Smtp-Source: AGHT+IHc4ZV1P7ynTyHLm1QGXBaMol+cFbhDf48jO9NGzxQ0vHQZWQY38cjCVetpAQ5WQtemrSIMzO+he4Al3LbIyjY=
X-Received: by 2002:a17:907:3d4d:b0:ac7:391b:e688 with SMTP id
 a640c23a62f3a-acad36d913fmr686501666b.58.1744482447405; Sat, 12 Apr 2025
 11:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
 <9c115086bd574b6c778a093143ebf54e14d7202b.camel@gmail.com>
 <Z_k3e1DfxmcJgQeu@debian-BULLSEYE-live-builder-AMD64> <20250412171920.531993c1@jic23-huawei>
In-Reply-To: <20250412171920.531993c1@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 21:26:50 +0300
X-Gm-Features: ATxdqUHaXOzoFAHryghLc_0-mJRqsg5cMpy8W5CVqSA_SjwIDSriuNUCGSYS18c
Message-ID: <CAHp75VdN4xhhq7KbEXW25cFxKfQTe=Z87=yobtg1f-w-Mz0psw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 7:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Fri, 11 Apr 2025 12:38:35 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> A general efficiency comment.  If you agree with a comment, no
> need to reply.  Better to crop that bit of the thread out and
> reply only to those parts where there is more to add.

> Cuts down on what reviewers need to read!  We assume anything
> you don't comment on is something you are happy with changing as
> suggested!

+ 1000!

> I normally only point this out to people who are sending a lot
> of code as it's just not worth it for one time contributors.
> So bad luck you get me being fussier ;)


--=20
With Best Regards,
Andy Shevchenko

