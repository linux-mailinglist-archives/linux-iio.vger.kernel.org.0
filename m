Return-Path: <linux-iio+bounces-18785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D8A9F925
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACEE189FBD1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55399296D30;
	Mon, 28 Apr 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcpKg/Pk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B9296159
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867003; cv=none; b=k89v2sDX3lAAkvePr7+gAlaW9WlDAxPKU+htjXztHpTHyFp/8nVJYT3mNJFEAWGkldTGo5rtsC3Iy9GOCUMvAd9uL/01wshKMWrCsxKcqmqxd2AqVWdI+Dwr3JkAuy7P8/ksinWGHbDWXSLZnazYwmKFQRj0xc7BoFzibK+OXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867003; c=relaxed/simple;
	bh=+HftrGyglZWYg2f7rgEOOxcIzoFYrPPglu4sLBVKgM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/qwOxzMLw53xLCzWiJlNkS2EtRLSmHr6dYRnEfUVY0GWxEkJ2XV+I9zFOx0J4txWJz+LumKOb1ti4MhIyVgJQZWt95mr6DmgAU5VaqX2qV3gofk2Ung8XsEPFiVoS69xByRFTOYDyZD9VszTuyMQy9FfXr416rVHGuUASBvJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcpKg/Pk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549963b5551so5282076e87.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745866999; x=1746471799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUgCFWyUIuKepl0WXekZM8Djouei2xLoByomeZyuuWs=;
        b=CcpKg/PkO56lQ1F142EvzwJajqEfZX5XvTdP0JiHR/RSXTMU7UgrdVv1g4gK4RMPXq
         el2JjH8XG6WtkAm/NZLtr7x9UI045ZOoCbNmomB4+CDowtq4X4/WgckcnrpUZVK7I9UT
         NRSeBABLxq7Y7ec8EoddBj2Wd1OOuV5xwnrjLAAgYq3sG204fcmMUu0eyph3Oe88Gsev
         layhB0vXd7skDu2/YA9IX9dcHI8IKqldrXYICtR/MIJsNJtsi+tTYe6bCLKwPEmMRrfd
         a8wfOrE8aeivVFBANFkHTokE8rMj3RrA+IOT6oKzaFyhjwvZr84xxIIrqJHQ+/yFPhJK
         9DPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866999; x=1746471799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUgCFWyUIuKepl0WXekZM8Djouei2xLoByomeZyuuWs=;
        b=A607yZRYJmgEK15oSl9N1mmMDjiRIF8idQbkLDrS5kcALsiQ7AihOve32F5s9zv/pz
         HXYaWEa/2R4S4fEMqw1/KvqrkcyF8E60e9lZEEwDRU0athpTyXF661j0gh1rTt8mq9Z6
         EO+lTynjIVKGrJd+LGhAPRKyRaYFXPenp84/Jb0zKNMWe439DGYBpQSEP5i+jFy1BBnn
         ghgUduwoi/7oKoMvVCw+vE92GSGp8ci4czWCFGHwW4hvhFa0SFujnmRHd9Rk8jPqmdmN
         ti55UV/MI+zK+WAfl+zIx/qRj3mxSEgxkkyaAS4QhYc9RXpbfMWV9gAMxKajZt9UtBal
         jBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEyq6CAmofsxgASsJ2QRuF1NqUnvXPJyhvOKb8eSAWzuVWkWPfJ38RcYs+76H+7ozwhjFUlGnTaBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0zMvmKbj6yCEqbbFTwYXKoMxAxpfPNwYlXUHM2vgDe/M3M6B
	7EAUsD97gmVcW0zPilZ/3kuLb66dL7PevQ6P7D23UJXpuGx87lCr0UwXE4XCIlvK29PcVn7oQYQ
	s93LK2RzDUTdK3YEfPN5scNZgbdM=
X-Gm-Gg: ASbGncv2ypP01gFRx3n+geOP+yLOqkI57IqdiJrWtkIx2fO4+DlC1g4VuOrbGM6pLtt
	I61WFDp5bUeF13Rpeu5Sg8xGz08KbClZa1qjsRkmYCm2nXN6mGA3kgnHIAJ+MlOr8vAXJ8j/8rP
	U/Bmm46zGy0aBqmLTwVVg6jY04TMarTjopFV/STJ4IXqFfoO2ONveDWA==
