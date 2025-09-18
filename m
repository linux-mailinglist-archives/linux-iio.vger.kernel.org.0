Return-Path: <linux-iio+bounces-24245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D796B84117
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97BF544976
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0904F22F74D;
	Thu, 18 Sep 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvmtbncS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5D287242
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191106; cv=none; b=fpdbzw2xumWzkhmpuwrW+M3rNBLxyuNvGqULimJw9Iz2ktuZlsdfAZAPBDe97wulWHJD2524YZjEvPMNLuUtdo+n9CxhG3CmTzsbPCor/WVPDx9jMwMDPKnVIQQs5NdXZVDRqmy7LYb6IjbGlT626v4okWo6TdBTMUfzhDcnapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191106; c=relaxed/simple;
	bh=kOvm+FSRDMqrfRGWXwZTtgcmHLHOo9umbhIA218JDrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDhjn9BO3236yyWdKbTTsS09ps23hT2CbIbnJete6Mjmh7KvTTwgJa8hoim3V5szQFqnNjpuUhi0eG5110jB9N37pTJEuJKhGoTjY+TRcwinTN3iTT82SAceUpE4ufgF4j2jsZNZTN0agYRZQkdtYQY2HQ1gv7WJjvAzYVksmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvmtbncS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso493958f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758191102; x=1758795902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOvm+FSRDMqrfRGWXwZTtgcmHLHOo9umbhIA218JDrg=;
        b=cvmtbncS4faW81Kst2F7UfgR/toi8Ef6z9b5bnLyxhpnScrKMWonjnsDVG6xDQq2t4
         birFdasZXFjQgGnv0YDBiz2HrGCt8+yWq+ewegyJSRsMp/Cp5ztrfi/GJYPhWX5njIcO
         gPU4l/+k4fKO3pnDdv2CwgmeOW76QiVXSlIyr7/RoB46+qjtZBnOsTsK/bOUVJc+DZaA
         G8WWNtiJFZfkmoX1zPR6k8z1g7wlRfQkVNkJHXf/Zvux+ZcqOPPbyPiRsQx4FPRs52ba
         9oYHS4K2doEIjH8ujdJy9tvL+2JpuavbZH4Yn75Ia1FOAvm0m0bojra+5q3FPUaRSfTy
         tHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191102; x=1758795902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOvm+FSRDMqrfRGWXwZTtgcmHLHOo9umbhIA218JDrg=;
        b=GRfaWy6XdqF/LkqNlHIts6qbSp+iGxIXMxkBsUAWasciwNiyXo39zZYSeoTAfhVHae
         s9gPSddhETiGR+f6dgtXzvOTnuy8BbEyUysyPmCQUJMSSwhUiA1HXryb4e7U4qzpy/Jx
         yEN8P7sFhM3nCmShfxRI4XcMUS3L2W01aXWZpUA3j1ovyr6obXLKepylzKdGgXfOJuyj
         LqpJ1bu8UT2Qgq+vt68jfZJNu0qjks85N8taMTQRcy6e/1JtwKAIqJHRXwrOrwCXwQDf
         OAa9AeVpCixTfiyJg9nd2cGf/r4SsEnPyRX3mxBkiN3maM1YNwsykQ3r9yMUYhPBa89E
         Kr5Q==
X-Gm-Message-State: AOJu0Yzh5oQN1dCvLhwxpJIhhzKs9xrnmeqf6Z2C+vlPdQkfInvJvuAR
	dPcbOvkyuST56NS2Ys+GUBCAUXJA9LjTPuoV1qhV1QdHAmG2O5H+bgJI
X-Gm-Gg: ASbGnct3Y59pmJar1igQkKoVGvklEVxwGvHKeq/rFb15vTjOlBs8Npf+sEr507e39ha
	h76nTxIreWJhgz+r0YfXLf9cUL4W6cJLDxLJjG9V6giksuUHaL9OJggoL/2cM7Casz0t2EP1P18
	gyd7WVaVST26fovwOB8zMdCdVknnaIDr5UM9qR2Chia7lQtyNfpUISmeauxbY4N4kJHZiUnklpJ
	M5q8EdyS6NRe9KMYsfRddsRYxOCQom4WzfyQBo6OhTaChkAI0dHaO5lnFY9FKyVfdzn4mZwMLNV
	84hfVwK0xOKaHAPKwwV0jo0r0I+gpVg6mG8e5sdqwtL1o/urejGaFTgNkX6wI8u6S2rzQGjggRk
	GwZUxZf4NjLCi6wnnJt7zvUy5tUiAn8fKpx5nYzw5+O4VRiQW6MOx/VnRTTQ3
X-Google-Smtp-Source: AGHT+IE89bqEquEMvnJ2bVfT2RyzTCxqXtWFe3MTLksbWjUhUBkk1SNeRoutV4BeFiYIHxO9vGiHdg==
X-Received: by 2002:a05:6000:40cb:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-3ee146119c6mr658186f8f.31.1758191101614;
        Thu, 18 Sep 2025 03:25:01 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2962807f8f.52.2025.09.18.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:25:01 -0700 (PDT)
Message-ID: <f2eb2424e4b3fc787d1f20b17852e97b1a708cc8.camel@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: ad7124: drop nr field
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 11:25:27 +0100
In-Reply-To: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 15:39 -0500, David Lechner wrote:
> The motivation behind this series was to remove the `nr` field in struct
> ad7124_channel since it is duplicating the same value as struct
> iio_chan_spec.address (and duplicated again by .scan_index).
>=20
> When it came to actually doing that though, I found that it was easier
> to first clean things up by removing the ad7124_enable_channel()
> function - which is a nice cleanup by itself. So ended up with 2 patches
> that end with the same result without ever mentioning the duplication.
>=20
> ---
> David Lechner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: inline ad7124_enable_cha=
nnel()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: remove unused `nr` field
>=20
> =C2=A0drivers/iio/adc/ad7124.c | 19 ++++++-------------
> =C2=A01 file changed, 6 insertions(+), 13 deletions(-)
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-drop-nr-field-518102218a61
>=20
> Best regards,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

