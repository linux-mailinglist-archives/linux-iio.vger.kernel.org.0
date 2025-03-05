Return-Path: <linux-iio+bounces-16419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A9A500B3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9615163355
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAA245023;
	Wed,  5 Mar 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyj7kxEG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0C38DE1
	for <linux-iio@vger.kernel.org>; Wed,  5 Mar 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181841; cv=none; b=XBfLYRamV3LQ7lXWEBpJPpYr0r1ASufZqkjYJkh4jX9aPIOpVLJlasLykMymp+WE7bIz6FXo9eNg7n4YQR2lvl5LX/CXCltUZXb7oMB8mf8KB7jaJtkYUYh0IzJxbuEx6xTb9i3goZ/bpVBZEZGsFMUYivvoND7h22LM0fXc2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181841; c=relaxed/simple;
	bh=dwu7LHr9Sw5TmT45WQ1zEUVJoTV7fGT58c3BEjhgE9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9DPaeFV6ind/z2nknmtAK3RQ7aRBPWMctQtIZXpAa60EhntitAfBYEQwggOkn6MiSXIJNxzLiQQKztSBiD4GVHAI+FOUgXiLTld2YHjDBG2PumgNgm+F6HZF+hkrkaDK1yj7kHaivTzO7S6PDDFMWXoX301dlpGUFYCbTyT6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyj7kxEG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e60b75f8723so3772267276.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Mar 2025 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741181839; x=1741786639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dwu7LHr9Sw5TmT45WQ1zEUVJoTV7fGT58c3BEjhgE9c=;
        b=Jyj7kxEGlBdMAHyBDqb/fU9Rn95ORO7Fotg/+v8Mn3RpTM2nOVXIKYlYB4PBcBhFqM
         xrjb7LSkepz3yA+WIfVLRXbe/AmpMOSPUVvIVncAE6R8STN+Uj4n2fOnyHTk2yI6ZLqO
         17OypJiWjkKWTlZN5cRHYDNGPx+UhELJxxxcFJEmtYPFKFxfuZSsk2EPwF94YN3DjDdj
         1HXomqOVvbv1qpWfXq7Bq16/6Vi8K4FgrOoilU9I6GAe0k4WwlwEIz6Ib5855T4S4p7U
         j8QvIMG4DXgAOtJ59L0zCZBc/6orniqHjMA+pvkqCIbl0tGWdYTcgQUyTpL3JtYCPd70
         DBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181839; x=1741786639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwu7LHr9Sw5TmT45WQ1zEUVJoTV7fGT58c3BEjhgE9c=;
        b=uLUETCh17Np1WnFJdfJP/4hpx78CLAwJRpBMXF58rh1Un7fqUzYqD2LYoB8R5AHrd9
         310FJnHVu9E0yUrFmoNssDSqDBuAdUIsHifAMLExHhLclOY74WM1L8NIeaFcrB78k/Ui
         s283PjqNrFUscSG5LTGKdnsEXCs8/1QrcSNq5Rq53IeVh3AZaZw99O/VVnVkO0PP15V9
         NRnSXiVj526LXNcPDIvLSnhmCYVKbQXE1CpRCruqPJuloQ2NSy/BWFsYy6k2BqUzNsqJ
         Azem8MT4GRDG/yboH0X5xFP4VBASAGJgsOMGHR+2oChYzwWHgsSj9/LRCYrgMVaRghfk
         6kQg==
X-Forwarded-Encrypted: i=1; AJvYcCUv86wOSP1/hsAH17Zyq8OUDLjI5uyCHqZehaHRunCCyjIzSuHLmhU3kdU4b1/172GR0t+evmY7XsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGiJ/HywMrEXQTIllY/jJbrCfHJ5LRu/ed0cHtEmH9AAyNqZP0
	5jlNs2/x0lPlKVNxkp/E05rpBIGiffD/UTxV0n7VcPbNzPH2dsO3MizDmJFrllRlHXSi3Im78eU
	lKaj3rOZ164c1K683sxD8BLW4f0w=
X-Gm-Gg: ASbGncuRE2R+RaejluKED+xBObkIRFTHkNcTnQngndHz4lnywQqTjPVfH87VH1tZl/r
	KAlQBtx6sBKBsmxqLTch25EOv+dI68dZfkoeYkhGIUEBKPr+Oa19uzTSlWpJQvHAkjj4HvZ+sS6
	L5Mh1pIjli2tGis0VyiMzQvA==
X-Google-Smtp-Source: AGHT+IFM0TLjMPXgyPlQliG4oRcEadmgHXz+MpvvpVSSfWm8eOmwx48bf5TCTtqSRaiUBL7DNZl8nBFzJbxuDjBQysU=
X-Received: by 2002:a05:6902:1b04:b0:e5a:e897:2846 with SMTP id
 3f1490d57ef6-e611e1ba0cemr3780205276.16.1741181839391; Wed, 05 Mar 2025
 05:37:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGd6pzNTB5f++sbirWxnD1Tq_rjTkBDVmSrpFYsMisEasAq4Rg@mail.gmail.com>
 <20250222151143.7ca7f718@jic23-huawei> <CAGd6pzOO_8VV8RPVz81-LE=eisuPjYsRQZAYgyfxwKLjKSM06Q@mail.gmail.com>
 <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Z8U0lsntJpTuBzyT@debian-BULLSEYE-live-builder-AMD64>
From: Siddharth Menon <simeddon@gmail.com>
Date: Wed, 5 Mar 2025 19:06:41 +0530
X-Gm-Features: AQ5f1JqIAhK_T0fTxMILA1bBI_iaOK24I28fqhZcVkuVoMhQ00mjCNp7jaJDBWo
Message-ID: <CAGd6pzN-4a2cs82ABHU5-pr32hg9DtvhpD8kM1skdbGq7_rvQw@mail.gmail.com>
Subject: Re: GSoC IIO project: Siddharth Menon
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:17, Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
>
> I did a quick look at the IIO staging drivers and here are some comments and
> improvement suggestions for those.

Thank you for taking the time to provide pointers to potential patches.
I'll begin with the adis16203, as it appears to be the simplest.
I'll also see if I can get access to any of the boards for testing.
If that's not possible, I'll focus on submitting patches with minimal risk
of breaking anything.

Regards,
Siddharth Menon

