Return-Path: <linux-iio+bounces-6726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A214D9135DD
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 21:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564C71F22CC3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 19:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8184597B;
	Sat, 22 Jun 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtEgjDXg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90021373;
	Sat, 22 Jun 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719085344; cv=none; b=ZJI/A5lettJ9PzY2fbBySP2vY/wfyTlaJGL9MDXw86FgkJ982vF8C63YwjbOaAyNnm72rwt17Ed95vJoawsGSXSedu8OzOOiRWqot3E+aLUoOI4J5IVjv+bv0viDs+bwJGpUwL00iX4Fd17DcdGEIkh6/pslbApJ21q7mPmmoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719085344; c=relaxed/simple;
	bh=fcJbsy2jm25GAUnNM9Xcuj1AU2NBoRKuw3UTI9/38rM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZwAbnok4ilpWpguMdUmJIjQr/WV6lsb/JVQwFcKd/+cOAzw+hmfD/4TPFCmTmF33KxdsLm3HUh3Djx6R/pRCfLGlx+UER6GzaDc3SwATo4V6JaydnnPniD2tD8zgCQc/DGfCmo/X5+4F+GD1na/uNmtBL6beptGsvRxGimY82HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtEgjDXg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so33864161fa.3;
        Sat, 22 Jun 2024 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719085341; x=1719690141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fcJbsy2jm25GAUnNM9Xcuj1AU2NBoRKuw3UTI9/38rM=;
        b=YtEgjDXgiJPKd4pDD6WwK3RizpTb+cdWAfSBUBYlYx7JlGih3jVO1UNj4EBfxIXQmt
         GVXaX36jsGtUTP53jDuM9eQdW9CwOmGktIgzTrWTd3vjN2RLl9940gI7p063oAnEJJ30
         RBSamPTpVumtQ/TF/G0RfZ3sEilmZsP7nYqGBKpOdIxcEocXVDOdkg0vQAaQc1N9xe+U
         LrQtoiei0WDTM1AYTgY3+sd/dDk6+4yiT8FpGi1V3HBHkA9aihMxc4uun0KwtFjzAqrU
         wqWT/Wy8kOYXmdf67BAAbtL0AC8LjX9XbGXBPSomWn9nF4I3pW7uaMaQlheY8AC/lD0G
         b57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719085341; x=1719690141;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcJbsy2jm25GAUnNM9Xcuj1AU2NBoRKuw3UTI9/38rM=;
        b=Hdy+45GT22Tydamsy+JUx3y3qW9ws1aX3zRmlMGVfwJjkg++v66sTMxEU2pozfDg+1
         ahKWkKAieX1Qce9tQXG78RitZdjGtrmZ83QN+DYrkla8dOz15Y0SpMj+GVtPYy012Q+E
         76QmZkaOFdkmR/9IAQKqrFmPdHIGpBO2EmCdcneWT9wufV/x4WCrE9EhQHNDymy6evbb
         7qzTI1N66YOYr4dt7iotaaQwb4g8vndT3gNDjVzyM9DHlNL25B/vwpOuLm7xWTjNhjY2
         VCVM3mNT6Iuk36tFC5muAod3X5rfx0Uvga1d7QwqBtnNTuOsYmJk3EMmqmWBVuClkfjo
         L5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV+lI0SMh1iKGiznvqxdlkAilycPIubSlECmiS0JQzwfKZ3pJDWRcw2qgsslx9x9zdA2c2DcvByLQCAzmGRu8iRDdbg+xPinFUVJYqafkexQXaAKulXV/coagZTr4A2JNWwLcu8EAloQseUbCGHSOidYPvnWbzXAeR/FOC16p0w
X-Gm-Message-State: AOJu0Yy7IFWu7o6dGW+1juazMn9jMHxBvfhUx2f+wWb/tsg0FZD8RTSP
	mjhiNkyAMZFvz4zngXSI2cCcM1R+gdItfzn8XjDBI5F44Zg8gb5jdMFBYxFOKpmlpzmqTvXtEPJ
	QTz2n6PRl5B83JP4o2tRutkMD+Fo=
X-Google-Smtp-Source: AGHT+IHzsJQQOfin1lQogznzEbzzUuyUAsOIZxSoPdvWF+xwgTub0+dgEi+j5N2GsC7SCJXZSGwdHtVAkmpj8apv+OE=
X-Received: by 2002:a2e:8250:0:b0:2ec:eee:f19e with SMTP id
 38308e7fff4ca-2ec5b3888a8mr3097551fa.37.1719085340800; Sat, 22 Jun 2024
 12:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Philippe Simons <simons.philippe@gmail.com>
Date: Sat, 22 Jun 2024 21:42:09 +0200
Message-ID: <CADomA4-TnSKthXDKA6f=o29he+Mt-ZxAcyTHkPRD3MVVkDBCKA@mail.gmail.com>
Subject: Re: [PATCH 6/8] power: supply: axp20x_usb_power: Add support for AXP717
To: macroalpha82@gmail.com
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	jernej.skrabec@gmail.com, krzk+dt@kernel.org, lars@metafoo.de, lee@kernel.org, 
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, macromorgan@hotmail.com, robh@kernel.org, 
	samuel@sholland.org, sre@kernel.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

sysfs correctly reports presence of USB power and voltages, tested on
RG35XX-H (H700)

Tested-by: Philippe Simons <simons.philippe@gmail.com>

