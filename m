Return-Path: <linux-iio+bounces-6274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA54908EAA
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0EE5B2BA3A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD716C6A0;
	Fri, 14 Jun 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAsTP2B0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059619D8B2;
	Fri, 14 Jun 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378336; cv=none; b=rHC3zXZhysTTVnm32hHNBO9ecM9V+rpSPa+TpMixQcHH37HUZZ+vi7wZu/QIN0R5fiEuyemOW4bKzHGTZcD2NQa04GjqEREMhs5TxGXua0gAfsBQH4TfdS2zUzz74F/ZbM7aj3b+AYaFUkmqBKT6lejiWxoYIbnhTqeZulcfU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378336; c=relaxed/simple;
	bh=n0VXXCfPmou8uH9QZpI7EsxDFETVqYEtAGTVK8+9SMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dd+yRB7A5nLCpwSL//yOUKcFu76WPalcD9okGOKuu4fBOWh6/woSsaKk5HDxft58SPYk5mjnpnpDx0/qrc+5+YWijmu0ijgFbK6s/812nxXM+Tgwyk2lHeJcLyFl0NcW56/iInETAJ+TWDB6pJvVziEXZHU2TpcRYE7EQeZyRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAsTP2B0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso21337675e9.0;
        Fri, 14 Jun 2024 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718378333; x=1718983133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0VXXCfPmou8uH9QZpI7EsxDFETVqYEtAGTVK8+9SMs=;
        b=SAsTP2B0oHgnyFVSOeQTdxlxg0USJ23E423f3VJ95OsDre7/e4orPD5fBLIVbcouBm
         uP7IThX6j+mUKz574SBhHBtlLpuQel3puLal0rKnIQF+f8gQAr4L1mi1Zxav6E/XLwny
         6I6JhvhimOHksj8ZTR7g02PBzEFA/fmLhSlVHTL5HoSCKF7D10LJKEkHihxI1qsT+qdt
         Izr+kyd2EebynW2eeQ6NUCJ5DTUiMVGbWlLQs/G8M98/7CQD9b9jZ28bunthXMKCou4m
         ZftRxwpPK3taMqfD3zbgt/nsNLnRZJ91vhONl1wtXHJWec8Lv4tSNqZTUeiHeKtuBzHM
         z8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718378333; x=1718983133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0VXXCfPmou8uH9QZpI7EsxDFETVqYEtAGTVK8+9SMs=;
        b=dMzHksBnELvD+koImr9PvB9Nsvo6fglA6hdscE/KWA/rDkIjQ+SCf9UXkXnmnEaxGx
         30kYzTsT0iPqDv+fRhaMogn7D7iFUtHBEPuE/9ZL1MX4o3Iw8libPZIxDEurmLxNeiAo
         PvIrDruN9jPQ50kzlUordPwNfQVtyRDuPDowZOWuS/cBfyvAuX9QCcYJdA+4yhTrb5+K
         KwdNv0j9QoRVsSkcke/Hat2rk5ETh4T9yl/LE7A2zav5xjpdJSPeeW/2m9OPxO+MGY3Q
         Ie5hG50wul3B0a9UJITKTdJDge9OTxyoV20/k+dyR+CNp9F44ReEc/1zHQiLFJ/TCdQp
         r0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0sKeWJLesPQVrgx1+CI8r1qNTbfa3K1Vzu1/o8CgTFKzZ/kWCuajlodqF+o4dN2vtosK82lIwmC6M5UAZxUgaG6/zZbZEHzDo6LB6v2n/Z8B2S6olOGAUIUUnGw7F0cEdRxBmDhqt
X-Gm-Message-State: AOJu0YyAxIu0gIztOQdi5x4tKNEfBS4VedmcdJI8KHEDr8/JPrub2P1W
	TaoiQ4yRN48Cd6EWYNpdgjxgyUUyZAkjouoOpZrCDDKKatuv4CV8
X-Google-Smtp-Source: AGHT+IF1nYDfi4kUMdMPKte9fw+UfwhCCfql8Q9Sz16z3yWy1yf0BeeKwkONyjVHSR28hmQ0vzd/xQ==
X-Received: by 2002:a5d:6e10:0:b0:360:728d:8439 with SMTP id ffacd0b85a97d-3607a4c864fmr3011348f8f.2.1718378333023;
        Fri, 14 Jun 2024 08:18:53 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360751037absm4606529f8f.91.2024.06.14.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:18:52 -0700 (PDT)
Message-ID: <c1b4fa5da3a28cc3c1eef1701015a8f21231cf17.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] iio: adc: use
 devm_regulator_get_enable_read_voltage round 1
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 17:18:52 +0200
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: 
	<20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 16:03 -0500, David Lechner wrote:
> Following up from [1], this is the first round of patches to convert the
> ADC drivers to use devm_regulator_get_enable_read_voltage().
>=20
> Some of these are trivial but some aren't so I'm breaking them up into
> smaller series to spread out the review load (and my work load).
>=20
> [1]:
> https://lore.kernel.org/linux-iio/20240429-regulator-get-enable-get-votla=
ge-v2-0-b1f11ab766c1@baylibre.com
>=20
> ---

Just two things that look like typos... With that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



