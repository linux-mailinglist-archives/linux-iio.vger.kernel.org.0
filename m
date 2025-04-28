Return-Path: <linux-iio+bounces-18798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D5CA9FC11
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 23:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C548466F94
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F41C5D4E;
	Mon, 28 Apr 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV/dGnHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B084D02
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745875035; cv=none; b=GKoKcuIOwGR4TwgxtXN3hDYDyvUZbv8OTScB8PwDFm5iOZiPKEfTeIuLRCGPdwRQxQCEIe8cPIEXxe/Cu6qoN/TzXtywW2sXUOsFJ71lf36+F3xiDg4FbBVoYxX1hfNpKa3TpkkBiHOOijgzpNQuCHgLKvHBlJxLVXrKWXyQsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745875035; c=relaxed/simple;
	bh=eRcTvXEXGqY/JdD9laGsKanBt5srq97X65aLLJBb+vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzK2AyJlRfW+YteL6uDXAJ+94t/R8WsLXjITSok+mKokp5oOU3nF191sAP2jAwHfiDjajrpOGSl0XsrBf6y3V880u2Gbwg9rYRgSOBxm+HvS6X+7pQ5p1YZ2VN49ME+smv7F/XOV1+UM7Qzwds3wOpkoFrVKLxjJvBNtMydxvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV/dGnHG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30effbfaf61so60719001fa.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745875031; x=1746479831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4HBy9rq9qZ6bOHJ3V0wOjCl5xRQv1bRSyVNlpN89hI=;
        b=iV/dGnHG+v2FQEgjKKGXfMmNDXpTUmpqOebenpIdODgBZUHvZRyB7Iq0PnKpsKu1DP
         Hla5n88jSUyw8q4+3BUcNIZmgyfXQ4KkL5rpw1mdrS/6VHpKb6VegvBJaK7IPSc501cx
         vceC+05Q8J5b59MKJJi3Wdm52GctsLJGiP55dx6e+agSqAWtOMRt0wpUUJfphejTL+uo
         p9UGNiEuvFKH3hX7i/x8HqEDtWDYmjZNWZ6oNGVeXyV2PRoJ7SSX4f7CJq7UdsS7bBRt
         JlXoVP+YbkUxPP1Z+mGoAYtKdnEBGvF5j2vcs9TPUBaEp7dZh1472qmSsbY5fHOlhYbK
         mR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745875031; x=1746479831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4HBy9rq9qZ6bOHJ3V0wOjCl5xRQv1bRSyVNlpN89hI=;
        b=jHUN5YjpOzLNwjDPOWXyHEDwwaGbLXjWICJWMJnFnCjvmfMJzMd+PRiJTxBpV++eyV
         P+GUGJ2bGbzV7AJKfZHiZBkxD5LRWzkWgyNa59PZcdZpv6hF77MH+HLlfLStRLCgIRUb
         pHdl4kvfT/YtqWZ+6L6aMytd3qBAVjLjTIzwpd6RTYXqJ7rjjAnzVDnFDb8lUbfdUw9E
         66NmYGGKMAvYdXJFIYkPATLRuByjahnCgUHZI4PbsqHyUd/b9pfrL99NcvQFf1Ov/3+Z
         Mirxr66jGwcCelLOqQwjhjv8MM+lQrj9hxALTI0lQq4hqTStlDBSS7usPTq7zYhbp+5a
         vmAg==
X-Forwarded-Encrypted: i=1; AJvYcCU04d4R33yJvApwKprfJUO8CpM5hSflpZgIwi9hQqT7lf1WVmA24SfjMgpmzIhEuMeVDKJJO87Khrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Dwsj+Q5r7Kg6fdvYwktTWGwMb+kcX2TlSkd0By48f7f5t76B
	9RTj2j/m1bVHDh7qOjgz1KfzF9SEjPp/M85a0CdP+aLCGiNXkKQPnI7DnM1lvqB0Ie4y4R+gka0
	AS46HNrkGhOZlYIDSIADJFS7cbQQ=
X-Gm-Gg: ASbGncu7ZFKIclkClVPCagwpIYUkdLQDVWn8W0ROi00FltdJXeILPFOB/wrDl4yS3gA
	DYw8Q0UJmnF63g6rC3fessJZMPaMQR66icXpgWeb9vwxGf0CtCxMFsWV+WMeCcKbYx3B5wAq4te
	T5aBP0jZIXIsnREToqsVtecBRRoRyv7QxQ7Npe1X5wkLSSAzrz0Zpc0A==
