Return-Path: <linux-iio+bounces-6584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A390EB49
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06859B20E81
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F2143732;
	Wed, 19 Jun 2024 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG3eQ6BY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954D1422A2;
	Wed, 19 Jun 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800865; cv=none; b=ZQu4C16zvCqnCDdCtGD2gfh74zKzj5NnuNjTnwPvn1W9nmVJGoP2lQ1zF6EiEk9bJgzMS8BVt81HogTx/Oy9PRXPkLpL6ExUjHQ6TUoWzGGZkJH/iyIFIDlTIaCT1AEg6Hteas9rqDKAeaU25z2Z+snA81SKnSkgxyBLzQdOzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800865; c=relaxed/simple;
	bh=ZLR4ItRSx4Bq+UI+mYmBlhJU0ucpXeC2/0LTg0av+8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZE1ZrwVV3c7Lq6SAu+oHxg5iTZ7G6om4+pMi2ns7CbV8hfRrlrOKE8JJDaXwK7dTtCdJx0QZv1W/NsuXqYXHX2fnGDxWolWZ52hSa4gtn8k7ceXkyJuj1iZ1kGRejB30TPd/r5Xmq+XdjDqlzbF7Sy+7jll9on3Z1GBNmvBff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QG3eQ6BY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-705c0115192so5490480b3a.1;
        Wed, 19 Jun 2024 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718800863; x=1719405663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3XO1HINgwUSLig8t8S+HnKynBtNEYSjal53hZWoJ2o=;
        b=QG3eQ6BYJFXoARuv/TW63Zy1NBzsmFE0/tzDdJge8c3CYkoCCGot8BCcW8QQe96Y90
         Ns2I+0oWvcO4kqmdltgHAgmatnpRqwxtiLZmnv4n0OHbXu5tbuHhhcNWMYjTdCgVxGHJ
         xNko4Ba0MIEXCZsGIwqcDkB36zFjCNIx9EbxGsDqa5L6rCIBNYO6cFxNosy47KI9ciT1
         9UPmDi8iTdMX8Wn22IwGRw4dH1c4BhhIOE84aVuENeaNOL3HUfHH3Mb8IWXfTDe1Tpwk
         lWXVGJdL/ZwZFHRD8fjosEnclaxpF3PoXcqQdMhC+2Nf9lS4/S28cxaIVZx75KYoMtRg
         DhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718800863; x=1719405663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3XO1HINgwUSLig8t8S+HnKynBtNEYSjal53hZWoJ2o=;
        b=qT2JDvHetnz8eT//70cC0w/+vPEFx8bNenl1NY6Miuv9hOrbTRtCmjWnAKhc5JdZpD
         MEtJ2nTkoQtaE9C4GF9l2uMILSpR1TqA5ht6ru8nzCRmNfkEjreAYexfmJy01OFcfRIu
         4CM4XzqNTI8uJgjJKqUPwd8rqj6e8MAt1bIZYntVaiL5BWtLO3MWrMFqzWEOsuFWIlm8
         sxL7Sw4z6KPkcMVVb3A5hJ2VGLUMLuloYgMQvHmaoc/TkubPAhYQA+a0MWO5c1zxH09c
         vDkuUYxmkyC4+9dtxZLdqHkodhjdYO+38YvSLEVo/tUpmTxTABKnemGg5OXb3d3JqhVk
         GKfg==
X-Forwarded-Encrypted: i=1; AJvYcCX4bH8Qy++0JXZqmngvEH6KebYVAQNmUgya0Ce51he3uQTArxwV0uA6GtORbtJI17lP0jLiV6nSFy8TcTpLUcCqZo2OClQjNv12WnXvtgoYIMSVeP/GI4ZtWkGCUfE4RpJmxTfvnHzyZujwtZta12R2m81c4Dnyllr6gWDzOZfoS0nGmosVYdUAJ81nvKPJi+KB/8ZvX6YPT0lzAV2CTg==
X-Gm-Message-State: AOJu0YxnH9W4aGtk3n2PLUF3JB5rtnC2oPDQgvtKmTN32ohX6pms/r2f
	TBjmogNL/fUjqY99Ai5ue1S0+ABj2zqcwVWmjWmwiAORoEGzOBnF
X-Google-Smtp-Source: AGHT+IH9YsQDk1R6XvQhoqiaiUmj84s3aq3mt70rwskC5i+d+qxMEDAF2qzDAcjHcctzetfj2GQmhA==
X-Received: by 2002:a05:6a00:23c7:b0:705:9526:3c0d with SMTP id d2e1a72fcca58-70629c32428mr3363035b3a.12.1718800862815;
        Wed, 19 Jun 2024 05:41:02 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6af5csm10593108b3a.162.2024.06.19.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:41:01 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:42:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <ZnLSL6wvyhGAVyUz@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <5f89baeb-c95a-4ad9-adc7-769fb124c0d4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f89baeb-c95a-4ad9-adc7-769fb124c0d4@sirena.org.uk>

On 06/19, Mark Brown wrote:
> On Tue, Jun 18, 2024 at 08:10:44PM -0300, Marcelo Schmitt wrote:
> 
> > First replies to v3 brought the idea of having a feature detection mechanism.
> > I didn't really get how to do that. If feature detection is required, can
> > somebody please provide some pointers on how to implement that?
> 
> Look at the checks in spi_setup() for bad_bits.  

Yes, I added MOSI idle configuration bits to bad_bits so spi_setup() fails
if the feature is requested but not supported:

	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
				 SPI_NO_TX | SPI_NO_RX | SPI_MOSI_IDLE_LOW |
				 SPI_MOSI_IDLE_HIGH);

am I still missing anything?

Thanks,
Marcelo

