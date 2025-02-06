Return-Path: <linux-iio+bounces-15084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B0A2B18D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3219169A6B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634119E98C;
	Thu,  6 Feb 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CH4Zibz3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5A19AD8B
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867576; cv=none; b=vAWzLhnP3GxZJsN+R07SdMhMp3fiAS2GRQ3tp7mINFLuPs95K81MNgxZKoi6//5NtYlZilTvoOoFQyy+iJBtzTZSsthJEijD3tS6Y9YJIM636ghyCtNhd4Q4FE7k/ph61UwEBvnw85VqSSSXWRj6ZebuSJud3pJ4B/xidjTSwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867576; c=relaxed/simple;
	bh=P0zr8OoINeTGs7g0sjgckyXehEfeKe5nFPFZvgr4A7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqDDMoFuLTDQ7LImdxx+OV7xDsJetFJs8VlJYmkPWwhL9Or6bksNLk869mTJ5670tfpabx73N6ghx3N+b9AUfroxlIKx3BRln2x3NGkr1iby4Wnm3aQwk+DtRtgqZjIoAmrnwq8829HZXFbX8fiwN/auHUIkKUBuTRY5NIHKMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CH4Zibz3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30229d5b229so11309681fa.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738867572; x=1739472372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0zr8OoINeTGs7g0sjgckyXehEfeKe5nFPFZvgr4A7s=;
        b=CH4Zibz3rE/F8+bMJiLzPz9S648Z2CCcv89XgbX1wwyiN6yPAERszqO6a5iBq7Z/D2
         cBdLYbFcA3laP1BPi8GqdgP4tKrvkBp0UlNaVBYUQKxKm+3FQ7kzyQ4I08q1+9wCffGq
         yX+CW3LVwHS/ifU6xvcAAHXEhpf9I3AFY4R7uLqnrHCHS++ZPjE5PXQWVztZjDGbJ6vV
         obSK705XFKPpSXCcq5DhCmaQ/Mchv21LOwNQDFmwO37qKgUGhjcFWyPcBSMcfARY1omi
         MzCVbXw/IUlFoMt+DvqHRiNTGPedgW9SrMeR4H7sR+8P/6+vezHA80xcbaORMqKpd9c2
         YC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867572; x=1739472372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0zr8OoINeTGs7g0sjgckyXehEfeKe5nFPFZvgr4A7s=;
        b=w6K9FhA6fp4og5EmhoTewQts53xXh4IIb9bL0xW7/BQL4PvhZP3FoCYcYB+mIqs4Ss
         FrgIiaYlBP5fAq8YHn8mVWMFsHh0Xz49uszA8IuI3lTOTVnf36pwOnTT1svBJNhzpSYx
         CFuCn8CHRoC/e+c45vobSKE0a6pHPKhozi9UBGnSB6+j1p0mJe/tFLLpaWB+hVJoYD+m
         HBZW4e0EaxszQoi4IIp69tZGxEdp38j6J+R5UZRod5v7660gM6GSfrZFNm1QLxw8f6hd
         OAQXtKowZE4vuDyPNjmBzPhw1nTKsnGUKKSXt4hLLYp1tcRH8Gr24s4nwkvoJrxLV0o4
         /zSA==
X-Forwarded-Encrypted: i=1; AJvYcCXdGDE1V9Srzuo4oLN5Dy35RB14heXV61ht8+oRrPNoAhAcw4yP/OXebwjFqV6bBA90rNpacv2PQyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SB+P9ztdBH7+mjNRSottluaWWEwe2atPOBZeKtV0EAhBXA6s
	A6iKj7MmPwNm42r0RGq/rQF1Bw+4JXnpqwK+Q0WIzAfSYPE/I5rBOqVJ0WwChg1aaK39L4sdYjv
	rXIZF0mw8OsOphAehXtCMWH6RpqnoZAWqWGWaiA==
X-Gm-Gg: ASbGnct/u6hJZzFk3WhPhsEKWfWrWQkAPRNbjtzwkzzsax+NcbnoXUaAgdzw0z/E20x
	ACVpHTjLSzfgDnBNZPVBQs5nyCKOMKy+iFCLx0Q7TWTmOE5a6KEOSX5dkioqOmy/+tnm0ins=
X-Google-Smtp-Source: AGHT+IHBXbEvo18HjmPufvQO4GaXJoRqBewEyheRHSK0Q9zbSI8UBYUsHoznNfcnvv1UkIJfoaGthv9VJSF8FinRDdA=
X-Received: by 2002:a05:651c:150c:b0:300:3a15:8f2a with SMTP id
 38308e7fff4ca-307e57bfe60mr399971fa.2.1738867572121; Thu, 06 Feb 2025
 10:46:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203080902.1864382-1-raag.jadav@intel.com> <20250203080902.1864382-7-raag.jadav@intel.com>
In-Reply-To: <20250203080902.1864382-7-raag.jadav@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Feb 2025 19:46:01 +0100
X-Gm-Features: AWEUYZk4bNNQBgH3TVFhlaeZ56ai3rTQMhsJjvQoZClT9barbrFQxRtMdamD3iI
Message-ID: <CACRpkdbDOH4gRcJFLeqhg1Aj3BR_SC0_1Odbi4vs-Oi70rTZ9w@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] pinctrl: cherryview: use devm_kmemdup_array()
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	dmitry.torokhov@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	sre@kernel.org, jic23@kernel.org, przemyslaw.kitszel@intel.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:09=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:

> Convert to use devm_kmemdup_array() which is more robust.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

