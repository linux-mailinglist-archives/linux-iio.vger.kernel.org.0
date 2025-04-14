Return-Path: <linux-iio+bounces-18077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7EA8801C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA3C3A7EE8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034C29DB7F;
	Mon, 14 Apr 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtm/BFNm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290225A2AB;
	Mon, 14 Apr 2025 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632727; cv=none; b=BXaCxdydxA+YLrGhoMyKBT0gwOE+I/VKZSL4olVTH99NC983r4ty9Zi38GyVKG4v1nWib611T6ZC0f5bKpx+eJy5HG9JGNH7+g4d9jHn2zKfy8zIQId+NkqCsvAYpQreY4zmlqUePV9Xe7uWJiuDczJ6zzBucgv0OQJpozznGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632727; c=relaxed/simple;
	bh=7HiWJUY7k3PBjq+nyjLuTF5RMOFecFY79b69z1xvKkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+grnK+mkZq1TGw11A5mILG/IakKQLtFG+NsHeaL+TwlaQJyOcsZdJChupH5CsLTxB4O0TFHXlqczx9RGZBFREkCbYlEpa8CDmy1U6FtpbgJjeVJ7iExCX7Bc8BCc4FIhFoUCyakGQFXxkdg1aHgWU40POh+cLQyORc1u0gV7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xtm/BFNm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7370a2d1981so3154516b3a.2;
        Mon, 14 Apr 2025 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744632725; x=1745237525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NVHglvUlYKOGcz6TwIpfPLcwNgLnD8HxMiutrlB7jI=;
        b=Xtm/BFNmvXWSVuDNPf9Cg7W6Q4O1UQ7/0j0YGLAWQK3OgFrExazip+KiK19Uh6GGS+
         MGWAsR/5hfUZSW9VLRxH+oB1PYn+wZxK//ZQGU2nKvLOvQcPWYPUdydRk2GuuK38KFIq
         yb8DPluhltxHyDAI/zUtPQl/3hZKRQoz9loLDS8QaUJtE9K51JmVDp2W96LLNP3VUHWV
         v7qYANzNUsLwb1jvKf/pKoMQVGWLg5Y3kSRlSk9jWO/mGAKszkfMxK4gXOAhsxHe9RI0
         26BJQWkpoyP9tUKCAOaE41pBwh5YSgWitz3hYhW2sSV88oLvUjgmgow9RLI1UfvpGgOV
         t8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744632725; x=1745237525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NVHglvUlYKOGcz6TwIpfPLcwNgLnD8HxMiutrlB7jI=;
        b=WbLAmXswXX5ylfGHPTug6OkWXs8Hf1qlyLTo+4OHO6EdCKgzO4WYSAwwH7N0xAOS6A
         krDDFA9mgLN+9wpDQLr8SUErM9QZ27BYqT84jpLmNtMP8vaLZJqzC+UFHkVuhEXk2mRo
         uooknkVv80/308DIaIaycJVVr3nlxmrAh1pqE5CQHxS1ldlOx2TSnHZhkGtzxG/7c23W
         R+GVaQaHMOgTd6Wz9B9WBaOYSbyPuDbDm4coCZ2mNuqsZZ0U5tiFrLhddHmYuYlPmk+C
         DeXSNhCMJV3WBfICWAhZDsjNt2wuONw1ogSJijZ5kUZS56AAjWdtTM471WxTniHoo39N
         2Irg==
X-Forwarded-Encrypted: i=1; AJvYcCUA5b+nOTor7wjPydz4Fu8Ne8uAiuilvbTsVJzjZcn/cpITNivI5ObcwuB0DdwlEgO6BjeUWmKJoD5q@vger.kernel.org, AJvYcCUVeULhvQbTID3ZHwhmzuqCOW5v3Gfgbk1JTfo93Rttje3HWiMh5ctP7PXVBmDlFbLFQ84JVup/W+XvHYKC@vger.kernel.org, AJvYcCVXIYJZNjs0cLN9RO428DmK9AXhmSndG/Gw2pDhS/GwMvA6coHH9DRr+vAydgx+h6X00cUASdrPxp0C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+flAXPamKdGYpD8Y21wdfasVjOcmjwUvbIFD2ZJkkVBTG2Se1
	I/c++UYkWKfT08NA1PdPf9MNqhvbX7a1Ki2K4tgu3AxfphGc4NBdj0xWz/25jzo=
