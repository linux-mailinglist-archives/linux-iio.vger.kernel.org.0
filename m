Return-Path: <linux-iio+bounces-26186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09251C53DA1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F8584F662A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5C34A782;
	Wed, 12 Nov 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+lODzMA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C9345741
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970385; cv=none; b=txD04fFLItbPCMF58XzUDW7BzzKGRmIVd5w5vJ3WlwbPFSwjIGpGM7T1Z0DcCBxpx2caEYSZUM+U/sjw+vigbNNzIDBEPX7+rNAsazUQEyQ4SXV46plx53QG7QCHFVufk5fvJdIuVT6NKBThe+mmg4L2JYAy9uvhB1u0irZaWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970385; c=relaxed/simple;
	bh=VMAUbEYSF7PdWXFDavrRElWyYpN1b3ZWMA2LzFa6Y2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jYGirB9K2MPF6f1bAkCd9/l1ntp1/+LU9SdMITlFDFEsyL11JanEwyRqedMlrVAqpqjRns0+NBSGK8gjDNO008FyTcJ8hR3wROsz0z5m7dzcpjYFs8kVhXY+7a2jTsesQweuqpY62qnm23avCX2bQ9bMnHuTda1r7fCnN5pN34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+lODzMA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c7e438a8so979137f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970381; x=1763575181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMAUbEYSF7PdWXFDavrRElWyYpN1b3ZWMA2LzFa6Y2k=;
        b=H+lODzMACjD7fg/L1U6+HbCwcOMolOc0aTrT63QKgmM6SXru/m/q4Ye139eRW2IwHj
         HMFGQIvhbPgv5AavISf1FOsZSsQdhJG9ltjyuoKaSmOIGV7ZYvKiOEHgxXe3LVOUfAIr
         ieL9O//2ZM9oScIp03rc7rXiCknlUlr3FBNGHGZctVfKrz4HqW+ZoLSKi90p/+oE+ISZ
         zoMDXIT6rpsOHO8DzdzwOO9uXhXg2L/ys4MtOEJ/0CiTJL+pyIQlo08T9hySsloZ3dhG
         Uy0l3F2PFrDuGWZ9O7u+fXJy4dbISyK3yY4E6HH5MFyMf4iBDjYR2ynjdFjHqpWGyOei
         0x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970381; x=1763575181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMAUbEYSF7PdWXFDavrRElWyYpN1b3ZWMA2LzFa6Y2k=;
        b=oK9WdNnkRnGIQCkVExeba0dTOUNp+Q4Jn2DV7QtuX24rnYhnCCYVFQB0k+jfDotD+9
         V2t8tTaM7Tux7yfYqTXOiE+3HtxM0pBOiv+5nOH5b8C9rVW7bM0Ki9Br/GXt3YsHES8P
         Qgnn9S6SwjRZlq2dCGdnECNTc0tVAxcBNzEdSyhJU85Xul6ijFfqVPJG7WOdV5noFyJD
         4Od8afAdVreTTa+ZX25pi73dVkVqNF1ozFuDXge1w1ZyAJwzs+2NVIljCo6iVIFev9Db
         0+Zx9/MczqPhpSvgllSCLPJLXBJei6A+DvEYVwyD5K/OzaWfeGUmy0FJ6KfzeVHYxxtl
         rIzw==
X-Forwarded-Encrypted: i=1; AJvYcCU1sqMQq4otgdZ3ouGVFHZKFotJ7PDndM1l09y4OtyduwQiWjf3TYU0X9Mtt8eqkT15sqhNP/kJMaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YXuFHDVu6N1nJ45LBcGWTK2TGZ9/JcRswo6jpAUaw7sMkjnM
	WcqLwI9lwvkcxyci1XA7WBex5XfovE5JugDmAG9k/04lZ3hLVxYTP4JT
X-Gm-Gg: ASbGncuyETARaotpxum9e3cfkDzLdG6XH1o1fLk+WtlEU69IK9mdledXc2o7aeACJcA
	vBas9vu6LZovDwpF+VpO9/27Qn8sES8Qa5JXMdMzIsKb1bVh8h2PyxV3dYK5fGCLNT3+L/3oQZI
	rOAFzrZPXqWb0FONLGWtjKX9TwJsj+6Xc2zsSF/VzXDj4kTmsdHqT8IumxIYR9dVqV0duTYGIaZ
	idf1/NnEx6ovvPVPn9x6M7X0X3lTDYpQeKrEnjkhmQzOw/wnlhNDauaKOKjs+sxPblNn9HhfLrd
	i7m0EDvWLeSLz5mAcAusRZi054PeErbVN3uicEcI7PNIUhq2jTITFjWRTnLBCwAAGXqIPV0RmQ4
	gMNnOAYI+b6FgJo1azyK7V0TslYLOdD1OWHKN7NdD/eLlCkaqjryLJ+AQd/0PMXcOp2ErmHUruI
	a9uEu35qRHgYMJmLCrqsk1QGOqqSj4lNGxz8l1qNpZi002GZko
X-Google-Smtp-Source: AGHT+IF0tXIDjvKHKVJyTGY8/nCli7RyVbquCxKAUvzuud0KSAJ9auI/vjzj6364H+ausPb7LeEufA==
X-Received: by 2002:a05:6000:2dc3:b0:42b:2c61:86f1 with SMTP id ffacd0b85a97d-42b4bdaeb66mr3081729f8f.35.1762970381278;
        Wed, 12 Nov 2025 09:59:41 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm25264899f8f.16.2025.11.12.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:59:40 -0800 (PST)
Message-ID: <0ec0086b91528e67c9a5c1fe4c27b65a3cc9f8aa.camel@gmail.com>
Subject: Re: [PATCH v1 0/3] iio: core: fix error path in iio_device_alloc()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Date: Wed, 12 Nov 2025 18:00:42 +0000
In-Reply-To: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
References: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 15:55 +0100, Andy Shevchenko wrote:
> The series is induced by the similar fixes in viio_trigger_alloc().
> Basically two things happen here: 1) add missed mutex_destroy()
> calls, and 2) refactor to make sure we clean resources with put_device()
> when appropriate.
>=20
> Andy Shevchenko (3):
> =C2=A0 iio: core: add missing mutex_destroy in iio_dev_release()
> =C2=A0 iio: core: Clean up device correctly on iio_device_alloc() failure
> =C2=A0 iio: core: Replace lockdep_set_class() + mutex_init() by combined =
call
>=20
> =C2=A0drivers/iio/industrialio-core.c | 18 +++++++++++-------
> =C2=A01 file changed, 11 insertions(+), 7 deletions(-)

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

