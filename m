Return-Path: <linux-iio+bounces-17801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9308A7F6F6
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 09:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90913BE91C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F322263F2B;
	Tue,  8 Apr 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzMZMwpQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA625F996
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098052; cv=none; b=TuSPPUwlNmPu/+j8gk2SHO9G/JGruKlgqGjKGTAH/yd2NlZTxloTo7y23MjbqIYNzpMJTblqj26T/h21fJ2MO9AfqDD7hHTevm6oHECXk6NOyMGrHFMV6973eSnVyD0ygANUJPUL8ZVldH26jwobKvwT+lE26D6MRzQexptOpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098052; c=relaxed/simple;
	bh=ovpdt0yqe2CPI3+bD56BFlvEeCCmLtTFgUQfzL5tXx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubovPba43cUoJTXMdEmUNolQnU89KW8t8nrtaPatg/u+C9+KI6IgJqOFlUZPbd1Y8g83o7cLXVM13H6swFzw0EdHA4V7LpYuaadEjXCMgmZAHQitp8MJX/BpHST7ZCQ5nZGDcA74B3N4xXUfwVWEPHfweTyDd/OwCo0vVEuC/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzMZMwpQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e589c258663so4729024276.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744098050; x=1744702850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovpdt0yqe2CPI3+bD56BFlvEeCCmLtTFgUQfzL5tXx8=;
        b=MzMZMwpQPwd1l4pPGh6Ge64GDp0Kl+OvGSuYHrXdKPSKCorYLH+xRxcMJikY/T9Op/
         tvRm78CZEW+5DvVIB5+AlL0UFLacWn+BnlLdK3LK+55M2PfPfrE+1kgIEnx42vsn7pWx
         JMneYz0sp+Jx+DtTn5c3z6dFeGQx0tzs4lNbtRGws8KTYuAHI5lrPP9HY/6+mLSS6/sx
         ky680T6AghssbfwRRBQOOxNvsyjk2kh349Sk2/TccSMV4IcgAthu0xoeD69aYAyR9BOq
         7h1Ot2qKC+pA9znLZFsjUD0/rXtBFlcn2jgKsFYrGQPZBnay/k1DlMNZcE95351WcA3H
         K67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098050; x=1744702850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovpdt0yqe2CPI3+bD56BFlvEeCCmLtTFgUQfzL5tXx8=;
        b=YAN06ZGx3kB5kK8rzVSpH53M7xhAYvkIsFY4ioYT7GTxEIL6nQ15eP8ELS5nkXy3VX
         RM05BMyzk0hrvERWcmfzxHp0cBVc6+quirudPNOwZDOqWF/tCSYuyNmU8mJM02i7CX/s
         ypiiOzgRCUqftJMzbxuuWxd3hmle3HicxlziaN+QF1KtR+vgkg3r5HWfRmmoqgSlr3Uu
         zww2By6i+kmJ6jqw2Oz9BayKt4cl2sGf9PxQj04bJwt/t6FYzgTXC9EABr85Y4QeoB0s
         jGwB2xBzHRGlqZlT5pr8Jk+dI5TC9S8+GoLFQlZnEWVJlMec3ArjvKGTB0LzXGGXLoEx
         bWLw==
X-Forwarded-Encrypted: i=1; AJvYcCVRgqzbqQj1gvXMNKNStdszWpuyF3NG365kT3oj0U6Xj8RFQiMzRk/H/7xpkq1ljEvfjjBIFZMqX74=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjjp2fxUF/1Z4NBNmDuzonks1cc/BLr97n0EZacXPkwfzsQfpO
	PvlkSR85ORC8A9lZ3e2GQALGVVwPhGEcNZBMyZssksC7pAG2m04ZlrfTS8Kbls29qcUx+na2si8
	MOBj0kY/tlvk//h2yCyY+rzZywGQ=
X-Gm-Gg: ASbGncs/zMA5WQNUHFX9blLLxJvH7YFHqshNVSA0oofhFrwvRuKbgrTETys1hl19fNU
	rZaKa0gw2AUjkKdUtN/L+j6qXV29PGZUZLAZF3aW1FjnJ1ADZjsy8Ywj1Lu53vbD2ua+rds6omm
	REdZs+ynPq9hGSPxidKADauLZJcoMwlwqM37oSu+XcsjM9l0NGRBFQ69Md29A=
X-Google-Smtp-Source: AGHT+IGDIVZEZ9/ts4bGXufimwUJm/8Qgwrg4FNAVGtpjf0NPTk4w62wTuo3pLx70zL8OvAMgM0OqDpIiUcLUkLvFwI=
X-Received: by 2002:a05:6902:2507:b0:e6b:7f3e:8d89 with SMTP id
 3f1490d57ef6-e6e1f9c7afbmr25372698276.27.1744098050011; Tue, 08 Apr 2025
 00:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei> <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
 <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64> <20250305145749.413fe30b@jic23-huawei>
 <CAGd6pzMzrJbRBXr2esV1x-TxXjg9zt22y6UdSXgXe7jCO3_raA@mail.gmail.com>
 <20250309161143.2b730912@jic23-huawei> <CAGd6pzPDL3FG6rRzBrT72eDdtE+ZMNx4A=WUj2xwA2jvYZBHdQ@mail.gmail.com>
 <Z_Sej1XAW__ZBtOb@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Z_Sej1XAW__ZBtOb@debian-BULLSEYE-live-builder-AMD64>
From: Siddharth Menon <simeddon@gmail.com>
Date: Tue, 8 Apr 2025 13:10:13 +0530
X-Gm-Features: ATxdqUEeMoxCWKJ0gycaS0RSxp_uX0bV8Dd-yhtNXRKhNpTcu0qNE8MWNv2g28o
Message-ID: <CAGd6pzOKnb6bP5TB5Lr5+o9d8Sj-FYjL2=bm0C3y-GctBCk-0w@mail.gmail.com>
Subject: Re: GSoC IIO project: Siddharth Menon
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 09:26, Marcelo Schmitt <marcelo.schmitt1@gmail.com> w=
rote:
> While it would be possible to do a GSoC project for ADT7316, I think it w=
ouldn't
> be as interesting as developing a new driver, IMO. May be a good one for
> contributing as non-gsoc project.

Thank you for the feedback, I=E2=80=99m not sure how I missed the staging d=
river.
While looking through available devices, I also came across the ADS8321.
From what I can tell, there=E2=80=99s currently no driver for it in the ker=
nel.

Based on the schematics in the datasheet, the device appears to be relative=
ly
simple to work with.

I believe developing a driver for the ADS8321 is quite feasible, if all
goes well, I will be submitting a proposal for it within the next few hours=
.

Regards,
Siddharth Menon