X-Google-Smtp-Source: AGHT+IG7aWFGwtJAEcczK+9C6YtnUP2FpA/MBuoQR25ebQ12IumGve8QwuBVBOmoj8J8S+Pi09AGI+ldj0wB1mDWHlI=
X-Received: by 2002:a05:651c:3132:b0:30b:f92c:16f3 with SMTP id
 38308e7fff4ca-31d45f26363mr1703601fa.11.1745875030900; Mon, 28 Apr 2025
 14:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei> <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
 <20250427112343.207918cd@jic23-huawei> <CAOMZO5BOXGcuuf7cyf-c6QLXVoKber2oWP+sgWA_RMHQtW5-cw@mail.gmail.com>
In-Reply-To: <CAOMZO5BOXGcuuf7cyf-c6QLXVoKber2oWP+sgWA_RMHQtW5-cw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 18:16:59 -0300
X-Gm-Features: ATxdqUFKKS06II_3aDaghYo_-_Bzu-M6ELk9iEdlGTI87ZZkpEVyVin0-CxT9hM
Message-ID: <CAOMZO5Bzrfu14-mzaF+EbAq=xGKMc-FGwJsx-aZd_RraH2Gscw@mail.gmail.com>
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:03=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Jonathan,
>
> On Sun, Apr 27, 2025 at 7:23=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
>
> > https://elixir.bootlin.com/linux/v6.14.4/source/drivers/iio/adc/max1363=
.c#L1460
> > There is where they are set.  Should show us if something weird is goin=
g on with
> > what the checks are seeing vs something going wrong at the debug check.
>
> I am not sure if this is what you want me to print:

Sorry, I should do it like this instead:

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1453,6 +1453,9 @@ static int max1363_alloc_scan_masks(struct
iio_dev *indio_dev)

        indio_dev->available_scan_masks =3D masks;

+       for (i =3D 0; i < st->chip_info->num_modes; i++)
+               pr_err("************ available_scan_masks is %lu\n", masks[=
i]);
+
        return 0;
 }

which prints:

