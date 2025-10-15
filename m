Return-Path: <linux-iio+bounces-25114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7ABE099B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AC41889594
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB786259C92;
	Wed, 15 Oct 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTH4KOa/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9F3254BF
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559340; cv=none; b=cpbEzdEQ/wr9M/OVnRXn/80zFKbops5KWtevwvHOogKV/5dv+wX/vbCHrp/igskGZLtOfjQSZ5m28c/BOCsTSUCBapYvv8tFOUmdMPj1DpqD2KkIDZMxCkC8hgI49E/BJYO6Qlp+/hD3tUJ2pifYFY3tcbyiMpIw9UMU+7ZgNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559340; c=relaxed/simple;
	bh=f33sC8KOhgzfcrNG4Qj/bQ/QmwkdFKt6EmZ5R4Q0M7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+MI0wDwa//fFrkQPNijJvsGCsAAfSeWWf0GwZ7MM//Ghp/NqwUOxSzmKPr69gDD5K5p/rrVxjuM8Rt2+LjOfvAM2CvpG3qlN5aeKICyZLQqV/zPWJWl5qKchiYQWa7vzItLS6KHerLr3+UtiWfPb2RDdPePj4VLfA4sXqzgsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTH4KOa/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7841da939deso19941b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559338; x=1761164138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElqsTIdctQn66pT7wW61kkU/IWdghkzXe7gYLEQptw4=;
        b=DTH4KOa/DDFU/TgfmAH/4o59rAphEnx4hT5pApdwkRRY7B9o6o2249n/mIPaFYUXcU
         Dzi6AGfiOjpqTd4KrR58gIGnZ268Rjz0afQc8yiiEUsPlnTqfJYzDeI2Nim2Zgg1qaiD
         TYoQ/gwN4ytgryo8wm/RvKuiX89sNUx3OHjZmCmoGqXT41LQHjhXDRhX/5aGn4unmssa
         1YjiZ93kWF6H6EQwaBKXf4FYBKlfcI2PQKueTVBlyyDbWLO1Bo8lfL6mpB7jIYcq+Vc+
         s340WzUheOWfxVIQKsJirYDKHGer9HqxCrEjBIXzgBhEpZvB7ni3vGyghIlpNgz1gNKQ
         Zgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559338; x=1761164138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElqsTIdctQn66pT7wW61kkU/IWdghkzXe7gYLEQptw4=;
        b=ZrcvLiv7jzpbYUCnBA6p2A9PGTGyZZjIv88hNVpjWzL01BpfCYo6YPo05ccJ29SS0D
         AY8df5lKiAryofJcaikzeTMsDH+0suCAFLjQ/QDjbs9ve1KbxG1AgchRo6z4rbgb7gRn
         qeRn2xFphOnRqtcvzODXfpSPwgdB9c36HRmRNiDB5S91QhYHEd1Cq5Gp989EySU5FV8d
         ia8UZ6NaqAQhw4EPleNFpG/opNJzwBIpmXt5eBq40KnWgGZJ7kqytLQq4ByB2xt1nmur
         +Uu+NuTBxm+5WYU1OLduy5N9Zdr9ghXmvQscv7shG3M8+2i+1CNl6KyFGZia5mhmcxtw
         wcaw==
X-Forwarded-Encrypted: i=1; AJvYcCV5nLI/9TnZfManr0Ef3fBGT4y704Ew5Gmb7L9e4iqw/mEcfVckClZ8WLq9V8+vO+raPGwi+35lTu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxss6lk+QKLkRpqMur04S/YKzk6yeax3OtgaDVYC8NPWvzg3uxp
	aQOHQEmMLbA4sR5flJmBtYRRDblQpefY2a+ZPyStgpgT/o0gZa2vc+ls
X-Gm-Gg: ASbGnctsl7GcSnrMZaCyVjen0DfvRgQPkPhGl47RBJmA1HzlrpEml3JtQ8dpGxOg49K
	LxRNV86xPy+4pvyVmQ8fKHtahYCvqq8As3TK+RGPNL2r73JJmowFAS/P7Nz8gtO/19k1hZf1Mr7
	S6X8+RxOz9Iw3NFpSFq0WmZtmFpbbet5thcgiPxujaHTHLi48p/tG9APmWsW39qLm/Hs/hqzEOH
	WP0iMjLPx5/GTUxSVj1qGncyUVZg+TxPq2IQKRGUw7pB7PhQm91vWF2qOAwZIOBaL57LM74UgnQ
	NMdkj7ssd6ywMmZZPZwd7phUbtdgXHREHmxDJLenyudXZJvLTHhwF2QrLq7TN4GSTXNA5fGyTWt
	JaOGtheIW30CWzYO+liooHH+eH5q78AhmfbXbaC96/IFvrKMBA1dSiFJc/c5/ggs07VTtGgz381
	zHjyn9NeBGOvUuDBvKyor+
X-Google-Smtp-Source: AGHT+IG4uNV20f7gDW9o0Gz7678vJFvvBZRhbd7tYd24sy95B2AzjYbBxmFfDzt3FdOHxVCYDasAlA==
X-Received: by 2002:a05:6a00:4b8b:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-79afd01f231mr16240519b3a.6.1760559338302;
        Wed, 15 Oct 2025 13:15:38 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992b06075fsm20183211b3a.17.2025.10.15.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:15:36 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:16:40 -0300
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
Subject: Re: [PATCH 2/6] spi: Support multi-bus controllers
Message-ID: <aPABKMoIbpMhOzxt@debian-BULLSEYE-live-builder-AMD64>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>

On 10/14, David Lechner wrote:
> Add support for SPI controllers with multiple physical SPI data buses.
> (A data bus in this context means lines connected to a serializer, so a
> controller with two data buses would have two serializers in a single
> controller).
> 
> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
> 
> To indicate support, a controller just needs to set ctlr->num_data_bus
> to something greater than 1. Peripherals indicate which bus they are
> connected to via device tree (ACPI support can be added if needed).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
LGTM

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

