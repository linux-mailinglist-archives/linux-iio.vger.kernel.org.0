Return-Path: <linux-iio+bounces-27323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D1CD7602
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 23:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813DE302E045
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B9322DAF;
	Mon, 22 Dec 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7XPPBGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41933B6E9
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766443688; cv=none; b=iTRWSRBWgANUB5NgescR+xb2nEDwqm1UFzNh4Hb2EknRd3MRFDUTWX4oDI1feciRh2vjC7n73Uo+CXg1cAKjOWllYWSt8msviJMmtaWZQKYs5RmteGbRuUFFAeScsXTE4qxwUTUpoun/mTMVuGZKz1u9f3vpiuKRxAcQ00X7iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766443688; c=relaxed/simple;
	bh=hqZtUKr2pVMKN9VqbzfLwrk4+3+68b7BNTbZdTz+fdI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=f/rRvHjRsrfy8RA9Ciy68JdO48Hb23biwPZ1vUQXPTT5TDg9RMIY3QK4973su4fZka1XNpIFF8X5RxzJqR1PHznBc6ZR09qmUhlaBEpBHiKglfOzq6ZS5fv6PmJ4Xh3mqqEadE8X6qcUNrCA35T68wAQW1yvLFUuvIP4tSKmWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7XPPBGI; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55b22d3b39fso933693e0c.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766443684; x=1767048484; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD48M7DpDkTpK5mvGBp2fBSePjAoFu0xC5R305JO1RI=;
        b=j7XPPBGIkvGugNIS669PKXUV2OKDmtXJxvHs7lnc5fHagibKdgpu4IGEDGpAOv1Yo3
         cBPKXi/kAfdui601MYoUs0hE7Tibc4BCrnBhH4Mz2/AvrmOWloni9l0QFFTPPzTB2gm+
         eU6Yx/a8brWfU6bvag4m9LDbehGMk6+9CjRuQO7TygJf3GHNu4Uzn8vMhrzHYb+9Yphn
         CbwMJdt6IoFAMQ2+eOsHOHWCEZa44ITVHdiBucyZkfxXe42wMhbjvlrNoAf9DxeuJhWz
         H2xpZlaNWpO6s2kwHRfsrEHe0Fg/Sx0mnEdS5SDlr34Opob4LyKxWX+5xoETdx9lDqYb
         z9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766443684; x=1767048484;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD48M7DpDkTpK5mvGBp2fBSePjAoFu0xC5R305JO1RI=;
        b=BWx916N3E/fmm5XHrHpqjdVMWzVKoGR9T9MiqU4T52NCAMpSNHpduDYPWQTFZc+TxR
         mmmFSZDGK1gCmAnDesVOE2VuRfJ6NPB/mZKWExdU5IbEU4Y5pBYnj+6fiCHOHVRB5i1M
         1BMBLyBgkK0vqQrT5NY/BxSMa4yvA1Fk2KdQCcF3FsHJSWqRiBs+j79FkbAbg2mdQkGf
         7jxv5RJ+ej01dXHtCCSi7509caFIkrfI+621UUcaSsCRj7e2VwZoGkT/NX7tUXFWTx1e
         V0AguSNyPN+9tMXWvma7LPeoM5RegV4Wpq2WYyuYb9urCzxfaP0icZWxblW45WyGu6nH
         GbLA==
X-Forwarded-Encrypted: i=1; AJvYcCX02agfcdVZinIQQqcRaIIZlFYGuMUnB9MneMFsWERVFqxEaOjfB23TVlfs5YdL+q0C6K6VUSSF0yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOALRNsRFd4x3SpX2gwjQOSzf8zz2XSwQPDdvCPB9tHAxQiu0
	wMm5SgAsGf52OAEJ3NGlt3/+TXhR4mo4lceufic2DLfHTG/N0helOasQiUBXEA==
X-Gm-Gg: AY/fxX4SVPxVIbzLW79PDFwoUaEb6wA70+3uEcOrFxYkiyJDVDKgyteo0bIx+xlMZmE
	10DnPJyssvzObQ2FiiQEvyuz+IkwwQL+vpQi6gKzU4DpdRsTEjSu2blwXRo9M/w4kJ9QNvd8Z6b
	zzxYnXYDg0wQ3PkPyLmUWopqA1J05R4H182972hatP8UHqhPipTkbdNny/+dQyfDd1V9gJnYAYQ
	//lHMeqT8Opb/bBdlt+/PC57UuVXPFXXvnDU+NP0jnuDObi6umvfiSMrQz+qPLJcxBvUm5UTtPr
	eZTu6I+9/guNabexuMEfRdRA2O5zQUmQN1uLSgsu6hpjkbTOvmIRFzilO+0JrX+Zz351zgLOvDY
	2MS8wElftCdOpbEVlxI8GaTysXSUZ+kg9jj4M3QyPbdqMuvuvsHp6XrlV5Fw/Q7av63iS3Z1Xz5
	eVaISNSmvFNzmHdUc=
X-Google-Smtp-Source: AGHT+IGvmyRglMrW4dP1CP47jmGFvC1tfinFRW81hCsuY201OJ8MpemsWdro1QpyogCImJPTMXgWbA==
X-Received: by 2002:a05:6122:1d53:b0:556:92b0:510a with SMTP id 71dfb90a1353d-5615be71e67mr3130922e0c.14.1766443684019;
        Mon, 22 Dec 2025 14:48:04 -0800 (PST)
Received: from localhost ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d14efe7sm3909150e0c.15.2025.12.22.14.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 14:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 17:47:53 -0500
Message-Id: <DF540STWMPDB.175MXGIDPR9L8@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-ads1018: Drop
 iio_device_claim_buffer_mode() call
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251216-ads1018-patch-v1-1-cf41d193e187@gmail.com>
 <20251221184958.2d825e2e@jic23-huawei>
In-Reply-To: <20251221184958.2d825e2e@jic23-huawei>

On Sun Dec 21, 2025 at 1:49 PM -05, Jonathan Cameron wrote:
> On Tue, 16 Dec 2025 19:52:01 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Drop iio_device_claim_buffer_mode() call in ads1018_trigger_handler() as
>> it's not actually protecting anything.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> I squashed this in.  One comment inline.
>> ---
>>  drivers/iio/adc/ti-ads1018.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
>> index af08702b62d2..b34184f68e63 100644
>> --- a/drivers/iio/adc/ti-ads1018.c
>> +++ b/drivers/iio/adc/ti-ads1018.c
>> @@ -557,9 +557,6 @@ static irqreturn_t ads1018_trigger_handler(int irq, =
void *p)
>>  	} scan =3D {};
>>  	int ret;
>> =20
>> -	if (iio_device_claim_buffer_mode(indio_dev))
>> -		goto out_notify_done;
>> -
>>  	if (iio_trigger_using_own(indio_dev)) {
>>  		disable_irq(ads1018->drdy_irq);
>>  		ret =3D ads1018_spi_read_exclusive(ads1018, &scan.conv, true);
>> @@ -568,14 +565,11 @@ static irqreturn_t ads1018_trigger_handler(int irq=
, void *p)
>>  		ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_bu=
f));
>>  		scan.conv =3D ads1018->rx_buf[0];
>>  	}
>> -	if (ret)
>> -		goto out_release_buffer;
>> =20
>> -	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timest=
amp);
>> +	if (!ret)
> Generally I fairly strongly prefer error paths out of line but in this
> case I'd rather just get this merged than go around again so I'll leave
> this as it stands.

Apologies, I'll keep it in mind.

Thanks, Jonathan!

--=20
 ~ Kurt