[    1.567841] ************ available_scan_masks is 1
[    1.577203] ************ available_scan_masks is 2
[    1.582032] ************ available_scan_masks is 4
[    1.586837] ************ available_scan_masks is 8
[    1.591644] ************ available_scan_masks is 3
[    1.596452] ************ available_scan_masks is 7
[    1.601258] ************ available_scan_masks is 15
[    1.606149] ************ available_scan_masks is 12
[    1.611041] ************ available_scan_masks is 4096
[    1.616101] ************ available_scan_masks is 8192
[    1.616105] ************ available_scan_masks is 262144
[    1.616108] ************ available_scan_masks is 524288
[    1.640493] ************ available_scan_masks is 12288
[    1.645640] ************ available_scan_masks is 786432
[    1.652223] max1363 1-0064: available_scan_mask 8 subset of 0. Never use=
d
[    1.659028] max1363 1-0064: available_scan_mask 9 subset of 0. Never use=
d
[    1.665829] max1363 1-0064: available_scan_mask 10 subset of 0. Never us=
ed
[    1.672722] max1363 1-0064: available_scan_mask 11 subset of 0. Never us=
ed
[    1.677071] fec 30be0000.ethernet eth0: registered PHC device 0
[    1.679623] max1363 1-0064: available_scan_mask 12 subset of 0. Never us=
ed
[    1.679630] max1363 1-0064: available_scan_mask 13 subset of 0. Never us=
ed
[    1.699327] max1363 1-0064: available_scan_mask 8 subset of 1. Never use=
d
[    1.706131] max1363 1-0064: available_scan_mask 9 subset of 1. Never use=
d
[    1.712932] max1363 1-0064: available_scan_mask 10 subset of 1. Never us=
ed
[    1.719819] max1363 1-0064: available_scan_mask 11 subset of 1. Never us=
ed
[    1.726706] max1363 1-0064: available_scan_mask 12 subset of 1. Never us=
ed
[    1.733593] max1363 1-0064: available_scan_mask 13 subset of 1. Never us=
ed
[    1.740490] max1363 1-0064: available_scan_mask 8 subset of 2. Never use=
d
[    1.747296] max1363 1-0064: available_scan_mask 9 subset of 2. Never use=
d
[    1.754106] max1363 1-0064: available_scan_mask 10 subset of 2. Never us=
ed
[    1.760995] max1363 1-0064: available_scan_mask 11 subset of 2. Never us=
ed
[    1.767882] max1363 1-0064: available_scan_mask 12 subset of 2. Never us=
ed
[    1.774769] max1363 1-0064: available_scan_mask 13 subset of 2. Never us=
ed
[    1.781660] max1363 1-0064: available_scan_mask 8 subset of 3. Never use=
d
[    1.788470] max1363 1-0064: available_scan_mask 9 subset of 3. Never use=
d
[    1.795280] max1363 1-0064: available_scan_mask 10 subset of 3. Never us=
ed
[    1.802170] max1363 1-0064: available_scan_mask 11 subset of 3. Never us=
ed
[    1.809058] max1363 1-0064: available_scan_mask 12 subset of 3. Never us=
ed
[    1.815947] max1363 1-0064: available_scan_mask 13 subset of 3. Never us=
ed
[    1.822836] max1363 1-0064: available_scan_mask 8 subset of 4. Never use=
d
[    1.829658] max1363 1-0064: available_scan_mask 9 subset of 4. Never use=
d
[    1.836465] max1363 1-0064: available_scan_mask 10 subset of 4. Never us=
ed
[    1.843356] max1363 1-0064: available_scan_mask 11 subset of 4. Never us=
ed
[    1.850273] max1363 1-0064: available_scan_mask 12 subset of 4. Never us=
ed
[    1.857191] max1363 1-0064: available_scan_mask 13 subset of 4. Never us=
ed
[    1.864101] max1363 1-0064: available_scan_mask 8 subset of 5. Never use=
d
[    1.870913] max1363 1-0064: available_scan_mask 9 subset of 5. Never use=
d
[    1.874462] mv88e6085 30be0000.ethernet-1:00: switch 0x1150
detected: Marvell 88E6320, revision 2
[    1.877716] max1363 1-0064: available_scan_mask 10 subset of 5. Never us=
ed
[    1.893466] max1363 1-0064: available_scan_mask 11 subset of 5. Never us=
ed
[    1.900355] max1363 1-0064: available_scan_mask 12 subset of 5. Never us=
ed
[    1.907250] max1363 1-0064: available_scan_mask 13 subset of 5. Never us=
ed
[    1.914139] max1363 1-0064: available_scan_mask 7 subset of 6. Never use=
d
[    1.920938] max1363 1-0064: available_scan_mask 8 subset of 6. Never use=
d
[    1.927747] max1363 1-0064: available_scan_mask 9 subset of 6. Never use=
d
[    1.934560] max1363 1-0064: available_scan_mask 10 subset of 6. Never us=
ed
[    1.941453] max1363 1-0064: available_scan_mask 11 subset of 6. Never us=
ed
[    1.948340] max1363 1-0064: available_scan_mask 12 subset of 6. Never us=
ed
[    1.955225] max1363 1-0064: available_scan_mask 13 subset of 6. Never us=
ed
[    1.962111] max1363 1-0064: available_scan_mask 8 subset of 7. Never use=
d
[    1.968912] max1363 1-0064: available_scan_mask 9 subset of 7. Never use=
d
[    1.975718] max1363 1-0064: available_scan_mask 10 subset of 7. Never us=
ed
[    1.982613] max1363 1-0064: available_scan_mask 11 subset of 7. Never us=
ed
[    1.989502] max1363 1-0064: available_scan_mask 12 subset of 7. Never us=
ed
[    1.996389] max1363 1-0064: available_scan_mask 13 subset of 7. Never us=
ed
[    2.003282] max1363 1-0064: available_scan_mask 9 subset of 8. Never use=
d
[    2.010084] max1363 1-0064: available_scan_mask 10 subset of 8. Never us=
ed
[    2.016970] max1363 1-0064: available_scan_mask 11 subset of 8. Never us=
ed
[    2.023855] max1363 1-0064: available_scan_mask 12 subset of 8. Never us=
ed
[    2.030742] max1363 1-0064: available_scan_mask 13 subset of 8. Never us=
ed
[    2.037626] max1363 1-0064: available_scan_mask 10 subset of 9. Never us=
ed
[    2.044514] max1363 1-0064: available_scan_mask 11 subset of 9. Never us=
ed
[    2.051400] max1363 1-0064: available_scan_mask 12 subset of 9. Never us=
ed
[    2.058287] max1363 1-0064: available_scan_mask 13 subset of 9. Never us=
ed
[    2.065175] max1363 1-0064: available_scan_mask 11 subset of 10. Never u=
sed
[    2.072149] max1363 1-0064: available_scan_mask 12 subset of 10. Never u=
sed
[    2.079122] max1363 1-0064: available_scan_mask 13 subset of 10. Never u=
sed
[    2.086101] max1363 1-0064: available_scan_mask 12 subset of 11. Never u=
sed
[    2.093077] max1363 1-0064: available_scan_mask 13 subset of 11. Never u=
sed
[    2.100055] max1363 1-0064: available_scan_mask 13 subset of 12. Never u=
sed

