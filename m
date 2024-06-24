Return-Path: <linux-iio+bounces-6800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE791447A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B7E1C211AD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD044AEC6;
	Mon, 24 Jun 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl5w/Fk5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2249645;
	Mon, 24 Jun 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217096; cv=none; b=undOdZxM1FyZlxcisxaqYQ2ztfGOc9Okk45Lb3zYZIZQl9cW/C+mz/9OgD2RbkidXE6ziSM87r1n02bgGv9gQFl+2A0FAPCrDB120BF57cyVeSc13/M8eVnfSnD4xhGyFpx4n3vOxRGedm2VV8Y24TJI9SW77Z4cOwwINo8GVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217096; c=relaxed/simple;
	bh=je7iVUYucuoeYQLpqSsqzD6r2n/1GXf0qdUuHS7ILWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYzUM2mFjI0Dngu+FuraktaxTLbcOyjO6sqRWVsaBcVqaWE5SzI8T2ABDT3s/N0jMUPeoGNRIGaW+RnE7DM6qYtCwC4N1wqBiwSRj3JJoeRLPub/63GQMcWS87ZeO2YvvIaTu55zT3CZ1ZlorPsQg6o0w4yHfrOy1J2guo738UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl5w/Fk5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3626c29d3f0so2323223f8f.1;
        Mon, 24 Jun 2024 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719217093; x=1719821893; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=je7iVUYucuoeYQLpqSsqzD6r2n/1GXf0qdUuHS7ILWI=;
        b=Sl5w/Fk574mbiTmj4dJJOI2pd+AxKOqsFoaBp7fmchrxZPzUahLJTAtrnwvYBgIczl
         tQrEER+kIHmCkjQQS99qGtQZCDHtJ12p+KdJVf4QYqUmmjygJIIm/5Kgh8rx5BBTZ7Qm
         DA8Ps7neZGHYmmp8vFo9XGmR31k8D4a6sdIOanot1/2gdscRI7y9sdLhQynPxDfTEmLE
         Sad7YeYrRnL9UREo21wDYTZjdmnRHstijAMOi7pVzx+wl2qmeJYBAyZNaIbByhJeegod
         f6HiHoESphApLy6vQqGQOASn6U0QiNAJeo9li21PQNGc6DbiSMY15d+ZaA+g4kngEXL5
         iWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217093; x=1719821893;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=je7iVUYucuoeYQLpqSsqzD6r2n/1GXf0qdUuHS7ILWI=;
        b=uqbVC2pUngrvWqzlNPiCCw0IauBVSPIZ/jJxHyMCXLW15jrtZdtAOnes8akQ7ZsxC0
         g9YqiK3hZMKMVFLiNw3I/+iqkBT7wlsQi86rfIGVL5mfftbUNU7H/qRfGradbci9ZMaG
         b9DmbQlS3orcsQ+8TxSV2wS0M5YxDsHc7z/JWpFYkgeU2w0huHFbyRUDkvQXdZqMyneW
         HHjFfx4lBBk51aejTffSMPgDBtMYX0GGhhfFSRO6t1gVk1SBxB4a9QsjLZYyLlw9q2tk
         G5tBYImOPWUrDU6i8BD4+9N2IkaCU4MU5OEBU1WWTxakFKn2khrlM05Tgs2vt6N3733P
         iyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvyscfKLZPTiPvqEJWYeEDlqiH1LUdwJP6uP/maJHu3NqcoFBs+RT0z90Mo/NYFXdm47Ksoes9OwKPNXRyKsqx//acg20+Sc+hgrWoZ6rOvHzv+wfIpKQwiv8jq3SBp3xoIXRzaRFR
X-Gm-Message-State: AOJu0Yw4NjSjOZy0UR8Xm+apB9KRq5gYCPkwjP5aEOzeDoLzmbo8rE2y
	gSDon9vVHu2pWoSLR35Mi/oTr0TBzvB3HItBbDp1QFSzxTtCfoaQ
X-Google-Smtp-Source: AGHT+IHnGYFexaKtfHeEI03foXMgcT/aayb9uK1oNmGi+t02VUhnUy5Mats+3Z7yrA54ooboVT9PcQ==
X-Received: by 2002:a5d:6544:0:b0:360:9a8a:5f02 with SMTP id ffacd0b85a97d-366e9629557mr2709718f8f.58.1719217092782;
        Mon, 24 Jun 2024 01:18:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c3d57sm9306718f8f.35.2024.06.24.01.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:18:12 -0700 (PDT)
Message-ID: <d95fee6fe2da5f4fb068f83975b383b1ba0b9bf0.camel@gmail.com>
Subject: Re: [PATCH 10/10] iio: dac: ad3552r: use
 devm_regulator_get_enable_read_voltage()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>,  Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:18:12 +0200
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-10-49e50cd0b99a@baylibre.com>
References: 
	<20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	 <20240621-iio-regulator-refactor-round-2-v1-10-49e50cd0b99a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 17:11 -0500, David Lechner wrote:
> Use devm_regulator_get_enable_read_voltage() to simplify the code.
> Error message is slightly changed since there is only one error return
> now.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



