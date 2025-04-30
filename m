Return-Path: <linux-iio+bounces-18896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C9AA4D6F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E045C188F03F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F525B1CD;
	Wed, 30 Apr 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezL+lvCO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E525A2B8;
	Wed, 30 Apr 2025 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019588; cv=none; b=hPIsVGGajmJyp0vQxjD3q5fodQETIXOMqnL6d1UXNXtSgqY+DYqVbxBMVZusx9a5wC3QzMIgLg5jI7APGtmNflzy9aovPj/g2nsUpdjFHtJ3f8hmkm24zru+ZOJZAHn1d5CXJ8gCGU6F8E1xsd5AbM2pJebCLgl7CiquwzAblUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019588; c=relaxed/simple;
	bh=wWgEBRErrnF6xxMaN2mz18JXSs/HfhwtuWHUT5D2paw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg4wPcUmFcwbs8mcBEyKgH8BZQgswT1ZP+bphuSlz6JQ7wWmHYRemd3g1O197ZUs4sBDMpYlloKU2P2MsVN3j1O4d5/DStH/ofqV/03kuHJSUloQdEIdUI7AD2fqJkJajRjVPOjWs2dATymFXL87nTcvFMGkvxAFv2AggePVcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezL+lvCO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499614d3d2so7835703e87.3;
        Wed, 30 Apr 2025 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746019584; x=1746624384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbYcmxjx46rp9IY7QIROXHl5nuz3mSe+PSNFYXDKTlk=;
        b=ezL+lvCOlM+RAou/9tWHv1byQVj+7Z3dDTnvaFEZFj5m8Gi5GcmGSCmWXIeVrtU/F1
         I/Koa4Wheb/F74p+b0KkQsP5lfG+cq6cUH2h7Vr2LhjsbX3RpNn6K07ffhEbJKTTaAl5
         ZJ+BWPD2ECglSYr4HRwiKrziEU+2UXtt/jvvzqL9Pxaq+qh6XNiDmAsIsz5KLZg15ufY
         SiZxutxRF6cwqCM+Td0tiSH3Xr+GtQ9nZ5O9Ty0jeg5NRqREGVVqgTegtlEs/CJeSWoc
         OIjTwYmPQT79rjZ8nGZfwGLJC//8tsisSuM56usFk4Y+0O4tIt5rd5gSjghEPgDtDqJt
         s0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746019584; x=1746624384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbYcmxjx46rp9IY7QIROXHl5nuz3mSe+PSNFYXDKTlk=;
        b=a3yLuJo2ipmpH+XWVyvd4UHdtodkVrPT9XEvjCQiStIO29aP36d8CxCzaVsaM9rRGq
         6VzQuQMA2G8wSivrdooDSjQgVgtUI+M6C8cFq9CJQp0ldne6DDdNB5h9z5nh8okXxc+P
         QctocGYLGc1ZT36B9veflpy8oaXOLIjns31xWzH+QD2Fuiebj0kIB3/HV1LAeV6gdfu8
         91VtY5p7C5fAENry1e7k2DyUN7+1N9b2geqQtKBhMAbW1j9Yb+pASS6qXzQi04VMVl1w
         8thXDxUtgvqS8Fa2yw+OZYK2LNIr2o2hE9FfF5DcnrM9LPDQc5HdvOJXJMnux8i4blbt
         T/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9FkAh5jdbpLvDMTgd8FcITkmNNDaKSyo+2QfNLOjOtn4GAlcJUFuiTJnsYza816TWqMfAltGx@vger.kernel.org, AJvYcCVMBe+UVwUMIz05jz0T9a2N3GwOEjILFuksDdRnvI97JRQCXiV7fB14rUno3wW+DA+Pf5TcYs5Ua8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWaR6A0DUh1GdA1uMg+LuIClx2NNYiTQXpmpZjDjq3f2mUGJR
	8C/uU7AbI67Yq7LKxneWWQNTYjH27Xs7zGprjQUrjRqqeOLE+EVcIHcIkRTG3hkJF50zPAMZf2y
	jitAKdquL661cScWXuXXGB7BmyM5U9rFA
