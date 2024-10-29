Return-Path: <linux-iio+bounces-11556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95439B4455
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85D2283B31
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF461F7565;
	Tue, 29 Oct 2024 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VldVGYdc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF71F7572;
	Tue, 29 Oct 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190982; cv=none; b=SrmV/U90C1bglR1voKLRyYKRXhaK0U03o5X5QDY9qsox/zIwzR0N/rZb8jMuUdSmkvVSb1VLd+7yPZCOyvYEciFWeWDRjF7G3ycer6eBFZ0994NJWtchmybWc2I0aprS5n520QjMIoIgS/dU4fjqCSQBtM54+1fTalPt2+aMFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190982; c=relaxed/simple;
	bh=kka1rEqQOTqWmDit77Z03FNqQ8AZE0MELAOwKU8XPZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G66Xxf1IoZVohXbsXKigMoNnR9uR7Sv2nac5Mkvcztjq0RaDHWDVS94js8wyD5weL4zLk8/b1z3HG0XXdUuxZ2N4SpjEGG+r4WRcUzvIYlzYXnOnM/GMMLLq/GFyLQEHfUl8NAnUfLsSKzeDgpsPB2yd2c0+3wHab+NUk08rszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VldVGYdc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5482058e87.1;
        Tue, 29 Oct 2024 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730190979; x=1730795779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycrZrG1+SEKNM3XzN4QO4HX07q3A9ermu1rSfvkb+aE=;
        b=VldVGYdcZt+IQ9fq2z22BoppXVPQ1pnowYXBPJ+RQyqwnUnszv3AiDUL1SgjXDI8Sy
         rHZhFNvxjZN/2vSyItATTShaweftm/nbpIoojTq8zYKjwBKSMqWCs3b2x9qwWY/oXYIb
         hwfwQwdzNIQYpvKsn73xTXoVSap5bP2DOh/l67jITDebX+vLb1byGn/Q5DNDYqT0f4VJ
         5iLcuVa9/n9CMQoZ2Bds/JgA87chbTimnFR4otg/bbhU7qEuKZAKkwpancY0euns+ff8
         eERO4cv8GQV+0mkF7cndNPlj/CzWvThyW4/kVjOIr7ysp9IuKYchPy2iGGrs0sc0FBua
         d+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730190979; x=1730795779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycrZrG1+SEKNM3XzN4QO4HX07q3A9ermu1rSfvkb+aE=;
        b=CLzkG7I58SdZuUGDpHl8WFFOdStAgyhgd6BEbp0nGfAxapYY2lRxZvosx0tOb0WLJX
         m0XaRP0pY9h3H5rUJUrB0DVQjqax18govSv8LoDwM2QE3SrszqLyi/fnGdRu9j0pRXjF
         9aBkpJIzQkMFDNXnP/hC2ynd6N9zqH3EDAwrYWJ7nr4ebd2iOHsgrM8farpSiNhT2ptP
         uVhJ/yEINvXwi5+vIsJycvoLahrrnFGcS3+5sqTMA4sHfFBJ8gHEUMva3fD9obuvikPq
         /kZIxdAdBsBH58I7hsa3VWVvmAFvM40x70VvyCFnqkI9Qq5PeYr+pI59zc/K4B0puExZ
         YQgA==
X-Forwarded-Encrypted: i=1; AJvYcCUFVRFZ73dyabg5G9qRVZTNot/Z7Dto8bFbP1HmJ1ZIa4wea79YIfkdFdY/wx4ddduUZtTfYyijBWdpy6Pl@vger.kernel.org, AJvYcCW8uIhuiQSTw3Nzyz+nYP89c85XFpkClQZi10n2FTVxEYzLlAP44TPFzrH6UCMrvIwlWnUcXfJiVRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iqtG2pyhYMIlrI1c0OwWyfJQbtxKTxisvzdCKFuUsXeT1iiz
	zl58D8Uz8jjbj3BZka2NyveHmTy9aj/tQqtFXZ1cqCTM1XUmXc8EiWmyba6ZWJsS8H1O
X-Google-Smtp-Source: AGHT+IF0UJTP/Jj1RKxnIvYQFowOLGKLi0bxAJwrPW9v9dlPuAjNm2sN9TSDrxmQx0SDto6AMm5KUA==
X-Received: by 2002:a05:6512:2397:b0:539:9746:2d77 with SMTP id 2adb3069b0e04-53b34c35fe0mr3988919e87.61.1730190978527;
        Tue, 29 Oct 2024 01:36:18 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd? (p200300f6ef1521002c2bbcc5835ec2dd.dip0.t-ipconnect.de. [2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b579968sm167478515e9.39.2024.10.29.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:36:18 -0700 (PDT)
Message-ID: <a1ebd05590051015e6ceb0d2fb4b239ed9959a67.camel@gmail.com>
Subject: Re: [PATCH] ad7923: fix array out of bounds in
 ad7923_update_scan_mode()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Zicheng Qu <quzicheng@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, patrick.vasseur@c-s.fr, 
	christophe.leroy@c-s.fr, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	tanghui20@huawei.com,
 zhangqiao22@huawei.com, judy.chenhui@huawei.com, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Date: Tue, 29 Oct 2024 09:40:37 +0100
In-Reply-To: <20241028205004.2298af74@jic23-huawei>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
	 <20241028205004.2298af74@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-28 at 20:50 +0000, Jonathan Cameron wrote:
> On Mon, 28 Oct 2024 14:23:57 +0000
> Zicheng Qu <quzicheng@huawei.com> wrote:
>=20
> > In the ad7923_update_scan_mode() , the variable len may exceed the leng=
th
> > of the st->tx_buf array, leading to an array overflow issue. The final
> > value of len depends on active_scan_mask (an unsigned long) and
> > num_channels-1 (an integer), with an upper limit of num_channels-1. In
> > the ad7923_probe() function, when assigning to indio_dev->num_channels,
> > its=C2=A0 size is not checked. Therefore, in ad7923_update_scan_mode(),=
 since
> > active_scan_mask is an unsigned long and num_channels has no set upper
> > limit, an overflow might occur.
> >=20
> > Fixes: 0eac259db28f ("IIO ADC support for AD7923")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> Thanks.
> This looks to be a valid bug but a wrong fix. Fairly sure the number of
> channels
> supported has changed at somepoint (probably with addition of more parts)
> and the size of tx has not increased to match.
>=20
> Nuno, could you take a look?

Hi Jonathan,

Yes, the fix seems to be the wrong one (and incomplete). In

commit 851644a60d20 ("iio: adc: ad7923: Add support for the
ad7908/ad7918/ad7928")

devices with 8 channels were added but the buffers not updated. Then, you
actually partially fixed the problem in

commit 01fcf129f61b ("iio: adc: ad7923: Fix undersized rx buffer.") but onl=
y for
the rx buffer.

So to me this is the right fix (if nothing else missed):

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 09680015a7ab..acc44cb34f82 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -48,7 +48,7 @@

 struct ad7923_state {
        struct spi_device               *spi;
-       struct spi_transfer             ring_xfer[5];
+       struct spi_transfer             ring_xfer[9];
        struct spi_transfer             scan_single_xfer[2];
        struct spi_message              ring_msg;
        struct spi_message              scan_single_msg;
@@ -64,7 +64,7 @@ struct ad7923_state {
         * Length =3D 8 channels + 4 extra for 8 byte timestamp
         */
        __be16                          rx_buf[12] __aligned(IIO_DMA_MINALI=
GN);
-       __be16                          tx_buf[4];
+       __be16                          tx_buf[8];
};

- Nuno S=C3=A1



