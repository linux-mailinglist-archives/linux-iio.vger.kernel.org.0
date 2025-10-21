Return-Path: <linux-iio+bounces-25328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC3BF6142
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 13:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E15F1889392
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9702F5302;
	Tue, 21 Oct 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsoM/dak"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22F269D17
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046551; cv=none; b=oQHi15OX49TFmI6/yQR5l7UwMAuXyLsM1p2UFN5cQMqhSSo6Knk6qVT/MNF1uq0t8pAhODf5wZr8A6ohXstv1K19iC6VEL/mclR4aWOetzPpsO2f7WgmdbhaeMz5Hb7o+EU9KfLthGQkJQo0iMATGlzg03KSEWLozPp88CHiItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046551; c=relaxed/simple;
	bh=v8WyGo3Y4RxKHGp7InCl285b0hOGchUITJMGf5WZlts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umLnar1XgrnribbVHOlrPJ283KeBBjTYapO+onqa17DWy85Wqc+HtmvkuYzOgrexKTDyx+XvFb/SZGLmzZJkv96MXUG4eow7gK62oJj8KnHhHrF7R8tN7h7WhTeZbPNV8Duficr0Hg4xLfDod4mPKxYKWctFOz8TLznt4l46Gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsoM/dak; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4c89df6145so898433066b.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761046548; x=1761651348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFKTQ9xP8P9jiFFOLe7mCIkwuW/VAdG24z5AEwC9Qyw=;
        b=IsoM/dakSF9Siyn3NdoIjc15KG9GAJ2231BPGLOfiHnJz/XFnB1b50CbqT+8vupnu5
         qHCsBPgkB6Eoi1tZvnJ7Lnn16ZSSerOrETJZXoFE2jQt+sCsP1XVuj2GY5Rr25jZDAl1
         CFvWR1uDLbvYFzeAYkuHgiDUd0z7vp7G3dTkGEX4joiSPEqLYE7UrsGd19yXdW2c+T6t
         D/whHYC41t2VZcGicMdi71/NiUUzFr8fj2Qxig9M7T6OrJttXnbDDix7x0pVIZH/QFto
         +sAPWF4m32PhM+sSpv9w6iE3BKb6jSl9zTEEzaHYhdagCvxfvvSnRwoM/iHPyImSdfMe
         tVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046548; x=1761651348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFKTQ9xP8P9jiFFOLe7mCIkwuW/VAdG24z5AEwC9Qyw=;
        b=t9kTCtUWSo7MR4LlqDOUVvSIoFDxGmI5Wcwr7ZZp8ZrHBSU6djZdy3OT+9KlOCZ9Kh
         yOtEOHI59nZTGCCy/n3cw/gTsl3Zw8SUlZu7huik8oySXn2gEnbDPv5vPoai1cvbQ1+T
         fnQoXq4pKMkM+06vKTAX0MM1CnjfjKytUf1i3mNDom2rLupIwaLKo48WFR9ivU8XrCwB
         ZPdsEzHo+/1CCX9bf10+RI1yoqrL/IiPX8ulQ1irZt5nSNhZD+kwVnKzl0VxLq3UYo5K
         6nzCj7jIvHE0tkmZP1zwwP8QAqVUhRfCF7qHPQeEwfg6w24G7U2vopWRKo6yAwPj7C60
         Gwyw==
X-Forwarded-Encrypted: i=1; AJvYcCUNd7rKiwA82kSLitHGmw7l3L0ry2574WjJnmwOktMTeiEuOSkIKr/faApISCUUGj2Y5NJpdP0NcbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7DB2K/g1ENYgxcChziHQbedij0BRWwalyKdHe26JXZ6zKtA5
	MobDZKIuzXJIwx1Q1O2filFlQrb4Hx1alKSpfjCRYqu34WLVqM5uKC3h
X-Gm-Gg: ASbGnctYN0xSs6bx1xCGHtAIB6/YQBtGocLNiofUD7HCsF/e1bnzfet2uZLOXGRcUJt
	K3C5+DMuiTh4b/foQhJbQARLwCQleefXrsKICt3IZnTUSfOQR+0VeBhwoaKojxPcjDScd8ZJHe5
	n9tfitbsWkLftMpTRFOxjUggCAaPgCA9MwK+ol7CrWClOqdwNqtamyO6vceW4oNOFYNAeFfJchZ
	adpDCX1w/XP5xo4XArSUKSJGWz3AIViAaXMpyba9BvDa0qCdAQd+XhMvSzUeVK3CqdPaBiuoDz+
	ad3uObZOc6NYgtL0U+pHyCgu/iXdFO/6sh8zNYQkqNSb9AQt22cV2nl+nER/Boy7r5SgJRu8WV0
	9SWmltbmijLJjGEhyXo4nJURiWjIJJwdFhc/2pz3Z+9LNJIjPgT7TW4ih7LVBgjXGR9LJFSG9cL
	nLLsqd3SzNC0vdGyxcEm+Gug==
X-Google-Smtp-Source: AGHT+IGK/mt9+RIXmJq5VxepoL8ZFZHiH/fhHgPGfPvqe5SfNcjEj67rA0t+4faUs1kLVBLk/wIUjg==
X-Received: by 2002:a17:907:d0d:b0:b41:873d:e226 with SMTP id a640c23a62f3a-b6472d5bbcfmr1809122166b.1.1761046547869;
        Tue, 21 Oct 2025 04:35:47 -0700 (PDT)
Received: from ctocxl9700.cto.st.com ([37.162.48.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e838b946sm1038119066b.19.2025.10.21.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:35:47 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:35:44 +0200
From: Mario Tesi <martepisa@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <20251021113544.GA256337@ctocxl9700.cto.st.com>
References: <20251015161619.GA87736@ctocxl9700.cto.st.com>
 <aO_e2DEGsO-kJQFx@lore-desk>
 <20251018202301.2680cc79@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018202301.2680cc79@jic23-huawei>

On Sat, Oct 18, 2025 at 08:23:01PM +0100, Jonathan Cameron wrote:
> On Wed, 15 Oct 2025 19:50:16 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > > The calibrated timestamp is calculated from the nominal value using the
> > > formula:
> > >   ts_gain[ns] ≈ ts_sensitivity - (ts_trim_coeff * val) / 1000.
> > > 
> > > The values of ts_sensitivity and ts_trim_coeff are not the same for all
> > > devices, so it is necessary to differentiate them based on the part name.
> > > For the correct values please consult the relevant AN.
> > > 
> > > Signed-off-by: Mario Tesi <mario.tesi@st.com>  
> > 
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Fixes tag?  Just reply to this thread with one and I'll pick it up from here.
> No need for a new version.
> 
> Otherwise seems fine to me.
> 
> Thanks,
> 
> Jonathan
> 
Fixes: cb3b6b8e1bc0 ("iio: imu: st_lsm6dsx: add odr calibration feature")

Thanks,
Mario