X-Gm-Gg: ASbGncsi+xMmbnYaBnbyJwgn1spsA5Q887wFS7sAhT79FzHpQEh4QQceMcPdcCBM2tC
	BlzHyDUwFWUXMd5s0xTBTCxAJ+oZuCWftA8GOTV51QZVVispagyvr6tyZat/OxfXACq7JySlhLm
	rfbioopInQ15UETds2Qqe90g4GDN6hxgOJuqp7v0G/5ONfaOGQDf26/w==
X-Google-Smtp-Source: AGHT+IHHF20FeumrcSTf70Yp2ajOokrCJ96ZyQmrLYRWknLcIg0QrvQ5JXXxGuHeSP5uHcsgsxmlT/VTTHC75iwep5I=
X-Received: by 2002:a05:6512:e93:b0:545:c7d:1796 with SMTP id
 2adb3069b0e04-54ea33aea24mr1100537e87.43.1746019583594; Wed, 30 Apr 2025
 06:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
 <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
 <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com> <20250430141112.00004bb8@huawei.com>
In-Reply-To: <20250430141112.00004bb8@huawei.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Apr 2025 10:26:12 -0300
X-Gm-Features: ATxdqUG649tIcgrq97Ik7etoNuY0EXY5HH1m2lsT9h4svB05dZhAvtF9NaSpKlc
Message-ID: <CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:11=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

> As below. Should be mask1[0] as we've already indexed the array with
> the above calculation.

Thanks for catching that bug.

Now I get:

