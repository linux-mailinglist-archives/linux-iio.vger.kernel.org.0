Return-Path: <linux-iio+bounces-18565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0CA994EC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09C63AF999
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2EA28E61B;
	Wed, 23 Apr 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwRDh2N8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9A27F4E5;
	Wed, 23 Apr 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424009; cv=none; b=D1i/jXd7gCky+OOuFenJO4+5ulZSMC1CbjSyeR5E/HbwUtRpEGIqngHm0tmhQ5R8fkRhf9+9NmyyupjZEhps2aJlI6MbLmpYYKbafgTLiS7/9Me586xLM1vJdj2WWeM7Co0Qfc7OeNKcxsJi8mz03/VjjgqzgUvD9q83hWw8E+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424009; c=relaxed/simple;
	bh=cWtUR1s+oX3cSyY2WWRDByfeehfCzTt4oDy/yxEDtOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBOUOAiNlPRdgcb/bHubnFnxJa+kT4Kjq70+mjyW0/8sPrapDZXquML/5TGmAnGptsLAZDSK9Km/mbR/Nial9EZsV+ugbQLWUaI55O9EhlJr9qWfu2du/L22VaX6Hgbhxtvve8TSurJkSJEgYvm1d9H22uUAJkAP0uaeXfPRpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwRDh2N8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso77043805ad.1;
        Wed, 23 Apr 2025 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745424008; x=1746028808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EvTbEH5kh8Gvs5zc8XdxJafo/2/TNuXbSiBQMUuVYw=;
        b=UwRDh2N8ZVpN/ruJuQB1hYcrXJMsE7kdXI8KU6uwDxXCxOiWcOLFsbdL4HTsUeOZxx
         U/qwdgIcQt6QKa/gf2qICP18Xxi/Yjg9EBVuNTKVdPLjoAGGKnBfbBQvt6xd+C3SSX6V
         02Q6kWkGrrtfCa/LUOg75FFwaTckTI3klTEQEuPa6oCm/fsIVv11N9VxMN+0i03fFbXt
         co+C/3szazfLLJZFDdnVFT6LNOqLhcJzI6bi4N44leSJwqt7+7I8uYhDvqpvk6hVMeTg
         X7oMEwgfKFQOdjpcrH+9dGcecA/8jEc1WzYe6EnG+keDn7Lczhq8F0p0w5kIck1H5ISe
         reww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745424008; x=1746028808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EvTbEH5kh8Gvs5zc8XdxJafo/2/TNuXbSiBQMUuVYw=;
        b=MYbB9FFakliUvhiAWjg9qGHcnVBRUMYxrqQ4DG+3kAT4khzYr35YDcWf1aM2PZW0aP
         pEdiIrznxDpowDsKfvgaEwv42iwZ6Tjn4zwH8qL6dtKn8Qg7AMmJPYtgPwU1nToM35ZO
         bkDGxk5VtK7EyKp1rrQxl/1zyyIP93ygVxEkiPc5a5glmBYIX71PgsoMnePNtZHmCUFX
         z38To2Q25aJy0BWl+s6zuYbyivl7pf/3ZV3Ail4Ec5zhukfcy7Vzz74zwUr3T1CVeXuH
         4tKxvP9uHBOUaetFKSq2MQyknlkhaLwYRfwSbW8b6ctS1ARnR55E7n0cox26sc2jyeW4
         27Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUg8R4hfD4Ea5tG016QWj3IufqbEI42tFec1IefiHnO6S5Vr4gUINDOAq2KInmatR/JqeS9Rzz8gPPn@vger.kernel.org, AJvYcCUqlfBWjiNOeAogYlPIRLhSbGZmv7McOKTbAdh3hEVWFQTocItADZhq747UcdRJWOLF/48QU1WUz2hk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qWmbieStSBizkrl2K73d9ZcWcpPPQICcx/8JroQIgLTz/JIn
	haMy94tSoAj8KZMIy2PLFrLzJKH1fiWcgQLkuThf0wMVXh/3Y0sI
X-Gm-Gg: ASbGncvIbORhNSXwuEHYCVyud56LLNIbjP2BhMbDg/5NeMVLjb2rTVCH4eIUNE6ahob
	/3DEPKNDC2X+vw/YWilUZHmilJPfTBCbPLjqkcLlIMviVF5lZ0sQ7Y1upvr6QE3FUsEzhEoeJnd
	z6QHiGiE7XfsWnIjx65aGPdfYAEZy+Pz90at/Qj/NHJ13bPaQCQY7p2m8Jyg/w7jLHXuwIS8g3x
	HlbYP0ci4pI80aNxQzlroj2w3569Wbj71lT2nHJM+1d4MvxT584IOf78sKUXFZI6kuNDnvgTLRS
	63dx/+tcp2WOdHP1S5qnDWtx7aSHjZxtheOikPDN2yI7b3E=
X-Google-Smtp-Source: AGHT+IED/lqrZnxvUHI1aAwGMY1lTJXmENoRyzf6pSkwVzPpPujy+wy5G1OHh0E7tjuPHBwKDdoJSg==
X-Received: by 2002:a17:902:ec90:b0:229:1717:8826 with SMTP id d9443c01a7336-22c535b4a1cmr292423255ad.28.1745424007506;
        Wed, 23 Apr 2025 09:00:07 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c50bde283sm106933665ad.6.2025.04.23.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:00:07 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: andy@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v5 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Thu, 24 Apr 2025 00:59:48 +0900
Message-Id: <20250423155948.20576-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aAfUZuujO0FUkJEG@smile.fi.intel.com>
References: <20250422155302.669960-1-gye976@gmail.com> <aAfUZuujO0FUkJEG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > +	if (ppm) {
> > +		if (!in_range(ppm, 1000, 4001)) {
> > +			dev_dbg(&indio_dev->dev,
> > +				"span point ppm should be between 1000 and 5000 inclusive.");
> > +			return -EINVAL;
> > +		}
>
> I proposed to define the _MIN and _MAX constants for the range and use them in
> the parameters. Any objection?

I'm sorry, my Gmail didn’t show your replies for some reason, so I missed your previous review. 
I only noticed it after checking iio lore directly.

It seems more readable to use _MIN and _MAX. I'll use those, thanks!

---

> > +
> > +	return len;
> > +}
> 
> Otherwise LGTM, thanks!

I'll send new patch based on your other review comments.
thanks.

--
Regards,
Gyeyoung

