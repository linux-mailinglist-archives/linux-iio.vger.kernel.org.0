Return-Path: <linux-iio+bounces-16587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C047FA584E9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E0168AAF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F71D6DB5;
	Sun,  9 Mar 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9y8+b/2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995C4690;
	Sun,  9 Mar 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741530273; cv=none; b=d4XdGRuW31Wzh2z/2BmerBq1qdnta87N9Px0iJKHExwRPuuVsNX9AVd3l+s6GkmPmCzeEV+TEfVF/xLSSOE4CCBy+zEzbX0HaWbg+LlPJmTZk+NLdj/FMj4QrKhuKEP3Imjp2hFB/18ldjrvTsDtb/N62Babu+PFtEUG5ChzqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741530273; c=relaxed/simple;
	bh=qNPaQ+3fbpLjlpDsZPQdDZ46x/TQwgLgUwhHdcqIHvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpTbHWU+htf2chCOXI+PdbL79bXd8i7c+WMRwaB1NaiN/rXu5s53SqeuBwyi2wf8SguU4aFDVO6TamUaYSCTbYoGWn+G4hhCwIfr1Mg6lI8xJ6oSMqHjz6yamn7u75DMmTspXkr50RF7NE1HBH6JPocR7fzqij1NQMjgAxPdvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9y8+b/2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd89d036so65162415ad.1;
        Sun, 09 Mar 2025 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741530272; x=1742135072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mi3TuIgwr9/F4gznHz26TJHlr+MuTIFSEN/eoEIJY8c=;
        b=G9y8+b/28ZopwpKjalH6msIlWuo7AjBoDOneCDTgef6hMdVN9N6LLh31uYLHv2C0eS
         aDmF5qETE7tpbRoGBZ3QzIrkuz63jBkjd0unKmKr0jThY8rrtzmero2f4IfWP2lkWNWu
         0Tqx7k+svnem7eK4+q61jyKa31l1YsGkTNVFb2JPpQu6yPxCEVsCo+2nmkTU1951eXMK
         ++0FzgC/hIUvhhav11qiMEPwCghadIsypSwVlXvYTNX7gNiIa/2sOZwEGPHf3DPvRpuS
         exh7CuyG6st9X1VjEEZUC6Kww7N2r7Eu79FYJ5uIsV6qDsNhFu6AKjQhdd73nQsAhk8P
         K9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741530272; x=1742135072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi3TuIgwr9/F4gznHz26TJHlr+MuTIFSEN/eoEIJY8c=;
        b=n9v/1wh+nB2julwo2SUhTw96FdzL8HoCsATCaZEfm9BCuSV4YeSvm1ISVo8uBOb3JS
         sq9Ga/0mUne9fuF5pUSyWqEGxCsidRQmUcgdj4RCod57YYh7/RZ/Tfbyv6UtoXM10RSf
         T+fJuct7jFBOtIhlsImGG5k6E5fyMb5f0sWED7FDhmjzhjFJLF63OLEbu/tCqn2X6WPW
         /XcEHx0e2+lp/xmHg25wxES+/IF0wExChuJoV/aQBQlmHBnA3oiKZBvUqX4BvmeI1pI2
         ANsF/M1A2zj/7JPTpjXK9XEJoEiRMCw/4D7gZMhUrbhVOnY0jD6PxA28OY1qc4XZE2fV
         HSag==
X-Forwarded-Encrypted: i=1; AJvYcCVIBfQwGLfNPai3FZbs4/xyBZVmwNaQe0AMNNHq3CS2k+wackYeZY5b7wm+te9bjnyulbvSsodgk0g=@vger.kernel.org, AJvYcCXgdk1vJSdiVc5yW0JB8AwwhwEniWmIs/RdGPfrtoinTQkPm7HCP8SuDQKk+vC3nsJ7oN/6Nd1TD1V9nN8/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Z7GSf+fdAqrb9oIsqz5Bj1KZEabkV+xouw/qE4bxjcK0k2xs
	UIL2wXbzZcky8UueHPgwan34FIF7CSMLVGr5TpGez8VzFy1VETsv
X-Gm-Gg: ASbGncvfd1cC1hQ0K5IGWX6CiD766IeKUHRd18TXzJ5ZXKbx2DB0fV6mhKsDuX7itN/
	ZjUHndXH2mG1bkqwguF/88VEg5BGkukD4CZ9eunIHVNW+EN2sFRfZo/OZheQrj3qodbM4s2aK4h
	myieA1hx6FgkWORIdd+4ZfSW6Wa88Q387g/cbwjoThfqL41KU++5YyhEFAo9a2d8VsdcNycMLs/
	WwvfI6ATN2IWhXKuxwFy0XK8RQX+cbWKqGjcMr87oFMaN9+gdWUBhGggpMlUSSFne7L9r2KrarS
	ukTi4X1J0zg6yjGtHD3yXNmU4xQvycZdbX6zEUK13rqmeZfQc3hx5w==
X-Google-Smtp-Source: AGHT+IGtXlAF9apJ6qkbzRk74eWQ6PWpTJPLI677ftWm+Y0Eye4qHKkcJgefH5VcGASo0BD+PlAMBQ==
X-Received: by 2002:a05:6a21:1693:b0:1f5:75a9:5255 with SMTP id adf61e73a8af0-1f575a9eeb9mr1633758637.39.1741530271708;
        Sun, 09 Mar 2025 07:24:31 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736d47f9da3sm718913b3a.137.2025.03.09.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:24:30 -0700 (PDT)
Date: Sun, 9 Mar 2025 11:25:25 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: accel: adxl367: fix setting odr for activity
 time update
Message-ID: <Z82k1SVjfk0ylXbS@debian-BULLSEYE-live-builder-AMD64>
References: <20250221203352.41941-1-l.rubusch@gmail.com>
 <20250222150329.66d6e79b@jic23-huawei>
 <CAFXKEHZEkNXAPVxZA5raPsA8cNt3A+tbd83kNzJc3wY5OjAsdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHZEkNXAPVxZA5raPsA8cNt3A+tbd83kNzJc3wY5OjAsdw@mail.gmail.com>

Hi Lothar,

On 03/08, Lothar Rubusch wrote:
> On Sat, Feb 22, 2025 at 4:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 21 Feb 2025 20:33:52 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > > Fix setting the odr value to update activity time based on frequency
> > > derrived by recent odr, and not by obsolete odr value.
> > >
...
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
...
> 
> Hi IIO ML readers - Hi Jonathan,
> AFAIK there is no tracked bug which I could refer to. Alternatively, I
> could refer to
> the commit hash of the original commit which introduced the code this
> patch is supposed
> to fix. Is this ok? Could you please help me here with the process?

Yes, the fixes tag should point to the commit that introduced the code that is
being fixed. So, this this patch should carry the following tag

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")

Also,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