[    1.556734] iio-core: ******** masklength is 9
[    1.559663] iio-core: ******** longs_per_mask is 1
[    1.564119] iio-core: ******** mask1[0] is 0x1
[    1.573367] iio-core: ******** mask2[0] is 0x2
[    1.577822] iio-core: ******** mask2[0] is 0x4
[    1.582279] iio-core: ******** mask2[0] is 0x8
[    1.586738] iio-core: ******** mask2[0] is 0x3
[    1.591198] iio-core: ******** mask2[0] is 0x7
[    1.595654] iio-core: ******** mask2[0] is 0xf
[    1.600110] iio-core: ******** mask2[0] is 0xc
[    1.604560] iio-core: ******** mask2[0] is 0x1000
[    1.609278] max1363 1-0064: available_scan_mask 8 subset of 0. Never use=
d
[    1.616084] iio-core: ******** mask2[0] is 0x2000
[    1.620799] max1363 1-0064: available_scan_mask 9 subset of 0. Never use=
d
[    1.627602] iio-core: ******** mask2[0] is 0x40000
[    1.632408] max1363 1-0064: available_scan_mask 10 subset of 0. Never us=
ed
[    1.639303] iio-core: ******** mask2[0] is 0x80000
[    1.644105] max1363 1-0064: available_scan_mask 11 subset of 0. Never us=
ed
[    1.650995] iio-core: ******** mask2[0] is 0x3000
[    1.655713] max1363 1-0064: available_scan_mask 12 subset of 0. Never us=
ed
[    1.662606] iio-core: ******** mask2[0] is 0xc0000
[    1.667412] max1363 1-0064: available_scan_mask 13 subset of 0. Never us=
ed
[    1.674309] iio-core: ******** mask1[1] is 0x2
[    1.678761] iio-core: ******** mask2[1] is 0x4
[    1.683212] iio-core: ******** mask2[1] is 0x8
[    1.687666] iio-core: ******** mask2[1] is 0x3
[    1.692118] iio-core: ******** mask2[1] is 0x7
[    1.696576] iio-core: ******** mask2[1] is 0xf
[    1.701029] iio-core: ******** mask2[1] is 0xc
[    1.705483] iio-core: ******** mask2[1] is 0x1000
[    1.710199] max1363 1-0064: available_scan_mask 8 subset of 1. Never use=
d
[    1.716996] iio-core: ******** mask2[1] is 0x2000
[    1.721711] max1363 1-0064: available_scan_mask 9 subset of 1. Never use=
d
[    1.728510] iio-core: ******** mask2[1] is 0x40000
[    1.733317] max1363 1-0064: available_scan_mask 10 subset of 1. Never us=
ed
[    1.740212] iio-core: ******** mask2[1] is 0x80000
[    1.745013] max1363 1-0064: available_scan_mask 11 subset of 1. Never us=
ed
[    1.751899] iio-core: ******** mask2[1] is 0x3000
[    1.756612] max1363 1-0064: available_scan_mask 12 subset of 1. Never us=
ed
[    1.763503] iio-core: ******** mask2[1] is 0xc0000
[    1.768306] max1363 1-0064: available_scan_mask 13 subset of 1. Never us=
ed
[    1.775193] iio-core: ******** mask1[2] is 0x4
[    1.779650] iio-core: ******** mask2[2] is 0x8
[    1.784117] iio-core: ******** mask2[2] is 0x3
[    1.788570] iio-core: ******** mask2[2] is 0x7
[    1.793023] iio-core: ******** mask2[2] is 0xf
[    1.797476] iio-core: ******** mask2[2] is 0xc
[    1.801934] iio-core: ******** mask2[2] is 0x1000
[    1.806650] max1363 1-0064: available_scan_mask 8 subset of 2. Never use=
d
[    1.813447] iio-core: ******** mask2[2] is 0x2000
[    1.818162] max1363 1-0064: available_scan_mask 9 subset of 2. Never use=
d
[    1.824961] iio-core: ******** mask2[2] is 0x40000
[    1.829764] max1363 1-0064: available_scan_mask 10 subset of 2. Never us=
ed
[    1.836649] iio-core: ******** mask2[2] is 0x80000
[    1.841450] max1363 1-0064: available_scan_mask 11 subset of 2. Never us=
ed
[    1.848336] iio-core: ******** mask2[2] is 0x3000
[    1.853049] max1363 1-0064: available_scan_mask 12 subset of 2. Never us=
ed
[    1.859934] iio-core: ******** mask2[2] is 0xc0000
[    1.864740] max1363 1-0064: available_scan_mask 13 subset of 2. Never us=
ed
[    1.871626] iio-core: ******** mask1[3] is 0x8
[    1.876079] iio-core: ******** mask2[3] is 0x3
[    1.880533] iio-core: ******** mask2[3] is 0x7
[    1.884985] iio-core: ******** mask2[3] is 0xf
[    1.889439] iio-core: ******** mask2[3] is 0xc
[    1.893891] iio-core: ******** mask2[3] is 0x1000
[    1.898605] max1363 1-0064: available_scan_mask 8 subset of 3. Never use=
d
[    1.905403] iio-core: ******** mask2[3] is 0x2000
[    1.910122] max1363 1-0064: available_scan_mask 9 subset of 3. Never use=
d
[    1.916921] iio-core: ******** mask2[3] is 0x40000
[    1.921724] max1363 1-0064: available_scan_mask 10 subset of 3. Never us=
ed
[    1.928610] iio-core: ******** mask2[3] is 0x80000
[    1.933413] max1363 1-0064: available_scan_mask 11 subset of 3. Never us=
ed
[    1.940297] iio-core: ******** mask2[3] is 0x3000
[    1.945012] max1363 1-0064: available_scan_mask 12 subset of 3. Never us=
ed
[    1.951897] iio-core: ******** mask2[3] is 0xc0000
[    1.956698] max1363 1-0064: available_scan_mask 13 subset of 3. Never us=
ed
[    1.963584] iio-core: ******** mask1[4] is 0x3
[    1.968037] iio-core: ******** mask2[4] is 0x7
[    1.972489] iio-core: ******** mask2[4] is 0xf
[    1.976942] iio-core: ******** mask2[4] is 0xc
[    1.981394] iio-core: ******** mask2[4] is 0x1000
[    1.986113] max1363 1-0064: available_scan_mask 8 subset of 4. Never use=
d
[    1.992915] iio-core: ******** mask2[4] is 0x2000
[    1.997626] max1363 1-0064: available_scan_mask 9 subset of 4. Never use=
d
[    2.004429] iio-core: ******** mask2[4] is 0x40000
[    2.009230] max1363 1-0064: available_scan_mask 10 subset of 4. Never us=
ed
[    2.016120] iio-core: ******** mask2[4] is 0x80000
[    2.020922] max1363 1-0064: available_scan_mask 11 subset of 4. Never us=
ed
[    2.027807] iio-core: ******** mask2[4] is 0x3000
[    2.032522] max1363 1-0064: available_scan_mask 12 subset of 4. Never us=
ed
[    2.039408] iio-core: ******** mask2[4] is 0xc0000
[    2.044210] max1363 1-0064: available_scan_mask 13 subset of 4. Never us=
ed
[    2.051095] iio-core: ******** mask1[5] is 0x7
[    2.055548] iio-core: ******** mask2[5] is 0xf
[    2.060000] iio-core: ******** mask2[5] is 0xc
[    2.064453] iio-core: ******** mask2[5] is 0x1000
[    2.069167] max1363 1-0064: available_scan_mask 8 subset of 5. Never use=
d
[    2.075966] iio-core: ******** mask2[5] is 0x2000
[    2.080680] max1363 1-0064: available_scan_mask 9 subset of 5. Never use=
d
[    2.087478] iio-core: ******** mask2[5] is 0x40000
[    2.092280] max1363 1-0064: available_scan_mask 10 subset of 5. Never us=
ed
[    2.099166] iio-core: ******** mask2[5] is 0x80000
[    2.103967] max1363 1-0064: available_scan_mask 11 subset of 5. Never us=
ed
[    2.110858] iio-core: ******** mask2[5] is 0x3000
[    2.115573] max1363 1-0064: available_scan_mask 12 subset of 5. Never us=
ed
[    2.122463] iio-core: ******** mask2[5] is 0xc0000
[    2.127265] max1363 1-0064: available_scan_mask 13 subset of 5. Never us=
ed
[    2.134150] iio-core: ******** mask1[6] is 0xf
[    2.138602] iio-core: ******** mask2[6] is 0xc
[    2.143056] max1363 1-0064: available_scan_mask 7 subset of 6. Never use=
d
[    2.149862] iio-core: ******** mask2[6] is 0x1000
[    2.154578] max1363 1-0064: available_scan_mask 8 subset of 6. Never use=
d
[    2.161374] iio-core: ******** mask2[6] is 0x2000
[    2.166089] max1363 1-0064: available_scan_mask 9 subset of 6. Never use=
d
[    2.172886] iio-core: ******** mask2[6] is 0x40000
[    2.177687] max1363 1-0064: available_scan_mask 10 subset of 6. Never us=
ed
[    2.184573] iio-core: ******** mask2[6] is 0x80000
[    2.189372] max1363 1-0064: available_scan_mask 11 subset of 6. Never us=
ed
[    2.196257] iio-core: ******** mask2[6] is 0x3000
[    2.200973] max1363 1-0064: available_scan_mask 12 subset of 6. Never us=
ed
[    2.207858] iio-core: ******** mask2[6] is 0xc0000
[    2.212659] max1363 1-0064: available_scan_mask 13 subset of 6. Never us=
ed
[    2.219544] iio-core: ******** mask1[7] is 0xc
[    2.223996] iio-core: ******** mask2[7] is 0x1000
[    2.228715] max1363 1-0064: available_scan_mask 8 subset of 7. Never use=
d
[    2.235518] iio-core: ******** mask2[7] is 0x2000
[    2.240234] max1363 1-0064: available_scan_mask 9 subset of 7. Never use=
d
[    2.247030] iio-core: ******** mask2[7] is 0x40000
[    2.251832] max1363 1-0064: available_scan_mask 10 subset of 7. Never us=
ed
[    2.258717] iio-core: ******** mask2[7] is 0x80000
[    2.263518] max1363 1-0064: available_scan_mask 11 subset of 7. Never us=
ed
[    2.270403] iio-core: ******** mask2[7] is 0x3000
[    2.275117] max1363 1-0064: available_scan_mask 12 subset of 7. Never us=
ed
[    2.282002] iio-core: ******** mask2[7] is 0xc0000
[    2.286803] max1363 1-0064: available_scan_mask 13 subset of 7. Never us=
ed
[    2.293688] iio-core: ******** mask1[8] is 0x1000
[    2.298401] iio-core: ******** mask2[8] is 0x2000
[    2.303116] max1363 1-0064: available_scan_mask 9 subset of 8. Never use=
d
[    2.309914] iio-core: ******** mask2[8] is 0x40000
[    2.314715] max1363 1-0064: available_scan_mask 10 subset of 8. Never us=
ed
[    2.321600] iio-core: ******** mask2[8] is 0x80000
[    2.326401] max1363 1-0064: available_scan_mask 11 subset of 8. Never us=
ed
[    2.333289] iio-core: ******** mask2[8] is 0x3000
[    2.338004] max1363 1-0064: available_scan_mask 12 subset of 8. Never us=
ed
[    2.344889] iio-core: ******** mask2[8] is 0xc0000
[    2.349691] max1363 1-0064: available_scan_mask 13 subset of 8. Never us=
ed
[    2.356577] iio-core: ******** mask1[9] is 0x2000
[    2.361294] iio-core: ******** mask2[9] is 0x40000
[    2.366094] max1363 1-0064: available_scan_mask 10 subset of 9. Never us=
ed
[    2.372977] iio-core: ******** mask2[9] is 0x80000
[    2.377778] max1363 1-0064: available_scan_mask 11 subset of 9. Never us=
ed
[    2.384663] iio-core: ******** mask2[9] is 0x3000
[    2.389377] max1363 1-0064: available_scan_mask 12 subset of 9. Never us=
ed
[    2.396262] iio-core: ******** mask2[9] is 0xc0000
[    2.401063] max1363 1-0064: available_scan_mask 13 subset of 9. Never us=
ed
[    2.407948] iio-core: ******** mask1[10] is 0x40000
[    2.412835] iio-core: ******** mask2[10] is 0x80000
[    2.417723] max1363 1-0064: available_scan_mask 11 subset of 10. Never u=
sed
[    2.424696] iio-core: ******** mask2[10] is 0x3000
[    2.429497] max1363 1-0064: available_scan_mask 12 subset of 10. Never u=
sed
[    2.436471] iio-core: ******** mask2[10] is 0xc0000
[    2.441359] max1363 1-0064: available_scan_mask 13 subset of 10. Never u=
sed
[    2.448331] iio-core: ******** mask1[11] is 0x80000
[    2.453218] iio-core: ******** mask2[11] is 0x3000
[    2.458020] max1363 1-0064: available_scan_mask 12 subset of 11. Never u=
sed
[    2.464991] iio-core: ******** mask2[11] is 0xc0000
[    2.469879] max1363 1-0064: available_scan_mask 13 subset of 11. Never u=
sed
[    2.476860] iio-core: ******** mask1[12] is 0x3000
[    2.481659] iio-core: ******** mask2[12] is 0xc0000
[    2.486551] max1363 1-0064: available_scan_mask 13 subset of 12. Never u=
sed

