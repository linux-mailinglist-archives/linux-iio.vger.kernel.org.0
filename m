Return-Path: <linux-iio+bounces-3769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A388A9F1
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FCC1C3A759
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64212FF88;
	Mon, 25 Mar 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wkPdG6oJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6F44C64
	for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378905; cv=none; b=Xj8SXwbQUYXadpgOdV1WD02iiDAUIwMHvdnq6hiiP6qmvbYWYHB6M/VJDtkDPpS9VhjlJspcIHHijnwycpcWYDmPKmzma9SRHCPI7zj5VzcgB787bwSkoUyzGfNY5iVnQwU9MxsQIarFu2rg7zqsEJHMagaMUhJlyAb0J9/LnsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378905; c=relaxed/simple;
	bh=J1GJWD2Uw75AizZkYb7+DSC6vbUI9FgQBFn59jiHELI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDUsw3qTXqJ+kaGrVtCe+TCR7CZlZCDW2dM10/5huskfg1jqF64aIQYTci6mrwbpSJGauQubEHamYNYwZBhVTor7A9c5k830oMDXgmwcjmMITihrBPXM6Nauye7KGpltF9H6i+LOQaHsWS3GdXyvpJqzQrh5Sz11GAEcO24NgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wkPdG6oJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso4786827e87.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711378901; x=1711983701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1GJWD2Uw75AizZkYb7+DSC6vbUI9FgQBFn59jiHELI=;
        b=wkPdG6oJ0VZTuqpGTI/gNdDKCqmqrJ/cx+k6nAXTANZspgyCcddCzQLje1hAiKnY+n
         DGXHkqFnnVJQj0u7JFZh6zWCMLj+MqToUF0GN2gZpypx1zBuReKXYWj2OQ7dvSFDPx4n
         v4MyCeJJJ8vayhngmx8kCoRQOnYTJEtEeT8tPvbTXCyVWAB0lXQIlH9+MwShTaeWzsdr
         d6EGk+WqKcS+PtR0EscRJCj7e/AWn9BEa5G6aCEZkGB93SDYLju7iiezIPaJ878FfSFO
         Mcl1lm0ExLpDztXySCt464O6SnfR/oMQ1uayBfSFgLS7EuUQPvRE9PSQdFfGikhOEiHR
         5OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378901; x=1711983701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1GJWD2Uw75AizZkYb7+DSC6vbUI9FgQBFn59jiHELI=;
        b=d9lZhmCUzARNdVQyInnNmqnpzUdHSEUSnadHJvROOsOyiZxEm8r7K8PyWAySQcOwPy
         7Ki8chcRQPXH3J3yMdR90KXSMAVeAIUxj8FGbjVy48e9OVZQbZxMFZ1DwFRwwvir5zzh
         WEu8zblgCKuDgjC+x+dJyuQbr3ycBGWVO19EkZiuV/gP2fWIMZE8/eIYIXnjPfZWhJzg
         8rOhnIrmPDYrsXpmYSNXxfS+w4d+qweNfYchqZiiAqa+4XNgbmsVoU1aDmNimV+Zs5JX
         jA7uXiDPDjbD1QlVWvmo4gKcqpkv8yyWPT01PXK+2BQs+NlyV4VCgGIN8Lu87gzU6dvr
         AytQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUsXhmn9yAqKAUvwqfLN3WKNwHzmcfTrVtzR3z4+cjI+1N8ztfKnjlDGqEYn5cCs3apoUIoABz9g2UHfyKEJ45gm0HZo+waSxH
X-Gm-Message-State: AOJu0YyG0bbH9CJEK9mxsV9SMuSEVezreaCTH2w/EN54vql5w2Ex3kum
	IiSwSNAnKDWEhPKFkY9Jbg15OevtLVrMFKKW2WCC4vJMZCl7yIZNOg1T7vHUnC7PkEVSR6GnM8Z
	oEBpZTATjhlnmD5cPRH8Pk6NF9FenFRqZ1TPbuw==
X-Google-Smtp-Source: AGHT+IEXWyh8xd3VomCJthT7kJfFp+OHTh+i9uf/Ek3pq0kOY3hlzw+qYnSAMFsfi1PIn1RIyt45npMZCd1BRSd8e1M=
X-Received: by 2002:a05:651c:232:b0:2d6:a5e0:f50 with SMTP id
 z18-20020a05651c023200b002d6a5e00f50mr56296ljn.11.1711378901034; Mon, 25 Mar
 2024 08:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
 <20240319-adding-new-ad738x-driver-v5-7-ce7df004ceb3@baylibre.com> <20240324131059.77fa8e68@jic23-huawei>
In-Reply-To: <20240324131059.77fa8e68@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Mar 2024 10:01:29 -0500
Message-ID: <CAMknhBH0E258geq8WOKf3X0r7VngdDoSfNB5g6KTGBzEoUtMqA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] iio: adc: ad7380: add support for ad738x-4 4
 channels variants
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 8:11=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 Mar 2024 11:11:28 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > Add support for ad7380/1/2/3-4 parts which are 4 channels
> > variants from ad7380/1/2/3
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> This and other patches I didn't comment on all look good to me.
> So just those minor few bits and bobs for v6 and I'll pick this up
> if nothing else comes in.
>

Hi Jonathan, as a reminder, this is the driver we dropped from the 6.9
cycle. We still don't have a patch prepared for the resolution boost
feature that may require us to reconsider some of our userspace
interface choices here. Hopefully we can get that sorted out in the
next 6 weeks, but I just wanted to make you aware ahead of time so
that we don't end up in the same situation in case things don't go as
planned again. Do you have "usual" way you prefer to handle a
situation like this?