X-Google-Smtp-Source: AGHT+IGrgpem7rk7nZC9WljzWx4SPDYHmPaMPZdJXHAyzmOYxhDLrjNxTBmOSWJiGyWh4Nwqpyx457oioR1B6zPqbzo=
X-Received: by 2002:a05:6512:3088:b0:549:8d60:ca76 with SMTP id
 2adb3069b0e04-54e8cc0bcd1mr3716066e87.38.1745866998812; Mon, 28 Apr 2025
 12:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei> <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
 <20250427112343.207918cd@jic23-huawei>
In-Reply-To: <20250427112343.207918cd@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 16:03:07 -0300
X-Gm-Features: ATxdqUHsz27PN6uTVmFAlIGG2XhtW7cr8SmCz_OpTKinO7ldw3cPstg_-G2leMg
Message-ID: <CAOMZO5BOXGcuuf7cyf-c6QLXVoKber2oWP+sgWA_RMHQtW5-cw@mail.gmail.com>
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Apr 27, 2025 at 7:23=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> https://elixir.bootlin.com/linux/v6.14.4/source/drivers/iio/adc/max1363.c=
#L1460
> There is where they are set.  Should show us if something weird is going =
on with
> what the checks are seeing vs something going wrong at the debug check.

I am not sure if this is what you want me to print:

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1453,6 +1453,8 @@ static int max1363_alloc_scan_masks(struct
iio_dev *indio_dev)

        indio_dev->available_scan_masks =3D masks;

+       pr_err("************ available_scan_masks is %lu\n", *masks);
+
        return 0;
 }