Who sets masklength =3D 9? Is this correct?

If I use BITS_PER_LONG instead of masklength inside bitmap_subset():

--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1947,16 +1947,22 @@ static void
iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
         * available masks in the order of preference (presumably the least
         * costy to access masks first).
         */
+       pr_err("******** masklength is %d", masklength);
+       pr_err("******** longs_per_mask is %d", longs_per_mask);
+
+
        for (i =3D 0; i < num_masks - 1; i++) {
                const unsigned long *mask1;
                int j;

                mask1 =3D av_masks + i * longs_per_mask;
+               pr_err("******** mask1[%d] is 0x%lx\n", i, mask1[0]);
                for (j =3D i + 1; j < num_masks; j++) {
                        const unsigned long *mask2;

                        mask2 =3D av_masks + j * longs_per_mask;
-                       if (bitmap_subset(mask2, mask1, masklength))
+                       pr_err("******** mask2[%d] is 0x%lx\n", i, mask2[0]=
);
+                       if (bitmap_subset(mask2, mask1, BITS_PER_LONG))
                                dev_warn(indio_dev->dev.parent,
                                         "available_scan_mask %d
subset of %d. Never used\n",
                                         j, i);

Then the correct subset information is printed:

[    1.560392] iio-core: ******** masklength is 9
[    1.560406] iio-core: ******** longs_per_mask is 1
[    1.564890] iio-core: ******** mask1[0] is 0x1
[    1.574185] iio-core: ******** mask2[0] is 0x2
[    1.578644] iio-core: ******** mask2[0] is 0x4
[    1.583108] iio-core: ******** mask2[0] is 0x8
[    1.587564] iio-core: ******** mask2[0] is 0x3
[    1.592024] iio-core: ******** mask2[0] is 0x7
[    1.596486] iio-core: ******** mask2[0] is 0xf
[    1.600948] iio-core: ******** mask2[0] is 0xc
[    1.605407] iio-core: ******** mask2[0] is 0x1000
[    1.610130] iio-core: ******** mask2[0] is 0x2000
[    1.614856] iio-core: ******** mask2[0] is 0x40000
[    1.619670] iio-core: ******** mask2[0] is 0x80000
[    1.624475] iio-core: ******** mask2[0] is 0x3000
[    1.629199] iio-core: ******** mask2[0] is 0xc0000
[    1.634017] iio-core: ******** mask1[1] is 0x2
[    1.638475] iio-core: ******** mask2[1] is 0x4
[    1.642941] iio-core: ******** mask2[1] is 0x8
[    1.647401] iio-core: ******** mask2[1] is 0x3
[    1.651865] iio-core: ******** mask2[1] is 0x7
[    1.656321] iio-core: ******** mask2[1] is 0xf
[    1.660786] iio-core: ******** mask2[1] is 0xc
[    1.665245] iio-core: ******** mask2[1] is 0x1000
[    1.669968] iio-core: ******** mask2[1] is 0x2000
[    1.674691] iio-core: ******** mask2[1] is 0x40000
[    1.679505] iio-core: ******** mask2[1] is 0x80000
[    1.684345] iio-core: ******** mask2[1] is 0x3000
[    1.689069] iio-core: ******** mask2[1] is 0xc0000
[    1.693872] iio-core: ******** mask1[2] is 0x4
[    1.698331] iio-core: ******** mask2[2] is 0x8
[    1.702788] iio-core: ******** mask2[2] is 0x3
[    1.707246] iio-core: ******** mask2[2] is 0x7
[    1.711702] iio-core: ******** mask2[2] is 0xf
[    1.716156] iio-core: ******** mask2[2] is 0xc
[    1.720614] iio-core: ******** mask2[2] is 0x1000
[    1.725333] iio-core: ******** mask2[2] is 0x2000
[    1.730046] iio-core: ******** mask2[2] is 0x40000
[    1.734850] iio-core: ******** mask2[2] is 0x80000
[    1.739665] iio-core: ******** mask2[2] is 0x3000
[    1.744385] iio-core: ******** mask2[2] is 0xc0000
[    1.749192] iio-core: ******** mask1[3] is 0x8
[    1.753654] iio-core: ******** mask2[3] is 0x3
[    1.758112] iio-core: ******** mask2[3] is 0x7
[    1.762570] iio-core: ******** mask2[3] is 0xf
[    1.767027] iio-core: ******** mask2[3] is 0xc
[    1.771484] iio-core: ******** mask2[3] is 0x1000
[    1.776203] iio-core: ******** mask2[3] is 0x2000
[    1.780921] iio-core: ******** mask2[3] is 0x40000
[    1.785727] iio-core: ******** mask2[3] is 0x80000
[    1.790531] iio-core: ******** mask2[3] is 0x3000
[    1.795253] iio-core: ******** mask2[3] is 0xc0000
[    1.800059] iio-core: ******** mask1[4] is 0x3
[    1.804515] iio-core: ******** mask2[4] is 0x7
[    1.808970] iio-core: ******** mask2[4] is 0xf
[    1.813427] iio-core: ******** mask2[4] is 0xc
[    1.817891] iio-core: ******** mask2[4] is 0x1000
[    1.822608] iio-core: ******** mask2[4] is 0x2000
[    1.827336] iio-core: ******** mask2[4] is 0x40000
[    1.832164] iio-core: ******** mask2[4] is 0x80000
[    1.836970] iio-core: ******** mask2[4] is 0x3000
[    1.841690] iio-core: ******** mask2[4] is 0xc0000
[    1.846495] iio-core: ******** mask1[5] is 0x7
[    1.850953] iio-core: ******** mask2[5] is 0xf
[    1.855409] iio-core: ******** mask2[5] is 0xc
[    1.859867] iio-core: ******** mask2[5] is 0x1000
[    1.864590] iio-core: ******** mask2[5] is 0x2000
[    1.869310] iio-core: ******** mask2[5] is 0x40000
[    1.874116] iio-core: ******** mask2[5] is 0x80000
[    1.878918] iio-core: ******** mask2[5] is 0x3000
[    1.883636] iio-core: ******** mask2[5] is 0xc0000
[    1.888442] iio-core: ******** mask1[6] is 0xf
[    1.892900] iio-core: ******** mask2[6] is 0xc
[    1.897364] max1363 1-0064: available_scan_mask 7 subset of 6. Never use=
d
[    1.904169] iio-core: ******** mask2[6] is 0x1000
[    1.908887] iio-core: ******** mask2[6] is 0x2000
[    1.913603] iio-core: ******** mask2[6] is 0x40000
[    1.918409] iio-core: ******** mask2[6] is 0x80000
[    1.923212] iio-core: ******** mask2[6] is 0x3000
[    1.927930] iio-core: ******** mask2[6] is 0xc0000
[    1.932733] iio-core: ******** mask1[7] is 0xc
[    1.937190] iio-core: ******** mask2[7] is 0x1000
[    1.941902] iio-core: ******** mask2[7] is 0x2000
[    1.941907] iio-core: ******** mask2[7] is 0x40000
[    1.941911] iio-core: ******** mask2[7] is 0x80000
[    1.941917] iio-core: ******** mask2[7] is 0x3000
[    1.965640] iio-core: ******** mask2[7] is 0xc0000
[    1.970447] iio-core: ******** mask1[8] is 0x1000
[    1.975163] iio-core: ******** mask2[8] is 0x2000
[    1.979881] iio-core: ******** mask2[8] is 0x40000
[    1.984683] iio-core: ******** mask2[8] is 0x80000
[    1.989491] iio-core: ******** mask2[8] is 0x3000
[    1.994209] iio-core: ******** mask2[8] is 0xc0000
[    1.999010] iio-core: ******** mask1[9] is 0x2000
[    2.003732] iio-core: ******** mask2[9] is 0x40000
[    2.008533] iio-core: ******** mask2[9] is 0x80000
[    2.013339] iio-core: ******** mask2[9] is 0x3000
[    2.018065] iio-core: ******** mask2[9] is 0xc0000
[    2.022866] iio-core: ******** mask1[10] is 0x40000
[    2.027760] iio-core: ******** mask2[10] is 0x80000
[    2.032647] iio-core: ******** mask2[10] is 0x3000
[    2.037453] iio-core: ******** mask2[10] is 0xc0000
[    2.042346] iio-core: ******** mask1[11] is 0x80000
[    2.047234] iio-core: ******** mask2[11] is 0x3000
[    2.052041] iio-core: ******** mask2[11] is 0xc0000
[    2.056928] iio-core: ******** mask1[12] is 0x3000
[    2.061736] iio-core: ******** mask2[12] is 0xc0000

