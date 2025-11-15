Return-Path: <linux-iio+bounces-26234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D307C60742
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055EB3BCB5E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08692FC029;
	Sat, 15 Nov 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG3jtSVL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7F2877F7
	for <linux-iio@vger.kernel.org>; Sat, 15 Nov 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763216191; cv=none; b=uAR5HgpvgN0DfwbgSASIr6RvfQH9/nxIf55X5cVYf4zo1XGFqN/pN3FCBIB8D6O5KdS5DPdYO6cEuwao/UCbDO4QNq32Swm7V5Pm/sSLVy560ext4Tdj1vlOHJ9gtAx6jKPlnANtdMvZ9IkYMQUIdOtswD69wdgV95L++tq58cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763216191; c=relaxed/simple;
	bh=lQDMn33BZA4A6/Iz+tzzcStrq+yIE8dCfga/dGLU5pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxWtVmWPMBj37yLbdugttEPUqxB0ujklm/tW0h6X03Q89KMoBIwcXA0tVOyu0l05fE5u6bMtpltW+t16ONA5Gmm5nDzKARdSXZEcWRFYE9qkvHvIBu4Sl+cubW41R6tMwzzcMKAMR6q0/7K1M1c+TI4r+J9O7jP2+rftKpgVD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG3jtSVL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc0d7255434so1754709a12.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Nov 2025 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763216189; x=1763820989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+fpNKU67bQPKNnLnZxW1QMryMXbqH3Y66bi/S1gzo4=;
        b=bG3jtSVLIOzCP3ri06v/F0WfTRMrhGtjp7Zmus+VjsqvPIEKUGbpT2PznRsq5rJLVB
         wnQndURAPMksO9is7j3Q0HRrota1quKir5K6C7fKWisj97UGy/kl+IKWKQT6tb9KlUwu
         rPBiXC47wCDh4LtU+l1d6EgBIYO/kalGcsE8ws/CPSorYiGMRiKl3MfbkwY7R8IlQMJK
         eo3OOBZA+KvFjmIolgsdZS0DLl+RrTdWZ/AstZnMiKCJmN0J3vNBd7yGCF6Tjk2YyjK6
         6BsEn1ybO42kdxfNSNOYdW2SM4F+TMoWBkH9QbICIt78LCPSrk0BM7jXEFWlKpSTRPmK
         hJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763216189; x=1763820989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+fpNKU67bQPKNnLnZxW1QMryMXbqH3Y66bi/S1gzo4=;
        b=Dx7E1ntGycCJZijkqBYfS0QZhZtPXkBTaUeoqCy1Lmtu8WIEL/GA6JFSS8n8lRQ53q
         EftdF0mMKyplQv0p9WhXhNdHGgJZwM4U77uMK1Vm6IZV1VLZ2ndYF0WzzMxPhvNzUBKv
         Ez6xgXyFrkJexCS/WQQAbUiEpXmMqtcK4wn5lX8OFvlvDQqafqIjxe5hDI99+NCmA5fj
         nSTersKNu0S0Fpsudsh6nbvSbLQ2w5qzlrESfPddAP09lhQs/l7h8zUErAtGc3XN8/PW
         RdxvBZXwMXK+I2brdyHGfQ8SP0SjneEGUXErEVwof3K7NJI6Iz7Iv+TV77tfO1NGXJ2f
         W3gw==
X-Forwarded-Encrypted: i=1; AJvYcCUlqp4EPyXPqUbO89H5oy9r2RDFu+MiHEjmbQsRj3IslEfAMn4AEDPGGJYtBPoO6bnR0CXRob6WV8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXHFabGyF+abwlxvySIFnVhgeXyh6sp2z6oL9ccKogERj8urq
	4jJq9B/RbsDM4UghDB0BW500yj2XBP4CruGsCeKFWqeYO/hua54kuO25
X-Gm-Gg: ASbGncs4iVShZqekQ+Jvbborq3motw7a2JKNuA5t8OBcjwug+MRXfmV7ePRrOrUE7LM
	DlTo3yaZvHVw8uYkR5cM/Zve72y2bPwnEqQLD//Wn5jVE43h6ngPJwO1EJOh9kEpyCC/hVoZKyH
	42zHWbzFM6/Dv7K0by5LCAdXMUrr9oUaQvNTTm3mquISonGKzU443qG4AQimpwOW3Dcgr61r0+F
	ULq01DYciJFY8oH87fFLeRzl91hgZHIOe8bXVd/3lwEmxkIDJZ39NF1pTXzLgZsfU327zYUKcRw
	htPtfseGc5PyyZ4IP63SBqjd08b3UdQEh8fnbHt8ynh3YqeXXQdrVreNeNiNt1M9RMEQaktROjL
	/kff2oGQZUAxfb5b1hsmABaTSk4d/98Zu1IXpMmIi8BOMOPRPkrXsQEev4AsWFx9nZnENGxRR62
	fGdakvGHHDhdl5FBXS6TZy
X-Google-Smtp-Source: AGHT+IFt5UfNZZzCWoZkNCgT7H9T2i6L90DMNpbzvAx2Pg8fW7yyjEV9hJ62Kua4odWnEM6/XiVGpA==
X-Received: by 2002:a05:7301:150e:b0:2a4:5a7a:3a5c with SMTP id 5a478bee46e88-2a4abdd0b97mr2113431eec.26.1763216189264;
        Sat, 15 Nov 2025 06:16:29 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a49db102f5sm17940394eec.4.2025.11.15.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 06:16:28 -0800 (PST)
Date: Sat, 15 Nov 2025 11:17:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
Message-ID: <aRiLjGnPLteViM2K@debian-BULLSEYE-live-builder-AMD64>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-4-8a92693314d9@baylibre.com>

On 11/07, David Lechner wrote:
> Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
> 
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v2 changes:
> * Fixed off-by-one in SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK GENMASK
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

