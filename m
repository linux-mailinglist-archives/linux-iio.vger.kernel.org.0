Return-Path: <linux-iio+bounces-17797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3DA7F357
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 05:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51B27A467D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 03:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5480F22258E;
	Tue,  8 Apr 2025 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Gz7uaM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D891C6B4
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744084561; cv=none; b=c6y0zAEtAWNpbyeDeCjSuCb2WX0C1zHdcvSL4t4Z7TsGtjI72ALGLhZSaNwHHhz5PP1uuQi2nXYBgixHJWENFk/WGM6dYJdm2rPhrh584Qp3KWAklXY8RsnUI2d94ee0ABLUTp+M5BS4Z6/GSC/DAfLQGUoToTM5tkLkYJzSkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744084561; c=relaxed/simple;
	bh=dUQ4iEozUwLGmxPAdU9YDoIFXLE52i+JA9VUzsRYQCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM6fK6LFfqYssmxKDBuoSRzn/R/UwMfCT7WKvKiX6c+E76E9ORS9B0P3k8APRUPDat7+eH6I6q4tg7eyd9I1RKZD4CC4ocdZW8unFqblv6AyRFPrK/I4VrZJeqhyyahtSgqwREOoi+p6YWcl0BAmWKxKdTOEpkKmnBoeKevAkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Gz7uaM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403cbb47fso54341255ad.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 20:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744084559; x=1744689359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j64pIJMl6GEy7jZb1jrmNXHVNllP+VN84RnoM8VLZCM=;
        b=f8Gz7uaMTFnH3KjDU9dW2i5UWdvJ/Jjb42bzfYuLLj2VzEQophoF6GhjapGlD7uNgp
         BVVIaWa9/fwEt/HIK/XZb0bdIu56zAQwGVfGkilIlbm2jKXP2Xpj/KinmFQcyARN2LYe
         zeT5j49j1h+jmgQdKst6JZH6puw1ImWd+9VqYZlK+0oTbcXSc44lqfycgX221CzSFk0W
         eBUtumhZe3xD0g++ZWvMAcnDmUQeJJ5LymLskXGFc6Ttk72AF8uOYq61au6A4kJUg923
         bbpsusAR4zdt7voJ+NCd0vebna+8ZjTNrVbiztOZV/FM59fEkzRNUqX6sc21fO/avql7
         fN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744084559; x=1744689359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j64pIJMl6GEy7jZb1jrmNXHVNllP+VN84RnoM8VLZCM=;
        b=QSm4wtVEbaIFnE/FG766+FeYO0eDUDxp8WLuwXTqzmhSraiWPIs6q8goFGqQC8I5NG
         WZEqpCDjSzq5l+BQVms9OQdRx+S6ZHFuom6AypTSBjgbcmDFN/5P6nkFt15PXww9f1T6
         kN5VScVWENQDljdyFcxPW5ADjem2TyO9lhMjAOcvNVGClai00Iyt0kuJPGq7ldTrh4ks
         yEwBPMdVFcdAA9+HvNu9u+SlbWIU/hoxLGngif5eEQqIe8dvqhSFtsCU45FaIBAx3nRQ
         jdNgmJk2gGX1M8oWCvtKjS6yeP/PMWEEJiHjDonduyutMoggiCrNrUVDDx+JSPvJK/1P
         Mtng==
X-Forwarded-Encrypted: i=1; AJvYcCVHlpmNHMMDvAAOZv9X/UTLjjWJKUdvEv3CWeDK6GZMSZcmtird4eGUg6Q37tQdEHhjJuy9Dz1EN3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZhBDY8e/A0nUnZ5IMeU6aEAEjrEDRW/Gw+Ev7Pc8IKp37ZTO
	CQbN1wt00UYlErvQUS78s0EtiMHJ24bV2qa67kj+RnVZegiZhjjK
X-Gm-Gg: ASbGncuFBWxRzehK0KkJYatrfhutuQQvbW/FhTHdJ2M2caF2FAC1GoAnYaysse2EC/I
	vAVN1aPQZUKGmcCHx9LdnXAJVkT8cOnVQvr4QSxMGKrJ6XGIfiUsqeVwSW1mm59dnlANbCsN8u1
	9oByGdZl84MRDzJvbL6xMTDR8IoGK7SyUpGJfyb8h1oos7buToP0RGIeckI/gEuzLnKgdKYX6zH
	NTvT0fpvll70cPUZ92p+WWjVqWAYv4R0Lns8NAafISM/0ESiYx1I8X3yNL0TYCNtxFz+F2B6aen
	UEYvXS93v/HUfIUzYN6ii0HEq0RJk4Lsl6TxiVqChPeHVOLIRTt0lQ==
X-Google-Smtp-Source: AGHT+IFXU/8jkT8tLPOwJBlwoLSjGtTM57Miqpzz7Zjv0Dzym0l4NyFv/M6+ei91YCxF58AL0QA8ng==
X-Received: by 2002:a17:903:40d0:b0:224:826:279e with SMTP id d9443c01a7336-22a8a8dec24mr212937205ad.50.1744084558907;
        Mon, 07 Apr 2025 20:55:58 -0700 (PDT)
Received: from localhost ([2804:30c:1653:4a00:99b5:8824:2327:4943])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2297865dfefsm89576445ad.151.2025.04.07.20.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 20:55:57 -0700 (PDT)
Date: Tue, 8 Apr 2025 00:57:03 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: Siddharth Menon
Message-ID: <Z_Sej1XAW__ZBtOb@debian-BULLSEYE-live-builder-AMD64>
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei>
 <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
 <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
 <20250305145749.413fe30b@jic23-huawei>
 <CAGd6pzMzrJbRBXr2esV1x-TxXjg9zt22y6UdSXgXe7jCO3_raA@mail.gmail.com>
 <20250309161143.2b730912@jic23-huawei>
 <CAGd6pzPDL3FG6rRzBrT72eDdtE+ZMNx4A=WUj2xwA2jvYZBHdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGd6pzPDL3FG6rRzBrT72eDdtE+ZMNx4A=WUj2xwA2jvYZBHdQ@mail.gmail.com>

Hi Siddharth,

On 04/08, Siddharth Menon wrote:
> subject: adt7316 driver viable as a gsoc project?
> 
> While working on the patch for the AD9832, I started looking for an available
> AD9832 board as I didn’t want to make too many changes without a testing unit
> on hand.
> 
> While I was browsing, I came across the ADT7316, which doesn’t seem to have
> existing driver support.

There's a driver in staging (drivers/staging/iio/addac/*).

> 
> I know this is last minute with proposal submissions closing tomorrow, but
> I’m considering working on it anyway and wanted to ask if it’d be worth getting
> this board.

While it would be possible to do a GSoC project for ADT7316, I think it wouldn't
be as interesting as developing a new driver, IMO. May be a good one for
contributing as non-gsoc project.

