Return-Path: <linux-iio+bounces-25838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B2C2B1F1
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F4C3B7DC2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B02FF161;
	Mon,  3 Nov 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpCsnoMh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD472FF158
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166655; cv=none; b=Am6Tmee6jyx7BIH+hNgUrKAQrnhsw8UZ5MgJ7x+rhwASSoohpfd/4yObc4vLIgXqi6AUGA59gHhq3yof/9EcVC/vSLoQCSIfz/zwuYpSQyfsGlmp5bBQ8bq7LSZLRd2hZBYVX4GDc9Yaam7sbHPOUTbXu0sd14SM5tbh2QBNQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166655; c=relaxed/simple;
	bh=gwxrWXEX7fo23pH19yXG5KJRK3YBkYUcouQhjKfGxfI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pm5selkgq6AhyTHCb7xVsiQVFRWyQa8qROeAd581w+FokQO0Xe9rvXX4T26lq4tDwYFC2/Da9juiohL2gdzp6JOmVGx1oKI9QggBNGW84U4SWgXye3Kjx9sLTEvtfNM3zF+juUC3trZ8oTKtOp08tqVBRQQhBvyDpe32o7Vbb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpCsnoMh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711b95226dso53930895e9.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166651; x=1762771451; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gwxrWXEX7fo23pH19yXG5KJRK3YBkYUcouQhjKfGxfI=;
        b=ZpCsnoMh5zYYVlq7Xi7kxyAu4hPcTvqU5eabIxTw5RmDp3L+FuPFIWYkUVBsuWBunZ
         5k1w6s60WH81n4wp1T5thx5MMUzQNtAma/Eq3b9oeXrj0G2CQ+VDsZxtxUyhV547t9ev
         ok1upMDStrJt9sKjuxg5Bay4rC9MnN9aADSw1c1H+HkzwVjezI8urrhHSpSteIvHAhSW
         bqftkEp9PQCN3+QX9jTg5WecthtizSkdecrMMHlL+VAlxkP70PCk8tbHgPAOWLeLMzkt
         RGXQ+zcr8e4IMt7AF1tigmEQd73s9seQZG9eqG/sO0Eb4Z3QUVMFTNsGXaxKzw5Z5sNV
         GfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166651; x=1762771451;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwxrWXEX7fo23pH19yXG5KJRK3YBkYUcouQhjKfGxfI=;
        b=bCBkSOBRNjCAHlea15o0ZVKgiPC7i5aiFTYt2C6XJjHVR7gBAyipBHyJwWtM+QYh69
         UirweNtYWfeTq48AYlDTVKHsKLmrla2wK2AWFmaUFsbhNADJw9/vAsx3jjTxqdQmQS/w
         la9Pot2pDO/mIymR+6/qNb559sdyEyFVjm4azAumeMj+a9VpevH5UAraC9AY4DO3dhFv
         kIffMyai1Gop3B/usp+xddXfFBjlNq8G0P8yBpoiwS7ZRJXM3rj0O7V//2KMFi0lpR1K
         QvbQcKF0+GI/yLN7ohvH9YmvE+2rOSxMkub3a07mPGifIx2PIX5MJHrOpMJy5VyekJ5z
         kLPw==
X-Forwarded-Encrypted: i=1; AJvYcCVP6tQN7kmPGchbe3n3F/b0l2lrjQNKaZbJqVzslP2CKgpledg4Vr0L7eggbya9dWH6KJMHIczeld8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHFlkf86oc5rhMtDKirPBuGJsppWlnmHzy5ec25AoZYEkW96c
	lpnhnlx1Y3IuH1AHveSAD7W0xXe/Dskcfp8aIRumWe7+YALDVWCvz1pS
X-Gm-Gg: ASbGnctZOkJmpN30bvwVe2tnVF36mqlEGs4P4G1YrNnFe0G4vqQc7BfCEHnKKcikk0J
	wvLcTYbjG6y8IoAiiFlsQoXi6LZt7DrXus+J0PbtluQKCXM1w24kgYomKxrezgXx6VrQuNf2IN6
	xJXY/resEqwZSar0OaLGnRkRVqcwHi5K2zsGxm3uxi7blnwFZGrYSqFziEBxXaAyb90u2w6D8wj
	hIpjITEXKN4HO9q/xdA0QVC2C2WdX0rDoH+QjCjU06vwN/FGgRs551TdHkKcMBl7PCXANyTR0wq
	UdMyo9GI1nxK/5WV7uAlgpBSKxl2rPwubdVdj5s/zuTW2BJGdtUgC7+/uaaFGp/Wd6gI8b/C14q
	zN5jTaVq4IXe/hC7iTTAZbNp4spZQXVITIRtHJ84H5ClfZJPA8MljMv4ZXan4hA7UKrhUR4YPYw
	PjhSG6NEru
X-Google-Smtp-Source: AGHT+IEZQEt8x3hNjFj2GY6h6M1uNTt+5/WDtXW3KDcxy8WpiE5bUoGql0X9KEjvJhdt1dZKY0FjNQ==
X-Received: by 2002:a05:600c:64c4:b0:46c:adf8:c845 with SMTP id 5b1f17b1804b1-477307db9aemr99822765e9.16.1762166650641;
        Mon, 03 Nov 2025 02:44:10 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm148339775e9.13.2025.11.03.02.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:44:10 -0800 (PST)
Message-ID: <f7f0bb22506abf662d3538346c693d9a73551de3.camel@gmail.com>
Subject: Re: [PATCH v3 09/10] iio: dac: ad5446: Fix coding style issues
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich	
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Date: Mon, 03 Nov 2025 10:44:46 +0000
In-Reply-To: <20251101165133.334b93c7@jic23-huawei>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
		<20251031-dev-add-ad5542-v3-9-d3541036c0e6@analog.com>
	 <20251101165133.334b93c7@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-01 at 16:51 +0000, Jonathan Cameron wrote:
> On Fri, 31 Oct 2025 12:31:30 +0000
> Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Fix style issues as reported by checkpatch. Additionally, make sure
> > include files are given in alphabetical order and that we include the
> > ones that were missing and remove the one we don't really use.
> If it's only 1 say what it is.=C2=A0 I see quite a few so guessing that
> was meant to be plural?
>=20
> Headers and white space are different things so really should be
> 2 patches.
>=20

Ok, will do. I actually had two patches but then feel into the temptation o=
f making
the series a bit smaller.

- Nuno S=C3=A1

> Actual changes all look good
>=20
> Jonathan
>=20
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/ad5446.c | 41 ++++++++++++++++++-----------------=
------
> > =C2=A01 file changed, 18 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> > index d288fb56e324..bf9f7edb1a81 100644
> > --- a/drivers/iio/dac/ad5446.c
> > +++ b/drivers/iio/dac/ad5446.c
> > @@ -5,21 +5,17 @@
> > =C2=A0 * Copyright 2010 Analog Devices Inc.
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/array_size.h>
> > =C2=A0#include <linux/cleanup.h>
> > -#include <linux/export.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/workqueue.h>
> > =C2=A0#include <linux/device.h>
> > -#include <linux/kernel.h>
> > -#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> > -#include <linux/list.h>
> > -#include <linux/regulator/consumer.h>
> > =C2=A0#include <linux/err.h>
> > -#include <linux/module.h>
> > -
> > +#include <linux/export.h>
> > =C2=A0#include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > +#include <linux/kstrtox.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/sysfs.h>
> > =C2=A0
> > =C2=A0#include "ad5446.h"

