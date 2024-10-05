Return-Path: <linux-iio+bounces-10218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4D991A68
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 22:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E21B283DAA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B671552E0;
	Sat,  5 Oct 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXvtJJLK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DC130AC8;
	Sat,  5 Oct 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158526; cv=none; b=N+lR32DHWuDNaE4TwBDCb6aHmKMx7H91qMM0lJVCCWHrKRFdyFoG/9QIvHT+vjeLE6ZdpYfapB3/BNwOgCo8PFBwd7K2FcLGjHsmqFYCuf5gpcNmsm3921CpTF1asSuMmrsZR0pLK1MgQyp6vhjWijv1gb3n03RL4+CmNK9f6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158526; c=relaxed/simple;
	bh=w0HjKOkh0Udy0AJiC9BsFFePM9EfCy7m1acEG36mIo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHg5yx990EWLw1ScCkzotNFEb+1d6LWdZeSmt4FVvLYJfeOyHvh+OBvniORf1BEcrc8t1FHPkTP4pshYhDuz/8QvkICQEkE7YreuEFWTROK7LVJ5gb7qIAKQq1uJ9HvJ2Tck1TGBAhIhcB9vWHgyJJSLia1BvvIXHZB3e3oe4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXvtJJLK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so2297407b3a.3;
        Sat, 05 Oct 2024 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728158524; x=1728763324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJH1sCU46AuN3DS6bA6+4wMeXiS/s5mo7e9ETOcqMoU=;
        b=eXvtJJLK+mwXj90ZRWLMnBlQArbKzpwx86sCbjESPxkWWEYJonLyIBkiUV15qFewsN
         K84b+aNTbKIixGyLhLLlVf/ONxOaOsuWeMGZk/DRrUJgwX1QU5+xbsUkz9hQxuveOywk
         vAjZw2LYC6U/qSk5Su+Sa10098s+BJtx270AVMX3+90FOE3KuQa6TxMO4V+pYr9Vnru0
         L26FkoF/tCjOGJxLJ2yht8FSYjm+gfsI+Mozo/MNuzfbmgDxSTRaBpMDKppyENd4/hKp
         8ed6HXHjJoUPVjNZ3o3MaRDa1hE1Amg1xoGT6THO3kJwRZlz4rfmhi8JS6LF1K2VzVWn
         a1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158524; x=1728763324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJH1sCU46AuN3DS6bA6+4wMeXiS/s5mo7e9ETOcqMoU=;
        b=Tuz63znB5xYz1pEf9wdSsayxhtUMqaZapOPcwtcxcq2B7z19B72b/osgBrnvZattP5
         Y+tUhggT36m/HHWJ3bZfry1w/DM2kaRvDz49dvamM0AZbpuUTqqQJyxJm5b0z6pwjiFZ
         jYkIXm1z8ipaQEDqcOkKl1xnzHbXs2fuvmQECRq1vxJjyS3VeXWF3xSQHb7niGl18ZoV
         KgNhrHNoFfuLVUpDf4fsgyRgJe+Tivsry8V24qaejy2iyMx7BKU/SfHMgp93svPRo7gL
         0ZcefbMUjJA5VRc8GqtdEHcSlUPsbpUqCOmjziX/teBqPjp8aOg2/lS2/NA+vApwA2uc
         qi3A==
X-Forwarded-Encrypted: i=1; AJvYcCUYvLCDTuy7IjLbY1ukVr/cG9fckabAJ489mpxbBGvQheGgf/7Ser/9tWwEb9efblaqCaRk2inywd0=@vger.kernel.org, AJvYcCWjcvX9PkntzoRHdjTqA4QkyutArpA+NTFUqijCJxp1MuEiXhSttnoz9wk+TmtxgE3PbU4m0c/+kKz+d0vE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WGyN3ot7EUQoedCrhVGJAXmpQJwzTJCH9ni/5+hO17qEHoK4
	P2JXU1RrruXabgX0lCYa/LK7ec/MvhwaaOhWcdmuDRU1CMsflHMR
X-Google-Smtp-Source: AGHT+IE6g2JBT8J5L70xI3+rVVrk4N3KrBHywaJAGZRCbZrsVzPzr0KFOapIa+vbGvtVTZSvPQ3JFw==
X-Received: by 2002:a05:6a00:10d2:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-71de24395d4mr11172135b3a.22.1728158523845;
        Sat, 05 Oct 2024 13:02:03 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0ccd04csm1825128b3a.46.2024.10.05.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:02:03 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: jic23@kernel.org,
	kimseer.paller@analog.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH v2] iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config 
Date: Sun,  6 Oct 2024 01:31:36 +0530
Message-ID: <20241005200144.24896-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <5e4f121f-85a4-489f-8949-a5b02be99d09@wanadoo.fr>
References: <5e4f121f-85a4-489f-8949-a5b02be99d09@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!
Thank you for your feedback. I’ve made the necessary adjustments based 
on your suggestions and checked with checkpatch.pl --strict, resolving 
the warnings. I'm sending the v3 patch right away.

Thanks again for your help, learned a lot!



