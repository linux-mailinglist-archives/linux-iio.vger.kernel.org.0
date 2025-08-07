Return-Path: <linux-iio+bounces-22419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E920B1DED6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6BA189026F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D4239E64;
	Thu,  7 Aug 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PumeLiIx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909A4430;
	Thu,  7 Aug 2025 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601831; cv=none; b=C6tFgkSUQ7Lp92OL8nC+vxm2Eq74b7fw2M2TZK4xaUGnK+XS2LPvo0pqmuVT6LqHY2kI0werGe9PYF2PppexQcNM4NjwGINBlRNp4YzqGT2cWTnD9VOB56q8TlUa7yVNvX3BeQLjYuULx+oM68iiKQQN5xNMkUEfkSdCXqcGjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601831; c=relaxed/simple;
	bh=7cnQyVFkUPTXEF1gjmi7BZ8pTeX9NMAma6yeP5JcgLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I95WkhGRSoIx0nRVJ0cgtUj9y8hKU+WhYg9RPUxcB2ocTzqlPwT6W6ewsH5M2xcL/siJMWAv4gQs/BHgeJ2sPe5Tp3YqA0MwYpupJHaI3g/L3earyd/vOg164tvdf7uV6igjdn6hQuuOYd/7CQ6P1nsgN0Pm8ntGKn6dbV5/30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PumeLiIx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso2356374a12.0;
        Thu, 07 Aug 2025 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754601828; x=1755206628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cnQyVFkUPTXEF1gjmi7BZ8pTeX9NMAma6yeP5JcgLg=;
        b=PumeLiIx9IWeR7FDT4kNqEQD9HZMa80v8ksmYPL4Vd9NMdb+Fgz1We3/2kNHMvP2lS
         CEdY0kq6ns3isyPWWdW3RkJSpyOnwlrPa6JW1Uv8Xfxu9GU8i7gxAmLcjmUvr19BWmuf
         6T3WNVhOOuUZ6bndjY/veMqb1F3QEBano28Kwuwy0+S2MwG7PJ4W5qizOtaE2+nyeHmy
         VLt4odqn6YySFWtAqMPjsHo5IpYNUserlMXY8w6DH8/q4TGnAx4rUtmn7c/0cntKpr6G
         okj6T8nvSzFnnjRsL3cUgzpnKjZ1MsY+M5MfEyLHQ1kH10Dd+Qf9V/bchYcslOsJB0cr
         g7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754601828; x=1755206628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cnQyVFkUPTXEF1gjmi7BZ8pTeX9NMAma6yeP5JcgLg=;
        b=rLfh82o0dZKtgwrnkReA8CT7aWd/NiZ29M7Zf7VImOdHQx69grgiaGO8v00XCh9XYE
         2KctfjV4Rdxm5lsUsGELToQNMQ3A95TB3jPo671TSloTUt+DvjiFtG4c0yRFiGkgNA5M
         YkV+VuBqqjn7EBMJYpQzH6IYWXyVTXdFOP/rWt7RPrkFyLdUxKs6FWhul7m5+ZfxKvtG
         1uGJNQDOUh/40DMndLLhi/YBgvktMxQmakjN5JEU3JSyyKxcjNhgVTrPVveTGKER5EKL
         NaKHr+0QktnixkN+YjEAiMNO2Aj56OhUScAXDPYVdY10+yzKCm9UyniOQ6lMEaO61+lv
         1GLA==
X-Forwarded-Encrypted: i=1; AJvYcCV/9CK93sHzf/v3xKos5Mq+wHszN/T6nwYnNXbAbXDEI+MRld6m3fYjrZltFm+X/PISUkGx6EJB/PC+freP@vger.kernel.org, AJvYcCV9ni0u4gOV4XUTqE+g2C6RUsWEohq+cxypdYE6tYmDAgZ5wKXqEWCRMnDv8jqzvg92coC/xtKKEzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3uqqlvjAPDrPOZLnUO02h71HZc51KkPLi9WUh3AezFwS1XnuG
	QbhsygadpStghFN8UNHHeCpY3GE7CVpPeUSBY9iIcZ+RkKb00V3BKHcsSETju4iQh5E3tdaQXID
	afbm33ng0ssk0S0k8qytMxvg6w/UY/8w=
X-Gm-Gg: ASbGncs79YGGsbVhOsB5LQ2tNMUTDNXSgrMKOWLOcL2IinVJPspayIu5hAN+mCLeOSt
	0lyZqhSbxfdJMdLX+UZ5uGnDYxDoKGNTnTBXbB8i+UU+1c/DBcU415w1epiiNcha0ns+RkFRg4m
	qRhEzE1qX96G75BvPdFl+ubRAtUfXxCx3wQ28eOnNpN33J1pABMXQVgcEKZkrEMFXkoj4J1W3Q4
	vkyc9lY3W7eFC4kK/6MBw/musaRXFVkKOFQWUT/jw==
X-Google-Smtp-Source: AGHT+IGt5XntAnwhrN8qQksXFdLsR2bYEaG+kLumk3FZSV2AUg6TXt/JF0M1J6/pOxYQ2qdytViOd+CAKrwTRU3Jp4I=
X-Received: by 2002:a17:907:3d03:b0:ad8:9645:798c with SMTP id
 a640c23a62f3a-af9c65d6bb9mr34841266b.51.1754601828089; Thu, 07 Aug 2025
 14:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJQOmQKO219rS8ZN@pc>
In-Reply-To: <aJQOmQKO219rS8ZN@pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:23:11 +0200
X-Gm-Features: Ac12FXyI2ZW3TRoVqpelRVAaP7sSbcujLogUyr7acX8D-Ksxlm6KWrf4LrPnbho
Message-ID: <CAHp75VeRDme0daA_P7nQu1RXVUry_6TKoW1P3xX+-BqDAk6K-A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:25=E2=80=AFAM Salah Triki <salah.triki@gmail.com> =
wrote:
>
> `devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
> Check its return value using `IS_ERR()` and propagate the error if
> necessary.

> `dev_info()` has been dropped as it was considered noisy.

> Also switch to `gpiod_set_value_cansleep()`, which is safe to use in
> sleepable contexts like probe.

'Also' automatically means: Please split to a separate patch.

You may drop dev_info() in the patch which converts to _cansleep,
though. Ordering of the patch should be based on the least noise and
churn between them.

--=20
With Best Regards,
Andy Shevchenko

