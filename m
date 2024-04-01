Return-Path: <linux-iio+bounces-3978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E29894590
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 21:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90622B21AFF
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032D53399;
	Mon,  1 Apr 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cuthe6Y0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0A339B1
	for <linux-iio@vger.kernel.org>; Mon,  1 Apr 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000313; cv=none; b=m1/4euOdXC8zo+42PbZi2ye3v7+4cnH2Su+K4ODc2zowWjr1gKHYm/ZLeD/QqW0Zql0QV9c41pdOIZQ2LlY6SgAgjmCu+TGSNXZLWv9fA71xeqzGZiplAlKut1qvKAK7klXj3vW++mLrf2yvMpATnFJNXZty9D55yUcaQGw0pYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000313; c=relaxed/simple;
	bh=0nSnVu/F7MlD/245znAwpTCtQGhr9EGy51aNPMORhrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnlUX/LSRcyMPmw8TUokLPAIJ/PlNl3By8tQYMU9TK+iI71tkHsgz6JrLfPTfrk7Ff9R5LBuBsrK1B5yzHC3V119Pfqu2SsmZ+0KwYkCMUD4C+ePZltbn0rKBuL0Ya2mQVb19wZ9FGzU+xC+NOvatXKj+ulFBehPo6OBRGYhXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cuthe6Y0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so42681961fa.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Apr 2024 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000310; x=1712605110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bY3a3JBXLnt/iNzTxqijK99mBFdUt0tkDeQjEmcVQc=;
        b=Cuthe6Y0G3Ye1fLC7dXiL4fGOkNd4NfjPZJmoRVJtcWilLYnveH+WtY2jO7c9mR+na
         bphm3JOp6GlQZl3bVbMM1LqTIK1ACrNmDvaMmnrRCP9ztFiAD0cdAAZYFp8AlQA732ub
         vKbZf9z6y0jlDUcxx3WtZf2swihNkG1zdZVy410REEzTaF7nNhjDT+h5DBn+0qEuCTZN
         YjHgpE5MnlYBj5MpXxYMA6tfJRQ9ut8aG6qwWQ3kongc6EKzEBlEi4/YqApYNCNDbBfH
         OsAFY8RvK3UP3wEQEvuk8pUbT3h44tEmQPNt//ejQzea1U63NTMcH3QY1bV1jxsRU76s
         nRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000310; x=1712605110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bY3a3JBXLnt/iNzTxqijK99mBFdUt0tkDeQjEmcVQc=;
        b=w+kClg7aZNUZVQWOWohZEljKd+9C4l+FjquEOtASV2OHbfzkCe0AdfCsHfMP+p+L+W
         B5iE89/zN5z1Q96DUiqDbdEtQ4JUQ4BDxlAq5URo3FWBNIxxAxWxR0HcsLoChnZPT7ms
         +G4jHnnSoLGDJgHMcimIe1iVxzkTAVhbqjFOg9JOb7A0R5JCDgw/T81eUlnf9gf9ihC5
         nZabcu35amU/ZEbruX5tf5XqGklhfe2HURG+qLhLPXTGFGAb++Swsu0qD7EjEL09XcrX
         dYF7ABqDzYmzRDcKZUG3QQVDf6dw6T28l1yqgOeTjHpTnz1RmPLmoYgIY7JHv1pO5XLm
         BfPg==
X-Forwarded-Encrypted: i=1; AJvYcCVlyknS6wajhFO5c9vB87pcECLB6QpUXwcYzOE4YDV4DV1ztAaQYiA6cMvXiECJ6+z38MG86vd3eRz2+5R0LgaFrmHNxEDTZbIp
X-Gm-Message-State: AOJu0YzxYRUAuBSmwFez/OMIzNpOUq9BMyOwDex9zgk9VXszt5SQdIVn
	dzZlOWhttSdMrS/zvIZ5wl3VXc/wA5XaH0+KE22J/WAInoGDD3j3P1Uw8nLvsMmIhZX4+DScbt5
	cW3490gJyDCtrf4SFJbcnnd/v08KHyP39pyyELQ==
X-Google-Smtp-Source: AGHT+IEVJBo9ETClmFMV8FnnRcbXynKEpxQUuxHnmFEh7UsZWB0NbydI63YqCu09aqp/JUvf9RldLfcypfUgMSP5V+8=
X-Received: by 2002:a2e:9058:0:b0:2d2:31a8:cb1a with SMTP id
 n24-20020a2e9058000000b002d231a8cb1amr3381413ljg.13.1712000310288; Mon, 01
 Apr 2024 12:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-2-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-2-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:38:19 -0500
Message-ID: <CAMknhBGaJxXvsQ8cZkgDsKLVjOY5y2pzox-99hdOCrUaoZdsxg@mail.gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: ad7173: fix buffers enablement for ad7176-2
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> AD7176-2 does not feature input buffers, enable buffers only on
>  supported models.
>
> Fixes: cff259bf7274 ("iio: adc: ad7173: fix buffers enablement for ad7176=
-2")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

To be consistent with has_temp, maybe add `.has_input_buf =3D false,` to
ID_AD7176_2.

But either way:

Reviewed-by: David Lechner <dlechner@baylibre.com>

