Return-Path: <linux-iio+bounces-18483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37FBA95AAF
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 03:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C4C175167
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 01:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356716F858;
	Tue, 22 Apr 2025 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfNYYT6r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80453E56F
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286675; cv=none; b=LJozvVZHCkfubb9Bls8rxGlsIb2mafS1pXFiZaitFiEdOp66TncdmLRjqwldpOb+jIbowzWzEPt6SsQTrZel8TnJJin6n+6kHLfGtXKT5ayF18kbC6IxdJB4CQP2x0OaqjTrd8IOepFKGUeoXHOdu30hpA05/2Fg4g/0pJED0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286675; c=relaxed/simple;
	bh=p6vCzTuuYyNNoY2DVeUBD6E1ciARfqjUUdyfjvusKqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkFel2N4nTKT1OcMqxZ4Vu6eXIsjD5z7FX5SsFo/hi3SFaogba7xxmBKv5MdAQN9hZrGeTKsl3wYCd8GS8weNed5BQT3KyIcOiMrs3q7to1UgmMqtVAyE77FeUMR8EJOxKtpzbK9FPiY85/XN7+YTtTX7Tc8dCaES1Q2p361/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfNYYT6r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c91576aso39160695ad.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745286674; x=1745891474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/e/peayTwXVV7MnytaHimW/zuidT/0nMjkhO68l6Uc=;
        b=SfNYYT6r3y8vC5pPC+TWa+Ze7WmnRCEgY58qYsssOfQ9n8O1nZJeNoLKYF5DhRk2MJ
         pmrkOStCype5A839Rl/Gmw3xiz6wIMecpeJsNvj2NkxjFONCxc2ogV/VhWNYumv7rGpf
         69CjtkFXs/Z0vtOAfb8+9Tr325/OuQmWQbilHbuYFTHNutXDMrCK+GfwoByr0akfcLag
         Sthq3wQdAzgwz66R//H3ZSaX/cN/53UfXS5r3Uad0iLSCz98SHUlQJQNZ+JuKEWFJhcz
         +3lpzK3tY6yYfjyWQ85h2cbYOr4GQLxVjwfyGSW0xI0SDdua/SRaUyz9MDkuf8zf4Esf
         4AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745286674; x=1745891474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/e/peayTwXVV7MnytaHimW/zuidT/0nMjkhO68l6Uc=;
        b=WZrmnN82ERhrp2m6UzhGcjbXKzC/ZQsmPrWe8L2OlcWOX78E9dtXc5Z5C2YKLtY22Z
         UvTdaqAi/WMjG1oaSNElTGVLQzvJBcvsY6o9PXDetIpXrGcYNakyUg17j3juyzV9mqCv
         tlxJk1ZjDLAyCqnIkLDzgBKKfAApbuEHKgRjf8l8U8yJTrR4CvqjXzwDUB8HFeTqPYbB
         oMPc7zAANLNSzkd4f6VP2KMdq4+EnCowGKnXzlWmdsWdTCRytzg2By93y8yZgsZZ3f3X
         anDrn5zAL8x4Ve7EGMEohyDQNMZxIdhQDqHLSftvy/aJ4m2xcs+1K3aNnWu3zvHxRcLi
         HeCw==
X-Forwarded-Encrypted: i=1; AJvYcCUICui/2EIq7kwPJY75l18FHK1QNmCq1Dmd1ck1kaWu2D0fRNm8hGa+6Zj/VMBgiraylvZda3tQkjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEqSZ6FESY9WzxwlytUXX5P1mfQ3cPtCBxtWCUal3FUlyI88D
	2Ccl+CEplw5WGqWQxiv/lY5WakdBYsfbXm+pT5DsLYoeOxDo+3EE
X-Gm-Gg: ASbGncsuCt1p9pkVjPkB5bsoj5DTDxzDBBDKSjoohiCBLwpVXQaKizA8o/u974rRSAq
	Rk1fbPoWZzcZeMHSYyonNYaQON7+tjgP+RcRn0bjU7DU5tswzDPiTLEQhU5HFLtzkbcMJRVXSWu
	h8sUotZDRHLzuaeDpeb3qf8e10e8x7fX0SlpInk1bbT8IgEjqcmS3XgV1GXvCpMvKyXA0UxHvOX
	S251AMh9LTzDUxypLK2JsGib96mdtU424ScB2jyS1IKXy79h8A2sC+UJ9CdfrNHRdrmcj1H86uB
	cWY/J3syTVvpVqD4CwCo3FYRygv8+VbCMUJ7+vJqRZz6pXE=
X-Google-Smtp-Source: AGHT+IGNq1aQKx2mwC74pd+Ap15eWH9ioqwSnN99niXQ0IafXZdau9VVGjyf0wW+JpJy8ZPSqC7OTQ==
X-Received: by 2002:a17:902:d4cc:b0:224:1074:6393 with SMTP id d9443c01a7336-22c5362753dmr201103645ad.43.1745286673553;
        Mon, 21 Apr 2025 18:51:13 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50eb48e0sm72731265ad.155.2025.04.21.18.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 18:51:12 -0700 (PDT)
Date: Mon, 21 Apr 2025 22:52:25 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Arthur Pilone <art.pilone@gmail.com>
Cc: jic23@kernel.org, marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
	bruno.stephan@usp.br, aschwarz@usp.br
Subject: Re: [PATCH v3] iio: adc: ad7091r-base: Remove duplicate code on
 volatile reg check
Message-ID: <aAb2WYSkhE3xWqAv@debian-BULLSEYE-live-builder-AMD64>
References: <20250421145534.91146-1-arthurpilone@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421145534.91146-1-arthurpilone@usp.br>

Hello Arthur et. al.

This version looks good to me.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 04/21, Arthur Pilone wrote:
> From: Arthur Pilone <art.pilone@gmail.com>
> 
> Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
> same test, checking whether a given 'reg' code is
> AD7091R_REG_RESULT or AD7091R_REG_ALERT. As the volatile ad7091r
> registers happen to be the only read-only ones, the volatile_reg()
> function now returns the negated output of writeable_reg().
> 
> Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
> Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
> Co-developed-by: Andre de Lima <aschwarz@usp.br>
> Signed-off-by: Andre de Lima <aschwarz@usp.br>
> Signed-off-by: Arthur Pilone <art.pilone@gmail.com>