[    1.559919] ************ available_scan_masks is 1
[    1.565265] max1363 1-0064: available_scan_mask 8 subset of 0. Never use=
d
[    1.572104] max1363 1-0064: available_scan_mask 9 subset of 0. Never use=
d
[    1.578912] max1363 1-0064: available_scan_mask 10 subset of 0. Never us=
ed
[    1.585805] max1363 1-0064: available_scan_mask 11 subset of 0. Never us=
ed
[    1.592699] max1363 1-0064: available_scan_mask 12 subset of 0. Never us=
ed
[    1.599586] max1363 1-0064: available_scan_mask 13 subset of 0. Never us=
ed
[    1.606488] max1363 1-0064: available_scan_mask 8 subset of 1. Never use=
d
[    1.613287] max1363 1-0064: available_scan_mask 9 subset of 1. Never use=
d
[    1.620092] max1363 1-0064: available_scan_mask 10 subset of 1. Never us=
ed
[    1.626989] max1363 1-0064: available_scan_mask 11 subset of 1. Never us=
ed
[    1.633882] max1363 1-0064: available_scan_mask 12 subset of 1. Never us=
ed
[    1.640772] max1363 1-0064: available_scan_mask 13 subset of 1. Never us=
ed
[    1.647664] max1363 1-0064: available_scan_mask 8 subset of 2. Never use=
d
[    1.654473] max1363 1-0064: available_scan_mask 9 subset of 2. Never use=
d
[    1.661274] max1363 1-0064: available_scan_mask 10 subset of 2. Never us=
ed
[    1.668171] max1363 1-0064: available_scan_mask 11 subset of 2. Never us=
ed
[    1.675063] max1363 1-0064: available_scan_mask 12 subset of 2. Never us=
ed
[    1.681957] max1363 1-0064: available_scan_mask 13 subset of 2. Never us=
ed
[    1.688851] max1363 1-0064: available_scan_mask 8 subset of 3. Never use=
d
[    1.695665] max1363 1-0064: available_scan_mask 9 subset of 3. Never use=
d
[    1.702466] max1363 1-0064: available_scan_mask 10 subset of 3. Never us=
ed
[    1.709364] max1363 1-0064: available_scan_mask 11 subset of 3. Never us=
ed
[    1.716248] max1363 1-0064: available_scan_mask 12 subset of 3. Never us=
ed
[    1.723134] max1363 1-0064: available_scan_mask 13 subset of 3. Never us=
ed
[    1.730020] max1363 1-0064: available_scan_mask 8 subset of 4. Never use=
d
[    1.736821] max1363 1-0064: available_scan_mask 9 subset of 4. Never use=
d
[    1.743622] max1363 1-0064: available_scan_mask 10 subset of 4. Never us=
ed
[    1.750508] max1363 1-0064: available_scan_mask 11 subset of 4. Never us=
ed
[    1.757396] max1363 1-0064: available_scan_mask 12 subset of 4. Never us=
ed
[    1.764283] max1363 1-0064: available_scan_mask 13 subset of 4. Never us=
ed
[    1.771170] max1363 1-0064: available_scan_mask 8 subset of 5. Never use=
d
[    1.777975] max1363 1-0064: available_scan_mask 9 subset of 5. Never use=
d
[    1.784775] max1363 1-0064: available_scan_mask 10 subset of 5. Never us=
ed
[    1.791662] max1363 1-0064: available_scan_mask 11 subset of 5. Never us=
ed
[    1.798547] max1363 1-0064: available_scan_mask 12 subset of 5. Never us=
ed
[    1.805434] max1363 1-0064: available_scan_mask 13 subset of 5. Never us=
ed
[    1.812323] max1363 1-0064: available_scan_mask 7 subset of 6. Never use=
d
[    1.819122] max1363 1-0064: available_scan_mask 8 subset of 6. Never use=
d
[    1.825949] max1363 1-0064: available_scan_mask 9 subset of 6. Never use=
d
[    1.832750] max1363 1-0064: available_scan_mask 10 subset of 6. Never us=
ed
[    1.839656] max1363 1-0064: available_scan_mask 11 subset of 6. Never us=
ed
[    1.846545] max1363 1-0064: available_scan_mask 12 subset of 6. Never us=
ed
[    1.853430] max1363 1-0064: available_scan_mask 13 subset of 6. Never us=
ed
[    1.860317] max1363 1-0064: available_scan_mask 8 subset of 7. Never use=
d
[    1.867116] max1363 1-0064: available_scan_mask 9 subset of 7. Never use=
d
[    1.873915] max1363 1-0064: available_scan_mask 10 subset of 7. Never us=
ed
[    1.880801] max1363 1-0064: available_scan_mask 11 subset of 7. Never us=
ed
[    1.887686] max1363 1-0064: available_scan_mask 12 subset of 7. Never us=
ed
[    1.894573] max1363 1-0064: available_scan_mask 13 subset of 7. Never us=
ed
[    1.901466] max1363 1-0064: available_scan_mask 9 subset of 8. Never use=
d
[    1.908267] max1363 1-0064: available_scan_mask 10 subset of 8. Never us=
ed
[    1.915153] max1363 1-0064: available_scan_mask 11 subset of 8. Never us=
ed
[    1.922037] max1363 1-0064: available_scan_mask 12 subset of 8. Never us=
ed
[    1.928923] max1363 1-0064: available_scan_mask 13 subset of 8. Never us=
ed
[    1.935810] max1363 1-0064: available_scan_mask 10 subset of 9. Never us=
ed
[    1.942696] max1363 1-0064: available_scan_mask 11 subset of 9. Never us=
ed
[    1.949582] max1363 1-0064: available_scan_mask 12 subset of 9. Never us=
ed
[    1.956469] max1363 1-0064: available_scan_mask 13 subset of 9. Never us=
ed
[    1.963356] max1363 1-0064: available_scan_mask 11 subset of 10. Never u=
sed
[    1.970330] max1363 1-0064: available_scan_mask 12 subset of 10. Never u=
sed
[    1.977303] max1363 1-0064: available_scan_mask 13 subset of 10. Never u=
sed
[    1.984276] max1363 1-0064: available_scan_mask 12 subset of 11. Never u=
sed
[    1.991249] max1363 1-0064: available_scan_mask 13 subset of 11. Never u=
sed
[    1.998222] max1363 1-0064: available_scan_mask 13 subset of 12. Never u=
sed