X-Gm-Gg: ASbGncu7xxzu7iGlBbVqCJ+zxiEWddWgBDlLUTfyY5WMlb7PL20RM14rkgqvQXZXBjI
	UM+zoQKyBIy0dtikOQWPHZATmVr9ux0uWZQXkXgCNbpmxN32mXQrvJvf6XuzZNG93gFczp6HKjA
	pBLE8h93FtilWeO+kCuYy5IUPkppkwL4R3yt8Sj8hiPARkJ6BjX12/OlMkXr8MRuwAl7++gNT+e
	Rxo4CDZovJZ85Vu82W+BUNKWvtg1Lqk98QGD2fUi+G3m1qA1dze/ROfDjIY0aIBzqGL1fZwyVqh
	lS8q2jcxC4FNjKOKwaNFMUmcpKve6UU5I6Z53EXpVRSkdt7d
X-Google-Smtp-Source: AGHT+IF+TIVrbFGinU7ywTDvjK5W6y83fY1DKIZT07Xcs1cZRpqvJc3wIS0iwg8lLbaz6rT1AlurdQ==
X-Received: by 2002:a05:6a20:d49a:b0:1ee:dd60:194f with SMTP id adf61e73a8af0-201799683ecmr16377045637.26.1744632724786;
        Mon, 14 Apr 2025 05:12:04 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b06161333a8sm4331209a12.7.2025.04.14.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:12:03 -0700 (PDT)
Date: Mon, 14 Apr 2025 09:13:12 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
Message-ID: <Z_z72J_gcZqW14CE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
 <20250412174710.33afb04d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412174710.33afb04d@jic23-huawei>

Hi Jonathan,

Thank you for reviewing this set.
Clarifying some bits inline. Will apply all other suggested changes.

Thanks,
Marcelo

On 04/12, Jonathan Cameron wrote:
> On Wed, 9 Apr 2025 09:24:35 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > 
> > Add support for the AD4170 ADC with the following features:
> > - Single-shot read.
> > - Analog front end PGA configuration.
> > - Digital filter and sampling frequency configuration.
> > - Calibration gain and offset configuration.
> > - Differential and pseudo-differential input configuration.
> > 
> > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Hi.
> 
> Clearly this is a massive driver, even with it broken up like this.
> So it might take a few cycles to review enough that we don't find
> new things :(

No worries. Yeah, I tried my best to make it concise but this is still not small
piece of code.

> 
> I can't think of a good way to split it up further though
> 
> Jonathan
> 
> > diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> > new file mode 100644
> > index 000000000000..0d24286ac2ab
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4170.c
> 
> 
...
> > +static int ad4170_regulator_setup(struct ad4170_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	int ret;
> > +
> > +	/* Required regulators */
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to get AVDD voltage.\n");
> > +
> > +	st->vrefs_uv[AD4170_AVDD_SUP] = ret;
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "iovdd");
> 
> If no channel uses this reference is it not optional?  Maybe not worth the
> complexity of handling that.  We have sometime bothered to do so in the past
> by first figuring out which references are in use, then trying to get the
> appropriate regulators with small changes for cases like this where
> it needs to be enabled but we might not need the voltage.

We can set the channel multiplexer to use IOVDD reference as diff chan negative
input. Similar thing can be done for the other reference supplies. I think
the examples in dt-binding don't use IOVDD but they could. Since the driver is
supporting other regulators, maybe support IOVDD too?

> 
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to get IOVDD voltage.\n");
> > +
> > +	st->vrefs_uv[AD4170_IOVDD_SUP] = ret;
> > +
> > +	/* Optional regulators */
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "avss");
> > +	if (ret < 0 && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "Failed to get AVSS voltage.\n");
> > +

