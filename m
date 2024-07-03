Return-Path: <linux-iio+bounces-7213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32207925465
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 09:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F4EB24C29
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 07:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75213664A;
	Wed,  3 Jul 2024 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ3xXZN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0E130A4D
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990428; cv=none; b=f9SO4hvTK/PCu0Lo5Lb1pCKEPvtlkS3OwzwLSJet6NaCCIFMvPHavRZfWkV8hl0wJZum55RQZXtgbDedikMhpg80rFx619Cpv+QN5kRIQyNMz/PxU3NHTyC9nBtNnKfNDzAFSMh9x6tiqAFR+BClNgooJPTDXEoGyD1gtNq6aTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990428; c=relaxed/simple;
	bh=94/YiQevyIJ6f5oF+UZGXc3nPNCmtYJQcSbSpFNU7Ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uav1YUzq9mkUP1taODGBJ6t+vDTsjOChfZOR2d4hq/vl/IfnVdVK821iTFgQTKijHkn8Unauj6TFMRE7/HnWo81Y8Kgtzev+qMgbj5fm1FC2XJ+EK0IReKAffPcRb3pHV2Nq911a3k0P4J8pqdaPjrEQZtNNz683r/ieiFe9wik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ3xXZN/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36701e6c6e8so2595115f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2024 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719990426; x=1720595226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94/YiQevyIJ6f5oF+UZGXc3nPNCmtYJQcSbSpFNU7Ns=;
        b=YQ3xXZN/UIECIruvckZiuotYiHdEjXszqhedmo0k0xlfJRjJCMbr6irxn4nsV02vYr
         2XvN6/FDvRtvBahqJCko/QAxmybTCQEMN1TcVZioB41rqe4WOW8GiitCUDcA6aMReV8v
         GVwghIew/sERZHtwogEwzjwWFz2Ojqgj+iz4x9B88u/5u/22o8b695L6RToa7H6xyi8w
         pdFue5YQH9rcNYXLvPq7FwzhfKhRSbRe3n0KWzSmsABgi5t1KK+oln4fkT6nmT2d9zn4
         kKZT40/7wWQOE0fKoMrt/MC9+Zf+8c/2NA77Dm4kdjyocnTAMYvz97t5a64hUKjsqU8P
         CHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719990426; x=1720595226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94/YiQevyIJ6f5oF+UZGXc3nPNCmtYJQcSbSpFNU7Ns=;
        b=CF7sSCL8kkz39S6TycxBj2HAMw1XoTxNIwdhXjXret5wrW7UJfeCi9JdGlX+nyFmx5
         7m6cxkTCKdxo8ZRb6Egc2qXLN789fO5NgR7iYbcMQxUs+ig61sazRBG3CDTfPaDUOVMQ
         i3RBFdkV+KTMCVx+7KMrv4Co1ZdGzhumd1i17xKPHeq58hGTPRW/UuYjtocDJIRvV3Xr
         ul55kYkyoSkD9vABF5Bn5tYIJVrZ1kRI6uPJPE6vEj9adTcfj3t4UQ4WhMf5Z0g8rK9W
         ZCszrhZvaBzWCvXTWGkYi7/TXAqGws6jYXyaiP78CMM6sy9xs9mZUpyiqw0v+e0hkqzj
         vYLw==
X-Forwarded-Encrypted: i=1; AJvYcCW3AxC0FfCG0n7wneG4w5ItC7UAi3nLxK9AkVp2i76um9lq1JqmGjvYcf8Th1mPjDKAyAR52IKYdw7NvAfHm1phv9QX1lSr3l8G
X-Gm-Message-State: AOJu0YxEAyIIA98XFqt5uOnaC2LEQwAuh51nGF70Yh8zd02RzW28dBoi
	oFb+2SMt43JbrjnO/1aJDtglZL1ztAArPv+G986IWO/vl7gnAW27lt48IEz5
X-Google-Smtp-Source: AGHT+IE7bT6cMVZUlOrcczuiH3P+xPe2/ItQj4QMgGAX8UbgshHV5ACRpsWC3AW25jDa7wzoDssy3Q==
X-Received: by 2002:adf:e782:0:b0:362:bb3e:93da with SMTP id ffacd0b85a97d-367757282c1mr6854744f8f.62.1719990425492;
        Wed, 03 Jul 2024 00:07:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d91fesm15226681f8f.40.2024.07.03.00.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:07:05 -0700 (PDT)
Message-ID: <c13f761e08cbe3c5021be34f5da774e44037c9a8.camel@gmail.com>
Subject: Re: [PATCH 00/20] iio: make masklength __private (round 1)
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>
Date: Wed, 03 Jul 2024 09:10:58 +0200
In-Reply-To: <20240702212652.01241fc2@jic23-huawei>
References: 
	<20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
	 <20240702212652.01241fc2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 21:26 +0100, Jonathan Cameron wrote:
> On Tue, 02 Jul 2024 18:02:32 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > Hi Jonathan,
> >=20
> > Here it goes the first round of what we discussed in [1] about
> > annotating .masklength as __private. Patches should be fairly simple so
> > hopefully I did not messed up much...
> >=20
> > Note that in core, there's one place where we're still directly writing
> > into .masklength (when it's effectively set). The plan is then to
> > directly use ACCESS_PRIVATE() in there in the same patch where we mark
> > .masklength as __private.
>=20
> Makes sense. Series looks good to me, but I'll not pick it up just yet.
> I've tagged a like second 6.11 pull request, so this is probably 6.12 mat=
erial
> unless things go particularly smoothly and Greg takes an additional last
> minute one as there is one set waiting for a fix that is in char-misc
> but not yet iio-togreg.
>=20
> Jonathan
>=20

Yeah, looks sane to me. Advantage of going in 6.12 is that (likely) we'' ge=
t all
the conversions done.

- Nuno S=C3=A1
>=20


