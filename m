Return-Path: <linux-iio+bounces-20929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC18AE5308
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 23:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7474E7A2698
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5C1EEA3C;
	Mon, 23 Jun 2025 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C87dIOdB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02401E22E6
	for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715324; cv=none; b=ltaPX/ZPMeiGfdIRs4pvfwG+CDu8D9K32yd+HSeW0u0gzW3Y75jL0DV2uAzxEntF/gIeM73SvrLoikqENMPxwCaF9tokKhaDbFDG0ngZ3LbV37jkZed3J+Y8GjSSwYQLEaf60My8wLc4XLguNb1bb5RXLxQuE6XO+UibC+0cPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715324; c=relaxed/simple;
	bh=4bYjjF2yI77Na1nfsIj+g4X8U6tLp5T8SWhZcd9HNQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJK0ru+k6Wb0r75OUxFRUUarzOcsouG1MpkfLUSRi8S6bnGMH+JzmWzIjxAHyiY6dKZFz6Ee75wT0uiN/OGH76+ermiwqFVPzVnU6utg09koX7fNsAtuoHSoZ9UC4ycnre+tZnu9DFlDQ+yuuLgePLtAoDJQvj1MBXB0mcD/wCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C87dIOdB; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so43233191fa.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750715321; x=1751320121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnU+QVcxCYxEYL6PbzPZLje0addWyJna8P/l/C/lVg0=;
        b=C87dIOdBKEHiRR4ASB6zeIVNydIg4vXXMHRB2eSnxdu6Xmg1YM/ZB/XV/UH+dnKX8y
         Fa+b0QGkAGRh+BY03nBCQroT2iyjAqOBatlfLU4iPmVgRCxFa/9urbBVLAATmI7pYCVy
         ArFGjm94IyXezHc0arYfoG1Gjzg4bKRyE06HKJs6zOg+4HDa0QY8Q8QpKaiUOk9EvkWE
         6JcQVmglXz8LjQTt34uShPjORshpZIgvpnOomAPhtvLG5aapyx+Mf7SBNwAWNNSCSiJv
         t337DfPivHq8AUIHLn9UaItSg7/ad9v8Xjm+8zR+vF2CnOkKYia72VUSzCfjHk/trSOH
         h2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715321; x=1751320121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnU+QVcxCYxEYL6PbzPZLje0addWyJna8P/l/C/lVg0=;
        b=v+NasAdwf9mhlw6w4tzeZQGsZfjyWo3T3s9hcvUrbUe/NgXmOuTe5nIAYgoEMG/tBE
         NxrszyUEKjOTtIB2RpOGdFI/Dney/+IAlFDHjNbi5Gyyz8EoNh5O8wcxCwUq9/hgoryr
         uLyv8zQe4oIknlA5okVxIrGWOU3/dfaU7zmYNBPVw/WLHfMTMf4/eCwuPubxtjGOPC/A
         GWysXkAvKi34Svr1TisC9KdtPuTFrE5LaafB+SyJ9NIVJXNVbMR3HOKhL9xqbRnlY94Q
         +t9B1v6Zj0QyrTl/ZNCofPfn11yjlWD1D0BWI9bue7cdduvFgKawWNruQZAHBV+ydLMH
         pvvA==
X-Forwarded-Encrypted: i=1; AJvYcCXbYRhIcVdjjowvzm1/bTfIfqXPYnA8YajTCIfZswU4APnJ6O/B6XlxLxTrNywDlzTww/BPQXrmHhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr83ny+2O+UPSE+vDy+P0iPKkdpoOCjTKZc71Urq0+wsaGXpus
	4A1HWz+lep9KNghwsLGhr7HXfSAzaMLotBfGgNl7s7tPFhwrxj+k1q8apzMlSkvyuw/5N72bLAa
	1W4Tlk78DPPUbKIa0EPUNM9/JjWRNlxlU+2y1Vt+nCg==
X-Gm-Gg: ASbGnctCjG3amVmRDzZKIu7t0fE6VhxVQZOnAFG+DxWhcoJioLQe1OI/JLKZ3/UkZzP
	tgh5yb1dgWQUbyCLJDf+8v7KnP8QopM1CtnKVBwAiMrhmVbw3tFC6mSfCOf6IzaQjw+SVeqUmVF
	js5sHX60tffwKJmVq9Dro7orh6QSSbghMHQwby7ezOCMaM
X-Google-Smtp-Source: AGHT+IFEqza0DpEdoJWsbOSXs+4vZVjClIQT5f7IxRB12yNjDJQmhlzB577QjPcTEosoLth3err0U0r4QBcPWJHQ7Rk=
X-Received: by 2002:a05:651c:1a0c:b0:32a:8c12:babf with SMTP id
 38308e7fff4ca-32b9918b02fmr47960381fa.2.1750715320985; Mon, 23 Jun 2025
 14:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-2-0766f6297430@baylibre.com>
 <aFj5eEvn2uw_HSl0@smile.fi.intel.com>
In-Reply-To: <aFj5eEvn2uw_HSl0@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Jun 2025 15:48:30 -0600
X-Gm-Features: AX0GCFtsL-oycWVZVWTYTg3bjp_VLHo3OYdhTaf-OnhrFfyHZtM-ORpccSVZDA0
Message-ID: <CAMknhBHuJY=8rxgJsMhvRNxZskmPhEZc1jJMQnHzQHFFoucWRA@mail.gmail.com>
Subject: Re: [PATCH 2/9] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:51=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Jun 20, 2025 at 05:20:08PM -0500, David Lechner wrote:
> > Replace uint8_t with u8 in the ad_sigma_delta driver.
> >
> > Technically, uint8_t comes from the C standard library, while u8 is a
> > Linux kernel type. Since we don't use the C standard library in the
> > kernel, we should use the kernel types instead.
>
> ...
>
> >       unsigned int reset_length =3D sigma_delta->info->num_resetclks;
> > -     uint8_t *buf;
> > +     u8 *buf;
> >       unsigned int size;
> >       int ret;
>
> Wondering if in the cases like this we may make it to be reversed xmas tr=
ee.

Fine with me as long as Jonathan doesn't mind the noise since it looks
like I will be doing a v2 anyway.

>
>         unsigned int reset_length =3D sigma_delta->info->num_resetclks;
>         unsigned int size;
>         u8 *buf;
>         int ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

