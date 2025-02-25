Return-Path: <linux-iio+bounces-16042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF28A43943
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192DB7A0765
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7F1A5BA1;
	Tue, 25 Feb 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8u1sAQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6B1A4E70
	for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475117; cv=none; b=jfBiLJjVtqQjIlqm+NDr1HT+L9rRB5DE1OhEusdhFeeMZ0FKN1mrhMBVBJeHuhpI7kl0RUoBXIdMMF21CiqWA0fbhGs00yy++YJFumsWz5sUosAfJ544NoABGgrGs1kFMsTVhStUAb97in5J01/yNJnrqoL02AVv64tXeYKTTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475117; c=relaxed/simple;
	bh=7E33E++zy3XCfRv/9Rr7A/PzL5im4YvFsbHmeyvLWdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=naKdz2PEHrz2a0eBpSVPe7+I67JIS+W86/pd1MWLVqFGoUy5GTTnxXGmNpoUA24hRY92rw1Lz4e3X7RSKsUTqNau28aFfdhmQhB3wDqVEWBbtRMK7dle/Xgfnqc6b9PwYl77n+aXu1pqJYU++2I3AT6lZY9oraFFojHxBt7G4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8u1sAQC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so1893721f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2025 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475114; x=1741079914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7E33E++zy3XCfRv/9Rr7A/PzL5im4YvFsbHmeyvLWdY=;
        b=j8u1sAQCGBvvrlPX2q8FO093I7LIwssEy17Y3cofNhfox82zLjDPWll2C/vpGwFtuI
         eqLY0GYp09yokD9fsTXPZkEV7Mr7nYXGhXZ/oo6NhhGOT0cladnVX8hsjvwYAE7k6yLJ
         S811wTJVcyOxzCGiP0bV5L8Ukp003I0/P/cm86G5uEBxyuJFVb8nCgFNk8pjQI230yTc
         rFxe6HZejYeAo5SNPEse4YzZF2zMmrVN+CTN0ySqjGvsRrb/71ZdYr4eMvGTJINYmxTj
         IVxvI8UXwfHzo2rgKn0GOjzQI9/gJ8KxTIo3mXewooC2U1/1es8MBREOCPACuVtaE2zP
         5Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475114; x=1741079914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7E33E++zy3XCfRv/9Rr7A/PzL5im4YvFsbHmeyvLWdY=;
        b=vr0OfbnRr9eZDcnOEyE/sRyD1I+HcDECFSkxBpxEOV8oXFnBM8yjg45Q0yD1Uiurez
         My2s37P2s55Y+XSy+hzQnVhMfe8Mmyp39LjNbs9z+FOrLEOLqwPXo7ERN3AqpEvPaJit
         d33rI0DGbSsaDr4OgRjDlzsxV6j6ZPM8QyFvZhjFaTyVvHRkz+N1TbKTqe78/DTeWVx8
         VQQm3mY7xBoSYPr9vom2/5vflYwgwwy50TSmGAFdGN4beGG7h8b4Vnd1gZ7z6/KzodwW
         7lb22WxZQ/JwpdoSRDrSugaXY+0jXlUjDC4z29AqFxVO/KNxNX2lQ4Mj6rMIMS9LnHwM
         5FIg==
X-Gm-Message-State: AOJu0YxUBqAbaZduM2cqWw73CBQwUYCZ5Vi04ltM1YrYy0wEGrzIVQ9d
	JzY0HghvqSWQQCB8fz6UTkaqeOm6Rey2tm2/XTM+wVlSMHGp7mCfQjlq0eshqmc=
X-Gm-Gg: ASbGncvu1kYFtIK59Zs0GPSqVeH0i/0iuMb9Sz+xBbp1T3cDCq5bT4K5Hzjv/fAJqgd
	y7QxsJautv/cTJqt/LhefPLnUbBkybf3vPALkvGFeIeY8jnyB7OVQrjc3rHzaB4OCER62XDly0j
	PrAE1/fDialKqfM6pgGXXq3ariXwwU/MXvD2Dv3yOlJixdr6koQMCTb4thRg1/TdZosez915ZWH
	JaWeKWTExhCP0H88wD5kv/emwaVhysNxAhFf4yvFsaHCBKUf+Ux3W2qg5Aei6dmK7NqqPzFqp6F
	NtKMMZVXlmH2Mcr3SRafqdxKQCr4gs7Wffrw3jpku4yenWk5I+7zywvEIU9872e1IAj/CCRIOw=
	=
X-Google-Smtp-Source: AGHT+IFLABiCgLifz7knsIE1SUaQMRX2v6JH+B2cr7imd9R9DR1MqDXSy2f8tfnPOvCnSOy12Lch6w==
X-Received: by 2002:adf:e7c7:0:b0:38f:309c:2c5f with SMTP id ffacd0b85a97d-38f6f085f21mr9252929f8f.34.1740475114097;
        Tue, 25 Feb 2025 01:18:34 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882644sm1595922f8f.42.2025.02.25.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:18:33 -0800 (PST)
Message-ID: <7416028f78ba0e10e8d1722edd67756e13c3867b.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: replace of.h with
 mod_devicetable.h
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>
Date: Tue, 25 Feb 2025 09:18:38 +0000
In-Reply-To: <Z7o62qQDyWLk642C@surfacebook.localdomain>
References: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
	 <Z7o62qQDyWLk642C@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-22 at 23:00 +0200, Andy Shevchenko wrote:
> Tue, Feb 18, 2025 at 10:34:57AM +0000, Nuno S=C3=A1 kirjoitti:
> > Don't use of.h in order to include mod_devicetable.h. Use it directly a=
s
> > there no direct dependency on OF.h
>=20
> ...
>=20
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/mutex.h>
> > -#include <linux/of.h>
> > +#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/platform_device.h>
> > =C2=A0#include <linux/property.h>
> > =C2=A0#include <linux/regmap.h>
>=20
> Can we preserve the alpabetical ordering?
>=20

Ups, my bad. Jonathan, should I re-spin or can you directly tweak it?

- Nuno S=C3=A1

