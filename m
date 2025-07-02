Return-Path: <linux-iio+bounces-21231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31847AF1487
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 13:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDBE1C41E95
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2940C266594;
	Wed,  2 Jul 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVS+UIpB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3891DF27E;
	Wed,  2 Jul 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456970; cv=none; b=gKV4CLOyd8LHRJjT+xGHkxWaRz2DNU889/QQnqb6hwFPg+C6A+hCeGH+UECz3L7KzNsxQSK6Fug2YGFAUOkB1QF71tmoiX/zxaT9ohfQYZ7GMJzPdFsOJU2Y5x5SBEaNevnWukGYF5VXwR3Cwk9y4jXiyId9f20XulnEUfAeaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456970; c=relaxed/simple;
	bh=rlOjbblrPFoFywhtJZYqVrS/QMtPxyquSajdBFeXgUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV+ZHUnq4XYk5NETvkpu798/zg5I+pwLy7P+6Tmmy8frKl5/oYLYK4+sUq4r0jn6gTcayrArJxJD+KUM5+ry7e5GAW3BqT88XAXwUTy0MZ/h5uAJkYLZzSEzrWkzDXqT8tlAlzvTqF40Ddw4RQDLgRB6wL5F6VWuFQ1Lvm4iGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVS+UIpB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d21526eff6so60035585a.1;
        Wed, 02 Jul 2025 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751456968; x=1752061768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p83byrHCO1lXCBi5YMU0ZTOGiOMnB2majfT2wo9dL9k=;
        b=CVS+UIpBp2iG4DIjsEJD3+o28lfDGQvGqQ8f5lgzH+eoPG9zmr20lYfZ3Q1r4o53qc
         6u+vKuUQ0NYM6XAwRrMxlgBEziMdh7BByaIP3hN3rkqZ44LVBkfuW6geoxT37PJRmH/m
         GfGrjYc0sq6JFimIFpL076BQMa6PvHTr/f2tMjMznDK2Ve9ceRRNtK5dpsVpoYkPsgqk
         GiYSQMDdB0JQ3QJerqspPgl/+lDbrU1Lp65zGkMdRAU+2cLT1Z2JX9Fxpz2pJN5H8Uij
         p5nHwG8IXKb5a9kN/a0oft6CgWXdZUBv/nlRAzgK+etMmY+7G6/VlbUc99YC/XUXcspi
         cPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456968; x=1752061768;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p83byrHCO1lXCBi5YMU0ZTOGiOMnB2majfT2wo9dL9k=;
        b=kONwg7gKLN5aRhnwKOdZTjE7cmBC5aNKZbuArTmv0rfy3L6WrS29z2GSq9mLRU4mfR
         RmMRfEvysPBWDE6Qn/Qh/cPDhEuzMvsln+KrEpknkI4m2qv7Hfv+gW85dU1ATqxv99VU
         9IIps/UIBF/8fAurkck3uDAFeVj/WzyAQxqcBwmwqWpLqI43Jrh7wB7lZMLQkMWkUGkW
         oyjw3Sal7SeW1EhycNtkavDkd2WI2VZFM+C/hnDrND6hrKhac0CPu80Oop25me0NThWH
         q4ms5NFXZgZo8k2abm7B0EmHBz1Y2rblSNeLokRfTZiZGRWYd0dQYRSzTLHohvUn/ugO
         HVPA==
X-Forwarded-Encrypted: i=1; AJvYcCUDELQTlmKXoQzWcgzpUpHjNxf5XzBpWEn9gMklcKFMCBHU3XCpbDgY2rDS8BOg02OYItgCf8ILGASe@vger.kernel.org, AJvYcCVKJPSJSD3ffb9PhRKJxhRhxpSLCha15304EOjapgVbRruaCOQLBB0tFjGFGB14DJvjirF0TJOI5PFZCg==@vger.kernel.org, AJvYcCXKOJFcUeIYgFDDOj7vKRELga1fjKiy+7E+HUSB4wtGCWhipnJgafg94ugNAW5r8O7OEC15gHbBOqoxw9aN@vger.kernel.org, AJvYcCXNNxaw4xy9ZDXpgltTiZ61zh3PkvtgKhOd/0L06l1a06IIwxlFgRrGJgP+8hisXtOq/rDq1c3H/cMj@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyNnsLnLGVBeJYSu0+1IYiwfRgMARhbSkQ38+ZBBkfuLOB/h1
	9XB/GsQFLuJBybd3ZENks0I40/rQjbIbretk3WhfhCc1MBa7/GiEzhd5AEL/do/O
X-Gm-Gg: ASbGncuW9jd6Y0iyN5gJntKfo2BZ18sN7sCECf+elibGmvOFuYD36KfqR5ZjdR4cT/S
	u5CevtBl+cHsImAumDAyj6KsukxLXsTm0ZoSRygdA+XueNKsv8/5/Tb9UC4Yzc/po2GX24lrGag
	nQndntP34bmnq4xH72h9e18iedk8e9RwQju4OEOstT5zR6MuXa+JoiiuIG5IClK5nelB5tzdszn
	LhkkuBTFi36tCy3o4IuYqFdTivu8yuhO0LtUoE5VzjJsE58gnrzzYRfOL1egGLY0396XjU4V8w/
	NqTy+NwziIWc6GyK85jtRZWoImVxZquUTjxi+oTcPr32g3lexbtroG7qXR0yKOEjgIof5y1ZpsO
	UCvlyhPg=
X-Google-Smtp-Source: AGHT+IEyZEMO6FefEf25MKiWBY3EZtRzSSK97igDWBQi5lsEl4woWicT9TuLBBe8ObJwSeH8wIEzJQ==
X-Received: by 2002:a05:620a:27d3:b0:7d4:4a59:6e8f with SMTP id af79cd13be357-7d5c47c0546mr121316285a.15.1751456968009;
        Wed, 02 Jul 2025 04:49:28 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44e13d800sm734399185a.71.2025.07.02.04.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:49:27 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:49:21 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v11 00/11] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <aGUcwQpYwojtZB3Y@JSANTO12-L01.ad.analog.com>
Reply-To: 20250614123807.3ded6764@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
 <aEweNqhLsL_Hg_gl@smile.fi.intel.com>
 <20250614123807.3ded6764@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614123807.3ded6764@jic23-huawei>

On 06/14, Jonathan Cameron wrote:
> On Fri, 13 Jun 2025 15:48:54 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Wed, Jun 11, 2025 at 08:49:34AM -0300, Jonathan Santos wrote:
> > > 
> > > This patch series introduces some new features, improvements,
> > > and fixes for the AD7768-1 ADC driver.
> > > 
> > > The goal is to support all key functionalities listed in the device
> > > datasheet, including filter mode selection, common mode voltage output
> > > configuration and GPIO support. Additionally, this includes fixes
> > > for SPI communication and for IIO interface, and also code improvements
> > > to enhance maintainability and readability.  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > (for all except DT patches)
> > 
> > The nit-picks can be addressed either in next version (if needed) or whilst
> > applying. Up to maintainers and you.
> > 
> 
> Applied patches 1-10 (with 10 tweaked as suggested).
> 
> For 11 I'll wait on answers to questions.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan, could you pick the patch 11? I have some follow-up patches
to send.
I can carry this patch to the new set, if needed.

Thanks,
Jonathan S.


