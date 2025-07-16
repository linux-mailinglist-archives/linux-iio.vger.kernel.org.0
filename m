Return-Path: <linux-iio+bounces-21727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13853B07E1B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E1D17E344
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4F29E11C;
	Wed, 16 Jul 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI9CtV+h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3A29C344
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694753; cv=none; b=vDj1jtQrwkm1Lr/+uJBJ1QnpSvq9jPI450F3zZKktKEdpK8b8228ZpZWnPcbdZBkcimkfI6ZWmk7mzBCJaD822obvS3cm7faOO7dauH3sfZBpBGfPchrX/+d9ABxZpf/JSX6kGVMg8fIgfbDDEla2RJcO/QdkeZWzgmHe/CMIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694753; c=relaxed/simple;
	bh=M+6EMLDtZ0reA/KntaeXeLNLgVXt+xYj7fGB1mWPG0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh23g0KlB6+QgSTyrLfvwgO3TDcrt9A4iDYOOko7CIDEW7QexTbfmdk/7ejz3gPK605VCGxk47a8j4o0eq+xllK4rcKNUpE7ZWD5VNlUtgg1XuxQd6mf8GrLl+q1MApyXI/XH2ln/tgRnP+A5V77QbptkGeF1v4P0MB1jT57Fxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI9CtV+h; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0d7b32322so34912566b.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752694749; x=1753299549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+6EMLDtZ0reA/KntaeXeLNLgVXt+xYj7fGB1mWPG0o=;
        b=SI9CtV+h4h/9EIXXjZZolBiDmSpSsKw7dlpyYNiwfPtqjHz1rC0vVcDX8MfqeDlVvz
         7P3xGtVAuY7x+I1gDYF9MI96PhxSVzx4x2Wux0EJ0L8aUkPZq+IAOml/+iE+ExD1ohJ0
         QTl4CoXsedjXQ1tgtrLVbf6qjdv3qBw2nLAHqQXrq2e1tuh4+0sKIGVs/8XAUUrHRcMQ
         udWA0jhYd+Y7mxj/ruBIPWj00ZPh7JfSR++kJk85TTGyVwg2F0VypKjWSXZV5IRWZl2L
         xZA5DZdceuAYXXztO/hdXxnIrS+I6USnPNob7sNhw6IkaM+EfVLvnG8jw+MbzdgX2JTG
         ojDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694749; x=1753299549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+6EMLDtZ0reA/KntaeXeLNLgVXt+xYj7fGB1mWPG0o=;
        b=L8slrHd2RELycOyEgwwms2zlSsB/8zOPB+HAWsWqznV+dKKibdNjz1zpgGEPowhE1F
         h4SXUGCyXBiMgMQsDhGmFxYaRedLnXNx65TBvJIJ6kK/yKIDIdcsxCdPGxe7tJ3WdnLK
         xLAoTFENFejJ/KXIgdseRjCVijkeaAPe+PDMgeU/wk1CKLlAlW5ZowAAmJyQp0+7fnDQ
         vLURORmSLKR4S5DXWYoDJLaZfhH6CMH2M73/M4SQjuqNAaZPe/XydBhN52Tl5UIyzfEE
         1KX4hvcA0OKTGB1ucf3rP+Op/CS8s3sCWnxuMTfBnP0WHbNwEbCdOpg9S/zKl11X/Dgd
         PFpg==
X-Gm-Message-State: AOJu0YyTklf1aPLFiravKSWp0GsKee51oZBQ7u6voG3beQ+dicqylnHW
	mMeM8pgrCyKLOCjNaEYfR2qf/XKTbtxoQ/0YIoizUqgn1BsZh4TLPtmCdO7K5DmqGuV2V9Fp8Zn
	nusU+N12muEZ/jdKaxqp46IvsEVG7kBs=
X-Gm-Gg: ASbGncs7coGIV2IBKCDJOGtT8RVaKQbOB3x6J2wWM+X5iYdN5S7spUdsvFU7ngzeuPj
	tihNHBVRQYeF9k+c6XXjBBcWffn8PTHcOGpDTYyHkz0fm5A38BQCJvmxgzBqm1g2ypuHFJK/1UA
	JZL+dUTbQ/esI9y2Yp6PVhU4d5uLlE1PNNcVRj4pvnEJYx62deDsOWPKz6ctpgDmPGiK9IdVf5e
	1vPdxA=
X-Google-Smtp-Source: AGHT+IGDQwzloRzPsGWYheCnPrccarTizQtYScpIAN5n6BTvGrdebHveUK146RrISzkoaxTvMfeCfiDPOPcXvhUci04=
X-Received: by 2002:a17:907:894b:b0:ade:470b:d5ac with SMTP id
 a640c23a62f3a-ae9ce196ca1mr366521266b.56.1752694748682; Wed, 16 Jul 2025
 12:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716192231.30337-1-antonio@mandelbit.com>
In-Reply-To: <20250716192231.30337-1-antonio@mandelbit.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Jul 2025 22:38:32 +0300
X-Gm-Features: Ac12FXwapTF5qY5Ih52gdOpqLc6u-txrGpv_oLJPxRSgv45p2BB9rEJMmUtE22A
Message-ID: <CAHp75Vcysq584=nVHEB-PqKBtTaL+CCKMEdkM_X0wNOaYzeU=w@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: linux-iio@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:22=E2=80=AFPM Antonio Quartulli
<antonio@mandelbit.com> wrote:
>
> In inv_icm42600_accel_convert_wom_to_roc() multiplying
> `threshold` by `convert` may result in a number requiring more
> than 32bit.

32 bits

> In this case, although `value` is 64bit wide, the result is

64-bit

> truncated because the multiplication is performed in the
> 32bit domain, due to both operands being 32bit long.

32-bit
32-bit

--=20
With Best Regards,
Andy Shevchenko

