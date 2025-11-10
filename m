Return-Path: <linux-iio+bounces-26150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A955C482AC
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86A234F8DD0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119732573D;
	Mon, 10 Nov 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV3j4stb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8541313E06
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793135; cv=none; b=fde0DzO2Gh92rc1UvpMd4uIcr+z7d+jYGWDakWojIpkfn9T1/rrcz17SSRpg0RUrm29FZb7y5NdiPYrsqVQDIsj8FhSjp1V3RKhjnq5EPv+5NXt4tKlvohogtcfeHrnkUG44GaECPkHiP9POyPziYSouRMFLX9Zh0yXz4BIR9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793135; c=relaxed/simple;
	bh=bgCzKrhzMsbjtyucE9Wji1o3OOtYybWdKrlZ1ecTWTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUOU6+69ars5elKd2KG5soF8QDU+tn5vGxvw1jZAE9LYdaROVTEZUQv+mgMYo/lQ0y8TePwQPy54sE664pyXsUdb3W60atNfv33gtZaWaXCJv1qso8WINZACt11cNmqtLCmpdz8b3myr8bV1F/c4chkXYnfy1kx8o3IMPrVzZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV3j4stb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b593def09e3so2011134a12.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793133; x=1763397933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejgzWIAmMtwDeIAONVbXRMu0MknYB8VkcpRxQd2rWvU=;
        b=nV3j4stbm+vcaGq0c5YHStIInJnhL8I54TPjZHDp6q0rY3KJdBeU2LdLBV+A8PMLNd
         3UDAcZroJ2/4u1ohtPKCixAdo5DMgRp2pTa42z705lK6Wh1wbqoz5w7yKpZlwP+YwK1d
         FXnwb72f4hCaWLFToIN26L5qlwRTbbqvPDgUPiPgNFY9ZFeg4nRg10UdtOeHyebrPBLV
         hW8pIVyoJkAu/yL6AeYS3+gn9fIGyx3klbslQG0NE+ySA5owcPBHKAMKkJ6LUUbPA7hq
         jyAh0y2ElV8g7ZXuLNUfRXPtZ5ThaRkUiYl0HTwaUGr+FTOUYjQdjLUJhmRyo5hoaOms
         P+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793133; x=1763397933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejgzWIAmMtwDeIAONVbXRMu0MknYB8VkcpRxQd2rWvU=;
        b=Zimrpx3XyiO+ju9++rxRMvWM5DGt1JHMly5qwmW7k/eaqoA0OwZkxXetAK5fY0JF0n
         vV5TXcxdHHe4UIs2qsEXOUsXy7gif40db9r8aNHjLMRvdDN+1kMATtbNNbItkZIlcCwW
         KBqUM7ZD5OfV/xCLySR53jciEuYyqI7OFa1rxy7gBVqFiGMnyUOgyQtEAIK88Utx6JQx
         9dBHWEswAHy8BUs1axRQHG+eOZNXgXtrqlWS/7Ap1wdlC3P2X7bXSlC+BnERmSisMiER
         rFCbNTBwJ4tHtkC4JcC09yEvBLvUclXiM0c818LkaDQ55bQ/VD5EZU0C3DlNsDnMrKX4
         BNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0F03jr2gjbWZ7FusnzuHpX4bocBM0urXxgbJoZgHc8/oIl4CIf120JRB3JelmPhB+L0SvYbbRJVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rMxQEbkwJgEK1eQo+hhafo31JCbsykoWA1MRlvlu28jbWovH
	BpJ03czkkABZuUYRd22YypKrGlGNyIt7SvJ1KQNtEtE0oD+QJRFlbhg4
X-Gm-Gg: ASbGnctYQ1jlhgyf3s48Rol0+aPNXeU3JWBodedlEisLnQs71SuZ75mBXicfCQqD59w
	agcWbdIkKJHpNnwiaBYJ5duKGM4r2Yqiw230XcM2ySGj0OXKWzAVDClIOACqmwuO/a/hYaw1KFc
	kWHGxpOO+bw+E9oSVRXACeUAhdpbXX5U+Mgt24VTwn3a+SKh3yUjBsII1qqXwk/FomSp5ItVs2f
	3gvPwvHY5k3YV1tOHbtz63OS4kngi/Ix31RK4VhE5r3wjur+dUQIp7q3FQt/dfzdWTyQC9909Bg
	hjjrY9admFsIg/MDk4oFEVD0yUR0ocSyPGmLK28h+eF9+ESY+ZaBEGjhT6IkwuYbcnsAnSO+gFX
	R/RTlsoicmreCHysu0wvZQ8Lkm/0TWG5YTPvIxKA7l5rWDnt29tsG4CTKRSd/JSbc+Q/2ALk0FJ
	+1qp6GDZdmKQ==
X-Google-Smtp-Source: AGHT+IHlDbq/FuhUx5b37jOHHuGk+B4j8Ue7lQztTGR+qjnK+j0oCN6+BEjfuAMoSyUWo5a31EZ/jA==
X-Received: by 2002:a17:902:da4b:b0:295:24d7:3792 with SMTP id d9443c01a7336-297e54030a4mr120060845ad.1.1762793133088;
        Mon, 10 Nov 2025 08:45:33 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29651c7409esm150687835ad.64.2025.11.10.08.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:45:32 -0800 (PST)
Date: Mon, 10 Nov 2025 13:46:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, cosmin.tanislav@analog.com
Subject: Re: [PATCH v1 0/3] iio: adc: Add AD4134 minimum I/O support
Message-ID: <aRIW-tksre10iB1v@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <5e0ea52e6a77a1d6af861ba5aaeeea5c3d514705.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e0ea52e6a77a1d6af861ba5aaeeea5c3d514705.camel@gmail.com>

Hi Nuno,

On 11/10, Nuno Sá wrote:
> On Mon, 2025-11-10 at 09:44 -0300, Marcelo Schmitt wrote:
> > This patch series adds basic support for ad4134. AD4134 is a very flexible
> > device that can be configured in many different ways. This series aims to
> > support the simplest way of interfacing with AD4134 which is called minimum I/O
> > mode in data sheet. This is essentially usual SPI with the addition of an ODR
> > (Output Data Rate) GPIO which functions as conversion start signal in minimum
> > I/O mode. The CS pin may be connected to a host controller CS pin or grounded.
> > 
> > This set provides just one feature:
> > - Single-shot ADC sample read.
> > 
> > [PATCH 1] Device tree documentation for AD4134.
> > [PATCH 2] IIO Linux driver for AD4134.
> > [PATCH 3] Initial IIO documentation.
> > 
> > There is a driver by Cosmin on ADI Linux tree that supports AD4134 in wiring
> > configurations suited for high speed data transfers. Even though the minimum I/O
> > support was initialy based on that high speed transfer driver, the result ended
> > up becoming entirely different. Also, because the different wiring
> > configurations are likely going to use different resources and software
> > interfaces, the code for AD4134 support was split into ad4134-spi.c,
> > ad4134-common.h, and ad4134-common.c.
> 
> I'm familiar with the odd way this part is implemented in ADI tree :). Question is, are
> you intending to support the high speed bits? I guess so, otherwise having the above split
> would not make much sense.
> 
Yes, the intent is that the common parts may be reusable by the high speed
driver when we get to upstream that. For now, this only supports conventional SPI.
We may, at least, get some support for AD4134, though.

